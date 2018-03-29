Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753024AbeC2OCO (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 10:02:14 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58087 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752458AbeC2OCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 10:02:12 -0400
Date: Thu, 29 Mar 2018 07:02:00 -0700
From: tip-bot for Thomas Richter <tipbot@zytor.com>
Message-ID: <tip-109d59b900e78834c66657dd4748fcedb9a1fe8d@git.kernel.org>
Cc: tmricht@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        tglx@linutronix.de, acme@redhat.com, hpa@zytor.com, mingo@kernel.org,
        heiko.carstens@de.ibm.com
Reply-To: mingo@kernel.org, heiko.carstens@de.ibm.com,
        linux-kernel@vger.kernel.org, tmricht@linux.vnet.ibm.com,
        schwidefsky@de.ibm.com, brueckner@linux.vnet.ibm.com,
        tglx@linutronix.de, acme@redhat.com, hpa@zytor.com
In-Reply-To: <20180326082538.2258-5-tmricht@linux.vnet.ibm.com>
References: <20180326082538.2258-5-tmricht@linux.vnet.ibm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf vendor events s390: Add JSON files for IBM z14
Git-Commit-ID: 109d59b900e78834c66657dd4748fcedb9a1fe8d
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

Commit-ID:  109d59b900e78834c66657dd4748fcedb9a1fe8d
Gitweb:     https://git.kernel.org/tip/109d59b900e78834c66657dd4748fcedb9a1fe8d
Author:     Thomas Richter <tmricht@linux.vnet.ibm.com>
AuthorDate: Mon, 26 Mar 2018 10:25:38 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 27 Mar 2018 13:13:39 -0300

perf vendor events s390: Add JSON files for IBM z14

Add CPU measurement counter facility event description files (json
files) for IBM z14.

Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Link: http://lkml.kernel.org/r/20180326082538.2258-5-tmricht@linux.vnet.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../arch/s390/{cf_z196 => cf_z14}/basic.json       |  24 --
 .../arch/s390/{cf_z10 => cf_z14}/crypto.json       |   0
 .../perf/pmu-events/arch/s390/cf_z14/extended.json | 320 +++++++++++++++++++++
 tools/perf/pmu-events/arch/s390/mapfile.csv        |   1 +
 4 files changed, 321 insertions(+), 24 deletions(-)

diff --git a/tools/perf/pmu-events/arch/s390/cf_z196/basic.json b/tools/perf/pmu-events/arch/s390/cf_z14/basic.json
similarity index 60%
copy from tools/perf/pmu-events/arch/s390/cf_z196/basic.json
copy to tools/perf/pmu-events/arch/s390/cf_z14/basic.json
index 8bf16759ca53..8f653c9d899d 100644
--- a/tools/perf/pmu-events/arch/s390/cf_z196/basic.json
+++ b/tools/perf/pmu-events/arch/s390/cf_z14/basic.json
@@ -47,28 +47,4 @@
 		"BriefDescription": "Problem-State Instructions",
 		"PublicDescription": "Problem-State Instruction Count"
 	},
-	{
-		"EventCode": "34",
-		"EventName": "PROBLEM_STATE_L1I_DIR_WRITES",
-		"BriefDescription": "Problem-State L1I Directory Writes",
-		"PublicDescription": "Problem-State Level-1 I-Cache Directory Write Count"
-	},
-	{
-		"EventCode": "35",
-		"EventName": "PROBLEM_STATE_L1I_PENALTY_CYCLES",
-		"BriefDescription": "Problem-State L1I Penalty Cycles",
-		"PublicDescription": "Problem-State Level-1 I-Cache Penalty Cycle Count"
-	},
-	{
-		"EventCode": "36",
-		"EventName": "PROBLEM_STATE_L1D_DIR_WRITES",
-		"BriefDescription": "Problem-State L1D Directory Writes",
-		"PublicDescription": "Problem-State Level-1 D-Cache Directory Write Count"
-	},
-	{
-		"EventCode": "37",
-		"EventName": "PROBLEM_STATE_L1D_PENALTY_CYCLES",
-		"BriefDescription": "Problem-State L1D Penalty Cycles",
-		"PublicDescription": "Problem-State Level-1 D-Cache Penalty Cycle Count"
-	},
 ]
