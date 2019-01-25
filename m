Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DDBBC282C3
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 03:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58FE12084A
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 03:23:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728882AbfAYDXi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 22:23:38 -0500
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:59404 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728575AbfAYDXU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 22:23:20 -0500
Received: by wens.csie.org (Postfix, from userid 1000)
        id 5D8C05FDC1; Fri, 25 Jan 2019 11:23:15 +0800 (CST)
From:   Chen-Yu Tsai <wens@csie.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 07/11] ARM: dts: sun8i-a23-a33: Move NAND controller device node to sort by address
Date:   Fri, 25 Jan 2019 11:23:10 +0800
Message-Id: <20190125032314.20915-8-wens@csie.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190125032314.20915-1-wens@csie.org>
References: <20190125032314.20915-1-wens@csie.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The NAND controller device node was inserted into the wrong position,
probably due to a rebase or merge, as the file's structure does not
provide enough context for git to accurately match the previous device
node block.

Fixes: d7b843df13ea ("ARM: dts: sun8i: add NAND controller node for A23/A33")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-a23-a33.dtsi | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-a23-a33.dtsi b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
index a9c123de5d2c..97ec8b8cec09 100644
--- a/arch/arm/boot/dts/sun8i-a23-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
@@ -155,6 +155,19 @@
 			#dma-cells = <1>;
 		};
 
+		nfc: nand@1c03000 {
+			compatible = "allwinner,sun4i-a10-nand";
+			reg = <0x01c03000 0x1000>;
+			interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_NAND>, <&ccu CLK_NAND>;
+			clock-names = "ahb", "mod";
+			resets = <&ccu RST_BUS_NAND>;
+			reset-names = "ahb";
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
 		mmc0: mmc@1c0f000 {
 			compatible = "allwinner,sun7i-a20-mmc";
 			reg = <0x01c0f000 0x1000>;
@@ -214,21 +227,6 @@
 			#size-cells = <0>;
 		};
 
-		nfc: nand@1c03000 {
-			compatible = "allwinner,sun4i-a10-nand";
-			reg = <0x01c03000 0x1000>;
-			interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&ccu CLK_BUS_NAND>, <&ccu CLK_NAND>;
-			clock-names = "ahb", "mod";
-			resets = <&ccu RST_BUS_NAND>;
-			reset-names = "ahb";
-			pinctrl-names = "default";
-			pinctrl-0 = <&nand_pins &nand_pins_cs0 &nand_pins_rb0>;
-			status = "disabled";
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-
 		usb_otg: usb@1c19000 {
 			/* compatible gets set in SoC specific dtsi file */
 			reg = <0x01c19000 0x0400>;
-- 
2.20.1

