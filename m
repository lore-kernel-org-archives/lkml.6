Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933533AbeCMQhc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 12:37:32 -0400
Received: from mail-ua0-f182.google.com ([209.85.217.182]:36184 "EHLO
        mail-ua0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933462AbeCMQh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 12:37:29 -0400
X-Google-Smtp-Source: AG47ELte1fqLmFwuFb5JPQegkYGHZnwyLl7SJo5Lw+fvaIu9cb02GGfbtKnbEtz3ZCVLdu37EfRU6TBAPq6GEtYxNwk=
MIME-Version: 1.0
In-Reply-To: <CAK7LNAQn1qM7zQvtUxiN-wG64RypmbHiE0ybzsXcc4aRvzmFCA@mail.gmail.com>
References: <20180313061109.72629-1-dianders@chromium.org> <CAK7LNAQn1qM7zQvtUxiN-wG64RypmbHiE0ybzsXcc4aRvzmFCA@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 13 Mar 2018 09:37:27 -0700
X-Google-Sender-Auth: aAWwp7qQleVK0BnvKCzvsgJUaao
Message-ID: <CAD=FV=UOwqYuHn8RUa8+W_pcJL1_ZGLfvBUg+68yW7TqbJcKDg@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] kbuild: Fix corner caches with .cache.mk
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Mathieu Malaterre <malat@debian.org>,
        Dave Hansen <dave.hansen@intel.com>, Yang Shi <yang.s@alibaba-inc.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Matthias Kaehlcke <mka@chromium.org>,
        Cao jin <caoj.fnst@cn.fujitsu.com>, Arnd Bergmann <arnd@arndb.de>,
        Mark Charlebois <charlebm@gmail.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>, Ingo Molnar <mingo@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Mar 13, 2018 at 12:49 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> Hi Douglas,
>
>
> 2018-03-13 15:11 GMT+09:00 Douglas Anderson <dianders@chromium.org>:
>> This two-patches fixes two corner cases with .cache.mk that have been
>> reported.  Neither problem was catastrophic, but certainly several
>> people ran into the problem solved by the first patch (can't build
>> after gcc upgrade) and wasted time debugging, so it's really a good
>> idea to fix.
>>
>> Sorry for the big delay between v2 and v3.  I never quite caught up
>> with email after the holidays, but hopefully better late than never...
>
>
> If v3 had been sent in time for v4.15
> I would have immediately queued it up.

Sigh.  My apologies again for sitting on this for so long.  :(


> But, the situation has changed.
>
> The direction of the development is
> to move the compiler flags evaluation to the Kconfig phase,
> and remove the Kbuild cache.
>
>
> If you are interested in the background,
> here are some of resources:
>
> Linus' comment that finally moved this work forward:
> https://lkml.org/lkml/2018/2/7/527
>
> Tons of discussion about the initial version:
> https://patchwork.kernel.org/patch/10207385/
>
> The core patch in the latest version:
> https://patchwork.kernel.org/patch/10225355/
>
>
> And, I am removing the Kbuild cache entirely:
> https://patchwork.kernel.org/patch/10225437/

Oh, that's great!


> I do not know how to handle your patches
> since I am removing the addressed code for 4.17-rc1,
> which is comming in a month or so.
>
> If this is a fatal problem, we can queue it up
> only for 4.16, but I do not hear problem reports these days...

Just drop them.  Ingo hated patch 2/2, and (like you) I haven't heard
any complaints about the problems described by patch 1/2 in the last
few months.  I got back to this because I told myself I would try to
re-focus on upstream stuff while I was at ELC, not because I suddenly
got another stream of complaints.  ;)


Anyway, glad to here you've come up with a better solution for the
future and we can get rid of the cache.  Thank you for all your hard
work!


-Doug
