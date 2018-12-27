Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 536DEC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 21:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2028021741
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 21:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="kQL73wy3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730622AbeL0V6L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 16:58:11 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:4181 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730415AbeL0V6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 16:58:07 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c254ae40000>; Thu, 27 Dec 2018 13:57:56 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 27 Dec 2018 13:58:06 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 27 Dec 2018 13:58:06 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 27 Dec
 2018 21:58:06 +0000
Received: from HQMAIL104.nvidia.com (172.18.146.11) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 27 Dec
 2018 21:58:06 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Thu, 27 Dec 2018 21:58:06 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.110.103.52]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c254aed0008>; Thu, 27 Dec 2018 13:58:05 -0800
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <mperttunen@nvidia.com>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V6 1/2] arm64: dtsi: Fix SDMMC address range
Date:   Thu, 27 Dec 2018 13:58:01 -0800
Message-ID: <1545947882-18875-2-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545947882-18875-1-git-send-email-skomatineni@nvidia.com>
References: <1545947882-18875-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1545947876; bh=CFBtF6ZaKNyqKgjWa+hPoclDVuRehYmyqcZmFtTTkGs=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=kQL73wy3glVWu3NL5PN9+i68OrojxVyubICWpxxwH4FyukaU75e+3A44+5DjcOhE0
         XUO7u/cpk3AiS/7zYvf/wspsyZeKgNH79gRk65H7H6YYS7UyG1qawh3MLUAmLr5ZZ3
         yv+VnH3hXKxfwhuLkfrfJNtkk/yUSidtcuCpG69+JkvvLh5zeoFxr38mYPeBCKFQNI
         YQTsNfOpOlg21QnhtY4V6o73hLdmJDJ6CYzDEn0yKl+usU6i1LZszwR3cRyBW0xHZh
         4voiD4OspXSfAa/uwjryjsz6RuTBg6mqR3tj7pCNMc6wTkxknWVNn2yGQnfFquAbOM
         X6fTf6KAR6TDA==
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

