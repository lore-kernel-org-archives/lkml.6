Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F207C282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 12:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4614A218D2
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 12:30:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbfBIMav (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 07:30:51 -0500
Received: from terminus.zytor.com ([198.137.202.136]:53925 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbfBIMav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 07:30:51 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x19CUhdb2627885
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 9 Feb 2019 04:30:43 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x19CUhhC2627882;
        Sat, 9 Feb 2019 04:30:43 -0800
Date:   Sat, 9 Feb 2019 04:30:43 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-l32z2qyhs6fe8unf4gk2ead2@git.kernel.org>
Cc:     tglx@linutronix.de, jolsa@kernel.org, namhyung@kernel.org,
        hpa@zytor.com, adrian.hunter@intel.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, acme@redhat.com
Reply-To: hpa@zytor.com, namhyung@kernel.org, tglx@linutronix.de,
          jolsa@kernel.org, adrian.hunter@intel.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org, acme@redhat.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf symbols: Introduce map_symbol.h
Git-Commit-ID: 9f4e8ff27a807dd6919faa0ecb2a152c57cfa5b2
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

Commit-ID:  9f4e8ff27a807dd6919faa0ecb2a152c57cfa5b2
Gitweb:     https://git.kernel.org/tip/9f4e8ff27a807dd6919faa0ecb2a152c57cfa5b2
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Sun, 27 Jan 2019 12:02:41 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 6 Feb 2019 10:00:38 -0300

perf symbols: Introduce map_symbol.h

To allow headers just wanting this definition to be able to get it
without all the things in symbol.h, to reduce the include dep tree.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-l32z2qyhs6fe8unf4gk2ead2@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/callchain.h  |  2 +-
 tools/perf/util/hist.h       |  1 +
 tools/perf/util/map_symbol.h | 22 ++++++++++++++++++++++
 tools/perf/util/sort.h       |  3 ++-
 tools/perf/util/symbol.h     | 14 +-------------
 5 files changed, 27 insertions(+), 15 deletions(-)

diff --git a/tools/perf/util/callchain.h b/tools/perf/util/callchain.h
index b6f18c2d4b14..80e056a3d882 100644
--- a/tools/perf/util/callchain.h
+++ b/tools/perf/util/callchain.h
@@ -5,7 +5,7 @@
 #include <linux/list.h>
 #include <linux/rbtree.h>
 #include "event.h"
-#include "symbol.h"
+#include "map_symbol.h"
 #include "branch.h"
 
 struct map;
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 08267af7439c..f50aad24928e 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -8,6 +8,7 @@
 #include "evsel.h"
 #include "header.h"
 #include "color.h"
+#include "symbol.h"
 #include "ui/progress.h"
 
 struct hist_entry;
diff --git a/tools/perf/util/map_symbol.h b/tools/perf/util/map_symbol.h
new file mode 100644
index 000000000000..5a1aed9f6bb4
--- /dev/null
+++ b/tools/perf/util/map_symbol.h
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0
+#ifndef __PERF_MAP_SYMBOL
+#define __PERF_MAP_SYMBOL 1
+
+#include <linux/types.h>
+
+struct map;
+struct symbol;
+
+struct map_symbol {
+	struct map    *map;
+	struct symbol *sym;
+};
+
+struct addr_map_symbol {
+	struct map    *map;
+	struct symbol *sym;
+	u64	      addr;
+	u64	      al_addr;
+	u64	      phys_addr;
+};
+#endif // __PERF_MAP_SYMBOL
diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
index dd6312876492..2fbee0b1011c 100644
--- a/tools/perf/util/sort.h
+++ b/tools/perf/util/sort.h
@@ -9,7 +9,8 @@
 #include <linux/list.h>
 #include "cache.h"
 #include <linux/rbtree.h>
-#include "symbol.h"
+#include "map_symbol.h"
+#include "symbol_conf.h"
 #include "string.h"
 #include "callchain.h"
 #include "values.h"
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 56e2bcb907cc..9a8fe012910a 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -8,6 +8,7 @@
 #include <linux/list.h>
 #include <linux/rbtree.h>
 #include <stdio.h>
+#include "map_symbol.h"
 #include "branch.h"
 #include "path.h"
 #include "symbol_conf.h"
@@ -115,19 +116,6 @@ struct ref_reloc_sym {
 	u64		unrelocated_addr;
 };
 
-struct map_symbol {
-	struct map    *map;
-	struct symbol *sym;
-};
-
-struct addr_map_symbol {
-	struct map    *map;
-	struct symbol *sym;
-	u64	      addr;
-	u64	      al_addr;
-	u64	      phys_addr;
-};
-
 struct branch_info {
 	struct addr_map_symbol from;
 	struct addr_map_symbol to;
