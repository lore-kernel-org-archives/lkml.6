Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2387525-1519634348-2-4931207037515446929
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
    t=1519634348; b=USiQOTAKj8M1zcfXYwYhYs1JCWl37cN4+QNLuQ0ZkRKvDBg
    WQUoAQaEhI05CE74NpGWEU/GvPcYpCd1JHT9xanCmfMw3QPBvq8pGrPkcvihDvhB
    elWsiJKY0kRyclK8HsqFV+o+sMct5BkWIQToZuQHYFlxf2/+4rVZbsf9iQgP7q/V
    kD1yDf0s2yhUH+HG5ND1YOPlBHmkb+yQr7MFwZxJsquXMaOJq/UbsiXSSRWqDIwm
    7AaZ1wZOudKKl6ZXwOmawGiNM5+RYDQ67noGK1+tBuyHIdXu+SaLQx+r3X//64Gc
    WdeY5uS4fiochsLyx9zhxIAHVMRCzKH9/+TDgzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519634348;
    bh=S7mDzt0hDdeMXb+Y/dfIW9xk1gio9KtJLmPeqeLlojg=; b=eXvUg/GjZyLI
    HncH6XTsLERukVsQs/B5IsWbzv0Sba7Z8r14kgDqV+x+NSo8w/XxEMopLMqpLU1b
    zT7mYwRtxGX6y36YvkDbEZjBlupoQKSrJ0nFIvwN23cH76ITJnbQL5TwXfBokzQG
    1p4AERtLIZLOi0dvwBad4P9xfP5OpLvpgFfJqKdvbuwNMflZQv/AeImZ/EVvQvtf
    NZfqM4QaehLUgm1TcCSUBoV2t7ucTqf5C2qErCqURXjMQ1at9CwBRrCxLYADB7lW
    F6RqROK5eqfea7TZwXmgFZt/g2BHNvuL4g3r+by3eraxsDqMDH+JqtB3I+FT/qia
    uoIQdu8FrA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=GfQzyVoC x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=BdE1mBmf;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=GfQzyVoC x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=BdE1mBmf;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752060AbeBZIVZ (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 03:21:25 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:44877 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751747AbeBZIVV (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Feb 2018 03:21:21 -0500
X-Google-Smtp-Source: AH8x225kQSqVo/1umYFQZN9UdjY+LNm2nUgysg+dyYaabzeAaQUlO3bKoDKlR150TXLj6Eaq0BiHqg==
From: Alex Shi <alex.shi@linaro.org>
To: Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        stable@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM64 PORT
        (AARCH64 ARCHITECTURE)), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 02/52] arm64: alternatives: apply boot time fixups via the linear mapping
Date: Mon, 26 Feb 2018 16:19:36 +0800
Message-Id: <1519633227-29832-3-git-send-email-alex.shi@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519633227-29832-1-git-send-email-alex.shi@linaro.org>
References: <1519633227-29832-1-git-send-email-alex.shi@linaro.org>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Ard Biesheuvel <ard.biesheuvel@linaro.org>

commit 5ea5306c323 upstream.

One important rule of thumb when desiging a secure software system is
that memory should never be writable and executable at the same time.
We mostly adhere to this rule in the kernel, except at boot time, when
regions may be mapped RWX until after we are done applying alternatives
or making other one-off changes.

For the alternative patching, we can improve the situation by applying
the fixups via the linear mapping, which is never mapped with executable
permissions. So map the linear alias of .text with RW- permissions
initially, and remove the write permissions as soon as alternative
patching has completed.

Reviewed-by: Laura Abbott <labbott@redhat.com>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org>

Conflicts:
	replace update_mapping_prot with old create_mapping_late
	arch/arm64/mm/mmu.c
---
 arch/arm64/include/asm/mmu.h    |  1 +
 arch/arm64/kernel/alternative.c | 11 ++++++-----
 arch/arm64/kernel/smp.c         |  1 +
 arch/arm64/mm/mmu.c             | 22 +++++++++++++++++-----
 4 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
index 8d9fce0..b075140 100644
--- a/arch/arm64/include/asm/mmu.h
+++ b/arch/arm64/include/asm/mmu.h
@@ -36,5 +36,6 @@ extern void create_pgd_mapping(struct mm_struct *mm, phys_addr_t phys,
 			       unsigned long virt, phys_addr_t size,
 			       pgprot_t prot, bool allow_block_mappings);
 extern void *fixmap_remap_fdt(phys_addr_t dt_phys);
