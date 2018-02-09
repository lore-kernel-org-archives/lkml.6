Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751092AbeBIGxt (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 01:53:49 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40598 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750828AbeBIGxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 01:53:47 -0500
X-Google-Smtp-Source: AH8x226JB4BFioBFxcpXSJSKO1Q06GQ1ivX9Kp3lDgVKAujoqPfFeKzHwWDBHMwwdWQK1HfCrl+x3A==
Date: Fri, 9 Feb 2018 07:53:43 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        Christoph Lameter <cl@linux.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Wanpeng Li <kernellwp@gmail.com>, Mike Galbraith <efault@gmx.de>,
        Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH 1/6] sched: Rename init_rq_hrtick to hrtick_rq_init
Message-ID: <20180209065343.iucv5tgiq2fjpe3v@gmail.com>
References: <1518112779-30196-1-git-send-email-frederic@kernel.org>
 <1518112779-30196-2-git-send-email-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518112779-30196-2-git-send-email-frederic@kernel.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Frederic Weisbecker <frederic@kernel.org> wrote:

> Do that rename in order to normalize the hrtick namespace.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Cc: Chris Metcalf <cmetcalf@mellanox.com>
> Cc: Christoph Lameter <cl@linux.com>
> Cc: Luiz Capitulino <lcapitulino@redhat.com>
> Cc: Mike Galbraith <efault@gmx.de>
> Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Rik van Riel <riel@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Wanpeng Li <kernellwp@gmail.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> ---
>  kernel/sched/core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 36f113a..fc9fa25 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -333,7 +333,7 @@ void hrtick_start(struct rq *rq, u64 delay)
>  }
>  #endif /* CONFIG_SMP */
>  
> -static void init_rq_hrtick(struct rq *rq)
> +static void hrtick_rq_init(struct rq *rq)

On a related note, I think we should also do:

s/start_hrtick_dl
 /sched_dl_hrtick_start

or such. (In a separate patch)

Thanks,

	Ingo
