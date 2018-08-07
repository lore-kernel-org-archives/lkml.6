Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC54C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 17:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45C3221533
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 17:18:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45C3221533
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390115AbeHGTdQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 15:33:16 -0400
Received: from mga07.intel.com ([134.134.136.100]:56647 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727354AbeHGTdQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 15:33:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Aug 2018 10:17:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,456,1526367600"; 
   d="scan'208";a="63290537"
Received: from otc-kbl-h-01.jf.intel.com ([10.54.55.131])
  by orsmga008.jf.intel.com with ESMTP; 07 Aug 2018 10:17:57 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, len.brown@intel.com,
        ak@linux.intel.com, linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH] x86/cpu: Rename Denverton and Gemini Lake
Date:   Tue,  7 Aug 2018 10:17:27 -0700
Message-Id: <1533662247-17575-1-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Denverton and Gemini Lake are platform names and should not be used for
Processor Family stuff. The microarchitecture codename should be used.

DENVERTON is Goldmont server SoC. Rename DENVERTON to GOLDMONT2, similar
to SILVERMONT2 being the silvermont server SoCs.

Rename GEMINI_LAKE to GOLDMONT_PLUS.

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/core.c                   |  4 ++--
 arch/x86/events/intel/cstate.c                 |  4 ++--
 arch/x86/events/intel/rapl.c                   |  4 ++--
 arch/x86/events/msr.c                          |  4 ++--
 arch/x86/include/asm/intel-family.h            |  4 ++--
 arch/x86/kernel/tsc.c                          |  2 +-
 drivers/cpufreq/intel_pstate.c                 |  2 +-
 drivers/edac/pnd2_edac.c                       |  2 +-
 drivers/idle/intel_idle.c                      |  6 +++---
 drivers/platform/x86/intel_telemetry_debugfs.c |  2 +-
 drivers/platform/x86/intel_telemetry_pltdrv.c  |  2 +-
 drivers/powercap/intel_rapl.c                  |  4 ++--
 tools/power/x86/turbostat/turbostat.c          | 22 +++++++++++-----------
 13 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 035c374..e2d36491 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4042,7 +4042,7 @@ __init int intel_pmu_init(void)
 		break;
 
 	case INTEL_FAM6_ATOM_GOLDMONT:
-	case INTEL_FAM6_ATOM_DENVERTON:
+	case INTEL_FAM6_ATOM_GOLDMONT2:
 		memcpy(hw_cache_event_ids, glm_hw_cache_event_ids,
 		       sizeof(hw_cache_event_ids));
 		memcpy(hw_cache_extra_regs, glm_hw_cache_extra_regs,
@@ -4068,7 +4068,7 @@ __init int intel_pmu_init(void)
 		name = "goldmont";
 		break;
 
-	case INTEL_FAM6_ATOM_GEMINI_LAKE:
+	case INTEL_FAM6_ATOM_GOLDMONT_PLUS:
 		memcpy(hw_cache_event_ids, glp_hw_cache_event_ids,
 		       sizeof(hw_cache_event_ids));
 		memcpy(hw_cache_extra_regs, glp_hw_cache_extra_regs,
diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index 9f8084f..be98b29 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -581,9 +581,9 @@ static const struct x86_cpu_id intel_cstates_match[] __initconst = {
 	X86_CSTATES_MODEL(INTEL_FAM6_XEON_PHI_KNM, knl_cstates),
 
 	X86_CSTATES_MODEL(INTEL_FAM6_ATOM_GOLDMONT, glm_cstates),
-	X86_CSTATES_MODEL(INTEL_FAM6_ATOM_DENVERTON, glm_cstates),
+	X86_CSTATES_MODEL(INTEL_FAM6_ATOM_GOLDMONT2, glm_cstates),
 
-	X86_CSTATES_MODEL(INTEL_FAM6_ATOM_GEMINI_LAKE, glm_cstates),
+	X86_CSTATES_MODEL(INTEL_FAM6_ATOM_GOLDMONT_PLUS, glm_cstates),
 	{ },
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_cstates_match);
diff --git a/arch/x86/events/intel/rapl.c b/arch/x86/events/intel/rapl.c
index 32f3e94..cb191c0 100644
--- a/arch/x86/events/intel/rapl.c
+++ b/arch/x86/events/intel/rapl.c
@@ -777,9 +777,9 @@ static const struct x86_cpu_id rapl_cpu_match[] __initconst = {
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_CANNONLAKE_MOBILE,  skl_rapl_init),
 
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_ATOM_GOLDMONT, hsw_rapl_init),
-	X86_RAPL_MODEL_MATCH(INTEL_FAM6_ATOM_DENVERTON, hsw_rapl_init),
+	X86_RAPL_MODEL_MATCH(INTEL_FAM6_ATOM_GOLDMONT2, hsw_rapl_init),
 
-	X86_RAPL_MODEL_MATCH(INTEL_FAM6_ATOM_GEMINI_LAKE, hsw_rapl_init),
+	X86_RAPL_MODEL_MATCH(INTEL_FAM6_ATOM_GOLDMONT_PLUS, hsw_rapl_init),
 	{},
 };
 
