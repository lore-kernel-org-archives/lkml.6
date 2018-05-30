Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752968AbeE3MEN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 08:04:13 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52198 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752502AbeE3MEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 08:04:00 -0400
X-Google-Smtp-Source: ADUXVKIu4IgH/7+yhkubxvsFW2ku/a1xUenpPQPWpGD50U7QsdL5CntA6IIVJL5AqSQnQNfuX/CsUw==
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
Subject: [PATCH v4 5/5] ARM: dts: imx6qdl: add missing compatible and clock properties for EPIT
Date: Wed, 30 May 2018 14:03:27 +0200
Message-Id: <20180530120327.27681-6-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180530120327.27681-1-peron.clem@gmail.com>
References: <20180530120327.27681-1-peron.clem@gmail.com>
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
Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx6qdl.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index c003e62bf290..0feec516847a 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -844,13 +844,23 @@
 			};
 
 			epit1: epit@20d0000 { /* EPIT1 */
+				compatible = "fsl,imx6q-epit", "fsl,imx31-epit";
 				reg = <0x020d0000 0x4000>;
 				interrupts = <0 56 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6QDL_CLK_IPG_PER>,
+					 <&clks IMX6QDL_CLK_EPIT1>;
+				clock-names = "ipg", "per";
+				status = "disabled";
 			};
 
 			epit2: epit@20d4000 { /* EPIT2 */
+				compatible = "fsl,imx6q-epit", "fsl,imx31-epit";
 				reg = <0x020d4000 0x4000>;
 				interrupts = <0 57 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6QDL_CLK_IPG_PER>,
+					 <&clks IMX6QDL_CLK_EPIT2>;
+				clock-names = "ipg", "per";
+				status = "disabled";
 			};
 
 			src: src@20d8000 {
-- 
2.17.0
