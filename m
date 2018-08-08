Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7BEBC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 22:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43B7821AA9
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 22:20:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="LtMW/3Tb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43B7821AA9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731239AbeHIAmG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 20:42:06 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:35979 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729034AbeHIAmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 20:42:05 -0400
Received: by mail-qk0-f196.google.com with SMTP id x192-v6so2733344qkb.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 15:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=gOgE/qUqTSLAsztykgcY3Bk4NZMWCXjygHskHhZyosM=;
        b=LtMW/3TbhDA3KcIwBHHh2Ggvt4iki53cra/274qpBBeRUHYkAyDor+2P95Phpi1tyt
         ePnnLq0E5XLZJvLj112DhTQO2Px6cuCKt2lw1Rw9+Af7wuSktX/R1XqqEYfsFlRQZ1c4
         pXWj/i4tVicvJVRlLFS7/fY80V4a+GJRSdes0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=gOgE/qUqTSLAsztykgcY3Bk4NZMWCXjygHskHhZyosM=;
        b=aYxVrwYEAanq3Qs0fT61pBWoL1Bq0ZmOJvT50Jyp7PX0poZyoxdoLJzInhdEmrFqOP
         CKPrsPuaNnGoEKLekvJWRC2tHxzOxQrNx7EZ7H+7p/AupJpTgVJBC+1QDp9upUzqzCyF
         lDpaRcx6D1p/2l7Gof36SIUKSBnk9v04b/hq58H7flABO1qwnSsyjkSbyIQf1+6ZU/XD
         6PCrGM8kLyEtStWsUzKCo17+JgQSVVzFQ/RKArlyxToxEF9OdjT+gpA7AqVP9DKtePAV
         YjOsoAqtAfzx45pHqCjekPYrZ0uklBttfrMw1b8lPal4/iwsvLp5sjbrQ0/OCnrWz+f2
         bJ4Q==
X-Gm-Message-State: AOUpUlEM9vYObSyPdDJy+rNGqxiYXvhcntliOmW2gz2Y1ND2mkl2g5Ck
        GV6iPDHP1CsyqA7YuoMhdzWTy4D8JJW8iTk4/H3N+LGp
X-Google-Smtp-Source: AA+uWPwUwjDbbkWY+j77u4K9G52NV+hmB2w2uEjJRGjokXzIbAB6u8bU5c3VszeCQlPr0sMDrPLXSin7vI2fEa9iZUc=
X-Received: by 2002:a37:1649:: with SMTP id g70-v6mr4138319qkh.137.1533766823440;
 Wed, 08 Aug 2018 15:20:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:aed:3442:0:0:0:0:0 with HTTP; Wed, 8 Aug 2018 15:20:22 -0700 (PDT)
In-Reply-To: <20180808220022.65184-1-joel@joelfernandes.org>
References: <20180808220022.65184-1-joel@joelfernandes.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 8 Aug 2018 15:20:22 -0700
Message-ID: <CAEXW_YQSRuWVK6jCAnbbepuVwF74VhoASb6rCFduDcv5V0uT0A@mail.gmail.com>
Subject: Re: [PATCH RFC ftrace/core] tracing: Directly call tracer and lockdep probes
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     kernel-team <kernel-team@android.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Byungchul Park <byungchul.park@lge.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 8, 2018 at 3:00 PM, Joel Fernandes (Google)
<joel@joelfernandes.org> wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
>

I realize I kept your authorship since I started working based on your patch ;-)

Well sorry about that, and you could change it to mine or keep it as
is it is if you want ;-)

thanks,

- Joel


