Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 719A3C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 357B22070B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549479280;
	bh=UWIu1mRSumwMCMRTuJP1O0nEruLzXljQgIHDJv9OVXA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Hfd6mCMq8GxpEsRZcf6AGLRkL6Gh+L3qdM/z54pqI/pjQT7K8mn04P2B+bXsNq1VT
	 ocjpRGLqhK9yd0sGTAxdpqSc65XTp0UNB2tdreFsJxx0uBmZaWNT4mdOAobOan/C6B
	 pDT3Aop9IcyrQ7Yc/cW8A/nOe3Yb8PteDKBUZEog=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbfBFSyi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 13:54:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:44074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727135AbfBFSto (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 13:49:44 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.41.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 621892186A;
        Wed,  6 Feb 2019 18:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549478983;
        bh=UWIu1mRSumwMCMRTuJP1O0nEruLzXljQgIHDJv9OVXA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Prra8eZF7Iz6COzBmRbV6J5Vw8EOFGkkto4VYzJLhCvbDZUe6yqGkOQyJ6xiAl8D7
         FKrquVUeRDpss3Z6hga7ANioflg6+FCG8pyj/npq2Jpaw0SV5kFKtkmFgkdQsqpnrP
         RrEQwWV04DIu/s79UIwvjo95q29NYNU8GqvVE4yk=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 10/53] perf tools: Add missing include for symbols.h
Date:   Wed,  6 Feb 2019 15:48:20 -0300
Message-Id: <20190206184903.24054-11-acme@kernel.org>
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

Several places were using definitions found in symbols.h but not
including it, getting it by sheer luck from some other headers that now
are in the process of removing that include because they don't need it
or because simply having struct forward declarations is enough, fix it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-xbcvvx296d70kpg9wb0qmeq9@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-c2c.c                               | 1 +
 tools/perf/builtin-inject.c                            | 1 +
 tools/perf/builtin-trace.c                             | 1 +
 tools/perf/tests/code-reading.c                        | 1 +
 tools/perf/tests/dwarf-unwind.c                        | 1 +
 tools/perf/ui/browsers/hists.c                         | 1 +
 tools/perf/ui/stdio/hist.c                             | 1 +
 tools/perf/util/event.c                                | 1 +
 tools/perf/util/hist.c                                 | 1 +
 tools/perf/util/intel-bts.c                            | 1 +
 tools/perf/util/machine.c                              | 1 +
 tools/perf/util/scripting-engines/trace-event-perl.c   | 1 +
 tools/perf/util/scripting-engines/trace-event-python.c | 1 +
 tools/perf/util/session.c                              | 1 +
 tools/perf/util/thread.c                               | 1 +
 tools/perf/util/unwind-libdw.c                         | 1 +
 16 files changed, 16 insertions(+)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 72ec0ae7d8ad..b2bf117881f1 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -33,6 +33,7 @@
 #include "ui/browsers/hists.h"
 #include "thread.h"
 #include "mem2node.h"
