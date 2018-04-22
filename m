Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757699AbeDVOWO (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 10:22:14 -0400
Received: from vpn-0-22.aquilenet.fr ([185.233.101.22]:36024 "EHLO
        leonov.paulk.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755522AbeDVOWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 10:22:07 -0400
From: Paul Kocialkowski <contact@paulk.fr>
To: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Russell King <linux@armlinux.org.uk>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Paul Kocialkowski <contact@paulk.fr>
Subject: [PATCH] ARM: dts: imx6qdl-cubox-i: Move card-detect GPIO to 1.5 SOM devices only
Date: Sun, 22 Apr 2018 16:21:51 +0200
Message-Id: <20180422142151.17910-1-contact@paulk.fr>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Solid-Run CuBox-i lower board used in the first generation of
CuBox-i devices feature a hinged micro SD card slot, that does not have
card-detect capability. Since the card-detect GPIO was specified in the
common cubox-i dtsi, it is moved to each device using the 1.5 SOM and is
thus removed from the imx6q-cubox-i dts.

Enabling the card-detect GPIO on the first generation CuBox-i devices
results in waiting for a card-detect event (that never occurs) and thus
not detecting the mmc card.

Since the CD pin is still dedicated to the purpose on the SOM board even
on the first generation CuBox-i devices, the pin control properties are
kept untouched regardless of the slot capability.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 arch/arm/boot/dts/imx6dl-cubox-i-emmc-som-v15.dts | 4 ++++
 arch/arm/boot/dts/imx6dl-cubox-i-som-v15.dts      | 4 ++++
 arch/arm/boot/dts/imx6q-cubox-i-emmc-som-v15.dts  | 4 ++++
 arch/arm/boot/dts/imx6q-cubox-i-som-v15.dts       | 4 ++++
 arch/arm/boot/dts/imx6qdl-cubox-i.dtsi            | 1 -
 5 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6dl-cubox-i-emmc-som-v15.dts b/arch/arm/boot/dts/imx6dl-cubox-i-emmc-som-v15.dts
index 2b2fc360b865..90a15f3b4fc0 100644
--- a/arch/arm/boot/dts/imx6dl-cubox-i-emmc-som-v15.dts
+++ b/arch/arm/boot/dts/imx6dl-cubox-i-emmc-som-v15.dts
@@ -50,3 +50,7 @@
 	model = "SolidRun Cubox-i Solo/DualLite (1.5som+emmc)";
 	compatible = "solidrun,cubox-i/dl", "fsl,imx6dl";
 };
+
+&usdhc2 {
+	cd-gpios = <&gpio1 4 GPIO_ACTIVE_LOW>;
+};
diff --git a/arch/arm/boot/dts/imx6dl-cubox-i-som-v15.dts b/arch/arm/boot/dts/imx6dl-cubox-i-som-v15.dts
index e09c565d1d1f..9bdec07fefe3 100644
--- a/arch/arm/boot/dts/imx6dl-cubox-i-som-v15.dts
+++ b/arch/arm/boot/dts/imx6dl-cubox-i-som-v15.dts
@@ -49,3 +49,7 @@
 	model = "SolidRun Cubox-i Solo/DualLite (1.5som)";
 	compatible = "solidrun,cubox-i/dl", "fsl,imx6dl";
 };
+
+&usdhc2 {
+	cd-gpios = <&gpio1 4 GPIO_ACTIVE_LOW>;
+};
diff --git a/arch/arm/boot/dts/imx6q-cubox-i-emmc-som-v15.dts b/arch/arm/boot/dts/imx6q-cubox-i-emmc-som-v15.dts
index 3e59ebbb3608..679a5431cbdb 100644
--- a/arch/arm/boot/dts/imx6q-cubox-i-emmc-som-v15.dts
+++ b/arch/arm/boot/dts/imx6q-cubox-i-emmc-som-v15.dts
@@ -58,3 +58,7 @@
 	fsl,transmit-atten-16ths = <9>;
 	fsl,no-spread-spectrum;
 };
+
+&usdhc2 {
+	cd-gpios = <&gpio1 4 GPIO_ACTIVE_LOW>;
+};
diff --git a/arch/arm/boot/dts/imx6q-cubox-i-som-v15.dts b/arch/arm/boot/dts/imx6q-cubox-i-som-v15.dts
index dab70d1230a2..b9b8733f13c3 100644
--- a/arch/arm/boot/dts/imx6q-cubox-i-som-v15.dts
+++ b/arch/arm/boot/dts/imx6q-cubox-i-som-v15.dts
@@ -57,3 +57,7 @@
 	fsl,transmit-atten-16ths = <9>;
 	fsl,no-spread-spectrum;
 };
+
+&usdhc2 {
+	cd-gpios = <&gpio1 4 GPIO_ACTIVE_LOW>;
+};
diff --git a/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi b/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi
index d1cfdc264126..170b3d27f875 100644
--- a/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi
@@ -254,7 +254,6 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_cubox_i_usdhc2_aux &pinctrl_cubox_i_usdhc2>;
 	vmmc-supply = <&vcc_3v3>;
-	cd-gpios = <&gpio1 4 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
 
-- 
2.17.0
