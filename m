Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 7D2D2C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 08:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D58520891
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 08:16:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D58520891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934633AbeFMIQj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 04:16:39 -0400
Received: from mail-sh2.amlogic.com ([58.32.228.45]:13702 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933618AbeFMIQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 04:16:04 -0400
Received: from localhost.localdomain (10.18.20.250) by mail-sh2.amlogic.com
 (10.18.11.6) with Microsoft SMTP Server id 15.0.1320.4; Wed, 13 Jun 2018
 16:15:59 +0800
From:   Yixun Lan <yixun.lan@amlogic.com>
To:     <linux-mtd@lists.infradead.org>
CC:     Liang Yang <liang.yang@amlogic.com>,
        Yixun Lan <yixun.lan@amlogic.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh@kernel.org>, Jian Hu <jian.hu@amlogic.com>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH 1/2] dt-bindings: nand: meson: add Amlogic NAND controller driver
Date:   Wed, 13 Jun 2018 16:13:13 +0000
Message-ID: <20180613161314.14894-2-yixun.lan@amlogic.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180613161314.14894-1-yixun.lan@amlogic.com>
References: <20180613161314.14894-1-yixun.lan@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.18.20.250]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liang Yang <liang.yang@amlogic.com>

Add Amlogic NAND controller dt-bindings for Meson SoC,
Current this driver support GXBB/GXL/AXG platform.

Signed-off-by: Liang Yang <liang.yang@amlogic.com>
Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
---
 .../bindings/mtd/amlogic,meson-nand.txt       | 118 ++++++++++++++++++
 1 file changed, 118 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt

diff --git a/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
new file mode 100644
index 000000000000..eac9f9433d5d
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
@@ -0,0 +1,118 @@
+Amlogic NAND Flash Controller (NFC) for GXBB/GXL/AXG family SoCs
+
+This file documents the properties in addition to those available in
+the MTD NAND bindings.
+
+Required properties:
+- compatible : contains one of:
+  - "amlogic,meson-gxl-nfc"
+  - "amlogic,meson-axg-nfc"
+- clocks     :
+	A list of phandle + clock-specifier pairs for the clocks listed
+	in clock-names.
+
+- clock-names: Should contain the following:
+	"core" - NFC module gate clock
+	"clkin0" - Parent clock of internal mux
+	"clkin1" - Other parent clock of internal mux
+
+- pins     : Select pins which NFC need.
+- nand_pins: Detail NAND pins information.
+		nand_pins: nand {
+			mux {
+				groups = "emmc_nand_d0",
+					"emmc_nand_d1",
+					"emmc_nand_d2",
+					"emmc_nand_d3",
+					"emmc_nand_d4",
+					"emmc_nand_d5",
+					"emmc_nand_d6",
+					"emmc_nand_d7",
+					"nand_ce0",
+					"nand_rb0",
+					"nand_ale",
+					"nand_cle",
+					"nand_wen_clk",
+					"nand_ren_wr";
+				function = "nand";
+			};
+		};
+
+- amlogic,mmc-syscon	: Required for NAND clocks, it's shared with SD/eMMC
+				controller port C
+
+Optional children nodes:
+Children nodes represent the available nand chips.
+
+Optional properties:
+- meson-nand-user-mode :
+	only set 2 or 16 which mean the way of reading OOB bytes by NFC.
+- meson-nand-ran-mode :
+	setting 0 or 1, means disable/enable scrambler which keeps the balence
+	of 0 and 1
+
+Other properties:
+see Documentation/devicetree/bindings/mtd/nand.txt for generic bindings.
+
+Example demonstrate on AXG SoC:
+
+	sd_emmc_c: mmc@7000 {
+		compatible = "simple-bus", "syscon";
+		reg = <0x0 0x7000 0x0 0x800>;
+		status = "okay";
+	};
+
+	nand: nfc@7800 {
+		compatible = "amlogic,meson-axg-nfc";
+		reg = <0x0 0x7800 0x0 0x100>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		interrupts = <GIC_SPI 34 IRQ_TYPE_EDGE_RISING>;
+		status = "disabled";
+		clocks = <&clkc CLKID_SD_EMMC_C>,
+				<&clkc CLKID_SD_EMMC_C_CLK0>,
+				<&clkc CLKID_FCLK_DIV2>;
+		clock-names = "core", "clkin0", "clkin1";
+		amlogic,mmc-syscon = <&sd_mmc_c>;
+
+		status = "okay";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&nand_pins>;
+
+		nand@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			nand-on-flash-bbt;
+			nand-ecc-mode = "hw";
+			nand-ecc-strength = <8>;
+			nand-ecc-step-size = <1024>;
+
+			meson-nand-user-mode = <2>;
+			meson-nand-ran-mode = <1>;
+
+			partition@0 {
+				label = "boot";
+				reg = <0x00000000 0x00200000>;
+				read-only;
+			};
+			partition@200000 {
+				label = "env";
+				reg = <0x00200000 0x00400000>;
+			};
+			partition@600000 {
+				label = "system";
+				reg = <0x00600000 0x00a00000>;
+			};
+			partition@1000000 {
+				label = "rootfs";
+				reg = <0x01000000 0x03000000>;
+			};
+			partition@4000000 {
+				label = "media";
+				reg = <0x04000000 0x8000000>;
+			};
+		};
+	};
-- 
2.17.1

