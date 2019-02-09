Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5744CC282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 12:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16C5A21939
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 12:31:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfBIMbc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 07:31:32 -0500
Received: from terminus.zytor.com ([198.137.202.136]:58753 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbfBIMbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 07:31:32 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x19CVMMx2627929
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 9 Feb 2019 04:31:22 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x19CVL9W2627926;
        Sat, 9 Feb 2019 04:31:21 -0800
Date:   Sat, 9 Feb 2019 04:31:21 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-ob8jehdjda8h5jsrv9dqj9tf@git.kernel.org>
Cc:     adrian.hunter@intel.com, acme@redhat.com, namhyung@kernel.org,
        tglx@linutronix.de, hpa@zytor.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, mingo@kernel.org
Reply-To: linux-kernel@vger.kernel.org, mingo@kernel.org, jolsa@kernel.org,
          tglx@linutronix.de, hpa@zytor.com, namhyung@kernel.org,
          acme@redhat.com, adrian.hunter@intel.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] pref tools: Add missing map.h includes
Git-Commit-ID: 1101f69af5335a863765100d1df1999fd1e8c5bf
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

Commit-ID:  1101f69af5335a863765100d1df1999fd1e8c5bf
Gitweb:     https://git.kernel.org/tip/1101f69af5335a863765100d1df1999fd1e8c5bf
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Sun, 27 Jan 2019 13:42:37 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 6 Feb 2019 10:00:38 -0300

pref tools: Add missing map.h includes

Lots of places get the map.h file indirectly, and since we're going to
remove it from machine.h, then those need to include it directly, do it
now, before we remove that dep.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-ob8jehdjda8h5jsrv9dqj9tf@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-annotate.c                          | 1 +
 tools/perf/builtin-inject.c                            | 1 +
 tools/perf/builtin-kallsyms.c                          | 1 +
 tools/perf/builtin-kmem.c                              | 1 +
 tools/perf/builtin-mem.c                               | 1 +
 tools/perf/builtin-report.c                            | 1 +
 tools/perf/builtin-script.c                            | 1 +
 tools/perf/builtin-top.c                               | 1 +
 tools/perf/builtin-trace.c                             | 1 +
 tools/perf/tests/code-reading.c                        | 1 +
 tools/perf/tests/hists_common.c                        | 1 +
 tools/perf/tests/hists_cumulate.c                      | 1 +
 tools/perf/tests/hists_filter.c                        | 1 +
 tools/perf/tests/hists_output.c                        | 1 +
 tools/perf/tests/mmap-thread-lookup.c                  | 1 +
 tools/perf/ui/browsers/annotate.c                      | 1 +
 tools/perf/ui/browsers/hists.c                         | 1 +
 tools/perf/util/annotate.c                             | 1 +
 tools/perf/util/build-id.c                             | 1 +
 tools/perf/util/callchain.c                            | 1 +
 tools/perf/util/db-export.c                            | 1 +
 tools/perf/util/dso.c                                  | 1 +
 tools/perf/util/event.c                                | 1 +
 tools/perf/util/intel-bts.c                            | 1 +
 tools/perf/util/probe-event.c                          | 1 +
 tools/perf/util/scripting-engines/trace-event-perl.c   | 1 +
 tools/perf/util/scripting-engines/trace-event-python.c | 1 +
 tools/perf/util/session.c                              | 1 +
 tools/perf/util/sort.c                                 | 1 +
 tools/perf/util/symbol-elf.c                           | 1 +
 tools/perf/util/symbol.c                               | 1 +
 tools/perf/util/unwind-libdw.c                         | 1 +
 tools/perf/util/unwind-libunwind-local.c               | 1 +
 tools/perf/util/unwind-libunwind.c                     | 1 +
 tools/perf/util/vdso.c                                 | 1 +
 35 files changed, 35 insertions(+)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 20db635347e5..7f3c3fea67b4 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -27,6 +27,7 @@
 #include "util/thread.h"
 #include "util/sort.h"
 #include "util/hist.h"
+#include "util/map.h"
 #include "util/session.h"
 #include "util/tool.h"
 #include "util/data.h"
diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index eda41673c4f3..3499addcfc12 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -12,6 +12,7 @@
 #include "util/color.h"
 #include "util/evlist.h"
 #include "util/evsel.h"
+#include "util/map.h"
 #include "util/session.h"
 #include "util/tool.h"
 #include "util/debug.h"
diff --git a/tools/perf/builtin-kallsyms.c b/tools/perf/builtin-kallsyms.c
index 90d1a2305b72..bc7a2bc7aed7 100644
--- a/tools/perf/builtin-kallsyms.c
+++ b/tools/perf/builtin-kallsyms.c
@@ -13,6 +13,7 @@
 #include <subcmd/parse-options.h>
 #include "debug.h"
 #include "machine.h"
+#include "map.h"
 #include "symbol.h"
 
 static int __cmd_kallsyms(int argc, const char **argv)
diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
index 088705c167bf..b80ec0883537 100644
--- a/tools/perf/builtin-kmem.c
+++ b/tools/perf/builtin-kmem.c
@@ -6,6 +6,7 @@
 #include "util/evsel.h"
 #include "util/util.h"
 #include "util/config.h"
+#include "util/map.h"
 #include "util/symbol.h"
 #include "util/thread.h"
 #include "util/header.h"
diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
index 57393e94d156..ba7e8d87dec3 100644
--- a/tools/perf/builtin-mem.c
+++ b/tools/perf/builtin-mem.c
@@ -13,6 +13,7 @@
 #include "util/data.h"
 #include "util/mem-events.h"
 #include "util/debug.h"
+#include "util/map.h"
 #include "util/symbol.h"
 
 #define MEM_OPERATION_LOAD	0x1
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index c9ceaf88759c..a007ea9a3874 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -16,6 +16,7 @@
 #include <linux/list.h>
 #include <linux/rbtree.h>
 #include <linux/err.h>
+#include "util/map.h"
 #include "util/symbol.h"
 #include "util/callchain.h"
 #include "util/values.h"
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index ac221f137ed2..8d5fe092525c 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -10,6 +10,7 @@
 #include "util/perf_regs.h"
 #include "util/session.h"
 #include "util/tool.h"
+#include "util/map.h"
 #include "util/symbol.h"
 #include "util/thread.h"
 #include "util/trace-event.h"
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 57b1d7495d02..619406339e4b 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -30,6 +30,7 @@
 #include "util/evsel.h"
 #include "util/event.h"
 #include "util/machine.h"
+#include "util/map.h"
 #include "util/session.h"
 #include "util/symbol.h"
 #include "util/thread.h"
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 1447993e1ee3..c0b91595d6e3 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -29,6 +29,7 @@
 #include "util/evlist.h"
 #include <subcmd/exec-cmd.h>
 #include "util/machine.h"
+#include "util/map.h"
 #include "util/path.h"
 #include "util/session.h"
 #include "util/thread.h"
diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index dbf2c69944d2..59d00b3d0a74 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -15,6 +15,7 @@
 #include "thread_map.h"
 #include "cpumap.h"
 #include "machine.h"
+#include "map.h"
 #include "event.h"
 #include "thread.h"
 
diff --git a/tools/perf/tests/hists_common.c b/tools/perf/tests/hists_common.c
index 6b0649c8b33e..469958cd7fe0 100644
--- a/tools/perf/tests/hists_common.c
+++ b/tools/perf/tests/hists_common.c
@@ -2,6 +2,7 @@
 #include <inttypes.h>
 #include "perf.h"
 #include "util/debug.h"
+#include "util/map.h"
 #include "util/symbol.h"
 #include "util/sort.h"
 #include "util/evsel.h"
diff --git a/tools/perf/tests/hists_cumulate.c b/tools/perf/tests/hists_cumulate.c
index 4ca417d1a06b..7a2eed6c783e 100644
--- a/tools/perf/tests/hists_cumulate.c
+++ b/tools/perf/tests/hists_cumulate.c
@@ -2,6 +2,7 @@
 #include "perf.h"
 #include "util/debug.h"
 #include "util/event.h"
+#include "util/map.h"
 #include "util/symbol.h"
 #include "util/sort.h"
 #include "util/evsel.h"
