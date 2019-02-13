Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E28C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04A52206C0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:33:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bd3rc/oc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394862AbfBMVdI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 16:33:08 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34561 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436813AbfBMVcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 16:32:47 -0500
Received: by mail-qk1-f196.google.com with SMTP id a15so2361567qkc.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 13:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=htX5NCY6rOuOTIoyhKI12TDdwsc2R7Wa3vlE0kAtWZo=;
        b=Bd3rc/oc98TZa70pugFF+4ZUCyk8cxClQU86pT/koqvumVajD83tjjtey5nmv+Xzeu
         vak5qd2Ml06tok0It+6AzVyXa8KvcgReAmTl/drALNkWQ2jGEKyWZ09X4vHTkOW2n6c0
         RKC0JmAbi97WQVpqxXSkTEDPF7pJ5gjCKnrVp1wjXUobPpHup1guR6AbmwD0K/51II4I
         Eqe4F6OiYqLjAhIopLv13n+gEA2h1r9ULVTzvl73tU6UUzm/lPurLiHGepviX0XmEdHW
         lMmdylw0pA7aob7qxQKu/6H0/yiBepd2+oTFnpFrGjcDR5Oo4s0tRrSaslngYBCh/LH4
         bvhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=htX5NCY6rOuOTIoyhKI12TDdwsc2R7Wa3vlE0kAtWZo=;
        b=X6nELhVHsPPRZGiiachFyyFBvOPYZqWnAdvJT71WzFHm/JmUcxkZVWU0aWhrLFdUQ6
         UZVnF88mGpuQ3mTNHBNf0VC9kXp9SsO9rEUoBtcKnbfOlZ9XrSdKCT+ktJs9niOI4SJT
         3l8frlYIYu5znJ53HpMpU1xHxZ61rMsTJepiQYdPPQzR833kGFpGxNCFd+NlQbRX44yG
         z60VIz5GDQ0KdwZUItmjn+PYl1qtwZUdjzAMqxQBFl2afi9SLiSifE0oLVTtsPSO5T2W
         h59i2RJj4gf5Wr+3+1XmPkb2nduan2N/3zHCiOjXf6cOoDRj54vSUCyO0huu7GOCcBsT
         h4Ag==
X-Gm-Message-State: AHQUAubQIrRiMzeb8UarnbMVq+gLSddIIVM+eMKrC6Sni1c6eFHAkBFo
        yNNkppi2RbvAGltZPtgZua87fg==
X-Google-Smtp-Source: AHgI3IZScYOCy2t3ydPZHF1R1hDVF+QJh+/5VQnYtvZcJHcSfN4VkZcPSm0RrxICXc1ht/aeja48Sw==
X-Received: by 2002:a37:5b47:: with SMTP id p68mr180434qkb.299.1550093566329;
        Wed, 13 Feb 2019 13:32:46 -0800 (PST)
Received: from localhost.localdomain (pool-72-71-243-63.cncdnh.fast00.myfairpoint.net. [72.71.243.63])
        by smtp.googlemail.com with ESMTPSA id 8sm382675qtr.7.2019.02.13.13.32.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 13:32:45 -0800 (PST)
From:   David Long <dave.long@linaro.org>
To:     stable@vger.kernel.org,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Tony Lindgren <tony@atomide.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Will Deacon <will.deacon@arm.com>, Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4.19 15/17] ARM: spectre-v2: per-CPU vtables to work around big.Little systems
Date:   Wed, 13 Feb 2019 16:32:21 -0500
Message-Id: <20190213213223.916-16-dave.long@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190213213223.916-1-dave.long@linaro.org>
References: <20190213213223.916-1-dave.long@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Russell King <rmk+kernel@armlinux.org.uk>

Commit 383fb3ee8024d596f488d2dbaf45e572897acbdb upstream.

In big.Little systems, some CPUs require the Spectre workarounds in
paths such as the context switch, but other CPUs do not.  In order
to handle these differences, we need per-CPU vtables.

We are unable to use the kernel's per-CPU variables to support this
as per-CPU is not initialised at times when we need access to the
vtables, so we have to use an array indexed by logical CPU number.

