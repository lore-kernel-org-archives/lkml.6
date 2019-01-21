Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F216C3712B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 20:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 113382089F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 20:03:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jB+3n8AZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbfAUUDM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 15:03:12 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:36160 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727699AbfAUUDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 15:03:11 -0500
Received: by mail-vk1-f195.google.com with SMTP id 185so4850635vkc.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 12:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=g3o/q0eHw+o6A4J+E89jZEoMHJiBmk+Ik/eQSO0DvoU=;
        b=jB+3n8AZ8JrOiOdBP/e1vLkswm7CSqthcJmKJw/Qtdbdhl6H3BSI9wcTo0TOGQsTnB
         hjlI4mrRcJj5jhQ4fV/xmYhDJ28OEERfWuVYt+Gp6Xkc836Dq5U02Fd+xLg2YBLtsyac
         bLHJmr2N72BqPf6S5d6gOzJrFXMmdpe3Dk2HE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=g3o/q0eHw+o6A4J+E89jZEoMHJiBmk+Ik/eQSO0DvoU=;
        b=P/3JdnS8TFdKn8V+fXn/ij2xvHUsNhpwbQ0khJtwzh+ZEQQ9vyHtQvo1gtWnIUFYs/
         VNZL/UDnO4Ok+dlAEP2Rk+tEwBPXagXcTp3tNWvyhkDL6DVODUmIgKHq7YsBacuyHmyG
         uEVD7s5OIpGMUwmfYiWeEjiDQ7Hk2Py363Cv1GM8Nv20xjg4NMKF++IUKx4AGHPYYUax
         f/s7Xy9cTcbiC91mxpeDdRc4lu2OaFTUFQLyY/HyE/bUvrpI9tBlVfOE6TgqxKzpWAKH
         J1nCfYbpATEkvlGeDt6psJApluJOd8cvqt9Z4D4FkwkUPOFLPnzPA+3qrXMHdsvuit+p
         fG1g==
X-Gm-Message-State: AJcUukffAKUyhXxUcGLP1DdhItvsiQZswG+hEPjhna+3GZTE9TpDFwEN
        sRQaXDaXvS1Jm8P+FaJDxLCTJSGrNp8=
X-Google-Smtp-Source: ALg8bN6dFRvusSaMmwfIM1a1puRauqZBw/nKcxuIVSX9kCAa69uuedUDq/hLrmT2hpkf/vRiJn1lsQ==
X-Received: by 2002:a1f:95d1:: with SMTP id x200mr12041158vkd.78.1548100988417;
        Mon, 21 Jan 2019 12:03:08 -0800 (PST)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com. [209.85.217.53])
        by smtp.gmail.com with ESMTPSA id r8sm11427580uan.0.2019.01.21.12.03.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jan 2019 12:03:06 -0800 (PST)
Received: by mail-vs1-f53.google.com with SMTP id n13so13353830vsk.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 12:03:06 -0800 (PST)
X-Received: by 2002:a67:848a:: with SMTP id g132mr12529219vsd.222.1548100985401;
 Mon, 21 Jan 2019 12:03:05 -0800 (PST)
MIME-Version: 1.0
References: <1546873978-27797-3-git-send-email-longman@redhat.com> <20190118084456.GA10690@shao2-debian>
In-Reply-To: <20190118084456.GA10690@shao2-debian>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 22 Jan 2019 09:02:53 +1300
X-Gmail-Original-Message-ID: <CAGXu5j+aEs3bq5Ym+VCYGmPQNJZC44vFk9MJDxH1zq=hZ3N4CA@mail.gmail.com>
Message-ID: <CAGXu5j+aEs3bq5Ym+VCYGmPQNJZC44vFk9MJDxH1zq=hZ3N4CA@mail.gmail.com>
Subject: Re: [LKP] [/proc/stat] 3047027b34: reaim.jobs_per_min -4.8% regression
To:     kernel test robot <rong.a.chen@intel.com>,
        Waiman Long <longman@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Daniel Colascione <dancol@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Randy Dunlap <rdunlap@infradead.org>, LKP <lkp@01.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 9:44 PM kernel test robot <rong.a.chen@intel.com> w=
