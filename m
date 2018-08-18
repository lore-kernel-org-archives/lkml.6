Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D8A6C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCFF82146E
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:27:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCFF82146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbeHROee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 10:34:34 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55695 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbeHROee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 10:34:34 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w7IBQnCc1285679
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 18 Aug 2018 04:26:49 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w7IBQnfU1285676;
        Sat, 18 Aug 2018 04:26:49 -0700
Date:   Sat, 18 Aug 2018 04:26:49 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-0683d13c1afbf5cca147b6f578d1463be132b11b@git.kernel.org>
Cc:     tglx@linutronix.de, peterz@infradead.org,
        alexander.shishkin@linux.intel.com, hpa@zytor.com,
        namhyung@kernel.org, acme@redhat.com, linux-kernel@vger.kernel.org,
        eranian@google.com, dsahern@gmail.com, mingo@kernel.org,
        jolsa@kernel.org
Reply-To: mingo@kernel.org, jolsa@kernel.org, acme@redhat.com,
          namhyung@kernel.org, hpa@zytor.com, peterz@infradead.org,
          alexander.shishkin@linux.intel.com, tglx@linutronix.de,
          dsahern@gmail.com, eranian@google.com,
          linux-kernel@vger.kernel.org
In-Reply-To: <20180804130521.11408-4-jolsa@kernel.org>
References: <20180804130521.11408-4-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf annotate: Get rid of
 annotation__scnprintf_samples_period()
Git-Commit-ID: 0683d13c1afbf5cca147b6f578d1463be132b11b
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

Commit-ID:  0683d13c1afbf5cca147b6f578d1463be132b11b
Gitweb:     https://git.kernel.org/tip/0683d13c1afbf5cca147b6f578d1463be132b11b
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Sat, 4 Aug 2018 15:05:04 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 8 Aug 2018 15:55:46 -0300

perf annotate: Get rid of annotation__scnprintf_samples_period()

We have more current function tto get the title for annotation,
which is hists__scnprintf_title. They both have same output as
far as the annotation's header line goes.

They differ in counting of the nr_samples, hists__scnprintf_title
provides more accurate number based on the setup of the
symbol_conf.filter_relative variable.

Plus it also displays any uid/thread/dso/socket filters/zooms
if there are set any, which annotation__scnprintf_samples_period
does not.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20180804130521.11408-4-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/annotate.c |  3 +--
 tools/perf/util/annotate.c        | 44 ++-------------------------------------
 tools/perf/util/annotate.h        |  7 -------
 3 files changed, 3 insertions(+), 51 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 3b4f1c10ff57..d264916d2648 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -624,8 +624,7 @@ static int annotate_browser__run(struct annotate_browser *browser,
 	char title[256];
 	int key;
 
-	annotation__scnprintf_samples_period(notes, title, sizeof(title), evsel);
-
+	hists__scnprintf_title(hists, title, sizeof(title));
 	if (annotate_browser__show(&browser->b, title, help) < 0)
 		return -1;
 
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 956c9b19d81c..0d40cee13f6b 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2389,7 +2389,7 @@ int symbol__tty_annotate2(struct symbol *sym, struct map *map,
 {
 	struct dso *dso = map->dso;
 	struct rb_root source_line = RB_ROOT;
-	struct annotation *notes = symbol__annotation(sym);
+	struct hists *hists = evsel__hists(evsel);
 	char buf[1024];
 
 	if (symbol__annotate2(sym, map, evsel, opts, NULL) < 0)
@@ -2401,7 +2401,7 @@ int symbol__tty_annotate2(struct symbol *sym, struct map *map,
 		print_summary(&source_line, dso->long_name);
 	}
 
-	annotation__scnprintf_samples_period(notes, buf, sizeof(buf), evsel);
+	hists__scnprintf_title(hists, buf, sizeof(buf));
 	fprintf(stdout, "%s\n%s() %s\n", buf, sym->name, dso->long_name);
 	symbol__annotate_fprintf2(sym, stdout);
 
@@ -2689,46 +2689,6 @@ out_free_offsets:
 	return -1;
 }
 
-int __annotation__scnprintf_samples_period(struct annotation *notes,
-					   char *bf, size_t size,
-					   struct perf_evsel *evsel,
-					   bool show_freq)
-{
-	const char *ev_name = perf_evsel__name(evsel);
-	char buf[1024], ref[30] = " show reference callgraph, ";
-	char sample_freq_str[64] = "";
-	unsigned long nr_samples = 0;
-	int nr_members = 1;
-	bool enable_ref = false;
-	u64 nr_events = 0;
-	char unit;
-	int i;
-
-	if (perf_evsel__is_group_event(evsel)) {
-		perf_evsel__group_desc(evsel, buf, sizeof(buf));
-		ev_name = buf;
-                nr_members = evsel->nr_members;
-	}
-
-	for (i = 0; i < nr_members; i++) {
-		struct sym_hist *ah = annotation__histogram(notes, evsel->idx + i);
-
-		nr_samples += ah->nr_samples;
-		nr_events  += ah->period;
-	}
-
-	if (symbol_conf.show_ref_callgraph && strstr(ev_name, "call-graph=no"))
-		enable_ref = true;
-
-	if (show_freq)
-		scnprintf(sample_freq_str, sizeof(sample_freq_str), " %d Hz,", evsel->attr.sample_freq);
-
-	nr_samples = convert_unit(nr_samples, &unit);
-	return scnprintf(bf, size, "Samples: %lu%c of event%s '%s',%s%sEvent count (approx.): %" PRIu64,
-			 nr_samples, unit, evsel->nr_members > 1 ? "s" : "",
-			 ev_name, sample_freq_str, enable_ref ? ref : " ", nr_events);
-}
-
 #define ANNOTATION__CFG(n) \
 	{ .name = #n, .value = &annotation__default_options.n, }
 
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index a93502d0c582..d06f14c656c6 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -177,13 +177,6 @@ int __annotation__scnprintf_samples_period(struct annotation *notes,
 					   struct perf_evsel *evsel,
 					   bool show_freq);
 
-static inline int annotation__scnprintf_samples_period(struct annotation *notes,
-						       char *bf, size_t size,
-						       struct perf_evsel *evsel)
-{
-	return __annotation__scnprintf_samples_period(notes, bf, size, evsel, true);
-}
-
 int disasm_line__scnprintf(struct disasm_line *dl, char *bf, size_t size, bool raw);
 size_t disasm__fprintf(struct list_head *head, FILE *fp);
 void symbol__calc_percent(struct symbol *sym, struct perf_evsel *evsel);
