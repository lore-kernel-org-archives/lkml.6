Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 307C3C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 10:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA9A420832
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 10:32:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="FEg2U7Zf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA9A420832
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbeJXTAK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 15:00:10 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41562 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbeJXTAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 15:00:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=bOKdDbizi6bBnj6+44wux1kWXZGkusqbfeKBeAR3RfU=; b=FEg2U7Zfj7ol
        ie5vN+cjxMJyTINsKt4n8XdOqGASRG68TYRJelppaQE+dx/iEbaE7XTHjJPfwPwnB4Pja98xTGWCo
        pmiO7Krh1Ix0sZlsH5cFjZYCW2M4RULlI1SevkO55CCpFslJuXd2SBhuCHRRKrB8gxl+sNfm7xLMJ
        khCG8=;
Received: from [185.7.230.213] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gFGSi-00013v-40; Wed, 24 Oct 2018 10:32:28 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id AA308440078; Wed, 24 Oct 2018 12:32:27 +0200 (CEST)
From:   Mark Brown <broonie@kernel.org>
To:     Keiji Hayashibara <hayashibara.keiji@socionext.com>
Cc:     Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        yamada.masahiro@socionext.com, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        stable@vger.kernel.org, masami.hiramatsu@linaro.org,
        jaswinder.singh@linaro.org, linux-kernel@vger.kernel.org,
        hayashibara.keiji@socionext.com, linux-spi@vger.kernel.org
Subject: Applied "spi: uniphier: fix incorrect property items" to the spi tree
In-Reply-To:  <1540373669-18969-1-git-send-email-hayashibara.keiji@socionext.com>
Message-Id: <20181024103227.AA308440078@finisterre.ee.mobilebroadband>
Date:   Wed, 24 Oct 2018 12:32:27 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: uniphier: fix incorrect property items

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

From 3511ba7d4ca6f39e2d060bb94e42a41ad1fee7bf Mon Sep 17 00:00:00 2001
From: Keiji Hayashibara <hayashibara.keiji@socionext.com>
Date: Wed, 24 Oct 2018 18:34:29 +0900
Subject: [PATCH] spi: uniphier: fix incorrect property items

This commit fixes incorrect property because it was different
from the actual.
The parameters of '#address-cells' and '#size-cells' were removed,
and 'interrupts', 'pinctrl-names' and 'pinctrl-0' were added.

Fixes: 4dcd5c2781f3 ("spi: add DT bindings for UniPhier SPI controller")
Signed-off-by: Keiji Hayashibara <hayashibara.keiji@socionext.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/spi/spi-uniphier.txt       | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-uniphier.txt b/Documentation/devicetree/bindings/spi/spi-uniphier.txt
index 504a4ecfc7b1..b04e66a52de5 100644
--- a/Documentation/devicetree/bindings/spi/spi-uniphier.txt
+++ b/Documentation/devicetree/bindings/spi/spi-uniphier.txt
@@ -5,18 +5,20 @@ UniPhier SoCs have SCSSI which supports SPI single channel.
 Required properties:
  - compatible: should be "socionext,uniphier-scssi"
  - reg: address and length of the spi master registers
- - #address-cells: must be <1>, see spi-bus.txt
- - #size-cells: must be <0>, see spi-bus.txt
- - clocks: A phandle to the clock for the device.
- - resets: A phandle to the reset control for the device.
+ - interrupts: a single interrupt specifier
+ - pinctrl-names: should be "default"
+ - pinctrl-0: pin control state for the default mode
+ - clocks: a phandle to the clock for the device
+ - resets: a phandle to the reset control for the device
 
 Example:
 
 spi0: spi@54006000 {
 	compatible = "socionext,uniphier-scssi";
 	reg = <0x54006000 0x100>;
-	#address-cells = <1>;
-	#size-cells = <0>;
+	interrupts = <0 39 4>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_spi0>;
 	clocks = <&peri_clk 11>;
 	resets = <&peri_rst 11>;
 };
-- 
2.19.0

