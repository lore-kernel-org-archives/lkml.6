Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E4ECC10F04
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7C0F222DC
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550191723;
	bh=nWdhOHlGLETRMfJylATaEONrC7guFsJaumjZBVkcgEI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=U3UGHxTYOQzcUyxzSc5KkpChLs3DwZEZWfNkf58gtvtbxt4GYm6eCubHdFQhb5rmS
	 Fw4V6/hChPTUvtrrEfariLKJMUWBiQO47pJBZ85Ez7Q5SMA5Q3ux9opXsv8TlJyOjM
	 KUybS/yXKx14XJUpjgOPmMxTt27KG3cynw7vEEFE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389821AbfBOAsl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 19:48:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:47828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389722AbfBOAsk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 19:48:40 -0500
Received: from quaco.ghostprotocols.net (unknown [189.40.103.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FF6F2229F;
        Fri, 15 Feb 2019 00:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550191717;
        bh=nWdhOHlGLETRMfJylATaEONrC7guFsJaumjZBVkcgEI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m4q8F37mvNPyOQRqjWlyGAnjzoNfIZHyTcvjcMU4q1FORf2n43cbP6KNWXjobC+L7
         NwuKWSr5fVK2W8309+qYmDPobuJaRWI6OyIC55le9AhGsF+ccXQ2+T10KEW7fQaUdf
         V3QqVgping85mekZsux2M+k2/7SWFSaLOB/eHSPg=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 38/43] perf tools: Rename build libperf to perf
Date:   Thu, 14 Feb 2019 21:45:34 -0300
Message-Id: <20190215004539.23571-39-acme@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215004539.23571-1-acme@kernel.org>
References: <20190215004539.23571-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Rename build libperf to perf, because it's used to build perf.

The libperf build object name will be used for libperf library.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190213123246.4015-4-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Build                              |  10 +-
 tools/perf/arch/Build                         |   4 +-
 tools/perf/arch/arm/Build                     |   4 +-
 tools/perf/arch/arm/tests/Build               |   8 +-
 tools/perf/arch/arm/util/Build                |   8 +-
 tools/perf/arch/arm64/Build                   |   4 +-
 tools/perf/arch/arm64/tests/Build             |   6 +-
 tools/perf/arch/arm64/util/Build              |  12 +-
 tools/perf/arch/nds32/Build                   |   2 +-
 tools/perf/arch/nds32/util/Build              |   2 +-
 tools/perf/arch/powerpc/Build                 |   4 +-
 tools/perf/arch/powerpc/tests/Build           |   6 +-
 tools/perf/arch/powerpc/util/Build            |  18 +-
 tools/perf/arch/s390/Build                    |   2 +-
 tools/perf/arch/s390/util/Build               |  12 +-
 tools/perf/arch/sh/Build                      |   2 +-
 tools/perf/arch/sh/util/Build                 |   2 +-
 tools/perf/arch/sparc/Build                   |   2 +-
 tools/perf/arch/sparc/util/Build              |   2 +-
 tools/perf/arch/x86/Build                     |   4 +-
 tools/perf/arch/x86/tests/Build               |  14 +-
 tools/perf/arch/x86/util/Build                |  30 +-
 tools/perf/arch/xtensa/Build                  |   2 +-
 tools/perf/arch/xtensa/util/Build             |   2 +-
 tools/perf/scripts/Build                      |   4 +-
 tools/perf/scripts/perl/Perf-Trace-Util/Build |   2 +-
 .../perf/scripts/python/Perf-Trace-Util/Build |   2 +-
 tools/perf/trace/beauty/Build                 |  26 +-
 tools/perf/ui/Build                           |  18 +-
 tools/perf/ui/browsers/Build                  |  10 +-
 tools/perf/ui/tui/Build                       |   8 +-
 tools/perf/util/Build                         | 276 +++++++++---------
 tools/perf/util/c++/Build                     |   4 +-
 tools/perf/util/cs-etm-decoder/Build          |   2 +-
 tools/perf/util/intel-pt-decoder/Build        |   2 +-
 tools/perf/util/scripting-engines/Build       |   4 +-
 36 files changed, 260 insertions(+), 260 deletions(-)

diff --git a/tools/perf/Build b/tools/perf/Build
index e5232d567611..5f392dbb88fc 100644
--- a/tools/perf/Build
+++ b/tools/perf/Build
@@ -46,10 +46,10 @@ CFLAGS_builtin-trace.o	   += -DSTRACE_GROUPS_DIR="BUILD_STR($(STRACE_GROUPS_DIR_
 CFLAGS_builtin-report.o	   += -DTIPDIR="BUILD_STR($(tipdir_SQ))"
 CFLAGS_builtin-report.o	   += -DDOCDIR="BUILD_STR($(srcdir_SQ)/Documentation)"
 
-libperf-y += util/
-libperf-y += arch/
-libperf-y += ui/
-libperf-y += scripts/
-libperf-$(CONFIG_TRACE) += trace/beauty/
+perf-y += util/
+perf-y += arch/
+perf-y += ui/
+perf-y += scripts/
+perf-$(CONFIG_TRACE) += trace/beauty/
 
 gtk-y += ui/gtk/
diff --git a/tools/perf/arch/Build b/tools/perf/arch/Build
index d9b6af837c7d..688818844c11 100644
--- a/tools/perf/arch/Build
+++ b/tools/perf/arch/Build
@@ -1,2 +1,2 @@
-libperf-y += common.o
-libperf-y += $(SRCARCH)/
+perf-y += common.o
+perf-y += $(SRCARCH)/
diff --git a/tools/perf/arch/arm/Build b/tools/perf/arch/arm/Build
index 41bf61da476a..36222e64bbf7 100644
--- a/tools/perf/arch/arm/Build
+++ b/tools/perf/arch/arm/Build
@@ -1,2 +1,2 @@
-libperf-y += util/
-libperf-$(CONFIG_DWARF_UNWIND) += tests/
+perf-y += util/
+perf-$(CONFIG_DWARF_UNWIND) += tests/
diff --git a/tools/perf/arch/arm/tests/Build b/tools/perf/arch/arm/tests/Build
index d9ae2733f9cc..bc8e97380c82 100644
--- a/tools/perf/arch/arm/tests/Build
+++ b/tools/perf/arch/arm/tests/Build
@@ -1,5 +1,5 @@
-libperf-y += regs_load.o
-libperf-y += dwarf-unwind.o
-libperf-y += vectors-page.o
+perf-y += regs_load.o
+perf-y += dwarf-unwind.o
+perf-y += vectors-page.o
 
-libperf-y += arch-tests.o
+perf-y += arch-tests.o
diff --git a/tools/perf/arch/arm/util/Build b/tools/perf/arch/arm/util/Build
index e64c5f216448..296f0eac5e18 100644
--- a/tools/perf/arch/arm/util/Build
+++ b/tools/perf/arch/arm/util/Build
@@ -1,6 +1,6 @@
-libperf-$(CONFIG_DWARF) += dwarf-regs.o
+perf-$(CONFIG_DWARF) += dwarf-regs.o
 
-libperf-$(CONFIG_LOCAL_LIBUNWIND)    += unwind-libunwind.o
-libperf-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
+perf-$(CONFIG_LOCAL_LIBUNWIND)    += unwind-libunwind.o
+perf-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
 
-libperf-$(CONFIG_AUXTRACE) += pmu.o auxtrace.o cs-etm.o
+perf-$(CONFIG_AUXTRACE) += pmu.o auxtrace.o cs-etm.o
diff --git a/tools/perf/arch/arm64/Build b/tools/perf/arch/arm64/Build
index 41bf61da476a..36222e64bbf7 100644
--- a/tools/perf/arch/arm64/Build
+++ b/tools/perf/arch/arm64/Build
@@ -1,2 +1,2 @@
-libperf-y += util/
-libperf-$(CONFIG_DWARF_UNWIND) += tests/
+perf-y += util/
+perf-$(CONFIG_DWARF_UNWIND) += tests/
diff --git a/tools/perf/arch/arm64/tests/Build b/tools/perf/arch/arm64/tests/Build
index 883c57ff0c08..41707fea74b3 100644
--- a/tools/perf/arch/arm64/tests/Build
+++ b/tools/perf/arch/arm64/tests/Build
@@ -1,4 +1,4 @@
-libperf-y += regs_load.o
-libperf-y += dwarf-unwind.o
+perf-y += regs_load.o
+perf-y += dwarf-unwind.o
 
-libperf-y += arch-tests.o
+perf-y += arch-tests.o
diff --git a/tools/perf/arch/arm64/util/Build b/tools/perf/arch/arm64/util/Build
index 68f8a8eb3ad0..3cde540d2fcf 100644
--- a/tools/perf/arch/arm64/util/Build
+++ b/tools/perf/arch/arm64/util/Build
@@ -1,10 +1,10 @@
-libperf-y += header.o
-libperf-y += sym-handling.o
-libperf-$(CONFIG_DWARF)     += dwarf-regs.o
-libperf-$(CONFIG_LOCAL_LIBUNWIND) += unwind-libunwind.o
-libperf-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
+perf-y += header.o
+perf-y += sym-handling.o
+perf-$(CONFIG_DWARF)     += dwarf-regs.o
+perf-$(CONFIG_LOCAL_LIBUNWIND) += unwind-libunwind.o
+perf-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
 
-libperf-$(CONFIG_AUXTRACE) += ../../arm/util/pmu.o \
+perf-$(CONFIG_AUXTRACE) += ../../arm/util/pmu.o \
 			      ../../arm/util/auxtrace.o \
 			      ../../arm/util/cs-etm.o \
 			      arm-spe.o
diff --git a/tools/perf/arch/nds32/Build b/tools/perf/arch/nds32/Build
index 54afe4a467e7..e4e5f33c84d8 100644
--- a/tools/perf/arch/nds32/Build
+++ b/tools/perf/arch/nds32/Build
@@ -1 +1 @@
-libperf-y += util/
+perf-y += util/
diff --git a/tools/perf/arch/nds32/util/Build b/tools/perf/arch/nds32/util/Build
index ca623bbf993c..d0bc205fe49a 100644
--- a/tools/perf/arch/nds32/util/Build
+++ b/tools/perf/arch/nds32/util/Build
@@ -1 +1 @@
-libperf-y += header.o
+perf-y += header.o
diff --git a/tools/perf/arch/powerpc/Build b/tools/perf/arch/powerpc/Build
index db52fa22d3a1..a7dd46a5b678 100644
--- a/tools/perf/arch/powerpc/Build
+++ b/tools/perf/arch/powerpc/Build
@@ -1,2 +1,2 @@
-libperf-y += util/
-libperf-y += tests/
+perf-y += util/
+perf-y += tests/
diff --git a/tools/perf/arch/powerpc/tests/Build b/tools/perf/arch/powerpc/tests/Build
index d827ef384b33..3526ab0af9f9 100644
--- a/tools/perf/arch/powerpc/tests/Build
+++ b/tools/perf/arch/powerpc/tests/Build
@@ -1,4 +1,4 @@
-libperf-$(CONFIG_DWARF_UNWIND) += regs_load.o
-libperf-$(CONFIG_DWARF_UNWIND) += dwarf-unwind.o
+perf-$(CONFIG_DWARF_UNWIND) += regs_load.o
+perf-$(CONFIG_DWARF_UNWIND) += dwarf-unwind.o
 
-libperf-y += arch-tests.o
+perf-y += arch-tests.o
diff --git a/tools/perf/arch/powerpc/util/Build b/tools/perf/arch/powerpc/util/Build
index ba98bd006488..7cf0b8803097 100644
--- a/tools/perf/arch/powerpc/util/Build
+++ b/tools/perf/arch/powerpc/util/Build
@@ -1,11 +1,11 @@
-libperf-y += header.o
-libperf-y += sym-handling.o
-libperf-y += kvm-stat.o
-libperf-y += perf_regs.o
-libperf-y += mem-events.o
+perf-y += header.o
+perf-y += sym-handling.o
+perf-y += kvm-stat.o
+perf-y += perf_regs.o
+perf-y += mem-events.o
 
-libperf-$(CONFIG_DWARF) += dwarf-regs.o
-libperf-$(CONFIG_DWARF) += skip-callchain-idx.o
+perf-$(CONFIG_DWARF) += dwarf-regs.o
+perf-$(CONFIG_DWARF) += skip-callchain-idx.o
 
-libperf-$(CONFIG_LIBUNWIND) += unwind-libunwind.o
-libperf-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
+perf-$(CONFIG_LIBUNWIND) += unwind-libunwind.o
+perf-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
diff --git a/tools/perf/arch/s390/Build b/tools/perf/arch/s390/Build
index 54afe4a467e7..e4e5f33c84d8 100644
--- a/tools/perf/arch/s390/Build
+++ b/tools/perf/arch/s390/Build
@@ -1 +1 @@
-libperf-y += util/
+perf-y += util/
diff --git a/tools/perf/arch/s390/util/Build b/tools/perf/arch/s390/util/Build
index 4a233683c684..22797f043b84 100644
--- a/tools/perf/arch/s390/util/Build
+++ b/tools/perf/arch/s390/util/Build
@@ -1,9 +1,9 @@
-libperf-y += header.o
-libperf-y += kvm-stat.o
+perf-y += header.o
+perf-y += kvm-stat.o
 
-libperf-$(CONFIG_DWARF) += dwarf-regs.o
-libperf-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
+perf-$(CONFIG_DWARF) += dwarf-regs.o
+perf-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
 
-libperf-y += machine.o
+perf-y += machine.o
 
-libperf-$(CONFIG_AUXTRACE) += auxtrace.o
+perf-$(CONFIG_AUXTRACE) += auxtrace.o
diff --git a/tools/perf/arch/sh/Build b/tools/perf/arch/sh/Build
index 54afe4a467e7..e4e5f33c84d8 100644
--- a/tools/perf/arch/sh/Build
+++ b/tools/perf/arch/sh/Build
@@ -1 +1 @@
-libperf-y += util/
+perf-y += util/
diff --git a/tools/perf/arch/sh/util/Build b/tools/perf/arch/sh/util/Build
index 954e287bbb89..e813e618954b 100644
--- a/tools/perf/arch/sh/util/Build
+++ b/tools/perf/arch/sh/util/Build
@@ -1 +1 @@
-libperf-$(CONFIG_DWARF) += dwarf-regs.o
+perf-$(CONFIG_DWARF) += dwarf-regs.o
diff --git a/tools/perf/arch/sparc/Build b/tools/perf/arch/sparc/Build
index 54afe4a467e7..e4e5f33c84d8 100644
--- a/tools/perf/arch/sparc/Build
+++ b/tools/perf/arch/sparc/Build
@@ -1 +1 @@
-libperf-y += util/
+perf-y += util/
diff --git a/tools/perf/arch/sparc/util/Build b/tools/perf/arch/sparc/util/Build
index 954e287bbb89..e813e618954b 100644
--- a/tools/perf/arch/sparc/util/Build
+++ b/tools/perf/arch/sparc/util/Build
@@ -1 +1 @@
-libperf-$(CONFIG_DWARF) += dwarf-regs.o
+perf-$(CONFIG_DWARF) += dwarf-regs.o
diff --git a/tools/perf/arch/x86/Build b/tools/perf/arch/x86/Build
index db52fa22d3a1..a7dd46a5b678 100644
--- a/tools/perf/arch/x86/Build
+++ b/tools/perf/arch/x86/Build
@@ -1,2 +1,2 @@
-libperf-y += util/
-libperf-y += tests/
+perf-y += util/
+perf-y += tests/
diff --git a/tools/perf/arch/x86/tests/Build b/tools/perf/arch/x86/tests/Build
index 586849ff83a0..3d83d0c6982d 100644
--- a/tools/perf/arch/x86/tests/Build
+++ b/tools/perf/arch/x86/tests/Build
@@ -1,8 +1,8 @@
-libperf-$(CONFIG_DWARF_UNWIND) += regs_load.o
-libperf-$(CONFIG_DWARF_UNWIND) += dwarf-unwind.o
+perf-$(CONFIG_DWARF_UNWIND) += regs_load.o
+perf-$(CONFIG_DWARF_UNWIND) += dwarf-unwind.o
 
-libperf-y += arch-tests.o
-libperf-y += rdpmc.o
-libperf-y += perf-time-to-tsc.o
-libperf-$(CONFIG_AUXTRACE) += insn-x86.o
-libperf-$(CONFIG_X86_64) += bp-modify.o
+perf-y += arch-tests.o
+perf-y += rdpmc.o
+perf-y += perf-time-to-tsc.o
+perf-$(CONFIG_AUXTRACE) += insn-x86.o
+perf-$(CONFIG_X86_64) += bp-modify.o
diff --git a/tools/perf/arch/x86/util/Build b/tools/perf/arch/x86/util/Build
index 844b8f335532..7aab0be5fc5f 100644
--- a/tools/perf/arch/x86/util/Build
+++ b/tools/perf/arch/x86/util/Build
@@ -1,18 +1,18 @@
-libperf-y += header.o
-libperf-y += tsc.o
-libperf-y += pmu.o
-libperf-y += kvm-stat.o
-libperf-y += perf_regs.o
-libperf-y += group.o
-libperf-y += machine.o
-libperf-y += event.o
+perf-y += header.o
+perf-y += tsc.o
+perf-y += pmu.o
+perf-y += kvm-stat.o
+perf-y += perf_regs.o
+perf-y += group.o
+perf-y += machine.o
+perf-y += event.o
 
-libperf-$(CONFIG_DWARF) += dwarf-regs.o
-libperf-$(CONFIG_BPF_PROLOGUE) += dwarf-regs.o
+perf-$(CONFIG_DWARF) += dwarf-regs.o
+perf-$(CONFIG_BPF_PROLOGUE) += dwarf-regs.o
 
-libperf-$(CONFIG_LOCAL_LIBUNWIND)    += unwind-libunwind.o
-libperf-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
+perf-$(CONFIG_LOCAL_LIBUNWIND)    += unwind-libunwind.o
+perf-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
 
-libperf-$(CONFIG_AUXTRACE) += auxtrace.o
-libperf-$(CONFIG_AUXTRACE) += intel-pt.o
-libperf-$(CONFIG_AUXTRACE) += intel-bts.o
+perf-$(CONFIG_AUXTRACE) += auxtrace.o
+perf-$(CONFIG_AUXTRACE) += intel-pt.o
+perf-$(CONFIG_AUXTRACE) += intel-bts.o
diff --git a/tools/perf/arch/xtensa/Build b/tools/perf/arch/xtensa/Build
index 54afe4a467e7..e4e5f33c84d8 100644
--- a/tools/perf/arch/xtensa/Build
+++ b/tools/perf/arch/xtensa/Build
@@ -1 +1 @@
-libperf-y += util/
+perf-y += util/
diff --git a/tools/perf/arch/xtensa/util/Build b/tools/perf/arch/xtensa/util/Build
index 954e287bbb89..e813e618954b 100644
--- a/tools/perf/arch/xtensa/util/Build
+++ b/tools/perf/arch/xtensa/util/Build
@@ -1 +1 @@
-libperf-$(CONFIG_DWARF) += dwarf-regs.o
+perf-$(CONFIG_DWARF) += dwarf-regs.o
diff --git a/tools/perf/scripts/Build b/tools/perf/scripts/Build
index 41efd7e368b3..68d4b54574ad 100644
--- a/tools/perf/scripts/Build
+++ b/tools/perf/scripts/Build
@@ -1,2 +1,2 @@
-libperf-$(CONFIG_LIBPERL)   += perl/Perf-Trace-Util/
-libperf-$(CONFIG_LIBPYTHON) += python/Perf-Trace-Util/
+perf-$(CONFIG_LIBPERL)   += perl/Perf-Trace-Util/
+perf-$(CONFIG_LIBPYTHON) += python/Perf-Trace-Util/
diff --git a/tools/perf/scripts/perl/Perf-Trace-Util/Build b/tools/perf/scripts/perl/Perf-Trace-Util/Build
index 34faecf774ae..db0036129307 100644
--- a/tools/perf/scripts/perl/Perf-Trace-Util/Build
+++ b/tools/perf/scripts/perl/Perf-Trace-Util/Build
@@ -1,4 +1,4 @@
-libperf-y += Context.o
+perf-y += Context.o
 
 CFLAGS_Context.o += $(PERL_EMBED_CCOPTS) -Wno-redundant-decls -Wno-strict-prototypes
 CFLAGS_Context.o += -Wno-unused-parameter -Wno-nested-externs -Wno-undef
diff --git a/tools/perf/scripts/python/Perf-Trace-Util/Build b/tools/perf/scripts/python/Perf-Trace-Util/Build
index aefc15c9444a..7d0e33ce6aba 100644
--- a/tools/perf/scripts/python/Perf-Trace-Util/Build
+++ b/tools/perf/scripts/python/Perf-Trace-Util/Build
@@ -1,3 +1,3 @@
-libperf-y += Context.o
+perf-y += Context.o
 
 CFLAGS_Context.o += $(PYTHON_EMBED_CCOPTS) -Wno-redundant-decls -Wno-strict-prototypes -Wno-unused-parameter -Wno-nested-externs
diff --git a/tools/perf/trace/beauty/Build b/tools/perf/trace/beauty/Build
index 637365099b7d..85f328ddf897 100644
--- a/tools/perf/trace/beauty/Build
+++ b/tools/perf/trace/beauty/Build
@@ -1,15 +1,15 @@
-libperf-y += clone.o
-libperf-y += fcntl.o
-libperf-y += flock.o
+perf-y += clone.o
+perf-y += fcntl.o
+perf-y += flock.o
 ifeq ($(SRCARCH),$(filter $(SRCARCH),x86))
-libperf-y += ioctl.o
+perf-y += ioctl.o
 endif
-libperf-y += kcmp.o
-libperf-y += mount_flags.o
-libperf-y += pkey_alloc.o
-libperf-y += arch_prctl.o
-libperf-y += prctl.o
-libperf-y += renameat.o
-libperf-y += sockaddr.o
-libperf-y += socket.o
-libperf-y += statx.o
+perf-y += kcmp.o
+perf-y += mount_flags.o
+perf-y += pkey_alloc.o
+perf-y += arch_prctl.o
+perf-y += prctl.o
+perf-y += renameat.o
+perf-y += sockaddr.o
+perf-y += socket.o
+perf-y += statx.o
diff --git a/tools/perf/ui/Build b/tools/perf/ui/Build
index 0a73538c0441..3aff83c3275f 100644
--- a/tools/perf/ui/Build
+++ b/tools/perf/ui/Build
@@ -1,14 +1,14 @@
-libperf-y += setup.o
-libperf-y += helpline.o
-libperf-y += progress.o
-libperf-y += util.o
-libperf-y += hist.o
-libperf-y += stdio/hist.o
+perf-y += setup.o
+perf-y += helpline.o
+perf-y += progress.o
+perf-y += util.o
+perf-y += hist.o
+perf-y += stdio/hist.o
 
 CFLAGS_setup.o += -DLIBDIR="BUILD_STR($(LIBDIR))"
 
-libperf-$(CONFIG_SLANG) += browser.o
-libperf-$(CONFIG_SLANG) += browsers/
-libperf-$(CONFIG_SLANG) += tui/
+perf-$(CONFIG_SLANG) += browser.o
+perf-$(CONFIG_SLANG) += browsers/
+perf-$(CONFIG_SLANG) += tui/
 
 CFLAGS_browser.o += -DENABLE_SLFUTURE_CONST
diff --git a/tools/perf/ui/browsers/Build b/tools/perf/ui/browsers/Build
index de223f5bed58..8fee56b46502 100644
--- a/tools/perf/ui/browsers/Build
+++ b/tools/perf/ui/browsers/Build
@@ -1,8 +1,8 @@
-libperf-y += annotate.o
-libperf-y += hists.o
-libperf-y += map.o
-libperf-y += scripts.o
-libperf-y += header.o
+perf-y += annotate.o
+perf-y += hists.o
+perf-y += map.o
+perf-y += scripts.o
+perf-y += header.o
 
 CFLAGS_annotate.o += -DENABLE_SLFUTURE_CONST
 CFLAGS_hists.o    += -DENABLE_SLFUTURE_CONST
diff --git a/tools/perf/ui/tui/Build b/tools/perf/ui/tui/Build
index 9e4c6ca41a9f..f916df33a1a7 100644
--- a/tools/perf/ui/tui/Build
+++ b/tools/perf/ui/tui/Build
@@ -1,4 +1,4 @@
-libperf-y += setup.o
-libperf-y += util.o
-libperf-y += helpline.o
-libperf-y += progress.o
+perf-y += setup.o
+perf-y += util.o
+perf-y += helpline.o
+perf-y += progress.o
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index a36e6e5a6f4f..ca0741c91903 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -1,162 +1,162 @@
-libperf-y += annotate.o
-libperf-y += block-range.o
-libperf-y += build-id.o
-libperf-y += config.o
-libperf-y += ctype.o
-libperf-y += db-export.o
-libperf-y += env.o
-libperf-y += event.o
-libperf-y += evlist.o
-libperf-y += evsel.o
-libperf-y += evsel_fprintf.o
-libperf-y += find_bit.o
-libperf-y += get_current_dir_name.o
-libperf-y += kallsyms.o
-libperf-y += levenshtein.o
-libperf-y += llvm-utils.o
-libperf-y += mmap.o
-libperf-y += memswap.o
-libperf-y += parse-events.o
-libperf-y += perf_regs.o
-libperf-y += path.o
-libperf-y += print_binary.o
-libperf-y += rbtree.o
-libperf-y += libstring.o
-libperf-y += bitmap.o
-libperf-y += hweight.o
-libperf-y += smt.o
-libperf-y += strbuf.o
-libperf-y += string.o
-libperf-y += strlist.o
-libperf-y += strfilter.o
-libperf-y += top.o
-libperf-y += usage.o
-libperf-y += dso.o
-libperf-y += symbol.o
-libperf-y += symbol_fprintf.o
-libperf-y += color.o
-libperf-y += color_config.o
-libperf-y += metricgroup.o
-libperf-y += header.o
-libperf-y += callchain.o
-libperf-y += values.o
-libperf-y += debug.o
-libperf-y += machine.o
-libperf-y += map.o
-libperf-y += pstack.o
-libperf-y += session.o
-libperf-y += sample-raw.o
-libperf-y += s390-sample-raw.o
-libperf-$(CONFIG_TRACE) += syscalltbl.o
-libperf-y += ordered-events.o
-libperf-y += namespaces.o
-libperf-y += comm.o
-libperf-y += thread.o
-libperf-y += thread_map.o
-libperf-y += trace-event-parse.o
-libperf-y += parse-events-flex.o
-libperf-y += parse-events-bison.o
-libperf-y += pmu.o
-libperf-y += pmu-flex.o
-libperf-y += pmu-bison.o
-libperf-y += trace-event-read.o
-libperf-y += trace-event-info.o
-libperf-y += trace-event-scripting.o
-libperf-y += trace-event.o
-libperf-y += svghelper.o
-libperf-y += sort.o
-libperf-y += hist.o
-libperf-y += util.o
-libperf-y += xyarray.o
-libperf-y += cpumap.o
-libperf-y += cgroup.o
-libperf-y += target.o
-libperf-y += rblist.o
-libperf-y += intlist.o
-libperf-y += vdso.o
-libperf-y += counts.o
-libperf-y += stat.o
-libperf-y += stat-shadow.o
-libperf-y += stat-display.o
-libperf-y += record.o
-libperf-y += srcline.o
-libperf-y += srccode.o
-libperf-y += data.o
-libperf-y += tsc.o
-libperf-y += cloexec.o
-libperf-y += call-path.o
-libperf-y += rwsem.o
-libperf-y += thread-stack.o
-libperf-$(CONFIG_AUXTRACE) += auxtrace.o
-libperf-$(CONFIG_AUXTRACE) += intel-pt-decoder/
-libperf-$(CONFIG_AUXTRACE) += intel-pt.o
-libperf-$(CONFIG_AUXTRACE) += intel-bts.o
-libperf-$(CONFIG_AUXTRACE) += arm-spe.o
-libperf-$(CONFIG_AUXTRACE) += arm-spe-pkt-decoder.o
-libperf-$(CONFIG_AUXTRACE) += s390-cpumsf.o
+perf-y += annotate.o
+perf-y += block-range.o
+perf-y += build-id.o
+perf-y += config.o
+perf-y += ctype.o
+perf-y += db-export.o
+perf-y += env.o
+perf-y += event.o
+perf-y += evlist.o
+perf-y += evsel.o
+perf-y += evsel_fprintf.o
+perf-y += find_bit.o
+perf-y += get_current_dir_name.o
+perf-y += kallsyms.o
+perf-y += levenshtein.o
+perf-y += llvm-utils.o
+perf-y += mmap.o
+perf-y += memswap.o
+perf-y += parse-events.o
+perf-y += perf_regs.o
+perf-y += path.o
+perf-y += print_binary.o
+perf-y += rbtree.o
+perf-y += libstring.o
+perf-y += bitmap.o
+perf-y += hweight.o
+perf-y += smt.o
+perf-y += strbuf.o
+perf-y += string.o
+perf-y += strlist.o
+perf-y += strfilter.o
+perf-y += top.o
+perf-y += usage.o
+perf-y += dso.o
+perf-y += symbol.o
+perf-y += symbol_fprintf.o
+perf-y += color.o
+perf-y += color_config.o
+perf-y += metricgroup.o
+perf-y += header.o
+perf-y += callchain.o
+perf-y += values.o
+perf-y += debug.o
+perf-y += machine.o
+perf-y += map.o
+perf-y += pstack.o
+perf-y += session.o
+perf-y += sample-raw.o
+perf-y += s390-sample-raw.o
+perf-$(CONFIG_TRACE) += syscalltbl.o
+perf-y += ordered-events.o
+perf-y += namespaces.o
+perf-y += comm.o
+perf-y += thread.o
+perf-y += thread_map.o
+perf-y += trace-event-parse.o
+perf-y += parse-events-flex.o
+perf-y += parse-events-bison.o
+perf-y += pmu.o
+perf-y += pmu-flex.o
+perf-y += pmu-bison.o
+perf-y += trace-event-read.o
+perf-y += trace-event-info.o
+perf-y += trace-event-scripting.o
+perf-y += trace-event.o
+perf-y += svghelper.o
+perf-y += sort.o
+perf-y += hist.o
+perf-y += util.o
+perf-y += xyarray.o
+perf-y += cpumap.o
+perf-y += cgroup.o
+perf-y += target.o
+perf-y += rblist.o
+perf-y += intlist.o
+perf-y += vdso.o
+perf-y += counts.o
+perf-y += stat.o
+perf-y += stat-shadow.o
+perf-y += stat-display.o
+perf-y += record.o
+perf-y += srcline.o
+perf-y += srccode.o
+perf-y += data.o
+perf-y += tsc.o
+perf-y += cloexec.o
+perf-y += call-path.o
+perf-y += rwsem.o
+perf-y += thread-stack.o
+perf-$(CONFIG_AUXTRACE) += auxtrace.o
+perf-$(CONFIG_AUXTRACE) += intel-pt-decoder/
+perf-$(CONFIG_AUXTRACE) += intel-pt.o
+perf-$(CONFIG_AUXTRACE) += intel-bts.o
+perf-$(CONFIG_AUXTRACE) += arm-spe.o
+perf-$(CONFIG_AUXTRACE) += arm-spe-pkt-decoder.o
+perf-$(CONFIG_AUXTRACE) += s390-cpumsf.o
 
 ifdef CONFIG_LIBOPENCSD
-libperf-$(CONFIG_AUXTRACE) += cs-etm.o
-libperf-$(CONFIG_AUXTRACE) += cs-etm-decoder/
+perf-$(CONFIG_AUXTRACE) += cs-etm.o
+perf-$(CONFIG_AUXTRACE) += cs-etm-decoder/
 endif
 
-libperf-y += parse-branch-options.o
-libperf-y += dump-insn.o
-libperf-y += parse-regs-options.o
-libperf-y += term.o
-libperf-y += help-unknown-cmd.o
-libperf-y += mem-events.o
-libperf-y += vsprintf.o
-libperf-y += units.o
-libperf-y += time-utils.o
-libperf-y += expr-bison.o
-libperf-y += branch.o
-libperf-y += mem2node.o
-
-libperf-$(CONFIG_LIBBPF) += bpf-loader.o
-libperf-$(CONFIG_BPF_PROLOGUE) += bpf-prologue.o
-libperf-$(CONFIG_LIBELF) += symbol-elf.o
-libperf-$(CONFIG_LIBELF) += probe-file.o
-libperf-$(CONFIG_LIBELF) += probe-event.o
+perf-y += parse-branch-options.o
+perf-y += dump-insn.o
+perf-y += parse-regs-options.o
+perf-y += term.o
+perf-y += help-unknown-cmd.o
+perf-y += mem-events.o
+perf-y += vsprintf.o
+perf-y += units.o
+perf-y += time-utils.o
+perf-y += expr-bison.o
+perf-y += branch.o
+perf-y += mem2node.o
+
+perf-$(CONFIG_LIBBPF) += bpf-loader.o
+perf-$(CONFIG_BPF_PROLOGUE) += bpf-prologue.o
+perf-$(CONFIG_LIBELF) += symbol-elf.o
+perf-$(CONFIG_LIBELF) += probe-file.o
+perf-$(CONFIG_LIBELF) += probe-event.o
 
 ifndef CONFIG_LIBELF
-libperf-y += symbol-minimal.o
+perf-y += symbol-minimal.o
 endif
 
 ifndef CONFIG_SETNS
-libperf-y += setns.o
+perf-y += setns.o
 endif
 
-libperf-$(CONFIG_DWARF) += probe-finder.o
-libperf-$(CONFIG_DWARF) += dwarf-aux.o
-libperf-$(CONFIG_DWARF) += dwarf-regs.o
+perf-$(CONFIG_DWARF) += probe-finder.o
+perf-$(CONFIG_DWARF) += dwarf-aux.o
+perf-$(CONFIG_DWARF) += dwarf-regs.o
 
-libperf-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
-libperf-$(CONFIG_LOCAL_LIBUNWIND)    += unwind-libunwind-local.o
-libperf-$(CONFIG_LIBUNWIND)          += unwind-libunwind.o
-libperf-$(CONFIG_LIBUNWIND_X86)      += libunwind/x86_32.o
-libperf-$(CONFIG_LIBUNWIND_AARCH64)  += libunwind/arm64.o
+perf-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
+perf-$(CONFIG_LOCAL_LIBUNWIND)    += unwind-libunwind-local.o
+perf-$(CONFIG_LIBUNWIND)          += unwind-libunwind.o
+perf-$(CONFIG_LIBUNWIND_X86)      += libunwind/x86_32.o
+perf-$(CONFIG_LIBUNWIND_AARCH64)  += libunwind/arm64.o
 
-libperf-$(CONFIG_LIBBABELTRACE) += data-convert-bt.o
+perf-$(CONFIG_LIBBABELTRACE) += data-convert-bt.o
 
-libperf-y += scripting-engines/
+perf-y += scripting-engines/
 
-libperf-$(CONFIG_ZLIB) += zlib.o
-libperf-$(CONFIG_LZMA) += lzma.o
-libperf-y += demangle-java.o
-libperf-y += demangle-rust.o
+perf-$(CONFIG_ZLIB) += zlib.o
+perf-$(CONFIG_LZMA) += lzma.o
+perf-y += demangle-java.o
+perf-y += demangle-rust.o
 
 ifdef CONFIG_JITDUMP
-libperf-$(CONFIG_LIBELF) += jitdump.o
-libperf-$(CONFIG_LIBELF) += genelf.o
-libperf-$(CONFIG_DWARF) += genelf_debug.o
+perf-$(CONFIG_LIBELF) += jitdump.o
+perf-$(CONFIG_LIBELF) += genelf.o
+perf-$(CONFIG_DWARF) += genelf_debug.o
 endif
 
-libperf-y += perf-hooks.o
+perf-y += perf-hooks.o
 
-libperf-$(CONFIG_LIBBPF) += bpf-event.o
+perf-$(CONFIG_LIBBPF) += bpf-event.o
 
-libperf-$(CONFIG_CXX) += c++/
+perf-$(CONFIG_CXX) += c++/
 
 CFLAGS_config.o   += -DETC_PERFCONFIG="BUILD_STR($(ETC_PERFCONFIG_SQ))"
 CFLAGS_llvm-utils.o += -DPERF_INCLUDE_DIR="BUILD_STR($(perf_include_dir_SQ))"
diff --git a/tools/perf/util/c++/Build b/tools/perf/util/c++/Build
index 988fef1b11d7..613ecfd76527 100644
--- a/tools/perf/util/c++/Build
+++ b/tools/perf/util/c++/Build
@@ -1,2 +1,2 @@
-libperf-$(CONFIG_CLANGLLVM) += clang.o
-libperf-$(CONFIG_CLANGLLVM) += clang-test.o
+perf-$(CONFIG_CLANGLLVM) += clang.o
+perf-$(CONFIG_CLANGLLVM) += clang-test.o
diff --git a/tools/perf/util/cs-etm-decoder/Build b/tools/perf/util/cs-etm-decoder/Build
index bc22c39c727f..216cb17a3322 100644
--- a/tools/perf/util/cs-etm-decoder/Build
+++ b/tools/perf/util/cs-etm-decoder/Build
@@ -1 +1 @@
-libperf-$(CONFIG_AUXTRACE) += cs-etm-decoder.o
+perf-$(CONFIG_AUXTRACE) += cs-etm-decoder.o
diff --git a/tools/perf/util/intel-pt-decoder/Build b/tools/perf/util/intel-pt-decoder/Build
index 1b704fbea9de..23bf788f84b9 100644
--- a/tools/perf/util/intel-pt-decoder/Build
+++ b/tools/perf/util/intel-pt-decoder/Build
@@ -1,4 +1,4 @@
-libperf-$(CONFIG_AUXTRACE) += intel-pt-pkt-decoder.o intel-pt-insn-decoder.o intel-pt-log.o intel-pt-decoder.o
+perf-$(CONFIG_AUXTRACE) += intel-pt-pkt-decoder.o intel-pt-insn-decoder.o intel-pt-log.o intel-pt-decoder.o
 
 inat_tables_script = util/intel-pt-decoder/gen-insn-attr-x86.awk
 inat_tables_maps = util/intel-pt-decoder/x86-opcode-map.txt
diff --git a/tools/perf/util/scripting-engines/Build b/tools/perf/util/scripting-engines/Build
index 82d28c67e0f3..7b342ce38d99 100644
--- a/tools/perf/util/scripting-engines/Build
+++ b/tools/perf/util/scripting-engines/Build
@@ -1,5 +1,5 @@
-libperf-$(CONFIG_LIBPERL)   += trace-event-perl.o
-libperf-$(CONFIG_LIBPYTHON) += trace-event-python.o
+perf-$(CONFIG_LIBPERL)   += trace-event-perl.o
+perf-$(CONFIG_LIBPYTHON) += trace-event-python.o
 
 CFLAGS_trace-event-perl.o += $(PERL_EMBED_CCOPTS) -Wno-redundant-decls -Wno-strict-prototypes -Wno-unused-parameter -Wno-shadow -Wno-nested-externs -Wno-undef -Wno-switch-default
 
-- 
2.19.1

