Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753183AbeDSNz3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 09:55:29 -0400
Received: from mail-sh2.amlogic.com ([58.32.228.45]:51765 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753081AbeDSNz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 09:55:27 -0400
From: Yixun Lan <yixun.lan@amlogic.com>
To: Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>
CC: Yixun Lan <yixun.lan@amlogic.com>, Rob Herring <robh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        <linux-amlogic@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 7/7] clk: meson: drop CLK_IGNORE_UNUSED flag
Date: Thu, 19 Apr 2018 21:54:26 +0800
Message-ID: <20180419135426.155794-8-yixun.lan@amlogic.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180419135426.155794-1-yixun.lan@amlogic.com>
References: <20180419135426.155794-1-yixun.lan@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.18.20.235]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rely on drivers to request the clock explicitly.

Previous the kernel will leave the clock on while
bootloader adready initilized the clock, this wasn't
optimal way, so fix it here.

Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
---
 drivers/clk/meson/axg-aoclk.c  | 1 -
 drivers/clk/meson/gxbb-aoclk.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/clk/meson/axg-aoclk.c b/drivers/clk/meson/axg-aoclk.c
index a5d00ef12268..d68b3e8ef483 100644
--- a/drivers/clk/meson/axg-aoclk.c
+++ b/drivers/clk/meson/axg-aoclk.c
@@ -27,7 +27,6 @@ static struct clk_regmap axg_aoclk_##_name = {					\
 		.ops = &clk_regmap_gate_ops,				\
 		.parent_names = (const char *[]){ "clk81" },		\
 		.num_parents = 1,					\
-		.flags = CLK_IGNORE_UNUSED,				\
 	},								\
 }
 
diff --git a/drivers/clk/meson/gxbb-aoclk.c b/drivers/clk/meson/gxbb-aoclk.c
index e145ebcdef38..c4d6027653a3 100644
--- a/drivers/clk/meson/gxbb-aoclk.c
+++ b/drivers/clk/meson/gxbb-aoclk.c
@@ -69,7 +69,6 @@ static struct clk_regmap _name##_ao = {					\
 		.ops = &clk_regmap_gate_ops,				\
 		.parent_names = (const char *[]){ "clk81" },		\
 		.num_parents = 1,					\
-		.flags = CLK_IGNORE_UNUSED,				\
 	},								\
 }
 
-- 
2.15.1
