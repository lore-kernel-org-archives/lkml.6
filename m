Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B53B3C282C2
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82FF12186A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549478987;
	bh=o8uIxCcIoF0hOFEN1vPINJ/plIKMNROwZf6gVOdadoM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wX9Aqf6yd//nUaQTLrMrCprgeNfholFthgpG3QEq1NcWSWqrybfdJwa1i0tBLf8dV
	 SQHbRbrHQWl4oIMxue14bkWHt9g5xe9onliYlH6KnBYJDlTZJeDlG1YAMi9C277sJt
	 n3WATAnf8vXzROcAXvE8p4oCiG5+Fq6s7yEKBquE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbfBFStp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 13:49:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:44030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727180AbfBFStl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 13:49:41 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.41.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE033206DD;
        Wed,  6 Feb 2019 18:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549478980;
        bh=o8uIxCcIoF0hOFEN1vPINJ/plIKMNROwZf6gVOdadoM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c+OltE04969+MnncEixiITGmwhXd3qWBhfd6I1f3/4h/tSzJTW98O+NxtVl4+ABtG
         3wti/y6/8CDEHY0Uxd8IGVxPNxruM8Jphx7LNAipa5/ZGrX8Ya/HW015f4Zfp2WY6N
         KPLyVJvogxlOpK1dQEl5n28RjI0n9dDqFMy8MQMw=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 09/53] perf hist: Remove symbol.h from hist.h, just fwd decls are needed
Date:   Wed,  6 Feb 2019 15:48:19 -0300
Message-Id: <20190206184903.24054-10-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190206184903.24054-1-acme@kernel.org>
References: <20190206184903.24054-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
-- 
2.20.1

