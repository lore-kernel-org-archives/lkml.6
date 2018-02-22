Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932734AbeBVOBe (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 09:01:34 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:37918 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932643AbeBVOBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 09:01:32 -0500
X-Google-Smtp-Source: AG47ELsBRIq8aSaqXAVVVfoMRTR07QDKB2+hl7HO9tmmS0/xLYZA2XfvoKuZ7cFdFGX4wht60zM6WObweZOKjuQ21Qs=
MIME-Version: 1.0
In-Reply-To: <20180211200847.25000-7-marcus.folkesson@gmail.com>
References: <20180211200847.25000-1-marcus.folkesson@gmail.com> <20180211200847.25000-7-marcus.folkesson@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 22 Feb 2018 15:01:30 +0100
Message-ID: <CACRpkdZzw+3DPvS7VOUzghmSgDTgDeCZ2i+FE=DCE+R5i1qycQ@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] watchdog: coh901327: make use of timeout-secs
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

On Sun, Feb 11, 2018 at 9:08 PM, Marcus Folkesson
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
> Notes:
>     v3:
>         - Reformat and use coh901327_wdt.timeout instead of margin when print out
>           timout in probe function.
>
>     v2:
>         - Set .timeout in coh901327_wdt structure declaration.
>         - Set .min_timeout to 1 instead of 0. I could not find a datasheet
>           for coh901327, so I'm not sure if 0 is valid. However, 0 seems
>           wrong to me and most driver has 1 as min value. If it should
>           be 0, please let me know and I have to set another initial
>           value for margin.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
