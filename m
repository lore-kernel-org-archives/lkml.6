Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08079C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 19:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9940220870
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 19:38:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j/4v1nME"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9940220870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754583AbeGITiv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 15:38:51 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35928 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754520AbeGITit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 15:38:49 -0400
Received: by mail-lj1-f196.google.com with SMTP id u7-v6so12320446lji.3;
        Mon, 09 Jul 2018 12:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QjTJinG9uSoHys0gClBjknBw4ENXg0T+FFSfsNaMQmQ=;
        b=j/4v1nMEiQ/jApomsrslU4MoL1jcXWXkua/iQYSFvvjn7qcHgK4mrkgEjM+jMbituJ
         W9NOHHZQs+fKeU/DwtTarS83hS5P+g9jXVu9+74gwNdZ/8Ew0DFflKRU5TUnwhRb9wCh
         nhNJrftPVAqmtyLaME7qTNDsZurstOnKK9JGLZ0nVY6xTTBDe5N3Hx8cG6s/CW7Ztxcl
         NDL9J+BDcTBG3SMXXe1K6aWMpL5UVSdIry0ZNKuTbVKXotv2JdH38iT8huQqBhIk1C19
         iP+2tBwaHUxt4/WgYjhFN8K1Zxl+enlx1vl+HYgmHkdiyqQfiHadkGE7V6mDlgAfoXLZ
         8W6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QjTJinG9uSoHys0gClBjknBw4ENXg0T+FFSfsNaMQmQ=;
        b=PMYL69SW5imLvgG+ixsXFBMaYhVuqiZ7o28bhJeSHRAB1Dg/1WFdL93oImGQyGORGS
         hIzNgziET5goV//IyUmklfvCmiNmYCxvpWsSEn8SeKdcowqe5bGmM3c+Iev0P13zfvq9
         HT6kmUI0D4tOauzjX4gSrUeVq/hZ0Q1gW/RCZNeLopas0VxOdmtLIe+zEpHz63CLqhhc
         p9hhsk+FfgXjVdwaWChbwFMVZca8s0FkVZPQ087+ybhhv/B3/pZFtLFV5WMvSPs+edvM
         5dg/Y2s+b8txStCOvsP6THS5X3AuTwT/PPHh+qgyYwsO1+8afFxvrpGOv4HIpAtajLWR
         ZNeQ==
X-Gm-Message-State: APt69E05zZaNjDLS8P7aP6qFs97ANA3GibbOLMVFc5G7EZyR5tHYtYru
        XCAeei7iv8gdzArXnJ6Kf14=
X-Google-Smtp-Source: AAOMgpcTLdqnCryYdNHy9i2+czoxAgpdBpAfn1SDGwxiNl2C0nKgUag7iz/OLgIBuHqKrnNazu+HWw==
X-Received: by 2002:a2e:5687:: with SMTP id k7-v6mr13164914lje.105.1531165127503;
        Mon, 09 Jul 2018 12:38:47 -0700 (PDT)
Received: from z50.lan (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id l20-v6sm4279014lfg.14.2018.07.09.12.38.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 12:38:46 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Shreeya Patel <shreeya.patel23498@gmail.com>,
        Arvind Yadav <arvind.yadav.cs@gmail.com>,
        linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH v3] mtd: rawnand: ams-delta: use GPIO lookup table
Date:   Mon,  9 Jul 2018 21:38:50 +0200
Message-Id: <20180709193850.20191-1-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180525222046.11200-1-jmkrzyszt@gmail.com>
References: <20180525222046.11200-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now as Amstrad Delta board - the only user of this driver - provides
GPIO lookup tables, switch from GPIO numbers to GPIO descriptors and
use the table to locate required GPIO pins.

Declare static variables for storing GPIO descriptors and replace
gpio_ function calls with their gpiod_ equivalents.

Pin naming used by the driver should be followed while respective GPIO
lookup table is initialized by a board init code.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
Changlog:
v1: Fix handling of devm_gpiod_get_optional() return values - thanks to
    Andy Shevchenko.
