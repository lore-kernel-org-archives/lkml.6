Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754415AbeCUXZZ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 19:25:25 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60640 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754380AbeCUXZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 19:25:19 -0400
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: [PATCH] ARM: multi_v7_defconfig: Enable missing drivers for supported Chromebooks.
Date: Thu, 22 Mar 2018 00:25:10 +0100
Message-Id: <20180321232510.5882-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable following drivers for merged devices:
- Batteries with BQ27XXX chips for Minnie boards.
- Elan eKTH I2C touchscreen for Minnie boards.
- GPIO charger for all Veyron boards..
- Rockchip SARADC driver for all rk3288 boards.
- Rockchip eFUSE driver for all rk3288 boards.
- TPM security chip for all Veyron boards.
- ChromeOS EC userspace interface for all chromebooks boards.
- ChromeOS EC light and proximity sensors for some chromebooks.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
 arch/arm/configs/multi_v7_defconfig | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index da7387689b88..a0254b9659a0 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -299,6 +299,7 @@ CONFIG_MOUSE_CYAPA=m
 CONFIG_MOUSE_ELAN_I2C=y
 CONFIG_INPUT_TOUCHSCREEN=y
 CONFIG_TOUCHSCREEN_ATMEL_MXT=m
+CONFIG_TOUCHSCREEN_ELAN=m
 CONFIG_TOUCHSCREEN_MMS114=m
 CONFIG_TOUCHSCREEN_ST1232=m
 CONFIG_TOUCHSCREEN_STMPE=y
@@ -439,8 +440,10 @@ CONFIG_GPIO_TPS6586X=y
 CONFIG_GPIO_TPS65910=y
 CONFIG_BATTERY_ACT8945A=y
 CONFIG_BATTERY_SBS=y
+CONFIG_BATTERY_BQ27XXX=m
 CONFIG_BATTERY_MAX17040=m
 CONFIG_BATTERY_MAX17042=m
+CONFIG_CHARGER_GPIO=m
 CONFIG_CHARGER_MAX14577=m
 CONFIG_CHARGER_MAX77693=m
 CONFIG_CHARGER_MAX8997=m
@@ -500,6 +503,7 @@ CONFIG_MFD_AXP20X_RSB=y
 CONFIG_MFD_CROS_EC=m
 CONFIG_MFD_CROS_EC_I2C=m
 CONFIG_MFD_CROS_EC_SPI=m
+CONFIG_MFD_CROS_EC_CHARDEV=m
 CONFIG_MFD_DA9063=m
 CONFIG_MFD_MAX14577=y
 CONFIG_MFD_MAX77686=y
@@ -877,10 +881,14 @@ CONFIG_AT91_ADC=m
 CONFIG_AT91_SAMA5D2_ADC=m
 CONFIG_BERLIN2_ADC=m
 CONFIG_EXYNOS_ADC=m
+CONFIG_ROCKCHIP_SARADC=m
 CONFIG_VF610_ADC=m
 CONFIG_XILINX_XADC=y
+CONFIG_IIO_CROS_EC_SENSORS_CORE=m
+CONFIG_IIO_CROS_EC_SENSORS=m
 CONFIG_MPU3050_I2C=y
 CONFIG_CM36651=m
+CONFIG_IIO_CROS_EC_LIGHT_PROX=m
 CONFIG_AK8975=y
 CONFIG_RASPBERRYPI_POWER=y
 CONFIG_IIO_HRTIMER_TRIGGER=y
@@ -917,6 +925,7 @@ CONFIG_PHY_SAMSUNG_USB2=m
 CONFIG_PHY_TEGRA_XUSB=y
 CONFIG_PHY_BRCM_SATA=y
 CONFIG_NVMEM=y
+CONFIG_ROCKCHIP_EFUSE=m
 CONFIG_NVMEM_SUNXI_SID=y
 CONFIG_BCM2835_MBOX=y
 CONFIG_RASPBERRYPI_FIRMWARE=y
@@ -954,6 +963,8 @@ CONFIG_CPUFREQ_DT=y
 CONFIG_KEYSTONE_IRQ=y
 CONFIG_HW_RANDOM=y
 CONFIG_HW_RANDOM_ST=y
+CONFIG_TCG_TPM=m
+CONFIG_TCG_TIS_I2C_INFINEON=m
 CONFIG_CRYPTO_USER=m
 CONFIG_CRYPTO_USER_API_HASH=m
 CONFIG_CRYPTO_USER_API_SKCIPHER=m
-- 
2.16.2
