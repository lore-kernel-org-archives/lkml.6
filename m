Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id eRGhOPjoGFt8UQAAmS7hNA
	; Thu, 07 Jun 2018 08:13:40 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id C2B9E6089E; Thu,  7 Jun 2018 08:13:40 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id EE7B960115;
	Thu,  7 Jun 2018 08:13:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EE7B960115
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932375AbeFGINg (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 04:13:36 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58259 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932102AbeFGINf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 04:13:35 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w578DQPE2125099
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 7 Jun 2018 01:13:26 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w578DPn12125096;
        Thu, 7 Jun 2018 01:13:25 -0700
Date: Thu, 7 Jun 2018 01:13:25 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-sogzdhugoavm6fyw60jnb0vs@git.kernel.org>
Cc: namhyung@kernel.org, tglx@linutronix.de, adrian.hunter@intel.com,
        linux-kernel@vger.kernel.org, wangnan0@huawei.com,
        mingo@kernel.org, dsahern@gmail.com, hpa@zytor.com,
        acme@redhat.com, jolsa@kernel.org
Reply-To: jolsa@kernel.org, acme@redhat.com, hpa@zytor.com,
          dsahern@gmail.com, linux-kernel@vger.kernel.org,
          mingo@kernel.org, wangnan0@huawei.com, adrian.hunter@intel.com,
          tglx@linutronix.de, namhyung@kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf annotate: Move objdump_path to struct
 annotation_options
Git-Commit-ID: f178fd2d498eccbf6592ace72b9f235f0e58c77d
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

Commit-ID:  f178fd2d498eccbf6592ace72b9f235f0e58c77d
Gitweb:     https://git.kernel.org/tip/f178fd2d498eccbf6592ace72b9f235f0e58c77d
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 28 May 2018 14:24:45 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 4 Jun 2018 10:28:53 -0300

perf annotate: Move objdump_path to struct annotation_options

One more step in grouping annotation options.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-sogzdhugoavm6fyw60jnb0vs@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/common.c       | 4 ++--
 tools/perf/arch/common.h       | 4 +---
 tools/perf/builtin-annotate.c  | 7 ++++---
 tools/perf/builtin-report.c    | 2 +-
 tools/perf/builtin-top.c       | 7 ++++---
 tools/perf/ui/browsers/hists.c | 3 ++-
 tools/perf/util/annotate.c     | 3 +--
 tools/perf/util/annotate.h     | 1 +
 8 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/tools/perf/arch/common.c b/tools/perf/arch/common.c
index c6f373508a4f..82657c01a3b8 100644
--- a/tools/perf/arch/common.c
+++ b/tools/perf/arch/common.c
@@ -189,7 +189,7 @@ out_error:
 	return -1;
 }
 
-int perf_env__lookup_objdump(struct perf_env *env)
+int perf_env__lookup_objdump(struct perf_env *env, const char **path)
 {
 	/*
 	 * For live mode, env->arch will be NULL and we can use
@@ -198,5 +198,5 @@ int perf_env__lookup_objdump(struct perf_env *env)
 	if (env->arch == NULL)
 		return 0;
 
-	return perf_env__lookup_binutils_path(env, "objdump", &objdump_path);
+	return perf_env__lookup_binutils_path(env, "objdump", path);
 }
diff --git a/tools/perf/arch/common.h b/tools/perf/arch/common.h
index 2d875baa92e6..2167001b18c5 100644
--- a/tools/perf/arch/common.h
+++ b/tools/perf/arch/common.h
@@ -4,8 +4,6 @@
 
 #include "../util/env.h"
 
-extern const char *objdump_path;
-
-int perf_env__lookup_objdump(struct perf_env *env);
+int perf_env__lookup_objdump(struct perf_env *env, const char **path);
 
 #endif /* ARCH_PERF_COMMON_H */
diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 2339ae719e1d..5eb22cc56363 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -388,8 +388,9 @@ static int __cmd_annotate(struct perf_annotate *ann)
 			goto out;
 	}
 
