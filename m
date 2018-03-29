Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753122AbeC2OBp (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 10:01:45 -0400
Received: from terminus.zytor.com ([198.137.202.136]:32967 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753089AbeC2OBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 10:01:44 -0400
Date: Thu, 29 Mar 2018 07:01:27 -0700
From: tip-bot for Thomas Richter <tipbot@zytor.com>
Message-ID: <tip-bc17f949d6feb633e579ee7e7dd58d9200073215@git.kernel.org>
Cc: mingo@kernel.org, hpa@zytor.com, acme@redhat.com,
        heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org,
        brueckner@linux.vnet.ibm.com, tmricht@linux.vnet.ibm.com,
        schwidefsky@de.ibm.com, tglx@linutronix.de
Reply-To: acme@redhat.com, heiko.carstens@de.ibm.com, mingo@kernel.org,
        hpa@zytor.com, tglx@linutronix.de, schwidefsky@de.ibm.com,
        brueckner@linux.vnet.ibm.com, tmricht@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20180326082538.2258-4-tmricht@linux.vnet.ibm.com>
References: <20180326082538.2258-4-tmricht@linux.vnet.ibm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf vendor events s390: Add JSON files for IBM z13
Git-Commit-ID: bc17f949d6feb633e579ee7e7dd58d9200073215
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

Commit-ID:  bc17f949d6feb633e579ee7e7dd58d9200073215
Gitweb:     https://git.kernel.org/tip/bc17f949d6feb633e579ee7e7dd58d9200073215
Author:     Thomas Richter <tmricht@linux.vnet.ibm.com>
AuthorDate: Mon, 26 Mar 2018 10:25:37 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 27 Mar 2018 13:13:39 -0300

perf vendor events s390: Add JSON files for IBM z13

Add CPU measurement counter facility event description files (json
files) for IBM z13.

Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Link: http://lkml.kernel.org/r/20180326082538.2258-4-tmricht@linux.vnet.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../arch/s390/{cf_z10 => cf_z13}/basic.json        |   0
 .../arch/s390/{cf_z10 => cf_z13}/crypto.json       |   0
 .../perf/pmu-events/arch/s390/cf_z13/extended.json | 338 +++++++++++++++++++++
 tools/perf/pmu-events/arch/s390/mapfile.csv        |   1 +
 4 files changed, 339 insertions(+)

diff --git a/tools/perf/pmu-events/arch/s390/cf_z10/basic.json b/tools/perf/pmu-events/arch/s390/cf_z13/basic.json
similarity index 100%
copy from tools/perf/pmu-events/arch/s390/cf_z10/basic.json
copy to tools/perf/pmu-events/arch/s390/cf_z13/basic.json
diff --git a/tools/perf/pmu-events/arch/s390/cf_z10/crypto.json b/tools/perf/pmu-events/arch/s390/cf_z13/crypto.json
similarity index 100%
copy from tools/perf/pmu-events/arch/s390/cf_z10/crypto.json
copy to tools/perf/pmu-events/arch/s390/cf_z13/crypto.json
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
