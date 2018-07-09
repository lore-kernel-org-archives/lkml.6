Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA53C5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC7EB20873
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:58:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC7EB20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933556AbeGIP6p (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 11:58:45 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:45283 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932848AbeGIP55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 11:57:57 -0400
Received: from wuerfel.lan ([46.223.138.35]) by mrelayeu.kundenserver.de
 (mreue105 [212.227.15.145]) with ESMTPA (Nemesis) id
 0MG9Yd-1fq4vj0x5L-00FBBc; Mon, 09 Jul 2018 17:57:32 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] mtd: rawnand: davinci: fix build testing on 64-bit
Date:   Mon,  9 Jul 2018 17:57:02 +0200
Message-Id: <20180709155730.2422841-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:rl4qp5+DspI/dyd5dNruM8CwTJZFogiKcSYOIUTSUXMmRCJjKO1
 fLkAzWcvmYKCERS6jVHym0aM224eyGjvc1g/72BjlPoNQVV8qcvxJRzaZOlfYsKzEUR8nK7
 k3L5GQnsgtdq4hGAKbzajcEG3pFCqb1Dwy8B1yleefQfYjNaLu7HfQYbrzF38e+zaONXavr
 4IfD+jmyjz4u40lDl6BKw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:gnJUTlPUSHc=:LU7wxRoAQn2gIVlOwWYwC8
 nVLGM0KrInbpmR7oTQ7gzluXUAAX0LrXYzFr7+OYSyOUe79ZFGeucOhak1NbyltzjVgMsF90T
 JohiioiLW8O3zuVIVIPCEetdpk5QfvChI/6v+pZf3RBZUjmy7FQNxgNFKlhKl4uErtc7Ah07x
 3A/H55AOoOCfnpQP2DrHH0+/qIvc18G388LBQ83tP4psOkR6qjmjCun+gHR+y2zqppEggNqZ4
 tiqxin6/f8GIlERHIgtCZk18vXzddxFconpl4BuH+c7QJwaJsSSkNXq85xQ2cMTAIFbov6M7a
 IjlCWSeYvV4gT6KpUKCUOS6tdCTMuU89PiOJxWpn1FIkB8jPbAh6xAZKK6vSnOiP+tkJZh+cV
 HMts1UKfFkQ8OhgTo9QTIGBwpqd81tavWBLR7sJkoK8euJoNvJMQYw+f/qODjCiHLDrTtLK7/
 PbqoDBxWe/q0XHtUHQ8u5u1mL+EQL5JGUJzP734LYcQcnfao2MPGTo3QPmuU+FdYieHdplrnb
 yvvyFIYZokaazX3KpzGpP1pErcTL7SxT1dcauPk05Ce1akTY+CQ5OE5xNcYs9WMEE7hZHjAAj
 hxtFXbqSyvLE6na8tZLhmdZVi+dT7vci4NOEJILM2PAUqQiZh9UXtDejVI0wa8MIiSVBF8T3e
 pCfJODYu+4VQ1iOsRch6n23w8cVYVo3A/n8pAIV+AWKrlOs8gq4KahgVIWOcusslHoD4=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we can build this driver everywhere, we run into a couple
of warnings like:

drivers/mtd/nand/raw/davinci_nand.c: In function 'nand_davinci_correct_4bit':
drivers/mtd/nand/raw/davinci_nand.c:322:21: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]

In all cases, this is harmless and we just need to cast to an uintptr_t
rather than an unsigned 32-bit integer.

Fixes: 347af8918e8a ("mtd: rawnand: davinci: Allow selection of this driver when COMPILE_TEST=y")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mtd/nand/raw/davinci_nand.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/mtd/nand/raw/davinci_nand.c b/drivers/mtd/nand/raw/davinci_nand.c
index cd12e5abafde..c638bd60eb0b 100644
--- a/drivers/mtd/nand/raw/davinci_nand.c
+++ b/drivers/mtd/nand/raw/davinci_nand.c
@@ -102,7 +102,7 @@ static void nand_davinci_hwcontrol(struct mtd_info *mtd, int cmd,
 				   unsigned int ctrl)
 {
 	struct davinci_nand_info	*info = to_davinci_nand(mtd);
-	uint32_t			addr = info->current_cs;
+	uintptr_t			addr = info->current_cs;
 	struct nand_chip		*nand = mtd_to_nand(mtd);
 
 	/* Did the control lines change? */
@@ -122,7 +122,7 @@ static void nand_davinci_hwcontrol(struct mtd_info *mtd, int cmd,
 static void nand_davinci_select_chip(struct mtd_info *mtd, int chip)
 {
 	struct davinci_nand_info	*info = to_davinci_nand(mtd);
-	uint32_t			addr = info->ioaddr;
+	uintptr_t			addr = info->ioaddr;
 
 	/* maybe kick in a second chipselect */
 	if (chip > 0)
@@ -319,7 +319,7 @@ static int nand_davinci_correct_4bit(struct mtd_info *mtd,
 	/* Unpack ten bytes into eight 10 bit values.  We know we're
 	 * little-endian, and use type punning for less shifting/masking.
 	 */
-	if (WARN_ON(0x01 & (unsigned) ecc_code))
+	if (WARN_ON(0x01 & (uintptr_t)ecc_code))
 		return -EINVAL;
 	ecc16 = (unsigned short *)ecc_code;
 
@@ -441,9 +441,9 @@ static void nand_davinci_read_buf(struct mtd_info *mtd, uint8_t *buf, int len)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
 
-	if ((0x03 & ((unsigned)buf)) == 0 && (0x03 & len) == 0)
+	if ((0x03 & ((uintptr_t)buf)) == 0 && (0x03 & len) == 0)
 		ioread32_rep(chip->IO_ADDR_R, buf, len >> 2);
-	else if ((0x01 & ((unsigned)buf)) == 0 && (0x01 & len) == 0)
+	else if ((0x01 & ((uintptr_t)buf)) == 0 && (0x01 & len) == 0)
 		ioread16_rep(chip->IO_ADDR_R, buf, len >> 1);
 	else
 		ioread8_rep(chip->IO_ADDR_R, buf, len);
@@ -454,9 +454,9 @@ static void nand_davinci_write_buf(struct mtd_info *mtd,
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
 
-	if ((0x03 & ((unsigned)buf)) == 0 && (0x03 & len) == 0)
+	if ((0x03 & ((uintptr_t)buf)) == 0 && (0x03 & len) == 0)
 		iowrite32_rep(chip->IO_ADDR_R, buf, len >> 2);
-	else if ((0x01 & ((unsigned)buf)) == 0 && (0x01 & len) == 0)
+	else if ((0x01 & ((uintptr_t)buf)) == 0 && (0x01 & len) == 0)
 		iowrite16_rep(chip->IO_ADDR_R, buf, len >> 1);
 	else
 		iowrite8_rep(chip->IO_ADDR_R, buf, len);
@@ -680,7 +680,7 @@ static int nand_davinci_probe(struct platform_device *pdev)
 	info->chip.bbt_md	= pdata->bbt_md;
 	info->timing		= pdata->timing;
 
-	info->ioaddr		= (uint32_t __force) vaddr;
+	info->ioaddr		= (uintptr_t __force) vaddr;
 
 	info->current_cs	= info->ioaddr;
 	info->core_chipsel	= pdata->core_chipsel;
-- 
2.9.0

