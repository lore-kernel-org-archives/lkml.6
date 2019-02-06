Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4095BC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BD08218DA
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549479003;
	bh=9ZMLu0XgM1t9SJ1W5MUB/YWao1+nxNVkwXc496IMGDg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CYwOeEL2r1XVz1+CiBxEP7Fng9q1xDJlcGhBAw6xHdgIMbIsci/xqbodFOR00wjwI
	 FzGXmmbvBqLMVCFkQHUpbCkEiCmH1xJC1A/Au0JuC7+X1eQsCWiE8ssleaT41VwDam
	 gV7nnz/n+doxgxOiGFVM2C7HwR1I1PzXoKO9kGzE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbfBFSuB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 13:50:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:44262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727350AbfBFSt6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 13:49:58 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.41.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F7F9206DD;
        Wed,  6 Feb 2019 18:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549478997;
        bh=9ZMLu0XgM1t9SJ1W5MUB/YWao1+nxNVkwXc496IMGDg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kf/Zgx5D2MLq7GMnGcoUo0262E6nThjY1CuHr8upYDh9nnWeXEE8YElVQLehupZj2
         fGg7/i1M0qk8DmhH/lfYGS9tEYm2h8egO+as7cpfrfPJpB2LwKaxNX4JdPlM3rr7pI
         MFz/RkwzTWkbhHyU6dUrnpGdLpnwR69g2unumfqo=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 16/53] perf pmu: Remove needless evsel.h include, only needs one fwd decl
Date:   Wed,  6 Feb 2019 15:48:26 -0300
Message-Id: <20190206184903.24054-17-acme@kernel.org>
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

To reduce the header dependency tree.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-rc389o1z0htwukqv6ni1viun@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/pmu.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 76fecec7b3f9..ffed23fb920a 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -6,9 +6,10 @@
 #include <linux/compiler.h>
 #include <linux/perf_event.h>
 #include <stdbool.h>
-#include "evsel.h"
 #include "parse-events.h"
 
+struct perf_evsel_config_term;
+
 enum {
 	PERF_PMU_FORMAT_VALUE_CONFIG,
 	PERF_PMU_FORMAT_VALUE_CONFIG1,
-- 
2.20.1

