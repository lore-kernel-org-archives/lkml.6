Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751801AbeCUC1L (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 22:27:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:45048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751959AbeCUCVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 22:21:32 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1839521840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180321022126.019682423@goodmis.org>
User-Agent: quilt/0.63-1
Date: Tue, 20 Mar 2018 22:21:09 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [for-next][PATCH 17/46] tracing: Move get_hist_field_flags()
References: <20180321022052.030055576@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0017-tracing-Move-get_hist_field_flags.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

Move get_hist_field_flags() to make it more easily accessible for new
code (and keep the move separate from new functionality).

Link: http://lkml.kernel.org/r/32470f0a7047ec7a6e84ba5ec89d6142cc6ede7d.1516069914.git.tom.zanussi@linux.intel.com

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 44 ++++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index ba326260c034..a81a709dc703 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -497,6 +497,28 @@ static const struct tracing_map_ops hist_trigger_elt_comm_ops = {
 	.elt_init	= hist_trigger_elt_comm_init,
 };
 
+static const char *get_hist_field_flags(struct hist_field *hist_field)
+{
+	const char *flags_str = NULL;
+
+	if (hist_field->flags & HIST_FIELD_FL_HEX)
+		flags_str = "hex";
+	else if (hist_field->flags & HIST_FIELD_FL_SYM)
+		flags_str = "sym";
+	else if (hist_field->flags & HIST_FIELD_FL_SYM_OFFSET)
+		flags_str = "sym-offset";
+	else if (hist_field->flags & HIST_FIELD_FL_EXECNAME)
+		flags_str = "execname";
+	else if (hist_field->flags & HIST_FIELD_FL_SYSCALL)
+		flags_str = "syscall";
+	else if (hist_field->flags & HIST_FIELD_FL_LOG2)
+		flags_str = "log2";
+	else if (hist_field->flags & HIST_FIELD_FL_TIMESTAMP_USECS)
+		flags_str = "usecs";
+
+	return flags_str;
+}
+
 static void destroy_hist_field(struct hist_field *hist_field,
 			       unsigned int level)
 {
@@ -1495,28 +1517,6 @@ const struct file_operations event_hist_fops = {
 	.release = single_release,
 };
 
-static const char *get_hist_field_flags(struct hist_field *hist_field)
-{
-	const char *flags_str = NULL;
-
-	if (hist_field->flags & HIST_FIELD_FL_HEX)
-		flags_str = "hex";
-	else if (hist_field->flags & HIST_FIELD_FL_SYM)
-		flags_str = "sym";
-	else if (hist_field->flags & HIST_FIELD_FL_SYM_OFFSET)
-		flags_str = "sym-offset";
-	else if (hist_field->flags & HIST_FIELD_FL_EXECNAME)
-		flags_str = "execname";
-	else if (hist_field->flags & HIST_FIELD_FL_SYSCALL)
-		flags_str = "syscall";
-	else if (hist_field->flags & HIST_FIELD_FL_LOG2)
-		flags_str = "log2";
-	else if (hist_field->flags & HIST_FIELD_FL_TIMESTAMP_USECS)
-		flags_str = "usecs";
-
-	return flags_str;
-}
-
 static void hist_field_print(struct seq_file *m, struct hist_field *hist_field)
 {
 	const char *field_name = hist_field_name(hist_field, 0);
-- 
2.15.1
