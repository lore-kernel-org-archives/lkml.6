Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB89ECE566
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8FEA21524
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:17:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UDwjh+Nh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8FEA21524
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733182AbeITD5n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 23:57:43 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34935 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728124AbeITD5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 23:57:42 -0400
Received: by mail-lf1-f67.google.com with SMTP id x20-v6so6549525lfg.2;
        Wed, 19 Sep 2018 15:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Xa8WBsY5qG1uqodTkxJSLMvFZ3M5Hdr4U4AdLrE7rSM=;
        b=UDwjh+NhXuw/SwtLDdOtYQB7qWAFQIhxN4EleEBnXxZowjJfpHiZ17eBu08vwQbGjM
         Ae5XUQeTOdevWU9Olz0QJfzYeCbP1lsrHFAcjmudmY6asNkBkSYPpg7kyDQq77TSklou
         Z/VUo11lFYa5e5Vcn6fF3qFrXJLFUH39m8yMeyhUa8CZ/tRE8gzeEyuyoLbxcdpvGrS1
         l4kTCmTzlAfhdZX2wvtHptGZACYo1KcsdmBDqDad/S+qx7t9Z/Ge849cRJWmhoKcbqlM
         I5dVB6UdWIhZRWW2PhPdlnyLpMbX9nvXm220oM/7VAB0e4DsZZXsiPXusa2ZgGXm1R7Z
         UOCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Xa8WBsY5qG1uqodTkxJSLMvFZ3M5Hdr4U4AdLrE7rSM=;
        b=O/0cGdOzjvEHC4Vk5r2FRyH9F7ppd3VK7kbXE5/aqdwvfOKSKbGBdwlJy14axFGS9Y
         GxBxkKT2ke+BE4y0gRUPOwjubGkjtlKIR5UYzKWE6TueD3m1xTuoQFT6TEGamS/DyqlD
         E2OPTn1twcQ7eOkA3CHcFFeXFn2Mr2lIftwIaRZyeDhEwjBdrpctwaxgWUNYQZmin8K1
         lgkZKyiMCQK0iQunJ4kcRWZTm7iCnNemzihfc2U6x9Oe+MRVJcru4tl/kNS7sFNbav9A
         qrNf3+9oREOHfGuVDNNhTNBmOltZahxz+tbtiU/JnJIXORQCPwufen8ivEdIfsLyGEXY
         ppCQ==
X-Gm-Message-State: APzg51D2SHkiCi5+/4R26vevHbVe2cA3XEiY0hZg7OtuSW1eb+Xj+pnx
        pIExbv1bUWndjc3XbVEAp3s=
X-Google-Smtp-Source: ANB0VdaMX1wHTZ/vwNhxHAmiRQDGyTkpuOJIzSTucjXQARX40r+rJmaWuI1P7tTwav8XWD/RlJD5Rg==
X-Received: by 2002:a19:aa52:: with SMTP id t79-v6mr25148061lfe.85.1537395460155;
        Wed, 19 Sep 2018 15:17:40 -0700 (PDT)
Received: from z50.lan (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id g11-v6sm4017501ljk.45.2018.09.19.15.17.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Sep 2018 15:17:39 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5] mtd: rawnand: ams-delta: use GPIO lookup table
Date:   Thu, 20 Sep 2018 00:17:29 +0200
Message-Id: <20180919221729.21179-1-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180909225605.16463-3-jmkrzyszt@gmail.com>
References: <20180909225605.16463-3-jmkrzyszt@gmail.com>
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
Acked-by: Boris Brezillon <boris.brezillon@bootlin.com>
Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
Changelog:
v5:
- rebased on nand/next
- resubmitted to linux-mtd as a stand-alone patch

v3 2/3:
- series rebased on top of v4.19-rc1
- added Acked-by: received from Miquel

v2 2/3 v4:
- fix style issue - thanks to Boris Brezillon
- resubmitted to linux-omap in a series

v3:
- remove problematic error code conversion no longer needed if used on
  top of commit d08605a64e67 ("ARM: OMAP1: ams-delta: move late devices
  back to init_machine") and commit 8853daf3b4ac ("gpiolib: Defer on
  non-DT find_chip_by_name() failure") already in linux-next - thanks
  to Boris Brezillon

v2:
- fix handling of devm_gpiod_get_optional() return values - thanks to
  Andy Shevchenko
- resubmitted to linux-mtd as a stand-alone patch

Originally submitted to linux-omap as "[PATCH 5/6] mtd: rawnand:
 ams-delta: use GPIO lookup table"

 drivers/mtd/nand/raw/ams-delta.c | 126 +++++++++++++++++++++------------------
 1 file changed, 67 insertions(+), 59 deletions(-)

diff --git a/drivers/mtd/nand/raw/ams-delta.c b/drivers/mtd/nand/raw/ams-delta.c
index 3d3786dcc5d1..a2d2dfc55984 100644
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
@@ -69,9 +74,9 @@ static void ams_delta_write_byte(struct nand_chip *this, u_char byte)
 
 	writew(0, io_base + OMAP_MPUIO_IO_CNTL);
 	writew(byte, this->legacy.IO_ADDR_W);
-	gpio_set_value(AMS_DELTA_GPIO_PIN_NAND_NWE, 0);
+	gpiod_set_value(gpiod_nwe, 0);
 	ndelay(40);
-	gpio_set_value(AMS_DELTA_GPIO_PIN_NAND_NWE, 1);
+	gpiod_set_value(gpiod_nwe, 1);
 }
 
 static u_char ams_delta_read_byte(struct nand_chip *this)
