Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D40DC004D5
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2003B21712
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:25:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eFsuQp+9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2003B21712
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbeI0Uo2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 16:44:28 -0400
Received: from merlin.infradead.org ([205.233.59.134]:37720 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727377AbeI0Uo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 16:44:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=cGVZtKkCVH1oy95ts6IZ7ZWMgXLitnoOO/nSQ6RBe5c=; b=eFsuQp+9h8SFdvZmLLJzqre5h
        N9jjjR/cs9Lr4OzN2cvQUfvP1VWIyYyDUDwryOcZijfRJE/4/ujVJrJSo5GbwDNLyxqGizmezX/Ue
        knsueahQvPxqzUSKkqb4PjrRtStIrVJxMq9h0pVQH2HJcn3ScRz1VGUj5Fw8uMGplKrCidez/f3yi
        3hM0mMsVCKmOfSGU9z2TrPSzKgtFNd15njyupTxQJ30a9oqJjX5GS6hs8iLspUoHeOqKrIohX0iS3
        VQBFAtLKOCcDIctl0IxkNn0m/mIw6pAiEL4Gnj+iQeGycZfUCvpgyKuKZNmghvO563eeLskYi0/xN
        u9PkH8iew==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g5XEJ-0007dZ-GI; Thu, 27 Sep 2018 14:25:44 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7E6F7210708E0; Thu, 27 Sep 2018 16:25:19 +0200 (CEST)
Date:   Thu, 27 Sep 2018 16:25:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        kan.liang@linux.intel.com, mingo@redhat.com, len.brown@intel.com,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH] x86/cpu: Rename Denverton and Gemini Lake
Message-ID: <20180927142519.GB3439@hirez.programming.kicks-ass.net>
References: <1533662247-17575-1-git-send-email-kan.liang@linux.intel.com>
 <1b7cb461-5321-86cf-3031-5ff545c3dc42@linux.intel.com>
 <20180807174851.GJ2494@hirez.programming.kicks-ass.net>
 <20180807183736.GR4238@tassilo.jf.intel.com>
 <alpine.DEB.2.21.1808072257080.1672@nanos.tec.linutronix.de>
 <20180807221725.GU4238@tassilo.jf.intel.com>
 <alpine.DEB.2.21.1808080653120.1672@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1808080653120.1672@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 08, 2018 at 07:14:52AM +0200, Thomas Gleixner wrote:

> We have that for the big cores as well:
> 
> #define INTEL_FAM6_HASWELL_CORE         0x3C
> #define INTEL_FAM6_HASWELL_X            0x3F
> #define INTEL_FAM6_HASWELL_ULT          0x45
> #define INTEL_FAM6_HASWELL_GT3E         0x46
> 
> Why would we treat ATOM differently? It's all the same scheme:
> 
> SILVERMONT_CLIENT  	0x37	     Baytrail, Valleyview
> SILVERMONT_SERVER	0x40	     Avaton, Rangely
> 
> and on goldmont it's not any different.
> 
> We really want one scheme for both Core and ATOM and not randomly picked
> different ones. For the kernel (aside of some peripheral stuff) the most
> interesting information is the UARCH plus the extra features which are
> enabled on a particular SoC.
> 
> The current naming scheme e.g. for SILVERMONT is utter crap because the 1/2
> variants are in fact CLIENT/SERVER and the comment in the header file, that
> there is no better name, is just silly.

OK, I spend a lot of time googling various things and came up with the
below. TL;DR:

/* "Small Core" Processors (Atom) */

#define INTEL_FAM6_ATOM_BONNELL		0x1C /* Diamondville, Pineview */
#define INTEL_FAM6_ATOM_BONNELL_MID	0x26 /* Silverthorne, Lincroft */

#define INTEL_FAM6_ATOM_SALTWELL	0x36 /* Cedarview */
#define INTEL_FAM6_ATOM_SALTWELL_MID	0x27 /* Penwell */
#define INTEL_FAM6_ATOM_SALTWELL_TABLET	0x35 /* Cloverview */

#define INTEL_FAM6_ATOM_SILVERMONT	0x37 /* Bay Trail, Valleyview */
#define INTEL_FAM6_ATOM_SILVERMONT_X	0x4D /* Avaton, Rangely */
#define INTEL_FAM6_ATOM_SILVERMONT_MID	0x4A /* Merriefield */

#define INTEL_FAM6_ATOM_AIRMONT		0x4C /* Cherry Trail, Braswell */
#define INTEL_FAM6_ATOM_AIRMONT_MID	0x5A /* Moorefield */

#define INTEL_FAM6_ATOM_GOLDMONT	0x5C /* Apollo Lake */
#define INTEL_FAM6_ATOM_GOLDMONT_X	0x5F /* Denvertor */
#define INTEL_FAM6_ATOM_GOLDMONT_PLUS	0x7A /* Gemini Lake */


---
Subject: x86/cpu: Sanitize FAM6_ATOM naming
From: Peter Zijlstra <peterz@infradead.org>
Date: Tue, 7 Aug 2018 10:17:27 -0700

Going primarily by:

  https://en.wikipedia.org/wiki/List_of_Intel_Atom_microprocessors#Silvermont_microarchitecture

with additional information gleaned from other related pages; notably:

 - Bonnell shrink was called Saltwell
 - Moorefield is the Merriefield refresh which makes it Airmont

The general naming scheme is: FAM6_ATOM_UARCH_SOCTYPE

