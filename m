Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b6B9+iUB"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2EEFF606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932669AbeFFKAz (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 06:00:55 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35846 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932601AbeFFKAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 06:00:38 -0400
X-Google-Smtp-Source: ADUXVKL6f3fVZLOnsBXL9EZKQXR/bTXrDfPr0PViA+5bASQzFYsfY2YprBcNN1eQyUFHSQNc7N03ZQ==
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
Subject: [PATCH v5 14/14] mfd: da9063: Add DA9063L support
Date: Wed,  6 Jun 2018 12:00:03 +0200
Message-Id: <20180606100003.17067-14-marek.vasut+renesas@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180606100003.17067-1-marek.vasut+renesas@gmail.com>
References: <20180606100003.17067-1-marek.vasut+renesas@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for DA9063L, which is a reduced variant of the DA9063
with less regulators and without RTC.

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
 drivers/mfd/da9063-i2c.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mfd/da9063-i2c.c b/drivers/mfd/da9063-i2c.c
index a449a9263dd7..50a24b1921d0 100644
--- a/drivers/mfd/da9063-i2c.c
+++ b/drivers/mfd/da9063-i2c.c
@@ -186,6 +186,7 @@ static struct regmap_config da9063_regmap_config = {
 
 static const struct of_device_id da9063_dt_ids[] = {
 	{ .compatible = "dlg,da9063", },
+	{ .compatible = "dlg,da9063l", },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, da9063_dt_ids);
@@ -231,6 +232,7 @@ static int da9063_i2c_probe(struct i2c_client *i2c,
 
 static const struct i2c_device_id da9063_i2c_id[] = {
 	{ "da9063", PMIC_TYPE_DA9063 },
+	{ "da9063l", PMIC_TYPE_DA9063L },
 	{},
 };
 MODULE_DEVICE_TABLE(i2c, da9063_i2c_id);
-- 
2.16.2
