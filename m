Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752018AbeCCJe4 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Mar 2018 04:34:56 -0500
Received: from mail-ua0-f170.google.com ([209.85.217.170]:37497 "EHLO
        mail-ua0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751894AbeCCJey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Mar 2018 04:34:54 -0500
X-Google-Smtp-Source: AG47ELsYRQNKflwCS864XXtCV3WTb0J0KLLZ2SfAzl+QZYL0JIm6Oxkyu9NJR2pS6iPm2MeLkn/fQSNw35rcF3QqUE8=
MIME-Version: 1.0
In-Reply-To: <CAB=NE6V+5MK-ytS+-QBppSBLz7T4hRQV8eMA2Vv9-crcbj7NYg@mail.gmail.com>
References: <1519965121-12017-1-git-send-email-yamada.masahiro@socionext.com>
 <1519965121-12017-10-git-send-email-yamada.masahiro@socionext.com>
 <CAFkk2KQTjnTLkBx_8jXLejxVJLHV6gijN0_MCYDwbsL+KNkp=w@mail.gmail.com> <CAB=NE6V+5MK-ytS+-QBppSBLz7T4hRQV8eMA2Vv9-crcbj7NYg@mail.gmail.com>
From: Ulf Magnusson <ulfalizer@gmail.com>
Date: Sat, 3 Mar 2018 10:34:53 +0100
Message-ID: <CAFkk2KT70V-bKpUKi_pczO30bh7mAfSPPxghvESG16_CuXJpWg@mail.gmail.com>
Subject: Re: [PATCH v2 09/11] kconfig: unittest: test randconfig for choice in choice
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 2, 2018 at 10:29 PM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
>
>
> On Fri, Mar 2, 2018, 3:14 AM Ulf Magnusson <ulfalizer@gmail.com> wrote:
>>
>> On Fri, Mar 2, 2018 at 5:31 AM, Masahiro Yamada
>> > This is complicated usage, but it is still used in the real world;
>> > drivers/usb/gadget/legacy/Kconfig is source'd in a choice context,
>> > then creates a sub-choice in it.
>>
>> That file is the only one that does all that weird choice stuff btw.
>>
>> It's as if it was written to make use of as much obscure Kconfig stuff
>> as possible. :P
>
>
> Can't we just use another way to describe this requirement on this file,
> with the trade-off of simplifying kconfig semantics?
>
>   Luis

I don't think changing how drivers/usb/gadget/legacy/Kconfig does
things would allow for any simplifications, unfortunately (except to
get rid of the fix tested by this patch, maybe).

Being able to have non-choice-value symbols and choices in choices is
a side effect of automatic submenu creation. Symbols and choices that
depend on the symbol before them end up in a submenu, and only the
top-level symbols in the choice are marked as choice value symbols.

I always wondered whether that was an intended feature or just
something people discovered works (it seems to work anyway...). It
feels pretty iffy to have cosmetic submenus affect behavior like that,
but playing devil's advocate, it kinda makes sense to put symbols
close to the symbols they depend on if you can get away with it.

Cheers,
Ulf
