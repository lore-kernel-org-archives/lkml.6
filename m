Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932847AbeBLNSB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 08:18:01 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:37370 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935287AbeBLNR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 08:17:57 -0500
X-Google-Smtp-Source: AH8x2244NvVt7s9K6mziJNi2BrSojMMn7CvCPx65VTgZUV8WH7AMiCOPSjpnzQkEGqwVcUnM+M2Dkw==
From: Linus Walleij <linus.walleij@linaro.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 12/21] regulator: pfuze100: Delete reference to ena_gpio
Date: Mon, 12 Feb 2018 14:17:08 +0100
Message-Id: <20180212131717.27193-13-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180212131717.27193-1-linus.walleij@linaro.org>
References: <20180212131717.27193-1-linus.walleij@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We now pass a GPIO descriptor to the core instead of a global
GPIO number, if this descriptor is NULL the GPIO line is not
used. Just delete the assignment of an invalid GPIO line.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/regulator/pfuze100-regulator.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/regulator/pfuze100-regulator.c b/drivers/regulator/pfuze100-regulator.c
index 63922a2167e5..f341d9614a77 100644
--- a/drivers/regulator/pfuze100-regulator.c
+++ b/drivers/regulator/pfuze100-regulator.c
@@ -648,7 +648,6 @@ static int pfuze100_regulator_probe(struct i2c_client *client,
 		config.init_data = init_data;
 		config.driver_data = pfuze_chip;
 		config.of_node = match_of_node(i);
-		config.ena_gpio = -EINVAL;
 
 		pfuze_chip->regulators[i] =
 			devm_regulator_register(&client->dev, desc, &config);
-- 
2.14.3
