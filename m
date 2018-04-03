Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753585AbeDCWDS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 18:03:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:48974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753160AbeDCWDR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 18:03:17 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D71B2133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Tue, 3 Apr 2018 18:03:13 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Kees Cook <keescook@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>, "Tobin C. Harding" <me@tobin.cc>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Laight <David.Laight@aculab.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v2] tracing, printk: Force no hashing when
 trace_printk() is used
Message-ID: <20180403180313.3cc8bb27@gandalf.local.home>
In-Reply-To: <CAGXu5jLbNtn9CqqCeG3UHmWfC9=qPmhjSLw9vu0Zcyt04XaQ+A@mail.gmail.com>
References: <20180403173126.4f79af9e@gandalf.local.home>
        <CAGXu5jLbNtn9CqqCeG3UHmWfC9=qPmhjSLw9vu0Zcyt04XaQ+A@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Apr 2018 14:43:43 -0700
Kees Cook <keescook@chromium.org> wrote:

> > A static_key is added called "trace_debug" and if it is set, then %p will
> > not be hashed.  
> 
> Hrm, well, using a static key does make it weirder for an attacker to enable. :)

Not just weirder, much more difficult. static_keys are read only (code
segments). To enable them, the system makes the code portion rw updates
the code, then sets it back to ro.

> 
> Whatever the case, if you can get Linus's Ack, sure. I would expect

Linus you OK with this?

> he'd want you to change all the trace_printk()s to %px with
> justifications, though.

What trace_printk()s do you want to change? They are throw away
functions. trace_printk() is not something that stays in the kernel.
It's added during debugging and then removed before submitting what you
are working on upstream. It's just annoying to have to use %px instead
of %p when debugging.

-- Steve