rote:
>
> Greeting,
>
> FYI, we noticed a -4.8% regression of reaim.jobs_per_min due to commit:
>
>
> commit: 3047027b34b8c6404b509903058b89836093acc7 ("[PATCH 2/2] /proc/stat=
: Add sysctl parameter to control irq counts latency")
> url: https://github.com/0day-ci/linux/commits/Waiman-Long/proc-stat-Reduc=
e-irqs-counting-performance-overhead/20190108-104818

Is this expected? (And it seems like other things in the report below
are faster? I don't understand why this particular regression was
called out?)

-Kees

>
>
> in testcase: reaim
> on test machine: 56 threads Intel(R) Xeon(R) CPU E5-2695 v3 @ 2.30GHz wit=
h 256G memory
> with following parameters:
>
>         runtime: 300s
>         nr_task: 5000
>         test: shared_memory
>         cpufreq_governor: performance
>         ucode: 0x3d
>
> test-description: REAIM is an updated and improved version of AIM 7 bench=
mark.
> test-url: https://sourceforge.net/projects/re-aim-7/
>
>
>
> Details are as below:
> -------------------------------------------------------------------------=
------------------------->
>
>
> To reproduce:
>
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp install job.yaml  # job file is attached in this email
>         bin/lkp run     job.yaml
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> compiler/cpufreq_governor/kconfig/nr_task/rootfs/runtime/tbox_group/test/=
testcase/ucode:
>   gcc-7/performance/x86_64-rhel-7.2/5000/debian-x86_64-2018-04-03.cgz/300=
s/lkp-hsw-ep5/shared_memory/reaim/0x3d
>
> commit:
>   51e8bce392 ("/proc/stat: Extract irqs counting code into show_stat_irqs=
()")
>   3047027b34 ("/proc/stat: Add sysctl parameter to control irq counts lat=
ency")
>
> 51e8bce392dd2cc9 3047027b34b8c6404b50990305
> ---------------- --------------------------
>        fail:runs  %reproduction    fail:runs
>            |             |             |
>           1:4          -25%            :4     kmsg.igb#:#:#:exceed_max#se=
cond
>          %stddev     %change         %stddev
>              \          |                \
>     101.96            +7.5%     109.60        reaim.child_systime
>      33.32            -1.8%      32.73        reaim.child_utime
>    5534451            -4.8%    5271308        reaim.jobs_per_min
>       1106            -4.8%       1054        reaim.jobs_per_min_child
>    5800927            -4.9%    5517884        reaim.max_jobs_per_min
>       5.42            +5.0%       5.69        reaim.parent_time
>       1.51            +5.3%       1.59        reaim.std_dev_time
>   29374932            -2.8%   28558608        reaim.time.minor_page_fault=
s
>       1681            +1.6%       1708        reaim.time.percent_of_cpu_t=
his_job_got
>       3841            +4.5%       4012        reaim.time.system_time
>       1234            -4.4%       1180        reaim.time.user_time
>   18500000            -2.7%   18000000        reaim.workload
>    5495296 =C2=B1  9%      -9.5%    4970496        meminfo.DirectMap2M
>       5142 =C2=B1 18%     -43.2%       2920 =C2=B1 46%  numa-vmstat.node0=
.nr_shmem
>      29.00 =C2=B1 32%     +56.9%      45.50 =C2=B1 10%  vmstat.procs.r
>      67175 =C2=B1 37%     +66.6%     111910 =C2=B1 20%  numa-meminfo.node=
0.AnonHugePages
>      20591 =C2=B1 18%     -43.2%      11691 =C2=B1 46%  numa-meminfo.node=
0.Shmem
>      64688 =C2=B1  6%     -36.8%      40906 =C2=B1 19%  slabinfo.kmalloc-=
8.active_objs
>      64691 =C2=B1  6%     -36.8%      40908 =C2=B1 19%  slabinfo.kmalloc-=
8.num_objs
>      37.36 =C2=B1  7%     +11.1%      41.53 =C2=B1  4%  boot-time.boot
>      29.15 =C2=B1  6%     +14.3%      33.31 =C2=B1  3%  boot-time.dhcp
>     847.73 =C2=B1  9%     +12.9%     957.09 =C2=B1  4%  boot-time.idle
>     202.50 =C2=B1100%    +101.7%     408.50        proc-vmstat.nr_mlock
>       8018 =C2=B1  9%     -12.3%       7034 =C2=B1  2%  proc-vmstat.nr_sh=
mem
>   29175944            -2.8%   28369676        proc-vmstat.numa_hit
>   29170351            -2.8%   28364111        proc-vmstat.numa_local
>       5439 =C2=B1  5%     -18.7%       4423 =C2=B1  7%  proc-vmstat.pgact=
ivate
>   30220220            -2.8%   29374906        proc-vmstat.pgalloc_normal
>   30182224            -2.7%   29368266        proc-vmstat.pgfault
>   30186671            -2.8%   29341792        proc-vmstat.pgfree
>      69510 =C2=B1 12%     -34.2%      45759 =C2=B1 33%  sched_debug.cfs_r=
q:/.load.avg
>      30.21 =C2=B1 24%     -33.6%      20.05 =C2=B1 20%  sched_debug.cfs_r=
q:/.runnable_load_avg.avg
>      66447 =C2=B1 12%     -37.6%      41460 =C2=B1 37%  sched_debug.cfs_r=
q:/.runnable_weight.avg
>      12.35 =C2=B1  4%     +88.0%      23.22 =C2=B1 15%  sched_debug.cpu.c=
lock.stddev
>      12.35 =C2=B1  4%     +88.0%      23.22 =C2=B1 15%  sched_debug.cpu.c=
lock_task.stddev
>      30.06 =C2=B1 12%     -26.5%      22.10 =C2=B1 13%  sched_debug.cpu.c=
pu_load[0].avg
>      29.37 =C2=B1  9%     -22.6%      22.72 =C2=B1 13%  sched_debug.cpu.c=
pu_load[1].avg
>      28.71 =C2=B1  6%     -21.1%      22.66 =C2=B1 16%  sched_debug.cpu.c=
pu_load[2].avg
>      17985           -12.0%      15823 =C2=B1  2%  sched_debug.cpu.curr->=
pid.max
>      67478 =C2=B1  6%     -32.5%      45531 =C2=B1 24%  sched_debug.cpu.l=
oad.avg
>      10369 =C2=B1 49%    -100.0%       0.00        sched_debug.cpu.load.m=
in
>       0.21 =C2=B1 34%    -100.0%       0.00        sched_debug.cpu.nr_run=
ning.min
>      12.98           -16.3%      10.86 =C2=B1 11%  perf-stat.i.MPKI
>  5.712e+09            -3.8%  5.492e+09        perf-stat.i.branch-instruct=
ions
>  1.024e+08            -3.7%   98557208        perf-stat.i.branch-misses
>       8.17            +0.4        8.58 =C2=B1  2%  perf-stat.i.cache-miss=
-rate%
>    7839589           +10.5%    8659798        perf-stat.i.cache-misses
>   86324420            +3.8%   89595898 =C2=B1  2%  perf-stat.i.cache-refe=
rences
>       1.55 =C2=B1  2%      -4.0%       1.49        perf-stat.i.cpi
>       2290            -1.9%       2246        perf-stat.i.cpu-migrations
>       4667           -10.9%       4160        perf-stat.i.cycles-between-=
cache-misses
>  8.749e+09            -3.9%  8.409e+09        perf-stat.i.dTLB-loads
>     527660 =C2=B1  3%     -15.0%     448539 =C2=B1  5%  perf-stat.i.dTLB-=
store-misses
>  5.747e+09            -4.3%  5.499e+09        perf-stat.i.dTLB-stores
>   53047071            -3.5%   51190942        perf-stat.i.iTLB-load-misse=
s
>   20576112           -13.7%   17759009 =C2=B1  2%  perf-stat.i.iTLB-loads
>  3.207e+10            -3.9%  3.083e+10        perf-stat.i.instructions
>       0.77            -2.3%       0.75        perf-stat.i.ipc
>      99933            -3.8%      96127        perf-stat.i.minor-faults
>    4325719            +5.6%    4568226        perf-stat.i.node-load-misse=
s
>      52.39            -2.0       50.36        perf-stat.i.node-store-miss=
-rate%
>    1411700           +20.9%    1706321        perf-stat.i.node-store-miss=
es
>     883790           +34.1%    1184836        perf-stat.i.node-stores
>      99933            -3.8%      96127        perf-stat.i.page-faults
>       2.69            +7.9%       2.91        perf-stat.overall.MPKI
>       9.08            +0.6        9.67 =C2=B1  2%  perf-stat.overall.cach=
e-miss-rate%
>       1.13            +5.0%       1.19        perf-stat.overall.cpi
>       4633            -8.6%       4233        perf-stat.overall.cycles-be=
tween-cache-misses
>       0.01 =C2=B1  2%      -0.0        0.01 =C2=B1  4%  perf-stat.overall=
.dTLB-store-miss-rate%
>      72.05            +2.2       74.24        perf-stat.overall.iTLB-load=
-miss-rate%
>       0.88            -4.8%       0.84        perf-stat.overall.ipc
>      78.12            +1.4       79.52        perf-stat.overall.node-load=
-miss-rate%
>      61.49            -2.5       59.01        perf-stat.overall.node-stor=
e-miss-rate%
>  5.688e+09            -3.8%  5.471e+09        perf-stat.ps.branch-instruc=
tions
>   1.02e+08            -3.7%   98177745        perf-stat.ps.branch-misses
>    7807912           +10.5%    8626353        perf-stat.ps.cache-misses
>   85999504            +3.8%   89266688 =C2=B1  2%  perf-stat.ps.cache-ref=
erences
>       2282            -1.9%       2239        perf-stat.ps.cpu-migrations
>  8.713e+09            -3.9%  8.376e+09        perf-stat.ps.dTLB-loads
>     525761 =C2=B1  3%     -15.0%     446967 =C2=B1  5%  perf-stat.ps.dTLB=
-store-misses
>  5.723e+09            -4.3%  5.478e+09        perf-stat.ps.dTLB-stores
>   52823322            -3.5%   50990190        perf-stat.ps.iTLB-load-miss=
es
>   20490261           -13.7%   17689923 =C2=B1  2%  perf-stat.ps.iTLB-load=
s
>  3.193e+10            -3.8%  3.071e+10        perf-stat.ps.instructions
>      99560            -3.8%      95786        perf-stat.ps.minor-faults
>    4308031            +5.6%    4550453        perf-stat.ps.node-load-miss=
es
>    1405805           +20.9%    1699670        perf-stat.ps.node-store-mis=
ses
>     880319           +34.1%    1180378        perf-stat.ps.node-stores
>      99560            -3.8%      95786        perf-stat.ps.page-faults
>  9.664e+12            -2.8%  9.397e+12        perf-stat.total.instruction=
s
>      33.09 =C2=B1  7%     -25.0        8.10 =C2=B1 45%  perf-profile.call=
trace.cycles-pp.entry_SYSCALL_64_after_hwframe
>      32.21 =C2=B1  7%     -24.3        7.92 =C2=B1 45%  perf-profile.call=
trace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      22.36 =C2=B1  7%     -17.1        5.24 =C2=B1 49%  perf-profile.call=
trace.cycles-pp.do_semtimedop.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      10.57 =C2=B1  5%      -8.3        2.31 =C2=B1 48%  perf-profile.call=
trace.cycles-pp.entry_SYSCALL_64
>       9.60 =C2=B1  4%      -7.6        2.03 =C2=B1 49%  perf-profile.call=
trace.cycles-pp.syscall_return_via_sysret
>       3.68 =C2=B1  8%      -3.3        0.43 =C2=B1102%  perf-profile.call=
trace.cycles-pp.security_ipc_permission.do_semtimedop.do_syscall_64.entry_S=
YSCALL_64_after_hwframe
>       4.37 =C2=B1  9%      -2.8        1.60 =C2=B1 50%  perf-profile.call=
trace.cycles-pp.ipc_obtain_object_check.do_semtimedop.do_syscall_64.entry_S=
YSCALL_64_after_hwframe
>       2.30 =C2=B1  2%      -1.9        0.44 =C2=B1102%  perf-profile.call=
trace.cycles-pp.security_sem_semop.do_semtimedop.do_syscall_64.entry_SYSCAL=
L_64_after_hwframe
>       5.10 =C2=B1  3%      -1.6        3.46 =C2=B1 10%  perf-profile.call=
trace.cycles-pp.ipc_has_perm.security_ipc_permission.do_semtimedop.do_sysca=
ll_64.entry_SYSCALL_64_after_hwframe
>       3.20            -1.3        1.95 =C2=B1 23%  perf-profile.calltrace=
.cycles-pp.avc_has_perm.ipc_has_perm.security_ipc_permission.do_semtimedop.=
do_syscall_64
>       2.12 =C2=B1  3%      -0.4        1.76 =C2=B1  4%  perf-profile.call=
trace.cycles-pp.avc_has_perm.ipc_has_perm.security_sem_semop.do_semtimedop.=
do_syscall_64
>       1.03 =C2=B1  2%      -0.1        0.94 =C2=B1  3%  perf-profile.call=
trace.cycles-pp.__do_page_fault.do_page_fault.page_fault
>       1.06 =C2=B1  2%      -0.1        0.97 =C2=B1  3%  perf-profile.call=
trace.cycles-pp.do_page_fault.page_fault
>       1.06 =C2=B1  2%      -0.1        0.98 =C2=B1  3%  perf-profile.call=
trace.cycles-pp.page_fault
>       0.91 =C2=B1  3%      -0.1        0.82 =C2=B1  3%  perf-profile.call=
trace.cycles-pp.handle_mm_fault.__do_page_fault.do_page_fault.page_fault
>       0.86 =C2=B1  3%      -0.1        0.78 =C2=B1  3%  perf-profile.call=
trace.cycles-pp.__handle_mm_fault.handle_mm_fault.__do_page_fault.do_page_f=
ault.page_fault
>       0.61 =C2=B1 12%      +0.2        0.79 =C2=B1 12%  perf-profile.call=
trace.cycles-pp.smp_apic_timer_interrupt.apic_timer_interrupt.cpuidle_enter=
_state.do_idle.cpu_startup_entry
>       0.61 =C2=B1 10%      +0.2        0.79 =C2=B1 10%  perf-profile.call=
trace.cycles-pp.shm_close.remove_vma.__do_munmap.ksys_shmdt.do_syscall_64
>       0.67 =C2=B1 11%      +0.2        0.86 =C2=B1 10%  perf-profile.call=
trace.cycles-pp.apic_timer_interrupt.cpuidle_enter_state.do_idle.cpu_startu=
p_entry.start_secondary
>       0.40 =C2=B1 57%      +0.2        0.62 =C2=B1  8%  perf-profile.call=
trace.cycles-pp.call_rwsem_down_write_failed.down_write.do_shmat.__x64_sys_=
shmat.do_syscall_64
>       0.40 =C2=B1 57%      +0.2        0.62 =C2=B1  7%  perf-profile.call=
trace.cycles-pp.rwsem_down_write_failed.call_rwsem_down_write_failed.down_w=
rite.do_shmat.__x64_sys_shmat
>       0.43 =C2=B1 57%      +0.2        0.66 =C2=B1  7%  perf-profile.call=
trace.cycles-pp.down_write.do_shmat.__x64_sys_shmat.do_syscall_64.entry_SYS=
CALL_64_after_hwframe
>       0.41 =C2=B1 57%      +0.3        0.67 =C2=B1  9%  perf-profile.call=
trace.cycles-pp.call_rwsem_down_write_failed.down_write.shm_close.remove_vm=
a.__do_munmap
>       0.40 =C2=B1 57%      +0.3        0.66 =C2=B1  7%  perf-profile.call=
trace.cycles-pp.down_write.ipcget.__x64_sys_shmget.do_syscall_64.entry_SYSC=
ALL_64_after_hwframe
>       0.41 =C2=B1 57%      +0.3        0.67 =C2=B1  9%  perf-profile.call=
trace.cycles-pp.rwsem_down_write_failed.call_rwsem_down_write_failed.down_w=
rite.shm_close.remove_vma
>       0.44 =C2=B1 57%      +0.3        0.71 =C2=B1  9%  perf-profile.call=
trace.cycles-pp.down_write.shm_close.remove_vma.__do_munmap.ksys_shmdt
>       0.26 =C2=B1100%      +0.4        0.67 =C2=B1  8%  perf-profile.call=
trace.cycles-pp.dput.__fput.task_work_run.exit_to_usermode_loop.do_syscall_=
64
>       0.28 =C2=B1100%      +0.4        0.71 =C2=B1  7%  perf-profile.call=
trace.cycles-pp.__might_fault._copy_from_user.do_semtimedop.do_syscall_64.e=
ntry_SYSCALL_64_after_hwframe
>       0.58 =C2=B1 10%      +0.4        1.03 =C2=B1  6%  perf-profile.call=
trace.cycles-pp.shmctl_down.ksys_shmctl.do_syscall_64.entry_SYSCALL_64_afte=
r_hwframe.shmctl
>       0.59 =C2=B1 10%      +0.5        1.05 =C2=B1  6%  perf-profile.call=
trace.cycles-pp.ksys_shmctl.do_syscall_64.entry_SYSCALL_64_after_hwframe.sh=
mctl
>       0.13 =C2=B1173%      +0.5        0.62 =C2=B1  7%  perf-profile.call=
trace.cycles-pp.call_rwsem_down_write_failed.down_write.ipcget.__x64_sys_sh=
mget.do_syscall_64
>       0.13 =C2=B1173%      +0.5        0.62 =C2=B1  7%  perf-profile.call=
trace.cycles-pp.rwsem_down_write_failed.call_rwsem_down_write_failed.down_w=
rite.ipcget.__x64_sys_shmget
>       0.12 =C2=B1173%      +0.5        0.66 =C2=B1  8%  perf-profile.call=
trace.cycles-pp.dentry_kill.dput.__fput.task_work_run.exit_to_usermode_loop
>       0.00            +0.6        0.58 =C2=B1  7%  perf-profile.calltrace=
.cycles-pp.copy_user_generic_unrolled._copy_from_user.do_semtimedop.do_sysc=
all_64.entry_SYSCALL_64_after_hwframe
>       0.00            +0.6        0.60 =C2=B1  7%  perf-profile.calltrace=
.cycles-pp.unmap_region.__do_munmap.ksys_shmdt.do_syscall_64.entry_SYSCALL_=
64_after_hwframe
>       0.00            +0.6        0.61 =C2=B1  7%  perf-profile.calltrace=
.cycles-pp.wait_consider_task.do_wait.kernel_wait4.__do_sys_wait4.do_syscal=
l_64
>       0.00            +0.6        0.62 =C2=B1  4%  perf-profile.calltrace=
.cycles-pp.semctl_down.ksys_semctl.do_syscall_64.entry_SYSCALL_64_after_hwf=
rame.semctl
>       0.75 =C2=B1  8%      +0.6        1.38 =C2=B1  8%  perf-profile.call=
trace.cycles-pp.__x64_sys_semop.do_syscall_64.entry_SYSCALL_64_after_hwfram=
e.semop
>       0.00            +0.6        0.65 =C2=B1  9%  perf-profile.calltrace=
.cycles-pp.ipcperms.do_semtimedop.do_syscall_64.entry_SYSCALL_64_after_hwfr=
ame.semop
>       0.00            +0.6        0.65 =C2=B1  8%  perf-profile.calltrace=
.cycles-pp.__dentry_kill.dentry_kill.dput.__fput.task_work_run
>       0.89 =C2=B1 11%      +0.7        1.57 =C2=B1  8%  perf-profile.call=
trace.cycles-pp.do_shmat.__x64_sys_shmat.do_syscall_64.entry_SYSCALL_64_aft=
er_hwframe.shmat
>       0.90 =C2=B1 11%      +0.7        1.58 =C2=B1  8%  perf-profile.call=
trace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.shmat
>       0.90 =C2=B1 10%      +0.7        1.58 =C2=B1  8%  perf-profile.call=
trace.cycles-pp.__x64_sys_shmat.do_syscall_64.entry_SYSCALL_64_after_hwfram=
e.shmat
>       0.00            +0.7        0.68 =C2=B1  5%  perf-profile.calltrace=
.cycles-pp.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64.entry_SYSCALL_=
64_after_hwframe
>       0.00            +0.7        0.69 =C2=B1  6%  perf-profile.calltrace=
.cycles-pp.entry_SYSCALL_64_after_hwframe.wait
>       0.00            +0.7        0.69 =C2=B1  6%  perf-profile.calltrace=
.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.wait
>       0.00            +0.7        0.69 =C2=B1  6%  perf-profile.calltrace=
.cycles-pp.__do_sys_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe.wait
>       0.00            +0.7        0.69 =C2=B1  6%  perf-profile.calltrace=
.cycles-pp.kernel_wait4.__do_sys_wait4.do_syscall_64.entry_SYSCALL_64_after=
_hwframe.wait
>       0.90 =C2=B1 11%      +0.7        1.59 =C2=B1  8%  perf-profile.call=
trace.cycles-pp.entry_SYSCALL_64_after_hwframe.shmat
>       0.00            +0.7        0.69 =C2=B1  5%  perf-profile.calltrace=
.cycles-pp.wait
>       0.27 =C2=B1100%      +0.7        0.99 =C2=B1  7%  perf-profile.call=
trace.cycles-pp.perform_atomic_semop.do_semtimedop.do_syscall_64.entry_SYSC=
ALL_64_after_hwframe.semop
>       0.95 =C2=B1 11%      +0.7        1.67 =C2=B1  8%  perf-profile.call=
trace.cycles-pp.shmat
>       0.00            +0.7        0.73 =C2=B1  6%  perf-profile.calltrace=
.cycles-pp.ipcget.ksys_semget.do_syscall_64.entry_SYSCALL_64_after_hwframe.=
semget
>       0.00            +0.7        0.74 =C2=B1  8%  perf-profile.calltrace=
.cycles-pp.task_work_run.exit_to_usermode_loop.do_syscall_64.entry_SYSCALL_=
64_after_hwframe.shmctl
>       0.72 =C2=B1  9%      +0.7        1.46 =C2=B1  7%  perf-profile.call=
trace.cycles-pp._raw_spin_lock.do_semtimedop.do_syscall_64.entry_SYSCALL_64=
_after_hwframe.semop
>       0.00            +0.8        0.75 =C2=B1  5%  perf-profile.calltrace=
.cycles-pp.ksys_semget.do_syscall_64.entry_SYSCALL_64_after_hwframe.semget
>       0.00            +0.8        0.76 =C2=B1  8%  perf-profile.calltrace=
.cycles-pp.exit_to_usermode_loop.do_syscall_64.entry_SYSCALL_64_after_hwfra=
me.shmctl
>       0.89 =C2=B1  9%      +0.8        1.65 =C2=B1  9%  perf-profile.call=
trace.cycles-pp.__do_munmap.ksys_shmdt.do_syscall_64.entry_SYSCALL_64_after=
_hwframe.shmdt
>       0.00            +0.8        0.76 =C2=B1  5%  perf-profile.calltrace=
.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.semget
>       0.00            +0.8        0.76 =C2=B1  5%  perf-profile.calltrace=
.cycles-pp.entry_SYSCALL_64_after_hwframe.semget
>       0.90 =C2=B1  9%      +0.8        1.68 =C2=B1  9%  perf-profile.call=
trace.cycles-pp.ksys_shmdt.do_syscall_64.entry_SYSCALL_64_after_hwframe.shm=
dt
>       0.00            +0.8        0.78 =C2=B1  6%  perf-profile.calltrace=
.cycles-pp.ksys_semctl.do_syscall_64.entry_SYSCALL_64_after_hwframe.semctl
>       0.00            +0.8        0.80 =C2=B1  5%  perf-profile.calltrace=
.cycles-pp.entry_SYSCALL_64_after_hwframe.semctl
>       0.00            +0.8        0.80 =C2=B1  5%  perf-profile.calltrace=
.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.semctl
>       0.00            +0.8        0.85 =C2=B1  5%  perf-profile.calltrace=
.cycles-pp.semget
>       0.97 =C2=B1  9%      +0.8        1.82 =C2=B1  6%  perf-profile.call=
trace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.shmctl
>       0.97 =C2=B1  9%      +0.8        1.82 =C2=B1  7%  perf-profile.call=
trace.cycles-pp.entry_SYSCALL_64_after_hwframe.shmctl
>       0.94 =C2=B1 10%      +0.9        1.79 =C2=B1  6%  perf-profile.call=
trace.cycles-pp._copy_from_user.do_semtimedop.do_syscall_64.entry_SYSCALL_6=
4_after_hwframe.semop
>       1.04 =C2=B1  9%      +0.9        1.91 =C2=B1  6%  perf-profile.call=
trace.cycles-pp.ipcget.__x64_sys_shmget.do_syscall_64.entry_SYSCALL_64_afte=
r_hwframe.shmget
>       1.05 =C2=B1  9%      +0.9        1.92 =C2=B1  5%  perf-profile.call=
trace.cycles-pp.__x64_sys_shmget.do_syscall_64.entry_SYSCALL_64_after_hwfra=
me.shmget
>       1.05 =C2=B1  9%      +0.9        1.93 =C2=B1  6%  perf-profile.call=
trace.cycles-pp.entry_SYSCALL_64_after_hwframe.shmget
>       1.05 =C2=B1  9%      +0.9        1.93 =C2=B1  6%  perf-profile.call=
trace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.shmget
>       1.02 =C2=B1  9%      +0.9        1.92 =C2=B1  7%  perf-profile.call=
trace.cycles-pp.shmctl
>       1.00 =C2=B1  9%      +0.9        1.93 =C2=B1  9%  perf-profile.call=
trace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.shmdt
>       1.00 =C2=B1  8%      +0.9        1.94 =C2=B1  9%  perf-profile.call=
trace.cycles-pp.entry_SYSCALL_64_after_hwframe.shmdt
>       1.13 =C2=B1  8%      +0.9        2.08 =C2=B1  6%  perf-profile.call=
trace.cycles-pp.shmget
>       0.00            +1.0        0.97 =C2=B1  5%  perf-profile.calltrace=
.cycles-pp.semctl
>       1.03 =C2=B1  9%      +1.0        1.99 =C2=B1  5%  perf-profile.call=
trace.cycles-pp.do_smart_update.do_semtimedop.do_syscall_64.entry_SYSCALL_6=
4_after_hwframe.semop
>       1.04 =C2=B1  8%      +1.0        2.03 =C2=B1  9%  perf-profile.call=
trace.cycles-pp.shmdt
>       2.61 =C2=B1  9%      +1.3        3.89 =C2=B1 14%  perf-profile.call=
trace.cycles-pp.security_ipc_permission.do_semtimedop.do_syscall_64.entry_S=
YSCALL_64_after_hwframe.semop
>       1.65 =C2=B1 13%      +2.0        3.65 =C2=B1  7%  perf-profile.call=
trace.cycles-pp.security_sem_semop.do_semtimedop.do_syscall_64.entry_SYSCAL=
L_64_after_hwframe.semop
>       1.61 =C2=B1  6%      +5.3        6.89 =C2=B1  2%  perf-profile.call=
trace.cycles-pp.idr_find.ipc_obtain_object_check.do_semtimedop.do_syscall_6=
4.entry_SYSCALL_64_after_hwframe
>       6.45 =C2=B1  9%      +6.2       12.63 =C2=B1  6%  perf-profile.call=
trace.cycles-pp.syscall_return_via_sysret.semop
>       2.92 =C2=B1  5%      +8.0       10.88 =C2=B1  7%  perf-profile.call=
trace.cycles-pp.ipc_obtain_object_check.do_semtimedop.do_syscall_64.entry_S=
YSCALL_64_after_hwframe.semop
>       9.07 =C2=B1  8%      +8.8       17.85 =C2=B1  6%  perf-profile.call=
trace.cycles-pp.entry_SYSCALL_64.semop
>      15.56 =C2=B1  8%     +18.8       34.38 =C2=B1  6%  perf-profile.call=
trace.cycles-pp.do_semtimedop.do_syscall_64.entry_SYSCALL_64_after_hwframe.=
semop
>      17.40 =C2=B1  8%     +20.4       37.82 =C2=B1  6%  perf-profile.call=
trace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.semop
>      17.99 =C2=B1  8%     +21.0       39.00 =C2=B1  6%  perf-profile.call=
trace.cycles-pp.entry_SYSCALL_64_after_hwframe.semop
>      33.85 =C2=B1  8%     +36.1       69.98 =C2=B1  6%  perf-profile.call=
trace.cycles-pp.semop
>
>
>
>                       reaim.time.percent_of_cpu_this_job_got
>
>   1800 +-+---------------------------------------------------------------=
---+
>        |         O                                                       =
   |
>   1780 +-OO O O     O                                                    =
   |
>   1760 O-+     O   O  OO                                                 =
   |
>        |                                                                 =
   |
>   1740 +-+                                                               =
   |
>        |                                                                 =
   |
>   1720 +-+                  O                       .+.                  =
   |
>        |                   O  O                    +   +                 =
   |
>   1700 +-+               O                       .+    :                 =
   |
>   1680 +-+      .+      .+.    .+ .+.+         .+       :         +.  .+.=
++.|
>        |.++.+.++  :  .++   ++.+  +    +.+.++.++         +.+.++.+.+  ++   =
   |
>   1660 +-+        : +                                                    =
   |
>        |           +                                                     =
   |
>   1640 +-+---------------------------------------------------------------=
---+
>
>
> [*] bisect-good sample
> [O] bisect-bad  sample
>
>
>
> Disclaimer:
> Results have been estimated based on internal Intel analysis and are prov=
ided
> for informational purposes only. Any difference in system hardware or sof=
tware
> design or configuration may affect actual performance.
>
>
> Thanks,
> Rong Chen



--=20
Kees Cook
