Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751467AbeFCWsp (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 18:48:45 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:34717 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751132AbeFCWsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 18:48:43 -0400
X-Google-Smtp-Source: ADUXVKIDyIoX8NI4IVgBAIM3r8k87EO4kVHfugCGvaKtM2yyfJ259TO74oCPmtJHjGS5NNqgKMG/8A==
From: Dmitry Osipenko <digetx@gmail.com>
To: Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc: linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] clk: tegra: Mark Memory Controller clock as critical
Date: Mon,  4 Jun 2018 01:48:05 +0300
Message-Id: <20180603224805.495-1-digetx@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Memory Controller should be always-on. Currently the sibling EMC clock is
marked as critical, let's mark MC clock too for consistency.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/clk/tegra/clk-divider.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/tegra/clk-divider.c b/drivers/clk/tegra/clk-divider.c
index 16e0aee14773..58874c1bbf5e 100644
--- a/drivers/clk/tegra/clk-divider.c
+++ b/drivers/clk/tegra/clk-divider.c
@@ -194,6 +194,7 @@ static const struct clk_div_table mc_div_table[] = {
 struct clk *tegra_clk_register_mc(const char *name, const char *parent_name,
 				  void __iomem *reg, spinlock_t *lock)
 {
-	return clk_register_divider_table(NULL, name, parent_name, 0, reg,
-					  16, 1, 0, mc_div_table, lock);
+	return clk_register_divider_table(NULL, name, parent_name,
+					  CLK_IS_CRITICAL, reg, 16, 1, 0,
+					  mc_div_table, lock);
 }
-- 
2.17.0
