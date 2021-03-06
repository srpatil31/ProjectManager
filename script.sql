USE [TASKMANAGERDB]
GO
/****** Object:  StoredProcedure [dbo].[SP_FILTER_ALL_TASK_MASTER]    Script Date: 23-08-2019 21:51:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_FILTER_ALL_TASK_MASTER]
(
@TASK VARCHAR(MAX) = NULL,
@PARENTTASK VARCHAR(MAX) = NULL,
@PRIORITYFROM INT = NULL,
@PRIORITYTO INT = NULL,
@DATEFROM DATETIME = NULL,
@DATELTO DATETIME = NULL
)
AS
BEGIN
	SELECT T.Task_ID,T.Task AS [Task],P.Parent_Task AS [Parent],T.Priority,T.Start_Date AS [Start Date],T.END_Date AS [End Date] FROM ParentTask P
	INNER JOIN Task T ON P.Parent_ID = T.Parent_ID
END



GO
/****** Object:  StoredProcedure [dbo].[SP_GET_ALL_TASK_MASTER]    Script Date: 23-08-2019 21:51:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GET_ALL_TASK_MASTER]
AS 
BEGIN
	SELECT T.Task_ID ,T.Task AS [Task],P.Parent_Task AS [Parent],T.Priority,T.Start_Date AS [Start Date],T.END_Date AS [End Date] FROM ParentTask P
	INNER JOIN Task T ON
	P.Parent_ID = T.Parent_ID
END;
GO
/****** Object:  Table [dbo].[ParentTask]    Script Date: 23-08-2019 21:51:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ParentTask](
	[Parent_ID] [int] IDENTITY(1,1) NOT NULL,
	[Parent_Task] [varchar](max) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Parent_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Project]    Script Date: 23-08-2019 21:51:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Project](
	[ProjectID] [int] IDENTITY(1,1) NOT NULL,
	[ProjectName] [varchar](max) NOT NULL,
	[StartDate] [datetime] NOT NULL,
	[EndDate] [datetime] NOT NULL,
	[Priority] [int] NULL,
	[ManagerId] [int] NULL,
	[IsCompleted] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[ProjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Task]    Script Date: 23-08-2019 21:51:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Task](
	[TaskID] [int] IDENTITY(1,1) NOT NULL,
	[ParentTask] [int] NULL,
	[TaskName] [varchar](max) NOT NULL,
	[StartDate] [datetime] NOT NULL,
	[EndDate] [datetime] NOT NULL,
	[Priority] [int] NULL,
	[ProjectId] [int] NULL,
	[IsParentTask] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[TaskID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[User]    Script Date: 23-08-2019 21:51:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[User](
	[EmployeeId] [int] NOT NULL,
	[FirstName] [varchar](max) NOT NULL,
	[LastName] [varchar](max) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[EmployeeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Project] ADD  DEFAULT ((0)) FOR [Priority]
GO
ALTER TABLE [dbo].[Task] ADD  DEFAULT ((0)) FOR [Priority]
GO
ALTER TABLE [dbo].[Project]  WITH CHECK ADD  CONSTRAINT [FK_ManagerId] FOREIGN KEY([ManagerId])
REFERENCES [dbo].[User] ([EmployeeId])
GO
ALTER TABLE [dbo].[Project] CHECK CONSTRAINT [FK_ManagerId]
GO
ALTER TABLE [dbo].[Task]  WITH CHECK ADD  CONSTRAINT [FK_ProjectID] FOREIGN KEY([ProjectId])
REFERENCES [dbo].[Project] ([ProjectID])
GO
ALTER TABLE [dbo].[Task] CHECK CONSTRAINT [FK_ProjectID]
GO
ALTER TABLE [dbo].[Project]  WITH CHECK ADD  CONSTRAINT [ck_prj_Priority] CHECK  (([Priority]>=(0) AND [Priority]<=(30)))
GO
ALTER TABLE [dbo].[Project] CHECK CONSTRAINT [ck_prj_Priority]
GO
ALTER TABLE [dbo].[Task]  WITH CHECK ADD  CONSTRAINT [ck_Priority] CHECK  (([Priority]>=(0) AND [Priority]<=(30)))
GO
ALTER TABLE [dbo].[Task] CHECK CONSTRAINT [ck_Priority]
GO
