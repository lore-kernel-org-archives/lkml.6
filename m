Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA451C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 08:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D5C52083C
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 08:16:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D5C52083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbeIAMYY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 08:24:24 -0400
Received: from mout.perfora.net ([74.208.4.196]:42101 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725819AbeIAMYY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 08:24:24 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MRV42-1gKAh91zAG-00Sge0; Sat, 01 Sep 2018 10:13:07 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 04/34] ARM: tegra: colibri_t30: add missing regulators
Date:   Sat,  1 Sep 2018 10:12:18 +0200
Message-Id: <20180901081248.22639-5-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180901081248.22639-1-marcel@ziswiler.com>
References: <20180901081248.22639-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:Air4tchrcg2Zsvh9IKEFU/tU42Z557kVy2oQaoH1zhj734Ixjsp
 iimDrZlDjgGj4kx/S4eXumXOtZyzrMh9PtnkMlPCEty5XgMcuUes/Bt0Pki7PXaSWPb/ZPQ
 Xovm+Uk6gKZfjWi5ykrJEf20fJUnQZ8N4KBAakahaEabzfVQ/cpjSywt7Olt86jkfLgU/XK
 VDjXXMj6KdeRWw4ha5D0A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:xqUdSYLVsxc=:CZCSY0YvclOjdZVPT4PQzV
 KoE6ovynga+ku8xYqOkg5+UYNriUjID60kFlmnmuSXvjjlynnOA8gCDgDMrJ2Htg5guZjI8ws
 vgyj5KDQ+354IhIEQrrZ6QMSWBlIqsBeVkwPqS11kZ/6zEPMdzcNELtEJcsUHWtgeU2OhQ3fB
 JuW+sHeElSfxOL+mjUtejWlyoeiMwuTFiwilZF9NIejZ/Mra0qT38nkyf+epMzNsSS9jy/CZT
 /7nHKwwOwDoDn96bqrC4i7vTz122KOlNaExnYnIpsm/8qe+G6dU+6kdh04XFomKj4Xr2KkPSo
 TQ2QfW11gDQ5oCyTDXHQYF9G5MLzH8xmKf5lp3ikS9sOCIZn6SOH4vnuIzy0w8TcniC0Cxb61
 SOpkoYIRTi+SW3+2V4HMSCW9h0ussIbaR3JTjKjADUkEyihfHC/+aBNtVb27Nz4tGih59zepi
 UmCY8NeLm8M3cebWjU4X8RPoaSfBNI/tZZIPHqy6nXFbrDvb6hn67DUjTSfZCHauEj/etW4Jc
 GyA1aQMuMXWxfH46VKSV1pU4ZjOeFEa348SZ7o+alfLE/qFteUXZ8mWerlspFB9O1d5wcALVs
 K1ld4Tp7niXrkH8DXe4E1bFU4ALcUM8H+ZpPSuQKaxsWaJ82iGWM6P+DBya/qUx0AkYMF1OBF
 6lXd5Jae549hdbf6+1DtzV2ltDDCKwd2iM0L2dA5Fp2ouJbLV/wczr8tX++g6KK0z30E=
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

Changes in v2: None

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
index 4d7ed25bd594..dc54eb734f64 100644
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
@@ -442,6 +443,7 @@
 	usb-phy@7d004000 {
 		status = "okay";
 		nvidia,is-wired = <1>;
+		vbus-supply = <&reg_lan_v_bus>;
 	};
 
 	clocks {
@@ -485,6 +487,15 @@
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
@@ -493,6 +504,14 @@
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

