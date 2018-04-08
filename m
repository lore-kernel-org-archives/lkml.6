Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752988AbeDHDVE (ORCPT <rfc822;w@1wt.eu>);
        Sat, 7 Apr 2018 23:21:04 -0400
Received: from mail-sh2.amlogic.com ([58.32.228.45]:14835 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752034AbeDHDU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Apr 2018 23:20:27 -0400
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
Subject: [PATCH v4 2/7] clk: meson: migrate to devm_of_clk_add_hw_provider API
Date: Sun, 8 Apr 2018 11:19:33 +0800
Message-ID: <20180408031938.153474-3-yixun.lan@amlogic.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180408031938.153474-1-yixun.lan@amlogic.com>
References: <20180408031938.153474-1-yixun.lan@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.18.20.235]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a protential memory leak, as of_clk_del_provider is
never called if of_clk_add_hw_provider has been executed.
Fix this by using devm variant API.

Suggested-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
---
 drivers/clk/meson/meson-aoclk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/meson/meson-aoclk.c b/drivers/clk/meson/meson-aoclk.c
index 14862c22e20d..14a1e46a4de6 100644
--- a/drivers/clk/meson/meson-aoclk.c
+++ b/drivers/clk/meson/meson-aoclk.c
@@ -78,6 +78,6 @@ int meson_aoclkc_probe(struct platform_device *pdev)
 			return ret;
 	}
 
-	return of_clk_add_hw_provider(dev->of_node, of_clk_hw_onecell_get,
+	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
 		(void *) data->hw_data);
 }
-- 
2.15.1
