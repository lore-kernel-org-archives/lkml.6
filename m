Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4377AECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 14:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07C0D20852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 14:34:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07C0D20852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388704AbeGXPle (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 11:41:34 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:17793 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388373AbeGXPle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 11:41:34 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b5738ff0000>; Tue, 24 Jul 2018 07:34:39 -0700
Received: from HQMAIL106.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 24 Jul 2018 07:34:43 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 24 Jul 2018 07:34:43 -0700
Received: from HQMAIL112.nvidia.com (172.18.146.18) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 24 Jul
 2018 14:34:47 +0000
Received: from HQMAIL103.nvidia.com (172.20.187.11) by HQMAIL112.nvidia.com
 (172.18.146.18) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 24 Jul
 2018 14:34:47 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1347.2 via Frontend
 Transport; Tue, 24 Jul 2018 14:34:47 +0000
Received: from dhcp-10-21-25-168.Nvidia.com (Not Verified[10.21.25.201]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5b5739040000>; Tue, 24 Jul 2018 07:34:46 -0700
From:   Aapo Vienamo <avienamo@nvidia.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Adrian Hunter" <adrian.hunter@intel.com>,
        Mikko Perttunen <mperttunen@nvidia.com>
CC:     <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Aapo Vienamo <avienamo@nvidia.com>
Subject: [PATCH 08/10] arm64: dts: tegra210: Add sdmmc pad auto calibration offsets
Date:   Tue, 24 Jul 2018 17:34:24 +0300
Message-ID: <1532442865-6391-7-git-send-email-avienamo@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1532442865-6391-1-git-send-email-avienamo@nvidia.com>
References: <1532442591-5640-1-git-send-email-avienamo@nvidia.com>
 <1532442865-6391-1-git-send-email-avienamo@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the calibration offset properties used for automatic pad drive
strength calibration.

Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra210.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra210.dtsi b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
index bc1918e..467bdfc 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
@@ -1051,6 +1051,10 @@
 		pinctrl-names = "sdmmc-3v3", "sdmmc-1v8";
 		pinctrl-0 = <&sdmmc1_3v3>;
 		pinctrl-1 = <&sdmmc1_1v8>;
+		pad-autocal-pull-up-offset-3v3 = <0x00>;
+		pad-autocal-pull-down-offset-3v3 = <0x7d>;
+		pad-autocal-pull-up-offset-1v8 = <0x7b>;
+		pad-autocal-pull-down-offset-1v8 = <0x7b>;
 		status = "disabled";
 	};
 
@@ -1062,6 +1066,8 @@
 		clock-names = "sdhci";
 		resets = <&tegra_car 9>;
 		reset-names = "sdhci";
+		pad-autocal-pull-up-offset-1v8 = <0x05>;
+		pad-autocal-pull-down-offset-1v8 = <0x05>;
 		status = "disabled";
 	};
 
@@ -1076,6 +1082,10 @@
 		pinctrl-names = "sdmmc-3v3", "sdmmc-1v8";
 		pinctrl-0 = <&sdmmc3_3v3>;
 		pinctrl-1 = <&sdmmc3_1v8>;
+		pad-autocal-pull-up-offset-3v3 = <0x00>;
+		pad-autocal-pull-down-offset-3v3 = <0x7d>;
+		pad-autocal-pull-up-offset-1v8 = <0x7b>;
+		pad-autocal-pull-down-offset-1v8 = <0x7b>;
 		status = "disabled";
 	};
 
@@ -1087,6 +1097,8 @@
 		clock-names = "sdhci";
 		resets = <&tegra_car 15>;
 		reset-names = "sdhci";
+		pad-autocal-pull-up-offset-1v8 = <0x05>;
+		pad-autocal-pull-down-offset-1v8 = <0x05>;
 		status = "disabled";
 	};
 
-- 
2.7.4

