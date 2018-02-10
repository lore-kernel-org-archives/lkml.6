Return-Path: <linus971@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518293293; cv=none;
        d=google.com; s=arc-20160816;
        b=ZuzwuS+e2tf9YGyFk9paooxsZuedd88gGHq9dICdFQga6njqMaCuuyFitLl06+pr9D
         HgTQ876SwOXdqTRNO6j4uNTbbyHsKAELxVmf0fUuv7b3KJrVon0EM33nTTIpp6fJEQCa
         D057J8sc086ocyYhBGjpLtW47NfRYQRu2lhbTocjjRiXtHqtkOQgSg80qnRSwcV14kZw
         zWy2IrmGzCsPcdMMSULvyA5xMpBl69as3MQPdVgvPbiWMmG+fIViYWvW9QfpeNq+y/92
         X5Ok7kbhTu+HpEyvRYekPT8ohkSfSAZKPYiLzxFVxAs3ORPSIjIGRLTOB0JZ2dGSoiwU
         2lQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=YpJBaE4XCpEcxG4IqIArvaFC2coN6x57v9taZZvm7bI=;
        b=XJADIoPFHuRwJUQgF2gYBb5l8nlR36GGVUhMvIw+DY9CxTtA7GgeOzqrzwbORHUp+k
         d2xuCz4MQTZLrKpnJCwq7uBLTc9afEr+TA68TkFpUFlGhEGtd31Qlt3kLUZY5kgTRHRm
         2/ViZS1bwcMvxWHQV6uKbqcsYkY3K63xsqTZQ7f/K3C365zspDhEFJUmKqyJbFzrdN5o
         buaPuHL/3eVJ6neMAHIQsTo3QOsXXIxMpEQ2iu508zmKajhpuMKDV4DH0lFmps0/hRvS
         T26xuoaXOqG7peA29g7AhuIiKYdkHiWWMyZRD6kHw06Zwgjq+V/q5wtDn0B7bEazPvi+
         /OhA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=qW1n55zv;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus971@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=qW1n55zv;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus971@gmail.com
X-Google-Smtp-Source: AH8x225qhs5kuE8etsAgN0ciyi2aeyZUrgtwdOebt/PdjMzprWl9n9lrSqlg8wdx7cYYE0Ar1GFfZn82XiUeXEfPr4s=
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <CAGXu5jKQgxxC2RQL0dxLKFVED2v-LiWKjtXY3DDpfwAXbnxM4Q@mail.gmail.com>
References: <1518106752-29228-1-git-send-email-yamada.masahiro@socionext.com>
 <1518106752-29228-5-git-send-email-yamada.masahiro@socionext.com>
 <20180209053038.pscoijvowmyudyzf@huvuddator> <CAK7LNATRxYCx9sE1haw815votyA5K8GQrMPPh0Q+n3kYa=JsgA@mail.gmail.com>
 <20180209124607.akjhncb5sempjqcn@huvuddator> <CAGXu5j+hv6G3m+fgr7ibXAnoE-2GsxtXoqr0pd5AaaNdFVQxYg@mail.gmail.com>
 <20180210054843.z3g7wvcmlccvww3h@huvuddator> <CAK7LNARHmAF2SxBcc1aUEH5MMzUo_furLevqy7QzGxqNRHYiyQ@mail.gmail.com>
 <20180210074924.3nhxsza5zdbaahxx@huvuddator> <20180210080556.mycqsjhxbaguwhay@huvuddator>
 <20180210085519.737ckf4bcl57h4g2@huvuddator> <CAGXu5jKQgxxC2RQL0dxLKFVED2v-LiWKjtXY3DDpfwAXbnxM4Q@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 10 Feb 2018 12:08:12 -0800
X-Google-Sender-Auth: QYm0GOsb1wrUNAhwVD2-oTFmqUg
Message-ID: <CA+55aFz-SJ970iqDsR8-Ke4z6WvB4n9RXAeen8pG=+YJWubETw@mail.gmail.com>
Subject: Re: [RFC PATCH 4/7] kconfig: support new special property shell=
To: Kees Cook <keescook@chromium.org>
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
X-GMAIL-MSGID: =?utf-8?q?1592045908286757019?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Feb 10, 2018 at 11:23 AM, Kees Cook <keescook@chromium.org> wrote:
>
> So, if this could do something like this:
>
>         config CC_HAS_STACKPROTECTOR_STRONG
>                 bool
>                 option
> shell="scripts/gcc-${ARCH}_${BITS}-has-stack-protector.sh $CC
> $KBUILD_CPPFLAGS"

Guys, this is not that important.

Don't make some stupid script for stackprotector. If the user doesn't
have a gcc that supports -fstackprotector-*, then don't show the
options. It matters NOT ONE WHIT whether that then means that
stackprotector will be off by default later.

Seriously. This is classic "Kees thinks that _his_ code is so
important that everybody should get the value _he_ cares about".

That's bullshit. Kees, get over yourself. It's a very common thing to
see, but it's WRONG. The fact that _you_ care about this doesn't mean
that everybody else should too.

The whole point was to simplify Kconfig, not to make it even worse.

                       Linus
