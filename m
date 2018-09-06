Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 341C3C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB1E0206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:45:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB1E0206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729888AbeIFSUl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 14:20:41 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54731 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729233AbeIFSUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 14:20:41 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w86Dhf0t310556
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 6 Sep 2018 06:43:41 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w86DhfV3310552;
        Thu, 6 Sep 2018 06:43:41 -0700
Date:   Thu, 6 Sep 2018 06:43:41 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-d0192fdba09a8901db133fe5a1fcd22d40fcf545@git.kernel.org>
Cc:     dsahern@gmail.com, jolsa@kernel.org, mingo@kernel.org,
        andi@firstfloor.org, acme@redhat.com, namhyung@kernel.org,
        alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
        hpa@zytor.com, tglx@linutronix.de, peterz@infradead.org
Reply-To: hpa@zytor.com, namhyung@kernel.org, linux-kernel@vger.kernel.org,
          alexander.shishkin@linux.intel.com, peterz@infradead.org,
          tglx@linutronix.de, jolsa@kernel.org, mingo@kernel.org,
          andi@firstfloor.org, dsahern@gmail.com, acme@redhat.com
In-Reply-To: <20180830063252.23729-43-jolsa@kernel.org>
References: <20180830063252.23729-43-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf stat: Move 'metric_events' to 'struct
 perf_stat_config'
Git-Commit-ID: d0192fdba09a8901db133fe5a1fcd22d40fcf545
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

Commit-ID:  d0192fdba09a8901db133fe5a1fcd22d40fcf545
Gitweb:     https://git.kernel.org/tip/d0192fdba09a8901db133fe5a1fcd22d40fcf545
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Thu, 30 Aug 2018 08:32:51 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 30 Aug 2018 15:52:25 -0300

perf stat: Move 'metric_events' to 'struct perf_stat_config'

Move the static variable 'metric_events' to 'struct perf_stat_config',
so that it can be passed around and used outside 'perf stat' command.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180830063252.23729-43-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 10 ++++------
 tools/perf/util/stat.h    |  1 +
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 8a4979748cbb..f4ddedc8619b 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -137,8 +137,6 @@ static const char *smi_cost_attrs = {
 
 static struct perf_evlist	*evsel_list;
 
-static struct rblist		 metric_events;
-
 static struct target target = {
 	.uid	= UINT_MAX,
 };
@@ -1082,7 +1080,7 @@ static void printout(struct perf_stat_config *config, int id, int nr,
 
 	perf_stat__print_shadow_stats(config, counter, uval,
 				first_shadow_cpu(config, counter, id),
-				&out, &metric_events, st);
+				&out, &config->metric_events, st);
 	if (!config->csv_output && !config->metric_only) {
 		print_noise(config, counter, noise);
 		print_running(config, run, ena);
@@ -1533,7 +1531,7 @@ static void print_metric_headers(struct perf_stat_config *config,
 		perf_stat__print_shadow_stats(config, counter, 0,
 					      0,
 					      &out,
-					      &metric_events,
+					      &config->metric_events,
 					      &rt_stat);
 	}
 	fputc('\n', config->output);
@@ -1860,7 +1858,7 @@ static int parse_metric_groups(const struct option *opt,
 			       const char *str,
 			       int unset __maybe_unused)
 {
-	return metricgroup__parse_groups(opt, str, &metric_events);
+	return metricgroup__parse_groups(opt, str, &stat_config.metric_events);
 }
 
 static const struct option stat_options[] = {
@@ -2321,7 +2319,7 @@ static int add_default_attributes(void)
 			struct option opt = { .value = &evsel_list };
 
 			return metricgroup__parse_groups(&opt, "transaction",
-							 &metric_events);
+							 &stat_config.metric_events);
 		}
 
 		if (pmu_have_event("cpu", "cycles-ct") &&
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 5193cbf6e4c6..8d3354e21e19 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -125,6 +125,7 @@ struct perf_stat_config {
 	aggr_get_id_t		 aggr_get_id;
 	struct cpu_map		*cpus_aggr_map;
 	u64			*walltime_run;
+	struct rblist		 metric_events;
 };
 
 void update_stats(struct stats *stats, u64 val);
