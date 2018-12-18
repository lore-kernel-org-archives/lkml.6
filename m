Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7647DC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44BBE2184C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="VcD+Wlra"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbeLRWhI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 17:37:08 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:13819 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727208AbeLRWhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 17:37:08 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c19768d0001>; Tue, 18 Dec 2018 14:37:01 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 18 Dec 2018 14:37:07 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 18 Dec 2018 14:37:07 -0800
Received: from HQMAIL102.nvidia.com (172.18.146.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 18 Dec
 2018 22:37:07 +0000
Received: from HQMAIL106.nvidia.com (172.18.146.12) by HQMAIL102.nvidia.com
 (172.18.146.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 18 Dec
 2018 22:37:06 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Tue, 18 Dec 2018 22:37:06 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.110.103.52]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c1976920003>; Tue, 18 Dec 2018 14:37:06 -0800
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <mperttunen@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <pchandru@nvidia.com>
CC:     <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V1] arm64: dts: tegra210: Device Tree Updates for Tegra210 I2C
Date:   Tue, 18 Dec 2018 14:37:04 -0800
Message-ID: <1545172624-19287-1-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1545172622; bh=wPJtdJPZ1s2VpSJ0BS83x2CIIcfEWBtvCSlLvwVlo7c=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=VcD+Wlram7LgpiNMkjV4vqI9bs6yjc9Ap5qckRLwCpTC1FOKfS3laNEPFXxyWskCB
         ae33+j6hXqtqPkWmjJGikribXSbYXocqIVID4vI97g/ziVrt0CkFXA+sOlinz43DZP
         zdcH8KRrMZuXWLyZ4+O/TfpoBlT4SeAiU1p+rbepZr5IngJcNsRjnMoI1OF7u8YfUg
         BR1bXMEhUUFHWBu0ClT8Pumv3bCtsvPqthNUwTT5+zAzrU77cMzcx1DAXi7roZ0SoF
         5PqQ3jaVaRs4DL/M9G71i6hR+89sB5+qVUfj0moObdrJ7mx935MVj1GAePKOcxUb+d
         7lPGzix1E6eVQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update I2C device node compatible string to be appropriate.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra210.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra210.dtsi b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
index 2205d66b0443..a8bd13727330 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
@@ -554,7 +554,7 @@
 	};
 
 	i2c@7000c000 {
-		compatible = "nvidia,tegra210-i2c", "nvidia,tegra114-i2c";
+		compatible = "nvidia,tegra210-i2c", "nvidia,tegra124-i2c";
 		reg = <0x0 0x7000c000 0x0 0x100>;
 		interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
 		#address-cells = <1>;
@@ -569,7 +569,7 @@
 	};
 
 	i2c@7000c400 {
-		compatible = "nvidia,tegra210-i2c", "nvidia,tegra114-i2c";
+		compatible = "nvidia,tegra210-i2c", "nvidia,tegra124-i2c";
 		reg = <0x0 0x7000c400 0x0 0x100>;
 		interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
 		#address-cells = <1>;
@@ -584,7 +584,7 @@
 	};
 
 	i2c@7000c500 {
-		compatible = "nvidia,tegra210-i2c", "nvidia,tegra114-i2c";
+		compatible = "nvidia,tegra210-i2c", "nvidia,tegra124-i2c";
 		reg = <0x0 0x7000c500 0x0 0x100>;
 		interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
 		#address-cells = <1>;
@@ -599,7 +599,7 @@
 	};
 
 	i2c@7000c700 {
-		compatible = "nvidia,tegra210-i2c", "nvidia,tegra114-i2c";
+		compatible = "nvidia,tegra210-i2c", "nvidia,tegra124-i2c";
 		reg = <0x0 0x7000c700 0x0 0x100>;
 		interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
 		#address-cells = <1>;
@@ -617,7 +617,7 @@
 	};
 
 	i2c@7000d000 {
-		compatible = "nvidia,tegra210-i2c", "nvidia,tegra114-i2c";
+		compatible = "nvidia,tegra210-i2c", "nvidia,tegra124-i2c";
 		reg = <0x0 0x7000d000 0x0 0x100>;
 		interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
 		#address-cells = <1>;
@@ -632,7 +632,7 @@
 	};
 
 	i2c@7000d100 {
-		compatible = "nvidia,tegra210-i2c", "nvidia,tegra114-i2c";
+		compatible = "nvidia,tegra210-i2c", "nvidia,tegra124-i2c";
 		reg = <0x0 0x7000d100 0x0 0x100>;
 		interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
 		#address-cells = <1>;
-- 
2.7.4

