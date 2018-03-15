Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752704AbeCORHs (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 13:07:48 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35862 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751931AbeCORHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 13:07:44 -0400
X-Google-Smtp-Source: AG47ELsQOl1lEIXUwMjgPFt85GOzScPV2jg/ZPt8cbsdsxjS9M3C9KE+9r8bSVtCOs4Dh3ZCVwXzVA==
From: Jagan Teki <jagan@amarulasolutions.com>
To: Shawn Guo <shawnguo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Fabio maggi <fabio.mauri@bticino.it>, lamiaposta71@gmail.com,
        Andrea CORTESE <andrea.cortese@bticino.it>,
        "davide . bonfanti" <davide.bonfanti@bticino.it>,
        Shyam Saini <shyam.saini@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Simone CIANNI <simone.cianni@bticino.it>,
        Raffaele RECALCATI <raffaele.recalcati@bticino.it>
Subject: [PATCH 2/3] ARM: dts: i.MX6: Add BTicino i.MX6DL Mamoj initial support
Date: Thu, 15 Mar 2018 22:37:09 +0530
Message-Id: <20180315170710.9551-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180315170710.9551-1-jagan@amarulasolutions.com>
References: <20180315170710.9551-1-jagan@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds initial support for BTicino i.MX6DL Mamoj board.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Signed-off-by: Simone CIANNI <simone.cianni@bticino.it>
Signed-off-by: Raffaele RECALCATI <raffaele.recalcati@bticino.it>
---
 arch/arm/boot/dts/Makefile         |   1 +
 arch/arm/boot/dts/imx6dl-mamoj.dts | 113 +++++++++++++++++++++++++++++++++++++
 2 files changed, 114 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6dl-mamoj.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 26e2e290ec28..b5dcc55bd157 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -397,6 +397,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
 	imx6dl-hummingboard2-som-v15.dtb \
 	imx6dl-icore.dtb \
 	imx6dl-icore-rqs.dtb \
+	imx6dl-mamoj.dtb \
 	imx6dl-nit6xlite.dtb \
 	imx6dl-nitrogen6x.dtb \
 	imx6dl-phytec-mira-rdk-nand.dtb \
diff --git a/arch/arm/boot/dts/imx6dl-mamoj.dts b/arch/arm/boot/dts/imx6dl-mamoj.dts
new file mode 100644
index 000000000000..53e85c7f06b4
--- /dev/null
+++ b/arch/arm/boot/dts/imx6dl-mamoj.dts
@@ -0,0 +1,113 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2018 BTicino
+ * Copyright (C) 2018 Amarula Solutions B.V.
+ */
+
+/dts-v1/;
+
+#include "imx6dl.dtsi"
+
+/ {
+	model = "BTicino i.MX6DL Mamoj board";
+	compatible = "bticino,imx6dl-mamoj", "fsl,imx6dl";
+};
+
+&fec {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enet>;
+	phy-mode = "mii";
+	status = "okay";
+};
+
+&i2c3 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c3>;
+	status = "okay";
+};
+
+&i2c4 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c4>;
+	status = "okay";
+};
+
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart3>;
+	status = "okay";
+};
+
+&usdhc3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc3>;
+	bus-width = <8>;
+	non-removable;
+	keep-power-in-suspend;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl_enet: enetgrp {
+		fsl,pins = <
+			MX6QDL_PAD_ENET_MDIO__ENET_MDIO		0x1b0b0
+			MX6QDL_PAD_ENET_MDC__ENET_MDC		0x1b0b0
+			MX6QDL_PAD_ENET_REF_CLK__ENET_TX_CLK	0x1b0b1
+			MX6QDL_PAD_ENET_TXD0__ENET_TX_DATA0	0x1b0b0
+			MX6QDL_PAD_ENET_TXD1__ENET_TX_DATA1	0x1b0b0
+			MX6QDL_PAD_KEY_ROW2__ENET_TX_DATA2	0x1b0b0
+			MX6QDL_PAD_KEY_ROW0__ENET_TX_DATA3	0x1b0b0
+			MX6QDL_PAD_ENET_TX_EN__ENET_TX_EN	0x1b0b0
+			MX6QDL_PAD_GPIO_19__ENET_TX_ER		0x1b0b0
+			MX6QDL_PAD_GPIO_18__ENET_RX_CLK		0x1b0b1
+			MX6QDL_PAD_ENET_RXD0__ENET_RX_DATA0	0x1b0b0
+			MX6QDL_PAD_ENET_RXD1__ENET_RX_DATA1	0x1b0b0
+			MX6QDL_PAD_KEY_COL2__ENET_RX_DATA2	0x1b0b0
+			MX6QDL_PAD_KEY_COL0__ENET_RX_DATA3      0x1b0b0
+			MX6QDL_PAD_ENET_CRS_DV__ENET_RX_EN	0x1b0b0
+			MX6QDL_PAD_ENET_RX_ER__ENET_RX_ER	0x1b0b0
+			MX6QDL_PAD_KEY_COL3__ENET_CRS		0x1b0b0
+			MX6QDL_PAD_KEY_ROW1__ENET_COL		0x1b0b0
+			/* KSZ8041 PHY Reset */
+			MX6QDL_PAD_KEY_COL1__GPIO4_IO08		0x1b0b0
+		>;
+	};
+
+	pinctrl_i2c3: i2c3grp {
+		fsl,pins = <
+			MX6QDL_PAD_GPIO_3__I2C3_SCL     0x4001b8b1
+			MX6QDL_PAD_GPIO_6__I2C3_SDA     0x4001b8b1
+		>;
+	};
+
+	pinctrl_i2c4: i2c4grp {
+		fsl,pins = <
+			MX6QDL_PAD_GPIO_7__I2C4_SCL	0x4001b8b1
+			MX6QDL_PAD_GPIO_8__I2C4_SDA	0x4001b8b1
+		>;
+	};
+
+	pinctrl_uart3: uart3grp {
+		fsl,pins = <
+			MX6QDL_PAD_EIM_D24__UART3_TX_DATA	0x1b0b1
+			MX6QDL_PAD_EIM_D25__UART3_RX_DATA	0x1b0b1
+		>;
+	};
+
+	pinctrl_usdhc3: usdhc3grp {
+		fsl,pins = <
+			MX6QDL_PAD_SD3_CMD__SD3_CMD	0x17059
+			MX6QDL_PAD_SD3_CLK__SD3_CLK	0x10059
+			MX6QDL_PAD_SD3_DAT0__SD3_DATA0	0x17059
+			MX6QDL_PAD_SD3_DAT1__SD3_DATA1	0x17059
+			MX6QDL_PAD_SD3_DAT2__SD3_DATA2	0x17059
+			MX6QDL_PAD_SD3_DAT3__SD3_DATA3	0x17059
+			MX6QDL_PAD_SD3_DAT4__SD3_DATA4	0x17059
+			MX6QDL_PAD_SD3_DAT5__SD3_DATA5	0x17059
+			MX6QDL_PAD_SD3_DAT6__SD3_DATA6	0x17059
+			MX6QDL_PAD_SD3_DAT7__SD3_DATA7	0x17059
+		>;
+	};
+};
-- 
2.14.3
