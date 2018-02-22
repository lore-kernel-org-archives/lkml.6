Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932679AbeBVNyf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 08:54:35 -0500
Received: from mail-io0-f169.google.com ([209.85.223.169]:36784 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932414AbeBVNyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 08:54:32 -0500
X-Google-Smtp-Source: AG47ELuPugaHpqO73yIFJh1v5D2mKKM8XUM3CR6eMjFrRCt1C87ozrKBge4g4YoOVZlZCtijlZG4EN5zVGErEQsmc1s=
MIME-Version: 1.0
In-Reply-To: <1518100057-23234-5-git-send-email-amelie.delaunay@st.com>
References: <1518100057-23234-1-git-send-email-amelie.delaunay@st.com> <1518100057-23234-5-git-send-email-amelie.delaunay@st.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 22 Feb 2018 14:54:31 +0100
Message-ID: <CACRpkdZFrRXEBW6KnqZ=h_7BxYn-RaAzhP4ovwC_DQSbAGZCVw@mail.gmail.com>
Subject: Re: [PATCH 4/6] ARM: dts: stm32: add MFX support on I2C1 on stm32746g-eval
To: Amelie Delaunay <amelie.delaunay@st.com>
Cc: Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-gpio@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 8, 2018 at 3:27 PM, Amelie Delaunay <amelie.delaunay@st.com> wrote:

> MFX is used as gpio expander on stm32746g-eval.
>
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>

(...)
> +       mfx: mfx@42 {
> +               compatible = "st,mfx";
> +               reg = <0x42>;
> +               interrupts = <8 1>;
> +               interrupt-parent = <&gpioi>;
> +               interrupt-controller;
> +               #interrupt-cells = <1>;
> +
> +               mfxgpio: mfx_gpio {
> +                       compatible = "st,mfx-gpio";
> +                       interrupts = <0>;
> +                       interrupt-parent = <&mfx>;
> +                       gpio-controller;
> +                       #gpio-cells = <2>;

So I think this node should contain some pin config states
that can  be referenced by the drivers to set up push/pull
etc. Probably it can use just standard pin config properties
like sx150x.

Yours,
Linus Walleij
