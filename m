Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC8ABC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74F3F20825
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="O+2ttCRG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74F3F20825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729455AbeKEVZ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 16:25:26 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:52048 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727128AbeKEVZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 16:25:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=P+W+mdCCTwXDOhlEV24zZ+3gD5JLHPQtrJbfwsYlmcU=; b=O+2ttCRGZhl6
        KrzuE9mTxisBUvICIxLcWLMAFg+km9o8yhFXgJUsw+ILsNEjm2iQ1KSwMkxWzeDE4UEziPHDJtImP
        d5ERCmc2S+2UKgJCw0NxSBNGvCiJDb4BaLTaGPA6BG1hkWliEqwHFUhbIQZBZ6U/uEo7RLJAuEAvF
        wAuhA=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gJddf-0008Lt-Kg; Mon, 05 Nov 2018 12:05:51 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 59AF31124D98; Mon,  5 Nov 2018 12:05:51 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Leilk Liu <leilk.liu@mediatek.com>
Cc:     Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-spi@vger.kernel.org
Subject: Applied "spi: mediatek: add spi support for mt8183 IC" to the spi tree
In-Reply-To:  <1541052139-8845-3-git-send-email-leilk.liu@mediatek.com>
Message-Id: <20181105120551.59AF31124D98@debutante.sirena.org.uk>
Date:   Mon,  5 Nov 2018 12:05:51 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: mediatek: add spi support for mt8183 IC

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From b654aa6f2bbb00508ea0abc1cdc98ba8baa13682 Mon Sep 17 00:00:00 2001
From: Leilk Liu <leilk.liu@mediatek.com>
Date: Thu, 1 Nov 2018 14:02:19 +0800
Subject: [PATCH] spi: mediatek: add spi support for mt8183 IC

this patch add support for mt8183 IC.

Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-mt65xx.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 3dc31627c655..f3119d82150e 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -120,6 +120,12 @@ static const struct mtk_spi_compatible mt8173_compat = {
 	.must_tx = true,
 };
 
+static const struct mtk_spi_compatible mt8183_compat = {
+	.need_pad_sel = true,
+	.must_tx = true,
+	.enhance_timing = true,
+};
+
 /*
  * A piece of default chip info unless the platform
  * supplies it.
@@ -150,6 +156,9 @@ static const struct of_device_id mtk_spi_of_match[] = {
 	{ .compatible = "mediatek,mt8173-spi",
 		.data = (void *)&mt8173_compat,
 	},
+	{ .compatible = "mediatek,mt8183-spi",
+		.data = (void *)&mt8183_compat,
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, mtk_spi_of_match);
-- 
2.19.0.rc2

