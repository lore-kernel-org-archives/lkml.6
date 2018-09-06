Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D21C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63DEC2075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:24:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63DEC2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729407AbeIFSAU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 14:00:20 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50371 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727708AbeIFSAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 14:00:20 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w86DOPdh307701
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 6 Sep 2018 06:24:25 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w86DOPwD307698;
        Thu, 6 Sep 2018 06:24:25 -0700
Date:   Thu, 6 Sep 2018 06:24:25 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-650d622046024623e71fea1f28acf1edb7e61a81@git.kernel.org>
Cc:     andi@firstfloor.org, jolsa@kernel.org, namhyung@kernel.org,
        alexander.shishkin@linux.intel.com, tglx@linutronix.de,
        mingo@kernel.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, hpa@zytor.com, dsahern@gmail.com,
        acme@redhat.com
Reply-To: andi@firstfloor.org, namhyung@kernel.org, jolsa@kernel.org,
          alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
          mingo@kernel.org, peterz@infradead.org, tglx@linutronix.de,
          dsahern@gmail.com, acme@redhat.com, hpa@zytor.com
In-Reply-To: <20180830063252.23729-8-jolsa@kernel.org>
References: <20180830063252.23729-8-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf evsel: Introduce perf_evsel__store_ids()
Git-Commit-ID: 650d622046024623e71fea1f28acf1edb7e61a81
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

Commit-ID:  650d622046024623e71fea1f28acf1edb7e61a81
Gitweb:     https://git.kernel.org/tip/650d622046024623e71fea1f28acf1edb7e61a81
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Thu, 30 Aug 2018 08:32:16 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 30 Aug 2018 15:52:21 -0300

perf evsel: Introduce perf_evsel__store_ids()

Add perf_evsel__store_ids() from stat's store_counter_ids() code to the
evsel class, so that it can be used globally.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180830063252.23729-8-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 33 +--------------------------------
 tools/perf/util/evsel.c   | 29 +++++++++++++++++++++++++++++
 tools/perf/util/evsel.h   |  1 +
 3 files changed, 31 insertions(+), 32 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 8291f503d0cc..45bbd156d496 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -497,37 +497,6 @@ static int perf_stat_synthesize_config(bool is_pipe)
 	return 0;
 }
 
-#define FD(e, x, y) (*(int *)xyarray__entry(e->fd, x, y))
-
-static int __store_counter_ids(struct perf_evsel *counter)
-{
-	int cpu, thread;
-
-	for (cpu = 0; cpu < xyarray__max_x(counter->fd); cpu++) {
-		for (thread = 0; thread < xyarray__max_y(counter->fd);
-		     thread++) {
-			int fd = FD(counter, cpu, thread);
-
-			if (perf_evlist__id_add_fd(evsel_list, counter,
-						   cpu, thread, fd) < 0)
-				return -1;
-		}
-	}
-
-	return 0;
-}
-
-static int store_counter_ids(struct perf_evsel *counter)
-{
-	struct cpu_map *cpus = counter->cpus;
-	struct thread_map *threads = counter->threads;
-
-	if (perf_evsel__alloc_id(counter, cpus->nr, threads->nr))
-		return -ENOMEM;
-
-	return __store_counter_ids(counter);
-}
-
 static bool perf_evsel__should_store_id(struct perf_evsel *counter)
 {
 	return STAT_RECORD || counter->attr.read_format & PERF_FORMAT_ID;
@@ -658,7 +627,7 @@ try_again:
 			unit_width = l;
 
 		if (perf_evsel__should_store_id(counter) &&
-		    store_counter_ids(counter))
+		    perf_evsel__store_ids(counter, evsel_list))
 			return -1;
 	}
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 1a61628a1c12..4ec909d57e9c 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2940,3 +2940,32 @@ struct perf_env *perf_evsel__env(struct perf_evsel *evsel)
 		return evsel->evlist->env;
 	return NULL;
 }
+
+static int store_evsel_ids(struct perf_evsel *evsel, struct perf_evlist *evlist)
+{
+	int cpu, thread;
+
+	for (cpu = 0; cpu < xyarray__max_x(evsel->fd); cpu++) {
+		for (thread = 0; thread < xyarray__max_y(evsel->fd);
+		     thread++) {
+			int fd = FD(evsel, cpu, thread);
+
+			if (perf_evlist__id_add_fd(evlist, evsel,
+						   cpu, thread, fd) < 0)
+				return -1;
+		}
+	}
+
+	return 0;
+}
+
+int perf_evsel__store_ids(struct perf_evsel *evsel, struct perf_evlist *evlist)
+{
+	struct cpu_map *cpus = evsel->cpus;
+	struct thread_map *threads = evsel->threads;
+
+	if (perf_evsel__alloc_id(evsel, cpus->nr, threads->nr))
+		return -ENOMEM;
+
+	return store_evsel_ids(evsel, evlist);
+}
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 163c960614d3..4f8430a85531 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -481,4 +481,5 @@ int perf_event_attr__fprintf(FILE *fp, struct perf_event_attr *attr,
 
 struct perf_env *perf_evsel__env(struct perf_evsel *evsel);
 
+int perf_evsel__store_ids(struct perf_evsel *evsel, struct perf_evlist *evlist);
 #endif /* __PERF_EVSEL_H */
