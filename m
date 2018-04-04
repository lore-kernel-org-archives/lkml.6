Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752529AbeDDTaq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 15:30:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:45338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751871AbeDDTan (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 15:30:43 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 969CC20CAA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Wed, 4 Apr 2018 15:30:39 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Kees Cook <keescook@chromium.org>, LKML <linux-kernel@vger.kernel.org>,
        "Tobin C. Harding" <me@tobin.cc>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Laight <David.Laight@aculab.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v2] tracing, printk: Force no hashing when
 trace_printk() is used
Message-ID: <20180404153039.1c26667b@gandalf.local.home>
In-Reply-To: <CA+55aFytqnsCVFnQojuSdSH2gpXk-eOEyjafQjJPA3GwyFpw8A@mail.gmail.com>
References: <20180403173126.4f79af9e@gandalf.local.home>
        <CAGXu5jLbNtn9CqqCeG3UHmWfC9=qPmhjSLw9vu0Zcyt04XaQ+A@mail.gmail.com>
        <20180403180313.3cc8bb27@gandalf.local.home>
        <20180404023455.GA493@jagdpanzerIV>
        <20180404131310.459e3ef2@gandalf.local.home>
        <CA+55aFytqnsCVFnQojuSdSH2gpXk-eOEyjafQjJPA3GwyFpw8A@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Apr 2018 12:04:42 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:


> 
> So at the *very* least this would need to be percpu logic, but even
> that is honestly broken since an NMI might come in and want to printk
> too.
> 
> Why don't you just use %px? That avoids all of these hacks.

Just need to remember to do that. I guess with time it will become
second nature.

> 
> So NAK on this stupid "enable and disable hashing that is
> fundamentally broken" approach.
> 

OK. I'll save the change locally, and add it while debugging kernels.
ktest can do that for me ;-)

-- Steve
