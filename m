Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 574DFC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03A412075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:18:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03A412075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729282AbeIFRx3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 13:53:29 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43957 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728724AbeIFRx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 13:53:28 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w86DHmSl305171
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 6 Sep 2018 06:17:48 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w86DHmO5305168;
        Thu, 6 Sep 2018 06:17:48 -0700
Date:   Thu, 6 Sep 2018 06:17:48 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Tzvetomir Stoyanov (VMware)" <tipbot@zytor.com>
Message-ID: <tip-266b851cc2874774a59f04a7b3b059ca0f26569b@git.kernel.org>
Cc:     acme@redhat.com, hpa@zytor.com, tglx@linutronix.de,
        rostedt@goodmis.org, tz.stoyanov@gmail.com, namhyung@kernel.org,
        jolsa@redhat.com, mingo@kernel.org, linux-kernel@vger.kernel.org
Reply-To: acme@redhat.com, hpa@zytor.com, tglx@linutronix.de,
          tz.stoyanov@gmail.com, rostedt@goodmis.org, namhyung@kernel.org,
          jolsa@redhat.com, mingo@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20180828185038.2dcb2743@gandalf.local.home>
References: <20180828185038.2dcb2743@gandalf.local.home>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] tools lib traceevent, perf tools: Split trace-seq
 related APIs in a separate header file
Git-Commit-ID: 266b851cc2874774a59f04a7b3b059ca0f26569b
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  266b851cc2874774a59f04a7b3b059ca0f26569b
Gitweb:     https://git.kernel.org/tip/266b851cc2874774a59f04a7b3b059ca0f26569b
Author:     Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
AuthorDate: Tue, 28 Aug 2018 18:50:38 -0400
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 30 Aug 2018 15:52:20 -0300

tools lib traceevent, perf tools: Split trace-seq related APIs in a separate header file

In order to make libtraceevent into a proper library, all its APIs
should be defined in corresponding header files.  This patch splits
trace-seq related APIs in a separate header file: trace-seq.h

Signed-off-by: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lkml.kernel.org/r/20180828185038.2dcb2743@gandalf.local.home
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/event-parse.c         |  1 +
 tools/lib/traceevent/event-parse.h         | 46 ++-----------------------
 tools/lib/traceevent/event-plugin.c        |  1 +
 tools/lib/traceevent/plugin_function.c     |  1 +
 tools/lib/traceevent/plugin_hrtimer.c      |  1 +
 tools/lib/traceevent/plugin_jbd2.c         |  1 +
 tools/lib/traceevent/plugin_kmem.c         |  1 +
 tools/lib/traceevent/plugin_kvm.c          |  1 +
 tools/lib/traceevent/plugin_mac80211.c     |  1 +
 tools/lib/traceevent/plugin_sched_switch.c |  1 +
 tools/lib/traceevent/plugin_scsi.c         |  1 +
 tools/lib/traceevent/plugin_xen.c          |  1 +
 tools/lib/traceevent/trace-seq.c           |  2 ++
 tools/lib/traceevent/trace-seq.h           | 55 ++++++++++++++++++++++++++++++
 tools/perf/util/trace-event.h              |  1 +
 15 files changed, 71 insertions(+), 44 deletions(-)

diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
index ce1e20227c64..70a42bec6931 100644
--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -24,6 +24,7 @@
 #include <netinet/in.h>
 #include "event-parse.h"
 #include "event-utils.h"
+#include "trace-seq.h"
 
 static const char *input_buf;
 static unsigned long long input_buf_ptr;
diff --git a/tools/lib/traceevent/event-parse.h b/tools/lib/traceevent/event-parse.h
index 44b7c2d41f9f..fa665c66bfa4 100644
--- a/tools/lib/traceevent/event-parse.h
+++ b/tools/lib/traceevent/event-parse.h
@@ -26,17 +26,12 @@
 #include <regex.h>
 #include <string.h>
 
+#include "trace-seq.h"
+
 #ifndef __maybe_unused
 #define __maybe_unused __attribute__((unused))
 #endif
 
-/* ----------------------- trace_seq ----------------------- */
-
-
-#ifndef TRACE_SEQ_BUF_SIZE
-#define TRACE_SEQ_BUF_SIZE 4096
-#endif
-
 #ifndef DEBUG_RECORD
 #define DEBUG_RECORD 0
 #endif
@@ -59,43 +54,6 @@ struct tep_record {
 #endif
 };
 
