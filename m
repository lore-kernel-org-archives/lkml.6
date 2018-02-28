Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3238909-1519790651-2-13236957378381071883
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES roen, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519790651; b=K+wfDn2UuzxNn6oSxJhZNOfzItVM3p/DV0gr0mVHdgrVjg4
    MeNX+p9KZ/XBwcbOIkAaCILsMt48ZLytBhLNFz9nACGuDR1FjEcf01WAWYDX0ELt
    W6lXHNxbqjKD9cDmz9cdCyGJ/p912lNlz8NN3gjJtQwjf3fUaeHDkW13E/JLLl3W
    VZjHmqxPW2OQK3vWaCsF2GyHEXDDIuzByoDTcDmkqkNm3FonOJMHeTK4CAdne7rX
    uxtY+P8yeUwxNHI/tUVUx9FXPNdv0W59I8ga7ZjMrZ50lbqkhPl55c/wMG49aycw
    3LToxMgjI2JxfthMVEQIIxmSf/nzmemnFY4EMIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519790651;
    bh=Dc0kkeu44UfOi1EiXBfePyqu3iL2CZsHYUa6WCie3uU=; b=OBAAER5/9KBO
    ANoFvpbGR0SX9BfL32x2zMCAqJDE/F/PTWwvZ5Uij9ZuWHGajErKgWFLY/1bGCc8
    VI4Ui+0E7x2+aYPM1VpVCSDmVV8XrIUjh9MVOmXq0CH4w0EqDsWNrGxAmFPCEWOd
    Eoo+h5unylzP6cGgqiQqhVJ/HhS3ymgl++fK1B8b1k73oHoTicokqmkfkIMEDcA3
    BhJcd+7iEQPsremjM0DZGXuwJJOD6/JrbtH+d0qOQc4KYIt/EkTdnDVtjUtG4iiN
    Jwpc5RImwt+xaTJk1maD8XEZWgDpybiGYUakwG1JBpMQ68rU0KpGv46dl/lAVp5q
    igOTIaZxSg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=I2x2yCrd x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=X7g26pQA;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=I2x2yCrd x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=X7g26pQA;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752154AbeB1D6u (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 22:58:50 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:46142 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751972AbeB1D6r (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Feb 2018 22:58:47 -0500
X-Google-Smtp-Source: AH8x224WkdghL1tTZMNhJ1vSPNgcpos2tRhb2ECIB11WwhkEg/97wPtYuzDpv6DQ22wEiXS9R7DC6g==
From: Alex Shi <alex.shi@linaro.org>
To: Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc: Alex Shi <alex.shi@linaro.org>
Subject: [PATCH 10/29] arm64: mm: Map entry trampoline into trampoline and kernel page tables
Date: Wed, 28 Feb 2018 11:56:32 +0800
Message-Id: <1519790211-16582-11-git-send-email-alex.shi@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
References: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Will Deacon <will.deacon@arm.com>

commit 51a0048beb44 upstream.

The exception entry trampoline needs to be mapped at the same virtual
address in both the trampoline page table (which maps nothing else)
and also the kernel page table, so that we can swizzle TTBR1_EL1 on
exceptions from and return to EL0.

This patch maps the trampoline at a fixed virtual address in the fixmap
area of the kernel virtual address space, which allows the kernel proper
to be randomized with respect to the trampoline when KASLR is enabled.

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Laura Abbott <labbott@redhat.com>
Tested-by: Shanker Donthineni <shankerd@codeaurora.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org>

Conflicts:
	no acpi apei in arch/arm64/include/asm/fixmap.h
	no rodata in arch/arm64/mm/mmu.c
---
 arch/arm64/include/asm/fixmap.h  |  5 +++++
 arch/arm64/include/asm/pgtable.h |  1 +
 arch/arm64/kernel/asm-offsets.c  |  6 +++++-
 arch/arm64/mm/mmu.c              | 23 +++++++++++++++++++++++
 4 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/fixmap.h b/arch/arm64/include/asm/fixmap.h
index caf86be..7b1d88c 100644
--- a/arch/arm64/include/asm/fixmap.h
+++ b/arch/arm64/include/asm/fixmap.h
@@ -51,6 +51,11 @@ enum fixed_addresses {
 
 	FIX_EARLYCON_MEM_BASE,
 	FIX_TEXT_POKE0,
+
+#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
+	FIX_ENTRY_TRAMP_TEXT,
+#define TRAMP_VALIAS		(__fix_to_virt(FIX_ENTRY_TRAMP_TEXT))
+#endif /* CONFIG_UNMAP_KERNEL_AT_EL0 */
 	__end_of_permanent_fixed_addresses,
 
 	/*
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 7acd3c5..3a30a39 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -692,6 +692,7 @@ static inline void pmdp_set_wrprotect(struct mm_struct *mm,
 
 extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
 extern pgd_t idmap_pg_dir[PTRS_PER_PGD];
+extern pgd_t tramp_pg_dir[PTRS_PER_PGD];
 
 /*
  * Encode and decode a swap entry:
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index c58ddf8..5f4bf3c 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -24,6 +24,7 @@
 #include <linux/kvm_host.h>
 #include <linux/suspend.h>
 #include <asm/cpufeature.h>
+#include <asm/fixmap.h>
 #include <asm/thread_info.h>
 #include <asm/memory.h>
 #include <asm/smp_plat.h>
@@ -144,11 +145,14 @@ int main(void)
   DEFINE(ARM_SMCCC_RES_X2_OFFS,		offsetof(struct arm_smccc_res, a2));
   DEFINE(ARM_SMCCC_QUIRK_ID_OFFS,	offsetof(struct arm_smccc_quirk, id));
   DEFINE(ARM_SMCCC_QUIRK_STATE_OFFS,	offsetof(struct arm_smccc_quirk, state));
-
   BLANK();
   DEFINE(HIBERN_PBE_ORIG,	offsetof(struct pbe, orig_address));
   DEFINE(HIBERN_PBE_ADDR,	offsetof(struct pbe, address));
   DEFINE(HIBERN_PBE_NEXT,	offsetof(struct pbe, next));
   DEFINE(ARM64_FTR_SYSVAL,	offsetof(struct arm64_ftr_reg, sys_val));
+  BLANK();
+#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
+  DEFINE(TRAMP_VALIAS,		TRAMP_VALIAS);
+#endif
   return 0;
 }
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index d5cc6d7..84945c9 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -419,6 +419,29 @@ static void __init map_kernel_segment(pgd_t *pgd, void *va_start, void *va_end,
 	vm_area_add_early(vma);
 }
 
+#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
+static int __init map_entry_trampoline(void)
+{
+	extern char __entry_tramp_text_start[];
+
+	pgprot_t prot = rodata_enabled ? PAGE_KERNEL_ROX : PAGE_KERNEL_EXEC;
+	phys_addr_t pa_start = __pa_symbol(__entry_tramp_text_start);
+
+	/* The trampoline is always mapped and can therefore be global */
+	pgprot_val(prot) &= ~PTE_NG;
+
+	/* Map only the text into the trampoline page table */
+	memset(tramp_pg_dir, 0, PGD_SIZE);
+	__create_pgd_mapping(tramp_pg_dir, pa_start, TRAMP_VALIAS, PAGE_SIZE,
+			     prot, pgd_pgtable_alloc, 0);
+
+	/* ...as well as the kernel page table */
+	__set_fixmap(FIX_ENTRY_TRAMP_TEXT, pa_start, prot);
+	return 0;
+}
+core_initcall(map_entry_trampoline);
+#endif
+
 /*
  * Create fine-grained mappings for the kernel.
  */
-- 
2.7.4
