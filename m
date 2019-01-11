Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A62EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 10:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCD7120872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 10:01:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="RZYWDAIW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731629AbfAKKBU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 05:01:20 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:50104 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727653AbfAKKBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 05:01:18 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0BA1BD9055922;
        Fri, 11 Jan 2019 04:01:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547200871;
        bh=wRPh7eWPN+28E6yoCvH6h88EFxsbUT3SSDCd/6DmG1c=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=RZYWDAIWn23EA1xb6WABnozXtK4CJNnFBDirmwkG8AOEc2KEwvLuW+3tIFjDRujnt
         MbxOX9g7eur76FbSiGts9LV7wHu3hLNxR+am7rGgArsIHQDdItOhmRNAk8GKxPTW+s
         6lRymimAM7T8KLrbgXS2pBe57K+4hNg47ppKuy8Q=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0BA1Bvt052104
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Jan 2019 04:01:11 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 11
 Jan 2019 04:01:10 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 11 Jan 2019 04:01:10 -0600
Received: from localhost.localdomain (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0BA12Xb015629;
        Fri, 11 Jan 2019 04:01:08 -0600
From:   Roger Quadros <rogerq@ti.com>
To:     <t-kristo@ti.com>
CC:     <nm@ti.com>, <nsekhar@ti.com>, <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Roger Quadros <rogerq@ti.com>
Subject: [PATCH 2/3] arm64: dts: ti: k3-am6: add USB support
Date:   Fri, 11 Jan 2019 12:01:00 +0200
Message-ID: <1547200861-17795-3-git-send-email-rogerq@ti.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547200861-17795-1-git-send-email-rogerq@ti.com>
References: <1547200861-17795-1-git-send-email-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds support for USB0 and USB1 instances on the AM6 SoC.
USB0 is limited to high-speed for now.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 80 ++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index 8b55108..680cbc7 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -199,4 +199,84 @@
 		#size-cells = <1>;
 		ranges = <0x0 0x0 0x00100000 0x1c000>;
 	};
+
+	dwc3_0: dwc3@4000000 {
+		compatible = "ti,am654-dwc3";
+		reg = <0x0 0x4000000 0x0 0x4000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0x0 0x4000000 0x20000>;
+		interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
+		dma-coherent;
+		status = "disabled";
+		power-domains = <&k3_pds 151>;
+		assigned-clocks = <&k3_clks 151 2>, <&k3_clks 151 7>;
+		assigned-clock-parents = <&k3_clks 151 4>,	/* set REF_CLK to 20MHz i.e. PER0_PLL/48 */
+					 <&k3_clks 151 9>;	/* set PIPE3_TXB_CLK to CLK_12M_RC/256 (for HS only) */
+
+		usb0: usb@10000 {
+			compatible = "snps,dwc3";
+			reg = <0x10000 0x10000>;
+			interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "peripheral",
+					  "host",
+					  "otg";
+			maximum-speed = "high-speed";
+			dr_mode = "otg";
+			phys = <&usb0_phy>;
+			phy-names = "usb2-phy";
+			snps,dis_u3_susphy_quirk;
+		};
+	};
+
+	usb0_phy: phy@4100000 {
+		compatible = "ti,am654-usb2", "ti,omap-usb2";
+		reg = <0x0 0x4100000 0x0 0x54>;
+		syscon-phy-power = <&scm_conf 0x4000>;
+		clocks = <&k3_clks 151 0>, <&k3_clks 151 1>;
+		clock-names = "wkupclk", "refclk";
+		#phy-cells = <0>;
+		status = "disabled";
+	};
+
+	dwc3_1: dwc3@4020000 {
+		compatible = "ti,am654-dwc3";
+		reg = <0x0 0x4020000 0x0 0x4000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0x0 0x4020000 0x20000>;
+		interrupts = <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>;
+		dma-coherent;
+		status = "disabled";
+		power-domains = <&k3_pds 152>;
+		assigned-clocks = <&k3_clks 152 2>;
+		assigned-clock-parents = <&k3_clks 152 4>;	/* set REF_CLK to 20MHz i.e. PER0_PLL/48 */
+
+		usb1: usb@10000 {
+			compatible = "snps,dwc3";
+			reg = <0x10000 0x10000>;
+			interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "peripheral",
+					  "host",
+					  "otg";
+			maximum-speed = "high-speed";
+			dr_mode = "otg";
+			phys = <&usb1_phy>;
+			phy-names = "usb2-phy";
+		};
+	};
+
+	usb1_phy: phy@4110000 {
+		compatible = "ti,am654-usb2", "ti,omap-usb2";
+		reg = <0x0 0x4110000 0x0 0x54>;
+		syscon-phy-power = <&scm_conf 0x4020>;
+		clocks = <&k3_clks 152 0>, <&k3_clks 152 1>;
+		clock-names = "wkupclk", "refclk";
+		#phy-cells = <0>;
+		status = "disabled";
+	};
 };
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

