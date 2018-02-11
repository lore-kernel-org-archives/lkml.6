Return-Path: <ulfalizer@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518384909; cv=none;
        d=google.com; s=arc-20160816;
        b=e+sjO7fgB2BJoHpvQpq+XX1YgLjK5S1DLoJdgxfPJ5E4C1fOyMd9v6oKvtE2LxPyzp
         /UTnnVf7bDqNst7JjzxwEB4fidG35njO5LmcOzDfP8Soz9GRGShRqJbrPfWjhFfox8BS
         3VpyYeL7p2ZfjxlU3ZwgOA0kJhTpdGsoIg4Re24gXILsO7h2Q5sXuQd5OLWA4BkMZJX0
         m6tiMYaqIbEk6Z0nSTtgvZI5VAXoBa4HWdfiRcPlubIURYGxR6hX+evo9Wwhz4PQMz3e
         yuLuUr+9mNaRZ2tG47IN8SLz5je8qz0maxmiyLJ4lyEqjnu8BOqgEy0iONu/47bgCV4S
         UV9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=9Xil5mkrbBlRwwFZpQFq39sMtgl4Sq+t3KGoIatlZmM=;
        b=cSwGmGQd6FLReoXfkN0NwRIGEagjUEzP3vKCO2VBAi9epHQ5jzk+e8ACWB3u7sW8hx
         6JN07o0T/oI9SQpntG3cSZJBxsrH97fo1OSzdNLDiF1gngyjkq3VDaahizX6GiY0v+45
         f/s/iWhP1FnE1c9iaaYhW0irE30H5hzq2/UKD33GVBOoT+BHgA2DrsVdjsaPDNXZbqjq
         AsBlDJvzO/ZWQ3QGwwH3AGVUqE5U1xz5s0Saua/dIVj25r6KSjtTsQszWSTQjlyJngd7
         RD4P7NJz+Lw2FfLXmExllGeGHVVNzVYNkVS/s8pp2Uo8jxq0rhg/Qbtmox4ljY863uIb
         8fLg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ZPsjN1L/;
       spf=pass (google.com: domain of ulfalizer@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=ulfalizer@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ZPsjN1L/;
       spf=pass (google.com: domain of ulfalizer@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=ulfalizer@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x227j/7tgit/uSBl3q6ufForsbok7rLbyPUhwLiGkOlNMw/yw6rY8RRsN3w8E5oBmlJi0k25nSYKVyv/USRyw+5Q=
MIME-Version: 1.0
In-Reply-To: <CAGXu5jLnho=kMVwZgV0rEs=brt2OZZrxEcYCK=8kt5kLbraZwQ@mail.gmail.com>
References: <20180210054843.z3g7wvcmlccvww3h@huvuddator> <CAK7LNARHmAF2SxBcc1aUEH5MMzUo_furLevqy7QzGxqNRHYiyQ@mail.gmail.com>
 <20180210074924.3nhxsza5zdbaahxx@huvuddator> <20180210080556.mycqsjhxbaguwhay@huvuddator>
 <20180210085519.737ckf4bcl57h4g2@huvuddator> <CAGXu5jKQgxxC2RQL0dxLKFVED2v-LiWKjtXY3DDpfwAXbnxM4Q@mail.gmail.com>
 <CA+55aFz-SJ970iqDsR8-Ke4z6WvB4n9RXAeen8pG=+YJWubETw@mail.gmail.com>
 <CAGXu5jLo0iuMsH89vj3nr8sv+1YvXfXgoPeBdxHwZm5i=DWoOA@mail.gmail.com>
 <CA+55aFxdx3FYE6YGifRR=BSG9QzXwgThj5z7RmV5P5+RpNXSiQ@mail.gmail.com>
 <CA+55aFyPyYyG-riaBQU5cGp_sC=r8mf9Mg6L=DUEH6EyQfWYwA@mail.gmail.com>
 <20180211103432.pf2ot6nd7nbhdhsy@huvuddator> <CAGXu5jLtFcvbazxUvL_=6uT+a8m0JQEB7v0OE41Z-PMoX_fWpA@mail.gmail.com>
 <CAFkk2KRAjA80Y74Nahf2Nk_5yOucoa1y2Xp54F2k-Hv0xgTAFg@mail.gmail.com> <CAGXu5jLnho=kMVwZgV0rEs=brt2OZZrxEcYCK=8kt5kLbraZwQ@mail.gmail.com>
From: Ulf Magnusson <ulfalizer@gmail.com>
Date: Sun, 11 Feb 2018 22:35:08 +0100
Message-ID: <CAFkk2KS=MyebbfyrbYETQHaWMNU5rrYbB0khxy+VXrvc5Tshtw@mail.gmail.com>
Subject: Re: [RFC PATCH 4/7] kconfig: support new special property shell=
To: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Masahiro Yamada <yamada.masahiro@socionext.com>,
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>,
	Nicolas Pitre <nicolas.pitre@linaro.org>, "Luis R . Rodriguez" <mcgrof@suse.com>,
	Randy Dunlap <rdunlap@infradead.org>, Sam Ravnborg <sam@ravnborg.org>,
	Michal Marek <michal.lkml@markovi.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Pavel Machek <pavel@ucw.cz>, linux-s390 <linux-s390@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>,
	Ingo Molnar <mingo@kernel.org>, "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>,
	Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591850368607646970?=
X-GMAIL-MSGID: =?utf-8?q?1592141974498996381?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Feb 11, 2018 at 10:05 PM, Kees Cook <keescook@chromium.org> wrote:
> On Sun, Feb 11, 2018 at 10:34 AM, Ulf Magnusson <ulfalizer@gmail.com> wrote:
>> On Sun, Feb 11, 2018 at 6:56 PM, Kees Cook <keescook@chromium.org> wrote:
>>> Old? That's not the case. The check for -fno-stack-protector will
>>> likely be needed forever, as some distro compilers enable
>>> stack-protector by default. So when someone wants to explicitly build
>>> without stack-protector (or if the compiler's stack-protector is
>>> detected as broken), we must force it off for the kernel build.
>>
>> What I meant is whether it makes sense to test if the
>> -fno-stack-protector option is supported. Can we reasonably assume
>> that passing -fno-stack-protector to the compiler won't cause an
>> error?
>
> That isn't something I've tested; but I can check if it's useful.

If it gets rid of a pointless test and symbol, I think it's useful, so
that would be nice. :)

>> Is it possible to build GCC with no "no stack protector" support? Do
>> we need to support any compilers that would choke on the
>> -fno-stack-protector flag itself?
>>
>> If we can reasonably assume that passing -fno-stack-protector is safe,
>> then CC_HAS_STACKPROTECTOR_NONE isn't needed.
>
> Well, there are two situations:
>
> - does the user want to build _without_ stack protector? (which is
> something some people want to do, no matter what I think of it)
>
> - did _AUTO discover that stack protector output is broken?
>
> In both cases, we need to pass -fno-stack-protector in case the distro
> compiler was built with stack protector enabled by default.

Yup, that's already the way it would work. Currently, there's also a
test for whether the compiler supports -fno-stack-protector. It's that
one that I suspect we might be able to get rid of.

Cheers,
Ulf "should merge replies"
