Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 989C1C282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 12:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 651D820863
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 12:20:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfBIMUh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 07:20:37 -0500
Received: from terminus.zytor.com ([198.137.202.136]:56215 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbfBIMUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 07:20:36 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x19CKFwT2624170
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 9 Feb 2019 04:20:15 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x19CKEJK2624164;
        Sat, 9 Feb 2019 04:20:14 -0800
Date:   Sat, 9 Feb 2019 04:20:14 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Ravi Bangoria <tipbot@zytor.com>
Message-ID: <tip-f0fabf9c897327abd39018aefb5029aff8c7e133@git.kernel.org>
Cc:     tglx@linutronix.de, dzickus@redhat.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, mpe@ellerman.id.au,
        namhyung@kernel.org, acme@redhat.com, hpa@zytor.com,
        ravi.bangoria@linux.ibm.com, jmario@redhat.com, jolsa@kernel.org,
        fowles@inreach.com, maddy@linux.vnet.ibm.com
Reply-To: ravi.bangoria@linux.ibm.com, maddy@linux.vnet.ibm.com,
          hpa@zytor.com, fowles@inreach.com, acme@redhat.com,
          mpe@ellerman.id.au, namhyung@kernel.org, jolsa@kernel.org,
          linux-kernel@vger.kernel.org, jmario@redhat.com,
          mingo@kernel.org, dzickus@redhat.com, tglx@linutronix.de
In-Reply-To: <20190129132412.771-1-ravi.bangoria@linux.ibm.com>
References: <20190129132412.771-1-ravi.bangoria@linux.ibm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf mem/c2c: Fix perf_mem_events to support
 powerpc
Git-Commit-ID: f0fabf9c897327abd39018aefb5029aff8c7e133
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

Commit-ID:  f0fabf9c897327abd39018aefb5029aff8c7e133
Gitweb:     https://git.kernel.org/tip/f0fabf9c897327abd39018aefb5029aff8c7e133
Author:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
AuthorDate: Tue, 29 Jan 2019 18:54:12 +0530
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 4 Feb 2019 11:32:14 -0300

perf mem/c2c: Fix perf_mem_events to support powerpc

PowerPC hardware does not have a builtin latency filter (--ldlat) for
the "mem-load" event and perf_mem_events by default includes
"/ldlat=30/" which is causing a failure on PowerPC. Refactor the code to
support "perf mem/c2c" on PowerPC.

This patch depends on kernel side changes done my Madhavan:
https://lists.ozlabs.org/pipermail/linuxppc-dev/2018-December/182596.html

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Dick Fowles <fowles@inreach.com>
Cc: Don Zickus <dzickus@redhat.com>
Cc: Joe Mario <jmario@redhat.com>
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org
Link: http://lkml.kernel.org/r/20190129132412.771-1-ravi.bangoria@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-c2c.txt     | 16 ++++++++++++----
 tools/perf/Documentation/perf-mem.txt     |  2 +-
 tools/perf/arch/powerpc/util/Build        |  1 +
 tools/perf/arch/powerpc/util/mem-events.c | 11 +++++++++++
 tools/perf/util/mem-events.c              |  2 +-
 5 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/tools/perf/Documentation/perf-c2c.txt b/tools/perf/Documentation/perf-c2c.txt
index 095aebdc5bb7..e6150f21267d 100644
--- a/tools/perf/Documentation/perf-c2c.txt
+++ b/tools/perf/Documentation/perf-c2c.txt
@@ -19,8 +19,11 @@ C2C stands for Cache To Cache.
 The perf c2c tool provides means for Shared Data C2C/HITM analysis. It allows
 you to track down the cacheline contentions.
 
-The tool is based on x86's load latency and precise store facility events
-provided by Intel CPUs. These events provide:
+On x86, the tool is based on load latency and precise store facility events
+provided by Intel CPUs. On PowerPC, the tool uses random instruction sampling
+with thresholding feature.
+
+These events provide:
   - memory address of the access
   - type of the access (load and store details)
   - latency (in cycles) of the load access
@@ -46,7 +49,7 @@ RECORD OPTIONS
 
 -l::
 --ldlat::
-	Configure mem-loads latency.
+	Configure mem-loads latency. (x86 only)
 
 -k::
 --all-kernel::
@@ -119,11 +122,16 @@ Following perf record options are configured by default:
   -W,-d,--phys-data,--sample-cpu
 
 Unless specified otherwise with '-e' option, following events are monitored by
-default:
+default on x86:
 
   cpu/mem-loads,ldlat=30/P
   cpu/mem-stores/P
 
+and following on PowerPC:
+
+  cpu/mem-loads/
+  cpu/mem-stores/
+
 User can pass any 'perf record' option behind '--' mark, like (to enable
 callchains and system wide monitoring):
 
diff --git a/tools/perf/Documentation/perf-mem.txt b/tools/perf/Documentation/perf-mem.txt
index f8d2167cf3e7..199ea0f0a6c0 100644
--- a/tools/perf/Documentation/perf-mem.txt
+++ b/tools/perf/Documentation/perf-mem.txt
@@ -82,7 +82,7 @@ RECORD OPTIONS
 	Be more verbose (show counter open errors, etc)
 
 --ldlat <n>::
-	Specify desired latency for loads event.
+	Specify desired latency for loads event. (x86 only)
 
 In addition, for report all perf report options are valid, and for record
 all perf record options.
diff --git a/tools/perf/arch/powerpc/util/Build b/tools/perf/arch/powerpc/util/Build
index 2e6595310420..ba98bd006488 100644
--- a/tools/perf/arch/powerpc/util/Build
+++ b/tools/perf/arch/powerpc/util/Build
@@ -2,6 +2,7 @@ libperf-y += header.o
 libperf-y += sym-handling.o
 libperf-y += kvm-stat.o
 libperf-y += perf_regs.o
+libperf-y += mem-events.o
 
 libperf-$(CONFIG_DWARF) += dwarf-regs.o
 libperf-$(CONFIG_DWARF) += skip-callchain-idx.o
diff --git a/tools/perf/arch/powerpc/util/mem-events.c b/tools/perf/arch/powerpc/util/mem-events.c
new file mode 100644
index 000000000000..d08311f04e95
--- /dev/null
+++ b/tools/perf/arch/powerpc/util/mem-events.c
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "mem-events.h"
+
+/* PowerPC does not support 'ldlat' parameter. */
+char *perf_mem_events__name(int i)
+{
+	if (i == PERF_MEM_EVENTS__LOAD)
+		return (char *) "cpu/mem-loads/";
+
+	return (char *) "cpu/mem-stores/";
+}
diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index 93f74d8d3cdd..42c3e5a229d2 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -28,7 +28,7 @@ struct perf_mem_event perf_mem_events[PERF_MEM_EVENTS__MAX] = {
 static char mem_loads_name[100];
 static bool mem_loads_name__init;
 
-char *perf_mem_events__name(int i)
+char * __weak perf_mem_events__name(int i)
 {
 	if (i == PERF_MEM_EVENTS__LOAD) {
 		if (!mem_loads_name__init) {
