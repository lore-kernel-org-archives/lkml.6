Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933079AbeCFS7V (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 13:59:21 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:42145 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932865AbeCFS7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 13:59:19 -0500
X-Google-Smtp-Source: AG47ELvgP7EMIYsfbkK8sjq2LuyFsOtN6Pe1Gsf3P8IzShK4+pXdswsUG48DuiPOUL1qF5UESnlaIw==
Date: Tue, 6 Mar 2018 10:59:15 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Benson Leung <bleung@chromium.org>
Cc: Olof Johansson <olof@lixom.net>, Bhumika Goyal <bhumirks@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Revert "platform/chrome: chromeos_laptop: make
 chromeos_laptop const"
Message-ID: <20180306185915.GA93346@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit a376cd91606365609d8fbd57247618bd51da1fc6 because
chromeos_laptop instances should not be marked as "const" (at this
time), since i2c_peripheral is being modified (we change "state" and
"tries") when we instantiate devices.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/platform/chrome/chromeos_laptop.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/platform/chrome/chromeos_laptop.c b/drivers/platform/chrome/chromeos_laptop.c
index 6dec6ab13300..d8599736a41a 100644
--- a/drivers/platform/chrome/chromeos_laptop.c
+++ b/drivers/platform/chrome/chromeos_laptop.c
@@ -423,7 +423,7 @@ static int chromeos_laptop_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static const struct chromeos_laptop samsung_series_5_550 = {
+static struct chromeos_laptop samsung_series_5_550 = {
 	.i2c_peripherals = {
 		/* Touchpad. */
 		{ .add = setup_cyapa_tp, I2C_ADAPTER_SMBUS },
@@ -432,14 +432,14 @@ static const struct chromeos_laptop samsung_series_5_550 = {
 	},
 };
 
-static const struct chromeos_laptop samsung_series_5 = {
+static struct chromeos_laptop samsung_series_5 = {
 	.i2c_peripherals = {
 		/* Light Sensor. */
 		{ .add = setup_tsl2583_als, I2C_ADAPTER_SMBUS },
 	},
 };
 
-static const struct chromeos_laptop chromebook_pixel = {
+static struct chromeos_laptop chromebook_pixel = {
 	.i2c_peripherals = {
 		/* Touch Screen. */
 		{ .add = setup_atmel_1664s_ts, I2C_ADAPTER_PANEL },
@@ -450,14 +450,14 @@ static const struct chromeos_laptop chromebook_pixel = {
 	},
 };
 
-static const struct chromeos_laptop hp_chromebook_14 = {
+static struct chromeos_laptop hp_chromebook_14 = {
 	.i2c_peripherals = {
 		/* Touchpad. */
 		{ .add = setup_cyapa_tp, I2C_ADAPTER_DESIGNWARE_0 },
 	},
 };
 
-static const struct chromeos_laptop dell_chromebook_11 = {
+static struct chromeos_laptop dell_chromebook_11 = {
 	.i2c_peripherals = {
 		/* Touchpad. */
 		{ .add = setup_cyapa_tp, I2C_ADAPTER_DESIGNWARE_0 },
@@ -466,28 +466,28 @@ static const struct chromeos_laptop dell_chromebook_11 = {
 	},
 };
 
-static const struct chromeos_laptop toshiba_cb35 = {
+static struct chromeos_laptop toshiba_cb35 = {
 	.i2c_peripherals = {
 		/* Touchpad. */
 		{ .add = setup_cyapa_tp, I2C_ADAPTER_DESIGNWARE_0 },
 	},
 };
 
-static const struct chromeos_laptop acer_c7_chromebook = {
+static struct chromeos_laptop acer_c7_chromebook = {
 	.i2c_peripherals = {
 		/* Touchpad. */
 		{ .add = setup_cyapa_tp, I2C_ADAPTER_SMBUS },
 	},
 };
 
-static const struct chromeos_laptop acer_ac700 = {
+static struct chromeos_laptop acer_ac700 = {
 	.i2c_peripherals = {
 		/* Light Sensor. */
 		{ .add = setup_tsl2563_als, I2C_ADAPTER_SMBUS },
 	},
 };
 
-static const struct chromeos_laptop acer_c720 = {
+static struct chromeos_laptop acer_c720 = {
 	.i2c_peripherals = {
 		/* Touchscreen. */
 		{ .add = setup_atmel_1664s_ts, I2C_ADAPTER_DESIGNWARE_1 },
@@ -500,14 +500,14 @@ static const struct chromeos_laptop acer_c720 = {
 	},
 };
 
-static const struct chromeos_laptop hp_pavilion_14_chromebook = {
+static struct chromeos_laptop hp_pavilion_14_chromebook = {
 	.i2c_peripherals = {
 		/* Touchpad. */
 		{ .add = setup_cyapa_tp, I2C_ADAPTER_SMBUS },
 	},
 };
 
-static const struct chromeos_laptop cr48 = {
+static struct chromeos_laptop cr48 = {
 	.i2c_peripherals = {
 		/* Light Sensor. */
 		{ .add = setup_tsl2563_als, I2C_ADAPTER_SMBUS },
-- 
2.16.2.395.g2e18187dfd-goog


-- 
Dmitry
