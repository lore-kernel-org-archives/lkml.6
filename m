Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2786C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E06D20883
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FZkVdldL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728987AbfAHQ4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 11:56:25 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35212 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728712AbfAHQ4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 11:56:15 -0500
Received: by mail-lf1-f66.google.com with SMTP id e26so3464016lfc.2;
        Tue, 08 Jan 2019 08:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9OvXwhCxM1xt9LzERNCzqQZpA6Q4+BEkTsZDw6x8xAY=;
        b=FZkVdldLnxOjxCc/kM2yZ1u7C8PnG93EeYuHqIWVIbzRq//gDBuuXImP9AkoU3Z/uY
         nsxzzWVmtSi7KfKpOgLOSmIvhT0jB0F7hQ8LlFc4MBHN0+CwbhlkfDk27tBMkFvGz8K4
         N96fwkBPP8usIX0511fM6DtsFmjMm1pErvfaYXIx9TAqh9Qf6hw/TNsJJkHJ6UTfNJYf
         qOSw1d0h/4Qqgwq3iZ1q1jwH8fKRDmvd/PZIBN5y2p2wW3bc6TjOA1AmZJOwlIjGZFDj
         PCnyUSh0U3cbK0W6M8bq8T9Q06ZhwpIN2YxrfLuEKcUFL3jfOeoUYfnjXH25V1iBshkj
         IqIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9OvXwhCxM1xt9LzERNCzqQZpA6Q4+BEkTsZDw6x8xAY=;
        b=Hjo7KioFQFf85VPjCSizRTGQjkGdlwflba4OVBfdJsBIMt+pPAQ4REDjpvUsPXacnw
         j89kubvAxC1rlr2VgAW3gX/DzHNNZQMdW2KyVvrP1YJXpRYHa/jgywGdRjppuVnmawqi
         HD3J2qkXnVZ1m4HzcoksH7upLw95rsDQimyKqWEhDbHRbyeGYu96N2OCbIaXXk5uEV/A
         ir5tnjQufyeB2PuzfT/+dAfiOeYU3LQceC7exTRdlXrQUWnzlZAMO0CnheFVRnUINwGC
         /fstBJPCqFNZSNvLV86TduoYMbCfhIhZBhTSRJG677A1IEyb0UrRA3al+9TPuOp4Zaz6
         oNYw==
X-Gm-Message-State: AJcUukddUYSJzaYBa1F7v+g5sykHSXINpMMXbJpgAIxWXCMY2y8rfZI5
        uZbzrjFfdhMuTaRcoK25o4E=
X-Google-Smtp-Source: ALg8bN6zN9PKHP7RMlsjyM6/i6cKoC2Pn/kP532vlyE5Im2xZ/tntbC1JpqgRVvuWNwwKp/iSa/ykQ==
X-Received: by 2002:a19:f20:: with SMTP id e32mr1544783lfi.51.1546966573132;
        Tue, 08 Jan 2019 08:56:13 -0800 (PST)
Received: from localhost.localdomain ([2a02:a315:5445:5300:d033:e708:8ec7:810d])
        by smtp.googlemail.com with ESMTPSA id f8sm14687989lfe.72.2019.01.08.08.56.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 08:56:12 -0800 (PST)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     krzk@kernel.org
Cc:     kgene@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, pawel.mikolaj.chmiel@gmail.com,
        xc-racer2@live.ca, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] ARM: defconfig: s5pv210: Enable more drivers present on Samsung Aries
Date:   Tue,  8 Jan 2019 17:56:01 +0100
Message-Id: <20190108165601.25708-5-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190108165601.25708-1-pawel.mikolaj.chmiel@gmail.com>
References: <20190108165601.25708-1-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit enables following drivers:
- i2c support (using s3c2410 driver)
- s5p-jpeg
- s5p-mfc
- exynos drm rotator
- pwm support
- pwm vibrator
- fixed regulator
- syscon poweroff
- Atmel maXTouch touchscreen
- Broadcom BCM4329 bluetooth over uart0
- dma devices (so we can use pl330 dma driver)

