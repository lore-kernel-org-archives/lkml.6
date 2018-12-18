Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CEE7C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 453BC21871
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:29:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbeLRO3R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 09:29:17 -0500
Received: from terminus.zytor.com ([198.137.202.136]:56025 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbeLRO3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 09:29:16 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBIEShcR2858250
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 18 Dec 2018 06:28:43 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBIESh9G2858247;
        Tue, 18 Dec 2018 06:28:43 -0800
Date:   Tue, 18 Dec 2018 06:28:43 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-appp27jw1ul8kgg872j43r5o@git.kernel.org>
Cc:     fweisbec@gmail.com, esyr@redhat.com, peterz@infradead.org,
        namhyung@kernel.org, lclaudio@uudg.org, rostedt@goodmis.org,
        mingo@kernel.org, tglx@linutronix.de, acme@redhat.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org, jolsa@kernel.org,
        ldv@altlinux.org, alexander.shishkin@linux.intel.com,
        adrian.hunter@intel.com
Reply-To: fweisbec@gmail.com, lclaudio@uudg.org, peterz@infradead.org,
          namhyung@kernel.org, esyr@redhat.com, rostedt@goodmis.org,
          mingo@kernel.org, tglx@linutronix.de, acme@redhat.com,
          hpa@zytor.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
          alexander.shishkin@linux.intel.com, adrian.hunter@intel.com,
          ldv@altlinux.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf ordered_events: Add first_time() method
Git-Commit-ID: 83356b3d124af5ae472ce1358222f6b7749d2322
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
Message-ID: <20181218142843.T1V8U5NVm7V7_AnxpvHwMpg9KR3sqt4LCpkhi8vvXOs@z>

Commit-ID:  83356b3d124af5ae472ce1358222f6b7749d2322
Gitweb:     https://git.kernel.org/tip/83356b3d124af5ae472ce1358222f6b7749d2322
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Thu, 6 Dec 2018 14:38:52 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 17 Dec 2018 15:02:17 -0300

perf ordered_events: Add first_time() method

To get the timestamp in the first event in the queue.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Dmitry Levin <ldv@altlinux.org>
Cc: Eugene Syromiatnikov <esyr@redhat.com>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Luis Cláudio Gonçalves <lclaudio@uudg.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/n/tip-appp27jw1ul8kgg872j43r5o@git.kernel.org
[ split from a larger patch ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/ordered-events.c | 11 +++++++++++
 tools/perf/util/ordered-events.h |  1 +
 2 files changed, 12 insertions(+)

diff --git a/tools/perf/util/ordered-events.c b/tools/perf/util/ordered-events.c
index 46965643020b..897589507d97 100644
--- a/tools/perf/util/ordered-events.c
+++ b/tools/perf/util/ordered-events.c
@@ -343,6 +343,17 @@ int ordered_events__flush_time(struct ordered_events *oe, u64 timestamp)
 	return __ordered_events__flush(oe, OE_FLUSH__TIME, timestamp);
 }
 
+u64 ordered_events__first_time(struct ordered_events *oe)
+{
+	struct ordered_event *event;
+
+	if (list_empty(&oe->events))
+		return 0;
+
+	event = list_first_entry(&oe->events, struct ordered_event, list);
+	return event->timestamp;
+}
+
 void ordered_events__init(struct ordered_events *oe, ordered_events__deliver_t deliver,
 			  void *data)
 {
diff --git a/tools/perf/util/ordered-events.h b/tools/perf/util/ordered-events.h
index f352af20e167..0920fb0ec6cc 100644
--- a/tools/perf/util/ordered-events.h
+++ b/tools/perf/util/ordered-events.h
@@ -61,6 +61,7 @@ void ordered_events__init(struct ordered_events *oe, ordered_events__deliver_t d
 			  void *data);
 void ordered_events__free(struct ordered_events *oe);
 void ordered_events__reinit(struct ordered_events *oe);
+u64 ordered_events__first_time(struct ordered_events *oe);
 
 static inline
 void ordered_events__set_alloc_size(struct ordered_events *oe, u64 size)
