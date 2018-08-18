Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B97C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A7B1218A8
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:55:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A7B1218A8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbeHRPDF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 11:03:05 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51197 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbeHRPDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 11:03:05 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w7IBtGP01291238
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 18 Aug 2018 04:55:16 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w7IBtGeA1291235;
        Sat, 18 Aug 2018 04:55:16 -0700
Date:   Sat, 18 Aug 2018 04:55:16 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Tzvetomir Stoyanov (VMware)" <tipbot@zytor.com>
Message-ID: <tip-0ae98637b611c51737eadd9cc6e041746dbb11ef@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        y.karadz@gmail.com, rostedt@goodmis.org, tz.stoyanov@gmail.com,
        tglx@linutronix.de, acme@redhat.com, mingo@kernel.org,
        hpa@zytor.com, peterz@infradead.org
Reply-To: tglx@linutronix.de, tz.stoyanov@gmail.com,
          linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
          rostedt@goodmis.org, y.karadz@gmail.com, mingo@kernel.org,
          peterz@infradead.org, hpa@zytor.com, acme@redhat.com
In-Reply-To: <20180808180703.575392642@goodmis.org>
References: <20180808180703.575392642@goodmis.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] tools lib traceevent: Rename static variables and
 functions in event-parse.c
Git-Commit-ID: 0ae98637b611c51737eadd9cc6e041746dbb11ef
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

Commit-ID:  0ae98637b611c51737eadd9cc6e041746dbb11ef
Gitweb:     https://git.kernel.org/tip/0ae98637b611c51737eadd9cc6e041746dbb11ef
Author:     Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
AuthorDate: Wed, 8 Aug 2018 14:03:09 -0400
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 13 Aug 2018 15:37:26 -0300

tools lib traceevent: Rename static variables and functions in event-parse.c

In order to make libtraceevent into a proper library, variables, data
structures and functions require a unique prefix to prevent name space
conflicts. That prefix will be "tep_" and not "pevent_". This changes
static variables and functions in event-parse.c: pevent_func_params,
__pevent_parse_format, __pevent_parse_event, pevent_error_str, pevent_search_event

Signed-off-by: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Yordan Karadzhov (VMware) <y.karadz@gmail.com>
Cc: linux-trace-devel@vger.kernel.org
Link: http://lkml.kernel.org/r/20180808180703.575392642@goodmis.org
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/event-parse.c | 54 +++++++++++++++++++-------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
index f723c088acca..6313e32680ff 100644
--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -92,9 +92,9 @@ struct event_handler {
 	void				*context;
 };
 
