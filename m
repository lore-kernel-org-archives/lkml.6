Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE127C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 12:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A36320894
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 12:27:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A36320894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731644AbeGZNoD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 09:44:03 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:17007 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730412AbeGZNoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 09:44:02 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b59be2e0000>; Thu, 26 Jul 2018 05:27:26 -0700
Received: from HQMAIL104.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 26 Jul 2018 05:27:25 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 26 Jul 2018 05:27:25 -0700
Received: from HQMAIL112.nvidia.com (172.18.146.18) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 26 Jul
 2018 12:27:25 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL112.nvidia.com
 (172.18.146.18) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 26 Jul
 2018 12:27:24 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1347.2 via Frontend
 Transport; Thu, 26 Jul 2018 12:27:24 +0000
Received: from dhcp-10-21-25-168.Nvidia.com (Not Verified[10.21.25.201]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5b59be2a0001>; Thu, 26 Jul 2018 05:27:24 -0700
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
Subject: [PATCH v2 08/10] arm64: dts: tegra210: Add sdmmc pad auto calibration offsets
Date:   Thu, 26 Jul 2018 15:26:54 +0300
Message-ID: <1532608016-14319-9-git-send-email-avienamo@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1532608016-14319-1-git-send-email-avienamo@nvidia.com>
References: <1532608016-14319-1-git-send-email-avienamo@nvidia.com>
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
index c449566..c16ab5f 100644
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
 
@@ -1088,6 +1098,8 @@
 		resets = <&tegra_car 15>;
 		reset-names = "sdhci";
 		nvidia,only-1-8-v;
+		pad-autocal-pull-up-offset-1v8 = <0x05>;
+		pad-autocal-pull-down-offset-1v8 = <0x05>;
 		status = "disabled";
 	};
 
-- 
2.7.4

