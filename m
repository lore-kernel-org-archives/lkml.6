Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2997FC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 21:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63AA82086D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 21:02:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731245AbeLNVCR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 16:02:17 -0500
Received: from terminus.zytor.com ([198.137.202.136]:47697 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730952AbeLNVCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 16:02:15 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBEL1gI11460402
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 14 Dec 2018 13:01:42 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBEL1gMt1460399;
        Fri, 14 Dec 2018 13:01:42 -0800
Date:   Fri, 14 Dec 2018 13:01:42 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-appp27jw1ul8kgg872j43r5o@git.kernel.org>
Cc:     peterz@infradead.org, namhyung@kernel.org, adrian.hunter@intel.com,
        hpa@zytor.com, tglx@linutronix.de, fweisbec@gmail.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        ldv@altlinux.org, lclaudio@uudg.org, rostedt@goodmis.org,
        mingo@kernel.org, acme@redhat.com, linux-kernel@vger.kernel.org,
        esyr@redhat.com
Reply-To: acme@redhat.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
          esyr@redhat.com, lclaudio@uudg.org, rostedt@goodmis.org,
          ldv@altlinux.org, jolsa@kernel.org, fweisbec@gmail.com,
          alexander.shishkin@linux.intel.com, hpa@zytor.com,
          tglx@linutronix.de, adrian.hunter@intel.com, namhyung@kernel.org,
          peterz@infradead.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf ordered_events: Add first_time() method
Git-Commit-ID: 5a0cb2ffce065d738d90c0bf372a79ddc961c9ff
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

Commit-ID:  5a0cb2ffce065d738d90c0bf372a79ddc961c9ff
Gitweb:     https://git.kernel.org/tip/5a0cb2ffce065d738d90c0bf372a79ddc961c9ff
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Thu, 6 Dec 2018 14:38:52 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 6 Dec 2018 16:43:28 -0300

perf ordered_events: Add first_time() method

To get the timestamp in the first event in the queue.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Dmitry Levin <ldv@altlinux.org>
Cc: Eugene Syromiatnikov <esyr@redhat.com>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
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
