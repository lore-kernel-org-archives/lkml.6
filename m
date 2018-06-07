Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id tLisIhLoGFsnTgAAmS7hNA
	; Thu, 07 Jun 2018 08:09:32 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 974B76089E; Thu,  7 Jun 2018 08:09:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 8B546607F7;
	Thu,  7 Jun 2018 08:09:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8B546607F7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753471AbeFGIJ2 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 04:09:28 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37121 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753232AbeFGIJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 04:09:26 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5789GlQ2124597
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 7 Jun 2018 01:09:16 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5789GqA2124593;
        Thu, 7 Jun 2018 01:09:16 -0700
Date: Thu, 7 Jun 2018 01:09:16 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-6qgtixurjgdk5u0n3rw78ges@git.kernel.org>
Cc: jolsa@kernel.org, tglx@linutronix.de, hpa@zytor.com,
        acme@redhat.com, namhyung@kernel.org, dsahern@gmail.com,
        wangnan0@huawei.com, linux-kernel@vger.kernel.org,
        adrian.hunter@intel.com, mingo@kernel.org
Reply-To: hpa@zytor.com, jolsa@kernel.org, tglx@linutronix.de,
          dsahern@gmail.com, namhyung@kernel.org, acme@redhat.com,
          wangnan0@huawei.com, linux-kernel@vger.kernel.org,
          adrian.hunter@intel.com, mingo@kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf annotate stdio: Use annotation_options
 consistently
Git-Commit-ID: 982d410bc6b405a75086236d3c1da1f18c40d6dd
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

Commit-ID:  982d410bc6b405a75086236d3c1da1f18c40d6dd
Gitweb:     https://git.kernel.org/tip/982d410bc6b405a75086236d3c1da1f18c40d6dd
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Fri, 25 May 2018 17:28:37 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 4 Jun 2018 10:28:52 -0300

perf annotate stdio: Use annotation_options consistently

Accross all the routines, this way we can have eventually have a
consistent set of defaults for all UIs.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-6qgtixurjgdk5u0n3rw78ges@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-annotate.c | 15 +++++++--------
 tools/perf/builtin-top.c      | 14 ++++++++------
 tools/perf/util/annotate.c    | 31 +++++++++++++++----------------
 tools/perf/util/annotate.h    | 15 +++++++++------
 tools/perf/util/top.h         |  3 ++-
 5 files changed, 41 insertions(+), 37 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 2b21bbcd70ea..7238010f28d4 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -40,9 +40,8 @@
 struct perf_annotate {
 	struct perf_tool tool;
 	struct perf_session *session;
+	struct annotation_options opts;
 	bool	   use_tui, use_stdio, use_stdio2, use_gtk;
-	bool	   full_paths;
-	bool	   print_line;
 	bool	   skip_missing;
 	bool	   has_br_stack;
 	bool	   group_set;
@@ -289,10 +288,9 @@ static int hist_entry__tty_annotate(struct hist_entry *he,
 				    struct perf_annotate *ann)
 {
 	if (!ann->use_stdio2)
-		return symbol__tty_annotate(he->ms.sym, he->ms.map, evsel,
-					    ann->print_line, ann->full_paths, 0, 0);
-	return symbol__tty_annotate2(he->ms.sym, he->ms.map, evsel,
-				     ann->print_line, ann->full_paths);
+		return symbol__tty_annotate(he->ms.sym, he->ms.map, evsel, &ann->opts);
+
+	return symbol__tty_annotate2(he->ms.sym, he->ms.map, evsel, &ann->opts);
 }
 
 static void hists__find_annotations(struct hists *hists,
@@ -476,6 +474,7 @@ int cmd_annotate(int argc, const char **argv)
 			.ordered_events = true,
 			.ordering_requires_timestamps = true,
 		},
+		.opts = annotation__default_options,
 	};
 	struct perf_data data = {
 		.mode  = PERF_DATA_MODE_READ,
@@ -503,9 +502,9 @@ int cmd_annotate(int argc, const char **argv)
 		   "file", "vmlinux pathname"),
 	OPT_BOOLEAN('m', "modules", &symbol_conf.use_modules,
 		    "load module symbols - WARNING: use only with -k and LIVE kernel"),
