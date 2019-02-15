Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09DA6C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C133920838
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:28:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392387AbfBOJ20 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 04:28:26 -0500
Received: from terminus.zytor.com ([198.137.202.136]:33413 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726815AbfBOJ2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 04:28:25 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1F9Rk2w1115974
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 15 Feb 2019 01:27:46 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1F9RkEB1115971;
        Fri, 15 Feb 2019 01:27:46 -0800
Date:   Fri, 15 Feb 2019 01:27:46 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Paul Clarke <tipbot@zytor.com>
Message-ID: <tip-ffe18505ba1d641a4935321d3c525e4e2efd64c3@git.kernel.org>
Cc:     ananth@linux.vnet.ibm.com, naveen.n.rao@linux.vnet.ibm.com,
        cel@us.ibm.com, pc@us.ibm.com, acme@redhat.com, mingo@kernel.org,
        hpa@zytor.com, mpe@ellerman.id.au, sukadev@linux.vnet.ibm.com,
        maddy@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de
Reply-To: tglx@linutronix.de, mingo@kernel.org, acme@redhat.com,
          pc@us.ibm.com, linux-kernel@vger.kernel.org,
          naveen.n.rao@linux.vnet.ibm.com, cel@us.ibm.com,
          maddy@linux.vnet.ibm.com, hpa@zytor.com,
          ananth@linux.vnet.ibm.com, mpe@ellerman.id.au,
          sukadev@linux.vnet.ibm.com
In-Reply-To: <20190207175314.31813-3-pc@us.ibm.com>
References: <20190207175314.31813-3-pc@us.ibm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf vendor events power8: Dl1_reload,
 instruction_misses, l2_stats, lsu_rejects, memory & pteg_reloads metrics
Git-Commit-ID: ffe18505ba1d641a4935321d3c525e4e2efd64c3
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  ffe18505ba1d641a4935321d3c525e4e2efd64c3
Gitweb:     https://git.kernel.org/tip/ffe18505ba1d641a4935321d3c525e4e2efd64c3
Author:     Paul Clarke <pc@us.ibm.com>
AuthorDate: Thu, 7 Feb 2019 12:53:12 -0500
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 14 Feb 2019 13:31:09 -0300

perf vendor events power8: Dl1_reload, instruction_misses, l2_stats, lsu_rejects, memory & pteg_reloads metrics

POWER8 metrics are not well publicized.

Some are here:

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

Signed-off-by: Paul Clarke <pc@us.ibm.com>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>
Cc: Carl Love <cel@us.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Link: http://lkml.kernel.org/r/20190207175314.31813-3-pc@us.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../pmu-events/arch/powerpc/power8/metrics.json    | 702 +++++++++++++++++++++
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
