Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F065FC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A75C32064D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:38:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A75C32064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729719AbeIFSOJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 14:14:09 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52107 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727708AbeIFSOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 14:14:09 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w86DcBhH309722
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 6 Sep 2018 06:38:11 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w86DcBVS309719;
        Thu, 6 Sep 2018 06:38:11 -0700
Date:   Thu, 6 Sep 2018 06:38:11 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-aea0dca1629c72128cf7174d1d3f3807f7297005@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        dsahern@gmail.com, hpa@zytor.com, acme@redhat.com,
        mingo@kernel.org, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        andi@firstfloor.org
Reply-To: linux-kernel@vger.kernel.org, tglx@linutronix.de,
          acme@redhat.com, mingo@kernel.org, hpa@zytor.com,
          dsahern@gmail.com, alexander.shishkin@linux.intel.com,
          namhyung@kernel.org, peterz@infradead.org, jolsa@kernel.org,
          andi@firstfloor.org
In-Reply-To: <20180830063252.23729-33-jolsa@kernel.org>
References: <20180830063252.23729-33-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf stat: Move 'null_run' to 'struct
 perf_stat_config'
Git-Commit-ID: aea0dca1629c72128cf7174d1d3f3807f7297005
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

Commit-ID:  aea0dca1629c72128cf7174d1d3f3807f7297005
Gitweb:     https://git.kernel.org/tip/aea0dca1629c72128cf7174d1d3f3807f7297005
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Thu, 30 Aug 2018 08:32:41 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 30 Aug 2018 15:52:24 -0300

perf stat: Move 'null_run' to 'struct perf_stat_config'

Move the static 'null_run' variable to 'struct perf_stat_config', so
that it can be passed around and used outside the 'perf stat' command.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180830063252.23729-33-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 7 +++----
 tools/perf/util/stat.h    | 1 +
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 381549a989b4..844c755564e3 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -148,7 +148,6 @@ typedef int (*aggr_get_id_t)(struct cpu_map *m, int cpu);
 #define METRIC_ONLY_LEN 20
 
 static volatile pid_t		child_pid			= -1;
-static bool			null_run			=  false;
 static int			detailed_run			=  0;
 static bool			transaction_run;
 static bool			topdown_run			= false;
@@ -1676,7 +1675,7 @@ static void print_footer(struct perf_stat_config *config)
 	FILE *output = config->output;
 	int n;
 
-	if (!null_run)
+	if (!config->null_run)
 		fprintf(output, "\n");
 
 	if (config->run_count == 1) {
@@ -1894,7 +1893,7 @@ static const struct option stat_options[] = {
 		    "repeat command and print average + stddev (max: 100, forever: 0)"),
 	OPT_BOOLEAN(0, "table", &walltime_run_table,
 		    "display details about each run (only with -r option)"),
-	OPT_BOOLEAN('n', "null", &null_run,
+	OPT_BOOLEAN('n', "null", &stat_config.null_run,
 		    "null run - dont start any counters"),
 	OPT_INCR('d', "detailed", &detailed_run,
 		    "detailed run - start a lot of events"),
@@ -2309,7 +2308,7 @@ static int add_default_attributes(void)
 	struct parse_events_error errinfo;
 
 	/* Set attrs if no event is selected and !null_run: */
-	if (null_run)
+	if (stat_config.null_run)
 		return 0;
 
 	if (transaction_run) {
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 35550e3efd81..c198926c0e27 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -94,6 +94,7 @@ struct perf_stat_config {
 	bool			 csv_output;
 	bool			 interval_clear;
 	bool			 metric_only;
+	bool			 null_run;
 	FILE			*output;
 	unsigned int		 interval;
 	unsigned int		 timeout;
