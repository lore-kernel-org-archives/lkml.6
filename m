Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 509DFC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 23:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 180B420844
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 23:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548458530;
	bh=dDDLExZTewl/zJiSntUpbqLHhh3dqmxZOVjJ0BoXqCo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MCidu3FjFp8GspNCiuGVZvPx9baCNyX3bol47NjrTjtorsI7rdyQwbPEhf+HmRbxg
	 gnn5MMRkZxC18mxcwwlDqVbj4D5qUAQuE8T2sz3yv88e102FwhdaslnwmsB6R3NJIu
	 UDbk2SfYFAJCHIfUI2mRc4dzQ8LkNvebfcZ0/Zfw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729755AbfAYXWI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 18:22:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:47540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729654AbfAYXTA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 18:19:00 -0500
Received: from quaco.cust.in.nbox.cz (unknown [95.82.135.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8826218D0;
        Fri, 25 Jan 2019 23:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548458339;
        bh=dDDLExZTewl/zJiSntUpbqLHhh3dqmxZOVjJ0BoXqCo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e2Fl3jNg0lFOt3pT46AcLvKGX3UgPi7owlsXAfxHQdnIQxIM8D2tIdpsaymOOS2MQ
         3ixqBzRabWPGkKeCYqQJet3KijdH1Hkpr7IhAGLN9pqxu4RCCGe3lEn48V0YOymu7S
         ir7raiqIgpagSXVbtcI+CRcdIcHRywOD/4ilX1DY=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 04/29] perf block-range: Add missing headers
Date:   Sat, 26 Jan 2019 00:18:18 +0100
Message-Id: <20190125231843.2895-5-acme@kernel.org>
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

Some are being obtained indirectly and as we prune unnecessary includes,
this stops working, fix it by adding the headers for things used in
these file.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-1p65lyeebc2ose0lbozvemda@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/block-range.c | 2 ++
 tools/perf/util/block-range.h | 6 +++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/block-range.c b/tools/perf/util/block-range.c
index f1451c987eec..1be432657501 100644
--- a/tools/perf/util/block-range.c
+++ b/tools/perf/util/block-range.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "block-range.h"
 #include "annotate.h"
+#include <assert.h>
+#include <stdlib.h>
 
 struct {
 	struct rb_root root;
diff --git a/tools/perf/util/block-range.h b/tools/perf/util/block-range.h
index a5ba719d69fb..ec0fb534bf56 100644
--- a/tools/perf/util/block-range.h
+++ b/tools/perf/util/block-range.h
@@ -2,7 +2,11 @@
 #ifndef __PERF_BLOCK_RANGE_H
 #define __PERF_BLOCK_RANGE_H
 
-#include "symbol.h"
+#include <stdbool.h>
+#include <linux/rbtree.h>
+#include <linux/types.h>
+
+struct symbol;
 
 /*
  * struct block_range - non-overlapping parts of basic blocks
-- 
2.20.1

