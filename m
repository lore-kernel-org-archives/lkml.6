Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7484CC4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 023C4218A8
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:51:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 023C4218A8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbeHRO7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 10:59:02 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44885 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbeHRO7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 10:59:01 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w7IBpCce1290741
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 18 Aug 2018 04:51:12 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w7IBpBqX1290738;
        Sat, 18 Aug 2018 04:51:11 -0700
Date:   Sat, 18 Aug 2018 04:51:11 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Tzvetomir Stoyanov (VMware)" <tipbot@zytor.com>
Message-ID: <tip-64e237906963d0c26d3b25e7751b4d6aaa01f720@git.kernel.org>
Cc:     acme@redhat.com, tz.stoyanov@gmail.com, akpm@linux-foundation.org,
        peterz@infradead.org, tglx@linutronix.de, rostedt@goodmis.org,
        hpa@zytor.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        y.karadz@gmail.com
Reply-To: acme@redhat.com, tz.stoyanov@gmail.com, peterz@infradead.org,
          akpm@linux-foundation.org, rostedt@goodmis.org,
          tglx@linutronix.de, hpa@zytor.com, mingo@kernel.org,
          y.karadz@gmail.com, linux-kernel@vger.kernel.org
In-Reply-To: <20180808180702.370659353@goodmis.org>
References: <20180808180702.370659353@goodmis.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] tools lib traceevent: Rename pevent_filter* APIs
Git-Commit-ID: 64e237906963d0c26d3b25e7751b4d6aaa01f720
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

Commit-ID:  64e237906963d0c26d3b25e7751b4d6aaa01f720
Gitweb:     https://git.kernel.org/tip/64e237906963d0c26d3b25e7751b4d6aaa01f720
Author:     Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
AuthorDate: Wed, 8 Aug 2018 14:03:01 -0400
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 13 Aug 2018 15:26:31 -0300

tools lib traceevent: Rename pevent_filter* APIs

In order to make libtraceevent into a proper library, variables, data
structures and functions require a unique prefix to prevent name space
conflicts. That prefix will be "tep_" and not "pevent_". This changes
APIs: PEVENT_FILTER_ERROR_BUFSZ, pevent_filter_alloc,
pevent_filter_add_filter_str, pevent_filter_match, pevent_filter_strerror,
pevent_event_filtered, pevent_filter_reset, pevent_filter_clear_trivial,
pevent_filter_free, pevent_filter_make_string, pevent_filter_remove_event,
pevent_filter_event_has_trivial, pevent_filter_copy, pevent_update_trivial,
pevent_filter_compare

Signed-off-by: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Yordan Karadzhov (VMware) <y.karadz@gmail.com>
Cc: linux-trace-devel@vger.kernel.org
Link: http://lkml.kernel.org/r/20180808180702.370659353@goodmis.org
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/event-parse.h  | 50 +++++++++++-----------
 tools/lib/traceevent/parse-filter.c | 84 ++++++++++++++++++-------------------
 2 files changed, 67 insertions(+), 67 deletions(-)

diff --git a/tools/lib/traceevent/event-parse.h b/tools/lib/traceevent/event-parse.h
index ec327849a7dc..c60329cd9463 100644
--- a/tools/lib/traceevent/event-parse.h
+++ b/tools/lib/traceevent/event-parse.h
@@ -930,16 +930,16 @@ struct filter_type {
 	struct filter_arg	*filter;
 };
 
-#define PEVENT_FILTER_ERROR_BUFSZ  1024
+#define TEP_FILTER_ERROR_BUFSZ  1024
 
 struct event_filter {
 	struct tep_handle	*pevent;
 	int			filters;
 	struct filter_type	*event_filters;
-	char			error_buffer[PEVENT_FILTER_ERROR_BUFSZ];
+	char			error_buffer[TEP_FILTER_ERROR_BUFSZ];
 };
 
-struct event_filter *pevent_filter_alloc(struct tep_handle *pevent);
+struct event_filter *tep_filter_alloc(struct tep_handle *pevent);
 
 /* for backward compatibility */
 #define FILTER_NONE		TEP_ERRNO__NO_FILTER
@@ -953,39 +953,39 @@ enum filter_trivial_type {
 	FILTER_TRIVIAL_BOTH,
 };
 
-enum tep_errno pevent_filter_add_filter_str(struct event_filter *filter,
-					    const char *filter_str);
+enum tep_errno tep_filter_add_filter_str(struct event_filter *filter,
+					 const char *filter_str);
 
-enum tep_errno pevent_filter_match(struct event_filter *filter,
-				   struct tep_record *record);
+enum tep_errno tep_filter_match(struct event_filter *filter,
+				struct tep_record *record);
 
