Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B57C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 04:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 828CB21872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 04:21:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="FWNq4zxH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbfAXEVD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 23:21:03 -0500
Received: from conuserg-12.nifty.com ([210.131.2.79]:63163 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbfAXEVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 23:21:02 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id x0O4JI06030691;
        Thu, 24 Jan 2019 13:19:20 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com x0O4JI06030691
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1548303561;
        bh=VHFb44+xsO5NAj11hpjxC6a3TDCSsDpuFIplJ8wqUP8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FWNq4zxHgQ6ZiYuqwmOzc7dKYJWcNBwBgcI3bABzN7iD+b+0WK6ru/YjOgw31kMDM
         LWlZoL5D/CDctAQEYPgCNZLxpWDK3yE3dM+vaes2iQABu2+TCT6ryrD56gWymertGz
         YOWnOALTBzuRDwzSTGTbzSJMHlRHRXzmiB5LmGTxmJcfWuq5S4+Afh+wEPkDWaZiF5
         w70yrNP8vfbmMWzvI52O+9FaUG7yPbbcuwSP6kdYseV4Uo0G+6Yf5UbObJbfD+1q+9
         XipsTAwiXtlXa3TryEMzIGd5tL5y7OL2DNhYsO7JuyWZDmPFnNJcNZ5+BOGNZU1hXE
         wtgEcMS/LV/Vw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-mtd@lists.infradead.org,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Brian Norris <computersforpeace@gmail.com>,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Boris Brezillon <bbrezillon@kernel.org>
Subject: [PATCH 2/2] mtd: rawnand: denali: remove unused function argument 'raw'
Date:   Thu, 24 Jan 2019 13:19:07 +0900
Message-Id: <1548303547-21156-3-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548303547-21156-1-git-send-email-yamada.masahiro@socionext.com>
References: <1548303547-21156-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This argument is not used at all.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/mtd/nand/raw/denali.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/mtd/nand/raw/denali.c b/drivers/mtd/nand/raw/denali.c
index 6775644..24aeafc 100644
--- a/drivers/mtd/nand/raw/denali.c
+++ b/drivers/mtd/nand/raw/denali.c
@@ -473,7 +473,7 @@ static void denali_setup_dma32(struct denali_nand_info *denali,
 }
 
 static int denali_pio_read(struct denali_nand_info *denali, void *buf,
-			   size_t size, int page, int raw)
+			   size_t size, int page)
 {
 	u32 addr = DENALI_MAP01 | DENALI_BANK(denali) | page;
 	uint32_t *buf32 = (uint32_t *)buf;
@@ -501,7 +501,7 @@ static int denali_pio_read(struct denali_nand_info *denali, void *buf,
 }
 
 static int denali_pio_write(struct denali_nand_info *denali,
-			    const void *buf, size_t size, int page, int raw)
+			    const void *buf, size_t size, int page)
 {
 	u32 addr = DENALI_MAP01 | DENALI_BANK(denali) | page;
 	const uint32_t *buf32 = (uint32_t *)buf;
@@ -522,16 +522,16 @@ static int denali_pio_write(struct denali_nand_info *denali,
 }
 
 static int denali_pio_xfer(struct denali_nand_info *denali, void *buf,
-			   size_t size, int page, int raw, int write)
+			   size_t size, int page, int write)
 {
 	if (write)
-		return denali_pio_write(denali, buf, size, page, raw);
+		return denali_pio_write(denali, buf, size, page);
 	else
-		return denali_pio_read(denali, buf, size, page, raw);
+		return denali_pio_read(denali, buf, size, page);
 }
 
 static int denali_dma_xfer(struct denali_nand_info *denali, void *buf,
-			   size_t size, int page, int raw, int write)
+			   size_t size, int page, int write)
 {
 	dma_addr_t dma_addr;
 	uint32_t irq_mask, irq_status, ecc_err_mask;
@@ -541,7 +541,7 @@ static int denali_dma_xfer(struct denali_nand_info *denali, void *buf,
 	dma_addr = dma_map_single(denali->dev, buf, size, dir);
 	if (dma_mapping_error(denali->dev, dma_addr)) {
 		dev_dbg(denali->dev, "Failed to DMA-map buffer. Trying PIO.\n");
-		return denali_pio_xfer(denali, buf, size, page, raw, write);
+		return denali_pio_xfer(denali, buf, size, page, write);
 	}
 
 	if (write) {
@@ -595,9 +595,9 @@ static int denali_data_xfer(struct denali_nand_info *denali, void *buf,
 		  denali->reg + TRANSFER_SPARE_REG);
 
 	if (denali->dma_avail)
-		return denali_dma_xfer(denali, buf, size, page, raw, write);
+		return denali_dma_xfer(denali, buf, size, page, write);
 	else
-		return denali_pio_xfer(denali, buf, size, page, raw, write);
+		return denali_pio_xfer(denali, buf, size, page, write);
 }
 
 static void denali_oob_xfer(struct mtd_info *mtd, struct nand_chip *chip,
-- 
2.7.4

