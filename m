Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B6EC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 347FB206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:42:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 347FB206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729814AbeIFSSD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 14:18:03 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58117 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729574AbeIFSSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 14:18:02 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w86Dg3pJ310379
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 6 Sep 2018 06:42:03 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w86Dg3fn310376;
        Thu, 6 Sep 2018 06:42:03 -0700
Date:   Thu, 6 Sep 2018 06:42:03 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-fdee335b00b0807e8d65b8e3d81214556f07bed3@git.kernel.org>
Cc:     jolsa@kernel.org, dsahern@gmail.com,
        alexander.shishkin@linux.intel.com, mingo@kernel.org,
        peterz@infradead.org, tglx@linutronix.de, andi@firstfloor.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com, acme@redhat.com,
        namhyung@kernel.org
Reply-To: tglx@linutronix.de, mingo@kernel.org, peterz@infradead.org,
          dsahern@gmail.com, alexander.shishkin@linux.intel.com,
          jolsa@kernel.org, namhyung@kernel.org, acme@redhat.com,
          linux-kernel@vger.kernel.org, andi@firstfloor.org, hpa@zytor.com
In-Reply-To: <20180830063252.23729-40-jolsa@kernel.org>
References: <20180830063252.23729-40-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf stat: Move 'no_merge' data to 'struct
 perf_stat_config'
Git-Commit-ID: fdee335b00b0807e8d65b8e3d81214556f07bed3
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

Commit-ID:  fdee335b00b0807e8d65b8e3d81214556f07bed3
Gitweb:     https://git.kernel.org/tip/fdee335b00b0807e8d65b8e3d81214556f07bed3
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Thu, 30 Aug 2018 08:32:48 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 30 Aug 2018 15:52:24 -0300

perf stat: Move 'no_merge' data to 'struct perf_stat_config'

Move the static variable 'no_merge' to 'struct perf_stat_config', so
that it can be passed around and used outside 'perf stat' command.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180830063252.23729-40-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 5 ++---
 tools/perf/util/stat.h    | 1 +
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 8ca85017a973..c4df076f1e54 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -158,7 +158,6 @@ static const char		*post_cmd			= NULL;
 static bool			sync_run			= false;
 static bool			forever				= false;
 static bool			force_metric_only		= false;
-static bool			no_merge			= false;
 static bool			walltime_run_table		= false;
 static struct timespec		ref_time;
 static bool			append_file;
@@ -1173,7 +1172,7 @@ static bool collect_data(struct perf_stat_config *config, struct perf_evsel *cou
 	if (counter->merged_stat)
 		return false;
 	cb(config, counter, data, true);
-	if (no_merge)
+	if (config->no_merge)
 		uniquify_event_name(counter);
 	else if (counter->auto_merge_stats)
 		collect_all_aliases(config, counter, cb, data);
@@ -1902,7 +1901,7 @@ static const struct option stat_options[] = {
 		    "list of cpus to monitor in system-wide"),
 	OPT_SET_UINT('A', "no-aggr", &stat_config.aggr_mode,
 		    "disable CPU count aggregation", AGGR_NONE),
-	OPT_BOOLEAN(0, "no-merge", &no_merge, "Do not merge identical named events"),
+	OPT_BOOLEAN(0, "no-merge", &stat_config.no_merge, "Do not merge identical named events"),
 	OPT_STRING('x', "field-separator", &stat_config.csv_sep, "separator",
 		   "print counts with custom separator"),
 	OPT_CALLBACK('G', "cgroup", &evsel_list, "name",
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 843672214cca..0758107fe56f 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -104,6 +104,7 @@ struct perf_stat_config {
 	bool			 null_run;
 	bool			 ru_display;
 	bool			 big_num;
+	bool			 no_merge;
 	FILE			*output;
 	unsigned int		 interval;
 	unsigned int		 timeout;
