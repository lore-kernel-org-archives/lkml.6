Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09310C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 995072064D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:39:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 995072064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729773AbeIFSPS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 14:15:18 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56211 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729468AbeIFSPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 14:15:18 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w86DdL5e309990
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 6 Sep 2018 06:39:21 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w86DdKea309987;
        Thu, 6 Sep 2018 06:39:20 -0700
Date:   Thu, 6 Sep 2018 06:39:20 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-3b3cd9a41c2b5d97309099ba6eae69b2d3177226@git.kernel.org>
Cc:     hpa@zytor.com, jolsa@kernel.org, andi@firstfloor.org,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        dsahern@gmail.com, tglx@linutronix.de, acme@redhat.com,
        mingo@kernel.org
Reply-To: acme@redhat.com, mingo@kernel.org, tglx@linutronix.de,
          dsahern@gmail.com, peterz@infradead.org,
          linux-kernel@vger.kernel.org, namhyung@kernel.org,
          alexander.shishkin@linux.intel.com, andi@firstfloor.org,
          jolsa@kernel.org, hpa@zytor.com
In-Reply-To: <20180830063252.23729-35-jolsa@kernel.org>
References: <20180830063252.23729-35-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf stat: Move 'print_mixed_hw_group_error' to
 'struct perf_stat_config'
Git-Commit-ID: 3b3cd9a41c2b5d97309099ba6eae69b2d3177226
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

Commit-ID:  3b3cd9a41c2b5d97309099ba6eae69b2d3177226
Gitweb:     https://git.kernel.org/tip/3b3cd9a41c2b5d97309099ba6eae69b2d3177226
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Thu, 30 Aug 2018 08:32:43 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 30 Aug 2018 15:52:24 -0300

perf stat: Move 'print_mixed_hw_group_error' to 'struct perf_stat_config'

Move the 'print_mixed_hw_group_error' global variable to 'struct perf_stat_config',
so that it can be passed around and used outside the 'perf stat' command.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180830063252.23729-35-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 5 ++---
 tools/perf/util/stat.h    | 1 +
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 8748bb5e5403..f61c2dc8c7e8 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -170,7 +170,6 @@ static bool			append_file;
 static bool			interval_count;
 static const char		*output_name;
 static int			output_fd;
-static int			print_mixed_hw_group_error;
 static u64			*walltime_run;
 static bool			ru_display			= false;
 static struct rusage		ru_data;
@@ -1052,7 +1051,7 @@ static void printout(struct perf_stat_config *config, int id, int nr,
 		if (counter->supported) {
 			config->print_free_counters_hint = 1;
 			if (is_mixed_hw_group(counter))
-				print_mixed_hw_group_error = 1;
+				config->print_mixed_hw_group_error = 1;
 		}
 
 		fprintf(config->output, "%-*s%s",
@@ -1715,7 +1714,7 @@ static void print_footer(struct perf_stat_config *config)
 "	perf stat ...\n"
 "	echo 1 > /proc/sys/kernel/nmi_watchdog\n");
 
-	if (print_mixed_hw_group_error)
+	if (config->print_mixed_hw_group_error)
 		fprintf(output,
 			"The events in group usually have to be from "
 			"the same PMU. Try reorganizing the group.\n");
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 8cad17363e90..6fb4dac26ccc 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -104,6 +104,7 @@ struct perf_stat_config {
 	int			 times;
 	int			 run_count;
 	int			 print_free_counters_hint;
+	int			 print_mixed_hw_group_error;
 	struct runtime_stat	*stats;
 	int			 stats_num;
 	const char		*csv_sep;
