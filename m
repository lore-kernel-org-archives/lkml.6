Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 442CDC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 14:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A21020664
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 14:14:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="cP52dbnx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A21020664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394882AbeKXA6v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 19:58:51 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53522 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388230AbeKXA6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 19:58:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=VINDoJdRHHMJeAQ64AzORio5RKA5Pe0OXjRDjNrhj38=; b=cP52dbnxj+oZ
        V73nmTFg4/upvQQ9gEVxtWMqGgABdTfKJine65kZvSskYoCAvF1rkYDM3aXvPxEznVTq6gbdcm1zZ
        IEHLAuACuSHwhRJc1RUzialOcvfOFTp4HHe1bcrN2RF8OHdckKvNxAbnOiEX6Ae+DONpzPm0THepy
        QBM3Q=;
Received: from [176.12.107.140] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gQCDv-00019j-S8; Fri, 23 Nov 2018 14:14:24 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 73C16440078; Fri, 23 Nov 2018 14:14:22 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-sunxi@googlegroups.com, linux-kernel@vger.kernel.org,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: dt-bindings: sun50i-codec-analog: Add headphone amp regulator supply" to the asoc tree
In-Reply-To:  <20181122102325.29495-2-wens@csie.org>
Message-Id: <20181123141422.73C16440078@finisterre.ee.mobilebroadband>
Date:   Fri, 23 Nov 2018 14:14:22 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: dt-bindings: sun50i-codec-analog: Add headphone amp regulator supply

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

From 21dd30200e3d350fe420d23a2a00b17633a3d1a2 Mon Sep 17 00:00:00 2001
From: Chen-Yu Tsai <wens@csie.org>
Date: Thu, 22 Nov 2018 18:23:18 +0800
Subject: [PATCH] ASoC: dt-bindings: sun50i-codec-analog: Add headphone amp
 regulator supply

On the Allwinner A64 SoC, the audio codec has a built-in headphone
amplifier. This amplifier has a power supply separate from the rest of
the analog audio circuitry.

Add a regulator supply property to handle this.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/sun50i-codec-analog.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/sun50i-codec-analog.txt b/Documentation/devicetree/bindings/sound/sun50i-codec-analog.txt
index 4f8ad0e04d20..056a098495cc 100644
--- a/Documentation/devicetree/bindings/sound/sun50i-codec-analog.txt
+++ b/Documentation/devicetree/bindings/sound/sun50i-codec-analog.txt
@@ -4,9 +4,11 @@ Required properties:
 - compatible: must be one of the following compatibles:
 		- "allwinner,sun50i-a64-codec-analog"
 - reg: must contain the registers location and length
+- cpvdd-supply: Regulator supply for the headphone amplifier
 
 Example:
 	codec_analog: codec-analog@1f015c0 {
 		compatible = "allwinner,sun50i-a64-codec-analog";
 		reg = <0x01f015c0 0x4>;
+		cpvdd-supply = <&reg_eldo1>;
 	};
-- 
2.19.1

