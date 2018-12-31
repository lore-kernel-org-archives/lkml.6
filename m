Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8402C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 13:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74F7C20828
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 13:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546262553;
	bh=SgtGQGygrDknb3zb9QF7SAu8yMjnCQvFcz0e+I9UV7w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=v8DOWnSVR+Wuf9IShfc9FErcIUvXTUN9MgpSkRmwpVanO/Z7b10VjcnxuGrRA0Rqq
	 QV49/nk3zfoBLwJ1rgA+GhhoochZNhPSzMISp6fVhLKdcX++hmZr8MxXhArevdnIt1
	 JUbaTHaKdrgdi0vfBbxNM0ajw0tFbyUolHCXGnfQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbeLaNWb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 08:22:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:37110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726181AbeLaNWb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 08:22:31 -0500
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BF3D21738;
        Mon, 31 Dec 2018 13:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546262549;
        bh=SgtGQGygrDknb3zb9QF7SAu8yMjnCQvFcz0e+I9UV7w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qgowp8TbjugfV6nKM9LiX6g7tiJ8G9XatRolEL/EKLfy77gR1WL3r2akXVK4l1Tpn
         CJLt0W/u2snPOXE+EAQTuTO/VZcTGxHDhl1MZRq/vjjGHln5CCrk11WyIvdWvobYZZ
         Y+VE77ufWzCwoZlL6JHxP86WnhFkFr5uMg7I/p3g=
Received: by mail-lf1-f51.google.com with SMTP id i26so18325812lfc.0;
        Mon, 31 Dec 2018 05:22:28 -0800 (PST)
X-Gm-Message-State: AA+aEWaGFuVY4xp6GaVNtW3pO66UTCWjmqVoGgmJHrAA2LKT4BTF36cR
        fB2as8XxkcgMCWKmQ6RlCEr5F5KSfzHcc3mqEFs=
X-Google-Smtp-Source: AFSGD/XQescy37sCegt46wGjXaHK6DW3kDaslrOBNrVOfIeY5k/m/xsqQLv1uqrZkNh0MGtp8SQLoKJpMUcHifkUzG0=
X-Received: by 2002:a19:10a4:: with SMTP id 36mr18217949lfq.60.1546262547132;
 Mon, 31 Dec 2018 05:22:27 -0800 (PST)
MIME-Version: 1.0
References: <20181228161819.18931-1-pawel.mikolaj.chmiel@gmail.com> <20181228161819.18931-7-pawel.mikolaj.chmiel@gmail.com>
In-Reply-To: <20181228161819.18931-7-pawel.mikolaj.chmiel@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 31 Dec 2018 14:22:16 +0100
X-Gmail-Original-Message-ID: <CAJKOXPcksbbOLpRBpbq33e5FtOOBZXNZCa0wA=TCn5vCSfQH3w@mail.gmail.com>
Message-ID: <CAJKOXPcksbbOLpRBpbq33e5FtOOBZXNZCa0wA=TCn5vCSfQH3w@mail.gmail.com>
Subject: Re: [PATCH 6/6] ARM: defconfig: s5pv210: Enable more drivers present
 on Samsung Aries
To:     =?UTF-8?Q?Pawe=C5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Cc:     kgene@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, xc-racer2@live.ca,
        linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Dec 2018 at 17:18, Pawe=C5=82 Chmiel
<pawel.mikolaj.chmiel@gmail.com> wrote:
>
> This commit enables following drivers:
> - i2c support (using s3c2410 driver)
> - s5p-jpeg
> - s5p-mfc
> - exynos drm rotator
> - pwm support
> - pwm vibrator
> - fixed regulator
> - syscon poweroff
> - Atmel maXTouch touchscreen
> - Broadcom BCM4329 bluetooth over uart0
> - dma devices (so we can use pl330 dma driver)
>
> Disable DEBUG_LL. It's currently set to uart1, but if we want to use
>  it on Aries, we would need to switch uart2, to get any logs.
>
> Signed-off-by: Pawe=C5=82 Chmiel <pawel.mikolaj.chmiel@gmail.com>
> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
> ---
>  arch/arm/configs/s5pv210_defconfig | 41 ++++++++++++++++++++++--------
>  1 file changed, 30 insertions(+), 11 deletions(-)
>
> diff --git a/arch/arm/configs/s5pv210_defconfig b/arch/arm/configs/s5pv21=
0_defconfig
> index a077597369f1..951196bdf008 100644
> --- a/arch/arm/configs/s5pv210_defconfig
> +++ b/arch/arm/configs/s5pv210_defconfig
> @@ -1,24 +1,24 @@
>  CONFIG_SYSVIPC=3Dy
>  CONFIG_NO_HZ=3Dy
>  CONFIG_HIGH_RES_TIMERS=3Dy
> +CONFIG_PREEMPT=3Dy

This and few other look like effect of savedefconfig. Please split
such change to separate commit, before adding new features.

Best regards,
Krzysztof

