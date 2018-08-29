Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 453FBC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 067802086B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:14:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 067802086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728280AbeH2MKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 08:10:21 -0400
Received: from mout.perfora.net ([74.208.4.197]:42419 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727107AbeH2MKU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 08:10:20 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MPWlD-1fzaK90yXZ-004ijX; Wed, 29 Aug 2018 10:14:32 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 09/31] ARM: tegra: colibri_t20: add missing regulators
Date:   Wed, 29 Aug 2018 10:13:45 +0200
Message-Id: <20180829081407.11304-10-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180829081407.11304-1-marcel@ziswiler.com>
References: <20180829081407.11304-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:A8g6ZqhPajAn9v1WU19/nZjOJwEszerCHMus9wI6sIUI2UpjZtN
 BAaiS7XPKfSkUrK7N2+Ecsaj7P/aWwjbzhe+n+GS3Vo5p0q0DsXnwP4m7qih/qi2Xir/Aa9
 /wZhbkWKuxlNQuPHQongZ2D1unhlHmdqHnBB7F01PnvRk87zbvJ1rSSmPJ5/Wu/5ebnDLk6
 FLR6P59i3Mg63f0FUp5Tw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:kiK+Kp6LRWE=:Pg8yopNNsmwLSQHlDKLpaY
 HqE187qR4aUgpr3zuWzRrDrsNcm6hwdrYhygpuU4/G2QHr/O22+NOsS75fbCl+iBTABDLIYRW
 nrp5D4+e7nsrezWPZfv7pSeMouDw1OVlfEkSXiq6lUNneUn4q8wlrMXsO7kcdybXomRIlcMSK
 j3AZAMaSAQgNIsqbCVO0fHr+qD2MvmDeMM06IsorkL3E2Y7KqUAWSKjqlWArApZbiQs1w+lIo
 ubJIwv8u1oNcvgGQavLUdNYVIU7gxsIALzunyQEVc/55GJUCq1+7PZzaDVAZX+fEm7k4a44oC
 OuhmtsL2YhYQrhllmIjuWv5LAA72mwwFKoUoDJpzBHq1AFbNrf+XbglZuSCorCPP+1zwUsFGR
 6a8XT2m52+d2foTdwbb0ai2Bb/xpu6X6Vmf278P4J25Q5W66uJVZ91IDhSxL+maqttT/7AaVt
 hzaR8SneaMOOQ7f7OYwlrTJBzR2QnwyQ/ehIKa5y0qyY0bS+RZV/Wo+5BqR2M12mPH/fdPxCP
 LPM81rOka3WGYKePiadDh/V2mxa6yOKoFY9vV9MPFLh16Bl2MoEZ93Oi8y7T1fD2pK7dZ7V9w
 tqRk3IZuYaSgz+SkHoOA/nGYjn3jYwkOPlHTLGRbkq+LBejcRRXcDbc6RYAUfuPLdBIY7gsy7
 0Q7goauc4iPbA9UudqzE8vSOhYhLqiJXyNVMwHTDstc3dW4qGrBlhUGaECQFNP1z2Pvs=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Add missing regulators:
- reg_lan_v_bus being USB Ethernet chip vbus supply
- carrier board reg_3v3 to be used as backlight and panel power supply
- carrier board HDMI supply being reg_5v0
- reg_usbc_vbus being the USB vbus supply of the EHCI instance 0

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra20-colibri-iris.dts | 28 ++++++++++++++++++++++++++--
 arch/arm/boot/dts/tegra20-colibri.dtsi     |  1 +
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20-colibri-iris.dts b/arch/arm/boot/dts/tegra20-colibri-iris.dts
index 6f89a417b0f2..9f0a819c68f2 100644
--- a/arch/arm/boot/dts/tegra20-colibri-iris.dts
+++ b/arch/arm/boot/dts/tegra20-colibri-iris.dts
@@ -23,6 +23,7 @@
 	host1x@50000000 {
 		hdmi@54280000 {
 			status = "okay";
+			hdmi-supply = <&reg_5v0>;
 		};
 	};
 
@@ -88,6 +89,7 @@
 
 	usb-phy@c5000000 {
 		status = "okay";
+		vbus-supply = <&reg_usbc_vbus>;
 	};
 
 	usb@c5008000 {
@@ -96,6 +98,7 @@
 
 	usb-phy@c5008000 {
 		status = "okay";
+		vbus-supply = <&reg_usbh_vbus>;
 	};
 
 	sdhci@c8000600 {
@@ -104,14 +107,35 @@
 		no-1-8-v;
 	};
 
+	reg_3v3: regulator-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "3.3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	reg_5v0: regulator-5v0 {
+		compatible = "regulator-fixed";
+		regulator-name = "5V";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+	};
+
+	reg_usbc_vbus: regulator-usbc-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "VCC_USB2";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&reg_5v0>;
+	};
+
 	/* USBH_PEN resp. USB_P_EN */
 	reg_usbh_vbus: regulator-usbh-vbus {
 		compatible = "regulator-fixed";
 		regulator-name = "VCC_USB1";
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
-		regulator-boot-on;
-		regulator-always-on;
 		gpio = <&gpio TEGRA_GPIO(W, 2) GPIO_ACTIVE_LOW>;
+		vin-supply = <&reg_5v0>;
 	};
 };
diff --git a/arch/arm/boot/dts/tegra20-colibri.dtsi b/arch/arm/boot/dts/tegra20-colibri.dtsi
index 1cf64f197c08..5e98f225322b 100644
--- a/arch/arm/boot/dts/tegra20-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra20-colibri.dtsi
@@ -471,6 +471,7 @@
 		status = "okay";
 		nvidia,phy-reset-gpio = <&gpio TEGRA_GPIO(V, 1)
 			GPIO_ACTIVE_LOW>;
+		vbus-supply = <&reg_lan_v_bus>;
 	};
 
 	sdhci@c8000600 {
-- 
2.14.4

