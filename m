Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751704AbeDFGlX (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 02:41:23 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:57768 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751562AbeDFGkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 02:40:24 -0400
From: <gabriel.fernandez@st.com>
To: <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Lee Jones <lee.jones@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Gabriel Fernandez <gabriel.fernandez@st.com>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <gabriel.fernandez.st@gmail.com>, <olivier.bideau@st.com>,
        Loic PALLARDY <loic.pallardy@st.com>,
        benjamin GAIGNARD <benjamin.gaignard@st.com>
Subject: [PATCH 3/6] clk: stm32mp1: fix SAI3 & SAI4 clocks
Date: Fri, 6 Apr 2018 08:39:30 +0200
Message-ID: <1522996773-24129-4-git-send-email-gabriel.fernandez@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1522996773-24129-1-git-send-email-gabriel.fernandez@st.com>
References: <1522996773-24129-1-git-send-email-gabriel.fernandez@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG1NODE1.st.com (10.75.127.1) To SFHDAG4NODE2.st.com
 (10.75.127.11)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-04-06_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

fix bad copy / paste.
SAI3 & SAI4 used gate of SAI2 instead SAI3 & SAI4

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
---
 drivers/clk/clk-stm32mp1.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-stm32mp1.c b/drivers/clk/clk-stm32mp1.c
index 9a67b1c..eefed49 100644
--- a/drivers/clk/clk-stm32mp1.c
+++ b/drivers/clk/clk-stm32mp1.c
@@ -1942,8 +1942,8 @@ enum {
 	KCLK(FDCAN_K, "fdcan_k", fdcan_src, 0, G_FDCAN, M_FDCAN),
 	KCLK(SAI1_K, "sai1_k", sai_src, 0, G_SAI1, M_SAI1),
 	KCLK(SAI2_K, "sai2_k", sai2_src, 0, G_SAI2, M_SAI2),
-	KCLK(SAI3_K, "sai3_k", sai_src, 0, G_SAI2, M_SAI3),
-	KCLK(SAI4_K, "sai4_k", sai_src, 0, G_SAI2, M_SAI4),
+	KCLK(SAI3_K, "sai3_k", sai_src, 0, G_SAI3, M_SAI3),
+	KCLK(SAI4_K, "sai4_k", sai_src, 0, G_SAI4, M_SAI4),
 	KCLK(ADC12_K, "adc12_k", adc12_src, 0, G_ADC12, M_ADC12),
 	KCLK(DSI_K, "dsi_k", dsi_src, 0, G_DSI, M_DSI),
 	KCLK(ADFSDM_K, "adfsdm_k", sai_src, 0, G_ADFSDM, M_SAI1),
-- 
1.9.1
