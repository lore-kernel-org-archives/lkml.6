Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A2FC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56FE920866
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:14:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cSjSMGkz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729592AbfAONOB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 08:14:01 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:45048 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728066AbfAONOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 08:14:00 -0500
Received: by mail-io1-f65.google.com with SMTP id r200so1959821iod.11
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 05:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vq9w96d0V1bY8w9Jczu7VtOBGCX5dpN2qXJ0q+JA2WU=;
        b=cSjSMGkzMa/D+hrMXZ6w5p1eKa2RLfXJgmzg3H2loGf2zux60f7wdPDYHAePqOwM58
         Ia1tTWDbhEnf/5D5f2A9DLci0+3QDgaDLnqlfa8ZcT9+CaHJjUDKwQHvn29ePXX8rNU8
         SciOPMbFP/HtLo1LtAvj5aIThdeckAWCPbiDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vq9w96d0V1bY8w9Jczu7VtOBGCX5dpN2qXJ0q+JA2WU=;
        b=MYXrpjreU4J4uY22yySMBPkA2p1ahlmmgNZ4OXN69fz3CwvJzbj19WDUw1Nag0CcM/
         TD5igNZHo3jWYTxNV4OLlSEBu9KBU3BiO+Y+voWY/et0KB5k8dwYoDbeTEcJ21S688jb
         OX3mTXJC1XsQx8SiYApI4CpktwIkOUnsebI+D5ycjDVjg5j+BSneHKwrGwPYG9j5bmFk
         1/pmRfd7U61X9mnVVKze6JiTY5PKPZtMdwp3B9ybNFR4Yrofh8tqABuEcMMhz3JzHkuA
         f8E7cTPEIl9F595uYAldqQz1bZXust8uKYyDAqRZ6BPGOc5EDcWjBdvXDcmzODjp7hz6
         HyHA==
X-Gm-Message-State: AJcUukfJ/NlGyFvX4LeaC2tr+vj4ltickR9RfRsp+V8oKAwT1mrUy486
        ijJjF8wNuv5Yyxfbn01YCyNAAweqT8Cz8hZMO7KTDg==
X-Google-Smtp-Source: ALg8bN7D5HWtnOzr2hTEllPcYJ1mwP9mSYCfmYJMjlwVrIwLA02DYLgEbqJmGSLikFfJryu4aPqVtzxcaGrbjnYSmqo=
X-Received: by 2002:a6b:c8c9:: with SMTP id y192mr1770540iof.183.1547558039315;
 Tue, 15 Jan 2019 05:13:59 -0800 (PST)
MIME-Version: 1.0
References: <20190115032444.GP17624@shao2-debian>
In-Reply-To: <20190115032444.GP17624@shao2-debian>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 15 Jan 2019 14:13:47 +0100
Message-ID: <CAKfTPtB4cHpF2JcUiOLbmczDVSLEmBCpNDcYqCdAqwYZ2LAsRg@mail.gmail.com>
Subject: Re: [LKP] [PM] 8234f6734c: will-it-scale.per_process_ops -3.6% regression
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKP <lkp@01.org>, Ladislav Michl <ladis@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rong,

