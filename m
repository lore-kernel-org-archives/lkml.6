Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967910AbeCALyu (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 06:54:50 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:43407 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967800AbeCALyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 06:54:47 -0500
X-Google-Smtp-Source: AG47ELtyRdQDKpto3cqqOHyFgodJ1+VG8yZxo6PHE/Ymh5EtTC3TRnnCt/hEtNHCa8SsBkbjRa+fJQs4PvGcpTeC8lM=
MIME-Version: 1.0
In-Reply-To: <CAPDyKFrN0t6Jr-gAuU4_OHEvYap2fRiaUbZC5E7sAGAQOUQjjw@mail.gmail.com>
References: <20180228111113.13639-1-jeffy.chen@rock-chips.com>
 <CAMuHMdWLL9CxmxSLsqs1QX0dDHVhp4NrW4Me2EZaZE_bJ330bA@mail.gmail.com>
 <CAAFQd5CLXUwH6jTq9ZOpbYt9-Xx-+Kgj-Nk+KujS=Y=qLByc9Q@mail.gmail.com>
 <CAMuHMdWdVdregCRh17Jfa92csBruZvLzAK+M8uajif0BSJTcaw@mail.gmail.com>
 <CAAFQd5CpA_M821cMDtiEiWxw_rL--hQy6T6imz_c+fSi3gH9zw@mail.gmail.com>
 <CAMuHMdVVDiuv7bpdC0X95Xy9dSK_TfjW5RvSekVym9Q02798Fg@mail.gmail.com>
 <CAAFQd5C0GZ9C-pAqAdpuyxaF2xthLPY62a921nmABTbbmYtBmQ@mail.gmail.com>
 <5A977638.8010506@rock-chips.com> <CAMuHMdU9PFAXwo+1Z7Baw1fanst9yFKZ3ohoSTiQiMKTaYMVVw@mail.gmail.com>
 <CAPDyKFq_hwao0hZCYmO-VrsW3vDJJboa1RG-TMLRQRgbt+YhpQ@mail.gmail.com>
 <CAMuHMdWg1y3Ragb9nYY12whZhUn8w0a4aOOR31LSNXa37NbfXg@mail.gmail.com> <CAPDyKFrN0t6Jr-gAuU4_OHEvYap2fRiaUbZC5E7sAGAQOUQjjw@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 1 Mar 2018 12:54:46 +0100
X-Google-Sender-Auth: RGBiNSWknw4rAGLSsmcZosnauhk
Message-ID: <CAMuHMdVXWj8GCAFy66usSj-z_zeWgY3SyxvpenUKf9cc-ZWK5w@mail.gmail.com>
Subject: Re: [PATCH] soc: rockchip: power-domain: remove PM clocks
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: JeffyChen <jeffy.chen@rock-chips.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>, Heiko Stuebner <heiko@sntech.de>,
        Caesar Wang <wxt@rock-chips.com>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ulf,

On Thu, Mar 1, 2018 at 12:22 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 1 March 2018 at 11:37, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>> On Thu, Mar 1, 2018 at 11:18 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>> Another problem with the PM clk is, more exactly with
>>> pm_clk_suspend|resume(), that those invokes only clk_enable|disable().
>>> pm_clk_suspend|resume() can't call clk_prepare|unprepare(), because we
>>> don't know if we running in atomic context when those are executed.
>>> Potentially this means leaving the clocks ungated - all the time.
>>>
>>> I have though about how to fix the above, several times, but I always
>>> ends up with thinking that's it more easy, to let the driver deal with
>>> the clocks, as then the problem goes away.
>>
>> There's a similar issue with powering on/off power areas.
>
> I don't follow. Can you elaborate?

I intended to comment on the atomic context (or not).
But I think I was wrong, and PM domain drivers do busy loops instead
of sleeps.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
