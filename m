Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754792AbeE1RfD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 13:35:03 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36874 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754650AbeE1ReY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 13:34:24 -0400
X-Google-Smtp-Source: AB8JxZpf9zkzLg7wEVzYV3+iSaRc39hNknpLBXF74lIsopksIX9tlIpTXKxNTQkizEwiA8eXMlr7DA==
From: =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To: Colin Didier <colin.dider@devialet.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>, NXP Linux Team <linux-imx@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Cl=C3=A9ment=20Peron?= <clement.peron@devialet.com>
Subject: [PATCH 3/5] Documentation: DT: add i.MX EPIT timer binding
Date: Mon, 28 May 2018 19:34:10 +0200
Message-Id: <20180528173412.10000-4-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528173412.10000-1-peron.clem@gmail.com>
References: <20180528173412.10000-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Clément Peron <clement.peron@devialet.com>

Add devicetree binding document for NXP's i.MX SoC specific
EPIT timer driver.

Signed-off-by: Clément Peron <clement.peron@devialet.com>
---
 .../devicetree/bindings/clock/imx6q,epit.txt  | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/imx6q,epit.txt

diff --git a/Documentation/devicetree/bindings/clock/imx6q,epit.txt b/Documentation/devicetree/bindings/clock/imx6q,epit.txt
new file mode 100644
index 000000000000..d54d455cebdc
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/imx6q,epit.txt
@@ -0,0 +1,25 @@
+Binding for the i.MX6 EPIT timer
+
+This binding uses the common clock binding[1].
+
+[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
+
+Required properties:
+- compatible: should be "fsl,imx6q-epit"
+- reg: physical base address of the controller and length of memory mapped
+  region.
+- interrupts: Should contain EPIT controller interrupt
+- clocks: list of clock specifiers, must contain an entry for each required
+  entry in clock-names
+- clock-names : as described in the clock bindings
+
+Example:
+	epit1: epit@20d0000 {
+		compatible = "fsl,imx6q-epit";
+		reg = <0x020d0000 0x4000>;
+		interrupts = <0 56 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&clks IMX6QDL_CLK_EPIT1>,
+			<&clks IMX6QDL_CLK_IPG_PER>,
+			<&clks IMX6QDL_CLK_CKIL>;
+		clock-names = "ipg", "per", "ckil";
+	};
-- 
2.17.0
