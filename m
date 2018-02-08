Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752172AbeBHBmH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 20:42:07 -0500
Received: from smtpproxy19.qq.com ([184.105.206.84]:45832 "EHLO
        smtpproxy19.qq.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751946AbeBHBmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 20:42:05 -0500
X-QQ-mid: bizesmtp2t1518054113triu705dj
X-QQ-SSF: 01400000004000F0FG22000A0000000
X-QQ-FEAT: q17Yoz/cMVoSSt4MCESbxrzGT53eatARnlfGYK+84eHjS8O5jH2f/lTlJP90F
        GXVh0UO3ug+PIqw6SPxG+hGjVK5WWbzt1RH15emDqvsc4Uu4iTyoQ2S6JnK+xB13mxZl6FA
        oRzjI1HntW8IeOZ99KibUtcWEabBMfUK5oOm9/W2lsnCaUMH2Ghg7aVVfMEVKAQ1SDqP7Tt
        VF24QVOZ8d9OcTyOni5f5B0Y24MvolZkRIi2s95hn6TsAmMBC8rZ7FCKOG0lc5+p1FwXQKL
        qFXyB4XS18Swu/vQ8Pmmzbf1iSMISDe9Qx2A==
X-QQ-GoodBg: 2
From: Zhengyuan Liu <liuzhengyuan@kylinos.cn>
To: rostedt@goodmis.org
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org,
        liuzhengyuang521@gmail.com, linx.z.chen@intel.com
Subject: [PATCH] ftrace: fix the file mode of graph tracer and stack tracer
Date: Thu,  8 Feb 2018 09:41:53 +0800
Message-Id: <1518054113-28096-1-git-send-email-liuzhengyuan@kylinos.cn>
X-Mailer: git-send-email 2.7.4
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:kylinos.cn:qybgforeign:qybgforeign4
X-QQ-Bgrelay: 1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's something looks weird that those files could be written by root
but shows with no write permission by ll command.
Chen LinX <linx.z.chen@intel.com> has sent a similar patch to fix
graph function file mode in 2000,  I didn't get the reason why that
patch wasn't applied so I resend it.

Signed-off-by: Zhengyuan Liu <liuzhengyuan@kylinos.cn>
---
 kernel/trace/ftrace.c      | 4 ++--
 kernel/trace/trace_stack.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index ccdf366..fe903dc8 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5513,10 +5513,10 @@ static __init int ftrace_init_dyn_tracefs(struct dentry *d_tracer)
 	ftrace_create_filter_files(&global_ops, d_tracer);
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
-	trace_create_file("set_graph_function", 0444, d_tracer,
+	trace_create_file("set_graph_function", 0644, d_tracer,
 				    NULL,
 				    &ftrace_graph_fops);
-	trace_create_file("set_graph_notrace", 0444, d_tracer,
+	trace_create_file("set_graph_notrace", 0644, d_tracer,
 				    NULL,
 				    &ftrace_graph_notrace_fops);
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
diff --git a/kernel/trace/trace_stack.c b/kernel/trace/trace_stack.c
index 734accc..4356f14 100644
--- a/kernel/trace/trace_stack.c
+++ b/kernel/trace/trace_stack.c
@@ -468,7 +468,7 @@ static __init int stack_trace_init(void)
 			NULL, &stack_trace_fops);
 
 #ifdef CONFIG_DYNAMIC_FTRACE
-	trace_create_file("stack_trace_filter", 0444, d_tracer,
+	trace_create_file("stack_trace_filter", 0644, d_tracer,
 			  &trace_ops, &stack_trace_filter_fops);
 #endif
 
-- 
2.7.4
