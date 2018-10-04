Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF656C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 11:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87FE721479
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 11:12:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jrhnnm7u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87FE721479
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbeJDSF3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 14:05:29 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:45876 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727183AbeJDSF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 14:05:27 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w94BCZkW002912;
        Thu, 4 Oct 2018 06:12:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1538651555;
        bh=9y0+sH57LR4O1uSbqpxWadeSndunLIPxjLq7LBe9VJE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=jrhnnm7uuXKQVpdtm2I9NvYomqHfs6tTkIn+cK7G7FNzMS1WiVrxzTaCmHYSRLFan
         A1bttcZmc1i/97f2JbeJT9jU2Aw4petAY+69h3mLm1L4F867NFeDPZxav2Kn7kAInA
         iPfmBHwqEvlCQrSN43oBviB7tJIXpjdxsDNGGujA=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w94BCZPf016158;
        Thu, 4 Oct 2018 06:12:35 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 4 Oct
 2018 06:12:34 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 4 Oct 2018 06:12:34 -0500
Received: from a0230074-OptiPlex-7010.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w94BCSLb027478;
        Thu, 4 Oct 2018 06:12:32 -0500
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>
CC:     <kishon@ti.com>, <faiz_abbas@ti.com>, <ulf.hansson@linaro.org>,
        <robh+dt@kernel.org>, <catalin.marinas@arm.com>,
        <adrian.hunter@intel.com>
Subject: [PATCH 1/6] dt-bindings: phy: am654-mmc-phy: Document new phy bindings
Date:   Thu, 4 Oct 2018 16:44:46 +0530
Message-ID: <20181004111451.9539-2-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181004111451.9539-1-faiz_abbas@ti.com>
References: <20181004111451.9539-1-faiz_abbas@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add information to document bindings for the MMC PHY
on TI's AM654 devices.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 .../devicetree/bindings/phy/am654-mmc-phy.txt | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/am654-mmc-phy.txt

diff --git a/Documentation/devicetree/bindings/phy/am654-mmc-phy.txt b/Documentation/devicetree/bindings/phy/am654-mmc-phy.txt
new file mode 100644
index 000000000000..766921612758
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/am654-mmc-phy.txt
@@ -0,0 +1,42 @@
+TI AM654 MMC PHY
+-------------------
+
+Required properties:
+ - compatible: ti,am654-emmc-phy
+ - #phy-cells: must be 0
+ - reg: PHY registers address offset and size
+ - clocks: must be phandle of the clock provider which is the host
+	   controller
+ - clock-names: must be "mmcclk"
+ - ti,otap-del-sel: Output Tap Delay select.
+ - ti,trm-icp: DLL trim select.
+ - ti,driver-strength-ohm: driver strength in ohms.
+			   Valid values are 33, 40, 50, 66, and 100 ohms.
+
+Example:
+			mmc_phy1: mmc_phy@10100 {
+				compatible = "ti,am654-mmc-phy";
+				reg = <0x10100 0x34>;
+				clocks = <&sdhci1>;
+				clock-names = "mmcclk";
+				#phy-cells = <0>;
+				ti,otap-del-sel = <0x2>;
+				ti,trm-icp = <0x8>;
+				status = "disabled";
+			};
+
+Host controller node:
+
+			sdhci1: sdhci@0 {
+				compatible = "ti,am654-sdhci-5.1";
+				reg = <0x0 0x1000>;
+				power-domains = <&k3_pds 48>;
+				clocks = <&k3_clks 48 0>, <&k3_clks 48 1>;
+				clock-names = "clk_ahb", "clk_xin";
+				interrupts = <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>;
+				clock-output-names = "mmc_cardclck";
+				#clock-cells = <0>;
+				phys=<&mmc_phy1>;
+				phy-names = "phy_arasan";
+				status = "disabled";
+			};
-- 
2.18.0

