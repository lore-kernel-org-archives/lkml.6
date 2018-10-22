Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67CF7C67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B99A20652
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:33:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B99A20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=digi.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728699AbeJVSvb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 14:51:31 -0400
Received: from mail1.bemta24.messagelabs.com ([67.219.250.208]:7092 "EHLO
        mail1.bemta24.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728660AbeJVSvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 14:51:31 -0400
Received: from [67.219.251.53] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-1.bemta.az-c.us-west-2.aws.symcld.net id DA/58-08683-C77ADCB5; Mon, 22 Oct 2018 10:33:32 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLIsWRWlGSWpSXmKPExsXi5LtOQLd6+dl
  og81nLC3mHznHarFx820Wi1VTd7JYbHp8jdWi69dKZovLu+awWSy9fpHJonXvEXaLv9s3sVi8
  2CLuwOWxZt4aRo9NqzrZPDYvqffY+G4Hk0f/XwOPz5vkAtiiWDPzkvIrElgzpv7tYynYzFNxd
  tkf1gbGD1xdjFwcQgKrGCXOH//BCuFsYZSYuugbWxcjJwebgI7ElP2HWUBsEQFJibUrFzGDFD
  ELTGGSOP1tF1iRsECYxMHV34GKODhYBFQl/vWogIR5Bdwkvk6YBFYiISAncfNcJzOIzSngLrH
  4/k1WEFsIqKb91GM2iHpBiZMzn4DtYhaQkDj44gUzRI2yxJYVFxgh5ihIrD1wnmkCI/8sJC2z
  kLQsYGRaxWiRVJSZnlGSm5iZo2toYKBraGika2hsDqRN9BKrdJP1Sot1y1OLS3SN9BLLi/WKK
  3OTc1L08lJLNjECoyKloLNoB+PLrvRDjJIcTEqivInGp6OF+JLyUyozEosz4otKc1KLDzHKcH
  AoSfB+Wno2WkiwKDU9tSItMwcYnzBpCQ4eJRHeqGVAad7igsTc4sx0iNQpRl2OJQ3/pzMLseT
  l56VKifOaghQJgBRllObBjYClikuMslLCvIwMDAxCPAWpRbmZJajyrxjFORiVhHk/glzCk5lX
  ArfpFdARTEBHXFc/A3JESSJCSqqBcTanpH5mmoDL3W2v+bkubLkz2cPlBe/Wc1dWu+5KfeKX0
  3ddt/KB1IXL1eHPLY6H5f9zn7QlN0lN8p6ntVfQc7VJv+6wsb3x++ggn9R4y8KB9y9jqL+ha7
  9AA/Obu9xvWVuYl2g/fXDxSlVDpFH/FN17a2c/ZlXqPlbz59Mk1kfK3gsmKEnaK7EUZyQaajE
  XFScCAKnNcaoQAwAA
X-Env-Sender: Alex.Gonzalez@digi.com
X-Msg-Ref: server-7.tower-365.messagelabs.com!1540204408!974579!7
X-Originating-IP: [66.77.174.16]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.14.24; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 32081 invoked from network); 22 Oct 2018 10:33:31 -0000
Received: from owa.digi.com (HELO MCL-VMS-XCH01.digi.com) (66.77.174.16)
  by server-7.tower-365.messagelabs.com with DHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 22 Oct 2018 10:33:31 -0000
Received: from DOR-SMS-XCH01.digi.com (10.49.8.99) by MCL-VMS-XCH01.digi.com
 (10.5.8.49) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 22 Oct 2018
 05:33:31 -0500
Received: from log-linux-hp-agonzal.digi.com (10.101.2.214) by
 dor-sms-xch01.digi.com (10.49.8.99) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Mon, 22 Oct 2018 12:33:29 +0200
From:   Alex Gonzalez <alex.gonzalez@digi.com>
To:     <shawnguo@kernel.org>
CC:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <s.hauer@pengutronix.de>, <kernel@pengutronix.de>,
        <fabio.estevam@nxp.com>, <linux-imx@nxp.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <alex.gonzalez@digi.com>
Subject: [PATCH 2/2] ARM: dts: ccimx6ulsbcpro: Add support for Goodix touch controller
Date:   Mon, 22 Oct 2018 12:33:19 +0200
Message-ID: <1540204399-12982-3-git-send-email-alex.gonzalez@digi.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1540204399-12982-1-git-send-email-alex.gonzalez@digi.com>
References: <1540204399-12982-1-git-send-email-alex.gonzalez@digi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.101.2.214]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alex Gonzalez <alex.gonzalez@digi.com>
---
 arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dts | 19 +++++++++++++++++++
 arch/arm/configs/imx_v6_v7_defconfig        |  1 +
 2 files changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dts b/arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dts
index ac9ae4ac77ba..2e7927930d4f 100644
--- a/arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dts
+++ b/arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dts
@@ -105,6 +105,19 @@
 	};
 };
 
+&i2c1 {
+	touchscreen@14 {
+		compatible = "goodix,gt911";
+		reg = <0x14>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_goodix_touch>;
+		interrupt-parent = <&gpio5>;
+		interrupts = <2 IRQ_TYPE_EDGE_RISING>;
+		irq-gpios = <&gpio5 2 GPIO_ACTIVE_HIGH>;
+		status = "okay";
+	};
+};
+
 &lcdif {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_lcdif_dat0_17
@@ -297,6 +310,12 @@
 		>;
 	};
 
+	pinctrl_goodix_touch: goodixgrp{
+		fsl,pins = <
+			MX6UL_PAD_SNVS_TAMPER2__GPIO5_IO02	0x1020
+		>;
+	};
+
 	pinctrl_lcdif_dat0_17: lcdifdatgrp0-17 {
 		fsl,pins = <
 			MX6UL_PAD_LCD_DATA00__LCDIF_DATA00	0x79
diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 7eca43ff69bb..d6e947307d67 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -170,6 +170,7 @@ CONFIG_MOUSE_PS2_ELANTECH=y
 CONFIG_INPUT_TOUCHSCREEN=y
 CONFIG_TOUCHSCREEN_ADS7846=y
 CONFIG_TOUCHSCREEN_EGALAX=y
+CONFIG_TOUCHSCREEN_GOODIX=y
 CONFIG_TOUCHSCREEN_MAX11801=y
 CONFIG_TOUCHSCREEN_IMX6UL_TSC=y
 CONFIG_TOUCHSCREEN_EDT_FT5X06=y
