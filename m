Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7340BC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ACB1204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:28:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fln0ryHU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ACB1204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937776AbeFSN2f (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 09:28:35 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35399 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937445AbeFSN2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 09:28:33 -0400
Received: by mail-wm0-f67.google.com with SMTP id j15-v6so483685wme.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 06:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=rY+Mearb61yI/8sHlTY96zob7PKS3N2lpxHPzmR1olc=;
        b=Fln0ryHUKZAKewDFRdQGLkhj/Ku1U/boVar63+LaUxUH/ZkIeL/giyk1mmE4wV7q1N
         WtHbURetS3KbBZJVVYosxYFNekge5cv15yGvJMY37wsVBNwVHhM1Mp69RxpUVV1NBW8w
         cn9PnMk1x2CCiaqmL7mu/etqVdpLekQ78zXkQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rY+Mearb61yI/8sHlTY96zob7PKS3N2lpxHPzmR1olc=;
        b=VP6+O5CL5VnFJlQPDLlR1CzCep2Sx2sxtdT9LF2F9QWg8IzLh7BP/pTqkdcCFQp4mf
         ag1J5ST5R7jMUSh/4xxLmez+phi1pKlb4cWAKZVYuFGIZN9IMjMqPuO3sG5wDz1ZXn7R
         /ukWLLlNSXyCi+PZhAHKaKYwyw9qQ7U5xYVBuipW4pWF4DiBZTu4sFiLHZeS8ZtN9Fox
         ObCSGtnJppL25GmOinbK4PWjWFKUxTPssPH9vP/4tP5JV4d0gNFdYt9Gg8CROUgAHP6K
         Q7X9AyvOQ67CG4t469QxLYxqQAHvBmfwB60sx1ruvXNMoqsGGVmUgB36KWUnjyzIiHBv
         Z5fg==
X-Gm-Message-State: APt69E0mzdvUKjy+MkbEUIjOJro21yrtMFzRv8kwad3VuCw0WbhLULhZ
        YhoQlm0JMKhae9rsCC5UbSzI7Q==
X-Google-Smtp-Source: ADUXVKJeEFS+NRSH4VuF0JSdEOq1kyrWigd19+mbjY0gL83Pv6KuoI7iz0vLejfOhiqcdPxyKYNNEQ==
X-Received: by 2002:a1c:470b:: with SMTP id u11-v6mr11464153wma.49.1529414911530;
        Tue, 19 Jun 2018 06:28:31 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e35:879a:6cd0:3c7c:d840:19fc:1700])
        by smtp.gmail.com with ESMTPSA id q17-v6sm19397225wrs.5.2018.06.19.06.28.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Jun 2018 06:28:30 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Eduardo Valentin <edubezval@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Kevin Wangtao <kevin.wangtao@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rui Zhang <rui.zhang@intel.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        linux-pm@vger.kernel.org (open list:POWER MANAGEMENT CORE)
Subject: [PATCH V9] powercap/drivers/idle_injection: Add an idle injection framework
Date:   Tue, 19 Jun 2018 15:23:40 +0200
Message-Id: <1529414627-5638-1-git-send-email-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initially, the cpu_cooling device for ARM was changed by adding a new
policy inserting idle cycles. The intel_powerclamp driver does a
similar action.

Instead of implementing idle injections privately in the cpu_cooling
device, move the idle injection code in a dedicated framework and give
the opportunity to other frameworks to make use of it.

The framework relies on the smpboot kthreads which handles via its
main loop the common code for hotplugging and [un]parking.

This code was previously tested with the cpu cooling device and went
through several iterations. It results now in split code and API
exported in the header file. It was tested with the cpu cooling device
with success.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Javi Merino <javi.merino@kernel.org>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Kevin Wangtao <kevin.wangtao@linaro.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Rui Zhang <rui.zhang@intel.com>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andrea Parri <andrea.parri@amarulasolutions.com>
---

V9:
   - Unconditionnally reset the should_run flag for all kthreads
     belonging to the cpumask and remove the park() callback (Viresh Kumar)
   - Fix up the typos in the comments (Viresh Kumar)

V8:
   - Rollback only what was modified
   - Add the park() callback to reset the should_run flag

V7:
   - Replace count approach by htimer_forward and restart (Peter Zijlstra)
   - Wait for task inactive when stopping the idle injections
   - Changed the comments and description

