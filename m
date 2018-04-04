Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751281AbeDDHhX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 03:37:23 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:60796 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750779AbeDDHhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 03:37:22 -0400
Date: Wed, 4 Apr 2018 09:37:15 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Daniel Wagner <wagi@monom.org>
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>, stable-rt@vger.kernel.org
Subject: Re: [PATCH RT 1/3] alarmtimer: Prevent live lock in alarm_cancel()
Message-ID: <20180404073715.gwiabamwvvyi2bum@linutronix.de>
References: <20180328100746.18668-1-bigeasy@linutronix.de>
 <c248f69e-1016-e7ec-64c2-1b8756524a49@monom.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c248f69e-1016-e7ec-64c2-1b8756524a49@monom.org>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-03 20:32:36 [+0200], Daniel Wagner wrote:
> Hi Sebastian,
> 
> On 03/28/2018 12:07 PM, Sebastian Andrzej Siewior wrote:
> > If alarm_try_to_cancel() requires a retry, then depending on the
> > priority setting the retry loop might prevent timer callback completion
> > on RT. Prevent that by waiting for completion on RT, no change for a
> > non RT kernel.
> > 
> > Cc: stable-rt@vger.kernel.org
> 
> How relevant is this serie for trees before eae1c4ae275f ("posix-timers:
> Make use of cancel/arm callbacks")? Patch #2 seems to depend on that change
> which was added in v4.12.

so #1 looks relevant since that alarmtimer was introduced. #2 since the
change you mentioned because after that patch alarmtimer would be
handled wrongly - before you should do the schedule_timout() which
should be fine.  And #3 since 3.0+ (since the RCU-readsection was added)
but it is not easy to trigger (you would have to delete the timer while
a callback is waiting for it).

> Thanks,
> Daniel

Sebastian
