Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751276AbeBVT5V (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 14:57:21 -0500
Received: from mail-vk0-f65.google.com ([209.85.213.65]:33055 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750776AbeBVT5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 14:57:20 -0500
X-Google-Smtp-Source: AH8x227id/xXXOsFGruZQjQRJlSObHSjVyfryEF0RAnqnz/c9UhP9ROrIJQxNK/RSdh2nDOwG0AXNam0+kJzMxTpqxA=
MIME-Version: 1.0
In-Reply-To: <CA+55aFxDh-69p0Lr52icct6-3PGcsHaZmMqHwks8HptdmdxvTg@mail.gmail.com>
References: <20180222174140.GA3154@beast> <CA+55aFxDh-69p0Lr52icct6-3PGcsHaZmMqHwks8HptdmdxvTg@mail.gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Thu, 22 Feb 2018 11:57:18 -0800
X-Google-Sender-Auth: JIeIBBZO8SrpNrOxIkzOVJqLuZs
Message-ID: <CAGXu5jJZh+LJYULPO=xqwz9ADm8Z3k+mKKnHXQYD2KWtwfxqbg@mail.gmail.com>
Subject: Re: [PATCH v3] kconfig.h: Include compiler types to avoid missed
 struct attributes
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Patrick McLean <chutzpah@gentoo.org>,
        "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2018 at 10:04 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Thu, Feb 22, 2018 at 9:41 AM, Kees Cook <keescook@chromium.org> wrote:
>>
>> Updated to include Tested-by. Linus, this looks ready to go.
>
> Ok, applied.
>
> I'm a bit worried that this ends up bypassing our automatic dependency
> generation.
>
> Lookie here (in a fully built tree):
>
>     find . -name '*.o.cmd' |
>         xargs grep -L linux/compiler_types.h |
>         xargs grep -l linux/kconfig.h |
>         while read i; do
>             j=$(echo $i | sed 's/\.o.cmd$/\.c/' | sed 's:/\.:/:');
>             test -f $j && echo $j;
>         done
>
> shows that a number of files don't end up depending on that header
> file, even though it's included (that "grep -l linux/kconfig,h"
> triggers on the command itself having that "-include linux/kconfig.h"
> line).
>
> It looks like "gcc -M" just doesn't list any files that get included
> on the command line with "-include".

Hmm. But does that mean deps for kconfig.h are broken too? That seems
silly. I'll take a look...

-Kees

-- 
Kees Cook
Pixel Security
