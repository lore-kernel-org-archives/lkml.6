Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3218881-1519790496-2-1160444775918391003
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
    t=1519790496; b=OGIQCQXHze/4pt5WmnyGMKBPkadyvR/bAsFVFEcczHM7eKw
    BLiN9OuLUfsE/UrBxIT27tARyUCVoj4LVWaNQYKF31ozkVXqhbW01KWzR3OmMZXl
    wQ+8gcKds5CuQn9GEMQr61x46gyJBjkcCqc7vQZ33Dz3ZgR0RPwhXtJgwHmFSS2m
    3m2BPGLAmW+9nzPQ72hEtMwsj6mCGSb5yf2675FzHH7pvgHz00SKv5cu5bPBS4ZH
    7a+76DSaLZoSAPZeS8jxIr/hH+AN0P7hISsZfhfB3/rFDDJ1i9wUUMeF9oXWor9/
    AMnhF+Cz1o2fyNMQtf5uXmXO3E9+wl3AREBk6RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519790496;
    bh=61Y8iHNGS/LyzooAj6849j03LY7srEwVDjkJR8E93VM=; b=b+7SkRX4B8T9
    wU5xUuxn9U2VeBCOatLQRcPU/q4NP0x4phF1kvlJM1E7v9V+u431Jq5Mg+lLoY1e
    wrmWxJTvxlRMzz/pQZ96dpRJYo55NQNtRDi04J9rSyL48p3gQi68H/qai7D0VGDh
    QGm+Gw2Q/I+dvQlYoCyrztuQ7qpKBUJVTC3Sr8g28FmY/cv0/1RnE6nEF1lGkgdt
    X9xr/DJtD32dklUsMYSCoSIAGJN1CJgHySJzCjJMO/txWKuGNBC/YfIRNBCL2/p6
    xUl4C4pr65lZB2QDOwjgZt59tP4lrjak5hpTW6YZnMZ63E64fVP9J680Tt6EbQlN
    GVfEqDZFFw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=dNmpN4p3 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=pGz1zpkq;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=dNmpN4p3 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=pGz1zpkq;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752409AbeB1EAw (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 23:00:52 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:46707 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752403AbeB1EAu (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Feb 2018 23:00:50 -0500
X-Google-Smtp-Source: AH8x224sO3tK3v8mdNzockHnBxio9++P4ASCw19fhUjfOLeViSJe33kzC/OOReUREt2fmAZOGvnfqg==
From: Alex Shi <alex.shi@linaro.org>
To: Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc: Alex Shi <alex.shi@linaro.org>
Subject: [PATCH 27/29] arm64: Force KPTI to be disabled on Cavium ThunderX
Date: Wed, 28 Feb 2018 11:56:49 +0800
Message-Id: <1519790211-16582-28-git-send-email-alex.shi@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
References: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Marc Zyngier <marc.zyngier@arm.com>

commit 6dc52b15c4a4 upstream.

Cavium ThunderX's erratum 27456 results in a corruption of icache
entries that are loaded from memory that is mapped as non-global
(i.e. ASID-tagged).

As KPTI is based on memory being mapped non-global, let's prevent
it from kicking in if this erratum is detected.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
[will: Update comment]
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>

Signed-off-by: Alex Shi <alex.shi@linaro.org>

Conflicts:
	using old function read_system_reg/cpus_have_cap to replace
	read_sanitised_ftr_reg/cpus_have_const_cap in
	arch/arm64/kernel/cpufeature.c
---
 arch/arm64/kernel/cpufeature.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 0fba610..760c851 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -753,12 +753,23 @@ static int __kpti_forced; /* 0: not forced, >0: forced on, <0: forced off */
 static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
 				int __unused)
 {
+	char const *str = "command line option";
 	u64 pfr0 = read_system_reg(SYS_ID_AA64PFR0_EL1);
 
-	/* Forced on command line? */
+	/*
+	 * For reasons that aren't entirely clear, enabling KPTI on Cavium
+	 * ThunderX leads to apparent I-cache corruption of kernel text, which
+	 * ends as well as you might imagine. Don't even try.
+	 */
+	if (cpus_have_cap(ARM64_WORKAROUND_CAVIUM_27456)) {
+		str = "ARM64_WORKAROUND_CAVIUM_27456";
+		__kpti_forced = -1;
+	}
+
+	/* Forced? */
 	if (__kpti_forced) {
-		pr_info_once("kernel page table isolation forced %s by command line option\n",
-			     __kpti_forced > 0 ? "ON" : "OFF");
+		pr_info_once("kernel page table isolation forced %s by %s\n",
+			     __kpti_forced > 0 ? "ON" : "OFF", str);
 		return __kpti_forced > 0;
 	}
 
-- 
2.7.4
