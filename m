Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 742B4C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 13:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42A832086D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 13:52:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42A832086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbeJIVJV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 17:09:21 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:4827 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727215AbeJIVJU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 17:09:20 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 42TzDX4xCdz9ttgG;
        Tue,  9 Oct 2018 15:51:56 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id QRQW5HDR3oRx; Tue,  9 Oct 2018 15:51:56 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 42TzDX4NLdz9ttfw;
        Tue,  9 Oct 2018 15:51:56 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 171478B80D;
        Tue,  9 Oct 2018 15:52:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id iBvCyLoNiyQl; Tue,  9 Oct 2018 15:52:08 +0200 (CEST)
Received: from pc13168vm.idsi0.si.c-s.fr (unknown [192.168.232.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1E2158B80B;
        Tue,  9 Oct 2018 15:52:07 +0200 (CEST)
Received: by pc13168vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 3EA9C6F444; Tue,  9 Oct 2018 13:52:06 +0000 (UTC)
Message-Id: <8549b86165e90d6f3a2b0423fc731048358e1aa1.1539092112.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1539092111.git.christophe.leroy@c-s.fr>
References: <cover.1539092111.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 17/24] powerpc/mm: Move pte_user() into nohash/pgtable.h
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Geoff Levand <geoff@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Kumar Gala <galak@kernel.crashing.org>,
        Li Yang <leoyang.li@nxp.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        Scott Wood <oss@buserror.net>, aneesh.kumar@linux.vnet.ibm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, dri-devel@lists.freedesktop.org
Date:   Tue,  9 Oct 2018 13:52:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now the pte-common.h is only for nohash platforms, lets
move pte_user() helper out of pte-common.h to put it
together with other helpers.

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/nohash/pgtable.h | 10 ++++++++++
 arch/powerpc/include/asm/pte-common.h     | 13 -------------
 2 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/include/asm/nohash/pgtable.h b/arch/powerpc/include/asm/nohash/pgtable.h
index 062d96233673..8de3b7eb88b0 100644
--- a/arch/powerpc/include/asm/nohash/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/pgtable.h
@@ -52,6 +52,16 @@ static inline bool pte_hw_valid(pte_t pte)
 }
 
 /*
+ * Don't just check for any non zero bits in __PAGE_USER, since for book3e
+ * and PTE_64BIT, PAGE_KERNEL_X contains _PAGE_BAP_SR which is also in
+ * _PAGE_USER.  Need to explicitly match _PAGE_BAP_UR bit in that case too.
+ */
+static inline bool pte_user(pte_t pte)
+{
+	return (pte_val(pte) & (_PAGE_USER | _PAGE_PRIVILEGED)) == _PAGE_USER;
+}
+
+/*
  * We only find page table entry in the last level
  * Hence no need for other accessors
  */
diff --git a/arch/powerpc/include/asm/pte-common.h b/arch/powerpc/include/asm/pte-common.h
index 3a8ec18ffd22..556a914ff845 100644
--- a/arch/powerpc/include/asm/pte-common.h
+++ b/arch/powerpc/include/asm/pte-common.h
@@ -66,19 +66,6 @@
 #define _PTE_NONE_MASK	0
 #endif
 
-#ifndef __ASSEMBLY__
-
-/*
- * Don't just check for any non zero bits in __PAGE_USER, since for book3e
- * and PTE_64BIT, PAGE_KERNEL_X contains _PAGE_BAP_SR which is also in
- * _PAGE_USER.  Need to explicitly match _PAGE_BAP_UR bit in that case too.
- */
-static inline bool pte_user(pte_t pte)
-{
-	return (pte_val(pte) & (_PAGE_USER | _PAGE_PRIVILEGED)) == _PAGE_USER;
-}
-#endif /* __ASSEMBLY__ */
-
 /* Location of the PFN in the PTE. Most 32-bit platforms use the same
  * as _PAGE_SHIFT here (ie, naturally aligned).
  * Platform who don't just pre-define the value so we don't override it here
-- 
2.13.3

