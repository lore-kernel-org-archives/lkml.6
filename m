Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C75C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 07:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCDD920852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 07:00:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCDD920852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goldelico.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729024AbeGYILE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 04:11:04 -0400
Received: from mo4-p04-ob.smtp.rzone.de ([85.215.255.124]:8115 "EHLO
        mo4-p04-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728714AbeGYIJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 04:09:37 -0400
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o12DNO4Ij0pB1ZSLA74="
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 43.13 DYNA|AUTH)
        with ESMTPSA id 6047f4u6P6xCd5i
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 25 Jul 2018 08:59:12 +0200 (CEST)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     Marek Belisko <marek@goldelico.com>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH 19/32] ARM: dts: omap3-gta04: add mcbsp (audio subsystem) pinmux
Date:   Wed, 25 Jul 2018 08:58:51 +0200
Message-Id: <a9ddc586d5f5b0f1ee8ee2351e792fb73e1ea986.1532501910.git.hns@goldelico.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <cover.1532501910.git.hns@goldelico.com>
References: <cover.1532501910.git.hns@goldelico.com>
In-Reply-To: <cover.1532501910.git.hns@goldelico.com>
References: <cover.1532501910.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GTA04 audio system makes use of all four McBSP ports, so set
up proper pinmux.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/omap3-gta04.dtsi | 39 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index a5d1fa1be9c5..935a2a707737 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -356,6 +356,45 @@
 			OMAP3_CORE1_IOPAD(0x2132, PIN_INPUT_PULLDOWN | MUX_MODE4) /* cam_strobe */
 		>;
 	};
+
+	mcbsp1_pins: pinmux_mcbsp1_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x218c, PIN_INPUT | MUX_MODE4)	/* mcbsp1_clkr.mcbsp1_clkr - gpio_156 FM interrupt */
+			OMAP3_CORE1_IOPAD(0x218e, PIN_OUTPUT | MUX_MODE0)	/* mcbsp1_clkr.mcbsp1_fsr */
+			OMAP3_CORE1_IOPAD(0x2190, PIN_OUTPUT | MUX_MODE0)	/* mcbsp1_dx.mcbsp1_dx */
+			OMAP3_CORE1_IOPAD(0x2192, PIN_INPUT | MUX_MODE0)	/* mcbsp1_dx.mcbsp1_dr */
+			/* mcbsp_clks is used as PENIRQ */
+			/* OMAP3_CORE1_IOPAD(0x2194, PIN_INPUT | MUX_MODE0)	/* mcbsp_clks.mcbsp_clks */
+			OMAP3_CORE1_IOPAD(0x2196, PIN_INPUT | MUX_MODE0)	/* mcbsp_clks.mcbsp1_fsx */
+			OMAP3_CORE1_IOPAD(0x2198, PIN_INPUT | MUX_MODE0)	/* mcbsp1_clkx.mcbsp1_clkx */
+		>;
+	};
+
+	mcbsp2_pins: pinmux_mcbsp2_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x213c, PIN_INPUT | MUX_MODE0)	/* mcbsp2_fsx.mcbsp2_fsx */
+			OMAP3_CORE1_IOPAD(0x213e, PIN_INPUT | MUX_MODE0)	/* mcbsp2_fsx.mcbsp2_clkx */
+			OMAP3_CORE1_IOPAD(0x2140, PIN_INPUT | MUX_MODE0)	/* mcbsp2_dr.mcbsp2_dr */
+			OMAP3_CORE1_IOPAD(0x2142, PIN_OUTPUT | MUX_MODE0)	/* mcbsp2_dr.mcbsp2_dx */
+		>;
+	};
+
+	mcbsp3_pins: pinmux_mcbsp3_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x216c, PIN_OUTPUT | MUX_MODE0)	/* mcbsp3_dx.mcbsp3_dx */
+			OMAP3_CORE1_IOPAD(0x216e, PIN_INPUT | MUX_MODE0)	/* mcbsp3_dx.mcbsp3_dr */
+			OMAP3_CORE1_IOPAD(0x2170, PIN_INPUT | MUX_MODE0)	/* mcbsp3_clkx.mcbsp3_clkx */
+			OMAP3_CORE1_IOPAD(0x2172, PIN_INPUT | MUX_MODE0)	/* mcbsp3_clkx.mcbsp3_fsx */
+		>;
+	};
+
+	mcbsp4_pins: pinmux_mcbsp4_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x2184, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* mcbsp4_clkx.mcbsp4_clkx */
+			OMAP3_CORE1_IOPAD(0x2186, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* mcbsp4_clkx.mcbsp4_dr */
+			OMAP3_CORE1_IOPAD(0x218a, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* mcbsp4_dx.mcbsp4_fsx */
+		>;
+	};
 };
 
 &omap3_pmx_core2 {
-- 
2.12.2

