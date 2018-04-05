Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751938AbeDEQFj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 12:05:39 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.166]:21557 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751807AbeDEQFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 12:05:37 -0400
X-RZG-AUTH: :JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o12DNO4Ij0lfw3o0
X-RZG-CLASS-ID: mo00
From: "H. Nikolaus Schaller" <hns@goldelico.com>
To: Peter Ujfalusi <peter.ujfalusi@ti.com>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc: letux-kernel@openphoenux.org, linux-omap <linux-omap@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH] ARM: dts: omap3-gta04: Add fixed 26MHz clock as fck for twl
Date: Thu,  5 Apr 2018 18:05:16 +0200
Message-Id: <c0b35797744a71df9d8088508814675cc5f07710.1522944315.git.hns@goldelico.com>
X-Mailer: git-send-email 2.12.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The board uses 26MHz oscillator for the twl4030 HFCLK.
This way we will not depend on the bootloader to configure the
CFG_BOOT:HFCLK_FREQ

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/omap3-gta04.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index 4170be70460e..ac830b917776 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -30,6 +30,13 @@
 		display0 = &lcd;
 	};
 
+	/* fixed 26MHz oscillator */
+	hfclk_26m: oscillator {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <26000000>;
+	};
+
 	gpio-keys {
 		compatible = "gpio-keys";
 
@@ -312,6 +319,9 @@
 		interrupts = <7>; /* SYS_NIRQ cascaded to intc */
 		interrupt-parent = <&intc>;
 
+		clocks = <&hfclk_26m>;
+		clock-names = "fck";
+
 		twl_audio: audio {
 			compatible = "ti,twl4030-audio";
 			ti,enable-vibra = <1>;
-- 
2.12.2
