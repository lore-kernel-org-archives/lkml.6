Return-Path: <keescook@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518450393; cv=none;
        d=google.com; s=arc-20160816;
        b=iScvLgS8pBFvKaUI0d2E3YBhB3/7z3PCjkC4QjciFv/67AgjqDafdDZO7MmGfZzeFJ
         DYpSJTfc88/RbRDC43Lxc6H1eTykKFFwkJV6Ziu90U6DGJqvpTeOvZvS2qdbBBFtwWrd
         KXND72v/p9s0/E9m6uiZtUrnqI+wsWiFAe7RKWoc+f/O3bm0L/DdGtgXRvZbP0jO6dQw
         M0C1JR3JZkLkwNYTPpgCCOHzUPm8mKlUU/lQ/4PpejJSlNkKsAZuk51Dpyjl+BQPlO3+
         duzCmmNZfsi+KSEo9TL7iRLIUwM7eW9m/GXaXjKI6TGFzb44P7IAGrfKNbrx4e1TB0oo
         j+/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=OCQwzJ9OEfKDAF4BJkzCS4FvpoBQRnug6TlWjgF4E1A=;
        b=rBIfIz3DJmn/SK6P9pvHzuzIbvB6zp/gRKcUS8Im9nMOPmJuPxPEfTRfKJGSNM0uNp
         UmJ0KPocVJemPuRX/okdo97FozxEarNmcEJPWvpLnjVJ9mVVUYisc2nK8AUxMnn4roTo
         I8CcqzJ0ygKEsoFtVqrqnAVTziD2w136SOpWVuvD0H8HnITvAzp+0reUPxZF/dgKUlsA
         32sno6co3kZUFeq5lZe3qvjq5qTyDMRHvPb6X1YeWnnjqzCWn5GFVc4OKxOD7xLaAOfs
         1oSdgHBK80yFcCnCTH3m2rwDC0ybWNVSZ44LDcgWAOKHkTXbkqdQ2VOxMbHc2+j+YvCt
         fKUg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=ZI+/pis4;
       dkim=pass header.i=@chromium.org header.s=google header.b=kHT9anCk;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=ZI+/pis4;
       dkim=pass header.i=@chromium.org header.s=google header.b=kHT9anCk;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AH8x227SDtjXeAWyToDmDrTt41ULq5k5zsY427hYnywb+2hxGN0ixFEvLxtLvXGtfoe1FD9FqQ8g95tva+48W47gvMI=
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <CAK7LNARdm7UESEEh-2qEP9R8jWSwzZ4d2x=pZZPuj6EVAsXnAA@mail.gmail.com>
References: <20180210054843.z3g7wvcmlccvww3h@huvuddator> <CAK7LNARHmAF2SxBcc1aUEH5MMzUo_furLevqy7QzGxqNRHYiyQ@mail.gmail.com>
 <20180210074924.3nhxsza5zdbaahxx@huvuddator> <20180210080556.mycqsjhxbaguwhay@huvuddator>
 <20180210085519.737ckf4bcl57h4g2@huvuddator> <CAGXu5jKQgxxC2RQL0dxLKFVED2v-LiWKjtXY3DDpfwAXbnxM4Q@mail.gmail.com>
 <CA+55aFz-SJ970iqDsR8-Ke4z6WvB4n9RXAeen8pG=+YJWubETw@mail.gmail.com>
 <CAGXu5jLo0iuMsH89vj3nr8sv+1YvXfXgoPeBdxHwZm5i=DWoOA@mail.gmail.com>
 <CA+55aFxdx3FYE6YGifRR=BSG9QzXwgThj5z7RmV5P5+RpNXSiQ@mail.gmail.com>
 <CA+55aFyPyYyG-riaBQU5cGp_sC=r8mf9Mg6L=DUEH6EyQfWYwA@mail.gmail.com>
 <20180211103432.pf2ot6nd7nbhdhsy@huvuddator> <CAK7LNARdm7UESEEh-2qEP9R8jWSwzZ4d2x=pZZPuj6EVAsXnAA@mail.gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Mon, 12 Feb 2018 07:46:32 -0800
X-Google-Sender-Auth: RUaZKSngnrfwJg0sLhfdcbCtf9M
Message-ID: <CAGXu5jJJEApa6qUS1-AZvt2RaSUDjUhV5Ysjs2mdy_KrwMkiUQ@mail.gmail.com>
Subject: Re: [RFC PATCH 4/7] kconfig: support new special property shell=
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Ulf Magnusson <ulfalizer@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>,
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>,
	Nicolas Pitre <nicolas.pitre@linaro.org>, "Luis R . Rodriguez" <mcgrof@suse.com>,
	Randy Dunlap <rdunlap@infradead.org>, Sam Ravnborg <sam@ravnborg.org>,
	Michal Marek <michal.lkml@markovi.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Pavel Machek <pavel@ucw.cz>, linux-s390 <linux-s390@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>,
	Ingo Molnar <mingo@kernel.org>, "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591850368607646970?=
X-GMAIL-MSGID: =?utf-8?q?1592210640181033228?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 12, 2018 at 2:44 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> Linus said:
>
>> But yes, I also reacted to your earlier " It can't silently rewrite it
>> to _REGULAR because the compiler support for _STRONG regressed."
>> Because it damn well can. If the compiler doesn't support
>> -fstack-protector-strong, we can just fall back on -fstack-protector.
>> Silently. No extra crazy complex logic for that either.
>
>
> If I understood his comment correctly,
> we do not need either WANT_* or _AUTO.
>
>
> Kees' comment:
>
>> In the stack-protector case, this becomes quite important, since the
>> goal is to record the user's selection regardless of compiler
>> capability. For example, if someone selects _REGULAR, it shouldn't
>> "upgrade" to _STRONG. (Similarly for _NONE.)
>
> No.  Kconfig will not do this silently.
>
> "make oldconfig" (or "make silentoldconfig" as well)
> always ask users about new symbols.

The case I want to make sure can never happen is to have a config
setting that ends up not actually being true. For example, if
CONFIG_CC_STACKPROTECTOR appears in /proc/config.gz but the kernel
wasn't actually built with a stack protector, that's bad. We end up in
a place where the user can't trust the config to represent the actual
results of the build.

So, as long as the Kconfig options are strongly tied to the compiler
capabilities, we're good on that front.

> So, I can suggest to remove _REGULAR and _NONE.
>
> We have just two bool options, like follows.
>
> ------------------->8-----------------
> config CC_STACKPROTECTOR
>         bool "Use stack protector"
>         depends on CC_HAS_STACKPROTECTOR
>
> config CC_STACKPROTECTOR_STRONG
>         bool "Use strong strong stack protector"
>         depends on CC_STACKPROTECTOR
>         depends on CC_HAS_STACKPROTECTOR_STRONG
> -------------------->8------------------
>
> This will work well for all{yes,mod,no}config.

This two-option arrangement is fine (though it assumes there won't be
another stack protector option in the future).

The issue I have is this removes _AUTO, which I think can be solved in
the two-option arrangement too. The purpose of _AUTO is to effectively
enable stack-protector by default. As this option has been available
for over 10 years, and all distros enable it, it's an obvious
candidate to be enabled-by-default, especially since it kills a class
of exploits (as mentioned in my commit log: BlueBorne was trivially
defeated with stack-protector). So it should be possible to make these
two options "default y", yes?

> We will not have a case where
> -fstack-protector-strong is supported, but -fstack-protector is not.

Correct.

-Kees

-- 
Kees Cook
Pixel Security
