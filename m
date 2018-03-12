Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932533AbeCLQMa (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 12:12:30 -0400
Received: from h1.radempa.de ([176.9.142.194]:56678 "EHLO mail.cosmopool.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932147AbeCLQLN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 12:11:13 -0400
From: Harald Geyer <harald@ccbib.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andre Przywara <andre.przywara@arm.com>,
        Icenowy Zheng <icenowy@aosc.io>, info@olimex.com,
        Harald Geyer <harald@ccbib.org>
Subject: [PATCH 4/5] arm64: dts: allwinner: a64: Add pwm device
Date: Mon, 12 Mar 2018 16:10:49 +0000
Message-Id: <20180312161050.7647-5-harald@ccbib.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180312161050.7647-1-harald@ccbib.org>
References: <20180312161050.7647-1-harald@ccbib.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This device is compatible with A13, so no new driver is needed.

Signed-off-by: Harald Geyer <harald@ccbib.org>
---
I saw that Andre Przywara has been working on A64 pwm too and has
submitted some patches a few days ago. I think his patches are functionally
equivalent to this one here, but clean up things a bit and thus are
preferable. See:

https://groups.google.com/forum/#!topic/linux-sunxi/hQFeteP591k

I'm including my patch here mostly to have a consistent series for others
to test. OTOH you might merge the device tree changes here and pick up
the cleanup patches from him. Either way should work fine.

 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 05d5e8def68a..95d52f6aa07f 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -364,6 +364,11 @@
 				bias-pull-up;
 			};
 
+			pwm_pin: pwm_pin {
+				pins = "PD22";
+				function = "pwm";
+			};
+
 			rmii_pins: rmii_pins {
 				pins = "PD10", "PD11", "PD13", "PD14", "PD17",
 				       "PD18", "PD19", "PD20", "PD22", "PD23";
@@ -629,6 +634,14 @@
 			#interrupt-cells = <3>;
 		};
 
+		pwm: pwm@1c21400 {
+			compatible = "allwinner,sun5i-a13-pwm";
+			reg = <0x01c21400 0x8>;
+			clocks = <&osc24M>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
 		rtc: rtc@1f00000 {
 			compatible = "allwinner,sun6i-a31-rtc";
 			reg = <0x01f00000 0x54>;
-- 
2.11.0
