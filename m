Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B747EC4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7014520666
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:54:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7014520666
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbeHRPCF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 11:02:05 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47817 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbeHRPCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 11:02:04 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w7IBsG2A1291139
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 18 Aug 2018 04:54:16 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w7IBsGDc1291136;
        Sat, 18 Aug 2018 04:54:16 -0700
Date:   Sat, 18 Aug 2018 04:54:16 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Tzvetomir Stoyanov (VMware)" <tipbot@zytor.com>
Message-ID: <tip-1634e4604cccbe6394dd858fb973604d2313336b@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        tglx@linutronix.de, akpm@linux-foundation.org, mingo@kernel.org,
        tz.stoyanov@gmail.com, y.karadz@gmail.com, acme@redhat.com,
        hpa@zytor.com, peterz@infradead.org
Reply-To: acme@redhat.com, hpa@zytor.com, y.karadz@gmail.com,
          peterz@infradead.org, akpm@linux-foundation.org,
          tglx@linutronix.de, rostedt@goodmis.org,
          linux-kernel@vger.kernel.org, tz.stoyanov@gmail.com,
          mingo@kernel.org
In-Reply-To: <20180808180703.275281085@goodmis.org>
References: <20180808180703.275281085@goodmis.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] tools lib traceevent: Rename internal parser
 related APIs
Git-Commit-ID: 1634e4604cccbe6394dd858fb973604d2313336b
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

Commit-ID:  1634e4604cccbe6394dd858fb973604d2313336b
Gitweb:     https://git.kernel.org/tip/1634e4604cccbe6394dd858fb973604d2313336b
Author:     Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
AuthorDate: Wed, 8 Aug 2018 14:03:07 -0400
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 13 Aug 2018 15:35:58 -0300

tools lib traceevent: Rename internal parser related APIs

In order to make libtraceevent into a proper library, variables, data
structures and functions require a unique prefix to prevent name space
conflicts. That prefix will be "tep_" and not "pevent_". This changes
APIs: pevent_buffer_init, pevent_read_token, pevent_free_token,
pevent_peek_char, pevent_get_input_buf, pevent_get_input_buf_ptr

Signed-off-by: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Yordan Karadzhov (VMware) <y.karadz@gmail.com>
Cc: linux-trace-devel@vger.kernel.org
Link: http://lkml.kernel.org/r/20180808180703.275281085@goodmis.org
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/event-parse.c  | 24 ++++++++++++------------
 tools/lib/traceevent/event-parse.h  | 12 ++++++------
 tools/lib/traceevent/parse-filter.c | 16 ++++++++--------
 3 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
index d367f7f2f2fc..8215e6ff36eb 100644
--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -73,12 +73,12 @@ static void init_input_buf(const char *buf, unsigned long long size)
 	input_buf_ptr = 0;
 }
 
-const char *pevent_get_input_buf(void)
+const char *tep_get_input_buf(void)
 {
 	return input_buf;
 }
 
-unsigned long long pevent_get_input_buf_ptr(void)
+unsigned long long tep_get_input_buf_ptr(void)
 {
 	return input_buf_ptr;
 }
@@ -113,14 +113,14 @@ process_defined_func(struct trace_seq *s, void *data, int size,
 static void free_func_handle(struct tep_function_handler *func);
 
 /**
- * pevent_buffer_init - init buffer for parsing
+ * tep_buffer_init - init buffer for parsing
  * @buf: buffer to parse
  * @size: the size of the buffer
  *
- * For use with pevent_read_token(), this initializes the internal
- * buffer that pevent_read_token() will parse.
+ * For use with tep_read_token(), this initializes the internal
+ * buffer that tep_read_token() will parse.
  */
-void pevent_buffer_init(const char *buf, unsigned long long size)
+void tep_buffer_init(const char *buf, unsigned long long size)
 {
 	init_input_buf(buf, size);
 }
@@ -913,11 +913,11 @@ static int __peek_char(void)
 }
 
 /**
- * pevent_peek_char - peek at the next character that will be read
+ * tep_peek_char - peek at the next character that will be read
  *
  * Returns the next character read, or -1 if end of buffer.
  */
-int pevent_peek_char(void)
+int tep_peek_char(void)
 {
 	return __peek_char();
 }
