Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,UPPERCASE_50_75,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E24BC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 18:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 150DE22E73
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 18:33:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N2N8TenW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 150DE22E73
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934626AbeGFSdi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 14:33:38 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:42603 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934546AbeGFSdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 14:33:35 -0400
Received: by mail-lf0-f68.google.com with SMTP id u202-v6so10518851lff.9;
        Fri, 06 Jul 2018 11:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5wD//z6jltn3lAsl96/sOnokHO3uo8uQ/EDmYBiYwUY=;
        b=N2N8TenW14K32vzWET+1Z5c764gLejRx0bmT/NUzFjT0rqti7ClNTG1dx2RP8DHOdR
         DGIDroStEE73RZguduzHUvEIFZ0uzadlmNq47HWTyO/Zm4K1UqtnF20OvwIWl9D2NYQ5
         Uw6anGbA+7UzScXsfjb2iBBqfMODJZjVV7IYEBfk29A0FH7UAL7Ja3Xfaxpf5sHJSHbb
         9ftcpUUbywugwlVoyUCD+BmVXmbCcLzS08gFxDsEEpQSBuAkD4pNXUO1jCMwVVJms9FO
         9tsCwSdA7KNGZrI+qGLujOY0cj34skMGKoCQdoI69HV04owq0soZPYh438lNItI4Eamx
         ad3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5wD//z6jltn3lAsl96/sOnokHO3uo8uQ/EDmYBiYwUY=;
        b=ONM1AxKWWw291IbVLgi7ChhNus7noKnNYIWAMtpKzbIKhk+wLmhVPInuZdngFr+EzN
         SmPXi1gVcM+kMUvMWf09E1sQWDFm27HiG0qEXgIaveV2VvaOjroTAofJo6d95CdT+8+2
         EohU9kpqysKSv9jbLdw2ssAc2jbUFhyT97qVTr7FSysp9Y0NVtjibkV7nVSErgX09bGv
         qImvx1RZErCHwYoCxYuXKt6Cwfhk3U9KCA8lbIlWe7v26fUOUj4UeTsgkQKubg9J/ujH
         axuehwu90unwOYhXHhZp+FHFAxc9R0ql3bqWbAVJUkOeJUaC7jaD9s5y6gux5dCl9fqR
         ssbA==
X-Gm-Message-State: APt69E35HYwnLtn0qZWLWSYOYERP6LmmShlbG9UgHxhfWXznitRfr3f6
        Ra8lhb3N84pp80eDe2V/L9c=
X-Google-Smtp-Source: AAOMgpefDb8TZx+2ke5icYcYJvoMzUJKBhDkXzTZoZA2bDSfkv+4KrzDuZpZPBik61BHSuwFTNpBDA==
X-Received: by 2002:a19:c403:: with SMTP id u3-v6mr7910946lff.87.1530902013672;
        Fri, 06 Jul 2018 11:33:33 -0700 (PDT)
Received: from localhost.localdomain (user-94-254-170-61.play-internet.pl. [94.254.170.61])
        by smtp.googlemail.com with ESMTPSA id l82-v6sm2314697lfb.8.2018.07.06.11.33.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Jul 2018 11:33:33 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     kgene@kernel.org, krzk@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, xc-racer2@live.ca,
        pawel.mikolaj.chmiel@gmail.com
Subject: [PATCH v3 8/9] ARM: s5pv210_defconfig: Enable drivers for Samsung Aries based phones
Date:   Fri,  6 Jul 2018 20:32:49 +0200
Message-Id: <1530901970-14972-9-git-send-email-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530901970-14972-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
References: <1530901970-14972-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable config options required for Samsung Aries based phones.
ARM_APPENDED_DTB is also needed, because stock bootloader
does not support loading dtb files.

Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
 arch/arm/configs/s5pv210_defconfig | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/s5pv210_defconfig b/arch/arm/configs/s5pv210_defconfig
index 9c862d366fb3..f719e7f9a655 100644
--- a/arch/arm/configs/s5pv210_defconfig
+++ b/arch/arm/configs/s5pv210_defconfig
@@ -13,9 +13,12 @@ CONFIG_SOLARIS_X86_PARTITION=y
 CONFIG_ARCH_S5PV210=y
 CONFIG_VMSPLIT_2G=y
 CONFIG_PREEMPT=y
+CONFIG_ARM_APPENDED_DTB=y
 CONFIG_CMDLINE="root=/dev/ram0 rw ramdisk=8192 initrd=0x20800000,8M console=ttySAC1,115200 init=/linuxrc"
 CONFIG_VFP=y
 CONFIG_NEON=y
+CONFIG_NET=y
+CONFIG_CFG80211=m
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
@@ -23,16 +26,42 @@ CONFIG_BLK_DEV_RAM_SIZE=8192
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
 CONFIG_MSDOS_FS=y
 CONFIG_VFAT_FS=y
-- 
2.7.4

