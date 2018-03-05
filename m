Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933402AbeCFAha (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 19:37:30 -0500
Received: from gateway36.websitewelcome.com ([192.185.187.5]:42255 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932963AbeCFAhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 19:37:25 -0500
Date: Mon, 5 Mar 2018 17:49:06 -0600
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Sean Wang <sean.wang@mediatek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] pinctrl: mediatek: mtk-common: use true and false for
 boolean values
Message-ID: <20180305234906.GA32058@embeddedgus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.175.117.58
X-Source-L: No
X-Exim-ID: 1eszqs-003hJs-LJ
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedgus) [189.175.117.58]:46108
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 15
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Assign true or false to boolean variables instead of an integer value.

This issue was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
index 3cf384f..e161561 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
@@ -501,7 +501,7 @@ static int mtk_pctrl_dt_subnode_to_map(struct pinctrl_dev *pctldev,
 	int num_pins, num_funcs, maps_per_pin;
 	unsigned long *configs;
 	unsigned int num_configs;
-	bool has_config = 0;
+	bool has_config = false;
 	int i, err;
 	unsigned reserve = 0;
 	struct mtk_pinctrl_group *grp;
@@ -520,7 +520,7 @@ static int mtk_pctrl_dt_subnode_to_map(struct pinctrl_dev *pctldev,
 		return err;
 
 	if (num_configs)
-		has_config = 1;
+		has_config = true;
 
 	num_pins = pins->length / sizeof(u32);
 	num_funcs = num_pins;
-- 
2.7.4
