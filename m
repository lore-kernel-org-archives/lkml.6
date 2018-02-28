Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3220176-1519790263-2-3460845136270017252
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, UPPERCASE_50_75 0.008, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519790262; b=hUx3GgtrSAP5hlklrbQO8KuKFDAFwRCw5ImZT/DtoI8BLWQ
    neBCyvNgHOsm4BXaWqIKX0rxhJz9Yd5K5OHzRoLEpO96r94NJxu/T49l8E/r/InE
    Hg3x5HJSSsbOWC1FuZnGW0TbC0d+JBO+X3X6WpF7+XycJeR3+9JwWBp8Skvjiaaw
    H85YBJcA64Trrl4Df+UuZw2nlhuYR/muJx7W5V+1BsuDUAHw1VySS205N2qh+I1Q
    81azZVxwUgbJ/BVtFEIWYIr8TZ12FlcZawx0NLv/DeE+2GIOygDY5EEPshdOGOuo
    cva5UkX9DdHaMG3whPajwpJXkwYTAVhebpLzRtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519790262;
    bh=hqY92IyaOn566ESbjSLskW0cc57GoyIQ8cfMxC4afJE=; b=hlZKGktY2sX6
    rvQp4UG8oYivWBDCTUp0pSeo1BuURLJ4Dalht3wEAJMBpRAytW2CewKlFNSFGULC
    cibiIJr8lwXbHzysO/sxwxH39T4ZaP9jcm+2zftHm8k9XUDv1HMSsOmi8d1n0Rnl
    5KuoERhN+UaWVPlkvCWhMqW4JjA+udZlSSvZCVeHu+YCVS2csK0iiqLg5ykNPojL
    OKIqIplBEgoE/IDyAW+XoZhT2GyO7iAYtOXEQsBztrz+QbNg6NCagRzFZDuPKLT2
    zUVwJLtUpUgqqMwUNzEnpjWxRsdNIIyDQVdtpWGVNdtm0gfG22f913zTbj7+aXPX
    Y9fQu7goTA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=UghItTln x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=RQv0iDtb;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=UghItTln x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=RQv0iDtb;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751821AbeB1D5j (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 22:57:39 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34119 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751793AbeB1D5h (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Feb 2018 22:57:37 -0500
X-Google-Smtp-Source: AG47ELtuKbVUJ2GaC+P2JtmWFo/t0U8BTXjbEj033Cw81RZBmYcas0buu1Uso4rbaGqqs/QD+Vyb2w==
From: Alex Shi <alex.shi@linaro.org>
To: Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc: Alex Shi <alex.shi@linaro.org>
Subject: [PATCH 01/29] arm64: mm: Use non-global mappings for kernel space
Date: Wed, 28 Feb 2018 11:56:23 +0800
Message-Id: <1519790211-16582-2-git-send-email-alex.shi@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
References: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Will Deacon <will.deacon@arm.com>

commit e046eb0c9bf2 upstream.

In preparation for unmapping the kernel whilst running in userspace,
make the kernel mappings non-global so we can avoid expensive TLB
invalidation on kernel exit to userspace.

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Laura Abbott <labbott@redhat.com>
Tested-by: Shanker Donthineni <shankerd@codeaurora.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org>

Conflicts:
	skip PTE_RDONLY of PAGE_NONE in arch/arm64/include/asm/pgtable-prot.h
---
 arch/arm64/include/asm/kernel-pgtable.h | 12 ++++++++++--
 arch/arm64/include/asm/pgtable-prot.h   | 21 +++++++++++++++------
 2 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/kernel-pgtable.h b/arch/arm64/include/asm/kernel-pgtable.h
index 7e51d1b..e4ddac9 100644
--- a/arch/arm64/include/asm/kernel-pgtable.h
+++ b/arch/arm64/include/asm/kernel-pgtable.h
@@ -71,8 +71,16 @@
 /*
  * Initial memory map attributes.
  */
-#define SWAPPER_PTE_FLAGS	(PTE_TYPE_PAGE | PTE_AF | PTE_SHARED)
-#define SWAPPER_PMD_FLAGS	(PMD_TYPE_SECT | PMD_SECT_AF | PMD_SECT_S)
+#define _SWAPPER_PTE_FLAGS	(PTE_TYPE_PAGE | PTE_AF | PTE_SHARED)
+#define _SWAPPER_PMD_FLAGS	(PMD_TYPE_SECT | PMD_SECT_AF | PMD_SECT_S)
+
+#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
+#define SWAPPER_PTE_FLAGS	(_SWAPPER_PTE_FLAGS | PTE_NG)
+#define SWAPPER_PMD_FLAGS	(_SWAPPER_PMD_FLAGS | PMD_SECT_NG)
+#else
+#define SWAPPER_PTE_FLAGS	_SWAPPER_PTE_FLAGS
+#define SWAPPER_PMD_FLAGS	_SWAPPER_PMD_FLAGS
+#endif
 
 #if ARM64_SWAPPER_USES_SECTION_MAPS
 #define SWAPPER_MM_MMUFLAGS	(PMD_ATTRINDX(MT_NORMAL) | SWAPPER_PMD_FLAGS)
diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
index 2142c77..84b5283 100644
--- a/arch/arm64/include/asm/pgtable-prot.h
+++ b/arch/arm64/include/asm/pgtable-prot.h
@@ -34,8 +34,16 @@
 
 #include <asm/pgtable-types.h>
 
-#define PROT_DEFAULT		(PTE_TYPE_PAGE | PTE_AF | PTE_SHARED)
-#define PROT_SECT_DEFAULT	(PMD_TYPE_SECT | PMD_SECT_AF | PMD_SECT_S)
+#define _PROT_DEFAULT		(PTE_TYPE_PAGE | PTE_AF | PTE_SHARED)
+#define _PROT_SECT_DEFAULT	(PMD_TYPE_SECT | PMD_SECT_AF | PMD_SECT_S)
+
+#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
+#define PROT_DEFAULT		(_PROT_DEFAULT | PTE_NG)
+#define PROT_SECT_DEFAULT	(_PROT_SECT_DEFAULT | PMD_SECT_NG)
+#else
+#define PROT_DEFAULT		_PROT_DEFAULT
+#define PROT_SECT_DEFAULT	_PROT_SECT_DEFAULT
+#endif /* CONFIG_UNMAP_KERNEL_AT_EL0 */
 
 #define PROT_DEVICE_nGnRnE	(PROT_DEFAULT | PTE_PXN | PTE_UXN | PTE_DIRTY | PTE_WRITE | PTE_ATTRINDX(MT_DEVICE_nGnRnE))
 #define PROT_DEVICE_nGnRE	(PROT_DEFAULT | PTE_PXN | PTE_UXN | PTE_DIRTY | PTE_WRITE | PTE_ATTRINDX(MT_DEVICE_nGnRE))
@@ -48,6 +56,7 @@
 #define PROT_SECT_NORMAL_EXEC	(PROT_SECT_DEFAULT | PMD_SECT_UXN | PMD_ATTRINDX(MT_NORMAL))
 
 #define _PAGE_DEFAULT		(PROT_DEFAULT | PTE_ATTRINDX(MT_NORMAL))
+#define _HYP_PAGE_DEFAULT	(_PAGE_DEFAULT & ~PTE_NG)
 
 #define PAGE_KERNEL		__pgprot(_PAGE_DEFAULT | PTE_PXN | PTE_UXN | PTE_DIRTY | PTE_WRITE)
 #define PAGE_KERNEL_RO		__pgprot(_PAGE_DEFAULT | PTE_PXN | PTE_UXN | PTE_DIRTY | PTE_RDONLY)
@@ -55,15 +64,15 @@
 #define PAGE_KERNEL_EXEC	__pgprot(_PAGE_DEFAULT | PTE_UXN | PTE_DIRTY | PTE_WRITE)
 #define PAGE_KERNEL_EXEC_CONT	__pgprot(_PAGE_DEFAULT | PTE_UXN | PTE_DIRTY | PTE_WRITE | PTE_CONT)
 
-#define PAGE_HYP		__pgprot(_PAGE_DEFAULT | PTE_HYP | PTE_HYP_XN)
-#define PAGE_HYP_EXEC		__pgprot(_PAGE_DEFAULT | PTE_HYP | PTE_RDONLY)
-#define PAGE_HYP_RO		__pgprot(_PAGE_DEFAULT | PTE_HYP | PTE_RDONLY | PTE_HYP_XN)
+#define PAGE_HYP		__pgprot(_HYP_PAGE_DEFAULT | PTE_HYP | PTE_HYP_XN)
+#define PAGE_HYP_EXEC		__pgprot(_HYP_PAGE_DEFAULT | PTE_HYP | PTE_RDONLY)
+#define PAGE_HYP_RO		__pgprot(_HYP_PAGE_DEFAULT | PTE_HYP | PTE_RDONLY | PTE_HYP_XN)
 #define PAGE_HYP_DEVICE		__pgprot(PROT_DEVICE_nGnRE | PTE_HYP)
 
 #define PAGE_S2			__pgprot(PROT_DEFAULT | PTE_S2_MEMATTR(MT_S2_NORMAL) | PTE_S2_RDONLY)
 #define PAGE_S2_DEVICE		__pgprot(PROT_DEFAULT | PTE_S2_MEMATTR(MT_S2_DEVICE_nGnRE) | PTE_S2_RDONLY | PTE_UXN)
 
-#define PAGE_NONE		__pgprot(((_PAGE_DEFAULT) & ~PTE_VALID) | PTE_PROT_NONE | PTE_PXN | PTE_UXN)
+#define PAGE_NONE		__pgprot(((_PAGE_DEFAULT) & ~PTE_VALID) | PTE_PROT_NONE | PTE_NG | PTE_PXN | PTE_UXN)
 #define PAGE_SHARED		__pgprot(_PAGE_DEFAULT | PTE_USER | PTE_NG | PTE_PXN | PTE_UXN | PTE_WRITE)
 #define PAGE_SHARED_EXEC	__pgprot(_PAGE_DEFAULT | PTE_USER | PTE_NG | PTE_PXN | PTE_WRITE)
 #define PAGE_COPY		__pgprot(_PAGE_DEFAULT | PTE_USER | PTE_NG | PTE_PXN | PTE_UXN)
-- 
2.7.4
