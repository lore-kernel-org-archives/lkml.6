Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752074AbeBET5L (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 14:57:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:56328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752010AbeBET4t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 14:56:49 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EF7C217B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Ahern <dsahern@gmail.com>, David Woodhouse <dwmw@amazon.co.uk>,
        Fenghua Yu <fenghua.yu@intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 05/10] tools headers: Synchoronize x86 features UAPI headers
Date: Mon,  5 Feb 2018 16:56:15 -0300
Message-Id: <20180205195620.9010-6-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180205195620.9010-1-acme@kernel.org>
References: <20180205195620.9010-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Sync tools/arch/x86/include/asm/{cpu,disabled-,required-}features.h with
the changes in:

  2961298efe1e ("x86/cpufeatures: Clean up Spectre v2 related CPUID flags")
  20ffa1caecca ("x86/speculation: Add basic IBPB (Indirect Branch Prediction Barrier) support")
  5d10cbc91d9e ("x86/cpufeatures: Add AMD feature bits for Speculation Control")
  fc67dd70adb7 ("x86/cpufeatures: Add Intel feature bits for Speculation Control")
  95ca0ee86360 ("x86/cpufeatures: Add CPUID_7_EDX CPUID leaf")
  a511e7935378 ("x86/intel_rdt: Enumerate L2 Code and Data Prioritization (CDP) feature")
  4fdec2034b75 ("x86/cpufeature: Move processor tracing out of scattered features")
  c995efd5a740 ("x86/retpoline: Fill RSB on context switch for affected CPUs")
  76b043848fd2 ("x86/retpoline: Add initial retpoline support")
  99c6fa2511d8 ("x86/cpufeatures: Add X86_BUG_SPECTRE_V[12]")
  de791821c295 ("x86/pti: Rename BUG_CPU_INSECURE to BUG_CPU_MELTDOWN")
  6cff64b86aaa ("x86/mm: Use INVPCID for __native_flush_tlb_single()")

None will entail changes in the tools/perf/, synchronizing to elliminate
these perf build warnings:

  Warning: Kernel ABI header at 'tools/arch/x86/include/asm/disabled-features.h' differs from latest version at 'arch/x86/include/asm/disabled-features.h'
  Warning: Kernel ABI header at 'tools/arch/x86/include/asm/required-features.h' differs from latest version at 'arch/x86/include/asm/required-features.h'
  Warning: Kernel ABI header at 'tools/arch/x86/include/asm/cpufeatures.h' differs from latest version at 'arch/x86/include/asm/cpufeatures.h'

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-dbdjack1k92xar5ccuq4el1h@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/x86/include/asm/cpufeatures.h       | 24 ++++++++++++++++++++----
 tools/arch/x86/include/asm/disabled-features.h |  3 ++-
 tools/arch/x86/include/asm/required-features.h |  3 ++-
 3 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/include/asm/cpufeatures.h
index 21ac898df2d8..1d9199e1c2ad 100644
--- a/tools/arch/x86/include/asm/cpufeatures.h
+++ b/tools/arch/x86/include/asm/cpufeatures.h
@@ -13,7 +13,7 @@
 /*
  * Defines x86 CPU feature bits
  */
-#define NCAPINTS			18	   /* N 32-bit words worth of info */
+#define NCAPINTS			19	   /* N 32-bit words worth of info */
 #define NBUGINTS			1	   /* N 32-bit bug flags */
 
 /*
@@ -203,12 +203,15 @@
 #define X86_FEATURE_PROC_FEEDBACK	( 7*32+ 9) /* AMD ProcFeedbackInterface */
 #define X86_FEATURE_SME			( 7*32+10) /* AMD Secure Memory Encryption */
 #define X86_FEATURE_PTI			( 7*32+11) /* Kernel Page Table Isolation enabled */
+#define X86_FEATURE_RETPOLINE		( 7*32+12) /* "" Generic Retpoline mitigation for Spectre variant 2 */
+#define X86_FEATURE_RETPOLINE_AMD	( 7*32+13) /* "" AMD Retpoline mitigation for Spectre variant 2 */
 #define X86_FEATURE_INTEL_PPIN		( 7*32+14) /* Intel Processor Inventory Number */
-#define X86_FEATURE_INTEL_PT		( 7*32+15) /* Intel Processor Trace */
-#define X86_FEATURE_AVX512_4VNNIW	( 7*32+16) /* AVX-512 Neural Network Instructions */
-#define X86_FEATURE_AVX512_4FMAPS	( 7*32+17) /* AVX-512 Multiply Accumulation Single precision */
+#define X86_FEATURE_CDP_L2		( 7*32+15) /* Code and Data Prioritization L2 */
 
 #define X86_FEATURE_MBA			( 7*32+18) /* Memory Bandwidth Allocation */
+#define X86_FEATURE_RSB_CTXSW		( 7*32+19) /* "" Fill RSB on context switches */
+
+#define X86_FEATURE_USE_IBPB		( 7*32+21) /* "" Indirect Branch Prediction Barrier enabled */
 
 /* Virtualization flags: Linux defined, word 8 */
 #define X86_FEATURE_TPR_SHADOW		( 8*32+ 0) /* Intel TPR Shadow */
