Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id dRGhOPjoGFt8UQAAmS7hNA
	; Thu, 07 Jun 2018 08:12:40 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id D6AB86089E; Thu,  7 Jun 2018 08:12:40 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 2F287607E7;
	Thu,  7 Jun 2018 08:12:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2F287607E7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753630AbeFGIMh (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 04:12:37 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46701 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751681AbeFGIMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 04:12:33 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w578CN5D2125021
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 7 Jun 2018 01:12:23 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w578CNmT2125018;
        Thu, 7 Jun 2018 01:12:23 -0700
Date: Thu, 7 Jun 2018 01:12:23 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-p3cdhltj58jt0byjzg3g7obx@git.kernel.org>
Cc: namhyung@kernel.org, tglx@linutronix.de, dsahern@gmail.com,
        adrian.hunter@intel.com, acme@redhat.com, hpa@zytor.com,
        wangnan0@huawei.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, jolsa@kernel.org
Reply-To: acme@redhat.com, hpa@zytor.com, namhyung@kernel.org,
          dsahern@gmail.com, adrian.hunter@intel.com, tglx@linutronix.de,
          jolsa@kernel.org, wangnan0@huawei.com,
          linux-kernel@vger.kernel.org, mingo@kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf annotate: Move disassembler_style global to
 annotation_options
Git-Commit-ID: a47e843edca81058b9f4187b78f8b98320ebbd59
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

Commit-ID:  a47e843edca81058b9f4187b78f8b98320ebbd59
Gitweb:     https://git.kernel.org/tip/a47e843edca81058b9f4187b78f8b98320ebbd59
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 28 May 2018 11:50:21 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 4 Jun 2018 10:28:53 -0300

perf annotate: Move disassembler_style global to annotation_options

Continuing to group annotation specific stuff into a struct.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-p3cdhltj58jt0byjzg3g7obx@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-annotate.c | 2 +-
 tools/perf/builtin-report.c   | 2 +-
 tools/perf/builtin-top.c      | 2 +-
 tools/perf/util/annotate.c    | 5 ++---
 tools/perf/util/annotate.h    | 3 +--
 5 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 2ca7172f0780..3ee063598364 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -519,7 +519,7 @@ int cmd_annotate(int argc, const char **argv)
 		    "Interleave source code with assembly code (default)"),
 	OPT_BOOLEAN(0, "asm-raw", &annotate.opts.show_asm_raw,
 		    "Display raw encoding of assembly instructions (default)"),
-	OPT_STRING('M', "disassembler-style", &disassembler_style, "disassembler style",
+	OPT_STRING('M', "disassembler-style", &annotate.opts.disassembler_style, "disassembler style",
 		   "Specify disassembler style (e.g. -M intel for intel syntax)"),
 	OPT_STRING(0, "objdump", &objdump_path, "path",
 		   "objdump binary to use for disassembly and annotations"),
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index bee6dbfbf11e..c74f9a219ad1 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1083,7 +1083,7 @@ int cmd_report(int argc, const char **argv)
 		    "Interleave source code with assembly code (default)"),
 	OPT_BOOLEAN(0, "asm-raw", &report.annotation_opts.show_asm_raw,
 		    "Display raw encoding of assembly instructions (default)"),
-	OPT_STRING('M', "disassembler-style", &disassembler_style, "disassembler style",
+	OPT_STRING('M', "disassembler-style", &report.annotation_opts.disassembler_style, "disassembler style",
 		   "Specify disassembler style (e.g. -M intel for intel syntax)"),
 	OPT_BOOLEAN(0, "show-total-period", &symbol_conf.show_total_period,
 		    "Show a column with the sum of periods"),
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index e65e72c06a01..739c158fb39e 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1348,7 +1348,7 @@ int cmd_top(int argc, const char **argv)
 		    "Enable kernel symbol demangling"),
 	OPT_STRING(0, "objdump", &objdump_path, "path",
 		    "objdump binary to use for disassembly and annotations"),
-	OPT_STRING('M', "disassembler-style", &disassembler_style, "disassembler style",
+	OPT_STRING('M', "disassembler-style", &top.annotation_opts.disassembler_style, "disassembler style",
 		   "Specify disassembler style (e.g. -M intel for intel syntax)"),
 	OPT_STRING('u', "uid", &target->uid_str, "user", "user to profile"),
 	OPT_CALLBACK(0, "percent-limit", &top, "percent",
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index ff8f4f474b22..a90777717b60 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -51,7 +51,6 @@ struct annotation_options annotation__default_options = {
 	.offset_level	= ANNOTATION__OFFSET_JUMP_TARGETS,
 };
 
-const char 	*disassembler_style;
 const char	*objdump_path;
 static regex_t	 file_lineno;
 
@@ -1659,8 +1658,8 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 		 " --stop-address=0x%016" PRIx64
 		 " -l -d %s %s -C \"%s\" 2>/dev/null|grep -v \"%s:\"|expand",
 		 objdump_path ? objdump_path : "objdump",
-		 disassembler_style ? "-M " : "",
-		 disassembler_style ? disassembler_style : "",
+		 opts->disassembler_style ? "-M " : "",
+		 opts->disassembler_style ?: "",
 		 map__rip_2objdump(map, sym->start),
 		 map__rip_2objdump(map, sym->end),
 		 opts->show_asm_raw ? "" : "--no-show-raw",
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 476ea2a25649..71a734b86873 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -80,6 +80,7 @@ struct annotation_options {
 	int  min_pcnt;
 	int  max_lines;
 	int  context;
+	const char *disassembler_style;
 };
 
 enum {
@@ -368,8 +369,6 @@ static inline int symbol__tui_annotate(struct symbol *sym __maybe_unused,
 }
 #endif
 
-extern const char	*disassembler_style;
-
 void annotation_config__init(void);
 
 #endif	/* __PERF_ANNOTATE_H */
