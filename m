Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751296AbeDDNge (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 09:36:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:37502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751167AbeDDNgd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 09:36:33 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCA23206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Wed, 4 Apr 2018 09:36:30 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Kees Cook <keescook@chromium.org>, LKML <linux-kernel@vger.kernel.org>,
        "Tobin C. Harding" <me@tobin.cc>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Laight <David.Laight@aculab.com>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>
Subject: Re: [RFC][PATCH] tracing, printk: Force no hashing when
 trace_printk() is used
Message-ID: <20180404093630.63fc0dd9@gandalf.local.home>
In-Reply-To: <20180404074927.GG4082@hirez.programming.kicks-ass.net>
References: <20180403154102.150b1be0@gandalf.local.home>
        <CAGXu5j+g6nbDz+gjAxZTSf1004J=naAf7b9dPTE0q8+7UtXCLw@mail.gmail.com>
        <20180403170612.7b11fc41@gandalf.local.home>
        <20180404074927.GG4082@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Apr 2018 09:49:27 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Tue, Apr 03, 2018 at 05:06:12PM -0400, Steven Rostedt wrote:
> > If you are concerned about attack surface, I could make it a bit more
> > difficult to tweak by malicious software. What about the patch below?
> > It would be much more difficult to modify this knob from an attack
> > vector.  
> 
> Not if you build using clang, because that doesn't support asm-goto and
> thus falls back to a simple runtime variable, which is exactly what Kees
> didn't want.

Fix clang ;-)

-- Steve
