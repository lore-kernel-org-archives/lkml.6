Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF72C282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 12:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACD3B21916
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 12:36:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbfBIMgK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 07:36:10 -0500
Received: from terminus.zytor.com ([198.137.202.136]:35675 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbfBIMgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 07:36:09 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x19Ca0Ye2628580
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 9 Feb 2019 04:36:00 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x19Ca0d32628577;
        Sat, 9 Feb 2019 04:36:00 -0800
Date:   Sat, 9 Feb 2019 04:36:00 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-6ebl3mwwiqocl79yts44qltu@git.kernel.org>
Cc:     mingo@kernel.org, namhyung@kernel.org, jolsa@kernel.org,
        adrian.hunter@intel.com, tglx@linutronix.de, hpa@zytor.com,
        linux-kernel@vger.kernel.org, acme@redhat.com
Reply-To: adrian.hunter@intel.com, jolsa@kernel.org, namhyung@kernel.org,
          mingo@kernel.org, tglx@linutronix.de, hpa@zytor.com,
          linux-kernel@vger.kernel.org, acme@redhat.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tools: Add missing include <callchain.h> in
 various places
Git-Commit-ID: b10ba7f1a278ce04d272b2b662f231552ab000ee
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

Commit-ID:  b10ba7f1a278ce04d272b2b662f231552ab000ee
Gitweb:     https://git.kernel.org/tip/b10ba7f1a278ce04d272b2b662f231552ab000ee
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 29 Jan 2019 11:11:04 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 6 Feb 2019 10:00:38 -0300

perf tools: Add missing include <callchain.h> in various places

Its getting it from hist.h and that will go away, as that header doesn't
need callchain.h at all.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-6ebl3mwwiqocl79yts44qltu@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/hists.c | 1 +
 tools/perf/ui/gtk/hists.c      | 1 +
 tools/perf/ui/hist.c           | 1 +
 tools/perf/ui/stdio/hist.c     | 1 +
 tools/perf/util/config.c       | 1 +
 tools/perf/util/hist.c         | 1 +
 6 files changed, 6 insertions(+)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index ac176b48178c..aef800d97ea1 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -8,6 +8,7 @@
 #include <linux/rbtree.h>
 #include <sys/ttydefaults.h>
 
+#include "../../util/callchain.h"
 #include "../../util/evsel.h"
 #include "../../util/evlist.h"
 #include "../../util/hist.h"
diff --git a/tools/perf/ui/gtk/hists.c b/tools/perf/ui/gtk/hists.c
index 74414ccd8c84..0c08890f006a 100644
--- a/tools/perf/ui/gtk/hists.c
+++ b/tools/perf/ui/gtk/hists.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "../evlist.h"
 #include "../cache.h"
+#include "../callchain.h"
 #include "../evsel.h"
 #include "../sort.h"
 #include "../hist.h"
diff --git a/tools/perf/ui/hist.c b/tools/perf/ui/hist.c
index fe3dfaa64a91..412d6f1626e3 100644
--- a/tools/perf/ui/hist.c
+++ b/tools/perf/ui/hist.c
@@ -3,6 +3,7 @@
 #include <math.h>
 #include <linux/compiler.h>
 
+#include "../util/callchain.h"
 #include "../util/hist.h"
 #include "../util/util.h"
 #include "../util/sort.h"
diff --git a/tools/perf/ui/stdio/hist.c b/tools/perf/ui/stdio/hist.c
index f25116f70878..a60f2993d390 100644
--- a/tools/perf/ui/stdio/hist.c
+++ b/tools/perf/ui/stdio/hist.c
@@ -2,6 +2,7 @@
 #include <stdio.h>
 #include <linux/string.h>
 
+#include "../../util/callchain.h"
 #include "../../util/util.h"
 #include "../../util/hist.h"
 #include "../../util/map.h"
diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
index 1ea8f898f1a1..fa092511c52b 100644
--- a/tools/perf/util/config.c
+++ b/tools/perf/util/config.c
@@ -13,6 +13,7 @@
 #include <sys/param.h>
 #include "util.h"
 #include "cache.h"
+#include "callchain.h"
 #include <subcmd/exec-cmd.h>
 #include "util/event.h"  /* proc_map_timeout */
 #include "util/hist.h"  /* perf_hist_config */
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 3560ad2e5551..7f9df74ab893 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include "callchain.h"
 #include "util.h"
 #include "build-id.h"
 #include "hist.h"
