Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 137E3C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 08:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB9632147C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 08:11:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="OHjzn7Ja"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbfBHIK7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 03:10:59 -0500
Received: from conuserg-07.nifty.com ([210.131.2.74]:63037 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727442AbfBHIK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 03:10:56 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id x188902K007241;
        Fri, 8 Feb 2019 17:09:11 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com x188902K007241
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1549613352;
        bh=0G9+10Zia38HKdZABMcllan4CmkUVH2FwVxeSCvb9Uk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OHjzn7JaxJRvQ6tvJWOXI1jqRmWlUSABKvdErsIkOg+I+K9lWKzNVB9tKo2Ahlyy7
         TlWkl0oNBpaU8TsjSpH2SKF8Znisep/MYbkakSSqra1Z+zc1lFnul3rxB+E8w1Ao2Y
         pwvXr0DQSOs7qNnzVL8Tep4DHdtqfRdwDZqulnBOYszVxk1zFSzLakLTE1fM0zOaGL
         E9pE5e0mHaAlO9fk0VCfBRQMkJxArm7zozd3oReS0lhd+a2jz0wdQa4yoniNk0ktXt
         QJiVlPryCg/KCl1Mgg6QIzu+8KRDAyTz5783fuZ2nZovt/8y4oGyeEXNxyH6iNoyUt
         YamVtEkykteWA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-mtd@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Brian Norris <computersforpeace@gmail.com>,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH 11/11] mtd: rawnand: denali: clean up coding style
Date:   Fri,  8 Feb 2019 17:08:55 +0900
Message-Id: <1549613335-30319-12-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549613335-30319-1-git-send-email-yamada.masahiro@socionext.com>
References: <1549613335-30319-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eliminate the following reports from 'scripts/checkpatch.pl --strict'.

  CHECK: Prefer kernel type 'u8' over 'uint8_t'
  CHECK: Prefer kernel type 'u32' over 'uint32_t'
  CHECK: Alignment should match open parenthesis

I slightly changed denali_check_erased_page() to make it shorter.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/mtd/nand/raw/denali.c | 41 +++++++++++++++++++----------------------
 1 file changed, 19 insertions(+), 22 deletions(-)

