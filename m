Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF48ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D5B120880
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:40:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D5B120880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389002AbeGWNiW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:38:22 -0400
Received: from mout.perfora.net ([74.208.4.194]:41343 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388263AbeGWNiV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:38:21 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPA (Nemesis) id
 0M1pkK-1g1iCZ2s8I-00tmhr; Mon, 23 Jul 2018 14:37:14 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 05/26] ARM: tegra: colibri_t30: add missing regulators
Date:   Mon, 23 Jul 2018 14:36:36 +0200
Message-Id: <20180723123658.980-6-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180723123658.980-1-marcel@ziswiler.com>
References: <20180723123658.980-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:2L9VcMxzyZI1j6eqGPJw7TmqvjuY2VuKI/C0AVrk0Vitz3laII5
 j6HBryr2pjRORkALbF6bL1jICd/JMQbRYcDTYMJKQ+YrQypky8D/H5cPciq9GTsykpoBQlB
 QATuG4aGXWya9knQb+2EE2v1KrZtU0lJL8LhVb4thpxpGs/RLSyn7TPErsfLuz0qeakcRJ6
 B11abZu6i1+/sDDeoA91g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ZMyBkUo5jiY=:THce8KQcJ7uwp6tLxl8lrL
 0dX8eXjkrdKJH7MoZdnVQYOiCSRvvqkntG8TxFzBG4UkjIo4jzW5ssz/seKhPHpmFiVafawaP
 HvymahXtXrxjxUTCOKppWe3Ti76pbJnWJHPwarhcloFxVCcfHnenGKnsGcCpZ1xWvihAqqCXO
 NopbF0x0C+TAaM84JNsVZEfwxRWSeGWu0DAqOs/maqEbibItZiPvTMzQJrSwprWXRrHcsCLhH
 kJ+EEswpotx1ZRCY1o7AIpQfNnb88Qqg4NoggFf8nqveMrujDDdxLiaX4tg5SBKEwCRFE1RmX
 eW8NSSGvaYZNoo1vZDT/waZJpg/P0XhA/O1QDCgCyC7slXJX79o8Iyfy1pBIyUw7ZjUwt/XCq
 HaQCJA3Di6H1XMnQVkMZd9LwmOUoLP0cMl+Qc6043gzHnvutAe6TX7EQs44+wpGFKUtF8li7R
 ps4r2RaY579Ow2cToffHnV+I4yZttGwTjYnhhNgVV5qb9cr5pw2vI0L68iipwCKKstt60T7P+
 VbBEHv9DvUGx1skINhHz9iTAZo+w4T0iY1TCz+9/1PbzHGgfH4ZuVKlUbq2D6MUqYzv2Mqnx0
 ufi3gZotM8xNw+Q+4ZkFD9ISsbZmTtfspKN286f0w2jC8N3ZDFLaUyrgTT1TLE+GN5jYSwRmj
 gJVd62MNxOprYCjty0BVtd/A8mCLd+cJlAQCaoIxVc635ctHHVkDAYAUmDMTOGKw22kA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Add missing regulators:
- reg_module_3v3_audio being VDDA supply of SGTL5000
- VDDD supply of SGTL5000 actually being reg_1v8_vio
- reg_lan_v_bus being USB Ethernet chip vbus supply
- carrier board HDMI supply being reg_5v0
- carrier board reg_3v3 actually being backlight and panel power supply

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra30-colibri-eval-v3.dts | 10 ++++++++++
 arch/arm/boot/dts/tegra30-colibri.dtsi        | 21 ++++++++++++++++++++-
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts b/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
index 5eb665d89435..1c057b285153 100644
--- a/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
+++ b/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
@@ -29,6 +29,7 @@
 		};
 		hdmi@54280000 {
 			status = "okay";
+			hdmi-supply = <&reg_5v0>;
 		};
 	};
 
@@ -127,6 +128,7 @@
 		default-brightness-level = <6>;
 		/* BL_ON */
 		enable-gpios = <&gpio TEGRA_GPIO(V, 2) GPIO_ACTIVE_HIGH>;
+		power-supply = <&reg_3v3>;
 	};
 
 	clocks {
@@ -159,6 +161,7 @@
 		compatible = "edt,et057090dhu", "simple-panel";
 
 		backlight = <&backlight>;
+		power-supply = <&reg_3v3>;
 	};
 
 	pwmleds {
@@ -181,6 +184,13 @@
 		};
 	};
 
+	reg_3v3: regulator-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "3.3V_SW";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
 	reg_5v0: regulator-5v0 {
 		compatible = "regulator-fixed";
 		regulator-name = "5V_SW";
diff --git a/arch/arm/boot/dts/tegra30-colibri.dtsi b/arch/arm/boot/dts/tegra30-colibri.dtsi
index c58bd41a68ae..fedcd2f7912b 100644
--- a/arch/arm/boot/dts/tegra30-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra30-colibri.dtsi
@@ -229,7 +229,8 @@
 		sgtl5000: codec@a {
 			compatible = "fsl,sgtl5000";
 			reg = <0x0a>;
-			VDDA-supply = <&reg_module_3v3>;
+			VDDA-supply = <&reg_module_3v3_audio>;
+			VDDD-supply = <&reg_1v8_vio>;
 			VDDIO-supply = <&reg_module_3v3>;
 			clocks = <&tegra_car TEGRA30_CLK_EXTERN1>;
 		};
@@ -450,6 +451,7 @@
 	usb-phy@7d004000 {
 		status = "okay";
 		nvidia,is-wired = <1>;
+		vbus-supply = <&reg_lan_v_bus>;
 	};
 
 	clocks {
@@ -493,6 +495,15 @@
 		regulator-always-on;
 	};
 
+	reg_lan_v_bus: regulator-lan-v-bus {
+		compatible = "regulator-fixed";
+		regulator-name = "LAN_V_BUS";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		enable-active-high;
+		gpio = <&gpio TEGRA_GPIO(DD, 2) GPIO_ACTIVE_HIGH>;
+	};
+
 	reg_module_3v3: regulator-module-3v3 {
 		compatible = "regulator-fixed";
 		regulator-name = "+V3.3";
@@ -501,6 +512,14 @@
 		regulator-always-on;
 	};
 
+	reg_module_3v3_audio: regulator-module-3v3-audio {
+		compatible = "regulator-fixed";
+		regulator-name = "+V3.3_AUDIO_AVDD_S";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+
 	sound {
 		compatible = "toradex,tegra-audio-sgtl5000-colibri_t30",
 			     "nvidia,tegra-audio-sgtl5000";
-- 
2.14.4

