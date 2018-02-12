Return-Path: <tglx@linutronix.de>
X-Google-Smtp-Source: AH8x225xnNIZ52MwXsaodukkfEx+0fAuf1WCJ7Ap+97e6nLVosnbTxIVOzx0wBi3OKzgd8tlD71L
ARC-Seal: i=1; a=rsa-sha256; t=1518431251; cv=none;
        d=google.com; s=arc-20160816;
        b=q+V+e/sd6QlvedrEdwQB5WKmWu7X9eOfwI5yjRVuuRThokec5Pr1g78E7sur2Lp59h
         7s92+zUrjKjaqNWfpTPIkL5LpVmYdFtblRny0ZU62tmLTUwnvx2ykujEgbzCOsZtiakx
         7el87IHdbqOPt1yVtTDoO8uw8HnYJ7Wqagin/vcEnB2p+OgbxHq+AI+9wMut48YSDxtU
         oCe6P9BUJROS7+Wy+Alivsxm2ANw5ONlPd7/QWECREUGnDxH2Kn+1Pi/BD8wTOaiNtX7
         NlRha49qlu9Ngde5Ji/OP+UwZU86jtqijGAAeu9es9ddEDeXSRkGlig9nGjPbRixsRLy
         B6qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:arc-authentication-results;
        bh=0Dyb0TdJKvVSXF2uYLxe0nsgHNUYu1OTKmO8CdqIGmc=;
        b=qFkqlM7AJ7Tru8Kjlo2684F+4N4sqXwL7pAe1Rgu/ynW1qkDdArPXGtDTazCHa9TvI
         v5l7pye5hrNmNoA6psw/rNnsBz4HK8BVIp5rnDaJ7ItvIwBxkzTisOjn8Kv2GoUiALv3
         vpmoY4CeVvFzsuXlPCZIV/GajQhoobj8MVblqNXC0w1AKTO6n43WS1HFJB5iO0c+xxAX
         uwOiEHMahBLMo8Gw69DdRP3wPgHROk7XyZSN6TkzslzGFW8utpLDGpWr/zzdszjRCRHZ
         xx5V1KnhFoJM4uUCrrt/ZFJzES4Ujem1QdvaEmIiW835zlYveAsMlAHJX3nTTZUsCFvL
         kPJw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Date: Mon, 12 Feb 2018 11:27:25 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
cc: Linus Torvalds <torvalds@linux-foundation.org>,
    Kees Cook <keescook@chromium.org>, Ulf Magnusson <ulfalizer@gmail.com>,
    Masahiro Yamada <yamada.masahiro@socionext.com>,
    Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
    Andrew Morton <akpm@linux-foundation.org>,
    Nicolas Pitre <nicolas.pitre@linaro.org>,
    "Luis R . Rodriguez" <mcgrof@suse.com>,
    Randy Dunlap <rdunlap@infradead.org>, Sam Ravnborg <sam@ravnborg.org>,
    Michal Marek <michal.lkml@markovi.net>,
    Martin Schwidefsky <schwidefsky@de.ibm.com>, Pavel Machek <pavel@ucw.cz>,
    linux-s390 <linux-s390@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>,
    Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
    Tejun Heo <tj@kernel.org>, Ingo Molnar <mingo@kernel.org>,
    "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>,
    Arnd Bergmann <arnd@arndb.de>, David Woodhouse <dwmw@amazon.co.uk>
Subject: Re: [RFC PATCH 4/7] kconfig: support new special property shell=
In-Reply-To: <20180212082635.GA25314@hirez.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.21.1802121125300.1158@nanos.tec.linutronix.de>
References: <20180210080556.mycqsjhxbaguwhay@huvuddator> <20180210085519.737ckf4bcl57h4g2@huvuddator> <CAGXu5jKQgxxC2RQL0dxLKFVED2v-LiWKjtXY3DDpfwAXbnxM4Q@mail.gmail.com> <CA+55aFz-SJ970iqDsR8-Ke4z6WvB4n9RXAeen8pG=+YJWubETw@mail.gmail.com>
 <CAGXu5jLo0iuMsH89vj3nr8sv+1YvXfXgoPeBdxHwZm5i=DWoOA@mail.gmail.com> <CA+55aFxdx3FYE6YGifRR=BSG9QzXwgThj5z7RmV5P5+RpNXSiQ@mail.gmail.com> <CA+55aFyPyYyG-riaBQU5cGp_sC=r8mf9Mg6L=DUEH6EyQfWYwA@mail.gmail.com> <20180211103432.pf2ot6nd7nbhdhsy@huvuddator>
 <CAGXu5jLtFcvbazxUvL_=6uT+a8m0JQEB7v0OE41Z-PMoX_fWpA@mail.gmail.com> <CA+55aFz3gUKQMr-X-b=ytLPX0AjGUaXNtLSUQ0_xZwZuDU33RQ@mail.gmail.com> <20180212082635.GA25314@hirez.programming.kicks-ass.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591850368607646970?=
X-GMAIL-MSGID: =?utf-8?q?1592190567442294171?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 12 Feb 2018, Peter Zijlstra wrote:

> On Sun, Feb 11, 2018 at 10:13:44AM -0800, Linus Torvalds wrote:
> 
> > That actually sounds like we could just
> > 
> >  (a) make gcc 4.5 be the minimum required version
> > 
> >  (b) actually error out if we find a bad compiler
> 
> So the unofficial plan was to enforce asm-goto and -fentry support by
> hard failure to build, which would get us at gcc-4.6 and then remove all

Has gcc-4.6 a (planned) retpoline backport? IIRC the cutoff for that was
gcc 4.9

Thanks,

	tglx
