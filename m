Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C0BC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 19:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14C20218EA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 19:37:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="EKyq3FQV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729741AbfABTgy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 14:36:54 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:10045 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729680AbfABTgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 14:36:52 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c2d12c90000>; Wed, 02 Jan 2019 11:36:41 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 02 Jan 2019 11:36:52 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 02 Jan 2019 11:36:52 -0800
Received: from HQMAIL108.nvidia.com (172.18.146.13) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 2 Jan
 2019 19:36:51 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Wed, 2 Jan 2019 19:36:51 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.110.103.52]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c2d12d30007>; Wed, 02 Jan 2019 11:36:51 -0800
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V7 1/2] arm64: dtsi: Fix SDMMC address range
Date:   Wed, 2 Jan 2019 11:36:47 -0800
Message-ID: <1546457808-18270-2-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1546457808-18270-1-git-send-email-skomatineni@nvidia.com>
References: <1546457808-18270-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1546457801; bh=CFBtF6ZaKNyqKgjWa+hPoclDVuRehYmyqcZmFtTTkGs=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=EKyq3FQV0+EihYXuQs0JNZbNNFen40c+IiaECfmFFv7OlJ01YZKCCKFR1Qn0ZxM2j
         rAkaYg8PLUf0hR8EwdHLYMtpw4qqprfqWgekWJbLdlH4JxkMNOarbMTDZ+sf6asjwo
         aKYlvd3t2VTMZun5yb0+DlWZofjrcuHUif66G0pwl9mqoP5lXrN7QE7RCjoQ8UxKJC
         ztla0regIz5WFSidf7LJtx0UxRxE8kG+dfkpX3J2e2GSu5aCXrOJNDZFy5SWqWWLd2
         pnzZoeQIG3tMcFNoOfjmm/i5B43Gn1eFmNOxjaf27D6OBLBeUvqVrtTpnQX8OVvIYy
         YJ5o4Ai41Bg+g==
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

