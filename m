Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 177B2C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 15:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96626208E0
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 15:08:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oKv8Imth"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96626208E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730430AbeHOSAi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 14:00:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:50506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729293AbeHOSAh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 14:00:37 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F28B208B1;
        Wed, 15 Aug 2018 15:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534345684;
        bh=+ghrAb06zNzhhVmStpudQjSeNZOp9Lc7Rv5AezLpFuM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oKv8ImthhUrGRVy8vjlCsq628x9sW8DyVxPfNxPzxmURwb57S+ZintFHmTAPs6o/s
         ez2pqG4BLUtYNYHMM/aCwnI2FzlR1OBCTddqbiklFUbETJCHeZ/ZfJiTdkcAVdKamP
         k80wr6Pvjmn8/kRNgh2RZbLGV9xaNVqXKgrGRBow=
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
Subject: [PATCH 20/35] tools lib traceevent: Rename pevent field APIs
Date:   Wed, 15 Aug 2018 12:05:56 -0300
Message-Id: <20180815150611.32080-21-acme@kernel.org>
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
APIs: pevent_free_format, pevent_free_format_field, pevent_get_field_raw,
pevent_get_field_val, pevent_get_common_field_val, pevent_get_any_field_val

Signed-off-by: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Yordan Karadzhov (VMware) <y.karadz@gmail.com>
Cc: linux-trace-devel@vger.kernel.org
Link: http://lkml.kernel.org/r/20180808180702.821244942@goodmis.org
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/event-parse.c         | 42 +++++++++++++++---------------
 tools/lib/traceevent/event-parse.h         | 28 ++++++++++----------
 tools/lib/traceevent/plugin_function.c     |  4 +--
 tools/lib/traceevent/plugin_kvm.c          | 28 ++++++++++----------
 tools/lib/traceevent/plugin_sched_switch.c | 18 ++++++-------
 5 files changed, 60 insertions(+), 60 deletions(-)

diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
index 4f924bf42b92..652b8ef6f4c7 100644
--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -6166,7 +6166,7 @@ __pevent_parse_event(struct tep_handle *pevent,
 	return 0;
 
 event_add_failed:
-	pevent_free_format(event);
+	tep_free_format(event);
 	return ret;
 }
 
@@ -6263,7 +6263,7 @@ int get_field_val(struct trace_seq *s, struct format_field *field,
 }
 
 /**
- * pevent_get_field_raw - return the raw pointer into the data field
+ * tep_get_field_raw - return the raw pointer into the data field
  * @s: The seq to print to on error
  * @event: the event that the field is for
  * @name: The name of the field
@@ -6276,9 +6276,9 @@ int get_field_val(struct trace_seq *s, struct format_field *field,
  *
  * On failure, it returns NULL.
  */
