Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E50C282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 09:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEC62217D7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 09:58:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729645AbfAZJ6w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 04:58:52 -0500
Received: from terminus.zytor.com ([198.137.202.136]:55503 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbfAZJ6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 04:58:52 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0Q9wjFT510403
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 26 Jan 2019 01:58:45 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0Q9wjp7510400;
        Sat, 26 Jan 2019 01:58:45 -0800
Date:   Sat, 26 Jan 2019 01:58:45 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-wrii9hy1a1wathc0398f9fgt@git.kernel.org>
Cc:     tglx@linutronix.de, namhyung@kernel.org, adrian.hunter@intel.com,
        jolsa@kernel.org, mingo@kernel.org, linux-kernel@vger.kernel.org,
        hpa@zytor.com, acme@redhat.com
Reply-To: hpa@zytor.com, acme@redhat.com, tglx@linutronix.de,
          namhyung@kernel.org, adrian.hunter@intel.com, jolsa@kernel.org,
          mingo@kernel.org, linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf symbols: Remove some unnecessary includes from
 symbol.h
Git-Commit-ID: 68c0188ea77891266c048d0768250eba51441cb2
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

Commit-ID:  68c0188ea77891266c048d0768250eba51441cb2
Gitweb:     https://git.kernel.org/tip/68c0188ea77891266c048d0768250eba51441cb2
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 22 Jan 2019 11:14:55 -0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 25 Jan 2019 15:12:09 +0100

perf symbols: Remove some unnecessary includes from symbol.h

And fixup the fallout in places like annotation and jitdump that were
using things like dirname() but weren't including libgen.h, etc.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-wrii9hy1a1wathc0398f9fgt@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c       |  1 +
 tools/perf/util/dso.c            |  1 +
 tools/perf/util/jitdump.c        |  1 +
 tools/perf/util/symbol-minimal.c |  1 +
 tools/perf/util/symbol.h         | 10 ++++------
 5 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 70de8f6b3aee..3d79add5f7ae 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -9,6 +9,7 @@
 
 #include <errno.h>
 #include <inttypes.h>
+#include <libgen.h>
 #include "util.h"
 #include "ui/ui.h"
 #include "sort.h"
diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 62c8cf622607..1b17f6de957d 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -8,6 +8,7 @@
 #include <unistd.h>
 #include <errno.h>
 #include <fcntl.h>
+#include <libgen.h>
 #include "compress.h"
 #include "path.h"
 #include "symbol.h"
diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
index bf249552a9b0..eda28d3570bc 100644
--- a/tools/perf/util/jitdump.c
+++ b/tools/perf/util/jitdump.c
@@ -2,6 +2,7 @@
 #include <sys/sysmacros.h>
 #include <sys/types.h>
 #include <errno.h>
+#include <libgen.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
diff --git a/tools/perf/util/symbol-minimal.c b/tools/perf/util/symbol-minimal.c
index 7119df77dc0b..17edbd4f6f85 100644
--- a/tools/perf/util/symbol-minimal.c
+++ b/tools/perf/util/symbol-minimal.c
@@ -3,6 +3,7 @@
 #include "util.h"
 
 #include <errno.h>
+#include <unistd.h>
 #include <stdio.h>
 #include <fcntl.h>
 #include <string.h>
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 956d9916e364..2162a5d9b3ac 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -5,16 +5,10 @@
 #include <linux/types.h>
 #include <stdbool.h>
 #include <stdint.h>
-#include "map.h"
-#include "../perf.h"
 #include <linux/list.h>
 #include <linux/rbtree.h>
 #include <stdio.h>
-#include <byteswap.h>
-#include <libgen.h>
 #include "branch.h"
-#include "build-id.h"
-#include "event.h"
 #include "path.h"
 #include "symbol_conf.h"
 
@@ -26,6 +20,10 @@
 
 #include "dso.h"
 
+struct map;
+struct map_groups;
+struct option;
+
 /*
  * libelf 0.8.x and earlier do not support ELF_C_READ_MMAP;
  * for newer versions we can use mmap to reduce memory usage:
