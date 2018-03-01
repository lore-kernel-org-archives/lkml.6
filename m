Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966661AbeCAJGq (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 04:06:46 -0500
Received: from mail-io0-f182.google.com ([209.85.223.182]:34036 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966604AbeCAJGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 04:06:30 -0500
X-Google-Smtp-Source: AG47ELvrKJ87EHk+gSpz9slQi416qNAM9dZDC3qyikWiizR0PRddE4u++W/usjZ0XHsofo7ehMJSX2fz+jwkuSNRAC4=
MIME-Version: 1.0
In-Reply-To: <1519832844-28068-1-git-send-email-ludovic.Barre@st.com>
References: <1519832844-28068-1-git-send-email-ludovic.Barre@st.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 1 Mar 2018 10:06:28 +0100
Message-ID: <CAPDyKFpfPAaLRZLqpyi6RwC1-=7Ao=u+OmEfHaYBABzd_-BKAw@mail.gmail.com>
Subject: Re: [PATCH V2 0/5] mmc: add stm32 sdmmc controller
To: Ludovic Barre <ludovic.Barre@st.com>
Cc: Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Gerald Baeza <gerald.baeza@st.com>,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ludovic,

On 28 February 2018 at 16:47, Ludovic Barre <ludovic.Barre@st.com> wrote:
> From: Ludovic Barre <ludovic.barre@st.com>
>
> This patch serie adds support of stm32 SDMMC controller.
> stm32h7 is the first SoC to use stm32 SDMMC controller
> (previous SoC had pl180 controller).

I am a not convinced this isn't a new improved variant of the pl180.
According to register layout and the code you submitted in patch2,
there are great similarities to pl180 and the mmci driver.

In other words, it more sounds like an improved variant of pl180,
hence I am thinking that you should try to extend the mmci driver
instead. Could you please have a look at that, unless you can specify
more exactly why that isn't suitable?

>
> The SDMMC features include the following:
> -Full compliance with MultiMediaCard System Specification Version 4.51.
>  Card support for three different databus modes:
>  1-bit (default), 4-bit and 8-bit.
> -Full compliance with SD memory card specifications version 4.1.
>  SDR104 speed limited to maximum allowed I/O speed, SPI mode and
>  UHS-II mode not supported.
> -Full compliance with SDIO card specification version 4.0.
>
> change V2:
> -dt-bindings: properties name
> st,dir-output-high; st,neg-edge; st,use-ckin
> -dt-bindings: node example s/sdmmc@/mmc@/g
> -removes return of enable/disable_imask functions
> -adds dev_warn if clk divisor is too short.
> -replaces overprotection of n_elem by fail of dma_map_sg
> -removes shortcut host->base
> -Use device_property_present
>
> Ludovic Barre (5):
>   dt-bindings: mmc: document the stm32 sdmmc bindings
>   mmc: add stm32 sdmmc controller driver
>   ARM: dts: stm32: add sdmmc support for stm32h743
>   ARM: dts: stm32: add sdmmc1 support for stm32h743i-eval
>   ARM: configs: stm32: add mmc and ext2/3/4 support
>
>  .../devicetree/bindings/mmc/st,stm32-sdmmc.txt     |  35 +
>  arch/arm/boot/dts/stm32h743-pinctrl.dtsi           |  26 +
>  arch/arm/boot/dts/stm32h743.dtsi                   |  26 +
>  arch/arm/boot/dts/stm32h743i-eval.dts              |  11 +
>  arch/arm/configs/stm32_defconfig                   |   4 +-
>  drivers/mmc/host/Kconfig                           |   8 +
>  drivers/mmc/host/Makefile                          |   1 +
>  drivers/mmc/host/stm32-sdmmc.c                     | 708 +++++++++++++++++++++
>  drivers/mmc/host/stm32-sdmmc.h                     | 220 +++++++
>  9 files changed, 1038 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/mmc/st,stm32-sdmmc.txt
>  create mode 100644 drivers/mmc/host/stm32-sdmmc.c
>  create mode 100644 drivers/mmc/host/stm32-sdmmc.h
>
> --
> 2.7.4
>

Kind regards
Uffe
