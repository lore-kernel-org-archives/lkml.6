Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E8A3ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 23:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BF7B20661
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 23:57:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sPwlnCuf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BF7B20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731112AbeGSAhS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 20:37:18 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:36768 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730813AbeGSAhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 20:37:17 -0400
Received: by mail-lf0-f67.google.com with SMTP id b22-v6so4704783lfa.3;
        Wed, 18 Jul 2018 16:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7UpVQKmbNqgcoYX7beG5QsOge6J6prdHCDj6n9vqTZM=;
        b=sPwlnCuf03EeIomuZl/nufBkir6j6bl5mxtOPupoxRmP6bLExqbnQsBW91SxU/HawO
         VVEGvQqiWU7qSYVYd5t/5F0UJs+AvWl9vfOhMOw6TBLRWP48F1Dx0QZ7pK56Qa+qd23A
         QT4+hIU/Zi1CsD1SVP5ddaJyPxtE7HNO9OSBMdh7hQMEhVBx6hWxIOivd84EgqKo3npq
         3NbofxiCXupZLDwYU2DcUwNOuYpxxlX6w5MKi4tXe5TOqM0kqUDPMXeRnNnoxz42vehq
         4DbZQ5XlFU+qxUVS+Jnfpzff+2B2POqw9a/3npneREuRpEMw+2byDikDhOpo+IFzSuvK
         dgIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7UpVQKmbNqgcoYX7beG5QsOge6J6prdHCDj6n9vqTZM=;
        b=S/tAIoIoaHjwyZ6Vurt+JklYAr8AC/f2R08+4YTjUNEjMH/L2MS6hT8mb+NjwSA/h9
         dcby0cvEtdOlnmyzh0CSraJUxC8kLQ/nzH4k3m9CdbBKKRAF5z0hKrJaBIOv5AGFG8kC
         8YqoPjaqwZoIEa3kbepK78AxwfxOzBiYV/BAHw9fd9+JkYvCLjc6PJlFDwiel3BARJYr
         +kzBwos9H/zOXlYEbHGmflYlABRU6CZZFZBKlLDSjmGOiJm9U6l2rFqt+6UFB1tvr3xf
         F+WUHSPhD/CgNQrzrkYUZzF1AR6ZklCtVi8J6qTdr822RL3ZjqZZrDwBVBQmA/XGkQ/s
         9lqw==
X-Gm-Message-State: AOUpUlHISs3r7XZmMkESA+OKHelMMMJTexbJTNtGvcaVyQu6Hz0YM5ZS
        Mz0yeerdPI4Sj3WaBglvAVg=
X-Google-Smtp-Source: AAOMgpdbtSiftXIk6ZWvWrBkBY16OasqkjudQFzoX/3IplArXFK63OCbkh8yrSXhIN6KViYM+ewWkA==
X-Received: by 2002:a19:1586:: with SMTP id 6-v6mr4910327lfv.51.1531958216950;
        Wed, 18 Jul 2018 16:56:56 -0700 (PDT)
Received: from z50.lan (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id h7-v6sm826584ljk.27.2018.07.18.16.56.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 16:56:56 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [RFC PATCH 5/8] mtd: rawnand: ams-delta: Request data port GPIO resource
Date:   Thu, 19 Jul 2018 01:57:07 +0200
Message-Id: <20180718235710.18242-6-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180718235710.18242-1-jmkrzyszt@gmail.com>
References: <20180718235710.18242-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Data port used by the driver is actually an OMAP MPUIO device, already
under control of gpio-omap driver.  For that reason we used to not
request the memory region of the port as that would fail because the
region is already busy.  Despite that, we are still accessing the port
by just ioremapping it and performing read/write operations.  Moreover,
we are doing that without any proteciton from other users legally
manipulating the port pins over GPIO API.

The plan is to convert the driver to access the port over functions
exposed by the gpio-omap driver.  Before that happens, we can already
obtain exclusive access to the port by requesting an array of its GPIO
descriptors.  For that to work on Amstrad Delta, respective GPIO lookup
table entries are added to the board init file.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
 arch/arm/mach-omap1/board-ams-delta.c | 11 ++++++++++-
 drivers/mtd/nand/raw/ams-delta.c      |  8 ++++++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index eedacdfe9725..16f7bbe47607 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -337,7 +337,8 @@ static struct platform_device ams_delta_nand_device = {
 	.resource	= ams_delta_nand_resources,
 };
 
-#define OMAP_GPIO_LABEL	"gpio-0-15"
+#define OMAP_GPIO_LABEL		"gpio-0-15"
+#define OMAP_MPUIO_LABEL	"mpuio"
 
 static struct gpiod_lookup_table ams_delta_nand_gpio_table = {
 	.table = {
@@ -349,6 +350,14 @@ static struct gpiod_lookup_table ams_delta_nand_gpio_table = {
 		GPIO_LOOKUP(LATCH2_LABEL, LATCH2_PIN_NAND_NWE, "nwe", 0),
 		GPIO_LOOKUP(LATCH2_LABEL, LATCH2_PIN_NAND_ALE, "ale", 0),
 		GPIO_LOOKUP(LATCH2_LABEL, LATCH2_PIN_NAND_CLE, "cle", 0),
+		GPIO_LOOKUP_IDX(OMAP_MPUIO_LABEL, 0, "data", 0, 0),
+		GPIO_LOOKUP_IDX(OMAP_MPUIO_LABEL, 1, "data", 1, 0),
+		GPIO_LOOKUP_IDX(OMAP_MPUIO_LABEL, 2, "data", 2, 0),
+		GPIO_LOOKUP_IDX(OMAP_MPUIO_LABEL, 3, "data", 3, 0),
+		GPIO_LOOKUP_IDX(OMAP_MPUIO_LABEL, 4, "data", 4, 0),
+		GPIO_LOOKUP_IDX(OMAP_MPUIO_LABEL, 5, "data", 5, 0),
+		GPIO_LOOKUP_IDX(OMAP_MPUIO_LABEL, 6, "data", 6, 0),
+		GPIO_LOOKUP_IDX(OMAP_MPUIO_LABEL, 7, "data", 7, 0),
 		{ },
 	},
 };
diff --git a/drivers/mtd/nand/raw/ams-delta.c b/drivers/mtd/nand/raw/ams-delta.c
index d7e4c9dbef67..ad62c0245458 100644
--- a/drivers/mtd/nand/raw/ams-delta.c
+++ b/drivers/mtd/nand/raw/ams-delta.c
@@ -189,6 +189,7 @@ static int ams_delta_init(struct platform_device *pdev)
 	struct mtd_info *mtd;
 	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	void __iomem *io_base;
+	struct gpio_descs *data_gpiods;
 	int err = 0;
 
 	if (!res)
@@ -289,6 +290,13 @@ static int ams_delta_init(struct platform_device *pdev)
 		dev_err(&pdev->dev, "CLE GPIO request failed (%d)\n", err);
 		goto out_mtd;
 	}
+	/* Request array of data pins, initialize them as output and set low */
+	data_gpiods = devm_gpiod_get_array(&pdev->dev, "data", GPIOD_OUT_LOW);
+	if (IS_ERR(data_gpiods)) {
+		err = PTR_ERR(data_gpiods);
+		dev_err(&pdev->dev, "data GPIO request failed: %d\n", err);
+		goto out_mtd;
+	}
 
 	/* Scan to find existence of the device */
 	err = nand_scan(mtd, 1);
-- 
2.16.4