diff --git a/tools/perf/tests/hists_filter.c b/tools/perf/tests/hists_filter.c
index 1c5bedab3c2c..975844807fe2 100644
--- a/tools/perf/tests/hists_filter.c
+++ b/tools/perf/tests/hists_filter.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "perf.h"
 #include "util/debug.h"
+#include "util/map.h"
 #include "util/symbol.h"
 #include "util/sort.h"
 #include "util/evsel.h"
diff --git a/tools/perf/tests/hists_output.c b/tools/perf/tests/hists_output.c
index 6c4bc68a77ee..0a510c524a5d 100644
--- a/tools/perf/tests/hists_output.c
+++ b/tools/perf/tests/hists_output.c
@@ -2,6 +2,7 @@
 #include "perf.h"
 #include "util/debug.h"
 #include "util/event.h"
+#include "util/map.h"
 #include "util/symbol.h"
 #include "util/sort.h"
 #include "util/evsel.h"
diff --git a/tools/perf/tests/mmap-thread-lookup.c b/tools/perf/tests/mmap-thread-lookup.c
index 5ede9b561d32..ba87e6e8d18c 100644
--- a/tools/perf/tests/mmap-thread-lookup.c
+++ b/tools/perf/tests/mmap-thread-lookup.c
@@ -11,6 +11,7 @@
 #include "tests.h"
 #include "machine.h"
 #include "thread_map.h"
+#include "map.h"
 #include "symbol.h"
 #include "thread.h"
 #include "util.h"
diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 82e16bf84466..35bdfd8b1e71 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -7,6 +7,7 @@
 #include "../../util/annotate.h"
 #include "../../util/hist.h"
 #include "../../util/sort.h"
+#include "../../util/map.h"
 #include "../../util/symbol.h"
 #include "../../util/evsel.h"
 #include "../../util/evlist.h"
diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 85790a4d1842..8ada0c690771 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -11,6 +11,7 @@
 #include "../../util/evsel.h"
 #include "../../util/evlist.h"
 #include "../../util/hist.h"
+#include "../../util/map.h"
 #include "../../util/pstack.h"
 #include "../../util/sort.h"
 #include "../../util/util.h"
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 3d79add5f7ae..2468b8aa0b6b 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -17,6 +17,7 @@
 #include "color.h"
 #include "config.h"
 #include "cache.h"
+#include "map.h"
 #include "symbol.h"
 #include "units.h"
 #include "debug.h"
diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index 2ff802068f06..bff0d17920ed 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -16,6 +16,7 @@
 #include "build-id.h"
 #include "event.h"
 #include "namespaces.h"
+#include "map.h"
 #include "symbol.h"
 #include "thread.h"
 #include <linux/kernel.h>
diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index 2974950039ac..cc47dba973f2 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -23,6 +23,7 @@
 #include "util.h"
 #include "sort.h"
 #include "machine.h"
+#include "map.h"
 #include "callchain.h"
 #include "branch.h"
 
diff --git a/tools/perf/util/db-export.c b/tools/perf/util/db-export.c
index 69fbb0a72d0c..de9b4769d06c 100644
--- a/tools/perf/util/db-export.c
+++ b/tools/perf/util/db-export.c
@@ -20,6 +20,7 @@
 #include "thread.h"
 #include "comm.h"
 #include "symbol.h"
+#include "map.h"
 #include "event.h"
 #include "util.h"
 #include "thread-stack.h"
diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index a8a54115b115..ba58ba603b69 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -12,6 +12,7 @@
 #include "compress.h"
 #include "namespaces.h"
 #include "path.h"
+#include "map.h"
 #include "symbol.h"
 #include "srcline.h"
 #include "dso.h"
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 1b5091a3d14f..4d84e7754be9 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -21,6 +21,7 @@
 #include "thread.h"
 #include "thread_map.h"
 #include "sane_ctype.h"
+#include "map.h"
 #include "symbol/kallsyms.h"
 #include "asm/bug.h"
 #include "stat.h"
diff --git a/tools/perf/util/intel-bts.c b/tools/perf/util/intel-bts.c
index ee6ca65f81f4..f7fe8ccf6d65 100644
--- a/tools/perf/util/intel-bts.c
+++ b/tools/perf/util/intel-bts.c
@@ -27,6 +27,7 @@
 #include "evsel.h"
 #include "evlist.h"
 #include "machine.h"
