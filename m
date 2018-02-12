Return-Path: <peterz@infradead.org>
X-Google-Smtp-Source: AH8x227bHeF39bCxBRjhqg6+SLgnqRuzOs2zThd83wzQh7X43borArJ7NJuJBHxM09gGelZ1c6wi
ARC-Seal: i=1; a=rsa-sha256; t=1518455204; cv=none;
        d=google.com; s=arc-20160816;
        b=HnhVuw2bdL7WXLknhO5fm7yDsiDJeT7q9uGVcoG1fFdTrSQlZzalz3dFAT2a3cqI75
         CWBUfVaYrJEPx0kqv325k0M1Cf+V5xwm4FSELbsTrqbNbHK4iX5UvygE43DkowvETf7l
         3zCbWTXPw5oYz1vmMcKFwuW0dVn9UBZwRSLr6Pm3H2f8FWVIpaqWOFPaqonHcjCpubp1
         gBHw28bw4lH9jlDGzCK2K+Ti6GXS3VZ0fE4PlCwCg74s0guMGvjW1QYhHsi5wOevnT+M
         xXpvRZ31pc4XpSVXO13T2G2TYFc0LEEI6w5rXEoNDR3ME0/kjS4wQJCWBFmnx7F8XmxF
         tPjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=ApuOwy7vp0dv6+ZaWaCR2eidVwf9+ZktlNNqhQcB28A=;
        b=VH1fLsueG0uI3TCabLjb2HZt6bbAniIwN9baY6Gulimx6zHAtF8N0O5gsRKBYrRNBJ
         fkFXejiGRTE95yQzeVuM1npO0g4I0MlOHYihE5pE6ds22061BSS2d8/FQaPXpM/yiI/z
         OmEIv8LUIMV+B83HbsLdPQXnwX070jZcqLGxlpPOxfEhQPsQMjjs1LVd5rOCvjx9Hzlu
         KrTasbJ6Q5i1DEm+1BKwPUkqELVNmJtwXV2neT18eqlyV8ZhmVBkKfaYPdL8e4V0duKU
         UzHwl0Dzhrimze8G+B7ro9x9H0fNC+Vg9eEbQib3akFZNNRvdDfIXv2P+11yvBUEjnh0
         xa1g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=casper.20170209 header.b=WRPJYPP1;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=ohsyGJSo;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 85.118.1.10 as permitted sender) smtp.mailfrom=peterz@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=casper.20170209 header.b=WRPJYPP1;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=ohsyGJSo;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 85.118.1.10 as permitted sender) smtp.mailfrom=peterz@infradead.org
Date: Mon, 12 Feb 2018 18:05:10 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Kees Cook <keescook@chromium.org>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
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
Message-ID: <20180212170510.GQ25181@hirez.programming.kicks-ass.net>
References: <CA+55aFz-SJ970iqDsR8-Ke4z6WvB4n9RXAeen8pG=+YJWubETw@mail.gmail.com>
 <CAGXu5jLo0iuMsH89vj3nr8sv+1YvXfXgoPeBdxHwZm5i=DWoOA@mail.gmail.com>
 <CA+55aFxdx3FYE6YGifRR=BSG9QzXwgThj5z7RmV5P5+RpNXSiQ@mail.gmail.com>
 <CA+55aFyPyYyG-riaBQU5cGp_sC=r8mf9Mg6L=DUEH6EyQfWYwA@mail.gmail.com>
 <20180211103432.pf2ot6nd7nbhdhsy@huvuddator>
 <CAGXu5jLtFcvbazxUvL_=6uT+a8m0JQEB7v0OE41Z-PMoX_fWpA@mail.gmail.com>
 <CA+55aFz3gUKQMr-X-b=ytLPX0AjGUaXNtLSUQ0_xZwZuDU33RQ@mail.gmail.com>
 <20180212082635.GA25314@hirez.programming.kicks-ass.net>
 <1518452362.6606.102.camel@infradead.org>
 <CAGXu5jLdH7wkrnB9YnRLf+vQsQyfHehUywkXqsBuy6WmVLH3OA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jLdH7wkrnB9YnRLf+vQsQyfHehUywkXqsBuy6WmVLH3OA@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591850368607646970?=
X-GMAIL-MSGID: =?utf-8?q?1592215684234979107?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 12, 2018 at 08:56:31AM -0800, Kees Cook wrote:
> That would be bad: Android exclusively builds with clang.

So implement asm-goto already, and do asm-cc-output while you're at it.

The whole asm-goto/jump_label stuff really does make a measureable
difference in performance, and its bloody rediculous LLVM doesn't have
it.

And no, a different interface to do something similar is not OK. We're
not going to have a second implementation of jump-labels and everything
else that uses it.
