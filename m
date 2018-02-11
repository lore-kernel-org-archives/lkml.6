Return-Path: <linus971@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518379596; cv=none;
        d=google.com; s=arc-20160816;
        b=vs1pnmxisV9kOsK+5bw7E4g/immjNZic2WQ+BjCaJG55G+c9JPGxMQ0Yh9l8YGvE0U
         +DE/e6iVA+92zTukisO5M6MA15S/jvpQg2A5IEGlQKL6/x5pD6Z8oQ3fzROirG7Qa2Ew
         DPcDmtN/ZfwgfUg609FqwVcRGyI85yoCUz+KhX4b99CcKu+uRiqCMRwLYx/vdifYcatx
         8mWZT4d2NMrZkERBXt6bPrSpmyq+WjH/KTX52jce2LFOeXjvLp98HnBsj+KXvo6pFLch
         Pqpl8n/3mWeeo/g03heJVc/HaZT6qjS0m+vsGJZ3ly+O/ZH7FTd8Okf73dvdShwmbhU4
         XZcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=bjnNUtgmogEwvKbKzKz6hu09uMC7QugunLR8KNEzjPI=;
        b=n+a6to8ZPJE40bPxJkFwlyFFThcPxpyrfkZ+nscZgrczypaNyCfwptAgH1SrQepsff
         tF/lnDFumMXAs4tmrPWFWCwVLcWU1x+IS8/G8BJ6/dh5sxN3Kj3bRFWH7vRAOihpHA2j
         lK/OxIqsNKdOAIekOsGpABVIzWL5SOYnRWaGNAegoft15lLomSRdyHpR4fhIIYtmG7Me
         K/RmyhMpe29kitUOsYToTutuuRV5quCg1wzM6QbXS+iCcKO+3LIx9dX1sKDY1VKXISsB
         rXGWusbFHTtc+nzIGzhCb1M5/m2675Zp7q70V4KBnaVZirrLN25ouo7bZslu0upYhqjJ
         g8gQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=FHffdu3l;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=FHffdu3l;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
X-Google-Smtp-Source: AH8x225cyOUAawQ1tNQcRERlyiZecz+0LuoBUNEGWnV2/xZ9GLxPSeeuaoLrKbzaaPo1rqVF8RYij1oYRdgO89xmVlk=
MIME-Version: 1.0
Sender: linus971@gmail.com
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
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 11 Feb 2018 12:06:35 -0800
X-Google-Sender-Auth: sVdYEL1r6a92Z511__A46eLyvzg
Message-ID: <CA+55aFy4WNC=pmga19CHhrX9QwOJsu1bUvGL0oNxq5EeMW94eg@mail.gmail.com>
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
X-GMAIL-MSGID: =?utf-8?q?1592136403665429004?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Feb 11, 2018 at 11:53 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Well, it's still not a very *big* bump. With modern distros being at
> 7.3, and people testing pre-releases of gcc-8, something like gcc-4.5
> is still pretty darn ancient.

... it's worth noting that our _documentation_ may claim that gcc-3.2
is the minimum supported version, but Arnd pointed out that a few
months ago that apparently nothing older than 4.1 has actually worked
for a longish while, and gcc-4.3 was needed on several architectures.

So the _real_ jump in required gcc version would be from 4.1 (4.3 in
many cases) to 4.5, not from our documented "3.2 minimum".

Arnd claimed that some architectures needed even newer-than-4.3, but I
assume that's limited to things like RISC-V that simply don't have old
gcc support at all.

That was from a discussion about bug report that only happened with
gcc-4.4, and was because gcc-4.4 did insane things, so we were talking
about how it wasn't necessarily worth supporting.

So we really have had a lot of unrelated reasons why just saying
"gcc-4.5 or newer"  would be a good thing.

            Linus
