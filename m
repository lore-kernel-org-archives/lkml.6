Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932721AbeBVOAv (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 09:00:51 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:37858 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932582AbeBVOAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 09:00:49 -0500
X-Google-Smtp-Source: AG47ELvj+rrzlqKWJG5SHrNtxHpO8owNsuG/2yPO8Fo5djULuHMmKFeUQkpHrm55PojMFK2O2FBUecTgMMj56ujOnV0=
MIME-Version: 1.0
In-Reply-To: <20180210091911.3644-7-marcus.folkesson@gmail.com>
References: <20180210091911.3644-1-marcus.folkesson@gmail.com> <20180210091911.3644-7-marcus.folkesson@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 22 Feb 2018 15:00:47 +0100
Message-ID: <CACRpkdbhm5s8tcF8vBeDVdzFbgo-L_BJk=76Qv=m5WNBdSbRhA@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] watchdog: coh901327: make use of timeout-secs
 provided in devicetree
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Barry Song <baohua@kernel.org>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support"
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 10, 2018 at 10:19 AM, Marcus Folkesson
<marcus.folkesson@gmail.com> wrote:

> watchdog_init_timeout() will allways pick timeout_param since it
> defaults to a valid timeout.
>
> Following best practice described in
> Documentation/watchdog/watchdog-kernel-api.txt to make use of
> the parameter logic.
>
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> ---
>
> v2:
>         - Set .timeout in coh901327_wdt structure declaration.
>         - Set .min_timeout to 1 instead of 0. I could not find a datasheet
>           for coh901327, so I'm not sure if 0 is valid. However, 0 seems
>                   wrong to me and most driver has 1 as min value. If it should
>                   be 0, please let me know and I have to set another initial
>                   value for margin.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