We use an array-of-pointers to avoid having function pointers in
the kernel's read/write .data section.

Reviewed-by: Julien Thierry <julien.thierry@arm.com>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: David A. Long <dave.long@linaro.org>
---
 arch/arm/include/asm/proc-fns.h | 23 +++++++++++++++++++++++
 arch/arm/kernel/setup.c         |  5 +++++
 arch/arm/kernel/smp.c           | 31 +++++++++++++++++++++++++++++++
 arch/arm/mm/proc-v7-bugs.c      | 17 ++---------------
 4 files changed, 61 insertions(+), 15 deletions(-)

diff --git a/arch/arm/include/asm/proc-fns.h b/arch/arm/include/asm/proc-fns.h
index c259cc49c641..e1b6f280ab08 100644
--- a/arch/arm/include/asm/proc-fns.h
+++ b/arch/arm/include/asm/proc-fns.h
@@ -104,12 +104,35 @@ extern void cpu_do_resume(void *);
 #else
 
 extern struct processor processor;
+#if defined(CONFIG_BIG_LITTLE) && defined(CONFIG_HARDEN_BRANCH_PREDICTOR)
+#include <linux/smp.h>
+/*
+ * This can't be a per-cpu variable because we need to access it before
+ * per-cpu has been initialised.  We have a couple of functions that are
+ * called in a pre-emptible context, and so can't use smp_processor_id()
+ * there, hence PROC_TABLE().  We insist in init_proc_vtable() that the
+ * function pointers for these are identical across all CPUs.
+ */
+extern struct processor *cpu_vtable[];
+#define PROC_VTABLE(f)			cpu_vtable[smp_processor_id()]->f
+#define PROC_TABLE(f)			cpu_vtable[0]->f
+static inline void init_proc_vtable(const struct processor *p)
+{
+	unsigned int cpu = smp_processor_id();
+	*cpu_vtable[cpu] = *p;
+	WARN_ON_ONCE(cpu_vtable[cpu]->dcache_clean_area !=
+		     cpu_vtable[0]->dcache_clean_area);
+	WARN_ON_ONCE(cpu_vtable[cpu]->set_pte_ext !=
+		     cpu_vtable[0]->set_pte_ext);
+}
+#else
 #define PROC_VTABLE(f)			processor.f
 #define PROC_TABLE(f)			processor.f
 static inline void init_proc_vtable(const struct processor *p)
 {
 	processor = *p;
 }
+#endif
 
 #define cpu_proc_init			PROC_VTABLE(_proc_init)
 #define cpu_check_bugs			PROC_VTABLE(check_bugs)
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index f269f4440496..7bbaa293a38c 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -115,6 +115,11 @@ EXPORT_SYMBOL(elf_hwcap2);
 
 #ifdef MULTI_CPU
 struct processor processor __ro_after_init;
+#if defined(CONFIG_BIG_LITTLE) && defined(CONFIG_HARDEN_BRANCH_PREDICTOR)
+struct processor *cpu_vtable[NR_CPUS] = {
+	[0] = &processor,
+};
+#endif
 #endif
 #ifdef MULTI_TLB
 struct cpu_tlb_fns cpu_tlb __ro_after_init;
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index f574a5e0d589..3bf82232b1be 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -42,6 +42,7 @@
 #include <asm/mmu_context.h>
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
+#include <asm/procinfo.h>
 #include <asm/processor.h>
 #include <asm/sections.h>
 #include <asm/tlbflush.h>
@@ -102,6 +103,30 @@ static unsigned long get_arch_pgd(pgd_t *pgd)
 #endif
 }
 