On Tue, 15 Jan 2019 at 04:24, kernel test robot <rong.a.chen@intel.com> wro=
te:
>
> Greeting,
>
> FYI, we noticed a -3.6% regression of will-it-scale.per_process_ops due t=
o commit:
>
>
> commit: 8234f6734c5d74ac794e5517437f51c57d65f865 ("PM-runtime: Switch aut=
osuspend over to using hrtimers")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>

Could you rerun with the patch :
https://lore.kernel.org/patchwork/patch/1030857/ ?
It optimizes autosuspend by reducing the number of call to ktime_get

Regards,
Vincent

> in testcase: will-it-scale
> on test machine: 104 threads Skylake with 192G memory
> with following parameters:
>
>         nr_task: 100%
>         mode: process
>         test: poll2
>         cpufreq_governor: performance
>
> test-description: Will It Scale takes a testcase and runs it from 1 throu=
gh to n parallel copies to see if the testcase will scale. It builds both a=
 process and threads based test in order to see any differences between the=
 two.
> test-url: https://github.com/antonblanchard/will-it-scale
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
> compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/tes=
tcase:
>   gcc-7/performance/x86_64-rhel-7.2/process/100%/debian-x86_64-2018-04-03=
.cgz/lkp-skl-fpga01/poll2/will-it-scale
>
> commit:
>   v4.20-rc7
>   8234f6734c ("PM-runtime: Switch autosuspend over to using hrtimers")
>
>        v4.20-rc7 8234f6734c5d74ac794e551743
> ---------------- --------------------------
>        fail:runs  %reproduction    fail:runs
>            |             |             |
>            :2           50%           1:4     dmesg.WARNING:at#for_ip_int=
errupt_entry/0x
>          %stddev     %change         %stddev
>              \          |                \
>     240408            -3.6%     231711        will-it-scale.per_process_o=
ps
>   25002520            -3.6%   24097991        will-it-scale.workload
>     351914            -1.7%     345882        interrupts.CAL:Function_cal=
l_interrupts
>       1.77 =C2=B1 45%      -1.1        0.64        mpstat.cpu.idle%
>     106164 =C2=B1 24%     -23.2%      81494 =C2=B1 28%  numa-meminfo.node=
0.AnonHugePages
>     326430 =C2=B1  8%     -11.3%     289513        softirqs.SCHED
>       1294            -2.0%       1268        vmstat.system.cs
>       3178           +48.4%       4716 =C2=B1 16%  slabinfo.eventpoll_pwq=
.active_objs
>       3178           +48.4%       4716 =C2=B1 16%  slabinfo.eventpoll_pwq=
.num_objs
>     336.32          -100.0%       0.00        uptime.boot
>       3192          -100.0%       0.00        uptime.idle
>  3.456e+08 =C2=B1 76%     -89.9%   34913819 =C2=B1 62%  cpuidle.C1E.time
>     747832 =C2=B1 72%     -87.5%      93171 =C2=B1 45%  cpuidle.C1E.usage
>      16209 =C2=B1 26%     -38.2%      10021 =C2=B1 44%  cpuidle.POLL.time
>       6352 =C2=B1 32%     -39.5%       3843 =C2=B1 48%  cpuidle.POLL.usag=
e
>     885259 =C2=B1  2%     -13.8%     763434 =C2=B1  7%  numa-vmstat.node0=
.numa_hit
>     865117 =C2=B1  2%     -13.9%     744992 =C2=B1  7%  numa-vmstat.node0=
.numa_local
>     405085 =C2=B1  7%     +38.0%     558905 =C2=B1  9%  numa-vmstat.node1=
.numa_hit
>     254056 =C2=B1 11%     +59.7%     405824 =C2=B1 13%  numa-vmstat.node1=
.numa_local
>     738158 =C2=B1 73%     -88.5%      85078 =C2=B1 47%  turbostat.C1E
>       1.07 =C2=B1 76%      -1.0        0.11 =C2=B1 62%  turbostat.C1E%
>       1.58 =C2=B1 49%     -65.4%       0.55 =C2=B1  6%  turbostat.CPU%c1
>       0.15 =C2=B1 13%     -35.0%       0.10 =C2=B1 38%  turbostat.CPU%c6
>     153.97 =C2=B1 16%     -54.7       99.31        turbostat.PKG_%
>      64141            +1.5%      65072        proc-vmstat.nr_anon_pages
>      19541            -7.0%      18178 =C2=B1  8%  proc-vmstat.nr_shmem
>      18296            +1.1%      18506        proc-vmstat.nr_slab_reclaim=
able
>     713938            -2.3%     697489        proc-vmstat.numa_hit
>     693688            -2.4%     677228        proc-vmstat.numa_local
>     772220            -1.9%     757334        proc-vmstat.pgalloc_normal
>     798565            -1.8%     784042        proc-vmstat.pgfault
>     732336            -2.7%     712661        proc-vmstat.pgfree
>      20.33 =C2=B1  4%      -7.0%      18.92        sched_debug.cfs_rq:/.r=
unnable_load_avg.max
>     160603           -44.5%      89108 =C2=B1 38%  sched_debug.cfs_rq:/.s=
pread0.avg
>     250694           -29.3%     177358 =C2=B1 18%  sched_debug.cfs_rq:/.s=
pread0.max
>       1109 =C2=B1  4%      -7.0%       1031        sched_debug.cfs_rq:/.u=
til_avg.max
>      20.33 =C2=B1  4%      -7.2%      18.88        sched_debug.cpu.cpu_lo=
ad[0].max
>     -10.00           +35.0%     -13.50        sched_debug.cpu.nr_uninterr=
uptible.min
>       3.56 =C2=B1 10%     +44.2%       5.14 =C2=B1 18%  sched_debug.cpu.n=
r_uninterruptible.stddev
>      87.10 =C2=B1 24%     -34.0%      57.44 =C2=B1 37%  sched_debug.cpu.s=
ched_goidle.avg
>     239.48           -25.6%     178.07 =C2=B1 18%  sched_debug.cpu.sched_=
goidle.stddev
>     332.67 =C2=B1  7%     -25.5%     247.83 =C2=B1 13%  sched_debug.cpu.t=
twu_count.min
>     231.67 =C2=B1  8%     -15.4%     195.96 =C2=B1 12%  sched_debug.cpu.t=
twu_local.min
>      95.47           -95.5        0.00        perf-profile.calltrace.cycl=
es-pp.poll
>      90.26           -90.3        0.00        perf-profile.calltrace.cycl=
es-pp.entry_SYSCALL_64_after_hwframe.poll
>      90.08           -90.1        0.00        perf-profile.calltrace.cycl=
es-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.poll
>      89.84           -89.8        0.00        perf-profile.calltrace.cycl=
es-pp.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_after_hwframe.poll
>      88.04           -88.0        0.00        perf-profile.calltrace.cycl=
es-pp.do_sys_poll.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_after_hwfra=
me.poll
>       2.66            -0.1        2.54        perf-profile.calltrace.cycl=
es-pp._copy_from_user.do_sys_poll.__x64_sys_poll.do_syscall_64.entry_SYSCAL=
L_64_after_hwframe
>       1.90            -0.1        1.81        perf-profile.calltrace.cycl=
es-pp.copy_user_enhanced_fast_string._copy_from_user.do_sys_poll.__x64_sys_=
poll.do_syscall_64
>       2.56            +0.1        2.64        perf-profile.calltrace.cycl=
es-pp.__fdget.do_sys_poll.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_aft=
er_hwframe
>       0.00            +2.3        2.29        perf-profile.calltrace.cycl=
es-pp.syscall_return_via_sysret
>       0.00            +2.3        2.34        perf-profile.calltrace.cycl=
es-pp.entry_SYSCALL_64
>      17.45            +3.8       21.24        perf-profile.calltrace.cycl=
es-pp.__fget_light.do_sys_poll.__x64_sys_poll.do_syscall_64.entry_SYSCALL_6=
4_after_hwframe
>       0.00           +92.7       92.66        perf-profile.calltrace.cycl=
es-pp.do_sys_poll.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_after_hwfra=
me
>       0.00           +94.5       94.51        perf-profile.calltrace.cycl=
es-pp.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       0.00           +94.8       94.75        perf-profile.calltrace.cycl=
es-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       0.00           +94.9       94.92        perf-profile.calltrace.cycl=
es-pp.entry_SYSCALL_64_after_hwframe
>      96.03           -96.0        0.00        perf-profile.children.cycle=
s-pp.poll
>      90.29           -90.3        0.00        perf-profile.children.cycle=
s-pp.entry_SYSCALL_64_after_hwframe
>      90.11           -90.1        0.00        perf-profile.children.cycle=
s-pp.do_syscall_64
>      89.87           -89.9        0.00        perf-profile.children.cycle=
s-pp.__x64_sys_poll
>      89.39           -89.4        0.00        perf-profile.children.cycle=
s-pp.do_sys_poll
>      16.19           -16.2        0.00        perf-profile.children.cycle=
s-pp.__fget_light
>      68.59           -68.6        0.00        perf-profile.self.cycles-pp=
.do_sys_poll
>      14.84           -14.8        0.00        perf-profile.self.cycles-pp=
.__fget_light
>  1.759e+13          -100.0%       0.00        perf-stat.branch-instructio=
ns
>       0.28            -0.3        0.00        perf-stat.branch-miss-rate%
>  4.904e+10          -100.0%       0.00        perf-stat.branch-misses
>       6.79 =C2=B1  3%      -6.8        0.00        perf-stat.cache-miss-r=
ate%
>  1.071e+08 =C2=B1  4%    -100.0%       0.00        perf-stat.cache-misses
>  1.578e+09          -100.0%       0.00        perf-stat.cache-references
>     385311 =C2=B1  2%    -100.0%       0.00        perf-stat.context-swit=
ches
>       1.04          -100.0%       0.00        perf-stat.cpi
>  8.643e+13          -100.0%       0.00        perf-stat.cpu-cycles
>      13787          -100.0%       0.00        perf-stat.cpu-migrations
>       0.00 =C2=B1  4%      -0.0        0.00        perf-stat.dTLB-load-mi=
ss-rate%
>   23324811 =C2=B1  5%    -100.0%       0.00        perf-stat.dTLB-load-mi=
sses
>  1.811e+13          -100.0%       0.00        perf-stat.dTLB-loads
>       0.00            -0.0        0.00        perf-stat.dTLB-store-miss-r=
ate%
>    2478029          -100.0%       0.00        perf-stat.dTLB-store-misses
>  8.775e+12          -100.0%       0.00        perf-stat.dTLB-stores
>      99.66           -99.7        0.00        perf-stat.iTLB-load-miss-ra=
te%
>  7.527e+09          -100.0%       0.00        perf-stat.iTLB-load-misses
>   25540468 =C2=B1 39%    -100.0%       0.00        perf-stat.iTLB-loads
>   8.33e+13          -100.0%       0.00        perf-stat.instructions
>      11066          -100.0%       0.00        perf-stat.instructions-per-=
iTLB-miss
>       0.96          -100.0%       0.00        perf-stat.ipc
>     777357          -100.0%       0.00        perf-stat.minor-faults
>      81.69           -81.7        0.00        perf-stat.node-load-miss-ra=
te%
>   20040093          -100.0%       0.00        perf-stat.node-load-misses
>    4491667 =C2=B1  7%    -100.0%       0.00        perf-stat.node-loads
>      75.23 =C2=B1 10%     -75.2        0.00        perf-stat.node-store-m=
iss-rate%
>    3418662 =C2=B1 30%    -100.0%       0.00        perf-stat.node-store-m=
isses
>    1027183 =C2=B1 11%    -100.0%       0.00        perf-stat.node-stores
>     777373          -100.0%       0.00        perf-stat.page-faults
>    3331644          -100.0%       0.00        perf-stat.path-length
>
>
>
>                             will-it-scale.per_process_ops
>
>   242000 +-+-------------------------------------------------------------=
---+
>          |                      +.+..   .+..+.      .+.+..+.+.+.    .+.+.=
.  |
>   240000 +-+                   +     +.+      +.+..+            +..+     =
 +.|
>   238000 +-+..+.+.  .+.   .+..+                                          =
   |
>          |        +.   +.+                                               =
   |
>   236000 +-+                                                             =
   |
>          |                                                               =
   |
>   234000 +-+                                                             =
   |
>          |                                  O O O  O                     =
   |
>   232000 +-+             O O  O O                      O  O O O O  O O O =
 O |
>   230000 +-+           O          O  O O O           O                   =
   |
>          |           O                                                   =
   |
>   228000 O-+    O O                                                      =
   |
>          | O  O                                                          =
   |
>   226000 +-+-------------------------------------------------------------=
---+
>
>
>                                 will-it-scale.workload
>
>   2.52e+07 +-+-----------------------------------------------------------=
---+
>            |                     +..+.   .+..+.      .+. .+.+..+.   .+..+=
.  |
>    2.5e+07 +-+                  +     +.+      +.+.+.   +        +.+     =
 +.|
>   2.48e+07 +-+.+..+. .+.    .+.+                                         =
   |
>            |        +   +..+                                             =
   |
>   2.46e+07 +-+                                                           =
   |
>   2.44e+07 +-+                                                           =
   |
>            |                                                             =
   |
>   2.42e+07 +-+               O   O           O O O O        O        O   =
   |
>    2.4e+07 +-+          O  O   O                        O O    O O O    O=
 O |
>            |          O             O O O O           O                  =
   |
>   2.38e+07 O-+    O                                                      =
   |
>   2.36e+07 +-O O    O                                                    =
   |
>            |                                                             =
   |
>   2.34e+07 +-+-----------------------------------------------------------=
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