@@ -1157,7 +1157,7 @@ static enum event_type read_token(char **tok)
 }
 
 /**
- * pevent_read_token - access to utilites to use the pevent parser
+ * tep_read_token - access to utilites to use the pevent parser
  * @tok: The token to return
  *
  * This will parse tokens from the string given by
@@ -1165,16 +1165,16 @@ static enum event_type read_token(char **tok)
  *
  * Returns the token type.
  */
-enum event_type pevent_read_token(char **tok)
+enum event_type tep_read_token(char **tok)
 {
 	return read_token(tok);
 }
 
 /**
- * pevent_free_token - free a token returned by pevent_read_token
+ * tep_free_token - free a token returned by tep_read_token
  * @token: the token to free
  */
-void pevent_free_token(char *token)
+void tep_free_token(char *token)
 {
 	free_token(token);
 }
diff --git a/tools/lib/traceevent/event-parse.h b/tools/lib/traceevent/event-parse.h
index 7f8921431cf1..c41547353b4c 100644
--- a/tools/lib/traceevent/event-parse.h
+++ b/tools/lib/traceevent/event-parse.h
@@ -797,12 +797,12 @@ void pevent_ref(struct tep_handle *pevent);
 void pevent_unref(struct tep_handle *pevent);
 
 /* access to the internal parser */
-void pevent_buffer_init(const char *buf, unsigned long long size);
-enum event_type pevent_read_token(char **tok);
-void pevent_free_token(char *token);
-int pevent_peek_char(void);
-const char *pevent_get_input_buf(void);
-unsigned long long pevent_get_input_buf_ptr(void);
+void tep_buffer_init(const char *buf, unsigned long long size);
+enum event_type tep_read_token(char **tok);
+void tep_free_token(char *token);
+int tep_peek_char(void);
+const char *tep_get_input_buf(void);
+unsigned long long tep_get_input_buf_ptr(void);
 
 /* for debugging */
 void tep_print_funcs(struct tep_handle *pevent);
diff --git a/tools/lib/traceevent/parse-filter.c b/tools/lib/traceevent/parse-filter.c
index 3efab9b4298f..5e3f29736a25 100644
--- a/tools/lib/traceevent/parse-filter.c
+++ b/tools/lib/traceevent/parse-filter.c
@@ -51,8 +51,8 @@ static void show_error(char *error_buf, const char *fmt, ...)
 	int len;
 	int i;
 
-	input = pevent_get_input_buf();
-	index = pevent_get_input_buf_ptr();
+	input = tep_get_input_buf();
+	index = tep_get_input_buf_ptr();
 	len = input ? strlen(input) : 0;
 
 	if (len) {
@@ -72,7 +72,7 @@ static void show_error(char *error_buf, const char *fmt, ...)
 
 static void free_token(char *token)
 {
-	pevent_free_token(token);
+	tep_free_token(token);
 }
 
 static enum event_type read_token(char **tok)
@@ -82,13 +82,13 @@ static enum event_type read_token(char **tok)
 
 	do {
 		free_token(token);
-		type = pevent_read_token(&token);
+		type = tep_read_token(&token);
 	} while (type == EVENT_NEWLINE || type == EVENT_SPACE);
 
 	/* If token is = or ! check to see if the next char is ~ */
 	if (token &&
 	    (strcmp(token, "=") == 0 || strcmp(token, "!") == 0) &&
-	    pevent_peek_char() == '~') {
+	    tep_peek_char() == '~') {
 		/* append it */
 		*tok = malloc(3);
 		if (*tok == NULL) {
@@ -98,7 +98,7 @@ static enum event_type read_token(char **tok)
 		sprintf(*tok, "%c%c", *token, '~');
 		free_token(token);
 		/* Now remove the '~' from the buffer */
-		pevent_read_token(&token);
+		tep_read_token(&token);
 		free_token(token);
 	} else
 		*tok = token;
@@ -1198,7 +1198,7 @@ process_event(struct event_format *event, const char *filter_str,
 {
 	int ret;
 
-	pevent_buffer_init(filter_str, strlen(filter_str));
+	tep_buffer_init(filter_str, strlen(filter_str));
 
 	ret = process_filter(event, parg, error_str, 0);
 	if (ret < 0)
@@ -1254,7 +1254,7 @@ filter_event(struct event_filter *filter, struct event_format *event,
 static void filter_init_error_buf(struct event_filter *filter)
 {
 	/* clear buffer to reset show error */
-	pevent_buffer_init("", 0);
+	tep_buffer_init("", 0);
 	filter->error_buffer[0] = '\0';
 }
 
