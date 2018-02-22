Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932871AbeBVOXa (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 09:23:30 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35224 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932848AbeBVOX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 09:23:28 -0500
X-Google-Smtp-Source: AH8x226BzgmDK4mdy3+yShEzABCGRaeXT9vHR9kHqyOI6GyoLn3TBSpYFsPWyjCSoA1wjZawanKI0Q==
From: Rui Miguel Silva <rui.silva@linaro.org>
To: horia.geanta@nxp.com, aymen.sghaier@nxp.com,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ryan Harkin <ryan.harkin@linaro.org>,
        "Bryan O'Donoghue" <pure.logic@nexus-software.ie>,
        Rui Miguel Silva <rui.silva@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, linux-clk@vger.kernel.org,
        Fabio Estevam <fabio.estevam@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Lukas Auer <lukas.auer@aisec.fraunhofer.de>
Subject: [PATCH v4 3/4] clk: imx7d: add CAAM clock
Date: Thu, 22 Feb 2018 14:22:49 +0000
Message-Id: <20180222142250.31348-4-rui.silva@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180222142250.31348-1-rui.silva@linaro.org>
References: <20180222142250.31348-1-rui.silva@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add CAAM clock so that we could use the Cryptographic Acceleration and
Assurance Module (CAAM) hardware block.

Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-clk@vger.kernel.org
Cc: "Horia Geantă" <horia.geanta@nxp.com>
Cc: Aymen Sghaier <aymen.sghaier@nxp.com>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Lukas Auer <lukas.auer@aisec.fraunhofer.de>
Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Rui Miguel Silva <rui.silva@linaro.org>
---
 drivers/clk/imx/clk-imx7d.c             | 1 +
 include/dt-bindings/clock/imx7d-clock.h | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx7d.c b/drivers/clk/imx/clk-imx7d.c
index 80dc211eb74b..52ab096fb39c 100644
--- a/drivers/clk/imx/clk-imx7d.c
+++ b/drivers/clk/imx/clk-imx7d.c
@@ -795,6 +795,7 @@ static void __init imx7d_clocks_init(struct device_node *ccm_node)
 	clks[IMX7D_DRAM_PHYM_ALT_ROOT_CLK] = imx_clk_gate4("dram_phym_alt_root_clk", "dram_phym_alt_post_div", base + 0x4130, 0);
 	clks[IMX7D_DRAM_ALT_ROOT_CLK] = imx_clk_gate4("dram_alt_root_clk", "dram_alt_post_div", base + 0x4130, 0);
 	clks[IMX7D_OCOTP_CLK] = imx_clk_gate4("ocotp_clk", "ipg_root_clk", base + 0x4230, 0);
+	clks[IMX7D_CAAM_CLK] = imx_clk_gate4("caam_clk", "ipg_root_clk", base + 0x4240, 0);
 	clks[IMX7D_USB_HSIC_ROOT_CLK] = imx_clk_gate4("usb_hsic_root_clk", "usb_hsic_post_div", base + 0x4420, 0);
 	clks[IMX7D_SDMA_CORE_CLK] = imx_clk_gate4("sdma_root_clk", "ahb_root_clk", base + 0x4480, 0);
 	clks[IMX7D_PCIE_CTRL_ROOT_CLK] = imx_clk_gate4("pcie_ctrl_root_clk", "pcie_ctrl_post_div", base + 0x4600, 0);
diff --git a/include/dt-bindings/clock/imx7d-clock.h b/include/dt-bindings/clock/imx7d-clock.h
index e2f99ae72d5c..2bc5618feaeb 100644
--- a/include/dt-bindings/clock/imx7d-clock.h
+++ b/include/dt-bindings/clock/imx7d-clock.h
@@ -452,5 +452,6 @@
 #define IMX7D_OCOTP_CLK			439
 #define IMX7D_NAND_RAWNAND_CLK		440
 #define IMX7D_NAND_USDHC_BUS_RAWNAND_CLK 441
-#define IMX7D_CLK_END			442
+#define IMX7D_CAAM_CLK			442
+#define IMX7D_CLK_END			443
 #endif /* __DT_BINDINGS_CLOCK_IMX7D_H */
-- 
2.16.2
