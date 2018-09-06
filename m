Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DE8DC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 10:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0590520857
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 10:22:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NBcQdLcQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0590520857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728707AbeIFO5X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 10:57:23 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45244 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbeIFO5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 10:57:23 -0400
Received: by mail-pg1-f196.google.com with SMTP id x26-v6so4982627pge.12
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 03:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=03bIWVCZcpSISui3/Ik6Fa/F3kqV26SZAxPeXglLQxw=;
        b=NBcQdLcQbCwTjKKcDm4+2ANdOnkvxrj/B55QkCps1JMGAWFtbwKnC9Mn0PwKBI1uT1
         +lS5EaejJvxLJz642JYK4CObkRmb6SF6lIyy+CTcwKjasQFVa2Xzg7xT2Ymt+TcpAydN
         PEipe99YTRKgBlJk0bbv+SAf2b7RsiNEC+ZscCFIQdcJNkL+5x2L15qyDLiHHDFamJo/
         NxGMlY+vFwlSPKocOLqM4HgJA1S3Nh51epauyPxAA6HFa92CEKOrvKtzxqx2Ft0nn092
         Kabt4Ggf/BEU/2n8iJb92Ho9WZH5/U1JCv2wNTxD+5pMi7+hGWc9J8+ARCvivLQRneCx
         zCJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=03bIWVCZcpSISui3/Ik6Fa/F3kqV26SZAxPeXglLQxw=;
        b=JI+QzpZU6VgjBfi4rtrNMMlZySIf6+i7gtCHKwNyPvc0C9ZRIO/kgtCOm4ZViYFArd
         j6GgkQYQQcRsVxQZb6gEpfgNNwYzMRMo9hExUAbeK75oad3aLteLIDbTqb6X4fZL2sin
         56OnxqfE6u45bBW1DIsKTGgz8iC/OHSo5Rp+6x7JbJTDABeIW+NRb8Vt0wmHPhPsgMce
         c2vx7+dmoHJxr7/AnJXYoZF2sH9I3jS/Rbdp4W4+zsv3kwl7C7wThMj2302RsmSWNiQ3
         fnKfFcq/QJMG7tb7gVMzedWxRM09nrj+M3PefikvvNFDl4VzRvhL0fFatVHwAgBeqz+p
         2WDg==
X-Gm-Message-State: APzg51Dt6Q85IEDXhgy8/1lm8EAc00h133LeiNFj1Y+h5iTnMq9tMQso
        XhG02QrrXwSTiRCh/vA7CwvONs3L
X-Google-Smtp-Source: ANB0Vda6zKJ0Ab0QpfofnQ53HKeh/Ng6YwnIDsM0nEbgCyhMULUtAydQ8B1URWQPjF3h6GHswl7BSw==
X-Received: by 2002:a63:e54b:: with SMTP id z11-v6mr1973207pgj.328.1536229356519;
        Thu, 06 Sep 2018 03:22:36 -0700 (PDT)
Received: from bbox-2.seo.corp.google.com ([2401:fa00:d:10:affa:813f:5380:6613])
        by smtp.gmail.com with ESMTPSA id h82-v6sm7909555pfa.173.2018.09.06.03.22.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Sep 2018 03:22:35 -0700 (PDT)
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>, linux@armlinux.org.uk
Cc:     steve.capper@linaro.org, will.deacon@arm.com,
        catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel-team@android.com,
        android-treble-mediatek-ext@partner.android.com,
        Minchan Kim <minchan@kernel.org>
Subject: [RFC 2/3] arm: mm: introduce L_PTE_SPECIAL
Date:   Thu,  6 Sep 2018 19:22:11 +0900
Message-Id: <20180906102212.218294-3-minchan@kernel.org>
X-Mailer: git-send-email 2.19.0.rc1.350.ge57e33dbd1-goog
In-Reply-To: <20180906102212.218294-1-minchan@kernel.org>
References: <20180906102212.218294-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces L_PTE_SPECIAL and pte functions for supporting
get_user_pages_fast.

Cc: Russell King <linux@armlinux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Steve Capper <steve.capper@linaro.org>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 arch/arm/Kconfig                      |  2 +-
 arch/arm/include/asm/pgtable-2level.h |  3 +--
 arch/arm/include/asm/pgtable-3level.h |  6 ------
 arch/arm/include/asm/pgtable.h        | 13 +++++++++++++
 4 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index e8cd55a5b04c..5d4489a019c4 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -10,7 +10,7 @@ config ARM
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_KCOV
 	select ARCH_HAS_MEMBARRIER_SYNC_CORE