Cc: x86@kernel.org
Cc: mingo@redhat.com
Cc: ak@linux.intel.com
Cc: tglx@linutronix.de
Cc: dave.hansen@linux.intel.com
Cc: len.brown@intel.com
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/events/intel/core.c                          |   20 ++++---
 arch/x86/events/intel/cstate.c                        |    8 +--
 arch/x86/events/intel/rapl.c                          |    4 -
 arch/x86/events/msr.c                                 |    8 +--
 arch/x86/include/asm/intel-family.h                   |   33 ++++++------
 arch/x86/kernel/cpu/common.c                          |   24 ++++-----
 arch/x86/kernel/tsc.c                                 |    2 
 arch/x86/kernel/tsc_msr.c                             |    4 -
 arch/x86/platform/atom/punit_atom_debug.c             |    4 -
 arch/x86/platform/intel-mid/device_libs/platform_bt.c |    2 
 drivers/acpi/acpi_lpss.c                              |    2 
 drivers/acpi/x86/utils.c                              |    2 
 drivers/cpufreq/intel_pstate.c                        |    4 -
 drivers/edac/pnd2_edac.c                              |    2 
 drivers/idle/intel_idle.c                             |   18 +++----
 drivers/mmc/host/sdhci-acpi.c                         |    2 
 drivers/pci/pci-mid.c                                 |    4 -
 drivers/platform/x86/intel_int0002_vgpio.c            |    2 
 drivers/platform/x86/intel_mid_powerbtn.c             |    4 -
 drivers/platform/x86/intel_telemetry_debugfs.c        |    2 
 drivers/platform/x86/intel_telemetry_pltdrv.c         |    2 
 drivers/powercap/intel_rapl.c                         |   10 +--
 drivers/thermal/intel_soc_dts_thermal.c               |    2 
 sound/soc/intel/boards/bytcr_rt5651.c                 |    2 
 tools/power/x86/turbostat/turbostat.c                 |   46 +++++++++---------
 25 files changed, 108 insertions(+), 105 deletions(-)

--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4121,11 +4121,11 @@ __init int intel_pmu_init(void)
 		name = "nehalem";
 		break;
 
-	case INTEL_FAM6_ATOM_PINEVIEW:
-	case INTEL_FAM6_ATOM_LINCROFT:
-	case INTEL_FAM6_ATOM_PENWELL:
-	case INTEL_FAM6_ATOM_CLOVERVIEW:
-	case INTEL_FAM6_ATOM_CEDARVIEW:
+	case INTEL_FAM6_ATOM_BONNELL:
+	case INTEL_FAM6_ATOM_BONNELL_MID:
+	case INTEL_FAM6_ATOM_SALTWELL:
+	case INTEL_FAM6_ATOM_SALTWELL_MID:
+	case INTEL_FAM6_ATOM_SALTWELL_TABLET:
 		memcpy(hw_cache_event_ids, atom_hw_cache_event_ids,
 		       sizeof(hw_cache_event_ids));
 
@@ -4138,9 +4138,11 @@ __init int intel_pmu_init(void)
 		name = "bonnell";
 		break;
 
-	case INTEL_FAM6_ATOM_SILVERMONT1:
-	case INTEL_FAM6_ATOM_SILVERMONT2:
+	case INTEL_FAM6_ATOM_SILVERMONT:
+	case INTEL_FAM6_ATOM_SILVERMONT_X:
+	case INTEL_FAM6_ATOM_SILVERMONT_MID:
 	case INTEL_FAM6_ATOM_AIRMONT:
+	case INTEL_FAM6_ATOM_AIRMONT_MID:
 		memcpy(hw_cache_event_ids, slm_hw_cache_event_ids,
 			sizeof(hw_cache_event_ids));
 		memcpy(hw_cache_extra_regs, slm_hw_cache_extra_regs,
@@ -4159,7 +4161,7 @@ __init int intel_pmu_init(void)
 		break;
 
 	case INTEL_FAM6_ATOM_GOLDMONT:
-	case INTEL_FAM6_ATOM_DENVERTON:
+	case INTEL_FAM6_ATOM_GOLDMONT_X:
 		memcpy(hw_cache_event_ids, glm_hw_cache_event_ids,
 		       sizeof(hw_cache_event_ids));
 		memcpy(hw_cache_extra_regs, glm_hw_cache_extra_regs,
@@ -4185,7 +4187,7 @@ __init int intel_pmu_init(void)
 		name = "goldmont";
 		break;
 
-	case INTEL_FAM6_ATOM_GEMINI_LAKE:
+	case INTEL_FAM6_ATOM_GOLDMONT_PLUS:
 		memcpy(hw_cache_event_ids, glp_hw_cache_event_ids,
 		       sizeof(hw_cache_event_ids));
 		memcpy(hw_cache_extra_regs, glp_hw_cache_extra_regs,
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -559,8 +559,8 @@ static const struct x86_cpu_id intel_cst
 
 	X86_CSTATES_MODEL(INTEL_FAM6_HASWELL_ULT, hswult_cstates),
 
-	X86_CSTATES_MODEL(INTEL_FAM6_ATOM_SILVERMONT1, slm_cstates),
-	X86_CSTATES_MODEL(INTEL_FAM6_ATOM_SILVERMONT2, slm_cstates),
+	X86_CSTATES_MODEL(INTEL_FAM6_ATOM_SILVERMONT, slm_cstates),
+	X86_CSTATES_MODEL(INTEL_FAM6_ATOM_SILVERMONT_X, slm_cstates),
 	X86_CSTATES_MODEL(INTEL_FAM6_ATOM_AIRMONT,     slm_cstates),
 
 	X86_CSTATES_MODEL(INTEL_FAM6_BROADWELL_CORE,   snb_cstates),
@@ -581,9 +581,9 @@ static const struct x86_cpu_id intel_cst
 	X86_CSTATES_MODEL(INTEL_FAM6_XEON_PHI_KNM, knl_cstates),
 
 	X86_CSTATES_MODEL(INTEL_FAM6_ATOM_GOLDMONT, glm_cstates),
-	X86_CSTATES_MODEL(INTEL_FAM6_ATOM_DENVERTON, glm_cstates),
+	X86_CSTATES_MODEL(INTEL_FAM6_ATOM_GOLDMONT_X, glm_cstates),
 
-	X86_CSTATES_MODEL(INTEL_FAM6_ATOM_GEMINI_LAKE, glm_cstates),
+	X86_CSTATES_MODEL(INTEL_FAM6_ATOM_GOLDMONT_PLUS, glm_cstates),
 	{ },
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_cstates_match);
--- a/arch/x86/events/intel/rapl.c
+++ b/arch/x86/events/intel/rapl.c
@@ -777,9 +777,9 @@ static const struct x86_cpu_id rapl_cpu_
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_CANNONLAKE_MOBILE,  skl_rapl_init),
 
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_ATOM_GOLDMONT, hsw_rapl_init),
-	X86_RAPL_MODEL_MATCH(INTEL_FAM6_ATOM_DENVERTON, hsw_rapl_init),
+	X86_RAPL_MODEL_MATCH(INTEL_FAM6_ATOM_GOLDMONT_X, hsw_rapl_init),
 
