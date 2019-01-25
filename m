Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80534C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 23:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46ECF20844
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 23:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548458519;
	bh=xogMiRAe51Bws4C9g63LywDcPGQNK/qu8p7DVNPc4Ls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2Y7qA4aLsebvpN/jfSLt62SI/o8A71dlknO2W31bCyag7zxewMnlg8PMTGQBvrO06
	 BFdoZsUYnvvuIF4D3ny1NjvsgKnZHxm8RiuRmBhM4zYbD91dJSfR5igxKwROH/pfMz
	 ucunHZrufB8JT+N1ifi66At0y9Np+sd2fwkyrwOU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729707AbfAYXTF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 18:19:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:47564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729672AbfAYXTC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 18:19:02 -0500
Received: from quaco.cust.in.nbox.cz (unknown [95.82.135.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC467218FF;
        Fri, 25 Jan 2019 23:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548458341;
        bh=xogMiRAe51Bws4C9g63LywDcPGQNK/qu8p7DVNPc4Ls=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VPBL6HtPlaxgrC0FFAhMoMVrOlu3AEVPtdhP31wHHabgorgcLHdwbwZFAYj33W+Vo
         VgrjPhgGDEuhz98CO+T1a5LgtcsFl17KRdQ75pRC9qg7oC/UU0DpGQ4U+yRC8T5zxE
         FzuPNWEJJs9puVZa3vgqvyaI++Z0ExFFolx9x5nM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 05/29] perf symbols: Remove include map.h from dso.h
Date:   Sat, 26 Jan 2019 00:18:19 +0100
Message-Id: <20190125231843.2895-6-acme@kernel.org>
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

Disentangling the dependency tree, to reduce build time.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-n2gcrfmh480rm44p7fra13vv@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/map.c     | 1 +
 tools/perf/util/dso.h            | 4 +++-
 tools/perf/util/symbol_fprintf.c | 1 +
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/ui/browsers/map.c b/tools/perf/ui/browsers/map.c
index 5b8b8c637686..c70d9337405b 100644
--- a/tools/perf/ui/browsers/map.c
+++ b/tools/perf/ui/browsers/map.c
@@ -6,6 +6,7 @@
 #include <linux/bitops.h>
 #include "../../util/util.h"
 #include "../../util/debug.h"
+#include "../../util/map.h"
 #include "../../util/symbol.h"
 #include "../browser.h"
 #include "../helpline.h"
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index af2eda29660f..56001b82d448 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -7,12 +7,14 @@
 #include <linux/rbtree.h>
 #include <sys/types.h>
 #include <stdbool.h>
+#include <stdio.h>
 #include "rwsem.h"
 #include <linux/bitops.h>
-#include "map.h"
 #include "namespaces.h"
 #include "build-id.h"
 
+struct map;
+
 enum dso_binary_type {
 	DSO_BINARY_TYPE__KALLSYMS = 0,
 	DSO_BINARY_TYPE__GUEST_KALLSYMS,
diff --git a/tools/perf/util/symbol_fprintf.c b/tools/perf/util/symbol_fprintf.c
index ed0205cc7942..50472c75da59 100644
--- a/tools/perf/util/symbol_fprintf.c
+++ b/tools/perf/util/symbol_fprintf.c
@@ -3,6 +3,7 @@
 #include <inttypes.h>
 #include <stdio.h>
 
+#include "map.h"
 #include "symbol.h"
 
 size_t symbol__fprintf(struct symbol *sym, FILE *fp)
-- 
2.20.1

