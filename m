Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936827AbeE2PGD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 11:06:03 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:37679 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935448AbeE2PFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 11:05:07 -0400
X-Google-Smtp-Source: AB8JxZqe3lh4d4wP313B1sriqfDFrtdQ6X+V9OJ1AOCKKuqb4O/hh0n1ouyVCDIWs7JBnIla2MW1tA==
From: =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        Colin Didier <colin.didier@devialet.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        =?UTF-8?q?Cl=C3=A9ment=20Peron?= <clement.peron@devialet.com>
Subject: [PATCH v2 2/5] ARM: clk-imx6q: add EPIT clock support
Date: Tue, 29 May 2018 17:04:52 +0200
Message-Id: <20180529150455.17300-3-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180529150455.17300-1-peron.clem@gmail.com>
References: <20180529150455.17300-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Didier <colin.didier@devialet.com>

Add EPIT clock support to the i.MX6Q clocking infrastructure.

Signed-off-by: Colin Didier <colin.didier@devialet.com>
Signed-off-by: Clément Peron <clement.peron@devialet.com>
---
 drivers/clk/imx/clk-imx6q.c               | 2 ++
 include/dt-bindings/clock/imx6qdl-clock.h | 4 +++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx6q.c b/drivers/clk/imx/clk-imx6q.c
index 8d518ad5dc13..b9ea7037e193 100644
--- a/drivers/clk/imx/clk-imx6q.c
+++ b/drivers/clk/imx/clk-imx6q.c
@@ -753,6 +753,8 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 	else
 		clk[IMX6Q_CLK_ECSPI5] = imx_clk_gate2("ecspi5",        "ecspi_root",        base + 0x6c, 8);
 	clk[IMX6QDL_CLK_ENET]         = imx_clk_gate2("enet",          "ipg",               base + 0x6c, 10);
+	clk[IMX6QDL_CLK_EPIT1]        = imx_clk_gate2("epit1",         "ipg",               base + 0x6c, 12);
+	clk[IMX6QDL_CLK_EPIT2]        = imx_clk_gate2("epit2",         "ipg",               base + 0x6c, 14);
 	clk[IMX6QDL_CLK_ESAI_EXTAL]   = imx_clk_gate2_shared("esai_extal",   "esai_podf",   base + 0x6c, 16, &share_count_esai);
 	clk[IMX6QDL_CLK_ESAI_IPG]     = imx_clk_gate2_shared("esai_ipg",   "ahb",           base + 0x6c, 16, &share_count_esai);
 	clk[IMX6QDL_CLK_ESAI_MEM]     = imx_clk_gate2_shared("esai_mem", "ahb",             base + 0x6c, 16, &share_count_esai);
diff --git a/include/dt-bindings/clock/imx6qdl-clock.h b/include/dt-bindings/clock/imx6qdl-clock.h
index da59fd9cdb5e..7ad171b8f3bf 100644
--- a/include/dt-bindings/clock/imx6qdl-clock.h
+++ b/include/dt-bindings/clock/imx6qdl-clock.h
@@ -271,6 +271,8 @@
 #define IMX6QDL_CLK_PRE_AXI			258
 #define IMX6QDL_CLK_MLB_SEL			259
 #define IMX6QDL_CLK_MLB_PODF			260
-#define IMX6QDL_CLK_END				261
+#define IMX6QDL_CLK_EPIT1			261
+#define IMX6QDL_CLK_EPIT2			262
+#define IMX6QDL_CLK_END				263
 
 #endif /* __DT_BINDINGS_CLOCK_IMX6QDL_H */
-- 
2.17.0
