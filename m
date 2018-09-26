Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3661C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CB86204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:53:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CB86204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbeIZPFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 11:05:19 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46045 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbeIZPFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 11:05:19 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8Q8rIAJ3772554
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 26 Sep 2018 01:53:18 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8Q8rIQH3772551;
        Wed, 26 Sep 2018 01:53:18 -0700
Date:   Wed, 26 Sep 2018 01:53:18 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Tzvetomir Stoyanov (VMware)" <tipbot@zytor.com>
Message-ID: <tip-035c450ffa0483e715fc7b14a2e8b744bf8a740a@git.kernel.org>
Cc:     namhyung@kernel.org, akpm@linux-foundation.org, jolsa@redhat.com,
        mingo@kernel.org, hpa@zytor.com, acme@redhat.com,
        rostedt@goodmis.org, tz.stoyanov@gmail.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Reply-To: acme@redhat.com, rostedt@goodmis.org, hpa@zytor.com,
          mingo@kernel.org, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, tz.stoyanov@gmail.com,
          jolsa@redhat.com, akpm@linux-foundation.org, namhyung@kernel.org
In-Reply-To: <20180919185725.076387655@goodmis.org>
References: <20180919185725.076387655@goodmis.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] tools lib traceevent: Add prefix tep_ to enum
 filter_trivial_type
Git-Commit-ID: 035c450ffa0483e715fc7b14a2e8b744bf8a740a
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

Commit-ID:  035c450ffa0483e715fc7b14a2e8b744bf8a740a
Gitweb:     https://git.kernel.org/tip/035c450ffa0483e715fc7b14a2e8b744bf8a740a
Author:     Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
AuthorDate: Wed, 19 Sep 2018 14:56:58 -0400
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 19 Sep 2018 17:30:46 -0300

tools lib traceevent: Add prefix tep_ to enum filter_trivial_type

In order to make libtraceevent into a proper library, variables, data
structures and functions require a unique prefix to prevent name space
conflicts. That prefix will be "tep_". This adds prefix tep_ to
enum filter_trivial_type and all its members.

Signed-off-by: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
Cc: linux-trace-devel@vger.kernel.org
Link: http://lkml.kernel.org/r/20180919185725.076387655@goodmis.org
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/event-parse.h  | 14 +++++++-------
 tools/lib/traceevent/parse-filter.c | 22 +++++++++++-----------
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/tools/lib/traceevent/event-parse.h b/tools/lib/traceevent/event-parse.h
index 830147dc6b21..9c29a5f7aa39 100644
--- a/tools/lib/traceevent/event-parse.h
+++ b/tools/lib/traceevent/event-parse.h
@@ -905,10 +905,10 @@ struct tep_event_filter *tep_filter_alloc(struct tep_handle *pevent);
 #define FILTER_MISS		TEP_ERRNO__FILTER_MISS
 #define FILTER_MATCH		TEP_ERRNO__FILTER_MATCH
 
