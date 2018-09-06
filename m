Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3411C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99795206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:41:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99795206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729802AbeIFSRa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 14:17:30 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44531 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729485AbeIFSRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 14:17:30 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w86DfVCW310187
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 6 Sep 2018 06:41:31 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w86DfV1K310184;
        Thu, 6 Sep 2018 06:41:31 -0700
Date:   Thu, 6 Sep 2018 06:41:31 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-34ff0866d46ae206de884f54e7235f57096e5588@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, hpa@zytor.com, andi@firstfloor.org,
        acme@redhat.com, dsahern@gmail.com, namhyung@kernel.org,
        jolsa@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        alexander.shishkin@linux.intel.com, peterz@infradead.org
Reply-To: linux-kernel@vger.kernel.org, hpa@zytor.com, andi@firstfloor.org,
          dsahern@gmail.com, jolsa@kernel.org, namhyung@kernel.org,
          tglx@linutronix.de, acme@redhat.com, peterz@infradead.org,
          alexander.shishkin@linux.intel.com, mingo@kernel.org
In-Reply-To: <20180830063252.23729-39-jolsa@kernel.org>
References: <20180830063252.23729-39-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf stat: Move 'big_num' data to 'struct
 perf_stat_config'
Git-Commit-ID: 34ff0866d46ae206de884f54e7235f57096e5588
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

Commit-ID:  34ff0866d46ae206de884f54e7235f57096e5588
Gitweb:     https://git.kernel.org/tip/34ff0866d46ae206de884f54e7235f57096e5588
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Thu, 30 Aug 2018 08:32:47 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 30 Aug 2018 15:52:24 -0300

perf stat: Move 'big_num' data to 'struct perf_stat_config'

Move the static variable 'big_num' to 'struct perf_stat_config', so that
it can be passed around and used outside 'perf stat' command.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180830063252.23729-39-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 8 ++++----
 tools/perf/util/stat.h    | 1 +
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 445673f688de..8ca85017a973 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -151,7 +151,6 @@ static bool			transaction_run;
 static bool			topdown_run			= false;
 static bool			smi_cost			= false;
 static bool			smi_reset			= false;
-static bool			big_num				=  true;
 static int			big_num_opt			=  -1;
 static bool			group				= false;
 static const char		*pre_cmd			= NULL;
@@ -192,6 +191,7 @@ static struct perf_stat_config stat_config = {
 	.run_count		= 1,
 	.metric_only_len	= METRIC_ONLY_LEN,
 	.walltime_nsecs_stats	= &walltime_nsecs_stats,
+	.big_num		= true,
 };
 
 static bool is_duration_time(struct perf_evsel *evsel)
@@ -945,7 +945,7 @@ static void abs_printout(struct perf_stat_config *config,
 	if (config->csv_output) {
 		fmt = floor(sc) != sc ?  "%.2f%s" : "%.0f%s";
 	} else {
-		if (big_num)
+		if (config->big_num)
 			fmt = floor(sc) != sc ? "%'18.2f%s" : "%'18.0f%s";
 		else
 			fmt = floor(sc) != sc ? "%18.2f%s" : "%18.0f%s";
@@ -2847,9 +2847,9 @@ int cmd_stat(int argc, const char **argv)
 			parse_options_usage(NULL, stat_options, "x", 1);
 			goto out;
 		} else /* Nope, so disable big number formatting */
-			big_num = false;
+			stat_config.big_num = false;
 	} else if (big_num_opt == 0) /* User passed --no-big-num */
-		big_num = false;
+		stat_config.big_num = false;
 
 	setup_system_wide(argc);
 
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index be202b066e62..843672214cca 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -103,6 +103,7 @@ struct perf_stat_config {
 	bool			 metric_only;
 	bool			 null_run;
 	bool			 ru_display;
+	bool			 big_num;
 	FILE			*output;
 	unsigned int		 interval;
 	unsigned int		 timeout;
