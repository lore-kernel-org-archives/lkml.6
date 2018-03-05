Return-Path: <peterz@infradead.org>
X-Google-Smtp-Source: AG47ELvjApWLDLcW/07kgX9U2A1qw5fXm+5m8dQHqTrY5loczPbuEOUa+IfFbk5HWC0wIC6C/1im
ARC-Seal: i=1; a=rsa-sha256; t=1520281665; cv=none;
        d=google.com; s=arc-20160816;
        b=QncAyJbGPWJ1xpH+P8/acLvCeQP71sX6BGPiM99WEvGQXTfoNfFZ+nnwK7FUup1piA
         ri0+sKs+WRYHBBtsExEiupaSG1WzV9x4LFSB59tFvBeMneChQ4jDxAIvxMvfchrwYhpU
         +Fh1/1hJCdflBbPgDtTR2+XzRyHkNCZ86VF9BChItGONMdxCHODo2vMu3PbobKPoCKcq
         VBJJn4kf4j85jpBWVzZB6ybODRS0WazSmSYaVCqD4Z20APRgyfF8eJIQ1B+ITH3eptAD
         uQv5wa4D+S/QJJ44gQK65Mr2m+bHutZJ6eHGg46x5OXIoX9abaG2YRx122sMShHpPStY
         rvFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=ebrgbK/rjjv9guV+EvPcIOyHATLO/0hUjlaK61jURIg=;
        b=EQLqQUxRoAZYviFrrnWbcd62FIotuuSFT6m78aWIqFuI7Qozb3GF7fdLqZit1O2Uf7
         O6ADX+ozVRjBFTiCM75A91mxhbYD0oT6Mueje0Zid9pVxJWMwys+0KUPM3fz3z/lEGbI
         WH61EU3lqhg6UfYzhAZfkRf+5ztlZ1hRCBTqdfhDUeXNCt1vLVeLaw6VRvE23g29bB6n
         He/A2SoyWPGA4mlCG823w11+o+IbTWC8DJSqiDUQIy1cAeJT0+QCWtgQloc46uRaVNkw
         SLLFMf6PxOF3744lMnr7UpQ27le8amc2I6cWdSif6ZnOqOEnkkrZRXxebdIp4ptOiJxS
         ebsQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=merlin.20170209 header.b=n2v4esg+;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 205.233.59.134 as permitted sender) smtp.mailfrom=peterz@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=merlin.20170209 header.b=n2v4esg+;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 205.233.59.134 as permitted sender) smtp.mailfrom=peterz@infradead.org
Date: Mon, 5 Mar 2018 21:26:52 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Kees Cook <keescook@chromium.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
	Alexander Popov <alex.popov@linux.com>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>,
	PaX Team <pageexec@freemail.hu>,
	Brad Spengler <spender@grsecurity.net>,
	Ingo Molnar <mingo@kernel.org>, Andy Lutomirski <luto@kernel.org>,
	Tycho Andersen <tycho@tycho.ws>, Laura Abbott <labbott@redhat.com>,
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
Message-ID: <20180305202652.GY25201@hirez.programming.kicks-ass.net>
References: <1520107232-14111-1-git-send-email-alex.popov@linux.com>
 <1520107232-14111-5-git-send-email-alex.popov@linux.com>
 <b52a2cca-cb5c-d47f-131e-7db297f78958@linux.intel.com>
 <CAGXu5jLRpJ7ktij4TpaSG-RZLOou=RWyY_=jTMNE87+E4Xp2Ag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jLRpJ7ktij4TpaSG-RZLOou=RWyY_=jTMNE87+E4Xp2Ag@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593947986518331727?=
X-GMAIL-MSGID: =?utf-8?q?1594130867577795851?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 05, 2018 at 12:06:18PM -0800, Kees Cook wrote:
> On Mon, Mar 5, 2018 at 11:40 AM, Dave Hansen
> <dave.hansen@linux.intel.com> wrote:
> > On 03/03/2018 12:00 PM, Alexander Popov wrote:
> >> @@ -128,6 +134,7 @@ static long syscall_trace_enter(struct pt_regs *regs)
> >>
> >>       do_audit_syscall_entry(regs, arch);
> >>
> >> +     erase_kstack();
> >>       return ret ?: regs->orig_ax;
> >>  }
> >
> > This seems like an odd place to be clearing the stack.  Why was it done her?
> 
> Perhaps the commit log could be improved, but the idea is that the
> audit work (ptrace, seccomp, etc), is happening before the syscall
> code starts running, and it has therefore written to the stack (that
> used to be cleared on last exit). This retains the clear stack state
> even in the face of ptrace-ish work happening before the syscall
> proper starts.

I'd suggest a code-comment over a Changelog twiddle. The changelog bit
only helps now, that code comments helps us again in 6 motnhs time when
we've forgotten everything again.
