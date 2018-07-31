Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54CF6C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 07:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09878208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 07:12:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="joBnoUkK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09878208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goldelico.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732141AbeGaIup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 04:50:45 -0400
Received: from mo4-p04-ob.smtp.rzone.de ([85.215.255.123]:18242 "EHLO
        mo4-p04-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727322AbeGaIuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 04:50:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1533021110;
        s=strato-dkim-0002; d=goldelico.com;
        h=References:In-Reply-To:References:In-Reply-To:Message-Id:Date:
        Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=fIvtYGrFdo0LnIe5kh7bffITAhIhopTBykgObflpVKY=;
        b=joBnoUkKbqAmTLGwidAryetKM/bXVvK2X9prJmT66H64fKlJo/+DYcyu9uiUZCXOtc
        Jo+n9GOp9V3YRx6wkRSG5jwZGmTLnOUiQCrz2iwJOr5C1k3SqxvuZqXZcZDuRY6Z4v3w
        5G0w0ujNfxHPYosYY6WABWbyTWF0GKnlwW+6Ihnn5PDMdS6BhxYJjiZgfj2XKsRiuWQZ
        qS3+bmHdbXZTI0jRtZXv+bEbUn0QOcmvk0sIq1x6kwW/EPYZrPB8HFTHbeQjQmLQe0ZS
        0bW/aQg99jbSar+92SsEDcC7X/CXQcNjw0FKlwWeLlvpfjj5vUvcN0ttax3GxH4p8qZv
        ysfw==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1pxICp41QvXLM9PJBRQ"
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 43.13 DYNA|AUTH)
        with ESMTPSA id 6047f4u6V7BhwOj
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Tue, 31 Jul 2018 09:11:43 +0200 (CEST)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     ladis@linux-mips.org,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Marek Belisko <marek@goldelico.com>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v2 18/32] ARM: dts: omap3-gta04: add camera pinmux
Date:   Tue, 31 Jul 2018 09:11:21 +0200
Message-Id: <6406849125350a3a921fb2620158d6d891d466da.1533021093.git.hns@goldelico.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <cover.1533021093.git.hns@goldelico.com>
References: <cover.1533021093.git.hns@goldelico.com>
In-Reply-To: <cover.1533021093.git.hns@goldelico.com>
References: <cover.1533021093.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ISP needs camera pinmux (which is referenced by the camera node).

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/omap3-gta04.dtsi | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index 3d3876782a00..89e16e1897f7 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -330,6 +330,32 @@
 			OMAP3_CORE1_IOPAD(0x2194, PIN_INPUT_PULLUP | MUX_MODE4) /* gpio160 */
 		>;
 	};
+
+	camera_pins: pinmux_camera_pins {
+		pinctrl-single,pins = <
+			/* set up parallel camera interface */
+			OMAP3_CORE1_IOPAD(0x210c, PIN_INPUT_PULLDOWN | MUX_MODE0) /* cam_hs */
+			OMAP3_CORE1_IOPAD(0x210e, PIN_INPUT_PULLDOWN | MUX_MODE0) /* cam_vs */
+			OMAP3_CORE1_IOPAD(0x2110, PIN_OUTPUT | MUX_MODE0) /* cam_xclka */
+			OMAP3_CORE1_IOPAD(0x2112, PIN_INPUT_PULLDOWN | MUX_MODE0) /* cam_pclk */
+			OMAP3_CORE1_IOPAD(0x2114, PIN_OUTPUT | MUX_MODE4) /* cam_fld = gpio_98 */
+			OMAP3_CORE1_IOPAD(0x2116, PIN_INPUT_PULLDOWN | MUX_MODE0) /* cam_d0 */
+			OMAP3_CORE1_IOPAD(0x2118, PIN_INPUT_PULLDOWN | MUX_MODE0) /* cam_d1 */
+			OMAP3_CORE1_IOPAD(0x211a, PIN_INPUT_PULLDOWN | MUX_MODE0) /* cam_d2 */
+			OMAP3_CORE1_IOPAD(0x211c, PIN_INPUT_PULLDOWN | MUX_MODE0) /* cam_d3 */
+			OMAP3_CORE1_IOPAD(0x211e, PIN_INPUT_PULLDOWN | MUX_MODE0) /* cam_d4 */
+			OMAP3_CORE1_IOPAD(0x2120, PIN_INPUT_PULLDOWN | MUX_MODE0) /* cam_d5 */
+			OMAP3_CORE1_IOPAD(0x2122, PIN_INPUT_PULLDOWN | MUX_MODE0) /* cam_d6 */
+			OMAP3_CORE1_IOPAD(0x2124, PIN_INPUT_PULLDOWN | MUX_MODE0) /* cam_d7 */
+			OMAP3_CORE1_IOPAD(0x2126, PIN_INPUT_PULLDOWN | MUX_MODE0) /* cam_d8 */
+			OMAP3_CORE1_IOPAD(0x2128, PIN_INPUT_PULLDOWN | MUX_MODE0) /* cam_d9 */
+			OMAP3_CORE1_IOPAD(0x212a, PIN_INPUT_PULLDOWN | MUX_MODE0) /* cam_d10 */
+			OMAP3_CORE1_IOPAD(0x212c, PIN_INPUT_PULLDOWN | MUX_MODE0) /* cam_d10 */
+			OMAP3_CORE1_IOPAD(0x212e, PIN_OUTPUT | MUX_MODE0) /* cam_xclkb */
+			OMAP3_CORE1_IOPAD(0x2130, PIN_OUTPUT | MUX_MODE4) /* cam_wen = gpio_167 */
+			OMAP3_CORE1_IOPAD(0x2132, PIN_INPUT_PULLDOWN | MUX_MODE4) /* cam_strobe */
+		>;
+	};
 };
 
 &omap3_pmx_core2 {
-- 
2.12.2

