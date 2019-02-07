Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D09D7C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7880E21872
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:53:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbfBGRx0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 12:53:26 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52132 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726576AbfBGRxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 12:53:22 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x17Hjjd5010781
        for <linux-kernel@vger.kernel.org>; Thu, 7 Feb 2019 12:53:21 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qgqv85mxe-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 12:53:20 -0500
Received: from localhost
        by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pc@us.ibm.com>;
        Thu, 7 Feb 2019 17:53:20 -0000
Received: from b03cxnp07028.gho.boulder.ibm.com (9.17.130.15)
        by e35.co.us.ibm.com (192.168.1.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 7 Feb 2019 17:53:18 -0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x17HrHD523593044
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Feb 2019 17:53:17 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7C104C6057;
        Thu,  7 Feb 2019 17:53:17 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3E0D0C6059;
        Thu,  7 Feb 2019 17:53:17 +0000 (GMT)
Received: from localhost (unknown [9.114.15.222])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu,  7 Feb 2019 17:53:17 +0000 (GMT)
From:   Paul Clarke <pc@us.ibm.com>
To:     linux-perf-users@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, ananth@linux.vnet.ibm.com,
        maddy@linux.vnet.ibm.com, naveen.n.rao@linux.vnet.ibm.com,
        sukadev@linux.ibm.com, mpe@ellerman.id.au, cel@us.ibm.com
Subject: [PATCH v2 4/4] [powerpc] perf vendor events: Add JSON metrics for POWER8
Date:   Thu,  7 Feb 2019 12:53:14 -0500
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190207175314.31813-1-pc@us.ibm.com>
References: <20190207175314.31813-1-pc@us.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19020717-0012-0000-0000-00001706A919
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010555; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000279; SDB=6.01157696; UDB=6.00604001; IPR=6.00938227;
 MB=3.00025481; MTD=3.00000008; XFM=3.00000015; UTC=2019-02-07 17:53:19
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19020717-0013-0000-0000-0000561DB870
Message-Id: <20190207175314.31813-5-pc@us.ibm.com>
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-07_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902070134
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

POWER8 metrics not well publicized.  Some are here:
https://www.ibm.com/support/knowledgecenter/en/SSFK5S_2.2.0/com.ibm.cluster.pedev.v2r2.pedev100.doc/bl7ug_derivedmetricspower8.htm

This patch is for metric groups:
- translation
- general

and other metrics not in a metric group.

Signed-off-by: Paul A. Clarke <pc@us.ibm.com>
---
 .../arch/powerpc/power8/metrics.json          | 590 ++++++++++++++++++
 1 file changed, 590 insertions(+)

diff --git a/tools/perf/pmu-events/arch/powerpc/power8/metrics.json b/tools/perf/pmu-events/arch/powerpc/power8/metrics.json
index d8b710e12377..bffb2d4a6420 100644
--- a/tools/perf/pmu-events/arch/powerpc/power8/metrics.json
+++ b/tools/perf/pmu-events/arch/powerpc/power8/metrics.json
@@ -836,6 +836,216 @@
         "MetricGroup": "estimated_dcache_miss_cpi",
         "MetricName": "rmem_cpi_percent"
     },
