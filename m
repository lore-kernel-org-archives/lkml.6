Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C3AC6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 16:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEBF720874
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 16:52:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEBF720874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731386AbeGVRtf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 13:49:35 -0400
Received: from mout.perfora.net ([74.208.4.197]:34067 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730548AbeGVRrY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 13:47:24 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0Lxv8M-1g23WI1l5A-015Jhz; Sun, 22 Jul 2018 18:50:02 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 09/28] ARM: tegra: apalis_t30: add missing regulators
Date:   Sun, 22 Jul 2018 18:49:17 +0200
Message-Id: <20180722164936.20581-10-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180722164936.20581-1-marcel@ziswiler.com>
References: <20180722164936.20581-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:rp7IfhmDvI/5Ie3AQnoYrIp5z9Womjg+IthROkBMwoi4L2U6iEk
 qCmUqrlZs8IeXvC+4mlhXgpxee8znwjZYzD6yiTsK9rm8WSnSsfAZjbVkkWLVU8asuOHa0T
 cpHR9IQLF23HpIVqhaGrT6sVI2TadKbLtIchozsBSM/nfpDuaPQ35F7Yqd20mTfxG33GWey
 J8GqMlLn9ZdtMxLELc2kg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:21cm9bdQY4o=:a3ZFFpmkZ+oR6+tXjx9x6D
 mfB9EYmb11X3hbGA60btH30a/jM9o3ZhKSajxAqrTK861qbhB4NWZovCz9dlA9Gphkg1ysWhy
 DC4oxrT3LEHmrftL+ZR5g2l/sie1P2g0YXjfN0z9flSSjV9GIFeRb8uNbDieMhgACezJt1oTx
 0ffQMpGGwBl5800PWAsjVMj2dDp7u3nLQAWPms/IW98EGpQCkKF87ol0dmZTl8jSEUkm3/lhd
 s/37C/fhB6ZzsfKu3BtrHqy9qKPfVpQPw2W8Zx00/yOODQv7ZOv3345GDFyYup06dgtmNfDYb
 c1TdL/APy4JClEhl/rHqtjRRP1FMbby3tYYT8BSKoTg/hqbwb0heyRC1PxHyKajnJL98+YRlg
 zq7rYTj44HQkw6VNwkDoj0u9+81XbM3fCe7vSrrzrUWEW/LxzzsaJtn7zTwgLqc0Ov6q8t9iW
 VWGSLBDV9D8MqneTKQJwnUJlZ6BSzmcOVzO+lmG99KKUsP7osu0+aWciyAtURRKjKgKFCGd+3
 lSVKfOnOSt21Lj8gJG0DTmpCvSi4PnaeQlTWnjMQuHwjhR6hBygNkUcPldm1F8lVtTsfFR3AX
 CI4IForTjHOBXsGg58MAR9hTl+Bk+FwAvP5cuLJKFrj2rbS0PPeXa4A1kAue8sHukymo54EXQ
 zgNfCELvb8c4xoHdeRZO0fiP1QeteS8GsTOVNHW3avQ2kVorgRGY7rFDHSnXayICBUz8=
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

 arch/arm/boot/dts/tegra30-apalis-eval.dts | 10 ++++++++++
 arch/arm/boot/dts/tegra30-apalis.dtsi     | 11 ++++++++++-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra30-apalis-eval.dts b/arch/arm/boot/dts/tegra30-apalis-eval.dts
index 85e6adc82515..05f3656c058c 100644
--- a/arch/arm/boot/dts/tegra30-apalis-eval.dts
+++ b/arch/arm/boot/dts/tegra30-apalis-eval.dts
@@ -47,6 +47,7 @@
 		};
 		hdmi@54280000 {
 			status = "okay";
+			hdmi-supply = <&reg_5v0>;
 		};
 	};
 
@@ -191,6 +192,7 @@
 		default-brightness-level = <6>;
 		/* BKL1_ON */
 		enable-gpios = <&gpio TEGRA_GPIO(V, 2) GPIO_ACTIVE_HIGH>;
+		power-supply = <&reg_3v3>;
 	};
 
 	gpio-keys {
@@ -213,6 +215,7 @@
 		compatible = "edt,et057090dhu", "simple-panel";
 
 		backlight = <&backlight>;
+		power-supply = <&reg_3v3>;
 	};
 
 	pwmleds {
@@ -237,6 +240,13 @@
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
index 45c0066984fe..ef181d13be31 100644
--- a/arch/arm/boot/dts/tegra30-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra30-apalis.dtsi
@@ -463,7 +463,8 @@
 		sgtl5000: codec@a {
 			compatible = "fsl,sgtl5000";
 			reg = <0x0a>;
-			VDDA-supply = <&reg_module_3v3>;
+			VDDA-supply = <&reg_module_3v3_audio>;
+			VDDD-supply = <&reg_1v8_vio>;
 			VDDIO-supply = <&reg_module_3v3>;
 			clocks = <&tegra_car TEGRA30_CLK_EXTERN1>;
 		};
@@ -764,6 +765,14 @@
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