@@ -79,11 +84,11 @@ static u_char ams_delta_read_byte(struct nand_chip *this)
 	u_char res;
 	void __iomem *io_base = (void __iomem *)nand_get_controller_data(this);
 
-	gpio_set_value(AMS_DELTA_GPIO_PIN_NAND_NRE, 0);
+	gpiod_set_value(gpiod_nre, 0);
 	ndelay(40);
 	writew(~0, io_base + OMAP_MPUIO_IO_CNTL);
 	res = readw(this->legacy.IO_ADDR_R);
-	gpio_set_value(AMS_DELTA_GPIO_PIN_NAND_NRE, 1);
+	gpiod_set_value(gpiod_nre, 1);
 
 	return res;
 }
@@ -118,12 +123,9 @@ static void ams_delta_hwcontrol(struct nand_chip *this, int cmd,
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
@@ -132,41 +134,9 @@ static void ams_delta_hwcontrol(struct nand_chip *this, int cmd,
 
 static int ams_delta_nand_ready(struct nand_chip *this)
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
@@ -214,12 +184,17 @@ static int ams_delta_init(struct platform_device *pdev)
 	this->legacy.write_buf = ams_delta_write_buf;
 	this->legacy.read_buf = ams_delta_read_buf;
 	this->legacy.cmd_ctrl = ams_delta_hwcontrol;
-	if (gpio_request(AMS_DELTA_GPIO_PIN_NAND_RB, "nand_rdy") == 0) {
-		this->legacy.dev_ready = ams_delta_nand_ready;
-	} else {
-		this->legacy.dev_ready = NULL;
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
+		this->legacy.dev_ready = ams_delta_nand_ready;
+
 	/* 25 us command delay time */
 	this->legacy.chip_delay = 30;
 	this->ecc.mode = NAND_ECC_SOFT;
@@ -228,9 +203,47 @@ static int ams_delta_init(struct platform_device *pdev)
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
+
+	gpiod_nce = devm_gpiod_get(&pdev->dev, "nce", GPIOD_OUT_HIGH);
+	if (IS_ERR(gpiod_nce)) {
+		err = PTR_ERR(gpiod_nce);
+		dev_err(&pdev->dev, "NCE GPIO request failed (%d)\n", err);
+		goto out_mtd;
+	}
+
+	gpiod_nre = devm_gpiod_get(&pdev->dev, "nre", GPIOD_OUT_HIGH);
+	if (IS_ERR(gpiod_nre)) {
+		err = PTR_ERR(gpiod_nre);
+		dev_err(&pdev->dev, "NRE GPIO request failed (%d)\n", err);
+		goto out_mtd;
+	}
+
+	gpiod_nwe = devm_gpiod_get(&pdev->dev, "nwe", GPIOD_OUT_HIGH);
+	if (IS_ERR(gpiod_nwe)) {
+		err = PTR_ERR(gpiod_nwe);
+		dev_err(&pdev->dev, "NWE GPIO request failed (%d)\n", err);
+		goto out_mtd;
+	}
+
+	gpiod_ale = devm_gpiod_get(&pdev->dev, "ale", GPIOD_OUT_LOW);
+	if (IS_ERR(gpiod_ale)) {
+		err = PTR_ERR(gpiod_ale);
+		dev_err(&pdev->dev, "ALE GPIO request failed (%d)\n", err);
+		goto out_mtd;
+	}
+
+	gpiod_cle = devm_gpiod_get(&pdev->dev, "cle", GPIOD_OUT_LOW);
+	if (IS_ERR(gpiod_cle)) {
+		err = PTR_ERR(gpiod_cle);
+		dev_err(&pdev->dev, "CLE GPIO request failed (%d)\n", err);
+		goto out_mtd;
+	}
 
 	/* Scan to find existence of the device */
 	err = nand_scan(this, 1);
@@ -244,9 +257,6 @@ static int ams_delta_init(struct platform_device *pdev)
 	goto out;
 
  out_mtd:
-	gpio_free_array(_mandatory_gpio, ARRAY_SIZE(_mandatory_gpio));
-out_gpio:
-	gpio_free(AMS_DELTA_GPIO_PIN_NAND_RB);
 	iounmap(io_base);
 out_free:
 	kfree(this);
@@ -264,8 +274,6 @@ static int ams_delta_cleanup(struct platform_device *pdev)
 	/* Release resources, unregister device */
 	nand_release(mtd_to_nand(ams_delta_mtd));
 
-	gpio_free_array(_mandatory_gpio, ARRAY_SIZE(_mandatory_gpio));
-	gpio_free(AMS_DELTA_GPIO_PIN_NAND_RB);
 	iounmap(io_base);
 
 	/* Free the MTD device structure */
-- 
2.16.4

