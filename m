Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA5AAC282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 09:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BC82214C6
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 09:56:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729542AbfAZJ4V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 04:56:21 -0500
Received: from terminus.zytor.com ([198.137.202.136]:36485 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbfAZJ4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 04:56:21 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0Q9uEZx510008
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 26 Jan 2019 01:56:14 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0Q9uEdB510005;
        Sat, 26 Jan 2019 01:56:14 -0800
Date:   Sat, 26 Jan 2019 01:56:14 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-ytbykaku63862guk7muflcy4@git.kernel.org>
Cc:     namhyung@kernel.org, jolsa@kernel.org, mingo@kernel.org,
        tglx@linutronix.de, acme@redhat.com, linux-kernel@vger.kernel.org,
        adrian.hunter@intel.com, hpa@zytor.com
Reply-To: adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
          acme@redhat.com, hpa@zytor.com, mingo@kernel.org,
          jolsa@kernel.org, namhyung@kernel.org, tglx@linutronix.de
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf annotate: Remove lots of headers from
 annotate.h
Git-Commit-ID: 8a249c73a5cc0f578ef2c5a392e20336203ebe3a
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

Commit-ID:  8a249c73a5cc0f578ef2c5a392e20336203ebe3a
Gitweb:     https://git.kernel.org/tip/8a249c73a5cc0f578ef2c5a392e20336203ebe3a
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 22 Jan 2019 10:47:38 -0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 25 Jan 2019 15:12:08 +0100

perf annotate: Remove lots of headers from annotate.h

To reduce the chances changes trigger tons of rebuilds, more to come.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-ytbykaku63862guk7muflcy4@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/gtk/annotate.c   |  1 +
 tools/perf/util/annotate.h     | 14 +++++++++++---
 tools/perf/util/stat-display.c |  1 +
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/tools/perf/ui/gtk/annotate.c b/tools/perf/ui/gtk/annotate.c
index 48428c9acd89..f22a7d142ada 100644
--- a/tools/perf/ui/gtk/annotate.c
+++ b/tools/perf/ui/gtk/annotate.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "gtk.h"
+#include "util/sort.h"
 #include "util/debug.h"
 #include "util/annotate.h"
 #include "util/evsel.h"
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index fb6463730ba4..95053cab41fe 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -4,16 +4,24 @@
 
 #include <stdbool.h>
 #include <stdint.h>
+#include <stdio.h>
 #include <linux/types.h>
-#include "symbol.h"
-#include "hist.h"
-#include "sort.h"
 #include <linux/list.h>
 #include <linux/rbtree.h>
 #include <pthread.h>
 #include <asm/bug.h>
+#include "symbol_conf.h"
 
+struct hist_browser_timer;
+struct hist_entry;
 struct ins_ops;
+struct map;
+struct map_symbol;
+struct addr_map_symbol;
+struct option;
+struct perf_sample;
+struct perf_evsel;
+struct symbol;
 
 struct ins {
 	const char     *name;
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 665ee374fc01..6d043c78f3c2 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -2,6 +2,7 @@
 #include <inttypes.h>
 #include <linux/time64.h>
 #include <math.h>
+#include "color.h"
 #include "evlist.h"
 #include "evsel.h"
 #include "stat.h"
