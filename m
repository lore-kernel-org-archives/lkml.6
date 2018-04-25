Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752316AbeDYV2l (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 17:28:41 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:50464 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751574AbeDYV2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 17:28:38 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Salyzyn <salyzyn@android.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>, Peter Anvin <hpa@zytor.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Prarit Bhargava <prarit@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>, Pavel Machek <pavel@ucw.cz>,
        Kevin Easton <kevin@guarana.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        SergeySenozhatsky <sergey.senozhatsky@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-tip-commits@vger.kernel.org
Subject: Re: [tip:timers/urgent] Revert: Unify CLOCK_MONOTONIC and CLOCK_BOOTTIME
Date: Wed, 25 Apr 2018 23:28:27 +0200
Message-ID: <2814513.Yf7f2L7MUC@aspire.rjw.lan>
In-Reply-To: <alpine.DEB.2.21.1804252108280.1589@nanos.tec.linutronix.de>
References: <tip-757d5a9b3052a4eebd029f207f1e1df59bef7b7d@git.kernel.org> <CA+55aFypQ0aMSO7T0hxN2YCvckSLZh6BMTuz185TyJZ69jRUrg@mail.gmail.com> <alpine.DEB.2.21.1804252108280.1589@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, April 25, 2018 9:09:29 PM CEST Thomas Gleixner wrote:
> On Wed, 25 Apr 2018, Linus Torvalds wrote:
> > On Wed, Apr 25, 2018 at 6:45 AM, tip-bot for Thomas Gleixner
> > <tipbot@zytor.com> wrote:
> > >
> > > As stated in the pull request for the unification of CLOCK_MONOTONIC and
> > > CLOCK_BOOTTIME, it was clear that we might have to revert the change.
> > 
> > I'm ok with the revert., but I do want the revert message to talk
> > about *exactly* what broke.
> > 
> > I don't see the reported watchdog things, and I run systemd and I ran
> > these patches.
> 
> With suspend/resume?
> 
> > So it's not just "systemd uses this for a watchdog". It must be
> > something specific that made it trigger for some people and not
> > others, and it's that specific thing that we should document so that
> > we know why this simplification failed.
> 
> Fair enough. Do the reporters have more information or do I have to chase
> it down myself?

Well, if CLOCK_MONOTONIC did not count when the system was suspended and now
it does that due to the change in question, then this is a significant
difference in behavior likely to confuse things even in principle.

While it may not confuse things on some systems after all, does this really
matter?

Thanks,
Rafael
