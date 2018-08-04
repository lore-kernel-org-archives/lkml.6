Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A265EC4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 13:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D8F8217FE
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 13:05:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D8F8217FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729743AbeHDPGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 11:06:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50464 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726753AbeHDPGM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 11:06:12 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8D27040704AF;
        Sat,  4 Aug 2018 13:05:32 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.198])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1CB72215670D;
        Sat,  4 Aug 2018 13:05:30 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Stephane Eranian <eranian@google.com>
Subject: [PATCH 05/20] perf annotate: Rename local sample variables to data
Date:   Sat,  4 Aug 2018 15:05:06 +0200
Message-Id: <20180804130521.11408-6-jolsa@kernel.org>
In-Reply-To: <20180804130521.11408-1-jolsa@kernel.org>
References: <20180804130521.11408-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Sat, 04 Aug 2018 13:05:32 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Sat, 04 Aug 2018 13:05:32 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@kernel.org' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on previous rename, changing also the local
variable names to fit properly.

Link: http://lkml.kernel.org/n/tip-5hjxeetp2v8c3n0zbttlki2j@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/annotate.c | 40 +++++++++++++++++++-------------------
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
@@ -1754,7 +1754,7 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
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
-- 
2.17.1

