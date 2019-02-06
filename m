Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5535AC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 245A1218B0
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549478989;
	bh=HMYqZhuniqdwFejBdxjkiaqgqvE82YV09El7G2q5yWM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LViDWepaAVyDiv+QpqyK30ohsgTlHyjmSotEMW7oMSae397SfQx7iVr9h90OQ/2NZ
	 MvNDZQ+PSCZub0ZSCRtDkOUS2OjhpHkrlEmpvlYEGbNYxCIWcXW9KF1SnziB90gC+Y
	 OOrFk2hMImbG6WOZm1Yg3D+YxXruqOLdsjE14B84=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbfBFStr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 13:49:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:44088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727230AbfBFStq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 13:49:46 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.41.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA325206DD;
        Wed,  6 Feb 2019 18:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549478985;
        bh=HMYqZhuniqdwFejBdxjkiaqgqvE82YV09El7G2q5yWM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=USR+zO0/7Cpa2lHPNLzrF2Roy3o3G0uzVNebECCIMi1Z6t4ErrOWdx1YqH8ep2Ezd
         pY/VmhNtQbsCzhyn76wgqxsK/r9WHQs2wPjR1MAhdcyBQ/Fn/NejjeDp7ibO+MYyC1
         PZadHYLQoRN/PwcBJM6tL0lQLVNqWAJVP9dckpVo=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 11/53] perf evsel: No need to include symbol.h in evsel.h, symbol_conf.h is enough
Date:   Wed,  6 Feb 2019 15:48:21 -0300
Message-Id: <20190206184903.24054-12-acme@kernel.org>
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
 
-- 
2.20.1

