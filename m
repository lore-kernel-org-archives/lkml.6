Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A34CC282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 12:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0379C218D2
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 12:34:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbfBIMeN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 07:34:13 -0500
Received: from terminus.zytor.com ([198.137.202.136]:33021 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbfBIMeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 07:34:12 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x19CY2eA2628355
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 9 Feb 2019 04:34:02 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x19CY1kM2628352;
        Sat, 9 Feb 2019 04:34:01 -0800
Date:   Sat, 9 Feb 2019 04:34:01 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-xbcvvx296d70kpg9wb0qmeq9@git.kernel.org>
Cc:     jolsa@kernel.org, acme@redhat.com, adrian.hunter@intel.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        hpa@zytor.com, namhyung@kernel.org
Reply-To: acme@redhat.com, jolsa@kernel.org, adrian.hunter@intel.com,
          mingo@kernel.org, linux-kernel@vger.kernel.org,
          namhyung@kernel.org, tglx@linutronix.de, hpa@zytor.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tools: Add missing include for symbols.h
Git-Commit-ID: daecf9e0fa8e1bb3b227fcc15c4070caccbbb14f
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

Commit-ID:  daecf9e0fa8e1bb3b227fcc15c4070caccbbb14f
Gitweb:     https://git.kernel.org/tip/daecf9e0fa8e1bb3b227fcc15c4070caccbbb14f
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 28 Jan 2019 00:03:34 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 6 Feb 2019 10:00:38 -0300

perf tools: Add missing include for symbols.h

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
