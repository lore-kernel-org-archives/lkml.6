Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F5F3C43615
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 16:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A0D7215EB
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 16:03:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A0D7215EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbeHRTLe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 15:11:34 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:32793 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726302AbeHRTLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 15:11:32 -0400
X-UUID: 470db19dce1843478da89fbc28d1404c-20180819
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 256948660; Sun, 19 Aug 2018 00:03:10 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Sun, 19 Aug 2018 00:03:08 +0800
Received: from mtkslt306.mediatek.inc (10.21.14.136) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Sun, 19 Aug 2018 00:03:09 +0800
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
Subject: [PATCH v1 3/5] arm64: dts: mt7622: fix ram size for rfb1
Date:   Sun, 19 Aug 2018 00:02:26 +0800
Message-ID: <303c61949cb9ae949f19b1d040301510f1bdbafe.1534607107.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <7d3ce6a89ffeb221dc3197b763521582bf300577.1534607107.git.ryder.lee@mediatek.com>
References: <7d3ce6a89ffeb221dc3197b763521582bf300577.1534607107.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix ram size to 512 megabytes and sort nodes in alphabetical order.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Acked-by: Sean Wang <sean.wang@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts | 196 +++++++++++++--------------
 1 file changed, 98 insertions(+), 98 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
index a747b7b..dcad086 100644
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

