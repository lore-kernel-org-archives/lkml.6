Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C87C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ACCB206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:31:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404962AbfBOJbC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 04:31:02 -0500
Received: from terminus.zytor.com ([198.137.202.136]:33277 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404940AbfBOJa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 04:30:58 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1F9UP1R1116546
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 15 Feb 2019 01:30:25 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1F9UOmo1116543;
        Fri, 15 Feb 2019 01:30:24 -0800
Date:   Fri, 15 Feb 2019 01:30:24 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Paul Clarke <tipbot@zytor.com>
Message-ID: <tip-0133491d4641b493aa0d0e5bd66b52999619cd8a@git.kernel.org>
Cc:     maddy@linux.vnet.ibm.com, mpe@ellerman.id.au, mingo@kernel.org,
        ananth@linux.vnet.ibm.com, hpa@zytor.com, cel@us.ibm.com,
        pc@us.ibm.com, naveen.n.rao@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, acme@redhat.com,
        sukadev@linux.vnet.ibm.com, tglx@linutronix.de
Reply-To: hpa@zytor.com, ananth@linux.vnet.ibm.com,
          maddy@linux.vnet.ibm.com, mingo@kernel.org, mpe@ellerman.id.au,
          cel@us.ibm.com, naveen.n.rao@linux.vnet.ibm.com, pc@us.ibm.com,
          linux-kernel@vger.kernel.org, sukadev@linux.vnet.ibm.com,
          tglx@linutronix.de, acme@redhat.com
In-Reply-To: <20190209181429.23950-3-pc@us.ibm.com>
References: <20190209181429.23950-3-pc@us.ibm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf vendor events power9: Dl1_reloads,
 instruction_misses, l[23]_stats & pteg_reloads metrics
Git-Commit-ID: 0133491d4641b493aa0d0e5bd66b52999619cd8a
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

Commit-ID:  0133491d4641b493aa0d0e5bd66b52999619cd8a
Gitweb:     https://git.kernel.org/tip/0133491d4641b493aa0d0e5bd66b52999619cd8a
Author:     Paul Clarke <pc@us.ibm.com>
AuthorDate: Sat, 9 Feb 2019 13:14:27 -0500
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 14 Feb 2019 13:31:10 -0300

perf vendor events power9: Dl1_reloads, instruction_misses, l[23]_stats & pteg_reloads metrics

Descriptions of metrics for POWER9 processors can be found in the
"POWER9 Performance Monitor Unit User’s Guide", which is currently
available on the "IBM Portal for OpenPOWER"
(https://www-355.ibm.com/systems/power/openpower/welcome.xhtml) at
https://www-355.ibm.com/systems/power/openpower/posting.xhtml?postingId=4948CDE1963C9BCA852582F800718190

This patch is for metric groups:
- dl1_reloads_percent_per_inst
- dl1_reloads_percent_per_ref
- instruction_misses_percent_per_inst
- l2_stats
- l3_stats
- pteg_reloads_percent_per_inst
- pteg_reloads_percent_per_ref

Signed-off-by: Paul Clarke <pc@us.ibm.com>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>
Cc: Carl Love <cel@us.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org
Link: http://lkml.kernel.org/r/20190209181429.23950-3-pc@us.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../pmu-events/arch/powerpc/power9/metrics.json    | 660 +++++++++++++++++++++
 1 file changed, 660 insertions(+)

diff --git a/tools/perf/pmu-events/arch/powerpc/power9/metrics.json b/tools/perf/pmu-events/arch/powerpc/power9/metrics.json
index cd46ebb8da6a..166f95518c45 100644
--- a/tools/perf/pmu-events/arch/powerpc/power9/metrics.json
+++ b/tools/perf/pmu-events/arch/powerpc/power9/metrics.json
@@ -484,6 +484,210 @@
         "MetricGroup": "cpi_breakdown",
         "MetricName": "vfxu_stall_cpi"
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
+        "BriefDescription": "% of DL1 reloads from L2 per Inst",
+        "MetricExpr": "PM_DATA_FROM_L2MISS * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "dl1_reloads_percent_per_inst",
+        "MetricName": "dl1_reload_from_l2_miss_rate_percent"
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
+        "BriefDescription": "% of DL1 Reloads that came from the L3 and were brought into the L3 by a prefetch, per instruction completed",
+        "MetricExpr": "PM_DATA_FROM_L3_MEPF * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "dl1_reloads_percent_per_inst",
+        "MetricName": "dl1_reload_from_l3_mepf_rate_percent"
+    },
+    {
+        "BriefDescription": "% of DL1 reloads from L3 per Inst",
+        "MetricExpr": "PM_DATA_FROM_L3MISS * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "dl1_reloads_percent_per_inst",
+        "MetricName": "dl1_reload_from_l3_miss_rate_percent"
+    },
+    {
+        "BriefDescription": "% of DL1 Reloads from L3 per Inst",
+        "MetricExpr": "PM_DATA_FROM_L3 * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "dl1_reloads_percent_per_inst",
+        "MetricName": "dl1_reload_from_l3_rate_percent"
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
+        "BriefDescription": "% of DL1 Reloads from sources beyond the local L2",
+        "MetricExpr": "PM_DATA_FROM_L2MISS * 100 / PM_L1_DCACHE_RELOAD_VALID",
+        "MetricGroup": "dl1_reloads_percent_per_ref",
+        "MetricName": "dl1_reload_from_l2_miss_percent"
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
+        "BriefDescription": "% of DL1 Reloads that came from L3 and were brought into the L3 by a prefetch",
+        "MetricExpr": "PM_DATA_FROM_L3_MEPF * 100 / PM_L1_DCACHE_RELOAD_VALID",
+        "MetricGroup": "dl1_reloads_percent_per_ref",
+        "MetricName": "dl1_reload_from_l3_mepf_percent"
+    },
+    {
+        "BriefDescription": "% of DL1 Reloads from sources beyond the local L3",
+        "MetricExpr": "PM_DATA_FROM_L3MISS * 100 / PM_L1_DCACHE_RELOAD_VALID",
+        "MetricGroup": "dl1_reloads_percent_per_ref",
+        "MetricName": "dl1_reload_from_l3_miss_percent"
+    },
+    {
+        "BriefDescription": "% of DL1 Reloads from L3",
+        "MetricExpr": "PM_DATA_FROM_L3 * 100 / PM_L1_DCACHE_RELOAD_VALID",
+        "MetricGroup": "dl1_reloads_percent_per_ref",
+        "MetricName": "dl1_reload_from_l3_percent"
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
+        "BriefDescription": "% of DL1 dL1_Reloads from Remote Memory",
+        "MetricExpr": "PM_DATA_FROM_RMEM * 100 / PM_L1_DCACHE_RELOAD_VALID",
+        "MetricGroup": "dl1_reloads_percent_per_ref",
+        "MetricName": "dl1_reload_from_rmem_percent"
+    },
     {
         "BriefDescription": "estimate of dl2l3 distant MOD miss rates with measured DL2L3 MOD latency as a %of dcache miss cpi",
         "MetricExpr": "PM_DATA_FROM_DL2L3_MOD * PM_MRK_DATA_FROM_DL2L3_MOD_CYC / PM_MRK_DATA_FROM_DL2L3_MOD / PM_CMPLU_STALL_DCACHE_MISS *100",
@@ -573,5 +777,461 @@
         "MetricExpr": "PM_DATA_FROM_RMEM * PM_MRK_DATA_FROM_RMEM_CYC / PM_MRK_DATA_FROM_RMEM / PM_CMPLU_STALL_DCACHE_MISS *100",
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
+        "BriefDescription": "%L2 Modified CO  Cache read Utilization (4 pclks per disp attempt)",
+        "MetricExpr": "((PM_L2_CASTOUT_MOD/2)*4)/ PM_RUN_CYC * 100",
+        "MetricGroup": "l2_stats",
+        "MetricName": "l2_co_m_rd_util"
+    },
+    {
+        "BriefDescription": "L2  dcache invalidates per run inst  (per core)",
+        "MetricExpr": "(PM_L2_DC_INV / 2) / PM_RUN_INST_CMPL * 100",
+        "MetricGroup": "l2_stats",
+        "MetricName": "l2_dc_inv_rate_percent"
+    },
+    {
+        "BriefDescription": "Demand load misses as a % of L2 LD dispatches (per thread)",
+        "MetricExpr": "PM_L1_DCACHE_RELOAD_VALID / (PM_L2_LD / 2) * 100",
+        "MetricGroup": "l2_stats",
+        "MetricName": "l2_dem_ld_disp_percent"
+    },
+    {
+        "BriefDescription": "L2  Icache invalidates per run inst  (per core)",
+        "MetricExpr": "(PM_L2_IC_INV / 2) / PM_RUN_INST_CMPL * 100",
+        "MetricGroup": "l2_stats",
+        "MetricName": "l2_ic_inv_rate_percent"
+    },
+    {
+        "BriefDescription": "L2  Inst misses  as a % of total L2  Inst dispatches (per thread)",
+        "MetricExpr": "PM_L2_INST_MISS /  PM_L2_INST * 100",
+        "MetricGroup": "l2_stats",
+        "MetricName": "l2_inst_miss_ratio_percent"
+    },
+    {
+        "BriefDescription": "Average number of cycles between L2 Load hits",
+        "MetricExpr": "(PM_L2_LD_HIT / PM_RUN_CYC) / 2",
+        "MetricGroup": "l2_stats",
+        "MetricName": "l2_ld_hit_frequency"
+    },
+    {
+        "BriefDescription": "Average number of cycles between L2 Load misses",
+        "MetricExpr": "(PM_L2_LD_MISS / PM_RUN_CYC) / 2",
+        "MetricGroup": "l2_stats",
+        "MetricName": "l2_ld_miss_frequency"
+    },
+    {
+        "BriefDescription": "L2 Load misses  as a % of total L2 Load dispatches (per thread)",
+        "MetricExpr": "PM_L2_LD_MISS / PM_L2_LD * 100",
+        "MetricGroup": "l2_stats",
+        "MetricName": "l2_ld_miss_ratio_percent"
+    },
+    {
+        "BriefDescription": "% L2 load disp attempts Cache read Utilization (4 pclks per disp attempt)",
+        "MetricExpr": "((PM_L2_RCLD_DISP/2)*4)/ PM_RUN_CYC * 100",
+        "MetricGroup": "l2_stats",
+        "MetricName": "l2_ld_rd_util"
+    },
+    {
+        "BriefDescription": "L2 load misses that require a cache write (4 pclks per disp attempt) % of pclks",
+        "MetricExpr": "((( PM_L2_LD_DISP - PM_L2_LD_HIT)/2)*4)/ PM_RUN_CYC * 100",
+        "MetricGroup": "l2_stats",
+        "MetricName": "l2_ldmiss_wr_util"
+    },
+    {
+        "BriefDescription": "L2  local pump prediction success",
+        "MetricExpr": "PM_L2_LOC_GUESS_CORRECT / (PM_L2_LOC_GUESS_CORRECT + PM_L2_LOC_GUESS_WRONG) * 100",
+        "MetricGroup": "l2_stats",
+        "MetricName": "l2_local_pred_correct_percent"
+    },
+    {
+        "BriefDescription": "L2 COs that were in M,Me,Mu state as a % of all L2 COs",
+        "MetricExpr": "PM_L2_CASTOUT_MOD / (PM_L2_CASTOUT_MOD + PM_L2_CASTOUT_SHR) * 100",
+        "MetricGroup": "l2_stats",
+        "MetricName": "l2_mod_co_percent"
+    },
+    {
+        "BriefDescription": "% of L2 Load RC dispatch atampts that failed  because of address collisions and cclass conflicts",
+        "MetricExpr": "(PM_L2_RCLD_DISP_FAIL_ADDR )/ PM_L2_RCLD_DISP * 100",
+        "MetricGroup": "l2_stats",
+        "MetricName": "l2_rc_ld_disp_addr_fail_percent"
+    },
+    {
+        "BriefDescription": "% of L2 Load RC dispatch attempts that failed",
+        "MetricExpr": "(PM_L2_RCLD_DISP_FAIL_ADDR + PM_L2_RCLD_DISP_FAIL_OTHER)/ PM_L2_RCLD_DISP * 100",
+        "MetricGroup": "l2_stats",
+        "MetricName": "l2_rc_ld_disp_fail_percent"
+    },
+    {
+        "BriefDescription": "% of L2 Store RC dispatch atampts that failed  because of address collisions and cclass conflicts",
+        "MetricExpr": "PM_L2_RCST_DISP_FAIL_ADDR / PM_L2_RCST_DISP * 100",
+        "MetricGroup": "l2_stats",
+        "MetricName": "l2_rc_st_disp_addr_fail_percent"
+    },
+    {
+        "BriefDescription": "% of L2 Store RC dispatch attempts that failed",
+        "MetricExpr": "(PM_L2_RCST_DISP_FAIL_ADDR + PM_L2_RCST_DISP_FAIL_OTHER)/ PM_L2_RCST_DISP * 100",
+        "MetricGroup": "l2_stats",
+        "MetricName": "l2_rc_st_disp_fail_percent"
+    },
+    {
+        "BriefDescription": "L2 Cache Read Utilization (per core)",
+        "MetricExpr": "(((PM_L2_RCLD_DISP/2)*4)/ PM_RUN_CYC * 100) + (((PM_L2_RCST_DISP/2)*4)/PM_RUN_CYC * 100) + (((PM_L2_CASTOUT_MOD/2)*4)/PM_RUN_CYC * 100)",
+        "MetricGroup": "l2_stats",
+        "MetricName": "l2_rd_util_percent"
+    },
+    {
+        "BriefDescription": "L2 COs that were in  T,Te,Si,S  state as a % of all L2 COs",
+        "MetricExpr": "PM_L2_CASTOUT_SHR / (PM_L2_CASTOUT_MOD + PM_L2_CASTOUT_SHR) * 100",
+        "MetricGroup": "l2_stats",
+        "MetricName": "l2_shr_co_percent"
+    },
+    {
+        "BriefDescription": "L2  Store misses  as a % of total L2  Store dispatches (per thread)",
+        "MetricExpr": "PM_L2_ST_MISS / PM_L2_ST * 100",
+        "MetricGroup": "l2_stats",
+        "MetricName": "l2_st_miss_ratio_percent"
+    },
+    {
+        "BriefDescription": "% L2 store disp attempts Cache read Utilization (4 pclks per disp attempt)",
+        "MetricExpr": "((PM_L2_RCST_DISP/2)*4) / PM_RUN_CYC * 100",
+        "MetricGroup": "l2_stats",
+        "MetricName": "l2_st_rd_util"
+    },
+    {
+        "BriefDescription": "L2 stores that require a cache write (4 pclks per disp attempt) % of pclks",
+        "MetricExpr": "((PM_L2_ST_DISP/2)*4) / PM_RUN_CYC * 100",
+        "MetricGroup": "l2_stats",
+        "MetricName": "l2_st_wr_util"
+    },
+    {
+        "BriefDescription": "L2 Cache Write Utilization (per core)",
+        "MetricExpr": "((((PM_L2_LD_DISP - PM_L2_LD_HIT)/2)*4) / PM_RUN_CYC * 100) + (((PM_L2_ST_DISP/2)*4) / PM_RUN_CYC * 100)",
+        "MetricGroup": "l2_stats",
+        "MetricName": "l2_wr_util_percent"
+    },
+    {
+        "BriefDescription": "Average number of cycles between L3 Load hits",
+        "MetricExpr": "(PM_L3_LD_HIT / PM_RUN_CYC) / 2",
+        "MetricGroup": "l3_stats",
+        "MetricName": "l3_ld_hit_frequency"
+    },
+    {
+        "BriefDescription": "Average number of cycles between L3 Load misses",
+        "MetricExpr": "(PM_L3_LD_MISS / PM_RUN_CYC) / 2",
+        "MetricGroup": "l3_stats",
+        "MetricName": "l3_ld_miss_frequency"
+    },
+    {
+        "BriefDescription": "Average number of Write-in machines used.  1 of 8 WI machines is sampled every L3 cycle",
+        "MetricExpr": "(PM_L3_WI_USAGE / PM_RUN_CYC) * 8",
+        "MetricGroup": "l3_stats",
+        "MetricName": "l3_wi_usage"
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
