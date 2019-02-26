Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A625C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 00:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E83AE2184D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 00:17:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3j+aHbYP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729222AbfBZAR3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 19:17:29 -0500
Received: from merlin.infradead.org ([205.233.59.134]:45758 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727551AbfBZAR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 19:17:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=UEjHNplR6m/WyEWJ+AsxV4MO9QINOd+jPQVHnC8owBc=; b=3j+aHbYPiRZ4X6NwyyTtt3+vO/
        uw3946FRzOx4YjtP17YmHjI6ukBesKrrgGD0CLJ7afwabv8iG1UHWBBSdimdX0986mzVbHgXdBIXw
        CkP9prE8Qb+az9mxncdgfhdKmj2aDVLb9eGgF3pTPl/aPk7uzm+ACbTUoWC28V3rDH5IdXQS4bIVX
        BVRF9b3Bz7VkLhoUhJohlfuDiwxYzl+A8kK9SUL6zhnRJGpWeR/TvypPIIsz5iu29517o1vF6RBbb
        QVQxKtk5a4yHg5kArT6XPGzHOm7svn2vqIdxwk43Vn0XZ/f2BvbLlWImnCrHWpSLlNSee6DppXwt9
        y753npaQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gyQQx-0001tv-Rd; Tue, 26 Feb 2019 00:17:20 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Vijai Kumar K <vijaikumar.kanagarajan@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH -next & mmotm] extcon: fix EXTCON_PTP5150 kconfig warnings and
 build errors
Message-ID: <ff1784cd-6429-8597-fcba-55b383727515@infradead.org>
Date:   Mon, 25 Feb 2019 16:17:18 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Having COMPILE_TEST here is causing problems.  I reported one
last week and have another one today.  Although I support
using COMPILE_TEST when possible, this one is better removed.

Fixes these warnings and build errors:

