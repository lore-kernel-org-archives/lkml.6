Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753513AbeC1Stw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 14:49:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:51798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752732AbeC1Sts (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 14:49:48 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E9A52177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Thomas Richter <tmricht@linux.vnet.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 7/8] perf vendor events s390: Add JSON files for IBM z13
Date: Wed, 28 Mar 2018 15:49:18 -0300
Message-Id: <20180328184919.32287-8-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180328184919.32287-1-acme@kernel.org>
References: <20180328184919.32287-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Richter <tmricht@linux.vnet.ibm.com>

Add CPU measurement counter facility event description files (json
files) for IBM z13.

Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Link: http://lkml.kernel.org/r/20180326082538.2258-4-tmricht@linux.vnet.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/pmu-events/arch/s390/cf_z13/basic.json  |  74 +++++
 tools/perf/pmu-events/arch/s390/cf_z13/crypto.json |  98 ++++++
 .../perf/pmu-events/arch/s390/cf_z13/extended.json | 338 +++++++++++++++++++++
 tools/perf/pmu-events/arch/s390/mapfile.csv        |   1 +
 4 files changed, 511 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/s390/cf_z13/basic.json
 create mode 100644 tools/perf/pmu-events/arch/s390/cf_z13/crypto.json
 create mode 100644 tools/perf/pmu-events/arch/s390/cf_z13/extended.json

