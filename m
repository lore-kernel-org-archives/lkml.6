Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935101AbeBMMP0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 07:15:26 -0500
Received: from terminus.zytor.com ([198.137.202.136]:46165 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934827AbeBMMPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 07:15:24 -0500
Date: Tue, 13 Feb 2018 04:03:56 -0800
From: tip-bot for William Cohen <tipbot@zytor.com>
Message-ID: <tip-109def8f4b73a508de947a33c5965f3aa568aee1@git.kernel.org>
Cc: jolsa@redhat.com, acme@redhat.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org, hpa@zytor.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        wcohen@redhat.com, tglx@linutronix.de
Reply-To: acme@redhat.com, mingo@kernel.org, jolsa@redhat.com,
        namhyung@kernel.org, wcohen@redhat.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, peterz@infradead.org, hpa@zytor.com,
        alexander.shishkin@linux.intel.com
In-Reply-To: <20180131032813.9564-1-wcohen@redhat.com>
References: <20180131032813.9564-1-wcohen@redhat.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf vendor events aarch64: Add JSON metrics for
 ARM Cortex-A53 Processor
Git-Commit-ID: 109def8f4b73a508de947a33c5965f3aa568aee1
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  109def8f4b73a508de947a33c5965f3aa568aee1
Gitweb:     https://git.kernel.org/tip/109def8f4b73a508de947a33c5965f3aa568aee1
Author:     William Cohen <wcohen@redhat.com>
AuthorDate: Tue, 30 Jan 2018 22:28:13 -0500
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 6 Feb 2018 10:11:49 -0300

perf vendor events aarch64: Add JSON metrics for ARM Cortex-A53 Processor

Add JSON metrics for ARM Cortex-A53 Processor.

Unlike the Intel processors there isn't a script that automatically
generated these files. The patch was manually generated from the
documentation and the previous oprofile ARM Cortex ac53 event file patch
I made.

The relevant documentation is in the "12.9 Events" section of the ARM
Cortex A53 MPCore Processor Revision: r0p4 Technical Reference Manual.

The ARM Cortex A53 manual is available at:

  http://infocenter.arm.com/help/topic/com.arm.doc.ddi0500g/DDI0500G_cortex_a53_trm.pdf

Use that to look for additional information about the events.

Signed-off-by: William Cohen <wcohen@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180131032813.9564-1-wcohen@redhat.com
[ Added references provided by William Cohen ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../pmu-events/arch/arm64/cortex-a53/branch.json   | 27 +++++++++++
 .../perf/pmu-events/arch/arm64/cortex-a53/bus.json | 22 +++++++++
 .../pmu-events/arch/arm64/cortex-a53/cache.json    | 27 +++++++++++
 .../pmu-events/arch/arm64/cortex-a53/memory.json   | 22 +++++++++
 .../pmu-events/arch/arm64/cortex-a53/other.json    | 32 +++++++++++++
 .../pmu-events/arch/arm64/cortex-a53/pipeline.json | 52 ++++++++++++++++++++++
 tools/perf/pmu-events/arch/arm64/mapfile.csv       |  1 +
 7 files changed, 183 insertions(+)

diff --git a/tools/perf/pmu-events/arch/arm64/cortex-a53/branch.json b/tools/perf/pmu-events/arch/arm64/cortex-a53/branch.json
new file mode 100644
index 0000000..3b62087
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/cortex-a53/branch.json
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
diff --git a/tools/perf/pmu-events/arch/arm64/cortex-a53/bus.json b/tools/perf/pmu-events/arch/arm64/cortex-a53/bus.json
new file mode 100644
index 0000000..480d9f7
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/cortex-a53/bus.json
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
diff --git a/tools/perf/pmu-events/arch/arm64/cortex-a53/cache.json b/tools/perf/pmu-events/arch/arm64/cortex-a53/cache.json
new file mode 100644
index 0000000..11baad6
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/cortex-a53/cache.json
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
diff --git a/tools/perf/pmu-events/arch/arm64/cortex-a53/memory.json b/tools/perf/pmu-events/arch/arm64/cortex-a53/memory.json
new file mode 100644
index 0000000..480d9f7
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/cortex-a53/memory.json
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
diff --git a/tools/perf/pmu-events/arch/arm64/cortex-a53/other.json b/tools/perf/pmu-events/arch/arm64/cortex-a53/other.json
new file mode 100644
index 0000000..73a2240
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/cortex-a53/other.json
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
diff --git a/tools/perf/pmu-events/arch/arm64/cortex-a53/pipeline.json b/tools/perf/pmu-events/arch/arm64/cortex-a53/pipeline.json
new file mode 100644
index 0000000..3149fb9
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/cortex-a53/pipeline.json
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
diff --git a/tools/perf/pmu-events/arch/arm64/mapfile.csv b/tools/perf/pmu-events/arch/arm64/mapfile.csv
index 219d675..e61c9ca 100644
--- a/tools/perf/pmu-events/arch/arm64/mapfile.csv
+++ b/tools/perf/pmu-events/arch/arm64/mapfile.csv
@@ -13,3 +13,4 @@
 #
 #Family-model,Version,Filename,EventType
 0x00000000420f5160,v1,cavium,core
+0x00000000410fd03[[:xdigit:]],v1,cortex-a53,core
