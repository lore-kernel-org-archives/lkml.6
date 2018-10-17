Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D1F2C5ACC6
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 02:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7F98214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 02:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="F6prPkEV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7F98214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbeJQKBF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 06:01:05 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:11504 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727062AbeJQKBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 06:01:04 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bc6996e0000>; Tue, 16 Oct 2018 19:07:42 -0700
Received: from HQMAIL106.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 16 Oct 2018 19:07:45 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 16 Oct 2018 19:07:45 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 17 Oct
 2018 02:07:44 +0000
Received: from HQMAIL104.nvidia.com (172.18.146.11) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 17 Oct
 2018 02:07:44 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Wed, 17 Oct 2018 02:07:44 +0000
Received: from vdumpa-ubuntu.nvidia.com (Not Verified[172.17.173.140]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5bc699700000>; Tue, 16 Oct 2018 19:07:44 -0700
From:   Krishna Reddy <vdumpa@nvidia.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mperttunen@nvidia.com>, <avienamo@nvidia.com>
CC:     <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Krishna Reddy <vdumpa@nvidia.com>
Subject: [PATCH 2/2] arm64: dts: tegra186: Enable IOMMU for SDHCI
Date:   Tue, 16 Oct 2018 19:06:48 -0700
Message-ID: <1539742008-16595-2-git-send-email-vdumpa@nvidia.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1539742008-16595-1-git-send-email-vdumpa@nvidia.com>
References: <1539742008-16595-1-git-send-email-vdumpa@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1539742062; bh=hmPjrldnCqsnfsDyJyzwkUddZmh/Q1iYL2pztR62qKE=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=F6prPkEVQu170B7fpzgnsf+CUnefSgb47uK7qaKvH7dXNkhr4uHYmK7Jr5odoAe5G
         2JrqS0JEBXmLe2gzkjm5DLGxae/a5I1h1z6xgXKe0sLkGcz9HNKPAS19OpTI/764Re
         6i+71fc31atbFQutSUMV9i+eK5vDFdmaNkNOSn85OKmScM0aJ1f1JGGQMxjvY7/0+R
         d8pFDVgOgpYhnsd6QMdBj4iWcS0t17PqYyLdrtpm3jl39lG2rhWgYShN8k0iaBEfLu
         IsXR32mX2ry3IZJ8uP0dnioaWHg1UguVtSHSWNBuHTIgog6pfEsmHCAP0noU216BBx
         MhS0MPjkmaqdA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable IOMMU for all SDHCI controllers in Tegra186.

Signed-off-by: Krishna Reddy <vdumpa@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra186.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
index 230c0c8..996997e 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
@@ -234,6 +234,7 @@
 		compatible = "nvidia,tegra186-sdhci";
 		reg = <0x0 0x03400000 0x0 0x10000>;
 		interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
+		iommus = <&smmu TEGRA186_SID_SDMMC1>;
 		clocks = <&bpmp TEGRA186_CLK_SDMMC1>;
 		clock-names = "sdhci";
 		resets = <&bpmp TEGRA186_RESET_SDMMC1>;
@@ -259,6 +260,7 @@
 		compatible = "nvidia,tegra186-sdhci";
 		reg = <0x0 0x03420000 0x0 0x10000>;
 		interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
+		iommus = <&smmu TEGRA186_SID_SDMMC2>;
 		clocks = <&bpmp TEGRA186_CLK_SDMMC2>;
 		clock-names = "sdhci";
 		resets = <&bpmp TEGRA186_RESET_SDMMC2>;
@@ -279,6 +281,7 @@
 		compatible = "nvidia,tegra186-sdhci";
 		reg = <0x0 0x03440000 0x0 0x10000>;
 		interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
+		iommus = <&smmu TEGRA186_SID_SDMMC3>;
 		clocks = <&bpmp TEGRA186_CLK_SDMMC3>;
 		clock-names = "sdhci";
 		resets = <&bpmp TEGRA186_RESET_SDMMC3>;
@@ -301,6 +304,7 @@
 		compatible = "nvidia,tegra186-sdhci";
 		reg = <0x0 0x03460000 0x0 0x10000>;
 		interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
+		iommus = <&smmu TEGRA186_SID_SDMMC4>;
 		clocks = <&bpmp TEGRA186_CLK_SDMMC4>;
 		clock-names = "sdhci";
 		assigned-clocks = <&bpmp TEGRA186_CLK_SDMMC4>,
-- 
2.1.4

