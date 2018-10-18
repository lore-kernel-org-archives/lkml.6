Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 380FDC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 07:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEE4E208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 07:59:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=as-electronics.de header.i=@as-electronics.de header.b="KsdTvla4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEE4E208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727712AbeJRP7m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 11:59:42 -0400
Received: from mo4-p05-ob.smtp.rzone.de ([85.215.255.136]:14260 "EHLO
        mo4-p05-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbeJRP7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 11:59:42 -0400
X-Greylist: delayed 739 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Oct 2018 11:59:41 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1539849594;
        s=strato-dkim-0002; d=as-electronics.de;
        h=Message-Id:Date:Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=8mRoC82yWy41GfVf86ASjT2si0+W6NzVDmL7PnsfOnw=;
        b=KsdTvla4dmoFrYUGBHX+ah/PdTwODxD4zU2D1PcU4l3hyiNtvN2menVflsTBKkbCs5
        5sAt5oSAIvtyY56x4zUaX0nIYXvROjoin9IFM4jysZXXhIjVOfzoujvjSFR4An9ep2Qc
        a9HcsNyyXNeullQT48Jtz6sPhJ0SgYN1dZyQC+PChJ/76V2X5XGOLWWq2Cp4SGbuETPb
        bt2SG9ws1vQpnK2ZK3xqQegcqdBp/rMp0+LoRmpIQEAagkScm7XR1+r7+w0IIQNJn+XI
        EZw8/Yxfjq2cMCzzsMmUA7JKu9FfKiNc4wdoa6cWA4kuhIc92piDypgiYTEAt/mAojrQ
        mz5w==
X-RZG-AUTH: ":LX8JdEmkW/4tAFwMkcNJIloh1hrA5u3owhPk7bdT5Fx22AatU+eLaHfutoZdl+X9BETxn4/4+IVqx+ZaE86CU4W9SKmmy5dqqXOHDy+cSfqdZKKHYA=="
X-RZG-CLASS-ID: mo05
Received: from fs-work.fritz.box
        by smtp.strato.de (RZmta 44.3 AUTH)
        with ESMTPSA id j097e4u9I7lBFmq
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Thu, 18 Oct 2018 09:47:11 +0200 (CEST)
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
To:     devicetree@vger.kernel.org, peter.chen@nxp.com
Cc:     Frieder Schrempf <frieder.schrempf@kontron.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: imx: Add dummy PHYs for HSIC-only USB controllers
Date:   Thu, 18 Oct 2018 09:45:04 +0200
Message-Id: <1539848729-27646-1-git-send-email-frieder.schrempf@kontron.de>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some SOCs in the i.MX6 family have a USB host controller that is
only capable of the HSIC interface and has no on-board PHY.

To be able to use these controllers, we need to add "usb-nop-xceiv"
dummy PHYs.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 arch/arm/boot/dts/imx6qdl.dtsi | 14 ++++++++++++++
 arch/arm/boot/dts/imx6sl.dtsi  |  7 +++++++
 arch/arm/boot/dts/imx6sx.dtsi  |  6 ++++++
 3 files changed, 27 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 61d2d26..d3404d1 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -139,6 +139,16 @@
 		interrupts = <0 94 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
+	usbphynop1: usbphynop1 {
+		compatible = "usb-nop-xceiv";
+		#phy-cells = <0>;
+	};
+
+	usbphynop2: usbphynop2 {
+		compatible = "usb-nop-xceiv";
+		#phy-cells = <0>;
+	};
+
 	soc {
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -981,6 +991,8 @@
 				reg = <0x02184400 0x200>;
 				interrupts = <0 41 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX6QDL_CLK_USBOH3>;
+				fsl,usbphy = <&usbphynop1>;
+				phy_type = "hsic";
 				fsl,usbmisc = <&usbmisc 2>;
 				dr_mode = "host";
 				ahb-burst-config = <0x0>;
@@ -994,6 +1006,8 @@
 				reg = <0x02184600 0x200>;
 				interrupts = <0 42 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX6QDL_CLK_USBOH3>;
+				fsl,usbphy = <&usbphynop2>;
+				phy_type = "hsic";
 				fsl,usbmisc = <&usbmisc 3>;
 				dr_mode = "host";
 				ahb-burst-config = <0x0>;
diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index 7a4f5da..81edcdc 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -110,6 +110,11 @@
 		interrupts = <0 94 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
+	usbphynop1: usbphynop1 {
+		compatible = "usb-nop-xceiv";
+		#phy-cells = <0>;
+	};
+
 	soc {
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -815,6 +820,8 @@
 				reg = <0x02184400 0x200>;
 				interrupts = <0 40 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX6SL_CLK_USBOH3>;
+				fsl,usbphy = <&usbphynop1>;
+				phy_type = "hsic";
 				fsl,usbmisc = <&usbmisc 2>;
 				dr_mode = "host";
 				ahb-burst-config = <0x0>;
diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 844caa3..07ed417 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -159,6 +159,11 @@
 		interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
+	usbphynop1: usbphynop1 {
+		compatible = "usb-nop-xceiv";
+		#phy-cells = <0>;
+	};
+
 	soc {
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -877,6 +882,7 @@
 				reg = <0x02184400 0x200>;
 				interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX6SX_CLK_USBOH3>;
+				fsl,usbphy = <&usbphynop1>;
 				fsl,usbmisc = <&usbmisc 2>;
 				phy_type = "hsic";
 				fsl,anatop = <&anatop>;
-- 
2.7.4