-struct pevent_func_params {
-	struct pevent_func_params	*next;
-	enum tep_func_arg_type		type;
+struct func_params {
+	struct func_params	*next;
+	enum tep_func_arg_type	type;
 };
 
 struct tep_function_handler {
@@ -102,7 +102,7 @@ struct tep_function_handler {
 	enum tep_func_arg_type		ret_type;
 	char				*name;
 	tep_func_handler		func;
-	struct pevent_func_params	*params;
+	struct func_params		*params;
 	int				nr_args;
 };
 
@@ -1161,7 +1161,7 @@ static enum event_type read_token(char **tok)
  * @tok: The token to return
  *
  * This will parse tokens from the string given by
- * pevent_init_data().
+ * tep_init_data().
  *
  * Returns the token type.
  */
@@ -4133,7 +4133,7 @@ process_defined_func(struct trace_seq *s, void *data, int size,
 		     struct event_format *event, struct print_arg *arg)
 {
 	struct tep_function_handler *func_handle = arg->func.func;
-	struct pevent_func_params *param;
+	struct func_params *param;
 	unsigned long long *args;
 	unsigned long long ret;
 	struct print_arg *farg;
@@ -6023,7 +6023,7 @@ static int find_event_handle(struct tep_handle *pevent, struct event_format *eve
 }
 
 /**
- * __pevent_parse_format - parse the event format
+ * __tep_parse_format - parse the event format
  * @buf: the buffer storing the event format string
  * @size: the size of @buf
  * @sys: the system the event belongs to
@@ -6035,9 +6035,9 @@ static int find_event_handle(struct tep_handle *pevent, struct event_format *eve
  *
  * /sys/kernel/debug/tracing/events/.../.../format
  */
-enum tep_errno __pevent_parse_format(struct event_format **eventp,
-				     struct tep_handle *pevent, const char *buf,
-				     unsigned long size, const char *sys)
+enum tep_errno __tep_parse_format(struct event_format **eventp,
+				  struct tep_handle *pevent, const char *buf,
+				  unsigned long size, const char *sys)
 {
 	struct event_format *event;
 	int ret;
@@ -6143,12 +6143,12 @@ enum tep_errno __pevent_parse_format(struct event_format **eventp,
 }
 
 static enum tep_errno
-__pevent_parse_event(struct tep_handle *pevent,
-		     struct event_format **eventp,
-		     const char *buf, unsigned long size,
-		     const char *sys)
+__parse_event(struct tep_handle *pevent,
+	      struct event_format **eventp,
+	      const char *buf, unsigned long size,
+	      const char *sys)
 {
-	int ret = __pevent_parse_format(eventp, pevent, buf, size, sys);
+	int ret = __tep_parse_format(eventp, pevent, buf, size, sys);
 	struct event_format *event = *eventp;
 
 	if (event == NULL)
@@ -6190,7 +6190,7 @@ enum tep_errno tep_parse_format(struct tep_handle *pevent,
 				const char *buf,
 				unsigned long size, const char *sys)
 {
-	return __pevent_parse_event(pevent, eventp, buf, size, sys);
+	return __parse_event(pevent, eventp, buf, size, sys);
 }
 
 /**
@@ -6211,12 +6211,12 @@ enum tep_errno tep_parse_event(struct tep_handle *pevent, const char *buf,
 			       unsigned long size, const char *sys)
 {
 	struct event_format *event = NULL;
-	return __pevent_parse_event(pevent, &event, buf, size, sys);
+	return __parse_event(pevent, &event, buf, size, sys);
 }
 
 #undef _PE
 #define _PE(code, str) str
-static const char * const pevent_error_str[] = {
+static const char * const tep_error_str[] = {
 	TEP_ERRORS
 };
 #undef _PE
@@ -6237,7 +6237,7 @@ int tep_strerror(struct tep_handle *pevent __maybe_unused,
 		return -1;
 
 	idx = errnum - __TEP_ERRNO__START - 1;
-	msg = pevent_error_str[idx];
+	msg = tep_error_str[idx];
 	snprintf(buf, buflen, "%s", msg);
 
 	return 0;
@@ -6463,7 +6463,7 @@ int tep_print_func_field(struct trace_seq *s, const char *fmt,
 
 static void free_func_handle(struct tep_function_handler *func)
 {
-	struct pevent_func_params *params;
+	struct func_params *params;
 
 	free(func->name);
 
@@ -6497,8 +6497,8 @@ int tep_register_print_function(struct tep_handle *pevent,
 				char *name, ...)
 {
 	struct tep_function_handler *func_handle;
-	struct pevent_func_params **next_param;
-	struct pevent_func_params *param;
+	struct func_params **next_param;
+	struct func_params *param;
 	enum tep_func_arg_type type;
 	va_list ap;
 	int ret;
@@ -6591,9 +6591,9 @@ int tep_unregister_print_function(struct tep_handle *pevent,
 	return -1;
 }
 
-static struct event_format *pevent_search_event(struct tep_handle *pevent, int id,
-						const char *sys_name,
-						const char *event_name)
+static struct event_format *search_event(struct tep_handle *pevent, int id,
+					 const char *sys_name,
+					 const char *event_name)
 {
 	struct event_format *event;
 
@@ -6638,7 +6638,7 @@ int tep_register_event_handler(struct tep_handle *pevent, int id,
 	struct event_format *event;
 	struct event_handler *handle;
 
-	event = pevent_search_event(pevent, id, sys_name, event_name);
+	event = search_event(pevent, id, sys_name, event_name);
 	if (event == NULL)
 		goto not_found;
 
@@ -6723,7 +6723,7 @@ int tep_unregister_event_handler(struct tep_handle *pevent, int id,
 	struct event_handler *handle;
 	struct event_handler **next;
 
-	event = pevent_search_event(pevent, id, sys_name, event_name);
+	event = search_event(pevent, id, sys_name, event_name);
 	if (event == NULL)
 		goto not_found;
 