+#if defined(CONFIG_BIG_LITTLE) && defined(CONFIG_HARDEN_BRANCH_PREDICTOR)
+static int secondary_biglittle_prepare(unsigned int cpu)
+{
+	if (!cpu_vtable[cpu])
+		cpu_vtable[cpu] = kzalloc(sizeof(*cpu_vtable[cpu]), GFP_KERNEL);
+
+	return cpu_vtable[cpu] ? 0 : -ENOMEM;
+}
+
+static void secondary_biglittle_init(void)
+{
+	init_proc_vtable(lookup_processor(read_cpuid_id())->proc);
+}
+#else
+static int secondary_biglittle_prepare(unsigned int cpu)
+{
+	return 0;
+}
+
+static void secondary_biglittle_init(void)
+{
+}
+#endif
+
 int __cpu_up(unsigned int cpu, struct task_struct *idle)
 {
 	int ret;
@@ -109,6 +134,10 @@ int __cpu_up(unsigned int cpu, struct task_struct *idle)
 	if (!smp_ops.smp_boot_secondary)
 		return -ENOSYS;
 
+	ret = secondary_biglittle_prepare(cpu);
+	if (ret)
+		return ret;
+
 	/*
 	 * We need to tell the secondary core where to find
 	 * its stack and the page tables.
@@ -359,6 +388,8 @@ asmlinkage void secondary_start_kernel(void)
 	struct mm_struct *mm = &init_mm;
 	unsigned int cpu;
 
+	secondary_biglittle_init();
+
 	/*
 	 * The identity mapping is uncached (strongly ordered), so
 	 * switch away from it before attempting any exclusive accesses.
diff --git a/arch/arm/mm/proc-v7-bugs.c b/arch/arm/mm/proc-v7-bugs.c
index 5544b82a2e7a..9a07916af8dd 100644
--- a/arch/arm/mm/proc-v7-bugs.c
+++ b/arch/arm/mm/proc-v7-bugs.c
@@ -52,8 +52,6 @@ static void cpu_v7_spectre_init(void)
 	case ARM_CPU_PART_CORTEX_A17:
 	case ARM_CPU_PART_CORTEX_A73:
 	case ARM_CPU_PART_CORTEX_A75:
-		if (processor.switch_mm != cpu_v7_bpiall_switch_mm)
-			goto bl_error;
 		per_cpu(harden_branch_predictor_fn, cpu) =
 			harden_branch_predictor_bpiall;
 		spectre_v2_method = "BPIALL";
@@ -61,8 +59,6 @@ static void cpu_v7_spectre_init(void)
 
 	case ARM_CPU_PART_CORTEX_A15:
 	case ARM_CPU_PART_BRAHMA_B15:
-		if (processor.switch_mm != cpu_v7_iciallu_switch_mm)
-			goto bl_error;
 		per_cpu(harden_branch_predictor_fn, cpu) =
 			harden_branch_predictor_iciallu;
 		spectre_v2_method = "ICIALLU";
@@ -88,11 +84,9 @@ static void cpu_v7_spectre_init(void)
 					  ARM_SMCCC_ARCH_WORKAROUND_1, &res);
 			if ((int)res.a0 != 0)
 				break;
-			if (processor.switch_mm != cpu_v7_hvc_switch_mm && cpu)
-				goto bl_error;
 			per_cpu(harden_branch_predictor_fn, cpu) =
 				call_hvc_arch_workaround_1;
-			processor.switch_mm = cpu_v7_hvc_switch_mm;
+			cpu_do_switch_mm = cpu_v7_hvc_switch_mm;
 			spectre_v2_method = "hypervisor";
 			break;
 
@@ -101,11 +95,9 @@ static void cpu_v7_spectre_init(void)
 					  ARM_SMCCC_ARCH_WORKAROUND_1, &res);
 			if ((int)res.a0 != 0)
 				break;
-			if (processor.switch_mm != cpu_v7_smc_switch_mm && cpu)
-				goto bl_error;
 			per_cpu(harden_branch_predictor_fn, cpu) =
 				call_smc_arch_workaround_1;
-			processor.switch_mm = cpu_v7_smc_switch_mm;
+			cpu_do_switch_mm = cpu_v7_smc_switch_mm;
 			spectre_v2_method = "firmware";
 			break;
 
@@ -119,11 +111,6 @@ static void cpu_v7_spectre_init(void)
 	if (spectre_v2_method)
 		pr_info("CPU%u: Spectre v2: using %s workaround\n",
 			smp_processor_id(), spectre_v2_method);
-	return;
-
-bl_error:
-	pr_err("CPU%u: Spectre v2: incorrect context switching function, system vulnerable\n",
-		cpu);
 }
 #else
 static void cpu_v7_spectre_init(void)
-- 
2.17.1