diff --git a/arch/x86/events/msr.c b/arch/x86/events/msr.c
index b4771a6..db8ed47 100644
--- a/arch/x86/events/msr.c
+++ b/arch/x86/events/msr.c
@@ -74,9 +74,9 @@ static bool test_intel(int idx)
 	case INTEL_FAM6_ATOM_AIRMONT:
 
 	case INTEL_FAM6_ATOM_GOLDMONT:
-	case INTEL_FAM6_ATOM_DENVERTON:
+	case INTEL_FAM6_ATOM_GOLDMONT2:
 
-	case INTEL_FAM6_ATOM_GEMINI_LAKE:
+	case INTEL_FAM6_ATOM_GOLDMONT_PLUS:
 
 	case INTEL_FAM6_XEON_PHI_KNL:
 	case INTEL_FAM6_XEON_PHI_KNM:
diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index cf090e5..60bbb2d 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -68,8 +68,8 @@
 #define INTEL_FAM6_ATOM_MERRIFIELD	0x4A /* Tangier */
 #define INTEL_FAM6_ATOM_MOOREFIELD	0x5A /* Anniedale */
 #define INTEL_FAM6_ATOM_GOLDMONT	0x5C
-#define INTEL_FAM6_ATOM_DENVERTON	0x5F /* Goldmont Microserver */
-#define INTEL_FAM6_ATOM_GEMINI_LAKE	0x7A
+#define INTEL_FAM6_ATOM_GOLDMONT2	0x5F /* Goldmont Microserver */
+#define INTEL_FAM6_ATOM_GOLDMONT_PLUS	0x7A
 
 /* Xeon Phi */
 
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 74392d9..3ba9469 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -620,7 +620,7 @@ unsigned long native_calibrate_tsc(void)
 		case INTEL_FAM6_KABYLAKE_DESKTOP:
 			crystal_khz = 24000;	/* 24.0 MHz */
 			break;
-		case INTEL_FAM6_ATOM_DENVERTON:
+		case INTEL_FAM6_ATOM_GOLDMONT2:
 			crystal_khz = 25000;	/* 25.0 MHz */
 			break;
 		case INTEL_FAM6_ATOM_GOLDMONT:
diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 3c39712..e342c65 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1785,7 +1785,7 @@ static const struct x86_cpu_id intel_pstate_cpu_ids[] = {
 	ICPU(INTEL_FAM6_XEON_PHI_KNL,		knl_funcs),
 	ICPU(INTEL_FAM6_XEON_PHI_KNM,		knl_funcs),
 	ICPU(INTEL_FAM6_ATOM_GOLDMONT,		core_funcs),
-	ICPU(INTEL_FAM6_ATOM_GEMINI_LAKE,       core_funcs),
+	ICPU(INTEL_FAM6_ATOM_GOLDMONT_PLUS,     core_funcs),
 	ICPU(INTEL_FAM6_SKYLAKE_X,		core_funcs),
 	{}
 };
diff --git a/drivers/edac/pnd2_edac.c b/drivers/edac/pnd2_edac.c
index df28b65..6a33c7e 100644
--- a/drivers/edac/pnd2_edac.c
+++ b/drivers/edac/pnd2_edac.c
@@ -1541,7 +1541,7 @@ static struct dunit_ops dnv_ops = {
 
 static const struct x86_cpu_id pnd2_cpuids[] = {
 	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_ATOM_GOLDMONT, 0, (kernel_ulong_t)&apl_ops },
-	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_ATOM_DENVERTON, 0, (kernel_ulong_t)&dnv_ops },
+	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_ATOM_GOLDMONT2, 0, (kernel_ulong_t)&dnv_ops },
 	{ }
 };
 MODULE_DEVICE_TABLE(x86cpu, pnd2_cpuids);
diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index b2ccce5..0203b76 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1104,8 +1104,8 @@ static const struct x86_cpu_id intel_idle_ids[] __initconst = {
 	ICPU(INTEL_FAM6_XEON_PHI_KNL,		idle_cpu_knl),
 	ICPU(INTEL_FAM6_XEON_PHI_KNM,		idle_cpu_knl),
 	ICPU(INTEL_FAM6_ATOM_GOLDMONT,		idle_cpu_bxt),
-	ICPU(INTEL_FAM6_ATOM_GEMINI_LAKE,	idle_cpu_bxt),
-	ICPU(INTEL_FAM6_ATOM_DENVERTON,		idle_cpu_dnv),
+	ICPU(INTEL_FAM6_ATOM_GOLDMONT_PLUS,	idle_cpu_bxt),
+	ICPU(INTEL_FAM6_ATOM_GOLDMONT2,	idle_cpu_dnv),
 	{}
 };
 
@@ -1322,7 +1322,7 @@ static void intel_idle_state_table_update(void)
 		ivt_idle_state_table_update();
 		break;
 	case INTEL_FAM6_ATOM_GOLDMONT:
-	case INTEL_FAM6_ATOM_GEMINI_LAKE:
+	case INTEL_FAM6_ATOM_GOLDMONT_PLUS:
 		bxt_idle_state_table_update();
 		break;
 	case INTEL_FAM6_SKYLAKE_DESKTOP:
diff --git a/drivers/platform/x86/intel_telemetry_debugfs.c b/drivers/platform/x86/intel_telemetry_debugfs.c
index ffd0474..cee08f2 100644
--- a/drivers/platform/x86/intel_telemetry_debugfs.c
+++ b/drivers/platform/x86/intel_telemetry_debugfs.c
@@ -320,7 +320,7 @@ static struct telemetry_debugfs_conf telem_apl_debugfs_conf = {
 
 static const struct x86_cpu_id telemetry_debugfs_cpu_ids[] = {
 	TELEM_DEBUGFS_CPU(INTEL_FAM6_ATOM_GOLDMONT, telem_apl_debugfs_conf),
-	TELEM_DEBUGFS_CPU(INTEL_FAM6_ATOM_GEMINI_LAKE, telem_apl_debugfs_conf),
+	TELEM_DEBUGFS_CPU(INTEL_FAM6_ATOM_GOLDMONT_PLUS, telem_apl_debugfs_conf),
 	{}
 };
 
diff --git a/drivers/platform/x86/intel_telemetry_pltdrv.c b/drivers/platform/x86/intel_telemetry_pltdrv.c
index 2f889d6..fcc6bee 100644
--- a/drivers/platform/x86/intel_telemetry_pltdrv.c
+++ b/drivers/platform/x86/intel_telemetry_pltdrv.c
@@ -192,7 +192,7 @@ static struct telemetry_plt_config telem_glk_config = {
 
 static const struct x86_cpu_id telemetry_cpu_ids[] = {
 	TELEM_CPU(INTEL_FAM6_ATOM_GOLDMONT, telem_apl_config),
-	TELEM_CPU(INTEL_FAM6_ATOM_GEMINI_LAKE, telem_glk_config),
+	TELEM_CPU(INTEL_FAM6_ATOM_GOLDMONT_PLUS, telem_glk_config),
 	{}
 };
 
diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
index 295d8dc..5effdac 100644
--- a/drivers/powercap/intel_rapl.c
+++ b/drivers/powercap/intel_rapl.c
@@ -1169,8 +1169,8 @@ static const struct x86_cpu_id rapl_ids[] __initconst = {
 	RAPL_CPU(INTEL_FAM6_ATOM_MERRIFIELD,	rapl_defaults_tng),
 	RAPL_CPU(INTEL_FAM6_ATOM_MOOREFIELD,	rapl_defaults_ann),
 	RAPL_CPU(INTEL_FAM6_ATOM_GOLDMONT,	rapl_defaults_core),
-	RAPL_CPU(INTEL_FAM6_ATOM_GEMINI_LAKE,	rapl_defaults_core),
-	RAPL_CPU(INTEL_FAM6_ATOM_DENVERTON,	rapl_defaults_core),
+	RAPL_CPU(INTEL_FAM6_ATOM_GOLDMONT_PLUS,	rapl_defaults_core),
+	RAPL_CPU(INTEL_FAM6_ATOM_GOLDMONT2,	rapl_defaults_core),
 
 	RAPL_CPU(INTEL_FAM6_XEON_PHI_KNL,	rapl_defaults_hsw_server),
 	RAPL_CPU(INTEL_FAM6_XEON_PHI_KNM,	rapl_defaults_hsw_server),
diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 4d14bbb..2949775 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -2084,7 +2084,7 @@ int has_turbo_ratio_group_limits(int family, int model)
 	switch (model) {
 	case INTEL_FAM6_ATOM_GOLDMONT:
 	case INTEL_FAM6_SKYLAKE_X:
-	case INTEL_FAM6_ATOM_DENVERTON:
+	case INTEL_FAM6_ATOM_GOLDMONT2:
 		return 1;
 	}
 	return 0;
@@ -3177,8 +3177,8 @@ int probe_nhm_msrs(unsigned int family, unsigned int model)
 		pkg_cstate_limits = phi_pkg_cstate_limits;
 		break;
 	case INTEL_FAM6_ATOM_GOLDMONT:	/* BXT */
-	case INTEL_FAM6_ATOM_GEMINI_LAKE:
-	case INTEL_FAM6_ATOM_DENVERTON:	/* DNV */
+	case INTEL_FAM6_ATOM_GOLDMONT_PLUS:
+	case INTEL_FAM6_ATOM_GOLDMONT2:	/* DNV */
 		pkg_cstate_limits = bxt_pkg_cstate_limits;
 		break;
 	default:
@@ -3221,7 +3221,7 @@ int is_dnv(unsigned int family, unsigned int model)
 		return 0;
 
 	switch (model) {
-	case INTEL_FAM6_ATOM_DENVERTON:
+	case INTEL_FAM6_ATOM_GOLDMONT2:
 		return 1;
 	}
 	return 0;
@@ -3805,7 +3805,7 @@ void rapl_probe(unsigned int family, unsigned int model)
 		}
 		break;
 	case INTEL_FAM6_ATOM_GOLDMONT:	/* BXT */
-	case INTEL_FAM6_ATOM_GEMINI_LAKE:
+	case INTEL_FAM6_ATOM_GOLDMONT_PLUS:
 		do_rapl = RAPL_PKG | RAPL_PKG_POWER_INFO;
 		if (rapl_joules)
 			BIC_PRESENT(BIC_Pkg_J);
@@ -3875,7 +3875,7 @@ void rapl_probe(unsigned int family, unsigned int model)
 			BIC_PRESENT(BIC_CorWatt);
 		}
 		break;
-	case INTEL_FAM6_ATOM_DENVERTON:	/* DNV */
+	case INTEL_FAM6_ATOM_GOLDMONT2:	/* DNV */
 		do_rapl = RAPL_PKG | RAPL_DRAM | RAPL_DRAM_POWER_INFO | RAPL_DRAM_PERF_STATUS | RAPL_PKG_PERF_STATUS | RAPL_PKG_POWER_INFO | RAPL_CORES_ENERGY_STATUS;
 		BIC_PRESENT(BIC_PKG__);
 		BIC_PRESENT(BIC_RAM__);
@@ -4155,8 +4155,8 @@ int has_snb_msrs(unsigned int family, unsigned int model)
 	case INTEL_FAM6_CANNONLAKE_MOBILE:	/* CNL */
 	case INTEL_FAM6_SKYLAKE_X:	/* SKX */
 	case INTEL_FAM6_ATOM_GOLDMONT:	/* BXT */
-	case INTEL_FAM6_ATOM_GEMINI_LAKE:
-	case INTEL_FAM6_ATOM_DENVERTON:	/* DNV */
+	case INTEL_FAM6_ATOM_GOLDMONT_PLUS:
+	case INTEL_FAM6_ATOM_GOLDMONT2:	/* DNV */
 		return 1;
 	}
 	return 0;
