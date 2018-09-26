Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3716EECE560
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88F89204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:51:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88F89204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727694AbeIZPDp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 11:03:45 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49555 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbeIZPDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 11:03:45 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8Q8pe1W3772386
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 26 Sep 2018 01:51:40 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8Q8peSk3772383;
        Wed, 26 Sep 2018 01:51:40 -0700
Date:   Wed, 26 Sep 2018 01:51:40 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Tzvetomir Stoyanov (VMware)" <tipbot@zytor.com>
Message-ID: <tip-9334c9616b71202c751a12edf5f83f51ec5a1663@git.kernel.org>
Cc:     hpa@zytor.com, akpm@linux-foundation.org, mingo@kernel.org,
        acme@redhat.com, tz.stoyanov@gmail.com,
        linux-kernel@vger.kernel.org, namhyung@kernel.org,
        rostedt@goodmis.org, jolsa@redhat.com, tglx@linutronix.de
Reply-To: tz.stoyanov@gmail.com, acme@redhat.com, mingo@kernel.org,
          akpm@linux-foundation.org, hpa@zytor.com, tglx@linutronix.de,
          jolsa@redhat.com, rostedt@goodmis.org, namhyung@kernel.org,
          linux-kernel@vger.kernel.org
In-Reply-To: <20180919185724.309837130@goodmis.org>
References: <20180919185724.309837130@goodmis.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] tools lib traceevent: Add prefix tep_ to structs
 filter_type and event_filter
Git-Commit-ID: 9334c9616b71202c751a12edf5f83f51ec5a1663
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

Commit-ID:  9334c9616b71202c751a12edf5f83f51ec5a1663
Gitweb:     https://git.kernel.org/tip/9334c9616b71202c751a12edf5f83f51ec5a1663
Author:     Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
AuthorDate: Wed, 19 Sep 2018 14:56:55 -0400
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 19 Sep 2018 17:28:28 -0300

tools lib traceevent: Add prefix tep_ to structs filter_type and event_filter

In order to make libtraceevent into a proper library, variables, data
structures and functions require a unique prefix to prevent name space
conflicts. That prefix will be "tep_". This adds prefix tep_ to
structs filter_type and event_filter

Signed-off-by: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
Cc: linux-trace-devel@vger.kernel.org
Link: http://lkml.kernel.org/r/20180919185724.309837130@goodmis.org
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/event-parse.h  | 34 ++++++-------
 tools/lib/traceevent/parse-filter.c | 96 ++++++++++++++++++-------------------
 2 files changed, 65 insertions(+), 65 deletions(-)

diff --git a/tools/lib/traceevent/event-parse.h b/tools/lib/traceevent/event-parse.h
index 1330fca2da1e..1abf15882460 100644
--- a/tools/lib/traceevent/event-parse.h
+++ b/tools/lib/traceevent/event-parse.h
@@ -882,7 +882,7 @@ struct tep_filter_arg {
 	};
 };
 
