Return-Path: <linus971@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518372825; cv=none;
        d=google.com; s=arc-20160816;
        b=NNZzvT4XBJIKMD+gqy+wY6lobExLcIi2yY0victGBRrQ00o/Evin9Fet/k3qBMIWe6
         YqocC9M5mi4vyKEOrdI1l4aCWlmDupIjUabK9gJnqGAvmw6c20h27qTEnPYvGRyMqWuB
         X8oE+5i8zVdHht5Q3eh519MLhXOwA5CWRRobrwDpofuLjlP0R3pF1Q7XT9ZZmo73Y+rv
         93RE47vrye56TSnor3SGweHY6loCFnfvp2ghg84OKvbeUUR0UoApwsZcx92Qk1WXvX3/
         bw3Db5ODaR1cCLvBsnRZbcrwB8csFmCA4T/bZLvlBF6YuSuChIdn6IPNUHDUyHEAhicc
         PHCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=ensroHXk+n1FOLiBDDOVMv+Oa9a0Jc5DOhizPS1Hosw=;
        b=J6lKcTv4rWrM2azbdzltoRQTOTe0OaTIahlDsfQzv44JSmPKkgkLMpr1ArjQbP94ym
         DD7+9Kfl8elX0GTzuFeE3L9SjnkrGWwRdiQqtHX8PdnX19+pViO3L7WDggYvEvVznVWj
         /7Rbaxd2n1vjzPHsSYH42sD4FwAdQ7dFp0zXYi0d5XuZ+V2icHBLZvuvO588iE/d6AAD
         g2HBaTdZCnwfRTCYgAal4TY0M6tH9yFx3NU0i9ZplM1/exLsNjsaVxRVRzfB4RfF+RHu
         cK/WBfwyD9TiNovt0JzFYEYVQmnhctkJ8GWp+oZVvDTTcF7ly88xlnZ8KKxitShWU6e4
         EHGQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=pIFZxsRI;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus971@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=pIFZxsRI;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus971@gmail.com
X-Google-Smtp-Source: AH8x225TTswlDS+923tlO/k7AwA1Cn9q2/1ZRwtSfswH/wK//tAcY/9NDYpE+YQnRt4iKPgHoBrwcjCcqaSsNYWfzvQ=
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <CAGXu5jLtFcvbazxUvL_=6uT+a8m0JQEB7v0OE41Z-PMoX_fWpA@mail.gmail.com>
References: <20180210054843.z3g7wvcmlccvww3h@huvuddator> <CAK7LNARHmAF2SxBcc1aUEH5MMzUo_furLevqy7QzGxqNRHYiyQ@mail.gmail.com>
 <20180210074924.3nhxsza5zdbaahxx@huvuddator> <20180210080556.mycqsjhxbaguwhay@huvuddator>
 <20180210085519.737ckf4bcl57h4g2@huvuddator> <CAGXu5jKQgxxC2RQL0dxLKFVED2v-LiWKjtXY3DDpfwAXbnxM4Q@mail.gmail.com>
 <CA+55aFz-SJ970iqDsR8-Ke4z6WvB4n9RXAeen8pG=+YJWubETw@mail.gmail.com>
 <CAGXu5jLo0iuMsH89vj3nr8sv+1YvXfXgoPeBdxHwZm5i=DWoOA@mail.gmail.com>
 <CA+55aFxdx3FYE6YGifRR=BSG9QzXwgThj5z7RmV5P5+RpNXSiQ@mail.gmail.com>
 <CA+55aFyPyYyG-riaBQU5cGp_sC=r8mf9Mg6L=DUEH6EyQfWYwA@mail.gmail.com>
 <20180211103432.pf2ot6nd7nbhdhsy@huvuddator> <CAGXu5jLtFcvbazxUvL_=6uT+a8m0JQEB7v0OE41Z-PMoX_fWpA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 11 Feb 2018 10:13:44 -0800
X-Google-Sender-Auth: 4DMzD37dyilSWvyyo4QnPEOd4_A
Message-ID: <CA+55aFz3gUKQMr-X-b=ytLPX0AjGUaXNtLSUQ0_xZwZuDU33RQ@mail.gmail.com>
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
X-GMAIL-MSGID: =?utf-8?q?1592129304404013146?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Feb 11, 2018 at 9:56 AM, Kees Cook <keescook@chromium.org> wrote:
>
>>     - How common are those broken compilers?
>
> I *thought* it was rare (i.e. gcc 4.2) but while working on ..._AUTO I
> found breakage in akpm's 4.4 gcc, and all of Arnd's gccs due to some
> very strange misconfiguration between the gcc build environment and
> other options. So, it turns out this is unfortunately common. The good
> news is that it does NOT appear to happen with most distro compilers,
> though I've seen Android's compiler regress the global vs %gs at least
> once about a year ago.

Hmm. Ok, so it's not *that* common, and won't affect normal people.

That actually sounds like we could just

 (a) make gcc 4.5 be the minimum required version

 (b) actually error out if we find a bad compiler

Upgrading the minimum required gcc version to 4.5 is pretty much going
to happen _anyway_, because we're starting to rely on "asm goto" for
avoiding speculation.

End result: maybe we can make the configuration phase just use the
standard "does gcc support this flag" logic, and then just have a
separate script that is run to validate that gcc doesn't generate
garbage, and error out loudly if it does.

               Linus
