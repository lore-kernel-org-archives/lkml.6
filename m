Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C63EC4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B65F218A8
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:50:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B65F218A8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbeHRO6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 10:58:00 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38363 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbeHRO6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 10:58:00 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w7IBoBiu1290479
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 18 Aug 2018 04:50:11 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w7IBoBJP1290476;
        Sat, 18 Aug 2018 04:50:11 -0700
Date:   Sat, 18 Aug 2018 04:50:11 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Tzvetomir Stoyanov (VMware)" <tipbot@zytor.com>
Message-ID: <tip-3cf477836e24187f2f3acbbf48c80a478d979093@git.kernel.org>
Cc:     y.karadz@gmail.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, tz.stoyanov@gmail.com, tglx@linutronix.de,
        acme@redhat.com, hpa@zytor.com, rostedt@goodmis.org,
        akpm@linux-foundation.org
Reply-To: linux-kernel@vger.kernel.org, mingo@kernel.org,
          y.karadz@gmail.com, tglx@linutronix.de, peterz@infradead.org,
          tz.stoyanov@gmail.com, hpa@zytor.com, rostedt@goodmis.org,
          acme@redhat.com, akpm@linux-foundation.org
In-Reply-To: <20180808180701.935881193@goodmis.org>
References: <20180808180701.935881193@goodmis.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] tools lib traceevent: Rename pevent_function*
 APIs
Git-Commit-ID: 3cf477836e24187f2f3acbbf48c80a478d979093
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

Commit-ID:  3cf477836e24187f2f3acbbf48c80a478d979093
Gitweb:     https://git.kernel.org/tip/3cf477836e24187f2f3acbbf48c80a478d979093
Author:     Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
AuthorDate: Wed, 8 Aug 2018 14:02:59 -0400
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 13 Aug 2018 15:24:26 -0300

tools lib traceevent: Rename pevent_function* APIs

In order to make libtraceevent into a proper library, variables, data
structures and functions require a unique prefix to prevent name space
conflicts. That prefix will be "tep_" and not "pevent_". This changes
APIs: pevent_function_handler, pevent_func_handler,
pevent_func_arg_type, PEVENT_FUNC_ARG_VOID, PEVENT_FUNC_ARG_INT,
PEVENT_FUNC_ARG_LONG, PEVENT_FUNC_ARG_STRING, PEVENT_FUNC_ARG_PTRS,
PEVENT_FUNC_ARG_MAX_TYPES

Signed-off-by: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Yordan Karadzhov (VMware) <y.karadz@gmail.com>
Cc: linux-trace-devel@vger.kernel.org
Link: http://lkml.kernel.org/r/20180808180701.935881193@goodmis.org
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/event-parse.c     | 62 +++++++++++++++++-----------------
 tools/lib/traceevent/event-parse.h     | 30 ++++++++--------
 tools/lib/traceevent/plugin_cfg80211.c |  6 ++--
 tools/lib/traceevent/plugin_jbd2.c     | 12 +++----
 tools/lib/traceevent/plugin_kvm.c      |  6 ++--
 tools/lib/traceevent/plugin_scsi.c     | 10 +++---
 tools/lib/traceevent/plugin_xen.c      |  6 ++--
 7 files changed, 66 insertions(+), 66 deletions(-)

diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
index 01b5dbf2abdf..8d0ce0ea52dc 100644
--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -94,14 +94,14 @@ struct event_handler {
 
 struct pevent_func_params {
 	struct pevent_func_params	*next;
-	enum pevent_func_arg_type	type;
+	enum tep_func_arg_type		type;
 };
 
-struct pevent_function_handler {
-	struct pevent_function_handler	*next;
-	enum pevent_func_arg_type	ret_type;
+struct tep_function_handler {
+	struct tep_function_handler	*next;
+	enum tep_func_arg_type		ret_type;
 	char				*name;
-	pevent_func_handler		func;
+	tep_func_handler		func;
 	struct pevent_func_params	*params;
 	int				nr_args;
 };
@@ -110,7 +110,7 @@ static unsigned long long
 process_defined_func(struct trace_seq *s, void *data, int size,
 		     struct event_format *event, struct print_arg *arg);
 
-static void free_func_handle(struct pevent_function_handler *func);
+static void free_func_handle(struct tep_function_handler *func);
 
 /**
  * pevent_buffer_init - init buffer for parsing
@@ -2914,10 +2914,10 @@ process_bitmask(struct event_format *event __maybe_unused, struct print_arg *arg
 	return EVENT_ERROR;
 }
 
-static struct pevent_function_handler *
+static struct tep_function_handler *
 find_func_handler(struct tep_handle *pevent, char *func_name)
 {
-	struct pevent_function_handler *func;
+	struct tep_function_handler *func;
 
 	if (!pevent)
 		return NULL;
@@ -2932,8 +2932,8 @@ find_func_handler(struct tep_handle *pevent, char *func_name)
 
 static void remove_func_handler(struct tep_handle *pevent, char *func_name)
 {
-	struct pevent_function_handler *func;
-	struct pevent_function_handler **next;
+	struct tep_function_handler *func;
+	struct tep_function_handler **next;
 
 	next = &pevent->func_handlers;
 	while ((func = *next)) {
@@ -2947,7 +2947,7 @@ static void remove_func_handler(struct tep_handle *pevent, char *func_name)
 }
 
 static enum event_type
-process_func_handler(struct event_format *event, struct pevent_function_handler *func,
+process_func_handler(struct event_format *event, struct tep_function_handler *func,
 		     struct print_arg *arg, char **tok)
 {
 	struct print_arg **next_arg;
@@ -3008,7 +3008,7 @@ static enum event_type
 process_function(struct event_format *event, struct print_arg *arg,
 		 char *token, char **tok)
 {
-	struct pevent_function_handler *func;
+	struct tep_function_handler *func;
 
 	if (strcmp(token, "__print_flags") == 0) {
 		free_token(token);
@@ -4132,7 +4132,7 @@ static unsigned long long
 process_defined_func(struct trace_seq *s, void *data, int size,
 		     struct event_format *event, struct print_arg *arg)
 {
-	struct pevent_function_handler *func_handle = arg->func.func;
+	struct tep_function_handler *func_handle = arg->func.func;
 	struct pevent_func_params *param;
 	unsigned long long *args;
 	unsigned long long ret;
@@ -4159,12 +4159,12 @@ process_defined_func(struct trace_seq *s, void *data, int size,
 
 	for (i = 0; i < func_handle->nr_args; i++) {
 		switch (param->type) {
-		case PEVENT_FUNC_ARG_INT:
-		case PEVENT_FUNC_ARG_LONG:
-		case PEVENT_FUNC_ARG_PTR:
+		case TEP_FUNC_ARG_INT:
+		case TEP_FUNC_ARG_LONG:
+		case TEP_FUNC_ARG_PTR:
 			args[i] = eval_num_arg(data, size, event, farg);
 			break;
-		case PEVENT_FUNC_ARG_STRING:
+		case TEP_FUNC_ARG_STRING:
 			trace_seq_init(&str);
 			print_str_arg(&str, data, size, event, "%s", -1, farg);
 			trace_seq_terminate(&str);
@@ -6461,7 +6461,7 @@ int tep_print_func_field(struct trace_seq *s, const char *fmt,
 	return -1;
 }
 
-static void free_func_handle(struct pevent_function_handler *func)
+static void free_func_handle(struct tep_function_handler *func)
 {
 	struct pevent_func_params *params;
 
@@ -6482,24 +6482,24 @@ static void free_func_handle(struct pevent_function_handler *func)
  * @func: the function to process the helper function
  * @ret_type: the return type of the helper function
  * @name: the name of the helper function
- * @parameters: A list of enum pevent_func_arg_type
+ * @parameters: A list of enum tep_func_arg_type
  *
  * Some events may have helper functions in the print format arguments.
  * This allows a plugin to dynamically create a way to process one
  * of these functions.
  *
- * The @parameters is a variable list of pevent_func_arg_type enums that
- * must end with PEVENT_FUNC_ARG_VOID.
+ * The @parameters is a variable list of tep_func_arg_type enums that
+ * must end with TEP_FUNC_ARG_VOID.
  */
 int pevent_register_print_function(struct tep_handle *pevent,
-				   pevent_func_handler func,
-				   enum pevent_func_arg_type ret_type,
+				   tep_func_handler func,
+				   enum tep_func_arg_type ret_type,
 				   char *name, ...)
 {
-	struct pevent_function_handler *func_handle;
+	struct tep_function_handler *func_handle;
 	struct pevent_func_params **next_param;
 	struct pevent_func_params *param;
-	enum pevent_func_arg_type type;
+	enum tep_func_arg_type type;
 	va_list ap;
 	int ret;
 
@@ -6532,11 +6532,11 @@ int pevent_register_print_function(struct tep_handle *pevent,
 	next_param = &(func_handle->params);
 	va_start(ap, name);
 	for (;;) {
-		type = va_arg(ap, enum pevent_func_arg_type);
-		if (type == PEVENT_FUNC_ARG_VOID)
+		type = va_arg(ap, enum tep_func_arg_type);
+		if (type == TEP_FUNC_ARG_VOID)
 			break;
 
-		if (type >= PEVENT_FUNC_ARG_MAX_TYPES) {
+		if (type >= TEP_FUNC_ARG_MAX_TYPES) {
 			do_warning("Invalid argument type %d", type);
 			ret = TEP_ERRNO__INVALID_ARG_TYPE;
 			goto out_free;
@@ -6579,9 +6579,9 @@ int pevent_register_print_function(struct tep_handle *pevent,
  * Returns 0 if the handler was removed successully, -1 otherwise.
  */
 int pevent_unregister_print_function(struct tep_handle *pevent,
-				     pevent_func_handler func, char *name)
+				     tep_func_handler func, char *name)
 {
-	struct pevent_function_handler *func_handle;
+	struct tep_function_handler *func_handle;
 
 	func_handle = find_func_handler(pevent, name);
 	if (func_handle && func_handle->func == func) {
@@ -6819,7 +6819,7 @@ void tep_free(struct tep_handle *pevent)
 	struct cmdline_list *cmdlist, *cmdnext;
 	struct func_list *funclist, *funcnext;
 	struct printk_list *printklist, *printknext;
-	struct pevent_function_handler *func_handler;
+	struct tep_function_handler *func_handler;
 	struct event_handler *handle;
 	int i;
 
diff --git a/tools/lib/traceevent/event-parse.h b/tools/lib/traceevent/event-parse.h
index 3067f524fef8..81f34132fc47 100644
--- a/tools/lib/traceevent/event-parse.h
+++ b/tools/lib/traceevent/event-parse.h
@@ -269,10 +269,10 @@ struct print_arg_op {
 	struct print_arg	*right;
 };
 
-struct pevent_function_handler;
+struct tep_function_handler;
 
 struct print_arg_func {
-	struct pevent_function_handler	*func;
+	struct tep_function_handler	*func;
 	struct print_arg		*args;
 };
 
@@ -361,16 +361,16 @@ enum event_type {
 	EVENT_SQUOTE,
 };
 
-typedef unsigned long long (*pevent_func_handler)(struct trace_seq *s,
-					     unsigned long long *args);
+typedef unsigned long long (*tep_func_handler)(struct trace_seq *s,
+					       unsigned long long *args);
 
-enum pevent_func_arg_type {
-	PEVENT_FUNC_ARG_VOID,
-	PEVENT_FUNC_ARG_INT,
-	PEVENT_FUNC_ARG_LONG,
-	PEVENT_FUNC_ARG_STRING,
-	PEVENT_FUNC_ARG_PTR,
-	PEVENT_FUNC_ARG_MAX_TYPES
+enum tep_func_arg_type {
+	TEP_FUNC_ARG_VOID,
+	TEP_FUNC_ARG_INT,
+	TEP_FUNC_ARG_LONG,
+	TEP_FUNC_ARG_STRING,
+	TEP_FUNC_ARG_PTR,
+	TEP_FUNC_ARG_MAX_TYPES
 };
 
 enum tep_flag {
@@ -524,7 +524,7 @@ struct tep_handle {
 	struct format_field *bprint_buf_field;
 
 	struct event_handler *handlers;
-	struct pevent_function_handler *func_handlers;
+	struct tep_function_handler *func_handlers;
 
 	/* cache */
 	struct event_format *last_event;
@@ -680,11 +680,11 @@ int pevent_unregister_event_handler(struct tep_handle *pevent, int id,
 				    const char *sys_name, const char *event_name,
 				    tep_event_handler_func func, void *context);
 int pevent_register_print_function(struct tep_handle *pevent,
-				   pevent_func_handler func,
-				   enum pevent_func_arg_type ret_type,
+				   tep_func_handler func,
+				   enum tep_func_arg_type ret_type,
 				   char *name, ...);
 int pevent_unregister_print_function(struct tep_handle *pevent,
-				     pevent_func_handler func, char *name);
+				     tep_func_handler func, char *name);
 
 struct format_field *tep_find_common_field(struct event_format *event, const char *name);
 struct format_field *tep_find_field(struct event_format *event, const char *name);
diff --git a/tools/lib/traceevent/plugin_cfg80211.c b/tools/lib/traceevent/plugin_cfg80211.c
index c189bbc9fa18..e0421e31509f 100644
--- a/tools/lib/traceevent/plugin_cfg80211.c
+++ b/tools/lib/traceevent/plugin_cfg80211.c
@@ -29,10 +29,10 @@ int TEP_PLUGIN_LOADER(struct tep_handle *pevent)
 {
 	pevent_register_print_function(pevent,
 				       process___le16_to_cpup,
-				       PEVENT_FUNC_ARG_INT,
+				       TEP_FUNC_ARG_INT,
 				       "__le16_to_cpup",
-				       PEVENT_FUNC_ARG_PTR,
-				       PEVENT_FUNC_ARG_VOID);
+				       TEP_FUNC_ARG_PTR,
+				       TEP_FUNC_ARG_VOID);
 	return 0;
 }
 
diff --git a/tools/lib/traceevent/plugin_jbd2.c b/tools/lib/traceevent/plugin_jbd2.c
index 9b88aebb48a9..6da955ff037e 100644
--- a/tools/lib/traceevent/plugin_jbd2.c
+++ b/tools/lib/traceevent/plugin_jbd2.c
@@ -51,17 +51,17 @@ int TEP_PLUGIN_LOADER(struct tep_handle *pevent)
 {
 	pevent_register_print_function(pevent,
 				       process_jbd2_dev_to_name,
-				       PEVENT_FUNC_ARG_STRING,
+				       TEP_FUNC_ARG_STRING,
 				       "jbd2_dev_to_name",
-				       PEVENT_FUNC_ARG_INT,
-				       PEVENT_FUNC_ARG_VOID);
+				       TEP_FUNC_ARG_INT,
+				       TEP_FUNC_ARG_VOID);
 
 	pevent_register_print_function(pevent,
 				       process_jiffies_to_msecs,
-				       PEVENT_FUNC_ARG_LONG,
+				       TEP_FUNC_ARG_LONG,
 				       "jiffies_to_msecs",
-				       PEVENT_FUNC_ARG_LONG,
-				       PEVENT_FUNC_ARG_VOID);
+				       TEP_FUNC_ARG_LONG,
+				       TEP_FUNC_ARG_VOID);
 	return 0;
 }
 
diff --git a/tools/lib/traceevent/plugin_kvm.c b/tools/lib/traceevent/plugin_kvm.c
index d71bc3fde75b..c20f743edf1f 100644
--- a/tools/lib/traceevent/plugin_kvm.c
+++ b/tools/lib/traceevent/plugin_kvm.c
@@ -479,10 +479,10 @@ int TEP_PLUGIN_LOADER(struct tep_handle *pevent)
 
 	pevent_register_print_function(pevent,
 				       process_is_writable_pte,
-				       PEVENT_FUNC_ARG_INT,
+				       TEP_FUNC_ARG_INT,
 				       "is_writable_pte",
-				       PEVENT_FUNC_ARG_LONG,
-				       PEVENT_FUNC_ARG_VOID);
+				       TEP_FUNC_ARG_LONG,
+				       TEP_FUNC_ARG_VOID);
 	return 0;
 }
 
diff --git a/tools/lib/traceevent/plugin_scsi.c b/tools/lib/traceevent/plugin_scsi.c
index bb9aea6fb000..ce38df7ed4d8 100644
--- a/tools/lib/traceevent/plugin_scsi.c
+++ b/tools/lib/traceevent/plugin_scsi.c
@@ -417,12 +417,12 @@ int TEP_PLUGIN_LOADER(struct tep_handle *pevent)
 {
 	pevent_register_print_function(pevent,
 				       process_scsi_trace_parse_cdb,
-				       PEVENT_FUNC_ARG_STRING,
+				       TEP_FUNC_ARG_STRING,
 				       "scsi_trace_parse_cdb",
-				       PEVENT_FUNC_ARG_PTR,
-				       PEVENT_FUNC_ARG_PTR,
-				       PEVENT_FUNC_ARG_INT,
-				       PEVENT_FUNC_ARG_VOID);
+				       TEP_FUNC_ARG_PTR,
+				       TEP_FUNC_ARG_PTR,
+				       TEP_FUNC_ARG_INT,
+				       TEP_FUNC_ARG_VOID);
 	return 0;
 }
 
diff --git a/tools/lib/traceevent/plugin_xen.c b/tools/lib/traceevent/plugin_xen.c
index 1973dd8abbfd..2ffbd91d5bb7 100644
--- a/tools/lib/traceevent/plugin_xen.c
+++ b/tools/lib/traceevent/plugin_xen.c
@@ -123,10 +123,10 @@ int TEP_PLUGIN_LOADER(struct tep_handle *pevent)
 {
 	pevent_register_print_function(pevent,
 				       process_xen_hypercall_name,
-				       PEVENT_FUNC_ARG_STRING,
+				       TEP_FUNC_ARG_STRING,
 				       "xen_hypercall_name",
-				       PEVENT_FUNC_ARG_INT,
-				       PEVENT_FUNC_ARG_VOID);
+				       TEP_FUNC_ARG_INT,
+				       TEP_FUNC_ARG_VOID);
 	return 0;
 }
 
