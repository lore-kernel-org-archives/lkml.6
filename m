Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936778AbeE2PFW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 11:05:22 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:43542 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936492AbeE2PFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 11:05:11 -0400
X-Google-Smtp-Source: AB8JxZrTwUz9SMJZaObliZGVoN6DAUlnKOCzOeMLqgzIUcby/gM7Os0gPa8YfQFKVi/MDQnmHwPTKQ==
From: =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        Colin Didier <colin.didier@devialet.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        =?UTF-8?q?Cl=C3=A9ment=20Peron?= <clement.peron@devialet.com>
Subject: [PATCH v2 5/5] ARM: dts: imx6qdl: add missing compatible and clock properties for EPIT
Date: Tue, 29 May 2018 17:04:55 +0200
Message-Id: <20180529150455.17300-6-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180529150455.17300-1-peron.clem@gmail.com>
References: <20180529150455.17300-1-peron.clem@gmail.com>
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
 arch/arm/boot/dts/imx6qdl.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index c003e62bf290..16fec147dcb8 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -844,13 +844,25 @@
 			};
 
 			epit1: epit@20d0000 { /* EPIT1 */
+				compatible = "fsl,imx6q-epit";
 				reg = <0x020d0000 0x4000>;
 				interrupts = <0 56 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6QDL_CLK_EPIT1>,
+					<&clks IMX6QDL_CLK_IPG_PER>,
+					<&clks IMX6QDL_CLK_CKIL>;
+				clock-names = "ipg", "per", "ckil";
+				status = "disabled";
 			};
 
 			epit2: epit@20d4000 { /* EPIT2 */
+				compatible = "fsl,imx6q-epit";
 				reg = <0x020d4000 0x4000>;
 				interrupts = <0 57 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6QDL_CLK_EPIT2>,
+					<&clks IMX6QDL_CLK_IPG_PER>,
+					<&clks IMX6QDL_CLK_CKIL>;
+				clock-names = "ipg", "per", "ckil";
+				status = "disabled";
 			};
 
 			src: src@20d8000 {
-- 
2.17.0