@@ -243,6 +246,7 @@
 #define X86_FEATURE_AVX512IFMA		( 9*32+21) /* AVX-512 Integer Fused Multiply-Add instructions */
 #define X86_FEATURE_CLFLUSHOPT		( 9*32+23) /* CLFLUSHOPT instruction */
 #define X86_FEATURE_CLWB		( 9*32+24) /* CLWB instruction */
+#define X86_FEATURE_INTEL_PT		( 9*32+25) /* Intel Processor Trace */
 #define X86_FEATURE_AVX512PF		( 9*32+26) /* AVX-512 Prefetch */
 #define X86_FEATURE_AVX512ER		( 9*32+27) /* AVX-512 Exponential and Reciprocal */
 #define X86_FEATURE_AVX512CD		( 9*32+28) /* AVX-512 Conflict Detection */
@@ -268,6 +272,9 @@
 #define X86_FEATURE_CLZERO		(13*32+ 0) /* CLZERO instruction */
 #define X86_FEATURE_IRPERF		(13*32+ 1) /* Instructions Retired Count */
 #define X86_FEATURE_XSAVEERPTR		(13*32+ 2) /* Always save/restore FP error pointers */
+#define X86_FEATURE_IBPB		(13*32+12) /* Indirect Branch Prediction Barrier */
+#define X86_FEATURE_IBRS		(13*32+14) /* Indirect Branch Restricted Speculation */
+#define X86_FEATURE_STIBP		(13*32+15) /* Single Thread Indirect Branch Predictors */
 
 /* Thermal and Power Management Leaf, CPUID level 0x00000006 (EAX), word 14 */
 #define X86_FEATURE_DTHERM		(14*32+ 0) /* Digital Thermal Sensor */
@@ -316,6 +323,13 @@
 #define X86_FEATURE_SUCCOR		(17*32+ 1) /* Uncorrectable error containment and recovery */
 #define X86_FEATURE_SMCA		(17*32+ 3) /* Scalable MCA */
 
+/* Intel-defined CPU features, CPUID level 0x00000007:0 (EDX), word 18 */
+#define X86_FEATURE_AVX512_4VNNIW	(18*32+ 2) /* AVX-512 Neural Network Instructions */
+#define X86_FEATURE_AVX512_4FMAPS	(18*32+ 3) /* AVX-512 Multiply Accumulation Single precision */
+#define X86_FEATURE_SPEC_CTRL		(18*32+26) /* "" Speculation Control (IBRS + IBPB) */
+#define X86_FEATURE_INTEL_STIBP		(18*32+27) /* "" Single Thread Indirect Branch Predictors */
+#define X86_FEATURE_ARCH_CAPABILITIES	(18*32+29) /* IA32_ARCH_CAPABILITIES MSR (Intel) */
+
 /*
  * BUG word(s)
  */
@@ -342,5 +356,7 @@
 #define X86_BUG_MONITOR			X86_BUG(12) /* IPI required to wake up remote CPU */
 #define X86_BUG_AMD_E400		X86_BUG(13) /* CPU is among the affected by Erratum 400 */
 #define X86_BUG_CPU_MELTDOWN		X86_BUG(14) /* CPU is affected by meltdown attack and needs kernel page table isolation */
+#define X86_BUG_SPECTRE_V1		X86_BUG(15) /* CPU is affected by Spectre variant 1 attack with conditional branches */
+#define X86_BUG_SPECTRE_V2		X86_BUG(16) /* CPU is affected by Spectre variant 2 attack with indirect branches */
 
 #endif /* _ASM_X86_CPUFEATURES_H */
diff --git a/tools/arch/x86/include/asm/disabled-features.h b/tools/arch/x86/include/asm/disabled-features.h
index b027633e7300..33833d1909af 100644
--- a/tools/arch/x86/include/asm/disabled-features.h
+++ b/tools/arch/x86/include/asm/disabled-features.h
@@ -77,6 +77,7 @@
 #define DISABLED_MASK15	0
 #define DISABLED_MASK16	(DISABLE_PKU|DISABLE_OSPKE|DISABLE_LA57|DISABLE_UMIP)
 #define DISABLED_MASK17	0
-#define DISABLED_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != 18)
+#define DISABLED_MASK18	0
+#define DISABLED_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != 19)
 
 #endif /* _ASM_X86_DISABLED_FEATURES_H */
diff --git a/tools/arch/x86/include/asm/required-features.h b/tools/arch/x86/include/asm/required-features.h
index d91ba04dd007..fb3a6de7440b 100644
--- a/tools/arch/x86/include/asm/required-features.h
+++ b/tools/arch/x86/include/asm/required-features.h
@@ -106,6 +106,7 @@
 #define REQUIRED_MASK15	0
 #define REQUIRED_MASK16	(NEED_LA57)
 #define REQUIRED_MASK17	0
-#define REQUIRED_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != 18)
+#define REQUIRED_MASK18	0
+#define REQUIRED_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != 19)
 
 #endif /* _ASM_X86_REQUIRED_FEATURES_H */
-- 
2.14.3
