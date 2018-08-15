Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D10C4646D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 05:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26F43216ED
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 05:18:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26F43216ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728449AbeHOIJF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 04:09:05 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:60763 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726013AbeHOIJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 04:09:04 -0400
X-UUID: 2f89eae410174ebf8158483a55dfe623-20180815
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 181550617; Wed, 15 Aug 2018 13:18:21 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Wed, 15 Aug 2018 13:18:20 +0800
Received: from mtkslt306.mediatek.inc (10.21.14.136) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Wed, 15 Aug 2018 13:18:20 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Sean Wang <sean.wang@mediatek.com>,
        Roy Luo <cheng-hao.luo@mediatek.com>,
        Weijie Gao <weijie.gao@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 3/5] arm64: dts: mt7622: fix ram size for rfb1
Date:   Wed, 15 Aug 2018 13:18:15 +0800
Message-ID: <3be2ef51a1dffed93538d256273bdecfc59cdea5.1534130854.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <68c4ca0158518d6bf50f2f7becfcb87ff3ce158a.1534130854.git.ryder.lee@mediatek.com>
References: <68c4ca0158518d6bf50f2f7becfcb87ff3ce158a.1534130854.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix ram size and sort nodes in alphabetical order.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts | 196 +++++++++++++--------------
 1 file changed, 98 insertions(+), 98 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
index b783764..033d7d1 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
@@ -51,7 +51,7 @@
 	};
 
 	memory {
-		reg = <0 0x40000000 0 0x3F000000>;
+		reg = <0 0x40000000 0 0x20000000>;
 	};
 
 	reg_1p8v: regulator-1p8v {
@@ -81,6 +81,103 @@
 	};
 };
 
+&bch {
+	status = "disabled";
+};
+
+&btif {
+	status = "okay";
+};
+
+&cir {
+	pinctrl-names = "default";
+	pinctrl-0 = <&irrx_pins>;
+	status = "okay";
+};
+
+&eth {
+	pinctrl-names = "default";
+	pinctrl-0 = <&eth_pins>;
+	status = "okay";
+
+	gmac1: mac@1 {
+		compatible = "mediatek,eth-mac";
+		reg = <1>;
+		phy-handle = <&phy5>;
+	};
+
+	mdio-bus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		phy5: ethernet-phy@5 {
+			reg = <5>;
+			phy-mode = "sgmii";
+		};
+	};
+};
+
+&i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_pins>;
+	status = "okay";
+};
+
+&i2c2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c2_pins>;
+	status = "okay";
+};
+
+&mmc0 {
+	pinctrl-names = "default", "state_uhs";
+	pinctrl-0 = <&emmc_pins_default>;
+	pinctrl-1 = <&emmc_pins_uhs>;
+	status = "okay";
+	bus-width = <8>;
+	max-frequency = <50000000>;
+	cap-mmc-highspeed;
+	mmc-hs200-1_8v;
+	vmmc-supply = <&reg_3p3v>;
+	vqmmc-supply = <&reg_1p8v>;
+	assigned-clocks = <&topckgen CLK_TOP_MSDC30_0_SEL>;
+	assigned-clock-parents = <&topckgen CLK_TOP_UNIV48M>;
+	non-removable;
+};
+
+&mmc1 {
+	pinctrl-names = "default", "state_uhs";
+	pinctrl-0 = <&sd0_pins_default>;
+	pinctrl-1 = <&sd0_pins_uhs>;
+	status = "okay";
+	bus-width = <4>;
+	max-frequency = <50000000>;
+	cap-sd-highspeed;
+	r_smpl = <1>;
+	cd-gpios = <&pio 81 GPIO_ACTIVE_LOW>;
+	vmmc-supply = <&reg_3p3v>;
+	vqmmc-supply = <&reg_3p3v>;
+	assigned-clocks = <&topckgen CLK_TOP_MSDC30_1_SEL>;
+	assigned-clock-parents = <&topckgen CLK_TOP_UNIV48M>;
+};
+
+&nandc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&parallel_nand_pins>;
+	status = "disabled";
+};
+
+&nor_flash {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi_nor_pins>;
+	status = "disabled";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+	};
+};
+
 &pcie {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pcie0_pins>;
@@ -344,103 +441,6 @@
 	};
 };
 
-&bch {
-	status = "disabled";
-};
-
-&btif {
-	status = "okay";
-};
-
-&cir {
-	pinctrl-names = "default";
-	pinctrl-0 = <&irrx_pins>;
-	status = "okay";
-};
-
-&eth {
-	pinctrl-names = "default";
-	pinctrl-0 = <&eth_pins>;
-	status = "okay";
-
-	gmac1: mac@1 {
-		compatible = "mediatek,eth-mac";
-		reg = <1>;
-		phy-handle = <&phy5>;
-	};
-
-	mdio-bus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		phy5: ethernet-phy@5 {
-			reg = <5>;
-			phy-mode = "sgmii";
-		};
-	};
-};
-
-&i2c1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c1_pins>;
-	status = "okay";
-};
-
-&i2c2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c2_pins>;
-	status = "okay";
-};
-
-&mmc0 {
-	pinctrl-names = "default", "state_uhs";
-	pinctrl-0 = <&emmc_pins_default>;
-	pinctrl-1 = <&emmc_pins_uhs>;
-	status = "okay";
-	bus-width = <8>;
-	max-frequency = <50000000>;
-	cap-mmc-highspeed;
-	mmc-hs200-1_8v;
-	vmmc-supply = <&reg_3p3v>;
-	vqmmc-supply = <&reg_1p8v>;
-	assigned-clocks = <&topckgen CLK_TOP_MSDC30_0_SEL>;
-	assigned-clock-parents = <&topckgen CLK_TOP_UNIV48M>;
-	non-removable;
-};
-
-&mmc1 {
-	pinctrl-names = "default", "state_uhs";
-	pinctrl-0 = <&sd0_pins_default>;
-	pinctrl-1 = <&sd0_pins_uhs>;
-	status = "okay";
-	bus-width = <4>;
-	max-frequency = <50000000>;
-	cap-sd-highspeed;
-	r_smpl = <1>;
-	cd-gpios = <&pio 81 GPIO_ACTIVE_LOW>;
-	vmmc-supply = <&reg_3p3v>;
-	vqmmc-supply = <&reg_3p3v>;
-	assigned-clocks = <&topckgen CLK_TOP_MSDC30_1_SEL>;
-	assigned-clock-parents = <&topckgen CLK_TOP_UNIV48M>;
-};
-
-&nandc {
-	pinctrl-names = "default";
-	pinctrl-0 = <&parallel_nand_pins>;
-	status = "disabled";
-};
-
-&nor_flash {
-	pinctrl-names = "default";
-	pinctrl-0 = <&spi_nor_pins>;
-	status = "disabled";
-
-	flash@0 {
-		compatible = "jedec,spi-nor";
-		reg = <0>;
-	};
-};
-
 &pwm {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pwm7_pins>;
-- 
1.9.1

