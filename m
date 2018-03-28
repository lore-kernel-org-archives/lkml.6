Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753481AbeC1Stq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 14:49:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:51716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752732AbeC1Stn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 14:49:43 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CFC2217D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Thomas Richter <tmricht@linux.vnet.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 5/8] perf vendor events s390: Add JSON files for IBM z196
Date: Wed, 28 Mar 2018 15:49:16 -0300
Message-Id: <20180328184919.32287-6-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180328184919.32287-1-acme@kernel.org>
References: <20180328184919.32287-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Richter <tmricht@linux.vnet.ibm.com>

Add CPU measurement counter facility event description files (json
files) for IBM z196.

Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Link: http://lkml.kernel.org/r/20180326082538.2258-2-tmricht@linux.vnet.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/pmu-events/arch/s390/cf_z196/basic.json |  74 +++++++++++
 .../perf/pmu-events/arch/s390/cf_z196/crypto.json  |  98 ++++++++++++++
 .../pmu-events/arch/s390/cf_z196/extended.json     | 146 +++++++++++++++++++++
 tools/perf/pmu-events/arch/s390/mapfile.csv        |   1 +
 4 files changed, 319 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/s390/cf_z196/basic.json
 create mode 100644 tools/perf/pmu-events/arch/s390/cf_z196/crypto.json
 create mode 100644 tools/perf/pmu-events/arch/s390/cf_z196/extended.json

