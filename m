Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 886FDC282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 12:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 590CD21916
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 12:33:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbfBIMdb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 07:33:31 -0500
Received: from terminus.zytor.com ([198.137.202.136]:45747 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbfBIMda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 07:33:30 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x19CXM3B2628300
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 9 Feb 2019 04:33:23 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x19CXMGZ2628297;
        Sat, 9 Feb 2019 04:33:22 -0800
Date:   Sat, 9 Feb 2019 04:33:22 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-cmvg5ght75mmfg1efeyna9rn@git.kernel.org>
Cc:     mingo@kernel.org, namhyung@kernel.org, acme@redhat.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org, jolsa@kernel.org,
        adrian.hunter@intel.com, tglx@linutronix.de
Reply-To: namhyung@kernel.org, hpa@zytor.com, acme@redhat.com,
          mingo@kernel.org, adrian.hunter@intel.com, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, jolsa@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf hist: Remove symbol.h from hist.h, just fwd
 decls are needed
Git-Commit-ID: 7cadca8e1b4ae95f8be37d8da246eae8ebf5fb3a
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

Commit-ID:  7cadca8e1b4ae95f8be37d8da246eae8ebf5fb3a
Gitweb:     https://git.kernel.org/tip/7cadca8e1b4ae95f8be37d8da246eae8ebf5fb3a
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Sun, 27 Jan 2019 14:10:31 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 6 Feb 2019 10:00:38 -0300

perf hist: Remove symbol.h from hist.h, just fwd decls are needed

To reduce the includes dependencies.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-cmvg5ght75mmfg1efeyna9rn@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/gtk/annotate.c | 1 +
 tools/perf/util/auxtrace.c   | 1 +
 tools/perf/util/callchain.c  | 1 +
 tools/perf/util/hist.h       | 3 ++-
 4 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/ui/gtk/annotate.c b/tools/perf/ui/gtk/annotate.c
index f42666ee0672..df49c9ba1785 100644
--- a/tools/perf/ui/gtk/annotate.c
+++ b/tools/perf/ui/gtk/annotate.c
@@ -5,6 +5,7 @@
 #include "util/annotate.h"
 #include "util/evsel.h"
 #include "util/map.h"
+#include "util/symbol.h"
 #include "ui/helpline.h"
 #include <inttypes.h>
 #include <signal.h>
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index f69961c4a4f3..94a22cc8004c 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -41,6 +41,7 @@
 #include "pmu.h"
 #include "evsel.h"
 #include "cpumap.h"
+#include "symbol.h"
 #include "thread_map.h"
 #include "asm/bug.h"
 #include "auxtrace.h"
diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index cc47dba973f2..abb608b09269 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -26,6 +26,7 @@
 #include "map.h"
 #include "callchain.h"
 #include "branch.h"
+#include "symbol.h"
 
 #define CALLCHAIN_PARAM_DEFAULT			\
 	.mode		= CHAIN_GRAPH_ABS,	\
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index f50aad24928e..38a72eb81427 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -8,12 +8,13 @@
 #include "evsel.h"
 #include "header.h"
 #include "color.h"
-#include "symbol.h"
 #include "ui/progress.h"
 
 struct hist_entry;
 struct hist_entry_ops;
 struct addr_location;
+struct mem_info;
+struct branch_info;
 struct symbol;
 
 enum hist_filter {
