Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92865C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4048B2064D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:30:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4048B2064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729484AbeIFSFv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 14:05:51 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55041 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728828AbeIFSFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 14:05:51 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w86DTmZv308373
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 6 Sep 2018 06:29:48 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w86DTlmj308370;
        Thu, 6 Sep 2018 06:29:47 -0700
Date:   Thu, 6 Sep 2018 06:29:47 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-b64df7f33743cd6095b4a007f5f15ff4432fbcf5@git.kernel.org>
Cc:     mingo@kernel.org, hpa@zytor.com, andi@firstfloor.org,
        dsahern@gmail.com, namhyung@kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, acme@redhat.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org
Reply-To: dsahern@gmail.com, namhyung@kernel.org, hpa@zytor.com,
          andi@firstfloor.org, linux-kernel@vger.kernel.org,
          peterz@infradead.org, mingo@kernel.org, acme@redhat.com,
          alexander.shishkin@linux.intel.com, jolsa@kernel.org,
          tglx@linutronix.de
In-Reply-To: <20180830063252.23729-18-jolsa@kernel.org>
References: <20180830063252.23729-18-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf stat: Add 'struct perf_stat_config' argument
 to perf_evlist__print_counters()
Git-Commit-ID: b64df7f33743cd6095b4a007f5f15ff4432fbcf5
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

Commit-ID:  b64df7f33743cd6095b4a007f5f15ff4432fbcf5
Gitweb:     https://git.kernel.org/tip/b64df7f33743cd6095b4a007f5f15ff4432fbcf5
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Thu, 30 Aug 2018 08:32:26 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 30 Aug 2018 15:52:22 -0300

perf stat: Add 'struct perf_stat_config' argument to perf_evlist__print_counters()

Add a 'struct perf_stat_config' argument to perf_evlist__print_counters(),
so that it can be moved out of the 'perf stat' command to generic object
in the following patches.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180830063252.23729-18-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 4ffbb6594eb6..f340641fe63a 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1694,10 +1694,11 @@ static void print_footer(void)
 
 static void
 perf_evlist__print_counters(struct perf_evlist *evlist,
+			    struct perf_stat_config *config,
 			    struct timespec *ts,
 			    int argc, const char **argv)
 {
-	int interval = stat_config.interval;
+	int interval = config->interval;
 	struct perf_evsel *counter;
 	char buf[64], *prefix = NULL;
 
@@ -1713,11 +1714,11 @@ perf_evlist__print_counters(struct perf_evlist *evlist,
 			print_metric_headers(prefix, false);
 		if (num_print_iv++ == 25)
 			num_print_iv = 0;
-		if (stat_config.aggr_mode == AGGR_GLOBAL && prefix)
-			fprintf(stat_config.output, "%s", prefix);
+		if (config->aggr_mode == AGGR_GLOBAL && prefix)
+			fprintf(config->output, "%s", prefix);
 	}
 
-	switch (stat_config.aggr_mode) {
+	switch (config->aggr_mode) {
 	case AGGR_CORE:
 	case AGGR_SOCKET:
 		print_aggr(prefix);
@@ -1736,7 +1737,7 @@ perf_evlist__print_counters(struct perf_evlist *evlist,
 			print_counter_aggr(counter, prefix);
 		}
 		if (metric_only)
-			fputc('\n', stat_config.output);
+			fputc('\n', config->output);
 		break;
 	case AGGR_NONE:
 		if (metric_only)
@@ -1757,7 +1758,7 @@ perf_evlist__print_counters(struct perf_evlist *evlist,
 	if (!interval && !csv_output)
 		print_footer();
 
-	fflush(stat_config.output);
+	fflush(config->output);
 }
 
 static void print_counters(struct timespec *ts, int argc, const char **argv)
@@ -1766,7 +1767,8 @@ static void print_counters(struct timespec *ts, int argc, const char **argv)
 	if (STAT_RECORD && perf_stat.data.is_pipe)
 		return;
 
-	perf_evlist__print_counters(evsel_list, ts, argc, argv);
+	perf_evlist__print_counters(evsel_list, &stat_config,
+				    ts, argc, argv);
 }
 
 static volatile int signr = -1;
