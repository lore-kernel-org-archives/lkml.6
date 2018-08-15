Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D27C7C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 15:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEA0321475
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 15:07:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ie7deLXT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEA0321475
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729864AbeHOR7u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 13:59:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:49760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729386AbeHOR7t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 13:59:49 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3002A20C0E;
        Wed, 15 Aug 2018 15:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534345636;
        bh=1ZO86iBB5jnIDzRCWae9hioNjFxvBeNTCdAV0pBAxaE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ie7deLXTb44dRqtX5Ap6cE+I1TabUpR30BP60KdQFub23oW/hU8u3u8jFgr+1VxwF
         wavI0ZLXPR8FEKA1Gxx1/O2ZBtiwvGvQoA4ZNs4UROueOjjtmqh8wIr9W056Je22NW
         AXn+muTTJeUVjfxu8Hp/PXV57Y4ohXG7byh6qTKc=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Yordan Karadzhov <y.karadz@gmail.com>,
        linux-trace-devel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 05/35] tools lib traceevent, perf tools: Rename pevent alloc / free APIs
Date:   Wed, 15 Aug 2018 12:05:41 -0300
Message-Id: <20180815150611.32080-6-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180815150611.32080-1-acme@kernel.org>
References: <20180815150611.32080-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>

In order to make libtraceevent into a proper library, variables, data
structures and functions require a unique prefix to prevent name space
conflicts. That prefix will be "tep_" and not "pevent_". This changes
APIs: pevent_alloc, pevent_free, pevent_event_info and pevent_func_resolver_t

Signed-off-by: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Yordan Karadzhov (VMware) <y.karadz@gmail.com>
Cc: linux-trace-devel@vger.kernel.org
Link: http://lkml.kernel.org/r/20180808180700.152609945@goodmis.org
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/event-parse.c  | 24 ++++++++++++------------
 tools/lib/traceevent/event-parse.h  | 12 ++++++------
 tools/perf/builtin-kmem.c           |  2 +-
 tools/perf/util/sort.c              |  2 +-
 tools/perf/util/trace-event-parse.c |  2 +-
 tools/perf/util/trace-event.c       |  6 +++---
 tools/perf/util/trace-event.h       |  2 +-
 7 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