+extern void mark_linear_text_alias_ro(void);
 
 #endif
diff --git a/arch/arm64/kernel/alternative.c b/arch/arm64/kernel/alternative.c
index 06d650f..8840c10 100644
--- a/arch/arm64/kernel/alternative.c
+++ b/arch/arm64/kernel/alternative.c
@@ -105,11 +105,11 @@ static u32 get_alt_insn(struct alt_instr *alt, u32 *insnptr, u32 *altinsnptr)
 	return insn;
 }
 
-static void __apply_alternatives(void *alt_region)
+static void __apply_alternatives(void *alt_region, bool use_linear_alias)
 {
 	struct alt_instr *alt;
 	struct alt_region *region = alt_region;
-	u32 *origptr, *replptr;
+	u32 *origptr, *replptr, *updptr;
 
 	for (alt = region->begin; alt < region->end; alt++) {
 		u32 insn;
@@ -124,11 +124,12 @@ static void __apply_alternatives(void *alt_region)
 
 		origptr = ALT_ORIG_PTR(alt);
 		replptr = ALT_REPL_PTR(alt);
+		updptr = use_linear_alias ? (u32 *)lm_alias(origptr) : origptr;
 		nr_inst = alt->alt_len / sizeof(insn);
 
 		for (i = 0; i < nr_inst; i++) {
 			insn = get_alt_insn(alt, origptr + i, replptr + i);
-			*(origptr + i) = cpu_to_le32(insn);
+			updptr[i] = cpu_to_le32(insn);
 		}
 
 		flush_icache_range((uintptr_t)origptr,
@@ -155,7 +156,7 @@ static int __apply_alternatives_multi_stop(void *unused)
 		isb();
 	} else {
 		BUG_ON(patched);
-		__apply_alternatives(&region);
+		__apply_alternatives(&region, true);
 		/* Barriers provided by the cache flushing */
 		WRITE_ONCE(patched, 1);
 	}
@@ -176,5 +177,5 @@ void apply_alternatives(void *start, size_t length)
 		.end	= start + length,
 	};
 
-	__apply_alternatives(&region);
+	__apply_alternatives(&region, false);
 }
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index a70f7d3..66db515 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -426,6 +426,7 @@ void __init smp_cpus_done(unsigned int max_cpus)
 	setup_cpu_features();
 	hyp_mode_check();
 	apply_alternatives_all();
+	mark_linear_text_alias_ro();
 }
 
 void __init smp_prepare_boot_cpu(void)
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index d5cc6d7..5dc72c0 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -354,16 +354,28 @@ static void __init __map_memblock(pgd_t *pgd, phys_addr_t start, phys_addr_t end
 				     !debug_pagealloc_enabled());
 
 	/*
-	 * Map the linear alias of the [_text, __init_begin) interval as
-	 * read-only/non-executable. This makes the contents of the
-	 * region accessible to subsystems such as hibernate, but
-	 * protects it from inadvertent modification or execution.
+	 * Map the linear alias of the [_text, __init_begin) interval
+	 * as non-executable now, and remove the write permission in
+	 * mark_linear_text_alias_ro() below (which will be called after
+	 * alternative patching has completed). This makes the contents
+	 * of the region accessible to subsystems such as hibernate,
+	 * but protects it from inadvertent modification or execution.
 	 */
 	__create_pgd_mapping(pgd, kernel_start, __phys_to_virt(kernel_start),
-			     kernel_end - kernel_start, PAGE_KERNEL_RO,
+			     kernel_end - kernel_start, PAGE_KERNEL,
 			     early_pgtable_alloc, !debug_pagealloc_enabled());
 }
 
+void __init mark_linear_text_alias_ro(void)
+{
+	/*
+	 * Remove the write permissions from the linear alias of .text/.rodata
+	 */
+	create_mapping_late(__pa_symbol(_text), (unsigned long)lm_alias(_text),
+			    (unsigned long)__init_begin - (unsigned long)_text,
+			    PAGE_KERNEL_RO);
+}
+
 static void __init map_mem(pgd_t *pgd)
 {
 	struct memblock_region *reg;
-- 
2.7.4
