Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757229AbeDZX71 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 19:59:27 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:37259 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757142AbeDZX7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 19:59:00 -0400
X-Google-Smtp-Source: AB8JxZql5k5PipM45UlpHBO7jQZnP6F6ox2lOgdrpFTkIaO71H9SbV0WnmxBqY2LPJy0x5S8ulGXZQ==
From: Dmitry Osipenko <digetx@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marcel Ziswiler <marcel@ziswiler.com>, Marc Dietrich <marvin24@gmx.de>
Cc: linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/4] clk: tegra20: Set correct parents for CDEV1/2 clocks
Date: Fri, 27 Apr 2018 02:58:17 +0300
Message-Id: <20180426235818.10018-4-digetx@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180426235818.10018-1-digetx@gmail.com>
References: <20180426235818.10018-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Parents of CDEV1/2 clocks are determined by muxing of the corresponding
pins. Pinctrl driver now provides the CDEV1/2 clock muxes and hence
CDEV1/2 clocks could have correct parents. Set CDEV1/2 parents to the
corresponding muxes to fix the parents.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/clk/tegra/clk-tegra20.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/tegra/clk-tegra20.c b/drivers/clk/tegra/clk-tegra20.c
index 16cf4108f2ff..7e8b6de86d89 100644
--- a/drivers/clk/tegra/clk-tegra20.c
+++ b/drivers/clk/tegra/clk-tegra20.c
@@ -844,14 +844,12 @@ static void __init tegra20_periph_clk_init(void)
 			     CLK_DIVIDER_POWER_OF_TWO, NULL);
 
 	/* cdev1 */
-	clk = clk_register_fixed_rate(NULL, "cdev1_fixed", NULL, 0, 26000000);
-	clk = tegra_clk_register_periph_gate("cdev1", "cdev1_fixed", 0,
+	clk = tegra_clk_register_periph_gate("cdev1", "cdev1_mux", 0,
 				    clk_base, 0, 94, periph_clk_enb_refcnt);
 	clks[TEGRA20_CLK_CDEV1] = clk;
 
 	/* cdev2 */
-	clk = clk_register_fixed_rate(NULL, "cdev2_fixed", NULL, 0, 26000000);
-	clk = tegra_clk_register_periph_gate("cdev2", "cdev2_fixed", 0,
+	clk = tegra_clk_register_periph_gate("cdev2", "cdev2_mux", 0,
 				    clk_base, 0, 93, periph_clk_enb_refcnt);
 	clks[TEGRA20_CLK_CDEV2] = clk;
 
-- 
2.17.0
