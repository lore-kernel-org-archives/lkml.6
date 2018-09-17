Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_DKIM_INVALID,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93050ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 00:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46BBC2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 00:47:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jtAiITlY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46BBC2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbeIQGMG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 02:12:06 -0400
Received: from mail-pf1-f178.google.com ([209.85.210.178]:44438 "EHLO
        mail-pf1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbeIQGMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 02:12:05 -0400
Received: by mail-pf1-f178.google.com with SMTP id k21-v6so6712815pff.11
        for <linux-kernel@vger.kernel.org>; Sun, 16 Sep 2018 17:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PGS6nKqUJ9lJAuL339gEx3gSAHIukbdG4jY5J92aO50=;
        b=jtAiITlY827cbDYM7291xDxLTQZOB1khzhBFf1EGHfUHeBm7gWxLnWtGScLxNL1Mdu
         2GW8ugp4q28BB5Ml/mJeLUl2+vloD1QGUj0NRiqzD2EHlbqj3r7Vq43jmuu3dJR42W/u
         LiWZ3Qp0LGF7aD0obd/vuavOK39DD2lc4h4BwTuvUUxGQeUlWe1PhXJgfMD6PUFLEDwi
         lPmsxR0meY1w9S6V7wrUb+muczrKixOE+zALN2odcf0CmnfMkNQeBXLfiuR/ysb1jLLU
         YKZDsb3Yw9sV7Zkg0y830fJW4VRgxQ4RF0rSNVFoeODwQ2IHZeUv+xbmvwydMp/B3qZN
         dt5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=PGS6nKqUJ9lJAuL339gEx3gSAHIukbdG4jY5J92aO50=;
        b=Rr5HnHc4XhqPjlqXD9X6dNkpt8ti7cbWsPGugrln3BkQI0tNLXIeJi6TSeJ9VQjdNc
         taNTD09K0kSxu6JBeH4LFZfS3uLuPnYE+mVO6ynVm1YmvNL2GCuiKNwtfG/E9d83lE0N
         Cqv+FbNNqEBzf5WQgoXIw9U9CiA6OlyPhNNIf3Cn6ouUXxGLzJXoc7TsOQDRsnLxmyF9
         aCQP6Zd9Zr/lFjxoULLN4+fwvnzalx+lZqwq+UYU8O6IT5N/DLUX5ew5PW7yuq4a9Oh2
         fqxZtLFFbgxHz8xEgOxHlKta+yoK+ewPcfLtAwfI5zrDOE+KfoZ9z1AfXMD2vTACc0Bc
         va5g==
X-Gm-Message-State: APzg51AKaIaxwOZSZm7DfcTEk2pOXcqLTn4r0ZbslEsvTuelJpxZrH/N
        6sUSGTMDBgzXYqofS5wkG6E=
X-Google-Smtp-Source: ANB0VdYoyr8MklBn37knXbkcs5GOv/llBrfyTql3oqYOR0rlw0UQRtTCpzxpw6mJTM1ZtjIAQU4UqA==
X-Received: by 2002:a62:1157:: with SMTP id z84-v6mr23541419pfi.66.1537145233644;
        Sun, 16 Sep 2018 17:47:13 -0700 (PDT)
Received: from bbox-2.seo.corp.google.com ([2401:fa00:d:10:affa:813f:5380:6613])
        by smtp.gmail.com with ESMTPSA id w16-v6sm29311503pfi.101.2018.09.16.17.47.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Sep 2018 17:47:12 -0700 (PDT)
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>, linux@armlinux.org.uk
Cc:     steve.capper@linaro.org, will.deacon@arm.com,
        catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel-team@android.com,
        miles.chen@mediatek.com, jian-min.lui@mediatek.com,
        juju.sung@mediatek.com, Minchan Kim <minchan@kernel.org>
Subject: [PATCH v1 2/3] arm: mm: introduce L_PTE_SPECIAL
Date:   Mon, 17 Sep 2018 09:44:50 +0900
Message-Id: <20180917004451.174527-3-minchan@kernel.org>
X-Mailer: git-send-email 2.19.0.397.gdd90340f6a-goog
In-Reply-To: <20180917004451.174527-1-minchan@kernel.org>
References: <20180917004451.174527-1-minchan@kernel.org>
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
index e8cd55a5b04c..278cf22b5aa1 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -10,7 +10,7 @@ config ARM
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_KCOV
 	select ARCH_HAS_MEMBARRIER_SYNC_CORE
-	select ARCH_HAS_PTE_SPECIAL if ARM_LPAE
+	select ARCH_HAS_PTE_SPECIAL if (ARM_LPAE || CPU_V7 || CPU_V6 || CPUV6K)
 	select ARCH_HAS_PHYS_TO_DMA
 	select ARCH_HAS_SET_MEMORY
 	select ARCH_HAS_STRICT_KERNEL_RWX if MMU && !XIP_KERNEL
diff --git a/arch/arm/include/asm/pgtable-2level.h b/arch/arm/include/asm/pgtable-2level.h
index 514b13c27b43..378668420642 100644
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
@@ -224,8 +225,6 @@ static inline pmd_t *pmd_offset(pud_t *pud, unsigned long addr)
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
2.19.0.397.gdd90340f6a-goog

