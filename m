Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84343C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 18:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34E8821EFB
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 18:08:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34E8821EFB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729250AbeHJUjv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 16:39:51 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:18994 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727462AbeHJUju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 16:39:50 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b6dd4a70001>; Fri, 10 Aug 2018 11:08:39 -0700
Received: from HQMAIL104.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 10 Aug 2018 11:08:55 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 10 Aug 2018 11:08:55 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 10 Aug
 2018 18:08:54 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 10 Aug
 2018 18:08:54 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1347.2 via Frontend
 Transport; Fri, 10 Aug 2018 18:08:54 +0000
Received: from dhcp-10-21-25-168.Nvidia.com (Not Verified[10.21.25.201]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5b6dd4b30003>; Fri, 10 Aug 2018 11:08:53 -0700
From:   Aapo Vienamo <avienamo@nvidia.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        "Stefan Agner" <stefan@agner.ch>
CC:     <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        Aapo Vienamo <avienamo@nvidia.com>
Subject: [PATCH v2 02/40] dt-bindings: mmc: tegra: Add pad voltage control properties
Date:   Fri, 10 Aug 2018 21:08:04 +0300
Message-ID: <1533924522-1037-3-git-send-email-avienamo@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533924522-1037-1-git-send-email-avienamo@nvidia.com>
References: <1533924522-1037-1-git-send-email-avienamo@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the pinctrl bindings used by the SDHCI driver to reconfigure
pad voltages on controllers supporting multiple voltage levels.

Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/mmc/nvidia,tegra20-sdhci.txt          | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
index 9bce578..90c214d 100644
--- a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
+++ b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
@@ -38,3 +38,25 @@ sdhci@c8000200 {
 	power-gpios = <&gpio 155 0>; /* gpio PT3 */
 	bus-width = <8>;
 };
+
+Optional properties for Tegra210 and Tegra186:
+- pinctrl-names, pinctrl-0, pinctrl-1 : Specify pad voltage
+  configurations. Valid pinctrl-names are "sdmmc-3v3" and "sdmmc-1v8"
+  for controllers supporting multiple voltage levels. The order of names
+  should correspond to the pin configuration states in pinctrl-0 and
+  pinctrl-1.
+
+Example:
+sdhci@700b0000 {
+	compatible = "nvidia,tegra210-sdhci", "nvidia,tegra124-sdhci";
+	reg = <0x0 0x700b0000 0x0 0x200>;
+	interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
+	clocks = <&tegra_car TEGRA210_CLK_SDMMC1>;
+	clock-names = "sdhci";
+	resets = <&tegra_car 14>;
+	reset-names = "sdhci";
+	pinctrl-names = "sdmmc-3v3", "sdmmc-1v8";
+	pinctrl-0 = <&sdmmc1_3v3>;
+	pinctrl-1 = <&sdmmc1_1v8>;
+	status = "disabled";
+};
-- 
2.7.4

