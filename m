Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA2AC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 00:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 571DF208DB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 00:58:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="myRU7h4B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 571DF208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933452AbeGIA6G (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 20:58:06 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37841 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933286AbeGIA6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 20:58:05 -0400
Received: by mail-wm0-f67.google.com with SMTP id n17-v6so18966055wmh.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jul 2018 17:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=4U1KEvBxidkb/PQhq2ucDWE1ZwdebM43bxaIOs5Gvlo=;
        b=myRU7h4BT/+twWwQi0cs6zq4SlLIVUbM99qQSFT0nXaUEIM+2iNSlCWqyzI7n27xfc
         65XsUz+OTdv5R4GZvFx8Ep05xFSYxSSWPxCfaZ46Jp0RxIdoZ1ChV+mhjE90052oQ3WX
         S3QoAtM9iuz+g/2G928KDw5BJ62fgem2/ZNPFQs/6rgXggvwJrs6TdFVSIk7u2MpcgON
         noSw5+BZXyC1TOKH3FeaHoFO0uFHNelogwTYGae9nNHA9ThiyZPo2kkGIyeOHeG5+P/v
         W9UXL6aVxo6iRSl7bxRWh27YM8DSNL5aP58ftZsmmYW0VJhfF+2BsXVkgc/DdkOJ4+K/
         PjJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4U1KEvBxidkb/PQhq2ucDWE1ZwdebM43bxaIOs5Gvlo=;
        b=QZDy9WCaM7OdZ8jGKSAHAoBUCo7KJrJ+ppoFL9HzJajCiyeNJ5y8kizzeqMQ5HqWLb
         vl/Jx+OsuZuGDJg9Qml/jpGgahgGCJ1Bf/j6BKnH01nhqiedYsmd7vxRoihhUQ1FraUQ
         vnacsvCPn6+x63j+riFSL8odnBEXtIrbrefa1I70SA6Im7Rb9yfxhpRGnyyVtReqP+8s
         hCsdDgNKoGbLsVJpB821Z/db+sE/tKabnIJ0TEW1c4uT8feuDC9suJvFAJW/A5E4TP0L
         didd5/twVriGV1kdi5vbQDPSEEEJt2rd0sSkjkt2/UhQNa2UdqpIai3Z2Yo8oPGNt3Z7
         7F0w==
X-Gm-Message-State: APt69E1FTmlA3vDtugaa/loGwQS8w5yvmTwTLIArbGH27Hp8asln+tk9
        zKDmtQUVOooA08Dxj13EplZAqA==
X-Google-Smtp-Source: AAOMgpe8DAtrTgcbBOYZlzAPaBPEUqpsc0aTd4VEbjYThd/f18UTIOrYFfO8lvsmaYY3an5C/2xSpg==
X-Received: by 2002:a1c:c60a:: with SMTP id w10-v6mr614405wmf.26.1531097883988;
        Sun, 08 Jul 2018 17:58:03 -0700 (PDT)
Received: from localhost.localdomain (ipb218f40d.dynamic.kabel-deutschland.de. [178.24.244.13])
        by smtp.gmail.com with ESMTPSA id 72-v6sm26532618wmo.26.2018.07.08.17.58.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 08 Jul 2018 17:58:03 -0700 (PDT)
From:   Eugeniu Rosca <roscaeugeniu@gmail.com>
X-Google-Original-From: Eugeniu Rosca <erosca@de.adit-jv.com>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Byungchul Park <byungchul.park@lge.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Eugeniu Rosca <rosca.eugeniu@gmail.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH] locking/lockdep: Report comm/pid/timestamp information
Date:   Mon,  9 Jul 2018 02:57:25 +0200
Message-Id: <20180709005725.18184-1-erosca@de.adit-jv.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Analyzing the "circular locking dependency" splat [2], I can see
the following skeleton/pattern:

<template>
    <comm/pid> is trying to acquire lock X.
    *same* <comm/pid> has previously acquired lock Y.
    lock Y depends on lock X (hence chance for deadlock).

    Print lock dependency chain:

    -> #N<depth> (lock-name-N){lock-usage-N}:
                  <stack-dump-N>
    [---->8----]
    -> #0<depth> (lock-name-0){lock-usage-0}:
                  <stack-dump-0>

    Print an example of potential scenario leading to real deadlock.
    List all locks held by <comm/pid> (4 in case of [2]).
    Print <comm/pid>'s backtrace (seems to be equal to <stack-dump-0>).
