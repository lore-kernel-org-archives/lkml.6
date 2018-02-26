Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2387525-1519633975-2-11319787608045813599
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519633973; b=tLem6AQjmyAUTvo+wF7YiudZzWqY2Od6pkQAJyulJ2cPdwR
    ocv+q56IAC3kXiWY84z4h5pjKaP2/TZpbYdGvrRgWVtlKFBaI6y2eB7VisJkhPC3
    meTSMhRKOK2Vfpq2DkzxJAQKQa0RI0jX8Qwt77rr6sYMmymCkwwhKUEiZ2Bjf8pW
    N80AzbBVRLTy38YvQlRiqd64l3X8XNpbtnSXlqRWwEPwUm/dg1lBkhxoBtcaWMn5
    P9/put86GFihsOYa5wOq59k8d4JWyXUgvjQqF6Jmn7LrQYzH2maI8uWs2CMOVkL+
    kvntDgk170ZN1K2a91vgdr7xdobLeuZ2aHYXn5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519633973;
    bh=jfEkyNuRFI0AGI2zyS0Weuuew1S0Dlud8Iqkt87+Caw=; b=cstQZesnoD6H
    CHwqi0mkn0TvHsMJDC5R0dBWgucsUWn6ZyYhY5+DMBUQyQbN9a/5Zfd0Ggvvdpvc
    SlFTMRygz2rPRcuaEbfiYzPNTosYDpVESkOU9wbTeQ/Aa/8y9/cwl/hLQkZ6X6QA
    pqw5+524rUmzt/8KHyDh1eJw/uSnGwIqQRpWOy1IcPysyTE4aFiZx8qxOQdIukUe
    4HZ636WP6T+4qqytX6UtkM9Q9cFUwN0ptpinFcaxif2SF0yg9jGWQkZAw3S7bJ2b
    5MGHn6W9LJRLBlayye4GeO8V5aoqvXPencregFsUiQbOcltHxgP1Cb/sRCp194Nn
    tB7539OMtQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=C9hGrqva x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ikaof30P;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=C9hGrqva x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ikaof30P;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752383AbeBZIcv (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 03:32:51 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:38465 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752559AbeBZIXx (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Feb 2018 03:23:53 -0500
X-Google-Smtp-Source: AH8x224J7ASU5oKKSsZXOFW7AKvLKT/MuaOWBRvFaOR5S8+8UxN+x8IRA+qxAUZmzDBXF+wdRcGkdw==
From: Alex Shi <alex.shi@linaro.org>
To: Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        stable@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM64 PORT
        (AARCH64 ARCHITECTURE)), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 23/52] arm64: Add skeleton to harden the branch predictor against aliasing attacks
Date: Mon, 26 Feb 2018 16:19:57 +0800
Message-Id: <1519633227-29832-24-git-send-email-alex.shi@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519633227-29832-1-git-send-email-alex.shi@linaro.org>
References: <1519633227-29832-1-git-send-email-alex.shi@linaro.org>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Will Deacon <will.deacon@arm.com>

commit 0f15adbb2861 upstream.

Aliasing attacks against CPU branch predictors can allow an attacker to
redirect speculative control flow on some CPUs and potentially divulge
information from one context to another.

This patch adds initial skeleton code behind a new Kconfig option to
enable implementation-specific mitigations against these attacks for
CPUs that are affected.

Co-developed-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org>

Conflicts:
	expand enable_da_f in entry.S
	use 5 parameters ARM64_FTR_BITS()
	add percpu.h in mm_types.h for percpu functions
	use cpus_have_cap instead of cpus_have_const_cap
	arch/arm64/Kconfig
	arch/arm64/include/asm/cpucaps.h
	arch/arm64/include/asm/mmu.h
	arch/arm64/include/asm/sysreg.h
	arch/arm64/kernel/cpufeature.c
	arch/arm64/kernel/entry.S
	arch/arm64/mm/fault.c
