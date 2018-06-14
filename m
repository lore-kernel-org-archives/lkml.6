Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 7FF51C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 06:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35183208D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 06:23:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35183208D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754690AbeFNGXb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 02:23:31 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56253 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752781AbeFNGX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 02:23:27 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5E6MmgE763831
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 13 Jun 2018 23:22:48 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5E6MmCV763828;
        Wed, 13 Jun 2018 23:22:48 -0700
Date:   Wed, 13 Jun 2018 23:22:48 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-f515572734fb323aa0efe9ea2c546cd7fee327f7@git.kernel.org>
Cc:     jolsa@kernel.org, mingo@kernel.org, namhyung@kernel.org,
        hpa@zytor.com, tglx@linutronix.de,
        alexander.shishkin@linux.intel.com, dsahern@gmail.com,
        linux-kernel@vger.kernel.org, andi@firstfloor.org, acme@redhat.com,
        eranian@google.com, milian.wolff@kdab.com, frederic@kernel.org,
        peterz@infradead.org
Reply-To: linux-kernel@vger.kernel.org, frederic@kernel.org,
          milian.wolff@kdab.com, eranian@google.com, andi@firstfloor.org,
          acme@redhat.com, peterz@infradead.org, mingo@kernel.org,
          jolsa@kernel.org, namhyung@kernel.org, tglx@linutronix.de,
          hpa@zytor.com, dsahern@gmail.com,
          alexander.shishkin@linux.intel.com
In-Reply-To: <20180606221513.11302-6-jolsa@kernel.org>
References: <20180606221513.11302-6-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf stat: Fix metric column header display
 alignment
Git-Commit-ID: f515572734fb323aa0efe9ea2c546cd7fee327f7
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

Commit-ID:  f515572734fb323aa0efe9ea2c546cd7fee327f7
Gitweb:     https://git.kernel.org/tip/f515572734fb323aa0efe9ea2c546cd7fee327f7
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Thu, 7 Jun 2018 00:15:08 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 7 Jun 2018 15:59:13 -0300

perf stat: Fix metric column header display alignment

Make the metric only display aligned.

Before:
  # perf stat --topdown -I 1000
  #           time core         cpus retiring             bad speculation      frontend bound       backend bound
       1.000394323 S0-C0           2     37.4%               12.0%               31.4%               19.2%
       1.000394323 S0-C1           2     25.1%                9.2%               43.8%               21.9%
       2.001521204 S0-C0           2     36.4%               11.4%               32.4%               19.8%
       2.001521204 S0-C1           2     26.2%                9.4%               43.1%               21.3%
       3.001930208 S0-C0           2     35.1%               10.7%               33.6%               20.6%
       3.001930208 S0-C1           2     28.9%               10.0%               40.0%               21.1%

After:
  # perf stat --topdown -I 1000
  #           time core         cpus             retiring      bad speculation       frontend bound        backend bound
       1.000303722 S0-C0           2                34.2%                 7.6%                34.2%                24.0%
       1.000303722 S0-C1           2                33.1%                 6.4%                36.9%                23.6%
       2.001281055 S0-C0           2                34.6%                 6.7%                36.8%                21.8%
       2.001281055 S0-C1           2                32.8%                 7.1%                38.1%                22.0%
       3.001546080 S0-C0           2                39.3%                 5.5%                32.7%                22.5%
       3.001546080 S0-C1           2                37.8%                 6.0%                33.1%                23.1%

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
Link: http://lkml.kernel.org/r/20180606221513.11302-6-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 9e7b6f108956..8f3fdc052728 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1001,19 +1001,20 @@ static void print_metric_only(void *ctx, const char *color, const char *fmt,
 {
 	struct outstate *os = ctx;
 	FILE *out = os->fh;
-	int n;
-	char buf[1024];
+	char buf[1024], str[1024];
 	unsigned mlen = METRIC_ONLY_LEN;
 
 	if (!valid_only_metric(unit))
 		return;
 	unit = fixunit(buf, os->evsel, unit);
-	n = color_fprintf(out, color ?: "", fmt, val);
-	if (n > METRIC_ONLY_LEN)
-		n = METRIC_ONLY_LEN;
 	if (mlen < strlen(unit))
 		mlen = strlen(unit) + 1;
-	fprintf(out, "%*s", mlen - n, "");
+
+	if (color)
+		mlen += strlen(color) + sizeof(PERF_COLOR_RESET) - 1;
+
+	color_snprintf(str, sizeof(str), color ?: "", fmt, val);
+	fprintf(out, "%*s ", mlen, str);
 }
 
 static void print_metric_only_csv(void *ctx, const char *color __maybe_unused,
@@ -1053,7 +1054,7 @@ static void print_metric_header(void *ctx, const char *color __maybe_unused,
 	if (csv_output)
 		fprintf(os->fh, "%s%s", unit, csv_sep);
 	else
-		fprintf(os->fh, "%-*s ", METRIC_ONLY_LEN, unit);
+		fprintf(os->fh, "%*s ", METRIC_ONLY_LEN, unit);
 }
 
 static void nsec_printout(int id, int nr, struct perf_evsel *evsel, double avg)
@@ -1721,7 +1722,7 @@ static void print_interval(char *prefix, struct timespec *ts)
 				fprintf(output, "             counts %*s events\n", unit_width, "unit");
 			break;
 		case AGGR_NONE:
-			fprintf(output, "#           time CPU");
+			fprintf(output, "#           time CPU    ");
 			if (!metric_only)
 				fprintf(output, "                counts %*s events\n", unit_width, "unit");
 			break;
