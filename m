Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3157214-1518623556-2-2122858161398959103
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518623555; b=q9z0PkXcrU4kMIl7kAgx+q1eRNA+QIHLzMNmiX06zfA/JVu
    YJIn76AxRcGdWi+F9DMxOyMqaMpLrjZZpoRsblZp+dumH29LfjmlN7e02xmXGZ3o
    JiDA9NYEz5+dUnC3s7MTLee1hPWwjZ5i949sKmDIS/WPJh1iFNiZcjPnc2pKX83d
    YqEzZdfS/W0tMXOfmxxRGn2tmLWjmD8s6CH8xK7Nl3aTNYTLKFvye4+FEN0PLAxY
    ijOn4qJwFAmnXGHEgId/ISPyCguiRFbuvBdl49OoNfTEZzhivs3+W0Jpj08in1f9
    fkn7sUd4uvLiKUYvOJjnDARHmK4pwzV0n8u5fpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1518623555;
    bh=/s3v19DQ4f5sPGj92UDuAjMT5jwdJ/Azi0AEYsiLKJU=; b=JcIi9hUrysSZ
    uimYlrYhpZVMCkdkDJEcKUU/dy4um2JXIoEcFfvqG1j2rYPZMxd/NLbldYAwNiVG
    c30dnelPk3Xq/3ec2r0HRu0SuyUYZL+ubwHd/gvw2ZOONK3Mla/9GhCwYB4jG4yk
    mPDleaHogpGE+U9D2ZWmj3oP4/2Wk1NVgTVzU3ekCqZmgAqjNv9+0gtemQMl4D5U
    sMuwVK9GrX8/W3WU4k/CT4qVC/Z3sTHmYUOxGRBtWLc8g2q2ylqBTtH0dDsJpCkh
    S0f70LINBx2p5fSMkTi1Ds2CCOT4tiD65iP66i+GOc8f5pGI/WGXc4TZJENuoayo
    vrsi+AnZ3Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=K5+u/SgZ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=L7K5lmlM;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=K5+u/SgZ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=L7K5lmlM;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031770AbeBNPvv (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Feb 2018 10:51:51 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:44745 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031713AbeBNPvu (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 14 Feb 2018 10:51:50 -0500
X-Google-Smtp-Source: AH8x224o/EfpqFyU20V62PEiRES7EBaVpdK27UoSMgxdJl+HNzuQo0xPpkvXkn4nrFmWJ6psj1r8hw==
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, will.deacon@arm.com,
        catalin.marinas@arm.com, broonie@linaro.org, marc.zyngier@arm.com,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH] arm64: Move post_ttbr_update_workaround to C code
Date: Wed, 14 Feb 2018 15:51:40 +0000
Message-Id: <20180214155140.27162-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180214154033.GA2745@kroah.com>
References: <20180214154033.GA2745@kroah.com>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Marc Zyngier <marc.zyngier@arm.com>

Commit 95e3de3590e3 upstream.

We will soon need to invoke a CPU-specific function pointer after changing
page tables, so move post_ttbr_update_workaround out into C code to make
this possible.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/assembler.h | 13 -------------
 arch/arm64/kernel/entry.S          |  2 +-
 arch/arm64/mm/context.c            |  9 +++++++++
 arch/arm64/mm/proc.S               |  3 +--
 4 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 6d951a82e656..463619dcadd4 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -481,19 +481,6 @@ alternative_endif
 	mrs	\rd, sp_el0
 	.endm
 
-/*
- * Errata workaround post TTBRx_EL1 update.
- */
-	.macro	post_ttbr_update_workaround
-#ifdef CONFIG_CAVIUM_ERRATUM_27456
-alternative_if ARM64_WORKAROUND_CAVIUM_27456
-	ic	iallu
-	dsb	nsh
-	isb
-alternative_else_nop_endif
-#endif
-	.endm
-
 /**
  * Errata workaround prior to disable MMU. Insert an ISB immediately prior
  * to executing the MSR that will change SCTLR_ELn[M] from a value of 1 to 0.
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index f786e8d3d5be..185c87a53fe3 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -275,7 +275,7 @@ alternative_else_nop_endif
 	 * Cavium erratum 27456 (broadcast TLBI instructions may cause I-cache
 	 * corruption).
 	 */
-	post_ttbr_update_workaround
+	bl	post_ttbr_update_workaround
 	.endif
 1:
 	.if	\el != 0
diff --git a/arch/arm64/mm/context.c b/arch/arm64/mm/context.c
index db28958d9e4f..23498d032c82 100644
--- a/arch/arm64/mm/context.c
+++ b/arch/arm64/mm/context.c
@@ -235,6 +235,15 @@ void check_and_switch_context(struct mm_struct *mm, unsigned int cpu)
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
index c25e58bc2910..27058f3fd132 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -148,8 +148,7 @@ ENTRY(cpu_do_switch_mm)
 	isb
 	msr	ttbr0_el1, x0			// now update TTBR0
 	isb
-	post_ttbr_update_workaround
-	ret
+	b	post_ttbr_update_workaround	// Back to C code...
 ENDPROC(cpu_do_switch_mm)
 
 	.pushsection ".idmap.text", "awx"
-- 
2.11.0
