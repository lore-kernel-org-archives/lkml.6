Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D86E3C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 902862083B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:53:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbfBGRxZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 12:53:25 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45654 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726650AbfBGRxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 12:53:22 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x17HmLGk066513
        for <linux-kernel@vger.kernel.org>; Thu, 7 Feb 2019 12:53:19 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qgr6n46g7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 12:53:19 -0500
Received: from localhost
        by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pc@us.ibm.com>;
        Thu, 7 Feb 2019 17:53:18 -0000
Received: from b03cxnp08027.gho.boulder.ibm.com (9.17.130.19)
        by e32.co.us.ibm.com (192.168.1.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 7 Feb 2019 17:53:16 -0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x17HrF0E29360336
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Feb 2019 17:53:15 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7AAEFC6067;
        Thu,  7 Feb 2019 17:53:15 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4CFB6C606C;
        Thu,  7 Feb 2019 17:53:15 +0000 (GMT)
Received: from localhost (unknown [9.114.15.222])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu,  7 Feb 2019 17:53:15 +0000 (GMT)
From:   Paul Clarke <pc@us.ibm.com>
To:     linux-perf-users@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, ananth@linux.vnet.ibm.com,
        maddy@linux.vnet.ibm.com, naveen.n.rao@linux.vnet.ibm.com,
        sukadev@linux.ibm.com, mpe@ellerman.id.au, cel@us.ibm.com
Subject: [PATCH v2 1/4] [powerpc] perf vendor events: Add JSON metrics for POWER8
Date:   Thu,  7 Feb 2019 12:53:11 -0500
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190207175314.31813-1-pc@us.ibm.com>
References: <20190207175314.31813-1-pc@us.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19020717-0004-0000-0000-000014DDC93F
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010555; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000279; SDB=6.01157696; UDB=6.00604001; IPR=6.00938227;
 MB=3.00025481; MTD=3.00000008; XFM=3.00000015; UTC=2019-02-07 17:53:18
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19020717-0005-0000-0000-00008A829904
Message-Id: <20190207175314.31813-2-pc@us.ibm.com>
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
- cpi_breakdown
- estimated_dcache_miss_cpi

Signed-off-by: Paul A. Clarke <pc@us.ibm.com>
---
 .../arch/powerpc/power8/metrics.json          | 461 ++++++++++++++++++
 1 file changed, 461 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/powerpc/power8/metrics.json

diff --git a/tools/perf/pmu-events/arch/powerpc/power8/metrics.json b/tools/perf/pmu-events/arch/powerpc/power8/metrics.json
new file mode 100644
index 000000000000..377b76226c08
--- /dev/null
+++ b/tools/perf/pmu-events/arch/powerpc/power8/metrics.json
@@ -0,0 +1,461 @@
+[
+    {
+        "BriefDescription": "Cycles stalled due to CRU or BRU operations",
+        "MetricExpr": "PM_CMPLU_STALL_BRU_CRU / PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "bru_cru_stall_cpi"
+    },
+    {
+        "BriefDescription": "Cycles stalled due to ISU Branch Operations",
+        "MetricExpr": "PM_CMPLU_STALL_BRU / PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "bru_stall_cpi"
+    },
+    {
+        "BriefDescription": "Cycles in which a Group Completed",
+        "MetricExpr": "PM_GRP_CMPL / PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "completion_cpi"
+    },
+    {
+        "BriefDescription": "Cycles stalled by CO queue full",
+        "MetricExpr": "PM_CMPLU_STALL_COQ_FULL / PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "coq_full_stall_cpi"
+    },
+    {
+        "BriefDescription": "Cycles stalled due to CRU Operations",
+        "MetricExpr": "(PM_CMPLU_STALL_BRU_CRU - PM_CMPLU_STALL_BRU) / PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "cru_stall_cpi"
+    },
+    {
+        "BriefDescription": "Cycles stalled by flushes",
+        "MetricExpr": "PM_CMPLU_STALL_FLUSH / PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "flush_stall_cpi"
+    },
+    {
+        "BriefDescription": "Cycles stalled by FXU Multi-Cycle Instructions",
+        "MetricExpr": "PM_CMPLU_STALL_FXLONG / PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "fxu_multi_cyc_cpi"
+    },
+    {
+        "BriefDescription": "Cycles stalled by FXU",
+        "MetricExpr": "PM_CMPLU_STALL_FXU / PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "fxu_stall_cpi"
+    },
+    {
+        "BriefDescription": "Other cycles stalled by FXU",
+        "MetricExpr": "(PM_CMPLU_STALL_FXU / PM_RUN_INST_CMPL) - (PM_CMPLU_STALL_FXLONG / PM_RUN_INST_CMPL)",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "fxu_stall_other_cpi"
+    },
+    {
+        "BriefDescription": "Cycles GCT empty due to Branch Mispredicts",
+        "MetricExpr": "PM_GCT_NOSLOT_BR_MPRED / PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "gct_empty_br_mpred_cpi"
+    },
+    {
+        "BriefDescription": "Cycles GCT empty due to Branch Mispredicts and Icache Misses",
+        "MetricExpr": "PM_GCT_NOSLOT_BR_MPRED_ICMISS / PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "gct_empty_br_mpred_ic_miss_cpi"
+    },
+    {
+        "BriefDescription": "GCT empty cycles",
+        "MetricExpr": "PM_GCT_NOSLOT_CYC / PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "gct_empty_cpi"
+    },
+    {
+        "BriefDescription": "Cycles GCT empty where dispatch was held",
+        "MetricExpr": "(PM_GCT_NOSLOT_DISP_HELD_MAP + PM_GCT_NOSLOT_DISP_HELD_SRQ + PM_GCT_NOSLOT_DISP_HELD_ISSQ + PM_GCT_NOSLOT_DISP_HELD_OTHER) / PM_RUN_INST_CMPL)",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "gct_empty_disp_held_cpi"
+    },
+    {
+        "BriefDescription": "Cycles GCT empty where dispatch was held due to issue queue",
+        "MetricExpr": "PM_GCT_NOSLOT_DISP_HELD_ISSQ / PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "gct_empty_disp_held_issq_cpi"
+    },
+    {
+        "BriefDescription": "Cycles GCT empty where dispatch was held due to maps",
+        "MetricExpr": "PM_GCT_NOSLOT_DISP_HELD_MAP / PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "gct_empty_disp_held_map_cpi"
+    },
+    {
+        "BriefDescription": "Cycles GCT empty where dispatch was held due to syncs and other effects",
+        "MetricExpr": "PM_GCT_NOSLOT_DISP_HELD_OTHER / PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "gct_empty_disp_held_other_cpi"
+    },
+    {
+        "BriefDescription": "Cycles GCT empty where dispatch was held due to SRQ",
+        "MetricExpr": "PM_GCT_NOSLOT_DISP_HELD_SRQ / PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "gct_empty_disp_held_srq_cpi"
+    },
+    {
+        "BriefDescription": "Cycles stalled by GCT empty due to Icache misses",
+        "MetricExpr": "PM_GCT_NOSLOT_IC_MISS  / PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "gct_empty_ic_miss_cpi"
+    },
+    {
+        "BriefDescription": "Cycles stalled by GCT empty due to Icache misses that resolve in the local L2 or L3",
+        "MetricExpr": "(PM_GCT_NOSLOT_IC_MISS - PM_GCT_NOSLOT_IC_L3MISS) / PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "gct_empty_ic_miss_l2l3_cpi"
+    },
+    {
+        "BriefDescription": "Cycles stalled by GCT empty due to Icache misses that resolve off-chip",
+        "MetricExpr": "PM_GCT_NOSLOT_IC_L3MISS / PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "gct_empty_ic_miss_l3miss_cpi"
+    },
+    {
+        "BriefDescription": "Other GCT empty cycles",
+        "MetricExpr": "(PM_GCT_NOSLOT_CYC / PM_RUN_INST_CMPL) - (PM_GCT_NOSLOT_IC_MISS  / PM_RUN_INST_CMPL) - (PM_GCT_NOSLOT_BR_MPRED / PM_RUN_INST_CMPL) - (PM_GCT_NOSLOT_BR_MPRED_ICMISS / PM_RUN_INST_CMPL) - ((PM_GCT_NOSLOT_DISP_HELD_MAP / PM_RUN_INST_CMPL) + (PM_GCT_NOSLOT_DISP_HELD_SRQ / PM_RUN_INST_CMPL) + (PM_GCT_NOSLOT_DISP_HELD_ISSQ / PM_RUN_INST_CMPL) + (PM_GCT_NOSLOT_DISP_HELD_OTHER / PM_RUN_INST_CMPL))",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "gct_empty_other_cpi"
+    },
+    {
+        "BriefDescription": "Cycles stalled by heavyweight syncs",
+        "MetricExpr": "PM_CMPLU_STALL_HWSYNC  / PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "hwsync_stall_cpi"
+    },
+    {
+        "BriefDescription": "Cycles stalled by LSU",
+        "MetricExpr": "PM_CMPLU_STALL_LSU / PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "lsu_stall_cpi"
+    },
+    {
+        "BriefDescription": "Cycles stalled by D-Cache Misses",
+        "MetricExpr": "PM_CMPLU_STALL_DCACHE_MISS / PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "lsu_stall_dcache_miss_cpi"
+    },
+    {
+        "BriefDescription": "Cycles stalled by D-Cache Misses that resolved in distant interventions and memory",
+        "MetricExpr": "(PM_CMPLU_STALL_DMISS_L3MISS - PM_CMPLU_STALL_DMISS_LMEM - PM_CMPLU_STALL_DMISS_L21_L31 - PM_CMPLU_STALL_DMISS_REMOTE) / PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "lsu_stall_dcache_miss_distant_cpi"
+    },
+    {
+        "BriefDescription": "Cycles stalled by D-Cache Misses that resolved in remote or distant caches",
+        "MetricExpr": "PM_CMPLU_STALL_DMISS_L21_L31 / PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "lsu_stall_dcache_miss_l21l31_cpi"
+    },
+    {
+        "BriefDescription": "Cycles stalled by D-Cache Misses that resolved in the local L2 or L3, where there was a conflict",
+        "MetricExpr": "PM_CMPLU_STALL_DMISS_L2L3_CONFLICT / PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "lsu_stall_dcache_miss_l2l3_conflict_cpi"
+    },
+    {
+        "BriefDescription": "Cycles stalled by D-Cache Misses that resolved in the local L2 or L3",
+        "MetricExpr": "PM_CMPLU_STALL_DMISS_L2L3 / PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "lsu_stall_dcache_miss_l2l3_cpi"
+    },
+    {
+        "BriefDescription": "Cycles stalled by D-Cache Misses that resolved in the local L2 or L3, where there was no conflict",
+        "MetricExpr": "(PM_CMPLU_STALL_DMISS_L2L3 - PM_CMPLU_STALL_DMISS_L2L3_CONFLICT) / PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "lsu_stall_dcache_miss_l2l3_noconflict_cpi"
+    },
+    {
+        "BriefDescription": "Cycles stalled by D-Cache Misses that resolved in other core's caches or memory",
+        "MetricExpr": "PM_CMPLU_STALL_DMISS_L3MISS / PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "lsu_stall_dcache_miss_l3miss_cpi"
+    },
+    {
+        "BriefDescription": "Cycles stalled by D-Cache Misses that resolved in local memory or local L4",
+        "MetricExpr": "PM_CMPLU_STALL_DMISS_LMEM / PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "lsu_stall_dcache_miss_lmem_cpi"
+    },
+    {
+        "BriefDescription": "Cycles stalled by D-Cache Misses that resolved in remote interventions and memory",
+        "MetricExpr": "PM_CMPLU_STALL_DMISS_REMOTE / PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "lsu_stall_dcache_miss_remote_cpi"
+    },
+    {
+        "BriefDescription": "Cycles stalled by ERAT Translation rejects",
+        "MetricExpr": "PM_CMPLU_STALL_ERAT_MISS / PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "lsu_stall_erat_miss_cpi"
+    },
+    {
+        "BriefDescription": "Cycles stalled by LSU load finishes",
+        "MetricExpr": "PM_CMPLU_STALL_LOAD_FINISH / PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "lsu_stall_ld_fin_cpi"
+    },
+    {
+        "BriefDescription": "Cycles stalled by LHS rejects",
+        "MetricExpr": "PM_CMPLU_STALL_REJECT_LHS / PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "lsu_stall_lhs_cpi"
+    },
+    {
+        "BriefDescription": "Cycles stalled by LMQ Full rejects",
+        "MetricExpr": "PM_CMPLU_STALL_REJ_LMQ_FULL / PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "lsu_stall_lmq_full_cpi"
+    },
+    {
+        "BriefDescription": "Cycles stalled by Other LSU Operations",
+        "MetricExpr": "(PM_CMPLU_STALL_LSU / PM_RUN_INST_CMPL) - (PM_CMPLU_STALL_DCACHE_MISS / PM_RUN_INST_CMPL) - (PM_CMPLU_STALL_REJECT / PM_RUN_INST_CMPL) - (PM_CMPLU_STALL_STORE / PM_RUN_INST_CMPL) - (PM_CMPLU_STALL_LOAD_FINISH / PM_RUN_INST_CMPL) - (PM_CMPLU_STALL_ST_FWD / PM_RUN_INST_CMPL)",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "lsu_stall_other_cpi"
+    },
+    {
+        "BriefDescription": "Cycles stalled by LSU Rejects",
+        "MetricExpr": "PM_CMPLU_STALL_REJECT / PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "lsu_stall_reject_cpi"
+    },
+    {
+        "BriefDescription": "Cycles stalled by Other LSU Rejects",
+        "MetricExpr": "(PM_CMPLU_STALL_REJECT / PM_RUN_INST_CMPL) - (PM_CMPLU_STALL_REJECT_LHS / PM_RUN_INST_CMPL) - (PM_CMPLU_STALL_ERAT_MISS / PM_RUN_INST_CMPL) - (PM_CMPLU_STALL_REJ_LMQ_FULL / PM_RUN_INST_CMPL)",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "lsu_stall_reject_other_cpi"
+    },
+    {
+        "BriefDescription": "Cycles stalled by LSU store forwarding",
+        "MetricExpr": "PM_CMPLU_STALL_ST_FWD / PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "lsu_stall_st_fwd_cpi"
+    },
+    {
+        "BriefDescription": "Cycles stalled by LSU Stores",
+        "MetricExpr": "PM_CMPLU_STALL_STORE / PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "lsu_stall_store_cpi"
+    },
+    {
+        "BriefDescription": "Cycles stalled by lightweight syncs",
+        "MetricExpr": "PM_CMPLU_STALL_LWSYNC / PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "lwsync_stall_cpi"
+    },
+    {
+        "MetricExpr": "PM_CMPLU_STALL_MEM_ECC_DELAY / PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "mem_ecc_delay_stall_cpi"
+    },
+    {
+        "BriefDescription": "Cycles stalled by nops (nothing next to finish)",
+        "MetricExpr": "PM_CMPLU_STALL_NO_NTF / PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "no_ntf_stall_cpi"
+    },
+    {
+        "MetricExpr": "PM_NTCG_ALL_FIN / PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "ntcg_all_fin_cpi"
+    },
+    {
+        "MetricExpr": "PM_CMPLU_STALL_NTCG_FLUSH / PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "ntcg_flush_cpi"
+    },
+    {
+        "BriefDescription": "Other thread block stall cycles",
+        "MetricExpr": "(PM_CMPLU_STALL_THRD - PM_CMPLU_STALL_LWSYNC - PM_CMPLU_STALL_HWSYNC - PM_CMPLU_STALL_MEM_ECC_DELAY - PM_CMPLU_STALL_FLUSH - PM_CMPLU_STALL_COQ_FULL)  / PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "other_block_stall_cpi"
+    },
+    {
+        "BriefDescription": "Cycles unaccounted for",
+        "MetricExpr": "(PM_RUN_CYC / PM_RUN_INST_CMPL) - (PM_CMPLU_STALL / PM_RUN_INST_CMPL) - (PM_GCT_NOSLOT_CYC / PM_RUN_INST_CMPL) - (PM_NTCG_ALL_FIN / PM_RUN_INST_CMPL) - (PM_CMPLU_STALL_THRD / PM_RUN_INST_CMPL) -  (PM_GRP_CMPL / PM_RUN_INST_CMPL)",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "other_cpi"
+    },
+    {
+        "BriefDescription": "Stall cycles unaccounted for",
+        "MetricExpr": "(PM_CMPLU_STALL / PM_RUN_INST_CMPL) - (PM_CMPLU_STALL_BRU_CRU / PM_RUN_INST_CMPL) - (PM_CMPLU_STALL_FXU / PM_RUN_INST_CMPL) - (PM_CMPLU_STALL_VSU / PM_RUN_INST_CMPL) - (PM_CMPLU_STALL_LSU / PM_RUN_INST_CMPL) - (PM_CMPLU_STALL_NTCG_FLUSH / PM_RUN_INST_CMPL) - (PM_CMPLU_STALL_NO_NTF / PM_RUN_INST_CMPL)",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "other_stall_cpi"
+    },
+    {
+        "BriefDescription": "Run cycles per run instruction",
+        "MetricExpr": "PM_RUN_CYC / PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "run_cpi"
+    },
+    {
+        "BriefDescription": "Completion Stall Cycles",
+        "MetricExpr": "PM_CMPLU_STALL / PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "stall_cpi"
+    },
+    {
+        "BriefDescription": "Cycles a thread was blocked",
+        "MetricExpr": "PM_CMPLU_STALL_THRD / PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "thread_block_stall_cpi"
+    },
+    {
+        "BriefDescription": "Cycles stalled by VSU",
+        "MetricExpr": "PM_CMPLU_STALL_VSU / PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "vsu_stall_cpi"
+    },
+    {
+        "BriefDescription": "Cycles stalled by other VSU Operations",
+        "MetricExpr": "(PM_CMPLU_STALL_VSU - PM_CMPLU_STALL_VECTOR - PM_CMPLU_STALL_SCALAR) / PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "vsu_stall_other_cpi"
+    },
+    {
+        "BriefDescription": "Cycles stalled by VSU Scalar Operations",
+        "MetricExpr": "PM_CMPLU_STALL_SCALAR / PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "vsu_stall_scalar_cpi"
+    },
+    {
+        "BriefDescription": "Cycles stalled by VSU Scalar Long Operations",
+        "MetricExpr": "PM_CMPLU_STALL_SCALAR_LONG / PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "vsu_stall_scalar_long_cpi"
+    },
+    {
+        "BriefDescription": "Cycles stalled by Other VSU Scalar Operations",
+        "MetricExpr": "(PM_CMPLU_STALL_SCALAR / PM_RUN_INST_CMPL) - (PM_CMPLU_STALL_SCALAR_LONG / PM_RUN_INST_CMPL)",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "vsu_stall_scalar_other_cpi"
+    },
+    {
+        "BriefDescription": "Cycles stalled by VSU Vector Operations",
+        "MetricExpr": "PM_CMPLU_STALL_VECTOR / PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "vsu_stall_vector_cpi"
+    },
+    {
+        "BriefDescription": "Cycles stalled by VSU Vector Long Operations",
+        "MetricExpr": "PM_CMPLU_STALL_VECTOR_LONG / PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "vsu_stall_vector_long_cpi"
+    },
+    {
+        "BriefDescription": "Cycles stalled by other VSU Vector Operations",
+        "MetricExpr": "(PM_CMPLU_STALL_VECTOR - PM_CMPLU_STALL_VECTOR_LONG) / PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "vsu_stall_vector_other_cpi"
+    },
+    {
+        "BriefDescription": "dL1 miss portion of CPI",
+        "MetricExpr": "( (PM_CMPLU_STALL_DCACHE_MISS / PM_RUN_INST_CMPL)/  (PM_RUN_CYC / PM_RUN_INST_CMPL))  * 100",
+        "MetricGroup": "estimated_dcache_miss_cpi",
+        "MetricName": "dcache_miss_cpi_percent"
+    },
+    {
+        "BriefDescription": "estimate of dl2l3 distant MOD miss rates with measured DL2L3 MOD latency as a %of dcache miss cpi",
+        "MetricExpr": "(((PM_DATA_FROM_DL2L3_MOD / PM_RUN_INST_CMPL) * (PM_MRK_DATA_FROM_DL2L3_MOD_CYC/ PM_MRK_DATA_FROM_DL2L3_MOD)) / (PM_CMPLU_STALL_DCACHE_MISS / PM_RUN_INST_CMPL)) *100",
+        "MetricGroup": "estimated_dcache_miss_cpi",
+        "MetricName": "dl2l3_mod_cpi_percent"
+    },
+    {
+        "BriefDescription": "estimate of dl2l3 distant SHR miss rates with measured DL2L3 SHR latency as a %of dcache miss cpi",
+        "MetricExpr": "(((PM_DATA_FROM_DL2L3_SHR / PM_RUN_INST_CMPL) * (PM_MRK_DATA_FROM_DL2L3_SHR_CYC/ PM_MRK_DATA_FROM_DL2L3_SHR)) / (PM_CMPLU_STALL_DCACHE_MISS / PM_RUN_INST_CMPL)) *100",
+        "MetricGroup": "estimated_dcache_miss_cpi",
+        "MetricName": "dl2l3_shr_cpi_percent"
+    },
+    {
+        "BriefDescription": "estimate of distant L4 miss rates with measured DL4 latency as a %of dcache miss cpi",
+        "MetricExpr": "(((PM_DATA_FROM_DL4 / PM_RUN_INST_CMPL) * (PM_MRK_DATA_FROM_DL4_CYC/ PM_MRK_DATA_FROM_DL4)) / (PM_CMPLU_STALL_DCACHE_MISS / PM_RUN_INST_CMPL)) *100",
+        "MetricGroup": "estimated_dcache_miss_cpi",
+        "MetricName": "dl4_cpi_percent"
+    },
+    {
+        "BriefDescription": "estimate of distant memory miss rates with measured DMEM latency as a %of dcache miss cpi",
+        "MetricExpr": "(((PM_DATA_FROM_DMEM / PM_RUN_INST_CMPL) * (PM_MRK_DATA_FROM_DMEM_CYC/ PM_MRK_DATA_FROM_DMEM)) / (PM_CMPLU_STALL_DCACHE_MISS / PM_RUN_INST_CMPL)) *100",
+        "MetricGroup": "estimated_dcache_miss_cpi",
+        "MetricName": "dmem_cpi_percent"
+    },
+    {
+        "BriefDescription": "estimate of dl21 MOD miss rates with measured L21 MOD latency as a %of dcache miss cpi",
+        "MetricExpr": "(((PM_DATA_FROM_L21_MOD / PM_RUN_INST_CMPL) * (PM_MRK_DATA_FROM_L21_MOD_CYC/ PM_MRK_DATA_FROM_L21_MOD)) / (PM_CMPLU_STALL_DCACHE_MISS / PM_RUN_INST_CMPL)) *100",
+        "MetricGroup": "estimated_dcache_miss_cpi",
+        "MetricName": "l21_mod_cpi_percent"
+    },
+    {
+        "BriefDescription": "estimate of dl21 SHR miss rates with measured L21 SHR latency as a %of dcache miss cpi",
+        "MetricExpr": "(((PM_DATA_FROM_L21_SHR / PM_RUN_INST_CMPL) * (PM_MRK_DATA_FROM_L21_SHR_CYC/ PM_MRK_DATA_FROM_L21_SHR)) / (PM_CMPLU_STALL_DCACHE_MISS / PM_RUN_INST_CMPL)) *100",
+        "MetricGroup": "estimated_dcache_miss_cpi",
+        "MetricName": "l21_shr_cpi_percent"
+    },
+    {
+        "BriefDescription": "estimate of dl2 miss rates with measured L2 latency as a %of dcache miss cpi",
+        "MetricExpr": "(((PM_DATA_FROM_L2  / PM_RUN_INST_CMPL) * (PM_MRK_DATA_FROM_L2_CYC/ PM_MRK_DATA_FROM_L2)) / (PM_CMPLU_STALL_DCACHE_MISS / PM_RUN_INST_CMPL) ) *100",
+        "MetricGroup": "estimated_dcache_miss_cpi",
+        "MetricName": "l2_cpi_percent"
+    },
+    {
+        "BriefDescription": "estimate of dl31 MOD miss rates with measured L31 MOD latency as a %of dcache miss cpi",
+        "MetricExpr": "(((PM_DATA_FROM_L31_MOD / PM_RUN_INST_CMPL) * (PM_MRK_DATA_FROM_L31_MOD_CYC/ PM_MRK_DATA_FROM_L31_MOD)) / (PM_CMPLU_STALL_DCACHE_MISS / PM_RUN_INST_CMPL)) *100",
+        "MetricGroup": "estimated_dcache_miss_cpi",
+        "MetricName": "l31_mod_cpi_percent"
+    },
+    {
+        "BriefDescription": "estimate of dl31 SHR miss rates with measured L31 SHR latency as a %of dcache miss cpi",
+        "MetricExpr": "(((PM_DATA_FROM_L31_SHR / PM_RUN_INST_CMPL) * (PM_MRK_DATA_FROM_L31_SHR_CYC/ PM_MRK_DATA_FROM_L31_SHR)) / (PM_CMPLU_STALL_DCACHE_MISS / PM_RUN_INST_CMPL)) *100",
+        "MetricGroup": "estimated_dcache_miss_cpi",
+        "MetricName": "l31_shr_cpi_percent"
+    },
+    {
+        "BriefDescription": "estimate of dl3 miss rates with measured L3 latency as a % of dcache miss cpi",
+        "MetricExpr": "(((PM_DATA_FROM_L3  / PM_RUN_INST_CMPL) * (PM_MRK_DATA_FROM_L3_CYC/ PM_MRK_DATA_FROM_L3)) / (PM_CMPLU_STALL_DCACHE_MISS / PM_RUN_INST_CMPL)) * 100",
+        "MetricGroup": "estimated_dcache_miss_cpi",
+        "MetricName": "l3_cpi_percent"
+    },
+    {
+        "BriefDescription": "estimate of Local L4 miss rates with measured LL4 latency as a %of dcache miss cpi",
+        "MetricExpr": "(((PM_DATA_FROM_LL4 / PM_RUN_INST_CMPL) * (PM_MRK_DATA_FROM_LL4_CYC/ PM_MRK_DATA_FROM_LL4)) / (PM_CMPLU_STALL_DCACHE_MISS / PM_RUN_INST_CMPL)) *100",
+        "MetricGroup": "estimated_dcache_miss_cpi",
+        "MetricName": "ll4_cpi_percent"
+    },
+    {
+        "BriefDescription": "estimate of Local memory miss rates with measured LMEM latency as a %of dcache miss cpi",
+        "MetricExpr": "(((PM_DATA_FROM_LMEM / PM_RUN_INST_CMPL) * (PM_MRK_DATA_FROM_LMEM_CYC/ PM_MRK_DATA_FROM_LMEM)) / (PM_CMPLU_STALL_DCACHE_MISS / PM_RUN_INST_CMPL)) *100",
+        "MetricGroup": "estimated_dcache_miss_cpi",
+        "MetricName": "lmem_cpi_percent"
+    },
+    {
+        "BriefDescription": "estimate of dl2l3 remote MOD miss rates with measured RL2L3 MOD latency as a %of dcache miss cpi",
+        "MetricExpr": "(((PM_DATA_FROM_RL2L3_MOD / PM_RUN_INST_CMPL) * (PM_MRK_DATA_FROM_RL2L3_MOD_CYC/ PM_MRK_DATA_FROM_RL2L3_MOD)) / (PM_CMPLU_STALL_DCACHE_MISS / PM_RUN_INST_CMPL)) *100",
+        "MetricGroup": "estimated_dcache_miss_cpi",
+        "MetricName": "rl2l3_mod_cpi_percent"
+    },
+    {
+        "BriefDescription": "estimate of dl2l3 shared miss rates with measured RL2L3 SHR latency as a %of dcache miss cpi",
+        "MetricExpr": "(((PM_DATA_FROM_RL2L3_SHR / PM_RUN_INST_CMPL) * (PM_MRK_DATA_FROM_RL2L3_SHR_CYC/ PM_MRK_DATA_FROM_RL2L3_SHR)) / (PM_CMPLU_STALL_DCACHE_MISS / PM_RUN_INST_CMPL)) * 100",
+        "MetricGroup": "estimated_dcache_miss_cpi",
+        "MetricName": "rl2l3_shr_cpi_percent"
+    },
+    {
+        "BriefDescription": "estimate of remote L4 miss rates with measured RL4 latency as a %of dcache miss cpi",
+        "MetricExpr": "(((PM_DATA_FROM_RL4 / PM_RUN_INST_CMPL) * (PM_MRK_DATA_FROM_RL4_CYC/ PM_MRK_DATA_FROM_RL4)) / (PM_CMPLU_STALL_DCACHE_MISS / PM_RUN_INST_CMPL)) *100",
+        "MetricGroup": "estimated_dcache_miss_cpi",
+        "MetricName": "rl4_cpi_percent"
+    },
+    {
+        "BriefDescription": "estimate of remote memory miss rates with measured RMEM latency as a %of dcache miss cpi",
+        "MetricExpr": "(((PM_DATA_FROM_RMEM / PM_RUN_INST_CMPL) * (PM_MRK_DATA_FROM_RMEM_CYC/ PM_MRK_DATA_FROM_RMEM)) / (PM_CMPLU_STALL_DCACHE_MISS / PM_RUN_INST_CMPL)) *100",
+        "MetricGroup": "estimated_dcache_miss_cpi",
+        "MetricName": "rmem_cpi_percent"
+    }
+]
-- 
2.17.1

