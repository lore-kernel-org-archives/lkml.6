Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3218881-1519790502-2-15654990398173875077
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519790501; b=oqJnCwatmw4lsA/wzKsae6JSiuAzECLjzW1uzoCb70iv+nY
    nqffG28PQRHqbrUS6w0duu0eXXG45/TFW866dQNu3HsBSWlKM9+dV+wfZFthxGYM
    S2IfqkvnwKfbT6YLmMUXZIaNHlcKQIks4hMQOvFlE8P6NgVc+FkJ+6BZVILeK+J9
    nsbwjMJRV663+x89XtzVtXu2fZk4raDdontsNeP9rD2FEhWSxPzALRuytRtElGXj
    kXV5IE4rWsHzsjhB477ub9dNQYINmjqyxdoXuzj9PJ4RSzf/ImbCJpnQ5ZsIzBwI
    JJhVSNO+cRfb8Ab7+VzD3qQa0trA164oSkyqvoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519790501;
    bh=nhekXz+j4qe8zsvb6aqEDZ9CqrRgNU1mr7x/gWhrze4=; b=FGl/ywgLtdP1
    zyZ+9yOLK0zVaP43tdECuf1cMhTJ7ruhv2nWLqVGGtlQvr/vgS5IvsEY7vAaH837
    /SjUBB4CD4c8aOW9jvMakp1+8RVsbbSkPVia2NsvINGJ9y3PhpoRvqrvXPbFEqkm
    STJIJYF0fBSUDG+moyKjgBGLxGv+ElDHX+d6lmejj7vEvNUSjMAK27gz56xpS9j6
    9iKuY31HlciHIRXmLeY21tX5uJptW3U9qGaPSh77VhdOKTuxiRIzHUD23sS7TAoe
    Da5KllsLm/ZM2jmYmPcushMDwrqkiGmWbZgkGZS7MJNmNuWXxeepcujM/vHWDO+p
    zEMEa/8Hpw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=E780oBEF x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Y1S49Ukv;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=E780oBEF x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Y1S49Ukv;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751821AbeB1EAn (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 23:00:43 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35763 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752373AbeB1EAk (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Feb 2018 23:00:40 -0500
X-Google-Smtp-Source: AH8x224cZb1QiUQOuumU9WdSW+pKKEGNTtTRZwy5Mi3h9xUBQVmWltqPOp5ppecKDP1JuE91zekglg==
From: Alex Shi <alex.shi@linaro.org>
To: Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc: Alex Shi <alex.shi@linaro.org>
Subject: [PATCH 26/29] arm64: kpti: Add ->enable callback to remap swapper using nG mappings
Date: Wed, 28 Feb 2018 11:56:48 +0800
Message-Id: <1519790211-16582-27-git-send-email-alex.shi@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
References: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Will Deacon <will.deacon@arm.com>

commit f992b4dfd58b upstream.

Defaulting to global mappings for kernel space is generally good for
performance and appears to be necessary for Cavium ThunderX. If we
subsequently decide that we need to enable kpti, then we need to rewrite
our existing page table entries to be non-global. This is fiddly, and
made worse by the possible use of contiguous mappings, which require
a strict break-before-make sequence.

Since the enable callback runs on each online CPU from stop_machine
context, we can have all CPUs enter the idmap, where secondaries can
wait for the primary CPU to rewrite swapper with its MMU off. It's all
fairly horrible, but at least it only runs once.

Nicolas Dechesne <nicolas.dechesne@linaro.org> found a bug on this commit
which cause boot failure on db410c etc board. Ard Biesheuvel found it
writting wrong contenct to ttbr1_el1 in __idmap_cpu_set_reserved_ttbr1
macro and fixed it by give it the right content.

Tested-by: Marc Zyngier <marc.zyngier@arm.com>
Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Signed-off-by: Alex Shi <alex.shi@linaro.org>

Conflicts:
	no get_thread_info/post_ttbr_update_workaround/pre_disable_mmu_workaround
	in arch/arm64/include/asm/assembler.h and arch/arm64/mm/proc.S
---
 arch/arm64/include/asm/assembler.h |   3 +
 arch/arm64/kernel/cpufeature.c     |  25 +++++
 arch/arm64/mm/proc.S               | 201 +++++++++++++++++++++++++++++++++++--
 3 files changed, 222 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 851290d..7193bf9 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -413,4 +413,7 @@ alternative_endif
 	movk	\reg, :abs_g0_nc:\val
 	.endm
 
+	.macro	pte_to_phys, phys, pte
+	and	\phys, \pte, #(((1 << (48 - PAGE_SHIFT)) - 1) << PAGE_SHIFT)
+	.endm
 #endif	/* __ASM_ASSEMBLER_H */
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index e62583d..0fba610 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -778,6 +778,30 @@ static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
 						     ID_AA64PFR0_CSV3_SHIFT);
 }
 
