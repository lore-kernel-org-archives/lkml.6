Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE1D0C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6769A21E21
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:00:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UcKfjPqa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6769A21E21
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732847AbeHIRZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 13:25:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:36926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732116AbeHIRZO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 13:25:14 -0400
Received: from jouet.infradead.org (179-240-153-38.3g.claro.net.br [179.240.153.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75D1821D62;
        Thu,  9 Aug 2018 14:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533826797;
        bh=xm6lFCWGE4K3HvRfkeGaSV9L+zCRS1zUr2zUDiNI6yM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UcKfjPqauD4yQ2jrTgio/yH4/D4Om9OzCnNM4nAdtwYup+8BJ6H2PDUAh3heZhxhb
         xk0+XEca79j6BRfDTYZv1P+vgEEVjHEmyY8/RRmft3PyebUbgdQC2F437iqM8yseoq
         twIC0OzYQatLNlZEpZfWKmAeCmYCga93rs0rGRqA=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        David Ahern <dsahern@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 17/44] perf annotate: Rename local sample variables to data
Date:   Thu,  9 Aug 2018 11:57:55 -0300
Message-Id: <20180809145822.21391-18-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180809145822.21391-1-acme@kernel.org>
References: <20180809145822.21391-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

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
2.14.4

