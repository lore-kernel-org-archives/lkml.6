Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752504AbeCUCZM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 22:25:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:45500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751999AbeCUCVh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 22:21:37 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87DDF21852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180321022129.551521939@goodmis.org>
User-Agent: quilt/0.63-1
Date: Tue, 20 Mar 2018 22:21:25 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [for-next][PATCH 33/46] tracing: Make tracing_set_clock() non-static
References: <20180321022052.030055576@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0033-tracing-Make-tracing_set_clock-non-static.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

Allow tracing code outside of trace.c to access tracing_set_clock().

Some applications may require a particular clock in order to function
properly, such as latency calculations.

Also, add an accessor returning the current clock string.

Link: http://lkml.kernel.org/r/6d1c53e9ee2163f54e1849f5376573f54f0e6009.1516069914.git.tom.zanussi@linux.intel.com

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 2 +-
 kernel/trace/trace.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 68f8702af9fb..551a7cd0d705 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6214,7 +6214,7 @@ static int tracing_clock_show(struct seq_file *m, void *v)
 	return 0;
 }
 
-static int tracing_set_clock(struct trace_array *tr, const char *clockstr)
+int tracing_set_clock(struct trace_array *tr, const char *clockstr)
 {
 	int i;
 
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 99b7ee7ed127..9de3e2a2f042 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -289,6 +289,7 @@ extern int trace_array_get(struct trace_array *tr);
 extern void trace_array_put(struct trace_array *tr);
 
 extern int tracing_set_time_stamp_abs(struct trace_array *tr, bool abs);
+extern int tracing_set_clock(struct trace_array *tr, const char *clockstr);
 
 extern bool trace_clock_in_ns(struct trace_array *tr);
 
-- 
2.15.1
