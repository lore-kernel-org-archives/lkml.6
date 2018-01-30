Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752509AbeA3NXY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 08:23:24 -0500
Received: from michel.telenet-ops.be ([195.130.137.88]:56340 "EHLO
        michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751464AbeA3NXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 08:23:23 -0500
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Miquel Raynal <miquel.raynal@free-electrons.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] mtd: nand: MTD_NAND_MARVELL should depend on HAS_DMA
Date: Tue, 30 Jan 2018 14:23:21 +0100
Message-Id: <1517318601-14793-1-git-send-email-geert@linux-m68k.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If NO_DMA=y:

    ERROR: "bad_dma_ops" [drivers/mtd/nand/marvell_nand.ko] undefined!

Add a dependency on HAS_DMA to fix this.

Fixes: 02f26ecf8c772751 ("mtd: nand: add reworked Marvell NAND controller driver")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/mtd/nand/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
index e6b8c59f2c0da7c0..736ac887303c88ba 100644
--- a/drivers/mtd/nand/Kconfig
+++ b/drivers/mtd/nand/Kconfig
@@ -328,7 +328,7 @@ config MTD_NAND_MARVELL
 	tristate "NAND controller support on Marvell boards"
 	depends on PXA3xx || ARCH_MMP || PLAT_ORION || ARCH_MVEBU || \
 		   COMPILE_TEST
-	depends on HAS_IOMEM
+	depends on HAS_IOMEM && HAS_DMA
 	help
 	  This enables the NAND flash controller driver for Marvell boards,
 	  including:
-- 
2.7.4