+#include "map.h"
 #include "session.h"
 #include "util.h"
 #include "thread.h"
diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 4008f0cc36e5..b0192160513d 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -41,6 +41,7 @@
 #include "debug.h"
 #include "cache.h"
 #include "color.h"
+#include "map.h"
 #include "symbol.h"
 #include "thread.h"
 #include <api/fs/fs.h>
diff --git a/tools/perf/util/scripting-engines/trace-event-perl.c b/tools/perf/util/scripting-engines/trace-event-perl.c
index b93f36b887b5..a9f22694eed1 100644
--- a/tools/perf/util/scripting-engines/trace-event-perl.c
+++ b/tools/perf/util/scripting-engines/trace-event-perl.c
@@ -37,6 +37,7 @@
 #include "../../perf.h"
 #include "../callchain.h"
 #include "../machine.h"
+#include "../map.h"
 #include "../thread.h"
 #include "../event.h"
 #include "../trace-event.h"
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 7059d1be2d09..d9c83776a80f 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -44,6 +44,7 @@
 #include "../thread-stack.h"
 #include "../trace-event.h"
 #include "../call-path.h"
+#include "map.h"
 #include "thread_map.h"
 #include "cpumap.h"
 #include "print_binary.h"
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 24fd62528a33..e9755a649993 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -13,6 +13,7 @@
 #include "evlist.h"
 #include "evsel.h"
 #include "memswap.h"
+#include "map.h"
 #include "session.h"
 #include "tool.h"
 #include "sort.h"
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 6c1a83768eb0..79e794406bef 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -6,6 +6,7 @@
 #include "sort.h"
 #include "hist.h"
 #include "comm.h"
+#include "map.h"
 #include "symbol.h"
 #include "thread.h"
 #include "evsel.h"
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 66a84d5846c8..848d1a0f8dc0 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -6,6 +6,7 @@
 #include <unistd.h>
 #include <inttypes.h>
 
+#include "map.h"
 #include "symbol.h"
 #include "demangle-java.h"
 #include "demangle-rust.h"
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index bcbcbd610460..7b194cf53cc0 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -17,6 +17,7 @@
 #include "util.h"
 #include "debug.h"
 #include "machine.h"
+#include "map.h"
 #include "symbol.h"
 #include "strlist.h"
 #include "intlist.h"
diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libdw.c
index 5eff9bfc5758..8ea7c89e73fd 100644
--- a/tools/perf/util/unwind-libdw.c
+++ b/tools/perf/util/unwind-libdw.c
@@ -8,6 +8,7 @@
 #include "unwind.h"
 #include "unwind-libdw.h"
 #include "machine.h"
+#include "map.h"
 #include "thread.h"
 #include <linux/types.h>
 #include "event.h"
diff --git a/tools/perf/util/unwind-libunwind-local.c b/tools/perf/util/unwind-libunwind-local.c
index 79f521a552cf..f3c666a84e4d 100644
--- a/tools/perf/util/unwind-libunwind-local.c
+++ b/tools/perf/util/unwind-libunwind-local.c
@@ -34,6 +34,7 @@
 #include "session.h"
 #include "perf_regs.h"
 #include "unwind.h"
+#include "map.h"
 #include "symbol.h"
 #include "util.h"
 #include "debug.h"
diff --git a/tools/perf/util/unwind-libunwind.c b/tools/perf/util/unwind-libunwind.c
index b029a5e9ae49..9778b3133b77 100644
--- a/tools/perf/util/unwind-libunwind.c
+++ b/tools/perf/util/unwind-libunwind.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "unwind.h"
+#include "map.h"
 #include "thread.h"
 #include "session.h"
 #include "debug.h"
diff --git a/tools/perf/util/vdso.c b/tools/perf/util/vdso.c
index 3702cba11d7d..5031b7b22bbd 100644
--- a/tools/perf/util/vdso.c
+++ b/tools/perf/util/vdso.c
@@ -11,6 +11,7 @@
 
 #include "vdso.h"
 #include "util.h"
+#include "map.h"
 #include "symbol.h"
 #include "machine.h"
 #include "thread.h"
