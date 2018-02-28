Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3220176-1519790563-2-9776683323285161012
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
    t=1519790562; b=hcgRN7cHlxIw6/9iG5h7LOdqesUiPKLFswQG/Bd/gHfnq1j
    z+VqXdlUiEvBUJF8DvUG+grOtENs5NOuvyx3Ek8v44Lmd55jt+6ZO2x9Em8Jw7mM
    uM0jmF3FeolX9d7JKy6xykmLLNjrMvQoGdc7eSqroS/qwBjD4/JX4YOduU80II4k
    Ug7EthhdoNXMEDxn/NJZy2/sA0jZ9DWtnUkg1uLTpbRPSjJDi0hySbTG/TF8goN9
    DDJgp5/A5lNVmPpDcch4ptSkcenSHeO7IBdxUhixvQ93k0+LFZiDMWxlqtYzjzOL
    nMuItoVkdsBxdnBkWKvHx1voBT6ubOOUoF2l1qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519790562;
    bh=95Iv0nJp083o8oUFCW7XEWIw7Oc3xuvo6wFQkXWVNj4=; b=fdxMB9DHik6U
    6KEpyB4bJNThXNp3xVIGiC0XmRpriASF1yuFo+tdepvd7JfUylxbJdOrJKL8L9ae
    ZdwN7skQbhF3HxxF7jhCDhEhpwr6zc4UXjZdIsY5jC83OIKMUA0P/c87i8eePrRF
    0gWbZOa/Gb9gFM+XRArUfQBqYfKUPXtkHLh3JwZQRHSmxDPD9OmHBsQPSdSZA/tQ
    e11Bd7HCegHO/owPhUD7MyokxNyCGVQOHdzb0IFG9j/GzdXdol2Ot2F4N4Cc6nze
    M1yg5gCYBMeDdCUjEBAHidJtuBWNWcR6IWGOmjQFVqo1KuMWKTt5T5+ZdeJb1fAC
    NUbRRgenaA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=dnHsb0lk x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=PnRZvjve;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=dnHsb0lk x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=PnRZvjve;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932171AbeB1D7n (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 22:59:43 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:32998 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932150AbeB1D7h (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Feb 2018 22:59:37 -0500
X-Google-Smtp-Source: AH8x227t8jgmj3CkRh0ZdkIGQrrcoAjiVJiWQUfXR51URc5Q4FrDgRMeJCiQ8odK8SaJ9tskj9nqLQ==
From: Alex Shi <alex.shi@linaro.org>
To: Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc: Alex Shi <alex.shi@linaro.org>
Subject: [PATCH 17/29] arm64: Kconfig: Add CONFIG_UNMAP_KERNEL_AT_EL0
Date: Wed, 28 Feb 2018 11:56:39 +0800
Message-Id: <1519790211-16582-18-git-send-email-alex.shi@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
References: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Will Deacon <will.deacon@arm.com>

commit 084eb77cd3a8 upstream.

Add a Kconfig entry to control use of the entry trampoline, which allows
us to unmap the kernel whilst running in userspace and improve the
robustness of KASLR.

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Laura Abbott <labbott@redhat.com>
Tested-by: Shanker Donthineni <shankerd@codeaurora.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org>
---
 arch/arm64/Kconfig | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 7769c2e..6b6e9f8 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -733,6 +733,19 @@ config FORCE_MAX_ZONEORDER
 	  However for 4K, we choose a higher default value, 11 as opposed to 10, giving us
 	  4M allocations matching the default size used by generic code.
 
+config UNMAP_KERNEL_AT_EL0
+	bool "Unmap kernel when running in userspace (aka \"KAISER\")"
+	default y
+	help
+	  Some attacks against KASLR make use of the timing difference between
+	  a permission fault which could arise from a page table entry that is
+	  present in the TLB, and a translation fault which always requires a
+	  page table walk. This option defends against these attacks by unmapping
+	  the kernel whilst running in userspace, therefore forcing translation
+	  faults for all of kernel space.
+
+	  If unsure, say Y.
+
 menuconfig ARMV8_DEPRECATED
 	bool "Emulate deprecated/obsolete ARMv8 instructions"
 	depends on COMPAT
-- 
2.7.4
