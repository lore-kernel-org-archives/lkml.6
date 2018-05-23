Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932651AbeEWLmy (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 07:42:54 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35138 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932529AbeEWLmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 07:42:53 -0400
X-Google-Smtp-Source: AB8JxZo8frTiTGgyLyMWdP95ZAUgYL+kZGLhzsAaf0JepbsVqvAXMl581ajd1EIkQfhcf+B42wNDQw==
From: Marek Vasut <marek.vasut@gmail.com>
X-Google-Original-From: Marek Vasut <marek.vasut+renesas@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH 1/6] mfd: da9063: Rename PMIC_DA9063 to PMIC_CHIP_ID_DA9063
Date: Wed, 23 May 2018 13:42:25 +0200
Message-Id: <20180523114230.10109-1-marek.vasut+renesas@gmail.com>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PMIC_DA9063 is a complete misnomer, it denotes the value of the
DA9063 chip ID register, so rename it as such. It is also the value
of chip ID register of DA9063L though, so drop the enum as all the
DA9063 "models" share the same chip ID and thus the distinction will
have to be made using DT or otherwise.

Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Steve Twiss <stwiss.opensource@diasemi.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org
---
 drivers/mfd/da9063-core.c            | 2 +-
 drivers/mfd/da9063-i2c.c             | 2 +-
 drivers/regulator/da9063-regulator.c | 2 +-
 include/linux/mfd/da9063/core.h      | 4 +---
 4 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/mfd/da9063-core.c b/drivers/mfd/da9063-core.c
index 6c2870d4e754..00b3caee4e21 100644
--- a/drivers/mfd/da9063-core.c
+++ b/drivers/mfd/da9063-core.c
@@ -192,7 +192,7 @@ int da9063_device_init(struct da9063 *da9063, unsigned int irq)
 		dev_err(da9063->dev, "Cannot read chip model id.\n");
 		return -EIO;
 	}
-	if (model != PMIC_DA9063) {
+	if (model != PMIC_CHIP_ID_DA9063) {
 		dev_err(da9063->dev, "Invalid chip model id: 0x%02x\n", model);
 		return -ENODEV;
 	}
diff --git a/drivers/mfd/da9063-i2c.c b/drivers/mfd/da9063-i2c.c
index 981805a2c521..7f84030c8d53 100644
--- a/drivers/mfd/da9063-i2c.c
+++ b/drivers/mfd/da9063-i2c.c
@@ -280,7 +280,7 @@ static int da9063_i2c_remove(struct i2c_client *i2c)
 }
 
 static const struct i2c_device_id da9063_i2c_id[] = {
-	{"da9063", PMIC_DA9063},
+	{ "da9063", PMIC_CHIP_ID_DA9063 },
 	{},
 };
 MODULE_DEVICE_TABLE(i2c, da9063_i2c_id);
diff --git a/drivers/regulator/da9063-regulator.c b/drivers/regulator/da9063-regulator.c
index 6a8f9cd69f52..87c884ae0064 100644
--- a/drivers/regulator/da9063-regulator.c
+++ b/drivers/regulator/da9063-regulator.c
@@ -585,7 +585,7 @@ static struct da9063_dev_model regulators_models[] = {
 	{
 		.regulator_info = da9063_regulator_info,
 		.n_regulators = ARRAY_SIZE(da9063_regulator_info),
-		.dev_model = PMIC_DA9063,
+		.dev_model = PMIC_CHIP_ID_DA9063,
 	},
 	{ }
 };
diff --git a/include/linux/mfd/da9063/core.h b/include/linux/mfd/da9063/core.h
index f3ae65db4c86..664f650d0086 100644
--- a/include/linux/mfd/da9063/core.h
+++ b/include/linux/mfd/da9063/core.h
@@ -29,9 +29,7 @@
 #define DA9063_DRVNAME_RTC		"da9063-rtc"
 #define DA9063_DRVNAME_VIBRATION	"da9063-vibration"
 
-enum da9063_models {
-	PMIC_DA9063 = 0x61,
-};
+#define PMIC_CHIP_ID_DA9063		0x61
 
 enum da9063_variant_codes {
 	PMIC_DA9063_AD = 0x3,
-- 
2.16.2
