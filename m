Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2387443-1519633976-2-529037209653921423
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
    t=1519633976; b=igOBZI7U3qpFyULUXBL1wHtAYQHhBceuZ5IfxtcU4wAkXcM
    dCc9S5EFccxsrgN98msDIHzvHplzXsBXg9fu5GIG5iyXpD5wRJCGAIvabaiV0yVP
    mhzb4r/tOtRbaZfkjLHL0o4b7NJGvtsFCRdl9BEGbLuzVm1kyXA5uKbv7ZpjPzja
    VwP2TyRjbGuO6ri7lR4GM0qThb24+ZasQTcVSzeVFGscihKYKWe2h52JkT5yKTtQ
    P78X4rrqP/Ix1qM/9wopBwhS5VloN86DkDAFX50mAjI2Ht1HF5QepxJdWRSiB+8E
    TThlbH+uhoDWRqql5Si0HnSu8WqNHs/nQ+NM9AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519633976;
    bh=vlTjjzmQguibQ42hHx0fE9h4nxyZ4I8LAAjWye+MNJs=; b=LajjV54o7z/8
    A/HqWflQY/LGcAS4B1FgfPKl6TSjgjJG4gtaWk7Eoput81jrBp6xEV8f4ntv/kaD
    XnWYvm8aAEaHf31O55qczHAdYeA0x31N2a49Fo/GKl/+l9Yl52grbAHne7t/ce9J
    XURXXxeXs+evUjqunRJxUrgLhtxi5ZD34QByC1im8/mrcElIMUe3YeMRztyDpcje
    ypcoGtNzoKp5IlXw3oe4Tp5YRnRRe0ZFgDauDntfUJiEgY9viz5W4m3BDtjjMqzA
    Do4usYafroqzm6RDIAnUtXvJwbw1b20y3CBCGga52XDyzWz5pVPjlkbbIAuYF3HU
    CRGxi405vw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=H6XzJ+Lr x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Mk5r7wi7;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=H6XzJ+Lr x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Mk5r7wi7;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751744AbeBZIXu (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 03:23:50 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:38458 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752027AbeBZIXq (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Feb 2018 03:23:46 -0500
X-Google-Smtp-Source: AH8x2267k017SDF2WB0n8U3qS2OV8t1iHahAyZ4FhjxYM+Xk4cwFfX36vZn4bpcBdqHw4YkfxrnGxA==
From: Alex Shi <alex.shi@linaro.org>
To: Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        stable@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM64 PORT
        (AARCH64 ARCHITECTURE)), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 22/52] arm64: Move post_ttbr_update_workaround to C code
Date: Mon, 26 Feb 2018 16:19:56 +0800
Message-Id: <1519633227-29832-23-git-send-email-alex.shi@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519633227-29832-1-git-send-email-alex.shi@linaro.org>
References: <1519633227-29832-1-git-send-email-alex.shi@linaro.org>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Marc Zyngier <marc.zyngier@arm.com>

commit 95e3de3590e3 upstream.

We will soon need to invoke a CPU-specific function pointer after changing
page tables, so move post_ttbr_update_workaround out into C code to make
this possible.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org>

Conflicts:
	don't include PAN related changes
	arch/arm64/include/asm/assembler.h
	arch/arm64/kernel/entry.S
	arch/arm64/mm/proc.S
---
 arch/arm64/mm/context.c | 9 +++++++++
 arch/arm64/mm/proc.S    | 3 +--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/context.c b/arch/arm64/mm/context.c
index efcf1f7..32eeabe91 100644
--- a/arch/arm64/mm/context.c
+++ b/arch/arm64/mm/context.c
@@ -224,6 +224,15 @@ void check_and_switch_context(struct mm_struct *mm, unsigned int cpu)
 	cpu_switch_mm(mm->pgd, mm);
 }
 
+/* Errata workaround post TTBRx_EL1 update. */
+asmlinkage void post_ttbr_update_workaround(void)
+{
+	asm(ALTERNATIVE("nop; nop; nop",
+			"ic iallu; dsb nsh; isb",
+			ARM64_WORKAROUND_CAVIUM_27456,
+			CONFIG_CAVIUM_ERRATUM_27456));
+}
+
 static int asids_init(void)
 {
 	asid_bits = get_cpu_asid_bits();
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index c2adb0c..cca061a 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -136,8 +136,7 @@ ENTRY(cpu_do_switch_mm)
 	bfi	x0, x1, #48, #16		// set the ASID
 	msr	ttbr0_el1, x0			// set TTBR0
 	isb
-	post_ttbr0_update_workaround
-	ret
+	b	post_ttbr_update_workaround	// Back to C code...
 ENDPROC(cpu_do_switch_mm)
 
 	.pushsection ".idmap.text", "ax"
-- 
2.7.4
