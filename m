Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01911C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 02:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE80F21905
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 02:16:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Qu0AtA7m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403793AbeLUCQH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 21:16:07 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:1179 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728307AbeLUCQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 21:16:07 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c1c4cdb0000>; Thu, 20 Dec 2018 18:15:56 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 20 Dec 2018 18:16:06 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 20 Dec 2018 18:16:06 -0800
Received: from HQMAIL110.nvidia.com (172.18.146.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 21 Dec
 2018 02:16:06 +0000
Received: from HQMAIL106.nvidia.com (172.18.146.12) by hqmail110.nvidia.com
 (172.18.146.15) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 21 Dec
 2018 02:16:05 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Fri, 21 Dec 2018 02:16:05 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.110.103.52]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c1c41050001>; Thu, 20 Dec 2018 17:25:30 -0800
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <mperttunen@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <adrian.hunter@intel.com>,
        <ulf.hansson@linaro.org>
CC:     <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        "Sowjanya Komatineni" <skomatineni@nvidia.com>
Subject: [PATCH V5 2/3] arm64: dtsi: Fix SDMMC address range
Date:   Thu, 20 Dec 2018 17:25:08 -0800
Message-ID: <1545355509-6914-3-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545355509-6914-1-git-send-email-skomatineni@nvidia.com>
References: <1545355509-6914-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1545358556; bh=CFBtF6ZaKNyqKgjWa+hPoclDVuRehYmyqcZmFtTTkGs=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=Qu0AtA7mfo7jscaVDpybw0JtkbV95jOdaMnoR/NX+ERLqiIa+ES4Kxv+lulX+/y0C
         XzdqDHm45gXPViX8ovLkcGR7mg78akwUyznbGotZI5pWreTqa+KFCx0rs1om2SZ84j
         H0ma4Y8a5KHUT08+jZv9+Jkf8n/vTOvUE+v51/t1cwP4eycQFQO6zPDdhal4R16oLo
         sriV3u7xzKnR15ooah4BXFka62Y/274WTrmDXmyqeJNQWmDiXvmQVE09aLNjau/6Fm
         YQN3qdiyHLfTSlMiSMcb0KBJDs2YFl6Xul592mJAFpyh1VIBELWt/ofJg7jN3Sa2Io
         aonh2UrAuEp3Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the SDMMC Controllers address space to be exact
defined register address range as per the design.

SDMMC Controller supporting Command Queue has CQHCI registers at
offset 0xF000.

This fix helps to identify the Tegra SDMMC Controllers supporting
Command Queue based on the size of address space.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra186.dtsi | 6 +++---
 arch/arm64/boot/dts/nvidia/tegra194.dtsi | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
index 2f3c8e29520d..6fda3d6a7f3d 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
@@ -231,7 +231,7 @@
 
 	sdmmc1: sdhci@3400000 {
 		compatible = "nvidia,tegra186-sdhci";
-		reg = <0x0 0x03400000 0x0 0x10000>;
+		reg = <0x0 0x03400000 0x0 0x220>;
 		interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&bpmp TEGRA186_CLK_SDMMC1>;
 		clock-names = "sdhci";
@@ -256,7 +256,7 @@
 
 	sdmmc2: sdhci@3420000 {
 		compatible = "nvidia,tegra186-sdhci";
-		reg = <0x0 0x03420000 0x0 0x10000>;
+		reg = <0x0 0x03420000 0x0 0x220>;
 		interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&bpmp TEGRA186_CLK_SDMMC2>;
 		clock-names = "sdhci";
@@ -276,7 +276,7 @@
 
 	sdmmc3: sdhci@3440000 {
 		compatible = "nvidia,tegra186-sdhci";
-		reg = <0x0 0x03440000 0x0 0x10000>;
+		reg = <0x0 0x03440000 0x0 0x220>;
 		interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&bpmp TEGRA186_CLK_SDMMC3>;
 		clock-names = "sdhci";
diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index c2091bb16546..6510ef6492b1 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -295,7 +295,7 @@
 
 		sdmmc1: sdhci@3400000 {
 			compatible = "nvidia,tegra194-sdhci", "nvidia,tegra186-sdhci";
-			reg = <0x03400000 0x10000>;
+			reg = <0x03400000 0x220>;
 			interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&bpmp TEGRA194_CLK_SDMMC1>;
 			clock-names = "sdhci";
@@ -306,7 +306,7 @@
 
 		sdmmc3: sdhci@3440000 {
 			compatible = "nvidia,tegra194-sdhci", "nvidia,tegra186-sdhci";
-			reg = <0x03440000 0x10000>;
+			reg = <0x03440000 0x220>;
 			interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&bpmp TEGRA194_CLK_SDMMC3>;
 			clock-names = "sdhci";
-- 
2.7.4