> Due to various problems with using tracepoints as probes for IRQ
> enable/disable and preempt enable/disable: such as using SRCU in NMI
> context and other issues with the irqsoff/preemptoff tracer, directly
> call the lockdep and irqsoff tracer probes for now. This keeps all the
> other benefits and clean ups of the patch being partially reverted.
>
> Based on Steve's original Partial revert patch. I added directly calling
> irqsoff tracer probes as well.
>
> Fixes: c3bc8fd637a9 ("tracing: Centralize preemptirq tracepoints and unify their usage")
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
> Steve, I expanded your partial revert such that it fixes the remaining
> issues as well while keeping the clean ups and benefits of my original
> patch. Its based on the latest ftrace/core. I'm still testing it, but it
> works so far. What do you think?  I feel like it could still be a step
> forward for this merge window.
> Also you could drop "tracepoint: Make rcuidle tracepoint callers use
> SRCU" since its not needed anymore for this merge window.
>
> Tests passing so far:
> - ftrace startup tests
> - locking api self-tests
> - manually tested preemptoff and irqsoff tracers
> - manually tested preempt/irq disable and enable events
> - boot tested without warnings
>
>  include/linux/irqflags.h        |  4 ++
>  include/linux/lockdep.h         |  2 -
>  init/main.c                     |  2 -
>  kernel/locking/lockdep.c        | 14 +------
>  kernel/trace/trace.h            | 16 ++++++++
>  kernel/trace/trace_irqsoff.c    | 26 ++-----------
>  kernel/trace/trace_preemptirq.c | 66 ++++++++++++++++++++++++---------
>  7 files changed, 75 insertions(+), 55 deletions(-)
>
> diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
> index 50edb9cbbd26..19a90ac7c87d 100644
> --- a/include/linux/irqflags.h
> +++ b/include/linux/irqflags.h
> @@ -19,9 +19,13 @@
>  #ifdef CONFIG_PROVE_LOCKING
>    extern void trace_softirqs_on(unsigned long ip);
>    extern void trace_softirqs_off(unsigned long ip);
> +  extern void lockdep_hardirqs_on(unsigned long ip);
> +  extern void lockdep_hardirqs_off(unsigned long ip);
>  #else
>  # define trace_softirqs_on(ip) do { } while (0)
>  # define trace_softirqs_off(ip)        do { } while (0)
> +# define lockdep_hardirqs_on(ip) do { } while (0)
> +# define lockdep_hardirqs_off(ip) do { } while (0)
>  #endif
>
>  #ifdef CONFIG_TRACE_IRQFLAGS
> diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
> index a8113357ceeb..b0d0b51c4d85 100644
> --- a/include/linux/lockdep.h
> +++ b/include/linux/lockdep.h
> @@ -267,7 +267,6 @@ struct held_lock {
>   * Initialization, self-test and debugging-output methods:
>   */
>  extern void lockdep_init(void);
> -extern void lockdep_init_early(void);
>  extern void lockdep_reset(void);
>  extern void lockdep_reset_lock(struct lockdep_map *lock);
>  extern void lockdep_free_key_range(void *start, unsigned long size);
> @@ -408,7 +407,6 @@ static inline void lockdep_on(void)
>  # define lock_set_class(l, n, k, s, i)         do { } while (0)
>  # define lock_set_subclass(l, s, i)            do { } while (0)
>  # define lockdep_init()                                do { } while (0)
> -# define lockdep_init_early()                  do { } while (0)
>  # define lockdep_init_map(lock, name, key, sub) \
>                 do { (void)(name); (void)(key); } while (0)
>  # define lockdep_set_class(lock, key)          do { (void)(key); } while (0)
> diff --git a/init/main.c b/init/main.c
> index 44fe43be84c1..5d42e577643a 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -649,8 +649,6 @@ asmlinkage __visible void __init start_kernel(void)
>         call_function_init();
>         WARN(!irqs_disabled(), "Interrupts were enabled early\n");
>
> -       lockdep_init_early();
> -
>         early_boot_irqs_disabled = false;
>         local_irq_enable();
>
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index 03bfaeb9f4e6..e406c5fdb41e 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -2840,8 +2840,7 @@ static void __trace_hardirqs_on_caller(unsigned long ip)
>         debug_atomic_inc(hardirqs_on_events);
>  }
>
> -static void lockdep_hardirqs_on(void *none, unsigned long ignore,
> -                               unsigned long ip)
> +void lockdep_hardirqs_on(unsigned long ip)
>  {
>         if (unlikely(!debug_locks || current->lockdep_recursion))
>                 return;
> @@ -2885,8 +2884,7 @@ static void lockdep_hardirqs_on(void *none, unsigned long ignore,
>  /*
>   * Hardirqs were disabled:
>   */
> -static void lockdep_hardirqs_off(void *none, unsigned long ignore,
> -                                unsigned long ip)
> +void lockdep_hardirqs_off(unsigned long ip)
>  {
>         struct task_struct *curr = current;
>
> @@ -4315,14 +4313,6 @@ void lockdep_reset_lock(struct lockdep_map *lock)
>         raw_local_irq_restore(flags);
>  }
>
> -void __init lockdep_init_early(void)
> -{
> -#ifdef CONFIG_PROVE_LOCKING
> -       register_trace_prio_irq_disable(lockdep_hardirqs_off, NULL, INT_MAX);
> -       register_trace_prio_irq_enable(lockdep_hardirqs_on, NULL, INT_MIN);
> -#endif
> -}
> -
>  void __init lockdep_init(void)
>  {
>         printk("Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar\n");
> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> index e1c8a1d6f240..74db16fe1fab 100644
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -1829,4 +1829,20 @@ static inline int tracing_alloc_snapshot_instance(struct trace_array *tr)
>
>  extern struct trace_iterator *tracepoint_print_iter;
>
> +#ifdef CONFIG_IRQSOFF_TRACER
> +void tracer_hardirqs_on(void *none, unsigned long a0, unsigned long a1);
> +void tracer_hardirqs_off(void *none, unsigned long a0, unsigned long a1);
> +#else
> +void tracer_hardirqs_on(void *none, unsigned long a0, unsigned long a1) { }
> +void tracer_hardirqs_off(void *none, unsigned long a0, unsigned long a1) { }
> +#endif
> +
> +#ifdef CONFIG_PREEMPT_TRACER
> +void tracer_preempt_on(void *none, unsigned long a0, unsigned long a1);
> +void tracer_preempt_off(void *none, unsigned long a0, unsigned long a1);
> +#else
> +void tracer_preempt_on(void *none, unsigned long a0, unsigned long a1) { }
> +void tracer_preempt_off(void *none, unsigned long a0, unsigned long a1) { }
> +#endif
> +
>  #endif /* _LINUX_KERNEL_TRACE_H */
> diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.c
> index 770cd30cda40..d61d42e431e9 100644
> --- a/kernel/trace/trace_irqsoff.c
> +++ b/kernel/trace/trace_irqsoff.c
> @@ -601,13 +601,13 @@ static void irqsoff_tracer_stop(struct trace_array *tr)
>  /*
>   * We are only interested in hardirq on/off events:
>   */
> -static void tracer_hardirqs_on(void *none, unsigned long a0, unsigned long a1)
> +void tracer_hardirqs_on(void *none, unsigned long a0, unsigned long a1)
>  {
>         if (!preempt_trace() && irq_trace())
>                 stop_critical_timing(a0, a1);
>  }
>
> -static void tracer_hardirqs_off(void *none, unsigned long a0, unsigned long a1)
> +void tracer_hardirqs_off(void *none, unsigned long a0, unsigned long a1)
>  {
>         if (!preempt_trace() && irq_trace())
>                 start_critical_timing(a0, a1);
> @@ -617,15 +617,11 @@ static int irqsoff_tracer_init(struct trace_array *tr)
>  {
>         trace_type = TRACER_IRQS_OFF;
>
> -       register_trace_irq_disable(tracer_hardirqs_off, NULL);
> -       register_trace_irq_enable(tracer_hardirqs_on, NULL);
>         return __irqsoff_tracer_init(tr);
>  }
>
>  static void irqsoff_tracer_reset(struct trace_array *tr)
>  {
> -       unregister_trace_irq_disable(tracer_hardirqs_off, NULL);
> -       unregister_trace_irq_enable(tracer_hardirqs_on, NULL);
>         __irqsoff_tracer_reset(tr);
>  }
>
> @@ -651,13 +647,13 @@ static struct tracer irqsoff_tracer __read_mostly =
>  #endif /*  CONFIG_IRQSOFF_TRACER */
>
>  #ifdef CONFIG_PREEMPT_TRACER
> -static void tracer_preempt_on(void *none, unsigned long a0, unsigned long a1)
> +void tracer_preempt_on(void *none, unsigned long a0, unsigned long a1)
>  {
>         if (preempt_trace() && !irq_trace())
>                 stop_critical_timing(a0, a1);
>  }
>
> -static void tracer_preempt_off(void *none, unsigned long a0, unsigned long a1)
> +void tracer_preempt_off(void *none, unsigned long a0, unsigned long a1)
>  {
>         if (preempt_trace() && !irq_trace())
>                 start_critical_timing(a0, a1);
> @@ -667,15 +663,11 @@ static int preemptoff_tracer_init(struct trace_array *tr)
>  {
>         trace_type = TRACER_PREEMPT_OFF;
>
> -       register_trace_preempt_disable(tracer_preempt_off, NULL);
> -       register_trace_preempt_enable(tracer_preempt_on, NULL);
>         return __irqsoff_tracer_init(tr);
>  }
>
>  static void preemptoff_tracer_reset(struct trace_array *tr)
>  {
> -       unregister_trace_preempt_disable(tracer_preempt_off, NULL);
> -       unregister_trace_preempt_enable(tracer_preempt_on, NULL);
>         __irqsoff_tracer_reset(tr);
>  }
>
> @@ -706,21 +698,11 @@ static int preemptirqsoff_tracer_init(struct trace_array *tr)
>  {
>         trace_type = TRACER_IRQS_OFF | TRACER_PREEMPT_OFF;
>
> -       register_trace_irq_disable(tracer_hardirqs_off, NULL);
> -       register_trace_irq_enable(tracer_hardirqs_on, NULL);
> -       register_trace_preempt_disable(tracer_preempt_off, NULL);
> -       register_trace_preempt_enable(tracer_preempt_on, NULL);
> -
>         return __irqsoff_tracer_init(tr);
>  }
>
>  static void preemptirqsoff_tracer_reset(struct trace_array *tr)
>  {
> -       unregister_trace_irq_disable(tracer_hardirqs_off, NULL);
> -       unregister_trace_irq_enable(tracer_hardirqs_on, NULL);
> -       unregister_trace_preempt_disable(tracer_preempt_off, NULL);
> -       unregister_trace_preempt_enable(tracer_preempt_on, NULL);
> -
>         __irqsoff_tracer_reset(tr);
>  }
>
> diff --git a/kernel/trace/trace_preemptirq.c b/kernel/trace/trace_preemptirq.c
> index e76b78bf258e..bd5654e9f886 100644
> --- a/kernel/trace/trace_preemptirq.c
> +++ b/kernel/trace/trace_preemptirq.c
> @@ -9,6 +9,7 @@
>  #include <linux/uaccess.h>
>  #include <linux/module.h>
>  #include <linux/ftrace.h>
> +#include "trace.h"
>
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/preemptirq.h>
> @@ -19,54 +20,85 @@ static DEFINE_PER_CPU(int, tracing_irq_cpu);
>
>  void trace_hardirqs_on(void)
>  {
> -       if (!this_cpu_read(tracing_irq_cpu))
> -               return;
> +       if (this_cpu_read(tracing_irq_cpu)) {
> +               trace_irq_enable_rcuidle(CALLER_ADDR0, CALLER_ADDR1);
>
> -       trace_irq_enable_rcuidle(CALLER_ADDR0, CALLER_ADDR1);
> -       this_cpu_write(tracing_irq_cpu, 0);
> +               /* irqsoff tracer */
> +               tracer_hardirqs_on(NULL /* unused */, CALLER_ADDR0, CALLER_ADDR1);
> +
> +               this_cpu_write(tracing_irq_cpu, 0);
> +       }
> +
> +       /* Call last so future IRQ state is noted last */
> +       lockdep_hardirqs_on(CALLER_ADDR0);
>  }
>  EXPORT_SYMBOL(trace_hardirqs_on);
>
>  void trace_hardirqs_off(void)
>  {
> -       if (this_cpu_read(tracing_irq_cpu))
> -               return;
> +       /* Call first so IRQ state is updated */
> +       lockdep_hardirqs_off(CALLER_ADDR0);
> +
> +       if (!this_cpu_read(tracing_irq_cpu)) {
> +               /* prevent recursion */
> +               this_cpu_write(tracing_irq_cpu, 1);
>
> -       this_cpu_write(tracing_irq_cpu, 1);
> -       trace_irq_disable_rcuidle(CALLER_ADDR0, CALLER_ADDR1);
> +               trace_irq_disable_rcuidle(CALLER_ADDR0, CALLER_ADDR1);
> +
> +               /* irqsoff tracer */
> +               tracer_hardirqs_off(NULL /* unused */, CALLER_ADDR0, CALLER_ADDR1);
> +       }
>  }
>  EXPORT_SYMBOL(trace_hardirqs_off);
>
>  __visible void trace_hardirqs_on_caller(unsigned long caller_addr)
>  {
> -       if (!this_cpu_read(tracing_irq_cpu))
> -               return;
> +       if (this_cpu_read(tracing_irq_cpu)) {
> +               trace_irq_enable_rcuidle(CALLER_ADDR0, caller_addr);
> +
> +               /* irqsoff tracer */
> +               tracer_hardirqs_on(NULL /* unused */, CALLER_ADDR0, caller_addr);
> +
> +               this_cpu_write(tracing_irq_cpu, 0);
> +       }
>
> -       trace_irq_enable_rcuidle(CALLER_ADDR0, caller_addr);
> -       this_cpu_write(tracing_irq_cpu, 0);
> +       /* Call last so future IRQ state is noted last */
> +       lockdep_hardirqs_on(CALLER_ADDR0);
>  }
>  EXPORT_SYMBOL(trace_hardirqs_on_caller);
>
>  __visible void trace_hardirqs_off_caller(unsigned long caller_addr)
>  {
> -       if (this_cpu_read(tracing_irq_cpu))
> -               return;
> +       /* Call first so IRQ state is updated */
> +       lockdep_hardirqs_off(CALLER_ADDR0);
>
> -       this_cpu_write(tracing_irq_cpu, 1);
> -       trace_irq_disable_rcuidle(CALLER_ADDR0, caller_addr);
> +       if (!this_cpu_read(tracing_irq_cpu)) {
> +               /* prevent recursion */
> +               this_cpu_write(tracing_irq_cpu, 1);
> +
> +               trace_irq_disable_rcuidle(CALLER_ADDR0, CALLER_ADDR1);
> +
> +               /* irqsoff tracer */
> +               tracer_hardirqs_off(NULL /* unused */, CALLER_ADDR0, CALLER_ADDR1);
> +       }
>  }
>  EXPORT_SYMBOL(trace_hardirqs_off_caller);
>  #endif /* CONFIG_TRACE_IRQFLAGS */
>
>  #ifdef CONFIG_TRACE_PREEMPT_TOGGLE
> -
>  void trace_preempt_on(unsigned long a0, unsigned long a1)
>  {
>         trace_preempt_enable_rcuidle(a0, a1);
> +
> +       /* preemptoff tracer */
> +       tracer_preempt_on(NULL /* unused */, a0, a1);
>  }
>
>  void trace_preempt_off(unsigned long a0, unsigned long a1)
>  {
>         trace_preempt_disable_rcuidle(a0, a1);
> +
> +       /* preemptoff tracer */
> +       tracer_preempt_off(NULL /* unused */, a0, a1);
>  }
>  #endif
> --
> 2.18.0.597.ga71716f1ad-goog
>