diff --git a/tools/perf/pmu-events/arch/s390/cf_z10/crypto.json b/tools/perf/pmu-events/arch/s390/cf_z14/crypto.json
similarity index 100%
copy from tools/perf/pmu-events/arch/s390/cf_z10/crypto.json
copy to tools/perf/pmu-events/arch/s390/cf_z14/crypto.json
diff --git a/tools/perf/pmu-events/arch/s390/cf_z14/extended.json b/tools/perf/pmu-events/arch/s390/cf_z14/extended.json
new file mode 100644
index 000000000000..aa4dfb46b65b
--- /dev/null
+++ b/tools/perf/pmu-events/arch/s390/cf_z14/extended.json
@@ -0,0 +1,320 @@
+[
+	{
+		"EventCode": "128",
+		"EventName": "L1D_RO_EXCL_WRITES",
+		"BriefDescription": "L1D Read-only Exclusive Writes",
+		"PublicDescription": "Counter:128	Name:L1D_RO_EXCL_WRITES A directory write to the Level-1 Data cache where the line was originally in a Read-Only state in the cache but has been updated to be in the Exclusive state that allows stores to the cache line"
+	},
+	{
+		"EventCode": "129",
+		"EventName": "DTLB2_WRITES",
+		"BriefDescription": "DTLB2 Writes",
+		"PublicDescription": "A translation has been written into The Translation Lookaside Buffer 2 (TLB2) and the request was made by the data cache"
+	},
+	{
+		"EventCode": "130",
+		"EventName": "DTLB2_MISSES",
+		"BriefDescription": "DTLB2 Misses",
+		"PublicDescription": "A TLB2 miss is in progress for a request made by the data cache. Incremented by one for every TLB2 miss in progress for the Level-1 Data cache on this cycle"
+	},
+	{
+		"EventCode": "131",
+		"EventName": "DTLB2_HPAGE_WRITES",
+		"BriefDescription": "DTLB2 One-Megabyte Page Writes",
+		"PublicDescription": "A translation entry was written into the Combined Region and Segment Table Entry array in the Level-2 TLB for a one-megabyte page or a Last Host Translation was done"
+	},
+	{
+		"EventCode": "132",
+		"EventName": "DTLB2_GPAGE_WRITES",
+		"BriefDescription": "DTLB2 Two-Gigabyte Page Writes",
+		"PublicDescription": "A translation entry for a two-gigabyte page was written into the Level-2 TLB"
+	},
+	{
+		"EventCode": "133",
+		"EventName": "L1D_L2D_SOURCED_WRITES",
+		"BriefDescription": "L1D L2D Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from the Level-2 Data cache"
+	},
+	{
+		"EventCode": "134",
+		"EventName": "ITLB2_WRITES",
+		"BriefDescription": "ITLB2 Writes",
+		"PublicDescription": "A translation entry has been written into the Translation Lookaside Buffer 2 (TLB2) and the request was made by the instruction cache"
+	},
+	{
+		"EventCode": "135",
+		"EventName": "ITLB2_MISSES",
+		"BriefDescription": "ITLB2 Misses",
+		"PublicDescription": "A TLB2 miss is in progress for a request made by the instruction cache. Incremented by one for every TLB2 miss in progress for the Level-1 Instruction cache in a cycle"
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
+		"PublicDescription": "A translation entry was written into the Page Table Entry array in the Level-2 TLB"
+	},
+	{
+		"EventCode": "138",
+		"EventName": "TLB2_CRSTE_WRITES",
+		"BriefDescription": "TLB2 CRSTE Writes",
+		"PublicDescription": "Translation entries were written into the Combined Region and Segment Table Entry array and the Page Table Entry array in the Level-2 TLB"
+	},
+	{
+		"EventCode": "139",
+		"EventName": "TLB2_ENGINES_BUSY",
+		"BriefDescription": "TLB2 Engines Busy",
+		"PublicDescription": "The number of Level-2 TLB translation engines busy in a cycle"
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
+		"EventName": "L1C_TLB2_MISSES",
+		"BriefDescription": "L1C TLB2 Misses",
+		"PublicDescription": "Increments by one for any cycle where a level-1 cache or level-2 TLB miss is in progress"
+	},
+	{
+		"EventCode": "144",
+		"EventName": "L1D_ONCHIP_L3_SOURCED_WRITES",
+		"BriefDescription": "L1D On-Chip L3 Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an On-Chip Level-3 cache without intervention"
+	},
+	{
+		"EventCode": "145",
+		"EventName": "L1D_ONCHIP_MEMORY_SOURCED_WRITES",
+		"BriefDescription": "L1D On-Chip Memory Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from On-Chip memory"
+	},
+	{
+		"EventCode": "146",
+		"EventName": "L1D_ONCHIP_L3_SOURCED_WRITES_IV",
+		"BriefDescription": "L1D On-Chip L3 Sourced Writes with Intervention",
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an On-Chip Level-3 cache with intervention"
+	},
+	{
+		"EventCode": "147",
+		"EventName": "L1D_ONCLUSTER_L3_SOURCED_WRITES",
+		"BriefDescription": "L1D On-Cluster L3 Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from On-Cluster Level-3 cache withountervention"
+	},
+	{
+		"EventCode": "148",
+		"EventName": "L1D_ONCLUSTER_MEMORY_SOURCED_WRITES",
+		"BriefDescription": "L1D On-Cluster Memory Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an On-Cluster memory"
+	},
+	{
+		"EventCode": "149",
+		"EventName": "L1D_ONCLUSTER_L3_SOURCED_WRITES_IV",
+		"BriefDescription": "L1D On-Cluster L3 Sourced Writes with Intervention",
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an On-Cluster Level-3 cache with intervention"
+	},
+	{
+		"EventCode": "150",
+		"EventName": "L1D_OFFCLUSTER_L3_SOURCED_WRITES",
+		"BriefDescription": "L1D Off-Cluster L3 Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an Off-Cluster Level-3 cache without intervention"
+	},
+	{
+		"EventCode": "151",
+		"EventName": "L1D_OFFCLUSTER_MEMORY_SOURCED_WRITES",
+		"BriefDescription": "L1D Off-Cluster Memory Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from Off-Cluster memory"
+	},
+	{
+		"EventCode": "152",
+		"EventName": "L1D_OFFCLUSTER_L3_SOURCED_WRITES_IV",
+		"BriefDescription": "L1D Off-Cluster L3 Sourced Writes with Intervention",
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an Off-Cluster Level-3 cache with intervention"
+	},
+	{
+		"EventCode": "153",
+		"EventName": "L1D_OFFDRAWER_L3_SOURCED_WRITES",
+		"BriefDescription": "L1D Off-Drawer L3 Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an Off-Drawer Level-3 cache without intervention"
+	},
+	{
+		"EventCode": "154",
+		"EventName": "L1D_OFFDRAWER_MEMORY_SOURCED_WRITES",
+		"BriefDescription": "L1D Off-Drawer Memory Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from Off-Drawer memory"
+	},
+	{
+		"EventCode": "155",
+		"EventName": "L1D_OFFDRAWER_L3_SOURCED_WRITES_IV",
+		"BriefDescription": "L1D Off-Drawer L3 Sourced Writes with Intervention",
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an Off-Drawer Level-3 cache with intervention"
+	},
+	{
+		"EventCode": "156",
+		"EventName": "L1D_ONDRAWER_L4_SOURCED_WRITES",
+		"BriefDescription": "L1D On-Drawer L4 Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from On-Drawer Level-4 cache"
+	},
+	{
+		"EventCode": "157",
+		"EventName": "L1D_OFFDRAWER_L4_SOURCED_WRITES",
+		"BriefDescription": "L1D Off-Drawer L4 Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from Off-Drawer Level-4 cache"
+	},
+	{
+		"EventCode": "158",
+		"EventName": "L1D_ONCHIP_L3_SOURCED_WRITES_RO",
+		"BriefDescription": "L1D On-Chip L3 Sourced Writes read-only",
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from On-Chip L3 but a read-only invalidate was done to remove other copies of the cache line"
+	},
+	{
+		"EventCode": "162",
+		"EventName": "L1I_ONCHIP_L3_SOURCED_WRITES",
+		"BriefDescription": "L1I On-Chip L3 Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache ine was sourced from an On-Chip Level-3 cache without intervention"
+	},
+	{
+		"EventCode": "163",
+		"EventName": "L1I_ONCHIP_MEMORY_SOURCED_WRITES",
+		"BriefDescription": "L1I On-Chip Memory Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache ine was sourced from On-Chip memory"
+	},
+	{
+		"EventCode": "164",
+		"EventName": "L1I_ONCHIP_L3_SOURCED_WRITES_IV",
+		"BriefDescription": "L1I On-Chip L3 Sourced Writes with Intervention",
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache ine was sourced from an On-Chip Level-3 cache with intervention"
+	},
+	{
+		"EventCode": "165",
+		"EventName": "L1I_ONCLUSTER_L3_SOURCED_WRITES",
+		"BriefDescription": "L1I On-Cluster L3 Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an On-Cluster Level-3 cache without intervention"
+	},
+	{
+		"EventCode": "166",
+		"EventName": "L1I_ONCLUSTER_MEMORY_SOURCED_WRITES",
+		"BriefDescription": "L1I On-Cluster Memory Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an On-Cluster memory"
+	},
+	{
+		"EventCode": "167",
+		"EventName": "L1I_ONCLUSTER_L3_SOURCED_WRITES_IV",
+		"BriefDescription": "L1I On-Cluster L3 Sourced Writes with Intervention",
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from On-Cluster Level-3 cache with intervention"
+	},
+	{
+		"EventCode": "168",
+		"EventName": "L1I_OFFCLUSTER_L3_SOURCED_WRITES",
+		"BriefDescription": "L1I Off-Cluster L3 Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an Off-Cluster Level-3 cache without intervention"
+	},
+	{
+		"EventCode": "169",
+		"EventName": "L1I_OFFCLUSTER_MEMORY_SOURCED_WRITES",
+		"BriefDescription": "L1I Off-Cluster Memory Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from Off-Cluster memory"
+	},
+	{
+		"EventCode": "170",
+		"EventName": "L1I_OFFCLUSTER_L3_SOURCED_WRITES_IV",
+		"BriefDescription": "L1I Off-Cluster L3 Sourced Writes with Intervention",
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an Off-Cluster Level-3 cache with intervention"
+	},
+	{
+		"EventCode": "171",
+		"EventName": "L1I_OFFDRAWER_L3_SOURCED_WRITES",
+		"BriefDescription": "L1I Off-Drawer L3 Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an Off-Drawer Level-3 cache without intervention"
+	},
+	{
+		"EventCode": "172",
+		"EventName": "L1I_OFFDRAWER_MEMORY_SOURCED_WRITES",
+		"BriefDescription": "L1I Off-Drawer Memory Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from Off-Drawer memory"
+	},
+	{
+		"EventCode": "173",
+		"EventName": "L1I_OFFDRAWER_L3_SOURCED_WRITES_IV",
+		"BriefDescription": "L1I Off-Drawer L3 Sourced Writes with Intervention",
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an Off-Drawer Level-3 cache with intervention"
+	},
+	{
+		"EventCode": "174",
+		"EventName": "L1I_ONDRAWER_L4_SOURCED_WRITES",
+		"BriefDescription": "L1I On-Drawer L4 Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from On-Drawer Level-4 cache"
+	},
+	{
+		"EventCode": "175",
+		"EventName": "L1I_OFFDRAWER_L4_SOURCED_WRITES",
+		"BriefDescription": "L1I Off-Drawer L4 Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from Off-Drawer Level-4 cache"
+	},
+	{
+		"EventCode": "224",
+		"EventName": "BCD_DFP_EXECUTION_SLOTS",
+		"BriefDescription": "BCD DFP Execution Slots",
+		"PublicDescription": "Count of floating point execution slots used for finished Binary Coded Decimal to Decimal Floating Point conversions. Instructions: CDZT, CXZT, CZDT, CZXT"
+	},
+	{
+		"EventCode": "225",
+		"EventName": "VX_BCD_EXECUTION_SLOTS",
+		"BriefDescription": "VX BCD Execution Slots",
+		"PublicDescription": "Count of floating point execution slots used for finished vector arithmetic Binary Coded Decimal instructions. Instructions: VAP, VSP, VMPVMSP, VDP, VSDP, VRP, VLIP, VSRP, VPSOPVCP, VTP, VPKZ, VUPKZ, VCVB, VCVBG, VCVDVCVDG"
+	},
+	{
+		"EventCode": "226",
+		"EventName": "DECIMAL_INSTRUCTIONS",
+		"BriefDescription": "Decimal Instructions",
+		"PublicDescription": "Decimal instructions dispatched. Instructions: CVB, CVD, AP, CP, DP, ED, EDMK, MP, SRP, SP, ZAP"
+	},
+	{
+		"EventCode": "232",
+		"EventName": "LAST_HOST_TRANSLATIONS",
+		"BriefDescription": "Last host translation done",
+		"PublicDescription": "Last Host Translation done"
+	},
+	{
+		"EventCode": "243",
+		"EventName": "TX_NC_TABORT",
+		"BriefDescription": "Aborted transactions in non-constrained TX mode",
+		"PublicDescription": "A transaction abort has occurred in a non-constrained transactional-execution mode"
+	},
+	{
+		"EventCode": "244",
+		"EventName": "TX_C_TABORT_NO_SPECIAL",
+		"BriefDescription": "Aborted transactions in constrained TX mode not using special completion logic",
+		"PublicDescription": "A transaction abort has occurred in a constrained transactional-execution mode and the CPU is not using any special logic to allow the transaction to complete"
+	},
+	{
+		"EventCode": "245",
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
index 3cff9c64bb85..ca7682748a4b 100644
--- a/tools/perf/pmu-events/arch/s390/mapfile.csv
+++ b/tools/perf/pmu-events/arch/s390/mapfile.csv
@@ -3,3 +3,4 @@ Family-model,Version,Filename,EventType
 281[78],1,cf_z196,core
 282[78],1,cf_zec12,core
 296[45],1,cf_z13,core
+3906,3,cf_z14,core
