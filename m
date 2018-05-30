Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753335AbeE3OKe (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 10:10:34 -0400
Received: from fllnx209.ext.ti.com ([198.47.19.16]:25601 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752734AbeE3OK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 10:10:27 -0400
From: Faiz Abbas <faiz_abbas@ti.com>
To: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>
CC: <robh+dt@kernel.org>, <bcousson@baylibre.com>, <tony@atomide.com>,
        <paul@pwsan.com>, <t-kristo@ti.com>, <faiz_abbas@ti.com>
Subject: [PATCH v2 3/6] clk: ti: dra7: Add clkctrl clock data for the mcan clocks
Date: Wed, 30 May 2018 19:41:30 +0530
Message-ID: <20180530141133.3711-4-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180530141133.3711-1-faiz_abbas@ti.com>
References: <20180530141133.3711-1-faiz_abbas@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add clkctrl data for the m_can clocks and register it within the
clkctrl driver

CC: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 drivers/clk/ti/clk-7xx.c         | 1 +
 include/dt-bindings/clock/dra7.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/clk/ti/clk-7xx.c b/drivers/clk/ti/clk-7xx.c
index fb249a1637a5..71a122b2dc67 100644
--- a/drivers/clk/ti/clk-7xx.c
+++ b/drivers/clk/ti/clk-7xx.c
@@ -708,6 +708,7 @@ static const struct omap_clkctrl_reg_data dra7_wkupaon_clkctrl_regs[] __initcons
 	{ DRA7_COUNTER_32K_CLKCTRL, NULL, 0, "wkupaon_iclk_mux" },
 	{ DRA7_UART10_CLKCTRL, dra7_uart10_bit_data, CLKF_SW_SUP, "wkupaon_cm:clk:0060:24" },
 	{ DRA7_DCAN1_CLKCTRL, dra7_dcan1_bit_data, CLKF_SW_SUP, "wkupaon_cm:clk:0068:24" },
+	{ DRA7_ADC_CLKCTRL, NULL, CLKF_SW_SUP, "mcan_clk" },
 	{ 0 },
 };
 
diff --git a/include/dt-bindings/clock/dra7.h b/include/dt-bindings/clock/dra7.h
index 5e1061b15aed..d7549c57cac3 100644
--- a/include/dt-bindings/clock/dra7.h
+++ b/include/dt-bindings/clock/dra7.h
@@ -168,5 +168,6 @@
 #define DRA7_COUNTER_32K_CLKCTRL	DRA7_CLKCTRL_INDEX(0x50)
 #define DRA7_UART10_CLKCTRL	DRA7_CLKCTRL_INDEX(0x80)
 #define DRA7_DCAN1_CLKCTRL	DRA7_CLKCTRL_INDEX(0x88)
+#define DRA7_ADC_CLKCTRL	DRA7_CLKCTRL_INDEX(0xa0)
 
 #endif
-- 
2.17.0
