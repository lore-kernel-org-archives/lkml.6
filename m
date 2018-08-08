Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 356A3C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 18:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE28321797
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 18:08:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE28321797
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731614AbeHHU3l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 16:29:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:50894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729734AbeHHU1w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 16:27:52 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E3DC21A29;
        Wed,  8 Aug 2018 18:07:01 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1fnSrM-0002Mu-IY; Wed, 08 Aug 2018 14:07:00 -0400
Message-Id: <20180808180700.469749700@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 08 Aug 2018 14:02:51 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org, linux-trace-devel@vger.kernel.org
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>,
        "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>
Subject: [RFC][PATCH v2 06/24] tools/lib/traceevent, tools/perf: Rename pevent parse APIs
References: <20180808180245.352784763@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>

In order to make libtraceevent into a proper library, variables, data
structures and functions require a unique prefix to prevent name space
conflicts. That prefix will be "tep_" and not "pevent_". This changes
APIs: pevent_parse_event, pevent_parse_format, pevent_parse_header_page

Signed-off-by: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/lib/traceevent/event-parse.c  | 22 +++++++++++-----------
 tools/lib/traceevent/event-parse.h  | 18 +++++++++---------
 tools/perf/util/trace-event-parse.c |  4 ++--
 tools/perf/util/trace-event-read.c  |  4 ++--
 tools/perf/util/trace-event.c       |  2 +-
 5 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
index 29f22e432084..419e57f5bbf3 100644
--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -5930,7 +5930,7 @@ static void parse_header_field(const char *field,
 }
 
 /**
- * pevent_parse_header_page - parse the data stored in the header page
+ * tep_parse_header_page - parse the data stored in the header page
  * @pevent: the handle to the pevent
  * @buf: the buffer storing the header page format string
  * @size: the size of @buf
@@ -5941,8 +5941,8 @@ static void parse_header_field(const char *field,
  *
  * /sys/kernel/debug/tracing/events/header_page
  */
