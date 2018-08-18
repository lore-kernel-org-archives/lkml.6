Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E98C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB3212146E
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:28:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB3212146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbeHROfe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 10:35:34 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44551 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbeHROfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 10:35:34 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w7IBRpTc1285921
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 18 Aug 2018 04:27:51 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w7IBRoi81285918;
        Sat, 18 Aug 2018 04:27:50 -0700
Date:   Sat, 18 Aug 2018 04:27:50 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-0440af74dcd0f32b134b1c4d47dc25f0bb539ded@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, jolsa@kernel.org, eranian@google.com,
        acme@redhat.com, alexander.shishkin@linux.intel.com,
        peterz@infradead.org, dsahern@gmail.com, mingo@kernel.org,
        namhyung@kernel.org, tglx@linutronix.de, hpa@zytor.com
Reply-To: tglx@linutronix.de, hpa@zytor.com, dsahern@gmail.com,
          peterz@infradead.org, namhyung@kernel.org, mingo@kernel.org,
          jolsa@kernel.org, eranian@google.com,
          alexander.shishkin@linux.intel.com, acme@redhat.com,
          linux-kernel@vger.kernel.org
In-Reply-To: <20180804130521.11408-6-jolsa@kernel.org>
References: <20180804130521.11408-6-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf annotate: Rename local sample variables to
 data
Git-Commit-ID: 0440af74dcd0f32b134b1c4d47dc25f0bb539ded
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

Commit-ID:  0440af74dcd0f32b134b1c4d47dc25f0bb539ded
Gitweb:     https://git.kernel.org/tip/0440af74dcd0f32b134b1c4d47dc25f0bb539ded
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Sat, 4 Aug 2018 15:05:06 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 8 Aug 2018 15:55:47 -0300

perf annotate: Rename local sample variables to data

Based on previous rename, changing also the local variable names to fit
properly.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20180804130521.11408-6-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index e4cb8963db1a..8bd278a71004 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1310,10 +1310,10 @@ annotation_line__print(struct annotation_line *al, struct symbol *sym, u64 start
 		struct annotation *notes = symbol__annotation(sym);
 
 		for (i = 0; i < al->data_nr; i++) {
-			struct annotation_data *sample = &al->data[i];
+			struct annotation_data *data = &al->data[i];
 
-			if (sample->percent > max_percent)
-				max_percent = sample->percent;
+			if (data->percent > max_percent)
+				max_percent = data->percent;
 		}
 
 		if (al->data_nr > nr_percent)
@@ -1351,18 +1351,18 @@ annotation_line__print(struct annotation_line *al, struct symbol *sym, u64 start
 		}
 
 		for (i = 0; i < nr_percent; i++) {
-			struct annotation_data *sample = &al->data[i];
+			struct annotation_data *data = &al->data[i];
 
-			color = get_percent_color(sample->percent);
+			color = get_percent_color(data->percent);
 
 			if (symbol_conf.show_total_period)
 				color_fprintf(stdout, color, " %11" PRIu64,
-					      sample->he.period);
+					      data->he.period);
 			else if (symbol_conf.show_nr_samples)
 				color_fprintf(stdout, color, " %7" PRIu64,
-					      sample->he.nr_samples);
+					      data->he.nr_samples);
 			else
-				color_fprintf(stdout, color, " %7.2f", sample->percent);
+				color_fprintf(stdout, color, " %7.2f", data->percent);
 		}
 
 		printf(" : ");
@@ -1754,7 +1754,7 @@ out_close_stdout:
 }
 
 static void calc_percent(struct sym_hist *hist,
-			 struct annotation_data *sample,
+			 struct annotation_data *data,
 			 s64 offset, s64 end)
 {
 	unsigned int hits = 0;
@@ -1767,9 +1767,9 @@ static void calc_percent(struct sym_hist *hist,
 	}
 
 	if (hist->nr_samples) {
-		sample->he.period     = period;
-		sample->he.nr_samples = hits;
-		sample->percent = 100.0 * hits / hist->nr_samples;
+		data->he.period     = period;
+		data->he.nr_samples = hits;
+		data->percent = 100.0 * hits / hist->nr_samples;
 	}
 }
 
@@ -1789,13 +1789,13 @@ static void annotation__calc_percent(struct annotation *notes,
 		end  = next ? next->offset : len;
 
 		for (i = 0; i < al->data_nr; i++) {
-			struct annotation_data *sample;
+			struct annotation_data *data;
 			struct sym_hist *hist;
 
-			hist   = annotation__histogram(notes, evsel->idx + i);
-			sample = &al->data[i];
+			hist = annotation__histogram(notes, evsel->idx + i);
+			data = &al->data[i];
 
-			calc_percent(hist, sample, al->offset, end);
+			calc_percent(hist, data, al->offset, end);
 		}
 	}
 }
@@ -2356,12 +2356,12 @@ static void annotation__calc_lines(struct annotation *notes, struct map *map,
 		int i;
 
 		for (i = 0; i < al->data_nr; i++) {
-			struct annotation_data *sample;
+			struct annotation_data *data;
 
-			sample = &al->data[i];
+			data = &al->data[i];
 
-			if (sample->percent > percent_max)
-				percent_max = sample->percent;
+			if (data->percent > percent_max)
+				percent_max = data->percent;
 		}
 
 		if (percent_max <= 0.5)
