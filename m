Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59128C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 23:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2891C218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 23:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548458512;
	bh=x/2n9lyZH0o03VkjBCQZlt1DfbsFdVjR8yhhlqquiW4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=D06KGP6AJeO3Abfw973yY+AcCyKgPzqNzMxG8gTYtUQvWmrK23x2ipinP9oS0PoY3
	 R82FtjkZk2mXmHuUHhQLV/Kd48WUq2EXxOsOkPdKj83C7p8VdhB81hvJwbgJLTaX31
	 7yEunlZldsB5Am9MAYuXoKJHilbCllPrvZ0P3l5E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729743AbfAYXTJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 18:19:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:47616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729694AbfAYXTG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 18:19:06 -0500
Received: from quaco.cust.in.nbox.cz (unknown [95.82.135.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3082218FF;
        Fri, 25 Jan 2019 23:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548458345;
        bh=x/2n9lyZH0o03VkjBCQZlt1DfbsFdVjR8yhhlqquiW4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pOlUOTD/YFJpacDkBns4tGB0mvXM7KUKJu+P5bunONL0ZFnX7sYnK/hDBF+lhxK+M
         7GTFZs0gY73zv72VxcnEF2BReJCAiEw4XalV9iIQxLejp04AyfiHM5nA3RlDcb1TWb
         6S1iO5PD4d1NygGvgbsFdUxXlQNk3CygI0FI/Yzk=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 07/29] perf namespaces: Remove namespaces.h from .h headers
Date:   Sat, 26 Jan 2019 00:18:21 +0100
Message-Id: <20190125231843.2895-8-acme@kernel.org>
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
index 62c8cf622607..8cbbb5be4a0b 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -9,6 +9,7 @@
 #include <errno.h>
 #include <fcntl.h>
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
-- 
2.20.1

