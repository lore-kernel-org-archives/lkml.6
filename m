Return-Path: <SRS0=KIOc=HN=goodmis.org=rostedt@kernel.org>
X-Google-Smtp-Source: AIpwx48iJGLBMatNQ4k3+j62KCFDVkGA17k1GyZTcGLCWJoIwCIxOXZcOTZZqkIGLYtwvzqViqLM
ARC-Seal: i=1; a=rsa-sha256; t=1524602920; cv=none;
        d=google.com; s=arc-20160816;
        b=cL732LWzPmTfE4DSpIYnLnmeaUJaRRjvQqyEw6d+db+LuFn8wvEG/PjjNq/oUQc52h
         RtnUxzuTJD8u9XSB/LsUBOjQumsosKxi7KHw7d5BlNrVyezwyoElvxHymqJc8MiXTV33
         WnUMjCgucKE5ZCUu6ptjgMvMV02oqP/oPBP+GDlCIG6RXzOnQ1QLIpWcmMD9lVIaAYAD
         h8qKJHqmMt5jxXZmv7y53MK/BsW6lWGbiIXr+Q3fHWMMirWX+vhhK72ATqjObWSkvzOV
         O2JuIPAIwt5Fg+yTIM02BVxfjFW+M50NXAvBQMjBZdQ8WpcAeICjL0JgvA2+ywkwpBJ/
         Pbcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:dmarc-filter
         :arc-authentication-results;
        bh=kgaKpfq2b2V5dDi277pGyQ6IoEbuAt1kBdmley+G23U=;
        b=m4yZP2/r1i71aAhD8YKUcNhwsCnom3ysCqMe0b4TauNGxaRbxw+IupVVZkyI6bHEas
         gKjtH2lrsxC0xic3icaNDu14pUChHXGS2wRbmBdi4jariylj35PJfrEgw7n/3qVH+6Gg
         yoBS/cLPL0MTCi3FcI1IjnjblGjwwLVbLDotm1ibWHdjgNZ39k2/+0SOzd9yr/fRJkuE
         xVhLYfIUxkcLHv6R11zvKZNZuMBi55CeWFh1t0tY4jMcXlA1ZhM6sTwQIk+4FSm8ZBBp
         hx0tio7o/U22KvgLSB4oO83fDBbx72+uyT4I59k0DI6Cb2buE/ra+gh6UL3rrwgqIcxN
         cHgg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=kioc=hn=goodmis.org=rostedt@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=KIOc=HN=goodmis.org=rostedt@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=kioc=hn=goodmis.org=rostedt@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=KIOc=HN=goodmis.org=rostedt@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBDA4217BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Tue, 24 Apr 2018 16:48:37 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Wei Wang <wvw@google.com>
Cc: gregkh@linuxfoundation.org, Wei Wang <wei.vince.wang@gmail.com>, Ingo
 Molnar <mingo@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Kees
 Cook <keescook@chromium.org>, Peter Zijlstra <peterz@infradead.org>, Thomas
 Gleixner <tglx@linutronix.de>, Crt Mori <cmo@melexis.com>, Alexei
 Starovoitov <ast@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
 linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>
Subject: Re: [PATCH] do not call trace_printk on non-debug build
Message-ID: <20180424164837.3f1bcd20@gandalf.local.home>
In-Reply-To: <20180424164505.0a4d15f7@gandalf.local.home>
References: <20180424180812.215900-1-wvw@google.com>
	<20180424145056.7c29ea18@gandalf.local.home>
	<CAGXk5yo44kAku+ZYx=8HzOgkEVC7ARNSER4MvWTCz-i51up=ew@mail.gmail.com>
	<20180424151416.397fbbde@gandalf.local.home>
	<CAGXk5yriz2CtCN-vkL0q7gdpV+f8+9GJH-FT+v3KBLb-fWoCZA@mail.gmail.com>
	<20180424152607.71fbee34@gandalf.local.home>
	<CAGXk5yre3aDtVbtEz4=DdBnLrT3U=LPA69jOp9zmkfeYiZ7w=Q@mail.gmail.com>
	<20180424164505.0a4d15f7@gandalf.local.home>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598651942651560845?=
X-GMAIL-MSGID: =?utf-8?q?1598662032289435666?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 24 Apr 2018 16:45:05 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 24 Apr 2018 20:39:27 +0000
> Wei Wang <wvw@google.com> wrote:
> 
> > The config is not something new and it is controlling pr_debug and
> > pr_devel, so might not be too annoying, IMHO. But I agree this is not a
> > problem from us but from abusers.  
> 
> And is the reason I never use pr_debug() and pr_devel().
> 

Which reminds me, I need to replace pr_debug() to pr_info() for this
line:

  pr_debug("syscall %s metadata not mapped, disabling ftrace event\n",

In trace_syscalls.c (I didn't add that), as a different commit that
changed syscall names for x86 caused all syscall tracepoints to
disappear. And if this was pr_info() and not pr_debug() the one that
made the change would have noticed his change had impact someplace else.

-- Steve
