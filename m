Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752943AbeC1Mcx (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 08:32:53 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:38863 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752065AbeC1Mcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 08:32:52 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R631e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07488;MF=yuwang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0T-EMcPG_1522240349;
From: Wang Yu <yuwang@linux.alibaba.com>
To: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel@vger.kernel.org, Wang Yu <yuwang@linux.alibaba.com>
Subject: [PATCH] ftrace: fix task's invalid comm of <...> when big pid
Date: Wed, 28 Mar 2018 20:32:27 +0800
Message-Id: <1522240347-24465-1-git-send-email-yuwang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

when pid is bigger than PID_MAX_DEFAULT, the comm of task
is <...>, it is better use pid_max to compare

Signed-off-by: Wang Yu <yuwang@linux.alibaba.com>
---
 kernel/trace/trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 mode change 100644 => 100755 kernel/trace/trace.c

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
old mode 100644
new mode 100755
index 20a2300..0d4bc7a
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1976,7 +1976,7 @@ static void __trace_find_cmdline(int pid, char comm[])
 		return;
 	}
 
-	if (pid > PID_MAX_DEFAULT) {
+	if (pid > pid_max) {
 		strcpy(comm, "<...>");
 		return;
 	}
-- 
1.8.3.1
