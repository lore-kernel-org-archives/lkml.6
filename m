Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932160AbeAaAFh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 19:05:37 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34303 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752764AbeAaAFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 19:05:34 -0500
X-Google-Smtp-Source: AH8x227M7RPcJGCIQdbn1ttD87xcezWRA1usi+AafMH1vXuHG+t8TJkrB5nDc7tJ4vqdD/37Y8rdXA==
From: =?UTF-8?q?Beno=C3=AEt=20Th=C3=A9baudeau?=
        <benoit.thebaudeau.dev@gmail.com>
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>,
        Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
        <u.kleine-koenig@pengutronix.de>,
        Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
        =?UTF-8?q?Beno=C3=AEt=20Th=C3=A9baudeau?=
        <benoit.thebaudeau.dev@gmail.com>
Subject: [PATCH v2 1/2] ARM: dts: imx25-pinfunc: Use consistent naming for eSDHC
Date: Wed, 31 Jan 2018 01:05:13 +0100
Message-Id: <20180131000514.5286-1-benoit.thebaudeau.dev@gmail.com>
X-Mailer: git-send-email 2.14.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This file had several naming inconsistencies for eSDHC:
 - the instances were named sometimes SDn, sometimes SDHCn, whereas they
   are named ESDHCn in the reference manual, e.g.:
     MX25_PAD_SD1_CMD__SD1_CMD
     MX25_PAD_D15__SDHC1_DAT7
 - the data ports were named sometimes DATAn, sometimes DATn like in the
   reference manual, e.g.:
     MX25_PAD_SD1_DATA0__SD1_DATA0
     MX25_PAD_D15__SDHC1_DAT7
 - in one case, the clock port was named DAT_CLK instead of CLK:
     MX25_PAD_CSI_D7__SDHC2_DAT_CLK

This change:
 - introduces new definitions using the naming from the reference
   manual,
 - keeps definitions using the legacy naming in order not to break
   compatibility for out-of-tree users (they can be removed later),
 - updates the in-tree files that were using the legacy naming.

Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Benoît Thébaudeau <benoit.thebaudeau.dev@gmail.com>
---
Changes v1 -> v2:
 - New patch (suggested by Uwe).
---
 .../boot/dts/imx25-eukrea-mbimxsd25-baseboard.dts  | 12 ++--
 arch/arm/boot/dts/imx25-pdk.dts                    | 12 ++--
 arch/arm/boot/dts/imx25-pinfunc.h                  | 72 ++++++++++++++--------
 3 files changed, 60 insertions(+), 36 deletions(-)

diff --git a/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard.dts b/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard.dts
index 0f053721d80f..6273a1f243ed 100644
--- a/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard.dts
+++ b/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard.dts
@@ -88,12 +88,12 @@
 
 		pinctrl_esdhc1: esdhc1grp {
 			fsl,pins = <
-				MX25_PAD_SD1_CMD__SD1_CMD		0x400000c0
-				MX25_PAD_SD1_CLK__SD1_CLK		0x400000c0
-				MX25_PAD_SD1_DATA0__SD1_DATA0		0x400000c0
-				MX25_PAD_SD1_DATA1__SD1_DATA1		0x400000c0
-				MX25_PAD_SD1_DATA2__SD1_DATA2		0x400000c0
-				MX25_PAD_SD1_DATA3__SD1_DATA3		0x400000c0
+				MX25_PAD_SD1_CMD__ESDHC1_CMD		0x400000c0
+				MX25_PAD_SD1_CLK__ESDHC1_CLK		0x400000c0
+				MX25_PAD_SD1_DATA0__ESDHC1_DAT0		0x400000c0
+				MX25_PAD_SD1_DATA1__ESDHC1_DAT1		0x400000c0
+				MX25_PAD_SD1_DATA2__ESDHC1_DAT2		0x400000c0
+				MX25_PAD_SD1_DATA3__ESDHC1_DAT3		0x400000c0
 			>;
 		};
 
