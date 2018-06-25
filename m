Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF73C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 08:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 793F0208AF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 08:23:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uwAjtp79"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 793F0208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753149AbeFYIXg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 04:23:36 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:37154 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752834AbeFYIXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 04:23:32 -0400
Received: by mail-ot0-f196.google.com with SMTP id u6-v6so5948379otk.4;
        Mon, 25 Jun 2018 01:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=8vqQPQxJmeJwehPwydFo05DSf7w1G0iTPUQeNxo9GBk=;
        b=uwAjtp7901EOaJwiTQ9G1yFGdrLklAV94te/Rslh/jFD8aVQdCwyJ5MXeX8jNerOfV
         0ZvtaDkXuuc8SCJdtEZczgBSPg8XoxOzF1aOyDzga7ciI0WKE33HpZA/F+ih73lbICp4
         WgdqwTCOlRRWHak6n89RhtUdEbQYAEd3nlPLujrE/+7NnL7aHkK83sKkci5YqsTPZgjx
         kW8gH83ZW5E28+G4IBL9CbtwkfPAO+MYmIcH7XF42+r/ufp99UrH3hyeSb6DorbW8gSF
         2nH5of2VsRSseWTHcF7zoCPlOJrDPQdVIcT02WErLJL3ocTl5ehujzFEHGizsd22E9Nj
         U9CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=8vqQPQxJmeJwehPwydFo05DSf7w1G0iTPUQeNxo9GBk=;
        b=lyDuT5IGUo1UvYdMxHcsc47Ic3POi5uWB6wSwQVVejUzUx51ORkVdMf5X/4UEqpuIp
         z4UktMwLCSpHTIHNHL9mMxe4Zr2iTL+lvbWCp0W8ajlrWCGgUWasAVm/2lkWmvVHrv6W
         R//o6zyKAVyn8xU0xMfCc9Z2vqxlLxMTMalTl4FyXkUvvrni/b6LjXDaae9tDMKIz1bL
         MkK4gL32lzFXkss7sJSHIxZyOD+mu0/pHFXN9mwUAIdesdRK2xOVi/G6tGuQvbf+f/+f
         uLSKMQIOPJeM5sUM3y8u1xb8O88WIpfnX9giK+erYmJJo5w+8F8UJz3nShHrfckEl+Uv
         ddbg==
X-Gm-Message-State: APt69E3hQ2+b9Yf80fDl6x6gWGIMXr9pWZI5bRdG677nmXN9rv9Y4M9T
        DQeMF3Yf2iZ4iafplbiFt31iCSGeF9b3jYTBTMI=
X-Google-Smtp-Source: AAOMgpcwNksRhxRlZuNqEArtKTu5y74FlBeUHmEYzyjSqoj7K0PbNPx8LKrCiHTbVOebT7SXYk+LMezZ1pAH+BFk2Pk=
X-Received: by 2002:a9d:3e4c:: with SMTP id h12-v6mr2358314otg.150.1529915011981;
 Mon, 25 Jun 2018 01:23:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1429:0:0:0:0:0 with HTTP; Mon, 25 Jun 2018 01:23:31
 -0700 (PDT)