-void *pevent_get_field_raw(struct trace_seq *s, struct event_format *event,
-			   const char *name, struct tep_record *record,
-			   int *len, int err)
+void *tep_get_field_raw(struct trace_seq *s, struct event_format *event,
+			const char *name, struct tep_record *record,
+			int *len, int err)
 {
 	struct format_field *field;
 	void *data = record->data;
@@ -6313,7 +6313,7 @@ void *pevent_get_field_raw(struct trace_seq *s, struct event_format *event,
 }
 
 /**
- * pevent_get_field_val - find a field and return its value
+ * tep_get_field_val - find a field and return its value
  * @s: The seq to print to on error
  * @event: the event that the field is for
  * @name: The name of the field
@@ -6323,9 +6323,9 @@ void *pevent_get_field_raw(struct trace_seq *s, struct event_format *event,
  *
  * Returns 0 on success -1 on field not found.
  */
-int pevent_get_field_val(struct trace_seq *s, struct event_format *event,
-			 const char *name, struct tep_record *record,
-			 unsigned long long *val, int err)
+int tep_get_field_val(struct trace_seq *s, struct event_format *event,
+		      const char *name, struct tep_record *record,
+		      unsigned long long *val, int err)
 {
 	struct format_field *field;
 
@@ -6338,7 +6338,7 @@ int pevent_get_field_val(struct trace_seq *s, struct event_format *event,
 }
 
 /**
- * pevent_get_common_field_val - find a common field and return its value
+ * tep_get_common_field_val - find a common field and return its value
  * @s: The seq to print to on error
  * @event: the event that the field is for
  * @name: The name of the field
@@ -6348,9 +6348,9 @@ int pevent_get_field_val(struct trace_seq *s, struct event_format *event,
  *
  * Returns 0 on success -1 on field not found.
  */
-int pevent_get_common_field_val(struct trace_seq *s, struct event_format *event,
-				const char *name, struct tep_record *record,
-				unsigned long long *val, int err)
+int tep_get_common_field_val(struct trace_seq *s, struct event_format *event,
+			     const char *name, struct tep_record *record,
+			     unsigned long long *val, int err)
 {
 	struct format_field *field;
 
@@ -6363,7 +6363,7 @@ int pevent_get_common_field_val(struct trace_seq *s, struct event_format *event,
 }
 
 /**
- * pevent_get_any_field_val - find a any field and return its value
+ * tep_get_any_field_val - find a any field and return its value
  * @s: The seq to print to on error
  * @event: the event that the field is for
  * @name: The name of the field
@@ -6373,9 +6373,9 @@ int pevent_get_common_field_val(struct trace_seq *s, struct event_format *event,
  *
  * Returns 0 on success -1 on field not found.
  */
-int pevent_get_any_field_val(struct trace_seq *s, struct event_format *event,
-			     const char *name, struct tep_record *record,
-			     unsigned long long *val, int err)
+int tep_get_any_field_val(struct trace_seq *s, struct event_format *event,
+			  const char *name, struct tep_record *record,
+			  unsigned long long *val, int err)
 {
 	struct format_field *field;
 
@@ -6771,7 +6771,7 @@ void pevent_ref(struct tep_handle *pevent)
 	pevent->ref_count++;
 }
 
-void pevent_free_format_field(struct format_field *field)
+void tep_free_format_field(struct format_field *field)
 {
 	free(field->type);
 	if (field->alias != field->name)
@@ -6786,7 +6786,7 @@ static void free_format_fields(struct format_field *field)
 
 	while (field) {
 		next = field->next;
-		pevent_free_format_field(field);
+		tep_free_format_field(field);
 		field = next;
 	}
 }
@@ -6797,7 +6797,7 @@ static void free_formats(struct format *format)
 	free_format_fields(format->fields);
 }
 
-void pevent_free_format(struct event_format *event)
+void tep_free_format(struct event_format *event)
 {
 	free(event->name);
 	free(event->system);
@@ -6883,7 +6883,7 @@ void tep_free(struct tep_handle *pevent)
 	}
 
 	for (i = 0; i < pevent->nr_events; i++)
-		pevent_free_format(pevent->events[i]);
+		tep_free_format(pevent->events[i]);
 
 	while (pevent->handlers) {
 		handle = pevent->handlers;
diff --git a/tools/lib/traceevent/event-parse.h b/tools/lib/traceevent/event-parse.h
index 2c4da2f1d4ed..04ffc6e508cf 100644
--- a/tools/lib/traceevent/event-parse.h
+++ b/tools/lib/traceevent/event-parse.h
@@ -648,22 +648,22 @@ enum tep_errno tep_parse_format(struct tep_handle *pevent,
 				struct event_format **eventp,
 				const char *buf,
 				unsigned long size, const char *sys);
-void pevent_free_format(struct event_format *event);
-void pevent_free_format_field(struct format_field *field);
-
-void *pevent_get_field_raw(struct trace_seq *s, struct event_format *event,
-			   const char *name, struct tep_record *record,
-			   int *len, int err);
-
-int pevent_get_field_val(struct trace_seq *s, struct event_format *event,
-			 const char *name, struct tep_record *record,
-			 unsigned long long *val, int err);
-int pevent_get_common_field_val(struct trace_seq *s, struct event_format *event,
-				const char *name, struct tep_record *record,
-				unsigned long long *val, int err);
-int pevent_get_any_field_val(struct trace_seq *s, struct event_format *event,
+void tep_free_format(struct event_format *event);
+void tep_free_format_field(struct format_field *field);
+
+void *tep_get_field_raw(struct trace_seq *s, struct event_format *event,
+			const char *name, struct tep_record *record,
+			int *len, int err);
+
+int tep_get_field_val(struct trace_seq *s, struct event_format *event,
+		      const char *name, struct tep_record *record,
+		      unsigned long long *val, int err);
+int tep_get_common_field_val(struct trace_seq *s, struct event_format *event,
 			     const char *name, struct tep_record *record,
 			     unsigned long long *val, int err);
+int tep_get_any_field_val(struct trace_seq *s, struct event_format *event,
+			  const char *name, struct tep_record *record,
+			  unsigned long long *val, int err);
 
 int tep_print_num_field(struct trace_seq *s, const char *fmt,
 			   struct event_format *event, const char *name,
diff --git a/tools/lib/traceevent/plugin_function.c b/tools/lib/traceevent/plugin_function.c
index 50cc356124f6..0962120960eb 100644
--- a/tools/lib/traceevent/plugin_function.c
+++ b/tools/lib/traceevent/plugin_function.c
@@ -132,12 +132,12 @@ static int function_handler(struct trace_seq *s, struct tep_record *record,
 	const char *parent;
 	int index = 0;
 
-	if (pevent_get_field_val(s, event, "ip", record, &function, 1))
+	if (tep_get_field_val(s, event, "ip", record, &function, 1))
 		return trace_seq_putc(s, '!');
 
 	func = pevent_find_function(pevent, function);
 
-	if (pevent_get_field_val(s, event, "parent_ip", record, &pfunction, 1))
+	if (tep_get_field_val(s, event, "parent_ip", record, &pfunction, 1))
 		return trace_seq_putc(s, '!');
 
 	parent = pevent_find_function(pevent, pfunction);
diff --git a/tools/lib/traceevent/plugin_kvm.c b/tools/lib/traceevent/plugin_kvm.c
index 4b3433763340..7ebe82bf19ce 100644
--- a/tools/lib/traceevent/plugin_kvm.c
+++ b/tools/lib/traceevent/plugin_kvm.c
@@ -254,10 +254,10 @@ static int print_exit_reason(struct trace_seq *s, struct tep_record *record,
 	unsigned long long val;
 	const char *reason;
 
-	if (pevent_get_field_val(s, event, field, record, &val, 1) < 0)
+	if (tep_get_field_val(s, event, field, record, &val, 1) < 0)
 		return -1;
 
-	if (pevent_get_field_val(s, event, "isa", record, &isa, 0) < 0)
+	if (tep_get_field_val(s, event, "isa", record, &isa, 0) < 0)
 		isa = 1;
 
 	reason = find_exit_reason(isa, val);
@@ -278,8 +278,8 @@ static int kvm_exit_handler(struct trace_seq *s, struct tep_record *record,
 
 	tep_print_num_field(s, " rip 0x%lx", event, "guest_rip", record, 1);
 
-	if (pevent_get_field_val(s, event, "info1", record, &info1, 0) >= 0
-	    && pevent_get_field_val(s, event, "info2", record, &info2, 0) >= 0)
+	if (tep_get_field_val(s, event, "info1", record, &info1, 0) >= 0
+	    && tep_get_field_val(s, event, "info2", record, &info2, 0) >= 0)
 		trace_seq_printf(s, " info %llx %llx", info1, info2);
 
 	return 0;
@@ -299,22 +299,22 @@ static int kvm_emulate_insn_handler(struct trace_seq *s,
 	uint8_t *insn;
 	const char *disasm;
 
-	if (pevent_get_field_val(s, event, "rip", record, &rip, 1) < 0)
+	if (tep_get_field_val(s, event, "rip", record, &rip, 1) < 0)
 		return -1;
 
-	if (pevent_get_field_val(s, event, "csbase", record, &csbase, 1) < 0)
+	if (tep_get_field_val(s, event, "csbase", record, &csbase, 1) < 0)
 		return -1;
 
-	if (pevent_get_field_val(s, event, "len", record, &len, 1) < 0)
+	if (tep_get_field_val(s, event, "len", record, &len, 1) < 0)
 		return -1;
 
-	if (pevent_get_field_val(s, event, "flags", record, &flags, 1) < 0)
+	if (tep_get_field_val(s, event, "flags", record, &flags, 1) < 0)
 		return -1;
 
-	if (pevent_get_field_val(s, event, "failed", record, &failed, 1) < 0)
+	if (tep_get_field_val(s, event, "failed", record, &failed, 1) < 0)
 		return -1;
 
-	insn = pevent_get_field_raw(s, event, "insn", record, &llen, 1);
+	insn = tep_get_field_raw(s, event, "insn", record, &llen, 1);
 	if (!insn)
 		return -1;
 
@@ -379,7 +379,7 @@ static int kvm_mmu_print_role(struct trace_seq *s, struct tep_record *record,
 	};
 	union kvm_mmu_page_role role;
 
-	if (pevent_get_field_val(s, event, "role", record, &val, 1) < 0)
+	if (tep_get_field_val(s, event, "role", record, &val, 1) < 0)
 		return -1;
 
 	role.word = (int)val;
@@ -409,7 +409,7 @@ static int kvm_mmu_print_role(struct trace_seq *s, struct tep_record *record,
 	tep_print_num_field(s, " root %u ",  event,
 			    "root_count", record, 1);
 
-	if (pevent_get_field_val(s, event, "unsync", record, &val, 1) < 0)
+	if (tep_get_field_val(s, event, "unsync", record, &val, 1) < 0)
 		return -1;
 
 	trace_seq_printf(s, "%s%c",  val ? "unsync" : "sync", 0);
@@ -422,12 +422,12 @@ static int kvm_mmu_get_page_handler(struct trace_seq *s,
 {
 	unsigned long long val;
 
-	if (pevent_get_field_val(s, event, "created", record, &val, 1) < 0)
+	if (tep_get_field_val(s, event, "created", record, &val, 1) < 0)
 		return -1;
 
 	trace_seq_printf(s, "%s ", val ? "new" : "existing");
 
-	if (pevent_get_field_val(s, event, "gfn", record, &val, 1) < 0)
+	if (tep_get_field_val(s, event, "gfn", record, &val, 1) < 0)
 		return -1;
 
 	trace_seq_printf(s, "sp gfn %llx ", val);
diff --git a/tools/lib/traceevent/plugin_sched_switch.c b/tools/lib/traceevent/plugin_sched_switch.c
index 3f3a89c3d041..eecb4bd95c11 100644
--- a/tools/lib/traceevent/plugin_sched_switch.c
+++ b/tools/lib/traceevent/plugin_sched_switch.c
@@ -71,7 +71,7 @@ static int sched_wakeup_handler(struct trace_seq *s,
 	struct format_field *field;
 	unsigned long long val;
 
-	if (pevent_get_field_val(s, event, "pid", record, &val, 1))
+	if (tep_get_field_val(s, event, "pid", record, &val, 1))
 		return trace_seq_putc(s, '!');
 
 	field = tep_find_any_field(event, "comm");
@@ -81,13 +81,13 @@ static int sched_wakeup_handler(struct trace_seq *s,
 	}
 	trace_seq_printf(s, "%lld", val);
 
-	if (pevent_get_field_val(s, event, "prio", record, &val, 0) == 0)
+	if (tep_get_field_val(s, event, "prio", record, &val, 0) == 0)
 		trace_seq_printf(s, " [%lld]", val);
 
-	if (pevent_get_field_val(s, event, "success", record, &val, 1) == 0)
+	if (tep_get_field_val(s, event, "success", record, &val, 1) == 0)
 		trace_seq_printf(s, " success=%lld", val);
 
-	if (pevent_get_field_val(s, event, "target_cpu", record, &val, 0) == 0)
+	if (tep_get_field_val(s, event, "target_cpu", record, &val, 0) == 0)
 		trace_seq_printf(s, " CPU:%03llu", val);
 
 	return 0;
@@ -100,7 +100,7 @@ static int sched_switch_handler(struct trace_seq *s,
 	struct format_field *field;
 	unsigned long long val;
 
-	if (pevent_get_field_val(s, event, "prev_pid", record, &val, 1))
+	if (tep_get_field_val(s, event, "prev_pid", record, &val, 1))
 		return trace_seq_putc(s, '!');
 
 	field = tep_find_any_field(event, "prev_comm");
@@ -110,15 +110,15 @@ static int sched_switch_handler(struct trace_seq *s,
 	}
 	trace_seq_printf(s, "%lld ", val);
 
-	if (pevent_get_field_val(s, event, "prev_prio", record, &val, 0) == 0)
+	if (tep_get_field_val(s, event, "prev_prio", record, &val, 0) == 0)
 		trace_seq_printf(s, "[%d] ", (int) val);
 
-	if (pevent_get_field_val(s,  event, "prev_state", record, &val, 0) == 0)
+	if (tep_get_field_val(s,  event, "prev_state", record, &val, 0) == 0)
 		write_state(s, val);
 
 	trace_seq_puts(s, " ==> ");
 
-	if (pevent_get_field_val(s, event, "next_pid", record, &val, 1))
+	if (tep_get_field_val(s, event, "next_pid", record, &val, 1))
 		return trace_seq_putc(s, '!');
 
 	field = tep_find_any_field(event, "next_comm");
@@ -128,7 +128,7 @@ static int sched_switch_handler(struct trace_seq *s,
 	}
 	trace_seq_printf(s, "%lld", val);
 
-	if (pevent_get_field_val(s, event, "next_prio", record, &val, 0) == 0)
+	if (tep_get_field_val(s, event, "next_prio", record, &val, 0) == 0)
 		trace_seq_printf(s, " [%d]", (int) val);
 
 	return 0;
-- 
2.14.4