-	if (!objdump_path) {
-		ret = perf_env__lookup_objdump(&session->header.env);
+	if (!ann->opts.objdump_path) {
+		ret = perf_env__lookup_objdump(&session->header.env,
+					       &ann->opts.objdump_path);
 		if (ret)
 			goto out;
 	}
@@ -521,7 +522,7 @@ int cmd_annotate(int argc, const char **argv)
 		    "Display raw encoding of assembly instructions (default)"),
 	OPT_STRING('M', "disassembler-style", &annotate.opts.disassembler_style, "disassembler style",
 		   "Specify disassembler style (e.g. -M intel for intel syntax)"),
-	OPT_STRING(0, "objdump", &objdump_path, "path",
+	OPT_STRING(0, "objdump", &annotate.opts.objdump_path, "path",
 		   "objdump binary to use for disassembly and annotations"),
 	OPT_BOOLEAN(0, "group", &symbol_conf.event_group,
 		    "Show event group information together"),
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 14b516a3a0de..bc133e7a7ac2 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1094,7 +1094,7 @@ int cmd_report(int argc, const char **argv)
 		    parse_branch_mode),
 	OPT_BOOLEAN(0, "branch-history", &branch_call_mode,
 		    "add last branch records to call history"),
-	OPT_STRING(0, "objdump", &objdump_path, "path",
+	OPT_STRING(0, "objdump", &report.annotation_opts.objdump_path, "path",
 		   "objdump binary to use for disassembly and annotations"),
 	OPT_BOOLEAN(0, "demangle", &symbol_conf.demangle,
 		    "Disable symbol demangling"),
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index bd60a631a481..ffdc2769ff9f 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1077,8 +1077,9 @@ static int __cmd_top(struct perf_top *top)
 	if (top->session == NULL)
 		return -1;
 
-	if (!objdump_path) {
-		ret = perf_env__lookup_objdump(&top->session->header.env);
+	if (!top->annotation_opts.objdump_path) {
+		ret = perf_env__lookup_objdump(&top->session->header.env,
+					       &top->annotation_opts.objdump_path);
 		if (ret)
 			goto out_delete;
 	}
@@ -1347,7 +1348,7 @@ int cmd_top(int argc, const char **argv)
 		    "Display raw encoding of assembly instructions (default)"),
 	OPT_BOOLEAN(0, "demangle-kernel", &symbol_conf.demangle_kernel,
 		    "Enable kernel symbol demangling"),
-	OPT_STRING(0, "objdump", &objdump_path, "path",
+	OPT_STRING(0, "objdump", &top.annotation_opts.objdump_path, "path",
 		    "objdump binary to use for disassembly and annotations"),
 	OPT_STRING('M', "disassembler-style", &top.annotation_opts.disassembler_style, "disassembler style",
 		   "Specify disassembler style (e.g. -M intel for intel syntax)"),
diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 3af1b74608ab..22054107f1af 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -2338,7 +2338,8 @@ do_annotate(struct hist_browser *browser, struct popup_action *act)
 	struct hist_entry *he;
 	int err;
 
-	if (!objdump_path && perf_env__lookup_objdump(browser->env))
+	if (!browser->annotation_opts->objdump_path &&
+	    perf_env__lookup_objdump(browser->env, &browser->annotation_opts->objdump_path))
 		return 0;
 
 	notes = symbol__annotation(act->ms.sym);
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index a90777717b60..2baa22933b0e 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -51,7 +51,6 @@ struct annotation_options annotation__default_options = {
 	.offset_level	= ANNOTATION__OFFSET_JUMP_TARGETS,
 };
 
-const char	*objdump_path;
 static regex_t	 file_lineno;
 
 static struct ins_ops *ins__find(struct arch *arch, const char *name);
@@ -1657,7 +1656,7 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 		 "%s %s%s --start-address=0x%016" PRIx64
 		 " --stop-address=0x%016" PRIx64
 		 " -l -d %s %s -C \"%s\" 2>/dev/null|grep -v \"%s:\"|expand",
-		 objdump_path ? objdump_path : "objdump",
+		 opts->objdump_path ?: "objdump",
 		 opts->disassembler_style ? "-M " : "",
 		 opts->disassembler_style ?: "",
 		 map__rip_2objdump(map, sym->start),
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 6e6e2a571928..a4c0d91907e6 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -80,6 +80,7 @@ struct annotation_options {
 	int  min_pcnt;
 	int  max_lines;
 	int  context;
+	const char *objdump_path;
 	const char *disassembler_style;
 };
 