+static int kpti_install_ng_mappings(void *__unused)
+{
+	typedef void (kpti_remap_fn)(int, int, phys_addr_t);
+	extern kpti_remap_fn idmap_kpti_install_ng_mappings;
+	kpti_remap_fn *remap_fn;
+
+	static bool kpti_applied = false;
+	int cpu = smp_processor_id();
+
+	if (kpti_applied)
+		return 0;
+
+	remap_fn = (void *)__pa_symbol(idmap_kpti_install_ng_mappings);
+
+	cpu_install_idmap();
+	remap_fn(cpu, num_online_cpus(), __pa_symbol(swapper_pg_dir));
+	cpu_uninstall_idmap();
+
+	if (!cpu)
+		kpti_applied = true;
+
+	return 0;
+}
+
 static int __init parse_kpti(char *str)
 {
 	bool enabled;
@@ -881,6 +905,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.capability = ARM64_UNMAP_KERNEL_AT_EL0,
 		.def_scope = SCOPE_SYSTEM,
 		.matches = unmap_kernel_at_el0,
+		.enable = kpti_install_ng_mappings,
 	},
 #endif
 	{},
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 3378f3e..5c268f5 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -148,6 +148,16 @@ alternative_else_nop_endif
 ENDPROC(cpu_do_switch_mm)
 
 	.pushsection ".idmap.text", "ax"
