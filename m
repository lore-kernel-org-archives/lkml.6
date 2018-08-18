Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4156EC4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2AB521748
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:45:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2AB521748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbeHROwx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 10:52:53 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60819 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbeHROww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 10:52:52 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w7IBj5qI1289891
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 18 Aug 2018 04:45:05 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w7IBj5Pk1289888;
        Sat, 18 Aug 2018 04:45:05 -0700
Date:   Sat, 18 Aug 2018 04:45:05 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Tzvetomir Stoyanov (VMware)" <tipbot@zytor.com>
Message-ID: <tip-4d5c58b15c4363219e19380848eb74ca60143187@git.kernel.org>
Cc:     rostedt@goodmis.org, mingo@kernel.org, y.karadz@gmail.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, akpm@linux-foundation.org,
        tz.stoyanov@gmail.com, hpa@zytor.com, acme@redhat.com
Reply-To: acme@redhat.com, tz.stoyanov@gmail.com, hpa@zytor.com,
          akpm@linux-foundation.org, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, y.karadz@gmail.com,
          peterz@infradead.org, mingo@kernel.org, rostedt@goodmis.org
In-Reply-To: <20180808180700.152609945@goodmis.org>
References: <20180808180700.152609945@goodmis.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] tools lib traceevent, perf tools: Rename pevent
 alloc / free APIs
Git-Commit-ID: 4d5c58b15c4363219e19380848eb74ca60143187
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

Commit-ID:  4d5c58b15c4363219e19380848eb74ca60143187
Gitweb:     https://git.kernel.org/tip/4d5c58b15c4363219e19380848eb74ca60143187
Author:     Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
AuthorDate: Wed, 8 Aug 2018 14:02:49 -0400
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 13 Aug 2018 15:21:43 -0300

tools lib traceevent, perf tools: Rename pevent alloc / free APIs

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
@@ -6754,9 +6754,9 @@ not_found:
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
 
