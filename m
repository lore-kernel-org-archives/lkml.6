Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9813CC282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 12:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 651C621916
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 12:34:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfBIMes (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 07:34:48 -0500
Received: from terminus.zytor.com ([198.137.202.136]:60763 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbfBIMes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 07:34:48 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x19CYfAI2628399
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 9 Feb 2019 04:34:41 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x19CYftO2628396;
        Sat, 9 Feb 2019 04:34:41 -0800
Date:   Sat, 9 Feb 2019 04:34:41 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-6duflwliprh2tr47w5x4t260@git.kernel.org>
Cc:     adrian.hunter@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, jolsa@kernel.org,
        namhyung@kernel.org, acme@redhat.com, mingo@kernel.org,
        tglx@linutronix.de
Reply-To: tglx@linutronix.de, mingo@kernel.org, acme@redhat.com,
          namhyung@kernel.org, jolsa@kernel.org,
          linux-kernel@vger.kernel.org, hpa@zytor.com,
          adrian.hunter@intel.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf evsel: No need to include symbol.h in evsel.h,
 symbol_conf.h is enough
Git-Commit-ID: 9cd997f85e29c1c2b53e23fa98df7ec44c344d67
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

Commit-ID:  9cd997f85e29c1c2b53e23fa98df7ec44c344d67
Gitweb:     https://git.kernel.org/tip/9cd997f85e29c1c2b53e23fa98df7ec44c344d67
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 28 Jan 2019 00:06:16 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 6 Feb 2019 10:00:38 -0300

perf evsel: No need to include symbol.h in evsel.h, symbol_conf.h is enough

To reduce the header dependency and avoid unnecessary rebuilds when
things change in symbol.h.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-6duflwliprh2tr47w5x4t260@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 29c5eb68c44b..cc578e02e08f 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -8,7 +8,7 @@
 #include <linux/perf_event.h>
 #include <linux/types.h>
 #include "xyarray.h"
-#include "symbol.h"
+#include "symbol_conf.h"
 #include "cpumap.h"
 #include "counts.h"
 
