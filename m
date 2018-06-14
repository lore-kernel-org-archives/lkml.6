Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id DABFCC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 06:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91D86208D8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 06:22:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91D86208D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754666AbeFNGWa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 02:22:30 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44873 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752899AbeFNGW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 02:22:27 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5E6LkMm763734
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 13 Jun 2018 23:21:46 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5E6LkSM763731;
        Wed, 13 Jun 2018 23:21:46 -0700
Date:   Wed, 13 Jun 2018 23:21:46 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-9660e08ee8cbc94ac835f2c30576c6e51fbece8f@git.kernel.org>
Cc:     andi@firstfloor.org, acme@redhat.com, frederic@kernel.org,
        alexander.shishkin@linux.intel.com, mingo@kernel.org,
        jolsa@kernel.org, linux-kernel@vger.kernel.org, dsahern@gmail.com,
        peterz@infradead.org, eranian@google.com, milian.wolff@kdab.com,
        namhyung@kernel.org, hpa@zytor.com, tglx@linutronix.de
Reply-To: andi@firstfloor.org, mingo@kernel.org, frederic@kernel.org,
          alexander.shishkin@linux.intel.com, acme@redhat.com,
          peterz@infradead.org, eranian@google.com, namhyung@kernel.org,
          milian.wolff@kdab.com, jolsa@kernel.org,
          linux-kernel@vger.kernel.org, dsahern@gmail.com,
          tglx@linutronix.de, hpa@zytor.com
In-Reply-To: <20180606221513.11302-4-jolsa@kernel.org>
References: <20180606221513.11302-4-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf stat: Add --interval-clear option
Git-Commit-ID: 9660e08ee8cbc94ac835f2c30576c6e51fbece8f
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

Commit-ID:  9660e08ee8cbc94ac835f2c30576c6e51fbece8f
Gitweb:     https://git.kernel.org/tip/9660e08ee8cbc94ac835f2c30576c6e51fbece8f
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Thu, 7 Jun 2018 00:15:06 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 7 Jun 2018 15:53:36 -0300

perf stat: Add --interval-clear option

Adding --interval-clear option to clear the screen before next interval.

Committer testing:

  # perf stat -I 1000 --interval-clear

And, as expected, it behaves almost like:

  # watch -n 0 perf stat -a sleep 1

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Milian Wolff <milian.wolff@kdab.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20180606221513.11302-4-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-stat.txt |  3 +++
 tools/perf/builtin-stat.c              | 11 +++++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index 5dfe102fb5b5..b10a90b6a718 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -178,6 +178,9 @@ Print count deltas for fixed number of times.
 This option should be used together with "-I" option.
 	example: 'perf stat -I 1000 --interval-count 2 -e cycles -a'
 
+--interval-clear::
+Clear the screen before next interval.
+
 --timeout msecs::
 Stop the 'perf stat' session and print count deltas after N milliseconds (minimum: 10 ms).
 This option is not supported with the "-I" option.
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 096ccb25c11f..f1532e3ac7d7 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -65,6 +65,7 @@
 #include "util/tool.h"
 #include "util/string2.h"
 #include "util/metricgroup.h"
+#include "util/top.h"
 #include "asm/bug.h"
 
 #include <linux/time64.h>
@@ -173,6 +174,7 @@ static struct cpu_map		*aggr_map;
 static aggr_get_id_t		aggr_get_id;
 static bool			append_file;
 static bool			interval_count;
+static bool			interval_clear;
 static const char		*output_name;
 static int			output_fd;
 static int			print_free_counters_hint;
@@ -1704,9 +1706,12 @@ static void print_interval(char *prefix, struct timespec *ts)
 	FILE *output = stat_config.output;
 	static int num_print_interval;
 
+	if (interval_clear)
+		puts(CONSOLE_CLEAR);
+
 	sprintf(prefix, "%6lu.%09lu%s", ts->tv_sec, ts->tv_nsec, csv_sep);
 
-	if (num_print_interval == 0 && !csv_output) {
+	if ((num_print_interval == 0 && !csv_output) || interval_clear) {
 		switch (stat_config.aggr_mode) {
 		case AGGR_SOCKET:
 			fprintf(output, "#           time socket cpus");
@@ -1738,7 +1743,7 @@ static void print_interval(char *prefix, struct timespec *ts)
 		}
 	}
 
-	if (num_print_interval == 0 && metric_only)
+	if ((num_print_interval == 0 && metric_only) || interval_clear)
 		print_metric_headers(" ", true);
 	if (++num_print_interval == 25)
 		num_print_interval = 0;
@@ -2057,6 +2062,8 @@ static const struct option stat_options[] = {
 		    "(overhead is possible for values <= 100ms)"),
 	OPT_INTEGER(0, "interval-count", &stat_config.times,
 		    "print counts for fixed number of times"),
+	OPT_BOOLEAN(0, "interval-clear", &interval_clear,
+		    "clear screen in between new interval"),
 	OPT_UINTEGER(0, "timeout", &stat_config.timeout,
 		    "stop workload and print counts after a timeout period in ms (>= 10ms)"),
 	OPT_SET_UINT(0, "per-socket", &stat_config.aggr_mode,
