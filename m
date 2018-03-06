Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754125AbeCFWBY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 17:01:24 -0500
Received: from botnar.kaiser.cx ([176.28.20.183]:40582 "EHLO botnar.kaiser.cx"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753805AbeCFWBW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 17:01:22 -0500
From: Martin Kaiser <martin@kaiser.cx>
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH] ARM: dts: i.MX25: define SSI FIFO depth
Date: Tue,  6 Mar 2018 22:58:19 +0100
Message-Id: <1520373499-13623-1-git-send-email-martin@kaiser.cx>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the i.MX25 reference manuals, each SSI has four FIFOs. All
of those FIFOs can store up to 15 entries.

The fsl_ssi driver's internal default for the FIFO depth in 8. Set our
non-default FIFO depth explicitly in the Device Tree.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 arch/arm/boot/dts/imx25.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
index 9725705..cf70df2 100644
--- a/arch/arm/boot/dts/imx25.dtsi
+++ b/arch/arm/boot/dts/imx25.dtsi
@@ -269,6 +269,7 @@
 				dmas = <&sdma 24 1 0>,
 				       <&sdma 25 1 0>;
 				dma-names = "rx", "tx";
+				fsl,fifo-depth = <15>;
 				status = "disabled";
 			};
 
@@ -329,6 +330,7 @@
 				dmas = <&sdma 28 1 0>,
 				       <&sdma 29 1 0>;
 				dma-names = "rx", "tx";
+				fsl,fifo-depth = <15>;
 				status = "disabled";
 			};
 
-- 
2.1.4
