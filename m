Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966320AbeCHLBU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 06:01:20 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:6182 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754981AbeCHK7q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 05:59:46 -0500
From: John Garry <john.garry@huawei.com>
To: <jolsa@redhat.com>, <ak@linux.intel.com>, <peterz@infradead.org>,
        <mingo@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <namhyung@kernel.org>,
        <wcohen@redhat.com>, <will.deacon@arm.com>,
        <ganapatrao.kulkarni@cavium.com>
CC: <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <zhangshaokun@hisilicon.com>,
        "John Garry" <john.garry@huawei.com>
Subject: [PATCH v3 06/11] perf vendor events arm64: Relocate Cortex A53 JSONs to arm subdirectory
Date: Thu, 8 Mar 2018 18:58:31 +0800
Message-ID: <1520506716-197429-7-git-send-email-john.garry@huawei.com>
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

Since jevents now supports vendor subdirectory, relocate
the Cortex-A53 JSONs to arm subdirectory.

Cc: William Cohen <wcohen@redhat.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 .../arch/arm64/arm/cortex-a53/branch.json          | 27 +++++++++++
 .../pmu-events/arch/arm64/arm/cortex-a53/bus.json  | 22 +++++++++
 .../arch/arm64/arm/cortex-a53/cache.json           | 27 +++++++++++
 .../arch/arm64/arm/cortex-a53/memory.json          | 22 +++++++++
 .../arch/arm64/arm/cortex-a53/other.json           | 32 +++++++++++++
 .../arch/arm64/arm/cortex-a53/pipeline.json        | 52 ++++++++++++++++++++++
 .../pmu-events/arch/arm64/cortex-a53/branch.json   | 27 -----------
 .../perf/pmu-events/arch/arm64/cortex-a53/bus.json | 22 ---------
 .../pmu-events/arch/arm64/cortex-a53/cache.json    | 27 -----------
 .../pmu-events/arch/arm64/cortex-a53/memory.json   | 22 ---------
 .../pmu-events/arch/arm64/cortex-a53/other.json    | 32 -------------
 .../pmu-events/arch/arm64/cortex-a53/pipeline.json | 52 ----------------------
 tools/perf/pmu-events/arch/arm64/mapfile.csv       |  2 +-
 13 files changed, 183 insertions(+), 183 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a53/branch.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a53/bus.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a53/cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a53/memory.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a53/other.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a53/pipeline.json
 delete mode 100644 tools/perf/pmu-events/arch/arm64/cortex-a53/branch.json
 delete mode 100644 tools/perf/pmu-events/arch/arm64/cortex-a53/bus.json
 delete mode 100644 tools/perf/pmu-events/arch/arm64/cortex-a53/cache.json
 delete mode 100644 tools/perf/pmu-events/arch/arm64/cortex-a53/memory.json
 delete mode 100644 tools/perf/pmu-events/arch/arm64/cortex-a53/other.json
 delete mode 100644 tools/perf/pmu-events/arch/arm64/cortex-a53/pipeline.json

diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a53/branch.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a53/branch.json
new file mode 100644
index 0000000..3b62087
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a53/branch.json
@@ -0,0 +1,27 @@
+[
+  {,
+    "EventCode": "0x7A",
+    "EventName": "BR_INDIRECT_SPEC",
+    "BriefDescription": "Branch speculatively executed - Indirect branch"
+  },
+  {,
+    "EventCode": "0xC9",
+    "EventName": "BR_COND",
+    "BriefDescription": "Conditional branch executed"
+  },
+  {,
+    "EventCode": "0xCA",
+    "EventName": "BR_INDIRECT_MISPRED",
+    "BriefDescription": "Indirect branch mispredicted"
+  },
+  {,
+    "EventCode": "0xCB",
+    "EventName": "BR_INDIRECT_MISPRED_ADDR",
+    "BriefDescription": "Indirect branch mispredicted because of address miscompare"
+  },
+  {,
+    "EventCode": "0xCC",
+    "EventName": "BR_COND_MISPRED",
+    "BriefDescription": "Conditional branch mispredicted"
+  }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a53/bus.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a53/bus.json
new file mode 100644
index 0000000..480d9f7
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a53/bus.json
@@ -0,0 +1,22 @@
+[
+  {,
+    "EventCode": "0x60",
+    "EventName": "BUS_ACCESS_LD",
+    "BriefDescription": "Bus access - Read"
+  },
+  {,
+    "EventCode": "0x61",
+    "EventName": "BUS_ACCESS_ST",
+    "BriefDescription": "Bus access - Write"
+  },
+  {,
+    "EventCode": "0xC0",
+    "EventName": "EXT_MEM_REQ",
+    "BriefDescription": "External memory request"
+  },
+  {,
+    "EventCode": "0xC1",
+    "EventName": "EXT_MEM_REQ_NC",
+    "BriefDescription": "Non-cacheable external memory request"
+  }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a53/cache.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a53/cache.json
new file mode 100644
index 0000000..11baad6
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a53/cache.json
@@ -0,0 +1,27 @@
+[
+  {,
+    "EventCode": "0xC2",
+    "EventName": "PREFETCH_LINEFILL",
+    "BriefDescription": "Linefill because of prefetch"
+  },
+  {,
+    "EventCode": "0xC3",
+    "EventName": "PREFETCH_LINEFILL_DROP",
+    "BriefDescription": "Instruction Cache Throttle occurred"
+  },
+  {,
+    "EventCode": "0xC4",
+    "EventName": "READ_ALLOC_ENTER",
+    "BriefDescription": "Entering read allocate mode"
+  },
+  {,
+    "EventCode": "0xC5",
+    "EventName": "READ_ALLOC",
+    "BriefDescription": "Read allocate mode"
+  },
+  {,
+    "EventCode": "0xC8",
+    "EventName": "EXT_SNOOP",
+    "BriefDescription": "SCU Snooped data from another CPU for this CPU"
+  }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a53/memory.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a53/memory.json
new file mode 100644
index 0000000..480d9f7
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a53/memory.json
@@ -0,0 +1,22 @@
+[
+  {,
+    "EventCode": "0x60",
+    "EventName": "BUS_ACCESS_LD",
+    "BriefDescription": "Bus access - Read"
+  },
+  {,
+    "EventCode": "0x61",
+    "EventName": "BUS_ACCESS_ST",
+    "BriefDescription": "Bus access - Write"
+  },
+  {,
+    "EventCode": "0xC0",
+    "EventName": "EXT_MEM_REQ",
+    "BriefDescription": "External memory request"
+  },
+  {,
+    "EventCode": "0xC1",
+    "EventName": "EXT_MEM_REQ_NC",
+    "BriefDescription": "Non-cacheable external memory request"
+  }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a53/other.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a53/other.json
new file mode 100644
index 0000000..73a2240
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a53/other.json
@@ -0,0 +1,32 @@
+[
+  {,
+    "EventCode": "0x86",
+    "EventName": "EXC_IRQ",
+    "BriefDescription": "Exception taken, IRQ"
+  },
+  {,
+    "EventCode": "0x87",
+    "EventName": "EXC_FIQ",
+    "BriefDescription": "Exception taken, FIQ"
+  },
+  {,
+    "EventCode": "0xC6",
+    "EventName": "PRE_DECODE_ERR",
+    "BriefDescription": "Pre-decode error"
+  },
+  {,
+    "EventCode": "0xD0",
+    "EventName": "L1I_CACHE_ERR",
+    "BriefDescription": "L1 Instruction Cache (data or tag) memory error"
+  },
+  {,
+    "EventCode": "0xD1",
+    "EventName": "L1D_CACHE_ERR",
+    "BriefDescription": "L1 Data Cache (data, tag or dirty) memory error, correctable or non-correctable"
+  },
+  {,
+    "EventCode": "0xD2",
+    "EventName": "TLB_ERR",
+    "BriefDescription": "TLB memory error"
+  }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a53/pipeline.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a53/pipeline.json
new file mode 100644
index 0000000..3149fb9
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a53/pipeline.json
@@ -0,0 +1,52 @@
+[
+  {,
+    "EventCode": "0xC7",
+    "EventName": "STALL_SB_FULL",
+    "BriefDescription": "Data Write operation that stalls the pipeline because the store buffer is full"
+  },
+  {,
+    "EventCode": "0xE0",
+    "EventName": "OTHER_IQ_DEP_STALL",
+    "BriefDescription": "Cycles that the DPU IQ is empty and that is not because of a recent micro-TLB miss, instruction cache miss or pre-decode error"
+  },
+  {,
+    "EventCode": "0xE1",
+    "EventName": "IC_DEP_STALL",
+    "BriefDescription": "Cycles the DPU IQ is empty and there is an instruction cache miss being processed"
+  },
+  {,
+    "EventCode": "0xE2",
+    "EventName": "IUTLB_DEP_STALL",
+    "BriefDescription": "Cycles the DPU IQ is empty and there is an instruction micro-TLB miss being processed"
+  },
+  {,
+    "EventCode": "0xE3",
+    "EventName": "DECODE_DEP_STALL",
+    "BriefDescription": "Cycles the DPU IQ is empty and there is a pre-decode error being processed"
+  },
+  {,
+    "EventCode": "0xE4",
+    "EventName": "OTHER_INTERLOCK_STALL",
+    "BriefDescription": "Cycles there is an interlock other than  Advanced SIMD/Floating-point instructions or load/store instruction"
+  },
+  {,
+    "EventCode": "0xE5",
+    "EventName": "AGU_DEP_STALL",
+    "BriefDescription": "Cycles there is an interlock for a load/store instruction waiting for data to calculate the address in the AGU"
+  },
+  {,
+    "EventCode": "0xE6",
+    "EventName": "SIMD_DEP_STALL",
+    "BriefDescription": "Cycles there is an interlock for an Advanced SIMD/Floating-point operation."
+  },
+  {,
+    "EventCode": "0xE7",
+    "EventName": "LD_DEP_STALL",
+    "BriefDescription": "Cycles there is a stall in the Wr stage because of a load miss"
+  },
+  {,
+    "EventCode": "0xE8",
+    "EventName": "ST_DEP_STALL",
+    "BriefDescription": "Cycles there is a stall in the Wr stage because of a store"
+  }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/cortex-a53/branch.json b/tools/perf/pmu-events/arch/arm64/cortex-a53/branch.json
deleted file mode 100644
index 3b62087..0000000
--- a/tools/perf/pmu-events/arch/arm64/cortex-a53/branch.json
+++ /dev/null
@@ -1,27 +0,0 @@
-[
-  {,
-    "EventCode": "0x7A",
-    "EventName": "BR_INDIRECT_SPEC",
-    "BriefDescription": "Branch speculatively executed - Indirect branch"
-  },
-  {,
-    "EventCode": "0xC9",
-    "EventName": "BR_COND",
-    "BriefDescription": "Conditional branch executed"
-  },
-  {,
-    "EventCode": "0xCA",
-    "EventName": "BR_INDIRECT_MISPRED",
-    "BriefDescription": "Indirect branch mispredicted"
-  },
-  {,
-    "EventCode": "0xCB",
-    "EventName": "BR_INDIRECT_MISPRED_ADDR",
-    "BriefDescription": "Indirect branch mispredicted because of address miscompare"
-  },
-  {,
-    "EventCode": "0xCC",
-    "EventName": "BR_COND_MISPRED",
-    "BriefDescription": "Conditional branch mispredicted"
-  }
-]
diff --git a/tools/perf/pmu-events/arch/arm64/cortex-a53/bus.json b/tools/perf/pmu-events/arch/arm64/cortex-a53/bus.json
deleted file mode 100644
index 480d9f7..0000000
--- a/tools/perf/pmu-events/arch/arm64/cortex-a53/bus.json
+++ /dev/null
@@ -1,22 +0,0 @@
-[
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
-    "EventCode": "0xC0",
-    "EventName": "EXT_MEM_REQ",
-    "BriefDescription": "External memory request"
-  },
-  {,
-    "EventCode": "0xC1",
-    "EventName": "EXT_MEM_REQ_NC",
-    "BriefDescription": "Non-cacheable external memory request"
-  }
-]
diff --git a/tools/perf/pmu-events/arch/arm64/cortex-a53/cache.json b/tools/perf/pmu-events/arch/arm64/cortex-a53/cache.json
deleted file mode 100644
index 11baad6..0000000
--- a/tools/perf/pmu-events/arch/arm64/cortex-a53/cache.json
+++ /dev/null
@@ -1,27 +0,0 @@
-[
-  {,
-    "EventCode": "0xC2",
-    "EventName": "PREFETCH_LINEFILL",
-    "BriefDescription": "Linefill because of prefetch"
-  },
-  {,
-    "EventCode": "0xC3",
-    "EventName": "PREFETCH_LINEFILL_DROP",
-    "BriefDescription": "Instruction Cache Throttle occurred"
-  },
-  {,
-    "EventCode": "0xC4",
-    "EventName": "READ_ALLOC_ENTER",
-    "BriefDescription": "Entering read allocate mode"
-  },
-  {,
-    "EventCode": "0xC5",
-    "EventName": "READ_ALLOC",
-    "BriefDescription": "Read allocate mode"
-  },
-  {,
-    "EventCode": "0xC8",
-    "EventName": "EXT_SNOOP",
-    "BriefDescription": "SCU Snooped data from another CPU for this CPU"
-  }
-]
diff --git a/tools/perf/pmu-events/arch/arm64/cortex-a53/memory.json b/tools/perf/pmu-events/arch/arm64/cortex-a53/memory.json
deleted file mode 100644
index 480d9f7..0000000
--- a/tools/perf/pmu-events/arch/arm64/cortex-a53/memory.json
+++ /dev/null
@@ -1,22 +0,0 @@
-[
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
-    "EventCode": "0xC0",
-    "EventName": "EXT_MEM_REQ",
-    "BriefDescription": "External memory request"
-  },
-  {,
-    "EventCode": "0xC1",
-    "EventName": "EXT_MEM_REQ_NC",
-    "BriefDescription": "Non-cacheable external memory request"
-  }
-]
diff --git a/tools/perf/pmu-events/arch/arm64/cortex-a53/other.json b/tools/perf/pmu-events/arch/arm64/cortex-a53/other.json
deleted file mode 100644
index 73a2240..0000000
--- a/tools/perf/pmu-events/arch/arm64/cortex-a53/other.json
+++ /dev/null
@@ -1,32 +0,0 @@
-[
-  {,
-    "EventCode": "0x86",
-    "EventName": "EXC_IRQ",
-    "BriefDescription": "Exception taken, IRQ"
-  },
-  {,
-    "EventCode": "0x87",
-    "EventName": "EXC_FIQ",
-    "BriefDescription": "Exception taken, FIQ"
-  },
-  {,
-    "EventCode": "0xC6",
-    "EventName": "PRE_DECODE_ERR",
-    "BriefDescription": "Pre-decode error"
-  },
-  {,
-    "EventCode": "0xD0",
-    "EventName": "L1I_CACHE_ERR",
-    "BriefDescription": "L1 Instruction Cache (data or tag) memory error"
-  },
-  {,
-    "EventCode": "0xD1",
-    "EventName": "L1D_CACHE_ERR",
-    "BriefDescription": "L1 Data Cache (data, tag or dirty) memory error, correctable or non-correctable"
-  },
-  {,
-    "EventCode": "0xD2",
-    "EventName": "TLB_ERR",
-    "BriefDescription": "TLB memory error"
-  }
-]
diff --git a/tools/perf/pmu-events/arch/arm64/cortex-a53/pipeline.json b/tools/perf/pmu-events/arch/arm64/cortex-a53/pipeline.json
deleted file mode 100644
index 3149fb9..0000000
--- a/tools/perf/pmu-events/arch/arm64/cortex-a53/pipeline.json
+++ /dev/null
@@ -1,52 +0,0 @@
-[
-  {,
-    "EventCode": "0xC7",
-    "EventName": "STALL_SB_FULL",
-    "BriefDescription": "Data Write operation that stalls the pipeline because the store buffer is full"
-  },
-  {,
-    "EventCode": "0xE0",
-    "EventName": "OTHER_IQ_DEP_STALL",
-    "BriefDescription": "Cycles that the DPU IQ is empty and that is not because of a recent micro-TLB miss, instruction cache miss or pre-decode error"
-  },
-  {,
-    "EventCode": "0xE1",
-    "EventName": "IC_DEP_STALL",
-    "BriefDescription": "Cycles the DPU IQ is empty and there is an instruction cache miss being processed"
-  },
-  {,
-    "EventCode": "0xE2",
-    "EventName": "IUTLB_DEP_STALL",
-    "BriefDescription": "Cycles the DPU IQ is empty and there is an instruction micro-TLB miss being processed"
-  },
-  {,
-    "EventCode": "0xE3",
-    "EventName": "DECODE_DEP_STALL",
-    "BriefDescription": "Cycles the DPU IQ is empty and there is a pre-decode error being processed"
-  },
-  {,
-    "EventCode": "0xE4",
-    "EventName": "OTHER_INTERLOCK_STALL",
-    "BriefDescription": "Cycles there is an interlock other than  Advanced SIMD/Floating-point instructions or load/store instruction"
-  },
-  {,
-    "EventCode": "0xE5",
-    "EventName": "AGU_DEP_STALL",
-    "BriefDescription": "Cycles there is an interlock for a load/store instruction waiting for data to calculate the address in the AGU"
-  },
-  {,
-    "EventCode": "0xE6",
-    "EventName": "SIMD_DEP_STALL",
-    "BriefDescription": "Cycles there is an interlock for an Advanced SIMD/Floating-point operation."
-  },
-  {,
-    "EventCode": "0xE7",
-    "EventName": "LD_DEP_STALL",
-    "BriefDescription": "Cycles there is a stall in the Wr stage because of a load miss"
-  },
-  {,
-    "EventCode": "0xE8",
-    "EventName": "ST_DEP_STALL",
-    "BriefDescription": "Cycles there is a stall in the Wr stage because of a store"
-  }
-]
diff --git a/tools/perf/pmu-events/arch/arm64/mapfile.csv b/tools/perf/pmu-events/arch/arm64/mapfile.csv
index 952a05c..cf14e23 100644
--- a/tools/perf/pmu-events/arch/arm64/mapfile.csv
+++ b/tools/perf/pmu-events/arch/arm64/mapfile.csv
@@ -12,5 +12,5 @@
 #
 #
 #Family-model,Version,Filename,EventType
+0x00000000410fd03[[:xdigit:]],v1,arm/cortex-a53,core
 0x00000000420f5160,v1,cavium/thunderx2,core
-0x00000000410fd03[[:xdigit:]],v1,cortex-a53,core
-- 
1.9.1