diff --git a/tools/perf/pmu-events/arch/s390/cf_z196/basic.json b/tools/perf/pmu-events/arch/s390/cf_z196/basic.json
new file mode 100644
index 000000000000..8bf16759ca53
--- /dev/null
+++ b/tools/perf/pmu-events/arch/s390/cf_z196/basic.json
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
diff --git a/tools/perf/pmu-events/arch/s390/cf_z196/crypto.json b/tools/perf/pmu-events/arch/s390/cf_z196/crypto.json
new file mode 100644
index 000000000000..7e5b72492141
--- /dev/null
+++ b/tools/perf/pmu-events/arch/s390/cf_z196/crypto.json
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
diff --git a/tools/perf/pmu-events/arch/s390/cf_z196/extended.json b/tools/perf/pmu-events/arch/s390/cf_z196/extended.json
new file mode 100644
index 000000000000..b6d7fec7c2e7
--- /dev/null
+++ b/tools/perf/pmu-events/arch/s390/cf_z196/extended.json
@@ -0,0 +1,146 @@
+[
+	{
+		"EventCode": "128",
+		"EventName": "L1D_L2_SOURCED_WRITES",
+		"BriefDescription": "L1D L2 Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 D-Cache directory where the returned cache line was sourced from the Level-2 cache"
+	},
+	{
+		"EventCode": "129",
+		"EventName": "L1I_L2_SOURCED_WRITES",
+		"BriefDescription": "L1I L2 Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 I-Cache directory where the returned cache line was sourced from the Level-2 cache"
+	},
+	{
+		"EventCode": "130",
+		"EventName": "DTLB1_MISSES",
+		"BriefDescription": "DTLB1 Misses",
+		"PublicDescription": "Level-1 Data TLB miss in progress. Incremented by one for every cycle a DTLB1 miss is in progress."
+	},
+	{
+		"EventCode": "131",
+		"EventName": "ITLB1_MISSES",
+		"BriefDescription": "ITLB1 Misses",
+		"PublicDescription": "Level-1 Instruction TLB miss in progress. Incremented by one for every cycle a ITLB1 miss is in progress."
+	},
+	{
+		"EventCode": "133",
+		"EventName": "L2C_STORES_SENT",
+		"BriefDescription": "L2C Stores Sent",
+		"PublicDescription": "Incremented by one for every store sent to Level-2 cache"
+	},
+	{
+		"EventCode": "134",
+		"EventName": "L1D_OFFBOOK_L3_SOURCED_WRITES",
+		"BriefDescription": "L1D Off-Book L3 Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 D-Cache directory where the returned cache line was sourced from an Off Book Level-3 cache"
+	},
+	{
+		"EventCode": "135",
+		"EventName": "L1D_ONBOOK_L4_SOURCED_WRITES",
+		"BriefDescription": "L1D On-Book L4 Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 D-Cache directory where the returned cache line was sourced from an On Book Level-4 cache"
+	},
+	{
+		"EventCode": "136",
+		"EventName": "L1I_ONBOOK_L4_SOURCED_WRITES",
+		"BriefDescription": "L1I On-Book L4 Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 I-Cache directory where the returned cache line was sourced from an On Book Level-4 cache"
+	},
+	{
+		"EventCode": "137",
+		"EventName": "L1D_RO_EXCL_WRITES",
+		"BriefDescription": "L1D Read-only Exclusive Writes",
+		"PublicDescription": "A directory write to the Level-1 D-Cache where the line was originally in a Read-Only state in the cache but has been updated to be in the Exclusive state that allows stores to the cache line"
+	},
+	{
+		"EventCode": "138",
+		"EventName": "L1D_OFFBOOK_L4_SOURCED_WRITES",
+		"BriefDescription": "L1D Off-Book L4 Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 D-Cache directory where the returned cache line was sourced from an Off Book Level-4 cache"
+	},
+	{
+		"EventCode": "139",
+		"EventName": "L1I_OFFBOOK_L4_SOURCED_WRITES",
+		"BriefDescription": "L1I Off-Book L4 Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 I-Cache directory where the returned cache line was sourced from an Off Book Level-4 cache"
+	},
+	{
+		"EventCode": "140",
+		"EventName": "DTLB1_HPAGE_WRITES",
+		"BriefDescription": "DTLB1 One-Megabyte Page Writes",
+		"PublicDescription": "A translation entry has been written to the Level-1 Data Translation Lookaside Buffer for a one-megabyte page"
+	},
+	{
+		"EventCode": "141",
+		"EventName": "L1D_LMEM_SOURCED_WRITES",
+		"BriefDescription": "L1D Local Memory Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 D-Cache where the installed cache line was sourced from memory that is attached to the same book as the Data cache (Local Memory)"
+	},
+	{
+		"EventCode": "142",
+		"EventName": "L1I_LMEM_SOURCED_WRITES",
+		"BriefDescription": "L1I Local Memory Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 I-Cache where the installed cache line was sourced from memory that is attached to the same book as the Instruction cache (Local Memory)"
+	},
+	{
+		"EventCode": "143",
+		"EventName": "L1I_OFFBOOK_L3_SOURCED_WRITES",
+		"BriefDescription": "L1I Off-Book L3 Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 I-Cache directory where the returned cache line was sourced from an Off Book Level-3 cache"
+	},
+	{
+		"EventCode": "144",
+		"EventName": "DTLB1_WRITES",
+		"BriefDescription": "DTLB1 Writes",
+		"PublicDescription": "A translation entry has been written to the Level-1 Data Translation Lookaside Buffer"
+	},
+	{
+		"EventCode": "145",
+		"EventName": "ITLB1_WRITES",
+		"BriefDescription": "ITLB1 Writes",
+		"PublicDescription": "A translation entry has been written to the Level-1 Instruction Translation Lookaside Buffer"
+	},
+	{
+		"EventCode": "146",
+		"EventName": "TLB2_PTE_WRITES",
+		"BriefDescription": "TLB2 PTE Writes",
+		"PublicDescription": "A translation entry has been written to the Level-2 TLB Page Table Entry arrays"
+	},
+	{
+		"EventCode": "147",
+		"EventName": "TLB2_CRSTE_HPAGE_WRITES",
+		"BriefDescription": "TLB2 CRSTE One-Megabyte Page Writes",
+		"PublicDescription": "A translation entry has been written to the Level-2 TLB Common Region Segment Table Entry arrays for a one-megabyte large page translation"
+	},
+	{
+		"EventCode": "148",
+		"EventName": "TLB2_CRSTE_WRITES",
+		"BriefDescription": "TLB2 CRSTE Writes",
+		"PublicDescription": "A translation entry has been written to the Level-2 TLB Common Region Segment Table Entry arrays"
+	},
+	{
+		"EventCode": "150",
+		"EventName": "L1D_ONCHIP_L3_SOURCED_WRITES",
+		"BriefDescription": "L1D On-Chip L3 Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 D-Cache directory where the returned cache line was sourced from an On Chip Level-3 cache"
+	},
+	{
+		"EventCode": "152",
+		"EventName": "L1D_OFFCHIP_L3_SOURCED_WRITES",
+		"BriefDescription": "L1D Off-Chip L3 Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 D-Cache directory where the returned cache line was sourced from an Off Chip/On Book Level-3 cache"
+	},
+	{
+		"EventCode": "153",
+		"EventName": "L1I_ONCHIP_L3_SOURCED_WRITES",
+		"BriefDescription": "L1I On-Chip L3 Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 I-Cache directory where the returned cache line was sourced from an On Chip Level-3 cache"
+	},
+	{
+		"EventCode": "155",
+		"EventName": "L1I_OFFCHIP_L3_SOURCED_WRITES",
+		"BriefDescription": "L1I Off-Chip L3 Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 I-Cache directory where the returned cache line was sourced from an Off Chip/On Book Level-3 cache"
+	},
+]
diff --git a/tools/perf/pmu-events/arch/s390/mapfile.csv b/tools/perf/pmu-events/arch/s390/mapfile.csv
index 735159593c2c..b9c673087011 100644
--- a/tools/perf/pmu-events/arch/s390/mapfile.csv
+++ b/tools/perf/pmu-events/arch/s390/mapfile.csv
@@ -1,2 +1,3 @@
 Family-model,Version,Filename,EventType
 209[78],1,cf_z10,core
+281[78],1,cf_z196,core
-- 
2.14.3