diff --git a/drivers/mtd/nand/raw/denali.c b/drivers/mtd/nand/raw/denali.c
index ce3a4bb..18d53dd 100644
--- a/drivers/mtd/nand/raw/denali.c
+++ b/drivers/mtd/nand/raw/denali.c
@@ -236,20 +236,17 @@ static int denali_check_erased_page(struct nand_chip *chip,
 				    unsigned int max_bitflips)
 {
 	struct mtd_ecc_stats *ecc_stats = &nand_to_mtd(chip)->ecc_stats;
-	uint8_t *ecc_code = chip->oob_poi + denali->oob_skip_bytes;
-	int ecc_steps = chip->ecc.steps;
-	int ecc_size = chip->ecc.size;
-	int ecc_bytes = chip->ecc.bytes;
+	struct nand_ecc_ctrl *ecc = &chip->ecc;
+	u8 *ecc_code = chip->oob_poi + denali->oob_skip_bytes;
 	int i, stat;
 
-	for (i = 0; i < ecc_steps; i++) {
+	for (i = 0; i < ecc->steps; i++) {
 		if (!(uncor_ecc_flags & BIT(i)))
 			continue;
 
-		stat = nand_check_erased_ecc_chunk(buf, ecc_size,
-						  ecc_code, ecc_bytes,
-						  NULL, 0,
-						  chip->ecc.strength);
+		stat = nand_check_erased_ecc_chunk(buf, ecc->size, ecc_code,
+						   ecc->bytes, NULL, 0,
+						   ecc->strength);
 		if (stat < 0) {
 			ecc_stats->failed++;
 		} else {
@@ -257,8 +254,8 @@ static int denali_check_erased_page(struct nand_chip *chip,
 			max_bitflips = max_t(unsigned int, max_bitflips, stat);
 		}
 
-		buf += ecc_size;
-		ecc_code += ecc_bytes;
+		buf += ecc->size;
+		ecc_code += ecc->bytes;
 	}
 
 	return max_bitflips;
@@ -270,7 +267,7 @@ static int denali_hw_ecc_fixup(struct nand_chip *chip,
 {
 	struct mtd_ecc_stats *ecc_stats = &nand_to_mtd(chip)->ecc_stats;
 	int bank = denali->active_bank;
-	uint32_t ecc_cor;
+	u32 ecc_cor;
 	unsigned int max_bitflips;
 
 	ecc_cor = ioread32(denali->reg + ECC_COR_INFO(bank));
@@ -301,15 +298,15 @@ static int denali_hw_ecc_fixup(struct nand_chip *chip,
 
 static int denali_sw_ecc_fixup(struct nand_chip *chip,
 			       struct denali_controller *denali,
-			       unsigned long *uncor_ecc_flags, uint8_t *buf)
+			       unsigned long *uncor_ecc_flags, u8 *buf)
 {
 	struct mtd_ecc_stats *ecc_stats = &nand_to_mtd(chip)->ecc_stats;
 	unsigned int ecc_size = chip->ecc.size;
 	unsigned int bitflips = 0;
 	unsigned int max_bitflips = 0;
-	uint32_t err_addr, err_cor_info;
+	u32 err_addr, err_cor_info;
 	unsigned int err_byte, err_sector, err_device;
-	uint8_t err_cor_value;
+	u8 err_cor_value;
 	unsigned int prev_sector = 0;
 	u32 irq_stat;
 
@@ -376,7 +373,7 @@ static int denali_sw_ecc_fixup(struct nand_chip *chip,
 static void denali_setup_dma64(struct denali_controller *denali,
 			       dma_addr_t dma_addr, int page, bool write)
 {
-	uint32_t mode;
+	u32 mode;
 	const int page_count = 1;
 
 	mode = DENALI_MAP10 | DENALI_BANK(denali) | page;
@@ -401,7 +398,7 @@ static void denali_setup_dma64(struct denali_controller *denali,
 static void denali_setup_dma32(struct denali_controller *denali,
 			       dma_addr_t dma_addr, int page, bool write)
 {
-	uint32_t mode;
+	u32 mode;
 	const int page_count = 1;
 
 	mode = DENALI_MAP10 | DENALI_BANK(denali);
@@ -650,7 +647,7 @@ static int denali_memcpy_in(void *buf, unsigned int offset, unsigned int len,
 	return 0;
 }
 
-static int denali_read_page_raw(struct nand_chip *chip, uint8_t *buf,
+static int denali_read_page_raw(struct nand_chip *chip, u8 *buf,
 				int oob_required, int page)
 {
 	struct denali_chip *dchip = to_denali_chip(chip);
@@ -687,7 +684,7 @@ static int denali_memcpy_out(void *buf, unsigned int offset, unsigned int len,
 	return 0;
 }
 
-static int denali_write_page_raw(struct nand_chip *chip, const uint8_t *buf,
+static int denali_write_page_raw(struct nand_chip *chip, const u8 *buf,
 				 int oob_required, int page)
 {
 	struct denali_chip *dchip = to_denali_chip(chip);
@@ -761,7 +758,7 @@ static int denali_write_oob(struct nand_chip *chip, int page)
 	return nand_prog_page_end_op(chip);
 }
 
-static int denali_read_page(struct nand_chip *chip, uint8_t *buf,
+static int denali_read_page(struct nand_chip *chip, u8 *buf,
 			    int oob_required, int page)
 {
 	struct denali_controller *denali = to_denali_controller(chip);
@@ -794,7 +791,7 @@ static int denali_read_page(struct nand_chip *chip, uint8_t *buf,
 	return stat;
 }
 
-static int denali_write_page(struct nand_chip *chip, const uint8_t *buf,
+static int denali_write_page(struct nand_chip *chip, const u8 *buf,
 			     int oob_required, int page)
 {
 	struct mtd_info *mtd = nand_to_mtd(chip);
@@ -813,7 +810,7 @@ static int denali_setup_data_interface(struct nand_chip *chip, int chipnr,
 	int acc_clks, re_2_we, re_2_re, we_2_re, addr_2_data;
 	int rdwr_en_lo, rdwr_en_hi, rdwr_en_lo_hi, cs_setup;
 	int addr_2_data_mask;
-	uint32_t tmp;
+	u32 tmp;
 
 	timings = nand_get_sdr_timings(conf);
 	if (IS_ERR(timings))
-- 
2.7.4

