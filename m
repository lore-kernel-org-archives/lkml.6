Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751344AbeCLJEt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 05:04:49 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:9349 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751248AbeCLJEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 05:04:47 -0400
From: <patrice.chotard@st.com>
To: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
CC: <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Patrice Chotard <patrice.chotard@st.com>
Subject: [RESEND PATCH] clk: stm32: Add clk entry for SDMMC2 on stm32F769
Date: Mon, 12 Mar 2018 10:04:07 +0100
Message-ID: <1520845447-10279-1-git-send-email-patrice.chotard@st.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG4NODE3.st.com (10.75.127.12) To SFHDAG6NODE3.st.com
 (10.75.127.18)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-12_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrice Chotard <patrice.chotard@st.com>

STM32F769 has 2 SDMMC port, add clock entry for the second one.

Signed-off-by: Alexandre TORGUE <alexandre.torgue@st.com>
Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
Acked-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/clk/clk-stm32f4.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-stm32f4.c b/drivers/clk/clk-stm32f4.c
index da44f8dc1d29..e7e3965c7aae 100644
--- a/drivers/clk/clk-stm32f4.c
+++ b/drivers/clk/clk-stm32f4.c
@@ -282,6 +282,7 @@ struct stm32f4_gate_data {
 
 	{ STM32F4_RCC_APB2ENR,  0,	"tim1",		"apb2_mul" },
 	{ STM32F4_RCC_APB2ENR,  1,	"tim8",		"apb2_mul" },
+	{ STM32F4_RCC_APB2ENR,  7,	"sdmmc2",	"sdmux"    },
 	{ STM32F4_RCC_APB2ENR,  8,	"adc1",		"apb2_div" },
 	{ STM32F4_RCC_APB2ENR,  9,	"adc2",		"apb2_div" },
 	{ STM32F4_RCC_APB2ENR, 10,	"adc3",		"apb2_div" },
@@ -315,7 +316,7 @@ struct stm32f4_gate_data {
 
 static const u64 stm32f746_gate_map[MAX_GATE_MAP] = { 0x000000f17ef417ffull,
 						      0x0000000000000003ull,
-						      0x04f77f033e01c9ffull };
+						      0x04f77f833e01c9ffull };
 
 static const u64 *stm32f4_gate_map;
 
-- 
1.9.1
