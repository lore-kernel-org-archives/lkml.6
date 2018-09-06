Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 288D0C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D22B32064D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:36:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D22B32064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729654AbeIFSLy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 14:11:54 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51639 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727708AbeIFSLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 14:11:54 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w86DZq4x309356
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 6 Sep 2018 06:35:52 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w86DZqrU309353;
        Thu, 6 Sep 2018 06:35:52 -0700
Date:   Thu, 6 Sep 2018 06:35:52 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-ee1760e2cf623bc6834fc3e4e89c6ad030a25dfd@git.kernel.org>
Cc:     andi@firstfloor.org, mingo@kernel.org, namhyung@kernel.org,
        alexander.shishkin@linux.intel.com, acme@redhat.com,
        jolsa@kernel.org, tglx@linutronix.de, hpa@zytor.com,
        dsahern@gmail.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org
Reply-To: peterz@infradead.org, linux-kernel@vger.kernel.org,
          dsahern@gmail.com, hpa@zytor.com, tglx@linutronix.de,
          jolsa@kernel.org, alexander.shishkin@linux.intel.com,
          acme@redhat.com, andi@firstfloor.org, mingo@kernel.org,
          namhyung@kernel.org
In-Reply-To: <20180830063252.23729-29-jolsa@kernel.org>
References: <20180830063252.23729-29-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf stat: Move 'metric_only_len' to 'struct
 perf_stat_config'
Git-Commit-ID: ee1760e2cf623bc6834fc3e4e89c6ad030a25dfd
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

Commit-ID:  ee1760e2cf623bc6834fc3e4e89c6ad030a25dfd
Gitweb:     https://git.kernel.org/tip/ee1760e2cf623bc6834fc3e4e89c6ad030a25dfd
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Thu, 30 Aug 2018 08:32:37 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 30 Aug 2018 15:52:23 -0300

perf stat: Move 'metric_only_len' to 'struct perf_stat_config'

Move the static 'metric_only_len' variable to 'struct perf_stat_config',
so that it can be passed around and used outside the 'perf stat' command.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180830063252.23729-29-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 10 +++++-----
 tools/perf/util/stat.h    |  1 +
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 1276596840c9..e96cef526ef0 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -176,7 +176,6 @@ static int			print_mixed_hw_group_error;
 static u64			*walltime_run;
 static bool			ru_display			= false;
 static struct rusage		ru_data;
-static unsigned int		metric_only_len			= METRIC_ONLY_LEN;
 
 struct perf_stat {
 	bool			 record;
@@ -200,6 +199,7 @@ static struct perf_stat_config stat_config = {
 	.scale		= true,
 	.unit_width	= 4, /* strlen("unit") */
 	.run_count	= 1,
+	.metric_only_len = METRIC_ONLY_LEN,
 };
 
 static bool is_duration_time(struct perf_evsel *evsel)
@@ -854,14 +854,14 @@ static const char *fixunit(char *buf, struct perf_evsel *evsel,
 	return unit;
 }
 
-static void print_metric_only(struct perf_stat_config *config __maybe_unused,
+static void print_metric_only(struct perf_stat_config *config,
 			      void *ctx, const char *color, const char *fmt,
 			      const char *unit, double val)
 {
 	struct outstate *os = ctx;
 	FILE *out = os->fh;
 	char buf[1024], str[1024];
-	unsigned mlen = metric_only_len;
+	unsigned mlen = config->metric_only_len;
 
 	if (!valid_only_metric(unit))
 		return;
@@ -902,7 +902,7 @@ static void new_line_metric(struct perf_stat_config *config __maybe_unused,
 {
 }
 
-static void print_metric_header(struct perf_stat_config *config __maybe_unused,
+static void print_metric_header(struct perf_stat_config *config,
 				void *ctx, const char *color __maybe_unused,
 				const char *fmt __maybe_unused,
 				const char *unit, double val __maybe_unused)
@@ -916,7 +916,7 @@ static void print_metric_header(struct perf_stat_config *config __maybe_unused,
 	if (config->csv_output)
 		fprintf(os->fh, "%s%s", unit, config->csv_sep);
 	else
-		fprintf(os->fh, "%*s ", metric_only_len, unit);
+		fprintf(os->fh, "%*s ", config->metric_only_len, unit);
 }
 
 static int first_shadow_cpu(struct perf_evsel *evsel, int id)
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 351a36f5f5b0..e70e6d93ee1b 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -99,6 +99,7 @@ struct perf_stat_config {
 	unsigned int		 timeout;
 	unsigned int		 initial_delay;
 	unsigned int		 unit_width;
+	unsigned int		 metric_only_len;
 	int			 times;
 	int			 run_count;
 	struct runtime_stat	*stats;
