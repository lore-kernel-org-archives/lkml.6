Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753547AbeDZGsP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 02:48:15 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:61084 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751465AbeDZGsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 02:48:12 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark Salyzyn <salyzyn@android.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>, Peter Anvin <hpa@zytor.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Prarit Bhargava <prarit@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Kevin Easton <kevin@guarana.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        SergeySenozhatsky <sergey.senozhatsky@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-tip-commits@vger.kernel.org
Subject: Re: [tip:timers/urgent] Revert: Unify CLOCK_MONOTONIC and CLOCK_BOOTTIME
Date: Thu, 26 Apr 2018 08:48:00 +0200
Message-ID: <1818264.9sG3yaIMPm@aspire.rjw.lan>
In-Reply-To: <20180425184140.6b6e524d@vmware.local.home>
References: <tip-757d5a9b3052a4eebd029f207f1e1df59bef7b7d@git.kernel.org> <5695751.Ycq0WTIcbj@aspire.rjw.lan> <20180425184140.6b6e524d@vmware.local.home>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, April 26, 2018 12:41:40 AM CEST Steven Rostedt wrote:
> On Wed, 25 Apr 2018 22:57:12 +0200
> "Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:
> 
> > FWIW, I run (64-bit) OpenSUSE 42.3 on the failing machine (Acer Aspire S5) with
> > my own kernel (custom config based on the distro one).
> > 
> > The problem here is that the machine doesn't resume from S2R.  It appears to
> > just hang somewhere around where we return to user space.  However, to trigger
> > the issue it needs to stay in suspend for several minutes (not sure how many
> > exactly).  If it is just back-to-back suspend/resume, it will resume correctly.
> 
> I guess the question that needs to be asked is, have you tried a kernel
> with this commit reverted and it works?

Yes, I have.

> I'd play a bit going back and
> forth between two kernels, one with the commit and one without and no
> other differences, to make sure that is indeed the problem commit.

I've done that.

It is the problem commit.

Thanks,
Rafael