WARNING: unmet direct dependencies detected for REGMAP_I2C
  Depends on [m]: I2C [=m]
  Selected by [y]:
  - EXTCON_PTN5150 [=y] && EXTCON [=y] && (I2C [=m] && GPIOLIB [=y] || COMPILE_TEST [=y])
  Selected by [m]:
  - EEPROM_AT24 [=m] && I2C [=m] && SYSFS [=y]
  - KEYBOARD_CAP11XX [=m] && !UML && INPUT [=y] && INPUT_KEYBOARD [=y] && OF [=y] && I2C [=m]
  - I2C_MUX_LTC4306 [=m] && I2C [=m] && I2C_MUX [=m]
  - GPIO_TS4900 [=m] && GPIOLIB [=y] && I2C [=m] && (SOC_IMX6 || COMPILE_TEST [=y])
  - SENSORS_LTC2945 [=m] && HWMON [=y] && I2C [=m]
  - SENSORS_LTC4222 [=m] && HWMON [=y] && I2C [=m]
  - SENSORS_MAX6621 [=m] && HWMON [=y] && I2C [=m]
  - SENSORS_LM75 [=m] && HWMON [=y] && I2C [=m]
  - SENSORS_NCT7802 [=m] && HWMON [=y] && I2C [=m]
  - SENSORS_EMC1403 [=m] && HWMON [=y] && I2C [=m]
  - SENSORS_ADS7828 [=m] && HWMON [=y] && I2C [=m]
  - SENSORS_INA2XX [=m] && HWMON [=y] && I2C [=m]
  - SENSORS_INA3221 [=m] && HWMON [=y] && I2C [=m]
  - SENSORS_TMP102 [=m] && HWMON [=y] && I2C [=m]
  - SENSORS_TMP103 [=m] && HWMON [=y] && I2C [=m]
  - MFD_BCM590XX [=m] && HAS_IOMEM [=y] && I2C [=m]
  - MFD_AXP20X_I2C [=m] && HAS_IOMEM [=y] && I2C [=m]
  - MFD_MADERA_I2C [=m] && HAS_IOMEM [=y] && MFD_MADERA [=m] && I2C [=m]
  - MFD_DA9062 [=m] && HAS_IOMEM [=y] && I2C [=m]
  - MFD_DA9063 [=m] && HAS_IOMEM [=y] && I2C [=m]
  - MFD_DA9150 [=m] && HAS_IOMEM [=y] && I2C [=m]
  - MFD_MC13XXX_I2C [=m] && HAS_IOMEM [=y] && I2C [=m]
  - MFD_88PM800 [=m] && HAS_IOMEM [=y] && I2C [=m]
  - MFD_88PM805 [=m] && HAS_IOMEM [=y] && I2C [=m]
  - MFD_MAX14577 [=m] && HAS_IOMEM [=y] && I2C [=m]
  - MFD_MAX77686 [=m] && HAS_IOMEM [=y] && I2C [=m] && (OF [=y] || COMPILE_TEST [=y])
  - MFD_MAX8907 [=m] && HAS_IOMEM [=y] && I2C [=m]
  - MFD_RT5033 [=m] && HAS_IOMEM [=y] && I2C [=m]
  - MFD_RN5T618 [=m] && HAS_IOMEM [=y] && I2C [=m] && OF [=y]
  - MFD_SI476X_CORE [=m] && HAS_IOMEM [=y] && I2C [=m]
  - MFD_SKY81452 [=m] && HAS_IOMEM [=y] && I2C [=m]
  - MFD_TI_LMU [=m] && HAS_IOMEM [=y] && I2C [=m]
  - TPS6105X [=m] && HAS_IOMEM [=y] && I2C [=m]
  - MFD_TPS65086 [=m] && HAS_IOMEM [=y] && I2C [=m]
  - MFD_TPS65217 [=m] && HAS_IOMEM [=y] && I2C [=m] && OF [=y]
  - MFD_TI_LP873X [=m] && HAS_IOMEM [=y] && I2C [=m]
  - MFD_TPS65218 [=m] && HAS_IOMEM [=y] && I2C [=m] && OF [=y]
  - MFD_TPS65912_I2C [=m] && HAS_IOMEM [=y] && I2C [=m]
  - MFD_LM3533 [=m] && HAS_IOMEM [=y] && I2C [=m]
  - MFD_WM8994 [=m] && HAS_IOMEM [=y] && I2C [=m]
  - REGULATOR_88PG86X [=m] && REGULATOR [=y] && I2C [=m]
  - REGULATOR_DA9211 [=m] && REGULATOR [=y] && I2C [=m]
  - REGULATOR_FAN53555 [=m] && REGULATOR [=y] && I2C [=m]
  - REGULATOR_LTC3676 [=m] && REGULATOR [=y] && I2C [=m]
  - REGULATOR_MAX8649 [=m] && REGULATOR [=y] && I2C [=m]
  - REGULATOR_MT6311 [=m] && REGULATOR [=y] && I2C [=m]
  - REGULATOR_PFUZE100 [=m] && REGULATOR [=y] && I2C [=m]
  - REGULATOR_PV88060 [=m] && REGULATOR [=y] && I2C [=m]
  - REGULATOR_PV88080 [=m] && REGULATOR [=y] && I2C [=m]
  - REGULATOR_SY8106A [=m] && REGULATOR [=y] && I2C [=m] && (OF [=y] || COMPILE_TEST [=y])
  - REGULATOR_TPS62360 [=m] && REGULATOR [=y] && I2C [=m]
  - REGULATOR_TPS65023 [=m] && REGULATOR [=y] && I2C [=m]
  - DRM_ANALOGIX_ANX78XX [=m] && HAS_IOMEM [=y] && DRM [=m] && DRM_BRIDGE [=y]
  - DRM_TOSHIBA_TC358767 [=m] && HAS_IOMEM [=y] && DRM [=m] && DRM_BRIDGE [=y] && OF [=y]
  - DRM_TI_SN65DSI86 [=m] && HAS_IOMEM [=y] && DRM [=m] && DRM_BRIDGE [=y] && OF [=y]
  - DRM_I2C_ADV7511 [=m] && HAS_IOMEM [=y] && DRM [=m] && DRM_BRIDGE [=y] && OF [=y]
  - BACKLIGHT_LM3630A [=m] && HAS_IOMEM [=y] && BACKLIGHT_LCD_SUPPORT [=y] && BACKLIGHT_CLASS_DEVICE [=m] && I2C [=m] && PWM [=y]
  - BACKLIGHT_LM3639 [=m] && HAS_IOMEM [=y] && BACKLIGHT_LCD_SUPPORT [=y] && BACKLIGHT_CLASS_DEVICE [=m] && I2C [=m]
  - LEDS_LM3642 [=m] && NEW_LEDS [=y] && LEDS_CLASS [=y] && I2C [=m]
  - LEDS_LP8860 [=m] && NEW_LEDS [=y] && LEDS_CLASS [=y] && I2C [=m] && OF [=y]
  - LEDS_TLC591XX [=m] && NEW_LEDS [=y] && LEDS_CLASS [=y] && I2C [=m]
  - LEDS_LM355x [=m] && NEW_LEDS [=y] && LEDS_CLASS [=y] && I2C [=m]
  - LEDS_IS31FL319X [=m] && NEW_LEDS [=y] && LEDS_CLASS [=y] && I2C [=m] && OF [=y]
  - EXTCON_RT8973A [=m] && EXTCON [=y] && I2C [=m]
  - ADXL345_I2C [=m] && IIO [=y] && INPUT_ADXL34X [=n]=n && I2C [=m]
  - BMC150_ACCEL_I2C [=m] && IIO [=y]
  - MMA7455_I2C [=m] && IIO [=y] && I2C [=m]
  - MXC4005 [=m] && IIO [=y] && I2C [=m]
  - MXC6255 [=m] && IIO [=y] && I2C [=m]
  - TI_ADS1015 [=m] && IIO [=y] && I2C [=m] && !SENSORS_ADS1015 [=n]
  - BME680_I2C [=m] && IIO [=y] && I2C [=m] && BME680 [=m]
  - AD5380 [=m] && IIO [=y] && (SPI_MASTER [=n] && I2C [=m]!=m || I2C [=m]) && I2C [=m]
  - BMG160_I2C [=m] && IIO [=y]
  - MPU3050_I2C [=m] && IIO [=y] && INPUT_MPU3050!=y && INPUT_MPU3050!=m && I2C [=m]
  - AFE4404 [=m] && IIO [=y] && I2C [=m]
  - MAX30100 [=m] && IIO [=y] && I2C [=m]
  - HTS221_I2C [=m] && IIO [=y] && HTS221 [=m]
  - INV_MPU6050_I2C [=m] && IIO [=y] && I2C_MUX [=m]
  - IIO_ST_LSM6DSX_I2C [=m] && IIO [=y] && IIO_ST_LSM6DSX [=m]
  - GP2AP020A00F [=m] && IIO [=y] && I2C [=m]
  - SENSORS_ISL29028 [=m] && IIO [=y] && I2C [=m]
  - JSA1212 [=m] && IIO [=y] && I2C [=m]
  - RPR0521 [=m] && IIO [=y] && I2C [=m]
  - LTR501 [=m] && IIO [=y] && I2C [=m]
  - MAX44000 [=m] && IIO [=y] && I2C [=m]
  - PA12203001 [=m] && IIO [=y] && I2C [=m]
  - ST_UVIS25_I2C [=m] && IIO [=y] && ST_UVIS25 [=m]
  - AK8974 [=m] && IIO [=y] && I2C [=m] && OF [=y]
  - SENSORS_HMC5843_I2C [=m] && IIO [=y] && I2C [=m]
  - SENSORS_RM3100_I2C [=m] && IIO [=y] && I2C [=m]
  - LMP91000 [=m] && IIO [=y] && I2C [=m]
  - BMP280_I2C [=m] && IIO [=y] && BMP280 [=m] && I2C [=m]
  - HP03 [=m] && IIO [=y] && I2C [=m]
  - ZPA2326_I2C [=m] && IIO [=y]
  - MLX90632 [=m] && IIO [=y] && I2C [=m]