</template>

The following questions appeared in my mind when analyzing [2]:
(A) What is the chronology of consuming the locks? Is it related to
    the order seen in the "dependency chain"?
(B) All four locks are reported to be held by the same task.
    Indeeed, based on available backtraces, 3 of 4 are acquired
    during the load of cpufreq_dt.ko by systemd-udevd. However,
    there is a different syscall behind "cpu_hotplug_lock.rw_sem" which
    made we wonder if it is really systemd-udevd consuming this lock. If
    not, is it still correct to say that systemd-udevd holds all locks?
(C) The example of potential unsafe scenario leading to deadlock
    puts a special emphasis on the CPU on which the lock is held.
    However, except for the last held lock (&sb->s_type->i_mutex_key#3),
    whose CPU can be extracted from:
    "CPU: 3 PID: 1598 Comm: systemd-udevd Not tainted 4.18.0-rc3+ #31"
    there is no CPU-related information for the other locks.
(D) "cpu_hotplug_lock.rw_sem){++++}, at: cpufreq_register_driver"
    doesn't match the stack backtrace of "cpu_hotplug_lock.rw_sem"
    (there is no cpufreq_register_driver() call in the backtrace).
    Maybe I misinterpret the report?
(E) "(opp_table_lock){+.+.}, at: dev_pm_opp_get_opp_table+0xbc/0x3bc"
    IMHO again contradicts the stack backtrace of "opp_table_lock",
    since it lacks the call of dev_pm_opp_get_opp_table().

This patch aims to only provide the answers to (A), (B) and (C) by
slightly enriching the output of lockdep. For the moment, it only
affects the printout of "circular dependencies".

Based on the enriched output [1], the answers seems to be:
(A) Lock chronology (each lock now carries a timestamp) doesn't match
    the lock order in the "dependency chain".
(B) "cpu_hotplug_lock.rw_sem" is acquired by the "echo" process (it is
    actually an 'echo MY_FEATURE > /sys/kernel/debug/sched_features')
    part of a specific systemd service. Since not all locks are held
    by systemd-udevd, lockdep output should be probably corrected?
(C) CPU is different for the echo process.
(D) Still no answer.
(E) Still no answer.

[1] Lockdep splat (enriched variant of [2] after applying this patch)
[   20.257522] ======================================================
[   20.263753] WARNING: possible circular locking dependency detected
[   20.269987] 4.18.0-rc3+ #33 Not tainted
[   20.273857] ------------------------------------------------------
[   20.280086] systemd-udevd/1600 is trying to acquire lock:
[   20.285530] 000000007190de44 (&sb->s_type->i_mutex_key#3){+.+.}, at: start_creating+0xb8/0x144
[   20.294261]
[   20.294261] but task is already holding lock:
[   20.300148] 0000000010149c4f (opp_table_lock){+.+.}, at: dev_pm_opp_get_opp_table+0xbc/0x3bc
[   20.308690]
[   20.308690] which lock already depends on the new lock.
[   20.316936]
[   20.316936] the existing dependency chain (in reverse order) is:
[   20.324479]
[   20.324479] -> #3 (opp_table_lock){+.+.}systemd-udevd/1600/CPU2)(20.255548):
[---->8------]
[   20.441481] -> #2 (subsys mutex#6){+.+.}systemd-udevd/1600/CPU2)(20.251603):
[---->8------]
[   20.577505] -> #1 (cpu_hotplug_lock.rw_sem){++++}echo/1235/CPU0)(12.283656):
[---->8------]
[   20.628173] -> #0 (&sb->s_type->i_mutex_key#3){+.+.}systemd-udevd/1600/CPU2)(20.628202):
[---->8------]

[2] Lockdep splat on H3ULCB Kingfisher board (w/o this patch)
[   21.114029] ======================================================
[   21.120257] WARNING: possible circular locking dependency detected
[   21.126489] 4.18.0-rc3+ #31 Not tainted
[   21.126497] ------------------------------------------------------
[   21.126504] systemd-udevd/1598 is trying to acquire lock:
[   21.126513] 00000000478cc794 (&sb->s_type->i_mutex_key#3){+.+.}, at: start_creating+0xb8/0x144
[   21.126566]
[   21.126566] but task is already holding lock:
[   21.126571] 00000000d1aef27f (opp_table_lock){+.+.}, at: dev_pm_opp_get_opp_table+0xbc/0x3bc
[   21.126616]
[   21.126616] which lock already depends on the new lock.
[   21.126616]
[   21.149183] the existing dependency chain (in reverse order) is:
[   21.149190]
[   21.149190] -> #3 (opp_table_lock){+.+.}:
[   21.149230]        lock_acquire+0x630/0x6a4
[   21.149245]        __mutex_lock+0x178/0x11c8
[   21.149256]        mutex_lock_nested+0x3c/0x4c
[   21.149269]        _of_add_opp_table_v2+0xbc/0x7e0
[   21.149295]        dev_pm_opp_of_add_table+0x1e8/0x210
[   21.172513]        dev_pm_opp_of_cpumask_add_table+0xb8/0xe0
[   21.172545]        cpufreq_init+0x1fc/0x420 [cpufreq_dt]
[   21.172559]        cpufreq_online+0x404/0xd74
[   21.172570]        cpufreq_add_dev+0x170/0x188
[   21.172585]        subsys_interface_register+0x268/0x290
[   21.172618]        cpufreq_register_driver+0x1f0/0x334
[   21.261266]        dt_cpufreq_probe+0x158/0x178 [cpufreq_dt]
[   21.266988]        platform_drv_probe+0xa4/0x130
[   21.271657]        driver_probe_device+0x4a4/0x5e4
[   21.276500]        __driver_attach+0x150/0x1e4
[   21.280992]        bus_for_each_dev+0x114/0x13c
[   21.285569]        driver_attach+0x50/0x5c
[   21.289711]        bus_add_driver+0x2a8/0x2fc
[   21.294113]        driver_register+0x180/0x1c8
[   21.298603]        __platform_driver_register+0x9c/0xac
[   21.303894]        dt_cpufreq_platdrv_init+0x28/0x1000 [cpufreq_dt]
[   21.310232]        do_one_initcall+0x608/0xc54
[   21.314729]        do_init_module+0x174/0x474
[   21.319140]        load_module+0x3cf8/0x3d8c
[   21.323462]        sys_finit_module+0x164/0x184
[   21.328041]        el0_svc_naked+0x30/0x34
[   21.332177]
[   21.332177] -> #2 (subsys mutex#6){+.+.}:
[   21.337761]        lock_acquire+0x630/0x6a4
[   21.341993]        __mutex_lock+0x178/0x11c8
[   21.346313]        mutex_lock_nested+0x3c/0x4c
[   21.350810]        subsys_interface_register+0x108/0x290
[   21.356186]        cpufreq_register_driver+0x1f0/0x334
[   21.361395]        dt_cpufreq_probe+0x158/0x178 [cpufreq_dt]
[   21.367116]        platform_drv_probe+0xa4/0x130
[   21.371782]        driver_probe_device+0x4a4/0x5e4
[   21.376623]        __driver_attach+0x150/0x1e4
[   21.381118]        bus_for_each_dev+0x114/0x13c
[   21.385700]        driver_attach+0x50/0x5c
[   21.389841]        bus_add_driver+0x2a8/0x2fc
[   21.394244]        driver_register+0x180/0x1c8
[   21.398738]        __platform_driver_register+0x9c/0xac
[   21.404029]        dt_cpufreq_platdrv_init+0x28/0x1000 [cpufreq_dt]
[   21.410359]        do_one_initcall+0x608/0xc54
[   21.414854]        do_init_module+0x174/0x474
[   21.419260]        load_module+0x3cf8/0x3d8c
[   21.423580]        sys_finit_module+0x164/0x184
[   21.428163]        el0_svc_naked+0x30/0x34
[   21.432300]
[   21.432300] -> #1 (cpu_hotplug_lock.rw_sem){++++}:
[   21.438665]        lock_acquire+0x630/0x6a4
[   21.442900]        cpus_read_lock+0x58/0x198
[   21.447220]        static_key_enable+0x1c/0x34
[   21.451714]        sched_feat_write+0x2e8/0x3d8
[   21.456298]        full_proxy_write+0xa4/0xc8
[   21.460707]        __vfs_write+0x110/0x3ac
[   21.464851]        vfs_write+0x138/0x2f4
[   21.468816]        ksys_write+0xd0/0x150
[   21.472787]        sys_write+0x34/0x44
[   21.476583]        el0_svc_naked+0x30/0x34
[   21.480717]
[   21.480717] -> #0 (&sb->s_type->i_mutex_key#3){+.+.}:
[   21.487345]        __lock_acquire+0x1d9c/0x200c
[   21.491932]        lock_acquire+0x630/0x6a4
[   21.496167]        down_write+0xb8/0x150
[   21.500139]        start_creating+0xb8/0x144
[   21.504460]        debugfs_create_dir+0x2c/0x1b0
[   21.509130]        opp_debug_register+0xc0/0x110
[   21.513800]        _add_opp_dev+0x190/0x1f0
[   21.518033]        dev_pm_opp_get_opp_table+0x160/0x3bc
[   21.523314]        _of_add_opp_table_v2+0x1ac/0x7e0
[   21.528246]        dev_pm_opp_of_add_table+0x1e8/0x210
[   21.533441]        dev_pm_opp_of_cpumask_add_table+0xb8/0xe0
[   21.539172]        cpufreq_init+0x1fc/0x420 [cpufreq_dt]
[   21.544550]        cpufreq_online+0x404/0xd74
[   21.548956]        cpufreq_add_dev+0x170/0x188
[   21.553453]        subsys_interface_register+0x268/0x290
[   21.558823]        cpufreq_register_driver+0x1f0/0x334
[   21.564031]        dt_cpufreq_probe+0x158/0x178 [cpufreq_dt]
[   21.569775]        platform_drv_probe+0xa4/0x130
[   21.569787]        driver_probe_device+0x4a4/0x5e4
[   21.569797]        __driver_attach+0x150/0x1e4
[   21.569810]        bus_for_each_dev+0x114/0x13c
[   21.569821]        driver_attach+0x50/0x5c
[   21.569832]        bus_add_driver+0x2a8/0x2fc
[   21.569842]        driver_register+0x180/0x1c8
[   21.569851]        __platform_driver_register+0x9c/0xac
[   21.569877]        dt_cpufreq_platdrv_init+0x28/0x1000 [cpufreq_dt]
[   21.569892]        do_one_initcall+0x608/0xc54
[   21.569906]        do_init_module+0x174/0x474
[   21.569918]        load_module+0x3cf8/0x3d8c
[   21.569929]        sys_finit_module+0x164/0x184
[   21.569939]        el0_svc_naked+0x30/0x34
[   21.569945]
[   21.569945] other info that might help us debug this:
[   21.569945]
[   21.569951] Chain exists of:
[   21.569951]   &sb->s_type->i_mutex_key#3 --> subsys mutex#6 --> opp_table_lock
[   21.569951]
[   21.569993]  Possible unsafe locking scenario:
[   21.569993]
[   21.569998]        CPU0                    CPU1
[   21.570003]        ----                    ----
[   21.570008]   lock(opp_table_lock);
[   21.570021]                                lock(subsys mutex#6);
[   21.570038]                                lock(opp_table_lock);
[   21.570051]   lock(&sb->s_type->i_mutex_key#3);
[   21.570068]
[   21.570068]  *** DEADLOCK ***
[   21.570068]
[   21.570078] 4 locks held by systemd-udevd/1598:
[   21.570083]  #0: 000000006d91e4b5 (&dev->mutex){....}, at: __driver_attach+0x134/0x1e4
[   21.570118]  #1: 000000007756007b (cpu_hotplug_lock.rw_sem){++++}, at: cpufreq_register_driver+0x154/0x334
[   21.570154]  #2: 000000001273ad9c (subsys mutex#6){+.+.}, at: subsys_interface_register+0x108/0x290
[   21.570192]  #3: 00000000d1aef27f (opp_table_lock){+.+.}, at: dev_pm_opp_get_opp_table+0xbc/0x3bc
[   21.570224]
[   21.570224] stack backtrace:
[   21.570238] CPU: 3 PID: 1598 Comm: systemd-udevd Not tainted 4.18.0-rc3+ #31
[   21.570246] Hardware name: Renesas H3ULCB Kingfisher board based on r8a7795 ES2.0+ (DT)
[   21.570253] Call trace:
[   21.570263]  dump_backtrace+0x0/0x2f0
[   21.570272]  show_stack+0x24/0x30
[   21.570288]  dump_stack+0x148/0x1dc
[   21.570301]  print_circular_bug.isra.11+0x2a8/0x3f0
[   21.570313]  check_prev_add.constprop.20+0x1c0/0xa68
[   21.570323]  __lock_acquire+0x1d9c/0x200c
[   21.570333]  lock_acquire+0x630/0x6a4
[   21.570346]  down_write+0xb8/0x150
[   21.570359]  start_creating+0xb8/0x144
[   21.570371]  debugfs_create_dir+0x2c/0x1b0
[   21.570382]  opp_debug_register+0xc0/0x110
[   21.570391]  _add_opp_dev+0x190/0x1f0
[   21.570402]  dev_pm_opp_get_opp_table+0x160/0x3bc
[   21.570412]  _of_add_opp_table_v2+0x1ac/0x7e0
[   21.570423]  dev_pm_opp_of_add_table+0x1e8/0x210
[   21.570434]  dev_pm_opp_of_cpumask_add_table+0xb8/0xe0
[   21.570456]  cpufreq_init+0x1fc/0x420 [cpufreq_dt]
[   21.570468]  cpufreq_online+0x404/0xd74
[   21.570479]  cpufreq_add_dev+0x170/0x188
[   21.570491]  subsys_interface_register+0x268/0x290
[   21.570503]  cpufreq_register_driver+0x1f0/0x334
[   21.570524]  dt_cpufreq_probe+0x158/0x178 [cpufreq_dt]
[   21.570535]  platform_drv_probe+0xa4/0x130
[   21.570544]  driver_probe_device+0x4a4/0x5e4
[   21.570553]  __driver_attach+0x150/0x1e4
[   21.570564]  bus_for_each_dev+0x114/0x13c
[   21.570576]  driver_attach+0x50/0x5c
[   21.570587]  bus_add_driver+0x2a8/0x2fc
[   21.570597]  driver_register+0x180/0x1c8
[   21.570607]  __platform_driver_register+0x9c/0xac
[   21.570628]  dt_cpufreq_platdrv_init+0x28/0x1000 [cpufreq_dt]
[   21.570638]  do_one_initcall+0x608/0xc54
[   21.570650]  do_init_module+0x174/0x474
[   21.570661]  load_module+0x3cf8/0x3d8c
[   21.570672]  sys_finit_module+0x164/0x184
[   21.570682]  el0_svc_naked+0x30/0x34

Signed-off-by: Eugeniu Rosca <erosca@de.adit-jv.com>
---
 include/linux/lockdep.h  |  4 ++++
 kernel/locking/lockdep.c | 19 +++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 6fc77d4dbdcd..eeed7ea2e198 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -186,6 +186,10 @@ struct lock_list {
 	struct list_head		entry;
 	struct lock_class		*class;
 	struct stack_trace		trace;
+	unsigned long long		ts;
+	char				comm[16];
+	pid_t				pid;
+	int				cpu;
 	int				distance;
 
 	/*
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 5fa4d3138bf1..c980fc42ee16 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -878,6 +878,11 @@ static int add_lock_to_list(struct lock_class *this, struct list_head *head,
 	entry->class = this;
 	entry->distance = distance;
 	entry->trace = *trace;
+	entry->cpu = smp_processor_id();
+	entry->pid = current->pid;
+	entry->ts = local_clock();
+	strlcpy(entry->comm, current->comm, sizeof(entry->comm));
+
 	/*
 	 * Both allocation and removal are done under the graph lock; but
 	 * iteration is under RCU-sched; see look_up_lock_class() and
@@ -1093,6 +1098,20 @@ print_circular_bug_entry(struct lock_list *target, int depth)
 		return 0;
 	printk("\n-> #%u", depth);
 	print_lock_name(target->class);
+
+	if (get_lock_parent(target)) {
+		u64 us = do_div(target->ts, 1000000000UL) / 1000;
+
+		pr_cont("%s/%d/CPU%d)(%llu.%06llu)", target->comm,
+			target->pid, target->cpu, target->ts, us);
+	} else {
+		u64 sec = local_clock();
+		u64 us = do_div(sec, 1000000000UL) / 1000;
+
+		pr_cont("%s/%d/CPU%d)(%llu.%06llu)", current->comm,
+			current->pid, smp_processor_id(), sec, us);
+	}
+
 	printk(KERN_CONT ":\n");
 	print_stack_trace(&target->trace, 6);
 
-- 
2.18.0