V6:
   - Move count to wake up function (Viresh Kumar)
   - Split atomic/non-atomic context to wake up tasks
   - Add the park callback to handle unplug/inject race
   - Replace atomic by READ_ONCE and WRITE_ONCE (Peter Zijlstra)

V5:
   - Move init_completion in the init function (Viresh Kumar)
   - Increment task count in the wakeup function (Viresh Kumar)
   - Remove rollback at init time (Viresh Kumar)

V4:
   - Wait for completion when stopping (Viresh Kumar)
   - Check init already done and rollback (Viresh Kumar)

V3:
   - Fixed typos (Viresh Kumar)
   - Removed extra blank line (Viresh Kumar)
   - Added full stop (Viresh Kumar)
   - Fixed Return kerneldoc format (Viresh Kumar)
   - Fixed multiple kthreads initialization (Viresh Kumar)
   - Fixed rollbacking the actions in the unregister function (Viresh Kumar)
   - Make idle injection kthreads name hardcoded
   - Kthreads are created in the initcall process

 V2: Fixed checkpatch warnings

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/powercap/Kconfig          |  10 ++
 drivers/powercap/Makefile         |   1 +
 drivers/powercap/idle_injection.c | 362 ++++++++++++++++++++++++++++++++++++++
 include/linux/idle_injection.h    |  29 +++
 4 files changed, 402 insertions(+)
 create mode 100644 drivers/powercap/idle_injection.c
 create mode 100644 include/linux/idle_injection.h

diff --git a/drivers/powercap/Kconfig b/drivers/powercap/Kconfig
index 85727ef..a767ef2 100644
--- a/drivers/powercap/Kconfig
+++ b/drivers/powercap/Kconfig
@@ -29,4 +29,14 @@ config INTEL_RAPL
 	  controller, CPU core (Power Plance 0), graphics uncore (Power Plane
 	  1), etc.
 
+config IDLE_INJECTION
+	bool "Idle injection framework"
+	depends on CPU_IDLE
+	default n
+	help
+	  This enables support for the idle injection framework. It
+	  provides a way to force idle periods on a set of specified
+	  CPUs for power capping. Idle period can be injected
+	  synchronously on a set of specified CPUs or alternatively
+	  on a per CPU basis.
 endif
diff --git a/drivers/powercap/Makefile b/drivers/powercap/Makefile
index 0a21ef3..c3bbfee 100644
--- a/drivers/powercap/Makefile
+++ b/drivers/powercap/Makefile
@@ -1,2 +1,3 @@
 obj-$(CONFIG_POWERCAP)	+= powercap_sys.o
 obj-$(CONFIG_INTEL_RAPL) += intel_rapl.o
