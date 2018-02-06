Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752671AbeBFEvA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 23:51:00 -0500
Received: from hermes.aosc.io ([199.195.250.187]:50283 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752625AbeBFEux (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 23:50:53 -0500
From: Icenowy Zheng <icenowy@aosc.io>
To: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        Ondrej Jirman <megous@megous.com>, Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH v2 04/10] ARM: sunxi: h3/h5: Add r_i2c I2C controller
Date: Tue,  6 Feb 2018 12:48:59 +0800
Message-Id: <20180206044905.30508-5-icenowy@aosc.io>
In-Reply-To: <20180206044905.30508-1-icenowy@aosc.io>
References: <20180206044905.30508-1-icenowy@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ondrej Jirman <megous@megous.com>

Allwinner H3/H5 SoCs have an I2C controller at PL GPIO bank.

Add support for it in the device tree.

Signed-off-by: Ondrej Jirman <megous@megous.com>
[Icenowy: Change to use r_ccu and change pinmux node name]
Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
---
Changes in v2:
- Added Chen-Yu's Review tag.

 arch/arm/boot/dts/sunxi-h3-h5.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
index fc602aed60a6..57606900a949 100644
--- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
+++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
@@ -716,6 +716,19 @@
 			status = "disabled";
 		};
 
+		r_i2c: i2c@1f02400 {
+			compatible = "allwinner,sun6i-a31-i2c";
+			reg = <0x01f02400 0x400>;
+			interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&r_i2c_pins>;
+			clocks = <&r_ccu CLK_APB0_I2C>;
+			resets = <&r_ccu RST_APB0_I2C>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
 		r_pio: pinctrl@1f02c00 {
 			compatible = "allwinner,sun8i-h3-r-pinctrl";
 			reg = <0x01f02c00 0x400>;
-- 
2.15.1
