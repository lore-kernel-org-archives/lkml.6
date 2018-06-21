Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,UPPERCASE_50_75,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B03FBC43142
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 19:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BB7421BC6
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 19:12:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D95R3Fzg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BB7421BC6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933437AbeFUTL0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 15:11:26 -0400
Received: from mail-lf0-f41.google.com ([209.85.215.41]:34041 "EHLO
        mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754290AbeFUTK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 15:10:29 -0400
Received: by mail-lf0-f41.google.com with SMTP id e13-v6so5926073lfc.1;
        Thu, 21 Jun 2018 12:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LHpvBC/R30/+ePZW+P0ClkO1Fj8zjlBn9BzdBfd95Mk=;
        b=D95R3FzgWn/hbOw3ZGTLEAnmbUolVsGHKS8JM0EJ9DNWgH6A2vpSl7JbNJMWiLJybZ
         3AeH8AozvXvdCN36LpVj0L8RORF+n0ahShrQJBdAhpIX48xUhakitYx9tl2fTq0Bg2Ej
         QSCkedGxXjgjNcV29+a/Ago/cNHsJcg4IMg//wJM0CV20ZskZoiDw2UAWa/76aky+WPU
         s14zywvunW+gmW6AgQgHddtX2Zbwumsq/zbYpHahS2FNCw34fbn5W6zgr1Dd2SsO3wZ0
         ec1NCLR5rqJGudBBYk4xN4A6tgY+ECC4dJmeCcp6/9RNFZjjqPF+dzsm/bXuQThCwMpQ
         +QbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LHpvBC/R30/+ePZW+P0ClkO1Fj8zjlBn9BzdBfd95Mk=;
        b=D/WbHEpi8AIWGOjNWBKG5cDLZOAhJDGS2MzYUsP8qAue5+dbb/qC63obkycgZEw5fG
         v9eOE39ae9tdOR1l4HJdzngNZ0xT1njMLcSs0gRR/4lYHY5XQ6cr+Y9W3FmQycZYQgKm
         X5ZleVhLzJb7h2qCpe41lvwGzUBL4bHQL64GRiRvrzmTurcax7SKnj1ZOawdnCECXAG7
         6C3V2yCmoos53kKWTtpgYnI0czo71pXHjCNUIihjgnGIhKkTni/FytG7tLvkZpR4e+QU
         0ou0aJ46HetGo/P+LEVhAOS7UDby5AT5SnhoXBFGSmRmCHE0sBbYPKWEMmjJwEra7MMA
         RKmQ==
X-Gm-Message-State: APt69E29RAMTo662wrjlP35ntYdYRrKmiWNABSsiw9pvFncy1kStSqRE
        Og8wMqs1C4qBatCy5Kncm9hrZLE6rOo=
X-Google-Smtp-Source: ADUXVKIS/b5+b/VuvzgVrnsiWHor2OOl4D2D6am4CBSFyerncz5E6a8uQ9FLfrge7CjPvX+XbMSBgA==
X-Received: by 2002:a19:9aca:: with SMTP id c193-v6mr4778701lfe.140.1529608227108;
        Thu, 21 Jun 2018 12:10:27 -0700 (PDT)
Received: from localhost.localdomain (user-94-254-170-61.play-internet.pl. [94.254.170.61])
        by smtp.googlemail.com with ESMTPSA id u3-v6sm988036lji.4.2018.06.21.12.10.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 21 Jun 2018 12:10:26 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     kgene@kernel.org, krzk@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, xc-racer2@live.ca,
        pawel.mikolaj.chmiel@gmail.com
Subject: [PATCH 4/7] ARM: s5pv210_defconfig: Enable drivers for Samsung Aries based phones
Date:   Thu, 21 Jun 2018 21:09:56 +0200
Message-Id: <1529608199-5583-5-git-send-email-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529608199-5583-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
References: <1529608199-5583-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable config options required for Samsung Aries based phones..
While we're here, also enable other useful options like:
- SYSVIPC
- CGROUPS
- DEVTMPFS
- networking support
- ext4 and autofs

Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
 arch/arm/configs/s5pv210_defconfig | 49 +++++++++++++++++++++++++++++++++++---
 1 file changed, 46 insertions(+), 3 deletions(-)

diff --git a/arch/arm/configs/s5pv210_defconfig b/arch/arm/configs/s5pv210_defconfig
index 09b5a7386414..a077597369f1 100644
--- a/arch/arm/configs/s5pv210_defconfig
+++ b/arch/arm/configs/s5pv210_defconfig
@@ -1,5 +1,7 @@
+CONFIG_SYSVIPC=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
+CONFIG_CGROUPS=y
 CONFIG_SYSFS_DEPRECATED=y
 CONFIG_SYSFS_DEPRECATED_V2=y
 CONFIG_BLK_DEV_INITRD=y
@@ -13,28 +15,68 @@ CONFIG_SOLARIS_X86_PARTITION=y
 CONFIG_ARCH_S5PV210=y
 CONFIG_VMSPLIT_2G=y
 CONFIG_PREEMPT=y
-CONFIG_AEABI=y
+CONFIG_ARM_APPENDED_DTB=y
 CONFIG_CMDLINE="root=/dev/ram0 rw ramdisk=8192 initrd=0x20800000,8M console=ttySAC1,115200 init=/linuxrc"
 CONFIG_VFP=y
 CONFIG_NEON=y
+CONFIG_NET=y
+CONFIG_PACKET=y
+CONFIG_UNIX=y
+CONFIG_INET=y
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+CONFIG_IP_PNP_BOOTP=y
+CONFIG_IP_PNP_RARP=y
+CONFIG_CFG80211=m
+CONFIG_MAC80211=m
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=8192
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_CHR_DEV_SG=y
+CONFIG_NETDEVICES=y
+CONFIG_BRCMFMAC=m
 CONFIG_INPUT_EVDEV=y
-# CONFIG_INPUT_KEYBOARD is not set
+CONFIG_KEYBOARD_GPIO=y
 # CONFIG_INPUT_MOUSE is not set
 CONFIG_INPUT_TOUCHSCREEN=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_SAMSUNG=y
 CONFIG_SERIAL_SAMSUNG_CONSOLE=y
 CONFIG_HW_RANDOM=y
+CONFIG_I2C_GPIO=y
+CONFIG_POWER_SUPPLY=y
+CONFIG_BATTERY_MAX17040=y
 # CONFIG_HWMON is not set
-# CONFIG_USB_SUPPORT is not set
+CONFIG_MFD_MAX8998=y
+CONFIG_REGULATOR=y
+CONFIG_REGULATOR_MAX8998=y
+CONFIG_DRM=y
+CONFIG_DRM_EXYNOS=y
+CONFIG_DRM_EXYNOS_FIMD=y
+CONFIG_DRM_EXYNOS_DPI=y
+CONFIG_USB=y
+CONFIG_USB_OTG=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_EXYNOS=y
+CONFIG_USB_OHCI_HCD=y
+CONFIG_USB_OHCI_EXYNOS=y
+CONFIG_USB_DWC2=y
+CONFIG_MMC=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_S3C=y
+CONFIG_MMC_SDHCI_S3C_DMA=y
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_DRV_MAX8998=m
+CONFIG_PHY_SAMSUNG_USB2=m
+CONFIG_PHY_S5PV210_USB2=y
 CONFIG_EXT2_FS=y
+CONFIG_EXT4_FS=y
+CONFIG_AUTOFS4_FS=y
 CONFIG_MSDOS_FS=y
 CONFIG_VFAT_FS=y
 CONFIG_TMPFS=y
@@ -44,6 +86,7 @@ CONFIG_ROMFS_FS=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ASCII=y
 CONFIG_NLS_ISO8859_1=y
+CONFIG_NLS_UTF8=y
 CONFIG_DEBUG_INFO=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_KERNEL=y
-- 
2.7.4

