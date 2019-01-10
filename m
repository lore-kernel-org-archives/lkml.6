Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E01C3C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 22:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A46B2214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 22:46:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="WAcTVK8z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729673AbfAJWqL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 17:46:11 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:17261 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728008AbfAJWqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 17:46:08 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c37cb1c0000>; Thu, 10 Jan 2019 14:45:48 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 10 Jan 2019 14:46:06 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 10 Jan 2019 14:46:06 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 10 Jan
 2019 22:46:06 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Thu, 10 Jan 2019 22:46:06 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.110.103.52]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c37cb2d0001>; Thu, 10 Jan 2019 14:46:05 -0800
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <mperttunen@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <adrian.hunter@intel.com>,
        <ulf.hansson@linaro.org>
CC:     <anrao@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V4 2/3] arm64: dts: tegra: Add SDMMC Auto-cal settings
Date:   Thu, 10 Jan 2019 14:46:02 -0800
Message-ID: <1547160363-25323-2-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547160363-25323-1-git-send-email-skomatineni@nvidia.com>
References: <1547160363-25323-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1547160348; bh=RWM2GTbeptX66p5GbZKMEkVtwxSPrW64qCpcXMVM4iw=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=WAcTVK8zDKCBSP8fN1I70X5rcIa9PAOg3WVj4GnZPU6VwgOZNr2moA1UPRGLUwIIk
         uPpJ1cKiwKx4ReIutRYTexJzyJMshQ6SPPDKw7BhS6kZKiExrLfM1Ur+PPmLgyZxKR
         SAM+y0LOq/3jdvSFxrhRRFND0cUv8GO7zHL8CFrq1UWlNk5LwaxVPaAnHAlt7dv4ll
         4PSgpFJV8HyOJF1Wbm/4KV29XCOHf9AOhg1VmQzKkTZOzqtHUq7uU97RpZLgqrjVah
         rNpuzEvgRiv0Lbo7XY6nDjmnVTvVnSqI5WEd0j3lBJ8+iZ+z/FWFUlZdD0e3FzluQC
         2jAhuG7zqmQ7A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SDMMC initial pad offsets used by auto calibration process.

Add SDMMC fixed drive strengths for Tegra210, Tegra186 and
Tegra194 which are used when calibration timeouts.

Fixed drive strengths are based on Pre SI Analysis of the pads.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra186.dtsi |  2 ++
 arch/arm64/boot/dts/nvidia/tegra194.dtsi | 34 +++++++++++++++++++
 arch/arm64/boot/dts/nvidia/tegra210.dtsi | 57 ++++++++++++++++++++++++++++++--
 3 files changed, 91 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
index 22815db4a3ed..169aee59ceac 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
@@ -315,6 +315,8 @@
 		nvidia,pad-autocal-pull-down-offset-hs400 = <0x05>;
 		nvidia,pad-autocal-pull-up-offset-1v8-timeout = <0x0a>;
 		nvidia,pad-autocal-pull-down-offset-1v8-timeout = <0x0a>;
+		nvidia,pad-autocal-pull-up-offset-3v3-timeout = <0x0a>;
+		nvidia,pad-autocal-pull-down-offset-3v3-timeout = <0x0a>;
 		nvidia,default-tap = <0x5>;
 		nvidia,default-trim = <0x9>;
 		nvidia,dqs-trim = <63>;
diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index 6dfa1ca0b851..596a36705c0f 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -303,6 +303,17 @@
 			clock-names = "sdhci";
 			resets = <&bpmp TEGRA194_RESET_SDMMC1>;
 			reset-names = "sdhci";
+			nvidia,pad-autocal-pull-up-offset-3v3-timeout =
+									<0x07>;
+			nvidia,pad-autocal-pull-down-offset-3v3-timeout =
+									<0x07>;
+			nvidia,pad-autocal-pull-up-offset-1v8-timeout = <0x06>;
+			nvidia,pad-autocal-pull-down-offset-1v8-timeout =
+									<0x07>;
+			nvidia,pad-autocal-pull-up-offset-sdr104 = <0x00>;
+			nvidia,pad-autocal-pull-down-offset-sdr104 = <0x00>;
+			nvidia,default-tap = <0x9>;
+			nvidia,default-trim = <0x5>;
 			status = "disabled";
 		};
 
@@ -314,6 +325,18 @@
 			clock-names = "sdhci";
 			resets = <&bpmp TEGRA194_RESET_SDMMC3>;
 			reset-names = "sdhci";
+			nvidia,pad-autocal-pull-up-offset-1v8 = <0x00>;
+			nvidia,pad-autocal-pull-down-offset-1v8 = <0x7a>;
+			nvidia,pad-autocal-pull-up-offset-3v3-timeout = <0x07>;
+			nvidia,pad-autocal-pull-down-offset-3v3-timeout =
+									<0x07>;
+			nvidia,pad-autocal-pull-up-offset-1v8-timeout = <0x06>;
+			nvidia,pad-autocal-pull-down-offset-1v8-timeout =
+									<0x07>;
+			nvidia,pad-autocal-pull-up-offset-sdr104 = <0x00>;
+			nvidia,pad-autocal-pull-down-offset-sdr104 = <0x00>;
+			nvidia,default-tap = <0x9>;
+			nvidia,default-trim = <0x5>;
 			status = "disabled";
 		};
 
@@ -325,6 +348,17 @@
 			clock-names = "sdhci";
 			resets = <&bpmp TEGRA194_RESET_SDMMC4>;
 			reset-names = "sdhci";
