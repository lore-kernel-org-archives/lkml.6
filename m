Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C32C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 16:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99BC824580
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 16:08:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="FYLHJJGM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99BC824580
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934140AbeFVQIT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 12:08:19 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:30586 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933391AbeFVQIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 12:08:15 -0400
Received: from grover.sesame (FL1-125-199-20-195.osk.mesh.ad.jp [125.199.20.195]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id w5MG6m5c022587;
        Sat, 23 Jun 2018 01:06:50 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com w5MG6m5c022587
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1529683611;
        bh=v5vvfEGZMfiay+4sJMQnFpe/h/B2T8+PH26onq6v+BI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FYLHJJGMwHUfApoJm0g3k4Lu0FtrEKepenhM9lf4Xj4Vg9fnChQwCb8pq5n16IQ+R
         37E00XOd7Ol1YYzhdDSY40Ugjdesb1Tf+Ba0UezpQXoShOVKlbjvC/JTtmrJT0vXpi
         +4BRHtVVnewNhWNwO6tCuMfXfrzN0N/66Aebvrnpgxmc/d1uX5KYxkV2yshwX8ITO3
         2K4XfLLUKnlh5PuQ/HqYTivBZuVfCHBheE2sagcRxQCKkpn9DO6wqNucx0rCxVA9JW
         iW+b58LgUwswfvM3eYoSesWjnBRbOyR0hCp/0O3iyJb9MbUDtfSu4+x77rIcXJEYe0
         Btji844rZZk4A==
X-Nifty-SrcIP: [125.199.20.195]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-mtd@lists.infradead.org,
        Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH v4 2/5] mtd: rawnand: denali_dt: use dev as a shorthand of &pdev->dev
Date:   Sat, 23 Jun 2018 01:06:35 +0900
Message-Id: <1529683598-25783-3-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529683598-25783-1-git-send-email-yamada.masahiro@socionext.com>
References: <1529683598-25783-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The probe function references &pdev->dev many times, and I will add
more soon.  Add 'dev' as a shorthand.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Richard Weinberger <richard@nod.at>
Tested-by: Richard Weinberger <richard@nod.at>
Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>
---

Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/mtd/nand/raw/denali_dt.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/mtd/nand/raw/denali_dt.c b/drivers/mtd/nand/raw/denali_dt.c
index 5869e90..6b4bd16 100644
--- a/drivers/mtd/nand/raw/denali_dt.c
+++ b/drivers/mtd/nand/raw/denali_dt.c
@@ -79,44 +79,45 @@ MODULE_DEVICE_TABLE(of, denali_nand_dt_ids);
 
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
 
-	dt->clk = devm_clk_get(&pdev->dev, NULL);
+	dt->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(dt->clk)) {
-		dev_err(&pdev->dev, "no clk available\n");
+		dev_err(dev, "no clk available\n");
 		return PTR_ERR(dt->clk);
 	}
 	ret = clk_prepare_enable(dt->clk);
-- 
2.7.4

