Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB4ECC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60EAC25EA3
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:42:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f4ae74N4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60EAC25EA3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752388AbeGBOmz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 10:42:55 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:33215 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752176AbeGBOmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 10:42:52 -0400
Received: by mail-yw0-f196.google.com with SMTP id c135-v6so4892262ywa.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 07:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TC42JHQ7mxVcj1tOtgD3YLxOmGVn78o/FfT8P8bdQok=;
        b=f4ae74N4nmXkpmsic+gLILtgvtL/TrHA0kx7HYCdFBbKnJkZu4xNzE2xVBZ2F/iGle
         9ZWhHEnDI0EVFPSWqJ3O3MGWr6lLptovbH1Vt1tFtao74MOOThxv648xjSo7pYJxXas8
         YB4w4ZNhRs9IDdPr7SX7AAARocdsoZP2pKst7nG94gHVQj+FUykPJVLodtM5Q/4kOnsH
         iZJ77CIlogAjpWqHkvwXg05YQDQb/z8RI60C5w/W3i7ezyIItE7kkL06XsPtHnQb0IX3
         wsVpa9egv60ZDBvBoeJZXEo9ZkOScEeRD/8K1ADsmwi6Mirpp7kz2k2NYmTn2T7NCEHg
         /RQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TC42JHQ7mxVcj1tOtgD3YLxOmGVn78o/FfT8P8bdQok=;
        b=hn/bKuKaNnLeqcfATkdGVoLIwlg9mhIBLfIEwj2dxb2EuBDeAbnwU4kpXHrQYbeIG/
         cuvnj4TrREywxwYqKo+8mFDKV1wqKuMjn3dDL8nQSsfDrTgRBdTniMFNAP3PRb0IOsgk
         eE+M79FuAOFAVS5ukQREy6HH0x/Ha5KC6DOmK5sX1mX6GuDPeHiCFiAroX2RfbuT76Dn
         JQIHWuKjfs0TJcM8xsxXAyKqfEHo4XPQzH0I74Zx3pZ7sNu4wvNfFLdp5/akzFuwl3Nz
         C8ksAgwLAFQaZnS8+hK/7x8krXtg2OFX5qfxbuxMb8BWXFojEglIUzEgsv5XTks5WNXv
         fAWA==
X-Gm-Message-State: APt69E0HMAYKHidRkQhyUEImFAeltaNdEy9azVo/WRuxrr9pfWPQRFja
        UoVSpSyo2We5CAxcpGNRDCvtvPXRODP/94vRSiwGMA==
X-Google-Smtp-Source: AAOMgpcnD1viqVSn48StDnm+VSHJN7f0tuwVQnfPVcdAXRJIccbbvNbdx2f03xSc8VzRXJ3WHWj9AHYERvtEMpESSgw=
X-Received: by 2002:a81:6f87:: with SMTP id k129-v6mr1460786ywc.232.1530542571384;
 Mon, 02 Jul 2018 07:42:51 -0700 (PDT)
MIME-Version: 1.0
References: <20180702102201.13461-1-enric.balletbo@collabora.com> <20180702102201.13461-3-enric.balletbo@collabora.com>
In-Reply-To: <20180702102201.13461-3-enric.balletbo@collabora.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Mon, 2 Jul 2018 07:42:40 -0700
Message-ID: <CABXOdTfj3d2S0WA93zimry46mNLnGKLTidPTnsjaCuLfhuEnGw@mail.gmail.com>
Subject: Re: [PATCH 2/3] arm/arm64: configs: Remove the MFD_ prefix for
 MFD_CROS_EC_I2C/SPI symbols.
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Russell King - ARM Linux <linux@armlinux.org.uk>, kgene@kernel.org,
        krzk@kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Olof Johansson <olof@lixom.net>,
        Gwendal Grignou <gwendal@chromium.org>,
        linux-samsung-soc@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        kernel@collabora.com, linux-arm-kernel@lists.infradead.org,
        bjorn.andersson@linaro.org, Arnd Bergmann <arnd@arndb.de>,
        gregory.clement@bootlin.com, ard.biesheuvel@linaro.org,
        miquel.raynal@bootlin.com, geert+renesas@glider.be,
        linux.amoon@gmail.com, stefan@agner.ch, amit.kucheria@linaro.org,
        martin.blumenstingl@googlemail.com, shuah@kernel.org,
        andy.gross@linaro.org, horms+renesas@verge.net.au,
        m.szyprowski@samsung.com, lukas@wunner.de,
        Tony Lindgren <tony@atomide.com>, xuwei5@hisilicon.com,
        boris.brezillon@bootlin.com, marc.zyngier@arm.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 2, 2018 at 3:22 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> The cros-ec I2C and SPI transport drivers have been moved from MFD
