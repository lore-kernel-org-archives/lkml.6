Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752566AbeDDQ1O (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 12:27:14 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:45914 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751606AbeDDQ1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 12:27:12 -0400
X-Google-Smtp-Source: AIpwx4+cjS1JkDi1ryKQ1k65bNbcpDxgXMD4OMjWdzLYWNTjs9QKXkuvwssA5QhJDGzVan+pBKHoY0g7o4ARqYmAOog=
MIME-Version: 1.0
In-Reply-To: <20180404074927.GG4082@hirez.programming.kicks-ass.net>
References: <20180403154102.150b1be0@gandalf.local.home> <CAGXu5j+g6nbDz+gjAxZTSf1004J=naAf7b9dPTE0q8+7UtXCLw@mail.gmail.com>
 <20180403170612.7b11fc41@gandalf.local.home> <20180404074927.GG4082@hirez.programming.kicks-ass.net>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 4 Apr 2018 09:27:10 -0700
X-Google-Sender-Auth: 28PjUD6AF6rA_LXKi3lEtuRgBj0
Message-ID: <CAGXu5jLkmcM+dWwr8FReWN9zFn31DakxAmXc4OfXT4qCymF7Qw@mail.gmail.com>
Subject: Re: [RFC][PATCH] tracing, printk: Force no hashing when
 trace_printk() is used
To: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>, "Tobin C. Harding" <me@tobin.cc>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Laight <David.Laight@aculab.com>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 4, 2018 at 12:49 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Tue, Apr 03, 2018 at 05:06:12PM -0400, Steven Rostedt wrote:
>> If you are concerned about attack surface, I could make it a bit more
>> difficult to tweak by malicious software. What about the patch below?
>> It would be much more difficult to modify this knob from an attack
>> vector.
>
> Not if you build using clang, because that doesn't support asm-goto and
> thus falls back to a simple runtime variable, which is exactly what Kees
> didn't want.

Nah, Clang will get asm-goto soon. I'm not worried about that. Besides
the "yay new target issue", I was concerned about Linus yelling about
seeing the knob added he specifically said he didn't want. :P

-Kees

-- 
Kees Cook
Pixel Security