+
+.macro	__idmap_cpu_set_reserved_ttbr1, tmp1, tmp2
+	adrp	\tmp1, empty_zero_page
+	msr	ttbr1_el1, \tmp1
+	isb
+	tlbi	vmalle1
+	dsb	nsh
+	isb
+.endm
+
 /*
  * void idmap_cpu_replace_ttbr1(phys_addr_t new_pgd)
  *
@@ -158,13 +168,7 @@ ENTRY(idmap_cpu_replace_ttbr1)
 	mrs	x2, daif
 	msr	daifset, #0xf
 
-	adrp	x1, empty_zero_page
-	msr	ttbr1_el1, x1
-	isb
-
-	tlbi	vmalle1
-	dsb	nsh
-	isb
+	__idmap_cpu_set_reserved_ttbr1 x1, x3
 
 	msr	ttbr1_el1, x0
 	isb
@@ -175,6 +179,189 @@ ENTRY(idmap_cpu_replace_ttbr1)
 ENDPROC(idmap_cpu_replace_ttbr1)
 	.popsection
 
+#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
+	.pushsection ".idmap.text", "ax"
+
+	.macro	__idmap_kpti_get_pgtable_ent, type
+	dc	cvac, cur_\()\type\()p		// Ensure any existing dirty
+	dmb	sy				// lines are written back before
+	ldr	\type, [cur_\()\type\()p]	// loading the entry
+	tbz	\type, #0, next_\()\type	// Skip invalid entries
+	.endm
+
+	.macro __idmap_kpti_put_pgtable_ent_ng, type
+	orr	\type, \type, #PTE_NG		// Same bit for blocks and pages
+	str	\type, [cur_\()\type\()p]	// Update the entry and ensure it
+	dc	civac, cur_\()\type\()p		// is visible to all CPUs.
+	.endm
+
+/*
+ * void __kpti_install_ng_mappings(int cpu, int num_cpus, phys_addr_t swapper)
+ *
+ * Called exactly once from stop_machine context by each CPU found during boot.
+ */
+__idmap_kpti_flag:
+	.long	1
+ENTRY(idmap_kpti_install_ng_mappings)
+	cpu		.req	w0
+	num_cpus	.req	w1
+	swapper_pa	.req	x2
+	swapper_ttb	.req	x3
+	flag_ptr	.req	x4
+	cur_pgdp	.req	x5
+	end_pgdp	.req	x6
+	pgd		.req	x7
+	cur_pudp	.req	x8
+	end_pudp	.req	x9
+	pud		.req	x10
+	cur_pmdp	.req	x11
+	end_pmdp	.req	x12
+	pmd		.req	x13
+	cur_ptep	.req	x14
+	end_ptep	.req	x15
+	pte		.req	x16
+
+	mrs	swapper_ttb, ttbr1_el1
+	adr	flag_ptr, __idmap_kpti_flag
+
+	cbnz	cpu, __idmap_kpti_secondary
+
+	/* We're the boot CPU. Wait for the others to catch up */
+	sevl
+1:	wfe
+	ldaxr	w18, [flag_ptr]
+	eor	w18, w18, num_cpus
+	cbnz	w18, 1b
+
+	/* We need to walk swapper, so turn off the MMU. */
+	mrs	x18, sctlr_el1
+	bic	x18, x18, #SCTLR_ELx_M
+	msr	sctlr_el1, x18
+	isb
+
+	/* Everybody is enjoying the idmap, so we can rewrite swapper. */
+	/* PGD */
+	mov	cur_pgdp, swapper_pa
+	add	end_pgdp, cur_pgdp, #(PTRS_PER_PGD * 8)
+do_pgd:	__idmap_kpti_get_pgtable_ent	pgd
+	tbnz	pgd, #1, walk_puds
+	__idmap_kpti_put_pgtable_ent_ng	pgd
+next_pgd:
+	add	cur_pgdp, cur_pgdp, #8
+	cmp	cur_pgdp, end_pgdp
+	b.ne	do_pgd
+
+	/* Publish the updated tables and nuke all the TLBs */
+	dsb	sy
+	tlbi	vmalle1is
+	dsb	ish
+	isb
+
+	/* We're done: fire up the MMU again */
+	mrs	x18, sctlr_el1
+	orr	x18, x18, #SCTLR_ELx_M
+	msr	sctlr_el1, x18
+	isb
+
+	/* Set the flag to zero to indicate that we're all done */
+	str	wzr, [flag_ptr]
+	ret
+
+	/* PUD */
+walk_puds:
+	.if CONFIG_PGTABLE_LEVELS > 3
+	pte_to_phys	cur_pudp, pgd
+	add	end_pudp, cur_pudp, #(PTRS_PER_PUD * 8)
+do_pud:	__idmap_kpti_get_pgtable_ent	pud
+	tbnz	pud, #1, walk_pmds
+	__idmap_kpti_put_pgtable_ent_ng	pud
+next_pud:
+	add	cur_pudp, cur_pudp, 8
+	cmp	cur_pudp, end_pudp
+	b.ne	do_pud
+	b	next_pgd
+	.else /* CONFIG_PGTABLE_LEVELS <= 3 */
+	mov	pud, pgd
+	b	walk_pmds
+next_pud:
+	b	next_pgd
+	.endif
+
+	/* PMD */
+walk_pmds:
+	.if CONFIG_PGTABLE_LEVELS > 2
+	pte_to_phys	cur_pmdp, pud
+	add	end_pmdp, cur_pmdp, #(PTRS_PER_PMD * 8)
+do_pmd:	__idmap_kpti_get_pgtable_ent	pmd
+	tbnz	pmd, #1, walk_ptes
+	__idmap_kpti_put_pgtable_ent_ng	pmd
+next_pmd:
+	add	cur_pmdp, cur_pmdp, #8
+	cmp	cur_pmdp, end_pmdp
+	b.ne	do_pmd
+	b	next_pud
+	.else /* CONFIG_PGTABLE_LEVELS <= 2 */
+	mov	pmd, pud
+	b	walk_ptes
+next_pmd:
+	b	next_pud
+	.endif
+
+	/* PTE */
+walk_ptes:
+	pte_to_phys	cur_ptep, pmd
+	add	end_ptep, cur_ptep, #(PTRS_PER_PTE * 8)
+do_pte:	__idmap_kpti_get_pgtable_ent	pte
+	__idmap_kpti_put_pgtable_ent_ng	pte
+next_pte:
+	add	cur_ptep, cur_ptep, #8
+	cmp	cur_ptep, end_ptep
+	b.ne	do_pte
+	b	next_pmd
+
+	/* Secondary CPUs end up here */
+__idmap_kpti_secondary:
+	/* Uninstall swapper before surgery begins */
+	__idmap_cpu_set_reserved_ttbr1 x18, x17
+
+	/* Increment the flag to let the boot CPU we're ready */
+1:	ldxr	w18, [flag_ptr]
+	add	w18, w18, #1
+	stxr	w17, w18, [flag_ptr]
+	cbnz	w17, 1b
+
+	/* Wait for the boot CPU to finish messing around with swapper */
+	sevl
+1:	wfe
+	ldxr	w18, [flag_ptr]
+	cbnz	w18, 1b
+
+	/* All done, act like nothing happened */
+	msr	ttbr1_el1, swapper_ttb
+	isb
+	ret
+
+	.unreq	cpu
+	.unreq	num_cpus
+	.unreq	swapper_pa
+	.unreq	swapper_ttb
+	.unreq	flag_ptr
+	.unreq	cur_pgdp
+	.unreq	end_pgdp
+	.unreq	pgd
+	.unreq	cur_pudp
+	.unreq	end_pudp
+	.unreq	pud
+	.unreq	cur_pmdp
+	.unreq	end_pmdp
+	.unreq	pmd
+	.unreq	cur_ptep
+	.unreq	end_ptep
+	.unreq	pte
+ENDPROC(idmap_kpti_install_ng_mappings)
+	.popsection
+#endif
+
 /*
  *	__cpu_setup
  *
-- 
2.7.4
