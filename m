Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74009C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B31D206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:31:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405010AbfBOJbi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 04:31:38 -0500
Received: from terminus.zytor.com ([198.137.202.136]:55477 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727555AbfBOJbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 04:31:37 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1F9V5Ik1116614
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 15 Feb 2019 01:31:05 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1F9V4WN1116611;
        Fri, 15 Feb 2019 01:31:04 -0800
Date:   Fri, 15 Feb 2019 01:31:04 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Paul Clarke <tipbot@zytor.com>
Message-ID: <tip-a4d832726471963b327fae33f14fa28c83db6a0e@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, pc@us.ibm.com, acme@redhat.com,
        tglx@linutronix.de, ananth@linux.vnet.ibm.com, hpa@zytor.com,
        maddy@linux.vnet.ibm.com, sukadev@linux.vnet.ibm.com,
        mingo@kernel.org, mpe@ellerman.id.au, cel@us.ibm.com,
        naveen.n.rao@linux.vnet.ibm.com
Reply-To: acme@redhat.com, tglx@linutronix.de, ananth@linux.vnet.ibm.com,
          linux-kernel@vger.kernel.org, pc@us.ibm.com,
          sukadev@linux.vnet.ibm.com, hpa@zytor.com,
          maddy@linux.vnet.ibm.com, mingo@kernel.org, mpe@ellerman.id.au,
          naveen.n.rao@linux.vnet.ibm.com, cel@us.ibm.com
In-Reply-To: <20190209181429.23950-4-pc@us.ibm.com>
References: <20190209181429.23950-4-pc@us.ibm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf vendor events power9: Branch_prediction,
 instruction_stats, latency, lsu_rejects, memory, prefetch & translation
 metrics
Git-Commit-ID: a4d832726471963b327fae33f14fa28c83db6a0e
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

Commit-ID:  a4d832726471963b327fae33f14fa28c83db6a0e
Gitweb:     https://git.kernel.org/tip/a4d832726471963b327fae33f14fa28c83db6a0e
Author:     Paul Clarke <pc@us.ibm.com>
AuthorDate: Sat, 9 Feb 2019 13:14:28 -0500
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 14 Feb 2019 13:31:10 -0300

perf vendor events power9: Branch_prediction, instruction_stats, latency, lsu_rejects, memory, prefetch & translation metrics

Descriptions of metrics for POWER9 processors can be found in the
"POWER9 Performance Monitor Unit User’s Guide", which is currently
available on the "IBM Portal for OpenPOWER"
(https://www-355.ibm.com/systems/power/openpower/welcome.xhtml) at
https://www-355.ibm.com/systems/power/openpower/posting.xhtml?postingId=4948CDE1963C9BCA852582F800718190

This patch is for metric groups:
- branch_prediction
- instruction_stats_percent_per_ref
- latency
- lsu_rejects
- memory
- prefetch
- translation

Plus, some whitespace changes.

Signed-off-by: Paul Clarke <pc@us.ibm.com>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>
Cc: Carl Love <cel@us.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org
Link: http://lkml.kernel.org/r/20190209181429.23950-4-pc@us.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../pmu-events/arch/powerpc/power9/metrics.json    | 403 ++++++++++++++++++++-
 1 file changed, 390 insertions(+), 13 deletions(-)

diff --git a/tools/perf/pmu-events/arch/powerpc/power9/metrics.json b/tools/perf/pmu-events/arch/powerpc/power9/metrics.json
index 166f95518c45..c39a922aaf84 100644
--- a/tools/perf/pmu-events/arch/powerpc/power9/metrics.json
+++ b/tools/perf/pmu-events/arch/powerpc/power9/metrics.json
@@ -1,4 +1,39 @@
 [
+    {
+        "MetricExpr": "PM_BR_MPRED_CMPL / PM_BR_PRED * 100",
+        "MetricGroup": "branch_prediction",
+        "MetricName": "br_misprediction_percent"
+    },
+    {
+        "BriefDescription": "Count cache branch misprediction per instruction",
+        "MetricExpr": "PM_BR_MPRED_CCACHE / PM_RUN_INST_CMPL * 100",
+        "MetricGroup": "branch_prediction",
+        "MetricName": "ccache_mispredict_rate_percent"
+    },
+    {
+        "BriefDescription": "Count cache branch misprediction",
+        "MetricExpr": "PM_BR_MPRED_CCACHE / PM_BR_PRED_CCACHE * 100",
+        "MetricGroup": "branch_prediction",
+        "MetricName": "ccache_misprediction_percent"
+    },
+    {
+        "BriefDescription": "Link stack branch misprediction",
+        "MetricExpr": "PM_BR_MPRED_LSTACK / PM_RUN_INST_CMPL * 100",
+        "MetricGroup": "branch_prediction",
+        "MetricName": "lstack_mispredict_rate_percent"
+    },
+    {
+        "BriefDescription": "Link stack branch misprediction",
+        "MetricExpr": "PM_BR_MPRED_LSTACK/ PM_BR_PRED_LSTACK * 100",
+        "MetricGroup": "branch_prediction",
+        "MetricName": "lstack_misprediction_percent"
+    },
+    {
+        "BriefDescription": "% Branches Taken",
+        "MetricExpr": "PM_BR_TAKEN_CMPL * 100 / PM_BRU_FIN",
+        "MetricGroup": "branch_prediction",
+        "MetricName": "taken_branches_percent"
+    },
     {
         "BriefDescription": "Completion stall due to a Branch Unit",
         "MetricExpr": "PM_CMPLU_STALL_BRU/PM_RUN_INST_CMPL",
@@ -881,13 +916,121 @@
         "MetricName": "l1_inst_miss_rate_percent"
     },
     {
-        "BriefDescription": "%L2 Modified CO  Cache read Utilization (4 pclks per disp attempt)",
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
+    {
+        "BriefDescription": "%L2 Modified CO Cache read Utilization (4 pclks per disp attempt)",
         "MetricExpr": "((PM_L2_CASTOUT_MOD/2)*4)/ PM_RUN_CYC * 100",
         "MetricGroup": "l2_stats",
         "MetricName": "l2_co_m_rd_util"
     },
     {
-        "BriefDescription": "L2  dcache invalidates per run inst  (per core)",
+        "BriefDescription": "L2 dcache invalidates per run inst (per core)",
         "MetricExpr": "(PM_L2_DC_INV / 2) / PM_RUN_INST_CMPL * 100",
         "MetricGroup": "l2_stats",
         "MetricName": "l2_dc_inv_rate_percent"
@@ -899,14 +1042,14 @@
         "MetricName": "l2_dem_ld_disp_percent"
     },
     {
-        "BriefDescription": "L2  Icache invalidates per run inst  (per core)",
+        "BriefDescription": "L2 Icache invalidates per run inst (per core)",
         "MetricExpr": "(PM_L2_IC_INV / 2) / PM_RUN_INST_CMPL * 100",
         "MetricGroup": "l2_stats",
         "MetricName": "l2_ic_inv_rate_percent"
     },
     {
-        "BriefDescription": "L2  Inst misses  as a % of total L2  Inst dispatches (per thread)",
-        "MetricExpr": "PM_L2_INST_MISS /  PM_L2_INST * 100",
+        "BriefDescription": "L2 Inst misses as a % of total L2 Inst dispatches (per thread)",
+        "MetricExpr": "PM_L2_INST_MISS / PM_L2_INST * 100",
         "MetricGroup": "l2_stats",
         "MetricName": "l2_inst_miss_ratio_percent"
     },
@@ -923,7 +1066,7 @@
         "MetricName": "l2_ld_miss_frequency"
     },
     {
-        "BriefDescription": "L2 Load misses  as a % of total L2 Load dispatches (per thread)",
+        "BriefDescription": "L2 Load misses as a % of total L2 Load dispatches (per thread)",
         "MetricExpr": "PM_L2_LD_MISS / PM_L2_LD * 100",
         "MetricGroup": "l2_stats",
         "MetricName": "l2_ld_miss_ratio_percent"
@@ -941,7 +1084,7 @@
         "MetricName": "l2_ldmiss_wr_util"
     },
     {
-        "BriefDescription": "L2  local pump prediction success",
+        "BriefDescription": "L2 local pump prediction success",
         "MetricExpr": "PM_L2_LOC_GUESS_CORRECT / (PM_L2_LOC_GUESS_CORRECT + PM_L2_LOC_GUESS_WRONG) * 100",
         "MetricGroup": "l2_stats",
         "MetricName": "l2_local_pred_correct_percent"
@@ -953,7 +1096,7 @@
         "MetricName": "l2_mod_co_percent"
     },
     {
-        "BriefDescription": "% of L2 Load RC dispatch atampts that failed  because of address collisions and cclass conflicts",
+        "BriefDescription": "% of L2 Load RC dispatch atampts that failed because of address collisions and cclass conflicts",
         "MetricExpr": "(PM_L2_RCLD_DISP_FAIL_ADDR )/ PM_L2_RCLD_DISP * 100",
         "MetricGroup": "l2_stats",
         "MetricName": "l2_rc_ld_disp_addr_fail_percent"
@@ -965,7 +1108,7 @@
         "MetricName": "l2_rc_ld_disp_fail_percent"
     },
     {
-        "BriefDescription": "% of L2 Store RC dispatch atampts that failed  because of address collisions and cclass conflicts",
+        "BriefDescription": "% of L2 Store RC dispatch atampts that failed because of address collisions and cclass conflicts",
         "MetricExpr": "PM_L2_RCST_DISP_FAIL_ADDR / PM_L2_RCST_DISP * 100",
         "MetricGroup": "l2_stats",
         "MetricName": "l2_rc_st_disp_addr_fail_percent"
@@ -983,13 +1126,13 @@
         "MetricName": "l2_rd_util_percent"
     },
     {
-        "BriefDescription": "L2 COs that were in  T,Te,Si,S  state as a % of all L2 COs",
+        "BriefDescription": "L2 COs that were in T,Te,Si,S state as a % of all L2 COs",
         "MetricExpr": "PM_L2_CASTOUT_SHR / (PM_L2_CASTOUT_MOD + PM_L2_CASTOUT_SHR) * 100",
         "MetricGroup": "l2_stats",
         "MetricName": "l2_shr_co_percent"
     },
     {
-        "BriefDescription": "L2  Store misses  as a % of total L2  Store dispatches (per thread)",
+        "BriefDescription": "L2 Store misses as a % of total L2 Store dispatches (per thread)",
         "MetricExpr": "PM_L2_ST_MISS / PM_L2_ST * 100",
         "MetricGroup": "l2_stats",
         "MetricName": "l2_st_miss_ratio_percent"
@@ -1025,13 +1168,205 @@
         "MetricName": "l3_ld_miss_frequency"
     },
     {
-        "BriefDescription": "Average number of Write-in machines used.  1 of 8 WI machines is sampled every L3 cycle",
+        "BriefDescription": "Average number of Write-in machines used. 1 of 8 WI machines is sampled every L3 cycle",
         "MetricExpr": "(PM_L3_WI_USAGE / PM_RUN_CYC) * 8",
         "MetricGroup": "l3_stats",
         "MetricName": "l3_wi_usage"
     },
     {
-        "BriefDescription": "DERAT Miss Rate (per run  instruction)(%)",
+        "BriefDescription": "Average icache miss latency",
+        "MetricExpr": "PM_IC_DEMAND_CYC / PM_IC_DEMAND_REQ",
+        "MetricGroup": "latency",
+        "MetricName": "average_il1_miss_latency"
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
+        "BriefDescription": "average L1 miss latency using marked events",
+        "MetricExpr": "PM_MRK_LD_MISS_L1_CYC / PM_MRK_LD_MISS_L1",
+        "MetricGroup": "latency",
+        "MetricName": "estimated_dl1miss_latency"
+    },
+    {
+        "BriefDescription": "Marked L21 Load latency",
+        "MetricExpr": "PM_MRK_DATA_FROM_L21_MOD_CYC/ PM_MRK_DATA_FROM_L21_MOD",
+        "MetricGroup": "latency",
+        "MetricName": "l21_mod_latency"
+    },
+    {
+        "BriefDescription": "Marked L21 Load latency",
+        "MetricExpr": "PM_MRK_DATA_FROM_L21_SHR_CYC/ PM_MRK_DATA_FROM_L21_SHR",
+        "MetricGroup": "latency",
+        "MetricName": "l21_shr_latency"
+    },
+    {
+        "BriefDescription": "Marked L2 Load latency",
+        "MetricExpr": "PM_MRK_DATA_FROM_L2_CYC/ PM_MRK_DATA_FROM_L2",
+        "MetricGroup": "latency",
+        "MetricName": "l2_latency"
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
+        "BriefDescription": "Marked L3 Load latency",
+        "MetricExpr": "PM_MRK_DATA_FROM_L3_CYC/ PM_MRK_DATA_FROM_L3",
+        "MetricGroup": "latency",
+        "MetricName": "l3_latency"
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
+    {
+        "BriefDescription": "ERAT miss reject ratio",
+        "MetricExpr": "PM_LSU_REJECT_ERAT_MISS * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "lsu_rejects",
+        "MetricName": "erat_reject_rate_percent"
+    },
+    {
+        "BriefDescription": "LHS reject ratio",
+        "MetricExpr": "PM_LSU_REJECT_LHS *100/ PM_RUN_INST_CMPL",
+        "MetricGroup": "lsu_rejects",
+        "MetricName": "lhs_reject_rate_percent"
+    },
+    {
+        "BriefDescription": "ERAT miss reject ratio",
+        "MetricExpr": "PM_LSU_REJECT_LMQ_FULL * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "lsu_rejects",
+        "MetricName": "lmq_full_reject_rate_percent"
+    },
+    {
+        "BriefDescription": "ERAT miss reject ratio",
+        "MetricExpr": "PM_LSU_REJECT_LMQ_FULL * 100 / PM_LD_REF_L1",
+        "MetricGroup": "lsu_rejects",
+        "MetricName": "lmq_full_reject_ratio_percent"
+    },
+    {
+        "BriefDescription": "L4 locality(%)",
+        "MetricExpr": "PM_DATA_FROM_LL4 * 100 / (PM_DATA_FROM_LL4 + PM_DATA_FROM_RL4 + PM_DATA_FROM_DL4)",
+        "MetricGroup": "memory",
+        "MetricName": "l4_locality"
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
+        "MetricExpr": "PM_DATA_FROM_LMEM * 100/ (PM_DATA_FROM_LMEM + PM_DATA_FROM_RMEM + PM_DATA_FROM_DMEM)",
+        "MetricGroup": "memory",
+        "MetricName": "mem_locality_percent"
+    },
+    {
+        "BriefDescription": "L1 Prefetches issued by the prefetch machine per instruction (per thread)",
+        "MetricExpr": "PM_L1_PREF / PM_RUN_INST_CMPL * 100",
+        "MetricGroup": "prefetch",
+        "MetricName": "l1_prefetch_rate_percent"
+    },
+    {
+        "BriefDescription": "DERAT Miss Rate (per run instruction)(%)",
         "MetricExpr": "PM_LSU_DERAT_MISS * 100 / PM_RUN_INST_CMPL",
         "MetricGroup": "pteg_reloads_percent_per_inst",
         "MetricName": "derat_miss_rate_percent"
@@ -1233,5 +1568,47 @@
         "MetricExpr": "PM_DPTEG_FROM_RMEM * 100 / PM_DTLB_MISS",
         "MetricGroup": "pteg_reloads_percent_per_ref",
         "MetricName": "pteg_from_rmem_percent"
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
+        "BriefDescription": "DERAT miss ratio",
+        "MetricExpr": "PM_LSU_DERAT_MISS / PM_LSU_DERAT_MISS",
+        "MetricGroup": "translation",
+        "MetricName": "derat_miss_ratio"
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
     }
 ]
