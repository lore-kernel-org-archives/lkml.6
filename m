Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56FB8C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 08:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B0E22075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 08:50:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B0E22075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbeIFNYl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 09:24:41 -0400
Received: from mout.perfora.net ([74.208.4.196]:43347 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726171AbeIFNYl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 09:24:41 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MAvqc-1g7hss2Cvs-009x2o; Thu, 06 Sep 2018 10:49:31 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-mtd@lists.infradead.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH 1/2] mtd: nand: reorder nand manufacturer ids
Date:   Thu,  6 Sep 2018 10:49:21 +0200
Message-Id: <20180906084922.14845-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
X-Provags-ID: V03:K1:+AiexZFmMICQ5bQT0cQklBVOP5HgxlxI+n91DMfJOVJtOrkporL
 QeYzkvRaZui3UzxOETZplw2+gwa+m7sGfNOv0ootZuMawLoq5fZ/+LVFLTDwp/J3l4PGZ6P
 80KL9jRJ9IhfASPtZNawgiBa3ZamfivlW3qU1P/5ZqUdJWcyqey4Bqp5dTTZSdru3lcoOV0
 K1TWbSEHq3wJ92MmrwMaw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:UpslRCgIWY8=:oFjWPCE77QedrVvB7JAvnK
 ttQPgJZ0SytpH0SyyKjiJ3Ofv5S0REmuIy0M39J+57I3EwMEj7u7+L5976IntCV5SPEzYMqvW
 N+MyswdkddxUr8Ps+XFFYGZiJELTBMWJsXyzS4c21gD6+1lNFKO/V88wMHdF3izcQJXKnezop
 6AhNwQ7xSAd4q8zs6MxLNKAVwcqCDkjWKSdTVuBhAcbMBqj/P27NqJEby2mUPb3XDHE1Ges7f
 VYFuF9COTyaz9mhvy6M9AcJ9RpuSLDDsXTNzPWkmzKSd8KESV9Sy55UstRoIbCWTG7i9Pzydl
 OMCKb+ag41TnaCFdRwi2TWUXYlW7XyCZKXjZu3fi6BmMeVp6qU3+9/pB9gS2hxFaHn1uXj5co
 +dvx3K8Y0JcvD+m3w7lOg2LEBd0WD0MBsG1j/ZCdCTzK6ooApz7eFedLwHqzzY4fFpiKmuR7s
 Ye+4EFdnU1N4ZZccP0sy1niMBbKmbJoIuSiCceS3jncyI/4Kh4GCuPq2neoAgVioYbJIQWYbG
 kD9NNLgWSUInQjHQ/Et/TSR4OGHmseELoMQ3+9pm2okL/nRLt65lslUpze1oCnxz5bB03hVm5
 57OzO8hDkqx91/v9hLoUs8czuDCA+tChfBfdC+5iAHekprCTQ0KvMZTIfcNi2IqTjWrAvkaJH
 qQHnSJUdHkzPc9E0c19aSH/9wYzwujrnkQ8fetd2NGXEMsZzWP706l6h/Y346+cya3Cs=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Reorder NAND manufacturer ids for clarity.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 drivers/mtd/nand/raw/nand_ids.c | 20 ++++++++++----------
 include/linux/mtd/rawnand.h     |  8 ++++----
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/mtd/nand/raw/nand_ids.c b/drivers/mtd/nand/raw/nand_ids.c
index 5423c3bb388e..0851cd86bf19 100644
--- a/drivers/mtd/nand/raw/nand_ids.c
+++ b/drivers/mtd/nand/raw/nand_ids.c
@@ -169,21 +169,21 @@ struct nand_flash_dev nand_flash_ids[] = {
 
 /* Manufacturer IDs */
 static const struct nand_manufacturer nand_manufacturers[] = {
-	{NAND_MFR_TOSHIBA, "Toshiba", &toshiba_nand_manuf_ops},
+	{NAND_MFR_AMD, "AMD/Spansion", &amd_nand_manuf_ops},
+	{NAND_MFR_ATO, "ATO"},
+	{NAND_MFR_EON, "Eon"},
 	{NAND_MFR_ESMT, "ESMT"},
-	{NAND_MFR_SAMSUNG, "Samsung", &samsung_nand_manuf_ops},
 	{NAND_MFR_FUJITSU, "Fujitsu"},
-	{NAND_MFR_NATIONAL, "National"},
-	{NAND_MFR_RENESAS, "Renesas"},
-	{NAND_MFR_STMICRO, "ST Micro"},
 	{NAND_MFR_HYNIX, "Hynix", &hynix_nand_manuf_ops},
-	{NAND_MFR_MICRON, "Micron", &micron_nand_manuf_ops},
-	{NAND_MFR_AMD, "AMD/Spansion", &amd_nand_manuf_ops},
+	{NAND_MFR_INTEL, "Intel"},
 	{NAND_MFR_MACRONIX, "Macronix", &macronix_nand_manuf_ops},
-	{NAND_MFR_EON, "Eon"},
+	{NAND_MFR_MICRON, "Micron", &micron_nand_manuf_ops},
+	{NAND_MFR_NATIONAL, "National"},
+	{NAND_MFR_RENESAS, "Renesas"},
+	{NAND_MFR_SAMSUNG, "Samsung", &samsung_nand_manuf_ops},
 	{NAND_MFR_SANDISK, "SanDisk"},
-	{NAND_MFR_INTEL, "Intel"},
-	{NAND_MFR_ATO, "ATO"},
+	{NAND_MFR_STMICRO, "ST Micro"},
+	{NAND_MFR_TOSHIBA, "Toshiba", &toshiba_nand_manuf_ops},
 	{NAND_MFR_WINBOND, "Winbond"},
 };
 
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index efb2345359bb..ca134851d211 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -1541,12 +1541,12 @@ nand_manufacturer_name(const struct nand_manufacturer *manufacturer)
 
 extern struct nand_flash_dev nand_flash_ids[];
 
-extern const struct nand_manufacturer_ops toshiba_nand_manuf_ops;
-extern const struct nand_manufacturer_ops samsung_nand_manuf_ops;
-extern const struct nand_manufacturer_ops hynix_nand_manuf_ops;
-extern const struct nand_manufacturer_ops micron_nand_manuf_ops;
 extern const struct nand_manufacturer_ops amd_nand_manuf_ops;
+extern const struct nand_manufacturer_ops hynix_nand_manuf_ops;
 extern const struct nand_manufacturer_ops macronix_nand_manuf_ops;
+extern const struct nand_manufacturer_ops micron_nand_manuf_ops;
+extern const struct nand_manufacturer_ops samsung_nand_manuf_ops;
+extern const struct nand_manufacturer_ops toshiba_nand_manuf_ops;
 
 int nand_create_bbt(struct nand_chip *chip);
 int nand_markbad_bbt(struct mtd_info *mtd, loff_t offs);
-- 
2.14.4

