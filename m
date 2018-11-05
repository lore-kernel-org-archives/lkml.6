Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC110C46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B53D20869
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:02:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="QAlPiY73"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B53D20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729590AbeKEVV1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 16:21:27 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45316 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727814AbeKEVV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 16:21:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=i/dhJ8a4J4Pn3Vo+oiRbuM2a76RD24TfOQ1Y0bIMQ0g=; b=QAlPiY73LWMm
        5252UOwuQFDrH3FiFvCzQo4iXDcZ6Quq2Cp9uIhioG0CRtYJHDVy8Go5NkMK49ioB4ZW55byKY0Gg
        RZOruM39XOqwykPB70Y58ZxapHRZaDe88lVlFPO2D1mRuIQx5xcDEYksVT6QFxJJImiPDhYXXfPb9
        8zWN0=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gJdZq-0008KR-8D; Mon, 05 Nov 2018 12:01:54 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id EB1181124D98; Mon,  5 Nov 2018 12:01:53 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Keiji Hayashibara <hayashibara.keiji@socionext.com>
Cc:     Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        yamada.masahiro@socionext.com, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        stable@vger.kernel.org, masami.hiramatsu@linaro.org,
        jaswinder.singh@linaro.org, linux-kernel@vger.kernel.org,
        hayashibara.keiji@socionext.com, linux-spi@vger.kernel.org
Subject: Applied "spi: uniphier: re-add addressing properties" to the spi tree
In-Reply-To:  <1540533525-1816-3-git-send-email-hayashibara.keiji@socionext.com>
Message-Id: <20181105120153.EB1181124D98@debutante.sirena.org.uk>
Date:   Mon,  5 Nov 2018 12:01:53 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: uniphier: re-add addressing properties

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

From 2a35a643f138a97e3bfee0c599c72e5ca80ebe7c Mon Sep 17 00:00:00 2001
From: Keiji Hayashibara <hayashibara.keiji@socionext.com>
Date: Fri, 26 Oct 2018 14:58:45 +0900
Subject: [PATCH] spi: uniphier: re-add addressing properties

In commit 7662d1dc17d4 ("spi: uniphier: fix incorrect property items")
addressing properties of #address-cells and #size-cells were removed.
Since it is not necessary to remove them, they are back again.

Signed-off-by: Keiji Hayashibara <hayashibara.keiji@socionext.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/spi/spi-uniphier.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-uniphier.txt b/Documentation/devicetree/bindings/spi/spi-uniphier.txt
index b04e66a52de5..e1201573a29a 100644
--- a/Documentation/devicetree/bindings/spi/spi-uniphier.txt
+++ b/Documentation/devicetree/bindings/spi/spi-uniphier.txt
@@ -5,6 +5,8 @@ UniPhier SoCs have SCSSI which supports SPI single channel.
 Required properties:
  - compatible: should be "socionext,uniphier-scssi"
  - reg: address and length of the spi master registers
+ - #address-cells: must be <1>, see spi-bus.txt
+ - #size-cells: must be <0>, see spi-bus.txt
  - interrupts: a single interrupt specifier
  - pinctrl-names: should be "default"
  - pinctrl-0: pin control state for the default mode
@@ -16,6 +18,8 @@ Example:
 spi0: spi@54006000 {
 	compatible = "socionext,uniphier-scssi";
 	reg = <0x54006000 0x100>;
+	#address-cells = <1>;
+	#size-cells = <0>;
 	interrupts = <0 39 4>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_spi0>;
-- 
2.19.0.rc2

