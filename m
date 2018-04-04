Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752125AbeDDQwm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 12:52:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:56242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751389AbeDDQwl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 12:52:41 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 922BC21707
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Wed, 4 Apr 2018 12:52:37 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Kees Cook <keescook@chromium.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, "Tobin C. Harding" <me@tobin.cc>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Laight <David.Laight@aculab.com>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>
Subject: Re: [RFC][PATCH] tracing, printk: Force no hashing when
 trace_printk() is used
Message-ID: <20180404125237.4f6bee3e@gandalf.local.home>
In-Reply-To: <CAGXu5jLkmcM+dWwr8FReWN9zFn31DakxAmXc4OfXT4qCymF7Qw@mail.gmail.com>
References: <20180403154102.150b1be0@gandalf.local.home>
        <CAGXu5j+g6nbDz+gjAxZTSf1004J=naAf7b9dPTE0q8+7UtXCLw@mail.gmail.com>
        <20180403170612.7b11fc41@gandalf.local.home>
        <20180404074927.GG4082@hirez.programming.kicks-ass.net>
        <CAGXu5jLkmcM+dWwr8FReWN9zFn31DakxAmXc4OfXT4qCymF7Qw@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Apr 2018 09:27:10 -0700
Kees Cook <keescook@chromium.org> wrote:

> On Wed, Apr 4, 2018 at 12:49 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> > On Tue, Apr 03, 2018 at 05:06:12PM -0400, Steven Rostedt wrote:  
> >> If you are concerned about attack surface, I could make it a bit more
> >> difficult to tweak by malicious software. What about the patch below?
> >> It would be much more difficult to modify this knob from an attack
> >> vector.  
> >
> > Not if you build using clang, because that doesn't support asm-goto and
> > thus falls back to a simple runtime variable, which is exactly what Kees
> > didn't want.  
> 
> Nah, Clang will get asm-goto soon. I'm not worried about that. Besides
> the "yay new target issue", I was concerned about Linus yelling about
> seeing the knob added he specifically said he didn't want. :P
>

This isn't really a knob. It can only get enabled when trace_printk()
is added, which requires a change to the kernel source code. It's just
an easy way on doing it yourself and recompiling.

No userspace can enable it, with the exception of adding a kernel
module that has a trace_printk() in it. A kernel command line option
wont even enable it.

-- Steve
