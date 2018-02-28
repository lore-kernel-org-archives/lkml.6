Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3220176-1519790555-2-3983316867471871263
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
    t=1519790554; b=B/y0rbaz4dnlpRojHQgIM2QXaMzAXdFwp0A6yLhcy3PMsj6
    yuAU/8Dhp/NJc/2sUlKRQO11UBcvtd1RfJAxCPbWgR9eJkjZSCVsJAI5YW7QJVrU
    NGZNGWt2vqxutFS4LZRlgydZCM6OZkYkNvpwfe7E7tB4WM0baiGjdgECac44d9W2
    kwdZGoDDqLOvrQkxeycyxOGXhBzcbBGpSevHA4ejXAq2lJyj9xnPn70MoQaymcom
    jc3mZKcXN41Zo1jR+PN1xrVf2irbqqD9JE1tT5kTH6jlM95cGVTIgpMTBK9FhtyZ
    4gfcI+LLKUusQQNK8iBex27s5LfSpBhYG/kFsMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519790554;
    bh=3X/tJlgDOIhzeNz+KgV3mfSlCMlc7iRs7Xo6UX1dC64=; b=YsHHghjpqUSZ
    J2qFBeYwpIuAFzCFIjTcnjWdwzjzn8MVL5OBsCjUHmR10FTvIWK5slGcFx7ZbKCJ
    dI2ErlK6qq4rP4HIbZsRA1CicZr+xF610cAadvGcKt5XEzMdc4/0WCA7tDois/3j
    HvA47I2FAdVL4SPIKmuCZJssYx2aCPVxnatLAaP20VywdQnAL4NONwP2eupk+F4f
    NCGXBgLxMOkDMW+9Md+nK0I9ZXSuG/w4FTbWPmuomeMuIXWnf7i4C5jTRdFZ7Nb7
    AzlV9p/2bSyI1PjiYmGg2ew5w/piHEhppl63MCucIpyKPxvlm89NcoqbztI2csSg
    5mBomyGBTA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=XU8+JuQA x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=n4IhFLFb;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=XU8+JuQA x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=n4IhFLFb;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751566AbeB1D7r (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 22:59:47 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:38539 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932196AbeB1D7p (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Feb 2018 22:59:45 -0500
X-Google-Smtp-Source: AH8x227ORuRdm1BL9hYBKN8EEFVfY4NUvLq8A2XWlQ6V20reOPLF+NPzAQA9Kp6PZKn/r/U2FfRMLA==
From: Alex Shi <alex.shi@linaro.org>
To: Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc: Alex Shi <alex.shi@linaro.org>
Subject: [PATCH 18/29] arm64: Kconfig: Reword UNMAP_KERNEL_AT_EL0 kconfig entry
Date: Wed, 28 Feb 2018 11:56:40 +0800
Message-Id: <1519790211-16582-19-git-send-email-alex.shi@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
References: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Will Deacon <will.deacon@arm.com>

commit 0617052ddde3 upstream.

Although CONFIG_UNMAP_KERNEL_AT_EL0 does make KASLR more robust, it's
actually more useful as a mitigation against speculation attacks that
can leak arbitrary kernel data to userspace through speculation.

Reword the Kconfig help message to reflect this, and make the option
depend on EXPERT so that it is on by default for the majority of users.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org>
---
 arch/arm64/Kconfig | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 6b6e9f8..c8471cf 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -734,15 +734,14 @@ config FORCE_MAX_ZONEORDER
 	  4M allocations matching the default size used by generic code.
 
 config UNMAP_KERNEL_AT_EL0
-	bool "Unmap kernel when running in userspace (aka \"KAISER\")"
+	bool "Unmap kernel when running in userspace (aka \"KAISER\")" if EXPERT
 	default y
 	help
-	  Some attacks against KASLR make use of the timing difference between
-	  a permission fault which could arise from a page table entry that is
-	  present in the TLB, and a translation fault which always requires a
-	  page table walk. This option defends against these attacks by unmapping
-	  the kernel whilst running in userspace, therefore forcing translation
-	  faults for all of kernel space.
+	  Speculation attacks against some high-performance processors can
+	  be used to bypass MMU permission checks and leak kernel data to
+	  userspace. This can be defended against by unmapping the kernel
+	  when running in userspace, mapping it back in on exception entry
+	  via a trampoline page in the vector table.
 
 	  If unsure, say Y.
 
-- 
2.7.4