v2: Remove problematic error code conversion, no longer needed if used
    on top of commit d08605a64e67 ("ARM: OMAP1: ams-delta: move late
    devices back to init_machine") already in linux-next and commit
    8853daf3b4ac ("gpiolib: Defer on non-DT find_chip_by_name()
    failure") just applied to linux-gpio/devel.

 drivers/mtd/nand/raw/ams-delta.c | 121 ++++++++++++++++++++-------------------
 1 file changed, 62 insertions(+), 59 deletions(-)

diff --git a/drivers/mtd/nand/raw/ams-delta.c b/drivers/mtd/nand/raw/ams-delta.c
index 37a3cc21c7bc..09b2f9fda5b9 100644
--- a/drivers/mtd/nand/raw/ams-delta.c
+++ b/drivers/mtd/nand/raw/ams-delta.c
@@ -20,23 +20,28 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/delay.h>
+#include <linux/gpio/consumer.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/rawnand.h>
 #include <linux/mtd/partitions.h>
-#include <linux/gpio.h>
 #include <linux/platform_data/gpio-omap.h>
 
 #include <asm/io.h>
 #include <asm/sizes.h>
 
-#include <mach/board-ams-delta.h>
-
 #include <mach/hardware.h>
 
 /*
  * MTD structure for E3 (Delta)
  */
 static struct mtd_info *ams_delta_mtd = NULL;
+static struct gpio_desc *gpiod_rdy;
+static struct gpio_desc *gpiod_nce;
+static struct gpio_desc *gpiod_nre;
+static struct gpio_desc *gpiod_nwp;
+static struct gpio_desc *gpiod_nwe;
+static struct gpio_desc *gpiod_ale;
+static struct gpio_desc *gpiod_cle;
 
 /*
  * Define partitions for flash devices
@@ -70,9 +75,9 @@ static void ams_delta_write_byte(struct mtd_info *mtd, u_char byte)
 
 	writew(0, io_base + OMAP_MPUIO_IO_CNTL);
 	writew(byte, this->IO_ADDR_W);
-	gpio_set_value(AMS_DELTA_GPIO_PIN_NAND_NWE, 0);
+	gpiod_set_value(gpiod_nwe, 0);
 	ndelay(40);
-	gpio_set_value(AMS_DELTA_GPIO_PIN_NAND_NWE, 1);
+	gpiod_set_value(gpiod_nwe, 1);
 }
 
 static u_char ams_delta_read_byte(struct mtd_info *mtd)
@@ -81,11 +86,11 @@ static u_char ams_delta_read_byte(struct mtd_info *mtd)
 	struct nand_chip *this = mtd_to_nand(mtd);
 	void __iomem *io_base = (void __iomem *)nand_get_controller_data(this);
 
-	gpio_set_value(AMS_DELTA_GPIO_PIN_NAND_NRE, 0);
+	gpiod_set_value(gpiod_nre, 0);
 	ndelay(40);
 	writew(~0, io_base + OMAP_MPUIO_IO_CNTL);
 	res = readw(this->IO_ADDR_R);
-	gpio_set_value(AMS_DELTA_GPIO_PIN_NAND_NRE, 1);
+	gpiod_set_value(gpiod_nre, 1);
 
 	return res;
 }
@@ -120,12 +125,9 @@ static void ams_delta_hwcontrol(struct mtd_info *mtd, int cmd,
 {
 
 	if (ctrl & NAND_CTRL_CHANGE) {
-		gpio_set_value(AMS_DELTA_GPIO_PIN_NAND_NCE,
-				(ctrl & NAND_NCE) == 0);
-		gpio_set_value(AMS_DELTA_GPIO_PIN_NAND_CLE,
-				(ctrl & NAND_CLE) != 0);
-		gpio_set_value(AMS_DELTA_GPIO_PIN_NAND_ALE,
-				(ctrl & NAND_ALE) != 0);
+		gpiod_set_value(gpiod_nce, !(ctrl & NAND_NCE));
+		gpiod_set_value(gpiod_cle, !!(ctrl & NAND_CLE));
+		gpiod_set_value(gpiod_ale, !!(ctrl & NAND_ALE));
 	}
 
 	if (cmd != NAND_CMD_NONE)
@@ -134,41 +136,9 @@ static void ams_delta_hwcontrol(struct mtd_info *mtd, int cmd,
 
 static int ams_delta_nand_ready(struct mtd_info *mtd)
 {
-	return gpio_get_value(AMS_DELTA_GPIO_PIN_NAND_RB);
+	return gpiod_get_value(gpiod_rdy);
 }
 
-static const struct gpio _mandatory_gpio[] = {
-	{
-		.gpio	= AMS_DELTA_GPIO_PIN_NAND_NCE,
-		.flags	= GPIOF_OUT_INIT_HIGH,
-		.label	= "nand_nce",
-	},
-	{
-		.gpio	= AMS_DELTA_GPIO_PIN_NAND_NRE,
-		.flags	= GPIOF_OUT_INIT_HIGH,
-		.label	= "nand_nre",
-	},
-	{
-		.gpio	= AMS_DELTA_GPIO_PIN_NAND_NWP,
-		.flags	= GPIOF_OUT_INIT_HIGH,
-		.label	= "nand_nwp",
-	},
-	{
-		.gpio	= AMS_DELTA_GPIO_PIN_NAND_NWE,
-		.flags	= GPIOF_OUT_INIT_HIGH,
-		.label	= "nand_nwe",
-	},
-	{
-		.gpio	= AMS_DELTA_GPIO_PIN_NAND_ALE,
-		.flags	= GPIOF_OUT_INIT_LOW,
-		.label	= "nand_ale",
-	},
-	{
-		.gpio	= AMS_DELTA_GPIO_PIN_NAND_CLE,
-		.flags	= GPIOF_OUT_INIT_LOW,
-		.label	= "nand_cle",
-	},
-};
 
 /*
  * Main initialization routine
@@ -216,12 +186,17 @@ static int ams_delta_init(struct platform_device *pdev)
 	this->write_buf = ams_delta_write_buf;
 	this->read_buf = ams_delta_read_buf;
 	this->cmd_ctrl = ams_delta_hwcontrol;
-	if (gpio_request(AMS_DELTA_GPIO_PIN_NAND_RB, "nand_rdy") == 0) {
-		this->dev_ready = ams_delta_nand_ready;
-	} else {
-		this->dev_ready = NULL;
-		pr_notice("Couldn't request gpio for Delta NAND ready.\n");
+
+	gpiod_rdy = devm_gpiod_get_optional(&pdev->dev, "rdy", GPIOD_IN);
+	if (IS_ERR(gpiod_rdy)) {
+		err = PTR_ERR(gpiod_rdy);
+		dev_warn(&pdev->dev, "RDY GPIO request failed (%d)\n", err);
+		goto out_mtd;
 	}
+
+	if (gpiod_rdy)
+		this->dev_ready = ams_delta_nand_ready;
+
 	/* 25 us command delay time */
 	this->chip_delay = 30;
 	this->ecc.mode = NAND_ECC_SOFT;
@@ -230,9 +205,42 @@ static int ams_delta_init(struct platform_device *pdev)
 	platform_set_drvdata(pdev, io_base);
 
 	/* Set chip enabled, but  */
-	err = gpio_request_array(_mandatory_gpio, ARRAY_SIZE(_mandatory_gpio));
-	if (err)
-		goto out_gpio;
+	gpiod_nwp = devm_gpiod_get(&pdev->dev, "nwp", GPIOD_OUT_HIGH);
+	if (IS_ERR(gpiod_nwp)) {
+		err = PTR_ERR(gpiod_nwp);
+		dev_err(&pdev->dev, "NWP GPIO request failed (%d)\n", err);
+		goto out_mtd;
+	}
+	gpiod_nce = devm_gpiod_get(&pdev->dev, "nce", GPIOD_OUT_HIGH);
+	if (IS_ERR(gpiod_nce)) {
+		err = PTR_ERR(gpiod_nce);
+		dev_err(&pdev->dev, "NCE GPIO request failed (%d)\n", err);
+		goto out_mtd;
+	}
+	gpiod_nre = devm_gpiod_get(&pdev->dev, "nre", GPIOD_OUT_HIGH);
+	if (IS_ERR(gpiod_nre)) {
+		err = PTR_ERR(gpiod_nre);
+		dev_err(&pdev->dev, "NRE GPIO request failed (%d)\n", err);
+		goto out_mtd;
+	}
+	gpiod_nwe = devm_gpiod_get(&pdev->dev, "nwe", GPIOD_OUT_HIGH);
+	if (IS_ERR(gpiod_nwe)) {
+		err = PTR_ERR(gpiod_nwe);
+		dev_err(&pdev->dev, "NWE GPIO request failed (%d)\n", err);
+		goto out_mtd;
+	}
+	gpiod_ale = devm_gpiod_get(&pdev->dev, "ale", GPIOD_OUT_LOW);
+	if (IS_ERR(gpiod_ale)) {
+		err = PTR_ERR(gpiod_ale);
+		dev_err(&pdev->dev, "ALE GPIO request failed (%d)\n", err);
+		goto out_mtd;
+	}
+	gpiod_cle = devm_gpiod_get(&pdev->dev, "cle", GPIOD_OUT_LOW);
+	if (IS_ERR(gpiod_cle)) {
+		err = PTR_ERR(gpiod_cle);
+		dev_err(&pdev->dev, "CLE GPIO request failed (%d)\n", err);
+		goto out_mtd;
+	}
 
 	/* Scan to find existence of the device */
 	err = nand_scan(ams_delta_mtd, 1);
@@ -246,9 +254,6 @@ static int ams_delta_init(struct platform_device *pdev)
 	goto out;
 
  out_mtd:
-	gpio_free_array(_mandatory_gpio, ARRAY_SIZE(_mandatory_gpio));
-out_gpio:
-	gpio_free(AMS_DELTA_GPIO_PIN_NAND_RB);
 	iounmap(io_base);
 out_free:
 	kfree(this);
@@ -266,8 +271,6 @@ static int ams_delta_cleanup(struct platform_device *pdev)
 	/* Release resources, unregister device */
 	nand_release(ams_delta_mtd);
 
-	gpio_free_array(_mandatory_gpio, ARRAY_SIZE(_mandatory_gpio));
-	gpio_free(AMS_DELTA_GPIO_PIN_NAND_RB);
 	iounmap(io_base);
 
 	/* Free the MTD device structure */
-- 
2.16.4

