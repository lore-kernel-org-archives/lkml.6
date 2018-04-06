Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752125AbeDFGk3 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 02:40:29 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:17072 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751977AbeDFGk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 02:40:26 -0400
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
Subject: [PATCH 4/6] clk: stm32mp1: add missing tzc2 clock
Date: Fri, 6 Apr 2018 08:39:31 +0200
Message-ID: <1522996773-24129-5-git-send-email-gabriel.fernandez@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1522996773-24129-1-git-send-email-gabriel.fernandez@st.com>
References: <1522996773-24129-1-git-send-email-gabriel.fernandez@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG7NODE3.st.com (10.75.127.21) To SFHDAG4NODE2.st.com
 (10.75.127.11)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-04-06_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

This patch adds tzc2 clock and rename tzc clock into tzc1

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
---
 drivers/clk/clk-stm32mp1.c                | 9 ++++++---
 include/dt-bindings/clock/stm32mp1-clks.h | 3 ++-
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/clk-stm32mp1.c b/drivers/clk/clk-stm32mp1.c
index eefed49..e32fc23 100644
--- a/drivers/clk/clk-stm32mp1.c
+++ b/drivers/clk/clk-stm32mp1.c
@@ -1399,7 +1399,8 @@ enum {
 	G_USBH,
 	G_ETHSTP,
 	G_RTCAPB,
-	G_TZC,
+	G_TZC1,
+	G_TZC2,
 	G_TZPC,
 	G_IWDG1,
 	G_BSEC,
@@ -1500,7 +1501,8 @@ enum {
 	K_GATE(G_BSEC,		RCC_APB5ENSETR, 16, 0),
 	K_GATE(G_IWDG1,		RCC_APB5ENSETR, 15, 0),
 	K_GATE(G_TZPC,		RCC_APB5ENSETR, 13, 0),
-	K_GATE(G_TZC,		RCC_APB5ENSETR, 12, 0),
+	K_GATE(G_TZC2,		RCC_APB5ENSETR, 12, 0),
+	K_GATE(G_TZC1,		RCC_APB5ENSETR, 11, 0),
 	K_GATE(G_RTCAPB,	RCC_APB5ENSETR, 8, 0),
 	K_MGATE(G_USART1,	RCC_APB5ENSETR, 4, 0),
 	K_MGATE(G_I2C6,		RCC_APB5ENSETR, 3, 0),
@@ -1854,7 +1856,8 @@ enum {
 	PCLK(USART1, "usart1", "pclk5", 0, G_USART1),
 	PCLK(RTCAPB, "rtcapb", "pclk5", CLK_IGNORE_UNUSED |
 	     CLK_IS_CRITICAL, G_RTCAPB),
-	PCLK(TZC, "tzc", "pclk5", CLK_IGNORE_UNUSED, G_TZC),
+	PCLK(TZC1, "tzc1", "ck_axi", CLK_IGNORE_UNUSED, G_TZC1),
+	PCLK(TZC2, "tzc2", "ck_axi", CLK_IGNORE_UNUSED, G_TZC2),
 	PCLK(TZPC, "tzpc", "pclk5", CLK_IGNORE_UNUSED, G_TZPC),
 	PCLK(IWDG1, "iwdg1", "pclk5", 0, G_IWDG1),
 	PCLK(BSEC, "bsec", "pclk5", CLK_IGNORE_UNUSED, G_BSEC),
diff --git a/include/dt-bindings/clock/stm32mp1-clks.h b/include/dt-bindings/clock/stm32mp1-clks.h
index 86e3ec6..6c807fd 100644
--- a/include/dt-bindings/clock/stm32mp1-clks.h
+++ b/include/dt-bindings/clock/stm32mp1-clks.h
@@ -76,7 +76,7 @@
 #define I2C6		63
 #define USART1		64
 #define RTCAPB		65
-#define TZC		66
+#define TZC1		66
 #define TZPC		67
 #define IWDG1		68
 #define BSEC		69
@@ -123,6 +123,7 @@
 #define CRC1		110
 #define USBH		111
 #define ETHSTP		112
+#define TZC2		113
 
 /* Kernel clocks */
 #define SDMMC1_K	118
-- 
1.9.1
