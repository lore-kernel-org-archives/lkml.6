Return-Path: <linus971@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518378165; cv=none;
        d=google.com; s=arc-20160816;
        b=iewVY4/PKhzimA280ZHBDzfxcVfFl2MRoSke9tvo1512jDKILsooC1OrsFoEk2xtF8
         dseJ8lz+Wpv1g0t38zQb+Xmky4hU8l0bHWE0MvBfEgXEI38zdXI78UmTHhngqJeALTZS
         zk80WnFQlHI1J1dWoh7NogjMt7VmpRfz0FMKYtr6Baubb/ZGHNtlhhSjZVaUN1WcMwTS
         BABwEgy5+ey2yBb3FQVA8BEE17D4En0JoqwIwWjvdxhnXnZABbXETrXCA88Ud2+ouPEm
         Szss1Ey61Yddndw16nlaOzu8mSklVnyz4lIhGagneBra8TQj2uOwVwwb8Kfyb3eb5OYU
         Td6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=LDa1JNbuG5vW64G7ctRJI7LC1Za01qvR5BhmjCGyfJs=;
        b=RF3tQjmcCz7PLKRwPi/IGm5HZMwi5lU+EjnUCnsgl5noICDOOysHJ4DIi7EhcfoosR
         QzP2bj5NwcI4p/epNKC0CU2siWW8NTd12mdw6xCF6bessKyBIEa2AahgAEpMyzakHDi4
         W92tMYUZc9SCqFP8RBTZO1dtq3/EXiIEUmohMOjW4ZViiw1ONo3UGwtASdwjUSRz8gXq
         M7Lpg03aTHq9unx/Kwvhhhg6oUC+Xy2kRhFH6nixi5IR0qpS6rrg46aaT7tPshmHCRVM
         BHt5rOo6kjZzFk3evcqq0rOPmlAS+6KS/YKCuE7Om4bJq99NLzyo+ppwCuUIPbgvznYY
         MBPw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=PWBpQM+S;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=PWBpQM+S;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
X-Google-Smtp-Source: AH8x224FFHmZ38U3zmyT9mt4IonYFDycOHcMUukvogxcOlvsGzI94buS/h1bK18yZjzICWhOrH92p2RLkq4m3p1KfqQ=
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <CA+55aFz3gUKQMr-X-b=ytLPX0AjGUaXNtLSUQ0_xZwZuDU33RQ@mail.gmail.com>
References: <20180210054843.z3g7wvcmlccvww3h@huvuddator> <CAK7LNARHmAF2SxBcc1aUEH5MMzUo_furLevqy7QzGxqNRHYiyQ@mail.gmail.com>
 <20180210074924.3nhxsza5zdbaahxx@huvuddator> <20180210080556.mycqsjhxbaguwhay@huvuddator>
 <20180210085519.737ckf4bcl57h4g2@huvuddator> <CAGXu5jKQgxxC2RQL0dxLKFVED2v-LiWKjtXY3DDpfwAXbnxM4Q@mail.gmail.com>
 <CA+55aFz-SJ970iqDsR8-Ke4z6WvB4n9RXAeen8pG=+YJWubETw@mail.gmail.com>
 <CAGXu5jLo0iuMsH89vj3nr8sv+1YvXfXgoPeBdxHwZm5i=DWoOA@mail.gmail.com>
 <CA+55aFxdx3FYE6YGifRR=BSG9QzXwgThj5z7RmV5P5+RpNXSiQ@mail.gmail.com>
 <CA+55aFyPyYyG-riaBQU5cGp_sC=r8mf9Mg6L=DUEH6EyQfWYwA@mail.gmail.com>
 <20180211103432.pf2ot6nd7nbhdhsy@huvuddator> <CAGXu5jLtFcvbazxUvL_=6uT+a8m0JQEB7v0OE41Z-PMoX_fWpA@mail.gmail.com>
 <CA+55aFz3gUKQMr-X-b=ytLPX0AjGUaXNtLSUQ0_xZwZuDU33RQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 11 Feb 2018 11:42:44 -0800
X-Google-Sender-Auth: ZC4aLCQDT62G5qnYjzPBBkNB_aE
Message-ID: <CA+55aFyj-CfvHoRtoDVHarMOcoDjyH5b9E6QecW7yHZo-Ok31A@mail.gmail.com>
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
X-GMAIL-MSGID: =?utf-8?q?1592134903498554213?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Feb 11, 2018 at 10:13 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> That actually sounds like we could just
>
>  (a) make gcc 4.5 be the minimum required version
>
>  (b) actually error out if we find a bad compiler

Just to explain why that's different from what we do not (apart from
the "error out" thing to actually actively discourage broken
compilers): it simplifies things if we can just add a trivial check as
part of the build process rather than as part of the configuration.

If we don't have to make it part of the configuration, we can use all
the normal Kconfig rules and build rules, and then we can add the
error check to any number of places where we already do various object
file munging.

For example, it would be pretty trivial to do the "check that there's
the right segment access" as part of link-vmlinux.sh or something.

And that would allow us to just use all the regular config
infrastructure, including the (hopefully by 4.17) "cc-option" thing at
Kconfig time.

             Linus
