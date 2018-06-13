Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id ADBCEC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 15:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 440DC2086A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 15:54:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 440DC2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935830AbeFMPyX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 11:54:23 -0400
Received: from mga01.intel.com ([192.55.52.88]:13039 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935694AbeFMPyW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 11:54:22 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jun 2018 08:54:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,219,1526367600"; 
   d="p7s'?scan'208";a="232300375"
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
  by orsmga005.jf.intel.com with ESMTP; 13 Jun 2018 08:54:20 -0700
Received: from orsmsx151.amr.corp.intel.com (10.22.226.38) by
 ORSMSX109.amr.corp.intel.com (10.22.240.7) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 13 Jun 2018 08:54:20 -0700
Received: from orsmsx109.amr.corp.intel.com ([169.254.11.237]) by
 ORSMSX151.amr.corp.intel.com ([10.22.226.38]) with mapi id 14.03.0319.002;
 Wed, 13 Jun 2018 08:54:20 -0700
From:   "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
To:     "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "andrea.parri@amarulasolutions.com" 
        <andrea.parri@amarulasolutions.com>,
        "kevin.wangtao@linaro.org" <kevin.wangtao@linaro.org>,
        "leo.yan@linaro.org" <leo.yan@linaro.org>,
        "daniel.thompson@linaro.org" <daniel.thompson@linaro.org>,
        "javi.merino@kernel.org" <javi.merino@kernel.org>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>
Subject: Re: [PATCH V6] powercap/drivers/idle_injection: Add an idle
 injection framework
Thread-Topic: [PATCH V6] powercap/drivers/idle_injection: Add an idle
 injection framework
Thread-Index: AQHUAy7K0hOWsj2UDUW8/aeIJzxwIQ==
Date:   Wed, 13 Jun 2018 15:54:19 +0000
Message-ID: <1528905257.48473.4.camel@intel.com>
References: <1528804816-32636-1-git-send-email-daniel.lezcano@linaro.org>
In-Reply-To: <1528804816-32636-1-git-send-email-daniel.lezcano@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [10.54.75.31]
Content-Type: multipart/signed; micalg=sha-1;
        protocol="application/x-pkcs7-signature"; boundary="=-Euj0MQZdGE4PU87b1vmp"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-Euj0MQZdGE4PU87b1vmp
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2018-06-12 at 14:00 +0200, Daniel Lezcano wrote:
> Initially, the cpu_cooling device for ARM was changed by adding a new
> policy inserting idle cycles. The intel_powerclamp driver does a
> similar action.
>=20
> Instead of implementing idle injections privately in the cpu_cooling
> device, move the idle injection code in a dedicated framework and
> give
> the opportunity to other frameworks to make use of it.
>=20
> The framework relies on the smpboot kthreads which handles via its
> main loop the common code for hotplugging and [un]parking.
>=20
> This code was previously tested with the cpu cooling device and went
> through several iterations. It results now in split code and API
> exported in the header file. It was tested with the cpu cooling
> device
> with success.
>=20
May be I have missed, but I don't see any use of powercap sysfs.

We created powercap sys that user space is presented a common interface
for power capping. The RAPL driver was also submitted as cooling device
before, but suggestion was to create this powercap.

So if powercap interface is not enough then may be we should enhance
that.

Thanks,
Srinivas

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
> V6:
>    - Move count to wake up function (Viresh Kumar)
>    - Split atomic/non-atomic context to wake up tasks
>    - Add the park callback to handle unplug/inject race
>    - Replace atomic by READ_ONCE and WRITE_ONCE (Peter Zijlstra)
>=20
> V5:
>    - Move init_completion in the init function (Viresh Kumar)
>    - Increment task count in the wakeup function (Viresh Kumar)
>    - Remove rollback at init time (Viresh Kumar)
>=20
> V4:
>    - Wait for completion when stopping (Viresh Kumar)
>    - Check init already done and rollback (Viresh Kumar)
>=20
> V3:
>    - Fixed typos (Viresh Kumar)
>    - Removed extra blank line (Viresh Kumar)
>    - Added full stop (Viresh Kumar)
>    - Fixed Return kerneldoc format (Viresh Kumar)
>    - Fixed multiple kthreads initialization (Viresh Kumar)
>    - Fixed rollbacking the actions in the unregister function (Viresh
> Kumar)
>    - Make idle injection kthreads name hardcoded
>    - Kthreads are created in the initcall process
>=20
>  V2: Fixed checkpatch warnings
>=20
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/powercap/Kconfig          |  10 +
>  drivers/powercap/Makefile         |   1 +
>  drivers/powercap/idle_injection.c | 414
> ++++++++++++++++++++++++++++++++++++++
>  include/linux/idle_injection.h    |  29 +++
>  4 files changed, 454 insertions(+)
>  create mode 100644 drivers/powercap/idle_injection.c
>  create mode 100644 include/linux/idle_injection.h
>=20
> diff --git a/drivers/powercap/Kconfig b/drivers/powercap/Kconfig
> index 85727ef..a767ef2 100644
> --- a/drivers/powercap/Kconfig
> +++ b/drivers/powercap/Kconfig
> @@ -29,4 +29,14 @@ config INTEL_RAPL
>  	  controller, CPU core (Power Plance 0), graphics uncore
> (Power Plane
>  	  1), etc.
> =20
> +config IDLE_INJECTION
> +	bool "Idle injection framework"
> +	depends on CPU_IDLE
> +	default n
> +	help
> +	  This enables support for the idle injection framework. It
> +	  provides a way to force idle periods on a set of specified
> +	  CPUs for power capping. Idle period can be injected
> +	  synchronously on a set of specified CPUs or alternatively
> +	  on a per CPU basis.
>  endif
> diff --git a/drivers/powercap/Makefile b/drivers/powercap/Makefile
> index 0a21ef3..c3bbfee 100644
> --- a/drivers/powercap/Makefile
> +++ b/drivers/powercap/Makefile
> @@ -1,2 +1,3 @@
>  obj-$(CONFIG_POWERCAP)	+=3D powercap_sys.o
>  obj-$(CONFIG_INTEL_RAPL) +=3D intel_rapl.o
> +obj-$(CONFIG_IDLE_INJECTION) +=3D idle_injection.o
> diff --git a/drivers/powercap/idle_injection.c
> b/drivers/powercap/idle_injection.c
> new file mode 100644
> index 0000000..1ff1a46
> --- /dev/null
> +++ b/drivers/powercap/idle_injection.c
> @@ -0,0 +1,414 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2018 Linaro Limited
> + *
> + * Author: Daniel Lezcano <daniel.lezcano@linaro.org>
> + *
> + * The idle injection framework proposes a way to force a cpu to
> enter
> + * an idle state during a specified amount of time for a specified
> + * period.
> + *
> + * It relies on the smpboot kthreads which handles, via its main
> loop,
> + * the common code for hotplugging and [un]parking.
> + *
> + * At init time, all the kthreads are created and parked.
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
> + * The task handling the timer interrupt will wakeup all the
> kthreads
> + * belonging to the cpumask.
> + */
> +#define pr_fmt(fmt) "ii_dev: " fmt
> +
> +#include <linux/cpu.h>
> +#include <linux/freezer.h>
> +#include <linux/hrtimer.h>
> +#include <linux/sched.h>
> +#include <linux/slab.h>
> +#include <linux/smpboot.h>
> +
> +#include <uapi/linux/sched/types.h>
> +
> +/**
> + * struct idle_injection_thread - task on/off switch structure
> + * @tsk: a pointer to a task_struct injecting the idle cycles
> + * @should_run: a integer used as a boolean by the smpboot kthread
> API
> + */
> +struct idle_injection_thread {
> +	struct task_struct *tsk;
> +	int should_run;
> +};
> +
> +/**
> + * struct idle_injection_device - data for the idle injection
> + * @cpumask: a cpumask containing the list of CPUs managed by the
> device
> + * @timer: a hrtimer giving the tempo for the idle injection
> + * @count: an atomic to keep track of the last task exiting the idle
> cycle
> + * @idle_duration_ms: an unsigned int specifying the idle duration
> + * @run_duration_ms: an unsigned int specifying the running duration
> + */
> +struct idle_injection_device {
> +	cpumask_var_t cpumask;
> +	struct hrtimer timer;
> +	struct completion stop_complete;
> +	unsigned int idle_duration_ms;
> +	unsigned int run_duration_ms;
> +	atomic_t count;
> +};
> +
> +static DEFINE_PER_CPU(struct idle_injection_thread,
> idle_injection_thread);
> +static DEFINE_PER_CPU(struct idle_injection_device *,
> idle_injection_device);
> +
> +/**
> + * __idle_injection_wakeup - Wake up all idle injection threads
> + * @ii_dev: the idle injection device
> + *
> + * Every idle injection task belonging to the idle injection device
> + * and running on an online CPU will be wake up by this call.
> + */
> +static void __idle_injection_wakeup(struct idle_injection_device
> *ii_dev)
> +{
> +	struct idle_injection_thread *iit;
> +	struct cpumask tmp;
> +	unsigned int cpu;
> +
> +	cpumask_and(&tmp, ii_dev->cpumask, cpu_online_mask);
> +
> +	atomic_set(&ii_dev->count, cpumask_weight(&tmp));
> +
> +	for_each_cpu(cpu, &tmp) {
> +		iit =3D per_cpu_ptr(&idle_injection_thread, cpu);
> +		iit->should_run =3D 1;
> +		wake_up_process(iit->tsk);
> +	}
> +}
> +
> +/**
> + * idle_injection_wakeup - Wake up all idle injection threads
> + * @ii_dev: the idle injection device
> + *
> + * This function wakes up all the idle injection tasks belonging to
> + * @ii_dev by invoking __idle_injection_wakeup() but with the cpu
> + * hoplug disabled.
> + */
> +static void idle_injection_wakeup(struct idle_injection_device
> *ii_dev)
> +{
> +	get_online_cpus();
> +	__idle_injection_wakeup(ii_dev);
> +	put_online_cpus();
> +}
> +
> +/**
> + * idle_injection_wakeup_fn - idle injection timer callback
> + * @timer: a hrtimer structure
> + *
> + * This function is called when the idle injection timer expires
> which
> + * will wake up the idle injection tasks and these ones, in turn,
> play
> + * idle a specified amount of time.
> + *
> + * Return: HRTIMER_NORESTART.
> + */
> +static enum hrtimer_restart idle_injection_wakeup_fn(struct hrtimer
> *timer)
> +{
> +	struct idle_injection_device *ii_dev =3D
> +		container_of(timer, struct idle_injection_device,
> timer);
> +
> +	__idle_injection_wakeup(ii_dev);
> +
> +	return HRTIMER_NORESTART;
> +}
> +
> +/**
> + * idle_injection_last_man - operations by the last task
> + * @ii_dev: a pointer to an idle_injection_device structure
> + *
> + * This function groups the operations done by the last idle
> injection
> + * task. It can be called from the idle injection callback as well
> as
> + * from the park callback when the thread is parked at hotplug time.
> + */
> +static void idle_injection_last_man(struct idle_injection_device
> *ii_dev)
> +{
> +	unsigned int run_duration_ms;
> +
> +	run_duration_ms =3D READ_ONCE(ii_dev->run_duration_ms);
> +	if (run_duration_ms) {
> +		hrtimer_start(&ii_dev->timer,
> ms_to_ktime(run_duration_ms),
> +			      HRTIMER_MODE_REL_PINNED);
> +		return;
> +	}
> +
> +	complete(&ii_dev->stop_complete);
> +}
> +
> +/**
> + * idle_injection_fn - idle injection routine
> + * @cpu: the CPU number the tasks belongs to
> + *
> + * The idle injection routine will stay idle the specified amount of
> + * time
> + */
> +static void idle_injection_fn(unsigned int cpu)
> +{
> +	struct idle_injection_device *ii_dev;
> +	struct idle_injection_thread *iit;
> +	unsigned int idle_duration_ms;
> +
> +	ii_dev =3D per_cpu(idle_injection_device, cpu);
> +	iit =3D per_cpu_ptr(&idle_injection_thread, cpu);
> +
> +	/*
> +	 * Boolean used by the smpboot main loop and used as a
> +	 * flip-flop in this function
> +	 */
> +	iit->should_run =3D 0;
> +
> +	idle_duration_ms =3D READ_ONCE(ii_dev->idle_duration_ms);
> +	if (idle_duration_ms)
> +		play_idle(idle_duration_ms);
> +
> +	if (atomic_dec_and_test(&ii_dev->count))
> +		idle_injection_last_man(ii_dev);
> +}
> +
> +/**
> + * idle_injection_set_duration - idle and run duration helper
> + * @run_duration_ms: an unsigned int giving the running time in
> milliseconds
> + * @idle_duration_ms: an unsigned int giving the idle time in
> milliseconds
> + */
> +void idle_injection_set_duration(struct idle_injection_device
> *ii_dev,
> +				 unsigned int run_duration_ms,
> +				 unsigned int idle_duration_ms)
> +{
> +	WRITE_ONCE(ii_dev->run_duration_ms, run_duration_ms);
> +	WRITE_ONCE(ii_dev->idle_duration_ms, idle_duration_ms);
> +}
> +
> +/**
> + * idle_injection_get_duration - idle and run duration helper
> + * @run_duration_ms: a pointer to an unsigned int to store the
> running time
> + * @idle_duration_ms: a pointer to an unsigned int to store the idle
> time
> + */
> +void idle_injection_get_duration(struct idle_injection_device
> *ii_dev,
> +				 unsigned int *run_duration_ms,
> +				 unsigned int *idle_duration_ms)
> +{
> +	*run_duration_ms =3D READ_ONCE(ii_dev->run_duration_ms);
> +	*idle_duration_ms =3D READ_ONCE(ii_dev->idle_duration_ms);
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
> +	if (!READ_ONCE(ii_dev->idle_duration_ms))
> +		return -EINVAL;
> +
> +	if (!READ_ONCE(ii_dev->run_duration_ms))
> +		return -EINVAL;
> +
> +	pr_debug("Starting injecting idle cycles on CPUs '%*pbl'\n",
> +		 cpumask_pr_args(ii_dev->cpumask));
> +
> +	idle_injection_wakeup(ii_dev);
> +
> +	return 0;
> +}
> +
> +/**
> + * idle_injection_stop - stops the idle injections
> + * @ii_dev: a pointer to an idle injection_device structure
> + *
> + * The function stops the idle injection by resetting the idle and
> + * running durations and wait for the threads to complete. If we are
> + * in the process of injecting an idle cycle, then this will wait
> the
> + * end of the cycle.
> + */
> +void idle_injection_stop(struct idle_injection_device *ii_dev)
> +{
> +	pr_debug("Stopping injecting idle cycles on CPUs '%*pbl'\n",
> +		 cpumask_pr_args(ii_dev->cpumask));
> +
> +	idle_injection_set_duration(ii_dev, 0, 0);
> +
> +	wait_for_completion_interruptible(&ii_dev->stop_complete);
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
> +	struct sched_param param =3D { .sched_priority =3D
> MAX_USER_RT_PRIO / 2 };
> +
> +	set_freezable();
> +
> +	sched_setscheduler(current, SCHED_FIFO, &param);
> +}
> +
> +/**
> + * idle_injection_park - move out of the idle injection threads pool
> + * @cpu: the CPU number where the kthread is running on
> + *
> + * Catch the situation where the CPU is hotplugged while we were
> about
> + * to inject an idle cycle.
> + */
> +static void idle_injection_park(unsigned int cpu)
> +{
> +	struct idle_injection_device *ii_dev;
> +	struct idle_injection_thread *iit;
> +
> +	ii_dev =3D per_cpu(idle_injection_device, cpu);
> +	iit =3D per_cpu_ptr(&idle_injection_thread, cpu);
> +
> +	/*
> +	 * If we are supposed to run an idle cycle but obviously we
> +	 * can't because we are in the process of parking, so bail
> out
> +	 * from the pool of idle injection tasks, do nothing
> otherwise.
> +	 */
> +	if (!iit->should_run)
> +		return;
> +
> +	iit->should_run =3D 0;
> +
> +	if (atomic_dec_and_test(&ii_dev->count))
> +		idle_injection_last_man(ii_dev);
> +}
> +
> +/**
> + * idle_injection_should_run - function helper for the smpboot API
> + * @cpu: the CPU number where the kthread is running on
> + *
> + * Return: a boolean telling if the thread can run.
> + */
> +static int idle_injection_should_run(unsigned int cpu)
> +{
> +	struct idle_injection_thread *iit =3D
> +		per_cpu_ptr(&idle_injection_thread, cpu);
> +
> +	return iit->should_run;
> +}
> +
> +static struct idle_injection_device *ii_dev_alloc(void)
> +{
> +	struct idle_injection_device *ii_dev;
> +
> +	ii_dev =3D kzalloc(sizeof(*ii_dev), GFP_KERNEL);
> +	if (!ii_dev)
> +		return NULL;
> +
> +	if (!alloc_cpumask_var(&ii_dev->cpumask, GFP_KERNEL)) {
> +		kfree(ii_dev);
> +		return NULL;
> +	}
> +
> +	return ii_dev;
> +}
> +
> +static void ii_dev_free(struct idle_injection_device *ii_dev)
> +{
> +	free_cpumask_var(ii_dev->cpumask);
> +	kfree(ii_dev);
> +}
> +
> +/**
> + * idle_injection_register - idle injection init routine
> + * @cpumask: the list of CPUs managed by the idle injection device
> + *
> + * This is the initialization function in charge of creating the
> + * initializing of the timer and allocate the structures. It does
> not
> + * starts the idle injection cycles.
> + *
> + * Return: NULL if an allocation fails.
> + */
> +struct idle_injection_device *idle_injection_register(struct cpumask
> *cpumask)
> +{
> +	struct idle_injection_device *ii_dev;
> +	int cpu;
> +
> +	ii_dev =3D ii_dev_alloc();
> +	if (!ii_dev)
> +		return NULL;
> +
> +	cpumask_copy(ii_dev->cpumask, cpumask);
> +	hrtimer_init(&ii_dev->timer, CLOCK_MONOTONIC,
> HRTIMER_MODE_REL);
> +	ii_dev->timer.function =3D idle_injection_wakeup_fn;
> +	init_completion(&ii_dev->stop_complete);
> +
> +	for_each_cpu(cpu, ii_dev->cpumask) {
> +
> +		if (per_cpu(idle_injection_device, cpu)) {
> +			pr_err("cpu%d is already registered\n",
> cpu);
> +			goto out_rollback_per_cpu;
> +		}
> +
> +		per_cpu(idle_injection_device, cpu) =3D ii_dev;
> +	}
> +
> +	return ii_dev;
> +
> +out_rollback_per_cpu:
> +	for_each_cpu(cpu, ii_dev->cpumask)
> +		per_cpu(idle_injection_device, cpu) =3D NULL;
> +
> +	ii_dev_free(ii_dev);
> +
> +	return NULL;
> +}
> +
> +/**
> + * idle_injection_unregister - Unregister the idle injection device
> + * @ii_dev: a pointer to an idle injection device
> + *
> + * The function is in charge of stopping the idle injections,
> + * unregister the kthreads and free the allocated memory in the
> + * register function.
> + */
> +void idle_injection_unregister(struct idle_injection_device *ii_dev)
> +{
> +	int cpu;
> +
> +	idle_injection_stop(ii_dev);
> +
> +	for_each_cpu(cpu, ii_dev->cpumask)
> +		per_cpu(idle_injection_device, cpu) =3D NULL;
> +
> +	ii_dev_free(ii_dev);
> +}
> +
> +static struct smp_hotplug_thread idle_injection_threads =3D {
> +	.store =3D &idle_injection_thread.tsk,
> +	.setup =3D idle_injection_setup,
> +	.park =3D idle_injection_park,
> +	.thread_fn =3D idle_injection_fn,
> +	.thread_comm =3D "idle_inject/%u",
> +	.thread_should_run =3D idle_injection_should_run,
> +};
> +
> +static int __init idle_injection_init(void)
> +{
> +	return
> smpboot_register_percpu_thread(&idle_injection_threads);
> +}
> +early_initcall(idle_injection_init);
> diff --git a/include/linux/idle_injection.h
> b/include/linux/idle_injection.h
> new file mode 100644
> index 0000000..ffd20d7
> --- /dev/null
> +++ b/include/linux/idle_injection.h
> @@ -0,0 +1,29 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2018 Linaro Ltd
> + *
> + * Author: Daniel Lezcano <daniel.lezcano@linaro.org>
> + *
> + */
> +#ifndef __IDLE_INJECTION_H__
> +#define __IDLE_INJECTION_H__
> +
> +/* private idle injection device structure */
> +struct idle_injection_device;
> +
> +struct idle_injection_device *idle_injection_register(struct cpumask
> *cpumask);
> +
> +void idle_injection_unregister(struct idle_injection_device
> *ii_dev);
> +
> +int idle_injection_start(struct idle_injection_device *ii_dev);
> +
> +void idle_injection_stop(struct idle_injection_device *ii_dev);
> +
> +void idle_injection_set_duration(struct idle_injection_device
> *ii_dev,
> +				 unsigned int run_duration_ms,
> +				 unsigned int idle_duration_ms);
> +
> +void idle_injection_get_duration(struct idle_injection_device
> *ii_dev,
> +				 unsigned int *run_duration_ms,
> +				 unsigned int *idle_duration_ms);
> +#endif /* __IDLE_INJECTION_H__ */
--=-Euj0MQZdGE4PU87b1vmp
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

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
aQGEV8ArjHXcotL/yLNh30JyB9sygYzIQadqyFvtvhUyiHwAh7Pf6Gl7Gsz0i/QSq7MK49JvgbUM
F1TCZwc7AgMBAAGjggI9MIICOTAdBgNVHQ4EFgQUf6YLVqF1vjXfk2h4J2GzgJAOB/8wHwYDVR0j
BBgwFoAUHmkqtNwo/kcYTiELP7ysES/wmPUwZQYDVR0fBF4wXDBaoFigVoZUaHR0cDovL3d3dy5p
bnRlbC5jb20vcmVwb3NpdG9yeS9DUkwvSW50ZWwlMjBFeHRlcm5hbCUyMEJhc2ljJTIwSXNzdWlu
ZyUyMENBJTIwNEEuY3JsMIGfBggrBgEFBQcBAQSBkjCBjzBpBggrBgEFBQcwAoZdaHR0cDovL3d3
dy5pbnRlbC5jb20vcmVwb3NpdG9yeS9jZXJ0aWZpY2F0ZXMvSW50ZWwlMjBFeHRlcm5hbCUyMEJh
c2ljJTIwSXNzdWluZyUyMENBJTIwNEEuY3J0MCIGCCsGAQUFBzABhhZodHRwOi8vb2NzcC5pbnRl
bC5jb20vMAsGA1UdDwQEAwIHgDA8BgkrBgEEAYI3FQcELzAtBiUrBgEEAYI3FQiGw4x1hJnlUYP9
gSiFjp9TgpHACWeB3r05lfBDAgFkAgEJMB8GA1UdJQQYMBYGCCsGAQUFBwMEBgorBgEEAYI3CgMM
MCkGCSsGAQQBgjcVCgQcMBowCgYIKwYBBQUHAwQwDAYKKwYBBAGCNwoDDDBXBgNVHREEUDBOoC0G
CisGAQQBgjcUAgOgHwwdc3Jpbml2YXMucGFuZHJ1dmFkYUBpbnRlbC5jb22BHXNyaW5pdmFzLnBh
bmRydXZhZGFAaW50ZWwuY29tMA0GCSqGSIb3DQEBBQUAA4IBAQDDpWcY9zqtG5P0e1FRJpG/RPQ6
p6sQJHZ5UwykMtYFqBJYOZn9B8koeLEhE4vOAh6v6fgVoCfOvwxJ57BUAdP3jvkbCaLz3r6nUHNr
6w6KwnT9rHykdDjZsRUGs2yP+139qVqoXRHTOLfqvnAzcirjgf4Fz3JRPJZraRWrICBehqhYVfFH
sxxBgOauQ+DTHjZARkomjmrATvlDpLMlN74L/BKZI4rl4R/BjSaLBzAKQnAN0nvWefpPzdeSYuxK
XaN1xDzINPDnmShXSbQzee0h2CvEnIMtPQDM9DJACUi14Cc9y4o7DqRky4r1+XnksN2lKnu83l4E
oSxCkDMhszkFMYICFzCCAhMCAQEwgZAweTELMAkGA1UEBhMCVVMxCzAJBgNVBAgTAkNBMRQwEgYD
VQQHEwtTYW50YSBDbGFyYTEaMBgGA1UEChMRSW50ZWwgQ29ycG9yYXRpb24xKzApBgNVBAMTIklu
dGVsIEV4dGVybmFsIEJhc2ljIElzc3VpbmcgQ0EgNEECEzMAAK0KIyEkTMbH5OYAAAAArQowCQYF
Kw4DAhoFAKBdMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE4MDYx
MzE1NTQxN1owIwYJKoZIhvcNAQkEMRYEFGbdaD2/QezmimkuJbL2G0saCRAGMA0GCSqGSIb3DQEB
AQUABIIBAEwXIRXppMK/8UuWGn0K9Uc7/feursRInULldoi2Fm1E/FCo5eSeOYQ+HFLFBPJOYpFA
WBxHT7m1RR++eTrVdX6KB0Rfr2lcAgsXH4omW9c9RVXF9tt5mztl3K7lUFs6lpBpMKZpaVsW3EQ9
8pEYuHmFf1NynNy09E1OGOUemkEHw3rel/buoPI+kde5fj7z9E/NO0MuDrkzP9UIWraCP0hAmnSZ
rugvHOGhwsZkDca88ot3TRjNQcnbj1cyrsVWI1qmqzl9Dy5eHa4GcbbkHqZMaV80WgLIQp1uhypN
rwA+0vKdk4BaapaD0hLuQQAHtf+Dw+6W8UOhwaIEpboeB+4AAAAAAAA=


--=-Euj0MQZdGE4PU87b1vmp--