ld: drivers/base/regmap/regmap-i2c.o: in function `regmap_smbus_byte_reg_read':
regmap-i2c.c:(.text+0x122): undefined reference to `i2c_smbus_read_byte_data'
ld: drivers/base/regmap/regmap-i2c.o: in function `regmap_smbus_byte_reg_write':
regmap-i2c.c:(.text+0x157): undefined reference to `i2c_smbus_write_byte_data'
ld: drivers/base/regmap/regmap-i2c.o: in function `regmap_smbus_word_reg_read':
regmap-i2c.c:(.text+0x182): undefined reference to `i2c_smbus_read_word_data'
ld: drivers/base/regmap/regmap-i2c.o: in function `regmap_smbus_word_read_swapped':
regmap-i2c.c:(.text+0x1b2): undefined reference to `i2c_smbus_read_word_data'
ld: drivers/base/regmap/regmap-i2c.o: in function `regmap_smbus_word_write_swapped':
regmap-i2c.c:(.text+0x1ee): undefined reference to `i2c_smbus_write_word_data'
ld: drivers/base/regmap/regmap-i2c.o: in function `regmap_smbus_word_reg_write':
regmap-i2c.c:(.text+0x217): undefined reference to `i2c_smbus_write_word_data'
ld: drivers/base/regmap/regmap-i2c.o: in function `regmap_i2c_smbus_i2c_read':
regmap-i2c.c:(.text+0x254): undefined reference to `i2c_smbus_read_i2c_block_data'
ld: drivers/base/regmap/regmap-i2c.o: in function `regmap_i2c_smbus_i2c_write':
regmap-i2c.c:(.text+0x2b0): undefined reference to `i2c_smbus_write_i2c_block_data'
ld: drivers/base/regmap/regmap-i2c.o: in function `regmap_i2c_read':
regmap-i2c.c:(.text+0x312): undefined reference to `i2c_transfer'
ld: drivers/base/regmap/regmap-i2c.o: in function `regmap_i2c_gather_write':
regmap-i2c.c:(.text+0x39c): undefined reference to `i2c_transfer'
ld: drivers/base/regmap/regmap-i2c.o: in function `regmap_i2c_write':
regmap-i2c.c:(.text+0x3f4): undefined reference to `i2c_transfer_buffer_flags'
ld: drivers/extcon/extcon-ptn5150.o: in function `ptn5150_i2c_init':
extcon-ptn5150.c:(.init.text+0xb): undefined reference to `i2c_register_driver'


Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>
Cc: Vijai Kumar K <vijaikumar.kanagarajan@gmail.com>
---
 drivers/extcon/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- mmotm-2019-0225-1340.orig/drivers/extcon/Kconfig
+++ mmotm-2019-0225-1340/drivers/extcon/Kconfig
@@ -116,7 +116,7 @@ config EXTCON_PALMAS
 
 config EXTCON_PTN5150
 	tristate "NXP PTN5150 CC LOGIC USB EXTCON support"
-	depends on I2C && GPIOLIB || COMPILE_TEST
+	depends on I2C && GPIOLIB
 	select REGMAP_I2C
 	help
 	  Say Y here to enable support for USB peripheral and USB host

