Return-Path: <peterz@infradead.org>
X-Google-Smtp-Source: AG47ELsDxv3kSI0ea3EUVlfOAAqsCeIjBdGvhiMKJvE4wQMFgWbZ63TN2SmsQ7KflUwkNECUo3dw
ARC-Seal: i=1; a=rsa-sha256; t=1520363271; cv=none;
        d=google.com; s=arc-20160816;
        b=AiTwHTt1YjlAvptJFTIz2U46jJK1mn+HVKwUQSBlPsMQdWMZi/Z/y2c4mqjJHtrd1+
         Gzdc79i8KQfxOG99xe+jtp3SXaHsUQJR3XxfJTLrlhPuVW3oEizf8v+5HET9l6WFsGIq
         J+vM5oK0cBLPhoPU5Ed0uhoXvrsVDjTUS+qYo6Ct3E70PdkR23e2uq83zkCJD1aOy1F7
         ENkzbSZoYqrUe2LsNf0PICama/udv3ZinGQldxTJcoLOeAIHJMQdwjfh8uUu0C5sbw9k
         sSHDIg9J6dwsOt0ACjvfrwLg6UFSBKzuoW+EwadfmoTVRlyi1JWi2AHPaOVnJn6IwTkb
         dU7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=sK0Ah4WgTXCFRU5csWSmrDfL3rCAAz++CWQbcLeLKxM=;
        b=lpxptpeyRbUPy2RRP5p8ZfirZEGrRj1UFzBnHXnuq9qQU0AuMTjrC2juEbGOy46TqK
         uo0Nk2JJdBgkkLW43b8B1l9/z8Q0rbqAZ7FnVkQrljrdT5kE2nWJIoJrvf3ikSdGPx65
         KROJB4hSPyo8e0BnJcPtt1yIHJWKs3Jz9gQ5hnqLr0q9E6P2T7LiF02YTZi9J3Ist7tY
         HfROI+LP5EpCNB4oDHdwLk7i7d7Rq2rpIoNzCrEFfTyuRz5/sMu/BGn5cK44GCi5kmME
         4I/7is01qZH44DrkYynY6WlUob5HL2vqORThdRcdtXr3DzRdLleXPPs+GFA1jONi/4As
         sSsw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=tURNZsih;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 198.137.202.133 as permitted sender) smtp.mailfrom=peterz@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=tURNZsih;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 198.137.202.133 as permitted sender) smtp.mailfrom=peterz@infradead.org
Date: Tue, 6 Mar 2018 20:07:20 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Daniel Micay <danielmicay@gmail.com>, Ingo Molnar <mingo@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Alexander Popov <alex.popov@linux.com>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>,
	PaX Team <pageexec@freemail.hu>,
	Brad Spengler <spender@grsecurity.net>,
	Andy Lutomirski <luto@kernel.org>, Tycho Andersen <tycho@tycho.ws>,
	Laura Abbott <labbott@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Borislav Petkov <bp@alien8.de>,
	Richard Sandiford <richard.sandiford@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"H . Peter Anvin" <hpa@zytor.com>,
	"Dmitry V . Levin" <ldv@altlinux.org>,
	Emese Revfy <re.emese@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
	Andrey Ryabinin <aryabinin@virtuozzo.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Thomas Garnier <thgarnie@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexei Starovoitov <ast@kernel.org>, Josef Bacik <jbacik@fb.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Ding Tianhong <dingtianhong@huawei.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Juergen Gross <jgross@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Mathias Krause <minipli@googlemail.com>,
	Vikas Shivappa <vikas.shivappa@linux.intel.com>,
	Kyle Huey <me@kylehuey.com>,
	Dmitry Safonov <dsafonov@virtuozzo.com>,
	Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>,
	X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC v9 4/7] x86/entry: Erase kernel stack in
 syscall_trace_enter()
Message-ID: <20180306190720.GK25181@hirez.programming.kicks-ass.net>
References: <1520107232-14111-1-git-send-email-alex.popov@linux.com>
 <1520107232-14111-5-git-send-email-alex.popov@linux.com>
 <b52a2cca-cb5c-d47f-131e-7db297f78958@linux.intel.com>
 <CAGXu5jLRpJ7ktij4TpaSG-RZLOou=RWyY_=jTMNE87+E4Xp2Ag@mail.gmail.com>
 <CA+55aFxEAYyrUkApo-dtZvxcYbvWBZJpUytjbm7e2wruTvbYjQ@mail.gmail.com>
 <CAGXu5j+-AjMKxOYDOpbmJ4X357JRGWViAOmqyqd6bu_w47mffw@mail.gmail.com>
 <20180306080855.phtgl2bzqm5hnthu@gmail.com>
 <CA+DvKQ+uQD0qyMvwqaRd_sMLBHE5q9pcfOQ+VknBW2==q0NJJA@mail.gmail.com>
 <CA+55aFwgmTaaA8QqMGm+VzRNbpKxDXbq2MtKyayyq8f+=PqWqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFwgmTaaA8QqMGm+VzRNbpKxDXbq2MtKyayyq8f+=PqWqA@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593947986518331727?=
X-GMAIL-MSGID: =?utf-8?q?1594216437174384915?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 06, 2018 at 10:56:58AM -0800, Linus Torvalds wrote:
> On Tue, Mar 6, 2018 at 7:16 AM, Daniel Micay <danielmicay@gmail.com> wrote:
> >
> > Zeroing locals isn't very expensive because the compiler has a chance
> > to optimize it out when it can figure out it isn't needed and they're
> > almost always used.
> 
> I thought I saw Kees with some stats, and it wasn't even noticeable.
> But maybe I mis-remember.
> 
> I definitely like the "zero local variables", and would actually
> prefer something even stronger than GCC_PLUGIN_STRUCTLEAK_BYREF_ALL
> (although I can't actually read gcc plugins, so I'm just going by
> name).
> 
> It's not necessarily just struct, it can very much be arrays and
> regular automatic variables too.
> 
> And yes, we might want to have some override switch for individual
> variables ("I really know what I'm doing and I promise I fill it
> myself, but the compiler doesn't understand me, look here:").

Right, I have one case in perf where we very carefully pass a partially
initialized structure around for performance raisins. So I would
definitely like to have that attribute that allows us to over-ride that
BYREF_ALL thing.