-enum trace_seq_fail {
-	TRACE_SEQ__GOOD,
-	TRACE_SEQ__BUFFER_POISONED,
-	TRACE_SEQ__MEM_ALLOC_FAILED,
-};
-
-/*
- * Trace sequences are used to allow a function to call several other functions
- * to create a string of data to use (up to a max of PAGE_SIZE).
- */
-
-struct trace_seq {
-	char			*buffer;
-	unsigned int		buffer_size;
-	unsigned int		len;
-	unsigned int		readpos;
-	enum trace_seq_fail	state;
-};
-
-void trace_seq_init(struct trace_seq *s);
-void trace_seq_reset(struct trace_seq *s);
-void trace_seq_destroy(struct trace_seq *s);
-
-extern int trace_seq_printf(struct trace_seq *s, const char *fmt, ...)
-	__attribute__ ((format (printf, 2, 3)));
-extern int trace_seq_vprintf(struct trace_seq *s, const char *fmt, va_list args)
-	__attribute__ ((format (printf, 2, 0)));
-
-extern int trace_seq_puts(struct trace_seq *s, const char *str);
-extern int trace_seq_putc(struct trace_seq *s, unsigned char c);
-
-extern void trace_seq_terminate(struct trace_seq *s);
-
-extern int trace_seq_do_fprintf(struct trace_seq *s, FILE *fp);
-extern int trace_seq_do_printf(struct trace_seq *s);
-
-
 /* ----------------------- pevent ----------------------- */
 
 struct tep_handle;
diff --git a/tools/lib/traceevent/event-plugin.c b/tools/lib/traceevent/event-plugin.c
index f17e25097e1e..ec16a103c0cc 100644
--- a/tools/lib/traceevent/event-plugin.c
+++ b/tools/lib/traceevent/event-plugin.c
@@ -15,6 +15,7 @@
 #include <dirent.h>
 #include "event-parse.h"
 #include "event-utils.h"
+#include "trace-seq.h"
 
 #define LOCAL_PLUGIN_DIR ".traceevent/plugins"
 
diff --git a/tools/lib/traceevent/plugin_function.c b/tools/lib/traceevent/plugin_function.c
index 424747475d37..2919042e7dc2 100644
--- a/tools/lib/traceevent/plugin_function.c
+++ b/tools/lib/traceevent/plugin_function.c
@@ -23,6 +23,7 @@
 
 #include "event-parse.h"
 #include "event-utils.h"
