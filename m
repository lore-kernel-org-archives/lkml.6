Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AH8x227tp91sfZCpIV1QFVNsG5tGboUNs0NPgQvXbkwgzZhIK3LVJ1KNVZfm38H7yfWJhGBm0ok4
ARC-Seal: i=1; a=rsa-sha256; t=1519142495; cv=none;
        d=google.com; s=arc-20160816;
        b=TtWyrVUlI7JkmUM7MQSMLQCLuywN7rz2nhqIJw6WNBmYR9eNeiQdLGnCAzpa9H4560
         JhCPzIY2EfnbEVXDaTYhmYpLOTvTe/KqItO7PoCyKNT0kh0xzzhak4UL2ug9g0+WISzy
         7mfwmk0QQdUZ1ZTyUnL4o0BmGftazRcrJ11xLgRjQ/5fpGiYbRW8N5aI3dHdfRxNfhsq
         Ht7pdmdEqzZD2DxpvvhuKoFEvaRcik7I3RBxKMbypYx5DVz7qZCkmD3Oz90D1XtWkVJ4
         Ax3MqLNatF5IwK7uwWCwgoLG0CzSXixy0c4B1z49eSb+UcFy8VTNCOIx0aNGuA3IULAg
         bfQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:dkim-filter:arc-authentication-results;
        bh=sc3JbggwibX74EIHJLzJPjjBEyfVohbRlJGvLlw3cPA=;
        b=h1HkEKK0ILKV/zm/VvfMA8Z0bMjolbh1xLwqb5rOXY3bAYvlFY4AvsE46bh0L0F3eQ
         tAwHaiIWa2V/Mfw1xDTiV8XzsTZCklxpBGxT5p4/3NggZULzUoBGDco8zPK0hcFBK/4l
         lIflGK+zjCaP8ag4QjVkwfSJzkv8PoSt153SuXufAko5OknLz24wX7P88QqLr6ppVbIC
         FyGsdTG0r9ArMckfhZEBv0dSt/ZNmf2KdKBVhYCHzpVrqDasmtNY2f4kCZ3F4cmuqnqH
         5wAjAkdWu0BTBjA3hIW54AkqCG2c3aps/gE/VX1LqqOmn7qXiDEUwOxglfkRuFJ5KGwT
         KM+w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=R1f29dYF;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.81 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=R1f29dYF;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.81 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w1KG1K7x003530
X-Nifty-SrcIP: [209.85.217.175]
MIME-Version: 1.0
In-Reply-To: <14335276.CH3Xr2i6I8@blindfold>
References: <20180219092245.26404-1-richard@nod.at> <CAK7LNASLQnWFO+qA94ifX8Gv1vMxGE-BOEhh1x2P-_mMUWRbAw@mail.gmail.com>
 <14335276.CH3Xr2i6I8@blindfold>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Wed, 21 Feb 2018 01:00:39 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQT8jEHt39xG7BvMMWjObdvCCpPhJAA83LFut4ewUVQsg@mail.gmail.com>
Message-ID: <CAK7LNAQT8jEHt39xG7BvMMWjObdvCCpPhJAA83LFut4ewUVQsg@mail.gmail.com>
Subject: Re: [PATCH v2] kbuild: Don't source kernel config
To: Richard Weinberger <richard@nod.at>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Nicholas Piggin <npiggin@gmail.com>, Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>, david@sigma-star.at,
        kbuild-all@01.org, Sam Ravnborg <sam@ravnborg.org>,
        Arnaud Lacombe <lacombar@gmail.com>,
        Nick Bowler <nbowler@elliptictech.com>, Michal Marek <mmarek@suse.cz>,
        Nicolas Pitre <nico@linaro.org>, Rusty Russell <rusty@rustcorp.com.au>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592820606337824892?=
X-GMAIL-MSGID: =?utf-8?q?1592936361595622779?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-02-21 0:25 GMT+09:00 Richard Weinberger <richard@nod.at>:
> Am Dienstag, 20. Februar 2018, 16:18:11 CET schrieb Masahiro Yamada:
>> 2018-02-19 18:22 GMT+09:00 Richard Weinberger <richard@nod.at>:
>> > Don't source the kernel config file in shell scripts.
>> > The config file is not a shell script and often imported from untrusted
>> > sources.
>> > What could possible go wrong? ;-)
>>
>> Please enumerate your real problems.
>
> Build a kernel where the .config contains something like:
> CONFIG_CMDLINE_BOOL=y
> CONFIG_CMDLINE="`echo hello > world`"


Same for Makefile
if a string symbol is referenced from Makefile, like

CONFIG_CROSS_COMPILE="$(shell echo hello > world)aarch64-linux-gnu-"



> I'll send a v3 because I forgot to convert one function in the shell script to
> the new bash array. kbuild bot FTW. :-)

You do not need to do so.

This patch is so ugly.

Also, changed shell scripts have '#!/bin/sh' shebang,
but you are adding bash as a requirement.




-- 
Best Regards
Masahiro Yamada
