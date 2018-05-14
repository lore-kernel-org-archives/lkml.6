Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752317AbeENIHW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 04:07:22 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:36052 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752212AbeENIHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 04:07:07 -0400
X-Google-Smtp-Source: AB8JxZoqI/IavGfUh0tQjCFE0CsIsJfUZnSsMEzSzdgkInimeinKt4vx8IDYWO8toDZsfSRHLInWMA==
From: Linus Walleij <linus.walleij@linaro.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 09/19 v3] regulator: pfuze100: Delete reference to ena_gpio
Date: Mon, 14 May 2018 10:06:30 +0200
Message-Id: <20180514080640.12515-10-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514080640.12515-1-linus.walleij@linaro.org>
References: <20180514080640.12515-1-linus.walleij@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We now pass a GPIO descriptor to the core instead of a global
GPIO number, if this descriptor is NULL the GPIO line is not
used. Just delete the assignment of an invalid GPIO line.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v2->v3:
- Resending.
ChangeLog v1->v2:
- Rebase the patch on the other changes.
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
2.17.0
