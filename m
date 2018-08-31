Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 996B3C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A54A20837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:41:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A54A20837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728591AbeHaUrQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 16:47:16 -0400
Received: from mout.perfora.net ([74.208.4.194]:40965 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728409AbeHaUrP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 16:47:15 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0M6Cey-1fh0Vm38ig-00yC11; Fri, 31 Aug 2018 18:38:42 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 08/34] ARM: tegra: apalis_t30: add missing regulators
Date:   Fri, 31 Aug 2018 18:37:50 +0200
Message-Id: <20180831163817.23970-9-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180831163817.23970-1-marcel@ziswiler.com>
References: <20180831163817.23970-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:wPFjibvPsanX2tlEL0tIkur5Hc+PqsB7cZcgtX9avj6BkB72CF+
 V2dgNu4DMK+JV42Zw5XEkT7Nw6llLOFI5wSWGE51G+HI9fpHCWqLMzkWHqLZ1LNoJn14Zj7
 XRdsEHPz6cAXAAyk+h3V1LCMtrrmRHwothwJKOxxCnNa/5tDkzvMc/g6gP8TwqfDdMMINSj
 3AshW2cGTpuVju2dJgy/A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:PnPr1EaxR3c=:2jjRrZApzOqOgIQj81vyJ/
 4rKeaCs5yMsH/HoXTC581+V8WNxHv8pE7+BuEYAN/3bJZSzAlclRUt7IXee0H8bbfHD47YiQD
 tgPofX+uJY6cAPxEPRZZw9bTZ65t/iKfBc/e15mSD5+GozMcibzuNJt1NbBW5qDH+1y+ilFyp
 eW7zZ0RgZ1u1Mnz/A2W9QcLH41ft1388JnGgM9avLrMHaMNdii+uQDCihmaT6jm1NJ19SMfde
 RNSKKsCMs+7pYb6fgLzlKAIHG19EfiyX9ScKNz9kcg5YfuJTyHh8RDNcBfFsCTOMhxcGrkqaw
 EbHVCogkUO5Z2jNwPXXaoOwyhJTW5uGExMKQjpH0weICymOw1B6jJcCH5qPvJN/vGIc95urpG
 76flitXbncCG1Ld51JhHa8QBYuAri7LHmFYBSwotkIfl9Lgbr48U80SpiuJYtW73OLVwjiY9X
 kpa+jVpsKiloyZVxKNbrNqSKlS/nyKyd5oDZzDz8WScZAMmMH+8Ff7OFe6hZZacUjCWBtPuYr
 zHT+4FuzElN0yKgrFhHlCtX8NBWiDWFFoSZpEV4rL4bFWD735vkC503qOiCovBR7K0DEc3MmI
 c432pChAhihufs3i3bssHWHbKLclgi6Hdco0J3GzgmY/issx3/SRRlHgw5tbL1xNqvl5DVSB6
 OMWPzZV2WcNXFz4uPKguKNnibkTKmGfdVxhfj1H7laiTiD8z112Tma7qXaPoaOYGbJY0=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Add missing regulators:
- reg_module_3v3_audio being VDDA supply of SGTL5000
- VDDD supply of SGTL5000 actually being reg_1v8_vio
- carrier board HDMI supply being reg_5v0
- carrier board reg_3v3 actually being backlight and panel power supply

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2: None

 arch/arm/boot/dts/tegra30-apalis-eval.dts | 10 ++++++++++
 arch/arm/boot/dts/tegra30-apalis.dtsi     | 11 ++++++++++-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra30-apalis-eval.dts b/arch/arm/boot/dts/tegra30-apalis-eval.dts
index 07da481bc441..14a62b5111ec 100644
--- a/arch/arm/boot/dts/tegra30-apalis-eval.dts
+++ b/arch/arm/boot/dts/tegra30-apalis-eval.dts
@@ -41,6 +41,7 @@
 		};
 		hdmi@54280000 {
 			status = "okay";
+			hdmi-supply = <&reg_5v0>;
 		};
 	};
 
@@ -185,6 +186,7 @@
 		default-brightness-level = <6>;
 		/* BKL1_ON */
 		enable-gpios = <&gpio TEGRA_GPIO(V, 2) GPIO_ACTIVE_HIGH>;
+		power-supply = <&reg_3v3>;
 	};
 
 	gpio-keys {
@@ -207,6 +209,7 @@
 		compatible = "edt,et057090dhu", "simple-panel";
 
 		backlight = <&backlight>;
+		power-supply = <&reg_3v3>;
 	};
 
 	pwmleds {
@@ -231,6 +234,13 @@
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
diff --git a/arch/arm/boot/dts/tegra30-apalis.dtsi b/arch/arm/boot/dts/tegra30-apalis.dtsi
index 214a23722ab4..3b2e15519e4b 100644
--- a/arch/arm/boot/dts/tegra30-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra30-apalis.dtsi
@@ -465,7 +465,8 @@
 		sgtl5000: codec@a {
 			compatible = "fsl,sgtl5000";
 			reg = <0x0a>;
-			VDDA-supply = <&reg_module_3v3>;
+			VDDA-supply = <&reg_module_3v3_audio>;
+			VDDD-supply = <&reg_1v8_vio>;
 			VDDIO-supply = <&reg_module_3v3>;
 			clocks = <&tegra_car TEGRA30_CLK_EXTERN1>;
 		};
@@ -758,6 +759,14 @@
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
 		compatible = "toradex,tegra-audio-sgtl5000-apalis_t30",
 			     "nvidia,tegra-audio-sgtl5000";
-- 
2.14.4

