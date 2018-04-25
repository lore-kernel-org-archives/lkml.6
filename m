Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753763AbeDYWlt (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 18:41:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:39458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753466AbeDYWlo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 18:41:44 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48FA521748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Wed, 25 Apr 2018 18:41:40 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
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
Subject: Re: [tip:timers/urgent] Revert: Unify CLOCK_MONOTONIC and
 CLOCK_BOOTTIME
Message-ID: <20180425184140.6b6e524d@vmware.local.home>
In-Reply-To: <5695751.Ycq0WTIcbj@aspire.rjw.lan>
References: <tip-757d5a9b3052a4eebd029f207f1e1df59bef7b7d@git.kernel.org>
        <alpine.DEB.2.21.1804252108280.1589@nanos.tec.linutronix.de>
        <CA+55aFz2_cwCjBDAqvzeX89Md26JR=DLhQxTPGuq8OQkWi0ehw@mail.gmail.com>
        <5695751.Ycq0WTIcbj@aspire.rjw.lan>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Apr 2018 22:57:12 +0200
"Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:

> FWIW, I run (64-bit) OpenSUSE 42.3 on the failing machine (Acer Aspire S5) with
> my own kernel (custom config based on the distro one).
> 
> The problem here is that the machine doesn't resume from S2R.  It appears to
> just hang somewhere around where we return to user space.  However, to trigger
> the issue it needs to stay in suspend for several minutes (not sure how many
> exactly).  If it is just back-to-back suspend/resume, it will resume correctly.

I guess the question that needs to be asked is, have you tried a kernel
with this commit reverted and it works? I'd play a bit going back and
forth between two kernels, one with the commit and one without and no
other differences, to make sure that is indeed the problem commit.

-- Steve