+#include "symbol.h"
 
 struct c2c_hists {
 	struct hists		hists;
diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 3499addcfc12..9bb1f35d5cb7 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -20,6 +20,7 @@
 #include "util/data.h"
 #include "util/auxtrace.h"
 #include "util/jit.h"
+#include "util/symbol.h"
 #include "util/thread.h"
 
 #include <subcmd/parse-options.h>
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index c0b91595d6e3..81a44954d435 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -30,6 +30,7 @@
 #include <subcmd/exec-cmd.h>
 #include "util/machine.h"
 #include "util/map.h"
+#include "util/symbol.h"
 #include "util/path.h"
 #include "util/session.h"
 #include "util/thread.h"
diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index 59d00b3d0a74..4ebd2681e760 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -16,6 +16,7 @@
 #include "cpumap.h"
 #include "machine.h"
 #include "map.h"
+#include "symbol.h"
 #include "event.h"
 #include "thread.h"
 
diff --git a/tools/perf/tests/dwarf-unwind.c b/tools/perf/tests/dwarf-unwind.c
index 7c8d2e422401..077c306c1cae 100644
--- a/tools/perf/tests/dwarf-unwind.c
+++ b/tools/perf/tests/dwarf-unwind.c
@@ -10,6 +10,7 @@
 #include "../util/unwind.h"
 #include "perf_regs.h"
 #include "map.h"
+#include "symbol.h"
 #include "thread.h"
 #include "callchain.h"
 
diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 8ada0c690771..ac176b48178c 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -12,6 +12,7 @@
 #include "../../util/evlist.h"
 #include "../../util/hist.h"
 #include "../../util/map.h"
+#include "../../util/symbol.h"
 #include "../../util/pstack.h"
 #include "../../util/sort.h"
 #include "../../util/util.h"
diff --git a/tools/perf/ui/stdio/hist.c b/tools/perf/ui/stdio/hist.c
index bb653a47f47a..f25116f70878 100644
--- a/tools/perf/ui/stdio/hist.c
+++ b/tools/perf/ui/stdio/hist.c
@@ -6,6 +6,7 @@
 #include "../../util/hist.h"
 #include "../../util/map.h"
 #include "../../util/map_groups.h"
+#include "../../util/symbol.h"
 #include "../../util/sort.h"
 #include "../../util/evsel.h"
 #include "../../util/srcline.h"
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 4d84e7754be9..ba7be74fad6e 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -22,6 +22,7 @@
 #include "thread_map.h"
 #include "sane_ctype.h"
 #include "map.h"
+#include "symbol.h"
 #include "symbol/kallsyms.h"
 #include "asm/bug.h"
 #include "stat.h"
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 9e7a8e044a0a..3560ad2e5551 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -11,6 +11,7 @@
 #include "evsel.h"
 #include "annotate.h"
 #include "srcline.h"
+#include "symbol.h"
 #include "thread.h"
 #include "ui/progress.h"
 #include <errno.h>
diff --git a/tools/perf/util/intel-bts.c b/tools/perf/util/intel-bts.c
index f7fe8ccf6d65..f99ac0cbe3ff 100644
--- a/tools/perf/util/intel-bts.c
+++ b/tools/perf/util/intel-bts.c
@@ -28,6 +28,7 @@
 #include "evlist.h"
 #include "machine.h"
 #include "map.h"
+#include "symbol.h"
 #include "session.h"
 #include "util.h"
 #include "thread.h"
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 66f019fdc510..61959aba7e27 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -10,6 +10,7 @@
 #include "hist.h"
 #include "machine.h"
 #include "map.h"
+#include "symbol.h"
 #include "sort.h"
 #include "strlist.h"
 #include "thread.h"
diff --git a/tools/perf/util/scripting-engines/trace-event-perl.c b/tools/perf/util/scripting-engines/trace-event-perl.c
index a9f22694eed1..5f06378a482b 100644
--- a/tools/perf/util/scripting-engines/trace-event-perl.c
+++ b/tools/perf/util/scripting-engines/trace-event-perl.c
@@ -38,6 +38,7 @@
 #include "../callchain.h"
 #include "../machine.h"
 #include "../map.h"
+#include "../symbol.h"
 #include "../thread.h"
 #include "../event.h"
 #include "../trace-event.h"
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index d9c83776a80f..0e17db41b49b 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -45,6 +45,7 @@
 #include "../trace-event.h"
 #include "../call-path.h"
 #include "map.h"
+#include "symbol.h"
 #include "thread_map.h"
 #include "cpumap.h"
 #include "print_binary.h"
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index e9755a649993..2012396abb7c 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -14,6 +14,7 @@
 #include "evsel.h"
 #include "memswap.h"
 #include "map.h"
+#include "symbol.h"
 #include "session.h"
 #include "tool.h"
 #include "sort.h"
diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index c83372329f89..4c179fef442d 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -12,6 +12,7 @@
 #include "debug.h"
 #include "namespaces.h"
 #include "comm.h"
+#include "symbol.h"
 #include "unwind.h"
 
 #include <api/fs/fs.h>
diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libdw.c
index 8ea7c89e73fd..407d0167b942 100644
--- a/tools/perf/util/unwind-libdw.c
+++ b/tools/perf/util/unwind-libdw.c
@@ -9,6 +9,7 @@
 #include "unwind-libdw.h"
 #include "machine.h"
 #include "map.h"
+#include "symbol.h"
 #include "thread.h"
 #include <linux/types.h>
 #include "event.h"
-- 
2.20.1