-	select ARCH_HAS_PTE_SPECIAL if ARM_LPAE
+	select ARCH_HAS_PTE_SPECIAL if (ARM_LPAE || CPU_V7 || CPU_V7M || CPU_V6 || CPUV6K)
 	select ARCH_HAS_PHYS_TO_DMA
 	select ARCH_HAS_SET_MEMORY
 	select ARCH_HAS_STRICT_KERNEL_RWX if MMU && !XIP_KERNEL
diff --git a/arch/arm/include/asm/pgtable-2level.h b/arch/arm/include/asm/pgtable-2level.h
index 91b99fadcba1..82386a2b84e7 100644
--- a/arch/arm/include/asm/pgtable-2level.h
+++ b/arch/arm/include/asm/pgtable-2level.h
@@ -120,6 +120,7 @@
 #define L_PTE_VALID		(_AT(pteval_t, 1) << 0)		/* Valid */
 #define L_PTE_PRESENT		(_AT(pteval_t, 1) << 0)
 #define L_PTE_YOUNG		(_AT(pteval_t, 1) << 1)
+#define L_PTE_SPECIAL		(_AT(pteval_t, 1) << 5)
 #define L_PTE_DIRTY		(_AT(pteval_t, 1) << 6)
 #define L_PTE_RDONLY		(_AT(pteval_t, 1) << 7)
 #define L_PTE_USER		(_AT(pteval_t, 1) << 8)
@@ -222,8 +223,6 @@ static inline pmd_t *pmd_offset(pud_t *pud, unsigned long addr)
 #define pmd_addr_end(addr,end) (end)
 
 #define set_pte_ext(ptep,pte,ext) cpu_set_pte_ext(ptep,pte,ext)
-#define pte_special(pte)	(0)
-static inline pte_t pte_mkspecial(pte_t pte) { return pte; }
 
 /*
  * We don't have huge page support for short descriptors, for the moment
diff --git a/arch/arm/include/asm/pgtable-3level.h b/arch/arm/include/asm/pgtable-3level.h
index 6d50a11d7793..b6f52e16b478 100644
--- a/arch/arm/include/asm/pgtable-3level.h
+++ b/arch/arm/include/asm/pgtable-3level.h
@@ -213,12 +213,6 @@ static inline pmd_t *pmd_offset(pud_t *pud, unsigned long addr)
 
 #define pmd_present(pmd)	(pmd_isset((pmd), L_PMD_SECT_VALID))
 #define pmd_young(pmd)		(pmd_isset((pmd), PMD_SECT_AF))
-#define pte_special(pte)	(pte_isset((pte), L_PTE_SPECIAL))
-static inline pte_t pte_mkspecial(pte_t pte)
-{
-	pte_val(pte) |= L_PTE_SPECIAL;
-	return pte;
-}
 
 #define pmd_write(pmd)		(pmd_isclear((pmd), L_PMD_SECT_RDONLY))
 #define pmd_dirty(pmd)		(pmd_isset((pmd), L_PMD_SECT_DIRTY))
diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index a757401129f9..6cc7ce0e423e 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -228,6 +228,11 @@ static inline pte_t *pmd_page_vaddr(pmd_t pmd)
 #define pte_dirty(pte)		(pte_isset((pte), L_PTE_DIRTY))
 #define pte_young(pte)		(pte_isset((pte), L_PTE_YOUNG))
 #define pte_exec(pte)		(pte_isclear((pte), L_PTE_XN))
+#ifdef CONFIG_ARCH_HAS_PTE_SPECIAL
+#define pte_special(pte)	(pte_isset((pte), L_PTE_SPECIAL))
+#else
+#define pte_special(pte)	(0)
+#endif
 
 #define pte_valid_user(pte)	\
 	(pte_valid(pte) && pte_isset((pte), L_PTE_USER) && pte_young(pte))
@@ -318,6 +323,14 @@ static inline pte_t pte_mknexec(pte_t pte)
 	return set_pte_bit(pte, __pgprot(L_PTE_XN));
 }
 
+#ifdef CONFIG_ARCH_HAS_PTE_SPECIAL
+static inline pte_t pte_mkspecial(pte_t pte)
+{
+	return set_pte_bit(pte, __pgprot(L_PTE_SPECIAL));
+}
+#else
+static inline pte_t pte_mkspecial(pte_t pte) { return pte; }
+#endif
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
 	const pteval_t mask = L_PTE_XN | L_PTE_RDONLY | L_PTE_USER |
-- 
2.19.0.rc1.350.ge57e33dbd1-goog

