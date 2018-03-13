Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932546AbeCMUh3 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 16:37:29 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:38345 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752196AbeCMUh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 16:37:28 -0400
X-Google-Smtp-Source: AG47ELsEM95HVHwNq+p2c1anWvUY0qT65ambW/+Gh/wd5GNyufDGuPIepq0Gsd6PAZeopbqaaAj68w==
From: Derek Basehore <dbasehore@chromium.org>
To: linux-kernel@vger.kernel.org
Cc: linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        heiko@sntech.de, sboyd@kernel.org, mturquette@baylibre.com,
        Derek Basehore <dbasehore@chromium.org>
Subject: [PATCH] clk: rockchip: Add 1.6GHz PLL rate
Date: Tue, 13 Mar 2018 13:37:19 -0700
Message-Id: <20180313203719.75639-1-dbasehore@chromium.org>
X-Mailer: git-send-email 2.16.2.660.g709887971b-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need this rate to generate 100, 200, and 228.57MHz from the same
PLL. 228.57MHz is useful for a pixel clock when the VPLL is used for
and external display.

Signed-off-by: Derek Basehore <dbasehore@chromium.org>
---
 drivers/clk/rockchip/clk-rk3399.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/rockchip/clk-rk3399.c b/drivers/clk/rockchip/clk-rk3399.c
index 6847120b61cd..3e57c6eef93d 100644
--- a/drivers/clk/rockchip/clk-rk3399.c
+++ b/drivers/clk/rockchip/clk-rk3399.c
@@ -57,6 +57,7 @@ static struct rockchip_pll_rate_table rk3399_pll_rates[] = {
 	RK3036_PLL_RATE(1656000000, 1, 69, 1, 1, 1, 0),
 	RK3036_PLL_RATE(1632000000, 1, 68, 1, 1, 1, 0),
 	RK3036_PLL_RATE(1608000000, 1, 67, 1, 1, 1, 0),
+	RK3036_PLL_RATE(1600000000, 3, 200, 1, 1, 1, 0),
 	RK3036_PLL_RATE(1584000000, 1, 66, 1, 1, 1, 0),
 	RK3036_PLL_RATE(1560000000, 1, 65, 1, 1, 1, 0),
 	RK3036_PLL_RATE(1536000000, 1, 64, 1, 1, 1, 0),
-- 
2.16.2.660.g709887971b-goog
