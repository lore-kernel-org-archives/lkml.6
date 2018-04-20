Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754562AbeDTJ4U (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 05:56:20 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:37416 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754523AbeDTJ4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 05:56:12 -0400
X-Google-Smtp-Source: AIpwx48ALRLSjHbffiHWaY9vqpK9IZlZXkpF8he5jZ4sPvfjPg8lPFy/dwpeuHvZS+20VkzRFpVx5A==
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] clk: meson: axg: let mpll clocks round closest
Date: Fri, 20 Apr 2018 11:56:03 +0200
Message-Id: <20180420095603.29964-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180420095603.29964-1-jbrunet@baylibre.com>
References: <20180420095603.29964-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let the mpll dividers achieve the closest rate possible, even if
it means rounding the requested rate up.

This is done to improve the accuracy of the rates provided by these
plls to the audio subsystem

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/axg.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clk/meson/axg.c b/drivers/clk/meson/axg.c
index 5f5d468c1efe..bd4dbc696b88 100644
--- a/drivers/clk/meson/axg.c
+++ b/drivers/clk/meson/axg.c
@@ -461,6 +461,7 @@ static struct clk_regmap axg_mpll0_div = {
 			.width	 = 1,
 		},
 		.lock = &meson_clk_lock,
+		.flags = CLK_MESON_MPLL_ROUND_CLOSEST,
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "mpll0_div",
@@ -507,6 +508,7 @@ static struct clk_regmap axg_mpll1_div = {
 			.width	 = 1,
 		},
 		.lock = &meson_clk_lock,
+		.flags = CLK_MESON_MPLL_ROUND_CLOSEST,
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "mpll1_div",
@@ -553,6 +555,7 @@ static struct clk_regmap axg_mpll2_div = {
 			.width	 = 1,
 		},
 		.lock = &meson_clk_lock,
+		.flags = CLK_MESON_MPLL_ROUND_CLOSEST,
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "mpll2_div",
@@ -599,6 +602,7 @@ static struct clk_regmap axg_mpll3_div = {
 			.width	 = 1,
 		},
 		.lock = &meson_clk_lock,
+		.flags = CLK_MESON_MPLL_ROUND_CLOSEST,
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "mpll3_div",
-- 
2.14.3