-enum filter_trivial_type {
-	FILTER_TRIVIAL_FALSE,
-	FILTER_TRIVIAL_TRUE,
-	FILTER_TRIVIAL_BOTH,
+enum tep_filter_trivial_type {
+	TEP_FILTER_TRIVIAL_FALSE,
+	TEP_FILTER_TRIVIAL_TRUE,
+	TEP_FILTER_TRIVIAL_BOTH,
 };
 
 enum tep_errno tep_filter_add_filter_str(struct tep_event_filter *filter,
@@ -926,7 +926,7 @@ int tep_event_filtered(struct tep_event_filter *filter,
 void tep_filter_reset(struct tep_event_filter *filter);
 
 int tep_filter_clear_trivial(struct tep_event_filter *filter,
-			     enum filter_trivial_type type);
+			     enum tep_filter_trivial_type type);
 
 void tep_filter_free(struct tep_event_filter *filter);
 
@@ -937,12 +937,12 @@ int tep_filter_remove_event(struct tep_event_filter *filter,
 
 int tep_filter_event_has_trivial(struct tep_event_filter *filter,
 				 int event_id,
-				 enum filter_trivial_type type);
+				 enum tep_filter_trivial_type type);
 
 int tep_filter_copy(struct tep_event_filter *dest, struct tep_event_filter *source);
 
 int tep_update_trivial(struct tep_event_filter *dest, struct tep_event_filter *source,
-			enum filter_trivial_type type);
+			enum tep_filter_trivial_type type);
 
 int tep_filter_compare(struct tep_event_filter *filter1, struct tep_event_filter *filter2);
 
diff --git a/tools/lib/traceevent/parse-filter.c b/tools/lib/traceevent/parse-filter.c
index 875bfaf79771..d64b6128fa7d 100644
--- a/tools/lib/traceevent/parse-filter.c
+++ b/tools/lib/traceevent/parse-filter.c
@@ -1534,7 +1534,7 @@ int tep_filter_copy(struct tep_event_filter *dest, struct tep_event_filter *sour
  *   events may have still been updated on error.
  */
 int tep_update_trivial(struct tep_event_filter *dest, struct tep_event_filter *source,
-		       enum filter_trivial_type type)
+		       enum tep_filter_trivial_type type)
 {
 	struct tep_handle *src_pevent;
 	struct tep_handle *dest_pevent;
@@ -1556,8 +1556,8 @@ int tep_update_trivial(struct tep_event_filter *dest, struct tep_event_filter *s
 		arg = filter_type->filter;
 		if (arg->type != TEP_FILTER_ARG_BOOLEAN)
 			continue;
-		if ((arg->boolean.value && type == FILTER_TRIVIAL_FALSE) ||
-		    (!arg->boolean.value && type == FILTER_TRIVIAL_TRUE))
+		if ((arg->boolean.value && type == TEP_FILTER_TRIVIAL_FALSE) ||
+		    (!arg->boolean.value && type == TEP_FILTER_TRIVIAL_TRUE))
 			continue;
 
 		event = filter_type->event;
@@ -1593,7 +1593,7 @@ int tep_update_trivial(struct tep_event_filter *dest, struct tep_event_filter *s
  * Returns 0 on success and -1 if there was a problem.
  */
 int tep_filter_clear_trivial(struct tep_event_filter *filter,
-			     enum filter_trivial_type type)
+			     enum tep_filter_trivial_type type)
 {
 	struct tep_filter_type *filter_type;
 	int count = 0;
@@ -1614,11 +1614,11 @@ int tep_filter_clear_trivial(struct tep_event_filter *filter,
 		if (filter_type->filter->type != TEP_FILTER_ARG_BOOLEAN)
 			continue;
 		switch (type) {
-		case FILTER_TRIVIAL_FALSE:
+		case TEP_FILTER_TRIVIAL_FALSE:
 			if (filter_type->filter->boolean.value)
 				continue;
 			break;
-		case FILTER_TRIVIAL_TRUE:
+		case TEP_FILTER_TRIVIAL_TRUE:
 			if (!filter_type->filter->boolean.value)
 				continue;
 		default:
@@ -1656,7 +1656,7 @@ int tep_filter_clear_trivial(struct tep_event_filter *filter,
  */
 int tep_filter_event_has_trivial(struct tep_event_filter *filter,
 				 int event_id,
-				 enum filter_trivial_type type)
+				 enum tep_filter_trivial_type type)
 {
 	struct tep_filter_type *filter_type;
 
@@ -1672,10 +1672,10 @@ int tep_filter_event_has_trivial(struct tep_event_filter *filter,
 		return 0;
 
 	switch (type) {
-	case FILTER_TRIVIAL_FALSE:
+	case TEP_FILTER_TRIVIAL_FALSE:
 		return !filter_type->filter->boolean.value;
 
-	case FILTER_TRIVIAL_TRUE:
+	case TEP_FILTER_TRIVIAL_TRUE:
 		return filter_type->filter->boolean.value;
 	default:
 		return 1;
@@ -2409,8 +2409,8 @@ int tep_filter_compare(struct tep_event_filter *filter1, struct tep_event_filter
 		if (filter_type1->filter->type != filter_type2->filter->type)
 			break;
 		switch (filter_type1->filter->type) {
-		case FILTER_TRIVIAL_FALSE:
-		case FILTER_TRIVIAL_TRUE:
+		case TEP_FILTER_TRIVIAL_FALSE:
+		case TEP_FILTER_TRIVIAL_TRUE:
 			/* trivial types just need the type compared */
 			continue;
 		default:
