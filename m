Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 92447C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 06:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51478208D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 06:23:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51478208D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754712AbeFNGXu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 02:23:50 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38987 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752892AbeFNGXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 02:23:47 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5E6NJOZ763861
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 13 Jun 2018 23:23:19 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5E6NJVK763858;
        Wed, 13 Jun 2018 23:23:19 -0700
Date:   Wed, 13 Jun 2018 23:23:19 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-c1a1f5d9da800dc715d8c1d8a9692c63c70c2955@git.kernel.org>
Cc:     tglx@linutronix.de, peterz@infradead.org, hpa@zytor.com,
        alexander.shishkin@linux.intel.com, milian.wolff@kdab.com,
        andi@firstfloor.org, acme@redhat.com, linux-kernel@vger.kernel.org,
        eranian@google.com, jolsa@kernel.org, frederic@kernel.org,
        namhyung@kernel.org, mingo@kernel.org, dsahern@gmail.com
Reply-To: linux-kernel@vger.kernel.org, frederic@kernel.org,
          jolsa@kernel.org, eranian@google.com, acme@redhat.com,
          dsahern@gmail.com, namhyung@kernel.org, mingo@kernel.org,
          milian.wolff@kdab.com, andi@firstfloor.org, hpa@zytor.com,
          alexander.shishkin@linux.intel.com, tglx@linutronix.de,
          peterz@infradead.org
In-Reply-To: <20180606221513.11302-7-jolsa@kernel.org>
References: <20180606221513.11302-7-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf stat: Allow to specify specific metric
 column len
Git-Commit-ID: c1a1f5d9da800dc715d8c1d8a9692c63c70c2955
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

Commit-ID:  c1a1f5d9da800dc715d8c1d8a9692c63c70c2955
Gitweb:     https://git.kernel.org/tip/c1a1f5d9da800dc715d8c1d8a9692c63c70c2955
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Thu, 7 Jun 2018 00:15:09 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 7 Jun 2018 16:01:44 -0300

perf stat: Allow to specify specific metric column len

The following change will introduce new metrics, that doesn't need such
wide hard coded spacing. Switch METRIC_ONLY_LEN macro usage with
metric_only_len variable.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Milian Wolff <milian.wolff@kdab.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20180606221513.11302-7-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 8f3fdc052728..3fc1f5286d50 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -145,6 +145,8 @@ static struct target target = {
 
 typedef int (*aggr_get_id_t)(struct cpu_map *m, int cpu);
 
+#define METRIC_ONLY_LEN 20
+
 static int			run_count			=  1;
 static bool			no_inherit			= false;
 static volatile pid_t		child_pid			= -1;
@@ -182,6 +184,7 @@ static int			print_mixed_hw_group_error;
 static u64			*walltime_run;
 static bool			ru_display			= false;
 static struct rusage		ru_data;
+static unsigned int		metric_only_len			= METRIC_ONLY_LEN;
 
 struct perf_stat {
 	bool			 record;
@@ -969,8 +972,6 @@ static void print_metric_csv(void *ctx,
 	fprintf(out, "%s%s%s%s", csv_sep, vals, csv_sep, unit);
 }
 
-#define METRIC_ONLY_LEN 20
-
 /* Filter out some columns that don't work well in metrics only mode */
 
 static bool valid_only_metric(const char *unit)
@@ -1002,7 +1003,7 @@ static void print_metric_only(void *ctx, const char *color, const char *fmt,
 	struct outstate *os = ctx;
 	FILE *out = os->fh;
 	char buf[1024], str[1024];
-	unsigned mlen = METRIC_ONLY_LEN;
+	unsigned mlen = metric_only_len;
 
 	if (!valid_only_metric(unit))
 		return;
@@ -1054,7 +1055,7 @@ static void print_metric_header(void *ctx, const char *color __maybe_unused,
 	if (csv_output)
 		fprintf(os->fh, "%s%s", unit, csv_sep);
 	else
-		fprintf(os->fh, "%*s ", METRIC_ONLY_LEN, unit);
+		fprintf(os->fh, "%*s ", metric_only_len, unit);
 }
 
 static void nsec_printout(int id, int nr, struct perf_evsel *evsel, double avg)
