Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1973C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 20:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64A4021521
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 20:30:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64A4021521
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933229AbeFUUa5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 16:30:57 -0400
Received: from andre.telenet-ops.be ([195.130.132.53]:33804 "EHLO
        andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932885AbeFUUa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 16:30:56 -0400
Received: from ayla.of.borg ([84.194.111.163])
        by andre.telenet-ops.be with bizsmtp
        id 1YWu1y00j3XaVaC01YWufz; Thu, 21 Jun 2018 22:30:55 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ayla.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1fW6EI-00074c-PL; Thu, 21 Jun 2018 22:30:54 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1fW6EI-0008Lc-NX; Thu, 21 Jun 2018 22:30:54 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v2] m68knommu: Fix typos in Coldfire 5272 DMA debug code
Date:   Thu, 21 Jun 2018 22:30:53 +0200
Message-Id: <20180621203053.32047-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If DEBUG_DMA is defined:

    include/asm/dma.h: In function ‘set_dma_mode’:
    include/asm/dma.h:393: error: ‘dmabp’ undeclared (first use in this function)
    include/asm/dma.h:393: error: (Each undeclared identifier is reported only once
    include/asm/dma.h:393: error: for each function it appears in.)
    include/asm/dma.h: In function ‘set_dma_addr’:
    include/asm/dma.h:424: error: ‘dmawp’ undeclared (first use in this function)

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Greg Ungerer <gerg@linux-m68k.org>
---
v2:
  - Add Acked-by.
---
 arch/m68k/include/asm/dma.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/m68k/include/asm/dma.h b/arch/m68k/include/asm/dma.h
index b0978a23bad1d7ee..ae2021964e32d36f 100644
--- a/arch/m68k/include/asm/dma.h
+++ b/arch/m68k/include/asm/dma.h
@@ -390,7 +390,7 @@ static __inline__ void set_dma_mode(unsigned int dmanr, char mode)
 
 #ifdef DEBUG_DMA
   printk("%s(%d): dmanr=%d DMR[%x]=%x DIR[%x]=%x\n", __FILE__, __LINE__,
-         dmanr, (int) &dmalp[MCFDMA_DMR], dmabp[MCFDMA_DMR],
+	 dmanr, (int) &dmalp[MCFDMA_DMR], dmalp[MCFDMA_DMR],
 	 (int) &dmawp[MCFDMA_DIR], dmawp[MCFDMA_DIR]);
 #endif
 }
@@ -421,7 +421,7 @@ static __inline__ void set_dma_addr(unsigned int dmanr, unsigned int a)
 
 #ifdef DEBUG_DMA
   printk("%s(%d): dmanr=%d DMR[%x]=%x SAR[%x]=%08x DAR[%x]=%08x\n",
-	__FILE__, __LINE__, dmanr, (int) &dmawp[MCFDMA_DMR], dmawp[MCFDMA_DMR],
+	__FILE__, __LINE__, dmanr, (int) &dmalp[MCFDMA_DMR], dmalp[MCFDMA_DMR],
 	(int) &dmalp[MCFDMA_DSAR], dmalp[MCFDMA_DSAR],
 	(int) &dmalp[MCFDMA_DDAR], dmalp[MCFDMA_DDAR]);
 #endif
-- 
2.17.1

