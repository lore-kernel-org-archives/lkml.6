Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED4F2C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 20:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A77882087D
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 20:46:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A77882087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbeH2Aj0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 20:39:26 -0400
Received: from mail.bootlin.com ([62.4.15.54]:60645 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727166AbeH2AjV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 20:39:21 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id C62FD22A3E; Tue, 28 Aug 2018 22:45:58 +0200 (CEST)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id 91629207B0;
        Tue, 28 Aug 2018 22:45:48 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Li Yang <leoyang.li@nxp.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 4/4] arm64: dts: add Microsys MPX-LS1046A SoM and SBC-LS1046A SBC
Date:   Tue, 28 Aug 2018 22:45:44 +0200
Message-Id: <20180828204544.10815-4-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180828204544.10815-1-alexandre.belloni@bootlin.com>
References: <20180828204544.10815-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Microsys designs a SoM based on the LS1046A named miriac MPX-LS1046A
https://microsys.de/products/system-on-modules/qoriqr-armr-architecture/miriactm-mpx-ls1046a/

It also provides an SBC accepting this SoM, the miriac SBC-LS1046
https://microsys.de/en/products/single-board-computer/miriactm-sbcs/miriactm-sbc-ls1046a/

This adds a dtsi for the SoM and a dts for the SBC.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../fsl-ls1046a-miriac-mpxls1046.dtsi         |  62 ++++++++++
 .../freescale/fsl-ls1046a-miriac-sbc1046.dts  | 117 ++++++++++++++++++
 3 files changed, 180 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1046a-miriac-mpxls1046.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1046a-miriac-sbc1046.dts

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 86e18adb695a..b0b81ca887e8 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -4,6 +4,7 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1012a-qds.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1012a-rdb.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1043a-qds.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1043a-rdb.dtb
+dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1046a-miriac-sbc1046.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1046a-qds.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1046a-rdb.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1088a-qds.dtb
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a-miriac-mpxls1046.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a-miriac-mpxls1046.dtsi
new file mode 100644
index 000000000000..d1948e27fdb4
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a-miriac-mpxls1046.dtsi
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+/ {
+	compatible = "microsys,mpxls1046a", "fsl,ls1046a";
+};
+
+&duart0 {
+	status = "okay";
+};
+
+&duart1 {
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+
+	temp-sensor@4c {
+		compatible = "national,lm90";
+		reg = <0x4c>;
+	};
+
+	eeprom@50 {
+		compatible = "at24,24c128";
+		reg = <0x50>;
+	};
+
+	rtc@32 {
+		compatible = "epson,rx8803";
+		reg = <0x32>;
+	};
+};
+
+&ifc {
+	#address-cells = <2>;
+	#size-cells = <1>;
+
+	ranges = <0x0 0x0 0x0 0x7e800000 0x00010000>;
+	status = "okay";
+
+	nand@0,0 {
+		compatible = "fsl,ifc-nand";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0x0 0x0 0x10000>;
+	};
+};
+
+&qspi {
+	num-cs = <1>;
+	bus-num = <0>;
+	status = "okay";
+
+	qflash0: s25fs512s@0 {
+		compatible = "spansion,m25p80";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		spi-max-frequency = <20000000>;
+		m25p,fast-read;
+		reg = <0>;
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a-miriac-sbc1046.dts b/arch/arm64/boot/dts/freescale/fsl-ls1046a-miriac-sbc1046.dts
new file mode 100644
index 000000000000..f31be6ed06ea
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a-miriac-sbc1046.dts
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+/dts-v1/;
+
+#include "fsl-ls1046a.dtsi"
+#include "fsl-ls1046a-miriac-mpxls1046.dtsi"
+
+/ {
+	model = "Microsys miriac SBC-LS1046A";
+	compatible = "microsys,sbc1046a", "microsys,mpxls1046a", "fsl,ls1046a";
+
+	aliases {
+		ethernet0 = &enet2;
+		ethernet1 = &enet4;
+		ethernet2 = &enet5;
+		ethernet3 = &enet6;
+
+		serial0 = &duart0;
+		serial1 = &duart1;
+		serial2 = &duart2;
+		serial3 = &duart3;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+};
+
+&duart0 {
+	status = "okay";
+};
+
+&duart1 {
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+
+	eeprom@57 {
+		compatible = "at24,24c128";
+		reg = <0x57>;
+	};
+};
+
+&i2c1 {
+	status = "okay";
+};
+
+&ifc {
+	nand@0,0 {
+		partition@0 {
+			reg = <0x0 0x00100000>;
+			label = "NAND U-Boot Image";
+			read-only;
+		};
+
+		partition@100000 {
+			reg = <0x00100000 0x00100000>;
+			label = "NAND U-Boot Env";
+		};
+
+		partition@200000 {
+			reg = <0x00200000 0x01E00000>;
+			label = "NAND FIT Image";
+		};
+
+		partition@02000000 {
+			reg = <0x02000000 0x1e000000>;
+			label = "NAND (RW) UBIFS Root File System";
+		};
+	};
+};
+
+#include "fsl-ls1046-post.dtsi"
+
+&fman0 {
+	compatible = "fsl,fman", "simple-bus";
+
+	ethernet@e4000 {
+		phy-handle = <&rgmii_phy1>;
+		phy-connection-type = "rgmii";
+	};
+
+	ethernet@e8000 {
+		phy-handle = <&sgmii_phy1>;
+		phy-connection-type = "sgmii";
+	};
+
+	ethernet@ea000 {
+		phy-handle = <&sgmii_phy2>;
+		phy-connection-type = "sgmii";
+	};
+
+	ethernet@f0000 {
+		phy-handle = <&sgmii_phy3>;
+		phy-connection-type = "sgmii";
+	};
+
+	mdio@fc000 {
+		rgmii_phy1: ethernet-phy@3 {
+			reg = <3>;
+		};
+
+		sgmii_phy1: ethernet-phy@2 {
+			reg = <2>;
+		};
+
+		sgmii_phy2: ethernet-phy@1 {
+			reg = <1>;
+		};
+
+		sgmii_phy3: ethernet-phy@0 {
+			reg = <0>;
+		};
+	};
+};
-- 
2.18.0