> subsystem to platform/chrome, at the same time, the config symbol has
> been renamed and lost the MFD_ prefix, so update all configs to the new
> config symbol name.
>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>
>  arch/arm/configs/exynos_defconfig   | 4 ++--
>  arch/arm/configs/multi_v7_defconfig | 4 ++--
>  arch/arm/configs/pxa_defconfig      | 4 ++--
>  arch/arm64/configs/defconfig        | 4 ++--
>  4 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
> index 85b2369d6b20..27ea6dfcf2f2 100644
> --- a/arch/arm/configs/exynos_defconfig
> +++ b/arch/arm/configs/exynos_defconfig
> @@ -155,8 +155,8 @@ CONFIG_THERMAL_EMULATION=y
>  CONFIG_WATCHDOG=y
>  CONFIG_S3C2410_WATCHDOG=y
>  CONFIG_MFD_CROS_EC=y
> -CONFIG_MFD_CROS_EC_I2C=y
> -CONFIG_MFD_CROS_EC_SPI=y
> +CONFIG_CROS_EC_I2C=y
> +CONFIG_CROS_EC_SPI=y
>  CONFIG_MFD_MAX14577=y
>  CONFIG_MFD_MAX77686=y
>  CONFIG_MFD_MAX77693=y
> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index 8f6be1982545..be732f382418 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -490,8 +490,8 @@ CONFIG_MFD_AC100=y
>  CONFIG_MFD_AXP20X_I2C=y
>  CONFIG_MFD_AXP20X_RSB=y
>  CONFIG_MFD_CROS_EC=m
> -CONFIG_MFD_CROS_EC_I2C=m
> -CONFIG_MFD_CROS_EC_SPI=m
> +CONFIG_CROS_EC_I2C=m
> +CONFIG_CROS_EC_SPI=m
>  CONFIG_MFD_DA9063=m
>  CONFIG_MFD_MAX14577=y
>  CONFIG_MFD_MAX77686=y
> diff --git a/arch/arm/configs/pxa_defconfig b/arch/arm/configs/pxa_defconfig
> index 5655a1cee87d..6bb506edb1f5 100644
> --- a/arch/arm/configs/pxa_defconfig
> +++ b/arch/arm/configs/pxa_defconfig
> @@ -398,8 +398,8 @@ CONFIG_MFD_AS3711=y
>  CONFIG_MFD_BCM590XX=m
>  CONFIG_MFD_AXP20X=y
>  CONFIG_MFD_CROS_EC=m
> -CONFIG_MFD_CROS_EC_I2C=m
> -CONFIG_MFD_CROS_EC_SPI=m
> +CONFIG_CROS_EC_I2C=m
> +CONFIG_CROS_EC_SPI=m
>  CONFIG_MFD_ASIC3=y
>  CONFIG_PMIC_DA903X=y
>  CONFIG_HTC_EGPIO=y
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index f9a186f6af8a..3ec0feccdd62 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -372,8 +372,8 @@ CONFIG_UNIPHIER_WATCHDOG=y
>  CONFIG_BCM2835_WDT=y
>  CONFIG_MFD_AXP20X_RSB=y
>  CONFIG_MFD_CROS_EC=y
> -CONFIG_MFD_CROS_EC_I2C=y
> -CONFIG_MFD_CROS_EC_SPI=y
> +CONFIG_CROS_EC_I2C=y
> +CONFIG_CROS_EC_SPI=y
>  CONFIG_MFD_CROS_EC_CHARDEV=m
>  CONFIG_MFD_EXYNOS_LPASS=m
>  CONFIG_MFD_HI6421_PMIC=y
> --
> 2.18.0
>
