Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECDE1C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 21:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF6C820857
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 21:31:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF6C820857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728609AbeIGCIu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 22:08:50 -0400
Received: from mout.perfora.net ([74.208.4.194]:48319 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726116AbeIGCIu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 22:08:50 -0400
Received: from localhost.net ([89.217.215.226]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPA (Nemesis) id 0MA7R9-1g8mQ727XV-00BKug;
 Thu, 06 Sep 2018 23:30:35 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-mtd@lists.infradead.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Arnd Bergmann <arnd@arndb.de>, Stefan Agner <stefan@agner.ch>,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Brian Norris <computersforpeace@gmail.com>
Subject: [PATCH v2 2/2] mtd: rawnand: ESMT: retrieve ECC requirements from 5th id byte
Date:   Thu,  6 Sep 2018 23:30:20 +0200
Message-Id: <20180906213020.7493-2-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180906213020.7493-1-marcel@ziswiler.com>
References: <20180906213020.7493-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:8K9w1DpsH0BYVpxRT4Ko/Yv3Usfd5WMTz81W+BESfPkM0swuLbM
 9iwjmq2IanD4yd5lshx7dzXxfDqV14MncSkKsHyJs3lcxOZrP7vUEum+SDR7RghhiZ2O6kZ
 nVEathQSbXLPmq/jQzr777gTt1KPvIWqA08MlXJUOzn0BmhQgtsxfyHuwGOP6tDOOO0Og03
 IZX+NKtMP8dR1AewBx4Tw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:10ZmuVbvr50=:FP2RNANDCW/ibKFmmb5AIb
 lBLmjoaGxxblicSXcP3Q+RU3NiAmk2iWHEJA1y42SeCbgLF6EpAIonAbebbYTZzrnFaQfyXZt
 /cxNpCqM4TIOzKsHAaIf37gOnZkLhiNagIbKJXiJvdeUSvcbZApK5KXuM4/b4rqCEGtM2hTxZ
 1ulZ3kwXCmSKQnn3hqVH/4LSBrUbQtNcGF4CalOSEjI9NuJByEh2mQB+6eUlgMQ5TGKdh/eqe
 EIk99Kg0Ong+/mr6FKjIBdL4rCoeO+qBG9DVsNwrjDoqBfN2H7vI+E/7eyCUb9+kOEyOFY89O
 JxXWlKXtQWPz3iLvtsG+RCM0G9oGjJF8IJXrRAE1WPKdi9AxO1aj0GUZ0ttvbeJGSc5jgoExU
 jvfAHHYbmu/K/cGMcOS5Q2VDLl0dT5+o099oi8AzMgIg/mp7xRcOWTE78E2RuRJjLxyieDBTs
 10XW6mEbdfSiUCFxv7czGLERhxz5yyqRKEJcGLSdrFGWpID92F3MNsVpIIqmORvh1UfRipAHb
 Qc6oa8GK6s8dOa5U5JsYLmdTPD+YFZpUuemXw9DFwOE9goa6c48zTkvgoM/9jYtQ+H2gNPTPX
 XsLDSnADeKVVoLlzmcHSr+wuEFWkt6FPp1+zoyZhXjzNdLXNr5iYNp/NKhnVvS5DnM9zG/P88
 vi2koKH0SfNNT2LQ9wmmnwgDfITWmQAvWn/2nRs8J/81QYJlioBaRIkTx83Gjfw8vDto=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

This patch enables support to read the ECC level from the NAND flash
using ESMT SLC NAND ID byte 5 information as documented e.g. in the
following data sheet:

https://www.esmt.com.tw/upload/pdf/ESMT/datasheets/F59L1G81LA(2Y).pdf

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2:
- Also hook the new esmt_nand_manuf_ops to the ESMT entry in the
  nand_manufacturer table as discovered by Boris.
- Also add the Makefile as well as include file changes as required.

 drivers/mtd/nand/raw/Makefile    |  1 +
 drivers/mtd/nand/raw/nand_esmt.c | 46 ++++++++++++++++++++++++++++++++++++++++
 drivers/mtd/nand/raw/nand_ids.c  |  2 +-
 include/linux/mtd/rawnand.h      |  1 +
 4 files changed, 49 insertions(+), 1 deletion(-)
 create mode 100644 drivers/mtd/nand/raw/nand_esmt.c

diff --git a/drivers/mtd/nand/raw/Makefile b/drivers/mtd/nand/raw/Makefile
index d5a5f9832b88..ecb4d6cde1ee 100644
--- a/drivers/mtd/nand/raw/Makefile
+++ b/drivers/mtd/nand/raw/Makefile
@@ -60,6 +60,7 @@ obj-$(CONFIG_MTD_NAND_TEGRA)		+= tegra_nand.o
 
 nand-objs := nand_base.o nand_bbt.o nand_timings.o nand_ids.o
 nand-objs += nand_amd.o
+nand-objs += nand_esmt.o
 nand-objs += nand_hynix.o
 nand-objs += nand_macronix.o
 nand-objs += nand_micron.o
diff --git a/drivers/mtd/nand/raw/nand_esmt.c b/drivers/mtd/nand/raw/nand_esmt.c
new file mode 100644
index 000000000000..360d351ac043
--- /dev/null
+++ b/drivers/mtd/nand/raw/nand_esmt.c
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2018 Toradex AG
+ *
+ * Author: Marcel Ziswiler <marcel.ziswiler@toradex.com>
+ */
+
+#include <linux/mtd/rawnand.h>
+
+static void esmt_nand_decode_id(struct nand_chip *chip)
+{
+	nand_decode_ext_id(chip);
+
+	/* Extract ECC requirements from 5th id byte. */
+	if (chip->id.len >= 5 && nand_is_slc(chip)) {
+		chip->ecc_step_ds = 512;
+		switch (chip->id.data[4] & 0x3) {
+		case 0x0:
+			chip->ecc_strength_ds = 4;
+			break;
+		case 0x1:
+			chip->ecc_strength_ds = 2;
+			break;
+		case 0x2:
+			chip->ecc_strength_ds = 1;
+			break;
+		default:
+			WARN(1, "Could not get ECC info");
+			chip->ecc_step_ds = 0;
+			break;
+		}
+	}
+}
+
+static int esmt_nand_init(struct nand_chip *chip)
+{
+	if (nand_is_slc(chip))
+		chip->bbt_options |= NAND_BBT_SCAN2NDPAGE;
+
+	return 0;
+}
+
+const struct nand_manufacturer_ops esmt_nand_manuf_ops = {
+	.detect = esmt_nand_decode_id,
+	.init = esmt_nand_init,
+};
diff --git a/drivers/mtd/nand/raw/nand_ids.c b/drivers/mtd/nand/raw/nand_ids.c
index 0851cd86bf19..f904f8b987e3 100644
--- a/drivers/mtd/nand/raw/nand_ids.c
+++ b/drivers/mtd/nand/raw/nand_ids.c
@@ -172,7 +172,7 @@ static const struct nand_manufacturer nand_manufacturers[] = {
 	{NAND_MFR_AMD, "AMD/Spansion", &amd_nand_manuf_ops},
 	{NAND_MFR_ATO, "ATO"},
 	{NAND_MFR_EON, "Eon"},
-	{NAND_MFR_ESMT, "ESMT"},
+	{NAND_MFR_ESMT, "ESMT", &esmt_nand_manuf_ops},
 	{NAND_MFR_FUJITSU, "Fujitsu"},
 	{NAND_MFR_HYNIX, "Hynix", &hynix_nand_manuf_ops},
 	{NAND_MFR_INTEL, "Intel"},
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index 20516fc28b74..c4656e3eeba1 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -1542,6 +1542,7 @@ nand_manufacturer_name(const struct nand_manufacturer *manufacturer)
 extern struct nand_flash_dev nand_flash_ids[];
 
 extern const struct nand_manufacturer_ops amd_nand_manuf_ops;
+extern const struct nand_manufacturer_ops esmt_nand_manuf_ops;
 extern const struct nand_manufacturer_ops hynix_nand_manuf_ops;
 extern const struct nand_manufacturer_ops macronix_nand_manuf_ops;
 extern const struct nand_manufacturer_ops micron_nand_manuf_ops;
-- 
2.14.4

