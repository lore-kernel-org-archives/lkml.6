Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751628AbeEBNgD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 09:36:03 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:54068 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751574AbeEBNf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 09:35:58 -0400
Date: Wed, 2 May 2018 15:35:53 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
cc: linux-kernel@vger.kernel.org, diego.viola@gmail.com,
        len.brown@intel.com, rjw@rjwysocki.net, rui.zhang@intel.com,
        stable@kernel.org
Subject: Re: [PATCH v2 2/7] clocksource: Allow clocksource_mark_unstable()
 on unregisered clocksources
In-Reply-To: <20180430100344.412078717@infradead.org>
Message-ID: <alpine.DEB.2.21.1805021534250.1560@nanos.tec.linutronix.de>
References: <20180430100008.503783478@infradead.org> <20180430100344.412078717@infradead.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Apr 2018, Peter Zijlstra wrote:
> --- a/kernel/time/clocksource.c
> +++ b/kernel/time/clocksource.c
> @@ -119,6 +119,16 @@ static DEFINE_SPINLOCK(watchdog_lock);
>  static int watchdog_running;
>  static atomic_t watchdog_reset_pending;
>  
> +static void inline clocksource_watchdog_lock(unsigned long *flags)
> +{
> +	spin_lock_irqsave(&watchdog_lock, *flags);
> +}
> +
> +static void inline clocksource_watchdog_unlock(unsigned long *flags)
> +{
> +	spin_unlock_irqrestore(&watchdog_lock, *flags);
> +}

I can see why you made that wrapper, but where are the stubs for
!CONFIG_CLOCKSOURCE_WATCHDOG?

Thanks,

	tglx
