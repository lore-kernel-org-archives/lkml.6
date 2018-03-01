Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2898263-1519909119-2-9507455704665983268
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
    t=1519909119; b=sMSOR0sENc8S8aNx+UsDUxauKtHbwMJW+JoDe+WmgPL06Mh
    CaMu6wL5s+YG5j/YEa+K+erdpTdqW5HTNYC5CcSGCHtxEccE/FxkqgzQ/pCvqT7c
    Qq0kt+6IC7eY7Axi2JM19iWr0EZnlP7Ze8Pswx7feBUIQpHb2mfnLFCKJ3UkPHnv
    /rkhjY9rcJ5ghn1doiHLaJDTQdKB4mDhdrIE/YoTSA1+hvbiwWECP95DDImXTgBf
    b67l/LCWJTwBaW6cbpgmMusTupMb6q2mTed/rX1bdPdZDXyD42JWtTyDXBvQpfEl
    I+hoSPJ/HoHe+s8zU3SECggVgShY6sj0N3tMkww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519909119;
    bh=BzSs6B5O9af3dF01m9Oi65XG3SRNuoRk/WR0mJQYa1U=; b=FPOHDoepD9y0
    l0u1SQ8TY9DYKvp1F/+X3jXCDk9A/VMnExErapxqa1HgjiL5sn9QMG6DF1Kz7qpY
    sMyomW+2kYd3+Zo69ueUiXLotCzCcyN9djl4liN2vfBBoxhL86lWsxiJJ+3EqE3a
    Un6UzIvWVKeLY8ZHS2D8RS344G0q6DGMDg/jsS91sNxIJxKVa3TctBZX7wV8YO0s
    RfeZP29kBtz9EimA7VkxdHsEC7lavYaCEI43JP1H0Q08fo2aLTW0fCnpSKoNPjqV
    Whpz0QMmcc/djtfanQ1UjyMkcw8OJqSajJg5S+oKADslFW4aCGsDUElJdK+hPabo
    L/57OAfM/A==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=G9Xpb+GJ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ICSQfMfS;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=G9Xpb+GJ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ICSQfMfS;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030643AbeCAM6f (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Mar 2018 07:58:35 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:44110 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030613AbeCAM6d (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Mar 2018 07:58:33 -0500
X-Google-Smtp-Source: AG47ELsSaHpLouGpAiK9eWqrim4cDZZDopX6aelhZ+aZklaZr9ZC4iYpduQn9xnN61fTwMcklfdgAg==
From: Alex Shi <alex.shi@linaro.org>
To: Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc: Alex Shi <alex.shi@linaro.org>
Subject: [PATCH 22/45] arm64: Move post_ttbr_update_workaround to C code
Date: Thu,  1 Mar 2018 20:53:59 +0800
Message-Id: <1519908862-11425-23-git-send-email-alex.shi@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519908862-11425-1-git-send-email-alex.shi@linaro.org>
References: <1519908862-11425-1-git-send-email-alex.shi@linaro.org>
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
