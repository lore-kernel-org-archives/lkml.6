Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755048AbeDDCfD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 22:35:03 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:34655 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752750AbeDDCfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 22:35:01 -0400
X-Google-Smtp-Source: AIpwx4/RdWVNQzDKaaam3+erJzNl8oos4e8zlA7okrB30+Pq89wY868xWuG6UmeX3HB+bXRpQfqG0w==
Date: Wed, 4 Apr 2018 11:34:55 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Kees Cook <keescook@chromium.org>, LKML <linux-kernel@vger.kernel.org>,
        "Tobin C. Harding" <me@tobin.cc>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Laight <David.Laight@aculab.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v2] tracing, printk: Force no hashing when trace_printk()
 is used
Message-ID: <20180404023455.GA493@jagdpanzerIV>
References: <20180403173126.4f79af9e@gandalf.local.home>
 <CAGXu5jLbNtn9CqqCeG3UHmWfC9=qPmhjSLw9vu0Zcyt04XaQ+A@mail.gmail.com>
 <20180403180313.3cc8bb27@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180403180313.3cc8bb27@gandalf.local.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (04/03/18 18:03), Steven Rostedt wrote:
> 
> > he'd want you to change all the trace_printk()s to %px with
> > justifications, though.
> 
> What trace_printk()s do you want to change? They are throw away
> functions. trace_printk() is not something that stays in the kernel.
> It's added during debugging and then removed before submitting what you
> are working on upstream.

Seems that your patch also can fix up bpf_trace_printk() - it doesn't
even support %px, only hashed %p, which it passes to __trace_printk().

	-ss
