Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CAD1C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCD0421871
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:28:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbeLRO2G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 09:28:06 -0500
Received: from terminus.zytor.com ([198.137.202.136]:36643 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbeLRO2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 09:28:06 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBIERYiT2858157
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 18 Dec 2018 06:27:34 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBIERYXt2858152;
        Tue, 18 Dec 2018 06:27:34 -0800
Date:   Tue, 18 Dec 2018 06:27:34 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-68ca5d07de207e56f57e887de23b03fbc1ebc2a6@git.kernel.org>
Cc:     acme@redhat.com, jolsa@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, ldv@altlinux.org, hpa@zytor.com,
        fweisbec@gmail.com, esyr@redhat.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        mingo@kernel.org, linux-kernel@vger.kernel.org, lclaudio@uudg.org,
        rostedt@goodmis.org
Reply-To: mingo@kernel.org, namhyung@kernel.org, rostedt@goodmis.org,
          lclaudio@uudg.org, linux-kernel@vger.kernel.org, esyr@redhat.com,
          fweisbec@gmail.com, alexander.shishkin@linux.intel.com,
          hpa@zytor.com, ldv@altlinux.org, tglx@linutronix.de,
          acme@redhat.com, jolsa@kernel.org, peterz@infradead.org
In-Reply-To: <20181205160509.1168-7-jolsa@kernel.org>
References: <20181205160509.1168-7-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf ordered_events: Add ordered_events__flush_time
 interface
Git-Commit-ID: 68ca5d07de207e56f57e887de23b03fbc1ebc2a6
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

Commit-ID:  68ca5d07de207e56f57e887de23b03fbc1ebc2a6
Gitweb:     https://git.kernel.org/tip/68ca5d07de207e56f57e887de23b03fbc1ebc2a6
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Wed, 5 Dec 2018 17:05:07 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 17 Dec 2018 15:02:12 -0300

perf ordered_events: Add ordered_events__flush_time interface

Add OE_FLUSH__TIME flush type, to be able to flush only certain amount
of the queue based on the provided timestamp. It will be used in the
following patches.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Dmitry Levin <ldv@altlinux.org>
Cc: Eugene Syromiatnikov <esyr@redhat.com>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Luis Cláudio Gonçalves <lclaudio@uudg.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20181205160509.1168-7-jolsa@kernel.org
[ Fix the build on older systems such as centos 5 and 6 where 'time' shadows a global declaration ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/ordered-events.c | 23 +++++++++++++++++++----
 tools/perf/util/ordered-events.h |  2 ++
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/ordered-events.c b/tools/perf/util/ordered-events.c
index c5412db05683..46965643020b 100644
--- a/tools/perf/util/ordered-events.c
+++ b/tools/perf/util/ordered-events.c
@@ -219,8 +219,7 @@ int ordered_events__queue(struct ordered_events *oe, union perf_event *event,
 	return 0;
 }
 
-static int __ordered_events__flush(struct ordered_events *oe,
-				   bool show_progress)
+static int do_flush(struct ordered_events *oe, bool show_progress)
 {
 	struct list_head *head = &oe->events;
 	struct ordered_event *tmp, *iter;
@@ -263,7 +262,8 @@ static int __ordered_events__flush(struct ordered_events *oe,
 	return 0;
 }
 
-int ordered_events__flush(struct ordered_events *oe, enum oe_flush how)
+static int __ordered_events__flush(struct ordered_events *oe, enum oe_flush how,
+				   u64 timestamp)
 {
 	static const char * const str[] = {
 		"NONE",
@@ -302,6 +302,11 @@ int ordered_events__flush(struct ordered_events *oe, enum oe_flush how)
 		break;
 	}
 
+	case OE_FLUSH__TIME:
+		oe->next_flush = timestamp;
+		show_progress = false;
+		break;
+
 	case OE_FLUSH__ROUND:
 	case OE_FLUSH__NONE:
 	default:
@@ -312,7 +317,7 @@ int ordered_events__flush(struct ordered_events *oe, enum oe_flush how)
 		   str[how], oe->nr_events);
 	pr_oe_time(oe->max_timestamp, "max_timestamp\n");
 
-	err = __ordered_events__flush(oe, show_progress);
+	err = do_flush(oe, show_progress);
 
 	if (!err) {
 		if (how == OE_FLUSH__ROUND)
@@ -328,6 +333,16 @@ int ordered_events__flush(struct ordered_events *oe, enum oe_flush how)
 	return err;
 }
 
+int ordered_events__flush(struct ordered_events *oe, enum oe_flush how)
+{
+	return __ordered_events__flush(oe, how, 0);
+}
+
+int ordered_events__flush_time(struct ordered_events *oe, u64 timestamp)
+{
+	return __ordered_events__flush(oe, OE_FLUSH__TIME, timestamp);
+}
+
 void ordered_events__init(struct ordered_events *oe, ordered_events__deliver_t deliver,
 			  void *data)
 {
diff --git a/tools/perf/util/ordered-events.h b/tools/perf/util/ordered-events.h
index 0c6e26aec0e3..f352af20e167 100644
--- a/tools/perf/util/ordered-events.h
+++ b/tools/perf/util/ordered-events.h
@@ -19,6 +19,7 @@ enum oe_flush {
 	OE_FLUSH__ROUND,
 	OE_FLUSH__HALF,
 	OE_FLUSH__TOP,
+	OE_FLUSH__TIME,
 };
 
 struct ordered_events;
@@ -55,6 +56,7 @@ int ordered_events__queue(struct ordered_events *oe, union perf_event *event,
 			  u64 timestamp, u64 file_offset);
 void ordered_events__delete(struct ordered_events *oe, struct ordered_event *event);
 int ordered_events__flush(struct ordered_events *oe, enum oe_flush how);
+int ordered_events__flush_time(struct ordered_events *oe, u64 timestamp);
 void ordered_events__init(struct ordered_events *oe, ordered_events__deliver_t deliver,
 			  void *data);
 void ordered_events__free(struct ordered_events *oe);
