Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2BD7C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9791F240C7
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:27:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9791F240C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754352AbeGEQ0Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 12:26:24 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:5951 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753988AbeGEQZh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 12:25:37 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 41M39h1Lsrz9ttrG;
        Thu,  5 Jul 2018 18:25:12 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id hgcCayK2QliV; Thu,  5 Jul 2018 18:25:12 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 41M39h0vV9z9ttr5;
        Thu,  5 Jul 2018 18:25:12 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E11F18B8CF;
        Thu,  5 Jul 2018 18:25:13 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id I96DVld2wV5D; Thu,  5 Jul 2018 18:25:13 +0200 (CEST)
Received: from po14934vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.4])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C3FD18B8BC;
        Thu,  5 Jul 2018 18:25:13 +0200 (CEST)
Received: by po14934vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 9C734711E2; Thu,  5 Jul 2018 16:25:13 +0000 (UTC)
Message-Id: <820e0ab274673d336c49ea47273aae18e5723af5.1530807556.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1530807556.git.christophe.leroy@c-s.fr>
References: <cover.1530807556.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 12/16] powerpc/44x: remove page.h from mmu-44x.h
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu,  5 Jul 2018 16:25:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mmu-44x.h doesn't need asm/page.h if PAGE_SHIFT are replaced by CONFIG_PPC_XX_PAGES

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/mmu-44x.h | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu-44x.h b/arch/powerpc/include/asm/mmu-44x.h
index 9bdbe1d1c9b9..295b3dbb2698 100644
--- a/arch/powerpc/include/asm/mmu-44x.h
+++ b/arch/powerpc/include/asm/mmu-44x.h
@@ -5,7 +5,6 @@
  * PPC440 support
  */
 
-#include <asm/page.h>
 #include <asm/asm-const.h>
 
 #define PPC44x_MMUCR_TID	0x000000ff
@@ -125,19 +124,19 @@ typedef struct {
 /* Size of the TLBs used for pinning in lowmem */
 #define PPC_PIN_SIZE	(1 << 28)	/* 256M */
 
-#if (PAGE_SHIFT == 12)
+#if defined(CONFIG_PPC_4K_PAGES)
 #define PPC44x_TLBE_SIZE	PPC44x_TLB_4K
 #define PPC47x_TLBE_SIZE	PPC47x_TLB0_4K
 #define mmu_virtual_psize	MMU_PAGE_4K
-#elif (PAGE_SHIFT == 14)
+#elif defined(CONFIG_PPC_16K_PAGES)
 #define PPC44x_TLBE_SIZE	PPC44x_TLB_16K
 #define PPC47x_TLBE_SIZE	PPC47x_TLB0_16K
 #define mmu_virtual_psize	MMU_PAGE_16K
-#elif (PAGE_SHIFT == 16)
+#elif defined(CONFIG_PPC_64K_PAGES)
 #define PPC44x_TLBE_SIZE	PPC44x_TLB_64K
 #define PPC47x_TLBE_SIZE	PPC47x_TLB0_64K
 #define mmu_virtual_psize	MMU_PAGE_64K
-#elif (PAGE_SHIFT == 18)
+#elif defined(CONFIG_PPC_256K_PAGES)
 #define PPC44x_TLBE_SIZE	PPC44x_TLB_256K
 #define mmu_virtual_psize	MMU_PAGE_256K
 #else
-- 
2.13.3

