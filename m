Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932629AbeBVNwt (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 08:52:49 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:45468 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932491AbeBVNwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 08:52:46 -0500
X-Google-Smtp-Source: AG47ELsTnV93Kq+VSp3svv5IayaBkqOIxj41+KDf9DZwFWqEW4wFkSfceW7hLrQ3mi2uIhNb1naShPHQhqdq+tlwIiI=
MIME-Version: 1.0
In-Reply-To: <1518100057-23234-6-git-send-email-amelie.delaunay@st.com>
References: <1518100057-23234-1-git-send-email-amelie.delaunay@st.com> <1518100057-23234-6-git-send-email-amelie.delaunay@st.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 22 Feb 2018 14:52:45 +0100
Message-ID: <CACRpkdbaFpLNdxZThVTO5V4y8wzekVpXoFJ_6EOOsKCD_h59cA@mail.gmail.com>
Subject: Re: [PATCH 5/6] ARM: dts: stm32: add joystick support on stm32746g-eval
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

Hi Amelie,

thanks for your patch.

On Thu, Feb 8, 2018 at 3:27 PM, Amelie Delaunay <amelie.delaunay@st.com> wrote:

> The joystick on stm32746g-eval uses gpios on MFX gpio expander.
>
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
(...)
> +       joystick {
> +               compatible = "gpio-keys";
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               button@1 {
> +                       label = "JoySel";
> +                       linux,code = <KEY_ENTER>;
> +                       gpios = <&mfxgpio 0 (GPIO_ACTIVE_LOW | GPIO_IN_PUSH_PULL | GPIO_PULL_UP)>;
> +               };

As I think this should not all be handled by GPIO, the joystick on
gpio-keys needs a pin control handle pointing back to pin control
states on the respective pins in the pin control/GPIO driver,
where it can set up these properties.

For the individual lines the pushing and pulling flags should be
removed.

Yours,
Linus Walleij
