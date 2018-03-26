Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752277AbeCZI0N (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 04:26:13 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37088 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751220AbeCZI0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 04:26:03 -0400
From: Thomas Richter <tmricht@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc: brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.vnet.ibm.com>
Subject: [PATCH 5/5] perf list: Add pmu event json file for IBM z14
Date: Mon, 26 Mar 2018 10:25:38 +0200
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20180326082538.2258-1-tmricht@linux.vnet.ibm.com>
References: <20180326082538.2258-1-tmricht@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18032608-0012-0000-0000-000005C338FF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18032608-0013-0000-0000-0000193F6D66
Message-Id: <20180326082538.2258-5-tmricht@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-26_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803260092
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add CPU measurement counter facility event description
files (json files) for IBM z14.

Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
---
 tools/perf/pmu-events/arch/s390/cf_z14/basic.json  |  50 ++++
 tools/perf/pmu-events/arch/s390/cf_z14/crypto.json |  98 +++++++
 .../perf/pmu-events/arch/s390/cf_z14/extended.json | 320 +++++++++++++++++++++
 tools/perf/pmu-events/arch/s390/mapfile.csv        |   1 +
 4 files changed, 469 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/s390/cf_z14/basic.json
 create mode 100644 tools/perf/pmu-events/arch/s390/cf_z14/crypto.json
 create mode 100644 tools/perf/pmu-events/arch/s390/cf_z14/extended.json

diff --git a/tools/perf/pmu-events/arch/s390/cf_z14/basic.json b/tools/perf/pmu-events/arch/s390/cf_z14/basic.json
new file mode 100644
index 000000000000..8f653c9d899d
--- /dev/null
+++ b/tools/perf/pmu-events/arch/s390/cf_z14/basic.json
@@ -0,0 +1,50 @@
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
+]
diff --git a/tools/perf/pmu-events/arch/s390/cf_z14/crypto.json b/tools/perf/pmu-events/arch/s390/cf_z14/crypto.json
new file mode 100644
index 000000000000..7e5b72492141
--- /dev/null
+++ b/tools/perf/pmu-events/arch/s390/cf_z14/crypto.json
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
-- 
2.14.3
