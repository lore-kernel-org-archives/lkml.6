Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A26D7C282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 09:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CD9D218CD
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 09:59:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729660AbfAZJ7a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 04:59:30 -0500
Received: from terminus.zytor.com ([198.137.202.136]:42355 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbfAZJ7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 04:59:30 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0Q9xMj5510455
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 26 Jan 2019 01:59:22 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0Q9xMQ4510452;
        Sat, 26 Jan 2019 01:59:22 -0800
Date:   Sat, 26 Jan 2019 01:59:22 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-wsjxzt99p83jubt6hu0med0f@git.kernel.org>
Cc:     tglx@linutronix.de, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com, mingo@kernel.org,
        jolsa@kernel.org, adrian.hunter@intel.com, acme@redhat.com
Reply-To: linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de,
          namhyung@kernel.org, mingo@kernel.org, jolsa@kernel.org,
          acme@redhat.com, adrian.hunter@intel.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf namespaces: Remove namespaces.h from .h
 headers
Git-Commit-ID: 40f3b2d20b52b090976a60fe56fb838a45eb362f
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

Commit-ID:  40f3b2d20b52b090976a60fe56fb838a45eb362f
Gitweb:     https://git.kernel.org/tip/40f3b2d20b52b090976a60fe56fb838a45eb362f
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 22 Jan 2019 11:24:34 -0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 25 Jan 2019 15:12:09 +0100

perf namespaces: Remove namespaces.h from .h headers

There we need just forward declarations, so remove it and add it just on
the .c files that actually touch the struct definitions.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-wsjxzt99p83jubt6hu0med0f@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-probe.c    | 1 +
 tools/perf/util/build-id.c    | 1 +
 tools/perf/util/build-id.h    | 3 ++-
 tools/perf/util/dso.c         | 1 +
 tools/perf/util/dso.h         | 2 +-
 tools/perf/util/probe-event.c | 1 +
 tools/perf/util/probe-event.h | 5 +++--
 tools/perf/util/probe-file.c  | 1 +
 tools/perf/util/thread.h      | 1 +
 tools/perf/util/util.c        | 1 +
 10 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-probe.c b/tools/perf/builtin-probe.c
index 99de91698de1..46d3c2deeb40 100644
--- a/tools/perf/builtin-probe.c
+++ b/tools/perf/builtin-probe.c
@@ -32,6 +32,7 @@
 
 #include "perf.h"
 #include "builtin.h"
+#include "namespaces.h"
 #include "util/util.h"
 #include "util/strlist.h"
 #include "util/strfilter.h"
diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index 04b1d53e4bf9..07ef7fad689c 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -15,6 +15,7 @@
 #include <sys/types.h>
 #include "build-id.h"
 #include "event.h"
+#include "namespaces.h"
 #include "symbol.h"
 #include "thread.h"
 #include <linux/kernel.h>
diff --git a/tools/perf/util/build-id.h b/tools/perf/util/build-id.h
index f0c565164a97..93668f38f1ed 100644
--- a/tools/perf/util/build-id.h
+++ b/tools/perf/util/build-id.h
@@ -6,9 +6,10 @@
 #define SBUILD_ID_SIZE	(BUILD_ID_SIZE * 2 + 1)
 
 #include "tool.h"
-#include "namespaces.h"
 #include <linux/types.h>
 
+struct nsinfo;
+
 extern struct perf_tool build_id__mark_dso_hit_ops;
 struct dso;
 struct feat_fd;
diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 1b17f6de957d..cbe6e7dc6af3 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -10,6 +10,7 @@
 #include <fcntl.h>
 #include <libgen.h>
 #include "compress.h"
+#include "namespaces.h"
 #include "path.h"
 #include "symbol.h"
 #include "srcline.h"
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index 56001b82d448..2de54c0b26b2 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -10,9 +10,9 @@
 #include <stdio.h>
 #include "rwsem.h"
 #include <linux/bitops.h>
-#include "namespaces.h"
 #include "build-id.h"
 
+struct machine;
 struct map;
 
 enum dso_binary_type {
diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 18a59fba97ff..736787a18b9e 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -35,6 +35,7 @@
 
 #include "util.h"
 #include "event.h"
+#include "namespaces.h"
 #include "strlist.h"
 #include "strfilter.h"
 #include "debug.h"
diff --git a/tools/perf/util/probe-event.h b/tools/perf/util/probe-event.h
index 15a98c3a2a2f..05c8d571a901 100644
--- a/tools/perf/util/probe-event.h
+++ b/tools/perf/util/probe-event.h
@@ -4,8 +4,9 @@
 
 #include <linux/compiler.h>
 #include <stdbool.h>
-#include "intlist.h"
-#include "namespaces.h"
+
+struct intlist;
+struct nsinfo;
 
 /* Probe related configurations */
 struct probe_conf {
diff --git a/tools/perf/util/probe-file.c b/tools/perf/util/probe-file.c
index 0b1195cad0e5..4062bc4412a9 100644
--- a/tools/perf/util/probe-file.c
+++ b/tools/perf/util/probe-file.c
@@ -20,6 +20,7 @@
 #include <sys/types.h>
 #include <sys/uio.h>
 #include <unistd.h>
+#include "namespaces.h"
 #include "util.h"
 #include "event.h"
 #include "strlist.h"
diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
index 712dd48cc0ca..f3c939150f90 100644
--- a/tools/perf/util/thread.h
+++ b/tools/perf/util/thread.h
@@ -13,6 +13,7 @@
 #include <intlist.h>
 #include "rwsem.h"
 
+struct namespaces_event;
 struct thread_stack;
 struct unwind_libunwind_ops;
 
diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index 093352e93d50..320b0fef249a 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -2,6 +2,7 @@
 #include "../perf.h"
 #include "util.h"
 #include "debug.h"
+#include "namespaces.h"
 #include <api/fs/fs.h>
 #include <sys/mman.h>
 #include <sys/stat.h>
