Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jhSG4H2y"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3592F607C7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932122AbeFFGHj (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 02:07:39 -0400
Received: from lelnx194.ext.ti.com ([198.47.27.80]:42342 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752371AbeFFGHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 02:07:33 -0400
From: Faiz Abbas <faiz_abbas@ti.com>
To: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-clk@vger.kernel.org>
CC: <robh+dt@kernel.org>, <bcousson@baylibre.com>, <tony@atomide.com>,
        <paul@pwsan.com>, <t-kristo@ti.com>, <faiz_abbas@ti.com>,
        <mark.rutland@arm.com>
Subject: [PATCH v3 2/6] clk: ti: dra7: Add clkctrl clock data for the mcan clocks
Date: Wed, 6 Jun 2018 11:38:22 +0530
Message-ID: <20180606060826.14671-3-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180606060826.14671-1-faiz_abbas@ti.com>
References: <20180606060826.14671-1-faiz_abbas@ti.com>
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
+	{ DRA7_ADC_CLKCTRL, NULL, CLKF_SW_SUP, "mcan_clk"},
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
