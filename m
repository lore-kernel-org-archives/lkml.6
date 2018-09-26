Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A78BEC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38D2B206B2
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:57:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38D2B206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbeIZPJb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 11:09:31 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54077 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbeIZPJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 11:09:30 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8Q8v8Il3773245
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 26 Sep 2018 01:57:08 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8Q8v7WQ3773242;
        Wed, 26 Sep 2018 01:57:07 -0700
Date:   Wed, 26 Sep 2018 01:57:07 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Sean V Kelley <tipbot@zytor.com>
Message-ID: <tip-tzvs1ip6srcv2et0ny58e0wy@git.kernel.org>
Cc:     acme@redhat.com, tglx@linutronix.de, hpa@zytor.com,
        john.garry@huawei.com, linux-kernel@vger.kernel.org,
        wcohen@redhat.com, seanvk.dev@oregontracks.org, mingo@kernel.org
Reply-To: acme@redhat.com, hpa@zytor.com, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, john.garry@huawei.com,
          wcohen@redhat.com, mingo@kernel.org, seanvk.dev@oregontracks.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf vendor events arm64: Revise core JSON events
 for eMAG
Git-Commit-ID: d35c595bf0053b7df80ef9d44140ac5da6cc698b
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

Commit-ID:  d35c595bf0053b7df80ef9d44140ac5da6cc698b
Gitweb:     https://git.kernel.org/tip/d35c595bf0053b7df80ef9d44140ac5da6cc698b
Author:     Sean V Kelley <seanvk.dev@oregontracks.org>
AuthorDate: Sun, 16 Sep 2018 15:12:03 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 20 Sep 2018 15:54:40 -0300

perf vendor events arm64: Revise core JSON events for eMAG

Split the PMU events into meaningful functional groups.  Update core pmu
events based on supported ARMv8 recommended IMPLEMENTATION DEFINED
events.

The JSON files are updated with reference to a PMU table shared here:

  https://github.com/AmpereComputing/ampere-centos-kernel/blob/amp-centos-7.5-kernel/Documentation/arm64/eMAG-ARM-CoreImpDefined.pdf

Changes in v3:
- Removed CHAIN event as it wouldn't be useful in Perf - William
- Will factor out events 0x00-0x38 in a follow-on patch - William
- to armv8-recommended.json
Changes in V2:
- Provided documentation for changes - John, William
- Broke up into meaningful groups - William

Signed-off-by: Sean V Kelley <seanvk.dev@oregontracks.org>
Reviewed-by: William Cohen <wcohen@redhat.com>
Cc: John Garry <john.garry@huawei.com>
Cc: linux-arm-kernel@lists.infradead.org
LPU-Reference: 20180916221203.7935-1-seanvk.dev@oregontracks.org
Link: https://lkml.kernel.org/n/tip-tzvs1ip6srcv2et0ny58e0wy@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../pmu-events/arch/arm64/ampere/emag/branch.json  |  23 +++
 .../pmu-events/arch/arm64/ampere/emag/bus.json     |  26 +++
 .../pmu-events/arch/arm64/ampere/emag/cache.json   | 191 +++++++++++++++++++++
 .../pmu-events/arch/arm64/ampere/emag/clock.json   |  20 +++
 .../arch/arm64/ampere/emag/core-imp-def.json       |  32 ----
 .../arch/arm64/ampere/emag/exception.json          |  50 ++++++
 .../arch/arm64/ampere/emag/instruction.json        |  89 ++++++++++
 .../arch/arm64/ampere/emag/intrinsic.json          |  14 ++
 .../pmu-events/arch/arm64/ampere/emag/memory.json  |  29 ++++
 .../arch/arm64/ampere/emag/pipeline.json           |  50 ++++++
 10 files changed, 492 insertions(+), 32 deletions(-)

