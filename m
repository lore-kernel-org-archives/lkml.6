Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3220176-1519790440-2-13538739220473636054
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
    t=1519790439; b=CMA9kcIt/h5uk1lDVpEqNj7rJHe5RW5XV0PprDWpNiP8q13
    5CvQB3HL6oLZm8mdG+tpO+hNUJvujNKXeAkRqDAL9ut3FYMcxrRTF8FrTQIkXRZV
    1vi3oEVSENFZYEy4jUyseAaGtKG4c+zbxj3zb0UUjME0Uh+BTkyRxvQRkFctB/1C
    XMLjsRtqFhFs9YclaNuvO9bEtoy6vYGYa5mLEOo92eKCNAwNArIXlOoRnekgHFmy
    HlFf/Wan0pKOcgCOuGLvbRve/0Z81Hg7iTCW4uZbFtb4OtdEclvhvw9LlZ0VB0Ar
    ke0kYssWX7vgOcqMGHZzaDB0AT1I1SqAw+A14aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519790439;
    bh=mYI9hVlX+A1UhBZZtOVFtY/jGzDIohyGCUWHl33Z7RM=; b=QDSnBiMZ94tY
    D6lTqxOCsh7v3ezVtE3HCV76uWvuFmkCn3f5mAd6GrOJI4xF/AZm4dVRzH4dNCFl
    2QadvNoN0OI7WkGGWcrlVK4md8CGMKYuTBZO5aIoylSLiDpRRgYuoQ4On8N6+bqB
    FgXfuyPX6eTSX07oxGWS5wuM9/iTFWwER4+mLby7rE4+DvWROBT9tAvQUzOphmhn
    uU2ZyEEnbqYE7RWqv09Z2bPe/nt5xAcDwLGkhWqU9Vupk7RsOS5CfaYutFSFlUNV
    1D7szfTZtMFbeDEt+gbnJWEpsdZKFNSbd9CXBLW3Fo8yadCjrL2vC24Nxo5v92/b
    qOshJ2mLOA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=A6UnT8xk x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=BnPEUhqx;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=A6UnT8xk x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=BnPEUhqx;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752368AbeB1EAf (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 23:00:35 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:35208 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752339AbeB1EAc (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Feb 2018 23:00:32 -0500
X-Google-Smtp-Source: AH8x226ZXYy/kLxkwLt5j3UCyUEuOVY6A5TpDqEti4HgohfGpfbpElaTt97EePqksgv+e1WO4U/MyQ==
From: Alex Shi <alex.shi@linaro.org>
To: Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc: Alex Shi <alex.shi@linaro.org>
Subject: [PATCH 25/29] arm64: kpti: Make use of nG dependent on arm64_kernel_unmapped_at_el0()
Date: Wed, 28 Feb 2018 11:56:47 +0800
Message-Id: <1519790211-16582-26-git-send-email-alex.shi@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
References: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Will Deacon <will.deacon@arm.com>

commit 41acec624087 upstream.

To allow systems which do not require kpti to continue running with
global kernel mappings (which appears to be a requirement for Cavium
ThunderX due to a CPU erratum), make the use of nG in the kernel page
tables dependent on arm64_kernel_unmapped_at_el0(), which is resolved
at runtime.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org>
---
 arch/arm64/include/asm/kernel-pgtable.h | 12 ++----------
 arch/arm64/include/asm/pgtable-prot.h   | 30 ++++++++++++++----------------
 2 files changed, 16 insertions(+), 26 deletions(-)

diff --git a/arch/arm64/include/asm/kernel-pgtable.h b/arch/arm64/include/asm/kernel-pgtable.h
index 135e829..be151cc 100644
--- a/arch/arm64/include/asm/kernel-pgtable.h
+++ b/arch/arm64/include/asm/kernel-pgtable.h
@@ -73,16 +73,8 @@
 /*
  * Initial memory map attributes.
  */
-#define _SWAPPER_PTE_FLAGS	(PTE_TYPE_PAGE | PTE_AF | PTE_SHARED)
-#define _SWAPPER_PMD_FLAGS	(PMD_TYPE_SECT | PMD_SECT_AF | PMD_SECT_S)
-
-#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
-#define SWAPPER_PTE_FLAGS	(_SWAPPER_PTE_FLAGS | PTE_NG)
-#define SWAPPER_PMD_FLAGS	(_SWAPPER_PMD_FLAGS | PMD_SECT_NG)
-#else
-#define SWAPPER_PTE_FLAGS	_SWAPPER_PTE_FLAGS
-#define SWAPPER_PMD_FLAGS	_SWAPPER_PMD_FLAGS
-#endif
+#define SWAPPER_PTE_FLAGS	(PTE_TYPE_PAGE | PTE_AF | PTE_SHARED)
+#define SWAPPER_PMD_FLAGS	(PMD_TYPE_SECT | PMD_SECT_AF | PMD_SECT_S)
 
 #if ARM64_SWAPPER_USES_SECTION_MAPS
 #define SWAPPER_MM_MMUFLAGS	(PMD_ATTRINDX(MT_NORMAL) | SWAPPER_PMD_FLAGS)
diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
index 84b5283..f705d96 100644
--- a/arch/arm64/include/asm/pgtable-prot.h
+++ b/arch/arm64/include/asm/pgtable-prot.h
@@ -37,13 +37,11 @@
 #define _PROT_DEFAULT		(PTE_TYPE_PAGE | PTE_AF | PTE_SHARED)
 #define _PROT_SECT_DEFAULT	(PMD_TYPE_SECT | PMD_SECT_AF | PMD_SECT_S)
 
-#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
-#define PROT_DEFAULT		(_PROT_DEFAULT | PTE_NG)
-#define PROT_SECT_DEFAULT	(_PROT_SECT_DEFAULT | PMD_SECT_NG)
-#else
-#define PROT_DEFAULT		_PROT_DEFAULT
-#define PROT_SECT_DEFAULT	_PROT_SECT_DEFAULT
-#endif /* CONFIG_UNMAP_KERNEL_AT_EL0 */
+#define PTE_MAYBE_NG		(arm64_kernel_unmapped_at_el0() ? PTE_NG : 0)
+#define PMD_MAYBE_NG		(arm64_kernel_unmapped_at_el0() ? PMD_SECT_NG : 0)
+
+#define PROT_DEFAULT		(_PROT_DEFAULT | PTE_MAYBE_NG)
+#define PROT_SECT_DEFAULT	(_PROT_SECT_DEFAULT | PMD_MAYBE_NG)
 
 #define PROT_DEVICE_nGnRnE	(PROT_DEFAULT | PTE_PXN | PTE_UXN | PTE_DIRTY | PTE_WRITE | PTE_ATTRINDX(MT_DEVICE_nGnRnE))
 #define PROT_DEVICE_nGnRE	(PROT_DEFAULT | PTE_PXN | PTE_UXN | PTE_DIRTY | PTE_WRITE | PTE_ATTRINDX(MT_DEVICE_nGnRE))
@@ -55,22 +53,22 @@
 #define PROT_SECT_NORMAL	(PROT_SECT_DEFAULT | PMD_SECT_PXN | PMD_SECT_UXN | PMD_ATTRINDX(MT_NORMAL))
 #define PROT_SECT_NORMAL_EXEC	(PROT_SECT_DEFAULT | PMD_SECT_UXN | PMD_ATTRINDX(MT_NORMAL))
 
-#define _PAGE_DEFAULT		(PROT_DEFAULT | PTE_ATTRINDX(MT_NORMAL))
-#define _HYP_PAGE_DEFAULT	(_PAGE_DEFAULT & ~PTE_NG)
+#define _PAGE_DEFAULT		(_PROT_DEFAULT | PTE_ATTRINDX(MT_NORMAL))
+#define _HYP_PAGE_DEFAULT	_PAGE_DEFAULT
 
-#define PAGE_KERNEL		__pgprot(_PAGE_DEFAULT | PTE_PXN | PTE_UXN | PTE_DIRTY | PTE_WRITE)
-#define PAGE_KERNEL_RO		__pgprot(_PAGE_DEFAULT | PTE_PXN | PTE_UXN | PTE_DIRTY | PTE_RDONLY)
-#define PAGE_KERNEL_ROX		__pgprot(_PAGE_DEFAULT | PTE_UXN | PTE_DIRTY | PTE_RDONLY)
-#define PAGE_KERNEL_EXEC	__pgprot(_PAGE_DEFAULT | PTE_UXN | PTE_DIRTY | PTE_WRITE)
-#define PAGE_KERNEL_EXEC_CONT	__pgprot(_PAGE_DEFAULT | PTE_UXN | PTE_DIRTY | PTE_WRITE | PTE_CONT)
+#define PAGE_KERNEL		__pgprot(PROT_NORMAL)
+#define PAGE_KERNEL_RO		__pgprot((PROT_NORMAL & ~PTE_WRITE) | PTE_RDONLY)
+#define PAGE_KERNEL_ROX		__pgprot((PROT_NORMAL & ~(PTE_WRITE | PTE_PXN)) | PTE_RDONLY)
+#define PAGE_KERNEL_EXEC	__pgprot(PROT_NORMAL & ~PTE_PXN)
+#define PAGE_KERNEL_EXEC_CONT	__pgprot((PROT_NORMAL & ~PTE_PXN) | PTE_CONT)
 
 #define PAGE_HYP		__pgprot(_HYP_PAGE_DEFAULT | PTE_HYP | PTE_HYP_XN)
 #define PAGE_HYP_EXEC		__pgprot(_HYP_PAGE_DEFAULT | PTE_HYP | PTE_RDONLY)
 #define PAGE_HYP_RO		__pgprot(_HYP_PAGE_DEFAULT | PTE_HYP | PTE_RDONLY | PTE_HYP_XN)
 #define PAGE_HYP_DEVICE		__pgprot(PROT_DEVICE_nGnRE | PTE_HYP)
 
-#define PAGE_S2			__pgprot(PROT_DEFAULT | PTE_S2_MEMATTR(MT_S2_NORMAL) | PTE_S2_RDONLY)
-#define PAGE_S2_DEVICE		__pgprot(PROT_DEFAULT | PTE_S2_MEMATTR(MT_S2_DEVICE_nGnRE) | PTE_S2_RDONLY | PTE_UXN)
+#define PAGE_S2			__pgprot(_PROT_DEFAULT | PTE_S2_MEMATTR(MT_S2_NORMAL) | PTE_S2_RDONLY)
+#define PAGE_S2_DEVICE		__pgprot(_PROT_DEFAULT | PTE_S2_MEMATTR(MT_S2_DEVICE_nGnRE) | PTE_S2_RDONLY | PTE_UXN)
 
 #define PAGE_NONE		__pgprot(((_PAGE_DEFAULT) & ~PTE_VALID) | PTE_PROT_NONE | PTE_NG | PTE_PXN | PTE_UXN)
 #define PAGE_SHARED		__pgprot(_PAGE_DEFAULT | PTE_USER | PTE_NG | PTE_PXN | PTE_UXN | PTE_WRITE)
-- 
2.7.4
