Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF4B9C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F5432064D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:39:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F5432064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729762AbeIFSOp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 14:14:45 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44421 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729506AbeIFSOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 14:14:45 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w86DckS9309763
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 6 Sep 2018 06:38:46 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w86DckEq309760;
        Thu, 6 Sep 2018 06:38:46 -0700
Date:   Thu, 6 Sep 2018 06:38:46 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-31084123c1962dd4235655c1839a50c9cf6c709b@git.kernel.org>
Cc:     dsahern@gmail.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, peterz@infradead.org, acme@redhat.com,
        andi@firstfloor.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, hpa@zytor.com, namhyung@kernel.org,
        mingo@kernel.org
Reply-To: mingo@kernel.org, hpa@zytor.com, namhyung@kernel.org,
          tglx@linutronix.de, linux-kernel@vger.kernel.org,
          acme@redhat.com, andi@firstfloor.org, jolsa@kernel.org,
          peterz@infradead.org, alexander.shishkin@linux.intel.com,
          dsahern@gmail.com
In-Reply-To: <20180830063252.23729-34-jolsa@kernel.org>
References: <20180830063252.23729-34-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf stat: Move 'print_free_counters_hint' to
 'struct perf_stat_config'
Git-Commit-ID: 31084123c1962dd4235655c1839a50c9cf6c709b
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

Commit-ID:  31084123c1962dd4235655c1839a50c9cf6c709b
Gitweb:     https://git.kernel.org/tip/31084123c1962dd4235655c1839a50c9cf6c709b
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Thu, 30 Aug 2018 08:32:42 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 30 Aug 2018 15:52:24 -0300

perf stat: Move 'print_free_counters_hint' to 'struct perf_stat_config'

Move the 'print_free_counters_hint' variable to 'struct perf_stat_config',
so that it can be passed around and used outside the 'perf stat' command.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180830063252.23729-34-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 5 ++---
 tools/perf/util/stat.h    | 1 +
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 844c755564e3..8748bb5e5403 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -170,7 +170,6 @@ static bool			append_file;
 static bool			interval_count;
 static const char		*output_name;
 static int			output_fd;
-static int			print_free_counters_hint;
 static int			print_mixed_hw_group_error;
 static u64			*walltime_run;
 static bool			ru_display			= false;
@@ -1051,7 +1050,7 @@ static void printout(struct perf_stat_config *config, int id, int nr,
 			config->csv_sep);
 
 		if (counter->supported) {
-			print_free_counters_hint = 1;
+			config->print_free_counters_hint = 1;
 			if (is_mixed_hw_group(counter))
 				print_mixed_hw_group_error = 1;
 		}
@@ -1707,7 +1706,7 @@ static void print_footer(struct perf_stat_config *config)
 	}
 	fprintf(output, "\n\n");
 
-	if (print_free_counters_hint &&
+	if (config->print_free_counters_hint &&
 	    sysctl__read_int("kernel/nmi_watchdog", &n) >= 0 &&
 	    n > 0)
 		fprintf(output,
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index c198926c0e27..8cad17363e90 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -103,6 +103,7 @@ struct perf_stat_config {
 	unsigned int		 metric_only_len;
 	int			 times;
 	int			 run_count;
+	int			 print_free_counters_hint;
 	struct runtime_stat	*stats;
 	int			 stats_num;
 	const char		*csv_sep;
