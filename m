Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D182BC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94F2C20834
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:08:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94F2C20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730014AbeH3TKx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 15:10:53 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:11617 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728709AbeH3TKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 15:10:52 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5b88085d0000>; Thu, 30 Aug 2018 08:08:13 -0700
Received: from HQMAIL103.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 30 Aug 2018 08:08:16 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 30 Aug 2018 08:08:16 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 30 Aug
 2018 15:08:16 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Thu, 30 Aug 2018 15:08:16 +0000
Received: from dhcp-10-21-25-168.Nvidia.com (Not Verified[10.21.25.201]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5b88085d0000>; Thu, 30 Aug 2018 08:08:15 -0700
From:   Aapo Vienamo <avienamo@nvidia.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Stefan Agner <stefan@agner.ch>
CC:     <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        Aapo Vienamo <avienamo@nvidia.com>
Subject: [PATCH v3 29/38] arm64: dts: Add Tegra186 sdmmc pinctrl voltage states
Date:   Thu, 30 Aug 2018 18:06:30 +0300
Message-ID: <20180830150639.21048-30-avienamo@nvidia.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180830150639.21048-1-avienamo@nvidia.com>
References: <20180830150639.21048-1-avienamo@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pad voltage configuration nodes for sdmmc pads with configurable
voltages on Tegra186.

Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra186.dtsi | 40 ++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
index b762227f6aa1..7669756c060f 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
@@ -4,6 +4,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/mailbox/tegra186-hsp.h>
 #include <dt-bindings/memory/tegra186-mc.h>
+#include <dt-bindings/pinctrl/pinctrl-tegra-io-pad.h>
 #include <dt-bindings/power/tegra186-powergate.h>
 #include <dt-bindings/reset/tegra186-reset.h>
 #include <dt-bindings/thermal/tegra186-bpmp-thermal.h>
@@ -236,6 +237,9 @@
 		clock-names = "sdhci";
 		resets = <&bpmp TEGRA186_RESET_SDMMC1>;
 		reset-names = "sdhci";
+		pinctrl-names = "sdmmc-3v3", "sdmmc-1v8";
+		pinctrl-0 = <&sdmmc1_3v3>;
+		pinctrl-1 = <&sdmmc1_1v8>;
 		status = "disabled";
 	};
 
@@ -247,6 +251,9 @@
 		clock-names = "sdhci";
 		resets = <&bpmp TEGRA186_RESET_SDMMC2>;
 		reset-names = "sdhci";
+		pinctrl-names = "sdmmc-3v3", "sdmmc-1v8";
+		pinctrl-0 = <&sdmmc2_3v3>;
+		pinctrl-1 = <&sdmmc2_1v8>;
 		status = "disabled";
 	};
 
@@ -258,6 +265,9 @@
 		clock-names = "sdhci";
 		resets = <&bpmp TEGRA186_RESET_SDMMC3>;
 		reset-names = "sdhci";
+		pinctrl-names = "sdmmc-3v3", "sdmmc-1v8";
+		pinctrl-0 = <&sdmmc3_3v3>;
+		pinctrl-1 = <&sdmmc3_1v8>;
 		status = "disabled";
 	};
 
@@ -368,6 +378,36 @@
 		      <0 0x0c380000 0 0x10000>,
 		      <0 0x0c390000 0 0x10000>;
 		reg-names = "pmc", "wake", "aotag", "scratch";
+
+		sdmmc1_3v3: sdmmc1-3v3 {
+			pins = "sdmmc1-hv";
+			power-source = <TEGRA_IO_PAD_VOLTAGE_3V3>;
+		};
+
+		sdmmc1_1v8: sdmmc1-1v8 {
+			pins = "sdmmc1-hv";
+			power-source = <TEGRA_IO_PAD_VOLTAGE_1V8>;
+		};
+
+		sdmmc2_3v3: sdmmc2-3v3 {
+			pins = "sdmmc2-hv";
+			power-source = <TEGRA_IO_PAD_VOLTAGE_3V3>;
+		};
+
+		sdmmc2_1v8: sdmmc2-1v8 {
+			pins = "sdmmc2-hv";
+			power-source = <TEGRA_IO_PAD_VOLTAGE_1V8>;
+		};
+
+		sdmmc3_3v3: sdmmc3-3v3 {
+			pins = "sdmmc3-hv";
+			power-source = <TEGRA_IO_PAD_VOLTAGE_3V3>;
+		};
+
+		sdmmc3_1v8: sdmmc3-1v8 {
+			pins = "sdmmc3-hv";
+			power-source = <TEGRA_IO_PAD_VOLTAGE_1V8>;
+		};
 	};
 
 	ccplex@e000000 {
-- 
2.18.0

