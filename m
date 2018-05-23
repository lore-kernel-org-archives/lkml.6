Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932745AbeEWLnh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 07:43:37 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37086 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932501AbeEWLnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 07:43:08 -0400
X-Google-Smtp-Source: AB8JxZrGvq9q0/NqfO5rOe5vLdfJ6E90KS5JIOpMJpFSKGKRe2Tp4lyTrrwk3MkDXpupeIFjFcy57g==
From: Marek Vasut <marek.vasut@gmail.com>
X-Google-Original-From: Marek Vasut <marek.vasut+renesas@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH 6/6] mfd: da9063: Add DA9063L support
Date: Wed, 23 May 2018 13:42:30 +0200
Message-Id: <20180523114230.10109-6-marek.vasut+renesas@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180523114230.10109-1-marek.vasut+renesas@gmail.com>
References: <20180523114230.10109-1-marek.vasut+renesas@gmail.com>
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
---
 drivers/mfd/da9063-i2c.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mfd/da9063-i2c.c b/drivers/mfd/da9063-i2c.c
index 5544ce8e3363..84bbd2bbcd2a 100644
--- a/drivers/mfd/da9063-i2c.c
+++ b/drivers/mfd/da9063-i2c.c
@@ -232,6 +232,7 @@ static struct regmap_config da9063_regmap_config = {
 
 static const struct of_device_id da9063_dt_ids[] = {
 	{ .compatible = "dlg,da9063", },
+	{ .compatible = "dlg,da9063l", },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, da9063_dt_ids);
@@ -282,6 +283,7 @@ static int da9063_i2c_remove(struct i2c_client *i2c)
 
 static const struct i2c_device_id da9063_i2c_id[] = {
 	{ "da9063", PMIC_TYPE_DA9063 },
+	{ "da9063l", PMIC_TYPE_DA9063L },
 	{},
 };
 MODULE_DEVICE_TABLE(i2c, da9063_i2c_id);
-- 
2.16.2
