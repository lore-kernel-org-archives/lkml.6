Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52959C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 14:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04CF821DEC
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 14:59:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AwdGEHfU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04CF821DEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732823AbeHIRZJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 13:25:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:36852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732116AbeHIRZJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 13:25:09 -0400
Received: from jouet.infradead.org (179-240-153-38.3g.claro.net.br [179.240.153.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B44792183D;
        Thu,  9 Aug 2018 14:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533826792;
        bh=icYW75KZLNPp/voNNWVfTs6JblV7EA4iZj7z0+DmpqA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AwdGEHfU9Nv7hjJ/rvOMsRJc3QFqBQY2MFWhZbYP2tWuoCHhVyviqQBhWJAJcw1mm
         FvlWtbCKXpcUkWxE73e43O8m6pyLiVt4IssKWEmgkNJQBE6Tm8kwOLTg2hiPGIym8X
         rugewdfWX5Ubc28z2SKD1LzMUd4X+IVPChrlEj1A=
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
Subject: [PATCH 16/44] perf annotate: Rename struct annotation_line::samples* to data*
Date:   Thu,  9 Aug 2018 11:57:54 -0300
Message-Id: <20180809145822.21391-17-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180809145822.21391-1-acme@kernel.org>
References: <20180809145822.21391-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

The name 'samples*' is little confusing because we have nested 'struct
sym_hist_entry' under annotation_line struct, which holds 'nr_samples'
as well.

Also the holding struct name is 'annotation_data' so the 'data' name
fits better.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20180804130521.11408-5-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/annotate.c | 10 ++++----
 tools/perf/util/annotate.c        | 52 +++++++++++++++++++--------------------
 tools/perf/util/annotate.h        |  4 +--
 3 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index d264916d2648..d648d1e153f3 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -227,10 +227,10 @@ static int disasm__cmp(struct annotation_line *a, struct annotation_line *b)
 {
 	int i;
 
-	for (i = 0; i < a->samples_nr; i++) {
-		if (a->samples[i].percent == b->samples[i].percent)
+	for (i = 0; i < a->data_nr; i++) {
+		if (a->data[i].percent == b->data[i].percent)
 			continue;
-		return a->samples[i].percent < b->samples[i].percent;
+		return a->data[i].percent < b->data[i].percent;
 	}
 	return 0;
 }
@@ -314,8 +314,8 @@ static void annotate_browser__calc_percent(struct annotate_browser *browser,
 			continue;
 		}
 
-		for (i = 0; i < pos->al.samples_nr; i++) {
-			struct annotation_data *sample = &pos->al.samples[i];
+		for (i = 0; i < pos->al.data_nr; i++) {
+			struct annotation_data *sample = &pos->al.data[i];
 
 			if (max_percent < sample->percent)
 				max_percent = sample->percent;
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 0d40cee13f6b..e4cb8963db1a 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1108,7 +1108,7 @@ annotation_line__new(struct annotate_args *args, size_t privsize)
 	if (perf_evsel__is_group_event(evsel))
 		nr = evsel->nr_members;
 
-	size += sizeof(al->samples[0]) * nr;
+	size += sizeof(al->data[0]) * nr;
 
 	al = zalloc(size);
 	if (al) {
@@ -1117,7 +1117,7 @@ annotation_line__new(struct annotate_args *args, size_t privsize)
 		al->offset     = args->offset;
 		al->line       = strdup(args->line);
 		al->line_nr    = args->line_nr;
-		al->samples_nr = nr;
+		al->data_nr    = nr;
 	}
 
 	return al;
@@ -1309,15 +1309,15 @@ annotation_line__print(struct annotation_line *al, struct symbol *sym, u64 start
 		const char *color;
 		struct annotation *notes = symbol__annotation(sym);
 
-		for (i = 0; i < al->samples_nr; i++) {
-			struct annotation_data *sample = &al->samples[i];
+		for (i = 0; i < al->data_nr; i++) {
+			struct annotation_data *sample = &al->data[i];
 
 			if (sample->percent > max_percent)
 				max_percent = sample->percent;
 		}
 
-		if (al->samples_nr > nr_percent)
-			nr_percent = al->samples_nr;
+		if (al->data_nr > nr_percent)
+			nr_percent = al->data_nr;
 
 		if (max_percent < min_pcnt)
 			return -1;
@@ -1351,7 +1351,7 @@ annotation_line__print(struct annotation_line *al, struct symbol *sym, u64 start
 		}
 
 		for (i = 0; i < nr_percent; i++) {
-			struct annotation_data *sample = &al->samples[i];
+			struct annotation_data *sample = &al->data[i];
 
 			color = get_percent_color(sample->percent);
 
@@ -1788,12 +1788,12 @@ static void annotation__calc_percent(struct annotation *notes,
 		next = annotation_line__next(al, &notes->src->source);
 		end  = next ? next->offset : len;
 
-		for (i = 0; i < al->samples_nr; i++) {
+		for (i = 0; i < al->data_nr; i++) {
 			struct annotation_data *sample;
 			struct sym_hist *hist;
 
 			hist   = annotation__histogram(notes, evsel->idx + i);
-			sample = &al->samples[i];
+			sample = &al->data[i];
 
 			calc_percent(hist, sample, al->offset, end);
 		}
@@ -1859,8 +1859,8 @@ static void insert_source_line(struct rb_root *root, struct annotation_line *al)
 
 		ret = strcmp(iter->path, al->path);
 		if (ret == 0) {
-			for (i = 0; i < al->samples_nr; i++)
-				iter->samples[i].percent_sum += al->samples[i].percent;
+			for (i = 0; i < al->data_nr; i++)
+				iter->data[i].percent_sum += al->data[i].percent;
 			return;
 		}
 
@@ -1870,8 +1870,8 @@ static void insert_source_line(struct rb_root *root, struct annotation_line *al)
 			p = &(*p)->rb_right;
 	}
 
-	for (i = 0; i < al->samples_nr; i++)
-		al->samples[i].percent_sum = al->samples[i].percent;
+	for (i = 0; i < al->data_nr; i++)
+		al->data[i].percent_sum = al->data[i].percent;
 
 	rb_link_node(&al->rb_node, parent, p);
 	rb_insert_color(&al->rb_node, root);
@@ -1881,10 +1881,10 @@ static int cmp_source_line(struct annotation_line *a, struct annotation_line *b)
 {
 	int i;
 
-	for (i = 0; i < a->samples_nr; i++) {
-		if (a->samples[i].percent_sum == b->samples[i].percent_sum)
+	for (i = 0; i < a->data_nr; i++) {
+		if (a->data[i].percent_sum == b->data[i].percent_sum)
 			continue;
-		return a->samples[i].percent_sum > b->samples[i].percent_sum;
+		return a->data[i].percent_sum > b->data[i].percent_sum;
 	}
 
 	return 0;
@@ -1949,8 +1949,8 @@ static void print_summary(struct rb_root *root, const char *filename)
 		int i;
 
 		al = rb_entry(node, struct annotation_line, rb_node);
-		for (i = 0; i < al->samples_nr; i++) {
-			percent = al->samples[i].percent_sum;
+		for (i = 0; i < al->data_nr; i++) {
+			percent = al->data[i].percent_sum;
 			color = get_percent_color(percent);
 			color_fprintf(stdout, color, " %7.2f", percent);
 
@@ -2355,10 +2355,10 @@ static void annotation__calc_lines(struct annotation *notes, struct map *map,
 		double percent_max = 0.0;
 		int i;
 
-		for (i = 0; i < al->samples_nr; i++) {
+		for (i = 0; i < al->data_nr; i++) {
 			struct annotation_data *sample;
 
-			sample = &al->samples[i];
+			sample = &al->data[i];
 
 			if (sample->percent > percent_max)
 				percent_max = sample->percent;
@@ -2448,8 +2448,8 @@ static double annotation_line__max_percent(struct annotation_line *al,
 	int i;
 
 	for (i = 0; i < notes->nr_events; i++) {
-		if (al->samples[i].percent > percent_max)
-			percent_max = al->samples[i].percent;
+		if (al->data[i].percent > percent_max)
+			percent_max = al->data[i].percent;
 	}
 
 	return percent_max;
@@ -2515,15 +2515,15 @@ static void __annotation_line__write(struct annotation_line *al, struct annotati
 		int i;
 
 		for (i = 0; i < notes->nr_events; i++) {
-			obj__set_percent_color(obj, al->samples[i].percent, current_entry);
+			obj__set_percent_color(obj, al->data[i].percent, current_entry);
 			if (notes->options->show_total_period) {
-				obj__printf(obj, "%11" PRIu64 " ", al->samples[i].he.period);
+				obj__printf(obj, "%11" PRIu64 " ", al->data[i].he.period);
 			} else if (notes->options->show_nr_samples) {
 				obj__printf(obj, "%6" PRIu64 " ",
-						   al->samples[i].he.nr_samples);
+						   al->data[i].he.nr_samples);
 			} else {
 				obj__printf(obj, "%6.2f ",
-						   al->samples[i].percent);
+						   al->data[i].percent);
 			}
 		}
 	} else {
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index d06f14c656c6..58aa14c55bab 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -122,8 +122,8 @@ struct annotation_line {
 	char			*path;
 	u32			 idx;
 	int			 idx_asm;
-	int			 samples_nr;
-	struct annotation_data	 samples[0];
+	int			 data_nr;
+	struct annotation_data	 data[0];
 };
 
 struct disasm_line {
-- 
2.14.4