+obj-$(CONFIG_IDLE_INJECTION) += idle_injection.o
diff --git a/drivers/powercap/idle_injection.c b/drivers/powercap/idle_injection.c
new file mode 100644
index 0000000..50ce348
--- /dev/null
+++ b/drivers/powercap/idle_injection.c
@@ -0,0 +1,362 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2018 Linaro Limited
+ *
+ * Author: Daniel Lezcano <daniel.lezcano@linaro.org>
+ *
+ * The idle injection framework proposes a way to force a cpu to enter
+ * an idle state during a specified amount of time for a specified
+ * period.
+ *
+ * It relies on the smpboot kthreads which handles, via its main loop,
+ * the common code for hotplugging and [un]parking.
+ *
+ * At init time, all the kthreads are created.
+ *
+ * A cpumask is specified as parameter for the idle injection
+ * registering function. The kthreads will be synchronized regarding
+ * this cpumask.
+ *
+ * The idle + run duration is specified via the helpers and then the
+ * idle injection can be started at this point.
+ *
+ * A kthread will call play_idle() with the specified idle duration
+ * from above.
+ *
+ * A timer is set after waking up all the tasks, to the next idle
+ * injection cycle.
+ *
+ * The task handling the timer interrupt will wakeup all the kthreads
+ * belonging to the cpumask.
+ *
+ * Stopping the idle injection is synchronous, when the function
+ * returns, there is the guarantee there is no more idle injection
+ * kthread in activity.
+ *
+ * It is up to the user of this framework to provide a lock at an
+ * upper level to prevent stupid things to happen, like starting while
+ * we are unregistering.
+ */
+#define pr_fmt(fmt) "ii_dev: " fmt
+
+#include <linux/cpu.h>
+#include <linux/freezer.h>
+#include <linux/hrtimer.h>
+#include <linux/kthread.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/smpboot.h>
+
+#include <uapi/linux/sched/types.h>
+
+/**
+ * struct idle_injection_thread - task on/off switch structure
+ * @tsk: a pointer to a task_struct injecting the idle cycles
+ * @should_run: a integer used as a boolean by the smpboot kthread API
+ */
+struct idle_injection_thread {
+	struct task_struct *tsk;
+	int should_run;
+};
+
+/**
+ * struct idle_injection_device - data for the idle injection
+ * @timer: a hrtimer giving the tempo for the idle injection
+ * @idle_duration_ms: an unsigned int specifying the idle duration
+ * @run_duration_ms: an unsigned int specifying the running duration
+ * @cpumask: a cpumask containing the list of CPUs managed by the device
+ */
+struct idle_injection_device {
+	struct hrtimer timer;
+	unsigned int idle_duration_ms;
+	unsigned int run_duration_ms;
+	unsigned long int cpumask[0];
+};
+
+static DEFINE_PER_CPU(struct idle_injection_thread, idle_injection_thread);
+static DEFINE_PER_CPU(struct idle_injection_device *, idle_injection_device);
+
+/**
+ * idle_injection_wakeup - Wake up all idle injection threads
+ * @ii_dev: the idle injection device
+ *
+ * Every idle injection task belonging to the idle injection device
+ * and running on an online CPU will be wake up by this call.
+ */
+static void idle_injection_wakeup(struct idle_injection_device *ii_dev)
+{
+	struct idle_injection_thread *iit;
+	unsigned int cpu;
+
+	for_each_cpu_and(cpu, to_cpumask(ii_dev->cpumask), cpu_online_mask) {
+		iit = per_cpu_ptr(&idle_injection_thread, cpu);
+		iit->should_run = 1;
+		wake_up_process(iit->tsk);
+	}
+}
+
+/**
+ * idle_injection_wakeup_fn - idle injection timer callback
+ * @timer: a hrtimer structure
+ *
+ * This function is called when the idle injection timer expires which
+ * will wake up the idle injection tasks and these ones, in turn, play
+ * idle a specified amount of time.
+ *
+ * Return: HRTIMER_RESTART.
+ */
+static enum hrtimer_restart idle_injection_wakeup_fn(struct hrtimer *timer)
+{
+	unsigned int duration_ms;
+	struct idle_injection_device *ii_dev =
+		container_of(timer, struct idle_injection_device, timer);
+
+	duration_ms = READ_ONCE(ii_dev->run_duration_ms);
+	duration_ms += READ_ONCE(ii_dev->idle_duration_ms);
+
+	idle_injection_wakeup(ii_dev);
+
+	hrtimer_forward_now(timer, ms_to_ktime(duration_ms));
+
+	return HRTIMER_RESTART;
+}
+
+/**
+ * idle_injection_fn - idle injection routine
+ * @cpu: the CPU number the task belongs to
+ *
+ * The idle injection routine will stay idle the specified amount of
+ * time
+ */
+static void idle_injection_fn(unsigned int cpu)
+{
+	struct idle_injection_device *ii_dev;
+	struct idle_injection_thread *iit;
+
+	ii_dev = per_cpu(idle_injection_device, cpu);
+	iit = per_cpu_ptr(&idle_injection_thread, cpu);
+
+	/*
+	 * Boolean used by the smpboot main loop and used as a
+	 * flip-flop in this function
+	 */
+	iit->should_run = 0;
+
+	play_idle(READ_ONCE(ii_dev->idle_duration_ms));
+}
+
+/**
+ * idle_injection_set_duration - idle and run duration helper
+ * @run_duration_ms: an unsigned int giving the running time in milliseconds
+ * @idle_duration_ms: an unsigned int giving the idle time in milliseconds
+ */
+void idle_injection_set_duration(struct idle_injection_device *ii_dev,
+				 unsigned int run_duration_ms,
+				 unsigned int idle_duration_ms)
+{
+	if (run_duration_ms && idle_duration_ms) {
+		WRITE_ONCE(ii_dev->run_duration_ms, run_duration_ms);
+		WRITE_ONCE(ii_dev->idle_duration_ms, idle_duration_ms);
+	}
+}
+
+/**
+ * idle_injection_get_duration - idle and run duration helper
+ * @run_duration_ms: a pointer to an unsigned int to store the running time
+ * @idle_duration_ms: a pointer to an unsigned int to store the idle time
+ */
+void idle_injection_get_duration(struct idle_injection_device *ii_dev,
+				 unsigned int *run_duration_ms,
+				 unsigned int *idle_duration_ms)
+{
+	*run_duration_ms = READ_ONCE(ii_dev->run_duration_ms);
+	*idle_duration_ms = READ_ONCE(ii_dev->idle_duration_ms);
+}
+
+/**
+ * idle_injection_start - starts the idle injections
+ * @ii_dev: a pointer to an idle_injection_device structure
+ *
+ * The function starts the idle injection cycles by first waking up
+ * all the tasks the ii_dev is attached to and let them handle the
+ * idle-run periods.
+ *
+ * Return: -EINVAL if the idle or the running durations are not set.
+ */
+int idle_injection_start(struct idle_injection_device *ii_dev)
+{
+	unsigned int idle_duration_ms = READ_ONCE(ii_dev->idle_duration_ms);
+	unsigned int run_duration_ms = READ_ONCE(ii_dev->run_duration_ms);
+
+	if (!idle_duration_ms || !run_duration_ms)
+		return -EINVAL;
+
+	pr_debug("Starting injecting idle cycles on CPUs '%*pbl'\n",
+		 cpumask_pr_args(to_cpumask(ii_dev->cpumask)));
+
+	idle_injection_wakeup(ii_dev);
+
+	hrtimer_start(&ii_dev->timer,
+		      ms_to_ktime(idle_duration_ms + run_duration_ms),
+		      HRTIMER_MODE_REL);
+
+	return 0;
+}
+
+/**
+ * idle_injection_stop - stops the idle injections
+ * @ii_dev: a pointer to an idle injection_device structure
+ *
+ * The function stops the idle injection and waits for the threads to
+ * complete. If we are in the process of injecting an idle cycle, then
+ * this will wait the end of the cycle.
+ *
+ * When the function returns there is no more idle injection
+ * activity. The kthreads are scheduled out and the periodic timer is
+ * off.
+ */
+void idle_injection_stop(struct idle_injection_device *ii_dev)
+{
+	struct idle_injection_thread *iit;
+	unsigned int cpu;
+
+	pr_debug("Stopping injecting idle cycles on CPUs '%*pbl'\n",
+		 cpumask_pr_args(to_cpumask(ii_dev->cpumask)));
+
+	hrtimer_cancel(&ii_dev->timer);
+
+	/*
+	 * We want the guarantee we have a quiescent point where
+	 * parked threads stay in there state while we are stopping
+	 * the idle injection. After exiting the loop, if any CPU is
+	 * plugged in, the 'should_run' boolean being false, the
+	 * smpboot main loop schedules the task out.
+	 */
+	cpu_hotplug_disable();
+
+	/*
+	 * Iterate over all (online + offline) CPUs here in case a CPU
+	 * got hotplugged out with "should_run" set to "1" and the
+	 * thread may start running again after the ii_dev is freed
+	 * and the CPU gets hotplugged in.
+	 */
+	for_each_cpu(cpu, to_cpumask(ii_dev->cpumask)) {
+		iit = per_cpu_ptr(&idle_injection_thread, cpu);
+		iit->should_run = 0;
+
+		wait_task_inactive(iit->tsk, 0);
+	}
+
+	cpu_hotplug_enable();
+}
+
+/**
+ * idle_injection_setup - initialize the current task as a RT task
+ * @cpu: the CPU number where the kthread is running on (not used)
+ *
+ * Called one time, this function is in charge of setting the task
+ * scheduler parameters.
+ */
+static void idle_injection_setup(unsigned int cpu)
+{
+	struct sched_param param = { .sched_priority = MAX_USER_RT_PRIO / 2 };
+
+	set_freezable();
+
+	sched_setscheduler(current, SCHED_FIFO, &param);
+}
+
+/**
+ * idle_injection_should_run - function helper for the smpboot API
+ * @cpu: the CPU number where the kthread is running on
+ *
+ * Return: a boolean telling if the thread can run.
+ */
+static int idle_injection_should_run(unsigned int cpu)
+{
+	struct idle_injection_thread *iit =
+		per_cpu_ptr(&idle_injection_thread, cpu);
+
+	return iit->should_run;
+}
+
+/**
+ * idle_injection_register - idle injection init routine
+ * @cpumask: the list of CPUs managed by the idle injection device
+ *
+ * This is the initialization function in charge of creating the
+ * initializing of the timer and allocate the structures. It does not
+ * starts the idle injection cycles.
+ *
+ * Return: NULL if an allocation fails.
+ */
+struct idle_injection_device *idle_injection_register(struct cpumask *cpumask)
+{
+	struct idle_injection_device *ii_dev;
+	int cpu, cpu_rb;
+
+	ii_dev = kzalloc(sizeof(*ii_dev) + cpumask_size(), GFP_KERNEL);
+	if (!ii_dev)
+		return NULL;
+
+	cpumask_copy(to_cpumask(ii_dev->cpumask), cpumask);
+	hrtimer_init(&ii_dev->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	ii_dev->timer.function = idle_injection_wakeup_fn;
+
+	for_each_cpu(cpu, to_cpumask(ii_dev->cpumask)) {
+
+		if (per_cpu(idle_injection_device, cpu)) {
+			pr_err("cpu%d is already registered\n", cpu);
+			goto out_rollback_per_cpu;
+		}
+
+		per_cpu(idle_injection_device, cpu) = ii_dev;
+	}
+
+	return ii_dev;
+
+out_rollback_per_cpu:
+	for_each_cpu(cpu_rb, to_cpumask(ii_dev->cpumask)) {
+		if (cpu == cpu_rb)
+			break;
+		per_cpu(idle_injection_device, cpu_rb) = NULL;
+	}
+
+	kfree(ii_dev);
+
+	return NULL;
+}
+
+/**
+ * idle_injection_unregister - Unregister the idle injection device
+ * @ii_dev: a pointer to an idle injection device
+ *
+ * The function is in charge of stopping the idle injections,
+ * unregister the kthreads and free the allocated memory in the
+ * register function.
+ */
+void idle_injection_unregister(struct idle_injection_device *ii_dev)
+{
+	unsigned int cpu;
+
+	idle_injection_stop(ii_dev);
+
+	for_each_cpu(cpu, to_cpumask(ii_dev->cpumask))
+		per_cpu(idle_injection_device, cpu) = NULL;
+
+	kfree(ii_dev);
+}
+
+static struct smp_hotplug_thread idle_injection_threads = {
+	.store = &idle_injection_thread.tsk,
+	.setup = idle_injection_setup,
+	.thread_fn = idle_injection_fn,
+	.thread_comm = "idle_inject/%u",
+	.thread_should_run = idle_injection_should_run,
+};
+
+static int __init idle_injection_init(void)
+{
+	return smpboot_register_percpu_thread(&idle_injection_threads);
+}
+early_initcall(idle_injection_init);
diff --git a/include/linux/idle_injection.h b/include/linux/idle_injection.h
new file mode 100644
index 0000000..ffd20d7
--- /dev/null
+++ b/include/linux/idle_injection.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2018 Linaro Ltd
+ *
+ * Author: Daniel Lezcano <daniel.lezcano@linaro.org>
+ *
+ */
+#ifndef __IDLE_INJECTION_H__
+#define __IDLE_INJECTION_H__
+
+/* private idle injection device structure */
+struct idle_injection_device;
+
+struct idle_injection_device *idle_injection_register(struct cpumask *cpumask);
+
+void idle_injection_unregister(struct idle_injection_device *ii_dev);
+
+int idle_injection_start(struct idle_injection_device *ii_dev);
+
+void idle_injection_stop(struct idle_injection_device *ii_dev);
+
+void idle_injection_set_duration(struct idle_injection_device *ii_dev,
+				 unsigned int run_duration_ms,
+				 unsigned int idle_duration_ms);
+
+void idle_injection_get_duration(struct idle_injection_device *ii_dev,
+				 unsigned int *run_duration_ms,
+				 unsigned int *idle_duration_ms);
+#endif /* __IDLE_INJECTION_H__ */
-- 
2.7.4

