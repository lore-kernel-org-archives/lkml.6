Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2BDFC282C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A9EC2083B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:53:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbfBGRxg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 12:53:36 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45896 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726985AbfBGRxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 12:53:22 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x17HmIqq066348
        for <linux-kernel@vger.kernel.org>; Thu, 7 Feb 2019 12:53:21 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qgr6n46hc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 12:53:21 -0500
Received: from localhost
        by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pc@us.ibm.com>;
        Thu, 7 Feb 2019 17:53:20 -0000
Received: from b03cxnp08028.gho.boulder.ibm.com (9.17.130.20)
        by e33.co.us.ibm.com (192.168.1.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 7 Feb 2019 17:53:17 -0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x17HrGng30081244
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Feb 2019 17:53:17 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C4D8AC6062;
        Thu,  7 Feb 2019 17:53:16 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9317AC605F;
        Thu,  7 Feb 2019 17:53:16 +0000 (GMT)
Received: from localhost (unknown [9.114.15.222])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu,  7 Feb 2019 17:53:16 +0000 (GMT)
From:   Paul Clarke <pc@us.ibm.com>
To:     linux-perf-users@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, ananth@linux.vnet.ibm.com,
        maddy@linux.vnet.ibm.com, naveen.n.rao@linux.vnet.ibm.com,
        sukadev@linux.ibm.com, mpe@ellerman.id.au, cel@us.ibm.com
Subject: [PATCH v2 3/4] [powerpc] perf vendor events: Add JSON metrics for POWER8
Date:   Thu,  7 Feb 2019 12:53:13 -0500
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190207175314.31813-1-pc@us.ibm.com>
References: <20190207175314.31813-1-pc@us.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19020717-0036-0000-0000-00000A86F09D
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010555; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000279; SDB=6.01157696; UDB=6.00604001; IPR=6.00938227;
 MB=3.00025481; MTD=3.00000008; XFM=3.00000015; UTC=2019-02-07 17:53:19
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19020717-0037-0000-0000-00004AA2D80F
Message-Id: <20190207175314.31813-4-pc@us.ibm.com>
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
- branch_prediction
- latency
- bus_stats
- instruction_mix
- instruction_stats_percent_per_ref

Signed-off-by: Paul A. Clarke <pc@us.ibm.com>
---
 .../arch/powerpc/power8/metrics.json          | 492 ++++++++++++++++++
 1 file changed, 492 insertions(+)

diff --git a/tools/perf/pmu-events/arch/powerpc/power8/metrics.json b/tools/perf/pmu-events/arch/powerpc/power8/metrics.json
index 9a6ec8aadffd..d8b710e12377 100644
--- a/tools/perf/pmu-events/arch/powerpc/power8/metrics.json
+++ b/tools/perf/pmu-events/arch/powerpc/power8/metrics.json
@@ -1,4 +1,100 @@
 [
+    {
+        "BriefDescription": "% of finished branches that were treated as BC+8",
+        "MetricExpr": "PM_BR_BC_8_CONV / PM_BRU_FIN * 100",
+        "MetricGroup": "branch_prediction",
+        "MetricName": "bc_8_branch_ratio_percent"
+    },
+    {
+        "BriefDescription": "% of finished branches that were pairable but not treated as BC+8",
+        "MetricExpr": "PM_BR_BC_8 / PM_BRU_FIN * 100",
+        "MetricGroup": "branch_prediction",
+        "MetricName": "bc_8_not_converted_branch_ratio_percent"
+    },
+    {
+        "BriefDescription": "Percent of mispredicted branches out of all predicted (correctly and incorrectly) branches that completed",
+        "MetricExpr": "PM_BR_MPRED_CMPL / (PM_BR_PRED_BR0 + PM_BR_PRED_BR1) * 100",
+        "MetricGroup": "branch_prediction",
+        "MetricName": "br_misprediction_percent"
+    },
+    {
+        "BriefDescription": "% of Branch miss predictions per instruction",
+        "MetricExpr": "PM_BR_MPRED_CMPL / PM_RUN_INST_CMPL * 100",
+        "MetricGroup": "branch_prediction",
+        "MetricName": "branch_mispredict_rate_percent"
+    },
+    {
+        "BriefDescription": "Count cache branch misprediction per instruction",
+        "MetricExpr": "PM_BR_MPRED_CCACHE / PM_RUN_INST_CMPL * 100",
+        "MetricGroup": "branch_prediction",
+        "MetricName": "ccache_mispredict_rate_percent"
+    },
+    {
+        "BriefDescription": "Percent of count catch mispredictions out of all completed branches that required count cache predictionn",
+        "MetricExpr": "PM_BR_MPRED_CCACHE / (PM_BR_PRED_CCACHE_BR0 + PM_BR_PRED_CCACHE_BR1) * 100",
+        "MetricGroup": "branch_prediction",
+        "MetricName": "ccache_misprediction_percent"
+    },
+    {
+        "BriefDescription": "CR MisPredictions per Instruction",
+        "MetricExpr": "PM_BR_MPRED_CR / PM_RUN_INST_CMPL * 100",
+        "MetricGroup": "branch_prediction",
+        "MetricName": "cr_mispredict_rate_percent"
+    },
+    {
+        "BriefDescription": "Link stack branch misprediction",
+        "MetricExpr": "(PM_BR_MPRED_TA - PM_BR_MPRED_CCACHE) / PM_RUN_INST_CMPL * 100",
+        "MetricGroup": "branch_prediction",
+        "MetricName": "lstack_mispredict_rate_percent"
+    },
+    {
+        "BriefDescription": "Percent of link stack mispredictions out of all completed branches that required link stack prediction",
+        "MetricExpr": "(PM_BR_MPRED_TA - PM_BR_MPRED_CCACHE) / (PM_BR_PRED_LSTACK_BR0 + PM_BR_PRED_LSTACK_BR1) * 100",
+        "MetricGroup": "branch_prediction",
+        "MetricName": "lstack_misprediction_percent"
+    },
+    {
+        "BriefDescription": "TA MisPredictions per Instruction",
+        "MetricExpr": "PM_BR_MPRED_TA / PM_RUN_INST_CMPL * 100",
+        "MetricGroup": "branch_prediction",
+        "MetricName": "ta_mispredict_rate_percent"
+    },
+    {
+        "BriefDescription": "Percent of target address mispredictions out of all completed branches that required address prediction",
+        "MetricExpr": "PM_BR_MPRED_TA / (PM_BR_PRED_CCACHE_BR0 + PM_BR_PRED_CCACHE_BR1 + PM_BR_PRED_LSTACK_BR0 + PM_BR_PRED_LSTACK_BR1) * 100",
+        "MetricGroup": "branch_prediction",
+        "MetricName": "ta_misprediction_percent"
+    },
+    {
+        "BriefDescription": "Percent of branches completed that were taken",
+        "MetricExpr": "PM_BR_TAKEN_CMPL * 100 / PM_BR_CMPL",
+        "MetricGroup": "branch_prediction",
+        "MetricName": "taken_branches_percent"
+    },
+    {
+        "BriefDescription": "Percent of chip+group+sys pumps that were incorrectly predicted",
+        "MetricExpr": "PM_PUMP_MPRED * 100 / (PM_PUMP_CPRED + PM_PUMP_MPRED)",
+        "MetricGroup": "bus_stats",
+        "MetricName": "any_pump_mpred_percent"
+    },
+    {
+        "BriefDescription": "Percent of chip pumps that were correctly predicted as chip pumps the first time",
+        "MetricExpr": "PM_CHIP_PUMP_CPRED * 100 / PM_L2_CHIP_PUMP",
+        "MetricGroup": "bus_stats",
+        "MetricName": "chip_pump_cpred_percent"
+    },
+    {
+        "BriefDescription": "Percent of group pumps that were correctly predicted as group pumps the first time",
+        "MetricExpr": "PM_GRP_PUMP_CPRED * 100 / PM_L2_GROUP_PUMP",
+        "MetricGroup": "bus_stats",
+        "MetricName": "group_pump_cpred_percent"
+    },
+    {
+        "BriefDescription": "Percent of system pumps that were correctly predicted as group pumps the first time",
+        "MetricExpr": "PM_SYS_PUMP_CPRED * 100 / PM_L2_GROUP_PUMP",
+        "MetricGroup": "bus_stats",
+        "MetricName": "sys_pump_cpred_percent"
+    },
     {
         "BriefDescription": "Cycles stalled due to CRU or BRU operations",
         "MetricExpr": "PM_CMPLU_STALL_BRU_CRU / PM_RUN_INST_CMPL",
@@ -842,6 +938,180 @@
         "MetricGroup": "instruction_misses_percent_per_inst",
         "MetricName": "l1_inst_miss_rate_percent"
     },
+    {
+        "BriefDescription": "% Branches per instruction",
+        "MetricExpr": "PM_BRU_FIN / PM_RUN_INST_CMPL",
+        "MetricGroup": "instruction_mix",
+        "MetricName": "branches_per_inst"
+    },
+    {
+        "BriefDescription": "Total Fixed point operations",
+        "MetricExpr": "(PM_FXU0_FIN + PM_FXU1_FIN)/PM_RUN_INST_CMPL",
+        "MetricGroup": "instruction_mix",
+        "MetricName": "fixed_per_inst"
+    },
+    {
+        "BriefDescription": "FXU0 balance",
+        "MetricExpr": "PM_FXU0_FIN / (PM_FXU0_FIN + PM_FXU1_FIN)",
+        "MetricGroup": "instruction_mix",
+        "MetricName": "fxu0_balance"
+    },
+    {
+        "BriefDescription": "Fraction of cycles that FXU0 is in use",
+        "MetricExpr": "PM_FXU0_FIN / PM_RUN_CYC",
+        "MetricGroup": "instruction_mix",
+        "MetricName": "fxu0_fin"
+    },
+    {
+        "BriefDescription": "FXU0 only Busy",
+        "MetricExpr": "PM_FXU0_BUSY_FXU1_IDLE / PM_CYC",
+        "MetricGroup": "instruction_mix",
+        "MetricName": "fxu0_only_busy"
+    },
+    {
+        "BriefDescription": "Fraction of cycles that FXU1 is in use",
+        "MetricExpr": "PM_FXU1_FIN / PM_RUN_CYC",
+        "MetricGroup": "instruction_mix",
+        "MetricName": "fxu1_fin"
+    },
+    {
+        "BriefDescription": "FXU1 only Busy",
+        "MetricExpr": "PM_FXU1_BUSY_FXU0_IDLE / PM_CYC",
+        "MetricGroup": "instruction_mix",
+        "MetricName": "fxu1_only_busy"
+    },
+    {
+        "BriefDescription": "Both FXU Busy",
+        "MetricExpr": "PM_FXU_BUSY / PM_CYC",
+        "MetricGroup": "instruction_mix",
+        "MetricName": "fxu_both_busy"
+    },
+    {
+        "BriefDescription": "Both FXU Idle",
+        "MetricExpr": "PM_FXU_IDLE / PM_CYC",
+        "MetricGroup": "instruction_mix",
+        "MetricName": "fxu_both_idle"
+    },
+    {
+        "BriefDescription": "PCT instruction loads",
+        "MetricExpr": "PM_LD_REF_L1 / PM_RUN_INST_CMPL",
+        "MetricGroup": "instruction_mix",
+        "MetricName": "loads_per_inst"
+    },
+    {
+        "BriefDescription": "PCT instruction stores",
+        "MetricExpr": "PM_ST_FIN  / PM_RUN_INST_CMPL",
+        "MetricGroup": "instruction_mix",
+        "MetricName": "stores_per_inst"
+    },
+    {
+        "BriefDescription": "Icache Fetchs per Icache Miss",
+        "MetricExpr": "(PM_L1_ICACHE_MISS - PM_IC_PREF_WRITE) / PM_L1_ICACHE_MISS",
+        "MetricGroup": "instruction_stats_percent_per_ref",
+        "MetricName": "icache_miss_reload"
+    },
+    {
+        "BriefDescription": "% of ICache reloads due to prefetch",
+        "MetricExpr": "PM_IC_PREF_WRITE * 100 / PM_L1_ICACHE_MISS",
+        "MetricGroup": "instruction_stats_percent_per_ref",
+        "MetricName": "icache_pref_percent"
+    },
+    {
+        "BriefDescription": "% of ICache reloads from Distant L2 or L3 (Modified)",
+        "MetricExpr": "PM_INST_FROM_DL2L3_MOD * 100 / PM_L1_ICACHE_MISS",
+        "MetricGroup": "instruction_stats_percent_per_ref",
+        "MetricName": "inst_from_dl2l3_mod_percent"
+    },
+    {
+        "BriefDescription": "% of ICache reloads from Distant L2 or L3 (Shared)",
+        "MetricExpr": "PM_INST_FROM_DL2L3_SHR * 100 / PM_L1_ICACHE_MISS",
+        "MetricGroup": "instruction_stats_percent_per_ref",
+        "MetricName": "inst_from_dl2l3_shr_percent"
+    },
+    {
+        "BriefDescription": "% of ICache reloads from Distant L4",
+        "MetricExpr": "PM_INST_FROM_DL4 * 100 / PM_L1_ICACHE_MISS",
+        "MetricGroup": "instruction_stats_percent_per_ref",
+        "MetricName": "inst_from_dl4_percent"
+    },
+    {
+        "BriefDescription": "% of ICache reloads from Distant Memory",
+        "MetricExpr": "PM_INST_FROM_DMEM * 100 / PM_L1_ICACHE_MISS",
+        "MetricGroup": "instruction_stats_percent_per_ref",
+        "MetricName": "inst_from_dmem_percent"
+    },
+    {
+        "BriefDescription": "% of ICache reloads from Private L2, other core",
+        "MetricExpr": "PM_INST_FROM_L21_MOD * 100 / PM_L1_ICACHE_MISS",
+        "MetricGroup": "instruction_stats_percent_per_ref",
+        "MetricName": "inst_from_l21_mod_percent"
+    },
+    {
+        "BriefDescription": "% of ICache reloads from Private L2, other core",
+        "MetricExpr": "PM_INST_FROM_L21_SHR * 100 / PM_L1_ICACHE_MISS",
+        "MetricGroup": "instruction_stats_percent_per_ref",
+        "MetricName": "inst_from_l21_shr_percent"
+    },
+    {
+        "BriefDescription": "% of ICache reloads from L2",
+        "MetricExpr": "PM_INST_FROM_L2 * 100 / PM_L1_ICACHE_MISS",
+        "MetricGroup": "instruction_stats_percent_per_ref",
+        "MetricName": "inst_from_l2_percent"
+    },
+    {
+        "BriefDescription": "% of ICache reloads from Private L3, other core",
+        "MetricExpr": "PM_INST_FROM_L31_MOD * 100 / PM_L1_ICACHE_MISS",
+        "MetricGroup": "instruction_stats_percent_per_ref",
+        "MetricName": "inst_from_l31_mod_percent"
+    },
+    {
+        "BriefDescription": "% of ICache reloads from Private L3, other core",
+        "MetricExpr": "PM_INST_FROM_L31_SHR * 100 / PM_L1_ICACHE_MISS",
+        "MetricGroup": "instruction_stats_percent_per_ref",
+        "MetricName": "inst_from_l31_shr_percent"
+    },
+    {
+        "BriefDescription": "% of ICache reloads from L3",
+        "MetricExpr": "PM_INST_FROM_L3 * 100 / PM_L1_ICACHE_MISS",
+        "MetricGroup": "instruction_stats_percent_per_ref",
+        "MetricName": "inst_from_l3_percent"
+    },
+    {
+        "BriefDescription": "% of ICache reloads from Local L4",
+        "MetricExpr": "PM_INST_FROM_LL4 * 100 / PM_L1_ICACHE_MISS",
+        "MetricGroup": "instruction_stats_percent_per_ref",
+        "MetricName": "inst_from_ll4_percent"
+    },
+    {
+        "BriefDescription": "% of ICache reloads from Local Memory",
+        "MetricExpr": "PM_INST_FROM_LMEM * 100 / PM_L1_ICACHE_MISS",
+        "MetricGroup": "instruction_stats_percent_per_ref",
+        "MetricName": "inst_from_lmem_percent"
+    },
+    {
+        "BriefDescription": "% of ICache reloads from Remote L2 or L3 (Modified)",
+        "MetricExpr": "PM_INST_FROM_RL2L3_MOD * 100 / PM_L1_ICACHE_MISS",
+        "MetricGroup": "instruction_stats_percent_per_ref",
+        "MetricName": "inst_from_rl2l3_mod_percent"
+    },
+    {
+        "BriefDescription": "% of ICache reloads from Remote L2 or L3 (Shared)",
+        "MetricExpr": "PM_INST_FROM_RL2L3_SHR * 100 / PM_L1_ICACHE_MISS",
+        "MetricGroup": "instruction_stats_percent_per_ref",
+        "MetricName": "inst_from_rl2l3_shr_percent"
+    },
+    {
+        "BriefDescription": "% of ICache reloads from Remote L4",
+        "MetricExpr": "PM_INST_FROM_RL4 * 100 / PM_L1_ICACHE_MISS",
+        "MetricGroup": "instruction_stats_percent_per_ref",
+        "MetricName": "inst_from_rl4_percent"
+    },
+    {
+        "BriefDescription": "% of ICache reloads from Remote Memory",
+        "MetricExpr": "PM_INST_FROM_RMEM * 100 / PM_L1_ICACHE_MISS",
+        "MetricGroup": "instruction_stats_percent_per_ref",
+        "MetricName": "inst_from_rmem_percent"
+    },
     {
         "BriefDescription": "Average number of stores that gather in the store buffer before being sent to an L2 RC machine",
         "MetricExpr": "PM_ST_CMPL / (PM_L2_ST / 2)",
@@ -860,6 +1130,228 @@
         "MetricGroup": "l2_stats",
         "MetricName": "l2_store_miss_ratio_percent"
     },
+    {
+        "BriefDescription": "average L1 miss latency using marked events",
+        "MetricExpr": "PM_MRK_LD_MISS_L1_CYC  /  PM_MRK_LD_MISS_L1",
+        "MetricGroup": "latency",
+        "MetricName": "average_dl1miss_latency"
+    },
+    {
+        "BriefDescription": "Average icache miss latency",
+        "MetricExpr": "(PM_IC_DEMAND_CYC /  PM_IC_DEMAND_REQ)",
+        "MetricGroup": "latency",
+        "MetricName": "average_il1_miss_latency"
+    },
+    {
+        "BriefDescription": "average service time for SYNC",
+        "MetricExpr": "PM_LSU_SRQ_SYNC_CYC / PM_LSU_SRQ_SYNC",
+        "MetricGroup": "latency",
+        "MetricName": "average_sync_cyc"
+    },
+    {
+        "BriefDescription": "Cycles LMQ slot0 was active on an average",
+        "MetricExpr": "PM_LSU_LMQ_S0_VALID  / PM_LSU_LMQ_S0_ALLOC",
+        "MetricGroup": "latency",
+        "MetricName": "avg_lmq_life_time"
+    },
+    {
+        "BriefDescription": "Average number of cycles LRQ stays active for one load.  Slot 0 is VALID ONLY FOR EVEN THREADS",
+        "MetricExpr": "PM_LSU_LRQ_S0_VALID  / PM_LSU_LRQ_S0_ALLOC",
+        "MetricGroup": "latency",
+        "MetricName": "avg_lrq_life_time_even"
+    },
+    {
+        "BriefDescription": "Average number of cycles LRQ stays active for one load.  Slot 43 is valid ONLY FOR ODD THREADS",
+        "MetricExpr": "PM_LSU_LRQ_S43_VALID  / PM_LSU_LRQ_S43_ALLOC",
+        "MetricGroup": "latency",
+        "MetricName": "avg_lrq_life_time_odd"
+    },
+    {
+        "BriefDescription": "Average number of cycles SRQ stays active for one load.  Slot 0 is VALID ONLY FOR EVEN THREADS",
+        "MetricExpr": "PM_LSU_SRQ_S0_VALID  / PM_LSU_SRQ_S0_ALLOC",
+        "MetricGroup": "latency",
+        "MetricName": "avg_srq_life_time_even"
+    },
+    {
+        "BriefDescription": "Average number of cycles SRQ stays active for one load.  Slot 39 is valid ONLY FOR ODD THREADS",
+        "MetricExpr": "PM_LSU_SRQ_S39_VALID  / PM_LSU_SRQ_S39_ALLOC",
+        "MetricGroup": "latency",
+        "MetricName": "avg_srq_life_time_odd"
+    },
+    {
+        "BriefDescription": "Marked background kill latency, measured in L2",
+        "MetricExpr": "PM_MRK_FAB_RSP_BKILL_CYC / PM_MRK_FAB_RSP_BKILL",
+        "MetricGroup": "latency",
+        "MetricName": "bkill_latency"
+    },
+    {
+        "BriefDescription": "Marked dclaim latency, measured in L2",
+        "MetricExpr": "PM_MRK_FAB_RSP_DCLAIM_CYC / PM_MRK_FAB_RSP_DCLAIM",
+        "MetricGroup": "latency",
+        "MetricName": "dclaim_latency"
+    },
+    {
+        "BriefDescription": "Marked L2L3 remote Load latency",
+        "MetricExpr": "PM_MRK_DATA_FROM_DL2L3_MOD_CYC/ PM_MRK_DATA_FROM_DL2L3_MOD",
+        "MetricGroup": "latency",
+        "MetricName": "dl2l3_mod_latency"
+    },
+    {
+        "BriefDescription": "Marked L2L3 distant Load latency",
+        "MetricExpr": "PM_MRK_DATA_FROM_DL2L3_SHR_CYC/ PM_MRK_DATA_FROM_DL2L3_SHR",
+        "MetricGroup": "latency",
+        "MetricName": "dl2l3_shr_latency"
+    },
+    {
+        "BriefDescription": "Distant L4 average load latency",
+        "MetricExpr": "PM_MRK_DATA_FROM_DL4_CYC/ PM_MRK_DATA_FROM_DL4",
+        "MetricGroup": "latency",
+        "MetricName": "dl4_latency"
+    },
+    {
+        "BriefDescription": "Marked Dmem Load latency",
+        "MetricExpr": "PM_MRK_DATA_FROM_DMEM_CYC/ PM_MRK_DATA_FROM_DMEM",
+        "MetricGroup": "latency",
+        "MetricName": "dmem_latency"
+    },
+    {
+        "BriefDescription": "estimated exposed miss latency for dL1 misses, ie load miss when we were NTC",
+        "MetricExpr": "PM_MRK_LD_MISS_EXPOSED_CYC  /  PM_MRK_LD_MISS_EXPOSED",
+        "MetricGroup": "latency",
+        "MetricName": "exposed_dl1miss_latency"
+    },
+    {
+        "BriefDescription": "Average load latency for all marked demand loads that came from L2.1 in the M state",
+        "MetricExpr": "PM_MRK_DATA_FROM_L21_MOD_CYC/ PM_MRK_DATA_FROM_L21_MOD",
+        "MetricGroup": "latency",
+        "MetricName": "l21_mod_latency"
+    },
+    {
+        "BriefDescription": "Average load latency for all marked demand loads that came from L2.1 in the S state",
+        "MetricExpr": "PM_MRK_DATA_FROM_L21_SHR_CYC/ PM_MRK_DATA_FROM_L21_SHR",
+        "MetricGroup": "latency",
+        "MetricName": "l21_shr_latency"
+    },
+    {
+        "BriefDescription": "Average load latency for all marked demand loads that came from the L2 and suffered a conflict at RC machine dispatch time due to load-hit-store",
+        "MetricExpr": "PM_MRK_DATA_FROM_L2_DISP_CONFLICT_LDHITST_CYC/ PM_MRK_DATA_FROM_L2_DISP_CONFLICT_LDHITST",
+        "MetricGroup": "latency",
+        "MetricName": "l2_disp_conflict_ldhitst_latency"
+    },
+    {
+        "BriefDescription": "Average load latency for all marked demand loads that came from the L2 and suffered a conflict at RC machine dispatch time NOT due load-hit-store",
+        "MetricExpr": "PM_MRK_DATA_FROM_L2_DISP_CONFLICT_OTHER_CYC/ PM_MRK_DATA_FROM_L2_DISP_CONFLICT_OTHER",
+        "MetricGroup": "latency",
+        "MetricName": "l2_disp_conflict_other_latency"
+    },
+    {
+        "BriefDescription": "Average load latency for all marked demand loads that came from the L2",
+        "MetricExpr": "PM_MRK_DATA_FROM_L2_CYC/ PM_MRK_DATA_FROM_L2",
+        "MetricGroup": "latency",
+        "MetricName": "l2_latency"
+    },
+    {
+        "BriefDescription": "Average load latency for all marked demand loads that were satisfied by lines prefetched into the L3.  This information is forwarded from the L3",
+        "MetricExpr": "PM_MRK_DATA_FROM_L2_MEPF_CYC/ PM_MRK_DATA_FROM_L2",
+        "MetricGroup": "latency",
+        "MetricName": "l2_mepf_latency"
+    },
+    {
+        "BriefDescription": "Average load latency for all marked demand loads that came from the L2 and suffered no conflicts",
+        "MetricExpr": "PM_MRK_DATA_FROM_L2_NO_CONFLICT_CYC/ PM_MRK_DATA_FROM_L2",
+        "MetricGroup": "latency",
+        "MetricName": "l2_no_conflict_latency"
+    },
+    {
+        "BriefDescription": "Average load latency for all marked demand loads that came from the L3 and beyond",
+        "MetricExpr": "PM_MRK_DATA_FROM_L2MISS_CYC/ PM_MRK_DATA_FROM_L2MISS",
+        "MetricGroup": "latency",
+        "MetricName": "l2miss_latency"
+    },
+    {
+        "BriefDescription": "Marked L31 Load latency",
+        "MetricExpr": "PM_MRK_DATA_FROM_L31_MOD_CYC/ PM_MRK_DATA_FROM_L31_MOD",
+        "MetricGroup": "latency",
+        "MetricName": "l31_mod_latency"
+    },
+    {
+        "BriefDescription": "Marked L31 Load latency",
+        "MetricExpr": "PM_MRK_DATA_FROM_L31_SHR_CYC/ PM_MRK_DATA_FROM_L31_SHR",
+        "MetricGroup": "latency",
+        "MetricName": "l31_shr_latency"
+    },
+    {
+        "BriefDescription": "Average load latency for all marked demand loads that came from the L3",
+        "MetricExpr": "PM_MRK_DATA_FROM_L3_CYC/ PM_MRK_DATA_FROM_L3",
+        "MetricGroup": "latency",
+        "MetricName": "l3_latency"
+    },
+    {
+        "BriefDescription": "Average load latency for all marked demand loads that came from the L3 and suffered no conflicts",
+        "MetricExpr": "PM_MRK_DATA_FROM_L3_NO_CONFLICT_CYC/ PM_MRK_DATA_FROM_L2",
+        "MetricGroup": "latency",
+        "MetricName": "l3_no_conflict_latency"
+    },
+    {
+        "BriefDescription": "Average load latency for all marked demand loads that come from beyond the L3",
+        "MetricExpr": "PM_MRK_DATA_FROM_L3MISS_CYC/ PM_MRK_DATA_FROM_L3MISS",
+        "MetricGroup": "latency",
+        "MetricName": "l3miss_latency"
+    },
+    {
+        "BriefDescription": "Average latency for marked reloads that hit in the L3 on the MEPF state.  i.e. lines that were prefetched into the L3",
+        "MetricExpr": "PM_MRK_DATA_FROM_L3_MEPF_CYC/ PM_MRK_DATA_FROM_L3_MEPF",
+        "MetricGroup": "latency",
+        "MetricName": "l3pref_latency"
+    },
+    {
+        "BriefDescription": "Local L4 average load latency",
+        "MetricExpr": "PM_MRK_DATA_FROM_LL4_CYC/ PM_MRK_DATA_FROM_LL4",
+        "MetricGroup": "latency",
+        "MetricName": "ll4_latency"
+    },
+    {
+        "BriefDescription": "Marked Lmem Load latency",
+        "MetricExpr": "PM_MRK_DATA_FROM_LMEM_CYC/ PM_MRK_DATA_FROM_LMEM",
+        "MetricGroup": "latency",
+        "MetricName": "lmem_latency"
+    },
+    {
+        "BriefDescription": "Latency for marked reloads that hit in the L2 or L3 of any other core on a different chip",
+        "MetricExpr": "PM_MRK_DATA_FROM_OFF_CHIP_CACHE_CYC/ PM_MRK_DATA_FROM_OFF_CHIP_CACHE",
+        "MetricGroup": "latency",
+        "MetricName": "off_chip_cache_latency"
+    },
+    {
+        "BriefDescription": "Latency for marked reloads that hit in the L2 or L3 of any other core on the same chip",
+        "MetricExpr": "PM_MRK_DATA_FROM_ON_CHIP_CACHE_CYC/ PM_MRK_DATA_FROM_ON_CHIP_CACHE",
+        "MetricGroup": "latency",
+        "MetricName": "on_chip_cache_latency"
+    },
+    {
+        "BriefDescription": "Marked L2L3 remote Load latency",
+        "MetricExpr": "PM_MRK_DATA_FROM_RL2L3_MOD_CYC/ PM_MRK_DATA_FROM_RL2L3_MOD",
+        "MetricGroup": "latency",
+        "MetricName": "rl2l3_mod_latency"
+    },
+    {
+        "BriefDescription": "Marked L2L3 remote Load latency",
+        "MetricExpr": "PM_MRK_DATA_FROM_RL2L3_SHR_CYC/ PM_MRK_DATA_FROM_RL2L3_SHR",
+        "MetricGroup": "latency",
+        "MetricName": "rl2l3_shr_latency"
+    },
+    {
+        "BriefDescription": "Remote L4 average load latency",
+        "MetricExpr": "PM_MRK_DATA_FROM_RL4_CYC/ PM_MRK_DATA_FROM_RL4",
+        "MetricGroup": "latency",
+        "MetricName": "rl4_latency"
+    },
+    {
+        "BriefDescription": "Marked Rmem Load latency",
+        "MetricExpr": "PM_MRK_DATA_FROM_RMEM_CYC/ PM_MRK_DATA_FROM_RMEM",
+        "MetricGroup": "latency",
+        "MetricName": "rmem_latency"
+    },
     {
         "BriefDescription": "ERAT miss reject ratio",
         "MetricExpr": "PM_LSU_REJECT_ERAT_MISS * 100  / PM_RUN_INST_CMPL",
-- 
2.17.1

