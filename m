Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id hK/dHorVG1uKGwAAmS7hNA
	; Sat, 09 Jun 2018 13:27:33 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id F23C4608C8; Sat,  9 Jun 2018 13:27:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 44DD96074D;
	Sat,  9 Jun 2018 13:27:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 44DD96074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=hygon.cn
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753375AbeFIN12 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 09:27:28 -0400
Received: from smtp21.cstnet.cn ([159.226.251.21]:40313 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753214AbeFIN1X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 09:27:23 -0400
Received: from pw-vbox.higon.com (unknown [182.150.46.145])
        by APP-01 (Coremail) with SMTP id qwCowADXuJlI1BtbejREBA--.817S2;
        Sat, 09 Jun 2018 21:21:18 +0800 (CST)
From: Pu Wen <puwen@hygon.cn>
To: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, zhangpanyong@hygon.cn
Cc: thomas.lendacky@amd.com, peterz@infradead.org, tony.luck@intel.com,
        bp@alien8.de, pbonzini@redhat.com, rkrcmar@redhat.com,
        boris.ostrovsky@oracle.com, jgross@suse.com, rjw@rjwysocki.net,
        lenb@kernel.org, viresh.kumar@linaro.org, mchehab@kernel.org,
        trenn@suse.com, shuah@kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-x86_64@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-pm@vger.kernel.org,
        kvm@vger.kernel.org, xen-devel@lists.xenproject.org,
        Pu Wen <puwen@hygon.cn>
Subject: [PATCH 01/11] x86/cpu: Add support for Hygon's Dhyana Family 18h processor
Date: Sat,  9 Jun 2018 21:21:02 +0800
Message-Id: <1528550462-28126-1-git-send-email-puwen@hygon.cn>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: qwCowADXuJlI1BtbejREBA--.817S2
X-Coremail-Antispam: 1UD129KBjvJXoW3GrWDGr47JrWftr4UKrWruFg_yoW3Ar4fpF
        WjyF48JF1kW3ZxX34qyr4kXryxZr1qga1Igw45Ga4rJa1Fv347Xr4vyw1fXryjvwn5Cr1r
        ta4Uua18tw4kAF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUv214x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr
        0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
        6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWxJVW8Jr1lOx8S6xCaFVCjc4AY6r
        1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02
        628vn2kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_
        WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVW8JVW3JwCI42IY6I8E87Iv67AK
        xVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa
        7VU1v38UUUUUU==
X-Originating-IP: [182.150.46.145]
X-CM-SenderInfo: psxzv046klw03qof0z/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables the x86 architecture support to Hygon Family
18h CPU:
- X86 architecture for AMD
  - Add a new hygon_cpu_dev struct in kernel/cpu/amd.c to register
    Hygon CPU device, with CPU vendor ID "HygonGenuine".
  - Add amd_get_topology() hygon support to make sure LLC is at the
    core complex level.
  - Add Hygon support in kernel/cpu/intel_cacheinfo.c to get correct
    cache topology and size.
  - Add Hygon support in smp_quirk_init_udelay() to enable no delay
    as Hygon processors are modern processor.
  - Add Hygon support in arch_init_ideal_nops(), mwait_play_dead().
- MTRR for X86
  - Add MTRR enablement for Hygon processor.
- NMI watchdog for X86
  - Add Hygon support in nmi_perfctr_msr_to_bit() and
    nmi_evntsel_msr_to_bit().

Signed-off-by: Pu Wen <puwen@hygon.cn>
---
 arch/x86/include/asm/processor.h       |  3 ++-
 arch/x86/kernel/alternative.c          |  4 ++++
 arch/x86/kernel/cpu/amd.c              | 14 +++++++++++++-
 arch/x86/kernel/cpu/intel_cacheinfo.c  |  9 ++++++---
 arch/x86/kernel/cpu/mtrr/cleanup.c     |  3 ++-
 arch/x86/kernel/cpu/mtrr/generic.c     |  3 ++-
 arch/x86/kernel/cpu/mtrr/main.c        |  2 +-
 arch/x86/kernel/cpu/perfctr-watchdog.c |  2 ++
 arch/x86/kernel/smpboot.c              |  4 +++-
 9 files changed, 35 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 21a1149..f1b659e 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -153,7 +153,8 @@ enum cpuid_regs_idx {
 #define X86_VENDOR_CENTAUR	5
 #define X86_VENDOR_TRANSMETA	7
 #define X86_VENDOR_NSC		8
-#define X86_VENDOR_NUM		9
+#define X86_VENDOR_HYGON	9
+#define X86_VENDOR_NUM		10
 
 #define X86_VENDOR_UNKNOWN	0xff
 
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index a481763..8f4925b 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -222,6 +222,10 @@ void __init arch_init_ideal_nops(void)
 		}
 		break;
 
+	case X86_VENDOR_HYGON:
+		ideal_nops = p6_nops;
+		return;
+
 	case X86_VENDOR_AMD:
 		if (boot_cpu_data.x86 > 0xf) {
 			ideal_nops = p6_nops;
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 1b18be3..76b1e7d 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -350,7 +350,7 @@ static void amd_get_topology(struct cpuinfo_x86 *c)
 		 * have an L3 cache by looking at the L3 cache CPUID leaf.
 		 */
 		if (cpuid_edx(0x80000006)) {
-			if (c->x86 == 0x17) {
+			if (c->x86 == 0x17 || c->x86 == 0x18) {
 				/*
 				 * LLC is at the core complex level.
 				 * Core complex id is ApicId[3].
@@ -988,6 +988,18 @@ static void cpu_detect_tlb_amd(struct cpuinfo_x86 *c)
 	tlb_lli_4m[ENTRIES] = tlb_lli_2m[ENTRIES] >> 1;
 }
 
+static const struct cpu_dev hygon_cpu_dev = {
+	.c_vendor	= "Hygon",
+	.c_ident	= { "HygonGenuine" },
+	.c_early_init   = early_init_amd,
+	.c_detect_tlb	= cpu_detect_tlb_amd,
+	.c_bsp_init	= bsp_init_amd,
+	.c_init		= init_amd,
+	.c_x86_vendor	= X86_VENDOR_HYGON,
+};
+
+cpu_dev_register(hygon_cpu_dev);
+
 static const struct cpu_dev amd_cpu_dev = {
 	.c_vendor	= "AMD",
 	.c_ident	= { "AuthenticAMD" },
diff --git a/arch/x86/kernel/cpu/intel_cacheinfo.c b/arch/x86/kernel/cpu/intel_cacheinfo.c
index 54d04d5..8d5d542 100644
--- a/arch/x86/kernel/cpu/intel_cacheinfo.c
+++ b/arch/x86/kernel/cpu/intel_cacheinfo.c
@@ -593,7 +593,8 @@ cpuid4_cache_lookup_regs(int index, struct _cpuid4_info_regs *this_leaf)
 	union _cpuid4_leaf_ecx	ecx;
 	unsigned		edx;
 
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD) {
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
+	    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) {
 		if (boot_cpu_has(X86_FEATURE_TOPOEXT))
 			cpuid_count(0x8000001d, index, &eax.full,
 				    &ebx.full, &ecx.full, &edx);
@@ -623,7 +624,8 @@ static int find_num_cache_leaves(struct cpuinfo_x86 *c)
 	union _cpuid4_leaf_eax	cache_eax;
 	int 			i = -1;
 
-	if (c->x86_vendor == X86_VENDOR_AMD)
+	if (c->x86_vendor == X86_VENDOR_AMD ||
+	    c->x86_vendor == X86_VENDOR_HYGON)
 		op = 0x8000001d;
 	else
 		op = 4;
@@ -871,7 +873,8 @@ static void __cache_cpumap_setup(unsigned int cpu, int index,
 	int index_msb, i;
 	struct cpuinfo_x86 *c = &cpu_data(cpu);
 
-	if (c->x86_vendor == X86_VENDOR_AMD) {
+	if (c->x86_vendor == X86_VENDOR_AMD ||
+	    c->x86_vendor == X86_VENDOR_HYGON) {
 		if (__cache_amd_cpumap_setup(cpu, index, base))
 			return;
 	}
diff --git a/arch/x86/kernel/cpu/mtrr/cleanup.c b/arch/x86/kernel/cpu/mtrr/cleanup.c
index 765afd5..3cd91b0 100644
--- a/arch/x86/kernel/cpu/mtrr/cleanup.c
+++ b/arch/x86/kernel/cpu/mtrr/cleanup.c
@@ -831,7 +831,8 @@ int __init amd_special_default_mtrr(void)
 {
 	u32 l, h;
 
-	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
+	     boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
 		return 0;
 	if (boot_cpu_data.x86 < 0xf)
 		return 0;
diff --git a/arch/x86/kernel/cpu/mtrr/generic.c b/arch/x86/kernel/cpu/mtrr/generic.c
index e12ee86..71f868f 100644
--- a/arch/x86/kernel/cpu/mtrr/generic.c
+++ b/arch/x86/kernel/cpu/mtrr/generic.c
@@ -49,7 +49,8 @@ static inline void k8_check_syscfg_dram_mod_en(void)
 {
 	u32 lo, hi;
 
-	if (!((boot_cpu_data.x86_vendor == X86_VENDOR_AMD) &&
+	if (!((boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
+	       boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) &&
 	      (boot_cpu_data.x86 >= 0x0f)))
 		return;
 
diff --git a/arch/x86/kernel/cpu/mtrr/main.c b/arch/x86/kernel/cpu/mtrr/main.c
index 7468de4..d2a87df 100644
--- a/arch/x86/kernel/cpu/mtrr/main.c
+++ b/arch/x86/kernel/cpu/mtrr/main.c
@@ -126,7 +126,7 @@ static void __init set_num_var_ranges(void)
 
 	if (use_intel())
 		rdmsr(MSR_MTRRcap, config, dummy);
-	else if (is_cpu(AMD))
+	else if (is_cpu(AMD) || is_cpu(HYGON))
 		config = 2;
 	else if (is_cpu(CYRIX) || is_cpu(CENTAUR))
 		config = 8;
diff --git a/arch/x86/kernel/cpu/perfctr-watchdog.c b/arch/x86/kernel/cpu/perfctr-watchdog.c
index d389083..9556930 100644
--- a/arch/x86/kernel/cpu/perfctr-watchdog.c
+++ b/arch/x86/kernel/cpu/perfctr-watchdog.c
@@ -46,6 +46,7 @@ static inline unsigned int nmi_perfctr_msr_to_bit(unsigned int msr)
 {
 	/* returns the bit offset of the performance counter register */
 	switch (boot_cpu_data.x86_vendor) {
+	case X86_VENDOR_HYGON:
 	case X86_VENDOR_AMD:
 		if (msr >= MSR_F15H_PERF_CTR)
 			return (msr - MSR_F15H_PERF_CTR) >> 1;
@@ -74,6 +75,7 @@ static inline unsigned int nmi_evntsel_msr_to_bit(unsigned int msr)
 {
 	/* returns the bit offset of the event selection register */
 	switch (boot_cpu_data.x86_vendor) {
+	case X86_VENDOR_HYGON:
 	case X86_VENDOR_AMD:
 		if (msr >= MSR_F15H_PERF_CTL)
 			return (msr - MSR_F15H_PERF_CTL) >> 1;
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 9dd324a..4304510 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -660,6 +660,7 @@ static void __init smp_quirk_init_udelay(void)
 
 	/* if modern processor, use no delay */
 	if (((boot_cpu_data.x86_vendor == X86_VENDOR_INTEL) && (boot_cpu_data.x86 == 6)) ||
+	    ((boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) && (boot_cpu_data.x86 >= 0x18)) ||
 	    ((boot_cpu_data.x86_vendor == X86_VENDOR_AMD) && (boot_cpu_data.x86 >= 0xF))) {
 		init_udelay = 0;
 		return;
@@ -1576,7 +1577,8 @@ static inline void mwait_play_dead(void)
 	void *mwait_ptr;
 	int i;
 
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
+	    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
 		return;
 	if (!this_cpu_has(X86_FEATURE_MWAIT))
 		return;
-- 
2.7.4
