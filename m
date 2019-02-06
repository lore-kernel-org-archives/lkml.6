Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F1CBC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69B7D2070B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549479257;
	bh=Q79efpcVUXGcajEnPRcvQuV2ZxhULUcIf/cX9z5WcJM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=y1Wnp1sq1B06x7ittIAwOxnmAbW1vEaE4w4g8KIVMOoDd1uQosiOSO9l0m0gC/8UO
	 Wu5zbKfQEiaufQivOwIsxIg6JCtLPIeQ9l9TD7WoIaRFZZy97cjv4yg5Nxbc3y0aXB
	 I/7iq6wl2Y3IxQgFnAK7Ke4WUzZ1N1kCiHHkPuRQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbfBFSyP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 13:54:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:44282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727368AbfBFSuA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 13:50:00 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.41.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE457218B0;
        Wed,  6 Feb 2019 18:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549478999;
        bh=Q79efpcVUXGcajEnPRcvQuV2ZxhULUcIf/cX9z5WcJM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lNFUgjcFuoQRT1dH5WmFmwz2XHvR7+LE0wwQsqD/I//YrEUVLLB8DeH2sVSy/zLns
         kd6mKNclJQ3Zxbkmznm+cue2Y5xZn4gqLSbkxyzgsCStM3gx9myBlueexl8MM8cZ6F
         GrVt71GFVmnVyE+1U950O7qHvAqu3iebJ+1oV7bA=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 17/53] perf kvm stat: Replace kvm-stat.h includes with forward declarations
Date:   Wed,  6 Feb 2019 15:48:27 -0300
Message-Id: <20190206184903.24054-18-acme@kernel.org>
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

To reduce the include header dependency tree and speed up perf builds.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-dngwaxuhfnhksawgdpo6e74n@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/powerpc/util/kvm-stat.c | 1 +
 tools/perf/arch/s390/util/kvm-stat.c    | 1 +
 tools/perf/arch/x86/util/kvm-stat.c     | 1 +
 tools/perf/util/kvm-stat.h              | 7 ++++---
 4 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/perf/arch/powerpc/util/kvm-stat.c b/tools/perf/arch/powerpc/util/kvm-stat.c
index 596ad6aedaac..86e64c47d8ea 100644
--- a/tools/perf/arch/powerpc/util/kvm-stat.c
+++ b/tools/perf/arch/powerpc/util/kvm-stat.c
@@ -3,6 +3,7 @@
 #include "util/kvm-stat.h"
 #include "util/parse-events.h"
 #include "util/debug.h"
+#include "util/evsel.h"
 
 #include "book3s_hv_exits.h"
 #include "book3s_hcalls.h"
diff --git a/tools/perf/arch/s390/util/kvm-stat.c b/tools/perf/arch/s390/util/kvm-stat.c
index aaabab5e2830..7e3961a4b292 100644
--- a/tools/perf/arch/s390/util/kvm-stat.c
+++ b/tools/perf/arch/s390/util/kvm-stat.c
@@ -11,6 +11,7 @@
 
 #include <errno.h>
 #include "../../util/kvm-stat.h"
+#include "../../util/evsel.h"
 #include <asm/sie.h>
 
 define_exit_reasons_table(sie_exit_reasons, sie_intercept_code);
diff --git a/tools/perf/arch/x86/util/kvm-stat.c b/tools/perf/arch/x86/util/kvm-stat.c
index 081353d7b095..865a9762f22e 100644
--- a/tools/perf/arch/x86/util/kvm-stat.c
+++ b/tools/perf/arch/x86/util/kvm-stat.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <errno.h>
 #include "../../util/kvm-stat.h"
+#include "../../util/evsel.h"
 #include <asm/svm.h>
 #include <asm/vmx.h>
 #include <asm/kvm.h>
diff --git a/tools/perf/util/kvm-stat.h b/tools/perf/util/kvm-stat.h
index 7b1f06567521..1403dec189b4 100644
--- a/tools/perf/util/kvm-stat.h
+++ b/tools/perf/util/kvm-stat.h
@@ -3,12 +3,13 @@
 #define __PERF_KVM_STAT_H
 
 #include "../perf.h"
-#include "evsel.h"
-#include "evlist.h"
-#include "session.h"
 #include "tool.h"
 #include "stat.h"
 
+struct perf_evsel;
+struct perf_evlist;
+struct perf_session;
+
 struct event_key {
 	#define INVALID_KEY     (~0ULL)
 	u64 key;
-- 
2.20.1