-	X86_RAPL_MODEL_MATCH(INTEL_FAM6_ATOM_GEMINI_LAKE, hsw_rapl_init),
+	X86_RAPL_MODEL_MATCH(INTEL_FAM6_ATOM_GOLDMONT_PLUS, hsw_rapl_init),
 	{},
 };
 
--- a/arch/x86/events/msr.c
+++ b/arch/x86/events/msr.c
@@ -69,14 +69,14 @@ static bool test_intel(int idx)
 	case INTEL_FAM6_BROADWELL_GT3E:
 	case INTEL_FAM6_BROADWELL_X:
 
-	case INTEL_FAM6_ATOM_SILVERMONT1:
-	case INTEL_FAM6_ATOM_SILVERMONT2:
+	case INTEL_FAM6_ATOM_SILVERMONT:
+	case INTEL_FAM6_ATOM_SILVERMONT_X:
 	case INTEL_FAM6_ATOM_AIRMONT:
 
 	case INTEL_FAM6_ATOM_GOLDMONT:
-	case INTEL_FAM6_ATOM_DENVERTON:
+	case INTEL_FAM6_ATOM_GOLDMONT_X:
 
-	case INTEL_FAM6_ATOM_GEMINI_LAKE:
+	case INTEL_FAM6_ATOM_GOLDMONT_PLUS:
 
 	case INTEL_FAM6_XEON_PHI_KNL:
 	case INTEL_FAM6_XEON_PHI_KNM:
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -8,9 +8,6 @@
  * The "_X" parts are generally the EP and EX Xeons, or the
  * "Extreme" ones, like Broadwell-E.
  *
- * Things ending in "2" are usually because we have no better
- * name for them.  There's no processor called "SILVERMONT2".
- *
  * While adding a new CPUID for a new microarchitecture, add a new
  * group to keep logically sorted out in chronological order. Within
  * that group keep the CPUID for the variants sorted by model number.
@@ -57,19 +54,23 @@
 
 /* "Small Core" Processors (Atom) */
 
