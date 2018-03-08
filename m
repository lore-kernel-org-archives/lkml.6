Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965928AbeCHK7x (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 05:59:53 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:60454 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S934957AbeCHK7t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 05:59:49 -0500
From: John Garry <john.garry@huawei.com>
To: <jolsa@redhat.com>, <ak@linux.intel.com>, <peterz@infradead.org>,
        <mingo@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <namhyung@kernel.org>,
        <wcohen@redhat.com>, <will.deacon@arm.com>,
        <ganapatrao.kulkarni@cavium.com>
CC: <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <zhangshaokun@hisilicon.com>,
        "John Garry" <john.garry@huawei.com>
Subject: [PATCH v3 10/11] perf vendor events arm64: fixup A53 to use recommended events
Date: Thu, 8 Mar 2018 18:58:35 +0800
Message-ID: <1520506716-197429-11-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520506716-197429-1-git-send-email-john.garry@huawei.com>
References: <1520506716-197429-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the ARM Cortex-A53 json to use event definition
from the ARMv8 recommended events.

In addition to this change, other changes were made:
- remove stray ','
- remove mirrored events in memory.json and bus.json
- fixed indentation to be consistent with other ARM
  JSONs

Cc: William Cohen <wcohen@redhat.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 .../arch/arm64/arm/cortex-a53/branch.json          | 14 +++----
 .../pmu-events/arch/arm64/arm/cortex-a53/bus.json  | 22 ++---------
 .../arch/arm64/arm/cortex-a53/cache.json           | 40 ++++++++++----------
 .../arch/arm64/arm/cortex-a53/memory.json          | 14 +------
 .../arch/arm64/arm/cortex-a53/other.json           | 44 ++++++++++------------
 .../arch/arm64/arm/cortex-a53/pipeline.json        | 20 +++++-----
 6 files changed, 62 insertions(+), 92 deletions(-)

diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a53/branch.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a53/branch.json
index 3b62087..0b0e6b2 100644
--- a/tools/perf/pmu-events/arch/arm64/arm/cortex-a53/branch.json
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a53/branch.json
@@ -1,25 +1,23 @@
 [
-  {,
-    "EventCode": "0x7A",
-    "EventName": "BR_INDIRECT_SPEC",
-    "BriefDescription": "Branch speculatively executed - Indirect branch"
+  {
+    "ArchStdEvent":  "BR_INDIRECT_SPEC",
   },
-  {,
+  {
     "EventCode": "0xC9",
     "EventName": "BR_COND",
     "BriefDescription": "Conditional branch executed"
   },
-  {,
+  {
     "EventCode": "0xCA",
     "EventName": "BR_INDIRECT_MISPRED",
     "BriefDescription": "Indirect branch mispredicted"
   },
-  {,
+  {
     "EventCode": "0xCB",
     "EventName": "BR_INDIRECT_MISPRED_ADDR",
     "BriefDescription": "Indirect branch mispredicted because of address miscompare"
   },
-  {,
+  {
     "EventCode": "0xCC",
     "EventName": "BR_COND_MISPRED",
     "BriefDescription": "Conditional branch mispredicted"
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a53/bus.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a53/bus.json
index 480d9f7..ce33b25 100644
--- a/tools/perf/pmu-events/arch/arm64/arm/cortex-a53/bus.json
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a53/bus.json
@@ -1,22 +1,8 @@
 [
-  {,
-    "EventCode": "0x60",
-    "EventName": "BUS_ACCESS_LD",
-    "BriefDescription": "Bus access - Read"
+  {
+        "ArchStdEvent": "BUS_ACCESS_RD",
   },
-  {,
-    "EventCode": "0x61",
-    "EventName": "BUS_ACCESS_ST",
-    "BriefDescription": "Bus access - Write"
-  },
-  {,
-    "EventCode": "0xC0",
-    "EventName": "EXT_MEM_REQ",
-    "BriefDescription": "External memory request"
-  },
-  {,
-    "EventCode": "0xC1",
-    "EventName": "EXT_MEM_REQ_NC",
-    "BriefDescription": "Non-cacheable external memory request"
+  {
+        "ArchStdEvent": "BUS_ACCESS_WR",
   }
 ]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a53/cache.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a53/cache.json
index 11baad6..5dfbec4 100644
--- a/tools/perf/pmu-events/arch/arm64/arm/cortex-a53/cache.json
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a53/cache.json
@@ -1,27 +1,27 @@
 [
-  {,
-    "EventCode": "0xC2",
-    "EventName": "PREFETCH_LINEFILL",
-    "BriefDescription": "Linefill because of prefetch"
+  {
+        "EventCode": "0xC2",
+        "EventName": "PREFETCH_LINEFILL",
+        "BriefDescription": "Linefill because of prefetch"
   },
-  {,
-    "EventCode": "0xC3",
-    "EventName": "PREFETCH_LINEFILL_DROP",
-    "BriefDescription": "Instruction Cache Throttle occurred"
+  {
+        "EventCode": "0xC3",
+        "EventName": "PREFETCH_LINEFILL_DROP",
+        "BriefDescription": "Instruction Cache Throttle occurred"
   },
-  {,
-    "EventCode": "0xC4",
-    "EventName": "READ_ALLOC_ENTER",
-    "BriefDescription": "Entering read allocate mode"
+  {
+        "EventCode": "0xC4",
+        "EventName": "READ_ALLOC_ENTER",
+        "BriefDescription": "Entering read allocate mode"
   },
-  {,
-    "EventCode": "0xC5",
-    "EventName": "READ_ALLOC",
-    "BriefDescription": "Read allocate mode"
+  {
+        "EventCode": "0xC5",
+        "EventName": "READ_ALLOC",
+        "BriefDescription": "Read allocate mode"
   },
-  {,
-    "EventCode": "0xC8",
-    "EventName": "EXT_SNOOP",
-    "BriefDescription": "SCU Snooped data from another CPU for this CPU"
+  {
+        "EventCode": "0xC8",
+        "EventName": "EXT_SNOOP",
+        "BriefDescription": "SCU Snooped data from another CPU for this CPU"
   }
 ]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a53/memory.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a53/memory.json
index 480d9f7..25ae642 100644
--- a/tools/perf/pmu-events/arch/arm64/arm/cortex-a53/memory.json
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a53/memory.json
@@ -1,20 +1,10 @@
 [
-  {,
-    "EventCode": "0x60",
-    "EventName": "BUS_ACCESS_LD",
-    "BriefDescription": "Bus access - Read"
-  },
-  {,
-    "EventCode": "0x61",
-    "EventName": "BUS_ACCESS_ST",
-    "BriefDescription": "Bus access - Write"
-  },
-  {,
+  {
     "EventCode": "0xC0",
     "EventName": "EXT_MEM_REQ",
     "BriefDescription": "External memory request"
   },
-  {,
+  {
     "EventCode": "0xC1",
     "EventName": "EXT_MEM_REQ_NC",
     "BriefDescription": "Non-cacheable external memory request"
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a53/other.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a53/other.json
index 73a2240..6cc6cbd 100644
--- a/tools/perf/pmu-events/arch/arm64/arm/cortex-a53/other.json
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a53/other.json
@@ -1,32 +1,28 @@
 [
-  {,
-    "EventCode": "0x86",
-    "EventName": "EXC_IRQ",
-    "BriefDescription": "Exception taken, IRQ"
+  {
+        "ArchStdEvent": "EXC_IRQ",
   },
-  {,
-    "EventCode": "0x87",
-    "EventName": "EXC_FIQ",
-    "BriefDescription": "Exception taken, FIQ"
+  {
+        "ArchStdEvent": "EXC_FIQ",
   },
-  {,
-    "EventCode": "0xC6",
-    "EventName": "PRE_DECODE_ERR",
-    "BriefDescription": "Pre-decode error"
+  {
+        "EventCode": "0xC6",
+        "EventName": "PRE_DECODE_ERR",
+        "BriefDescription": "Pre-decode error"
   },
-  {,
-    "EventCode": "0xD0",
-    "EventName": "L1I_CACHE_ERR",
-    "BriefDescription": "L1 Instruction Cache (data or tag) memory error"
+  {
+        "EventCode": "0xD0",
+        "EventName": "L1I_CACHE_ERR",
+        "BriefDescription": "L1 Instruction Cache (data or tag) memory error"
   },
-  {,
-    "EventCode": "0xD1",
-    "EventName": "L1D_CACHE_ERR",
-    "BriefDescription": "L1 Data Cache (data, tag or dirty) memory error, correctable or non-correctable"
+  {
+        "EventCode": "0xD1",
+        "EventName": "L1D_CACHE_ERR",
+        "BriefDescription": "L1 Data Cache (data, tag or dirty) memory error, correctable or non-correctable"
   },
-  {,
-    "EventCode": "0xD2",
-    "EventName": "TLB_ERR",
-    "BriefDescription": "TLB memory error"
+  {
+        "EventCode": "0xD2",
+        "EventName": "TLB_ERR",
+        "BriefDescription": "TLB memory error"
   }
 ]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a53/pipeline.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a53/pipeline.json
index 3149fb9..f45a6b5 100644
--- a/tools/perf/pmu-events/arch/arm64/arm/cortex-a53/pipeline.json
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a53/pipeline.json
@@ -1,50 +1,50 @@
 [
-  {,
+  {
     "EventCode": "0xC7",
     "EventName": "STALL_SB_FULL",
     "BriefDescription": "Data Write operation that stalls the pipeline because the store buffer is full"
   },
-  {,
+  {
     "EventCode": "0xE0",
     "EventName": "OTHER_IQ_DEP_STALL",
     "BriefDescription": "Cycles that the DPU IQ is empty and that is not because of a recent micro-TLB miss, instruction cache miss or pre-decode error"
   },
-  {,
+  {
     "EventCode": "0xE1",
     "EventName": "IC_DEP_STALL",
     "BriefDescription": "Cycles the DPU IQ is empty and there is an instruction cache miss being processed"
   },
-  {,
+  {
     "EventCode": "0xE2",
     "EventName": "IUTLB_DEP_STALL",
     "BriefDescription": "Cycles the DPU IQ is empty and there is an instruction micro-TLB miss being processed"
   },
-  {,
+  {
     "EventCode": "0xE3",
     "EventName": "DECODE_DEP_STALL",
     "BriefDescription": "Cycles the DPU IQ is empty and there is a pre-decode error being processed"
   },
-  {,
+  {
     "EventCode": "0xE4",
     "EventName": "OTHER_INTERLOCK_STALL",
     "BriefDescription": "Cycles there is an interlock other than  Advanced SIMD/Floating-point instructions or load/store instruction"
   },
-  {,
+  {
     "EventCode": "0xE5",
     "EventName": "AGU_DEP_STALL",
     "BriefDescription": "Cycles there is an interlock for a load/store instruction waiting for data to calculate the address in the AGU"
   },
-  {,
+  {
     "EventCode": "0xE6",
     "EventName": "SIMD_DEP_STALL",
     "BriefDescription": "Cycles there is an interlock for an Advanced SIMD/Floating-point operation."
   },
-  {,
+  {
     "EventCode": "0xE7",
     "EventName": "LD_DEP_STALL",
     "BriefDescription": "Cycles there is a stall in the Wr stage because of a load miss"
   },
-  {,
+  {
     "EventCode": "0xE8",
     "EventName": "ST_DEP_STALL",
     "BriefDescription": "Cycles there is a stall in the Wr stage because of a store"
-- 
1.9.1
