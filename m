Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45954C46460
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 13:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB298217AE
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 13:53:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB298217AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbeHKQ1R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 12:27:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:39966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727379AbeHKQY3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 12:24:29 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24DE621A2D;
        Sat, 11 Aug 2018 13:50:13 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1foUHU-00063I-60; Sat, 11 Aug 2018 09:50:12 -0400
Message-Id: <20180811135012.070051434@goodmis.org>
User-Agent: quilt/0.65
Date:   Sat, 11 Aug 2018 09:49:35 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 07/34] tracing: Remove orphaned function using_ftrace_ops_list_func().
References: <20180811134928.034373761@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Remove using_ftrace_ops_list_func() since it is no longer used.

Using ftrace_ops_list_func() has been introduced by commit 7eea4fce0246
("tracing/stack_trace: Skip 4 instead of 3 when using ftrace_ops_list_func")
as a helper function, but its caller has been removed by commit 72ac426a5bb0
("tracing: Clean up stack tracing and fix fentry updates").  So it is not
called anymore.

Link: http://lkml.kernel.org/r/153260904427.12474.9952096317439329851.stgit@devbox

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 5 -----
 kernel/trace/trace.h  | 1 -
 2 files changed, 6 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index caf9cbf35816..b8b3324ca1c8 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -313,11 +313,6 @@ static void update_ftrace_function(void)
 	ftrace_trace_function = func;
 }
 
-int using_ftrace_ops_list_func(void)
-{
-	return ftrace_trace_function == ftrace_ops_list_func;
-}
-
 static void add_ftrace_ops(struct ftrace_ops __rcu **list,
 			   struct ftrace_ops *ops)
 {
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 3f9d9acc69e6..e1c8a1d6f240 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -937,7 +937,6 @@ void ftrace_destroy_function_files(struct trace_array *tr);
 void ftrace_init_global_array_ops(struct trace_array *tr);
 void ftrace_init_array_ops(struct trace_array *tr, ftrace_func_t func);
 void ftrace_reset_array_ops(struct trace_array *tr);
-int using_ftrace_ops_list_func(void);
 void ftrace_init_tracefs(struct trace_array *tr, struct dentry *d_tracer);
 void ftrace_init_tracefs_toplevel(struct trace_array *tr,
 				  struct dentry *d_tracer);
-- 
2.18.0