-int pevent_parse_header_page(struct tep_handle *pevent, char *buf, unsigned long size,
-			     int long_size)
+int tep_parse_header_page(struct tep_handle *pevent, char *buf, unsigned long size,
+			  int long_size)
 {
 	int ignore;
 
@@ -6171,7 +6171,7 @@ __pevent_parse_event(struct tep_handle *pevent,
 }
 
 /**
- * pevent_parse_format - parse the event format
+ * tep_parse_format - parse the event format
  * @pevent: the handle to the pevent
  * @eventp: returned format
  * @buf: the buffer storing the event format string
@@ -6185,16 +6185,16 @@ __pevent_parse_event(struct tep_handle *pevent,
  *
  * /sys/kernel/debug/tracing/events/.../.../format
  */
-enum pevent_errno pevent_parse_format(struct tep_handle *pevent,
-				      struct event_format **eventp,
-				      const char *buf,
-				      unsigned long size, const char *sys)
+enum pevent_errno tep_parse_format(struct tep_handle *pevent,
+				   struct event_format **eventp,
+				   const char *buf,
+				   unsigned long size, const char *sys)
 {
 	return __pevent_parse_event(pevent, eventp, buf, size, sys);
 }
 
 /**
- * pevent_parse_event - parse the event format
+ * tep_parse_event - parse the event format
  * @pevent: the handle to the pevent
  * @buf: the buffer storing the event format string
  * @size: the size of @buf
@@ -6207,8 +6207,8 @@ enum pevent_errno pevent_parse_format(struct tep_handle *pevent,
  *
  * /sys/kernel/debug/tracing/events/.../.../format
  */
-enum pevent_errno pevent_parse_event(struct tep_handle *pevent, const char *buf,
-				     unsigned long size, const char *sys)
+enum pevent_errno tep_parse_event(struct tep_handle *pevent, const char *buf,
+				  unsigned long size, const char *sys)
 {
 	struct event_format *event = NULL;
 	return __pevent_parse_event(pevent, &event, buf, size, sys);
diff --git a/tools/lib/traceevent/event-parse.h b/tools/lib/traceevent/event-parse.h
index 83c78290061e..eae429a98f7a 100644
--- a/tools/lib/traceevent/event-parse.h
+++ b/tools/lib/traceevent/event-parse.h
@@ -639,15 +639,15 @@ void pevent_print_event_data(struct tep_handle *pevent, struct trace_seq *s,
 void pevent_print_event(struct tep_handle *pevent, struct trace_seq *s,
 			struct tep_record *record, bool use_trace_clock);
 
-int pevent_parse_header_page(struct tep_handle *pevent, char *buf, unsigned long size,
-			     int long_size);
-
-enum pevent_errno pevent_parse_event(struct tep_handle *pevent, const char *buf,
-				     unsigned long size, const char *sys);
-enum pevent_errno pevent_parse_format(struct tep_handle *pevent,
-				      struct event_format **eventp,
-				      const char *buf,
-				      unsigned long size, const char *sys);
+int tep_parse_header_page(struct tep_handle *pevent, char *buf, unsigned long size,
+			  int long_size);
+
+enum pevent_errno tep_parse_event(struct tep_handle *pevent, const char *buf,
+				  unsigned long size, const char *sys);
+enum pevent_errno tep_parse_format(struct tep_handle *pevent,
+				   struct event_format **eventp,
+				   const char *buf,
+				   unsigned long size, const char *sys);
 void pevent_free_format(struct event_format *event);
 void pevent_free_format_field(struct format_field *field);
 
diff --git a/tools/perf/util/trace-event-parse.c b/tools/perf/util/trace-event-parse.c
index 0a769a340fc9..f8b91f3813ca 100644
--- a/tools/perf/util/trace-event-parse.c
+++ b/tools/perf/util/trace-event-parse.c
@@ -180,13 +180,13 @@ void parse_saved_cmdline(struct tep_handle *pevent,
 
 int parse_ftrace_file(struct tep_handle *pevent, char *buf, unsigned long size)
 {
-	return pevent_parse_event(pevent, buf, size, "ftrace");
+	return tep_parse_event(pevent, buf, size, "ftrace");
 }
 
 int parse_event_file(struct tep_handle *pevent,
 		     char *buf, unsigned long size, char *sys)
 {
-	return pevent_parse_event(pevent, buf, size, sys);
+	return tep_parse_event(pevent, buf, size, sys);
 }
 
 struct event_format *trace_find_next_event(struct tep_handle *pevent,
diff --git a/tools/perf/util/trace-event-read.c b/tools/perf/util/trace-event-read.c
index cbd4970415ef..a89a50dee8e7 100644
--- a/tools/perf/util/trace-event-read.c
+++ b/tools/perf/util/trace-event-read.c
@@ -235,8 +235,8 @@ static int read_header_files(struct tep_handle *pevent)
 		return -1;
 	}
 
-	if (!pevent_parse_header_page(pevent, header_page, size,
-				      pevent_get_long_size(pevent))) {
+	if (!tep_parse_header_page(pevent, header_page, size,
+				   pevent_get_long_size(pevent))) {
 		/*
 		 * The commit field in the page is of type long,
 		 * use that instead, since it represents the kernel.
diff --git a/tools/perf/util/trace-event.c b/tools/perf/util/trace-event.c
index 116fffa788b9..eed1c11c1915 100644
--- a/tools/perf/util/trace-event.c
+++ b/tools/perf/util/trace-event.c
@@ -93,7 +93,7 @@ tp_format(const char *sys, const char *name)
 	if (err)
 		return ERR_PTR(err);
 
-	pevent_parse_format(pevent, &event, data, size, sys);
+	tep_parse_format(pevent, &event, data, size, sys);
 
 	free(data);
 	return event;
-- 
2.18.0


