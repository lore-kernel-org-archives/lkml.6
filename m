Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932994AbeEHQ3S (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 12:29:18 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:42814 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932735AbeEHQ3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 12:29:15 -0400
X-Google-Smtp-Source: AB8JxZruXRRZNbV43CbALF5NUsHSY1O2viusk9XbyTrpBSuPF0RxynLv7mEc56/rHRKC1xV8QCJ+xA==
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
Subject: [PATCH v3 2/4] clk: tegra20: Correct parents of CDEV1/2 clocks
Date: Tue,  8 May 2018 19:26:05 +0300
Message-Id: <20180508162607.3500-4-digetx@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508162607.3500-1-digetx@gmail.com>
References: <20180508162607.3500-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Parents of CDEV1/2 clocks are determined by muxing of the corresponding
pins. Pinctrl driver now provides the CDEV1/2 clock muxes and hence
CDEV1/2 clocks could have correct parents. Set CDEV1/2 parents to the
corresponding muxes to fix the parents.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Reviewed-by: Marcel Ziswiler <marcel@ziswiler.com>
Tested-by: Marcel Ziswiler <marcel@ziswiler.com>
Tested-by: Marc Dietrich <marvin24@gmx.de>
Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
Acked-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/tegra/clk-tegra20.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/tegra/clk-tegra20.c b/drivers/clk/tegra/clk-tegra20.c
index ad5a7b5e3a39..636500a98561 100644
--- a/drivers/clk/tegra/clk-tegra20.c
+++ b/drivers/clk/tegra/clk-tegra20.c
@@ -846,14 +846,12 @@ static void __init tegra20_periph_clk_init(void)
 			     NULL);
 
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
