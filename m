Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752931AbeEUOdL (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 10:33:11 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:35273 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752678AbeEUOc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 10:32:59 -0400
X-Google-Smtp-Source: AB8JxZrokihz74yF3y7hdAP5yKr59FoKFY2KjwaOhW1e24j+h/EGRkNe7Gy6SNEvgpqwayo5AOQq52xWSrBX1pEhZKE=
MIME-Version: 1.0
In-Reply-To: <CAFkk2KSCtj8E48Y3KDRvT8E6bjqWpc_FvpwjVpo1Vx-tQPikwQ@mail.gmail.com>
References: <1526537830-22606-1-git-send-email-yamada.masahiro@socionext.com>
 <1526537830-22606-8-git-send-email-yamada.masahiro@socionext.com>
 <20180520145031.GB9826@ravnborg.org> <CAFkk2KSCtj8E48Y3KDRvT8E6bjqWpc_FvpwjVpo1Vx-tQPikwQ@mail.gmail.com>
From: Ulf Magnusson <ulfalizer@gmail.com>
Date: Mon, 21 May 2018 16:32:57 +0200
Message-ID: <CAFkk2KQuPiy=ziKeixNHzu-_k+Mau6PUwYTQh_EbWEu0GX-tkg@mail.gmail.com>
Subject: Re: [PATCH v4 07/31] kconfig: add built-in function support
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
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

On Mon, May 21, 2018 at 4:23 PM, Ulf Magnusson <ulfalizer@gmail.com> wrote:
> On Sun, May 20, 2018 at 4:50 PM, Sam Ravnborg <sam@ravnborg.org> wrote:
>> Will the following be equal:
>>
>>         $(foo,abc,$(x),$(y))
>>         $(foo, abc, $(x), $(y))
>>
>> make is rather annoying as space is significant, but there seems no good reason
>> for kconfig to inheritate this.
>> So unless there are good arguments consider alloing the spaces.
>> If the current implmentation already supports optional spaces then I just missed
>> it whie reviewing.
>>
>>         Sam
>
> +1 from me.
>
> I also find the rules for whitespace in Make confusing, and always
> have to look them up when doing trickier stuff. Maybe they're the
> result of people not considering whitespace initially, and stuff
> getting tacked on later. GNU Make adds some alternate syntaxes with
> quotes.
>
> I was going to mention shell, but it looks like you already did. :)
>
> If we go with Make-like syntax, maybe we could at least have a variant
> with fewer whitespace gotchas.
>
> Cheers,
> Ulf

Maybe it'd be a pain to implement, but something like $(foo $(x) "two
words" "interpolated $(stuff)") seems pretty nice, with three
arguments there.

For variables too:

  x = foo
  y = "two words"

Or have mandatory quotes, but yeah, bit spammy there maybe.

Cheers,
Ulf
