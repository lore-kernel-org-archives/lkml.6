Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1825685-1518709165-2-6231294244172595987
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518709164; b=WYYlUgnT4hbREbG1G80n0+XQL1A+elIij4PD6m3/lllyUCP
    PpkRrxE0k+KILFfrKwLG6X0ILjvfceyftJV/emQXDeIsmhsqSBSkkcCkTFNqII7k
    Mo9MVlpOqkS9JiLxrDTr6wartip+YFF0nX07Z7uUvpGpGD1PknTE7+N0tfI4BNvv
    aS1Cl/tjAszJbYP9SE7gbNiJVqidWNlggm0srytdhNfEdu0OxTnyMfeiZvDJWprB
    DfF0J4SNsl4GXr4j+vl+v7y45sYCTt/FdZMAbhb5uQXHMnyt9X4u/kWJUUAo2bj4
    FSfl+E/LLaQKO2Qc0r6YTKJuTy+S/IGlULif7rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518709164; bh=NCaQXAezv61IF2AxtxDfb+WwqC
    PGi9M+cCiBWhF8FAE=; b=h0909MfMYOd0FI7CNcImvv2QR0/JmHcGxlIq5g/3Z5
    LT7taGtS8YZJ7m3JBmfgPtqphvVeNPqbVoxWxVY0Z52FSoIJei+F9rCQ+019Z89v
    8LkWnOadrrm4h849WrscdOvw2QG6vL06M3l3o8ve4PEgARIEreDX2AGG0kBLVNEf
    AxD5pFspgCjnVFTiIqCvv2rnEuv84A3kdmacZxy4j+cs0ceFu6HvUSwbKT/+3+6f
    YO7Pnshv8KMwiIg9/0cVx5kXBxycVZX17NySJlGeBoUtgjVCTpwogicX9thPyGKG
    iYGGEHpYpRELv7hdklc9vkS94LTmz8AJReuCvED74WmA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423447AbeBOPjU (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:39:20 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:59728 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423106AbeBOPjS (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:39:18 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Shanker Donthineni <shankerd@codeaurora.org>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH 4.15 018/202] [Variant 3/Meltdown] arm64: mm: Remove pre_ttbr0_update_workaround for Falkor erratum #E1003
Date: Thu, 15 Feb 2018 16:15:18 +0100
Message-Id: <20180215151713.825217644@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will.deacon@arm.com>


Commit 85d13c001497 upstream.

The pre_ttbr0_update_workaround hook is called prior to context-switching
TTBR0 because Falkor erratum E1003 can cause TLB allocation with the wrong
ASID if both the ASID and the base address of the TTBR are updated at
the same time.

With the ASID sitting safely in TTBR1, we no longer update things
atomically, so we can remove the pre_ttbr0_update_workaround macro as
it's no longer required. The erratum infrastructure and documentation
is left around for #E1003, as it will be required by the entry
trampoline code in a future patch.

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Laura Abbott <labbott@redhat.com>
Tested-by: Shanker Donthineni <shankerd@codeaurora.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/include/asm/assembler.h   |   22 ----------------------
 arch/arm64/include/asm/mmu_context.h |    2 --
 arch/arm64/mm/context.c              |   11 -----------
 arch/arm64/mm/proc.S                 |    1 -
 4 files changed, 36 deletions(-)

--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -26,7 +26,6 @@
 #include <asm/asm-offsets.h>
 #include <asm/cpufeature.h>
 #include <asm/debug-monitors.h>
-#include <asm/mmu_context.h>
 #include <asm/page.h>
 #include <asm/pgtable-hwdef.h>
 #include <asm/ptrace.h>
@@ -478,27 +477,6 @@ alternative_endif
 	.endm
 
 /*
- * Errata workaround prior to TTBR0_EL1 update
- *
- * 	val:	TTBR value with new BADDR, preserved
- * 	tmp0:	temporary register, clobbered
- * 	tmp1:	other temporary register, clobbered
- */
-	.macro	pre_ttbr0_update_workaround, val, tmp0, tmp1
-#ifdef CONFIG_QCOM_FALKOR_ERRATUM_1003
-alternative_if ARM64_WORKAROUND_QCOM_FALKOR_E1003
-	mrs	\tmp0, ttbr0_el1
-	mov	\tmp1, #FALKOR_RESERVED_ASID
-	bfi	\tmp0, \tmp1, #48, #16		// reserved ASID + old BADDR
-	msr	ttbr0_el1, \tmp0
-	isb
-	bfi	\tmp0, \val, #0, #48		// reserved ASID + new BADDR
-	msr	ttbr0_el1, \tmp0
-	isb
-alternative_else_nop_endif
-#endif
-	.endm
-
 /*
  * Errata workaround post TTBR0_EL1 update.
  */
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -19,8 +19,6 @@
 #ifndef __ASM_MMU_CONTEXT_H
 #define __ASM_MMU_CONTEXT_H
 
-#define FALKOR_RESERVED_ASID	1
-
 #ifndef __ASSEMBLY__
 
 #include <linux/compiler.h>
--- a/arch/arm64/mm/context.c
+++ b/arch/arm64/mm/context.c
@@ -79,13 +79,6 @@ void verify_cpu_asid_bits(void)
 	}
 }
 
-static void set_reserved_asid_bits(void)
-{
-	if (IS_ENABLED(CONFIG_QCOM_FALKOR_ERRATUM_1003) &&
-	    cpus_have_const_cap(ARM64_WORKAROUND_QCOM_FALKOR_E1003))
-		__set_bit(FALKOR_RESERVED_ASID, asid_map);
-}
-
 static void flush_context(unsigned int cpu)
 {
 	int i;
@@ -94,8 +87,6 @@ static void flush_context(unsigned int c
 	/* Update the list of reserved ASIDs and the ASID bitmap. */
 	bitmap_clear(asid_map, 0, NUM_USER_ASIDS);
 
-	set_reserved_asid_bits();
-
 	for_each_possible_cpu(i) {
 		asid = atomic64_xchg_relaxed(&per_cpu(active_asids, i), 0);
 		/*
@@ -254,8 +245,6 @@ static int asids_init(void)
 		panic("Failed to allocate bitmap for %lu ASIDs\n",
 		      NUM_USER_ASIDS);
 
-	set_reserved_asid_bits();
-
 	pr_info("ASID allocator initialised with %lu entries\n", NUM_USER_ASIDS);
 	return 0;
 }
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -138,7 +138,6 @@ ENDPROC(cpu_do_resume)
  *	- pgd_phys - physical address of new TTB
  */
 ENTRY(cpu_do_switch_mm)
-	pre_ttbr0_update_workaround x0, x2, x3
 	mrs	x2, ttbr1_el1
 	mmid	x1, x1				// get mm->context.id
 	bfi	x2, x1, #48, #16		// set the ASID
