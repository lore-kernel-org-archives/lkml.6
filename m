Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 814BCC5CFC0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 01:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F85D20693
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 01:20:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="ztJHRBJV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F85D20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965144AbeFOBUb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 21:20:31 -0400
Received: from conuserg-08.nifty.com ([210.131.2.75]:27010 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965001AbeFOBU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 21:20:29 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id w5F1IuMM005465;
        Fri, 15 Jun 2018 10:18:59 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com w5F1IuMM005465
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1529025539;
        bh=6+iHk+x2dWO+Qd/UgvvhTtWHsBi6GstNKr7N04OKinM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ztJHRBJVke2gvzj1MsmyWVKd+UrVxKqNiM39Rswfgf9pcjPlK4S9ydSRL5Qjexw17
         2ydgotSl/s7GmD8beOmhsRg/GKoCrp9VCW30pkRmxCH5MheciXlCFJHD6FfxJMO9Hn
         Cb42ZOt//52QeBQ6uo26O5zvDRif5E/1hmqAyytTRjZFRWQtIFIQ0TwySbIZeSc2fZ
         xCcs31UEeVhMkkUH8GdEwcwmbU6BbzLwJOMDPlQBY8XkSlKXZOkFbWdydcHoQAxvER
         TLJBWZrbeL9UBNbh6j6/qelNAtO5RfGpZHGd4931DB7ZucOi4AXPYygwl2PgGNEElE
         W99ygDZV3Q8GA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-mtd@lists.infradead.org,
        Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kbuild@vger.kernel.org,
        Richard Weinberger <richard@nod.at>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH v3 2/3] mtd: rawnand: denali_dt: use dev as a shorthand of &pdev->dev
Date:   Fri, 15 Jun 2018 10:18:51 +0900
Message-Id: <1529025532-22087-3-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529025532-22087-1-git-send-email-yamada.masahiro@socionext.com>
References: <1529025532-22087-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The probe function references &pdev->dev many times.  Add 'dev' as
a shorthand.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v3: None
Changes in v2: None

 drivers/mtd/nand/raw/denali_dt.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/mtd/nand/raw/denali_dt.c b/drivers/mtd/nand/raw/denali_dt.c
index ce6239d..afaae37 100644
--- a/drivers/mtd/nand/raw/denali_dt.c
+++ b/drivers/mtd/nand/raw/denali_dt.c
@@ -81,38 +81,39 @@ MODULE_DEVICE_TABLE(of, denali_nand_dt_ids);
 
 static int denali_dt_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct resource *res;
 	struct denali_dt *dt;
 	const struct denali_dt_data *data;
 	struct denali_nand_info *denali;
 	int ret;
 
-	dt = devm_kzalloc(&pdev->dev, sizeof(*dt), GFP_KERNEL);
+	dt = devm_kzalloc(dev, sizeof(*dt), GFP_KERNEL);
 	if (!dt)
 		return -ENOMEM;
 	denali = &dt->denali;
 
-	data = of_device_get_match_data(&pdev->dev);
+	data = of_device_get_match_data(dev);
 	if (data) {
 		denali->revision = data->revision;
 		denali->caps = data->caps;
 		denali->ecc_caps = data->ecc_caps;
 	}
 
-	denali->dev = &pdev->dev;
+	denali->dev = dev;
 	denali->irq = platform_get_irq(pdev, 0);
 	if (denali->irq < 0) {
-		dev_err(&pdev->dev, "no irq defined\n");
+		dev_err(dev, "no irq defined\n");
 		return denali->irq;
 	}
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "denali_reg");
-	denali->reg = devm_ioremap_resource(&pdev->dev, res);
+	denali->reg = devm_ioremap_resource(dev, res);
 	if (IS_ERR(denali->reg))
 		return PTR_ERR(denali->reg);
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "nand_data");
-	denali->host = devm_ioremap_resource(&pdev->dev, res);
+	denali->host = devm_ioremap_resource(dev, res);
 	if (IS_ERR(denali->host))
 		return PTR_ERR(denali->host);
 
@@ -120,19 +121,19 @@ static int denali_dt_probe(struct platform_device *pdev)
 	 * A single anonymous clock is supported for the backward compatibility.
 	 * New platforms should support all the named clocks.
 	 */
-	dt->clk = devm_clk_get(&pdev->dev, "nand");
+	dt->clk = devm_clk_get(dev, "nand");
 	if (IS_ERR(dt->clk))
-		dt->clk = devm_clk_get(&pdev->dev, NULL);
+		dt->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(dt->clk)) {
-		dev_err(&pdev->dev, "no clk available\n");
+		dev_err(dev, "no clk available\n");
 		return PTR_ERR(dt->clk);
 	}
 
-	dt->clk_x = devm_clk_get(&pdev->dev, "nand_x");
+	dt->clk_x = devm_clk_get(dev, "nand_x");
 	if (IS_ERR(dt->clk_x))
 		dt->clk_x = NULL;
 
-	dt->clk_ecc = devm_clk_get(&pdev->dev, "ecc");
+	dt->clk_ecc = devm_clk_get(dev, "ecc");
 	if (IS_ERR(dt->clk_ecc))
 		dt->clk_ecc = NULL;
 
@@ -155,7 +156,7 @@ static int denali_dt_probe(struct platform_device *pdev)
 		 * Hardcode the clock rates for the backward compatibility.
 		 * This works for both SOCFPGA and UniPhier.
 		 */
-		dev_notice(&pdev->dev,
+		dev_notice(dev,
 			   "necessary clock is missing. default clock rates are used.\n");
 		denali->clk_x_rate = 200000000;
 	}
-- 
2.7.4