Disable DEBUG_LL. It's currently set to uart1, but if we want to use it
on Aries, we would need to switch it to uart2, to get any logs.

Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
---
 arch/arm/configs/s5pv210_defconfig | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/arch/arm/configs/s5pv210_defconfig b/arch/arm/configs/s5pv210_defconfig
index 0159636d4c0d..951196bdf008 100644
--- a/arch/arm/configs/s5pv210_defconfig
+++ b/arch/arm/configs/s5pv210_defconfig
@@ -27,6 +27,11 @@ CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
 CONFIG_IP_PNP_BOOTP=y
 CONFIG_IP_PNP_RARP=y
+CONFIG_BT=m
+CONFIG_BT_RFCOMM=y
+CONFIG_BT_BNEP=y
+CONFIG_BT_HCIUART=m
+CONFIG_BT_HCIUART_BCM=y
 CONFIG_CFG80211=m
 CONFIG_MAC80211=m
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
@@ -44,21 +49,35 @@ CONFIG_INPUT_EVDEV=y
 CONFIG_KEYBOARD_GPIO=y
 # CONFIG_INPUT_MOUSE is not set
 CONFIG_INPUT_TOUCHSCREEN=y
+CONFIG_TOUCHSCREEN_ATMEL_MXT=m
+CONFIG_INPUT_MISC=y
+CONFIG_INPUT_PWM_VIBRA=m
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_SAMSUNG=y
 CONFIG_SERIAL_SAMSUNG_CONSOLE=y
+CONFIG_SERIAL_DEV_BUS=y
 CONFIG_HW_RANDOM=y
 CONFIG_I2C_GPIO=y
+CONFIG_I2C_S3C2410=y
+CONFIG_POWER_RESET=y
+CONFIG_POWER_RESET_SYSCON_POWEROFF=y
 CONFIG_POWER_SUPPLY=y
 CONFIG_BATTERY_MAX17040=y
 # CONFIG_HWMON is not set
 CONFIG_MFD_MAX8998=y
 CONFIG_REGULATOR=y
+CONFIG_REGULATOR_FIXED_VOLTAGE=y
 CONFIG_REGULATOR_MAX8998=y
+CONFIG_MEDIA_SUPPORT=m
+CONFIG_MEDIA_CAMERA_SUPPORT=y
+CONFIG_V4L_MEM2MEM_DRIVERS=y
+CONFIG_VIDEO_SAMSUNG_S5P_JPEG=m
+CONFIG_VIDEO_SAMSUNG_S5P_MFC=m
 CONFIG_DRM=y
 CONFIG_DRM_EXYNOS=y
 CONFIG_DRM_EXYNOS_FIMD=y
 CONFIG_DRM_EXYNOS_DPI=y
+CONFIG_DRM_EXYNOS_ROTATOR=y
 CONFIG_USB=y
 CONFIG_USB_OTG=y
 CONFIG_USB_EHCI_HCD=y
@@ -72,6 +91,9 @@ CONFIG_MMC_SDHCI_S3C=y
 CONFIG_MMC_SDHCI_S3C_DMA=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_MAX8998=m
+CONFIG_DMADEVICES=y
+CONFIG_PWM=y
+CONFIG_PWM_SAMSUNG=y
 CONFIG_PHY_SAMSUNG_USB2=m
 CONFIG_PHY_S5PV210_USB2=y
 CONFIG_EXT2_FS=y
@@ -97,6 +119,3 @@ CONFIG_DEBUG_SPINLOCK=y
 CONFIG_DEBUG_MUTEXES=y
 CONFIG_DEBUG_ATOMIC_SLEEP=y
 CONFIG_DEBUG_USER=y
-CONFIG_DEBUG_LL=y
-CONFIG_DEBUG_S3C_UART1=y
-CONFIG_EARLY_PRINTK=y
-- 
2.17.1