-#define INTEL_FAM6_ATOM_PINEVIEW	0x1C
-#define INTEL_FAM6_ATOM_LINCROFT	0x26
-#define INTEL_FAM6_ATOM_PENWELL		0x27
-#define INTEL_FAM6_ATOM_CLOVERVIEW	0x35
-#define INTEL_FAM6_ATOM_CEDARVIEW	0x36
-#define INTEL_FAM6_ATOM_SILVERMONT1	0x37 /* BayTrail/BYT / Valleyview */
-#define INTEL_FAM6_ATOM_SILVERMONT2	0x4D /* Avaton/Rangely */
-#define INTEL_FAM6_ATOM_AIRMONT		0x4C /* CherryTrail / Braswell */
-#define INTEL_FAM6_ATOM_MERRIFIELD	0x4A /* Tangier */
-#define INTEL_FAM6_ATOM_MOOREFIELD	0x5A /* Anniedale */
-#define INTEL_FAM6_ATOM_GOLDMONT	0x5C
-#define INTEL_FAM6_ATOM_DENVERTON	0x5F /* Goldmont Microserver */
-#define INTEL_FAM6_ATOM_GEMINI_LAKE	0x7A
+#define INTEL_FAM6_ATOM_BONNELL		0x1C /* Diamondville, Pineview */
+#define INTEL_FAM6_ATOM_BONNELL_MID	0x26 /* Silverthorne, Lincroft */
+
+#define INTEL_FAM6_ATOM_SALTWELL	0x36 /* Cedarview */
+#define INTEL_FAM6_ATOM_SALTWELL_MID	0x27 /* Penwell */
+#define INTEL_FAM6_ATOM_SALTWELL_TABLET	0x35 /* Cloverview */
+
+#define INTEL_FAM6_ATOM_SILVERMONT	0x37 /* Bay Trail, Valleyview */
+#define INTEL_FAM6_ATOM_SILVERMONT_X	0x4D /* Avaton, Rangely */
+#define INTEL_FAM6_ATOM_SILVERMONT_MID	0x4A /* Merriefield */
+
+#define INTEL_FAM6_ATOM_AIRMONT		0x4C /* Cherry Trail, Braswell */
+#define INTEL_FAM6_ATOM_AIRMONT_MID	0x5A /* Moorefield */
+
+#define INTEL_FAM6_ATOM_GOLDMONT	0x5C /* Apollo Lake */
+#define INTEL_FAM6_ATOM_GOLDMONT_X	0x5F /* Denvertor */
+#define INTEL_FAM6_ATOM_GOLDMONT_PLUS	0x7A /* Gemini Lake */
 
 /* Xeon Phi */
 
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -949,11 +949,11 @@ static void identify_cpu_without_cpuid(s
 }
 
 static const __initconst struct x86_cpu_id cpu_no_speculation[] = {
-	{ X86_VENDOR_INTEL,	6, INTEL_FAM6_ATOM_CEDARVIEW,	X86_FEATURE_ANY },
-	{ X86_VENDOR_INTEL,	6, INTEL_FAM6_ATOM_CLOVERVIEW,	X86_FEATURE_ANY },
-	{ X86_VENDOR_INTEL,	6, INTEL_FAM6_ATOM_LINCROFT,	X86_FEATURE_ANY },
-	{ X86_VENDOR_INTEL,	6, INTEL_FAM6_ATOM_PENWELL,	X86_FEATURE_ANY },
-	{ X86_VENDOR_INTEL,	6, INTEL_FAM6_ATOM_PINEVIEW,	X86_FEATURE_ANY },
+	{ X86_VENDOR_INTEL,	6, INTEL_FAM6_ATOM_SALTWELL,	X86_FEATURE_ANY },
+	{ X86_VENDOR_INTEL,	6, INTEL_FAM6_ATOM_SALTWELL_TABLET,	X86_FEATURE_ANY },
+	{ X86_VENDOR_INTEL,	6, INTEL_FAM6_ATOM_BONNELL_MID,	X86_FEATURE_ANY },
+	{ X86_VENDOR_INTEL,	6, INTEL_FAM6_ATOM_SALTWELL_MID,	X86_FEATURE_ANY },
+	{ X86_VENDOR_INTEL,	6, INTEL_FAM6_ATOM_BONNELL,	X86_FEATURE_ANY },
 	{ X86_VENDOR_CENTAUR,	5 },
 	{ X86_VENDOR_INTEL,	5 },
 	{ X86_VENDOR_NSC,	5 },
@@ -968,10 +968,10 @@ static const __initconst struct x86_cpu_
 
 /* Only list CPUs which speculate but are non susceptible to SSB */
 static const __initconst struct x86_cpu_id cpu_no_spec_store_bypass[] = {
-	{ X86_VENDOR_INTEL,	6,	INTEL_FAM6_ATOM_SILVERMONT1	},
+	{ X86_VENDOR_INTEL,	6,	INTEL_FAM6_ATOM_SILVERMONT	},
 	{ X86_VENDOR_INTEL,	6,	INTEL_FAM6_ATOM_AIRMONT		},
-	{ X86_VENDOR_INTEL,	6,	INTEL_FAM6_ATOM_SILVERMONT2	},
-	{ X86_VENDOR_INTEL,	6,	INTEL_FAM6_ATOM_MERRIFIELD	},
+	{ X86_VENDOR_INTEL,	6,	INTEL_FAM6_ATOM_SILVERMONT_X	},
+	{ X86_VENDOR_INTEL,	6,	INTEL_FAM6_ATOM_SILVERMONT_MID	},
 	{ X86_VENDOR_INTEL,	6,	INTEL_FAM6_CORE_YONAH		},
 	{ X86_VENDOR_INTEL,	6,	INTEL_FAM6_XEON_PHI_KNL		},
 	{ X86_VENDOR_INTEL,	6,	INTEL_FAM6_XEON_PHI_KNM		},
@@ -984,11 +984,11 @@ static const __initconst struct x86_cpu_
 
 static const __initconst struct x86_cpu_id cpu_no_l1tf[] = {
 	/* in addition to cpu_no_speculation */
-	{ X86_VENDOR_INTEL,	6,	INTEL_FAM6_ATOM_SILVERMONT1	},
-	{ X86_VENDOR_INTEL,	6,	INTEL_FAM6_ATOM_SILVERMONT2	},
+	{ X86_VENDOR_INTEL,	6,	INTEL_FAM6_ATOM_SILVERMONT	},
+	{ X86_VENDOR_INTEL,	6,	INTEL_FAM6_ATOM_SILVERMONT_X	},
 	{ X86_VENDOR_INTEL,	6,	INTEL_FAM6_ATOM_AIRMONT		},
-	{ X86_VENDOR_INTEL,	6,	INTEL_FAM6_ATOM_MERRIFIELD	},
-	{ X86_VENDOR_INTEL,	6,	INTEL_FAM6_ATOM_MOOREFIELD	},
+	{ X86_VENDOR_INTEL,	6,	INTEL_FAM6_ATOM_SILVERMONT_MID	},
+	{ X86_VENDOR_INTEL,	6,	INTEL_FAM6_ATOM_AIRMONT_MID	},
 	{ X86_VENDOR_INTEL,	6,	INTEL_FAM6_ATOM_GOLDMONT	},
 	{ X86_VENDOR_INTEL,	6,	INTEL_FAM6_ATOM_DENVERTON	},
 	{ X86_VENDOR_INTEL,	6,	INTEL_FAM6_ATOM_GEMINI_LAKE	},
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -635,7 +635,7 @@ unsigned long native_calibrate_tsc(void)
 		case INTEL_FAM6_KABYLAKE_DESKTOP:
 			crystal_khz = 24000;	/* 24.0 MHz */
 			break;
-		case INTEL_FAM6_ATOM_DENVERTON:
+		case INTEL_FAM6_ATOM_GOLDMONT_X:
 			crystal_khz = 25000;	/* 25.0 MHz */
 			break;
 		case INTEL_FAM6_ATOM_GOLDMONT:
--- a/arch/x86/kernel/tsc_msr.c
+++ b/arch/x86/kernel/tsc_msr.c
@@ -59,9 +59,9 @@ static const struct freq_desc freq_desc_
 };
 
 static const struct x86_cpu_id tsc_msr_cpu_ids[] = {
-	INTEL_CPU_FAM6(ATOM_PENWELL,		freq_desc_pnw),
+	INTEL_CPU_FAM6(ATOM_SALTWELL,		freq_desc_pnw),
 	INTEL_CPU_FAM6(ATOM_CLOVERVIEW,		freq_desc_clv),
-	INTEL_CPU_FAM6(ATOM_SILVERMONT1,	freq_desc_byt),
+	INTEL_CPU_FAM6(ATOM_SILVERMONT,	freq_desc_byt),
 	INTEL_CPU_FAM6(ATOM_AIRMONT,		freq_desc_cht),
 	INTEL_CPU_FAM6(ATOM_MERRIFIELD,		freq_desc_tng),
 	INTEL_CPU_FAM6(ATOM_MOOREFIELD,		freq_desc_ann),
--- a/arch/x86/platform/atom/punit_atom_debug.c
+++ b/arch/x86/platform/atom/punit_atom_debug.c
@@ -143,8 +143,8 @@ static void punit_dbgfs_unregister(void)
 	  (kernel_ulong_t)&drv_data }
 
 static const struct x86_cpu_id intel_punit_cpu_ids[] = {
-	ICPU(INTEL_FAM6_ATOM_SILVERMONT1, punit_device_byt),
-	ICPU(INTEL_FAM6_ATOM_MERRIFIELD,  punit_device_tng),
+	ICPU(INTEL_FAM6_ATOM_SILVERMONT, punit_device_byt),
+	ICPU(INTEL_FAM6_ATOM_SILVERMONT_MID,  punit_device_tng),
 	ICPU(INTEL_FAM6_ATOM_AIRMONT,	  punit_device_cht),
 	{}
 };
--- a/arch/x86/platform/intel-mid/device_libs/platform_bt.c
+++ b/arch/x86/platform/intel-mid/device_libs/platform_bt.c
@@ -68,7 +68,7 @@ static struct bt_sfi_data tng_bt_sfi_dat
 	{ X86_VENDOR_INTEL, 6, model, X86_FEATURE_ANY, (kernel_ulong_t)&ddata }
 
 static const struct x86_cpu_id bt_sfi_cpu_ids[] = {
-	ICPU(INTEL_FAM6_ATOM_MERRIFIELD, tng_bt_sfi_data),
+	ICPU(INTEL_FAM6_ATOM_SILVERMONT_MID, tng_bt_sfi_data),
 	{}
 };
 
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -292,7 +292,7 @@ static const struct lpss_device_desc bsw
 #define ICPU(model)	{ X86_VENDOR_INTEL, 6, model, X86_FEATURE_ANY, }
 
 static const struct x86_cpu_id lpss_cpu_ids[] = {
-	ICPU(INTEL_FAM6_ATOM_SILVERMONT1),	/* Valleyview, Bay Trail */
+	ICPU(INTEL_FAM6_ATOM_SILVERMONT),	/* Valleyview, Bay Trail */
 	ICPU(INTEL_FAM6_ATOM_AIRMONT),	/* Braswell, Cherry Trail */
 	{}
 };
--- a/drivers/acpi/x86/utils.c
+++ b/drivers/acpi/x86/utils.c
@@ -54,7 +54,7 @@ static const struct always_present_id al
 	 * Bay / Cherry Trail PWM directly poked by GPU driver in win10,
 	 * but Linux uses a separate PWM driver, harmless if not used.
 	 */
-	ENTRY("80860F09", "1", ICPU(INTEL_FAM6_ATOM_SILVERMONT1), {}),
+	ENTRY("80860F09", "1", ICPU(INTEL_FAM6_ATOM_SILVERMONT), {}),
 	ENTRY("80862288", "1", ICPU(INTEL_FAM6_ATOM_AIRMONT), {}),
 	/*
 	 * The INT0002 device is necessary to clear wakeup interrupt sources
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1778,7 +1778,7 @@ static const struct pstate_funcs knl_fun
 static const struct x86_cpu_id intel_pstate_cpu_ids[] = {
 	ICPU(INTEL_FAM6_SANDYBRIDGE, 		core_funcs),
 	ICPU(INTEL_FAM6_SANDYBRIDGE_X,		core_funcs),
-	ICPU(INTEL_FAM6_ATOM_SILVERMONT1,	silvermont_funcs),
+	ICPU(INTEL_FAM6_ATOM_SILVERMONT,	silvermont_funcs),
 	ICPU(INTEL_FAM6_IVYBRIDGE,		core_funcs),
 	ICPU(INTEL_FAM6_HASWELL_CORE,		core_funcs),
 	ICPU(INTEL_FAM6_BROADWELL_CORE,		core_funcs),
@@ -1795,7 +1795,7 @@ static const struct x86_cpu_id intel_pst
 	ICPU(INTEL_FAM6_XEON_PHI_KNL,		knl_funcs),
 	ICPU(INTEL_FAM6_XEON_PHI_KNM,		knl_funcs),
 	ICPU(INTEL_FAM6_ATOM_GOLDMONT,		core_funcs),
-	ICPU(INTEL_FAM6_ATOM_GEMINI_LAKE,       core_funcs),
+	ICPU(INTEL_FAM6_ATOM_GOLDMONT_PLUS,     core_funcs),
 	ICPU(INTEL_FAM6_SKYLAKE_X,		core_funcs),
 	{}
 };
--- a/drivers/edac/pnd2_edac.c
+++ b/drivers/edac/pnd2_edac.c
@@ -1541,7 +1541,7 @@ static struct dunit_ops dnv_ops = {
 
 static const struct x86_cpu_id pnd2_cpuids[] = {
 	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_ATOM_GOLDMONT, 0, (kernel_ulong_t)&apl_ops },
-	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_ATOM_DENVERTON, 0, (kernel_ulong_t)&dnv_ops },
+	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_ATOM_GOLDMONT_X, 0, (kernel_ulong_t)&dnv_ops },
 	{ }
 };
 MODULE_DEVICE_TABLE(x86cpu, pnd2_cpuids);
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1076,14 +1076,14 @@ static const struct x86_cpu_id intel_idl
 	ICPU(INTEL_FAM6_WESTMERE,		idle_cpu_nehalem),
 	ICPU(INTEL_FAM6_WESTMERE_EP,		idle_cpu_nehalem),
 	ICPU(INTEL_FAM6_NEHALEM_EX,		idle_cpu_nehalem),
-	ICPU(INTEL_FAM6_ATOM_PINEVIEW,		idle_cpu_atom),
-	ICPU(INTEL_FAM6_ATOM_LINCROFT,		idle_cpu_lincroft),
+	ICPU(INTEL_FAM6_ATOM_BONNELL,		idle_cpu_atom),
+	ICPU(INTEL_FAM6_ATOM_BONNELL_MID,		idle_cpu_lincroft),
 	ICPU(INTEL_FAM6_WESTMERE_EX,		idle_cpu_nehalem),
 	ICPU(INTEL_FAM6_SANDYBRIDGE,		idle_cpu_snb),
 	ICPU(INTEL_FAM6_SANDYBRIDGE_X,		idle_cpu_snb),
-	ICPU(INTEL_FAM6_ATOM_CEDARVIEW,		idle_cpu_atom),
-	ICPU(INTEL_FAM6_ATOM_SILVERMONT1,	idle_cpu_byt),
-	ICPU(INTEL_FAM6_ATOM_MERRIFIELD,	idle_cpu_tangier),
+	ICPU(INTEL_FAM6_ATOM_SALTWELL,		idle_cpu_atom),
+	ICPU(INTEL_FAM6_ATOM_SILVERMONT,	idle_cpu_byt),
+	ICPU(INTEL_FAM6_ATOM_SILVERMONT_MID,	idle_cpu_tangier),
 	ICPU(INTEL_FAM6_ATOM_AIRMONT,		idle_cpu_cht),
 	ICPU(INTEL_FAM6_IVYBRIDGE,		idle_cpu_ivb),
 	ICPU(INTEL_FAM6_IVYBRIDGE_X,		idle_cpu_ivt),
@@ -1091,7 +1091,7 @@ static const struct x86_cpu_id intel_idl
 	ICPU(INTEL_FAM6_HASWELL_X,		idle_cpu_hsw),
 	ICPU(INTEL_FAM6_HASWELL_ULT,		idle_cpu_hsw),
 	ICPU(INTEL_FAM6_HASWELL_GT3E,		idle_cpu_hsw),
-	ICPU(INTEL_FAM6_ATOM_SILVERMONT2,	idle_cpu_avn),
+	ICPU(INTEL_FAM6_ATOM_SILVERMONT_X,	idle_cpu_avn),
 	ICPU(INTEL_FAM6_BROADWELL_CORE,		idle_cpu_bdw),
 	ICPU(INTEL_FAM6_BROADWELL_GT3E,		idle_cpu_bdw),
 	ICPU(INTEL_FAM6_BROADWELL_X,		idle_cpu_bdw),
@@ -1104,8 +1104,8 @@ static const struct x86_cpu_id intel_idl
 	ICPU(INTEL_FAM6_XEON_PHI_KNL,		idle_cpu_knl),
 	ICPU(INTEL_FAM6_XEON_PHI_KNM,		idle_cpu_knl),
 	ICPU(INTEL_FAM6_ATOM_GOLDMONT,		idle_cpu_bxt),
-	ICPU(INTEL_FAM6_ATOM_GEMINI_LAKE,	idle_cpu_bxt),
-	ICPU(INTEL_FAM6_ATOM_DENVERTON,		idle_cpu_dnv),
+	ICPU(INTEL_FAM6_ATOM_GOLDMONT_PLUS,	idle_cpu_bxt),
+	ICPU(INTEL_FAM6_ATOM_GOLDMONT_X,	idle_cpu_dnv),
 	{}
 };
 
@@ -1322,7 +1322,7 @@ static void intel_idle_state_table_updat
 		ivt_idle_state_table_update();
 		break;
 	case INTEL_FAM6_ATOM_GOLDMONT:
-	case INTEL_FAM6_ATOM_GEMINI_LAKE:
+	case INTEL_FAM6_ATOM_GOLDMONT_PLUS:
 		bxt_idle_state_table_update();
 		break;
 	case INTEL_FAM6_SKYLAKE_DESKTOP:
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -246,7 +246,7 @@ static const struct sdhci_acpi_chip sdhc
 static bool sdhci_acpi_byt(void)
 {
 	static const struct x86_cpu_id byt[] = {
-		{ X86_VENDOR_INTEL, 6, INTEL_FAM6_ATOM_SILVERMONT1 },
+		{ X86_VENDOR_INTEL, 6, INTEL_FAM6_ATOM_SILVERMONT },
 		{}
 	};
 
--- a/drivers/pci/pci-mid.c
+++ b/drivers/pci/pci-mid.c
@@ -62,8 +62,8 @@ static const struct pci_platform_pm_ops
  * arch/x86/platform/intel-mid/pwr.c.
  */
 static const struct x86_cpu_id lpss_cpu_ids[] = {
-	ICPU(INTEL_FAM6_ATOM_PENWELL),
-	ICPU(INTEL_FAM6_ATOM_MERRIFIELD),
+	ICPU(INTEL_FAM6_ATOM_SALTWELL_MID),
+	ICPU(INTEL_FAM6_ATOM_SILVERMONT_MID),
 	{}
 };
 
--- a/drivers/platform/x86/intel_int0002_vgpio.c
+++ b/drivers/platform/x86/intel_int0002_vgpio.c
@@ -60,7 +60,7 @@ static const struct x86_cpu_id int0002_c
 /*
  * Limit ourselves to Cherry Trail for now, until testing shows we
  * need to handle the INT0002 device on Baytrail too.
- *	ICPU(INTEL_FAM6_ATOM_SILVERMONT1),	 * Valleyview, Bay Trail *
+ *	ICPU(INTEL_FAM6_ATOM_SILVERMONT),	 * Valleyview, Bay Trail *
  */
 	ICPU(INTEL_FAM6_ATOM_AIRMONT),		/* Braswell, Cherry Trail */
 	{}
--- a/drivers/platform/x86/intel_mid_powerbtn.c
+++ b/drivers/platform/x86/intel_mid_powerbtn.c
@@ -125,8 +125,8 @@ static const struct mid_pb_ddata mrfld_d
 	{ X86_VENDOR_INTEL, 6, model, X86_FEATURE_ANY, (kernel_ulong_t)&ddata }
 
 static const struct x86_cpu_id mid_pb_cpu_ids[] = {
-	ICPU(INTEL_FAM6_ATOM_PENWELL,		mfld_ddata),
-	ICPU(INTEL_FAM6_ATOM_MERRIFIELD,	mrfld_ddata),
+	ICPU(INTEL_FAM6_ATOM_SALTWELL_MID,		mfld_ddata),
+	ICPU(INTEL_FAM6_ATOM_SILVERMONT_MID,	mrfld_ddata),
 	{}
 };
 
--- a/drivers/platform/x86/intel_telemetry_debugfs.c
+++ b/drivers/platform/x86/intel_telemetry_debugfs.c
@@ -320,7 +320,7 @@ static struct telemetry_debugfs_conf tel
 
 static const struct x86_cpu_id telemetry_debugfs_cpu_ids[] = {
 	TELEM_DEBUGFS_CPU(INTEL_FAM6_ATOM_GOLDMONT, telem_apl_debugfs_conf),
-	TELEM_DEBUGFS_CPU(INTEL_FAM6_ATOM_GEMINI_LAKE, telem_apl_debugfs_conf),
+	TELEM_DEBUGFS_CPU(INTEL_FAM6_ATOM_GOLDMONT_PLUS, telem_apl_debugfs_conf),
 	{}
 };
 
--- a/drivers/platform/x86/intel_telemetry_pltdrv.c
+++ b/drivers/platform/x86/intel_telemetry_pltdrv.c
@@ -192,7 +192,7 @@ static struct telemetry_plt_config telem
 
 static const struct x86_cpu_id telemetry_cpu_ids[] = {
 	TELEM_CPU(INTEL_FAM6_ATOM_GOLDMONT, telem_apl_config),
-	TELEM_CPU(INTEL_FAM6_ATOM_GEMINI_LAKE, telem_glk_config),
+	TELEM_CPU(INTEL_FAM6_ATOM_GOLDMONT_PLUS, telem_glk_config),
 	{}
 };
 
--- a/drivers/powercap/intel_rapl.c
+++ b/drivers/powercap/intel_rapl.c
@@ -1164,13 +1164,13 @@ static const struct x86_cpu_id rapl_ids[
 	RAPL_CPU(INTEL_FAM6_KABYLAKE_DESKTOP,	rapl_defaults_core),
 	RAPL_CPU(INTEL_FAM6_CANNONLAKE_MOBILE,	rapl_defaults_core),
 
-	RAPL_CPU(INTEL_FAM6_ATOM_SILVERMONT1,	rapl_defaults_byt),
+	RAPL_CPU(INTEL_FAM6_ATOM_SILVERMONT,	rapl_defaults_byt),
 	RAPL_CPU(INTEL_FAM6_ATOM_AIRMONT,	rapl_defaults_cht),
-	RAPL_CPU(INTEL_FAM6_ATOM_MERRIFIELD,	rapl_defaults_tng),
-	RAPL_CPU(INTEL_FAM6_ATOM_MOOREFIELD,	rapl_defaults_ann),
+	RAPL_CPU(INTEL_FAM6_ATOM_SILVERMONT_MID,	rapl_defaults_tng),
+	RAPL_CPU(INTEL_FAM6_ATOM_AIRMONT_MID,	rapl_defaults_ann),
 	RAPL_CPU(INTEL_FAM6_ATOM_GOLDMONT,	rapl_defaults_core),
-	RAPL_CPU(INTEL_FAM6_ATOM_GEMINI_LAKE,	rapl_defaults_core),
-	RAPL_CPU(INTEL_FAM6_ATOM_DENVERTON,	rapl_defaults_core),
+	RAPL_CPU(INTEL_FAM6_ATOM_GOLDMONT_PLUS,	rapl_defaults_core),
+	RAPL_CPU(INTEL_FAM6_ATOM_GOLDMONT_X,	rapl_defaults_core),
 
 	RAPL_CPU(INTEL_FAM6_XEON_PHI_KNL,	rapl_defaults_hsw_server),
 	RAPL_CPU(INTEL_FAM6_XEON_PHI_KNM,	rapl_defaults_hsw_server),
--- a/drivers/thermal/intel_soc_dts_thermal.c
+++ b/drivers/thermal/intel_soc_dts_thermal.c
@@ -45,7 +45,7 @@ static irqreturn_t soc_irq_thread_fn(int
 }
 
 static const struct x86_cpu_id soc_thermal_ids[] = {
-	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_ATOM_SILVERMONT1, 0,
+	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_ATOM_SILVERMONT, 0,
 		BYT_SOC_DTS_APIC_IRQ},
 	{}
 };
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -787,7 +787,7 @@ static struct snd_soc_card byt_rt5651_ca
 };
 
 static const struct x86_cpu_id baytrail_cpu_ids[] = {
-	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_ATOM_SILVERMONT1 }, /* Valleyview */
+	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_ATOM_SILVERMONT }, /* Valleyview */
 	{}
 };
 
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -2082,7 +2082,7 @@ int has_turbo_ratio_group_limits(int fam
 	switch (model) {
 	case INTEL_FAM6_ATOM_GOLDMONT:
 	case INTEL_FAM6_SKYLAKE_X:
-	case INTEL_FAM6_ATOM_DENVERTON:
+	case INTEL_FAM6_ATOM_GOLDMONT_X:
 		return 1;
 	}
 	return 0;
@@ -3149,9 +3149,9 @@ int probe_nhm_msrs(unsigned int family,
 		pkg_cstate_limits = skx_pkg_cstate_limits;
 		has_misc_feature_control = 1;
 		break;
-	case INTEL_FAM6_ATOM_SILVERMONT1:	/* BYT */
+	case INTEL_FAM6_ATOM_SILVERMONT:	/* BYT */
 		no_MSR_MISC_PWR_MGMT = 1;
-	case INTEL_FAM6_ATOM_SILVERMONT2:	/* AVN */
+	case INTEL_FAM6_ATOM_SILVERMONT_X:	/* AVN */
 		pkg_cstate_limits = slv_pkg_cstate_limits;
 		break;
 	case INTEL_FAM6_ATOM_AIRMONT:	/* AMT */
@@ -3163,8 +3163,8 @@ int probe_nhm_msrs(unsigned int family,
 		pkg_cstate_limits = phi_pkg_cstate_limits;
 		break;
 	case INTEL_FAM6_ATOM_GOLDMONT:	/* BXT */
-	case INTEL_FAM6_ATOM_GEMINI_LAKE:
-	case INTEL_FAM6_ATOM_DENVERTON:	/* DNV */
+	case INTEL_FAM6_ATOM_GOLDMONT_PLUS:
+	case INTEL_FAM6_ATOM_GOLDMONT_X:	/* DNV */
 		pkg_cstate_limits = bxt_pkg_cstate_limits;
 		break;
 	default:
@@ -3193,9 +3193,9 @@ int has_slv_msrs(unsigned int family, un
 		return 0;
 
 	switch (model) {
-	case INTEL_FAM6_ATOM_SILVERMONT1:
-	case INTEL_FAM6_ATOM_MERRIFIELD:
-	case INTEL_FAM6_ATOM_MOOREFIELD:
+	case INTEL_FAM6_ATOM_SILVERMONT:
+	case INTEL_FAM6_ATOM_SILVERMONT_MID:
+	case INTEL_FAM6_ATOM_AIRMONT_MID:
 		return 1;
 	}
 	return 0;
@@ -3207,7 +3207,7 @@ int is_dnv(unsigned int family, unsigned
 		return 0;
 
 	switch (model) {
-	case INTEL_FAM6_ATOM_DENVERTON:
+	case INTEL_FAM6_ATOM_GOLDMONT_X:
 		return 1;
 	}
 	return 0;
@@ -3724,8 +3724,8 @@ double get_tdp(unsigned int model)
 			return ((msr >> 0) & RAPL_POWER_GRANULARITY) * rapl_power_units;
 
 	switch (model) {
-	case INTEL_FAM6_ATOM_SILVERMONT1:
-	case INTEL_FAM6_ATOM_SILVERMONT2:
+	case INTEL_FAM6_ATOM_SILVERMONT:
+	case INTEL_FAM6_ATOM_SILVERMONT_X:
 		return 30.0;
 	default:
 		return 135.0;
@@ -3791,7 +3791,7 @@ void rapl_probe(unsigned int family, uns
 		}
 		break;
 	case INTEL_FAM6_ATOM_GOLDMONT:	/* BXT */
-	case INTEL_FAM6_ATOM_GEMINI_LAKE:
+	case INTEL_FAM6_ATOM_GOLDMONT_PLUS:
 		do_rapl = RAPL_PKG | RAPL_PKG_POWER_INFO;
 		if (rapl_joules)
 			BIC_PRESENT(BIC_Pkg_J);
@@ -3850,8 +3850,8 @@ void rapl_probe(unsigned int family, uns
 			BIC_PRESENT(BIC_RAMWatt);
 		}
 		break;
-	case INTEL_FAM6_ATOM_SILVERMONT1:	/* BYT */
-	case INTEL_FAM6_ATOM_SILVERMONT2:	/* AVN */
+	case INTEL_FAM6_ATOM_SILVERMONT:	/* BYT */
+	case INTEL_FAM6_ATOM_SILVERMONT_X:	/* AVN */
 		do_rapl = RAPL_PKG | RAPL_CORES;
 		if (rapl_joules) {
 			BIC_PRESENT(BIC_Pkg_J);
@@ -3861,7 +3861,7 @@ void rapl_probe(unsigned int family, uns
 			BIC_PRESENT(BIC_CorWatt);
 		}
 		break;
-	case INTEL_FAM6_ATOM_DENVERTON:	/* DNV */
+	case INTEL_FAM6_ATOM_GOLDMONT_X:	/* DNV */
 		do_rapl = RAPL_PKG | RAPL_DRAM | RAPL_DRAM_POWER_INFO | RAPL_DRAM_PERF_STATUS | RAPL_PKG_PERF_STATUS | RAPL_PKG_POWER_INFO | RAPL_CORES_ENERGY_STATUS;
 		BIC_PRESENT(BIC_PKG__);
 		BIC_PRESENT(BIC_RAM__);
@@ -3884,7 +3884,7 @@ void rapl_probe(unsigned int family, uns
 		return;
 
 	rapl_power_units = 1.0 / (1 << (msr & 0xF));
-	if (model == INTEL_FAM6_ATOM_SILVERMONT1)
+	if (model == INTEL_FAM6_ATOM_SILVERMONT)
 		rapl_energy_units = 1.0 * (1 << (msr >> 8 & 0x1F)) / 1000000;
 	else
 		rapl_energy_units = 1.0 / (1 << (msr >> 8 & 0x1F));
@@ -4141,8 +4141,8 @@ int has_snb_msrs(unsigned int family, un
 	case INTEL_FAM6_CANNONLAKE_MOBILE:	/* CNL */
 	case INTEL_FAM6_SKYLAKE_X:	/* SKX */
 	case INTEL_FAM6_ATOM_GOLDMONT:	/* BXT */
-	case INTEL_FAM6_ATOM_GEMINI_LAKE:
-	case INTEL_FAM6_ATOM_DENVERTON:	/* DNV */
+	case INTEL_FAM6_ATOM_GOLDMONT_PLUS:
+	case INTEL_FAM6_ATOM_GOLDMONT_X:	/* DNV */
 		return 1;
 	}
 	return 0;
@@ -4174,7 +4174,7 @@ int has_hsw_msrs(unsigned int family, un
 	case INTEL_FAM6_KABYLAKE_DESKTOP:	/* KBL */
 	case INTEL_FAM6_CANNONLAKE_MOBILE:	/* CNL */
 	case INTEL_FAM6_ATOM_GOLDMONT:	/* BXT */
-	case INTEL_FAM6_ATOM_GEMINI_LAKE:
+	case INTEL_FAM6_ATOM_GOLDMONT_PLUS:
 		return 1;
 	}
 	return 0;
@@ -4209,8 +4209,8 @@ int is_slm(unsigned int family, unsigned
 	if (!genuine_intel)
 		return 0;
 	switch (model) {
-	case INTEL_FAM6_ATOM_SILVERMONT1:	/* BYT */
-	case INTEL_FAM6_ATOM_SILVERMONT2:	/* AVN */
+	case INTEL_FAM6_ATOM_SILVERMONT:	/* BYT */
+	case INTEL_FAM6_ATOM_SILVERMONT_X:	/* AVN */
 		return 1;
 	}
 	return 0;
@@ -4581,11 +4581,11 @@ void process_cpuid()
 				case INTEL_FAM6_KABYLAKE_DESKTOP:	/* KBL */
 					crystal_hz = 24000000;	/* 24.0 MHz */
 					break;
-				case INTEL_FAM6_ATOM_DENVERTON:	/* DNV */
+				case INTEL_FAM6_ATOM_GOLDMONT_X:	/* DNV */
 					crystal_hz = 25000000;	/* 25.0 MHz */
 					break;
 				case INTEL_FAM6_ATOM_GOLDMONT:	/* BXT */
-				case INTEL_FAM6_ATOM_GEMINI_LAKE:
+				case INTEL_FAM6_ATOM_GOLDMONT_PLUS:
 					crystal_hz = 19200000;	/* 19.2 MHz */
 					break;
 				default:
