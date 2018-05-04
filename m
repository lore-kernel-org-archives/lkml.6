Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751690AbeEDPyM (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 11:54:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:57722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751456AbeEDPyK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 11:54:10 -0400
Message-Id: <20180504155408.789831945@goodmis.org>
User-Agent: quilt/0.63-1
Date: Fri, 04 May 2018 11:52:42 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Namhyung Kim <namhyung@kernel.org>, Chen LinX <linx.z.chen@intel.com>
Subject: [PATCH 1/2] ftrace: Have set_graph_* files have normal file modes
References: <20180504155241.113624273@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0001-ftrace-Have-set_graph_-files-have-normal-file-modes.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen LinX <linx.z.chen@intel.com>

The set_graph_function and set_graph_notrace file mode should be 0644
instead of 0444 as they are writeable. Note, the mode appears to be ignored
regardless, but they should at least look sane.

Link: http://lkml.kernel.org/r/1409725869-4501-1-git-send-email-linx.z.chen@intel.com

Acked-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Chen LinX <linx.z.chen@intel.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 16bbf062018f..8d83bcf9ef69 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5514,10 +5514,10 @@ static __init int ftrace_init_dyn_tracefs(struct dentry *d_tracer)
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
-- 
2.17.0
