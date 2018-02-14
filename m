Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030710AbeBNOZl (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 09:25:41 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:38311 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030308AbeBNOZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 09:25:38 -0500
X-Google-Smtp-Source: AH8x224W0ZcBQgw7Os7TStnBcUtd7sSyYj77TgAj4zVs4wVqr/IP4jF9FM1USSh6mVb+wYdkPI+3+hhZp+SC5RxtNVY=
MIME-Version: 1.0
In-Reply-To: <20180214135306.GA23932@w540>
References: <1518515162-23663-1-git-send-email-jacopo+renesas@jmondi.org>
 <1518515162-23663-5-git-send-email-jacopo+renesas@jmondi.org>
 <CAMuHMdUpEjnNa4kru7mUnvhTu2YoofoopuCvUp=AGdRJqfaNEw@mail.gmail.com> <20180214135306.GA23932@w540>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 14 Feb 2018 15:25:36 +0100
X-Google-Sender-Auth: FCZcq64C66VMtVlJRJwo9ww0ZyA
Message-ID: <CAMuHMdV60atVdYWisihSJwYJr_sxYFfj-ZRG=jA2e0fkHVAuSQ@mail.gmail.com>
Subject: Re: [PATCH 04/15] pinctrl: sh-pfc: Initial R-Car M3-N support
To: jacopo mondi <jacopo@jmondi.org>
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacopo,

On Wed, Feb 14, 2018 at 2:53 PM, jacopo mondi <jacopo@jmondi.org> wrote:
> On Wed, Feb 14, 2018 at 02:37:08PM +0100, Geert Uytterhoeven wrote:
>> On Tue, Feb 13, 2018 at 10:45 AM, Jacopo Mondi
>> <jacopo+renesas@jmondi.org> wrote:
>> > Add initial PFC support for R-Car M3-N (r8a77965) SoC.
>> > No groups or functions defined, just pin and registers enumeration.
>> >
>> > Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
>>
>> Thanks for your patch!
>>
>> Looks mostly OK to me.
>> You do want to compare with pfc-r8a7796.c: all differences not related to
>> SATA_DEVSL, FSCLK, DU_DOTCLKIN2/3, and PRESET are issues that were fixed
>> recently in pfc-r8a7796.c, and should apply to pfc-r8a77965.c, too.
>>
>
> I have used the M3-W tables with the exception of the pins/groups you
> mentioned, that are clearly marked as different in the datasheet. At
> least, this was my intention :)
>
> I used v4.15 M3-W PFC tables, should I look in v4.16-rc1 or in
> renesas-drivers for updates?

Always look at the latest version in my sh-pfc branch ;-)

>> That leaves us with very few differences only, but it won't be trivial to have
>> a combined M3-W/N PFC driver, I'm afraid.
>
> Takes a certain degree of grep-foo to clearly highlight differences
> between the two version. Do you have any script/tools you use to
> compare PFC tables a bit more easily?

The "--no-index" option of git diff allows to compare files against each
other, instead of against some other version.
Can be combined with wdiff:

$ git help wdiff
`git wdiff' is aliased to `diff --color-words'

soc-dts-diff (https://www.spinics.net/lists/linux-renesas-soc/msg22630.html)
also helps, even for drivers.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
