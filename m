Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752964AbeFDKEW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 06:04:22 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:45264 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752498AbeFDKBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 06:01:04 -0400
X-Google-Smtp-Source: ADUXVKL0GvZzxLm4hZ41tYInz3Sna1RFXHDIHPEJnNMPEqbOSZej/BD4JOkop5HL7il9hvsKKXGvlw==
From: =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To: Colin Didier <colin.didier@devialet.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        Sascha Hauer <s.hauer@pengutronix.de>, Rob Herring <robh@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        =?UTF-8?q?Cl=C3=A9ment=20Peron?= <clement.peron@devialet.com>
Subject: [PATCH v5 4/4] ARM: dts: imx: add missing compatible and clock properties for EPIT
Date: Mon,  4 Jun 2018 12:00:35 +0200
Message-Id: <20180604100035.19558-5-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180604100035.19558-1-peron.clem@gmail.com>
References: <20180604100035.19558-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Didier <colin.didier@devialet.com>

Add missing compatible and clock properties for EPIT node.

Signed-off-by: Colin Didier <colin.didier@devialet.com>
Signed-off-by: Clément Peron <clement.peron@devialet.com>
---
 arch/arm/boot/dts/imx25.dtsi   |  8 ++++++--
 arch/arm/boot/dts/imx6qdl.dtsi | 10 ++++++++--
 arch/arm/boot/dts/imx6sl.dtsi  | 14 ++++++++++----
 arch/arm/boot/dts/imx6sx.dtsi  | 10 ++++++++--
 arch/arm/boot/dts/imx6ul.dtsi  | 10 ++++++++--
 5 files changed, 40 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
index cf70df20b19c..15fd4308dad8 100644
--- a/arch/arm/boot/dts/imx25.dtsi
+++ b/arch/arm/boot/dts/imx25.dtsi
@@ -396,15 +396,19 @@
 			};
 
 			epit1: timer@53f94000 {
-				compatible = "fsl,imx25-epit";
+				compatible = "fsl,imx25-epit", "fsl,imx31-epit";
 				reg = <0x53f94000 0x4000>;
 				interrupts = <28>;
+				clocks = <&clks 83>;
+				status = "disabled";
 			};
 
 			epit2: timer@53f98000 {
-				compatible = "fsl,imx25-epit";
+				compatible = "fsl,imx25-epit", "fsl,imx31-epit";
 				reg = <0x53f98000 0x4000>;
 				interrupts = <27>;
+				clocks = <&clks 84>;
+				status = "disabled";
 			};
 
 			gpio4: gpio@53f9c000 {
diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index c003e62bf290..65c4ee07454c 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -843,14 +843,20 @@
 				};
 			};
 
-			epit1: epit@20d0000 { /* EPIT1 */
+			epit1: timer@20d0000 {
+				compatible = "fsl,imx6qdl-epit", "fsl,imx31-epit";
 				reg = <0x020d0000 0x4000>;
 				interrupts = <0 56 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6QDL_CLK_EPIT1>;
+				status = "disabled";
 			};
 
-			epit2: epit@20d4000 { /* EPIT2 */
+			epit2: timer@20d4000 {
+				compatible = "fsl,imx6qdl-epit", "fsl,imx31-epit";
 				reg = <0x020d4000 0x4000>;
 				interrupts = <0 57 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6QDL_CLK_EPIT2>;
+				status = "disabled";
 			};
 
 			src: src@20d8000 {
diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index ab6a7e2e7e8f..6229bbef7ccc 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -671,14 +671,20 @@
 				};
 			};
 
-			epit1: epit@20d0000 {
+			epit1: timer@20d0000 {
+				compatible = "fsl,imx6sl-epit", "fsl,imx31-epit";
 				reg = <0x020d0000 0x4000>;
-				interrupts = <0 56 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6SL_CLK_EPIT1>;
+				status = "disabled";
 			};
 
-			epit2: epit@20d4000 {
+			epit2: timer@20d4000 {
+				compatible = "fsl,imx6sl-epit", "fsl,imx31-epit";
 				reg = <0x020d4000 0x4000>;
-				interrupts = <0 57 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6SL_CLK_EPIT2>;
+				status = "disabled";
 			};
 
 			src: src@20d8000 {
diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 49c7205b8db8..2b30559d3270 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -736,14 +736,20 @@
 				};
 			};
 
-			epit1: epit@20d0000 {
+			epit1: timer@20d0000 {
+				compatible = "fsl,imx6sx-epit", "fsl,imx31-epit";
 				reg = <0x020d0000 0x4000>;
 				interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6SX_CLK_EPIT1>;
+				status = "disabled";
 			};
 
-			epit2: epit@20d4000 {
+			epit2: timer@20d4000 {
+				compatible = "fsl,imx6sx-epit", "fsl,imx31-epit";
 				reg = <0x020d4000 0x4000>;
 				interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6SX_CLK_EPIT2>;
+				status = "disabled";
 			};
 
 			src: src@20d8000 {
diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index 1241972b16ba..d5f765da1ee2 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -658,14 +658,20 @@
 				};
 			};
 
-			epit1: epit@20d0000 {
+			epit1: timer@20d0000 {
+				compatible = "fsl,imx6ul-epit", "fsl,imx31-epit";
 				reg = <0x020d0000 0x4000>;
 				interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6UL_CLK_EPIT1>;
+				status = "disabled";
 			};
 
-			epit2: epit@20d4000 {
+			epit2: timer@20d4000 {
+				compatible = "fsl,imx6ul-epit", "fsl,imx31-epit";
 				reg = <0x020d4000 0x4000>;
 				interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6UL_CLK_EPIT2>;
+				status = "disabled";
 			};
 
 			src: src@20d8000 {
-- 
2.17.0
