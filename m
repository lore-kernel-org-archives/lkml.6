Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,UPPERCASE_50_75,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A21CCC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5924323E3C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:41:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5924323E3C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753290AbeGDOlG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 10:41:06 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38270 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753220AbeGDOlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 10:41:04 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 0C598263B33
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     kernel@collabora.com, Marek Szyprowski <m.szyprowski@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Olof Johansson <olof@lixom.net>, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Russell King <linux@armlinux.org.uk>,
        Simon Horman <horms+renesas@verge.net.au>
Subject: [RESEND PATCH] ARM: multi_v7_defconfig: Enable missing drivers for supported Chromebooks.
Date:   Wed,  4 Jul 2018 16:40:55 +0200
Message-Id: <20180704144055.22005-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
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
Fixed some conflicts when I picked up the old patch [1]

[1] https://patchwork.kernel.org/patch/10300677/

 arch/arm/configs/multi_v7_defconfig | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 8f6be1982545..764b14ac271c 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -280,6 +280,7 @@ CONFIG_MOUSE_CYAPA=m
 CONFIG_MOUSE_ELAN_I2C=y
 CONFIG_INPUT_TOUCHSCREEN=y
 CONFIG_TOUCHSCREEN_ATMEL_MXT=m
+CONFIG_TOUCHSCREEN_ELAN=m
 CONFIG_TOUCHSCREEN_MMS114=m
 CONFIG_TOUCHSCREEN_WM97XX=m
 CONFIG_TOUCHSCREEN_ST1232=m
@@ -340,6 +341,8 @@ CONFIG_SERIAL_DEV_BUS=y
 CONFIG_VIRTIO_CONSOLE=y
 CONFIG_HW_RANDOM=y
 CONFIG_HW_RANDOM_ST=y
+CONFIG_TCG_TPM=m
+CONFIG_TCG_TIS_I2C_INFINEON=m
 CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_ARB_GPIO_CHALLENGE=m
 CONFIG_I2C_MUX_PCA954x=y
@@ -433,9 +436,11 @@ CONFIG_POWER_RESET_RMOBILE=y
 CONFIG_BATTERY_ACT8945A=y
 CONFIG_BATTERY_CPCAP=m
 CONFIG_BATTERY_SBS=y
+CONFIG_BATTERY_BQ27XXX=m
 CONFIG_AXP20X_POWER=m
 CONFIG_BATTERY_MAX17040=m
 CONFIG_BATTERY_MAX17042=m
+CONFIG_CHARGER_GPIO=m
 CONFIG_CHARGER_CPCAP=m
 CONFIG_CHARGER_MAX14577=m
 CONFIG_CHARGER_MAX77693=m
@@ -492,6 +497,7 @@ CONFIG_MFD_AXP20X_RSB=y
 CONFIG_MFD_CROS_EC=m
 CONFIG_MFD_CROS_EC_I2C=m
 CONFIG_MFD_CROS_EC_SPI=m
+CONFIG_MFD_CROS_EC_CHARDEV=m
 CONFIG_MFD_DA9063=m
 CONFIG_MFD_MAX14577=y
 CONFIG_MFD_MAX77686=y
@@ -892,10 +898,14 @@ CONFIG_AT91_SAMA5D2_ADC=m
 CONFIG_BERLIN2_ADC=m
 CONFIG_CPCAP_ADC=m
 CONFIG_EXYNOS_ADC=m
+CONFIG_ROCKCHIP_SARADC=m
 CONFIG_VF610_ADC=m
 CONFIG_XILINX_XADC=y
+CONFIG_IIO_CROS_EC_SENSORS_CORE=m
+CONFIG_IIO_CROS_EC_SENSORS=m
 CONFIG_MPU3050_I2C=y
 CONFIG_CM36651=m
+CONFIG_IIO_CROS_EC_LIGHT_PROX=m
 CONFIG_SENSORS_ISL29018=y
 CONFIG_SENSORS_ISL29028=y
 CONFIG_AK8975=y
@@ -936,6 +946,7 @@ CONFIG_PHY_DM816X_USB=m
 CONFIG_OMAP_USB2=y
 CONFIG_TI_PIPE3=y
 CONFIG_TWL4030_USB=m
+CONFIG_ROCKCHIP_EFUSE=m
 CONFIG_NVMEM_IMX_OCOTP=y
 CONFIG_NVMEM_SUNXI_SID=y
 CONFIG_NVMEM_VF610_OCOTP=y
-- 
2.18.0

