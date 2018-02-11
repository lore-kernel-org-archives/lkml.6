Return-Path: <keescook@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518383514; cv=none;
        d=google.com; s=arc-20160816;
        b=sFiQxuHvFSVn94gRoGI60/ABFfA9rMeO9PPIoqSH0246R8C1g44WiA/WgBtm3ylaHH
         XJPQFaaJ+C/lcLco70XxGeJbhvha9PStdPMJdes8fq+gpW81dWfdzFqiY7BVa7VCPp+K
         LeOvn8XR0W1n3ztRDEny0tyB7NeO4KjeRZrJc0KTQeSGpiJ+j+1m1TswjORIpYKbOigB
         r8b/jnIf+jptdknJe/RYq/kH8PSnZoCN2dlmoCEFHTCPBYIt1WLqAtOxWqAv8oBUjJTN
         7nwJ+EKhjUtYOyujaSc2dt4srCVy/NMSDOZXW2qXmC3thrMO495+nHWRUTdUXHgWsx8n
         BoNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=syZl7vEo+d4yLYQQGlo/Evx4ObbiaSTOvzb+EA7KlV8=;
        b=ytL7wt3grlyB8m3Cn/J2ZliX2RCZee2t/dXZ8ytCX7CT3xZdlWwyKmbDHA9as0Ke3n
         7bbHL7aQ00H71Fn2n+eybc1Eqrgmq/JlbqGbyMEndqjBohYv3cAINQiPZAMQnp/YPHMn
         a6O7VnKFybH0Z0Hg00bp3FrRRuge0QmcmePH5svtSQMImBr2r4QzBWpKoFkYSy4lh1Z6
         DQBf4MYohY7wOMtLitRpEDOkaBirggx9EH1QtHFhUNFPyk/gZwqDFWPbKpypgD4BGj6c
         LtUopbxJt3AZ1ARw1nfjfJR3meXs2i/E/7UF3jEX4lOBHCZ4EVagYxdE0De7N+Wz8/Uf
         MWwA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=J8dL6Z8r;
       dkim=pass header.i=@chromium.org header.s=google header.b=M5mXhUkG;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=J8dL6Z8r;
       dkim=pass header.i=@chromium.org header.s=google header.b=M5mXhUkG;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AH8x224frd8IWNszKYSDXd19OQI21VKompmHTGYz1V/OyEoU9Iz0Mndmpft9BXxl51owhztuIkR5zlPMFpWSFiqOVOM=
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <CA+55aFwWQ4nL2Asmzn0NSsw=w-tX5hAM9bFiOZhxehnhWH+wkw@mail.gmail.com>
References: <20180210054843.z3g7wvcmlccvww3h@huvuddator> <CAK7LNARHmAF2SxBcc1aUEH5MMzUo_furLevqy7QzGxqNRHYiyQ@mail.gmail.com>
 <20180210074924.3nhxsza5zdbaahxx@huvuddator> <20180210080556.mycqsjhxbaguwhay@huvuddator>
 <20180210085519.737ckf4bcl57h4g2@huvuddator> <CAGXu5jKQgxxC2RQL0dxLKFVED2v-LiWKjtXY3DDpfwAXbnxM4Q@mail.gmail.com>
 <CA+55aFz-SJ970iqDsR8-Ke4z6WvB4n9RXAeen8pG=+YJWubETw@mail.gmail.com>
 <CAGXu5jLo0iuMsH89vj3nr8sv+1YvXfXgoPeBdxHwZm5i=DWoOA@mail.gmail.com>
 <CA+55aFxdx3FYE6YGifRR=BSG9QzXwgThj5z7RmV5P5+RpNXSiQ@mail.gmail.com>
 <CA+55aFyPyYyG-riaBQU5cGp_sC=r8mf9Mg6L=DUEH6EyQfWYwA@mail.gmail.com>
 <20180211103432.pf2ot6nd7nbhdhsy@huvuddator> <CAGXu5jLtFcvbazxUvL_=6uT+a8m0JQEB7v0OE41Z-PMoX_fWpA@mail.gmail.com>
 <CA+55aFz3gUKQMr-X-b=ytLPX0AjGUaXNtLSUQ0_xZwZuDU33RQ@mail.gmail.com>
 <CAGXu5jLV-i5OAbXMQiJC-idXB+XrxMCC+RigQ+4R6eZWqn4rgg@mail.gmail.com> <CA+55aFwWQ4nL2Asmzn0NSsw=w-tX5hAM9bFiOZhxehnhWH+wkw@mail.gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Sun, 11 Feb 2018 13:11:53 -0800
X-Google-Sender-Auth: 4JkaYv59av3v80iISx2N5708Pdc
Message-ID: <CAGXu5jK7sCK=x8=jVXXYadATf6k7L7ijNS-4oMSRqKtzov_jag@mail.gmail.com>
Subject: Re: [RFC PATCH 4/7] kconfig: support new special property shell=
To: Linus Torvalds <torvalds@linux-foundation.org>
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
X-GMAIL-MSGID: =?utf-8?q?1592140511792644163?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Feb 11, 2018 at 11:53 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Sun, Feb 11, 2018 at 11:39 AM, Kees Cook <keescook@chromium.org> wrote:
>> This made akpm and Arnd very very grumpy as it regressed their builds.
>> That's why I had to deal with the condition very carefully for _AUTO.
>
> Well, Arnd build new cross-tools last week, probably because you
> really need new tools for other reasons anyway (ie all the spectre
> mitigation). So I think Arnd is set.
>
> And akpm being on some ancient stone age system has been an issue
> before. The only way to fix it is to break it.

I don't seem to be the one that can declare such things, which is why
I pulled _AUTO out of -mm before the 4.15 merge window. It was
breaking akpm and Arnd, which seemed like a serious problem,
especially since you've yelled about how it's very bad to break
builds, etc.

> What I would worry about primarily is not one of the odd developers
> who can upgrade, but random people in the wild. I don't want to lose
> the occasional odd tester that does things nobody else does.
>
> But with gcc-4.5 being 7+ years old, I can't imagine it's a huge issue.

You have no objection from me at all on this. I have been yelled at
repeatedly (unjustly in this thread even) for "forcing options" on
people. I worked very hard to NOT break people with this, so it didn't
seem like a good plan to knowingly break builds. (And the other
options, _REGULAR and _STRONG, _do_ actually break the build if you
have a broken compiler. But for _AUTO, that seemed like a very bad
idea. I could only imagine the flames.)

-Kees

-- 
Kees Cook
Pixel Security
