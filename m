Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751731AbeEDPyN (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 11:54:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:57728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751508AbeEDPyK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 11:54:10 -0400
Message-Id: <20180504155408.949705090@goodmis.org>
User-Agent: quilt/0.63-1
Date: Fri, 04 May 2018 11:52:43 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zhengyuan Liu <liuzhengyuan@kylinos.cn>
Subject: [PATCH 2/2] tracing: Fix the file mode of stack tracer
References: <20180504155241.113624273@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0002-tracing-Fix-the-file-mode-of-stack-tracer.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhengyuan Liu <liuzhengyuan@kylinos.cn>

It looks weird that the stack_trace_filter file can be written by root
but shows that it does not have write permission by ll command.

Link: http://lkml.kernel.org/r/1518054113-28096-1-git-send-email-liuzhengyuan@kylinos.cn

Signed-off-by: Zhengyuan Liu <liuzhengyuan@kylinos.cn>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_stack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_stack.c b/kernel/trace/trace_stack.c
index 3c7bfc4bf5e9..4237eba4ef20 100644
--- a/kernel/trace/trace_stack.c
+++ b/kernel/trace/trace_stack.c
@@ -472,7 +472,7 @@ static __init int stack_trace_init(void)
 			NULL, &stack_trace_fops);
 
 #ifdef CONFIG_DYNAMIC_FTRACE
-	trace_create_file("stack_trace_filter", 0444, d_tracer,
+	trace_create_file("stack_trace_filter", 0644, d_tracer,
 			  &trace_ops, &stack_trace_filter_fops);
 #endif
 
-- 
2.17.0
