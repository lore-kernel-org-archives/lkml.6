Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA2C0C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97DBD2064D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:34:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97DBD2064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729665AbeIFSJ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 14:09:57 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56683 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729252AbeIFSJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 14:09:57 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w86DX0pb308870
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 6 Sep 2018 06:33:00 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w86DX01q308867;
        Thu, 6 Sep 2018 06:33:00 -0700
Date:   Thu, 6 Sep 2018 06:33:00 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-df4f7b4d4b1e61e6b16ac2e3760be46bac86e4f4@git.kernel.org>
Cc:     alexander.shishkin@linux.intel.com, dsahern@gmail.com,
        mingo@kernel.org, acme@redhat.com, jolsa@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        andi@firstfloor.org, namhyung@kernel.org, hpa@zytor.com,
        peterz@infradead.org
Reply-To: namhyung@kernel.org, hpa@zytor.com, peterz@infradead.org,
          andi@firstfloor.org, mingo@kernel.org, jolsa@kernel.org,
          acme@redhat.com, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
          dsahern@gmail.com
In-Reply-To: <20180830063252.23729-24-jolsa@kernel.org>
References: <20180830063252.23729-24-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf stat: Move 'unit_width' to 'struct
 perf_stat_config'
Git-Commit-ID: df4f7b4d4b1e61e6b16ac2e3760be46bac86e4f4
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

Commit-ID:  df4f7b4d4b1e61e6b16ac2e3760be46bac86e4f4
Gitweb:     https://git.kernel.org/tip/df4f7b4d4b1e61e6b16ac2e3760be46bac86e4f4
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Thu, 30 Aug 2018 08:32:32 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 30 Aug 2018 15:52:23 -0300

perf stat: Move 'unit_width' to 'struct perf_stat_config'

Move the static 'unit_width' variable to 'struct perf_stat_config',
so it can be passed around and used outside the 'perf stat' command.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180830063252.23729-24-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 11 ++++++-----
 tools/perf/util/stat.h    |  1 +
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 397cb4f28d7f..24171aa6c41f 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -161,7 +161,6 @@ static bool			group				= false;
 static const char		*pre_cmd			= NULL;
 static const char		*post_cmd			= NULL;
 static bool			sync_run			= false;
-static unsigned int		unit_width			= 4; /* strlen("unit") */
 static bool			forever				= false;
 static bool			force_metric_only		= false;
 static bool			no_merge			= false;
@@ -200,6 +199,7 @@ static volatile int done = 0;
 static struct perf_stat_config stat_config = {
 	.aggr_mode	= AGGR_GLOBAL,
 	.scale		= true,
+	.unit_width	= 4, /* strlen("unit") */
 };
 
 static bool is_duration_time(struct perf_evsel *evsel)
@@ -524,8 +524,8 @@ try_again:
 		counter->supported = true;
 
 		l = strlen(counter->unit);
-		if (l > unit_width)
-			unit_width = l;
+		if (l > stat_config.unit_width)
+			stat_config.unit_width = l;
 
 		if (perf_evsel__should_store_id(counter) &&
 		    perf_evsel__store_ids(counter, evsel_list))
@@ -963,7 +963,7 @@ static void abs_printout(struct perf_stat_config *config,
 
 	if (evsel->unit)
 		fprintf(output, "%-*s%s",
-			config->csv_output ? 0 : unit_width,
+			config->csv_output ? 0 : config->unit_width,
 			evsel->unit, config->csv_sep);
 
 	fprintf(output, "%-*s", config->csv_output ? 0 : 25, perf_evsel__name(evsel));
@@ -1056,7 +1056,7 @@ static void printout(struct perf_stat_config *config, int id, int nr,
 		}
 
 		fprintf(config->output, "%-*s%s",
-			config->csv_output ? 0 : unit_width,
+			config->csv_output ? 0 : config->unit_width,
 			counter->unit, config->csv_sep);
 
 		fprintf(config->output, "%*s",
@@ -1542,6 +1542,7 @@ static void print_interval(struct perf_stat_config *config,
 			   char *prefix, struct timespec *ts)
 {
 	bool metric_only = config->metric_only;
+	unsigned int unit_width = config->unit_width;
 	FILE *output = config->output;
 	static int num_print_interval;
 
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index da838182b99c..2dc66e0ba4b8 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -98,6 +98,7 @@ struct perf_stat_config {
 	unsigned int		 interval;
 	unsigned int		 timeout;
 	unsigned int		 initial_delay;
+	unsigned int		 unit_width;
 	int			 times;
 	struct runtime_stat	*stats;
 	int			 stats_num;
