Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6851C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EE3D21872
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:53:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbfBGRxh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 12:53:37 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59570 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726989AbfBGRxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 12:53:22 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x17HiBp7089837
        for <linux-kernel@vger.kernel.org>; Thu, 7 Feb 2019 12:53:21 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qgsb4re5h-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 12:53:21 -0500
Received: from localhost
        by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pc@us.ibm.com>;
        Thu, 7 Feb 2019 17:53:20 -0000
Received: from b03cxnp08028.gho.boulder.ibm.com (9.17.130.20)
        by e31.co.us.ibm.com (192.168.1.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 7 Feb 2019 17:53:17 -0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x17HrGVo27066602
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Feb 2019 17:53:16 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 25AF0C6059;
        Thu,  7 Feb 2019 17:53:16 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EDC33C6061;
        Thu,  7 Feb 2019 17:53:15 +0000 (GMT)
Received: from localhost (unknown [9.114.15.222])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu,  7 Feb 2019 17:53:15 +0000 (GMT)
From:   Paul Clarke <pc@us.ibm.com>
To:     linux-perf-users@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, ananth@linux.vnet.ibm.com,
        maddy@linux.vnet.ibm.com, naveen.n.rao@linux.vnet.ibm.com,
        sukadev@linux.ibm.com, mpe@ellerman.id.au, cel@us.ibm.com
Subject: [PATCH v2 2/4] [powerpc] perf vendor events: Add JSON metrics for POWER8
Date:   Thu,  7 Feb 2019 12:53:12 -0500
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190207175314.31813-1-pc@us.ibm.com>
References: <20190207175314.31813-1-pc@us.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19020717-8235-0000-0000-00000E582B82
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010555; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000279; SDB=6.01157696; UDB=6.00604001; IPR=6.00938227;
 MB=3.00025481; MTD=3.00000008; XFM=3.00000015; UTC=2019-02-07 17:53:18
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19020717-8236-0000-0000-00004460D6AA
Message-Id: <20190207175314.31813-3-pc@us.ibm.com>
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
- dl1_reloads_percent_per_inst
- dl1_reloads_percent_per_ref
- instruction_misses_percent_per_inst
- l2_stats
- lsu_rejects
- memory
- pteg_reloads_percent_per_inst
- pteg_reloads_percent_per_ref

Signed-off-by: Paul A. Clarke <pc@us.ibm.com>
---
 .../arch/powerpc/power8/metrics.json          | 702 ++++++++++++++++++
 1 file changed, 702 insertions(+)

diff --git a/tools/perf/pmu-events/arch/powerpc/power8/metrics.json b/tools/perf/pmu-events/arch/powerpc/power8/metrics.json
index 377b76226c08..9a6ec8aadffd 100644
--- a/tools/perf/pmu-events/arch/powerpc/power8/metrics.json
+++ b/tools/perf/pmu-events/arch/powerpc/power8/metrics.json
@@ -356,6 +356,288 @@
         "MetricGroup": "cpi_breakdown",
         "MetricName": "vsu_stall_vector_other_cpi"
     },
