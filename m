Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8781BC32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 08:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46CA420827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 08:32:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46CA420827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.De
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbeKHSGk convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 13:06:40 -0500
Received: from skedge03.snt-world.com ([91.208.41.68]:40970 "EHLO
        skedge03.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbeKHSGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 13:06:40 -0500
Received: from sntmail14r.snt-is.com (unknown [10.203.32.184])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge03.snt-world.com (Postfix) with ESMTPS id 697122134261;
        Thu,  8 Nov 2018 09:32:11 +0100 (CET)
Received: from sntmail11s.snt-is.com (10.203.32.181) by sntmail14r.snt-is.com
 (10.203.32.184) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Thu, 8 Nov 2018
 09:32:11 +0100
Received: from sntmail11s.snt-is.com ([fe80::b972:ad22:ada5:7c6a]) by
 sntmail11s.snt-is.com ([fe80::b972:ad22:ada5:7c6a%4]) with mapi id
 15.01.1466.003; Thu, 8 Nov 2018 09:32:11 +0100
From:   Schrempf Frieder <frieder.schrempf@kontron.De>
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        "David Woodhouse" <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>
CC:     Schrempf Frieder <frieder.schrempf@kontron.De>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>
Subject: [PATCH] mtd: nand: spi: Add initial support for Toshiba TC58CVG2S0H
Thread-Topic: [PATCH] mtd: nand: spi: Add initial support for Toshiba
 TC58CVG2S0H
Thread-Index: AQHUdz2L3HigzaAOUUKXPQ4ku2nhHg==
Date:   Thu, 8 Nov 2018 08:32:11 +0000
Message-ID: <1541665796-21092-1-git-send-email-frieder.schrempf@kontron.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.42]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: 697122134261.A566A
X-SnT-MailScanner: Found to be clean
X-SnT-MailScanner-SpamCheck: 
X-SnT-MailScanner-From: frieder.schrempf@kontron.de
X-SnT-MailScanner-To: boris.brezillon@bootlin.com,
        computersforpeace@gmail.com, dwmw2@infradead.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        marek.vasut@gmail.com, miquel.raynal@bootlin.com, richard@nod.at
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add minimal support for the Toshiba TC58CVG2S0H SPI NAND chip.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 drivers/mtd/nand/spi/Makefile  |   2 +-
 drivers/mtd/nand/spi/core.c    |   1 +
 drivers/mtd/nand/spi/toshiba.c | 136 ++++++++++++++++++++++++++++++++++++
 include/linux/mtd/spinand.h    |   1 +
 4 files changed, 139 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/spi/Makefile b/drivers/mtd/nand/spi/Makefile
index b74e074..be5f735 100644
--- a/drivers/mtd/nand/spi/Makefile
+++ b/drivers/mtd/nand/spi/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
-spinand-objs := core.o macronix.o micron.o winbond.o
+spinand-objs := core.o macronix.o micron.o toshiba.o winbond.o
 obj-$(CONFIG_MTD_SPI_NAND) += spinand.o
diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 30f8364..87bdf2a 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -766,6 +766,7 @@ static const struct nand_ops spinand_ops = {
 static const struct spinand_manufacturer *spinand_manufacturers[] = {
 	&macronix_spinand_manufacturer,
 	&micron_spinand_manufacturer,
+	&toshiba_spinand_manufacturer,
 	&winbond_spinand_manufacturer,
 };
 
diff --git a/drivers/mtd/nand/spi/toshiba.c b/drivers/mtd/nand/spi/toshiba.c
new file mode 100644
index 0000000..294bcf6
--- /dev/null
+++ b/drivers/mtd/nand/spi/toshiba.c
@@ -0,0 +1,136 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018 exceet electronics GmbH
+ * Copyright (c) 2018 Kontron Electronics GmbH
+ *
+ * Author: Frieder Schrempf <frieder.schrempf@kontron.de>
+ */
+
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/mtd/spinand.h>
+
+#define SPINAND_MFR_TOSHIBA		0x98
+
+static SPINAND_OP_VARIANTS(read_cache_variants,
+		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
+
+static SPINAND_OP_VARIANTS(write_cache_variants,
+		SPINAND_PROG_LOAD(true, 0, NULL, 0));
+
+static SPINAND_OP_VARIANTS(update_cache_variants,
+		SPINAND_PROG_LOAD(false, 0, NULL, 0));
+
+static int tc58cvg2s0h_ooblayout_ecc(struct mtd_info *mtd, int section,
+				     struct mtd_oob_region *region)
+{
+	if (section > 7)
+		return -ERANGE;
+
+	region->offset = 128 + 16 * section;
+	region->length = 16;
+
+
+	return 0;
+}
+
+static int tc58cvg2s0h_ooblayout_free(struct mtd_info *mtd, int section,
+				      struct mtd_oob_region *region)
+{
+	if (section > 7)
+		return -ERANGE;
+
+	region->offset = 2 + 16 * section;
+	region->length = 14;
+
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops tc58cvg2s0h_ooblayout = {
+	.ecc = tc58cvg2s0h_ooblayout_ecc,
+	.free = tc58cvg2s0h_ooblayout_free,
+};
+
+static int tc58cvg2s0h_ecc_get_status(struct spinand_device *spinand,
+				      u8 status)
+{
+	struct nand_device *nand = spinand_to_nand(spinand);
+	u8 mbf = 0;
+	struct spi_mem_op op = SPINAND_GET_FEATURE_OP(0x30, &mbf);
+
+	switch (status & STATUS_ECC_MASK) {
+	case STATUS_ECC_NO_BITFLIPS:
+		return 0;
+
+	case STATUS_ECC_UNCOR_ERROR:
+		return -EBADMSG;
+
+	case STATUS_ECC_HAS_BITFLIPS:
+		/*
+		 * Let's try to retrieve the real maximum number of bitflips
+		 * in order to avoid forcing the wear-leveling layer to move
+		 * data around if it's not necessary.
+		 */
+		if (spi_mem_exec_op(spinand->spimem, &op))
+			return nand->eccreq.strength;
+
+		mbf >>= 4;
+
+		if (WARN_ON(mbf > nand->eccreq.strength || !mbf))
+			return nand->eccreq.strength;
+
+		return mbf;
+
+	default:
+		break;
+	}
+
+	return -EINVAL;
+}
+
+static const struct spinand_info toshiba_spinand_table[] = {
+	SPINAND_INFO("TC58CVG2S0H", 0xCD,
+		     NAND_MEMORG(1, 4096, 256, 64, 2048, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&tc58cvg2s0h_ooblayout,
+				     tc58cvg2s0h_ecc_get_status)),
+};
+
+static int toshiba_spinand_detect(struct spinand_device *spinand)
+{
+	u8 *id = spinand->id.data;
+	int ret;
+
+	/*
+	 * Toshiba SPI NAND read ID needs a dummy byte,
+	 * so the first byte in id is garbage.
+	 */
+	if (id[1] != SPINAND_MFR_TOSHIBA)
+		return 0;
+
+	ret = spinand_match_and_init(spinand, toshiba_spinand_table,
+				     ARRAY_SIZE(toshiba_spinand_table),
+				     id[2]);
+	if (ret)
+		return ret;
+
+	return 1;
+}
+
+static const struct spinand_manufacturer_ops toshiba_spinand_manuf_ops = {
+	.detect = toshiba_spinand_detect,
+};
+
+const struct spinand_manufacturer toshiba_spinand_manufacturer = {
+	.id = SPINAND_MFR_TOSHIBA,
+	.name = "Toshiba",
+	.ops = &toshiba_spinand_manuf_ops,
+};
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 088ff96..816c4b0 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -196,6 +196,7 @@ struct spinand_manufacturer {
 /* SPI NAND manufacturers */
 extern const struct spinand_manufacturer macronix_spinand_manufacturer;
 extern const struct spinand_manufacturer micron_spinand_manufacturer;
+extern const struct spinand_manufacturer toshiba_spinand_manufacturer;
 extern const struct spinand_manufacturer winbond_spinand_manufacturer;
 
 /**
-- 
2.7.4
