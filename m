Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,UPPERCASE_50_75,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99CABC43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 17:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 534B923D0D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 17:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6S4JkzT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 534B923D0D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966070AbeF0RMz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 13:12:55 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34854 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966048AbeF0RMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 13:12:51 -0400
Received: by mail-lj1-f195.google.com with SMTP id i125-v6so2245141lji.2;
        Wed, 27 Jun 2018 10:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5wD//z6jltn3lAsl96/sOnokHO3uo8uQ/EDmYBiYwUY=;
        b=U6S4JkzTRBL03Xu+grvUd25y65zlyM1SNO/zIygbvNXj1ctNUTxZ+pvsWYXgD6EPsq
         8ZiOhEQMKm+OQNZDwmr+o8vxNVSWzeiT0lcwYeb6ogO9fHCC+c+ndSbuvuI4S5t/af4e
         OcfDBnTDFd16rJCCaqkhmiJPdMM+0V+OqIdJ9aSpCSr3Bvqu7ko/I0XON6yZjyCEidrH
         zij1AjQdNe64knXGCuoTMvKzghdFQeNRCvjgA8s/PRDbImbSguZpKh567OUfjlUx8sH/
         CxJ39HIszwnWNP4ZoTEpPmRu45/qwmkXpCXgS26or1ssXnRAMQnYWwvZQzhTAC/1hn1Y
         gwtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5wD//z6jltn3lAsl96/sOnokHO3uo8uQ/EDmYBiYwUY=;
        b=px4PGVxroQAgyOfssDGNPGzTgx82xlLFTdiADFadmATx7G0tN5jao0pwpqinn1Pmiw
         oXNx54E3K33vdXK1XVOUAZdZEP1GYfVFKMy9ZCfKmj/bbnt0ayVjFQ96LodUKTOPSa2h
         2g+KKsoORvUnMVSALRAej6NdKm+ZBasRMiDxMJAIUT1rS+aRFqZ0e28+5qg+okJJqNkj
         ivFW9JW38iFfFwSLhAG7B1ngfAgddH1FCSN2jvw++hFs7iFM8UY+Z7S8BPBT5TmMcZS8
         DsyscA0IX4ge0DgTdP7Ki8ZfQjNTpXD4bzz9q2jOfX48394aieJFsxkWr+FkMa0vLF72
         WatA==
X-Gm-Message-State: APt69E3p7BKwW5EbiyBIkKg49oaS2Yr6LCaKYBQQw4RFpwxE5rNDP7ex
        kOp/77MbJWfdXmLwT29IFlY=
X-Google-Smtp-Source: ADUXVKKRFbgQnfi8YoqVra8hevvASSxQ01uRTzXomSbPXI5Ua7lNmnZExNaSE+nhTt92LwQ8J7bGqg==
X-Received: by 2002:a2e:8595:: with SMTP id b21-v6mr4520880lji.131.1530119570200;
        Wed, 27 Jun 2018 10:12:50 -0700 (PDT)
Received: from localhost.localdomain (user-94-254-170-61.play-internet.pl. [94.254.170.61])
        by smtp.googlemail.com with ESMTPSA id n9-v6sm929344lfb.7.2018.06.27.10.12.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 27 Jun 2018 10:12:49 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     kgene@kernel.org, krzk@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, xc-racer2@live.ca,
        pawel.mikolaj.chmiel@gmail.com
Subject: [PATCH v2 09/10] ARM: s5pv210_defconfig: Enable drivers for Samsung Aries based phones
Date:   Wed, 27 Jun 2018 19:12:23 +0200
Message-Id: <1530119544-30023-10-git-send-email-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530119544-30023-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
References: <1530119544-30023-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
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

