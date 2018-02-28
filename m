Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752490AbeB1Mg5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 07:36:57 -0500
Received: from regular1.263xmail.com ([211.150.99.135]:47942 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752377AbeB1Mgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 07:36:55 -0500
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: jeffy.chen@rock-chips.com
X-FST-TO: geert@linux-m68k.org
X-SENDER-IP: 103.29.142.67
X-LOGIN-NAME: jeffy.chen@rock-chips.com
X-UNIQUE-TAG: <6cabef9d3f383d469f5925a87edfb282>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Message-ID: <5A96A24E.80401@rock-chips.com>
Date: Wed, 28 Feb 2018 20:36:30 +0800
From: JeffyChen <jeffy.chen@rock-chips.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:19.0) Gecko/20130126 Thunderbird/19.0
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>, Heiko Stuebner <heiko@sntech.de>,
        Caesar Wang <wxt@rock-chips.com>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] soc: rockchip: power-domain: remove PM clocks
References: <20180228111113.13639-1-jeffy.chen@rock-chips.com> <CAMuHMdWLL9CxmxSLsqs1QX0dDHVhp4NrW4Me2EZaZE_bJ330bA@mail.gmail.com>
In-Reply-To: <CAMuHMdWLL9CxmxSLsqs1QX0dDHVhp4NrW4Me2EZaZE_bJ330bA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

Thanks for you reply.

On 02/28/2018 08:17 PM, Geert Uytterhoeven wrote:
> Hi Jeffy,
>
> On Wed, Feb 28, 2018 at 12:11 PM, Jeffy Chen <jeffy.chen@rock-chips.com> wrote:
>> Currently we are adding all of the attached devices' clocks as pm clocks
>> and enable them when powering on the power domain.
>>
>> This seems unnecessary, because those clocks are already controlled in
>> the devices' drivers with better error handling.
>>
>> Tested on my chromebook minnie(rk3288) and chromebook kevin(rk3399).
>>
>> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
>
> Thanks for your patch!
>
> Just wondering: so you prefer to handle the clocks explicitly in all drivers,
> instead of delegating this task to Runtime PM?
hmmm, i think we should control PM clks here, but not all clocks...at 
least some of the clocks are not required to be enabled while pd power 
on(waste power?).

and seems the drivers might have better control for error 
handling(decide to ignore or fail to probe or else).

also Runtime PM seems optional(could be disabled in config), and some 
devices(or even chips) don't have PM.

>
> Gr{oetje,eeting}s,
>
>                          Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                  -- Linus Torvalds
>
>
>
