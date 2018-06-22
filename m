Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7853C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 13:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98D8724301
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 13:49:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98D8724301
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753131AbeFVNtw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 09:49:52 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:45242 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751370AbeFVNtu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 09:49:50 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 41C0LL2cH5z9ttw5;
        Fri, 22 Jun 2018 15:49:46 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id zKM9-b6FfJme; Fri, 22 Jun 2018 15:49:46 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 41C0LL28nWz9ttqy;
        Fri, 22 Jun 2018 15:49:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 631E18B967;
        Fri, 22 Jun 2018 15:49:48 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id lkd_M-B44vBV; Fri, 22 Jun 2018 15:49:48 +0200 (CEST)
Received: from po14934vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.35])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 39E958B964;
        Fri, 22 Jun 2018 15:49:48 +0200 (CEST)
Received: by po14934vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 2B3976763B; Fri, 22 Jun 2018 13:49:48 +0000 (UTC)
Message-Id: <f3a64e8451cd539f8a2e864045576ad99598160d.1529589663.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/mm: fix missing prototypes in slice.c
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, malat@debian.org,
        aneesh.kumar@linux.vnet.ibm.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 22 Jun 2018 13:49:48 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following warnings (obtained with make W=1).

arch/powerpc/mm/slice.c: At top level:
arch/powerpc/mm/slice.c:682:15: error: no previous prototype for 'arch_get_unmapped_area' [-Werror=missing-prototypes]
 unsigned long arch_get_unmapped_area(struct file *filp,
               ^
arch/powerpc/mm/slice.c:692:15: error: no previous prototype for 'arch_get_unmapped_area_topdown' [-Werror=missing-prototypes]
 unsigned long arch_get_unmapped_area_topdown(struct file *filp,
               ^

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/slice.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
index 205fe557ca10..9530c6db406a 100644
--- a/arch/powerpc/mm/slice.c
+++ b/arch/powerpc/mm/slice.c
@@ -31,6 +31,7 @@
 #include <linux/spinlock.h>
 #include <linux/export.h>
 #include <linux/hugetlb.h>
+#include <linux/sched/mm.h>
 #include <asm/mman.h>
 #include <asm/mmu.h>
 #include <asm/copro.h>
-- 
2.13.3

