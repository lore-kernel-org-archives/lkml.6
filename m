Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A476C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57FAB218D2
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549478971;
	bh=nfg3y+FMh8aQk7KbyNjqliGpkpmghmtMYoeoolG5v7k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Y2BwrxxMt73kptJ2I4iVQVxN1kcO6uE0YP73vK5fGsiShHxgxQ/YDVzuIQ/fphxR2
	 sg2PoUzrQQc3TpNsnRhPciSHL1I3VkojJu8tHCwqW9Gavmud+mAfBWLV24iS65PTgy
	 QVUbzUWcUyXVdy8oMthvIHIRw8wKZGr2X5RaouTA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfBFSt3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 13:49:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:43756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726880AbfBFSt1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 13:49:27 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.41.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 684D72186A;
        Wed,  6 Feb 2019 18:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549478966;
        bh=nfg3y+FMh8aQk7KbyNjqliGpkpmghmtMYoeoolG5v7k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TqsDpQDTE/65zyKANh/2hf5gRJSvkqG1wHzeKY2GMDp7fXd+pHFwiblPoEl3iwA26
         f0qQzTy+Mw9xPDuS2m9ZLedi0S5ZYt3/pdNqWX7LrV6Z0pa436DQA/ICKDgSaUeyJh
         JIwGaVatZN9zdPzIqAl+EzXDCNuLKCdaZt3vL+2g=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 03/53] perf srccode: Move struct definition from map.h to srccode.h
Date:   Wed,  6 Feb 2019 15:48:13 -0300
Message-Id: <20190206184903.24054-4-acme@kernel.org>
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

To reduce the header dependencies, since we already have a srccode.h
header, then there is where the 'struct srccode_state' should be, and
map.h, that is more widely used should have just a forward declaraion
of 'struct srccode_state'.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-64lrkjjaa7wlo1zi2gr5u3es@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/map.h     | 13 +------------
 tools/perf/util/srccode.h | 13 +++++++++++++
 tools/perf/util/thread.h  |  2 +-
 3 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index 09282aa45c80..5a889db4fca5 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -174,18 +174,7 @@ char *map__srcline(struct map *map, u64 addr, struct symbol *sym);
 int map__fprintf_srcline(struct map *map, u64 addr, const char *prefix,
 			 FILE *fp);
 
-struct srccode_state {
-	char *srcfile;
-	unsigned line;
-};
-
-static inline void srccode_state_init(struct srccode_state *state)
-{
-	state->srcfile = NULL;
-	state->line = 0;
-}
-
-void srccode_state_free(struct srccode_state *state);
+struct srccode_state;
 
 int map__fprintf_srccode(struct map *map, u64 addr,
 			 FILE *fp, struct srccode_state *state);
diff --git a/tools/perf/util/srccode.h b/tools/perf/util/srccode.h
index e500a746d5f1..1b5ed769779c 100644
--- a/tools/perf/util/srccode.h
+++ b/tools/perf/util/srccode.h
@@ -1,6 +1,19 @@
 #ifndef SRCCODE_H
 #define SRCCODE_H 1
 
+struct srccode_state {
+	char	 *srcfile;
+	unsigned line;
+};
+
+static inline void srccode_state_init(struct srccode_state *state)
+{
+	state->srcfile = NULL;
+	state->line    = 0;
+}
+
+void srccode_state_free(struct srccode_state *state);
+
 /* Result is not 0 terminated */
 char *find_sourceline(char *fn, unsigned line, int *lenp);
 
diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
index f3c939150f90..856cf1a9040a 100644
--- a/tools/perf/util/thread.h
+++ b/tools/perf/util/thread.h
@@ -7,8 +7,8 @@
 #include <linux/list.h>
 #include <unistd.h>
 #include <sys/types.h>
+#include "srccode.h"
 #include "symbol.h"
-#include "map.h"
 #include <strlist.h>
 #include <intlist.h>
 #include "rwsem.h"
-- 
2.20.1

