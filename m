Return-Path: <linus971@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518324364; cv=none;
        d=google.com; s=arc-20160816;
        b=0w3n+bSmxL1oE9CUMWnkbJXAI7w8S06kgwKjbhXK0BZBKnDbLM2WNQbKgeFgwpCkXJ
         7o9agNJUrUxyWh5sjm710wkfbiuknmNwm/1JABc/OeeIR0EdziZOwiGLjjWS1KBq7dfw
         K/08JDuq4Dv9Rc9FRyiBDT7SnyR/xhVkVPkoADENghn83VFvfZabC/OdmInv6frFOQGQ
         wZ3XL1o2WiHmO/RvzCivubdT8LyzjoPrLIhibhhaZ5DG9t1GAXJj+Yrb+wr5p3vH4LyM
         mvIXEgit3LA/HHOrejBh55WrmiuRFEQJlLcJjQrMFcp9VrcgztQ77Jb7lz1eB+xawn9O
         UYkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=Y+spHF5SXvmuLp5VqWOH3i3Da5A3GnZ1eenTF71ZLq8=;
        b=b1E4c3Zt1PzfqDYF5SxVjzxvgT9wCWLEXqCaGVa2eeltU6krEEoTybBygUJlpc/W+5
         DWQqVZ+QbNj2YcXLE1fslZVd2w3mYy1cIUU5225oejIcLUGJ7fhvR97E4Eeahx6V+FbJ
         KCghYU7ZbYcDi9yQBJyIdf67jkc9o5I7jIaYiJmWgEDSM2j6AhakKHQ5U03bfsAr8HPQ
         AwJQSr17TgvTgsC60fpetHQwsZb1rvVa9Tuog9akd8yQa8miGjjTKBVdJR+PV0YE1CnH
         9OvG19gYka9ya+wTkMwpk6u5I1dLiETbwUvc5JAeeFDZt9EA/AD+WiSZ5jW9oxeA6/g8
         YQyg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=tHHuo0IT;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=tHHuo0IT;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
X-Google-Smtp-Source: AH8x227XLU2cuVEbq7w6rD+LLlmcGCRTfWi728d61tXeQ453AxQv2Ynt9NLqnOnvFkhOdJmGkAwp/CBwPoC4FQ6R6LA=
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <CAGXu5jLo0iuMsH89vj3nr8sv+1YvXfXgoPeBdxHwZm5i=DWoOA@mail.gmail.com>
References: <1518106752-29228-1-git-send-email-yamada.masahiro@socionext.com>
 <1518106752-29228-5-git-send-email-yamada.masahiro@socionext.com>
 <20180209053038.pscoijvowmyudyzf@huvuddator> <CAK7LNATRxYCx9sE1haw815votyA5K8GQrMPPh0Q+n3kYa=JsgA@mail.gmail.com>
 <20180209124607.akjhncb5sempjqcn@huvuddator> <CAGXu5j+hv6G3m+fgr7ibXAnoE-2GsxtXoqr0pd5AaaNdFVQxYg@mail.gmail.com>
 <20180210054843.z3g7wvcmlccvww3h@huvuddator> <CAK7LNARHmAF2SxBcc1aUEH5MMzUo_furLevqy7QzGxqNRHYiyQ@mail.gmail.com>
 <20180210074924.3nhxsza5zdbaahxx@huvuddator> <20180210080556.mycqsjhxbaguwhay@huvuddator>
 <20180210085519.737ckf4bcl57h4g2@huvuddator> <CAGXu5jKQgxxC2RQL0dxLKFVED2v-LiWKjtXY3DDpfwAXbnxM4Q@mail.gmail.com>
 <CA+55aFz-SJ970iqDsR8-Ke4z6WvB4n9RXAeen8pG=+YJWubETw@mail.gmail.com> <CAGXu5jLo0iuMsH89vj3nr8sv+1YvXfXgoPeBdxHwZm5i=DWoOA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 10 Feb 2018 20:46:02 -0800
X-Google-Sender-Auth: JNCr5wLaef5j0kJeDVmnrtvEEPA
Message-ID: <CA+55aFxdx3FYE6YGifRR=BSG9QzXwgThj5z7RmV5P5+RpNXSiQ@mail.gmail.com>
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
X-GMAIL-MSGID: =?utf-8?q?1592078488402797363?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Feb 10, 2018 at 8:13 PM, Kees Cook <keescook@chromium.org> wrote:
>
> It's been there since the very beginning when Arjan added it to
> validate that the compiler actually produces a stack protector when
> you give it -fstack-protector. Older gccs broke this entirely, more
> recent misconfigurations (as seen with some of Arnd's local gcc
> builds) did similar, and there have been regressions in some versions
> where gcc's x86 support flipped to the global canary instead of the
> %gs-offset canary.

Argh. I wanted to get rid of all that entirely, and simplify this all.
The mentioned script (and bugzilla) was from 2006, I assumed this was
all historical.

But if it has broken again since, I guess we need to have a silly script. Grr.

But yes, I also reacted to your earlier " It can't silently rewrite it
to _REGULAR because the compiler support for _STRONG regressed."
Because it damn well can. If the compiler doesn't support
-fstack-protector-strong, we can just fall back on -fstack-protector.
Silently. No extra crazy complex logic for that either.

                 Linus
