Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752223AbeA3AzG (ORCPT <rfc822;w@1wt.eu>);
        Mon, 29 Jan 2018 19:55:06 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:45299 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751417AbeA3AzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jan 2018 19:55:06 -0500
From: Yisheng Xie <xieyisheng1@huawei.com>
To: <rostedt@goodmis.org>, <mingo@redhat.com>
CC: <linux-kernel@vger.kernel.org>, Yisheng Xie <xieyisheng1@huawei.com>
Subject: [PATCH] ftrace: use helper function clear_ftrace_function
Date: Tue, 30 Jan 2018 08:46:01 +0800
Message-ID: <1517273161-36355-1-git-send-email-xieyisheng1@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have helper function clear_ftrace_function(), use it instead of hard
code. And this should not have any functional change.

Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
---
 kernel/trace/ftrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 554b517..ba78e03 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6779,7 +6779,7 @@ int unregister_ftrace_function(struct ftrace_ops *ops)
 
 	} else {
 		/* stopping ftrace calls (just send to ftrace_stub) */
-		ftrace_trace_function = ftrace_stub;
+		clear_ftrace_function();
 
 		ftrace_shutdown_sysctl();
 	}
-- 
1.7.12.4
