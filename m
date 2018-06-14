Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 97D67C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 05:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 449D3208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 05:13:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="z6BgS8OH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 449D3208CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752792AbeFNFNN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 01:13:13 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:64794 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752681AbeFNFNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 01:13:11 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id w5E5BB4c003441;
        Thu, 14 Jun 2018 14:11:13 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com w5E5BB4c003441
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1528953074;
        bh=6zjCqH2/niUWhUqhnX5ee0MSTNWgyn0kUe8iu0jnQPU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z6BgS8OH5DSrPToX1BHq86OzxFhnw8BCXYFuWu7qpMybpEeAP5SYL90V2lvtwn4Jk
         5ALyM1rLp4zOqq6Zt3mHpeCuGAXH5CiXSE2mytStgnKBU6652Ts/ev/D3KkAdXnLyN
         t0ElTicMtjKvgkitY+55Om4GVBq/yoGG/ywjoPwvKChtb68aC5M6mVfCPY4htGJdTL
         /wMJTM2cuA3PYOmpG5MFc5FTTk8X88d/RYJjRvbZ6/osm9N5R0kEAELVRpLAHcOhWm
         E1ymWihDDEVaWiPQcIMWN2xTASHBhCMo89VMxsY8I/fZiFL++Ot+2IMbEimvxs38Zm
         hUFTkADyfDduQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-mtd@lists.infradead.org,
        Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Richard Weinberger <richard@sigma-star.at>,
        Philipp Rosenberger <p.rosenberger@linutronix.de>,
        Rob Herring <robh@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH v2 1/3] mtd: rawnand: denali_dt: use dev as a shorthand of &pdev->dev
Date:   Thu, 14 Jun 2018 14:11:05 +0900
Message-Id: <1528953067-24324-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528953067-24324-1-git-send-email-yamada.masahiro@socionext.com>
References: <1528953067-24324-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add 'dev' as a shorthand before adding more code that takes a
pointer to struce device.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2: None

 drivers/mtd/nand/raw/denali_dt.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/mtd/nand/raw/denali_dt.c b/drivers/mtd/nand/raw/denali_dt.c
index cfd33e6..d923cfa 100644
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