---
 arch/arm64/Kconfig               | 17 +++++++++
 arch/arm64/include/asm/cpucaps.h |  3 +-
 arch/arm64/include/asm/mmu.h     | 38 +++++++++++++++++++++
 arch/arm64/include/asm/sysreg.h  |  1 +
 arch/arm64/kernel/Makefile       |  4 +++
 arch/arm64/kernel/bpi.S          | 55 +++++++++++++++++++++++++++++
 arch/arm64/kernel/cpu_errata.c   | 74 ++++++++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/cpufeature.c   |  1 +
 arch/arm64/kernel/entry.S        |  8 +++--
 arch/arm64/mm/context.c          |  2 ++
 arch/arm64/mm/fault.c            | 17 +++++++++
 include/linux/mm_types.h         |  1 +
 12 files changed, 217 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm64/kernel/bpi.S

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 7769c2e..0c4be63 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -733,6 +733,23 @@ config FORCE_MAX_ZONEORDER
 	  However for 4K, we choose a higher default value, 11 as opposed to 10, giving us
 	  4M allocations matching the default size used by generic code.
 
+config HARDEN_BRANCH_PREDICTOR
+	bool "Harden the branch predictor against aliasing attacks" if EXPERT
+	default y
+	help
+	  Speculation attacks against some high-performance processors rely on
+	  being able to manipulate the branch predictor for a victim context by
+	  executing aliasing branches in the attacker context.  Such attacks
+	  can be partially mitigated against by clearing internal branch
+	  predictor state and limiting the prediction logic in some situations.
+
+	  This config option will take CPU-specific actions to harden the
+	  branch predictor against aliasing attacks and may rely on specific
+	  instruction sequences or control bits being set by the system
+	  firmware.
+
+	  If unsure, say Y.
+
 menuconfig ARMV8_DEPRECATED
 	bool "Emulate deprecated/obsolete ARMv8 instructions"
 	depends on COMPAT
diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
index 87b4465..f8b7799 100644
--- a/arch/arm64/include/asm/cpucaps.h
+++ b/arch/arm64/include/asm/cpucaps.h
@@ -34,7 +34,8 @@
 #define ARM64_HAS_32BIT_EL0			13
 #define ARM64_HYP_OFFSET_LOW			14
 #define ARM64_MISMATCHED_CACHE_LINE_SIZE	15
+#define ARM64_HARDEN_BRANCH_PREDICTOR		16
 
-#define ARM64_NCAPS				16
+#define ARM64_NCAPS				17
 
 #endif /* __ASM_CPUCAPS_H */
diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
index b075140..203974c 100644
--- a/arch/arm64/include/asm/mmu.h
+++ b/arch/arm64/include/asm/mmu.h
@@ -28,6 +28,44 @@ typedef struct {
  */
 #define ASID(mm)	((mm)->context.id.counter & 0xffff)
 
+
+typedef void (*bp_hardening_cb_t)(void);
+
+struct bp_hardening_data {
+	int			hyp_vectors_slot;
+	bp_hardening_cb_t	fn;
+};
+
+#ifdef CONFIG_HARDEN_BRANCH_PREDICTOR
+extern char __bp_harden_hyp_vecs_start[], __bp_harden_hyp_vecs_end[];
+
+DECLARE_PER_CPU_READ_MOSTLY(struct bp_hardening_data, bp_hardening_data);
+
+static inline struct bp_hardening_data *arm64_get_bp_hardening_data(void)
+{
+	return this_cpu_ptr(&bp_hardening_data);
+}
+
+static inline void arm64_apply_bp_hardening(void)
+{
+	struct bp_hardening_data *d;
+
+	if (!cpus_have_cap(ARM64_HARDEN_BRANCH_PREDICTOR))
+		return;
+
+	d = arm64_get_bp_hardening_data();
+	if (d->fn)
+		d->fn();
+}
+#else
+static inline struct bp_hardening_data *arm64_get_bp_hardening_data(void)
+{
+	return NULL;
+}
+
+static inline void arm64_apply_bp_hardening(void)	{ }
+#endif	/* CONFIG_HARDEN_BRANCH_PREDICTOR */
+
 extern void paging_init(void);
 extern void bootmem_init(void);
 extern void __iomem *early_io_map(phys_addr_t phys, unsigned long virt);
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 7393cc7..e91710f 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -117,6 +117,7 @@
 #define ID_AA64ISAR0_AES_SHIFT		4
 
 /* id_aa64pfr0 */
+#define ID_AA64PFR0_CSV2_SHIFT		56
 #define ID_AA64PFR0_GIC_SHIFT		24
 #define ID_AA64PFR0_ASIMD_SHIFT		20
 #define ID_AA64PFR0_FP_SHIFT		16
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 7d66bba..74b8fd8 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -51,6 +51,10 @@ arm64-obj-$(CONFIG_HIBERNATION)		+= hibernate.o hibernate-asm.o
 arm64-obj-$(CONFIG_KEXEC)		+= machine_kexec.o relocate_kernel.o	\
 					   cpu-reset.o
 
+ifeq ($(CONFIG_KVM),y)
+arm64-obj-$(CONFIG_HARDEN_BRANCH_PREDICTOR)	+= bpi.o
+endif
+
 obj-y					+= $(arm64-obj-y) vdso/ probes/
 obj-m					+= $(arm64-obj-m)
 head-y					:= head.o
diff --git a/arch/arm64/kernel/bpi.S b/arch/arm64/kernel/bpi.S
new file mode 100644
index 0000000..06a931e
--- /dev/null
+++ b/arch/arm64/kernel/bpi.S
@@ -0,0 +1,55 @@
+/*
+ * Contains CPU specific branch predictor invalidation sequences
+ *
+ * Copyright (C) 2018 ARM Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/linkage.h>
+
+.macro ventry target
+	.rept 31
+	nop
+	.endr
+	b	\target
+.endm
+
+.macro vectors target
+	ventry \target + 0x000
+	ventry \target + 0x080
+	ventry \target + 0x100
+	ventry \target + 0x180
+
+	ventry \target + 0x200
+	ventry \target + 0x280
+	ventry \target + 0x300
+	ventry \target + 0x380
+
+	ventry \target + 0x400
+	ventry \target + 0x480
+	ventry \target + 0x500
+	ventry \target + 0x580
+
+	ventry \target + 0x600
+	ventry \target + 0x680
+	ventry \target + 0x700
+	ventry \target + 0x780
+.endm
+
+	.align	11
+ENTRY(__bp_harden_hyp_vecs_start)
+	.rept 4
+	vectors __kvm_hyp_vector
+	.endr
+ENTRY(__bp_harden_hyp_vecs_end)
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 8de43799..0e07893 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -46,6 +46,80 @@ static int cpu_enable_trap_ctr_access(void *__unused)
 	return 0;
 }
 
+#ifdef CONFIG_HARDEN_BRANCH_PREDICTOR
+#include <asm/mmu_context.h>
+#include <asm/cacheflush.h>
+
+DEFINE_PER_CPU_READ_MOSTLY(struct bp_hardening_data, bp_hardening_data);
+
+#ifdef CONFIG_KVM
+static void __copy_hyp_vect_bpi(int slot, const char *hyp_vecs_start,
+				const char *hyp_vecs_end)
+{
+	void *dst = lm_alias(__bp_harden_hyp_vecs_start + slot * SZ_2K);
+	int i;
+
+	for (i = 0; i < SZ_2K; i += 0x80)
+		memcpy(dst + i, hyp_vecs_start, hyp_vecs_end - hyp_vecs_start);
+
+	flush_icache_range((uintptr_t)dst, (uintptr_t)dst + SZ_2K);
+}
+
+static void __install_bp_hardening_cb(bp_hardening_cb_t fn,
+				      const char *hyp_vecs_start,
+				      const char *hyp_vecs_end)
+{
+	static int last_slot = -1;
+	static DEFINE_SPINLOCK(bp_lock);
+	int cpu, slot = -1;
+
+	spin_lock(&bp_lock);
+	for_each_possible_cpu(cpu) {
+		if (per_cpu(bp_hardening_data.fn, cpu) == fn) {
+			slot = per_cpu(bp_hardening_data.hyp_vectors_slot, cpu);
+			break;
+		}
+	}
+
+	if (slot == -1) {
+		last_slot++;
+		BUG_ON(((__bp_harden_hyp_vecs_end - __bp_harden_hyp_vecs_start)
+			/ SZ_2K) <= last_slot);
+		slot = last_slot;
+		__copy_hyp_vect_bpi(slot, hyp_vecs_start, hyp_vecs_end);
+	}
+
+	__this_cpu_write(bp_hardening_data.hyp_vectors_slot, slot);
+	__this_cpu_write(bp_hardening_data.fn, fn);
+	spin_unlock(&bp_lock);
+}
+#else
+static void __install_bp_hardening_cb(bp_hardening_cb_t fn,
+				      const char *hyp_vecs_start,
+				      const char *hyp_vecs_end)
+{
+	__this_cpu_write(bp_hardening_data.fn, fn);
+}
+#endif	/* CONFIG_KVM */
+
+static void  install_bp_hardening_cb(const struct arm64_cpu_capabilities *entry,
+				     bp_hardening_cb_t fn,
+				     const char *hyp_vecs_start,
+				     const char *hyp_vecs_end)
+{
+	u64 pfr0;
+
+	if (!entry->matches(entry, SCOPE_LOCAL_CPU))
+		return;
+
+	pfr0 = read_cpuid(ID_AA64PFR0_EL1);
+	if (cpuid_feature_extract_unsigned_field(pfr0, ID_AA64PFR0_CSV2_SHIFT))
+		return;
+
+	__install_bp_hardening_cb(fn, hyp_vecs_start, hyp_vecs_end);
+}
+#endif	/* CONFIG_HARDEN_BRANCH_PREDICTOR */
+
 #define MIDR_RANGE(model, min, max) \
 	.def_scope = SCOPE_LOCAL_CPU, \
 	.matches = is_affected_midr_range, \
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 5c41ef6..6e7fda3 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -98,6 +98,7 @@ static const struct arm64_ftr_bits ftr_id_aa64pfr0[] = {
 	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, ID_AA64PFR0_GIC_SHIFT, 4, 0),
 	S_ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR0_ASIMD_SHIFT, 4, ID_AA64PFR0_ASIMD_NI),
 	S_ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR0_FP_SHIFT, 4, ID_AA64PFR0_FP_NI),