-int pevent_filter_strerror(struct event_filter *filter, enum tep_errno err,
-			   char *buf, size_t buflen);
+int tep_filter_strerror(struct event_filter *filter, enum tep_errno err,
+			char *buf, size_t buflen);
 
-int pevent_event_filtered(struct event_filter *filter,
-			  int event_id);
+int tep_event_filtered(struct event_filter *filter,
+		       int event_id);
 
-void pevent_filter_reset(struct event_filter *filter);
+void tep_filter_reset(struct event_filter *filter);
 
-int pevent_filter_clear_trivial(struct event_filter *filter,
-				 enum filter_trivial_type type);
+int tep_filter_clear_trivial(struct event_filter *filter,
+			     enum filter_trivial_type type);
 
-void pevent_filter_free(struct event_filter *filter);
+void tep_filter_free(struct event_filter *filter);
 
-char *pevent_filter_make_string(struct event_filter *filter, int event_id);
+char *tep_filter_make_string(struct event_filter *filter, int event_id);
 
-int pevent_filter_remove_event(struct event_filter *filter,
-			       int event_id);
+int tep_filter_remove_event(struct event_filter *filter,
+			    int event_id);
 
-int pevent_filter_event_has_trivial(struct event_filter *filter,
-				    int event_id,
-				    enum filter_trivial_type type);
+int tep_filter_event_has_trivial(struct event_filter *filter,
+				 int event_id,
+				 enum filter_trivial_type type);
 
-int pevent_filter_copy(struct event_filter *dest, struct event_filter *source);
+int tep_filter_copy(struct event_filter *dest, struct event_filter *source);
 
-int pevent_update_trivial(struct event_filter *dest, struct event_filter *source,
-			  enum filter_trivial_type type);
+int tep_update_trivial(struct event_filter *dest, struct event_filter *source,
+			enum filter_trivial_type type);
 
-int pevent_filter_compare(struct event_filter *filter1, struct event_filter *filter2);
+int tep_filter_compare(struct event_filter *filter1, struct event_filter *filter2);
 
 #endif /* _PARSE_EVENTS_H */
diff --git a/tools/lib/traceevent/parse-filter.c b/tools/lib/traceevent/parse-filter.c
index 5dc474027313..f3d812676169 100644
--- a/tools/lib/traceevent/parse-filter.c
+++ b/tools/lib/traceevent/parse-filter.c
@@ -66,7 +66,7 @@ static void show_error(char *error_buf, const char *fmt, ...)
 	}
 
 	va_start(ap, fmt);
-	vsnprintf(error_buf + len, PEVENT_FILTER_ERROR_BUFSZ - len, fmt, ap);
+	vsnprintf(error_buf + len, TEP_FILTER_ERROR_BUFSZ - len, fmt, ap);
 	va_end(ap);
 }
 
@@ -176,10 +176,10 @@ add_filter_type(struct event_filter *filter, int id)
 }
 
 /**
- * pevent_filter_alloc - create a new event filter
+ * tep_filter_alloc - create a new event filter
  * @pevent: The pevent that this filter is associated with
  */
-struct event_filter *pevent_filter_alloc(struct tep_handle *pevent)
+struct event_filter *tep_filter_alloc(struct tep_handle *pevent)
 {
 	struct event_filter *filter;
 
@@ -1259,16 +1259,16 @@ static void filter_init_error_buf(struct event_filter *filter)
 }
 
 /**
- * pevent_filter_add_filter_str - add a new filter
+ * tep_filter_add_filter_str - add a new filter
  * @filter: the event filter to add to
  * @filter_str: the filter string that contains the filter
  *
  * Returns 0 if the filter was successfully added or a
- * negative error code.  Use pevent_filter_strerror() to see
+ * negative error code.  Use tep_filter_strerror() to see
  * actual error message in case of error.
  */
