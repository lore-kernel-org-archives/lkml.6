Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751355AbeEVE6g (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 00:58:36 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:41222 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751001AbeEVE6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 00:58:34 -0400
X-Google-Smtp-Source: AB8JxZo137WUx+0YvI/5hBy4t3/p7jcilflAD92ISHq1UQDhTG81mswU3CKhKy5ruSUAjc+S6umQuZzILGbNjNTYpgw=
MIME-Version: 1.0
In-Reply-To: <CAFkk2KRQP=6+a=WDCDPP1r7z5oy1TtHXOBrtFUXw0fjQJpgi9w@mail.gmail.com>
References: <1526537830-22606-1-git-send-email-yamada.masahiro@socionext.com>
 <1526537830-22606-8-git-send-email-yamada.masahiro@socionext.com>
 <20180520145031.GB9826@ravnborg.org> <CAFkk2KSCtj8E48Y3KDRvT8E6bjqWpc_FvpwjVpo1Vx-tQPikwQ@mail.gmail.com>
 <CAFkk2KQuPiy=ziKeixNHzu-_k+Mau6PUwYTQh_EbWEu0GX-tkg@mail.gmail.com>
 <CAFkk2KSf-P9RrLsK=dAgeOSYvznCygxF7X6ZG9DR4WwotfoODA@mail.gmail.com>
 <CAK7LNARWmojPEgWcuS4SSb-+a+_u4SHwxxdqoLbHfK9KARwy9g@mail.gmail.com> <CAFkk2KRQP=6+a=WDCDPP1r7z5oy1TtHXOBrtFUXw0fjQJpgi9w@mail.gmail.com>
From: Ulf Magnusson <ulfalizer@gmail.com>
Date: Tue, 22 May 2018 06:58:33 +0200
Message-ID: <CAFkk2KR26OsXYDKskDnpi-djati3wRS5W2eXO9SUu6nq8rb0Uw@mail.gmail.com>
Subject: Re: [PATCH v4 07/31] kconfig: add built-in function support
To: Masahiro Yamada <yamada.masahiro@socionext.com>
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

On Tue, May 22, 2018 at 6:50 AM, Ulf Magnusson <ulfalizer@gmail.com> wrote:
> On Tue, May 22, 2018 at 5:11 AM, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>> 2018-05-22 0:10 GMT+09:00 Ulf Magnusson <ulfalizer@gmail.com>:
>>> On Mon, May 21, 2018 at 4:32 PM, Ulf Magnusson <ulfalizer@gmail.com> wrote:
>>>> On Mon, May 21, 2018 at 4:23 PM, Ulf Magnusson <ulfalizer@gmail.com> wrote:
>>>>> On Sun, May 20, 2018 at 4:50 PM, Sam Ravnborg <sam@ravnborg.org> wrote:
>>>>>> Will the following be equal:
>>>>>>
>>>>>>         $(foo,abc,$(x),$(y))
>>>>>>         $(foo, abc, $(x), $(y))
>>>>>>
>>>>>> make is rather annoying as space is significant, but there seems no good reason
>>>>>> for kconfig to inheritate this.
>>>>>> So unless there are good arguments consider alloing the spaces.
>>>>>> If the current implmentation already supports optional spaces then I just missed
>>>>>> it whie reviewing.
>>>>>>
>>>>>>         Sam
>>>>>
>>>>> +1 from me.
>>>>>
>>>>> I also find the rules for whitespace in Make confusing, and always
>>>>> have to look them up when doing trickier stuff. Maybe they're the
>>>>> result of people not considering whitespace initially, and stuff
>>>>> getting tacked on later. GNU Make adds some alternate syntaxes with
>>>>> quotes.
>>>>>
>>>>> I was going to mention shell, but it looks like you already did. :)
>>>>>
>>>>> If we go with Make-like syntax, maybe we could at least have a variant
>>>>> with fewer whitespace gotchas.
>>>>>
>>>>> Cheers,
>>>>> Ulf
>>>>
>>>> Maybe it'd be a pain to implement, but something like $(foo $(x) "two
>>>> words" "interpolated $(stuff)") seems pretty nice, with three
>>>> arguments there.
>>>
>>> Guess that might interact poorly with $(shell foo "bar baz") though.
>>> Kinda nice to have a syntax that doesn't overlap with shell when
>>> building shell commands.
>>
>>
>> Right.  I can easily imagine
>> that would end up with more gotchas due to quoting and escaping.
>
> Yeah, you're right. It's probably trying to fix something that isn't
> broken. Make's syntax really isn't bad there, just slightly
> non-obvious at first...
>
> Think it's fine now. Better to commit to the syntax than trying to be
> "helpful" by adding a bunch of random exceptions too. That probably
> gives a bigger mess in the end...
>
> Cheers,
> Ulf

I'm fine with the comma-after-function-name change though. That just
makes it more consistent.

Cheers,
Ulf
