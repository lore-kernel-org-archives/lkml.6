Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751933AbeDYU5Y (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 16:57:24 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:62719 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751772AbeDYU5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 16:57:23 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
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
Date: Wed, 25 Apr 2018 22:57:12 +0200
Message-ID: <5695751.Ycq0WTIcbj@aspire.rjw.lan>
In-Reply-To: <CA+55aFz2_cwCjBDAqvzeX89Md26JR=DLhQxTPGuq8OQkWi0ehw@mail.gmail.com>
References: <tip-757d5a9b3052a4eebd029f207f1e1df59bef7b7d@git.kernel.org> <alpine.DEB.2.21.1804252108280.1589@nanos.tec.linutronix.de> <CA+55aFz2_cwCjBDAqvzeX89Md26JR=DLhQxTPGuq8OQkWi0ehw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, April 25, 2018 9:41:23 PM CEST Linus Torvalds wrote:
> On Wed, Apr 25, 2018 at 12:09 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > On Wed, 25 Apr 2018, Linus Torvalds wrote:
> >>
> >> I don't see the reported watchdog things, and I run systemd and I ran
> >> these patches.
> >
> > With suspend/resume?
> 
> Yes. I run them on my laptop, and while I don't do a _lot_ of
> suspend/resume, I do some. My laptop right now is running a "just
> after rc1" kernel, and has been for the last week, and has a couple of
> suspends in that time. Type "closed my laptop, took it elsewhere,
> opened it again", so more than a few minutes.
> 
> > Fair enough. Do the reporters have more information or do I have to chase
> > it down myself?
> 
> I think reporters should just say what distro they are running, and
> systemd versions etc, and how they debugged this. Maybe the pattern is
> obvious.
> 
> For the record, I just run plain F27, obviously with my own kernel
> (and a tweaked config, but it approaches just being a "make
> localmodconfig" of the distro config).

FWIW, I run (64-bit) OpenSUSE 42.3 on the failing machine (Acer Aspire S5) with
my own kernel (custom config based on the distro one).

The problem here is that the machine doesn't resume from S2R.  It appears to
just hang somewhere around where we return to user space.  However, to trigger
the issue it needs to stay in suspend for several minutes (not sure how many
exactly).  If it is just back-to-back suspend/resume, it will resume correctly.

Thanks,
Rafael
