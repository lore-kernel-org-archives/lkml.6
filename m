Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3238909-1519790700-2-1651606837734968764
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519790699; b=n4+/y05wuXrfbQmJJs4SNZwx5GHM/Y+v7d6QFBs6P/lbr1I
    lQ1H9CvB95sGnEoktXE79T1+b8LRl8xXBrg//m6jvY4JXyA6Xs0w13rOfWIWSTdq
    u4A1FD3DXn24gCT3o6TYcxtacfpyF7UCU02GGX82K3SSHa2pqJMsA+R1rNOWARdc
    Sd4m5ztR6FqrNGuxa6Y8SYV6wIVNLkoNiT4LihmgS1ydGXVC6KAPNzmNuGtc7Bx+
    O+iCmt1an/v7ppHzuGnPJuY5viYCEjG4AdSp3w2iSZF84upqBmAShxeyiovEwk9M
    M8O6/yATfk4bmkTwDALl4mHkt/0CeX49WxDdeIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519790699;
    bh=JlI9DP1HlKjji9zn/7bpfmOr/uB1krsnDWBdsArXfLk=; b=fTTOXhhmd6kY
    AMu4HKzqQ3mXOLaJ4YwO2GNGRGGuVbF8fu81oGzZJYpK+I/g2tBfZu5iZqSDdNL/
    5ThBCIchxh34DERkk8ieC+zp7HrVjpi8b6Dc9c4Pmr9Sh83uqW3zqUH9JpayTBhf
    ehs3pMuVvmpldRGUGvalWfwNCYVlJT0WFkljIPGQrvp/M5aNPC75DSX+UnPhptCf
    TncWUK7gONhNmwcaCbsZboj4saMoWMisjRGhH1HtfYGXvV4iLKjtcp6pHnxwZ/a5
    RJ4lHoBl4ILIHYL2BJt18WiphSMrOX2LK/w64pCyTLp2Sc09ny3ItWFaUcgTXGWZ
    KFSw+ykL7A==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=RQH5Gop9 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ZL6NAsa0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=RQH5Gop9 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ZL6NAsa0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751761AbeB1EE4 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 23:04:56 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:43783 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751880AbeB1D5o (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Feb 2018 22:57:44 -0500
X-Google-Smtp-Source: AH8x225pH61GA44SAyTeUZvevtVHkYINqQmetMstU7nYwJKhpKHBs0dAwTaSwj8Xe1kbHskrvQOw8w==
From: Alex Shi <alex.shi@linaro.org>
To: Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc: Alex Shi <alex.shi@linaro.org>
Subject: [PATCH 02/29] arm64: mm: Move ASID from TTBR0 to TTBR1
Date: Wed, 28 Feb 2018 11:56:24 +0800
Message-Id: <1519790211-16582-3-git-send-email-alex.shi@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
References: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Will Deacon <will.deacon@arm.com>

commit 7655abb95386 upstream.

In preparation for mapping kernelspace and userspace with different
ASIDs, move the ASID to TTBR1 and update switch_mm to context-switch
TTBR0 via an invalid mapping (the zero page).

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Laura Abbott <labbott@redhat.com>
Tested-by: Shanker Donthineni <shankerd@codeaurora.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org>

Conflicts:
	no pre_ttbr0_update_workaround in arch/arm64/mm/proc.S
---
 arch/arm64/include/asm/mmu_context.h   | 7 +++++++
 arch/arm64/include/asm/pgtable-hwdef.h | 1 +
 arch/arm64/include/asm/proc-fns.h      | 6 ------
 arch/arm64/mm/proc.S                   | 9 ++++++---
 4 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index a501853..b96c4799 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -50,6 +50,13 @@ static inline void cpu_set_reserved_ttbr0(void)
 	isb();
 }
 
+static inline void cpu_switch_mm(pgd_t *pgd, struct mm_struct *mm)
+{
+	BUG_ON(pgd == swapper_pg_dir);
+	cpu_set_reserved_ttbr0();
+	cpu_do_switch_mm(virt_to_phys(pgd),mm);
+}
+
 /*
  * TCR.T0SZ value to use when the ID map is active. Usually equals
  * TCR_T0SZ(VA_BITS), unless system RAM is positioned very high in
diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
index eb0c2bd..8df4cb6 100644
--- a/arch/arm64/include/asm/pgtable-hwdef.h
+++ b/arch/arm64/include/asm/pgtable-hwdef.h
@@ -272,6 +272,7 @@
 #define TCR_TG1_4K		(UL(2) << TCR_TG1_SHIFT)
 #define TCR_TG1_64K		(UL(3) << TCR_TG1_SHIFT)
 
+#define TCR_A1			(UL(1) << 22)
 #define TCR_ASID16		(UL(1) << 36)
 #define TCR_TBI0		(UL(1) << 37)
 #define TCR_HA			(UL(1) << 39)
diff --git a/arch/arm64/include/asm/proc-fns.h b/arch/arm64/include/asm/proc-fns.h
index 14ad6e4..16cef2e 100644
--- a/arch/arm64/include/asm/proc-fns.h
+++ b/arch/arm64/include/asm/proc-fns.h
@@ -35,12 +35,6 @@ extern u64 cpu_do_resume(phys_addr_t ptr, u64 idmap_ttbr);
 
 #include <asm/memory.h>
 
-#define cpu_switch_mm(pgd,mm)				\
-do {							\
-	BUG_ON(pgd == swapper_pg_dir);			\
-	cpu_do_switch_mm(virt_to_phys(pgd),mm);		\
-} while (0)
-
 #endif /* __ASSEMBLY__ */
 #endif /* __KERNEL__ */
 #endif /* __ASM_PROCFNS_H */
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 352c73b..3378f3e 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -132,9 +132,12 @@ ENDPROC(cpu_do_resume)
  *	- pgd_phys - physical address of new TTB
  */
 ENTRY(cpu_do_switch_mm)
+	mrs	x2, ttbr1_el1
 	mmid	x1, x1				// get mm->context.id
-	bfi	x0, x1, #48, #16		// set the ASID
-	msr	ttbr0_el1, x0			// set TTBR0
+	bfi	x2, x1, #48, #16		// set the ASID
+	msr	ttbr1_el1, x2			// in TTBR1 (since TCR.A1 is set)
+	isb
+	msr	ttbr0_el1, x0			// now update TTBR0
 	isb
 alternative_if ARM64_WORKAROUND_CAVIUM_27456
 	ic	iallu
@@ -222,7 +225,7 @@ ENTRY(__cpu_setup)
 	 * both user and kernel.
 	 */
 	ldr	x10, =TCR_TxSZ(VA_BITS) | TCR_CACHE_FLAGS | TCR_SMP_FLAGS | \
-			TCR_TG_FLAGS | TCR_ASID16 | TCR_TBI0
+			TCR_TG_FLAGS | TCR_ASID16 | TCR_TBI0 | TCR_A1
 	tcr_set_idmap_t0sz	x10, x9
 
 	/*
-- 
2.7.4
