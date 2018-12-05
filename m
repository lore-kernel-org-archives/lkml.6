Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3EA5C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AF60214DA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:48:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AF60214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728891AbeLEXsa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 18:48:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:58246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728411AbeLEXsa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 18:48:30 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1D6F206B7;
        Wed,  5 Dec 2018 23:48:29 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1gUgu4-000063-Jl; Wed, 05 Dec 2018 18:48:28 -0500
Message-Id: <20181205234828.508662484@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 05 Dec 2018 18:47:50 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [for-next][PATCH 01/30] function_graph: Remove unused task_curr_ret_stack()
References: <20181205234749.372720574@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

The static inline function task_curr_ret_stack() is unused, remove it.

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/ftrace.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index dd16e8218db3..10bd46434908 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -809,11 +809,6 @@ extern void ftrace_graph_init_task(struct task_struct *t);
 extern void ftrace_graph_exit_task(struct task_struct *t);
 extern void ftrace_graph_init_idle_task(struct task_struct *t, int cpu);
 
-static inline int task_curr_ret_stack(struct task_struct *t)
-{
-	return t->curr_ret_stack;
-}
-
 static inline void pause_graph_tracing(void)
 {
 	atomic_inc(&current->tracing_graph_pause);
@@ -838,11 +833,6 @@ static inline int register_ftrace_graph(trace_func_graph_ret_t retfunc,
 }
 static inline void unregister_ftrace_graph(void) { }
 
-static inline int task_curr_ret_stack(struct task_struct *tsk)
-{
-	return -1;
-}
-
 static inline unsigned long
 ftrace_graph_ret_addr(struct task_struct *task, int *idx, unsigned long ret,
 		      unsigned long *retp)
-- 
2.19.1


