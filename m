Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752037AbeDFGk0 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 02:40:26 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:3925 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751558AbeDFGkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 02:40:22 -0400
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
Subject: [PATCH 5/6] clk: stm32mp1: set stgen_k clock as critical
Date: Fri, 6 Apr 2018 08:39:32 +0200
Message-ID: <1522996773-24129-6-git-send-email-gabriel.fernandez@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1522996773-24129-1-git-send-email-gabriel.fernandez@st.com>
References: <1522996773-24129-1-git-send-email-gabriel.fernandez@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG7NODE1.st.com (10.75.127.19) To SFHDAG4NODE2.st.com
 (10.75.127.11)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-04-06_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

stgen_k should be declared as critical to avoid blocking console
when ck_hsi is not used.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
---
 drivers/clk/clk-stm32mp1.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/clk/clk-stm32mp1.c b/drivers/clk/clk-stm32mp1.c
index e32fc23..b7b5361 100644
--- a/drivers/clk/clk-stm32mp1.c
+++ b/drivers/clk/clk-stm32mp1.c
@@ -1913,8 +1913,7 @@ enum {
 	KCLK(RNG1_K, "rng1_k", rng_src, 0, G_RNG1, M_RNG1),
 	KCLK(RNG2_K, "rng2_k", rng_src, 0, G_RNG2, M_RNG2),
 	KCLK(USBPHY_K, "usbphy_k", usbphy_src, 0, G_USBPHY, M_USBPHY),
-	KCLK(STGEN_K, "stgen_k",  stgen_src, CLK_IGNORE_UNUSED,
-	     G_STGEN, M_STGEN),
+	KCLK(STGEN_K, "stgen_k", stgen_src, CLK_IS_CRITICAL, G_STGEN, M_STGEN),
 	KCLK(SPDIF_K, "spdif_k", spdif_src, 0, G_SPDIF, M_SPDIF),
 	KCLK(SPI1_K, "spi1_k", spi123_src, 0, G_SPI1, M_SPI1),
 	KCLK(SPI2_K, "spi2_k", spi123_src, 0, G_SPI2, M_SPI23),
-- 
1.9.1
