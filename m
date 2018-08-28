Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E89EC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 21:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9B422087E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 21:08:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="KmvIDbGG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9B422087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727853AbeH2BCZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 21:02:25 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47980 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727285AbeH2BCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 21:02:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=V2QBaMY7FoS7vzKsD8C0T3zOo6sr7e0YDM24q/zS/Y8=; b=KmvIDbGGnqPd
        tln3NnpcP8/CeXHGXkx6Axa8+IOD1Fc3l3LpMmvc8E+WsNbRll6p6dKTshmp7jzO2yWio0LVBQqX9
        R0ApIiLyIvKsDX3K7l3PnkxC8BHmVEbFUZ0iqoPwN2mg3mJnmWZW+X8Mr0oK+CWECNJ/G+LUqMWcd
        7mez8=;
Received: from 94.197.121.204.threembb.co.uk ([94.197.121.204] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fulE0-0007lZ-7u; Tue, 28 Aug 2018 21:08:32 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 3411A44009A; Tue, 28 Aug 2018 21:57:35 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Lanqing Liu <lanqing.liu@spreadtrum.com>
Cc:     Baolin Wang <baolin.wang@linaro.org>,
        Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, orsonzhai@gmail.com,
        zhang.lyra@gmail.com, lanqing.liu@spreadtrum.com,
        baolin.wang@linaro.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Applied "spi: Add Spreadtrum SPI controller documentation" to the spi tree
In-Reply-To: 
Message-Id: <20180828205735.3411A44009A@finisterre.ee.mobilebroadband>
Date:   Tue, 28 Aug 2018 21:57:35 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: Add Spreadtrum SPI controller documentation

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

From 862cf93e4b9ba17f6375dc68c1e01da3210d5310 Mon Sep 17 00:00:00 2001
From: Lanqing Liu <lanqing.liu@spreadtrum.com>
Date: Thu, 16 Aug 2018 20:54:50 +0800
Subject: [PATCH] spi: Add Spreadtrum SPI controller documentation

This patch adds the binding documentation for Spreadtrum SPI
controller device.

Signed-off-by: Lanqing Liu <lanqing.liu@spreadtrum.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/spi/spi-sprd.txt      | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-sprd.txt

diff --git a/Documentation/devicetree/bindings/spi/spi-sprd.txt b/Documentation/devicetree/bindings/spi/spi-sprd.txt
new file mode 100644
index 000000000000..bad211a19da4
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-sprd.txt
@@ -0,0 +1,26 @@
+Spreadtrum SPI Controller
+
+Required properties:
+- compatible: Should be "sprd,sc9860-spi".
+- reg: Offset and length of SPI controller register space.
+- interrupts: Should contain SPI interrupt.
+- clock-names: Should contain following entries:
+	"spi" for SPI clock,
+	"source" for SPI source (parent) clock,
+	"enable" for SPI module enable clock.
+- clocks: List of clock input name strings sorted in the same order
+	as the clock-names property.
+- #address-cells: The number of cells required to define a chip select
+	address on the SPI bus. Should be set to 1.
+- #size-cells: Should be set to 0.
+
+Example:
+spi0: spi@70a00000{
+	compatible = "sprd,sc9860-spi";
+	reg = <0 0x70a00000 0 0x1000>;
+	interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
+	clock-names = "spi", "source","enable";
+	clocks = <&clk_spi0>, <&ext_26m>, <&clk_ap_apb_gates 5>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+};
-- 
2.18.0

