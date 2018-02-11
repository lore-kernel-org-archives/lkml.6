Return-Path: <keescook@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518322412; cv=none;
        d=google.com; s=arc-20160816;
        b=sD3Jrs5YeWyTXTvp7S1sy6C1SxnJhGAzxmzKUwKP8xAihN64BucHx2sDKIsQ7fXSdt
         EuJDYHymWFrFfI1qF1MSpZ6B7S2rHG+m7m7TQV21dZyq/QXrFn2TcTYngC6JN54LBuy4
         /qedeSVFiFa/klrUH/6kf47u8yOQvj93rrbrqCtq80yAOV2P17jwoE+2OZEg8/G+BLOe
         QtEJqpGV1d80s251b7BJD7zt07+ychjIs7U/KEXgA3flFPCugPglDADj4JuVnbYitr3T
         WG64sXtTAktFqdrq6CUxaCiisl/7cH/FBQkhWpEfUhpnRUb7FOxCDzScFj3Jgrt4bDfV
         CjxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=tt2fl4STXrycFCTz1f54CtueFBYWfmGnIXA5RhQDmdw=;
        b=mbbJpiyHGzZGtc6WVKL6Otc+QJqPAX2XZYtlVWZb/LNQzvamIk6vGzguL0ZPqzKpfs
         ZlUnajFgO4IgkCi0C61FFUU3MoaCXKEiaoCe8ZtP8h/ZD/EOPqpO4rS63satZG7vzLrI
         3uo9eVB7qZsLIkeOSqd6rXisntxlNW9F1XEvEqum23LQq7F47QPEHcu5mNifFF/tTq6Y
         fi8BhpMWauqf7aIKi72LprTFWIvCCIXFA1fG9cYD0/DOYnt1hhwd+jN0WY/UVfVf4Mx7
         yQNHOpXnkBPwDZMfcoWO+yTGZXxJDpL89cPPMvR8FpEJvxYRUghd4hg7Gr+oBTkKL22+
         VRbQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=wTzxREYT;
       dkim=pass header.i=@chromium.org header.s=google header.b=hRKQ4jW4;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=wTzxREYT;
       dkim=pass header.i=@chromium.org header.s=google header.b=hRKQ4jW4;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AH8x226YvJQuWnAyVnx+vYRnLriIRjUE3qKPj18ztcMjJh3u+XIMX0W0Q69wK4ODOLzYN9wR/mJ/mcQdcwq1D5O7OGs=
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <CA+55aFz-SJ970iqDsR8-Ke4z6WvB4n9RXAeen8pG=+YJWubETw@mail.gmail.com>
References: <1518106752-29228-1-git-send-email-yamada.masahiro@socionext.com>
 <1518106752-29228-5-git-send-email-yamada.masahiro@socionext.com>
 <20180209053038.pscoijvowmyudyzf@huvuddator> <CAK7LNATRxYCx9sE1haw815votyA5K8GQrMPPh0Q+n3kYa=JsgA@mail.gmail.com>
 <20180209124607.akjhncb5sempjqcn@huvuddator> <CAGXu5j+hv6G3m+fgr7ibXAnoE-2GsxtXoqr0pd5AaaNdFVQxYg@mail.gmail.com>
 <20180210054843.z3g7wvcmlccvww3h@huvuddator> <CAK7LNARHmAF2SxBcc1aUEH5MMzUo_furLevqy7QzGxqNRHYiyQ@mail.gmail.com>
 <20180210074924.3nhxsza5zdbaahxx@huvuddator> <20180210080556.mycqsjhxbaguwhay@huvuddator>
 <20180210085519.737ckf4bcl57h4g2@huvuddator> <CAGXu5jKQgxxC2RQL0dxLKFVED2v-LiWKjtXY3DDpfwAXbnxM4Q@mail.gmail.com>
 <CA+55aFz-SJ970iqDsR8-Ke4z6WvB4n9RXAeen8pG=+YJWubETw@mail.gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Sat, 10 Feb 2018 20:13:31 -0800
X-Google-Sender-Auth: 8dt-4L-uGjdi2deRluHP5gyPg08
Message-ID: <CAGXu5jLo0iuMsH89vj3nr8sv+1YvXfXgoPeBdxHwZm5i=DWoOA@mail.gmail.com>
Subject: Re: [RFC PATCH 4/7] kconfig: support new special property shell=
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ulf Magnusson <ulfalizer@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>,
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>,
	Nicolas Pitre <nicolas.pitre@linaro.org>, "Luis R . Rodriguez" <mcgrof@suse.com>,
	Randy Dunlap <rdunlap@infradead.org>, Sam Ravnborg <sam@ravnborg.org>,
	Michal Marek <michal.lkml@markovi.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Pavel Machek <pavel@ucw.cz>, linux-s390 <linux-s390@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591850368607646970?=
X-GMAIL-MSGID: =?utf-8?q?1592076441844496733?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Feb 10, 2018 at 12:08 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Sat, Feb 10, 2018 at 11:23 AM, Kees Cook <keescook@chromium.org> wrote:
>>
>> So, if this could do something like this:
>>
>>         config CC_HAS_STACKPROTECTOR_STRONG
>>                 bool
>>                 option
>> shell="scripts/gcc-${ARCH}_${BITS}-has-stack-protector.sh $CC
>> $KBUILD_CPPFLAGS"
>
> Guys, this is not that important.
>
> Don't make some stupid script for stackprotector. If the user doesn't
> have a gcc that supports -fstackprotector-*, then don't show the
> options. It matters NOT ONE WHIT whether that then means that
> stackprotector will be off by default later.

What? Maybe you're misunderstanding the script? This script already exists:

$ ls scripts/gcc-x86_*
scripts/gcc-x86_32-has-stack-protector.sh
scripts/gcc-x86_64-has-stack-protector.sh

It's been there since the very beginning when Arjan added it to
validate that the compiler actually produces a stack protector when
you give it -fstack-protector. Older gccs broke this entirely, more
recent misconfigurations (as seen with some of Arnd's local gcc
builds) did similar, and there have been regressions in some versions
where gcc's x86 support flipped to the global canary instead of the
%gs-offset canary.

> Seriously. This is classic "Kees thinks that _his_ code is so
> important that everybody should get the value _he_ cares about".

I care about the kernel build informing people about what's gone wrong
as early as possible instead of producing an unbootable image that
takes forever to debug.

-Kees

-- 
Kees Cook
Pixel Security
