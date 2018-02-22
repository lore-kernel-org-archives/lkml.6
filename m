Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932883AbeBVOXj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 09:23:39 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33709 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932851AbeBVOXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 09:23:32 -0500
X-Google-Smtp-Source: AH8x2266fdWwkPw9s1h2WE+0+68vh8veovdkIaf0ck+tBc+Ymg3oBa7Uv5UufBqerAbjmfDZNYePaQ==
From: Rui Miguel Silva <rui.silva@linaro.org>
To: horia.geanta@nxp.com, aymen.sghaier@nxp.com,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ryan Harkin <ryan.harkin@linaro.org>,
        "Bryan O'Donoghue" <pure.logic@nexus-software.ie>,
        Rui Miguel Silva <rui.silva@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
        devicetree@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, "David S. Miller" <davem@davemloft.net>,
        Lukas Auer <lukas.auer@aisec.fraunhofer.de>
Subject: [PATCH v4 4/4] ARM: dts: imx7s: add CAAM device node
Date: Thu, 22 Feb 2018 14:22:50 +0000
Message-Id: <20180222142250.31348-5-rui.silva@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180222142250.31348-1-rui.silva@linaro.org>
References: <20180222142250.31348-1-rui.silva@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add CAAM device node to the i.MX7s device tree.

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: devicetree@vger.kernel.org
Cc: "Horia Geantă" <horia.geanta@nxp.com>
Cc: Aymen Sghaier <aymen.sghaier@nxp.com>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Lukas Auer <lukas.auer@aisec.fraunhofer.de>
Signed-off-by: Rui Miguel Silva <rui.silva@linaro.org>
---
 arch/arm/boot/dts/imx7s.dtsi | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index 9aa2bb998552..d88c179e4c00 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -822,6 +822,36 @@
 				status = "disabled";
 			};
 
+			crypto: caam@30900000 {
+				compatible = "fsl,sec-v4.0";
+				#address-cells = <1>;
+				#size-cells = <1>;
+				reg = <0x30900000 0x40000>;
+				ranges = <0 0x30900000 0x40000>;
+				interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX7D_CAAM_CLK>,
+					 <&clks IMX7D_AHB_CHANNEL_ROOT_CLK>;
+				clock-names = "ipg", "aclk";
+
+				sec_jr0: jr0@1000 {
+					compatible = "fsl,sec-v4.0-job-ring";
+					reg = <0x1000 0x1000>;
+					interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				sec_jr1: jr1@2000 {
+					compatible = "fsl,sec-v4.0-job-ring";
+					reg = <0x2000 0x1000>;
+					interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				sec_jr2: jr1@3000 {
+					compatible = "fsl,sec-v4.0-job-ring";
+					reg = <0x3000 0x1000>;
+					interrupts = <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>;
+				};
+			};
+
 			flexcan1: can@30a00000 {
 				compatible = "fsl,imx7d-flexcan", "fsl,imx6q-flexcan";
 				reg = <0x30a00000 0x10000>;
-- 
2.16.2
