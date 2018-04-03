Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753045AbeDCUIB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 16:08:01 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:44116 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751179AbeDCUIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 16:08:00 -0400
X-Google-Smtp-Source: AIpwx494bnIHqnlyzb/mlhmJDNzTEO3e+O8ZdXZKUbDKrJX0rtZfgetQdWDYcB8HtjJ6fS99c5oE0d2megDkJUcuwAw=
MIME-Version: 1.0
In-Reply-To: <20180403154102.150b1be0@gandalf.local.home>
References: <20180403154102.150b1be0@gandalf.local.home>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 3 Apr 2018 13:07:58 -0700
X-Google-Sender-Auth: R-acmqlBjKHSgqV5aMOk4Gsozug
Message-ID: <CAGXu5j+g6nbDz+gjAxZTSf1004J=naAf7b9dPTE0q8+7UtXCLw@mail.gmail.com>
Subject: Re: [RFC][PATCH] tracing, printk: Force no hashing when
 trace_printk() is used
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, "Tobin C. Harding" <me@tobin.cc>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Laight <David.Laight@aculab.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 3, 2018 at 12:41 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
> Both trace_debug is set and kptr_restrict is set to zero in the same
> code that produces the above banner. This will allow trace_printk() to
> not be affected by security code, as trace_printk() should never be run
> on a machine that needs security of this kind.

While I think it'd be nice to have a boot-time knob for this (a debate
that was unsuccessful in earlier threads), I remain skeptical of
having a _runtime_ knob for this, as then it becomes a target (and
yes, there are plenty of targets, but why add another).

If this was __ro_after_init, maybe that'd be nicer. CONFIG_TRACING=y
is used everywhere, so this is really just the whole knob debate over
again. Instead, I've been following Linus's distillation of %p usage
in the kernel:

http://lkml.kernel.org/r/CA+55aFwQEd_d40g4mUCSsVRZzrFPUJt74vc6PPpb675hYNXcKw@mail.gmail.com

-Kees

-- 
Kees Cook
Pixel Security
