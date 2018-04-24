Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756191AbeDXH7d (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 03:59:33 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:12538 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755968AbeDXH7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 03:59:30 -0400
From: <gabriel.fernandez@st.com>
To: <sboyd@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <olivier.bideau@st.com>,
        Loic PALLARDY <loic.pallardy@st.com>,
        benjamin GAIGNARD <benjamin.gaignard@st.com>,
        Gabriel Fernandez <gabriel.fernandez@st.com>
Subject: [PATCH] clk: stm32mp1: Add CLK_IGNORE_UNUSED to ck_sys_dbg clock
Date: Tue, 24 Apr 2018 09:58:43 +0200
Message-ID: <1524556723-26926-1-git-send-email-gabriel.fernandez@st.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG8NODE2.st.com (10.75.127.23) To SFHDAG4NODE2.st.com
 (10.75.127.11)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-24_01:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

Don't disable the dbg clock if was set by bootloader.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
---
 drivers/clk/clk-stm32mp1.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-stm32mp1.c b/drivers/clk/clk-stm32mp1.c
index edd3cf4..35dabf1 100644
--- a/drivers/clk/clk-stm32mp1.c
+++ b/drivers/clk/clk-stm32mp1.c
@@ -1988,7 +1988,8 @@ enum {
 		  _DIV(RCC_MCO2CFGR, 4, 4, 0, NULL)),
 
 	/* Debug clocks */
-	GATE(CK_DBG, "ck_sys_dbg", "ck_axi", 0, RCC_DBGCFGR, 8, 0),
+	GATE(CK_DBG, "ck_sys_dbg", "ck_axi", CLK_IGNORE_UNUSED,
+	     RCC_DBGCFGR, 8, 0),
 
 	COMPOSITE(CK_TRACE, "ck_trace", ck_trace_src, CLK_OPS_PARENT_ENABLE,
 		  _GATE(RCC_DBGCFGR, 9, 0),
-- 
1.9.1
