Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D085AC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 10:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D44D20861
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 10:57:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D44D20861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbeIGPh4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 11:37:56 -0400
Received: from mail-sh2.amlogic.com ([58.32.228.45]:19408 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727785AbeIGPhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 11:37:54 -0400
Received: from localhost.localdomain (10.18.11.217) by mail-sh2.amlogic.com
 (10.18.11.6) with Microsoft SMTP Server id 15.0.1320.4; Fri, 7 Sep 2018
 18:57:47 +0800
From:   Jianxin Pan <jianxin.pan@amlogic.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        <linux-mtd@lists.infradead.org>
CC:     Liang Yang <liang.yang@amlogic.com>,
        Yixun Lan <yixun.lan@amlogic.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh@kernel.org>, Jian Hu <jian.hu@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [RFC PATCH v3 1/2] dt-bindings: nand: meson: add Amlogic NAND controller driver
Date:   Fri, 7 Sep 2018 18:57:10 +0800
Message-ID: <1536317831-58056-2-git-send-email-jianxin.pan@amlogic.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1536317831-58056-1-git-send-email-jianxin.pan@amlogic.com>
References: <1536317831-58056-1-git-send-email-jianxin.pan@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.18.11.217]
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
 .../devicetree/bindings/mtd/amlogic,meson-nand.txt | 91 ++++++++++++++++++++++
 1 file changed, 91 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt

diff --git a/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
new file mode 100644
index 0000000..655a778
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
@@ -0,0 +1,91 @@
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
+	"device" - device clock from eMMC sub clock controller
+
+- pins     : Select pins which NFC need.
+- nand_pins: Detail NAND pins information.
+- amlogic,mmc-syscon	: Required for NAND clocks, it's shared with SD/eMMC
+				controller port C
+
+Optional children nodes:
+Children nodes represent the available nand chips.
+
+
+
+Other properties:
+see Documentation/devicetree/bindings/mtd/nand.txt for generic bindings.
+
+Example demonstrate on AXG SoC:
+
+	sd_emmc_c_clkc: mmc@7000 {
+		compatible = "amlogic,meson-axg-mmc-clkc", "syscon";
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
+
+		clocks = <&clkc CLKID_SD_EMMC_C>,
+			<&sd_emmc_c_clkc CLKID_MMC_DIV>;
+		clock-names = "core", "device";
+		amlogic,mmc-syscon = <&sd_emmc_c_clkc>;
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
+			amlogic,nand-enable-scrambler;
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
1.9.1

