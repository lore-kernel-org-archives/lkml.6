Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HKx2ji2c"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 429FD601D9
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932705AbeFFKCR (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 06:02:17 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:46274 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932569AbeFFKA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 06:00:29 -0400
X-Google-Smtp-Source: ADUXVKI1cdpsU4PUCWRvKbC1iLq9BhjPsh3YSj185dm4w2SOZuRz+PLmHIy6IsU+QDbl1ls0+31fpQ==
From: Marek Vasut <marek.vasut@gmail.com>
X-Google-Original-From: Marek Vasut <marek.vasut+renesas@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v5 07/14] mfd: da9063: Rename PMIC_DA9063 to PMIC_CHIP_ID_DA9063
Date: Wed,  6 Jun 2018 11:59:56 +0200
Message-Id: <20180606100003.17067-7-marek.vasut+renesas@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180606100003.17067-1-marek.vasut+renesas@gmail.com>
References: <20180606100003.17067-1-marek.vasut+renesas@gmail.com>
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
Acked-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
Acked-by: Steve Twiss <stwiss.opensource@diasemi.com>
---
V2: No change
V3: No change
V4: No change
V5: No change
---
 drivers/mfd/da9063-core.c            | 2 +-
 drivers/mfd/da9063-i2c.c             | 2 +-
 drivers/regulator/da9063-regulator.c | 2 +-
 include/linux/mfd/da9063/core.h      | 4 +---
 4 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/mfd/da9063-core.c b/drivers/mfd/da9063-core.c
index f57558590283..c54777cc2f12 100644
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
index e9797153bc19..d1fe88777e3f 100644
--- a/drivers/mfd/da9063-i2c.c
+++ b/drivers/mfd/da9063-i2c.c
@@ -181,7 +181,7 @@ static int da9063_i2c_probe(struct i2c_client *i2c,
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
index 260cd5834861..e015b065db7e 100644
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
