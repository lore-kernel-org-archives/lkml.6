Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751677AbeA3KQC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 05:16:02 -0500
Received: from mail-qk0-f193.google.com ([209.85.220.193]:42568 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751411AbeA3KQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 05:16:00 -0500
X-Google-Smtp-Source: AH8x225tblFAgpkEc9P6xcLS8gHfzYYB3Jarfyi+5KKeBbHDxm9qJufTt+9h1uQafd8KCooJezlduX1QRzRjZq9uAhM=
MIME-Version: 1.0
In-Reply-To: <1516979499-3665-1-git-send-email-fabrice.gasnier@st.com>
References: <1516979499-3665-1-git-send-email-fabrice.gasnier@st.com>
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date: Tue, 30 Jan 2018 11:15:58 +0100
Message-ID: <CA+M3ks7Z+A--e5MTkARkHoDmAEhTyzE-_QaJ4HPd7O6CJrWm+Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] Add support for PWM input capture on STM32
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Benjamin GAIGNARD <benjamin.gaignard@st.com>,
        devicetree@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PWM List <linux-pwm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w0UAG7W2002800

2018-01-26 16:11 GMT+01:00 Fabrice Gasnier <fabrice.gasnier@st.com>:
> This series adds support for capture to stm32-pwm driver.
> Capture is based on DMAs.
> - First two patches are precursor patches
> - Subsequent two patches add support for requesting DMAs to MFD core
> - Next three patches add support for capture to stm32-pwm driver
> - This has been tested on stm32429i-eval board.
>
> ---
> Changes in v2:
> - Abstract DMA handling from child driver: move it to MFD core
> - Rework pwm capture routines to adopt this change
> - Comment on optional dma support, beautify DMAs probe

For this series:
Reviewed-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>

>
> Fabrice Gasnier (8):
>   pwm: stm32: fix, remove unused struct device
>   pwm: stm32: protect common prescaler for all channels
>   dt-bindings: mfd: stm32-timers: add support for dmas
>   mfd: stm32-timers: add support for dmas
>   pwm: stm32: add capture support
>   pwm: stm32: improve capture by tuning counter prescaler
>   pwm: stm32: use input prescaler to improve period capture
>   ARM: dts: stm32: Enable pwm3 input capture on stm32f429i-eval
>
>  .../devicetree/bindings/mfd/stm32-timers.txt       |  20 ++
>  arch/arm/boot/dts/stm32429i-eval.dts               |   3 +
>  drivers/mfd/stm32-timers.c                         | 215 +++++++++++++++-
>  drivers/pwm/pwm-stm32.c                            | 276 ++++++++++++++++++++-
>  include/linux/mfd/stm32-timers.h                   |  39 +++
>  5 files changed, 547 insertions(+), 6 deletions(-)
>
> --
> 1.9.1
>



-- 
Benjamin Gaignard

Graphic Study Group

Linaro.org │ Open source software for ARM SoCs

Follow Linaro: Facebook | Twitter | Blog
