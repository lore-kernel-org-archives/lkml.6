Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D0AEC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 15:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66F2220C0E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 15:08:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iAyxbOCI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66F2220C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730568AbeHOSAy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 14:00:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:50736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730492AbeHOSAy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 14:00:54 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7388021475;
        Wed, 15 Aug 2018 15:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534345700;
        bh=q8bvvABgJx+Zo0sbL3rcPLJGSHBYFXX0bAm80V9dztw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iAyxbOCIlMtk/B4RV03IuGz1M5Uf1B/8MpyfdZk6rntf2SPqWFs8vWRBN5gWyvc/y
         WKUv2ShZfFIdJKqThdwEeQ5d9xVTM0Z+SZ+HRWBogEL5nvAMF03Pzqu4S+LA/yW4lO
         8Qu1FYZigg6o7v4we2RFgT6DbOVAn+zEL1Fo1a6A=
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
Subject: [PATCH 25/35] tools lib traceevent: Rename static variables and functions in event-parse.c
Date:   Wed, 15 Aug 2018 12:06:01 -0300
Message-Id: <20180815150611.32080-26-acme@kernel.org>
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
 
-- 
2.14.4

