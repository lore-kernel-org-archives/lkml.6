Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753289AbeAaVgM (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 16:36:12 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36402 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753183AbeAaVf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 16:35:58 -0500
X-Google-Smtp-Source: AH8x227OspmB4LOiEEjzTJ3tz1ww94DqTZQgh4LgHh8i3mRFJMSV6HfyAm8nFg/dyEXqOlqwVdzT+w==
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
Subject: [PATCH v3 2/2] ARM: dts: imx25-pinfunc: Always set SION for eSDHC CMD
Date: Wed, 31 Jan 2018 22:35:44 +0100
Message-Id: <20180131213544.4508-2-benoit.thebaudeau.dev@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180131213544.4508-1-benoit.thebaudeau.dev@gmail.com>
References: <20180131213544.4508-1-benoit.thebaudeau.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The eSDHC does not work properly if the SION bit is not set for the
bidirectional CMD signal, whatever the eSDHC instance and the selected
pad. Therefore, setting SION is mandatory for all eSDHC CMD ports. Do
this for MX25_PAD_*__ESDHCn_CMD in imx25-pinfunc.h in order to enforce
this behavior for all boards.

This had already been done for eSDHC1, but not for eSDHC2. Also, define
MX25_PAD_FEC_MDC__ESDHC2_CMD so that all the possible cases are covered
from now on.

Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Benoît Thébaudeau <benoit.thebaudeau.dev@gmail.com>
Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
---
Changes v2 -> v3:
 - Quickly mention SION in each comment, besides the reference to the
   verbose comment (suggested by Uwe).
Changes v1 -> v2:
 - Update eSDHC instance and port naming following the addition of "ARM:
   dts: imx25-pinfunc: Use consistent naming for eSDHC".
 - Reference the more verbose comment for MX25_PAD_SD1_CMD__ESDHC1_CMD
   instead of copying the same less detailed comment everywhere
   (suggested by Uwe).
---
 arch/arm/boot/dts/imx25-pinfunc.h | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/imx25-pinfunc.h b/arch/arm/boot/dts/imx25-pinfunc.h
index 2915c65a13c9..a4807062a90f 100644
--- a/arch/arm/boot/dts/imx25-pinfunc.h
+++ b/arch/arm/boot/dts/imx25-pinfunc.h
@@ -236,7 +236,8 @@
 #define MX25_PAD_LD8__LD8			0x0e8 0x2e0 0x000 0x00 0x000
 #define MX25_PAD_LD8__UART4_RXD			0x0e8 0x2e0 0x570 0x02 0x000
 #define MX25_PAD_LD8__FEC_TX_ERR		0x0e8 0x2e0 0x000 0x05 0x000
-#define MX25_PAD_LD8__ESDHC2_CMD		0x0e8 0x2e0 0x4e0 0x06 0x000
+/* SION must be set; see the comment for MX25_PAD_SD1_CMD__ESDHC1_CMD. */
+#define MX25_PAD_LD8__ESDHC2_CMD		0x0e8 0x2e0 0x4e0 0x16 0x000
 
 #define MX25_PAD_LD9__LD9			0x0ec 0x2e4 0x000 0x00 0x000
 #define MX25_PAD_LD9__UART4_TXD			0x0ec 0x2e4 0x000 0x02 0x000
@@ -316,7 +317,8 @@
 #define MX25_PAD_CSI_D5__CSPI3_RDY		0x12c 0x324 0x000 0x07 0x000
 
 #define MX25_PAD_CSI_D6__CSI_D6			0x130 0x328 0x000 0x00 0x000
-#define MX25_PAD_CSI_D6__ESDHC2_CMD		0x130 0x328 0x4e0 0x02 0x001
+/* SION must be set; see the comment for MX25_PAD_SD1_CMD__ESDHC1_CMD. */
+#define MX25_PAD_CSI_D6__ESDHC2_CMD		0x130 0x328 0x4e0 0x12 0x001
 #define MX25_PAD_CSI_D6__SIM1_PD0		0x130 0x328 0x000 0x04 0x000
 #define MX25_PAD_CSI_D6__GPIO_1_31		0x130 0x328 0x000 0x05 0x000
 
@@ -419,11 +421,11 @@
 #define MX25_PAD_UART2_CTS__GPIO_4_29		0x18c 0x384 0x000 0x05 0x000
 
 /*
- * Removing the SION bit from MX25_PAD_SD1_CMD__ESDHC1_CMD breaks detecting an
- * SD card. According to the i.MX25 reference manual (e.g. Figure 23-2 in
- * IMX25RM Rev. 2 from 01/2011) this pin is bidirectional. So it seems to be a
- * silicon bug that configuring the ESDHC1_CMD function doesn't enable the input
- * path for this pin.
+ * Removing the SION bit from MX25_PAD_*__ESDHCn_CMD breaks detecting an SD
+ * card. According to the i.MX25 reference manual (e.g. Figure 23-2 in IMX25RM
+ * Rev. 2 from 01/2011) this pin is bidirectional. So it seems to be a silicon
+ * bug that configuring the ESDHCn_CMD function doesn't enable the input path
+ * for this pin.
  * This might have side effects for other hardware units that are connected to
  * that pin and use the respective function as input.
  */
@@ -496,6 +498,8 @@
 #define MX25_PAD_KPP_COL3__GPIO_3_4		0x1c4 0x3bc 0x000 0x05 0x000
 
 #define MX25_PAD_FEC_MDC__FEC_MDC		0x1c8 0x3c0 0x000 0x00 0x000
+/* SION must be set; see the comment for MX25_PAD_SD1_CMD__ESDHC1_CMD. */
+#define MX25_PAD_FEC_MDC__ESDHC2_CMD		0x1c8 0x3c0 0x4e0 0x11 0x002
 #define MX25_PAD_FEC_MDC__AUD4_TXD		0x1c8 0x3c0 0x464 0x02 0x001
 #define MX25_PAD_FEC_MDC__GPIO_3_5		0x1c8 0x3c0 0x000 0x05 0x000
 
-- 
2.14.1
