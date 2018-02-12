Return-Path: <peterz@infradead.org>
X-Google-Smtp-Source: AH8x225I3MlnwWnwkolOUDYVWNF/l/jxLP6XmaaylDTp2zzlGmSS5OPYkjWjdolRZ/cwpFZyt5Qf
ARC-Seal: i=1; a=rsa-sha256; t=1518454880; cv=none;
        d=google.com; s=arc-20160816;
        b=QfmQ7o6uMHJaoH2CE2YzISVL/E2SagN44mM2v06co/YjvIRT5mFIm8Lg1bcIdgY4UC
         /nF6wKHQX90NqJrjMSLpRE6pqVHKYw8aSSFdqc0Cy2/F0YKSWdmvPj5uP2YZJ1LIrwpR
         cuXJpsp+nOAzTELsyCjh3suThcaEpu1A82ioaUP1BN7kn30QmHYnmfmvZiQUlY4P5XYt
         cxxARuwUwr1yOf0ovjUkg3t8mM48qfG3lFRlZRI5U51H49IPqxpxYFhvqzBcKxeVOCK7
         udfVUBvRJg8f8n3Y+KbV52PbRSK7kcpQTtPqKWFKyFXuwQWpqg9PEEyvTWA+zehe/Mwz
         nMPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=b1ExieaGY1FxmXxm8xD3/gr6bpSumEyDBJC3WPmVvl8=;
        b=UQnSbfxZMmirvEevbCtXGmk1I59anpsahSQKhOVqyR61q2JznmhlEJF7M9pg+STm3n
         RCQpMQB2/Z1YZbXOqri199AAvcVw0aOpUAH8VW1HQO7jNHHNBJDPHuchT/HJszw6G1rt
         IvIZVbqVGtSx8U8uGKoDUdYek4X/4vJtH+sQw2cSaGozTc1BukDWWy+vDIpm2+BWV32x
         4nm+fP4po4G7eVuTe2H4wPz84Z0EEN4/iGB7As/WK3iB24OVdCw6S4EZwnNveyzNLpGG
         EnS0IamWubFlrmJrmPF5spZquiZfIA7AMqHr8xUMsSxHhXbkRga27pJ06ma5Rg+osAm6
         d4bw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=casper.20170209 header.b=EcUadDjF;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=nSEP3uKO;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 85.118.1.10 as permitted sender) smtp.mailfrom=peterz@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=casper.20170209 header.b=EcUadDjF;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=nSEP3uKO;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 85.118.1.10 as permitted sender) smtp.mailfrom=peterz@infradead.org
Date: Mon, 12 Feb 2018 18:00:27 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: David Woodhouse <dwmw2@infradead.org>
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
	Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH 4/7] kconfig: support new special property shell=
Message-ID: <20180212170027.GP25181@hirez.programming.kicks-ass.net>
References: <CAGXu5jKQgxxC2RQL0dxLKFVED2v-LiWKjtXY3DDpfwAXbnxM4Q@mail.gmail.com>
 <CA+55aFz-SJ970iqDsR8-Ke4z6WvB4n9RXAeen8pG=+YJWubETw@mail.gmail.com>
 <CAGXu5jLo0iuMsH89vj3nr8sv+1YvXfXgoPeBdxHwZm5i=DWoOA@mail.gmail.com>
 <CA+55aFxdx3FYE6YGifRR=BSG9QzXwgThj5z7RmV5P5+RpNXSiQ@mail.gmail.com>
 <CA+55aFyPyYyG-riaBQU5cGp_sC=r8mf9Mg6L=DUEH6EyQfWYwA@mail.gmail.com>
 <20180211103432.pf2ot6nd7nbhdhsy@huvuddator>
 <CAGXu5jLtFcvbazxUvL_=6uT+a8m0JQEB7v0OE41Z-PMoX_fWpA@mail.gmail.com>
 <CA+55aFz3gUKQMr-X-b=ytLPX0AjGUaXNtLSUQ0_xZwZuDU33RQ@mail.gmail.com>
 <20180212082635.GA25314@hirez.programming.kicks-ass.net>
 <1518452362.6606.102.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1518452362.6606.102.camel@infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591850368607646970?=
X-GMAIL-MSGID: =?utf-8?q?1592215345092706123?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 12, 2018 at 04:19:22PM +0000, David Woodhouse wrote:
> On Mon, 2018-02-12 at 09:26 +0100, Peter Zijlstra wrote:
> > On Sun, Feb 11, 2018 at 10:13:44AM -0800, Linus Torvalds wrote:
> > 
> > > That actually sounds like we could just
> > > 
> > >  (a) make gcc 4.5 be the minimum required version
> > > 
> > >  (b) actually error out if we find a bad compiler
> > 
> > So the unofficial plan was to enforce asm-goto and -fentry support by
> > hard failure to build, which would get us at gcc-4.6 and then remove all
> > the fallback cruft needed for those features -- for x86. If we want to
> > do this tree wide, that's obviously OK with me too ;-)
> 
> This would also kill clang support, right?

Yes, not sure why I should care about that though.
