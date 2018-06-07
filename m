Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id XTVbIq/nGFu/SgAAmS7hNA
	; Thu, 07 Jun 2018 08:12:08 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 23CB96089E; Thu,  7 Jun 2018 08:12:08 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 538C860115;
	Thu,  7 Jun 2018 08:12:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 538C860115
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753573AbeFGIMF (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 04:12:05 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52311 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753014AbeFGIMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 04:12:01 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w578Bq5v2124829
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 7 Jun 2018 01:11:52 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w578BpkY2124826;
        Thu, 7 Jun 2018 01:11:51 -0700
Date: Thu, 7 Jun 2018 01:11:51 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-astei92tzxp4yccag5pxb2h7@git.kernel.org>
Cc: tglx@linutronix.de, namhyung@kernel.org, wangnan0@huawei.com,
        jolsa@kernel.org, mingo@kernel.org, dsahern@gmail.com,
        hpa@zytor.com, adrian.hunter@intel.com, acme@redhat.com,
        linux-kernel@vger.kernel.org
Reply-To: tglx@linutronix.de, mingo@kernel.org, dsahern@gmail.com,
          namhyung@kernel.org, wangnan0@huawei.com, jolsa@kernel.org,
          linux-kernel@vger.kernel.org, adrian.hunter@intel.com,
          acme@redhat.com, hpa@zytor.com
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf annotate: Adopt anotation options from
 symbol_conf
Git-Commit-ID: 1eddd9e4101d21709c453d80a42d2efc4277cb27
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

Commit-ID:  1eddd9e4101d21709c453d80a42d2efc4277cb27
Gitweb:     https://git.kernel.org/tip/1eddd9e4101d21709c453d80a42d2efc4277cb27
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 28 May 2018 11:42:59 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 4 Jun 2018 10:28:53 -0300

perf annotate: Adopt anotation options from symbol_conf

Continuing to group annotation options in an annotation specific struct.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-astei92tzxp4yccag5pxb2h7@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-annotate.c | 4 ++--
 tools/perf/builtin-report.c   | 6 ++++--
 tools/perf/builtin-top.c      | 4 ++--
 tools/perf/util/annotate.c    | 6 ++++--
 tools/perf/util/annotate.h    | 4 +++-
 tools/perf/util/symbol.c      | 1 -
 tools/perf/util/symbol.h      | 2 --
 7 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 7238010f28d4..2ca7172f0780 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -515,9 +515,9 @@ int cmd_annotate(int argc, const char **argv)
 	OPT_CALLBACK(0, "symfs", NULL, "directory",
 		     "Look for files with symbols relative to this directory",
 		     symbol__config_symfs),
-	OPT_BOOLEAN(0, "source", &symbol_conf.annotate_src,
+	OPT_BOOLEAN(0, "source", &annotate.opts.annotate_src,
 		    "Interleave source code with assembly code (default)"),
-	OPT_BOOLEAN(0, "asm-raw", &symbol_conf.annotate_asm_raw,
+	OPT_BOOLEAN(0, "asm-raw", &annotate.opts.show_asm_raw,
 		    "Display raw encoding of assembly instructions (default)"),
 	OPT_STRING('M', "disassembler-style", &disassembler_style, "disassembler style",
 		   "Specify disassembler style (e.g. -M intel for intel syntax)"),
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 7a689c933f04..bee6dbfbf11e 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -71,6 +71,7 @@ struct report {
 	bool			group_set;
 	int			max_stack;
 	struct perf_read_values	show_threads_values;
+	struct annotation_options annotation_opts;
 	const char		*pretty_printing_style;
 	const char		*cpu_list;
 	const char		*symbol_filter_str;
@@ -988,6 +989,7 @@ int cmd_report(int argc, const char **argv)
 		.max_stack		 = PERF_MAX_STACK_DEPTH,
 		.pretty_printing_style	 = "normal",
 		.socket_filter		 = -1,
+		.annotation_opts	 = annotation__default_options,
 	};
 	const struct option options[] = {
 	OPT_STRING('i', "input", &input_name, "file",
@@ -1077,9 +1079,9 @@ int cmd_report(int argc, const char **argv)
 		   "list of cpus to profile"),
 	OPT_BOOLEAN('I', "show-info", &report.show_full_info,
 		    "Display extended information about perf.data file"),
-	OPT_BOOLEAN(0, "source", &symbol_conf.annotate_src,
+	OPT_BOOLEAN(0, "source", &report.annotation_opts.annotate_src,
 		    "Interleave source code with assembly code (default)"),
-	OPT_BOOLEAN(0, "asm-raw", &symbol_conf.annotate_asm_raw,
+	OPT_BOOLEAN(0, "asm-raw", &report.annotation_opts.show_asm_raw,
 		    "Display raw encoding of assembly instructions (default)"),
 	OPT_STRING('M', "disassembler-style", &disassembler_style, "disassembler style",
 		   "Specify disassembler style (e.g. -M intel for intel syntax)"),
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 2c14ca61c657..e65e72c06a01 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1340,9 +1340,9 @@ int cmd_top(int argc, const char **argv)
 		   "only consider symbols in these comms"),
 	OPT_STRING(0, "symbols", &symbol_conf.sym_list_str, "symbol[,symbol...]",
 		   "only consider these symbols"),
-	OPT_BOOLEAN(0, "source", &symbol_conf.annotate_src,
+	OPT_BOOLEAN(0, "source", &top.annotation_opts.annotate_src,
 		    "Interleave source code with assembly code (default)"),
-	OPT_BOOLEAN(0, "asm-raw", &symbol_conf.annotate_asm_raw,
+	OPT_BOOLEAN(0, "asm-raw", &top.annotation_opts.show_asm_raw,
 		    "Display raw encoding of assembly instructions (default)"),
 	OPT_BOOLEAN(0, "demangle-kernel", &symbol_conf.demangle_kernel,
 		    "Enable kernel symbol demangling"),
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 502f9d124a44..ff8f4f474b22 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -47,6 +47,7 @@
 struct annotation_options annotation__default_options = {
 	.use_offset     = true,
 	.jump_arrows    = true,
+	.annotate_src	= true,
 	.offset_level	= ANNOTATION__OFFSET_JUMP_TARGETS,
 };
 
@@ -1609,6 +1610,7 @@ fallback:
 
 static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 {
+	struct annotation_options *opts = args->options;
 	struct map *map = args->ms.map;
 	struct dso *dso = map->dso;
 	char *command;
@@ -1661,8 +1663,8 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 		 disassembler_style ? disassembler_style : "",
 		 map__rip_2objdump(map, sym->start),
 		 map__rip_2objdump(map, sym->end),
-		 symbol_conf.annotate_asm_raw ? "" : "--no-show-raw",
-		 symbol_conf.annotate_src ? "-S" : "",
+		 opts->show_asm_raw ? "" : "--no-show-raw",
+		 opts->annotate_src ? "-S" : "",
 		 symfs_filename, symfs_filename);
 
 	if (err < 0) {
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 013d414b0e57..476ea2a25649 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -73,7 +73,9 @@ struct annotation_options {
 	     show_nr_jumps,
 	     show_nr_samples,
 	     show_total_period,
-	     show_minmax_cycle;
+	     show_minmax_cycle,
+	     show_asm_raw,
+	     annotate_src;
 	u8   offset_level;
 	int  min_pcnt;
 	int  max_lines;
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 8c84437f2a10..3f632c60888f 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -40,7 +40,6 @@ char **vmlinux_path;
 struct symbol_conf symbol_conf = {
 	.use_modules		= true,
 	.try_vmlinux_path	= true,
-	.annotate_src		= true,
 	.demangle		= true,
 	.demangle_kernel	= false,
 	.cumulate_callchain	= true,
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 1be9a6bad967..f25fae4b5743 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -108,8 +108,6 @@ struct symbol_conf {
 			show_cpu_utilization,
 			initialized,
 			kptr_restrict,
-			annotate_asm_raw,
-			annotate_src,
 			event_group,
 			demangle,
 			demangle_kernel,
