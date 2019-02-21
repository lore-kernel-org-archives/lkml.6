Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79151C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 08:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B501214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 08:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="ApBZAfUa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbfBUIE7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 03:04:59 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:9790 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725385AbfBUIE4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 03:04:56 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 444n7p0Rk3z9vJg9;
        Thu, 21 Feb 2019 09:04:54 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=ApBZAfUa; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id i42-HcW_fhsF; Thu, 21 Feb 2019 09:04:54 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 444n7n6YWmz9vJg1;
        Thu, 21 Feb 2019 09:04:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1550736293; bh=UEoSB/AezPasAGD2CrkCIDztNdkmNHmxKJ269GvTrfE=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=ApBZAfUaGyTrxpn3c/AHQS9dBHcGmx+RiUwNzMsyHeh9A5iDks/7C7K6/fT3MshFO
         jBfvOWpTkHWbJEq6mVpvRi2+ktGNGJoR4Ll/20s5K1wHE+2psYOd7ZfuRuAq9738yW
         /CkKXF3LSUCXsv7Rjy26I0HbqFK/babOEJcnfDNk=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id DDFF28B78F;
        Thu, 21 Feb 2019 09:04:54 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Ii8RswflVEoF; Thu, 21 Feb 2019 09:04:54 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B28A18B75B;
        Thu, 21 Feb 2019 09:04:54 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 905E36E866; Thu, 21 Feb 2019 08:04:54 +0000 (UTC)
Message-Id: <d2ea939964b8973da854dfae7baf61288da821f4.1550692943.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1550692943.git.christophe.leroy@c-s.fr>
References: <cover.1550692943.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v4 06/16] powerpc/wii: remove wii_mmu_mapin_mem2()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, j.neuschaefer@gmx.net
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu, 21 Feb 2019 08:04:54 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wii_mmu_mapin_mem2() is not used anymore, remove it.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/platforms/embedded6xx/wii.c | 28 ----------------------------
 1 file changed, 28 deletions(-)

diff --git a/arch/powerpc/platforms/embedded6xx/wii.c b/arch/powerpc/platforms/embedded6xx/wii.c
index ac4ee88efc80..235fe81aa2b1 100644
--- a/arch/powerpc/platforms/embedded6xx/wii.c
+++ b/arch/powerpc/platforms/embedded6xx/wii.c
@@ -54,10 +54,6 @@
 static void __iomem *hw_ctrl;
 static void __iomem *hw_gpio;
 
-unsigned long wii_hole_start;
-unsigned long wii_hole_size;
-
-
 static int __init page_aligned(unsigned long x)
 {
 	return !(x & (PAGE_SIZE-1));
@@ -69,30 +65,6 @@ void __init wii_memory_fixups(void)
 
 	BUG_ON(memblock.memory.cnt != 2);
 	BUG_ON(!page_aligned(p[0].base) || !page_aligned(p[1].base));
-
-	/* determine hole */
-	wii_hole_start = ALIGN(p[0].base + p[0].size, PAGE_SIZE);
-	wii_hole_size = p[1].base - wii_hole_start;
-}
-
-unsigned long __init wii_mmu_mapin_mem2(unsigned long top)
-{
-	unsigned long delta, size, bl;
-	unsigned long max_size = (256<<20);
-
-	/* MEM2 64MB@0x10000000 */
-	delta = wii_hole_start + wii_hole_size;
-	size = top - delta;
-
-	if (__map_without_bats)
-		return delta;
-
-	for (bl = 128<<10; bl < max_size; bl <<= 1) {
-		if (bl * 2 > size)
-			break;
-	}
-	setbat(4, PAGE_OFFSET+delta, delta, bl, PAGE_KERNEL_X);
-	return delta + bl;
 }
 
 static void __noreturn wii_spin(void)
-- 
2.13.3

