Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752414AbeEPPGO (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 11:06:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:48634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751290AbeEPPCB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 11:02:01 -0400
Message-Id: <20180516150159.757510877@goodmis.org>
User-Agent: quilt/0.63-1
Date: Wed, 16 May 2018 11:00:16 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Karim Yaghmour <karim.yaghmour@opersys.com>,
        Brendan Gregg <bgregg@netflix.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Yann Ylavic <ylavic.dev@gmail.com>,
        linux-rt-users@vger.kernel.org
Subject: [PATCH v3 04/14] tracing: Add brackets in ftrace event dynamic arrays
References: <20180516150012.135869655@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0004-tracing-Add-brackets-in-ftrace-event-dynamic-arrays.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

The dynamic arrays defined for ftrace internal events, such as the buf field
for trace_marker (ftrace/print) did not have brackets which makes the filter
code not accept it as a string. This is not currently an issues because the
filter code doesn't do anything for these events, but they will in the
future, and this needs to be fixed for when it does.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_export.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_export.c b/kernel/trace/trace_export.c
index 548e62eb5c46..d842f1eadfe5 100644
--- a/kernel/trace/trace_export.c
+++ b/kernel/trace/trace_export.c
@@ -117,7 +117,7 @@ static void __always_unused ____ftrace_check_##name(void)		\
 
 #undef __dynamic_array
 #define __dynamic_array(type, item)					\
-	ret = trace_define_field(event_call, #type, #item,		\
+	ret = trace_define_field(event_call, #type "[]", #item,  \
 				 offsetof(typeof(field), item),		\
 				 0, is_signed_type(type), filter_type);\
 	if (ret)							\
-- 
2.17.0
