Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754427AbeDTJe3 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 05:34:29 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33889 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754191AbeDTJe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 05:34:27 -0400
X-Google-Smtp-Source: AIpwx4/h7SSfSpaM237pqd8pJsQF0idz8lzPmy4b+WIbGGHdoaLSlMRknwC0oopz8H2T3NBDOKt3Mw==
From: Andrea Greco <andrea.greco.gapmilano@gmail.com>
Cc: andrea.greco.gapmilano@gmail.com, Andrea Greco <a.greco@4sigma.it>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] RTC: DS1340 Add support for trickle charger.
Date: Fri, 20 Apr 2018 11:34:02 +0200
Message-Id: <20180420093402.28758-1-andrea.greco.gapmilano@gmail.com>
X-Mailer: git-send-email 2.14.3
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrea Greco <a.greco@4sigma.it>

Add support Dallas DS1340 trickle charger function.

Signed-off-by: Andrea Greco <a.greco@4sigma.it>
---
 drivers/rtc/rtc-ds1307.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index a13e59edff53..e9ec4160d7f6 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -201,6 +201,7 @@ static const struct chip_desc chips[last_ds_type] = {
 		.century_reg	= DS1307_REG_HOUR,
 		.century_enable_bit = DS1340_BIT_CENTURY_EN,
 		.century_bit	= DS1340_BIT_CENTURY,
+		.do_trickle_setup = &do_trickle_setup_ds1339,
 		.trickle_charger_reg = 0x08,
 	},
 	[ds_1341] = {
@@ -1371,6 +1372,7 @@ static void ds1307_clks_register(struct ds1307 *ds1307)
 static const struct regmap_config regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
+	.max_register = 0x9,
 };
 
 static int ds1307_probe(struct i2c_client *client,
-- 
2.14.3
