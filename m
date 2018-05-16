Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752387AbeEPLsk (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 07:48:40 -0400
Received: from olimex.com ([184.105.72.32]:35676 "EHLO olimex.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751844AbeEPLsi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 07:48:38 -0400
From: Stefan Mavrodiev <stefan@olimex.com>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-kernel@vger.kernel.org (open list),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Allwinner
        sunXi SoC support)
Cc: linux-sunxi@googlegroups.com, Stefan Mavrodiev <stefan@olimex.com>
Subject: [PATCH 1/1] ARM:dts:sunxi: Add Olimex A20-SOM-EVB-eMMC board
Date: Wed, 16 May 2018 14:38:08 +0300
Message-Id: <1526470689-6275-1-git-send-email-stefan@olimex.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the new rev.E of A20-SOM-EVB, there is option for 16GB eMMC.
Currently used card is KLMAG2GEND, wired to MMC2 slot.

Signed-off-by: Stefan Mavrodiev <stefan@olimex.com>
---
 arch/arm/boot/dts/Makefile                         |  1 +
 .../arm/boot/dts/sun7i-a20-olimex-som-evb-emmc.dts | 37 ++++++++++++++++++++++
 2 files changed, 38 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun7i-a20-olimex-som-evb-emmc.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 1db91ec..7f1ee65 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -959,6 +959,7 @@ dtb-$(CONFIG_MACH_SUN7I) += \
 	sun7i-a20-m3.dtb \
 	sun7i-a20-mk808c.dtb \
 	sun7i-a20-olimex-som-evb.dtb \
+	sun7i-a20-olimex-som-evb-emmc.dtb \
 	sun7i-a20-olimex-som204-evb.dtb \
 	sun7i-a20-olimex-som204-evb-emmc.dtb \
 	sun7i-a20-olinuxino-lime.dtb \
diff --git a/arch/arm/boot/dts/sun7i-a20-olimex-som-evb-emmc.dts b/arch/arm/boot/dts/sun7i-a20-olimex-som-evb-emmc.dts
new file mode 100644
index 0000000..81ebc97
--- /dev/null
+++ b/arch/arm/boot/dts/sun7i-a20-olimex-som-evb-emmc.dts
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Device Tree Source for A20-Olimex-SOM-EVB-eMMC Board
+ *
+ * Copyright (C) 2018 Olimex Ltd.
+ *   Author: Stefan Mavrodiev <stefan@olimex.com>
+ */
+
+/dts-v1/;
+#include "sun7i-a20-olimex-som-evb.dts"
+
+/ {
+
+	model = "Olimex A20-Olimex-SOM-EVB-eMMC";
+	compatible = "olimex,a20-olimex-som-evb-emmc", "allwinner,sun7i-a20";
+
+	mmc2_pwrseq: mmc2_pwrseq {
+		compatible = "mmc-pwrseq-emmc";
+		reset-gpios = <&pio 2 18 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&mmc2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc2_pins_a>;
+	vmmc-supply = <&reg_vcc3v3>;
+	mmc-pwrseq = <&mmc2_pwrseq>;
+	bus-width = <4>;
+	non-removable;
+	status = "okay";
+
+	emmc: emmc@0 {
+		reg = <0>;
+		compatible = "mmc-card";
+		broken-hpi;
+	};
+};
-- 
2.7.4
