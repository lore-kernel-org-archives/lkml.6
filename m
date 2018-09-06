Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F032C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E62B12075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:38:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E62B12075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729632AbeIFSNg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 14:13:36 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44567 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727708AbeIFSNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 14:13:36 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w86Dbb1f309672
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 6 Sep 2018 06:37:37 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w86Dba7N309669;
        Thu, 6 Sep 2018 06:37:36 -0700
Date:   Thu, 6 Sep 2018 06:37:36 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-26893a6018f88779c0aded934e99e0ebb6859a58@git.kernel.org>
Cc:     peterz@infradead.org, jolsa@kernel.org, namhyung@kernel.org,
        mingo@kernel.org, alexander.shishkin@linux.intel.com,
        linux-kernel@vger.kernel.org, andi@firstfloor.org,
        dsahern@gmail.com, acme@redhat.com, tglx@linutronix.de,
        hpa@zytor.com
Reply-To: acme@redhat.com, tglx@linutronix.de, hpa@zytor.com,
          mingo@kernel.org, linux-kernel@vger.kernel.org,
          dsahern@gmail.com, andi@firstfloor.org,
          alexander.shishkin@linux.intel.com, jolsa@kernel.org,
          namhyung@kernel.org, peterz@infradead.org
In-Reply-To: <20180830063252.23729-32-jolsa@kernel.org>
References: <20180830063252.23729-32-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf stat: Add 'walltime_nsecs_stats' pointer to
 'struct perf_stat_config'
Git-Commit-ID: 26893a6018f88779c0aded934e99e0ebb6859a58
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

Commit-ID:  26893a6018f88779c0aded934e99e0ebb6859a58
Gitweb:     https://git.kernel.org/tip/26893a6018f88779c0aded934e99e0ebb6859a58
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Thu, 30 Aug 2018 08:32:40 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 30 Aug 2018 15:52:24 -0300

perf stat: Add 'walltime_nsecs_stats' pointer to 'struct perf_stat_config'

Add 'walltime_nsecs_stats' pointer to 'struct perf_stat_config', so that
it can be passed around and used outside the 'perf stat' command.

It's initialized to point to stat's walltime_nsecs_stats value.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180830063252.23729-32-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 15 ++++++++-------
 tools/perf/util/stat.h    |  1 +
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 2711d8f6e4b8..381549a989b4 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -195,11 +195,12 @@ static struct perf_stat		perf_stat;
 static volatile int done = 0;
 
 static struct perf_stat_config stat_config = {
-	.aggr_mode	= AGGR_GLOBAL,
-	.scale		= true,
-	.unit_width	= 4, /* strlen("unit") */
-	.run_count	= 1,
-	.metric_only_len = METRIC_ONLY_LEN,
+	.aggr_mode		= AGGR_GLOBAL,
+	.scale			= true,
+	.unit_width		= 4, /* strlen("unit") */
+	.run_count		= 1,
+	.metric_only_len	= METRIC_ONLY_LEN,
+	.walltime_nsecs_stats	= &walltime_nsecs_stats,
 };
 
 static bool is_duration_time(struct perf_evsel *evsel)
@@ -1671,7 +1672,7 @@ static double timeval2double(struct timeval *t)
 
 static void print_footer(struct perf_stat_config *config)
 {
-	double avg = avg_stats(&walltime_nsecs_stats) / NSEC_PER_SEC;
+	double avg = avg_stats(config->walltime_nsecs_stats) / NSEC_PER_SEC;
 	FILE *output = config->output;
 	int n;
 
@@ -1690,7 +1691,7 @@ static void print_footer(struct perf_stat_config *config)
 			fprintf(output, " %17.9f seconds sys\n", ru_stime);
 		}
 	} else {
-		double sd = stddev_stats(&walltime_nsecs_stats) / NSEC_PER_SEC;
+		double sd = stddev_stats(config->walltime_nsecs_stats) / NSEC_PER_SEC;
 		/*
 		 * Display at most 2 more significant
 		 * digits than the stddev inaccuracy.
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index e70e6d93ee1b..35550e3efd81 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -105,6 +105,7 @@ struct perf_stat_config {
 	struct runtime_stat	*stats;
 	int			 stats_num;
 	const char		*csv_sep;
+	struct stats		*walltime_nsecs_stats;
 };
 
 void update_stats(struct stats *stats, u64 val);
