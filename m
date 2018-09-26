Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 641D8C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 186012083A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:43:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 186012083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbeIZOz2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 10:55:28 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43205 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbeIZOz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 10:55:27 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8Q8hQdm3769708
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 26 Sep 2018 01:43:26 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8Q8hQH23769705;
        Wed, 26 Sep 2018 01:43:26 -0700
Date:   Wed, 26 Sep 2018 01:43:26 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andi Kleen <tipbot@zytor.com>
Message-ID: <tip-c12e039d1233f24ab2726945f883037f47b26f1d@git.kernel.org>
Cc:     hpa@zytor.com, jolsa@kernel.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, kim.phillips@arm.com,
        tglx@linutronix.de, acme@redhat.com, ak@linux.intel.com
Reply-To: jolsa@kernel.org, hpa@zytor.com, mingo@kernel.org,
          tglx@linutronix.de, kim.phillips@arm.com,
          linux-kernel@vger.kernel.org, ak@linux.intel.com, acme@redhat.com
In-Reply-To: <20180914031038.4160-2-andi@firstfloor.org>
References: <20180914031038.4160-2-andi@firstfloor.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tools: Report itrace options in help
Git-Commit-ID: c12e039d1233f24ab2726945f883037f47b26f1d
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

Commit-ID:  c12e039d1233f24ab2726945f883037f47b26f1d
Gitweb:     https://git.kernel.org/tip/c12e039d1233f24ab2726945f883037f47b26f1d
Author:     Andi Kleen <ak@linux.intel.com>
AuthorDate: Thu, 13 Sep 2018 20:10:31 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 19 Sep 2018 15:06:59 -0300

perf tools: Report itrace options in help

I often forget all the options that --itrace accepts. Instead of burying
them in the man page only report them in the normal command line help
too to make them easier accessible.

v2: Align

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kim Phillips <kim.phillips@arm.com>
Link: http://lkml.kernel.org/r/20180914031038.4160-2-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-inject.c |  3 ++-
 tools/perf/builtin-report.c |  2 +-
 tools/perf/builtin-script.c |  2 +-
 tools/perf/util/auxtrace.h  | 19 +++++++++++++++++++
 4 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index b4a29f435b06..eda41673c4f3 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -798,7 +798,8 @@ int cmd_inject(int argc, const char **argv)
 			   "kallsyms pathname"),
 		OPT_BOOLEAN('f', "force", &data.force, "don't complain, do it"),
 		OPT_CALLBACK_OPTARG(0, "itrace", &inject.itrace_synth_opts,
-				    NULL, "opts", "Instruction Tracing options",
+				    NULL, "opts", "Instruction Tracing options\n"
+				    ITRACE_HELP,
 				    itrace_parse_synth_opts),
 		OPT_BOOLEAN(0, "strip", &inject.strip,
 			    "strip non-synthesized events (use with --itrace)"),
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 7507e4d6dce1..c0703979c51d 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1104,7 +1104,7 @@ int cmd_report(int argc, const char **argv)
 	OPT_CALLBACK(0, "percentage", NULL, "relative|absolute",
 		     "how to display percentage of filtered entries", parse_filter_percentage),
 	OPT_CALLBACK_OPTARG(0, "itrace", &itrace_synth_opts, NULL, "opts",
-			    "Instruction Tracing options",
+			    "Instruction Tracing options\n" ITRACE_HELP,
 			    itrace_parse_synth_opts),
 	OPT_BOOLEAN(0, "full-source-path", &srcline_full_filename,
 			"Show full source file name path for source lines"),
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 765391b6c88c..66699dd351e0 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -3193,7 +3193,7 @@ int cmd_script(int argc, const char **argv)
 	OPT_BOOLEAN(0, "ns", &nanosecs,
 		    "Use 9 decimal places when displaying time"),
 	OPT_CALLBACK_OPTARG(0, "itrace", &itrace_synth_opts, NULL, "opts",
-			    "Instruction Tracing options",
+			    "Instruction Tracing options\n" ITRACE_HELP,
 			    itrace_parse_synth_opts),
 	OPT_BOOLEAN(0, "full-source-path", &srcline_full_filename,
 			"Show full source file name path for source lines"),
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index a86b7eab6673..0a6ce9c4fc11 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -576,6 +576,23 @@ static inline void auxtrace__free(struct perf_session *session)
 	return session->auxtrace->free(session);
 }
 
+#define ITRACE_HELP \
+"				i:	    		synthesize instructions events\n"		\
+"				b:	    		synthesize branches events\n"		\
+"				c:	    		synthesize branches events (calls only)\n"	\
+"				r:	    		synthesize branches events (returns only)\n" \
+"				x:	    		synthesize transactions events\n"		\
+"				w:	    		synthesize ptwrite events\n"		\
+"				p:	    		synthesize power events\n"			\
+"				e:	    		synthesize error events\n"			\
+"				d:	    		create a debug log\n"			\
+"				g[len]:     		synthesize a call chain (use with i or x)\n" \
+"				l[len]:     		synthesize last branch entries (use with i or x)\n" \
+"				sNUMBER:    		skip initial number of events\n"		\
+"				PERIOD[ns|us|ms|i|t]:   specify period to sample stream\n" \
+"				concatenate multiple options. Default is ibxwpe or cewp\n"
+
+
 #else
 
 static inline struct auxtrace_record *
@@ -716,6 +733,8 @@ void auxtrace_mmap_params__set_idx(struct auxtrace_mmap_params *mp,
 				   struct perf_evlist *evlist, int idx,
 				   bool per_cpu);
 
+#define ITRACE_HELP ""
+
 #endif
 
 #endif
