Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933006AbeBVPaT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 10:30:19 -0500
Received: from mail-it0-f47.google.com ([209.85.214.47]:56094 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932972AbeBVPaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 10:30:14 -0500
X-Google-Smtp-Source: AG47ELva+uGxuLdzOANtCutObHBAfAJ8qHfdj9NMBJRHZeCOgbn/3PSgqTRN8SjOQyHBF+hZRbkm1BFLOYXvjkbaQnI=
MIME-Version: 1.0
In-Reply-To: <86o9kkdbr3.wl-marc.zyngier@arm.com>
References: <20170301183257.6554-1-f.fainelli@gmail.com> <83d6bd0da9254d868d3f713bd3bc282c@www.loen.fr>
 <913ED32F-36F8-4F31-9221-263DD5599FB2@gmail.com> <3136391.js9qjGvjLN@phil> <86o9kkdbr3.wl-marc.zyngier@arm.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 22 Feb 2018 16:30:13 +0100
Message-ID: <CACRpkdZhMN-ZaVaveWPyrh03M1QveWP_6M+oQ5Bj=aZ3V_3u0Q@mail.gmail.com>
Subject: Re: [PATCH fixes v3] pinctrl: Really force states during suspend/resume
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stephen Warren <swarren@nvidia.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Al Cooper <alcooperx@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 19, 2018 at 8:23 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>> Am Montag, 19. Februar 2018, 19:03:27 CET schrieb Florian Fainelli:

>> > Can you indicate which DTS file is used for your Chromebook model? Sorry about the breakage.
>>
>> that should be
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts
>>
>> I'm vacationing right now, so don't think I'll find time to dive into
>> Rockchip pinctrl this week. But I'd guess it could be somehow
>> related to the ATF touching pins during suspend/resume?
>
> That'd be really unfortunate. I would have assumed that ATF would
> leave things as they were instead of re-configuring them to whatever
> default.
>
> The most annoying thing is that if that's indeed the case, we need to
> find a solution that will cope with the current state of the
> firmware. I guess that'd mean eagerly saving/restoring the pin state
> across suspend/resume, irrespective of what firmware could do?

What is ATF? Asus Touch Firmware?

Does it in effect mean that when the Rockchip pinctrl driver
says pinctrl_force_sleep() and pinctrl_force_default()
it expects those to be a noop?

Then the real patch to apply is something deleting the
pinctrl_force* calls from the pinctrl-rockchip driver,
is it not?

Yours,
Linus Walleij