+	ARM64_FTR_BITS(FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64PFR0_CSV2_SHIFT, 4, 0),
 	/* Linux doesn't care about the EL3 */
 	ARM64_FTR_BITS(FTR_NONSTRICT, FTR_EXACT, ID_AA64PFR0_EL3_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, ID_AA64PFR0_EL2_SHIFT, 4, 0),
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 0a27e12..bdb0139 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -549,13 +549,15 @@ el0_ia:
 	 * Instruction abort handling
 	 */
 	mrs	x26, far_el1
-	// enable interrupts before calling the main handler
-	enable_dbg_and_irq
+	msr	daifclr, #(8 | 4 | 1)
+#ifdef CONFIG_TRACE_IRQFLAGS
+	bl	trace_hardirqs_off
+#endif
 	ct_user_exit
 	mov	x0, x26
 	mov	x1, x25
 	mov	x2, sp
-	bl	do_mem_abort
+	bl	do_el0_ia_bp_hardening
 	b	ret_to_user
 el0_fpsimd_acc:
 	/*
diff --git a/arch/arm64/mm/context.c b/arch/arm64/mm/context.c
index 32eeabe91..afc9266 100644
--- a/arch/arm64/mm/context.c
+++ b/arch/arm64/mm/context.c
@@ -231,6 +231,8 @@ asmlinkage void post_ttbr_update_workaround(void)
 			"ic iallu; dsb nsh; isb",
 			ARM64_WORKAROUND_CAVIUM_27456,
 			CONFIG_CAVIUM_ERRATUM_27456));
+
+	arm64_apply_bp_hardening();
 }
 
 static int asids_init(void)
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 4df70c9..c95b194 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -590,6 +590,23 @@ asmlinkage void __exception do_mem_abort(unsigned long addr, unsigned int esr,
 	arm64_notify_die("", regs, &info, esr);
 }
 
+asmlinkage void __exception do_el0_ia_bp_hardening(unsigned long addr,
+						   unsigned int esr,
+						   struct pt_regs *regs)
+{
+	/*
+	 * We've taken an instruction abort from userspace and not yet
+	 * re-enabled IRQs. If the address is a kernel address, apply
+	 * BP hardening prior to enabling IRQs and pre-emption.
+	 */
+	if (addr > TASK_SIZE)
+		arm64_apply_bp_hardening();
+
+	local_irq_enable();
+	do_mem_abort(addr, esr, regs);
+}
+
+
 /*
  * Handle stack alignment exceptions.
  */
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index e8471c2..15a82f3 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -13,6 +13,7 @@
 #include <linux/uprobes.h>
 #include <linux/page-flags-layout.h>
 #include <linux/workqueue.h>
+#include <linux/percpu.h>
 #include <asm/page.h>
 #include <asm/mmu.h>
 
-- 
2.7.4
