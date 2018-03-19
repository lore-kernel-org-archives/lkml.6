Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755106AbeCSD7N (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 23:59:13 -0400
Received: from regular1.263xmail.com ([211.150.99.141]:48633 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754375AbeCSD7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 23:59:11 -0400
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: jeffy.chen@rock-chips.com
X-FST-TO: linux-kernel@vger.kernel.org
X-SENDER-IP: 103.29.142.67
X-LOGIN-NAME: jeffy.chen@rock-chips.com
X-UNIQUE-TAG: <381e07299b88db5bb8cab735c2bf8742>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From: Jeffy Chen <jeffy.chen@rock-chips.com>
To: linux-kernel@vger.kernel.org, broonie@kernel.org,
        alexandre.belloni@bootlin.com
Cc: Jeffy Chen <jeffy.chen@rock-chips.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Gabriel Fernandez <gabriel.fernandez@st.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Jerome Brunet <jbrunet@baylibre.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH v6] clk: lpc32xx: Set name of regmap_config
Date: Mon, 19 Mar 2018 11:58:54 +0800
Message-Id: <20180319035854.3265-1-jeffy.chen@rock-chips.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are now allowing to register debugfs without a valid device, and not
having a valid name will end up using "dummy*" to create debugfs dir.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
Acked-by: Vladimir Zapolskiy <vz@mleia.com>
---

Changes in v6:
Modify name as Vladimir suggested.

 drivers/clk/nxp/clk-lpc32xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/nxp/clk-lpc32xx.c b/drivers/clk/nxp/clk-lpc32xx.c
index f5d815f577e0..5eeecee17b69 100644
--- a/drivers/clk/nxp/clk-lpc32xx.c
+++ b/drivers/clk/nxp/clk-lpc32xx.c
@@ -67,6 +67,7 @@
 #define LPC32XX_USB_CLK_STS		0xF8
 
 static struct regmap_config lpc32xx_scb_regmap_config = {
+	.name = "scb",
 	.reg_bits = 32,
 	.val_bits = 32,
 	.reg_stride = 4,
-- 
2.11.0
