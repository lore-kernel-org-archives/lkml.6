Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 267FCC43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 10:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC01720841
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 10:12:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC01720841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbeIBO1z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 10:27:55 -0400
Received: from mout.perfora.net ([74.208.4.196]:59505 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727357AbeIBOYz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 10:24:55 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MJV9h-1ftOFR2j5n-003AuW; Sun, 02 Sep 2018 12:09:35 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 09/37] ARM: tegra: colibri_t20: add missing regulators
Date:   Sun,  2 Sep 2018 12:08:38 +0200
Message-Id: <20180902100906.25792-10-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180902100906.25792-1-marcel@ziswiler.com>
References: <20180902100906.25792-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:8Lal8Tu61boKioVqeCyCu74CsD+so6DpS51tQ/mQ8FBaXYWqMWP
 2IqbV+4D9BXKsqeHUMxfLPoW7oyfSLCHOQn+5qwAOFhRS/6LdO5LSVU1GGrJszIvM0h8yq2
 /jEZzE0WSY1XmWPmW0F3M1dZSiwn7f4TxGbDYb2ACWI+3B/CQqcLbe7x/qGxi+oWFCwOhXA
 r4QAcWiNr70TTqR63uBBg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:axr7QiYHNqs=:HmTg0TjaqYoOjtHh28UYjx
 dXW8tGRHFyPdKlvqVba/BgeGA0vhp5gRjDvDlFcWoWZuOCxWT88aRrhZflvq3tSOwypjdMPMd
 6LZf418zzK9jO4miSQkoWz46B2GouljvDyQL1N6f0P80ZdyXTlV9H5ezpjEi7RuErcvcUZ/38
 9EWFUUAB7uUS2491tgmI+M3IYhdIK4Y6lErIIMS4KFGBpwDror7opGBSClfxtQ/mX+4Aek7d4
 VcLBhQPaO/y0WV2H7L1xcKdBsMQSqXZGm7aEYiBuIOPunU4FzJKZWL2VTaUOr7WTzf7eJ3p7f
 bt12MXpcZuDUSfAwtMIQUIjQmmf8QFoUmOwsCapj47qlQfjOA6EC9xR1y5eNC7aT4TYfdqNOy
 l5Hxpm+fLuKzR6idFbuPg/y2AEsFy+/9PM2xIdo6mD2i9GLrO0YZDxqCrBEyo6uaIO4jn8K4e
 IV5hxfh3sxI5QSVrfUpJpZklBUbT3EuQkuvTWYRpD5EJ5bJ8DwM6UWHqmLZ8rwszjTw3rDoI4
 dKtx7mg6rMkgsJy4GuWOON+fFkA0oQ1KHhS6cWi//10Xw3zuNSsrqaxvybZsP8sKKcTAGueOu
 7/ozyva/blcIYK6U1A5TuqeaW36ITbByTPeFxLZBrBFiDvjVQY3GKej5BjMvzFeOwZoAt9Hhq
 ZD5pp2jjL3CYmNtFUoWQdkcOeA9vYgDavhhK1Ro/xUU7yKQW9mI3n5MXVYlLh2PcJY04=
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

Changes in v2: None

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

