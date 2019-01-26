Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD96AC282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 09:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3C78218B0
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 09:57:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729615AbfAZJ5g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 04:57:36 -0500
Received: from terminus.zytor.com ([198.137.202.136]:38075 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbfAZJ5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 04:57:36 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0Q9vU2V510307
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 26 Jan 2019 01:57:30 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0Q9vUK2510304;
        Sat, 26 Jan 2019 01:57:30 -0800
Date:   Sat, 26 Jan 2019 01:57:30 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-1p65lyeebc2ose0lbozvemda@git.kernel.org>
Cc:     hpa@zytor.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        adrian.hunter@intel.com, acme@redhat.com, namhyung@kernel.org,
        mingo@kernel.org, tglx@linutronix.de
Reply-To: hpa@zytor.com, linux-kernel@vger.kernel.org, jolsa@kernel.org,
          adrian.hunter@intel.com, acme@redhat.com, namhyung@kernel.org,
          mingo@kernel.org, tglx@linutronix.de
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf block-range: Add missing headers
Git-Commit-ID: e7a795d3ba62897d326f1732d01325594a6ef64f
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

Commit-ID:  e7a795d3ba62897d326f1732d01325594a6ef64f
Gitweb:     https://git.kernel.org/tip/e7a795d3ba62897d326f1732d01325594a6ef64f
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 22 Jan 2019 11:03:49 -0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 25 Jan 2019 15:12:09 +0100

perf block-range: Add missing headers

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