diff --git a/tools/perf/pmu-events/arch/s390/cf_z13/basic.json b/tools/perf/pmu-events/arch/s390/cf_z13/basic.json
new file mode 100644
index 000000000000..8bf16759ca53
--- /dev/null
+++ b/tools/perf/pmu-events/arch/s390/cf_z13/basic.json
@@ -0,0 +1,74 @@
+[
+	{
+		"EventCode": "0",
+		"EventName": "CPU_CYCLES",
+		"BriefDescription": "CPU Cycles",
+		"PublicDescription": "Cycle Count"
+	},
+	{
+		"EventCode": "1",
+		"EventName": "INSTRUCTIONS",
+		"BriefDescription": "Instructions",
+		"PublicDescription": "Instruction Count"
+	},
+	{
+		"EventCode": "2",
+		"EventName": "L1I_DIR_WRITES",
+		"BriefDescription": "L1I Directory Writes",
+		"PublicDescription": "Level-1 I-Cache Directory Write Count"
+	},
+	{
+		"EventCode": "3",
+		"EventName": "L1I_PENALTY_CYCLES",
+		"BriefDescription": "L1I Penalty Cycles",
+		"PublicDescription": "Level-1 I-Cache Penalty Cycle Count"
+	},
+	{
+		"EventCode": "4",
+		"EventName": "L1D_DIR_WRITES",
+		"BriefDescription": "L1D Directory Writes",
+		"PublicDescription": "Level-1 D-Cache Directory Write Count"
+	},
+	{
+		"EventCode": "5",
+		"EventName": "L1D_PENALTY_CYCLES",
+		"BriefDescription": "L1D Penalty Cycles",
+		"PublicDescription": "Level-1 D-Cache Penalty Cycle Count"
+	},
+	{
+		"EventCode": "32",
+		"EventName": "PROBLEM_STATE_CPU_CYCLES",
+		"BriefDescription": "Problem-State CPU Cycles",
+		"PublicDescription": "Problem-State Cycle Count"
+	},
+	{
+		"EventCode": "33",
+		"EventName": "PROBLEM_STATE_INSTRUCTIONS",
+		"BriefDescription": "Problem-State Instructions",
+		"PublicDescription": "Problem-State Instruction Count"
+	},
+	{
+		"EventCode": "34",
+		"EventName": "PROBLEM_STATE_L1I_DIR_WRITES",
+		"BriefDescription": "Problem-State L1I Directory Writes",
+		"PublicDescription": "Problem-State Level-1 I-Cache Directory Write Count"
+	},
+	{
+		"EventCode": "35",
+		"EventName": "PROBLEM_STATE_L1I_PENALTY_CYCLES",
+		"BriefDescription": "Problem-State L1I Penalty Cycles",
+		"PublicDescription": "Problem-State Level-1 I-Cache Penalty Cycle Count"
+	},
+	{
+		"EventCode": "36",
+		"EventName": "PROBLEM_STATE_L1D_DIR_WRITES",
+		"BriefDescription": "Problem-State L1D Directory Writes",
+		"PublicDescription": "Problem-State Level-1 D-Cache Directory Write Count"
+	},
+	{
+		"EventCode": "37",
+		"EventName": "PROBLEM_STATE_L1D_PENALTY_CYCLES",
+		"BriefDescription": "Problem-State L1D Penalty Cycles",
+		"PublicDescription": "Problem-State Level-1 D-Cache Penalty Cycle Count"
+	},
+]
diff --git a/tools/perf/pmu-events/arch/s390/cf_z13/crypto.json b/tools/perf/pmu-events/arch/s390/cf_z13/crypto.json
new file mode 100644
index 000000000000..7e5b72492141
--- /dev/null
+++ b/tools/perf/pmu-events/arch/s390/cf_z13/crypto.json
@@ -0,0 +1,98 @@
+[
+	{
+		"EventCode": "64",
+		"EventName": "PRNG_FUNCTIONS",
+		"BriefDescription": "PRNG Functions",
+		"PublicDescription": "Total number of the PRNG functions issued by the CPU"
+	},
+	{
+		"EventCode": "65",
+		"EventName": "PRNG_CYCLES",
+		"BriefDescription": "PRNG Cycles",
+		"PublicDescription": "Total number of CPU cycles when the DEA/AES coprocessor is busy performing PRNG functions issued by the CPU"
+	},
+	{
+		"EventCode": "66",
+		"EventName": "PRNG_BLOCKED_FUNCTIONS",
+		"BriefDescription": "PRNG Blocked Functions",
+		"PublicDescription": "Total number of the PRNG functions that are issued by the CPU and are blocked because the DEA/AES coprocessor is busy performing a function issued by another CPU"
+	},
+	{
+		"EventCode": "67",
+		"EventName": "PRNG_BLOCKED_CYCLES",
+		"BriefDescription": "PRNG Blocked Cycles",
+		"PublicDescription": "Total number of CPU cycles blocked for the PRNG functions issued by the CPU because the DEA/AES coprocessor is busy performing a function issued by another CPU"
+	},
+	{
+		"EventCode": "68",
+		"EventName": "SHA_FUNCTIONS",
+		"BriefDescription": "SHA Functions",
+		"PublicDescription": "Total number of SHA functions issued by the CPU"
+	},
+	{
+		"EventCode": "69",
+		"EventName": "SHA_CYCLES",
+		"BriefDescription": "SHA Cycles",
+		"PublicDescription": "Total number of CPU cycles when the SHA coprocessor is busy performing the SHA functions issued by the CPU"
+	},
+	{
+		"EventCode": "70",
+		"EventName": "SHA_BLOCKED_FUNCTIONS",
+		"BriefDescription": "SHA Blocked Functions",
+		"PublicDescription": "Total number of the SHA functions that are issued by the CPU and are blocked because the SHA coprocessor is busy performing a function issued by another CPU"
+	},
+	{
+		"EventCode": "71",
+		"EventName": "SHA_BLOCKED_CYCLES",
+		"BriefDescription": "SHA Bloced Cycles",
+		"PublicDescription": "Total number of CPU cycles blocked for the SHA functions issued by the CPU because the SHA coprocessor is busy performing a function issued by another CPU"
+	},
+	{
+		"EventCode": "72",
+		"EventName": "DEA_FUNCTIONS",
+		"BriefDescription": "DEA Functions",
+		"PublicDescription": "Total number of the DEA functions issued by the CPU"
+	},
+	{
+		"EventCode": "73",
+		"EventName": "DEA_CYCLES",
+		"BriefDescription": "DEA Cycles",
+		"PublicDescription": "Total number of CPU cycles when the DEA/AES coprocessor is busy performing the DEA functions issued by the CPU"
+	},
+	{
+		"EventCode": "74",
+		"EventName": "DEA_BLOCKED_FUNCTIONS",
+		"BriefDescription": "DEA Blocked Functions",
+		"PublicDescription": "Total number of the DEA functions that are issued by the CPU and are blocked because the DEA/AES coprocessor is busy performing a function issued by another CPU"
+	},
+	{
+		"EventCode": "75",
+		"EventName": "DEA_BLOCKED_CYCLES",
+		"BriefDescription": "DEA Blocked Cycles",
+		"PublicDescription": "Total number of CPU cycles blocked for the DEA functions issued by the CPU because the DEA/AES coprocessor is busy performing a function issued by another CPU"
+	},
+	{
+		"EventCode": "76",
+		"EventName": "AES_FUNCTIONS",
+		"BriefDescription": "AES Functions",
+		"PublicDescription": "Total number of AES functions issued by the CPU"
+	},
+	{
+		"EventCode": "77",
+		"EventName": "AES_CYCLES",
+		"BriefDescription": "AES Cycles",
+		"PublicDescription": "Total number of CPU cycles when the DEA/AES coprocessor is busy performing the AES functions issued by the CPU"
+	},
+	{
+		"EventCode": "78",
+		"EventName": "AES_BLOCKED_FUNCTIONS",
+		"BriefDescription": "AES Blocked Functions",
+		"PublicDescription": "Total number of AES functions that are issued by the CPU and are blocked because the DEA/AES coprocessor is busy performing a function issued by another CPU"
+	},
+	{
+		"EventCode": "79",
+		"EventName": "AES_BLOCKED_CYCLES",
+		"BriefDescription": "AES Blocked Cycles",
+		"PublicDescription": "Total number of CPU cycles blocked for the AES functions issued by the CPU because the DEA/AES coprocessor is busy performing a function issued by another CPU"
+	},
+]
diff --git a/tools/perf/pmu-events/arch/s390/cf_z13/extended.json b/tools/perf/pmu-events/arch/s390/cf_z13/extended.json
new file mode 100644
index 000000000000..9a002b6967f1
--- /dev/null
+++ b/tools/perf/pmu-events/arch/s390/cf_z13/extended.json
@@ -0,0 +1,338 @@
+[
+	{
+		"EventCode": "128",
+		"EventName": "L1D_RO_EXCL_WRITES",
+		"BriefDescription": "L1D Read-only Exclusive Writes",
+		"PublicDescription": "A directory write to the Level-1 Data cache where the line was originally in a Read-Only state in the cache but has been updated to be in the Exclusive state that allows stores to the cache line."
+	},
+	{
+		"EventCode": "129",
+		"EventName": "DTLB1_WRITES",
+		"BriefDescription": "DTLB1 Writes",
+		"PublicDescription": "A translation entry has been written to the Level-1 Data Translation Lookaside Buffer"
+	},
+	{
+		"EventCode": "130",
+		"EventName": "DTLB1_MISSES",
+		"BriefDescription": "DTLB1 Misses",
+		"PublicDescription": "Level-1 Data TLB miss in progress. Incremented by one for every cycle a DTLB1 miss is in progress."
+	},
+	{
+		"EventCode": "131",
+		"EventName": "DTLB1_HPAGE_WRITES",
+		"BriefDescription": "DTLB1 One-Megabyte Page Writes",
+		"PublicDescription": "A translation entry has been written to the Level-1 Data Translation Lookaside Buffer for a one-megabyte page"
+	},
+	{
+		"EventCode": "132",
+		"EventName": "DTLB1_GPAGE_WRITES",
+		"BriefDescription": "DTLB1 Two-Gigabyte Page Writes",
+		"PublicDescription": "Counter:132	Name:DTLB1_GPAGE_WRITES A translation entry has been written to the Level-1 Data Translation Lookaside Buffer for a two-gigabyte page."
+	},
+	{
+		"EventCode": "133",
+		"EventName": "L1D_L2D_SOURCED_WRITES",
+		"BriefDescription": "L1D L2D Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from the Level-2 Data cache"
+	},
+	{
+		"EventCode": "134",
+		"EventName": "ITLB1_WRITES",
+		"BriefDescription": "ITLB1 Writes",
+		"PublicDescription": "A translation entry has been written to the Level-1 Instruction Translation Lookaside Buffer"
+	},
+	{
+		"EventCode": "135",
+		"EventName": "ITLB1_MISSES",
+		"BriefDescription": "ITLB1 Misses",
+		"PublicDescription": "Level-1 Instruction TLB miss in progress. Incremented by one for every cycle an ITLB1 miss is in progress"
+	},
+	{
+		"EventCode": "136",
+		"EventName": "L1I_L2I_SOURCED_WRITES",
+		"BriefDescription": "L1I L2I Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from the Level-2 Instruction cache"
+	},
+	{
+		"EventCode": "137",
+		"EventName": "TLB2_PTE_WRITES",
+		"BriefDescription": "TLB2 PTE Writes",
+		"PublicDescription": "A translation entry has been written to the Level-2 TLB Page Table Entry arrays"
+	},
+	{
+		"EventCode": "138",
+		"EventName": "TLB2_CRSTE_HPAGE_WRITES",
+		"BriefDescription": "TLB2 CRSTE One-Megabyte Page Writes",
+		"PublicDescription": "A translation entry has been written to the Level-2 TLB Combined Region Segment Table Entry arrays for a one-megabyte large page translation"
+	},
+	{
+		"EventCode": "139",
+		"EventName": "TLB2_CRSTE_WRITES",
+		"BriefDescription": "TLB2 CRSTE Writes",
+		"PublicDescription": "A translation entry has been written to the Level-2 TLB Combined Region Segment Table Entry arrays"
+	},
+	{
+		"EventCode": "140",
+		"EventName": "TX_C_TEND",
+		"BriefDescription": "Completed TEND instructions in constrained TX mode",
+		"PublicDescription": "A TEND instruction has completed in a constrained transactional-execution mode"
+	},
+	{
+		"EventCode": "141",
+		"EventName": "TX_NC_TEND",
+		"BriefDescription": "Completed TEND instructions in non-constrained TX mode",
+		"PublicDescription": "A TEND instruction has completed in a non-constrained transactional-execution mode"
+	},
+	{
+		"EventCode": "143",
+		"EventName": "L1C_TLB1_MISSES",
+		"BriefDescription": "L1C TLB1 Misses",
+		"PublicDescription": "Increments by one for any cycle where a Level-1 cache or Level-1 TLB miss is in progress."
+	},
+	{
+		"EventCode": "144",
+		"EventName": "L1D_ONCHIP_L3_SOURCED_WRITES",
+		"BriefDescription": "L1D On-Chip L3 Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an On-Chip Level-3 cache without intervention"
+	},
+	{
+		"EventCode": "145",
+		"EventName": "L1D_ONCHIP_L3_SOURCED_WRITES_IV",
+		"BriefDescription": "L1D On-Chip L3 Sourced Writes with Intervention",
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an On-Chip Level-3 cache with intervention"
+	},
+	{
+		"EventCode": "146",
+		"EventName": "L1D_ONNODE_L4_SOURCED_WRITES",
+		"BriefDescription": "L1D On-Node L4 Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an On-Node Level-4 cache"
+	},
+	{
+		"EventCode": "147",
+		"EventName": "L1D_ONNODE_L3_SOURCED_WRITES_IV",
+		"BriefDescription": "L1D On-Node L3 Sourced Writes with Intervention",
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an On-Node Level-3 cache with intervention"
+	},
+	{
+		"EventCode": "148",
+		"EventName": "L1D_ONNODE_L3_SOURCED_WRITES",
+		"BriefDescription": "L1D On-Node L3 Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an On-Node Level-3 cache without intervention"
+	},
+	{
+		"EventCode": "149",
+		"EventName": "L1D_ONDRAWER_L4_SOURCED_WRITES",
+		"BriefDescription": "L1D On-Drawer L4 Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an On-Drawer Level-4 cache"
+	},
+	{
+		"EventCode": "150",
+		"EventName": "L1D_ONDRAWER_L3_SOURCED_WRITES_IV",
+		"BriefDescription": "L1D On-Drawer L3 Sourced Writes with Intervention",
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an On-Drawer Level-3 cache with intervention"
+	},
+	{
+		"EventCode": "151",
+		"EventName": "L1D_ONDRAWER_L3_SOURCED_WRITES",
+		"BriefDescription": "L1D On-Drawer L3 Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an On-Drawer Level-3 cache without intervention"
+	},
+	{
+		"EventCode": "152",
+		"EventName": "L1D_OFFDRAWER_SCOL_L4_SOURCED_WRITES",
+		"BriefDescription": "L1D Off-Drawer Same-Column L4 Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an Off-Drawer Same-Column Level-4 cache"
+	},
+	{
+		"EventCode": "153",
+		"EventName": "L1D_OFFDRAWER_SCOL_L3_SOURCED_WRITES_IV",
+		"BriefDescription": "L1D Off-Drawer Same-Column L3 Sourced Writes with Intervention",
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an Off-Drawer Same-Column Level-3 cache with intervention"
+	},
+	{
+		"EventCode": "154",
+		"EventName": "L1D_OFFDRAWER_SCOL_L3_SOURCED_WRITES",
+		"BriefDescription": "L1D Off-Drawer Same-Column L3 Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an Off-Drawer Same-Column Level-3 cache without intervention"
+	},
+	{
+		"EventCode": "155",
+		"EventName": "L1D_OFFDRAWER_FCOL_L4_SOURCED_WRITES",
+		"BriefDescription": "L1D Off-Drawer Far-Column L3 Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an Off-Drawer Far-Column Level-4 cache"
+	},
+	{
+		"EventCode": "156",
+		"EventName": "L1D_OFFDRAWER_FCOL_L3_SOURCED_WRITES_IV",
+		"BriefDescription": "L1D Off-Drawer Far-Column L3 Sourced Writes with Intervention",
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an Off-Drawer Far-Column Level-3 cache with intervention"
+	},
+	{
+		"EventCode": "157",
+		"EventName": "L1D_OFFDRAWER_FCOL_L3_SOURCED_WRITES",
+		"BriefDescription": "L1D Off-Drawer Far-Column L3 Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an Off-Drawer Far-Column Level-3 cache without intervention"
+	},
+	{
+		"EventCode": "158",
+		"EventName": "L1D_ONNODE_MEM_SOURCED_WRITES",
+		"BriefDescription": "L1D On-Node Memory Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from On-Node memory"
+	},
+	{
+		"EventCode": "159",
+		"EventName": "L1D_ONDRAWER_MEM_SOURCED_WRITES",
+		"BriefDescription": "L1D On-Drawer Memory Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from On-Drawer memory"
+	},
+	{
+		"EventCode": "160",
+		"EventName": "L1D_OFFDRAWER_MEM_SOURCED_WRITES",
+		"BriefDescription": "L1D Off-Drawer Memory Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from On-Drawer memory"
+	},
+	{
+		"EventCode": "161",
+		"EventName": "L1D_ONCHIP_MEM_SOURCED_WRITES",
+		"BriefDescription": "L1D On-Chip Memory Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from On-Chip memory"
+	},
+	{
+		"EventCode": "162",
+		"EventName": "L1I_ONCHIP_L3_SOURCED_WRITES",
+		"BriefDescription": "L1I On-Chip L3 Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an On-Chip Level-3 cache without intervention"
+	},
+	{
+		"EventCode": "163",
+		"EventName": "L1I_ONCHIP_L3_SOURCED_WRITES_IV",
+		"BriefDescription": "L1I On-Chip L3 Sourced Writes with Intervention",
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an On Chip Level-3 cache with intervention"
+	},
+	{
+		"EventCode": "164",
+		"EventName": "L1I_ONNODE_L4_SOURCED_WRITES",
+		"BriefDescription": "L1I On-Chip L4 Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an On-Node Level-4 cache"
+	},
+	{
+		"EventCode": "165",
+		"EventName": "L1I_ONNODE_L3_SOURCED_WRITES_IV",
+		"BriefDescription": "L1I On-Node L3 Sourced Writes with Intervention",
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an On-Node Level-3 cache with intervention"
+	},
+	{
+		"EventCode": "166",
+		"EventName": "L1I_ONNODE_L3_SOURCED_WRITES",
+		"BriefDescription": "L1I On-Node L3 Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an On-Node Level-3 cache without intervention"
+	},
+	{
+		"EventCode": "167",
+		"EventName": "L1I_ONDRAWER_L4_SOURCED_WRITES",
+		"BriefDescription": "L1I On-Drawer L4 Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an On-Drawer Level-4 cache"
+	},
+	{
+		"EventCode": "168",
+		"EventName": "L1I_ONDRAWER_L3_SOURCED_WRITES_IV",
+		"BriefDescription": "L1I On-Drawer L3 Sourced Writes with Intervention",
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an On-Drawer Level-3 cache with intervention"
+	},
+	{
+		"EventCode": "169",
+		"EventName": "L1I_ONDRAWER_L3_SOURCED_WRITES",
+		"BriefDescription": "L1I On-Drawer L3 Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an On-Drawer Level-3 cache without intervention"
+	},
+	{
+		"EventCode": "170",
+		"EventName": "L1I_OFFDRAWER_SCOL_L4_SOURCED_WRITES",
+		"BriefDescription": "L1I Off-Drawer Same-Column L4 Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an Off-Drawer Same-Column Level-4 cache"
+	},
+	{
+		"EventCode": "171",
+		"EventName": "L1I_OFFDRAWER_SCOL_L3_SOURCED_WRITES_IV",
+		"BriefDescription": "L1I Off-Drawer Same-Column L3 Sourced Writes with Intervention",
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an Off-Drawer Same-Column Level-3 cache with intervention"
+	},
+	{
+		"EventCode": "172",
+		"EventName": "L1I_OFFDRAWER_SCOL_L3_SOURCED_WRITES",
+		"BriefDescription": "L1I Off-Drawer Same-Column L3 Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an Off-Drawer Same-Column Level-3 cache without intervention"
+	},
+	{
+		"EventCode": "173",
+		"EventName": "L1I_OFFDRAWER_FCOL_L4_SOURCED_WRITES",
+		"BriefDescription": "L1I Off-Drawer Far-Column L4 Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an Off-Drawer Far-Column Level-4 cache"
+	},
+	{
+		"EventCode": "174",
+		"EventName": "L1I_OFFDRAWER_FCOL_L3_SOURCED_WRITES_IV",
+		"BriefDescription": "L1I Off-Drawer Far-Column L3 Sourced Writes with Intervention",
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an Off-Drawer Far-Column Level-3 cache with intervention"
+	},
+	{
+		"EventCode": "175",
+		"EventName": "L1I_OFFDRAWER_FCOL_L3_SOURCED_WRITES",
+		"BriefDescription": "L1I Off-Drawer Far-Column L3 Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an Off-Drawer Far-Column Level-3 cache without intervention"
+	},
+	{
+		"EventCode": "176",
+		"EventName": "L1I_ONNODE_MEM_SOURCED_WRITES",
+		"BriefDescription": "L1I On-Node Memory Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from On-Node memory"
+	},
+	{
+		"EventCode": "177",
+		"EventName": "L1I_ONDRAWER_MEM_SOURCED_WRITES",
+		"BriefDescription": "L1I On-Drawer Memory Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from On-Drawer memory"
+	},
+	{
+		"EventCode": "178",
+		"EventName": "L1I_OFFDRAWER_MEM_SOURCED_WRITES",
+		"BriefDescription": "L1I Off-Drawer Memory Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from On-Drawer memory"
+	},
+	{
+		"EventCode": "179",
+		"EventName": "L1I_ONCHIP_MEM_SOURCED_WRITES",
+		"BriefDescription": "L1I On-Chip Memory Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from On-Chip memory"
+	},
+	{
+		"EventCode": "218",
+		"EventName": "TX_NC_TABORT",
+		"BriefDescription": "Aborted transactions in non-constrained TX mode",
+		"PublicDescription": "A transaction abort has occurred in a non-constrained transactional-execution mode"
+	},
+	{
+		"EventCode": "219",
+		"EventName": "TX_C_TABORT_NO_SPECIAL",
+		"BriefDescription": "Aborted transactions in constrained TX mode not using special completion logic",
+		"PublicDescription": "A transaction abort has occurred in a constrained transactional-execution mode and the CPU is not using any special logic to allow the transaction to complete"
+	},
+	{
+		"EventCode": "220",
+		"EventName": "TX_C_TABORT_SPECIAL",
+		"BriefDescription": "Aborted transactions in constrained TX mode using special completion logic",
+		"PublicDescription": "A transaction abort has occurred in a constrained transactional-execution mode and the CPU is using special logic to allow the transaction to complete"
+	},
+	{
+		"EventCode": "448",
+		"EventName": "MT_DIAG_CYCLES_ONE_THR_ACTIVE",
+		"BriefDescription": "Cycle count with one thread active",
+		"PublicDescription": "Cycle count with one thread active"
+	},
+	{
+		"EventCode": "449",
+		"EventName": "MT_DIAG_CYCLES_TWO_THR_ACTIVE",
+		"BriefDescription": "Cycle count with two threads active",
+		"PublicDescription": "Cycle count with two threads active"
+	},
+]
diff --git a/tools/perf/pmu-events/arch/s390/mapfile.csv b/tools/perf/pmu-events/arch/s390/mapfile.csv
index c57f8e75fa23..3cff9c64bb85 100644
--- a/tools/perf/pmu-events/arch/s390/mapfile.csv
+++ b/tools/perf/pmu-events/arch/s390/mapfile.csv
@@ -2,3 +2,4 @@ Family-model,Version,Filename,EventType
 209[78],1,cf_z10,core
 281[78],1,cf_z196,core
 282[78],1,cf_zec12,core
+296[45],1,cf_z13,core
-- 
2.14.3