diff --git a/arch/arm/boot/dts/imx25-pdk.dts b/arch/arm/boot/dts/imx25-pdk.dts
index 2d15ce72d006..498496deaa27 100644
--- a/arch/arm/boot/dts/imx25-pdk.dts
+++ b/arch/arm/boot/dts/imx25-pdk.dts
@@ -165,12 +165,12 @@
 
 		pinctrl_esdhc1: esdhc1grp {
 			fsl,pins = <
-				MX25_PAD_SD1_CMD__SD1_CMD		0x80000000
-				MX25_PAD_SD1_CLK__SD1_CLK		0x80000000
-				MX25_PAD_SD1_DATA0__SD1_DATA0		0x80000000
-				MX25_PAD_SD1_DATA1__SD1_DATA1		0x80000000
-				MX25_PAD_SD1_DATA2__SD1_DATA2		0x80000000
-				MX25_PAD_SD1_DATA3__SD1_DATA3		0x80000000
+				MX25_PAD_SD1_CMD__ESDHC1_CMD		0x80000000
+				MX25_PAD_SD1_CLK__ESDHC1_CLK		0x80000000
+				MX25_PAD_SD1_DATA0__ESDHC1_DAT0		0x80000000
+				MX25_PAD_SD1_DATA1__ESDHC1_DAT1		0x80000000
+				MX25_PAD_SD1_DATA2__ESDHC1_DAT2		0x80000000
+				MX25_PAD_SD1_DATA3__ESDHC1_DAT3		0x80000000
 				MX25_PAD_A14__GPIO_2_0			0x80000000
 				MX25_PAD_A15__GPIO_2_1			0x80000000
 			>;
diff --git a/arch/arm/boot/dts/imx25-pinfunc.h b/arch/arm/boot/dts/imx25-pinfunc.h
index 6c63dca1b9b8..2915c65a13c9 100644
--- a/arch/arm/boot/dts/imx25-pinfunc.h
+++ b/arch/arm/boot/dts/imx25-pinfunc.h
@@ -151,21 +151,21 @@
 #define MX25_PAD_D15__D15			0x088 0x280 0x000 0x00 0x000
 #define MX25_PAD_D15__LD16			0x088 0x280 0x000 0x01 0x000
 #define MX25_PAD_D15__GPIO_4_5			0x088 0x280 0x000 0x05 0x000
-#define MX25_PAD_D15__SDHC1_DAT7		0x088 0x280 0x4d8 0x06 0x000
+#define MX25_PAD_D15__ESDHC1_DAT7		0x088 0x280 0x4d8 0x06 0x000
 
 #define MX25_PAD_D14__D14			0x08c 0x284 0x000 0x00 0x000
 #define MX25_PAD_D14__LD17			0x08c 0x284 0x000 0x01 0x000
 #define MX25_PAD_D14__GPIO_4_6			0x08c 0x284 0x000 0x05 0x000
-#define MX25_PAD_D14__SDHC1_DAT6		0x08c 0x284 0x4d4 0x06 0x000
+#define MX25_PAD_D14__ESDHC1_DAT6		0x08c 0x284 0x4d4 0x06 0x000
 
 #define MX25_PAD_D13__D13			0x090 0x288 0x000 0x00 0x000
 #define MX25_PAD_D13__LD18			0x090 0x288 0x000 0x01 0x000
 #define MX25_PAD_D13__GPIO_4_7			0x090 0x288 0x000 0x05 0x000
-#define MX25_PAD_D13__SDHC1_DAT5		0x090 0x288 0x4d0 0x06 0x000
+#define MX25_PAD_D13__ESDHC1_DAT5		0x090 0x288 0x4d0 0x06 0x000
 
 #define MX25_PAD_D12__D12			0x094 0x28c 0x000 0x00 0x000
 #define MX25_PAD_D12__GPIO_4_8			0x094 0x28c 0x000 0x05 0x000
-#define MX25_PAD_D12__SDHC1_DAT4		0x094 0x28c 0x4cc 0x06 0x000
+#define MX25_PAD_D12__ESDHC1_DAT4		0x094 0x28c 0x4cc 0x06 0x000
 
 #define MX25_PAD_D11__D11			0x098 0x290 0x000 0x00 0x000
 #define MX25_PAD_D11__GPIO_4_9			0x098 0x290 0x000 0x05 0x000
@@ -236,12 +236,12 @@
 #define MX25_PAD_LD8__LD8			0x0e8 0x2e0 0x000 0x00 0x000
 #define MX25_PAD_LD8__UART4_RXD			0x0e8 0x2e0 0x570 0x02 0x000
 #define MX25_PAD_LD8__FEC_TX_ERR		0x0e8 0x2e0 0x000 0x05 0x000
-#define MX25_PAD_LD8__SDHC2_CMD			0x0e8 0x2e0 0x4e0 0x06 0x000
+#define MX25_PAD_LD8__ESDHC2_CMD		0x0e8 0x2e0 0x4e0 0x06 0x000
 
 #define MX25_PAD_LD9__LD9			0x0ec 0x2e4 0x000 0x00 0x000
 #define MX25_PAD_LD9__UART4_TXD			0x0ec 0x2e4 0x000 0x02 0x000
 #define MX25_PAD_LD9__FEC_COL			0x0ec 0x2e4 0x504 0x05 0x001
-#define MX25_PAD_LD9__SDHC2_CLK			0x0ec 0x2e4 0x4dc 0x06 0x000
+#define MX25_PAD_LD9__ESDHC2_CLK		0x0ec 0x2e4 0x4dc 0x06 0x000
 
 #define MX25_PAD_LD10__LD10			0x0f0 0x2e8 0x000 0x00 0x000
 #define MX25_PAD_LD10__UART4_RTS		0x0f0 0x2e8 0x56c 0x02 0x000
@@ -250,7 +250,7 @@
 #define MX25_PAD_LD11__LD11			0x0f4 0x2ec 0x000 0x00 0x000
 #define MX25_PAD_LD11__UART4_CTS		0x0f4 0x2ec 0x000 0x02 0x000
 #define MX25_PAD_LD11__FEC_RDATA2		0x0f4 0x2ec 0x50c 0x05 0x001
-#define MX25_PAD_LD11__SDHC2_DAT1		0x0f4 0x2ec 0x4e8 0x06 0x000
+#define MX25_PAD_LD11__ESDHC2_DAT1		0x0f4 0x2ec 0x4e8 0x06 0x000
 
 #define MX25_PAD_LD12__LD12			0x0f8 0x2f0 0x000 0x00 0x000
 #define MX25_PAD_LD12__CSPI2_MOSI		0x0f8 0x2f0 0x4a0 0x02 0x000
@@ -316,12 +316,12 @@
 #define MX25_PAD_CSI_D5__CSPI3_RDY		0x12c 0x324 0x000 0x07 0x000
 
 #define MX25_PAD_CSI_D6__CSI_D6			0x130 0x328 0x000 0x00 0x000
-#define MX25_PAD_CSI_D6__SDHC2_CMD		0x130 0x328 0x4e0 0x02 0x001
+#define MX25_PAD_CSI_D6__ESDHC2_CMD		0x130 0x328 0x4e0 0x02 0x001
 #define MX25_PAD_CSI_D6__SIM1_PD0		0x130 0x328 0x000 0x04 0x000
 #define MX25_PAD_CSI_D6__GPIO_1_31		0x130 0x328 0x000 0x05 0x000
 
 #define MX25_PAD_CSI_D7__CSI_D7			0x134 0x32c 0x000 0x00 0x000
-#define MX25_PAD_CSI_D7__SDHC2_DAT_CLK		0x134 0x32C 0x4dc 0x02 0x001
+#define MX25_PAD_CSI_D7__ESDHC2_CLK		0x134 0x32C 0x4dc 0x02 0x001
 #define MX25_PAD_CSI_D7__GPIO_1_6		0x134 0x32c 0x000 0x05 0x000
 
 #define MX25_PAD_CSI_D8__CSI_D8			0x138 0x330 0x000 0x00 0x000
@@ -336,22 +336,22 @@
 
 #define MX25_PAD_CSI_MCLK__CSI_MCLK		0x140 0x338 0x000 0x00 0x000
 #define MX25_PAD_CSI_MCLK__AUD6_TXD		0x140 0x338 0x000 0x01 0x000
-#define MX25_PAD_CSI_MCLK__SDHC2_DAT0		0x140 0x338 0x4e4 0x02 0x001
+#define MX25_PAD_CSI_MCLK__ESDHC2_DAT0		0x140 0x338 0x4e4 0x02 0x001
 #define MX25_PAD_CSI_MCLK__GPIO_1_8		0x140 0x338 0x000 0x05 0x000
 
 #define MX25_PAD_CSI_VSYNC__CSI_VSYNC		0x144 0x33c 0x000 0x00 0x000
 #define MX25_PAD_CSI_VSYNC__AUD6_RXD		0x144 0x33c 0x000 0x01 0x000
-#define MX25_PAD_CSI_VSYNC__SDHC2_DAT1		0x144 0x33c 0x4e8 0x02 0x001
+#define MX25_PAD_CSI_VSYNC__ESDHC2_DAT1		0x144 0x33c 0x4e8 0x02 0x001
 #define MX25_PAD_CSI_VSYNC__GPIO_1_9		0x144 0x33c 0x000 0x05 0x000
 
 #define MX25_PAD_CSI_HSYNC__CSI_HSYNC		0x148 0x340 0x000 0x00 0x000
 #define MX25_PAD_CSI_HSYNC__AUD6_TXC		0x148 0x340 0x000 0x01 0x000
-#define MX25_PAD_CSI_HSYNC__SDHC2_DAT2		0x148 0x340 0x4ec 0x02 0x001
+#define MX25_PAD_CSI_HSYNC__ESDHC2_DAT2		0x148 0x340 0x4ec 0x02 0x001
 #define MX25_PAD_CSI_HSYNC__GPIO_1_10		0x148 0x340 0x000 0x05 0x000
 
 #define MX25_PAD_CSI_PIXCLK__CSI_PIXCLK		0x14c 0x344 0x000 0x00 0x000
 #define MX25_PAD_CSI_PIXCLK__AUD6_TXFS		0x14c 0x344 0x000 0x01 0x000
-#define MX25_PAD_CSI_PIXCLK__SDHC2_DAT3		0x14c 0x344 0x4f0 0x02 0x001
+#define MX25_PAD_CSI_PIXCLK__ESDHC2_DAT3	0x14c 0x344 0x4f0 0x02 0x001
 #define MX25_PAD_CSI_PIXCLK__GPIO_1_11		0x14c 0x344 0x000 0x05 0x000
 
 #define MX25_PAD_I2C1_CLK__I2C1_CLK		0x150 0x348 0x000 0x00 0x000
@@ -419,37 +419,37 @@
 #define MX25_PAD_UART2_CTS__GPIO_4_29		0x18c 0x384 0x000 0x05 0x000
 
 /*
- * Removing the SION bit from MX25_PAD_SD1_CMD__SD1_CMD breaks detecting an SD
- * card. According to the i.MX25 reference manual (e.g. Figure 23-2 in IMX25RM
- * Rev. 2 from 01/2011) this pin is bidirectional. So it seems to be a silicon
- * bug that configuring the SD1_CMD function doesn't enable the input path for
- * this pin.
+ * Removing the SION bit from MX25_PAD_SD1_CMD__ESDHC1_CMD breaks detecting an
+ * SD card. According to the i.MX25 reference manual (e.g. Figure 23-2 in
+ * IMX25RM Rev. 2 from 01/2011) this pin is bidirectional. So it seems to be a
+ * silicon bug that configuring the ESDHC1_CMD function doesn't enable the input
+ * path for this pin.
  * This might have side effects for other hardware units that are connected to
  * that pin and use the respective function as input.
  */
-#define MX25_PAD_SD1_CMD__SD1_CMD		0x190 0x388 0x000 0x10 0x000
+#define MX25_PAD_SD1_CMD__ESDHC1_CMD		0x190 0x388 0x000 0x10 0x000
 #define MX25_PAD_SD1_CMD__CSPI2_MOSI		0x190 0x388 0x4a0 0x01 0x001
 #define MX25_PAD_SD1_CMD__FEC_RDATA2		0x190 0x388 0x50c 0x02 0x002
 #define MX25_PAD_SD1_CMD__GPIO_2_23		0x190 0x388 0x000 0x05 0x000
 
-#define MX25_PAD_SD1_CLK__SD1_CLK		0x194 0x38c 0x000 0x00 0x000
+#define MX25_PAD_SD1_CLK__ESDHC1_CLK		0x194 0x38c 0x000 0x00 0x000
 #define MX25_PAD_SD1_CLK__CSPI2_MISO		0x194 0x38c 0x49c 0x01 0x001
 #define MX25_PAD_SD1_CLK__FEC_RDATA3		0x194 0x38c 0x510 0x02 0x002
 #define MX25_PAD_SD1_CLK__GPIO_2_24		0x194 0x38c 0x000 0x05 0x000
 
-#define MX25_PAD_SD1_DATA0__SD1_DATA0		0x198 0x390 0x000 0x00 0x000
+#define MX25_PAD_SD1_DATA0__ESDHC1_DAT0		0x198 0x390 0x000 0x00 0x000
 #define MX25_PAD_SD1_DATA0__CSPI2_SCLK		0x198 0x390 0x494 0x01 0x001
 #define MX25_PAD_SD1_DATA0__GPIO_2_25		0x198 0x390 0x000 0x05 0x000
 
-#define MX25_PAD_SD1_DATA1__SD1_DATA1		0x19c 0x394 0x000 0x00 0x000
+#define MX25_PAD_SD1_DATA1__ESDHC1_DAT1		0x19c 0x394 0x000 0x00 0x000
 #define MX25_PAD_SD1_DATA1__AUD7_RXD		0x19c 0x394 0x478 0x03 0x000
 #define MX25_PAD_SD1_DATA1__GPIO_2_26		0x19c 0x394 0x000 0x05 0x000
 
-#define MX25_PAD_SD1_DATA2__SD1_DATA2		0x1a0 0x398 0x000 0x00 0x000
+#define MX25_PAD_SD1_DATA2__ESDHC1_DAT2		0x1a0 0x398 0x000 0x00 0x000
 #define MX25_PAD_SD1_DATA2__FEC_RX_CLK		0x1a0 0x398 0x514 0x02 0x002
 #define MX25_PAD_SD1_DATA2__GPIO_2_27		0x1a0 0x398 0x000 0x05 0x000
 
-#define MX25_PAD_SD1_DATA3__SD1_DATA3		0x1a4 0x39c 0x000 0x00 0x000
+#define MX25_PAD_SD1_DATA3__ESDHC1_DAT3		0x1a4 0x39c 0x000 0x00 0x000
 #define MX25_PAD_SD1_DATA3__FEC_CRS		0x1a4 0x39c 0x508 0x02 0x002
 #define MX25_PAD_SD1_DATA3__GPIO_2_28		0x1a4 0x39c 0x000 0x05 0x000
 
@@ -601,4 +601,28 @@
 #define MX25_PAD_BOOT_MODE1__BOOT_MODE1		0x228 0x000 0x000 0x00 0x000
 #define MX25_PAD_BOOT_MODE1__GPIO_4_31		0x228 0x000 0x000 0x05 0x000
 
+/*
+ * Compatibility defines for out-of-tree users. You should update if you make
+ * use of one of them.
+ */
+#define MX25_PAD_D15__SDHC1_DAT7		MX25_PAD_D15__ESDHC1_DAT7
+#define MX25_PAD_D14__SDHC1_DAT6		MX25_PAD_D14__ESDHC1_DAT6
+#define MX25_PAD_D13__SDHC1_DAT5		MX25_PAD_D13__ESDHC1_DAT5
+#define MX25_PAD_D12__SDHC1_DAT4		MX25_PAD_D12__ESDHC1_DAT4
+#define MX25_PAD_LD8__SDHC2_CMD			MX25_PAD_LD8__ESDHC2_CMD
+#define MX25_PAD_LD9__SDHC2_CLK			MX25_PAD_LD9__ESDHC2_CLK
+#define MX25_PAD_LD11__SDHC2_DAT1		MX25_PAD_LD11__ESDHC2_DAT1
+#define MX25_PAD_CSI_D6__SDHC2_CMD		MX25_PAD_CSI_D6__ESDHC2_CMD
+#define MX25_PAD_CSI_D7__SDHC2_DAT_CLK		MX25_PAD_CSI_D7__ESDHC2_CLK
+#define MX25_PAD_CSI_MCLK__SDHC2_DAT0		MX25_PAD_CSI_MCLK__ESDHC2_DAT0
+#define MX25_PAD_CSI_VSYNC__SDHC2_DAT1		MX25_PAD_CSI_VSYNC__ESDHC2_DAT1
+#define MX25_PAD_CSI_HSYNC__SDHC2_DAT2		MX25_PAD_CSI_HSYNC__ESDHC2_DAT2
+#define MX25_PAD_CSI_PIXCLK__SDHC2_DAT3		MX25_PAD_CSI_PIXCLK__ESDHC2_DAT3
+#define MX25_PAD_SD1_CMD__SD1_CMD		MX25_PAD_SD1_CMD__ESDHC1_CMD
+#define MX25_PAD_SD1_CLK__SD1_CLK		MX25_PAD_SD1_CLK__ESDHC1_CLK
+#define MX25_PAD_SD1_DATA0__SD1_DATA0		MX25_PAD_SD1_DATA0__ESDHC1_DAT0
+#define MX25_PAD_SD1_DATA1__SD1_DATA1		MX25_PAD_SD1_DATA1__ESDHC1_DAT1
+#define MX25_PAD_SD1_DATA2__SD1_DATA2		MX25_PAD_SD1_DATA2__ESDHC1_DAT2
+#define MX25_PAD_SD1_DATA3__SD1_DATA3		MX25_PAD_SD1_DATA3__ESDHC1_DAT3
+
 #endif /* __DTS_IMX25_PINFUNC_H */
-- 
2.14.1