-	OPT_BOOLEAN('l', "print-line", &annotate.print_line,
+	OPT_BOOLEAN('l', "print-line", &annotate.opts.print_lines,
 		    "print matching source lines (may be slow)"),
-	OPT_BOOLEAN('P', "full-paths", &annotate.full_paths,
+	OPT_BOOLEAN('P', "full-paths", &annotate.opts.full_path,
 		    "Don't shorten the displayed pathnames"),
 	OPT_BOOLEAN(0, "skip-missing", &annotate.skip_missing,
 		    "Skip symbols that cannot be annotated"),
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 4284840022a3..5e58cd4de90b 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -243,10 +243,9 @@ static void perf_top__show_details(struct perf_top *top)
 		goto out_unlock;
 
 	printf("Showing %s for %s\n", perf_evsel__name(top->sym_evsel), symbol->name);
-	printf("  Events  Pcnt (>=%d%%)\n", top->sym_pcnt_filter);
+	printf("  Events  Pcnt (>=%d%%)\n", top->annotation_opts.min_pcnt);
 
-	more = symbol__annotate_printf(symbol, he->ms.map, top->sym_evsel,
-				       0, top->sym_pcnt_filter, top->print_entries, 4);
+	more = symbol__annotate_printf(symbol, he->ms.map, top->sym_evsel, &top->annotation_opts);
 
 	if (top->evlist->enabled) {
 		if (top->zero)
@@ -406,7 +405,7 @@ static void perf_top__print_mapped_keys(struct perf_top *top)
 
 	fprintf(stdout, "\t[f]     profile display filter (count).    \t(%d)\n", top->count_filter);
 
-	fprintf(stdout, "\t[F]     annotate display filter (percent). \t(%d%%)\n", top->sym_pcnt_filter);
+	fprintf(stdout, "\t[F]     annotate display filter (percent). \t(%d%%)\n", top->annotation_opts.min_pcnt);
 	fprintf(stdout, "\t[s]     annotate symbol.                   \t(%s)\n", name?: "NULL");
 	fprintf(stdout, "\t[S]     stop annotation.\n");
 
@@ -509,7 +508,7 @@ static bool perf_top__handle_keypress(struct perf_top *top, int c)
 			prompt_integer(&top->count_filter, "Enter display event count filter");
 			break;
 		case 'F':
-			prompt_percent(&top->sym_pcnt_filter,
+			prompt_percent(&top->annotation_opts.min_pcnt,
 				       "Enter details display event filter (percent)");
 			break;
 		case 'K':
@@ -1259,7 +1258,7 @@ int cmd_top(int argc, const char **argv)
 			.overwrite	= 1,
 		},
 		.max_stack	     = sysctl__max_stack(),
-		.sym_pcnt_filter     = 5,
+		.annotation_opts     = annotation__default_options,
 		.nr_threads_synthesize = UINT_MAX,
 	};
 	struct record_opts *opts = &top.record_opts;
@@ -1385,6 +1384,9 @@ int cmd_top(int argc, const char **argv)
 	if (status < 0)
 		return status;
 
+	top.annotation_opts.min_pcnt = 5;
+	top.annotation_opts.context  = 4;
+
 	top.evlist = perf_evlist__new();
 	if (top.evlist == NULL)
 		return -ENOMEM;
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index bcd5d3e17b85..abcc7e24c365 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1985,8 +1985,8 @@ static int annotated_source__addr_fmt_width(struct list_head *lines, u64 start)
 }
 
 int symbol__annotate_printf(struct symbol *sym, struct map *map,
-			    struct perf_evsel *evsel, bool full_paths,
-			    int min_pcnt, int max_lines, int context)
+			    struct perf_evsel *evsel,
+			    struct annotation_options *opts)
 {
 	struct dso *dso = map->dso;
 	char *filename;
@@ -1998,6 +1998,7 @@ int symbol__annotate_printf(struct symbol *sym, struct map *map,
 	u64 start = map__rip_2objdump(map, sym->start);
 	int printed = 2, queue_len = 0, addr_fmt_width;
 	int more = 0;
+	bool context = opts->context;
 	u64 len;
 	int width = symbol_conf.show_total_period ? 12 : 8;
 	int graph_dotted_len;
@@ -2007,7 +2008,7 @@ int symbol__annotate_printf(struct symbol *sym, struct map *map,
 	if (!filename)
 		return -ENOMEM;
 
-	if (full_paths)
+	if (opts->full_path)
 		d_filename = filename;
 	else
 		d_filename = basename(filename);
@@ -2042,7 +2043,7 @@ int symbol__annotate_printf(struct symbol *sym, struct map *map,
 		}
 
 		err = annotation_line__print(pos, sym, start, evsel, len,
-					     min_pcnt, printed, max_lines,
+					     opts->min_pcnt, printed, opts->max_lines,
 					     queue, addr_fmt_width);
 
 		switch (err) {
@@ -2375,20 +2376,19 @@ static void symbol__calc_lines(struct symbol *sym, struct map *map,
 }
 
 int symbol__tty_annotate2(struct symbol *sym, struct map *map,
-			  struct perf_evsel *evsel, bool print_lines,
-			  bool full_paths)
+			  struct perf_evsel *evsel,
+			  struct annotation_options *opts)
 {
 	struct dso *dso = map->dso;
 	struct rb_root source_line = RB_ROOT;
-	struct annotation_options opts = annotation__default_options;
 	struct annotation *notes = symbol__annotation(sym);
 	char buf[1024];
 
-	if (symbol__annotate2(sym, map, evsel, &opts, NULL) < 0)
+	if (symbol__annotate2(sym, map, evsel, opts, NULL) < 0)
 		return -1;
 
-	if (print_lines) {
-		srcline_full_filename = full_paths;
+	if (opts->print_lines) {
+		srcline_full_filename = opts->full_path;
 		symbol__calc_lines(sym, map, &source_line);
 		print_summary(&source_line, dso->long_name);
 	}
@@ -2403,8 +2403,8 @@ int symbol__tty_annotate2(struct symbol *sym, struct map *map,
 }
 
 int symbol__tty_annotate(struct symbol *sym, struct map *map,
-			 struct perf_evsel *evsel, bool print_lines,
-			 bool full_paths, int min_pcnt, int max_lines)
+			 struct perf_evsel *evsel,
+			 struct annotation_options *opts)
 {
 	struct dso *dso = map->dso;
 	struct rb_root source_line = RB_ROOT;
@@ -2414,14 +2414,13 @@ int symbol__tty_annotate(struct symbol *sym, struct map *map,
 
 	symbol__calc_percent(sym, evsel);
 
-	if (print_lines) {
-		srcline_full_filename = full_paths;
+	if (opts->print_lines) {
+		srcline_full_filename = opts->full_path;
 		symbol__calc_lines(sym, map, &source_line);
 		print_summary(&source_line, dso->long_name);
 	}
 
-	symbol__annotate_printf(sym, map, evsel, full_paths,
-				min_pcnt, max_lines, 0);
+	symbol__annotate_printf(sym, map, evsel, opts);
 
 	annotated_source__purge(symbol__annotation(sym)->src);
 
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 3dc4ca1d6c08..20f3326cc640 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -67,12 +67,17 @@ struct annotation_options {
 	bool hide_src_code,
 	     use_offset,
 	     jump_arrows,
+	     print_lines,
+	     full_path,
 	     show_linenr,
 	     show_nr_jumps,
 	     show_nr_samples,
 	     show_total_period,
 	     show_minmax_cycle;
 	u8   offset_level;
+	int  min_pcnt;
+	int  max_lines;
+	int  context;
 };
 
 enum {
@@ -328,8 +333,8 @@ int symbol__strerror_disassemble(struct symbol *sym, struct map *map,
 				 int errnum, char *buf, size_t buflen);
 
 int symbol__annotate_printf(struct symbol *sym, struct map *map,
-			    struct perf_evsel *evsel, bool full_paths,
-			    int min_pcnt, int max_lines, int context);
+			    struct perf_evsel *evsel,
+			    struct annotation_options *options);
 int symbol__annotate_fprintf2(struct symbol *sym, FILE *fp);
 void symbol__annotate_zero_histogram(struct symbol *sym, int evidx);
 void symbol__annotate_decay_histogram(struct symbol *sym, int evidx);
@@ -340,12 +345,10 @@ int map_symbol__annotation_dump(struct map_symbol *ms, struct perf_evsel *evsel)
 bool ui__has_annotation(void);
 
 int symbol__tty_annotate(struct symbol *sym, struct map *map,
-			 struct perf_evsel *evsel, bool print_lines,
-			 bool full_paths, int min_pcnt, int max_lines);
+			 struct perf_evsel *evsel, struct annotation_options *opts);
 
 int symbol__tty_annotate2(struct symbol *sym, struct map *map,
-			  struct perf_evsel *evsel, bool print_lines,
-			  bool full_paths);
+			  struct perf_evsel *evsel, struct annotation_options *opts);
 
 #ifdef HAVE_SLANG_SUPPORT
 int symbol__tui_annotate(struct symbol *sym, struct map *map,
diff --git a/tools/perf/util/top.h b/tools/perf/util/top.h
index 9892323cdd7c..9add1f72ce95 100644
--- a/tools/perf/util/top.h
+++ b/tools/perf/util/top.h
@@ -3,6 +3,7 @@
 #define __PERF_TOP_H 1
 
 #include "tool.h"
+#include "annotate.h"
 #include <linux/types.h>
 #include <stddef.h>
 #include <stdbool.h>
@@ -16,6 +17,7 @@ struct perf_top {
 	struct perf_tool   tool;
 	struct perf_evlist *evlist;
 	struct record_opts record_opts;
+	struct annotation_options annotation_opts;
 	/*
 	 * Symbols will be added here in perf_event__process_sample and will
 	 * get out after decayed.
@@ -35,7 +37,6 @@ struct perf_top {
 	struct perf_session *session;
 	struct winsize	   winsize;
 	int		   realtime_prio;
-	int		   sym_pcnt_filter;
 	const char	   *sym_filter;
 	float		   min_percent;
 	unsigned int	   nr_threads_synthesize;
