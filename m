Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB69C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A9C2218C3
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549478993;
	bh=/MC0Gzd0L5zRhLAMz3wCOA/bSygDjnJK+Arx+KrOghI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Zr7N/X5wXWxwhkZr/341p6gZJHLhoupGTD2R9clbUtEb/a94t067TXbN/7kX8+C+D
	 dXmupzHIacawWEu9pQUyXvb/tg6+jd+IDR0aDA6gRRNOzBJJa0jv45FNnmbZSvv1eP
	 PizJHkCGYgjsoPNkI93ptams+OE9Uoqy2hvovE+Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbfBFStv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 13:49:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:44140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727259AbfBFSts (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 13:49:48 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.41.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14B5B2083B;
        Wed,  6 Feb 2019 18:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549478988;
        bh=/MC0Gzd0L5zRhLAMz3wCOA/bSygDjnJK+Arx+KrOghI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hF91/PAqhlfQfA/7cV8bfQpWhKj+d1gXfxTN369eM7wiXoXqyU09QJeoSu2VOMRw4
         hO4hsz41NsVD8cgf4u5Gufij7NpFqgwKSdPnNMfc5ucizlrNAIa+VS0wSqD7MylFFG
         /YOFQ4Bzb0qDI+r7h+Jb/SoC5/VlXm4r8vzOzPbE=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 12/53] perf thread: Don't include symbol.h, symbol_conf.h is enough
Date:   Wed,  6 Feb 2019 15:48:22 -0300
Message-Id: <20190206184903.24054-13-acme@kernel.org>
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

Also add stdio.h to get the FILE definition.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-8vx5396phynuxhdsxxfbdhsk@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/thread.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
index 856cf1a9040a..8276ffeec556 100644
--- a/tools/perf/util/thread.h
+++ b/tools/perf/util/thread.h
@@ -5,14 +5,17 @@
 #include <linux/refcount.h>
 #include <linux/rbtree.h>
 #include <linux/list.h>
+#include <stdio.h>
 #include <unistd.h>
 #include <sys/types.h>
 #include "srccode.h"
-#include "symbol.h"
+#include "symbol_conf.h"
 #include <strlist.h>
 #include <intlist.h>
 #include "rwsem.h"
 
+struct addr_location;
+struct map;
 struct namespaces_event;
 struct thread_stack;
 struct unwind_libunwind_ops;
-- 
2.20.1

