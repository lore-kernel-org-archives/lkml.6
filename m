Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752926AbeC1Cw1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 22:52:27 -0400
Received: from mail-sh2.amlogic.com ([58.32.228.45]:51111 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751099AbeC1Cw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 22:52:26 -0400
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
Subject: [PATCH v3 5/6] clk: meson: drop CLK_SET_RATE_PARENT flag
Date: Wed, 28 Mar 2018 10:50:49 +0800
Message-ID: <20180328025050.221585-6-yixun.lan@amlogic.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180328025050.221585-1-yixun.lan@amlogic.com>
References: <20180328025050.221585-1-yixun.lan@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.18.20.235]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clk81 is not expected to be changed, so drop this flag.

Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
---
 drivers/clk/meson/gxbb-aoclk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/meson/gxbb-aoclk.c b/drivers/clk/meson/gxbb-aoclk.c
index 5a922639a264..89b048aad239 100644
--- a/drivers/clk/meson/gxbb-aoclk.c
+++ b/drivers/clk/meson/gxbb-aoclk.c
@@ -70,7 +70,7 @@ static struct clk_regmap _name##_ao = {					\
 		.ops = &clk_regmap_gate_ops,				\
 		.parent_names = (const char *[]){ "clk81" },		\
 		.num_parents = 1,					\
-		.flags = (CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED),	\
+		.flags = CLK_IGNORE_UNUSED,				\
 	},								\
 }
 
-- 
2.15.1