diff --git a/tools/perf/pmu-events/arch/arm64/ampere/emag/branch.json b/tools/perf/pmu-events/arch/arm64/ampere/emag/branch.json
new file mode 100644
index 000000000000..abc98b018446
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/ampere/emag/branch.json
@@ -0,0 +1,23 @@
+[
+    {
+        "ArchStdEvent": "BR_IMMED_SPEC",
+    },
+    {
+        "ArchStdEvent": "BR_RETURN_SPEC",
+    },
+    {
+        "ArchStdEvent": "BR_INDIRECT_SPEC",
+    },
+    {
+        "PublicDescription": "Mispredicted or not predicted branch speculatively executed",
+        "EventCode": "0x10",
+        "EventName": "BR_MIS_PRED",
+        "BriefDescription": "Branch mispredicted"
+    },
+    {
+        "PublicDescription": "Predictable branch speculatively executed",
+        "EventCode": "0x12",
+        "EventName": "BR_PRED",
+        "BriefDescription": "Predictable branch"
+    },
+]
diff --git a/tools/perf/pmu-events/arch/arm64/ampere/emag/bus.json b/tools/perf/pmu-events/arch/arm64/ampere/emag/bus.json
new file mode 100644
index 000000000000..687b2629e1d1
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/ampere/emag/bus.json
@@ -0,0 +1,26 @@
+[
+    {
+        "ArchStdEvent": "BUS_ACCESS_RD",
+    },
+    {
+        "ArchStdEvent": "BUS_ACCESS_WR",
+    },
+    {
+        "ArchStdEvent": "BUS_ACCESS_SHARED",
+    },
+    {
+        "ArchStdEvent": "BUS_ACCESS_NOT_SHARED",
+    },
+    {
+        "ArchStdEvent": "BUS_ACCESS_NORMAL",
+    },
+    {
+        "ArchStdEvent": "BUS_ACCESS_PERIPH",
+    },
+    {
+        "PublicDescription": "Bus access",
+        "EventCode": "0x19",
+        "EventName": "BUS_ACCESS",
+        "BriefDescription": "Bus access"
+    },
+]
diff --git a/tools/perf/pmu-events/arch/arm64/ampere/emag/cache.json b/tools/perf/pmu-events/arch/arm64/ampere/emag/cache.json
new file mode 100644
index 000000000000..df9201434cb6
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/ampere/emag/cache.json
@@ -0,0 +1,191 @@
+[
+    {
+        "ArchStdEvent": "L1D_CACHE_RD",
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_WR",
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_REFILL_RD",
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_INVAL",
+    },
+    {
+        "ArchStdEvent": "L1D_TLB_REFILL_RD",
+    },
+    {
+        "ArchStdEvent": "L1D_TLB_REFILL_WR",
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_RD",
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_WR",
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_REFILL_RD",
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_REFILL_WR",
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_WB_VICTIM",
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_WB_CLEAN",
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_INVAL",
+    },
+    {
+        "PublicDescription": "Level 1 instruction cache refill",
+        "EventCode": "0x01",
+        "EventName": "L1I_CACHE_REFILL",
+        "BriefDescription": "L1I cache refill"
+    },
+    {
+        "PublicDescription": "Level 1 instruction TLB refill",
+        "EventCode": "0x02",
+        "EventName": "L1I_TLB_REFILL",
+        "BriefDescription": "L1I TLB refill"
+    },
+    {
+        "PublicDescription": "Level 1 data cache refill",
+        "EventCode": "0x03",
+        "EventName": "L1D_CACHE_REFILL",
+        "BriefDescription": "L1D cache refill"
+    },
+    {
+        "PublicDescription": "Level 1 data cache access",
+        "EventCode": "0x04",
+        "EventName": "L1D_CACHE_ACCESS",
+        "BriefDescription": "L1D cache access"
+    },
+    {
+        "PublicDescription": "Level 1 data TLB refill",
+        "EventCode": "0x05",
+        "EventName": "L1D_TLB_REFILL",
+        "BriefDescription": "L1D TLB refill"
+    },
+    {
+        "PublicDescription": "Level 1 instruction cache access",
+        "EventCode": "0x14",
+        "EventName": "L1I_CACHE_ACCESS",
+        "BriefDescription": "L1I cache access"
+    },
+    {
+        "PublicDescription": "Level 2 data cache access",
+        "EventCode": "0x16",
+        "EventName": "L2D_CACHE_ACCESS",
+        "BriefDescription": "L2D cache access"
+    },
+    {
+        "PublicDescription": "Level 2 data refill",
+        "EventCode": "0x17",
+        "EventName": "L2D_CACHE_REFILL",
+        "BriefDescription": "L2D cache refill"
+    },
+    {
+        "PublicDescription": "Level 2 data cache, Write-Back",
+        "EventCode": "0x18",
+        "EventName": "L2D_CACHE_WB",
+        "BriefDescription": "L2D cache Write-Back"
+    },
+    {
+        "PublicDescription": "Level 1 data TLB access. This event counts any load or store operation which accesses the data L1 TLB",
+        "EventCode": "0x25",
+        "EventName": "L1D_TLB_ACCESS",
+        "BriefDescription": "L1D TLB access"
+    },
+    {
+        "PublicDescription": "Level 1 instruction TLB access. This event counts any instruction fetch which accesses the instruction L1 TLB",
+        "EventCode": "0x26",
+        "EventName": "L1I_TLB_ACCESS",
+        "BriefDescription": "L1I TLB access"
+    },
+    {
+        "PublicDescription": "Level 2 access to data TLB that caused a page table walk. This event counts on any data access which causes L2D_TLB_REFILL to count",
+        "EventCode": "0x34",
+        "EventName": "L2D_TLB_ACCESS",
+        "BriefDescription": "L2D TLB access"
+    },
+    {
+        "PublicDescription": "Level 2 access to instruciton TLB that caused a page table walk. This event counts on any instruciton access which causes L2I_TLB_REFILL to count",
+        "EventCode": "0x35",
+        "EventName": "L2I_TLB_ACCESS",
+        "BriefDescription": "L2D TLB access"
+    },
+    {
+        "PublicDescription": "Branch target buffer misprediction",
+        "EventCode": "0x102",
+        "EventName": "BTB_MIS_PRED",
+        "BriefDescription": "BTB misprediction"
+    },
+    {
+        "PublicDescription": "ITB miss",
+        "EventCode": "0x103",
+        "EventName": "ITB_MISS",
+        "BriefDescription": "ITB miss"
+    },
+    {
+        "PublicDescription": "DTB miss",
+        "EventCode": "0x104",
+        "EventName": "DTB_MISS",
+        "BriefDescription": "DTB miss"
+    },
+    {
+        "PublicDescription": "Level 1 data cache late miss",
+        "EventCode": "0x105",
+        "EventName": "L1D_CACHE_LATE_MISS",
+        "BriefDescription": "L1D cache late miss"
+    },
+    {
+        "PublicDescription": "Level 1 data cache prefetch request",
+        "EventCode": "0x106",
+        "EventName": "L1D_CACHE_PREFETCH",
+        "BriefDescription": "L1D cache prefetch"
+    },
+    {
+        "PublicDescription": "Level 2 data cache prefetch request",
+        "EventCode": "0x107",
+        "EventName": "L2D_CACHE_PREFETCH",
+        "BriefDescription": "L2D cache prefetch"
+    },
+    {
+        "PublicDescription": "Level 1 stage 2 TLB refill",
+        "EventCode": "0x111",
+        "EventName": "L1_STAGE2_TLB_REFILL",
+        "BriefDescription": "L1 stage 2 TLB refill"
+    },
+    {
+        "PublicDescription": "Page walk cache level-0 stage-1 hit",
+        "EventCode": "0x112",
+        "EventName": "PAGE_WALK_L0_STAGE1_HIT",
+        "BriefDescription": "Page walk, L0 stage-1 hit"
+    },
+    {
+        "PublicDescription": "Page walk cache level-1 stage-1 hit",
+        "EventCode": "0x113",
+        "EventName": "PAGE_WALK_L1_STAGE1_HIT",
+        "BriefDescription": "Page walk, L1 stage-1 hit"
+    },
+    {
+        "PublicDescription": "Page walk cache level-2 stage-1 hit",
+        "EventCode": "0x114",
+        "EventName": "PAGE_WALK_L2_STAGE1_HIT",
+        "BriefDescription": "Page walk, L2 stage-1 hit"
+    },
+    {
+        "PublicDescription": "Page walk cache level-1 stage-2 hit",
+        "EventCode": "0x115",
+        "EventName": "PAGE_WALK_L1_STAGE2_HIT",
+        "BriefDescription": "Page walk, L1 stage-2 hit"
+    },
+    {
+        "PublicDescription": "Page walk cache level-2 stage-2 hit",
+        "EventCode": "0x116",
+        "EventName": "PAGE_WALK_L2_STAGE2_HIT",
+        "BriefDescription": "Page walk, L2 stage-2 hit"
+    },
+]
diff --git a/tools/perf/pmu-events/arch/arm64/ampere/emag/clock.json b/tools/perf/pmu-events/arch/arm64/ampere/emag/clock.json
new file mode 100644
index 000000000000..38cd1f1a70dc
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/ampere/emag/clock.json
@@ -0,0 +1,20 @@
+[
+    {
+        "PublicDescription": "The number of core clock cycles",
+        "EventCode": "0x11",
+        "EventName": "CPU_CYCLES",
+        "BriefDescription": "Clock cycles"
+    },
+    {
+        "PublicDescription": "FSU clocking gated off cycle",
+        "EventCode": "0x101",
+        "EventName": "FSU_CLOCK_OFF_CYCLES",
+        "BriefDescription": "FSU clocking gated off cycle"
+    },
+    {
+        "PublicDescription": "Wait state cycle",
+        "EventCode": "0x110",
+        "EventName": "Wait_CYCLES",
+        "BriefDescription": "Wait state cycle"
+    },
+]
diff --git a/tools/perf/pmu-events/arch/arm64/ampere/emag/core-imp-def.json b/tools/perf/pmu-events/arch/arm64/ampere/emag/core-imp-def.json
deleted file mode 100644
index bc03c06c3918..000000000000
--- a/tools/perf/pmu-events/arch/arm64/ampere/emag/core-imp-def.json
+++ /dev/null
@@ -1,32 +0,0 @@
-[
-    {
-        "ArchStdEvent": "L1D_CACHE_RD",
-    },
-    {
-        "ArchStdEvent": "L1D_CACHE_WR",
-    },
-    {
-        "ArchStdEvent": "L1D_CACHE_REFILL_RD",
-    },
-    {
-        "ArchStdEvent": "L1D_CACHE_REFILL_WR",
-    },
-    {
-        "ArchStdEvent": "L1D_TLB_REFILL_RD",
-    },
-    {
-        "ArchStdEvent": "L1D_TLB_REFILL_WR",
-    },
-    {
-        "ArchStdEvent": "L1D_TLB_RD",
-    },
-    {
-        "ArchStdEvent": "L1D_TLB_WR",
-    },
-    {
-        "ArchStdEvent": "BUS_ACCESS_RD",
-   },
-   {
-        "ArchStdEvent": "BUS_ACCESS_WR",
-   }
-]
diff --git a/tools/perf/pmu-events/arch/arm64/ampere/emag/exception.json b/tools/perf/pmu-events/arch/arm64/ampere/emag/exception.json
new file mode 100644
index 000000000000..3720dc28a15f
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/ampere/emag/exception.json
@@ -0,0 +1,50 @@
+[
+    {
+        "ArchStdEvent": "EXC_UNDEF",
+    },
+    {
+        "ArchStdEvent": "EXC_SVC",
+    },
+    {
+        "ArchStdEvent": "EXC_PABORT",
+    },
+    {
+        "ArchStdEvent": "EXC_DABORT",
+    },
+    {
+        "ArchStdEvent": "EXC_IRQ",
+    },
+    {
+        "ArchStdEvent": "EXC_FIQ",
+    },
+    {
+        "ArchStdEvent": "EXC_HVC",
+    },
+    {
+        "ArchStdEvent": "EXC_TRAP_PABORT",
+    },
+    {
+        "ArchStdEvent": "EXC_TRAP_DABORT",
+    },
+    {
+        "ArchStdEvent": "EXC_TRAP_OTHER",
+    },
+    {
+        "ArchStdEvent": "EXC_TRAP_IRQ",
+    },
+    {
+        "ArchStdEvent": "EXC_TRAP_FIQ",
+    },
+    {
+        "PublicDescription": "Exception taken",
+        "EventCode": "0x09",
+        "EventName": "EXC_TAKEN",
+        "BriefDescription": "Exception taken"
+    },
+    {
+        "PublicDescription": "Instruction architecturally executed, condition check pass, exception return",
+        "EventCode": "0x0a",
+        "EventName": "EXC_RETURN",
+        "BriefDescription": "Exception return"
+    },
+]
diff --git a/tools/perf/pmu-events/arch/arm64/ampere/emag/instruction.json b/tools/perf/pmu-events/arch/arm64/ampere/emag/instruction.json
new file mode 100644
index 000000000000..82cf753e6472
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/ampere/emag/instruction.json
@@ -0,0 +1,89 @@
+[
+    {
+        "ArchStdEvent": "LD_SPEC",
+    },
+    {
+        "ArchStdEvent": "ST_SPEC",
+    },
+    {
+        "ArchStdEvent": "LDST_SPEC",
+    },
+    {
+        "ArchStdEvent": "DP_SPEC",
+    },
+    {
+        "ArchStdEvent": "ASE_SPEC",
+    },
+    {
+        "ArchStdEvent": "VFP_SPEC",
+    },
+    {
+        "ArchStdEvent": "PC_WRITE_SPEC",
+    },
+    {
+        "ArchStdEvent": "CRYPTO_SPEC",
+    },
+    {
+        "ArchStdEvent": "ISB_SPEC",
+    },
+    {
+        "ArchStdEvent": "DSB_SPEC",
+    },
+    {
+        "ArchStdEvent": "DMB_SPEC",
+    },
+    {
+        "ArchStdEvent": "RC_LD_SPEC",
+    },
+    {
+        "ArchStdEvent": "RC_ST_SPEC",
+    },
+    {
+        "PublicDescription": "Instruction architecturally executed, software increment",
+        "EventCode": "0x00",
+        "EventName": "SW_INCR",
+        "BriefDescription": "Software increment"
+    },
+    {
+        "PublicDescription": "Instruction architecturally executed",
+        "EventCode": "0x08",
+        "EventName": "INST_RETIRED",
+        "BriefDescription": "Instruction retired"
+    },
+    {
+        "PublicDescription": "Instruction architecturally executed, condition code check pass, write to CONTEXTIDR",
+        "EventCode": "0x0b",
+        "EventName": "CID_WRITE_RETIRED",
+        "BriefDescription": "Write to CONTEXTIDR"
+    },
+    {
+        "PublicDescription": "Operation speculatively executed",
+        "EventCode": "0x1b",
+        "EventName": "INST_SPEC",
+        "BriefDescription": "Speculatively executed"
+    },
+    {
+        "PublicDescription": "Instruction architecturally executed (condition check pass), write to TTBR",
+        "EventCode": "0x1c",
+        "EventName": "TTBR_WRITE_RETIRED",
+        "BriefDescription": "Instruction executed, TTBR write"
+    },
+    {
+        "PublicDescription": "Instruction architecturally executed, branch. This event counts all branches, taken or not. This excludes exception entries, debug entries and CCFAIL branches",
+        "EventCode": "0x21",
+        "EventName": "BR_RETIRED",
+        "BriefDescription": "Branch retired"
+    },
+    {
+        "PublicDescription": "Instruction architecturally executed, mispredicted branch. This event counts any branch counted by BR_RETIRED which is not correctly predicted and causes a pipeline flush",
+        "EventCode": "0x22",
+        "EventName": "BR_MISPRED_RETIRED",
+        "BriefDescription": "Mispredicted branch retired"
+    },
+    {
+        "PublicDescription": "Operation speculatively executed, NOP",
+        "EventCode": "0x100",
+        "EventName": "NOP_SPEC",
+        "BriefDescription": "Speculatively executed, NOP"
+    },
+]
diff --git a/tools/perf/pmu-events/arch/arm64/ampere/emag/intrinsic.json b/tools/perf/pmu-events/arch/arm64/ampere/emag/intrinsic.json
new file mode 100644
index 000000000000..2aecc5c2347d
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/ampere/emag/intrinsic.json
@@ -0,0 +1,14 @@
+[
+    {
+        "ArchStdEvent": "LDREX_SPEC",
+    },
+    {
+        "ArchStdEvent": "STREX_PASS_SPEC",
+    },
+    {
+        "ArchStdEvent": "STREX_FAIL_SPEC",
+    },
+    {
+        "ArchStdEvent": "STREX_SPEC",
+    },
+]
diff --git a/tools/perf/pmu-events/arch/arm64/ampere/emag/memory.json b/tools/perf/pmu-events/arch/arm64/ampere/emag/memory.json
new file mode 100644
index 000000000000..08508697b318
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/ampere/emag/memory.json
@@ -0,0 +1,29 @@
+[
+    {
+        "ArchStdEvent": "MEM_ACCESS_RD",
+    },
+    {
+        "ArchStdEvent": "MEM_ACCESS_WR",
+    },
+    {
+        "ArchStdEvent": "UNALIGNED_LD_SPEC",
+    },
+    {
+        "ArchStdEvent": "UNALIGNED_ST_SPEC",
+    },
+    {
+        "ArchStdEvent": "UNALIGNED_LDST_SPEC",
+    },
+    {
+        "PublicDescription": "Data memory access",
+        "EventCode": "0x13",
+        "EventName": "MEM_ACCESS",
+        "BriefDescription": "Memory access"
+    },
+    {
+        "PublicDescription": "Local memory error. This event counts any correctable or uncorrectable memory error (ECC or parity) in the protected core RAMs",
+        "EventCode": "0x1a",
+        "EventName": "MEM_ERROR",
+        "BriefDescription": "Memory error"
+    },
+]
diff --git a/tools/perf/pmu-events/arch/arm64/ampere/emag/pipeline.json b/tools/perf/pmu-events/arch/arm64/ampere/emag/pipeline.json
new file mode 100644
index 000000000000..e2087de586bf
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/ampere/emag/pipeline.json
@@ -0,0 +1,50 @@
+[
+    {
+        "PublicDescription": "Decode starved for instruction cycle",
+        "EventCode": "0x108",
+        "EventName": "DECODE_STALL",
+        "BriefDescription": "Decode starved"
+    },
+    {
+        "PublicDescription": "Op dispatch stalled cycle",
+        "EventCode": "0x109",
+        "EventName": "DISPATCH_STALL",
+        "BriefDescription": "Dispatch stalled"
+    },
+    {
+        "PublicDescription": "IXA Op non-issue",
+        "EventCode": "0x10a",
+        "EventName": "IXA_STALL",
+        "BriefDescription": "IXA stalled"
+    },
+    {
+        "PublicDescription": "IXB Op non-issue",
+        "EventCode": "0x10b",
+        "EventName": "IXB_STALL",
+        "BriefDescription": "IXB stalled"
+    },
+    {
+        "PublicDescription": "BX Op non-issue",
+        "EventCode": "0x10c",
+        "EventName": "BX_STALL",
+        "BriefDescription": "BX stalled"
+    },
+    {
+        "PublicDescription": "LX Op non-issue",
+        "EventCode": "0x10d",
+        "EventName": "LX_STALL",
+        "BriefDescription": "LX stalled"
+    },
+    {
+        "PublicDescription": "SX Op non-issue",
+        "EventCode": "0x10e",
+        "EventName": "SX_STALL",
+        "BriefDescription": "SX stalled"
+    },
+    {
+        "PublicDescription": "FX Op non-issue",
+        "EventCode": "0x10f",
+        "EventName": "FX_STALL",
+        "BriefDescription": "FX stalled"
+    },
+]
