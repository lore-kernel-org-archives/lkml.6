Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98ECEC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70F5E21900
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:06:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730595AbfBRMGl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 07:06:41 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45154 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730538AbfBRMGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 07:06:40 -0500
Received: by mail-qk1-f194.google.com with SMTP id y195so9757948qka.12
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 04:06:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AWJkRh6siUdGaDmneKWnVivvtFst5oz85CoGO/1XMWE=;
        b=IZ4PdNiTjl8McXr81SUC5Eq0CHfJXxcSYwVoaLbMG4aXWyEGlFdM3zpADx/a33Fud4
         bk0Q7L+H+8cL1g+TLdXu0r38F/JRr2pYhd6yE3fblzxUcatSKA0gWum5rv9gp0igMxbn
         s/CKCpuKp8jzadSH8iPMaSaBxCAQ4aIE4PWVnREW0DymneNhra5YRqcvUOKf3BH6FbLA
         Ga5Y0JCkAbpzlV1hXUtNHSHEpg9TkaB/Ij8RksZ1jZ/gTT2ADfXcg2u9njkvgt7qnIFa
         FzYk/UsDNZA8bR5qZyn2VCFc9HnTMuyAobS5W0oaWRkM+yQyzo3Fb9XJ7caklYHfFQd0
         WaAA==
X-Gm-Message-State: AHQUAub8zTKM+vR2uKbPGJxPgSDspn4VQj1CCRiBHwtHrZ932u6LmJ7a
        Kg5TchOYIJUk7Httg+y5Dp7U8GB//gYsY+8rQr0=
X-Google-Smtp-Source: AHgI3IZ3yzAzSfG2LJnG0Gb52oIjA4zipv/djAobQ/3q1IVEMYVZ6oA+iYxfS/OPByfH6OrZrMtKO8hVXx7u4Bp8IAI=
X-Received: by 2002:a37:bdc6:: with SMTP id n189mr15950708qkf.330.1550491599524;
 Mon, 18 Feb 2019 04:06:39 -0800 (PST)
MIME-Version: 1.0
References: <1549628937-363-1-git-send-email-sugaya.taichi@socionext.com>
In-Reply-To: <1549628937-363-1-git-send-email-sugaya.taichi@socionext.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 18 Feb 2019 13:06:21 +0100
Message-ID: <CAK8P3a1+w=VWkFWBRnzBEVb389Od25pwGANtZR0DLTF0NfV-NQ@mail.gmail.com>
Subject: Re: [PATCH v2 14/15] ARM: configs: Add Milbeaut M10V defconfig
To:     Sugaya Taichi <sugaya.taichi@socionext.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Takao Orito <orito.takao@socionext.com>,
        Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
        Shinji Kanematsu <kanematsu.shinji@socionext.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 8, 2019 at 1:30 PM Sugaya Taichi
<sugaya.taichi@socionext.com> wrote:
>
> This patch adds the minimal defconfig for the Milbeaut M10V.
>
> Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
> ---
>  arch/arm/configs/milbeaut_m10v_defconfig | 366 +++++++++++++++++++++++++++++++
>  1 file changed, 366 insertions(+)


I think it would be good to reduce this a little bit. Please also add any
options you need for booting to multi_v7_defconfig. Device drivers you
don't need for booting but for additional features should be loadable
modules there.

> +CONFIG_KALLSYMS_ALL=y
> +CONFIG_EMBEDDED=y

CONFIG_EMBEDDED should not normally be set on device
configurations. Despite the name it's not something for general
embedded computing, but it's rather an option that lets you
turn other option that one should normally not have to change.

> +CONFIG_PROFILING=y
> +CONFIG_OPROFILE=m

Oprofile is rarely used these days, maybe change the default to
PERF_EVENTS=y?

> +CONFIG_HAVE_ARM_ARCH_TIMER=y
> +CONFIG_VMSPLIT_2G=y
> +CONFIG_PREEMPT=y
> +CONFIG_THUMB2_KERNEL=y

I think this will be the first armv8-a platform with thumb2 by default,
and it's probably a good thing to start testing that more.

> +CONFIG_HIGHMEM=y

It's unusual to have both VMSPLIT_2G and HIGHMEM.

> +CONFIG_ARM_APPENDED_DTB=y

If you are able to fix the boot loaders, this should be turned off

> +CONFIG_NL80211_TESTMODE=y
> +CONFIG_CFG80211_DEVELOPER_WARNINGS=y
> +CONFIG_CFG80211_REG_DEBUG=y

That seems like more debugging that you should need.

> +# CONFIG_I2C is not set
> +# CONFIG_I2C_BOARDINFO is not set
> +# CONFIG_I2C_COMPAT is not set
> +# CONFIG_I2C_CHARDEV is not set
> +# CONFIG_I2C_MUX is not set
> +# CONFIG_I2C_HELPER_AUTO is not set
> +# CONFIG_I2C_ALGOBIT is not set
> +# CONFIG_I2C_SNI_M10V is not set

If I2C is disabled, you shoulnd't need any of the later
options here.

> +CONFIG_FB=y
> +# CONFIG_VGA_ARB is not set

Since you don't have a framebuffer driver, and likely won't
add one (new drivers should use drivers/gpu/drm), I'd drop
this.

> +# CONFIG_USB is not set
> +# CONFIG_USB_ANNOUNCE_NEW_DEVICES is not set
> +# CONFIG_USB_MON is not set
> +# CONFIG_USB_XHCI_HCD is not set
> +# CONFIG_USB_EHCI_HCD is not set
> +# CONFIG_USB_EHCI_ROOT_HUB_TT is not set
...
> +# CONFIG_MMC is not set
> +# CONFIG_MMC_SDHCI is not set
> +# CONFIG_MMC_SDHCI_PLTFM is not set
> +# CONFIG_MMC_SDHCI_F_SDH30 is not set
> +# CONFIG_MMC_SDHCI_F_EMMC50 is not set

Also for USB and MMC: if you don't have the subsystem, you
should not need to list the other options.

> +CONFIG_NEW_LEDS=y
> +CONFIG_LEDS_CLASS=y
> +CONFIG_LEDS_GPIO=y
> +CONFIG_LEDS_TRIGGER_TIMER=y
> +CONFIG_LEDS_TRIGGER_HEARTBEAT=y
> +CONFIG_RTC_CLASS=y
> +# CONFIG_RTC_HCTOSYS is not set
> +# CONFIG_RTC_SYSTOHC is not set
> +CONFIG_RTC_DEBUG=y
> +CONFIG_RTC_DRV_RX8025=y
> +CONFIG_DMADEVICES=y
> +CONFIG_MB86S7X_HDMAC=y
> +CONFIG_MB8AC0300_XDMAC=y
> +CONFIG_UIO=y
> +CONFIG_UIO_SNI=y
> +# CONFIG_IOMMU_SUPPORT is not set
> +#CONFIG_PWM=y is not set
> +# CONFIG_PWM_SYSFS is not set
> +#CONFIG_PWM_M10V=y is not set
> +CONFIG_RESET_CONTROLLER=y
> +CONFIG_EXFAT=y

CONFIG_EXFAT does not exist in mainline kernels.

> +CONFIG_IPCU_FS=y
> +# CONFIG_TEST_IPCU_FS is not set

same for IPCU_FS, and probably a lot of other options.

        Arnd
