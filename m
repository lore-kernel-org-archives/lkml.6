Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753016AbeAaCAw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 21:00:52 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52016 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752954AbeAaCAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 21:00:49 -0500
X-Google-Smtp-Source: AH8x225tpylhnk8jVUiQfNU0CbN4uUMwGRMaDWdQrOWhwifXcFa6f7pYXfaJBu2vgdM5uDiIS0fpRw==
From: "Bryan O'Donoghue" <pure.logic@nexus-software.ie>
To: horia.geanta@nxp.com, aymen.sghaier@nxp.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: fabio.estevam@nxp.com, peng.fan@nxp.com, davem@davemloft.net,
        lukas.auer@aisec.fraunhofer.de, rui.silva@linaro.org,
        ryan.harkin@linaro.org, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        "Bryan O'Donoghue" <pure.logic@nexus-software.ie>
Subject: [PATCH v3 5/5] ARM: dts: imx7s: add CAAM device node
Date: Wed, 31 Jan 2018 02:00:40 +0000
Message-Id: <1517364040-27607-6-git-send-email-pure.logic@nexus-software.ie>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517364040-27607-1-git-send-email-pure.logic@nexus-software.ie>
References: <1517364040-27607-1-git-send-email-pure.logic@nexus-software.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rui Miguel Silva <rui.silva@linaro.org>

Add CAAM device node to the i.MX7s device tree.

Signed-off-by: Rui Miguel Silva <rui.silva@linaro.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org
Cc: "Horia Geantă" <horia.geanta@nxp.com>
Cc: Aymen Sghaier <aymen.sghaier@nxp.com>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Lukas Auer <lukas.auer@aisec.fraunhofer.de>
Signed-off-by: Bryan O'Donoghue <pure.logic@nexus-software.ie>
---
 arch/arm/boot/dts/imx7s.dtsi | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index 82ad26e..e38c159 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -805,6 +805,37 @@
 				status = "disabled";
 			};
 
+			crypto: caam@30900000 {
+				compatible = "fsl,sec-v4.0";
+				fsl,sec-era = <4>;
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
2.7.4
