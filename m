Return-Path: <ulfalizer@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518374075; cv=none;
        d=google.com; s=arc-20160816;
        b=eGusnhLPD/+1TDXE0NcKBpTvXP9lve0CN4MAN2aQ3OiZy2N3WjtuOznSqr9oJ2Mz7k
         NTym51sH4C0DjYguPzqQ2sIdKUCzBa18D4DSTCSSi7Xqnc5hoCZ+rofzqPpLVOTnMEZz
         Zlgg2DZ8POLhZuQjRw2N1Y0A8u+CeF++Li++dlzC16W+PKiw0VZQaYxQcxlN9VIxZjjA
         5yz6ChfVcEZQYoALfIWN98CQVeO3KVIprVMKEsx4enqOtWVVbThv3+PC6fACup21rKJ2
         zpWgPgWMFE74xQJrSOIJ/kcOCK1q0TrxpqO+2UrGu8UTKA5dc+twssYcOfKQ12PWx064
         XGTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=boCiq4DcbqezdPoJlFPNANUX+d6g01FLBgm63P1qtR4=;
        b=A6kBxO8XI0HxsC0KrfQYsTyvrKPMq8AHnARWDwhy7hjlPjdUcntIjBSdN0ghv0ZpIM
         PU949lca4WUormsTvYIR+rxy3VPcxzCIKufV7dk43Kf8tif78ZizZ9rRluFMpJ027qOZ
         0u8PRYw96SIhJ+7Is7l3QjVcvqVUgbZ0jVhh5HW6RcVaNSsMRL4zAZKK2XtAo0mbVtKb
         Ingu1CfGe/qcSc4LZMqIdfNpTl20nWT4ueVXyogtF+C+cE7SpCIEWsBndoqmhbtp5yeF
         WM/4gnF3E6MDNTWsnMkpM8VsLmmmlU6N20RXuYM/NwNk8OnxHNhwURORPsyBDJx2B6j6
         nQzw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=cRn4FWCJ;
       spf=pass (google.com: domain of ulfalizer@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=ulfalizer@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=cRn4FWCJ;
       spf=pass (google.com: domain of ulfalizer@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=ulfalizer@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x227wacrOIq/GtIkNbjKvMOoM1+c87UBVvefA4jCLicP75hWlAAARzahmzuEG0wyjo1jnogCyxJYsZnZi9u5VjIw=
MIME-Version: 1.0
In-Reply-To: <CAGXu5jLtFcvbazxUvL_=6uT+a8m0JQEB7v0OE41Z-PMoX_fWpA@mail.gmail.com>
References: <20180210054843.z3g7wvcmlccvww3h@huvuddator> <CAK7LNARHmAF2SxBcc1aUEH5MMzUo_furLevqy7QzGxqNRHYiyQ@mail.gmail.com>
 <20180210074924.3nhxsza5zdbaahxx@huvuddator> <20180210080556.mycqsjhxbaguwhay@huvuddator>
 <20180210085519.737ckf4bcl57h4g2@huvuddator> <CAGXu5jKQgxxC2RQL0dxLKFVED2v-LiWKjtXY3DDpfwAXbnxM4Q@mail.gmail.com>
 <CA+55aFz-SJ970iqDsR8-Ke4z6WvB4n9RXAeen8pG=+YJWubETw@mail.gmail.com>
 <CAGXu5jLo0iuMsH89vj3nr8sv+1YvXfXgoPeBdxHwZm5i=DWoOA@mail.gmail.com>
 <CA+55aFxdx3FYE6YGifRR=BSG9QzXwgThj5z7RmV5P5+RpNXSiQ@mail.gmail.com>
 <CA+55aFyPyYyG-riaBQU5cGp_sC=r8mf9Mg6L=DUEH6EyQfWYwA@mail.gmail.com>
 <20180211103432.pf2ot6nd7nbhdhsy@huvuddator> <CAGXu5jLtFcvbazxUvL_=6uT+a8m0JQEB7v0OE41Z-PMoX_fWpA@mail.gmail.com>
From: Ulf Magnusson <ulfalizer@gmail.com>
Date: Sun, 11 Feb 2018 19:34:34 +0100
Message-ID: <CAFkk2KRAjA80Y74Nahf2Nk_5yOucoa1y2Xp54F2k-Hv0xgTAFg@mail.gmail.com>
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
X-GMAIL-MSGID: =?utf-8?q?1592130614425414940?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Feb 11, 2018 at 6:56 PM, Kees Cook <keescook@chromium.org> wrote:
> Old? That's not the case. The check for -fno-stack-protector will
> likely be needed forever, as some distro compilers enable
> stack-protector by default. So when someone wants to explicitly build
> without stack-protector (or if the compiler's stack-protector is
> detected as broken), we must force it off for the kernel build.

What I meant is whether it makes sense to test if the
-fno-stack-protector option is supported. Can we reasonably assume
that passing -fno-stack-protector to the compiler won't cause an
error?

Is it possible to build GCC with no "no stack protector" support? Do
we need to support any compilers that would choke on the
-fno-stack-protector flag itself?

If we can reasonably assume that passing -fno-stack-protector is safe,
then CC_HAS_STACKPROTECTOR_NONE isn't needed.

Cheers,
Ulf
