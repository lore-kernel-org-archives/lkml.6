Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B2CC4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 688C6218A8
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:53:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 688C6218A8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbeHRPBE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 11:01:04 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55293 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbeHRPBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 11:01:03 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w7IBrEDh1290894
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 18 Aug 2018 04:53:14 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w7IBrE2G1290891;
        Sat, 18 Aug 2018 04:53:14 -0700
Date:   Sat, 18 Aug 2018 04:53:14 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Tzvetomir Stoyanov (VMware)" <tipbot@zytor.com>
Message-ID: <tip-610e1e4ff0431b3a86a0ebfcdb47828b8e082329@git.kernel.org>
Cc:     rostedt@goodmis.org, tz.stoyanov@gmail.com, acme@redhat.com,
        hpa@zytor.com, akpm@linux-foundation.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, mingo@kernel.org, y.karadz@gmail.com,
        peterz@infradead.org
Reply-To: rostedt@goodmis.org, tz.stoyanov@gmail.com, acme@redhat.com,
          hpa@zytor.com, tglx@linutronix.de, akpm@linux-foundation.org,
          linux-kernel@vger.kernel.org, mingo@kernel.org,
          y.karadz@gmail.com, peterz@infradead.org
In-Reply-To: <20180808180702.966965051@goodmis.org>
References: <20180808180702.966965051@goodmis.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] tools lib traceevent: Rename pevent_find_* APIs
Git-Commit-ID: 610e1e4ff0431b3a86a0ebfcdb47828b8e082329
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

Commit-ID:  610e1e4ff0431b3a86a0ebfcdb47828b8e082329
Gitweb:     https://git.kernel.org/tip/610e1e4ff0431b3a86a0ebfcdb47828b8e082329
Author:     Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
AuthorDate: Wed, 8 Aug 2018 14:03:05 -0400
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 13 Aug 2018 15:31:28 -0300

tools lib traceevent: Rename pevent_find_* APIs

In order to make libtraceevent into a proper library, variables, data
structures and functions require a unique prefix to prevent name space
conflicts. That prefix will be "tep_" and not "pevent_". This changes
APIs: pevent_find_function, pevent_find_function_address,
pevent_find_event_by_name, pevent_find_event_by_record

Signed-off-by: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Yordan Karadzhov (VMware) <y.karadz@gmail.com>
Cc: linux-trace-devel@vger.kernel.org
Link: http://lkml.kernel.org/r/20180808180702.966965051@goodmis.org
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/event-parse.c     | 24 ++++++++++++------------
 tools/lib/traceevent/event-parse.h     |  8 ++++----
 tools/lib/traceevent/parse-filter.c    | 10 +++++-----
 tools/lib/traceevent/plugin_function.c |  4 ++--
 tools/lib/traceevent/plugin_kmem.c     |  4 ++--
 5 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
index 652b8ef6f4c7..53d866434478 100644
--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -503,7 +503,7 @@ find_func(struct tep_handle *pevent, unsigned long long addr)
 }
 
 /**
- * pevent_find_function - find a function by a given address
+ * tep_find_function - find a function by a given address
  * @pevent: handle for the pevent
  * @addr: the address to find the function with
  *
@@ -511,7 +511,7 @@ find_func(struct tep_handle *pevent, unsigned long long addr)
  * address. Note, the address does not have to be exact, it
  * will select the function that would contain the address.
  */