-enum tep_errno pevent_filter_add_filter_str(struct event_filter *filter,
-					       const char *filter_str)
+enum tep_errno tep_filter_add_filter_str(struct event_filter *filter,
+					 const char *filter_str)
 {
 	struct tep_handle *pevent = filter->pevent;
 	struct event_list *event;
@@ -1349,7 +1349,7 @@ enum tep_errno pevent_filter_add_filter_str(struct event_filter *filter,
 
 		if (ret >= 0 && pevent->test_filters) {
 			char *test;
-			test = pevent_filter_make_string(filter, event->event->id);
+			test = tep_filter_make_string(filter, event->event->id);
 			if (test) {
 				printf(" '%s: %s'\n", event->event->name, test);
 				free(test);
@@ -1371,7 +1371,7 @@ static void free_filter_type(struct filter_type *filter_type)
 }
 
 /**
- * pevent_filter_strerror - fill error message in a buffer
+ * tep_filter_strerror - fill error message in a buffer
  * @filter: the event filter contains error
  * @err: the error code
  * @buf: the buffer to be filled in
@@ -1379,8 +1379,8 @@ static void free_filter_type(struct filter_type *filter_type)
  *
  * Returns 0 if message was filled successfully, -1 if error
  */
-int pevent_filter_strerror(struct event_filter *filter, enum tep_errno err,
-			   char *buf, size_t buflen)
+int tep_filter_strerror(struct event_filter *filter, enum tep_errno err,
+			char *buf, size_t buflen)
 {
 	if (err <= __TEP_ERRNO__START || err >= __TEP_ERRNO__END)
 		return -1;
@@ -1397,7 +1397,7 @@ int pevent_filter_strerror(struct event_filter *filter, enum tep_errno err,
 }
 
 /**
- * pevent_filter_remove_event - remove a filter for an event
+ * tep_filter_remove_event - remove a filter for an event
  * @filter: the event filter to remove from
  * @event_id: the event to remove a filter for
  *
@@ -1407,8 +1407,8 @@ int pevent_filter_strerror(struct event_filter *filter, enum tep_errno err,
  * Returns 1: if an event was removed
  *   0: if the event was not found
  */
-int pevent_filter_remove_event(struct event_filter *filter,
-			       int event_id)
+int tep_filter_remove_event(struct event_filter *filter,
+			    int event_id)
 {
 	struct filter_type *filter_type;
 	unsigned long len;
@@ -1437,12 +1437,12 @@ int pevent_filter_remove_event(struct event_filter *filter,
 }
 
 /**
- * pevent_filter_reset - clear all filters in a filter
+ * tep_filter_reset - clear all filters in a filter
  * @filter: the event filter to reset
  *
  * Removes all filters from a filter and resets it.
  */
-void pevent_filter_reset(struct event_filter *filter)
+void tep_filter_reset(struct event_filter *filter)
 {
 	int i;
 
@@ -1454,11 +1454,11 @@ void pevent_filter_reset(struct event_filter *filter)
 	filter->event_filters = NULL;
 }
 
-void pevent_filter_free(struct event_filter *filter)
+void tep_filter_free(struct event_filter *filter)
 {
 	pevent_unref(filter->pevent);
 
-	pevent_filter_reset(filter);
+	tep_filter_reset(filter);
 
 	free(filter);
 }
@@ -1515,18 +1515,18 @@ static int copy_filter_type(struct event_filter *filter,
 }
 
 /**
- * pevent_filter_copy - copy a filter using another filter
+ * tep_filter_copy - copy a filter using another filter
  * @dest - the filter to copy to
  * @source - the filter to copy from
  *
  * Returns 0 on success and -1 if not all filters were copied
  */
-int pevent_filter_copy(struct event_filter *dest, struct event_filter *source)
+int tep_filter_copy(struct event_filter *dest, struct event_filter *source)
 {
 	int ret = 0;
 	int i;
 
-	pevent_filter_reset(dest);
+	tep_filter_reset(dest);
 
 	for (i = 0; i < source->filters; i++) {
 		if (copy_filter_type(dest, source, &source->event_filters[i]))
@@ -1537,7 +1537,7 @@ int pevent_filter_copy(struct event_filter *dest, struct event_filter *source)
 
 
 /**
- * pevent_update_trivial - update the trivial filters with the given filter
+ * tep_update_trivial - update the trivial filters with the given filter
  * @dest - the filter to update
  * @source - the filter as the source of the update
  * @type - the type of trivial filter to update.
@@ -1547,8 +1547,8 @@ int pevent_filter_copy(struct event_filter *dest, struct event_filter *source)
  * Returns 0 on success and -1 if there was a problem updating, but
  *   events may have still been updated on error.
  */
-int pevent_update_trivial(struct event_filter *dest, struct event_filter *source,
-			  enum filter_trivial_type type)
+int tep_update_trivial(struct event_filter *dest, struct event_filter *source,
+		       enum filter_trivial_type type)
 {
 	struct tep_handle *src_pevent;
 	struct tep_handle *dest_pevent;
@@ -1585,7 +1585,7 @@ int pevent_update_trivial(struct event_filter *dest, struct event_filter *source
 				return -1;
 		}
 
-		str = pevent_filter_make_string(source, event->id);
+		str = tep_filter_make_string(source, event->id);
 		if (!str)
 			continue;
 
@@ -1598,7 +1598,7 @@ int pevent_update_trivial(struct event_filter *dest, struct event_filter *source
 }
 
 /**
- * pevent_filter_clear_trivial - clear TRUE and FALSE filters
+ * tep_filter_clear_trivial - clear TRUE and FALSE filters
  * @filter: the filter to remove trivial filters from
  * @type: remove only true, false, or both
  *
@@ -1606,8 +1606,8 @@ int pevent_update_trivial(struct event_filter *dest, struct event_filter *source
  *
  * Returns 0 on success and -1 if there was a problem.
  */
-int pevent_filter_clear_trivial(struct event_filter *filter,
-				 enum filter_trivial_type type)
+int tep_filter_clear_trivial(struct event_filter *filter,
+			     enum filter_trivial_type type)
 {
 	struct filter_type *filter_type;
 	int count = 0;
@@ -1653,14 +1653,14 @@ int pevent_filter_clear_trivial(struct event_filter *filter,
 		return 0;
 
 	for (i = 0; i < count; i++)
-		pevent_filter_remove_event(filter, ids[i]);
+		tep_filter_remove_event(filter, ids[i]);
 
 	free(ids);
 	return 0;
 }
 
 /**
- * pevent_filter_event_has_trivial - return true event contains trivial filter
+ * tep_filter_event_has_trivial - return true event contains trivial filter
  * @filter: the filter with the information
  * @event_id: the id of the event to test
  * @type: trivial type to test for (TRUE, FALSE, EITHER)
@@ -1668,9 +1668,9 @@ int pevent_filter_clear_trivial(struct event_filter *filter,
  * Returns 1 if the event contains a matching trivial type
  *  otherwise 0.
  */
-int pevent_filter_event_has_trivial(struct event_filter *filter,
-				    int event_id,
-				    enum filter_trivial_type type)
+int tep_filter_event_has_trivial(struct event_filter *filter,
+				 int event_id,
+				 enum filter_trivial_type type)
 {
 	struct filter_type *filter_type;
 
@@ -2015,14 +2015,14 @@ static int test_filter(struct event_format *event, struct filter_arg *arg,
 }
 
 /**
- * pevent_event_filtered - return true if event has filter
+ * tep_event_filtered - return true if event has filter
  * @filter: filter struct with filter information
  * @event_id: event id to test if filter exists
  *
  * Returns 1 if filter found for @event_id
  *   otherwise 0;
  */
-int pevent_event_filtered(struct event_filter *filter, int event_id)
+int tep_event_filtered(struct event_filter *filter, int event_id)
 {
 	struct filter_type *filter_type;
 
@@ -2035,7 +2035,7 @@ int pevent_event_filtered(struct event_filter *filter, int event_id)
 }
 
 /**
- * pevent_filter_match - test if a record matches a filter
+ * tep_filter_match - test if a record matches a filter
  * @filter: filter struct with filter information
  * @record: the record to test against the filter
  *
@@ -2046,8 +2046,8 @@ int pevent_event_filtered(struct event_filter *filter, int event_id)
  * NO_FILTER - if no filters exist
  * otherwise - error occurred during test
  */
-enum tep_errno pevent_filter_match(struct event_filter *filter,
-				   struct tep_record *record)
+enum tep_errno tep_filter_match(struct event_filter *filter,
+				struct tep_record *record)
 {
 	struct tep_handle *pevent = filter->pevent;
 	struct filter_type *filter_type;
@@ -2364,7 +2364,7 @@ static char *arg_to_str(struct event_filter *filter, struct filter_arg *arg)
 }
 
 /**
- * pevent_filter_make_string - return a string showing the filter
+ * tep_filter_make_string - return a string showing the filter
  * @filter: filter struct with filter information
  * @event_id: the event id to return the filter string with
  *
@@ -2373,7 +2373,7 @@ static char *arg_to_str(struct event_filter *filter, struct filter_arg *arg)
  *  NULL is returned if no filter is found or allocation failed.
  */
 char *
-pevent_filter_make_string(struct event_filter *filter, int event_id)
+tep_filter_make_string(struct event_filter *filter, int event_id)
 {
 	struct filter_type *filter_type;
 
@@ -2389,7 +2389,7 @@ pevent_filter_make_string(struct event_filter *filter, int event_id)
 }
 
 /**
- * pevent_filter_compare - compare two filters and return if they are the same
+ * tep_filter_compare - compare two filters and return if they are the same
  * @filter1: Filter to compare with @filter2
  * @filter2: Filter to compare with @filter1
  *
@@ -2397,7 +2397,7 @@ pevent_filter_make_string(struct event_filter *filter, int event_id)
  *  1 if the two filters hold the same content.
  *  0 if they do not.
  */
-int pevent_filter_compare(struct event_filter *filter1, struct event_filter *filter2)
+int tep_filter_compare(struct event_filter *filter1, struct event_filter *filter2)
 {
 	struct filter_type *filter_type1;
 	struct filter_type *filter_type2;