In-Reply-To: <1529414627-5638-1-git-send-email-daniel.lezcano@linaro.org>
References: <1529414627-5638-1-git-send-email-daniel.lezcano@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 25 Jun 2018 10:23:31 +0200
X-Google-Sender-Auth: FMNTIvqJNFDvV-qPqA79Juk9eGM
Message-ID: <CAJZ5v0iyS7wUx5sYnyhZxhRD7EMEWyKzcpBu7vXUGxuwM4+prw@mail.gmail.com>
Subject: Re: [PATCH V9] powercap/drivers/idle_injection: Add an idle injection framework
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Kevin Wangtao <kevin.wangtao@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rui Zhang <rui.zhang@intel.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        "open list:POWER MANAGEMENT CORE" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 3:23 PM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
> Initially, the cpu_cooling device for ARM was changed by adding a new
> policy inserting idle cycles. The intel_powerclamp driver does a
> similar action.
>
> Instead of implementing idle injections privately in the cpu_cooling
> device, move the idle injection code in a dedicated framework and give
> the opportunity to other frameworks to make use of it.
>
> The framework relies on the smpboot kthreads which handles via its
> main loop the common code for hotplugging and [un]parking.
>
> This code was previously tested with the cpu cooling device and went
> through several iterations. It results now in split code and API
> exported in the header file. It was tested with the cpu cooling device
> with success.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Eduardo Valentin <edubezval@gmail.com>
> Cc: Javi Merino <javi.merino@kernel.org>
> Cc: Leo Yan <leo.yan@linaro.org>
> Cc: Kevin Wangtao <kevin.wangtao@linaro.org>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Rui Zhang <rui.zhang@intel.com>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Andrea Parri <andrea.parri@amarulasolutions.com>
> ---
>
> V9:
>    - Unconditionnally reset the should_run flag for all kthreads
>      belonging to the cpumask and remove the park() callback (Viresh Kumar)
>    - Fix up the typos in the comments (Viresh Kumar)
>
> V8:
>    - Rollback only what was modified
>    - Add the park() callback to reset the should_run flag
>
> V7:
>    - Replace count approach by htimer_forward and restart (Peter Zijlstra)
>    - Wait for task inactive when stopping the idle injections
>    - Changed the comments and description
>
> V6:
>    - Move count to wake up function (Viresh Kumar)
>    - Split atomic/non-atomic context to wake up tasks
>    - Add the park callback to handle unplug/inject race
>    - Replace atomic by READ_ONCE and WRITE_ONCE (Peter Zijlstra)
>
> V5:
>    - Move init_completion in the init function (Viresh Kumar)
>    - Increment task count in the wakeup function (Viresh Kumar)
>    - Remove rollback at init time (Viresh Kumar)
>
> V4:
>    - Wait for completion when stopping (Viresh Kumar)
>    - Check init already done and rollback (Viresh Kumar)
>
> V3:
>    - Fixed typos (Viresh Kumar)
>    - Removed extra blank line (Viresh Kumar)
>    - Added full stop (Viresh Kumar)
>    - Fixed Return kerneldoc format (Viresh Kumar)
>    - Fixed multiple kthreads initialization (Viresh Kumar)
>    - Fixed rollbacking the actions in the unregister function (Viresh Kumar)
>    - Make idle injection kthreads name hardcoded
>    - Kthreads are created in the initcall process
>
>  V2: Fixed checkpatch warnings
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/powercap/Kconfig          |  10 ++
>  drivers/powercap/Makefile         |   1 +
>  drivers/powercap/idle_injection.c | 362 ++++++++++++++++++++++++++++++++++++++
>  include/linux/idle_injection.h    |  29 +++
>  4 files changed, 402 insertions(+)
>  create mode 100644 drivers/powercap/idle_injection.c
>  create mode 100644 include/linux/idle_injection.h
>
> diff --git a/drivers/powercap/Kconfig b/drivers/powercap/Kconfig
> index 85727ef..a767ef2 100644
> --- a/drivers/powercap/Kconfig
> +++ b/drivers/powercap/Kconfig
> @@ -29,4 +29,14 @@ config INTEL_RAPL
>           controller, CPU core (Power Plance 0), graphics uncore (Power Plane
>           1), etc.
>
> +config IDLE_INJECTION
> +       bool "Idle injection framework"
> +       depends on CPU_IDLE
> +       default n
> +       help
> +         This enables support for the idle injection framework. It
> +         provides a way to force idle periods on a set of specified
> +         CPUs for power capping. Idle period can be injected
> +         synchronously on a set of specified CPUs or alternatively
> +         on a per CPU basis.
>  endif
> diff --git a/drivers/powercap/Makefile b/drivers/powercap/Makefile
> index 0a21ef3..c3bbfee 100644
> --- a/drivers/powercap/Makefile
> +++ b/drivers/powercap/Makefile
> @@ -1,2 +1,3 @@
>  obj-$(CONFIG_POWERCAP) += powercap_sys.o
>  obj-$(CONFIG_INTEL_RAPL) += intel_rapl.o
> +obj-$(CONFIG_IDLE_INJECTION) += idle_injection.o
> diff --git a/drivers/powercap/idle_injection.c b/drivers/powercap/idle_injection.c
> new file mode 100644
> index 0000000..50ce348
> --- /dev/null
> +++ b/drivers/powercap/idle_injection.c
> @@ -0,0 +1,362 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2018 Linaro Limited
> + *
> + * Author: Daniel Lezcano <daniel.lezcano@linaro.org>
> + *
> + * The idle injection framework proposes a way to force a cpu to enter
> + * an idle state during a specified amount of time for a specified
> + * period.
> + *
> + * It relies on the smpboot kthreads which handles, via its main loop,
> + * the common code for hotplugging and [un]parking.
> + *
> + * At init time, all the kthreads are created.
> + *
> + * A cpumask is specified as parameter for the idle injection
> + * registering function. The kthreads will be synchronized regarding
> + * this cpumask.
> + *
> + * The idle + run duration is specified via the helpers and then the
> + * idle injection can be started at this point.
> + *
> + * A kthread will call play_idle() with the specified idle duration
> + * from above.
> + *
> + * A timer is set after waking up all the tasks, to the next idle
> + * injection cycle.
> + *
> + * The task handling the timer interrupt will wakeup all the kthreads
> + * belonging to the cpumask.
> + *
> + * Stopping the idle injection is synchronous, when the function
> + * returns, there is the guarantee there is no more idle injection
> + * kthread in activity.
> + *
> + * It is up to the user of this framework to provide a lock at an
> + * upper level to prevent stupid things to happen, like starting while
> + * we are unregistering.
> + */