-struct filter_type {
+struct tep_filter_type {
 	int			event_id;
 	struct tep_event_format	*event;
 	struct tep_filter_arg	*filter;
@@ -890,14 +890,14 @@ struct filter_type {
 
 #define TEP_FILTER_ERROR_BUFSZ  1024
 
-struct event_filter {
+struct tep_event_filter {
 	struct tep_handle	*pevent;
 	int			filters;
-	struct filter_type	*event_filters;
+	struct tep_filter_type	*event_filters;
 	char			error_buffer[TEP_FILTER_ERROR_BUFSZ];
 };
 
-struct event_filter *tep_filter_alloc(struct tep_handle *pevent);
+struct tep_event_filter *tep_filter_alloc(struct tep_handle *pevent);
 
 /* for backward compatibility */
 #define FILTER_NONE		TEP_ERRNO__NO_FILTER
@@ -911,39 +911,39 @@ enum filter_trivial_type {
 	FILTER_TRIVIAL_BOTH,
 };
 
-enum tep_errno tep_filter_add_filter_str(struct event_filter *filter,
+enum tep_errno tep_filter_add_filter_str(struct tep_event_filter *filter,
 					 const char *filter_str);
 
-enum tep_errno tep_filter_match(struct event_filter *filter,
+enum tep_errno tep_filter_match(struct tep_event_filter *filter,
 				struct tep_record *record);
 
-int tep_filter_strerror(struct event_filter *filter, enum tep_errno err,
+int tep_filter_strerror(struct tep_event_filter *filter, enum tep_errno err,
 			char *buf, size_t buflen);
 
-int tep_event_filtered(struct event_filter *filter,
+int tep_event_filtered(struct tep_event_filter *filter,
 		       int event_id);
 
-void tep_filter_reset(struct event_filter *filter);
+void tep_filter_reset(struct tep_event_filter *filter);
 
-int tep_filter_clear_trivial(struct event_filter *filter,
+int tep_filter_clear_trivial(struct tep_event_filter *filter,
 			     enum filter_trivial_type type);
 
-void tep_filter_free(struct event_filter *filter);
+void tep_filter_free(struct tep_event_filter *filter);
 
-char *tep_filter_make_string(struct event_filter *filter, int event_id);
+char *tep_filter_make_string(struct tep_event_filter *filter, int event_id);
 
-int tep_filter_remove_event(struct event_filter *filter,
+int tep_filter_remove_event(struct tep_event_filter *filter,
 			    int event_id);
 
-int tep_filter_event_has_trivial(struct event_filter *filter,
+int tep_filter_event_has_trivial(struct tep_event_filter *filter,
 				 int event_id,
 				 enum filter_trivial_type type);
 
-int tep_filter_copy(struct event_filter *dest, struct event_filter *source);
+int tep_filter_copy(struct tep_event_filter *dest, struct tep_event_filter *source);
 
-int tep_update_trivial(struct event_filter *dest, struct event_filter *source,
+int tep_update_trivial(struct tep_event_filter *dest, struct tep_event_filter *source,
 			enum filter_trivial_type type);
 
-int tep_filter_compare(struct event_filter *filter1, struct event_filter *filter2);
+int tep_filter_compare(struct tep_event_filter *filter1, struct tep_event_filter *filter2);
 
 #endif /* _PARSE_EVENTS_H */
diff --git a/tools/lib/traceevent/parse-filter.c b/tools/lib/traceevent/parse-filter.c
index b9ca1b9e14e4..875bfaf79771 100644
--- a/tools/lib/traceevent/parse-filter.c
+++ b/tools/lib/traceevent/parse-filter.c
@@ -94,8 +94,8 @@ static enum tep_event_type read_token(char **tok)
 
 static int filter_cmp(const void *a, const void *b)
 {
-	const struct filter_type *ea = a;
-	const struct filter_type *eb = b;
+	const struct tep_filter_type *ea = a;
+	const struct tep_filter_type *eb = b;
 
 	if (ea->event_id < eb->event_id)
 		return -1;
@@ -106,11 +106,11 @@ static int filter_cmp(const void *a, const void *b)
 	return 0;
 }
 
-static struct filter_type *
-find_filter_type(struct event_filter *filter, int id)
+static struct tep_filter_type *
+find_filter_type(struct tep_event_filter *filter, int id)
 {
-	struct filter_type *filter_type;
-	struct filter_type key;
+	struct tep_filter_type *filter_type;
+	struct tep_filter_type key;
 
 	key.event_id = id;
 
@@ -122,10 +122,10 @@ find_filter_type(struct event_filter *filter, int id)
 	return filter_type;
 }
 
-static struct filter_type *
-add_filter_type(struct event_filter *filter, int id)
+static struct tep_filter_type *
+add_filter_type(struct tep_event_filter *filter, int id)
 {
-	struct filter_type *filter_type;
+	struct tep_filter_type *filter_type;
 	int i;
 
 	filter_type = find_filter_type(filter, id);
@@ -165,9 +165,9 @@ add_filter_type(struct event_filter *filter, int id)
  * tep_filter_alloc - create a new event filter
  * @pevent: The pevent that this filter is associated with
  */
-struct event_filter *tep_filter_alloc(struct tep_handle *pevent)
+struct tep_event_filter *tep_filter_alloc(struct tep_handle *pevent)
 {
-	struct event_filter *filter;
+	struct tep_event_filter *filter;
 
 	filter = malloc(sizeof(*filter));
 	if (filter == NULL)
@@ -1204,10 +1204,10 @@ process_event(struct tep_event_format *event, const char *filter_str,
 }
 
 static enum tep_errno
-filter_event(struct event_filter *filter, struct tep_event_format *event,
+filter_event(struct tep_event_filter *filter, struct tep_event_format *event,
 	     const char *filter_str, char *error_str)
 {
-	struct filter_type *filter_type;
+	struct tep_filter_type *filter_type;
 	struct tep_filter_arg *arg;
 	enum tep_errno ret;
 
@@ -1237,7 +1237,7 @@ filter_event(struct event_filter *filter, struct tep_event_format *event,
 	return 0;
 }
 
-static void filter_init_error_buf(struct event_filter *filter)
+static void filter_init_error_buf(struct tep_event_filter *filter)
 {
 	/* clear buffer to reset show error */
 	tep_buffer_init("", 0);
@@ -1253,7 +1253,7 @@ static void filter_init_error_buf(struct event_filter *filter)
  * negative error code.  Use tep_filter_strerror() to see
  * actual error message in case of error.
  */
-enum tep_errno tep_filter_add_filter_str(struct event_filter *filter,
+enum tep_errno tep_filter_add_filter_str(struct tep_event_filter *filter,
 					 const char *filter_str)
 {
 	struct tep_handle *pevent = filter->pevent;
@@ -1351,7 +1351,7 @@ enum tep_errno tep_filter_add_filter_str(struct event_filter *filter,
 	return rtn;
 }
 
-static void free_filter_type(struct filter_type *filter_type)
+static void free_filter_type(struct tep_filter_type *filter_type)
 {
 	free_arg(filter_type->filter);
 }
@@ -1365,7 +1365,7 @@ static void free_filter_type(struct filter_type *filter_type)
  *
  * Returns 0 if message was filled successfully, -1 if error
  */
-int tep_filter_strerror(struct event_filter *filter, enum tep_errno err,
+int tep_filter_strerror(struct tep_event_filter *filter, enum tep_errno err,
 			char *buf, size_t buflen)
 {
 	if (err <= __TEP_ERRNO__START || err >= __TEP_ERRNO__END)
@@ -1393,10 +1393,10 @@ int tep_filter_strerror(struct event_filter *filter, enum tep_errno err,
  * Returns 1: if an event was removed
  *   0: if the event was not found
  */
-int tep_filter_remove_event(struct event_filter *filter,
+int tep_filter_remove_event(struct tep_event_filter *filter,
 			    int event_id)
 {
-	struct filter_type *filter_type;
+	struct tep_filter_type *filter_type;
 	unsigned long len;
 
 	if (!filter->filters)
@@ -1428,7 +1428,7 @@ int tep_filter_remove_event(struct event_filter *filter,
  *
  * Removes all filters from a filter and resets it.
  */
-void tep_filter_reset(struct event_filter *filter)
+void tep_filter_reset(struct tep_event_filter *filter)
 {
 	int i;
 
@@ -1440,7 +1440,7 @@ void tep_filter_reset(struct event_filter *filter)
 	filter->event_filters = NULL;
 }
 
-void tep_filter_free(struct event_filter *filter)
+void tep_filter_free(struct tep_event_filter *filter)
 {
 	tep_unref(filter->pevent);
 
@@ -1449,11 +1449,11 @@ void tep_filter_free(struct event_filter *filter)
 	free(filter);
 }
 
-static char *arg_to_str(struct event_filter *filter, struct tep_filter_arg *arg);
+static char *arg_to_str(struct tep_event_filter *filter, struct tep_filter_arg *arg);
 
-static int copy_filter_type(struct event_filter *filter,
-			     struct event_filter *source,
-			     struct filter_type *filter_type)
+static int copy_filter_type(struct tep_event_filter *filter,
+			    struct tep_event_filter *source,
+			    struct tep_filter_type *filter_type)
 {
 	struct tep_filter_arg *arg;
 	struct tep_event_format *event;
@@ -1507,7 +1507,7 @@ static int copy_filter_type(struct event_filter *filter,
  *
  * Returns 0 on success and -1 if not all filters were copied
  */
-int tep_filter_copy(struct event_filter *dest, struct event_filter *source)
+int tep_filter_copy(struct tep_event_filter *dest, struct tep_event_filter *source)
 {
 	int ret = 0;
 	int i;
@@ -1533,13 +1533,13 @@ int tep_filter_copy(struct event_filter *dest, struct event_filter *source)
  * Returns 0 on success and -1 if there was a problem updating, but
  *   events may have still been updated on error.
  */
-int tep_update_trivial(struct event_filter *dest, struct event_filter *source,
+int tep_update_trivial(struct tep_event_filter *dest, struct tep_event_filter *source,
 		       enum filter_trivial_type type)
 {
 	struct tep_handle *src_pevent;
 	struct tep_handle *dest_pevent;
 	struct tep_event_format *event;
-	struct filter_type *filter_type;
+	struct tep_filter_type *filter_type;
 	struct tep_filter_arg *arg;
 	char *str;
 	int i;
@@ -1592,10 +1592,10 @@ int tep_update_trivial(struct event_filter *dest, struct event_filter *source,
  *
  * Returns 0 on success and -1 if there was a problem.
  */
-int tep_filter_clear_trivial(struct event_filter *filter,
+int tep_filter_clear_trivial(struct tep_event_filter *filter,
 			     enum filter_trivial_type type)
 {
-	struct filter_type *filter_type;
+	struct tep_filter_type *filter_type;
 	int count = 0;
 	int *ids = NULL;
 	int i;
@@ -1654,11 +1654,11 @@ int tep_filter_clear_trivial(struct event_filter *filter,
  * Returns 1 if the event contains a matching trivial type
  *  otherwise 0.
  */
-int tep_filter_event_has_trivial(struct event_filter *filter,
+int tep_filter_event_has_trivial(struct tep_event_filter *filter,
 				 int event_id,
 				 enum filter_trivial_type type)
 {
-	struct filter_type *filter_type;
+	struct tep_filter_type *filter_type;
 
 	if (!filter->filters)
 		return 0;
@@ -2008,9 +2008,9 @@ static int test_filter(struct tep_event_format *event, struct tep_filter_arg *ar
  * Returns 1 if filter found for @event_id
  *   otherwise 0;
  */
-int tep_event_filtered(struct event_filter *filter, int event_id)
+int tep_event_filtered(struct tep_event_filter *filter, int event_id)
 {
-	struct filter_type *filter_type;
+	struct tep_filter_type *filter_type;
 
 	if (!filter->filters)
 		return 0;
@@ -2032,11 +2032,11 @@ int tep_event_filtered(struct event_filter *filter, int event_id)
  * NO_FILTER - if no filters exist
  * otherwise - error occurred during test
  */
-enum tep_errno tep_filter_match(struct event_filter *filter,
+enum tep_errno tep_filter_match(struct tep_event_filter *filter,
 				struct tep_record *record)
 {
 	struct tep_handle *pevent = filter->pevent;
-	struct filter_type *filter_type;
+	struct tep_filter_type *filter_type;
 	int event_id;
 	int ret;
 	enum tep_errno err = 0;
@@ -2059,7 +2059,7 @@ enum tep_errno tep_filter_match(struct event_filter *filter,
 	return ret ? TEP_ERRNO__FILTER_MATCH : TEP_ERRNO__FILTER_MISS;
 }
 
-static char *op_to_str(struct event_filter *filter, struct tep_filter_arg *arg)
+static char *op_to_str(struct tep_event_filter *filter, struct tep_filter_arg *arg)
 {
 	char *str = NULL;
 	char *left = NULL;
@@ -2163,7 +2163,7 @@ static char *op_to_str(struct event_filter *filter, struct tep_filter_arg *arg)
 	return str;
 }
 
-static char *val_to_str(struct event_filter *filter, struct tep_filter_arg *arg)
+static char *val_to_str(struct tep_event_filter *filter, struct tep_filter_arg *arg)
 {
 	char *str = NULL;
 
@@ -2172,12 +2172,12 @@ static char *val_to_str(struct event_filter *filter, struct tep_filter_arg *arg)
 	return str;
 }
 
-static char *field_to_str(struct event_filter *filter, struct tep_filter_arg *arg)
+static char *field_to_str(struct tep_event_filter *filter, struct tep_filter_arg *arg)
 {
 	return strdup(arg->field.field->name);
 }
 
-static char *exp_to_str(struct event_filter *filter, struct tep_filter_arg *arg)
+static char *exp_to_str(struct tep_event_filter *filter, struct tep_filter_arg *arg)
 {
 	char *lstr;
 	char *rstr;
@@ -2233,7 +2233,7 @@ out:
 	return str;
 }
 
-static char *num_to_str(struct event_filter *filter, struct tep_filter_arg *arg)
+static char *num_to_str(struct tep_event_filter *filter, struct tep_filter_arg *arg)
 {
 	char *lstr;
 	char *rstr;
@@ -2283,7 +2283,7 @@ out:
 	return str;
 }
 
-static char *str_to_str(struct event_filter *filter, struct tep_filter_arg *arg)
+static char *str_to_str(struct tep_event_filter *filter, struct tep_filter_arg *arg)
 {
 	char *str = NULL;
 	char *op = NULL;
@@ -2315,7 +2315,7 @@ static char *str_to_str(struct event_filter *filter, struct tep_filter_arg *arg)
 	return str;
 }
 
-static char *arg_to_str(struct event_filter *filter, struct tep_filter_arg *arg)
+static char *arg_to_str(struct tep_event_filter *filter, struct tep_filter_arg *arg)
 {
 	char *str = NULL;
 
@@ -2359,9 +2359,9 @@ static char *arg_to_str(struct event_filter *filter, struct tep_filter_arg *arg)
  *  NULL is returned if no filter is found or allocation failed.
  */
 char *
-tep_filter_make_string(struct event_filter *filter, int event_id)
+tep_filter_make_string(struct tep_event_filter *filter, int event_id)
 {
-	struct filter_type *filter_type;
+	struct tep_filter_type *filter_type;
 
 	if (!filter->filters)
 		return NULL;
@@ -2383,10 +2383,10 @@ tep_filter_make_string(struct event_filter *filter, int event_id)
  *  1 if the two filters hold the same content.
  *  0 if they do not.
  */
-int tep_filter_compare(struct event_filter *filter1, struct event_filter *filter2)
+int tep_filter_compare(struct tep_event_filter *filter1, struct tep_event_filter *filter2)
 {
-	struct filter_type *filter_type1;
-	struct filter_type *filter_type2;
+	struct tep_filter_type *filter_type1;
+	struct tep_filter_type *filter_type2;
 	char *str1, *str2;
 	int result;
 	int i;