-const char *pevent_find_function(struct tep_handle *pevent, unsigned long long addr)
+const char *tep_find_function(struct tep_handle *pevent, unsigned long long addr)
 {
 	struct func_map *map;
 
@@ -523,16 +523,16 @@ const char *pevent_find_function(struct tep_handle *pevent, unsigned long long a
 }
 
 /**
- * pevent_find_function_address - find a function address by a given address
+ * tep_find_function_address - find a function address by a given address
  * @pevent: handle for the pevent
  * @addr: the address to find the function with
  *
  * Returns the address the function starts at. This can be used in
- * conjunction with pevent_find_function to print both the function
+ * conjunction with tep_find_function to print both the function
  * name and the function offset.
  */
 unsigned long long
-pevent_find_function_address(struct tep_handle *pevent, unsigned long long addr)
+tep_find_function_address(struct tep_handle *pevent, unsigned long long addr)
 {
 	struct func_map *map;
 
@@ -3498,7 +3498,7 @@ struct event_format *tep_find_event(struct tep_handle *pevent, int id)
 }
 
 /**
- * pevent_find_event_by_name - find an event by given name
+ * tep_find_event_by_name - find an event by given name
  * @pevent: a handle to the pevent
  * @sys: the system name to search for
  * @name: the name of the event to search for
@@ -3507,8 +3507,8 @@ struct event_format *tep_find_event(struct tep_handle *pevent, int id)
  * @sys. If @sys is NULL the first event with @name is returned.
  */
 struct event_format *
-pevent_find_event_by_name(struct tep_handle *pevent,
-			  const char *sys, const char *name)
+tep_find_event_by_name(struct tep_handle *pevent,
+		       const char *sys, const char *name)
 {
 	struct event_format *event;
 	int i;
@@ -5433,7 +5433,7 @@ static bool is_timestamp_in_us(char *trace_clock, bool use_trace_clock)
 }
 
 /**
- * pevent_find_event_by_record - return the event from a given record
+ * tep_find_event_by_record - return the event from a given record
  * @pevent: a handle to the pevent
  * @record: The record to get the event from
  *
@@ -5441,7 +5441,7 @@ static bool is_timestamp_in_us(char *trace_clock, bool use_trace_clock)
  * is found.
  */
 struct event_format *
-pevent_find_event_by_record(struct tep_handle *pevent, struct tep_record *record)
+tep_find_event_by_record(struct tep_handle *pevent, struct tep_record *record)
 {
 	int type;
 
@@ -5564,7 +5564,7 @@ void tep_print_event(struct tep_handle *pevent, struct trace_seq *s,
 {
 	struct event_format *event;
 
-	event = pevent_find_event_by_record(pevent, record);
+	event = tep_find_event_by_record(pevent, record);
 	if (!event) {
 		int i;
 		int type = trace_parse_common_type(pevent, record->data);
@@ -6607,7 +6607,7 @@ static struct event_format *pevent_search_event(struct tep_handle *pevent, int i
 		if (sys_name && (strcmp(sys_name, event->system) != 0))
 			return NULL;
 	} else {
-		event = pevent_find_event_by_name(pevent, sys_name, event_name);
+		event = tep_find_event_by_name(pevent, sys_name, event_name);
 		if (!event)
 			return NULL;
 	}
diff --git a/tools/lib/traceevent/event-parse.h b/tools/lib/traceevent/event-parse.h
index 04ffc6e508cf..63ec6d419219 100644
--- a/tools/lib/traceevent/event-parse.h
+++ b/tools/lib/traceevent/event-parse.h
@@ -690,9 +690,9 @@ struct format_field *tep_find_common_field(struct event_format *event, const cha
 struct format_field *tep_find_field(struct event_format *event, const char *name);
 struct format_field *tep_find_any_field(struct event_format *event, const char *name);
 
-const char *pevent_find_function(struct tep_handle *pevent, unsigned long long addr);
+const char *tep_find_function(struct tep_handle *pevent, unsigned long long addr);
 unsigned long long
-pevent_find_function_address(struct tep_handle *pevent, unsigned long long addr);
+tep_find_function_address(struct tep_handle *pevent, unsigned long long addr);
 unsigned long long tep_read_number(struct tep_handle *pevent, const void *ptr, int size);
 int tep_read_number_field(struct format_field *field, const void *data,
 			  unsigned long long *value);
@@ -700,10 +700,10 @@ int tep_read_number_field(struct format_field *field, const void *data,
 struct event_format *tep_find_event(struct tep_handle *pevent, int id);
 
 struct event_format *
-pevent_find_event_by_name(struct tep_handle *pevent, const char *sys, const char *name);
+tep_find_event_by_name(struct tep_handle *pevent, const char *sys, const char *name);
 
 struct event_format *
-pevent_find_event_by_record(struct tep_handle *pevent, struct tep_record *record);
+tep_find_event_by_record(struct tep_handle *pevent, struct tep_record *record);
 
 void tep_data_lat_fmt(struct tep_handle *pevent,
 		      struct trace_seq *s, struct tep_record *record);
diff --git a/tools/lib/traceevent/parse-filter.c b/tools/lib/traceevent/parse-filter.c
index 474d820e97e1..3efab9b4298f 100644
--- a/tools/lib/traceevent/parse-filter.c
+++ b/tools/lib/traceevent/parse-filter.c
@@ -1478,7 +1478,7 @@ static int copy_filter_type(struct event_filter *filter,
 	/* Can't assume that the pevent's are the same */
 	sys = filter_type->event->system;
 	name = filter_type->event->name;
-	event = pevent_find_event_by_name(filter->pevent, sys, name);
+	event = tep_find_event_by_name(filter->pevent, sys, name);
 	if (!event)
 		return -1;
 
@@ -1578,9 +1578,9 @@ int tep_update_trivial(struct event_filter *dest, struct event_filter *source,
 
 		if (src_pevent != dest_pevent) {
 			/* do a look up */
-			event = pevent_find_event_by_name(src_pevent,
-							  event->system,
-							  event->name);
+			event = tep_find_event_by_name(src_pevent,
+						       event->system,
+						       event->name);
 			if (!event)
 				return -1;
 		}
@@ -1909,7 +1909,7 @@ static const char *get_field_str(struct filter_arg *arg, struct tep_record *reco
 
 		if (arg->str.field->flags & (FIELD_IS_POINTER | FIELD_IS_LONG))
 			/* convert to a kernel symbol */
-			val = pevent_find_function(pevent, addr);
+			val = tep_find_function(pevent, addr);
 
 		if (val == NULL) {
 			/* just use the hex of the string name */
diff --git a/tools/lib/traceevent/plugin_function.c b/tools/lib/traceevent/plugin_function.c
index 0962120960eb..424747475d37 100644
--- a/tools/lib/traceevent/plugin_function.c
+++ b/tools/lib/traceevent/plugin_function.c
@@ -135,12 +135,12 @@ static int function_handler(struct trace_seq *s, struct tep_record *record,
 	if (tep_get_field_val(s, event, "ip", record, &function, 1))
 		return trace_seq_putc(s, '!');
 
-	func = pevent_find_function(pevent, function);
+	func = tep_find_function(pevent, function);
 
 	if (tep_get_field_val(s, event, "parent_ip", record, &pfunction, 1))
 		return trace_seq_putc(s, '!');
 
-	parent = pevent_find_function(pevent, pfunction);
+	parent = tep_find_function(pevent, pfunction);
 
 	if (parent && ftrace_indent->set)
 		index = add_and_get_index(parent, func, record->cpu);
diff --git a/tools/lib/traceevent/plugin_kmem.c b/tools/lib/traceevent/plugin_kmem.c
index 6d5938d82c66..73966b05abce 100644
--- a/tools/lib/traceevent/plugin_kmem.c
+++ b/tools/lib/traceevent/plugin_kmem.c
@@ -38,11 +38,11 @@ static int call_site_handler(struct trace_seq *s, struct tep_record *record,
 	if (tep_read_number_field(field, data, &val))
 		return 1;
 
-	func = pevent_find_function(event->pevent, val);
+	func = tep_find_function(event->pevent, val);
 	if (!func)
 		return 1;
 
-	addr = pevent_find_function_address(event->pevent, val);
+	addr = tep_find_function_address(event->pevent, val);
 
 	trace_seq_printf(s, "(%s+0x%x) ", func, (int)(val - addr));
 	return 1;