+#include "trace-seq.h"
 
 static struct func_stack {
 	int size;
diff --git a/tools/lib/traceevent/plugin_hrtimer.c b/tools/lib/traceevent/plugin_hrtimer.c
index b43bfec565d8..29b608076ea0 100644
--- a/tools/lib/traceevent/plugin_hrtimer.c
+++ b/tools/lib/traceevent/plugin_hrtimer.c
@@ -23,6 +23,7 @@
 #include <string.h>
 
 #include "event-parse.h"
+#include "trace-seq.h"
 
 static int timer_expire_handler(struct trace_seq *s,
 				struct tep_record *record,
diff --git a/tools/lib/traceevent/plugin_jbd2.c b/tools/lib/traceevent/plugin_jbd2.c
index 45a9acd19640..a5e34135dd6a 100644
--- a/tools/lib/traceevent/plugin_jbd2.c
+++ b/tools/lib/traceevent/plugin_jbd2.c
@@ -22,6 +22,7 @@
 #include <string.h>
 
 #include "event-parse.h"
+#include "trace-seq.h"
 
 #define MINORBITS	20
 #define MINORMASK	((1U << MINORBITS) - 1)
diff --git a/tools/lib/traceevent/plugin_kmem.c b/tools/lib/traceevent/plugin_kmem.c
index 73966b05abce..a7a162575e2c 100644
--- a/tools/lib/traceevent/plugin_kmem.c
+++ b/tools/lib/traceevent/plugin_kmem.c
@@ -22,6 +22,7 @@
 #include <string.h>
 
 #include "event-parse.h"
+#include "trace-seq.h"
 
 static int call_site_handler(struct trace_seq *s, struct tep_record *record,
 			     struct event_format *event, void *context)
diff --git a/tools/lib/traceevent/plugin_kvm.c b/tools/lib/traceevent/plugin_kvm.c
index 1d0d15906225..a0dfd3d0f197 100644
--- a/tools/lib/traceevent/plugin_kvm.c
+++ b/tools/lib/traceevent/plugin_kvm.c
@@ -23,6 +23,7 @@
 #include <stdint.h>
 
 #include "event-parse.h"
+#include "trace-seq.h"
 
 #ifdef HAVE_UDIS86
 
diff --git a/tools/lib/traceevent/plugin_mac80211.c b/tools/lib/traceevent/plugin_mac80211.c
index de50a5316203..0b7779444b63 100644
--- a/tools/lib/traceevent/plugin_mac80211.c
+++ b/tools/lib/traceevent/plugin_mac80211.c
@@ -22,6 +22,7 @@
 #include <string.h>
 
 #include "event-parse.h"
+#include "trace-seq.h"
 
 #define INDENT 65
 
diff --git a/tools/lib/traceevent/plugin_sched_switch.c b/tools/lib/traceevent/plugin_sched_switch.c
index eecb4bd95c11..582d3be2849b 100644
--- a/tools/lib/traceevent/plugin_sched_switch.c
+++ b/tools/lib/traceevent/plugin_sched_switch.c
@@ -22,6 +22,7 @@
 #include <string.h>
 
 #include "event-parse.h"
+#include "trace-seq.h"
 
 static void write_state(struct trace_seq *s, int val)
 {
diff --git a/tools/lib/traceevent/plugin_scsi.c b/tools/lib/traceevent/plugin_scsi.c
index 5ec346f6b842..4eba25cc1431 100644
--- a/tools/lib/traceevent/plugin_scsi.c
+++ b/tools/lib/traceevent/plugin_scsi.c
@@ -3,6 +3,7 @@
 #include <string.h>
 #include <inttypes.h>
 #include "event-parse.h"
+#include "trace-seq.h"
 
 typedef unsigned long sector_t;
 typedef uint64_t u64;
diff --git a/tools/lib/traceevent/plugin_xen.c b/tools/lib/traceevent/plugin_xen.c
index b2acbd6e9c86..bc0496e4c296 100644
--- a/tools/lib/traceevent/plugin_xen.c
+++ b/tools/lib/traceevent/plugin_xen.c
@@ -3,6 +3,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include "event-parse.h"
+#include "trace-seq.h"
 
 #define __HYPERVISOR_set_trap_table			0
 #define __HYPERVISOR_mmu_update				1
diff --git a/tools/lib/traceevent/trace-seq.c b/tools/lib/traceevent/trace-seq.c
index e3bac4543d3b..8ff1d55954d1 100644
--- a/tools/lib/traceevent/trace-seq.c
+++ b/tools/lib/traceevent/trace-seq.c
@@ -3,6 +3,8 @@
  * Copyright (C) 2009 Red Hat Inc, Steven Rostedt <srostedt@redhat.com>
  *
  */
+#include "trace-seq.h"
+
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
diff --git a/tools/lib/traceevent/trace-seq.h b/tools/lib/traceevent/trace-seq.h
new file mode 100644
index 000000000000..d68ec69f8d1a
--- /dev/null
+++ b/tools/lib/traceevent/trace-seq.h
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: LGPL-2.1
+/*
+ * Copyright (C) 2009, 2010 Red Hat Inc, Steven Rostedt <srostedt@redhat.com>
+ *
+ */
+
+#ifndef _TRACE_SEQ_H
+#define _TRACE_SEQ_H
+
+#include <stdarg.h>
+#include <stdio.h>
+
+/* ----------------------- trace_seq ----------------------- */
+
+#ifndef TRACE_SEQ_BUF_SIZE
+#define TRACE_SEQ_BUF_SIZE 4096
+#endif
+
+enum trace_seq_fail {
+	TRACE_SEQ__GOOD,
+	TRACE_SEQ__BUFFER_POISONED,
+	TRACE_SEQ__MEM_ALLOC_FAILED,
+};
+
+/*
+ * Trace sequences are used to allow a function to call several other functions
+ * to create a string of data to use (up to a max of PAGE_SIZE).
+ */
+
+struct trace_seq {
+	char			*buffer;
+	unsigned int		buffer_size;
+	unsigned int		len;
+	unsigned int		readpos;
+	enum trace_seq_fail	state;
+};
+
+void trace_seq_init(struct trace_seq *s);
+void trace_seq_reset(struct trace_seq *s);
+void trace_seq_destroy(struct trace_seq *s);
+
+extern int trace_seq_printf(struct trace_seq *s, const char *fmt, ...)
+	__attribute__ ((format (printf, 2, 3)));
+extern int trace_seq_vprintf(struct trace_seq *s, const char *fmt, va_list args)
+	__attribute__ ((format (printf, 2, 0)));
+
+extern int trace_seq_puts(struct trace_seq *s, const char *str);
+extern int trace_seq_putc(struct trace_seq *s, unsigned char c);
+
+extern void trace_seq_terminate(struct trace_seq *s);
+
+extern int trace_seq_do_fprintf(struct trace_seq *s, FILE *fp);
+extern int trace_seq_do_printf(struct trace_seq *s);
+
+#endif /* _TRACE_SEQ_H */
diff --git a/tools/perf/util/trace-event.h b/tools/perf/util/trace-event.h
index 40204ec3a7a2..c69d77d7cf55 100644
--- a/tools/perf/util/trace-event.h
+++ b/tools/perf/util/trace-event.h
@@ -3,6 +3,7 @@
 #define _PERF_UTIL_TRACE_EVENT_H
 
 #include <traceevent/event-parse.h>
+#include <traceevent/trace-seq.h>
 #include "parse-events.h"
 
 struct machine;
