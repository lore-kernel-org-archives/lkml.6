Return-Path: <linus971@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518378793; cv=none;
        d=google.com; s=arc-20160816;
        b=flPGdEKG6fEEQYPTIYpUyHHOQBu55imI31rtt0e2tACxo33ypfXTUb73wqV9mkQQBj
         mumD6DN5lEwquCt0L7vgwcKn5ViDKut98sbJi6tF/Aoll4CNxCO/ws5m3nA+oFFOB7rI
         QpKTcSb/AyC9QBJPOc0zFAROaknKivcNjgwM5yxrMcvyk16776i36u1fhJXnY8uNqLAJ
         T29Z83gTZmLBfOIRv6KwMXw3oO0A9uulGZK1vscrAeEF7YKA++2hUGFJAwbFQYj9hZdk
         GfrM01skGEwEzHTU9+UbGP9BOkPsQ9W30Mj2ecrb8x7NIbN7FlPOW+jcC62551Wjm8pF
         2zyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=qgDjNPL/BGmRBIOYPJ0ngSj0+w6w9GpeO5ZvT2Pzkdk=;
        b=hEpUK0yTAToaTp1F3LMbDtYDupov9Ek/1t2ZGLbTXDzNjtUA5RQjfRKOmemXDbsMC5
         QwzakrfUQ3nzoIr5Hw07VH9K+e9e9fDZjP6GZst9gtjX+5yhv/4xkHjbfFMM6e/pSod4
         ZvQeMg9T/Dh+1zU3bH5BNX34OEhMGlZerEdoBRwTl6+I+E298+GIjCoB057QogTzZJAF
         F5+qgfoBApulab1ZTS5Y83VghRCQ2Ko+vE4gd0Mx1hoA4EM7bQNvQ8OaAaRukV0gyYCu
         T8As2dmRfhmlDKVoJA5PXCZDVXUobd2jsNwD6t1brErh9zpAKxyG7Gfq89xbl/SumsOD
         GzdQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=PQaEtuav;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=PQaEtuav;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
X-Google-Smtp-Source: AH8x225xTLXmCqQ13d7s7FVcmZLRXL6MhiSQX2QKM2WjGucqMI1nrV8/l+I6CHW1TMhBnesCszI5yGssURWnHnwVnj0=
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <CAGXu5jLV-i5OAbXMQiJC-idXB+XrxMCC+RigQ+4R6eZWqn4rgg@mail.gmail.com>
References: <20180210054843.z3g7wvcmlccvww3h@huvuddator> <CAK7LNARHmAF2SxBcc1aUEH5MMzUo_furLevqy7QzGxqNRHYiyQ@mail.gmail.com>
 <20180210074924.3nhxsza5zdbaahxx@huvuddator> <20180210080556.mycqsjhxbaguwhay@huvuddator>
 <20180210085519.737ckf4bcl57h4g2@huvuddator> <CAGXu5jKQgxxC2RQL0dxLKFVED2v-LiWKjtXY3DDpfwAXbnxM4Q@mail.gmail.com>
 <CA+55aFz-SJ970iqDsR8-Ke4z6WvB4n9RXAeen8pG=+YJWubETw@mail.gmail.com>
 <CAGXu5jLo0iuMsH89vj3nr8sv+1YvXfXgoPeBdxHwZm5i=DWoOA@mail.gmail.com>
 <CA+55aFxdx3FYE6YGifRR=BSG9QzXwgThj5z7RmV5P5+RpNXSiQ@mail.gmail.com>
 <CA+55aFyPyYyG-riaBQU5cGp_sC=r8mf9Mg6L=DUEH6EyQfWYwA@mail.gmail.com>
 <20180211103432.pf2ot6nd7nbhdhsy@huvuddator> <CAGXu5jLtFcvbazxUvL_=6uT+a8m0JQEB7v0OE41Z-PMoX_fWpA@mail.gmail.com>
 <CA+55aFz3gUKQMr-X-b=ytLPX0AjGUaXNtLSUQ0_xZwZuDU33RQ@mail.gmail.com> <CAGXu5jLV-i5OAbXMQiJC-idXB+XrxMCC+RigQ+4R6eZWqn4rgg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 11 Feb 2018 11:53:12 -0800
X-Google-Sender-Auth: M7SaFCzvzKuqdlBmM7ySHqWIBe4
Message-ID: <CA+55aFwWQ4nL2Asmzn0NSsw=w-tX5hAM9bFiOZhxehnhWH+wkw@mail.gmail.com>
Subject: Re: [RFC PATCH 4/7] kconfig: support new special property shell=
To: Kees Cook <keescook@chromium.org>
Cc: Ulf Magnusson <ulfalizer@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>,
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
X-GMAIL-MSGID: =?utf-8?q?1592135562247609645?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Feb 11, 2018 at 11:39 AM, Kees Cook <keescook@chromium.org> wrote:
>>
>>  (a) make gcc 4.5 be the minimum required version
>
> I love bumping minimum for so many reason more than just stack protector. :)

Well, it's still not a very *big* bump. With modern distros being at
7.3, and people testing pre-releases of gcc-8, something like gcc-4.5
is still pretty darn ancient.

But it would be good to be able to rely on asm goto rather than have
completely different logic for "have to do it by hand". And I do
wonder how many of our "let's test if gcc supports this option" are
completely out-dated.

And in <linux/compiler-gcc.h> we still have tests for truly ancient garbage.

> This made akpm and Arnd very very grumpy as it regressed their builds.
> That's why I had to deal with the condition very carefully for _AUTO.

Well, Arnd build new cross-tools last week, probably because you
really need new tools for other reasons anyway (ie all the spectre
mitigation). So I think Arnd is set.

And akpm being on some ancient stone age system has been an issue
before. The only way to fix it is to break it.

What I would worry about primarily is not one of the odd developers
who can upgrade, but random people in the wild. I don't want to lose
the occasional odd tester that does things nobody else does.

But with gcc-4.5 being 7+ years old, I can't imagine it's a huge issue.

              Linus
