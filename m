Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D44C282C2
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17094218B0
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549478997;
	bh=axHoVg+pzMTo4DnhV7+08VAF7n0YAXyAvWc44jEX0x4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HAEge4jEn4ZfxCEjiz7UrIAB3pNz/3chryhWZ1y3TJalmF24kd507dKTPME1GbvbM
	 G9OwyIhIrhaHodXBc+0ccmjRr15YA/RiTPNB081fQzDuRrax/9pA9SAGF8oXX4Z3Oh
	 cJZgNWD1e+xfWd/5rD69BJcYyoBbHi+wHErCwAkQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbfBFStz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 13:49:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:44178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727269AbfBFStv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 13:49:51 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.41.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67F32206DD;
        Wed,  6 Feb 2019 18:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549478990;
        bh=axHoVg+pzMTo4DnhV7+08VAF7n0YAXyAvWc44jEX0x4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qaf4v3b6j/iD8wrOk1nuhYzg827JWpsLdJDiOisfP5dppYVPpo+A3EI+G/2Dff2Tp
         P1zeOpaw4/V5zYa1Q1xAZ04zqjRVVOl5kR5Ec1TVbCWR8VIhvRmPsMctizWr17byBm
         sfXic5r3FvB6JYDvXyA2NXhCia5HidGd1Oz2dK04=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 13/53] perf tools: Add missing include <callchain.h> in various places
Date:   Wed,  6 Feb 2019 15:48:23 -0300
Message-Id: <20190206184903.24054-14-acme@kernel.org>
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
-- 
2.20.1

