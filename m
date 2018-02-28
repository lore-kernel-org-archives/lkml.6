Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3218881-1519790513-2-3615419244527091141
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
    t=1519790513; b=QqwgnfXAW9iVWreJXRU6KT0x/TV6ul9CwSL6fR5p9a0xEJL
    mceWnXRJjHTXoMB93foPAj4mcOtIAAnQJtWJ624v6C5Ekr4cGF5qAA2ryu/4aFpu
    sC8WgegLuZJJo3why9TNf+4JAnH//Xg//qk3+/vM9BYiZeBmHFjandfwrnSHfpit
    m3+w7a/8WAiuTVhXQwyAOmsX4zC4nGesSKxlHbauiVdXpxZDqbaRkI/UwmRxkPo/
    ysPO14S8ldkonhT74T8cD+bKi6Bpyfba/nqG1FXme39YvuIXuH+VhBUMFr6GO+IR
    AXRAF75KFghZvFXvCtiUvggSNZ5O4vAmLjIreJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519790513;
    bh=JC5B9Ogq58f9r18lYBOpTdl94tTzOD0MxFQZk4nXoSI=; b=HcrE8klb/Hu5
    HRhBItStQXU8Hqw0TnZlgHV7uTaynQ/sBC10tyIrjH8Nx+2fTNWcOL22s/9XFpmJ
    U7+64LJ7vGD9YTu17UmPBMKd7wl0Ca7MBOoq8DQ3g9EC71C002k699HdcS8c7q57
    +MHjl8qjwdbxSQDygD0q4/3rt6UX6uN2Io+UflU6KjLYbVmiRViuUJw0UfDzPSLG
    eFEHHxBLGJOOvoCS9URQ/ufzEvxCoB0X5QDfejebz5EOpGs+h7+T52OiNwIIjkcz
    gpamj/eZMHuI6P5bZK9unX5JCU5Rqiwr2v1bst5kbniE4qn07PhZNH5pGflJSmwr
    DNNcsUpgiA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=ZrT0fHbE x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=sylWBO9O;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=ZrT0fHbE x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=sylWBO9O;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752347AbeB1EA3 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 23:00:29 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:34165 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752340AbeB1EA0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Feb 2018 23:00:26 -0500
X-Google-Smtp-Source: AH8x224+CnVfyUNg1L5afvXWuQl4vQMpd6FZ6JGuN/m2lUj3lz2krvUHm1GwwXqLBenkqUebj9TXQQ==
From: Alex Shi <alex.shi@linaro.org>
To: Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc: Jayachandran C <jnair@caviumnetworks.com>,
        Alex Shi <alex.shi@linaro.org>
Subject: [PATCH 24/29] arm64: Turn on KPTI only on CPUs that need it
Date: Wed, 28 Feb 2018 11:56:46 +0800
Message-Id: <1519790211-16582-25-git-send-email-alex.shi@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
References: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jayachandran C <jnair@caviumnetworks.com>

commit 0ba2e29c7fc1 upstream.

Whitelist Broadcom Vulcan/Cavium ThunderX2 processors in
unmap_kernel_at_el0(). These CPUs are not vulnerable to
CVE-2017-5754 and do not need KPTI when KASLR is off.

Acked-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Jayachandran C <jnair@caviumnetworks.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org>
---
 arch/arm64/kernel/cpufeature.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 6200b81..e62583d 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -766,6 +766,13 @@ static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
 	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE))
 		return true;
 
+	/* Don't force KPTI for CPUs that are not vulnerable */
+	switch (read_cpuid_id() & MIDR_CPU_MODEL_MASK) {
+	case MIDR_CAVIUM_THUNDERX2:
+	case MIDR_BRCM_VULCAN:
+		return false;
+	}
+
 	/* Defer to CPU feature registers */
 	return !cpuid_feature_extract_unsigned_field(pfr0,
 						     ID_AA64PFR0_CSV3_SHIFT);
-- 
2.7.4