index 57ed9348d1aa..040180f6ed74 100644
--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -438,9 +438,9 @@ __find_func(struct tep_handle *pevent, unsigned long long addr)
 }
 
 struct func_resolver {
-	pevent_func_resolver_t *func;
-	void		       *priv;
-	struct func_map	       map;
+	tep_func_resolver_t	*func;
+	void			*priv;
+	struct func_map		map;
 };
 
 /**
@@ -454,7 +454,7 @@ struct func_resolver {
  * pevent->funclist.
  */
 int pevent_set_function_resolver(struct tep_handle *pevent,
-				 pevent_func_resolver_t *func, void *priv)
+				 tep_func_resolver_t *func, void *priv)
 {
 	struct func_resolver *resolver = malloc(sizeof(*resolver));
 
@@ -5399,8 +5399,8 @@ int pevent_cmdline_pid(struct tep_handle *pevent, struct cmdline *cmdline)
  * This parses the raw @data using the given @event information and
  * writes the print format into the trace_seq.
  */
-void pevent_event_info(struct trace_seq *s, struct event_format *event,
-		       struct tep_record *record)
+void tep_event_info(struct trace_seq *s, struct event_format *event,
+		    struct tep_record *record)
 {
 	int print_pretty = 1;
 
@@ -5556,7 +5556,7 @@ void pevent_print_event_data(struct tep_handle *pevent, struct trace_seq *s,
 	if (len < 20)
 		trace_seq_printf(s, "%.*s", 20 - len, spaces);
 
-	pevent_event_info(s, event, record);
+	tep_event_info(s, event, record);
 }
 
 void pevent_print_event(struct tep_handle *pevent, struct trace_seq *s,
@@ -6754,9 +6754,9 @@ int pevent_unregister_event_handler(struct tep_handle *pevent, int id,
 }
 
 /**
- * pevent_alloc - create a pevent handle
+ * tep_alloc - create a pevent handle
  */
-struct tep_handle *pevent_alloc(void)
+struct tep_handle *tep_alloc(void)
 {
 	struct tep_handle *pevent = calloc(1, sizeof(*pevent));
 
@@ -6811,10 +6811,10 @@ void pevent_free_format(struct event_format *event)
 }
 
 /**
- * pevent_free - free a pevent handle
+ * tep_free - free a pevent handle
  * @pevent: the pevent handle to free
  */
-void pevent_free(struct tep_handle *pevent)
+void tep_free(struct tep_handle *pevent)
 {
 	struct cmdline_list *cmdlist, *cmdnext;
 	struct func_list *funclist, *funcnext;
@@ -6901,5 +6901,5 @@ void pevent_free(struct tep_handle *pevent)
 
 void pevent_unref(struct tep_handle *pevent)
 {
-	pevent_free(pevent);
+	tep_free(pevent);
 }
diff --git a/tools/lib/traceevent/event-parse.h b/tools/lib/traceevent/event-parse.h
index b4b698c3833e..c229240666b7 100644
--- a/tools/lib/traceevent/event-parse.h
+++ b/tools/lib/traceevent/event-parse.h
@@ -454,8 +454,8 @@ struct func_list;
 struct event_handler;
 struct func_resolver;
 
-typedef char *(pevent_func_resolver_t)(void *priv,
-				       unsigned long long *addrp, char **modp);
+typedef char *(tep_func_resolver_t)(void *priv,
+				    unsigned long long *addrp, char **modp);
 
 struct tep_handle {
 	int ref_count;
@@ -616,7 +616,7 @@ enum trace_flag_type {
 };
 
 int pevent_set_function_resolver(struct tep_handle *pevent,
-				 pevent_func_resolver_t *func, void *priv);
+				 tep_func_resolver_t *func, void *priv);
 void pevent_reset_function_resolver(struct tep_handle *pevent);
 int pevent_register_comm(struct tep_handle *pevent, const char *comm, int pid);
 int pevent_register_trace_clock(struct tep_handle *pevent, const char *trace_clock);
@@ -722,7 +722,7 @@ void pevent_print_field(struct trace_seq *s, void *data,
 			struct format_field *field);
 void pevent_print_fields(struct trace_seq *s, void *data,
 			 int size __maybe_unused, struct event_format *event);
-void pevent_event_info(struct trace_seq *s, struct event_format *event,
+void tep_event_info(struct trace_seq *s, struct event_format *event,
 		       struct tep_record *record);
 int pevent_strerror(struct tep_handle *pevent, enum pevent_errno errnum,
 		    char *buf, size_t buflen);
@@ -791,8 +791,8 @@ static inline void pevent_set_latency_format(struct tep_handle *pevent, int lat)
 	pevent->latency_format = lat;
 }
 
-struct tep_handle *pevent_alloc(void);
-void pevent_free(struct tep_handle *pevent);
+struct tep_handle *tep_alloc(void);
+void tep_free(struct tep_handle *pevent);
 void pevent_ref(struct tep_handle *pevent);
 void pevent_unref(struct tep_handle *pevent);
 
diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
index b23e861fa6ae..73c073ade71c 100644
--- a/tools/perf/builtin-kmem.c
+++ b/tools/perf/builtin-kmem.c
@@ -747,7 +747,7 @@ static int parse_gfp_flags(struct perf_evsel *evsel, struct perf_sample *sample,
 	}
 
 	trace_seq_init(&seq);
-	pevent_event_info(&seq, evsel->tp_format, &record);
+	tep_event_info(&seq, evsel->tp_format, &record);
 
 	str = strtok_r(seq.buffer, " ", &pos);
 	while (str) {
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 2c9924ab872d..08cdaf2be1af 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -613,7 +613,7 @@ static char *get_trace_output(struct hist_entry *he)
 		pevent_print_fields(&seq, he->raw_data, he->raw_size,
 				    evsel->tp_format);
 	} else {
-		pevent_event_info(&seq, evsel->tp_format, &rec);
+		tep_event_info(&seq, evsel->tp_format, &rec);
 	}
 	/*
 	 * Trim the buffer, it starts at 4KB and we're not going to
diff --git a/tools/perf/util/trace-event-parse.c b/tools/perf/util/trace-event-parse.c
index 29af1fb0b888..630d0e81fe87 100644
--- a/tools/perf/util/trace-event-parse.c
+++ b/tools/perf/util/trace-event-parse.c
@@ -125,7 +125,7 @@ void event_format__fprintf(struct event_format *event,
 	record.data = data;
 
 	trace_seq_init(&s);
-	pevent_event_info(&s, event, &record);
+	tep_event_info(&s, event, &record);
 	trace_seq_do_fprintf(&s, fp);
 	trace_seq_destroy(&s);
 }
diff --git a/tools/perf/util/trace-event.c b/tools/perf/util/trace-event.c
index 7c0cd9a0f575..11066ed43ca4 100644
--- a/tools/perf/util/trace-event.c
+++ b/tools/perf/util/trace-event.c
@@ -28,7 +28,7 @@ static bool tevent_initialized;
 
 int trace_event__init(struct trace_event *t)
 {
-	struct tep_handle *pevent = pevent_alloc();
+	struct tep_handle *pevent = tep_alloc();
 
 	if (pevent) {
 		t->plugin_list = traceevent_load_plugins(pevent);
@@ -55,7 +55,7 @@ static int trace_event__init2(void)
 }
 
 int trace_event__register_resolver(struct machine *machine,
-				   pevent_func_resolver_t *func)
+				   tep_func_resolver_t *func)
 {
 	if (!tevent_initialized && trace_event__init2())
 		return -1;
@@ -66,7 +66,7 @@ int trace_event__register_resolver(struct machine *machine,
 void trace_event__cleanup(struct trace_event *t)
 {
 	traceevent_unload_plugins(t->plugin_list, t->pevent);
-	pevent_free(t->pevent);
+	tep_free(t->pevent);
 }
 
 /*
diff --git a/tools/perf/util/trace-event.h b/tools/perf/util/trace-event.h
index b8f2516e9a65..40204ec3a7a2 100644
--- a/tools/perf/util/trace-event.h
+++ b/tools/perf/util/trace-event.h
@@ -20,7 +20,7 @@ struct trace_event {
 int trace_event__init(struct trace_event *t);
 void trace_event__cleanup(struct trace_event *t);
 int trace_event__register_resolver(struct machine *machine,
-				   pevent_func_resolver_t *func);
+				   tep_func_resolver_t *func);
 struct event_format*
 trace_event__tp_format(const char *sys, const char *name);
 
-- 
2.14.4

