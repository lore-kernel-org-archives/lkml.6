Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A3B6C282C2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 23:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5861B218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 23:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548458343;
	bh=FUh0fQYYMoqcGPGRZGCvV7DyYTpP0x749huxyy0hbrU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KN+ZpgZDD4DcLDmX95+H2gyieti3rJOv3IaGd/jaCecchYe4sZEG3cqrRLIEQ8gvT
	 eV+Nb0xyXyFs7YnIJaus9ZB+78nYpyj6438yjE4AZQIQTL8l7plVhoRUcmhhA8LY1B
	 wYZbEGxnQc29f+PWDTRKVyZiSRAQHS03/febPEDU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729682AbfAYXTC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 18:19:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:47460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729637AbfAYXS4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 18:18:56 -0500
Received: from quaco.cust.in.nbox.cz (unknown [95.82.135.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFEDD218FF;
        Fri, 25 Jan 2019 23:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548458335;
        bh=FUh0fQYYMoqcGPGRZGCvV7DyYTpP0x749huxyy0hbrU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nKgSqOA5ZLuF3jccCIo0azoGemeZdahQWCfpEM/X96bUCp3QRZkJfLRcsTq3BQEBq
         yj4VwpVMOBJjo2VZy58RifXESqfF4DnyrwjhWHHzPQuHOA9bzvGIjrRXZNkIHG0oSn
         Yfc/VvuPhj7sim4zvsJ8X9EFPLviIdmOyB3QElPI=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 02/29] perf annotate: Remove lots of headers from annotate.h
Date:   Sat, 26 Jan 2019 00:18:16 +0100
Message-Id: <20190125231843.2895-3-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190125231843.2895-1-acme@kernel.org>
References: <20190125231843.2895-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
-- 
2.20.1

