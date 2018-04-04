Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751318AbeDDHts (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 03:49:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57738 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750910AbeDDHtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 03:49:47 -0400
Date: Wed, 4 Apr 2018 09:49:27 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
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
Message-ID: <20180404074927.GG4082@hirez.programming.kicks-ass.net>
References: <20180403154102.150b1be0@gandalf.local.home>
 <CAGXu5j+g6nbDz+gjAxZTSf1004J=naAf7b9dPTE0q8+7UtXCLw@mail.gmail.com>
 <20180403170612.7b11fc41@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180403170612.7b11fc41@gandalf.local.home>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 03, 2018 at 05:06:12PM -0400, Steven Rostedt wrote:
> If you are concerned about attack surface, I could make it a bit more
> difficult to tweak by malicious software. What about the patch below?
> It would be much more difficult to modify this knob from an attack
> vector.

Not if you build using clang, because that doesn't support asm-goto and
thus falls back to a simple runtime variable, which is exactly what Kees
didn't want.
