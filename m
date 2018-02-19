Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753789AbeBSURN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 15:17:13 -0500
Received: from mail-lf0-f68.google.com ([209.85.215.68]:34980 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753685AbeBSURL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 15:17:11 -0500
X-Google-Smtp-Source: AH8x226y9tOOS3l2HXvTS5qZgtahBY97bw5RcMVjPETFOJmu2Rn2vWf8IA/OaW2W6Sfsz6wyvwlBpw==
From: Tomasz Maciej Nowak <tmn505@gmail.com>
To: thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org
Cc: robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Tomasz Maciej Nowak <tmn505@gmail.com>
Subject: [PATCH] ARM: dtc: tegra: enable front panel leds in TrimSlice
Date: Mon, 19 Feb 2018 21:16:23 +0100
Message-Id: <20180219201623.6987-1-tmn505@gmail.com>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds device nodes for two front panel LEDs.

Signed-off-by: Tomasz Maciej Nowak <tmn505@gmail.com>
---
 arch/arm/boot/dts/tegra20-trimslice.dts | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20-trimslice.dts b/arch/arm/boot/dts/tegra20-trimslice.dts
index d55c6b240a30..31a8b088d386 100644
--- a/arch/arm/boot/dts/tegra20-trimslice.dts
+++ b/arch/arm/boot/dts/tegra20-trimslice.dts
@@ -200,16 +200,17 @@
 			conf_ata {
 				nvidia,pins = "ata", "atc", "atd", "ate",
 					"crtp", "dap2", "dap3", "dap4", "dta",
-					"dtb", "dtc", "dtd", "dte", "gmb",
-					"gme", "i2cp", "pta", "slxc", "slxd",
-					"spdi", "spdo", "uda";
+					"dtb", "dtc", "dtd", "gmb", "gme",
+					"i2cp", "pta", "slxc", "slxd", "spdi",
+					"spdo", "uda";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 			};
 			conf_atb {
 				nvidia,pins = "atb", "cdev1", "cdev2", "dap1",
-					"gma", "gmc", "gmd", "gpu", "gpu7",
-					"gpv", "sdio1", "slxa", "slxk", "uac";
+					"dte", "gma", "gmc", "gmd", "gpu",
+					"gpu7", "gpv", "sdio1", "slxa", "slxk",
+					"uac";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 			};
@@ -402,6 +403,20 @@
 		};
 	};
 
+	gpio-leds {
+		compatible = "gpio-leds";
+
+		ds2 {
+			label = "trimslice:green:right";
+			gpios = <&gpio TEGRA_GPIO(D, 2) GPIO_ACTIVE_LOW>;
+		};
+
+		ds3 {
+			label = "trimslice:green:left";
+			gpios = <&gpio TEGRA_GPIO(BB, 5) GPIO_ACTIVE_LOW>;
+		};
+	};
+
 	poweroff {
 		compatible = "gpio-poweroff";
 		gpios = <&gpio TEGRA_GPIO(X, 7) GPIO_ACTIVE_LOW>;
-- 
2.16.2
