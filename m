Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753669AbeDTG2c (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 02:28:32 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:32831 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751254AbeDTG23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 02:28:29 -0400
X-Google-Smtp-Source: AIpwx48HaTPondZXVXwuLfzZWYGAvLqrJmw0pmmnu832poptlxzG32W9EFbLIQwEoF17A7wbPOQ4ysxgW2LlwY+ZhFk=
MIME-Version: 1.0
In-Reply-To: <152417672470.46528.14790019208345640453@swboyd.mtv.corp.google.com>
References: <1524063005-1716-1-git-send-email-geert+renesas@glider.be>
 <1524063005-1716-2-git-send-email-geert+renesas@glider.be> <152417672470.46528.14790019208345640453@swboyd.mtv.corp.google.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 20 Apr 2018 08:28:28 +0200
X-Google-Sender-Auth: 7BYFx3cA8evub-LVj59WwZFp35E
Message-ID: <CAMuHMdUX9dJcGLgftAAeCOXYxKUOQ_dW7=oLwNt5VRbd6nQpuA@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] clk: Extract OF clock helpers in <linux/of_clk.h>
To: Stephen Boyd <sboyd@kernel.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Linus Walleij <linus.walleij@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-tegra@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen, Rob,

On Fri, Apr 20, 2018 at 12:25 AM, Stephen Boyd <sboyd@kernel.org> wrote:
> Quoting Geert Uytterhoeven (2018-04-18 07:50:01)
>> The use of of_clk_get_parent_{count,name}() and of_clk_init() is not
>> limited to clock providers.
>>
>> Hence move these helpers into their own header file, so callers that are
>> not clock providers no longer have to include <linux/clk-provider.h>.
>>
>> Suggested-by: Stephen Boyd <sboyd@kernel.org>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
>> ---
>> v3:
>>   - Add Reviewed-by,
>>   - Add SPDX-License-Identifier,
>>   - Add to clock section in MAINTAINERS (note that Rob is still listed
>>     as a maintainer, too, due to the include/linux/of*.h catch-all
>>     rule),
>
> Can you X: out this file so Rob is happy? Or that doesn't work?

I guess that should work.

My point here is that due to the catch-all rule, he's listed as maintainer
for of_{dma,gpio,irq,iommu,mdio,net,pci} too, which are all helpers for
other subsystems. Perhaps these should be X'd-out too?
Or is it OK without X-ing them out, as the clock maintainers are now shown, too?

Rob: What's your preference?

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
