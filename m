Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C712C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 16:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C665620856
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 16:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S86XCxFO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387425AbeL1QSt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 11:18:49 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46469 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387400AbeL1QSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 11:18:44 -0500
Received: by mail-lj1-f195.google.com with SMTP id v15-v6so19067594ljh.13;
        Fri, 28 Dec 2018 08:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TMSLDL48glwA1oH7bbsCQDglQ0bWOL5UXlljzhH70zo=;
        b=S86XCxFOlg49LKQKFnHrzBTfHNBFlvDLzosSpu20KQUI38zJh5yiiuXV/Jo96rHaez
         P+AEdovgvYzlj2ZmmmErJYa6DFXgIj2YDD9Kd/c9LvWZJnpRLdkId3jUzhE6hE5spqgq
         yCIPIjKaJzbq56KusZem7DRDJ21OwQAHlywD17C52ZnS/Hp9+We56PVN4cQh4e61JjFg
         3lsQzP5fdgbEu/ANDJnq+KoHOGq2UT5AQ+m2FnrahyB9dprWdYDi3Q/OYbLvMYCmuWVj
         brfN/qjwo3gPGgS8Y+IaeRNvLhJyO1/ungI9JCk/VI0r/QrTORBUxG7YEv3xFGDMjEaL
         tfow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TMSLDL48glwA1oH7bbsCQDglQ0bWOL5UXlljzhH70zo=;
        b=NXiXTsOlgr4cWBbyDwZv4y4FlOm+p07x21NLuzpSJG5O9aSkGFp7XAfgOaSE2wTy7O
         EJTSLDfImwb3SbmVF+KxULAGTW226r7uq8CBIvYBpq7WT2Vk8pB9pFp77SftWDPytIGr
         PKEBbeHEuV19BIxiPd2esaJKf0la9xSmDg+1oyNRLZn7FAtNF6iCVlU5ZVeAxr5HZfcw
         m0Awmo1e3CVGtJGS/sSYiOXUrIrEIWMOnepFrrAKlq806V9/JMbmm2ZwcEvrpiEBnr/E
         xUnlbmaip3ggny/ymfHHZ0cMRns6NO7l05V+gNhV705PFD8E9NwDqA9EIusxpm9XYWER
         pPWw==
X-Gm-Message-State: AA+aEWaX4BtZAAGSr484Voaf2rDO37gMEM4oeVrwDrjM/cbgeTmt4ivN
        k4oQ5YUtISiu/w6CLIuY3/28YR259LgreA==
X-Google-Smtp-Source: ALg8bN6y3VVbBRWQepE2H4W+R13Viwmz9dAyOgeOQvoJ5IT2ho8COEoqMhJ2qFdDZqLjg1EwN6O9TQ==
X-Received: by 2002:a2e:9783:: with SMTP id y3-v6mr16123171lji.167.1546013921342;
        Fri, 28 Dec 2018 08:18:41 -0800 (PST)
Received: from localhost.localdomain ([2a02:a315:5445:5300:7146:fd07:48ff:9665])
        by smtp.googlemail.com with ESMTPSA id r4sm8136502lfe.60.2018.12.28.08.18.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Dec 2018 08:18:40 -0800 (PST)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     krzk@kernel.org
Cc:     kgene@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, pawel.mikolaj.chmiel@gmail.com,
        xc-racer2@live.ca, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] ARM: defconfig: s5pv210: Enable more drivers present on Samsung Aries
Date:   Fri, 28 Dec 2018 17:18:19 +0100
Message-Id: <20181228161819.18931-7-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181228161819.18931-1-pawel.mikolaj.chmiel@gmail.com>
References: <20181228161819.18931-1-pawel.mikolaj.chmiel@gmail.com>
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

Disable DEBUG_LL. It's currently set to uart1, but if we want to use
 it on Aries, we would need to switch uart2, to get any logs.

Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
---
 arch/arm/configs/s5pv210_defconfig | 41 ++++++++++++++++++++++--------
 1 file changed, 30 insertions(+), 11 deletions(-)

diff --git a/arch/arm/configs/s5pv210_defconfig b/arch/arm/configs/s5pv210_defconfig
index a077597369f1..951196bdf008 100644
--- a/arch/arm/configs/s5pv210_defconfig
+++ b/arch/arm/configs/s5pv210_defconfig
@@ -1,24 +1,24 @@
 CONFIG_SYSVIPC=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
+CONFIG_PREEMPT=y
 CONFIG_CGROUPS=y
 CONFIG_SYSFS_DEPRECATED=y
 CONFIG_SYSFS_DEPRECATED_V2=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_KALLSYMS_ALL=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-# CONFIG_BLK_DEV_BSG is not set
-CONFIG_PARTITION_ADVANCED=y
-CONFIG_BSD_DISKLABEL=y
-CONFIG_SOLARIS_X86_PARTITION=y
 CONFIG_ARCH_S5PV210=y
 CONFIG_VMSPLIT_2G=y
-CONFIG_PREEMPT=y
 CONFIG_ARM_APPENDED_DTB=y
 CONFIG_CMDLINE="root=/dev/ram0 rw ramdisk=8192 initrd=0x20800000,8M console=ttySAC1,115200 init=/linuxrc"
 CONFIG_VFP=y
 CONFIG_NEON=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+# CONFIG_BLK_DEV_BSG is not set
+CONFIG_PARTITION_ADVANCED=y
+CONFIG_BSD_DISKLABEL=y
+CONFIG_SOLARIS_X86_PARTITION=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
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
@@ -87,6 +109,7 @@ CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ASCII=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_UTF8=y
+CONFIG_CRC_CCITT=y
 CONFIG_DEBUG_INFO=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_KERNEL=y
@@ -96,7 +119,3 @@ CONFIG_DEBUG_SPINLOCK=y
 CONFIG_DEBUG_MUTEXES=y
 CONFIG_DEBUG_ATOMIC_SLEEP=y
 CONFIG_DEBUG_USER=y
-CONFIG_DEBUG_LL=y
-CONFIG_DEBUG_S3C_UART1=y
-CONFIG_EARLY_PRINTK=y
-CONFIG_CRC_CCITT=y
-- 
2.17.1

