Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752514AbeDQJQf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 05:16:35 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:58872 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751211AbeDQJQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 05:16:33 -0400
From: <gabriel.fernandez@st.com>
To: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        benjamin GAIGNARD <benjamin.gaignard@st.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <gabriel.fernandez@st.com>
Subject: [PATCH] clk: stm32: fix: stm32 clock drivers are not compiled by default
Date: Tue, 17 Apr 2018 11:15:19 +0200
Message-ID: <1523956519-20976-1-git-send-email-gabriel.fernandez@st.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.119]
X-ClientProxiedBy: GPXDAG7NODE4.st.com (10.75.127.83) To GPXDAG4NODE5.st.com
 (10.75.127.75)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-17_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

Clock driver is mandatory if the machine is selected.
Then don't use 'bool' and 'depends on' commands, but 'def_bool'
with the machine(s).

Fixes: da32d3539fca ("clk: stm32: add configuration flags for each of the stm32 drivers")


Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
---
 drivers/clk/Kconfig | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 41492e9..34968a3 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -266,15 +266,13 @@ config COMMON_CLK_STM32MP157
 	  Support for stm32mp157 SoC family clocks
 
 config COMMON_CLK_STM32F
-	bool "Clock driver for stm32f4 and stm32f7 SoC families"
-	depends on MACH_STM32F429 || MACH_STM32F469 || MACH_STM32F746
+	def_bool COMMON_CLK && (MACH_STM32F429 || MACH_STM32F469 || MACH_STM32F746)
 	help
 	---help---
 	  Support for stm32f4 and stm32f7 SoC families clocks
 
 config COMMON_CLK_STM32H7
-	bool "Clock driver for stm32h7 SoC family"
-	depends on MACH_STM32H743
+	def_bool COMMON_CLK && MACH_STM32H743
 	help
 	---help---
 	  Support for stm32h7 SoC family clocks
-- 
1.9.1