+    {
+        "BriefDescription": "% of DL1 Reloads from Distant L2 or L3 (Modified) per Inst",
+        "MetricExpr": "PM_DATA_FROM_DL2L3_MOD * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "dl1_reloads_percent_per_inst",
+        "MetricName": "dl1_reload_from_dl2l3_mod_rate_percent"
+    },
+    {
+        "BriefDescription": "% of DL1 Reloads from Distant L2 or L3 (Shared) per Inst",
+        "MetricExpr": "PM_DATA_FROM_DL2L3_SHR * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "dl1_reloads_percent_per_inst",
+        "MetricName": "dl1_reload_from_dl2l3_shr_rate_percent"
+    },
+    {
+        "BriefDescription": "% of DL1 Reloads from Distant L4 per Inst",
+        "MetricExpr": "PM_DATA_FROM_DL4 * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "dl1_reloads_percent_per_inst",
+        "MetricName": "dl1_reload_from_dl4_rate_percent"
+    },
+    {
+        "BriefDescription": "% of DL1 Reloads from Distant Memory per Inst",
+        "MetricExpr": "PM_DATA_FROM_DMEM * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "dl1_reloads_percent_per_inst",
+        "MetricName": "dl1_reload_from_dmem_rate_percent"
+    },
+    {
+        "BriefDescription": "% of DL1 reloads from Private L2, other core per Inst",
+        "MetricExpr": "PM_DATA_FROM_L21_MOD * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "dl1_reloads_percent_per_inst",
+        "MetricName": "dl1_reload_from_l21_mod_rate_percent"
+    },
+    {
+        "BriefDescription": "% of DL1 reloads from Private L2, other core per Inst",
+        "MetricExpr": "PM_DATA_FROM_L21_SHR * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "dl1_reloads_percent_per_inst",
+        "MetricName": "dl1_reload_from_l21_shr_rate_percent"
+    },
+    {
+        "BriefDescription": "Percentage of L2 load hits per instruction where the L2 experienced a Load-Hit-Store conflict",
+        "MetricExpr": "PM_DATA_FROM_L2_DISP_CONFLICT_LDHITST * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "dl1_reloads_percent_per_inst",
+        "MetricName": "dl1_reload_from_l2_lhs_rate_percent"
+    },
+    {
+        "BriefDescription": "% of DL1 reloads from L2 per Inst",
+        "MetricExpr": "PM_DATA_FROM_L2MISS * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "dl1_reloads_percent_per_inst",
+        "MetricName": "dl1_reload_from_l2_miss_rate_percent"
+    },
+    {
+        "BriefDescription": "Percentage of L2 load hits per instruction where the L2 did not experience a conflict",
+        "MetricExpr": "PM_DATA_FROM_L2_NO_CONFLICT * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "dl1_reloads_percent_per_inst",
+        "MetricName": "dl1_reload_from_l2_no_conflict_rate_percent"
+    },
+    {
+        "BriefDescription": "Percentage of L2 load hits per instruction where the L2 experienced some conflict other than Load-Hit-Store",
+        "MetricExpr": "PM_DATA_FROM_L2_DISP_CONFLICT_OTHER * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "dl1_reloads_percent_per_inst",
+        "MetricName": "dl1_reload_from_l2_other_conflict_rate_percent"
+    },
+    {
+        "BriefDescription": "% of DL1 reloads from L2 per Inst",
+        "MetricExpr": "PM_DATA_FROM_L2 * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "dl1_reloads_percent_per_inst",
+        "MetricName": "dl1_reload_from_l2_rate_percent"
+    },
+    {
+        "BriefDescription": "% of DL1 reloads from Private L3 M state, other core per Inst",
+        "MetricExpr": "PM_DATA_FROM_L31_MOD * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "dl1_reloads_percent_per_inst",
+        "MetricName": "dl1_reload_from_l31_mod_rate_percent"
+    },
+    {
+        "BriefDescription": "% of DL1 reloads from Private L3 S tate, other core per Inst",
+        "MetricExpr": "PM_DATA_FROM_L31_SHR * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "dl1_reloads_percent_per_inst",
+        "MetricName": "dl1_reload_from_l31_shr_rate_percent"
+    },
+    {
+        "BriefDescription": "Percentage of L3 load hits per instruction where the load collided with a pending prefetch",
+        "MetricExpr": "PM_DATA_FROM_L3_DISP_CONFLICT * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "dl1_reloads_percent_per_inst",
+        "MetricName": "dl1_reload_from_l3_conflict_rate_percent"
+    },
+    {
+        "BriefDescription": "% of DL1 reloads from L3 per Inst",
+        "MetricExpr": "PM_DATA_FROM_L3MISS * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "dl1_reloads_percent_per_inst",
+        "MetricName": "dl1_reload_from_l3_miss_rate_percent"
+    },
+    {
+        "BriefDescription": "Percentage of L3 load hits per instruction where the L3 did not experience a conflict",
+        "MetricExpr": "PM_DATA_FROM_L3_NO_CONFLICT * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "dl1_reloads_percent_per_inst",
+        "MetricName": "dl1_reload_from_l3_no_conflict_rate_percent"
+    },
+    {
+        "BriefDescription": "% of DL1 Reloads from L3 per Inst",
+        "MetricExpr": "PM_DATA_FROM_L3 * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "dl1_reloads_percent_per_inst",
+        "MetricName": "dl1_reload_from_l3_rate_percent"
+    },
+    {
+        "BriefDescription": "% of DL1 Reloads from Local L4 per Inst",
+        "MetricExpr": "PM_DATA_FROM_LL4 * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "dl1_reloads_percent_per_inst",
+        "MetricName": "dl1_reload_from_ll4_rate_percent"
+    },
+    {
+        "BriefDescription": "% of DL1 Reloads from Local Memory per Inst",
+        "MetricExpr": "PM_DATA_FROM_LMEM * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "dl1_reloads_percent_per_inst",
+        "MetricName": "dl1_reload_from_lmem_rate_percent"
+    },
+    {
+        "BriefDescription": "% of DL1 reloads from Private L3, other core per Inst",
+        "MetricExpr": "PM_DATA_FROM_RL2L3_MOD * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "dl1_reloads_percent_per_inst",
+        "MetricName": "dl1_reload_from_rl2l3_mod_rate_percent"
+    },
+    {
+        "BriefDescription": "% of DL1 reloads from Private L3, other core per Inst",
+        "MetricExpr": "PM_DATA_FROM_RL2L3_SHR * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "dl1_reloads_percent_per_inst",
+        "MetricName": "dl1_reload_from_rl2l3_shr_rate_percent"
+    },
+    {
+        "BriefDescription": "% of DL1 Reloads from Remote Memory per Inst",
+        "MetricExpr": "PM_DATA_FROM_RL4 * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "dl1_reloads_percent_per_inst",
+        "MetricName": "dl1_reload_from_rl4_rate_percent"
+    },
+    {
+        "BriefDescription": "% of DL1 Reloads from Remote Memory per Inst",
+        "MetricExpr": "PM_DATA_FROM_RMEM * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "dl1_reloads_percent_per_inst",
+        "MetricName": "dl1_reload_from_rmem_rate_percent"
+    },
+    {
+        "BriefDescription": "Percentage of L1 demand load misses per run instruction",
+        "MetricExpr": "PM_LD_MISS_L1 * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "dl1_reloads_percent_per_inst",
+        "MetricName": "l1_ld_miss_rate_percent"
+    },
+    {
+        "BriefDescription": "% of DL1 misses that result in a cache reload",
+        "MetricExpr": "PM_L1_DCACHE_RELOAD_VALID * 100 / PM_LD_MISS_L1",
+        "MetricGroup": "dl1_reloads_percent_per_ref",
+        "MetricName": "dl1_miss_reloads_percent"
+    },
+    {
+        "BriefDescription": "% of DL1 dL1_Reloads from Distant L2 or L3 (Modified)",
+        "MetricExpr": "PM_DATA_FROM_DL2L3_MOD * 100 / PM_L1_DCACHE_RELOAD_VALID",
+        "MetricGroup": "dl1_reloads_percent_per_ref",
+        "MetricName": "dl1_reload_from_dl2l3_mod_percent"
+    },
+    {
+        "BriefDescription": "% of DL1 dL1_Reloads from Distant L2 or L3 (Shared)",
+        "MetricExpr": "PM_DATA_FROM_DL2L3_SHR * 100 / PM_L1_DCACHE_RELOAD_VALID",
+        "MetricGroup": "dl1_reloads_percent_per_ref",
+        "MetricName": "dl1_reload_from_dl2l3_shr_percent"
+    },
+    {
+        "BriefDescription": "% of DL1 dL1_Reloads from Distant L4",
+        "MetricExpr": "PM_DATA_FROM_DL4 * 100 / PM_L1_DCACHE_RELOAD_VALID",
+        "MetricGroup": "dl1_reloads_percent_per_ref",
+        "MetricName": "dl1_reload_from_dl4_percent"
+    },
+    {
+        "BriefDescription": "% of DL1 dL1_Reloads from Distant Memory",
+        "MetricExpr": "PM_DATA_FROM_DMEM * 100 / PM_L1_DCACHE_RELOAD_VALID",
+        "MetricGroup": "dl1_reloads_percent_per_ref",
+        "MetricName": "dl1_reload_from_dmem_percent"
+    },
+    {
+        "BriefDescription": "% of DL1 reloads from Private L2, other core",
+        "MetricExpr": "PM_DATA_FROM_L21_MOD * 100 / PM_L1_DCACHE_RELOAD_VALID",
+        "MetricGroup": "dl1_reloads_percent_per_ref",
+        "MetricName": "dl1_reload_from_l21_mod_percent"
+    },
+    {
+        "BriefDescription": "% of DL1 reloads from Private L2, other core",
+        "MetricExpr": "PM_DATA_FROM_L21_SHR * 100 / PM_L1_DCACHE_RELOAD_VALID",
+        "MetricGroup": "dl1_reloads_percent_per_ref",
+        "MetricName": "dl1_reload_from_l21_shr_percent"
+    },
+    {
+        "BriefDescription": "Percentage of DL1 reloads from L2 with a Load-Hit-Store conflict",
+        "MetricExpr": "PM_DATA_FROM_L2_DISP_CONFLICT_LDHITST * 100 / PM_L1_DCACHE_RELOAD_VALID",
+        "MetricGroup": "dl1_reloads_percent_per_ref",
+        "MetricName": "dl1_reload_from_l2_lhs_percent"
+    },
+    {
+        "BriefDescription": "Percentage of DL1 reloads from L2 with no conflicts",
+        "MetricExpr": "PM_DATA_FROM_L2_NO_CONFLICT * 100 / PM_L1_DCACHE_RELOAD_VALID",
+        "MetricGroup": "dl1_reloads_percent_per_ref",
+        "MetricName": "dl1_reload_from_l2_no_conflict_percent"
+    },
+    {
+        "BriefDescription": "Percentage of DL1 reloads from L2 with some conflict other than Load-Hit-Store",
+        "MetricExpr": "PM_DATA_FROM_L2_DISP_CONFLICT_OTHER * 100 / PM_L1_DCACHE_RELOAD_VALID",
+        "MetricGroup": "dl1_reloads_percent_per_ref",
+        "MetricName": "dl1_reload_from_l2_other_conflict_percent"
+    },
+    {
+        "BriefDescription": "% of DL1 reloads from L2",
+        "MetricExpr": "PM_DATA_FROM_L2 * 100 / PM_L1_DCACHE_RELOAD_VALID",
+        "MetricGroup": "dl1_reloads_percent_per_ref",
+        "MetricName": "dl1_reload_from_l2_percent"
+    },
+    {
+        "BriefDescription": "% of DL1 reloads from Private L3, other core",
+        "MetricExpr": "PM_DATA_FROM_L31_MOD * 100 / PM_L1_DCACHE_RELOAD_VALID",
+        "MetricGroup": "dl1_reloads_percent_per_ref",
+        "MetricName": "dl1_reload_from_l31_mod_percent"
+    },
+    {
+        "BriefDescription": "% of DL1 reloads from Private L3, other core",
+        "MetricExpr": "PM_DATA_FROM_L31_SHR * 100 / PM_L1_DCACHE_RELOAD_VALID",
+        "MetricGroup": "dl1_reloads_percent_per_ref",
+        "MetricName": "dl1_reload_from_l31_shr_percent"
+    },
+    {
+        "BriefDescription": "Percentage of DL1 reloads from L3 where the load collided with a pending prefetch",
+        "MetricExpr": "PM_DATA_FROM_L3_DISP_CONFLICT * 100 / PM_L1_DCACHE_RELOAD_VALID",
+        "MetricGroup": "dl1_reloads_percent_per_ref",
+        "MetricName": "dl1_reload_from_l3_conflict_percent"
+    },
+    {
+        "BriefDescription": "Percentage of L3 load hits per instruction where the line was brought into the L3 by a prefetch operation",
+        "MetricExpr": "PM_DATA_FROM_L3_MEPF * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "dl1_reloads_percent_per_ref",
+        "MetricName": "dl1_reload_from_l3_mepf_rate_percent"
+    },
+    {
+        "BriefDescription": "Percentage of DL1 reloads from L3 without conflicts",
+        "MetricExpr": "PM_DATA_FROM_L3_NO_CONFLICT * 100 / PM_L1_DCACHE_RELOAD_VALID",
+        "MetricGroup": "dl1_reloads_percent_per_ref",
+        "MetricName": "dl1_reload_from_l3_no_conflict_percent"
+    },
+    {
+        "BriefDescription": "% of DL1 Reloads from L3",
+        "MetricExpr": "PM_DATA_FROM_L3 * 100 / PM_L1_DCACHE_RELOAD_VALID",
+        "MetricGroup": "dl1_reloads_percent_per_ref",
+        "MetricName": "dl1_reload_from_l3_percent"
+    },
+    {
+        "BriefDescription": "% of DL1 dL1_Reloads from Local L4",
+        "MetricExpr": "PM_DATA_FROM_LL4 * 100 / PM_L1_DCACHE_RELOAD_VALID",
+        "MetricGroup": "dl1_reloads_percent_per_ref",
+        "MetricName": "dl1_reload_from_ll4_percent"
+    },
+    {
+        "BriefDescription": "% of DL1 dL1_Reloads from Local Memory",
+        "MetricExpr": "PM_DATA_FROM_LMEM * 100 / PM_L1_DCACHE_RELOAD_VALID",
+        "MetricGroup": "dl1_reloads_percent_per_ref",
+        "MetricName": "dl1_reload_from_lmem_percent"
+    },
+    {
+        "BriefDescription": "% of DL1 dL1_Reloads from Remote L2 or L3 (Modified)",
+        "MetricExpr": "PM_DATA_FROM_RL2L3_MOD * 100 / PM_L1_DCACHE_RELOAD_VALID",
+        "MetricGroup": "dl1_reloads_percent_per_ref",
+        "MetricName": "dl1_reload_from_rl2l3_mod_percent"
+    },
+    {
+        "BriefDescription": "% of DL1 dL1_Reloads from Remote L2 or L3 (Shared)",
+        "MetricExpr": "PM_DATA_FROM_RL2L3_SHR * 100 / PM_L1_DCACHE_RELOAD_VALID",
+        "MetricGroup": "dl1_reloads_percent_per_ref",
+        "MetricName": "dl1_reload_from_rl2l3_shr_percent"
+    },
+    {
+        "BriefDescription": "% of DL1 dL1_Reloads from Remote L4",
+        "MetricExpr": "PM_DATA_FROM_RL4 * 100 / PM_L1_DCACHE_RELOAD_VALID",
+        "MetricGroup": "dl1_reloads_percent_per_ref",
+        "MetricName": "dl1_reload_from_rl4_percent"
+    },
+    {
+        "BriefDescription": "% of DL1 dL1_Reloads from Remote Memory",
+        "MetricExpr": "PM_DATA_FROM_RMEM * 100 / PM_L1_DCACHE_RELOAD_VALID",
+        "MetricGroup": "dl1_reloads_percent_per_ref",
+        "MetricName": "dl1_reload_from_rmem_percent"
+    },
     {
         "BriefDescription": "dL1 miss portion of CPI",
         "MetricExpr": "( (PM_CMPLU_STALL_DCACHE_MISS / PM_RUN_INST_CMPL)/  (PM_RUN_CYC / PM_RUN_INST_CMPL))  * 100",
@@ -457,5 +739,425 @@
         "MetricExpr": "(((PM_DATA_FROM_RMEM / PM_RUN_INST_CMPL) * (PM_MRK_DATA_FROM_RMEM_CYC/ PM_MRK_DATA_FROM_RMEM)) / (PM_CMPLU_STALL_DCACHE_MISS / PM_RUN_INST_CMPL)) *100",
         "MetricGroup": "estimated_dcache_miss_cpi",
         "MetricName": "rmem_cpi_percent"
+    },
+    {
+        "BriefDescription": "% of ICache reloads from Distant L2 or L3 (Modified) per Inst",
+        "MetricExpr": "PM_INST_FROM_DL2L3_MOD * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "instruction_misses_percent_per_inst",
+        "MetricName": "inst_from_dl2l3_mod_rate_percent"
+    },
+    {
+        "BriefDescription": "% of ICache reloads from Distant L2 or L3 (Shared) per Inst",
+        "MetricExpr": "PM_INST_FROM_DL2L3_SHR * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "instruction_misses_percent_per_inst",
+        "MetricName": "inst_from_dl2l3_shr_rate_percent"
+    },
+    {
+        "BriefDescription": "% of ICache reloads from Distant L4 per Inst",
+        "MetricExpr": "PM_INST_FROM_DL4 * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "instruction_misses_percent_per_inst",
+        "MetricName": "inst_from_dl4_rate_percent"
+    },
+    {
+        "BriefDescription": "% of ICache reloads from Distant Memory per Inst",
+        "MetricExpr": "PM_INST_FROM_DMEM * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "instruction_misses_percent_per_inst",
+        "MetricName": "inst_from_dmem_rate_percent"
+    },
+    {
+        "BriefDescription": "% of ICache reloads from Private L2, other core per Inst",
+        "MetricExpr": "PM_INST_FROM_L21_MOD * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "instruction_misses_percent_per_inst",
+        "MetricName": "inst_from_l21_mod_rate_percent"
+    },
+    {
+        "BriefDescription": "% of ICache reloads from Private L2, other core per Inst",
+        "MetricExpr": "PM_INST_FROM_L21_SHR * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "instruction_misses_percent_per_inst",
+        "MetricName": "inst_from_l21_shr_rate_percent"
+    },
+    {
+        "BriefDescription": "% of ICache reloads from L2 per Inst",
+        "MetricExpr": "PM_INST_FROM_L2 * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "instruction_misses_percent_per_inst",
+        "MetricName": "inst_from_l2_rate_percent"
+    },
+    {
+        "BriefDescription": "% of ICache reloads from Private L3, other core per Inst",
+        "MetricExpr": "PM_INST_FROM_L31_MOD * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "instruction_misses_percent_per_inst",
+        "MetricName": "inst_from_l31_mod_rate_percent"
+    },
+    {
+        "BriefDescription": "% of ICache reloads from Private L3 other core per Inst",
+        "MetricExpr": "PM_INST_FROM_L31_SHR * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "instruction_misses_percent_per_inst",
+        "MetricName": "inst_from_l31_shr_rate_percent"
+    },
+    {
+        "BriefDescription": "% of ICache reloads from L3 per Inst",
+        "MetricExpr": "PM_INST_FROM_L3 * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "instruction_misses_percent_per_inst",
+        "MetricName": "inst_from_l3_rate_percent"
+    },
+    {
+        "BriefDescription": "% of ICache reloads from Local L4 per Inst",
+        "MetricExpr": "PM_INST_FROM_LL4 * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "instruction_misses_percent_per_inst",
+        "MetricName": "inst_from_ll4_rate_percent"
+    },
+    {
+        "BriefDescription": "% of ICache reloads from Local Memory per Inst",
+        "MetricExpr": "PM_INST_FROM_LMEM * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "instruction_misses_percent_per_inst",
+        "MetricName": "inst_from_lmem_rate_percent"
+    },
+    {
+        "BriefDescription": "% of ICache reloads from Remote L2 or L3 (Modified) per Inst",
+        "MetricExpr": "PM_INST_FROM_RL2L3_MOD * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "instruction_misses_percent_per_inst",
+        "MetricName": "inst_from_rl2l3_mod_rate_percent"
+    },
+    {
+        "BriefDescription": "% of ICache reloads from Remote L2 or L3 (Shared) per Inst",
+        "MetricExpr": "PM_INST_FROM_RL2L3_SHR * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "instruction_misses_percent_per_inst",
+        "MetricName": "inst_from_rl2l3_shr_rate_percent"
+    },
+    {
+        "BriefDescription": "% of ICache reloads from Remote L4 per Inst",
+        "MetricExpr": "PM_INST_FROM_RL4 * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "instruction_misses_percent_per_inst",
+        "MetricName": "inst_from_rl4_rate_percent"
+    },
+    {
+        "BriefDescription": "% of ICache reloads from Remote Memory per Inst",
+        "MetricExpr": "PM_INST_FROM_RMEM * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "instruction_misses_percent_per_inst",
+        "MetricName": "inst_from_rmem_rate_percent"
+    },
+    {
+        "BriefDescription": "Instruction Cache Miss Rate (Per run Instruction)(%)",
+        "MetricExpr": "PM_L1_ICACHE_MISS * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "instruction_misses_percent_per_inst",
+        "MetricName": "l1_inst_miss_rate_percent"
+    },
+    {
+        "BriefDescription": "Average number of stores that gather in the store buffer before being sent to an L2 RC machine",
+        "MetricExpr": "PM_ST_CMPL / (PM_L2_ST / 2)",
+        "MetricGroup": "l2_stats",
+        "MetricName": "avg_stores_gathered"
+    },
+    {
+        "BriefDescription": "L2  Store misses  as a % of total L2  Store dispatches (per thread)",
+        "MetricExpr": "PM_L2_ST_MISS /  PM_L2_ST * 100",
+        "MetricGroup": "l2_stats",
+        "MetricName": "l2_st_miss_ratio_percent"
+    },
+    {
+        "BriefDescription": "Percentage of L2 store misses per drained store.  A drained store may contain multiple individual stores if they target the same line",
+        "MetricExpr": "PM_L2_ST_MISS / (PM_L2_ST / 2)",
+        "MetricGroup": "l2_stats",
+        "MetricName": "l2_store_miss_ratio_percent"
+    },
+    {
+        "BriefDescription": "ERAT miss reject ratio",
+        "MetricExpr": "PM_LSU_REJECT_ERAT_MISS * 100  / PM_RUN_INST_CMPL",
+        "MetricGroup": "lsu_rejects",
+        "MetricName": "erat_reject_rate_percent"
+    },
+    {
+        "BriefDescription": "ERAT miss reject ratio",
+        "MetricExpr": "PM_LSU_REJECT_ERAT_MISS * 100  / (PM_LSU_FIN - PM_LSU_FX_FIN)",
+        "MetricGroup": "lsu_rejects",
+        "MetricName": "erat_reject_ratio_percent"
+    },
+    {
+        "BriefDescription": "LHS reject ratio",
+        "MetricExpr": "PM_LSU_REJECT_LHS *100/ PM_RUN_INST_CMPL",
+        "MetricGroup": "lsu_rejects",
+        "MetricName": "lhs_reject_rate_percent"
+    },
+    {
+        "BriefDescription": "LHS reject ratio",
+        "MetricExpr": "PM_LSU_REJECT_LHS *100/ (PM_LSU_FIN - PM_LSU_FX_FIN)",
+        "MetricGroup": "lsu_rejects",
+        "MetricName": "lhs_reject_ratio_percent"
+    },
+    {
+        "BriefDescription": "LMQ full reject ratio",
+        "MetricExpr": "PM_LSU_REJECT_LMQ_FULL * 100  / PM_RUN_INST_CMPL",
+        "MetricGroup": "lsu_rejects",
+        "MetricName": "lmq_full_reject_rate_percent"
+    },
+    {
+        "BriefDescription": "ERAT miss reject ratio",
+        "MetricExpr": "PM_LSU_REJECT_LMQ_FULL * 100  / PM_LD_REF_L1",
+        "MetricGroup": "lsu_rejects",
+        "MetricName": "lmq_full_reject_ratio_percent"
+    },
+    {
+        "BriefDescription": "LSU reject ratio",
+        "MetricExpr": "PM_LSU_REJECT *100/ PM_RUN_INST_CMPL",
+        "MetricGroup": "lsu_rejects",
+        "MetricName": "lsu_reject_rate_percent"
+    },
+    {
+        "BriefDescription": "LSU reject ratio",
+        "MetricExpr": "PM_LSU_REJECT *100/ (PM_LSU_FIN - PM_LSU_FX_FIN)",
+        "MetricGroup": "lsu_rejects",
+        "MetricName": "lsu_reject_ratio_percent"
+    },
+    {
+        "BriefDescription": "Ratio of reloads from local L4 to distant L4",
+        "MetricExpr": "PM_DATA_FROM_LL4 / PM_DATA_FROM_DL4",
+        "MetricGroup": "memory",
+        "MetricName": "ld_ll4_per_ld_dmem"
+    },
+    {
+        "BriefDescription": "Ratio of reloads from local L4 to remote+distant L4",
+        "MetricExpr": "PM_DATA_FROM_LL4 / (PM_DATA_FROM_DL4 + PM_DATA_FROM_RL4)",
+        "MetricGroup": "memory",
+        "MetricName": "ld_ll4_per_ld_mem"
+    },
+    {
+        "BriefDescription": "Ratio of reloads from local L4 to remote L4",
+        "MetricExpr": "PM_DATA_FROM_LL4 / PM_DATA_FROM_RL4",
+        "MetricGroup": "memory",
+        "MetricName": "ld_ll4_per_ld_rl4"
+    },
+    {
+        "BriefDescription": "Number of loads from local memory per loads from distant memory",
+        "MetricExpr": "PM_DATA_FROM_LMEM / PM_DATA_FROM_DMEM",
+        "MetricGroup": "memory",
+        "MetricName": "ld_lmem_per_ld_dmem"
+    },
+    {
+        "BriefDescription": "Number of loads from local memory per loads from remote and distant memory",
+        "MetricExpr": "PM_DATA_FROM_LMEM / (PM_DATA_FROM_DMEM + PM_DATA_FROM_RMEM)",
+        "MetricGroup": "memory",
+        "MetricName": "ld_lmem_per_ld_mem"
+    },
+    {
+        "BriefDescription": "Number of loads from local memory per loads from remote memory",
+        "MetricExpr": "PM_DATA_FROM_LMEM / PM_DATA_FROM_RMEM",
+        "MetricGroup": "memory",
+        "MetricName": "ld_lmem_per_ld_rmem"
+    },
+    {
+        "BriefDescription": "Number of loads from remote memory per loads from distant memory",
+        "MetricExpr": "PM_DATA_FROM_RMEM / PM_DATA_FROM_DMEM",
+        "MetricGroup": "memory",
+        "MetricName": "ld_rmem_per_ld_dmem"
+    },
+    {
+        "BriefDescription": "Memory locality",
+        "MetricExpr": "(PM_DATA_FROM_LL4 + PM_DATA_FROM_LMEM) * 100/ (PM_DATA_FROM_LMEM + PM_DATA_FROM_LL4 + PM_DATA_FROM_RMEM + PM_DATA_FROM_RL4 + PM_DATA_FROM_DMEM + PM_DATA_FROM_DL4)",
+        "MetricGroup": "memory",
+        "MetricName": "mem_locality_percent"
+    },
+    {
+        "BriefDescription": "DERAT Miss Rate (per run  instruction)(%)",
+        "MetricExpr": "PM_LSU_DERAT_MISS * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "pteg_reloads_percent_per_inst",
+        "MetricName": "derat_miss_rate_percent"
+    },
+    {
+        "BriefDescription": "% of DERAT reloads from Distant L2 or L3 (Modified) per inst",
+        "MetricExpr": "PM_DPTEG_FROM_DL2L3_MOD * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "pteg_reloads_percent_per_inst",
+        "MetricName": "pteg_from_dl2l3_mod_rate_percent"
+    },
+    {
+        "BriefDescription": "% of DERAT reloads from Distant L2 or L3 (Shared) per inst",
+        "MetricExpr": "PM_DPTEG_FROM_DL2L3_SHR * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "pteg_reloads_percent_per_inst",
+        "MetricName": "pteg_from_dl2l3_shr_rate_percent"
+    },
+    {
+        "BriefDescription": "% of DERAT reloads from Distant L4 per inst",
+        "MetricExpr": "PM_DPTEG_FROM_DL4 * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "pteg_reloads_percent_per_inst",
+        "MetricName": "pteg_from_dl4_rate_percent"
+    },
+    {
+        "BriefDescription": "% of DERAT reloads from Distant Memory per inst",
+        "MetricExpr": "PM_DPTEG_FROM_DMEM * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "pteg_reloads_percent_per_inst",
+        "MetricName": "pteg_from_dmem_rate_percent"
+    },
+    {
+        "BriefDescription": "% of DERAT reloads from Private L2, other core per inst",
+        "MetricExpr": "PM_DPTEG_FROM_L21_MOD * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "pteg_reloads_percent_per_inst",
+        "MetricName": "pteg_from_l21_mod_rate_percent"
+    },
+    {
+        "BriefDescription": "% of DERAT reloads from Private L2, other core per inst",
+        "MetricExpr": "PM_DPTEG_FROM_L21_SHR * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "pteg_reloads_percent_per_inst",
+        "MetricName": "pteg_from_l21_shr_rate_percent"
+    },
+    {
+        "BriefDescription": "% of DERAT reloads from L2 per inst",
+        "MetricExpr": "PM_DPTEG_FROM_L2 * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "pteg_reloads_percent_per_inst",
+        "MetricName": "pteg_from_l2_rate_percent"
+    },
+    {
+        "BriefDescription": "% of DERAT reloads from Private L3, other core per inst",
+        "MetricExpr": "PM_DPTEG_FROM_L31_MOD * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "pteg_reloads_percent_per_inst",
+        "MetricName": "pteg_from_l31_mod_rate_percent"
+    },
+    {
+        "BriefDescription": "% of DERAT reloads from Private L3, other core per inst",
+        "MetricExpr": "PM_DPTEG_FROM_L31_SHR * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "pteg_reloads_percent_per_inst",
+        "MetricName": "pteg_from_l31_shr_rate_percent"
+    },
+    {
+        "BriefDescription": "% of DERAT reloads from L3 per inst",
+        "MetricExpr": "PM_DPTEG_FROM_L3 * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "pteg_reloads_percent_per_inst",
+        "MetricName": "pteg_from_l3_rate_percent"
+    },
+    {
+        "BriefDescription": "% of DERAT reloads from Local L4 per inst",
+        "MetricExpr": "PM_DPTEG_FROM_LL4 * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "pteg_reloads_percent_per_inst",
+        "MetricName": "pteg_from_ll4_rate_percent"
+    },
+    {
+        "BriefDescription": "% of DERAT reloads from Local Memory per inst",
+        "MetricExpr": "PM_DPTEG_FROM_LMEM * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "pteg_reloads_percent_per_inst",
+        "MetricName": "pteg_from_lmem_rate_percent"
+    },
+    {
+        "BriefDescription": "% of DERAT reloads from Remote L2 or L3 (Modified) per inst",
+        "MetricExpr": "PM_DPTEG_FROM_RL2L3_MOD * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "pteg_reloads_percent_per_inst",
+        "MetricName": "pteg_from_rl2l3_mod_rate_percent"
+    },
+    {
+        "BriefDescription": "% of DERAT reloads from Remote L2 or L3 (Shared) per inst",
+        "MetricExpr": "PM_DPTEG_FROM_RL2L3_SHR * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "pteg_reloads_percent_per_inst",
+        "MetricName": "pteg_from_rl2l3_shr_rate_percent"
+    },
+    {
+        "BriefDescription": "% of DERAT reloads from Remote L4 per inst",
+        "MetricExpr": "PM_DPTEG_FROM_RL4 * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "pteg_reloads_percent_per_inst",
+        "MetricName": "pteg_from_rl4_rate_percent"
+    },
+    {
+        "BriefDescription": "% of DERAT reloads from Remote Memory per inst",
+        "MetricExpr": "PM_DPTEG_FROM_RMEM * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "pteg_reloads_percent_per_inst",
+        "MetricName": "pteg_from_rmem_rate_percent"
+    },
+    {
+        "BriefDescription": "% of DERAT misses that result in an ERAT reload",
+        "MetricExpr": "PM_DTLB_MISS * 100 / PM_LSU_DERAT_MISS",
+        "MetricGroup": "pteg_reloads_percent_per_ref",
+        "MetricName": "derat_miss_reload_percent"
+    },
+    {
+        "BriefDescription": "% of DERAT reloads from Distant L2 or L3 (Modified)",
+        "MetricExpr": "PM_DPTEG_FROM_DL2L3_MOD * 100 / PM_DTLB_MISS",
+        "MetricGroup": "pteg_reloads_percent_per_ref",
+        "MetricName": "pteg_from_dl2l3_mod_percent"
+    },
+    {
+        "BriefDescription": "% of DERAT reloads from Distant L2 or L3 (Shared)",
+        "MetricExpr": "PM_DPTEG_FROM_DL2L3_SHR * 100 / PM_DTLB_MISS",
+        "MetricGroup": "pteg_reloads_percent_per_ref",
+        "MetricName": "pteg_from_dl2l3_shr_percent"
+    },
+    {
+        "BriefDescription": "% of DERAT reloads from Distant L4",
+        "MetricExpr": "PM_DPTEG_FROM_DL4 * 100 / PM_DTLB_MISS",
+        "MetricGroup": "pteg_reloads_percent_per_ref",
+        "MetricName": "pteg_from_dl4_percent"
+    },
+    {
+        "BriefDescription": "% of DERAT reloads from Distant Memory",
+        "MetricExpr": "PM_DPTEG_FROM_DMEM * 100 / PM_DTLB_MISS",
+        "MetricGroup": "pteg_reloads_percent_per_ref",
+        "MetricName": "pteg_from_dmem_percent"
+    },
+    {
+        "BriefDescription": "% of DERAT reloads from Private L2, other core",
+        "MetricExpr": "PM_DPTEG_FROM_L21_MOD * 100 / PM_DTLB_MISS",
+        "MetricGroup": "pteg_reloads_percent_per_ref",
+        "MetricName": "pteg_from_l21_mod_percent"
+    },
+    {
+        "BriefDescription": "% of DERAT reloads from Private L2, other core",
+        "MetricExpr": "PM_DPTEG_FROM_L21_SHR * 100 / PM_DTLB_MISS",
+        "MetricGroup": "pteg_reloads_percent_per_ref",
+        "MetricName": "pteg_from_l21_shr_percent"
+    },
+    {
+        "BriefDescription": "% of DERAT reloads from L2",
+        "MetricExpr": "PM_DPTEG_FROM_L2 * 100 / PM_DTLB_MISS",
+        "MetricGroup": "pteg_reloads_percent_per_ref",
+        "MetricName": "pteg_from_l2_percent"
+    },
+    {
+        "BriefDescription": "% of DERAT reloads from Private L3, other core",
+        "MetricExpr": "PM_DPTEG_FROM_L31_MOD * 100 / PM_DTLB_MISS",
+        "MetricGroup": "pteg_reloads_percent_per_ref",
+        "MetricName": "pteg_from_l31_mod_percent"
+    },
+    {
+        "BriefDescription": "% of DERAT reloads from Private L3, other core",
+        "MetricExpr": "PM_DPTEG_FROM_L31_SHR * 100 / PM_DTLB_MISS",
+        "MetricGroup": "pteg_reloads_percent_per_ref",
+        "MetricName": "pteg_from_l31_shr_percent"
+    },
+    {
+        "BriefDescription": "% of DERAT reloads from L3",
+        "MetricExpr": "PM_DPTEG_FROM_L3 * 100 / PM_DTLB_MISS",
+        "MetricGroup": "pteg_reloads_percent_per_ref",
+        "MetricName": "pteg_from_l3_percent"
+    },
+    {
+        "BriefDescription": "% of DERAT reloads from Local L4",
+        "MetricExpr": "PM_DPTEG_FROM_LL4 * 100 / PM_DTLB_MISS",
+        "MetricGroup": "pteg_reloads_percent_per_ref",
+        "MetricName": "pteg_from_ll4_percent"
+    },
+    {
+        "BriefDescription": "% of DERAT reloads from Local Memory",
+        "MetricExpr": "PM_DPTEG_FROM_LMEM * 100 / PM_DTLB_MISS",
+        "MetricGroup": "pteg_reloads_percent_per_ref",
+        "MetricName": "pteg_from_lmem_percent"
+    },
+    {
+        "BriefDescription": "% of DERAT reloads from Remote L2 or L3 (Modified)",
+        "MetricExpr": "PM_DPTEG_FROM_RL2L3_MOD * 100 / PM_DTLB_MISS",
+        "MetricGroup": "pteg_reloads_percent_per_ref",
+        "MetricName": "pteg_from_rl2l3_mod_percent"
+    },
+    {
+        "BriefDescription": "% of DERAT reloads from Remote L2 or L3 (Shared)",
+        "MetricExpr": "PM_DPTEG_FROM_RL2L3_SHR * 100 / PM_DTLB_MISS",
+        "MetricGroup": "pteg_reloads_percent_per_ref",
+        "MetricName": "pteg_from_rl2l3_shr_percent"
+    },
+    {
+        "BriefDescription": "% of DERAT reloads from Remote L4",
+        "MetricExpr": "PM_DPTEG_FROM_RL4 * 100 / PM_DTLB_MISS",
+        "MetricGroup": "pteg_reloads_percent_per_ref",
+        "MetricName": "pteg_from_rl4_percent"
+    },
+    {
+        "BriefDescription": "% of DERAT reloads from Remote Memory",
+        "MetricExpr": "PM_DPTEG_FROM_RMEM * 100 / PM_DTLB_MISS",
+        "MetricGroup": "pteg_reloads_percent_per_ref",
+        "MetricName": "pteg_from_rmem_percent"
     }
 ]
-- 
2.17.1

