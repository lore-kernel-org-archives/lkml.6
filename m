Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752542AbeEVDMh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 23:12:37 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:52385 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751746AbeEVDMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 23:12:33 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w4M3CNJP024209
X-Nifty-SrcIP: [209.85.213.41]
X-Google-Smtp-Source: AB8JxZpoe/NUuGybhE6YFbwSJAeki4HNp5uQ9VEK6aE6WyDqCnME1UqXB8RqmPg9peOAjH4FIewZ/1gjsut/n8YzlAM=
MIME-Version: 1.0
In-Reply-To: <CAFkk2KSf-P9RrLsK=dAgeOSYvznCygxF7X6ZG9DR4WwotfoODA@mail.gmail.com>
References: <1526537830-22606-1-git-send-email-yamada.masahiro@socionext.com>
 <1526537830-22606-8-git-send-email-yamada.masahiro@socionext.com>
 <20180520145031.GB9826@ravnborg.org> <CAFkk2KSCtj8E48Y3KDRvT8E6bjqWpc_FvpwjVpo1Vx-tQPikwQ@mail.gmail.com>
 <CAFkk2KQuPiy=ziKeixNHzu-_k+Mau6PUwYTQh_EbWEu0GX-tkg@mail.gmail.com> <CAFkk2KSf-P9RrLsK=dAgeOSYvznCygxF7X6ZG9DR4WwotfoODA@mail.gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Tue, 22 May 2018 12:11:42 +0900
X-Gmail-Original-Message-ID: <CAK7LNARWmojPEgWcuS4SSb-+a+_u4SHwxxdqoLbHfK9KARwy9g@mail.gmail.com>
Message-ID: <CAK7LNARWmojPEgWcuS4SSb-+a+_u4SHwxxdqoLbHfK9KARwy9g@mail.gmail.com>
Subject: Re: [PATCH v4 07/31] kconfig: add built-in function support
To: Ulf Magnusson <ulfalizer@gmail.com>
Cc: Sam Ravnborg <sam@ravnborg.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>, Kees Cook <keescook@chromium.org>,
        Emese Revfy <re.emese@gmail.com>, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-05-22 0:10 GMT+09:00 Ulf Magnusson <ulfalizer@gmail.com>:
> On Mon, May 21, 2018 at 4:32 PM, Ulf Magnusson <ulfalizer@gmail.com> wrote:
>> On Mon, May 21, 2018 at 4:23 PM, Ulf Magnusson <ulfalizer@gmail.com> wrote:
>>> On Sun, May 20, 2018 at 4:50 PM, Sam Ravnborg <sam@ravnborg.org> wrote:
>>>> Will the following be equal:
>>>>
>>>>         $(foo,abc,$(x),$(y))
>>>>         $(foo, abc, $(x), $(y))
>>>>
>>>> make is rather annoying as space is significant, but there seems no good reason
>>>> for kconfig to inheritate this.
>>>> So unless there are good arguments consider alloing the spaces.
>>>> If the current implmentation already supports optional spaces then I just missed
>>>> it whie reviewing.
>>>>
>>>>         Sam
>>>
>>> +1 from me.
>>>
>>> I also find the rules for whitespace in Make confusing, and always
>>> have to look them up when doing trickier stuff. Maybe they're the
>>> result of people not considering whitespace initially, and stuff
>>> getting tacked on later. GNU Make adds some alternate syntaxes with
>>> quotes.
>>>
>>> I was going to mention shell, but it looks like you already did. :)
>>>
>>> If we go with Make-like syntax, maybe we could at least have a variant
>>> with fewer whitespace gotchas.
>>>
>>> Cheers,
>>> Ulf
>>
>> Maybe it'd be a pain to implement, but something like $(foo $(x) "two
>> words" "interpolated $(stuff)") seems pretty nice, with three
>> arguments there.
>
> Guess that might interact poorly with $(shell foo "bar baz") though.
> Kinda nice to have a syntax that doesn't overlap with shell when
> building shell commands.


Right.  I can easily imagine
that would end up with more gotchas due to quoting and escaping.



> Still wondering if you could get rid of some of the Make gotchas
> without losing other stuff...
>
> Cheers,
> Ulf



-- 
Best Regards
Masahiro Yamada