+    {
+        "BriefDescription": "Branch Mispredict flushes per instruction",
+        "MetricExpr": "PM_FLUSH_BR_MPRED / PM_RUN_INST_CMPL * 100",
+        "MetricGroup": "general",
+        "MetricName": "br_mpred_flush_rate_percent"
+    },
+    {
+        "BriefDescription": "Cycles per instruction",
+        "MetricExpr": "PM_CYC / PM_INST_CMPL",
+        "MetricGroup": "general",
+        "MetricName": "cpi"
+    },
+    {
+        "BriefDescription": "Percentage Cycles a group completed",
+        "MetricExpr": "PM_GRP_CMPL / PM_CYC * 100",
+        "MetricGroup": "general",
+        "MetricName": "cyc_grp_completed_percent"
+    },
+    {
+        "BriefDescription": "Percentage Cycles a group dispatched",
+        "MetricExpr": "PM_1PLUS_PPC_DISP / PM_CYC * 100",
+        "MetricGroup": "general",
+        "MetricName": "cyc_grp_dispatched_percent"
+    },
+    {
+        "BriefDescription": "Cycles per group",
+        "MetricExpr": "PM_CYC / PM_1PLUS_PPC_CMPL",
+        "MetricGroup": "general",
+        "MetricName": "cyc_per_group"
+    },
+    {
+        "BriefDescription": "GCT empty cycles",
+        "MetricExpr": "(PM_FLUSH_DISP / PM_RUN_INST_CMPL) * 100",
+        "MetricGroup": "general",
+        "MetricName": "disp_flush_rate_percent"
+    },
+    {
+        "BriefDescription": "% DTLB miss rate per inst",
+        "MetricExpr": "PM_DTLB_MISS  / PM_RUN_INST_CMPL *100",
+        "MetricGroup": "general",
+        "MetricName": "dtlb_miss_rate_percent"
+    },
+    {
+        "BriefDescription": "Flush rate (%)",
+        "MetricExpr": "PM_FLUSH * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "general",
+        "MetricName": "flush_rate_percent"
+    },
+    {
+        "BriefDescription": "GCT slot utilization (11 to 14) as a % of cycles this thread had atleast 1 slot valid",
+        "MetricExpr": "PM_GCT_UTIL_11_14_ENTRIES / ( PM_RUN_CYC - PM_GCT_NOSLOT_CYC) * 100",
+        "MetricGroup": "general",
+        "MetricName": "gct_util_11to14_slots_percent"
+    },
+    {
+        "BriefDescription": "GCT slot utilization (15 to 17) as a % of cycles this thread had atleast 1 slot valid",
+        "MetricExpr": "PM_GCT_UTIL_15_17_ENTRIES / ( PM_RUN_CYC - PM_GCT_NOSLOT_CYC) * 100",
+        "MetricGroup": "general",
+        "MetricName": "gct_util_15to17_slots_percent"
+    },
+    {
+        "BriefDescription": "GCT slot utilization 18+ as a % of cycles this thread had atleast 1 slot valid",
+        "MetricExpr": "PM_GCT_UTIL_18_ENTRIES / ( PM_RUN_CYC - PM_GCT_NOSLOT_CYC) * 100",
+        "MetricGroup": "general",
+        "MetricName": "gct_util_18plus_slots_percent"
+    },
+    {
+        "BriefDescription": "GCT slot utilization (1 to 2) as a % of cycles this thread had atleast 1 slot valid",
+        "MetricExpr": "PM_GCT_UTIL_1_2_ENTRIES /  ( PM_RUN_CYC - PM_GCT_NOSLOT_CYC) * 100",
+        "MetricGroup": "general",
+        "MetricName": "gct_util_1to2_slots_percent"
+    },
+    {
+        "BriefDescription": "GCT slot utilization (3 to 6) as a % of cycles this thread had atleast 1 slot valid",
+        "MetricExpr": "PM_GCT_UTIL_3_6_ENTRIES / ( PM_RUN_CYC - PM_GCT_NOSLOT_CYC) * 100",
+        "MetricGroup": "general",
+        "MetricName": "gct_util_3to6_slots_percent"
+    },
+    {
+        "BriefDescription": "GCT slot utilization (7 to 10) as a % of cycles this thread had atleast 1 slot valid",
+        "MetricExpr": "PM_GCT_UTIL_7_10_ENTRIES / ( PM_RUN_CYC - PM_GCT_NOSLOT_CYC) * 100",
+        "MetricGroup": "general",
+        "MetricName": "gct_util_7to10_slots_percent"
+    },
+    {
+        "BriefDescription": "Avg. group size",
+        "MetricExpr": "PM_INST_CMPL / PM_1PLUS_PPC_CMPL",
+        "MetricGroup": "general",
+        "MetricName": "group_size"
+    },
+    {
+        "BriefDescription": "Instructions per group",
+        "MetricExpr": "PM_INST_CMPL / PM_1PLUS_PPC_CMPL",
+        "MetricGroup": "general",
+        "MetricName": "inst_per_group"
+    },
+    {
+        "BriefDescription": "Instructions per cycles",
+        "MetricExpr": "PM_INST_CMPL / PM_CYC",
+        "MetricGroup": "general",
+        "MetricName": "ipc"
+    },
+    {
+        "BriefDescription": "% ITLB miss rate per inst",
+        "MetricExpr": "PM_ITLB_MISS  / PM_RUN_INST_CMPL *100",
+        "MetricGroup": "general",
+        "MetricName": "itlb_miss_rate_percent"
+    },
+    {
+        "BriefDescription": "Percentage of L1 load misses per L1 load ref",
+        "MetricExpr": "PM_LD_MISS_L1 / PM_LD_REF_L1 * 100",
+        "MetricGroup": "general",
+        "MetricName": "l1_ld_miss_ratio_percent"
+    },
+    {
+        "BriefDescription": "Percentage of L1 store misses per run instruction",
+        "MetricExpr": "PM_ST_MISS_L1 * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "general",
+        "MetricName": "l1_st_miss_rate_percent"
+    },
+    {
+        "BriefDescription": "Percentage of L1 store misses per L1 store ref",
+        "MetricExpr": "PM_ST_MISS_L1 / PM_ST_FIN  * 100",
+        "MetricGroup": "general",
+        "MetricName": "l1_st_miss_ratio_percent"
+    },
+    {
+        "BriefDescription": "L2 Instruction Miss Rate (per instruction)(%)",
+        "MetricExpr": "PM_INST_FROM_L2MISS * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "general",
+        "MetricName": "l2_inst_miss_rate_percent"
+    },
+    {
+        "BriefDescription": "L2 dmand  Load Miss Rate (per run instruction)(%)",
+        "MetricExpr": "PM_DATA_FROM_L2MISS * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "general",
+        "MetricName": "l2_ld_miss_rate_percent"
+    },
+    {
+        "BriefDescription": "L2 PTEG Miss Rate (per run instruction)(%)",
+        "MetricExpr": "PM_DPTEG_FROM_L2MISS * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "general",
+        "MetricName": "l2_pteg_miss_rate_percent"
+    },
+    {
+        "BriefDescription": "Percentage of L2 store misses per run instruction",
+        "MetricExpr": "PM_ST_MISS_L1 * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "general",
+        "MetricName": "l2_st_miss_rate_percent"
+    },
+    {
+        "BriefDescription": "L3 Instruction Miss Rate (per instruction)(%)",
+        "MetricExpr": "PM_INST_FROM_L3MISS * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "general",
+        "MetricName": "l3_inst_miss_rate_percent"
+    },
+    {
+        "BriefDescription": "L3 demand Load Miss Rate (per run instruction)(%)",
+        "MetricExpr": "PM_DATA_FROM_L3MISS * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "general",
+        "MetricName": "l3_ld_miss_rate_percent"
+    },
+    {
+        "BriefDescription": "L3 PTEG Miss Rate (per run instruction)(%)",
+        "MetricExpr": "PM_DPTEG_FROM_L3MISS * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "general",
+        "MetricName": "l3_pteg_miss_rate_percent"
+    },
+    {
+        "BriefDescription": "Run cycles per cycle",
+        "MetricExpr": "PM_RUN_CYC / PM_CYC*100",
+        "MetricGroup": "general",
+        "MetricName": "run_cycles_percent"
+    },
+    {
+        "BriefDescription": "Percentage of cycles spent in SMT2 Mode",
+        "MetricExpr": "(PM_RUN_CYC_SMT2_MODE/PM_RUN_CYC) * 100",
+        "MetricGroup": "general",
+        "MetricName": "smt2_cycles_percent"
+    },
+    {
+        "BriefDescription": "Percentage of cycles spent in SMT4 Mode",
+        "MetricExpr": "(PM_RUN_CYC_SMT4_MODE/PM_RUN_CYC) * 100",
+        "MetricGroup": "general",
+        "MetricName": "smt4_cycles_percent"
+    },
+    {
+        "BriefDescription": "Percentage of cycles spent in SMT8 Mode",
+        "MetricExpr": "(PM_RUN_CYC_SMT8_MODE/PM_RUN_CYC) * 100",
+        "MetricGroup": "general",
+        "MetricName": "smt8_cycles_percent"
+    },
+    {
+        "BriefDescription": "IPC of all instructions completed by the core while this thread was stalled",
+        "MetricExpr": "PM_CMPLU_STALL_OTHER_CMPL/PM_RUN_CYC",
+        "MetricGroup": "general",
+        "MetricName": "smt_benefit"
+    },
+    {
+        "BriefDescription": "Instruction dispatch-to-completion ratio",
+        "MetricExpr": "PM_INST_DISP / PM_INST_CMPL",
+        "MetricGroup": "general",
+        "MetricName": "speculation"
+    },
+    {
+        "BriefDescription": "Percentage of cycles spent in Single Thread Mode",
+        "MetricExpr": "(PM_RUN_CYC_ST_MODE/PM_RUN_CYC) * 100",
+        "MetricGroup": "general",
+        "MetricName": "st_cycles_percent"
+    },
     {
         "BriefDescription": "% of ICache reloads from Distant L2 or L3 (Modified) per Inst",
         "MetricExpr": "PM_INST_FROM_DL2L3_MOD * 100 / PM_RUN_INST_CMPL",
@@ -1651,5 +1861,385 @@
         "MetricExpr": "PM_DPTEG_FROM_RMEM * 100 / PM_DTLB_MISS",
         "MetricGroup": "pteg_reloads_percent_per_ref",
         "MetricName": "pteg_from_rmem_percent"
+    },
+    {
+        "BriefDescription": "% DERAT miss ratio for 16G page per inst",
+        "MetricExpr": "100 * PM_DERAT_MISS_16G / PM_RUN_INST_CMPL",
+        "MetricGroup": "translation",
+        "MetricName": "derat_16g_miss_rate_percent"
+    },
+    {
+        "BriefDescription": "DERAT miss ratio for 16G page",
+        "MetricExpr": "PM_DERAT_MISS_16G / PM_LSU_DERAT_MISS",
+        "MetricGroup": "translation",
+        "MetricName": "derat_16g_miss_ratio"
+    },
+    {
+        "BriefDescription": "% DERAT miss rate for 16M page per inst",
+        "MetricExpr": "PM_DERAT_MISS_16M * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "translation",
+        "MetricName": "derat_16m_miss_rate_percent"
+    },
+    {
+        "BriefDescription": "DERAT miss ratio for 16M page",
+        "MetricExpr": "PM_DERAT_MISS_16M / PM_LSU_DERAT_MISS",
+        "MetricGroup": "translation",
+        "MetricName": "derat_16m_miss_ratio"
+    },
+    {
+        "BriefDescription": "% DERAT miss rate for 4K page per inst",
+        "MetricExpr": "PM_DERAT_MISS_4K * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "translation",
+        "MetricName": "derat_4k_miss_rate_percent"
+    },
+    {
+        "BriefDescription": "DERAT miss ratio for 4K page",
+        "MetricExpr": "PM_DERAT_MISS_4K / PM_LSU_DERAT_MISS",
+        "MetricGroup": "translation",
+        "MetricName": "derat_4k_miss_ratio"
+    },
+    {
+        "BriefDescription": "% DERAT miss ratio for 64K page per inst",
+        "MetricExpr": "PM_DERAT_MISS_64K * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "translation",
+        "MetricName": "derat_64k_miss_rate_percent"
+    },
+    {
+        "BriefDescription": "DERAT miss ratio for 64K page",
+        "MetricExpr": "PM_DERAT_MISS_64K / PM_LSU_DERAT_MISS",
+        "MetricGroup": "translation",
+        "MetricName": "derat_64k_miss_ratio"
+    },
+    {
+        "BriefDescription": "% DSLB_Miss_Rate per inst",
+        "MetricExpr": "PM_DSLB_MISS * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "translation",
+        "MetricName": "dslb_miss_rate_percent"
+    },
+    {
+        "BriefDescription": "% ISLB miss rate per inst",
+        "MetricExpr": "PM_ISLB_MISS * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "translation",
+        "MetricName": "islb_miss_rate_percent"
+    },
+    {
+        "BriefDescription": "Fraction of hits on any Centaur (local, remote, or distant) on either L4 or DRAM per L1 load ref",
+        "MetricExpr": "PM_DATA_FROM_MEMORY / PM_LD_REF_L1",
+        "MetricName": "any_centaur_ld_hit_ratio"
+    },
+    {
+        "BriefDescription": "Base Completion Cycles",
+        "MetricExpr": "PM_1PLUS_PPC_CMPL / PM_RUN_INST_CMPL",
+        "MetricName": "base_completion_cpi"
+    },
+    {
+        "BriefDescription": "Marked background kill latency, measured in L2",
+        "MetricExpr": "PM_MRK_FAB_RSP_BKILL_CYC / PM_MRK_FAB_RSP_BKILL",
+        "MetricName": "bkill_ratio_percent"
+    },
+    {
+        "BriefDescription": "cycles",
+        "MetricExpr": "PM_RUN_CYC",
+        "MetricName": "custom_secs"
+    },
+    {
+        "BriefDescription": "Fraction of hits on a distant chip's Centaur (L4 or DRAM) per L1 load ref",
+        "MetricExpr": "(PM_DATA_FROM_DMEM + PM_DATA_FROM_DL4) / PM_LD_REF_L1",
+        "MetricName": "distant_centaur_ld_hit_ratio"
+    },
+    {
+        "BriefDescription": "% of DL1 reloads that came from the L3 and beyond",
+        "MetricExpr": "PM_DATA_FROM_L2MISS * 100 / PM_L1_DCACHE_RELOAD_VALID",
+        "MetricName": "dl1_reload_from_l2_miss_percent"
+    },
+    {
+        "BriefDescription": "% of DL1 reloads from Private L3, other core per Inst",
+        "MetricExpr": "(PM_DATA_FROM_L31_MOD + PM_DATA_FROM_L31_SHR) * 100 / PM_RUN_INST_CMPL",
+        "MetricName": "dl1_reload_from_l31_rate_percent"
+    },
+    {
+        "BriefDescription": "Percentage of DL1 reloads from L3 where the lines were brought into the L3 by a prefetch operation",
+        "MetricExpr": "PM_DATA_FROM_L3_MEPF * 100 / PM_L1_DCACHE_RELOAD_VALID",
+        "MetricName": "dl1_reload_from_l3_mepf_percent"
+    },
+    {
+        "BriefDescription": "% of DL1 Reloads from beyond the local L3",
+        "MetricExpr": "PM_DATA_FROM_L3MISS * 100 / PM_L1_DCACHE_RELOAD_VALID",
+        "MetricName": "dl1_reload_from_l3_miss_percent"
+    },
+    {
+        "BriefDescription": "Fraction of hits of a line in the M (exclusive) state on the L2 or L3 of a core on a distant chip per L1 load ref",
+        "MetricExpr": "PM_DATA_FROM_DL2L3_MOD / PM_LD_REF_L1",
+        "MetricName": "dl2l3_mod_ld_hit_ratio"
+    },
+    {
+        "BriefDescription": "Fraction of hits of a line in the S state on the L2 or L3 of a core on a distant chip per L1 load ref",
+        "MetricExpr": "PM_DATA_FROM_DL2L3_SHR / PM_LD_REF_L1",
+        "MetricName": "dl2l3_shr_ld_hit_ratio"
+    },
+    {
+        "BriefDescription": "Fraction of hits on a distant Centaur's cache per L1 load ref",
+        "MetricExpr": "PM_DATA_FROM_DL4 / PM_LD_REF_L1",
+        "MetricName": "dl4_ld_hit_ratio"
+    },
+    {
+        "BriefDescription": "Fraction of hits on a distant Centaur's DRAM per L1 load ref",
+        "MetricExpr": "PM_DATA_FROM_DMEM / PM_LD_REF_L1",
+        "MetricName": "dmem_ld_hit_ratio"
+    },
+    {
+        "BriefDescription": "Rate of DERAT reloads from L2",
+        "MetricExpr": "PM_DPTEG_FROM_L2 * 100 / PM_RUN_INST_CMPL",
+        "MetricName": "dpteg_from_l2_rate_percent"
+    },
+    {
+        "BriefDescription": "Rate of DERAT reloads from L3",
+        "MetricExpr": "PM_DPTEG_FROM_L3 * 100 / PM_RUN_INST_CMPL",
+        "MetricName": "dpteg_from_l3_rate_percent"
+    },
+    {
+        "BriefDescription": "Overhead of expansion cycles",
+        "MetricExpr": "(PM_GRP_CMPL / PM_RUN_INST_CMPL) - (PM_1PLUS_PPC_CMPL / PM_RUN_INST_CMPL)",
+        "MetricName": "expansion_overhead_cpi"
+    },
+    {
+        "BriefDescription": "Total Fixed point operations executded in the Load/Store Unit following a load/store operation",
+        "MetricExpr": "PM_LSU_FX_FIN/PM_RUN_INST_CMPL",
+        "MetricName": "fixed_in_lsu_per_inst"
+    },
+    {
+        "BriefDescription": "GCT empty cycles",
+        "MetricExpr": "(PM_GCT_NOSLOT_CYC / PM_RUN_CYC) * 100",
+        "MetricName": "gct_empty_percent"
+    },
+    {
+        "BriefDescription": "Rate of IERAT reloads from L2",
+        "MetricExpr": "PM_IPTEG_FROM_L2 * 100 / PM_RUN_INST_CMPL",
+        "MetricName": "ipteg_from_l2_rate_percent"
+    },
+    {
+        "BriefDescription": "Rate of IERAT reloads from L3",
+        "MetricExpr": "PM_IPTEG_FROM_L3 * 100 / PM_RUN_INST_CMPL",
+        "MetricName": "ipteg_from_l3_rate_percent"
+    },
+    {
+        "BriefDescription": "Rate of IERAT reloads from local memory",
+        "MetricExpr": "PM_IPTEG_FROM_LL4 * 100 / PM_RUN_INST_CMPL",
+        "MetricName": "ipteg_from_ll4_rate_percent"
+    },
+    {
+        "BriefDescription": "Rate of IERAT reloads from local memory",
+        "MetricExpr": "PM_IPTEG_FROM_LMEM * 100 / PM_RUN_INST_CMPL",
+        "MetricName": "ipteg_from_lmem_rate_percent"
+    },
+    {
+        "BriefDescription": "Fraction of L1 hits per load ref",
+        "MetricExpr": "(PM_LD_REF_L1 - PM_LD_MISS_L1) / PM_LD_REF_L1",
+        "MetricName": "l1_ld_hit_ratio"
+    },
+    {
+        "BriefDescription": "Fraction of L1 load misses per L1 load ref",
+        "MetricExpr": "PM_LD_MISS_L1 / PM_LD_REF_L1",
+        "MetricName": "l1_ld_miss_ratio"
+    },
+    {
+        "BriefDescription": "Fraction of hits on another core's L2 on the same chip per L1 load ref",
+        "MetricExpr": "(PM_DATA_FROM_L21_MOD + PM_DATA_FROM_L21_SHR) / PM_LD_REF_L1",
+        "MetricName": "l2_1_ld_hit_ratio"
+    },
+    {
+        "BriefDescription": "Fraction of hits of a line in the M (exclusive) state on another core's L2 on the same chip per L1 load ref",
+        "MetricExpr": "PM_DATA_FROM_L21_MOD / PM_LD_REF_L1",
+        "MetricName": "l2_1_mod_ld_hit_ratio"
+    },
+    {
+        "BriefDescription": "Fraction of hits of a line in the S state on another core's L2 on the same chip per L1 load ref",
+        "MetricExpr": "PM_DATA_FROM_L21_SHR / PM_LD_REF_L1",
+        "MetricName": "l2_1_shr_ld_hit_ratio"
+    },
+    {
+        "BriefDescription": "Average number of Castout machines used.  1 of 16 CO machines is sampled every L2 cycle",
+        "MetricExpr": "(PM_CO_USAGE / PM_RUN_CYC) * 16",
+        "MetricName": "l2_co_usage"
+    },
+    {
+        "BriefDescription": "Fraction of L2 load hits per L1 load ref",
+        "MetricExpr": "PM_DATA_FROM_L2 / PM_LD_REF_L1",
+        "MetricName": "l2_ld_hit_ratio"
+    },
+    {
+        "BriefDescription": "Fraction of L2 load misses per L1 load ref",
+        "MetricExpr": "PM_DATA_FROM_L2MISS / PM_LD_REF_L1",
+        "MetricName": "l2_ld_miss_ratio"
+    },
+    {
+        "BriefDescription": "Fraction of L2 load hits per L1 load ref where the L2 experienced a Load-Hit-Store conflict",
+        "MetricExpr": "PM_DATA_FROM_L2_DISP_CONFLICT_LDHITST / PM_LD_REF_L1",
+        "MetricName": "l2_lhs_ld_hit_ratio"
+    },
+    {
+        "BriefDescription": "Fraction of L2 load hits per L1 load ref where the L2 did not experience a conflict",
+        "MetricExpr": "PM_DATA_FROM_L2_NO_CONFLICT / PM_LD_REF_L1",
+        "MetricName": "l2_no_conflict_ld_hit_ratio"
+    },
+    {
+        "BriefDescription": "Fraction of L2 load hits per L1 load ref where the L2 experienced some conflict other than Load-Hit-Store",
+        "MetricExpr": "PM_DATA_FROM_L2_DISP_CONFLICT_OTHER / PM_LD_REF_L1",
+        "MetricName": "l2_other_conflict_ld_hit_ratio"
+    },
+    {
+        "BriefDescription": "Average number of Read/Claim machines used.  1 of 16 RC machines is sampled every L2 cycle",
+        "MetricExpr": "(PM_RC_USAGE / PM_RUN_CYC) * 16",
+        "MetricName": "l2_rc_usage"
+    },
+    {
+        "BriefDescription": "Average number of Snoop machines used.  1 of 8 SN machines is sampled every L2 cycle",
+        "MetricExpr": "(PM_SN_USAGE / PM_RUN_CYC) * 8",
+        "MetricName": "l2_sn_usage"
+    },
+    {
+        "BriefDescription": "Marked L31 Load latency",
+        "MetricExpr": "(PM_MRK_DATA_FROM_L31_SHR_CYC + PM_MRK_DATA_FROM_L31_MOD_CYC) / (PM_MRK_DATA_FROM_L31_SHR + PM_MRK_DATA_FROM_L31_MOD)",
+        "MetricName": "l31_latency"
+    },
+    {
+        "BriefDescription": "Fraction of hits on another core's L3 on the same chip per L1 load ref",
+        "MetricExpr": "(PM_DATA_FROM_L31_MOD + PM_DATA_FROM_L31_SHR) / PM_LD_REF_L1",
+        "MetricName": "l3_1_ld_hit_ratio"
+    },
+    {
+        "BriefDescription": "Fraction of hits of a line in the M (exclusive) state on another core's L3 on the same chip per L1 load ref",
+        "MetricExpr": "PM_DATA_FROM_L31_MOD / PM_LD_REF_L1",
+        "MetricName": "l3_1_mod_ld_hit_ratio"
+    },
+    {
+        "BriefDescription": "Fraction of hits of a line in the S state on another core's L3 on the same chip per L1 load ref",
+        "MetricExpr": "PM_DATA_FROM_L31_SHR / PM_LD_REF_L1",
+        "MetricName": "l3_1_shr_ld_hit_ratio"
+    },
+    {
+        "BriefDescription": "Fraction of L3 load hits per load ref where the demand load collided with a pending prefetch",
+        "MetricExpr": "PM_DATA_FROM_L3_DISP_CONFLICT / PM_LD_REF_L1",
+        "MetricName": "l3_conflict_ld_hit_ratio"
+    },
+    {
+        "BriefDescription": "Fraction of L3 load hits per L1 load ref",
+        "MetricExpr": "PM_DATA_FROM_L3 / PM_LD_REF_L1",
+        "MetricName": "l3_ld_hit_ratio"
+    },
+    {
+        "BriefDescription": "Fraction of L3 load misses per L1 load ref",
+        "MetricExpr": "PM_DATA_FROM_L3MISS / PM_LD_REF_L1",
+        "MetricName": "l3_ld_miss_ratio"
+    },
+    {
+        "BriefDescription": "Fraction of L3 load hits per load ref where the L3 did not experience a conflict",
+        "MetricExpr": "PM_DATA_FROM_L3_NO_CONFLICT / PM_LD_REF_L1",
+        "MetricName": "l3_no_conflict_ld_hit_ratio"
+    },
+    {
+        "BriefDescription": "Fraction of L3 hits on lines that were not in the MEPF state per L1 load ref",
+        "MetricExpr": "(PM_DATA_FROM_L3 - PM_DATA_FROM_L3_MEPF) / PM_LD_REF_L1",
+        "MetricName": "l3other_ld_hit_ratio"
+    },
+    {
+        "BriefDescription": "Fraction of L3 hits on lines that were recently prefetched into the L3 (MEPF state) per L1 load ref",
+        "MetricExpr": "PM_DATA_FROM_L3_MEPF / PM_LD_REF_L1",
+        "MetricName": "l3pref_ld_hit_ratio"
+    },
+    {
+        "BriefDescription": "Fraction of hits on a local Centaur's cache per L1 load ref",
+        "MetricExpr": "PM_DATA_FROM_LL4 / PM_LD_REF_L1",
+        "MetricName": "ll4_ld_hit_ratio"
+    },
+    {
+        "BriefDescription": "Fraction of hits on a local Centaur's DRAM per L1 load ref",
+        "MetricExpr": "PM_DATA_FROM_LMEM / PM_LD_REF_L1",
+        "MetricName": "lmem_ld_hit_ratio"
+    },
+    {
+        "BriefDescription": "Fraction of hits on a local Centaur (L4 or DRAM) per L1 load ref",
+        "MetricExpr": "(PM_DATA_FROM_LMEM + PM_DATA_FROM_LL4) / PM_LD_REF_L1",
+        "MetricName": "local_centaur_ld_hit_ratio"
+    },
+    {
+        "BriefDescription": "Cycles stalled by Other LSU Operations",
+        "MetricExpr": "(PM_CMPLU_STALL_LSU - PM_CMPLU_STALL_REJECT - PM_CMPLU_STALL_DCACHE_MISS - PM_CMPLU_STALL_STORE) / (PM_LD_REF_L1 - PM_LD_MISS_L1)",
+        "MetricName": "lsu_stall_avg_cyc_per_l1hit_stfw"
+    },
+    {
+        "BriefDescription": "Fraction of hits on another core's L2 or L3 on a different chip (remote or distant) per L1 load ref",
+        "MetricExpr": "PM_DATA_FROM_OFF_CHIP_CACHE / PM_LD_REF_L1",
+        "MetricName": "off_chip_cache_ld_hit_ratio"
+    },
+    {
+        "BriefDescription": "Fraction of hits on another core's L2 or L3 on the same chip per L1 load ref",
+        "MetricExpr": "PM_DATA_FROM_ON_CHIP_CACHE / PM_LD_REF_L1",
+        "MetricName": "on_chip_cache_ld_hit_ratio"
+    },
+    {
+        "BriefDescription": "Fraction of hits on a remote chip's Centaur (L4 or DRAM) per L1 load ref",
+        "MetricExpr": "(PM_DATA_FROM_RMEM + PM_DATA_FROM_RL4) / PM_LD_REF_L1",
+        "MetricName": "remote_centaur_ld_hit_ratio"
+    },
+    {
+        "BriefDescription": "Percent of all FXU/VSU instructions that got rejected because of unavailable resources or facilities",
+        "MetricExpr": "PM_ISU_REJECT_RES_NA *100/ PM_RUN_INST_CMPL",
+        "MetricName": "resource_na_reject_rate_percent"
+    },
+    {
+        "BriefDescription": "Fraction of hits of a line in the M (exclusive) state on the L2 or L3 of a core on a remote chip per L1 load ref",
+        "MetricExpr": "PM_DATA_FROM_RL2L3_MOD / PM_LD_REF_L1",
+        "MetricName": "rl2l3_mod_ld_hit_ratio"
+    },
+    {
+        "BriefDescription": "Fraction of hits of a line in the S state on the L2 or L3 of a core on a remote chip per L1 load ref",
+        "MetricExpr": "PM_DATA_FROM_RL2L3_SHR / PM_LD_REF_L1",
+        "MetricName": "rl2l3_shr_ld_hit_ratio"
+    },
+    {
+        "BriefDescription": "Fraction of hits on a remote Centaur's cache per L1 load ref",
+        "MetricExpr": "PM_DATA_FROM_RL4 / PM_LD_REF_L1",
+        "MetricName": "rl4_ld_hit_ratio"
+    },
+    {
+        "BriefDescription": "Fraction of hits on a remote Centaur's DRAM per L1 load ref",
+        "MetricExpr": "PM_DATA_FROM_RMEM / PM_LD_REF_L1",
+        "MetricName": "rmem_ld_hit_ratio"
+    },
+    {
+        "BriefDescription": "Percent of all FXU/VSU instructions that got rejected due to SAR Bypass",
+        "MetricExpr": "PM_ISU_REJECT_SAR_BYPASS *100/ PM_RUN_INST_CMPL",
+        "MetricName": "sar_bypass_reject_rate_percent"
+    },
+    {
+        "BriefDescription": "Percent of all FXU/VSU instructions that got rejected because of unavailable sources",
+        "MetricExpr": "PM_ISU_REJECT_SRC_NA *100/ PM_RUN_INST_CMPL",
+        "MetricName": "source_na_reject_rate_percent"
+    },
+    {
+        "BriefDescription": "Store forward rate",
+        "MetricExpr": "100 * (PM_LSU0_SRQ_STFWD + PM_LSU1_SRQ_STFWD) / PM_RUN_INST_CMPL",
+        "MetricName": "store_forward_rate_percent"
+    },
+    {
+        "BriefDescription": "Store forward rate",
+        "MetricExpr": "100 * (PM_LSU0_SRQ_STFWD + PM_LSU1_SRQ_STFWD) / (PM_LD_REF_L1 - PM_LD_MISS_L1)",
+        "MetricName": "store_forward_ratio_percent"
+    },
+    {
+        "BriefDescription": "Marked store latency, from core completion to L2 RC machine completion",
+        "MetricExpr": "(PM_MRK_ST_L2DISP_TO_CMPL_CYC + PM_MRK_ST_DRAIN_TO_L2DISP_CYC) / PM_MRK_ST_NEST",
+        "MetricName": "store_latency"
+    },
+    {
+        "BriefDescription": "Cycles stalled by any sync",
+        "MetricExpr": "(PM_CMPLU_STALL_LWSYNC + PM_CMPLU_STALL_HWSYNC)  / PM_RUN_INST_CMPL",
+        "MetricName": "sync_stall_cpi"
+    },
+    {
+        "BriefDescription": "Percentage of lines that were prefetched into the L3 and evicted before they were consumed",
+        "MetricExpr": "(PM_L3_CO_MEPF / 2) / PM_L3_PREF_ALL * 100",
+        "MetricName": "wasted_l3_prefetch_percent"
     }
 ]
-- 
2.17.1

