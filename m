Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85BAEC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 488972075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:33:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 488972075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729640AbeIFSIu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 14:08:50 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55861 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729141AbeIFSIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 14:08:50 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w86DVsJr308746
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 6 Sep 2018 06:31:54 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w86DVrtV308741;
        Thu, 6 Sep 2018 06:31:53 -0700
Date:   Thu, 6 Sep 2018 06:31:53 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-132c6ba3c440fd21a45ff7f9d7a1f53813f4d0e3@git.kernel.org>
Cc:     alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        dsahern@gmail.com, jolsa@kernel.org, mingo@kernel.org,
        hpa@zytor.com, peterz@infradead.org, linux-kernel@vger.kernel.org,
        acme@redhat.com, andi@firstfloor.org, tglx@linutronix.de
Reply-To: dsahern@gmail.com, namhyung@kernel.org,
          alexander.shishkin@linux.intel.com, tglx@linutronix.de,
          acme@redhat.com, andi@firstfloor.org,
          linux-kernel@vger.kernel.org, peterz@infradead.org,
          hpa@zytor.com, mingo@kernel.org, jolsa@kernel.org
In-Reply-To: <20180830063252.23729-22-jolsa@kernel.org>
References: <20180830063252.23729-22-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf stat: Move 'interval_clear' to 'struct
 perf_stat_config'
Git-Commit-ID: 132c6ba3c440fd21a45ff7f9d7a1f53813f4d0e3
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

Commit-ID:  132c6ba3c440fd21a45ff7f9d7a1f53813f4d0e3
Gitweb:     https://git.kernel.org/tip/132c6ba3c440fd21a45ff7f9d7a1f53813f4d0e3
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Thu, 30 Aug 2018 08:32:30 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 30 Aug 2018 15:52:23 -0300

perf stat: Move 'interval_clear' to 'struct perf_stat_config'

Move the static 'interval_clear' variable to 'struct perf_stat_config',
so it can be passed around and used outside the 'perf stat' command.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180830063252.23729-22-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 9 ++++-----
 tools/perf/util/stat.h    | 1 +
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 4c29e5065e02..89297ab77d21 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -172,7 +172,6 @@ static struct cpu_map		*aggr_map;
 static aggr_get_id_t		aggr_get_id;
 static bool			append_file;
 static bool			interval_count;
-static bool			interval_clear;
 static const char		*output_name;
 static int			output_fd;
 static int			print_free_counters_hint;
@@ -1544,12 +1543,12 @@ static void print_interval(struct perf_stat_config *config,
 	FILE *output = config->output;
 	static int num_print_interval;
 
-	if (interval_clear)
+	if (config->interval_clear)
 		puts(CONSOLE_CLEAR);
 
 	sprintf(prefix, "%6lu.%09lu%s", ts->tv_sec, ts->tv_nsec, config->csv_sep);
 
-	if ((num_print_interval == 0 && !config->csv_output) || interval_clear) {
+	if ((num_print_interval == 0 && !config->csv_output) || config->interval_clear) {
 		switch (config->aggr_mode) {
 		case AGGR_SOCKET:
 			fprintf(output, "#           time socket cpus");
@@ -1581,7 +1580,7 @@ static void print_interval(struct perf_stat_config *config,
 		}
 	}
 
-	if ((num_print_interval == 0 || interval_clear) && metric_only)
+	if ((num_print_interval == 0 || config->interval_clear) && metric_only)
 		print_metric_headers(config, " ", true);
 	if (++num_print_interval == 25)
 		num_print_interval = 0;
@@ -1911,7 +1910,7 @@ static const struct option stat_options[] = {
 		    "(overhead is possible for values <= 100ms)"),
 	OPT_INTEGER(0, "interval-count", &stat_config.times,
 		    "print counts for fixed number of times"),
-	OPT_BOOLEAN(0, "interval-clear", &interval_clear,
+	OPT_BOOLEAN(0, "interval-clear", &stat_config.interval_clear,
 		    "clear screen in between new interval"),
 	OPT_UINTEGER(0, "timeout", &stat_config.timeout,
 		    "stop workload and print counts after a timeout period in ms (>= 10ms)"),
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 18546d8b0279..470ab37601be 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -92,6 +92,7 @@ struct perf_stat_config {
 	bool			 no_inherit;
 	bool			 identifier;
 	bool			 csv_output;
+	bool			 interval_clear;
 	FILE			*output;
 	unsigned int		 interval;
 	unsigned int		 timeout;
