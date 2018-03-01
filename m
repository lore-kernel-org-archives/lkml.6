Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033415AbeCARXP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 12:23:15 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:36722 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033238AbeCARXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 12:23:12 -0500
X-Google-Smtp-Source: AG47ELungoB4dIxewxc8IXm6S3JbJRBwMG6HY86Pah6jxzuampDqVol0VeUDxgagYm2ekNJXJGiRwLRvBEdUUZDn7mI=
MIME-Version: 1.0
In-Reply-To: <20180301163331.987775783@linutronix.de>
References: <20180301163331.987775783@linutronix.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 1 Mar 2018 09:23:10 -0800
X-Google-Sender-Auth: _yOoBli6Ydv9sOMt8LgGsEoGcU4
Message-ID: <CA+55aFzV8Q20vL83xa+1UKzeQ0w-SAksCDxJD4szALRDCSUZ2w@mail.gmail.com>
Subject: Re: [RFC/RFT patch 0/7] timekeeping: Unify clock MONOTONIC and clock BOOTTIME
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Stultz <john.stultz@linaro.org>, Petr Mladek <pmladek@suse.com>,
        Mark Salyzyn <salyzyn@android.com>,
        Prarit Bhargava <prarit@redhat.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Kevin Easton <kevin@guarana.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 1, 2018 at 8:33 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> This really needs lot of testing, documentation updates and more input from
> userspace folks to make a final decision.

Honestly, I don't think we'd get the testing this kind of change needs
except by just trying it.

I'm willing to merge this in the 4.17 merge window, with the
understanding that if people end up reporting issues, we may just have
to revert it all, and chalk it up to a learning experience - and add
the appropriate commentary in the kernel code about exactly what it
was that depended on that MONO/BOOT difference.

One non-technical thing I would ask: use some other word than
"conflate". Maybe just "combine". Or better yet, "unify".

"Conflate" technically and historically means the same thing as
combine, but has very much gathered a side meaning of "confuse".

So yes, "conflate" is indeed about mixing or combining, but it's
typically used in the sense of a *bad* combination or mixing. So
"trying to conflate two issues" means "trying to mix two issues that
are not the same into one".

So "unify" and "conflate" mean both the same thing and almost exactly
the opposite at the same time.

And yes, you will find dictionaries (and linguists) that hold purely
to the old meaning. As always, there are fogeys that can't get over
the fact that meanings meander and change.

               Linus
