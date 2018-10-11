Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA29AC4161D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 14:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0C352085B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 14:56:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="tOfOck3q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0C352085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728723AbeJKWYE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 18:24:04 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47004 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727363AbeJKWYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 18:24:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=wmPjRwxT+sX42nx0hJ3+zGxMJnlYCx4eqAWVzH8Sk/o=; b=tOfOck3qaAhi
        Ih584BfwVd/R5fu1M9E/i+OILyflNDcjWsVVNCR1+/hQ30X9cBldTOZp906D8ttwBOaSDyQgDqS1s
        3ccgEwVsAh0qNVQP/t5FUnIAiybhj57aaFWe+lppGhDO59WxpWg3hCiHVzr8VHQKi1Q/H5wu2bgAr
        fiG4I=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gAcNo-0001tO-57; Thu, 11 Oct 2018 14:56:12 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id E2B9B11223ED; Thu, 11 Oct 2018 15:56:11 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Huibin Hong <huibin.hong@rock-chips.com>
Cc:     Emil Renner Berthing <kernel@esmil.dk>,
        Mark Brown <broonie@kernel.org>,
        linux-rockchip@lists.infradead.org,
        Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Mark Brown <broonie@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        Nickey Yang <nickey.yang@rock-chips.com>,
        Klaus Goger <klaus.goger@theobroma-systems.com>,
        Randy Li <ayaka@soulik.info>, Chris Zhong <zyw@rock-chips.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Applied "spi: rockchip: initialize dma_slave_config properly" to the spi tree
In-Reply-To:  <20181010090038.20834-2-kernel@esmil.dk>
Message-Id: <20181011145611.E2B9B11223ED@debutante.sirena.org.uk>
Date:   Thu, 11 Oct 2018 15:56:11 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: rockchip: initialize dma_slave_config properly

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

From dd8fd2cbc73f8650f651da71fc61a6e4f30c1566 Mon Sep 17 00:00:00 2001
From: Huibin Hong <huibin.hong@rock-chips.com>
Date: Wed, 10 Oct 2018 11:00:32 +0200
Subject: [PATCH] spi: rockchip: initialize dma_slave_config properly

The rxconf and txconf structs are allocated on the
stack, so make sure we zero them before filling out
the relevant fields.

Signed-off-by: Huibin Hong <huibin.hong@rock-chips.com>
Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-rockchip.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index fdcf3076681b..185bbdce62b1 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -445,6 +445,9 @@ static int rockchip_spi_prepare_dma(struct rockchip_spi *rs)
 	struct dma_slave_config rxconf, txconf;
 	struct dma_async_tx_descriptor *rxdesc, *txdesc;
 
+	memset(&rxconf, 0, sizeof(rxconf));
+	memset(&txconf, 0, sizeof(txconf));
+
 	spin_lock_irqsave(&rs->lock, flags);
 	rs->state &= ~RXBUSY;
 	rs->state &= ~TXBUSY;
-- 
2.19.0.rc2

