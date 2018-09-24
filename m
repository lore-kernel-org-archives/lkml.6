Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6AABECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 770202086B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:05:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LU9buA40"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 770202086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732626AbeIXVHj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 17:07:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:52972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732554AbeIXVHi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 17:07:38 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 409A62086B;
        Mon, 24 Sep 2018 15:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537801502;
        bh=0Qp3QDhU2XthjZS03jS8VRpijsLNrHk5DMsdAHR26sA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LU9buA40qtMrRjtBd0Ch2exy4VLT1sAup2lrytCraGQabehzroGPuk+CbOg6aR/NO
         heBDpRAl7DiYKms/k9K5lNEn/ocwZBb9gFQU9YSB3lKrHHuE677rdmK63VvB7okJ2f
         zvP9YHT+9A/IDUZpdMSlsoP5bN3UO3ItjQ1K2eCc=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-trace-devel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 20/27] tools lib traceevent: Add prefix tep_ to enum filter_trivial_type
Date:   Mon, 24 Sep 2018 12:02:35 -0300
Message-Id: <20180924150242.14235-21-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180924150242.14235-1-acme@kernel.org>
References: <20180924150242.14235-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>

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
-- 
2.14.4