+			nvidia,pad-autocal-pull-up-offset-hs400 = <0x00>;
+			nvidia,pad-autocal-pull-down-offset-hs400 = <0x00>;
+			nvidia,pad-autocal-pull-up-offset-1v8-timeout = <0x0a>;
+			nvidia,pad-autocal-pull-down-offset-1v8-timeout =
+									<0x0a>;
+			nvidia,pad-autocal-pull-up-offset-3v3-timeout = <0x0a>;
+			nvidia,pad-autocal-pull-down-offset-3v3-timeout =
+									<0x0a>;
+			nvidia,default-tap = <0x8>;
+			nvidia,default-trim = <0x14>;
+			nvidia,dqs-trim = <40>;
 			status = "disabled";
 		};
 
diff --git a/arch/arm64/boot/dts/nvidia/tegra210.dtsi b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
index 2205d66b0443..41408df9d4e9 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
@@ -476,6 +476,48 @@
 		compatible = "nvidia,tegra210-pinmux";
 		reg = <0x0 0x700008d4 0x0 0x29c>, /* Pad control registers */
 		      <0x0 0x70003000 0x0 0x294>; /* Mux registers */
+		sdmmc1_3v3_drv: sdmmc1-3v3-drv {
+			sdmmc1 {
+				nvidia,pins = "drive_sdmmc1";
+				nvidia,pull-down-strength = <0x8>;
+				nvidia,pull-up-strength = <0x8>;
+			};
+		};
+		sdmmc1_1v8_drv: sdmmc1-1v8-drv {
+			sdmmc1 {
+				nvidia,pins = "drive_sdmmc1";
+				nvidia,pull-down-strength = <0x4>;
+				nvidia,pull-up-strength = <0x3>;
+			};
+		};
+		sdmmc2_1v8_drv: sdmmc2-1v8-drv {
+			sdmmc2 {
+				nvidia,pins = "drive_sdmmc2";
+				nvidia,pull-down-strength = <0x10>;
+				nvidia,pull-up-strength = <0x10>;
+			};
+		};
+		sdmmc3_3v3_drv: sdmmc3-3v3-drv {
+			sdmmc3 {
+				nvidia,pins = "drive_sdmmc3";
+				nvidia,pull-down-strength = <0x8>;
+				nvidia,pull-up-strength = <0x8>;
+			};
+		};
+		sdmmc3_1v8_drv: sdmmc3-1v8-drv {
+			sdmmc3 {
+				nvidia,pins = "drive_sdmmc3";
+				nvidia,pull-down-strength = <0x4>;
+				nvidia,pull-up-strength = <0x3>;
+			};
+		};
+		sdmmc4_1v8_drv: sdmmc4-1v8-drv {
+			sdmmc4 {
+				nvidia,pins = "drive_sdmmc4";
+				nvidia,pull-down-strength = <0x10>;
+				nvidia,pull-up-strength = <0x10>;
+			};
+		};
 	};
 
 	/*
@@ -1050,9 +1092,12 @@
 		clock-names = "sdhci";
 		resets = <&tegra_car 14>;
 		reset-names = "sdhci";
-		pinctrl-names = "sdmmc-3v3", "sdmmc-1v8";
+		pinctrl-names = "sdmmc-3v3", "sdmmc-1v8",
+				"sdmmc-3v3-drv", "sdmmc-1v8-drv";
 		pinctrl-0 = <&sdmmc1_3v3>;
 		pinctrl-1 = <&sdmmc1_1v8>;
+		pinctrl-2 = <&sdmmc1_3v3_drv>;
+		pinctrl-3 = <&sdmmc1_1v8_drv>;
 		nvidia,pad-autocal-pull-up-offset-3v3 = <0x00>;
 		nvidia,pad-autocal-pull-down-offset-3v3 = <0x7d>;
 		nvidia,pad-autocal-pull-up-offset-1v8 = <0x7b>;
@@ -1075,6 +1120,8 @@
 		clock-names = "sdhci";
 		resets = <&tegra_car 9>;
 		reset-names = "sdhci";
+		pinctrl-names = "sdmmc-1v8-drv";
+		pinctrl-0 = <&sdmmc2_1v8_drv>;
 		nvidia,pad-autocal-pull-up-offset-1v8 = <0x05>;
 		nvidia,pad-autocal-pull-down-offset-1v8 = <0x05>;
 		nvidia,default-tap = <0x8>;
@@ -1090,9 +1137,12 @@
 		clock-names = "sdhci";
 		resets = <&tegra_car 69>;
 		reset-names = "sdhci";
-		pinctrl-names = "sdmmc-3v3", "sdmmc-1v8";
+		pinctrl-names = "sdmmc-3v3", "sdmmc-1v8",
+				"sdmmc-3v3-drv", "sdmmc-1v8-drv";
 		pinctrl-0 = <&sdmmc3_3v3>;
 		pinctrl-1 = <&sdmmc3_1v8>;
+		pinctrl-2 = <&sdmmc3_3v3_drv>;
+		pinctrl-3 = <&sdmmc3_1v8_drv>;
 		nvidia,pad-autocal-pull-up-offset-3v3 = <0x00>;
 		nvidia,pad-autocal-pull-down-offset-3v3 = <0x7d>;
 		nvidia,pad-autocal-pull-up-offset-1v8 = <0x7b>;
@@ -1110,6 +1160,9 @@
 		clock-names = "sdhci";
 		resets = <&tegra_car 15>;
 		reset-names = "sdhci";
+		pinctrl-names = "sdmmc-3v3-drv", "sdmmc-1v8-drv";
+		pinctrl-0 = <&sdmmc4_1v8_drv>;
+		pinctrl-1 = <&sdmmc4_1v8_drv>;
 		nvidia,pad-autocal-pull-up-offset-1v8 = <0x05>;
 		nvidia,pad-autocal-pull-down-offset-1v8 = <0x05>;
 		nvidia,default-tap = <0x8>;
-- 
2.7.4

