Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933054AbeEWMzI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 08:55:08 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55058 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932089AbeEWMxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 08:53:20 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7C5BD602BC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilialin@codeaurora.org
From: Ilia Lin <ilialin@codeaurora.org>
To: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
        mark.rutland@arm.com, andy.gross@linaro.org, david.brown@linaro.org,
        will.deacon@arm.com
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        vireshk@kernel.org, ilialin@codeaurora.org
Subject: [PATCH v11 3/8] clk: Use devm_ in the register fixed factor clock
Date: Wed, 23 May 2018 15:52:56 +0300
Message-Id: <1527079981-11179-4-git-send-email-ilialin@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1527079981-11179-1-git-send-email-ilialin@codeaurora.org>
References: <1527079981-11179-1-git-send-email-ilialin@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_clk_hw_register instead of clk_hw_register
to simplify the usage of this API. This way drivers that call
the clk_hw_register_fixed_factor won't need to maintain
a data structure for further cleanup.

Signed-off-by: Ilia Lin <ilialin@codeaurora.org>
---
 drivers/clk/clk-fixed-factor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-fixed-factor.c b/drivers/clk/clk-fixed-factor.c
index a5d402d..8e39bda 100644
--- a/drivers/clk/clk-fixed-factor.c
+++ b/drivers/clk/clk-fixed-factor.c
@@ -94,7 +94,7 @@ struct clk_hw *clk_hw_register_fixed_factor(struct device *dev,
 	init.num_parents = 1;
 
 	hw = &fix->hw;
-	ret = clk_hw_register(dev, hw);
+	ret = devm_clk_hw_register(dev, hw);
 	if (ret) {
 		kfree(fix);
 		hw = ERR_PTR(ret);
-- 
1.9.1