>  CONFIG_CGROUPS=3Dy
>  CONFIG_SYSFS_DEPRECATED=3Dy
>  CONFIG_SYSFS_DEPRECATED_V2=3Dy
>  CONFIG_BLK_DEV_INITRD=3Dy
>  CONFIG_KALLSYMS_ALL=3Dy
> -CONFIG_MODULES=3Dy
> -CONFIG_MODULE_UNLOAD=3Dy
> -# CONFIG_BLK_DEV_BSG is not set
> -CONFIG_PARTITION_ADVANCED=3Dy
> -CONFIG_BSD_DISKLABEL=3Dy
> -CONFIG_SOLARIS_X86_PARTITION=3Dy
>  CONFIG_ARCH_S5PV210=3Dy
>  CONFIG_VMSPLIT_2G=3Dy
> -CONFIG_PREEMPT=3Dy
>  CONFIG_ARM_APPENDED_DTB=3Dy
>  CONFIG_CMDLINE=3D"root=3D/dev/ram0 rw ramdisk=3D8192 initrd=3D0x20800000=
,8M console=3DttySAC1,115200 init=3D/linuxrc"
>  CONFIG_VFP=3Dy
>  CONFIG_NEON=3Dy
> +CONFIG_MODULES=3Dy
> +CONFIG_MODULE_UNLOAD=3Dy
> +# CONFIG_BLK_DEV_BSG is not set
> +CONFIG_PARTITION_ADVANCED=3Dy
> +CONFIG_BSD_DISKLABEL=3Dy
> +CONFIG_SOLARIS_X86_PARTITION=3Dy
>  CONFIG_NET=3Dy
>  CONFIG_PACKET=3Dy
>  CONFIG_UNIX=3Dy
> @@ -27,6 +27,11 @@ CONFIG_IP_PNP=3Dy
>  CONFIG_IP_PNP_DHCP=3Dy
>  CONFIG_IP_PNP_BOOTP=3Dy
>  CONFIG_IP_PNP_RARP=3Dy
> +CONFIG_BT=3Dm
> +CONFIG_BT_RFCOMM=3Dy
> +CONFIG_BT_BNEP=3Dy
> +CONFIG_BT_HCIUART=3Dm
> +CONFIG_BT_HCIUART_BCM=3Dy
>  CONFIG_CFG80211=3Dm
>  CONFIG_MAC80211=3Dm
>  CONFIG_UEVENT_HELPER_PATH=3D"/sbin/hotplug"
> @@ -44,21 +49,35 @@ CONFIG_INPUT_EVDEV=3Dy
>  CONFIG_KEYBOARD_GPIO=3Dy
>  # CONFIG_INPUT_MOUSE is not set
>  CONFIG_INPUT_TOUCHSCREEN=3Dy
> +CONFIG_TOUCHSCREEN_ATMEL_MXT=3Dm
> +CONFIG_INPUT_MISC=3Dy
> +CONFIG_INPUT_PWM_VIBRA=3Dm
>  CONFIG_SERIAL_8250=3Dy
>  CONFIG_SERIAL_SAMSUNG=3Dy
>  CONFIG_SERIAL_SAMSUNG_CONSOLE=3Dy
> +CONFIG_SERIAL_DEV_BUS=3Dy
>  CONFIG_HW_RANDOM=3Dy
>  CONFIG_I2C_GPIO=3Dy
> +CONFIG_I2C_S3C2410=3Dy
> +CONFIG_POWER_RESET=3Dy
> +CONFIG_POWER_RESET_SYSCON_POWEROFF=3Dy
>  CONFIG_POWER_SUPPLY=3Dy
>  CONFIG_BATTERY_MAX17040=3Dy
>  # CONFIG_HWMON is not set
>  CONFIG_MFD_MAX8998=3Dy
>  CONFIG_REGULATOR=3Dy
> +CONFIG_REGULATOR_FIXED_VOLTAGE=3Dy
>  CONFIG_REGULATOR_MAX8998=3Dy
> +CONFIG_MEDIA_SUPPORT=3Dm
> +CONFIG_MEDIA_CAMERA_SUPPORT=3Dy
> +CONFIG_V4L_MEM2MEM_DRIVERS=3Dy
> +CONFIG_VIDEO_SAMSUNG_S5P_JPEG=3Dm
> +CONFIG_VIDEO_SAMSUNG_S5P_MFC=3Dm
>  CONFIG_DRM=3Dy
>  CONFIG_DRM_EXYNOS=3Dy
>  CONFIG_DRM_EXYNOS_FIMD=3Dy
>  CONFIG_DRM_EXYNOS_DPI=3Dy
> +CONFIG_DRM_EXYNOS_ROTATOR=3Dy
>  CONFIG_USB=3Dy
>  CONFIG_USB_OTG=3Dy
>  CONFIG_USB_EHCI_HCD=3Dy
> @@ -72,6 +91,9 @@ CONFIG_MMC_SDHCI_S3C=3Dy
>  CONFIG_MMC_SDHCI_S3C_DMA=3Dy
>  CONFIG_RTC_CLASS=3Dy
>  CONFIG_RTC_DRV_MAX8998=3Dm
> +CONFIG_DMADEVICES=3Dy
> +CONFIG_PWM=3Dy
> +CONFIG_PWM_SAMSUNG=3Dy
>  CONFIG_PHY_SAMSUNG_USB2=3Dm
>  CONFIG_PHY_S5PV210_USB2=3Dy
>  CONFIG_EXT2_FS=3Dy
> @@ -87,6 +109,7 @@ CONFIG_NLS_CODEPAGE_437=3Dy
>  CONFIG_NLS_ASCII=3Dy
>  CONFIG_NLS_ISO8859_1=3Dy
>  CONFIG_NLS_UTF8=3Dy
> +CONFIG_CRC_CCITT=3Dy
>  CONFIG_DEBUG_INFO=3Dy
>  CONFIG_MAGIC_SYSRQ=3Dy
>  CONFIG_DEBUG_KERNEL=3Dy
> @@ -96,7 +119,3 @@ CONFIG_DEBUG_SPINLOCK=3Dy
>  CONFIG_DEBUG_MUTEXES=3Dy
>  CONFIG_DEBUG_ATOMIC_SLEEP=3Dy
>  CONFIG_DEBUG_USER=3Dy
> -CONFIG_DEBUG_LL=3Dy
> -CONFIG_DEBUG_S3C_UART1=3Dy
> -CONFIG_EARLY_PRINTK=3Dy
> -CONFIG_CRC_CCITT=3Dy
> --
> 2.17.1
>
