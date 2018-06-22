Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,UPPERCASE_50_75
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E93C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 07:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D0EE23E81
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 07:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q9WehJyG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D0EE23E81
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751394AbeFVHyZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 03:54:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:33588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750934AbeFVHyX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 03:54:23 -0400
Received: from mail-wr0-f176.google.com (mail-wr0-f176.google.com [209.85.128.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1EF5A23E81;
        Fri, 22 Jun 2018 07:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529654062;
        bh=Ht1dL9eIojSlvqMyQEFBtcdQgrdtPceRKZLlK6BBkEQ=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=Q9WehJyGvju3iSRMvrxpqly4mbZ9sHEq6E+jnPVWqyrG/bwaDWCTUnzTxe4iAJ2bB
         GgNVG4kk1VElYu5LxEd7E882DObggbCWw+rtHMc+srrOTuhogTT71oKSmpVUhqFFvU
         J3+CRgQPo1Fi4afrlbLzwkAXKapnd5+e4sa2AH0o=
Received: by mail-wr0-f176.google.com with SMTP id d2-v6so5672123wrm.10;
        Fri, 22 Jun 2018 00:54:22 -0700 (PDT)
X-Gm-Message-State: APt69E0a4JsJ7XRxPf2WXKGaVHm6ypwtEauxQPO1l9kj/SkNbNpTSuak
        sWQyfW2BXCmy5h1giE6Rs0VdSToVxK6O0AR8bz0=
X-Google-Smtp-Source: AAOMgpdjVHG9eD+uUgfjt/2vmhApd5qV+23jV3vL0Z2zoDqtGW7quUWqvKFW9q6yp3/ps42kqdsyjD/5Su/77EjR8QM=
X-Received: by 2002:adf:f482:: with SMTP id l2-v6mr611127wro.259.1529654060574;
 Fri, 22 Jun 2018 00:54:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9166:0:0:0:0:0 with HTTP; Fri, 22 Jun 2018 00:54:20
 -0700 (PDT)
In-Reply-To: <1529608199-5583-5-git-send-email-pawel.mikolaj.chmiel@gmail.com>
References: <1529608199-5583-1-git-send-email-pawel.mikolaj.chmiel@gmail.com> <1529608199-5583-5-git-send-email-pawel.mikolaj.chmiel@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Fri, 22 Jun 2018 09:54:20 +0200
X-Gmail-Original-Message-ID: <CAJKOXPe3D5Qp_idZY57UJi2c10D7wEfTZ=W=PkzanK4NPf-WWg@mail.gmail.com>
Message-ID: <CAJKOXPe3D5Qp_idZY57UJi2c10D7wEfTZ=W=PkzanK4NPf-WWg@mail.gmail.com>
Subject: Re: [PATCH 4/7] ARM: s5pv210_defconfig: Enable drivers for Samsung
 Aries based phones
To:     =?UTF-8?Q?Pawe=C5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Cc:     kgene@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, xc-racer2@live.ca
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 June 2018 at 21:09, Pawe=C5=82 Chmiel <pawel.mikolaj.chmiel@gmail.com=
> wrote:
> Enable config options required for Samsung Aries based phones..

Two dots.

> While we're here, also enable other useful options like:

Please split it. One set of changes needed for Aries and second set of
other useful changes with short explanation why they are needed. This
explanation might be for example:
1. because typical Linux distro or systemd requires them,
2. they are useful for debugging.

> - SYSVIPC
> - CGROUPS
> - DEVTMPFS
> - networking support
> - ext4 and autofs
>
> Signed-off-by: Pawe=C5=82 Chmiel <pawel.mikolaj.chmiel@gmail.com>
> ---
>  arch/arm/configs/s5pv210_defconfig | 49 ++++++++++++++++++++++++++++++++=
+++---
>  1 file changed, 46 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/configs/s5pv210_defconfig b/arch/arm/configs/s5pv21=
0_defconfig
> index 09b5a7386414..a077597369f1 100644
> --- a/arch/arm/configs/s5pv210_defconfig
> +++ b/arch/arm/configs/s5pv210_defconfig
> @@ -1,5 +1,7 @@
> +CONFIG_SYSVIPC=3Dy
>  CONFIG_NO_HZ=3Dy
>  CONFIG_HIGH_RES_TIMERS=3Dy
> +CONFIG_CGROUPS=3Dy
>  CONFIG_SYSFS_DEPRECATED=3Dy
>  CONFIG_SYSFS_DEPRECATED_V2=3Dy
>  CONFIG_BLK_DEV_INITRD=3Dy
> @@ -13,28 +15,68 @@ CONFIG_SOLARIS_X86_PARTITION=3Dy
>  CONFIG_ARCH_S5PV210=3Dy
>  CONFIG_VMSPLIT_2G=3Dy
>  CONFIG_PREEMPT=3Dy
> -CONFIG_AEABI=3Dy

I believe this comes from savedefconfig. In such case please make it a
separate commit, before all others, because it should not bring any
functional differences.

Best regards,
Krzysztof

> +CONFIG_ARM_APPENDED_DTB=3Dy
>  CONFIG_CMDLINE=3D"root=3D/dev/ram0 rw ramdisk=3D8192 initrd=3D0x20800000=
,8M console=3DttySAC1,115200 init=3D/linuxrc"
>  CONFIG_VFP=3Dy
>  CONFIG_NEON=3Dy
> +CONFIG_NET=3Dy
> +CONFIG_PACKET=3Dy
> +CONFIG_UNIX=3Dy
> +CONFIG_INET=3Dy
> +CONFIG_IP_PNP=3Dy
> +CONFIG_IP_PNP_DHCP=3Dy
> +CONFIG_IP_PNP_BOOTP=3Dy
> +CONFIG_IP_PNP_RARP=3Dy
> +CONFIG_CFG80211=3Dm
> +CONFIG_MAC80211=3Dm
>  CONFIG_UEVENT_HELPER_PATH=3D"/sbin/hotplug"
> +CONFIG_DEVTMPFS=3Dy
> +CONFIG_DEVTMPFS_MOUNT=3Dy
>  CONFIG_BLK_DEV_LOOP=3Dy
>  CONFIG_BLK_DEV_RAM=3Dy
>  CONFIG_BLK_DEV_RAM_SIZE=3D8192
>  CONFIG_SCSI=3Dy
>  CONFIG_BLK_DEV_SD=3Dy
>  CONFIG_CHR_DEV_SG=3Dy
> +CONFIG_NETDEVICES=3Dy
> +CONFIG_BRCMFMAC=3Dm
>  CONFIG_INPUT_EVDEV=3Dy
> -# CONFIG_INPUT_KEYBOARD is not set
> +CONFIG_KEYBOARD_GPIO=3Dy
>  # CONFIG_INPUT_MOUSE is not set
>  CONFIG_INPUT_TOUCHSCREEN=3Dy
>  CONFIG_SERIAL_8250=3Dy
>  CONFIG_SERIAL_SAMSUNG=3Dy
>  CONFIG_SERIAL_SAMSUNG_CONSOLE=3Dy
>  CONFIG_HW_RANDOM=3Dy
> +CONFIG_I2C_GPIO=3Dy
> +CONFIG_POWER_SUPPLY=3Dy
> +CONFIG_BATTERY_MAX17040=3Dy
>  # CONFIG_HWMON is not set
> -# CONFIG_USB_SUPPORT is not set
> +CONFIG_MFD_MAX8998=3Dy
> +CONFIG_REGULATOR=3Dy
> +CONFIG_REGULATOR_MAX8998=3Dy
> +CONFIG_DRM=3Dy
> +CONFIG_DRM_EXYNOS=3Dy
> +CONFIG_DRM_EXYNOS_FIMD=3Dy
> +CONFIG_DRM_EXYNOS_DPI=3Dy
> +CONFIG_USB=3Dy
> +CONFIG_USB_OTG=3Dy
> +CONFIG_USB_EHCI_HCD=3Dy
> +CONFIG_USB_EHCI_EXYNOS=3Dy
> +CONFIG_USB_OHCI_HCD=3Dy
> +CONFIG_USB_OHCI_EXYNOS=3Dy
> +CONFIG_USB_DWC2=3Dy
> +CONFIG_MMC=3Dy
> +CONFIG_MMC_SDHCI=3Dy
> +CONFIG_MMC_SDHCI_S3C=3Dy
> +CONFIG_MMC_SDHCI_S3C_DMA=3Dy
> +CONFIG_RTC_CLASS=3Dy
> +CONFIG_RTC_DRV_MAX8998=3Dm
> +CONFIG_PHY_SAMSUNG_USB2=3Dm
> +CONFIG_PHY_S5PV210_USB2=3Dy
>  CONFIG_EXT2_FS=3Dy
> +CONFIG_EXT4_FS=3Dy
> +CONFIG_AUTOFS4_FS=3Dy
>  CONFIG_MSDOS_FS=3Dy
>  CONFIG_VFAT_FS=3Dy
>  CONFIG_TMPFS=3Dy
> @@ -44,6 +86,7 @@ CONFIG_ROMFS_FS=3Dy
>  CONFIG_NLS_CODEPAGE_437=3Dy
>  CONFIG_NLS_ASCII=3Dy
>  CONFIG_NLS_ISO8859_1=3Dy
> +CONFIG_NLS_UTF8=3Dy
>  CONFIG_DEBUG_INFO=3Dy
>  CONFIG_MAGIC_SYSRQ=3Dy
>  CONFIG_DEBUG_KERNEL=3Dy
> --
> 2.7.4
>
