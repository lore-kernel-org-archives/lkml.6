Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3057C282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 12:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87A0B218D2
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 12:29:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbfBIM3c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 07:29:32 -0500
Received: from terminus.zytor.com ([198.137.202.136]:37147 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726724AbfBIM3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 07:29:31 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x19CTN5G2627524
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 9 Feb 2019 04:29:23 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x19CTNXl2627521;
        Sat, 9 Feb 2019 04:29:23 -0800
Date:   Sat, 9 Feb 2019 04:29:23 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-64lrkjjaa7wlo1zi2gr5u3es@git.kernel.org>
Cc:     adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
        namhyung@kernel.org, mingo@kernel.org, acme@redhat.com,
        ak@linux.intel.com, jolsa@kernel.org, tglx@linutronix.de,
        hpa@zytor.com
Reply-To: mingo@kernel.org, namhyung@kernel.org, adrian.hunter@intel.com,
          linux-kernel@vger.kernel.org, hpa@zytor.com, jolsa@kernel.org,
          tglx@linutronix.de, ak@linux.intel.com, acme@redhat.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf srccode: Move struct definition from map.h to
 srccode.h
Git-Commit-ID: 4fed072609b8aae27eac7169033f762867a5ab4c
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

Commit-ID:  4fed072609b8aae27eac7169033f762867a5ab4c
Gitweb:     https://git.kernel.org/tip/4fed072609b8aae27eac7169033f762867a5ab4c
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Sun, 27 Jan 2019 11:31:39 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 6 Feb 2019 10:00:38 -0300

perf srccode: Move struct definition from map.h to srccode.h

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
