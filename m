Return-Path: <peterz@infradead.org>
X-Google-Smtp-Source: AH8x227Rdc763JLZ9hxj7pxkcPoXS59eEXbPk1m6VjO5W1IYWGnGjKy2HWVokOzu9jvgoGaMgaof
ARC-Seal: i=1; a=rsa-sha256; t=1518436352; cv=none;
        d=google.com; s=arc-20160816;
        b=xKiILNlcBqHAJCxfWSiJ1PO3GNXZuFPOPtzGZ1ABgzijAA9sbjTxry6AUA4ZQ7HtDK
         /0T/H8tC0vVqrAboT24itvjAyQ2iYTKWGRX9cCdIazAScIBSXH0UsO2LZnlua7qOHdbx
         expki55peBtc7yvxirf/vtJ3v9+KKg+uSoGKOiAn6VngidtJRNF77hzkD4otDZXw86BF
         dPrXNlXQ5WoQjy8kEM7i7Bay06cYbdIn/Q/HqoimV4uB7eXU7b2AYw/8NBer60uYMyp8
         2i29kJAPKkTY2oM5inSc04FzaGfx8s1bSVhNgPtCnH+9IwZ3qNhQvK6RxzmZ5anLhClD
         DaLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=f7rgb9iWwxNoxyJhYuTb3ObLoW0EjJyLmu4asaKlzEU=;
        b=YJeHtgW0E2/v4KnJxb+q/S7VRA1bl8f2F1a5AV+BS9HiPRAW2rLErzyESLZIX9o5m0
         sZ/Q561jXOF6OFcmZ8VYXNkSA5tRR5Hv6QhXNiPEgSgV+jiGWT2bbWRK5Yj0k7vnD13w
         kHEdJFWyI1RkDypTnRODGERAiraDCURetNPgDnQdYtfl39B731g5BAq1VB/Rdt63aNlv
         frds4k7FjP9RxQuG2SAISM48eukaIsZn1LhwnGFA/ImHvYKMKMZAcUeS5bhYbMcJxTU9
         5cWLp28Vg+5V2GSDtdv+GIjXaW9+AFyZQmW6eLWlYytn10wUU1lkRZSkajUzbwOivwqZ
         Hbiw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=merlin.20170209 header.b=GOoLes0r;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 205.233.59.134 as permitted sender) smtp.mailfrom=peterz@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=merlin.20170209 header.b=GOoLes0r;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 205.233.59.134 as permitted sender) smtp.mailfrom=peterz@infradead.org
Date: Mon, 12 Feb 2018 12:52:06 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Kees Cook <keescook@chromium.org>,
	Ulf Magnusson <ulfalizer@gmail.com>,
	Masahiro Yamada <yamada.masahiro@socionext.com>,
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nicolas Pitre <nicolas.pitre@linaro.org>,
	"Luis R . Rodriguez" <mcgrof@suse.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	Michal Marek <michal.lkml@markovi.net>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Pavel Machek <pavel@ucw.cz>,
	linux-s390 <linux-s390@vger.kernel.org>,
	Jiri Kosina <jkosina@suse.cz>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Tejun Heo <tj@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	"Van De Ven, Arjan" <arjan.van.de.ven@intel.com>,
	Arnd Bergmann <arnd@arndb.de>, David Woodhouse <dwmw@amazon.co.uk>
Subject: Re: [RFC PATCH 4/7] kconfig: support new special property shell=
Message-ID: <20180212115206.GJ25181@hirez.programming.kicks-ass.net>
References: <CAGXu5jKQgxxC2RQL0dxLKFVED2v-LiWKjtXY3DDpfwAXbnxM4Q@mail.gmail.com>
 <CA+55aFz-SJ970iqDsR8-Ke4z6WvB4n9RXAeen8pG=+YJWubETw@mail.gmail.com>
 <CAGXu5jLo0iuMsH89vj3nr8sv+1YvXfXgoPeBdxHwZm5i=DWoOA@mail.gmail.com>
 <CA+55aFxdx3FYE6YGifRR=BSG9QzXwgThj5z7RmV5P5+RpNXSiQ@mail.gmail.com>
 <CA+55aFyPyYyG-riaBQU5cGp_sC=r8mf9Mg6L=DUEH6EyQfWYwA@mail.gmail.com>
 <20180211103432.pf2ot6nd7nbhdhsy@huvuddator>
 <CAGXu5jLtFcvbazxUvL_=6uT+a8m0JQEB7v0OE41Z-PMoX_fWpA@mail.gmail.com>
 <CA+55aFz3gUKQMr-X-b=ytLPX0AjGUaXNtLSUQ0_xZwZuDU33RQ@mail.gmail.com>
 <20180212082635.GA25314@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1802121125300.1158@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1802121125300.1158@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591850368607646970?=
X-GMAIL-MSGID: =?utf-8?q?1592195917184871189?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 12, 2018 at 11:27:25AM +0100, Thomas Gleixner wrote:
> On Mon, 12 Feb 2018, Peter Zijlstra wrote:
> 
> > On Sun, Feb 11, 2018 at 10:13:44AM -0800, Linus Torvalds wrote:
> > 
> > > That actually sounds like we could just
> > > 
> > >  (a) make gcc 4.5 be the minimum required version
> > > 
> > >  (b) actually error out if we find a bad compiler
> > 
> > So the unofficial plan was to enforce asm-goto and -fentry support by
> > hard failure to build, which would get us at gcc-4.6 and then remove all
> 
> Has gcc-4.6 a (planned) retpoline backport? IIRC the cutoff for that was
> gcc 4.9

Official GCC will not do retpoline before 4.9 AFAIK. But if someone
were to want to build a RETPOLINE=n kernel I don't see why we should
mandate retpoline.

Also, distro's have backported retpoline much further back already.
