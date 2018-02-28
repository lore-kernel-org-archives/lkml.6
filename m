Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752614AbeB1OIJ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 09:08:09 -0500
Received: from mail-vk0-f43.google.com ([209.85.213.43]:41425 "EHLO
        mail-vk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752241AbeB1OII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 09:08:08 -0500
X-Google-Smtp-Source: AG47ELthTVCFYG2mRsww5RMwajqLiZZh48JVdyUMpR/Rt34VKkc84g/eszQn9ZMRU3MGV4YDWtTOoQ==
MIME-Version: 1.0
In-Reply-To: <CAMuHMdVVDiuv7bpdC0X95Xy9dSK_TfjW5RvSekVym9Q02798Fg@mail.gmail.com>
References: <20180228111113.13639-1-jeffy.chen@rock-chips.com>
 <CAMuHMdWLL9CxmxSLsqs1QX0dDHVhp4NrW4Me2EZaZE_bJ330bA@mail.gmail.com>
 <CAAFQd5CLXUwH6jTq9ZOpbYt9-Xx-+Kgj-Nk+KujS=Y=qLByc9Q@mail.gmail.com>
 <CAMuHMdWdVdregCRh17Jfa92csBruZvLzAK+M8uajif0BSJTcaw@mail.gmail.com>
 <CAAFQd5CpA_M821cMDtiEiWxw_rL--hQy6T6imz_c+fSi3gH9zw@mail.gmail.com> <CAMuHMdVVDiuv7bpdC0X95Xy9dSK_TfjW5RvSekVym9Q02798Fg@mail.gmail.com>
From: Tomasz Figa <tfiga@chromium.org>
Date: Wed, 28 Feb 2018 23:07:44 +0900
X-Gmail-Original-Message-ID: <CAAFQd5C0GZ9C-pAqAdpuyxaF2xthLPY62a921nmABTbbmYtBmQ@mail.gmail.com>
Message-ID: <CAAFQd5C0GZ9C-pAqAdpuyxaF2xthLPY62a921nmABTbbmYtBmQ@mail.gmail.com>
Subject: Re: [PATCH] soc: rockchip: power-domain: remove PM clocks
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jeffy Chen <jeffy.chen@rock-chips.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>, Heiko Stuebner <heiko@sntech.de>,
        Caesar Wang <wxt@rock-chips.com>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 28, 2018 at 10:11 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Hi Tomasz,
>
> On Wed, Feb 28, 2018 at 1:49 PM, Tomasz Figa <tfiga@chromium.org> wrote:
>> On Wed, Feb 28, 2018 at 9:32 PM, Geert Uytterhoeven
>> <geert@linux-m68k.org> wrote:
>>> On Wed, Feb 28, 2018 at 1:29 PM, Tomasz Figa <tfiga@chromium.org> wrote:
>>>> Also, how about systems where runtime PM is disabled? I think that's
>>>> one of the reasons we control the clocks explicitly in the drivers
>>>> anyway.
>>>
>>> On many platforms, Runtime PM is always enabled.
>>
>> Can we make such assumption? If so, could we just make an explicit
>> "select PM_RUNTIME" in Kconfig of the SoC?
>
> Note that the PM_RUNTIME symbol was removed in commit 464ed18ebdb6236f
> ("PM: Eliminate CONFIG_PM_RUNTIME"), in favor of plain PM.
>
> The following already select PM unconditionally:
>   - ARCH_OMAP2PLUS_TYPICAL
>   - ARCH_RENESAS (except EMEV2)
>   - ARCH_TEGRA
>   - ARCH_VEXPRESS

Thanks! Sounds like we might be able to simplify a lot of things with
doing the same for Rockchip.

Best regards,
Tomasz
