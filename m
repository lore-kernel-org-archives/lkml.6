Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754899AbeDZIyN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 04:54:13 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:46256 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754054AbeDZIyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 04:54:07 -0400
Date: Thu, 26 Apr 2018 10:53:40 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
cc: Linus Torvalds <torvalds@linux-foundation.org>,
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
        Jonathan Corbet <corbet@lwn.net>, linux-tip-commits@vger.kernel.org,
        Mike Galbraith <efault@gmx.de>
Subject: Re: [tip:timers/urgent] Revert: Unify CLOCK_MONOTONIC and
 CLOCK_BOOTTIME
In-Reply-To: <1937172.K7anUBJQAz@aspire.rjw.lan>
Message-ID: <alpine.DEB.2.21.1804261053020.1584@nanos.tec.linutronix.de>
References: <tip-757d5a9b3052a4eebd029f207f1e1df59bef7b7d@git.kernel.org> <alpine.DEB.2.21.1804252108280.1589@nanos.tec.linutronix.de> <2814513.Yf7f2L7MUC@aspire.rjw.lan> <1937172.K7anUBJQAz@aspire.rjw.lan>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Apr 2018, Rafael J. Wysocki wrote:
> FWIW, here's a list of issues reported and narrowed down to the commit
> in question so far I could find:
> 
> * systemd kills daemons on resume, after >WatchdogSec seconds
>   of suspending (Genki Sky).  [Verified that that's because systemd uses
>   CLOCK_MONOTONIC and expects it to not include the suspend time.]
> 
> * systemd-journald misbehaves after resume:
>   systemd-journald[7266]: File /var/log/journal/016627c3c4784cd4812d4b7e96a34226/system.journal corrupted or uncleanly shut down, renaming and replacing.
>   (	Mike Galbraith).
> 
> * NetworkManager reports "networking disabled" and networking is broken
>   after resume 50% of the time (Pavel).  [May be because of systemd.]
> 
> * MATE desktop dims the display and starts the screensaver right after
>   system resume (Pavel).
> 
> * Full system hang during resume (me).  [May be due to systemd or NM or both.]
> 
> I'm not sure if all of the above can be connected to one specific thing (other
> than the fact that things get confused if they expect CLOCK_MONOTONIC to not
> include system suspend time).

Thanks for collecting the info. I'll amend the changelog with those.

Thanks,

	tglx