@@ -4188,7 +4188,7 @@ int has_hsw_msrs(unsigned int family, unsigned int model)
 	case INTEL_FAM6_KABYLAKE_DESKTOP:	/* KBL */
 	case INTEL_FAM6_CANNONLAKE_MOBILE:	/* CNL */
 	case INTEL_FAM6_ATOM_GOLDMONT:	/* BXT */
-	case INTEL_FAM6_ATOM_GEMINI_LAKE:
+	case INTEL_FAM6_ATOM_GOLDMONT_PLUS:
 		return 1;
 	}
 	return 0;
@@ -4593,11 +4593,11 @@ void process_cpuid()
 				case INTEL_FAM6_KABYLAKE_DESKTOP:	/* KBL */
 					crystal_hz = 24000000;	/* 24.0 MHz */
 					break;
-				case INTEL_FAM6_ATOM_DENVERTON:	/* DNV */
+				case INTEL_FAM6_ATOM_GOLDMONT2:	/* DNV */
 					crystal_hz = 25000000;	/* 25.0 MHz */
 					break;
 				case INTEL_FAM6_ATOM_GOLDMONT:	/* BXT */
-				case INTEL_FAM6_ATOM_GEMINI_LAKE:
+				case INTEL_FAM6_ATOM_GOLDMONT_PLUS:
 					crystal_hz = 19200000;	/* 19.2 MHz */
 					break;
 				default:
-- 
2.7.4

