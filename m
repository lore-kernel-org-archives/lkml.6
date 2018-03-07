Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935011AbeCGUfP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 15:35:15 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48442 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934899AbeCGUfK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 15:35:10 -0500
From: Waiman Long <longman@redhat.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Waiman Long <longman@redhat.com>
Subject: [PATCH 5/5] ipc: Show ranges of msgmni and shmmni with CTL_FLAGS_SHOW_RANGE
Date: Wed,  7 Mar 2018 15:34:29 -0500
Message-Id: <1520454869-13871-6-git-send-email-longman@redhat.com>
In-Reply-To: <1520454869-13871-1-git-send-email-longman@redhat.com>
References: <1520454869-13871-1-git-send-email-longman@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CTL_FLAGS_SHOW_RANGE flag is added to the msgmni and shmmni
ctl_table entries to show their ranges. Two range table entries are
reserved for the new *_range sysctl parameters.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 ipc/ipc_sysctl.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/ipc/ipc_sysctl.c b/ipc/ipc_sysctl.c
index 2c03f57..3b4d7cd 100644
--- a/ipc/ipc_sysctl.c
+++ b/ipc/ipc_sysctl.c
@@ -143,7 +143,7 @@ static int proc_ipc_sem_dointvec(struct ctl_table *table, int write,
 		.proc_handler	= proc_ipc_dointvec_minmax,
 		.extra1		= &zero,
 		.extra2		= &ipc_mni,
-		.flags		= CTL_FLAGS_CLAMP_RANGE,
+		.flags		= CTL_FLAGS_CLAMP_RANGE|CTL_FLAGS_SHOW_RANGE,
 	},
 	{
 		.procname	= "shm_rmid_forced",
@@ -171,7 +171,7 @@ static int proc_ipc_sem_dointvec(struct ctl_table *table, int write,
 		.proc_handler	= proc_ipc_dointvec_minmax,
 		.extra1		= &zero,
 		.extra2		= &ipc_mni,
-		.flags		= CTL_FLAGS_CLAMP_RANGE,
+		.flags		= CTL_FLAGS_CLAMP_RANGE|CTL_FLAGS_SHOW_RANGE,
 	},
 	{
 		.procname	= "auto_msgmni",
@@ -228,6 +228,7 @@ static int proc_ipc_sem_dointvec(struct ctl_table *table, int write,
 		.extra2		= &int_max,
 	},
 #endif
+	CTL_RESERVE_RANGES(2)
 	{}
 };
 
-- 
1.8.3.1