The English above and elsewhere needs some polishing IMO, but I can
take care of that. :-)

> +#define pr_fmt(fmt) "ii_dev: " fmt
> +
> +#include <linux/cpu.h>
> +#include <linux/freezer.h>
> +#include <linux/hrtimer.h>
> +#include <linux/kthread.h>
> +#include <linux/sched.h>
> +#include <linux/slab.h>
> +#include <linux/smpboot.h>
> +
> +#include <uapi/linux/sched/types.h>
> +
> +/**
> + * struct idle_injection_thread - task on/off switch structure
> + * @tsk: a pointer to a task_struct injecting the idle cycles
> + * @should_run: a integer used as a boolean by the smpboot kthread API
> + */
> +struct idle_injection_thread {
> +       struct task_struct *tsk;
> +       int should_run;
> +};
> +
> +/**
> + * struct idle_injection_device - data for the idle injection
> + * @timer: a hrtimer giving the tempo for the idle injection
> + * @idle_duration_ms: an unsigned int specifying the idle duration
> + * @run_duration_ms: an unsigned int specifying the running duration
> + * @cpumask: a cpumask containing the list of CPUs managed by the device
> + */
> +struct idle_injection_device {
> +       struct hrtimer timer;
> +       unsigned int idle_duration_ms;
> +       unsigned int run_duration_ms;
> +       unsigned long int cpumask[0];
> +};
> +
> +static DEFINE_PER_CPU(struct idle_injection_thread, idle_injection_thread);
> +static DEFINE_PER_CPU(struct idle_injection_device *, idle_injection_device);
> +
> +/**
> + * idle_injection_wakeup - Wake up all idle injection threads
> + * @ii_dev: the idle injection device
> + *
> + * Every idle injection task belonging to the idle injection device
> + * and running on an online CPU will be wake up by this call.
> + */
> +static void idle_injection_wakeup(struct idle_injection_device *ii_dev)
> +{
> +       struct idle_injection_thread *iit;
> +       unsigned int cpu;
> +
> +       for_each_cpu_and(cpu, to_cpumask(ii_dev->cpumask), cpu_online_mask) {
> +               iit = per_cpu_ptr(&idle_injection_thread, cpu);
> +               iit->should_run = 1;
> +               wake_up_process(iit->tsk);
> +       }
> +}
> +
> +/**
> + * idle_injection_wakeup_fn - idle injection timer callback
> + * @timer: a hrtimer structure
> + *
> + * This function is called when the idle injection timer expires which
> + * will wake up the idle injection tasks and these ones, in turn, play
> + * idle a specified amount of time.
> + *
> + * Return: HRTIMER_RESTART.
> + */
> +static enum hrtimer_restart idle_injection_wakeup_fn(struct hrtimer *timer)
> +{
> +       unsigned int duration_ms;
> +       struct idle_injection_device *ii_dev =
> +               container_of(timer, struct idle_injection_device, timer);
> +
> +       duration_ms = READ_ONCE(ii_dev->run_duration_ms);
> +       duration_ms += READ_ONCE(ii_dev->idle_duration_ms);
> +
> +       idle_injection_wakeup(ii_dev);
> +
> +       hrtimer_forward_now(timer, ms_to_ktime(duration_ms));
> +
> +       return HRTIMER_RESTART;
> +}
> +
> +/**
> + * idle_injection_fn - idle injection routine
> + * @cpu: the CPU number the task belongs to
> + *
> + * The idle injection routine will stay idle the specified amount of
> + * time
> + */
> +static void idle_injection_fn(unsigned int cpu)
> +{
> +       struct idle_injection_device *ii_dev;
> +       struct idle_injection_thread *iit;
> +
> +       ii_dev = per_cpu(idle_injection_device, cpu);
> +       iit = per_cpu_ptr(&idle_injection_thread, cpu);
> +
> +       /*
> +        * Boolean used by the smpboot main loop and used as a
> +        * flip-flop in this function
> +        */
> +       iit->should_run = 0;
> +
> +       play_idle(READ_ONCE(ii_dev->idle_duration_ms));
> +}
> +
> +/**
> + * idle_injection_set_duration - idle and run duration helper
> + * @run_duration_ms: an unsigned int giving the running time in milliseconds
> + * @idle_duration_ms: an unsigned int giving the idle time in milliseconds
> + */
> +void idle_injection_set_duration(struct idle_injection_device *ii_dev,
> +                                unsigned int run_duration_ms,
> +                                unsigned int idle_duration_ms)
> +{
> +       if (run_duration_ms && idle_duration_ms) {
> +               WRITE_ONCE(ii_dev->run_duration_ms, run_duration_ms);
> +               WRITE_ONCE(ii_dev->idle_duration_ms, idle_duration_ms);
> +       }
> +}
> +
> +/**
> + * idle_injection_get_duration - idle and run duration helper
> + * @run_duration_ms: a pointer to an unsigned int to store the running time
> + * @idle_duration_ms: a pointer to an unsigned int to store the idle time
> + */
> +void idle_injection_get_duration(struct idle_injection_device *ii_dev,
> +                                unsigned int *run_duration_ms,
> +                                unsigned int *idle_duration_ms)
> +{
> +       *run_duration_ms = READ_ONCE(ii_dev->run_duration_ms);
> +       *idle_duration_ms = READ_ONCE(ii_dev->idle_duration_ms);

Should you check the arguments against NULL before attempting to
dereference them?  If not, then why not?

> +}
> +
> +/**
> + * idle_injection_start - starts the idle injections
> + * @ii_dev: a pointer to an idle_injection_device structure
> + *
> + * The function starts the idle injection cycles by first waking up
> + * all the tasks the ii_dev is attached to and let them handle the
> + * idle-run periods.
> + *
> + * Return: -EINVAL if the idle or the running durations are not set.
> + */
> +int idle_injection_start(struct idle_injection_device *ii_dev)
> +{
> +       unsigned int idle_duration_ms = READ_ONCE(ii_dev->idle_duration_ms);
> +       unsigned int run_duration_ms = READ_ONCE(ii_dev->run_duration_ms);
> +
> +       if (!idle_duration_ms || !run_duration_ms)
> +               return -EINVAL;
> +
> +       pr_debug("Starting injecting idle cycles on CPUs '%*pbl'\n",
> +                cpumask_pr_args(to_cpumask(ii_dev->cpumask)));
> +
> +       idle_injection_wakeup(ii_dev);
> +
> +       hrtimer_start(&ii_dev->timer,
> +                     ms_to_ktime(idle_duration_ms + run_duration_ms),
> +                     HRTIMER_MODE_REL);
> +
> +       return 0;
> +}
> +
> +/**
> + * idle_injection_stop - stops the idle injections
> + * @ii_dev: a pointer to an idle injection_device structure
> + *
> + * The function stops the idle injection and waits for the threads to
> + * complete. If we are in the process of injecting an idle cycle, then
> + * this will wait the end of the cycle.
> + *
> + * When the function returns there is no more idle injection
> + * activity. The kthreads are scheduled out and the periodic timer is
> + * off.
> + */
> +void idle_injection_stop(struct idle_injection_device *ii_dev)
> +{
> +       struct idle_injection_thread *iit;
> +       unsigned int cpu;
> +
> +       pr_debug("Stopping injecting idle cycles on CPUs '%*pbl'\n",
> +                cpumask_pr_args(to_cpumask(ii_dev->cpumask)));
> +
> +       hrtimer_cancel(&ii_dev->timer);
> +
> +       /*
> +        * We want the guarantee we have a quiescent point where
> +        * parked threads stay in there state while we are stopping
> +        * the idle injection. After exiting the loop, if any CPU is
> +        * plugged in, the 'should_run' boolean being false, the
> +        * smpboot main loop schedules the task out.
> +        */
> +       cpu_hotplug_disable();
> +
> +       /*
> +        * Iterate over all (online + offline) CPUs here in case a CPU
> +        * got hotplugged out with "should_run" set to "1" and the
> +        * thread may start running again after the ii_dev is freed
> +        * and the CPU gets hotplugged in.
> +        */
> +       for_each_cpu(cpu, to_cpumask(ii_dev->cpumask)) {
> +               iit = per_cpu_ptr(&idle_injection_thread, cpu);
> +               iit->should_run = 0;
> +
> +               wait_task_inactive(iit->tsk, 0);
> +       }
> +
> +       cpu_hotplug_enable();
> +}
> +
> +/**
> + * idle_injection_setup - initialize the current task as a RT task
> + * @cpu: the CPU number where the kthread is running on (not used)
> + *
> + * Called one time, this function is in charge of setting the task
> + * scheduler parameters.
> + */
> +static void idle_injection_setup(unsigned int cpu)
> +{
> +       struct sched_param param = { .sched_priority = MAX_USER_RT_PRIO / 2 };
> +
> +       set_freezable();

Why do you need set_freezable() here?

> +
> +       sched_setscheduler(current, SCHED_FIFO, &param);
> +}
