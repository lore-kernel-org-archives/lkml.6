Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933286AbeCSNXk (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 09:23:40 -0400
Received: from mail-io0-f227.google.com ([209.85.223.227]:33065 "EHLO
        mail-io0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932635AbeCSNXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 09:23:39 -0400
X-Google-Smtp-Source: AG47ELvutYMAzCRsqcysj/5nJMl6igD9BLFFXaks26ZYb5EzJ1/ms1wW7YbwAkVNU5U6bT5ZyhiApI09DcYa
X-Relaying-Domain: lexmark.com
From: Nicholas Lowell <nlowell@lexmark.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org
Cc: Nicholas Lowell <nlowell@lexmark.com>
Subject: [PATCH] regulator: giving regulator controlling gpios a non-empty label when used through the devicetree.
Date: Mon, 19 Mar 2018 09:23:14 -0400
Message-Id: <1521465799-5589-1-git-send-email-nlowell@lexmark.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the label is empty, it causes missing information and limits diagnostics
for instances such as 'cat /sys/kernel/debug/gpio'

Setting the label to the regulator supply_name will point to the device
using the gpio(s).

Signed-off-by: Nicholas Lowell <nlowell@lexmark.com>
---
 drivers/regulator/gpio-regulator.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/gpio-regulator.c b/drivers/regulator/gpio-regulator.c
index 0fce06a..b1f00e2 100644
--- a/drivers/regulator/gpio-regulator.c
+++ b/drivers/regulator/gpio-regulator.c
@@ -196,6 +196,7 @@ of_get_gpio_regulator_config(struct device *dev, struct device_node *np,
 				break;
 			}
 			config->gpios[i].gpio = gpio;
+			config->gpios[i].label = config->supply_name;
 			if (proplen > 0) {
 				of_property_read_u32_index(np, "gpios-states",
 							   i, &ret);
-- 
2.7.4
