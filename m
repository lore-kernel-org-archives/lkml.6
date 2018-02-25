Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751759AbeBYNvt (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 08:51:49 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33949 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750987AbeBYNvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 08:51:46 -0500
X-Google-Smtp-Source: AH8x227+l+acjfZAdJuQEqTv6frW4TF64Zt+D/imclalGtuuHn9dOnp4n/ulXT0Y2HTCVMdUWWl+MA==
Date: Sun, 25 Feb 2018 21:51:34 +0800
From: hao_zhang <hao5781286@gmail.com>
To: thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, wens@csie.org, maxime.ripard@free-electrons.com,
        Claudiu.Beznea@microchip.com
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org, linux-sunxi@googlegroups.com,
        hao5781286@gmail.com
Subject: [PATCH v2 2/4] ARM: dtsi: add pwm node for sun8i.
Message-ID: <20180225135134.GA14529@arx-s1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds pwm node for sun8i.

Signed-off-by: hao_zhang <hao5781286@gmail.com>
---
 arch/arm/boot/dts/sun8i-r40.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r40.dtsi
index 173dcc1..99a0261 100644
--- a/arch/arm/boot/dts/sun8i-r40.dtsi
+++ b/arch/arm/boot/dts/sun8i-r40.dtsi
@@ -295,6 +295,11 @@
 				bias-pull-up;
 			};
 
+			pwm_ch0_pin: pwm-ch0-pin {
+				pins = "PB2";
+				function = "pwm";
+			};
+
 			uart0_pb_pins: uart0-pb-pins {
 				pins = "PB22", "PB23";
 				function = "uart0";
@@ -306,6 +311,14 @@
 			reg = <0x01c20c90 0x10>;
 		};
 
+		pwm: pwm@1c23400 {
+			     compatible = "allwinner,sun8i-r40-pwm";
+			     reg = <0x01c23400 0x154>;
+			     clocks = <&osc24M>;
+			     #pwm-cells = <3>;
+			     status = "disabled";
+		};
+
 		uart0: serial@1c28000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c28000 0x400>;
-- 
2.7.4
