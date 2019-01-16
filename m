Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B89C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6EF920675
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:38:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391426AbfAPPiU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 10:38:20 -0500
Received: from mga11.intel.com ([192.55.52.93]:62823 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387906AbfAPPiT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 10:38:19 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jan 2019 07:38:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,486,1539673200"; 
   d="scan'208";a="292035059"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.6])
  by orsmga005.jf.intel.com with ESMTP; 16 Jan 2019 07:38:17 -0800
Date:   Wed, 16 Jan 2019 23:38:39 +0800
From:   kernel test robot <rong.a.chen@intel.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Ladislav Michl <ladis@linux-mips.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, LKP <lkp@01.org>
Subject: Re: [LKP] [PM] 8234f6734c: will-it-scale.per_process_ops -3.6%
 regression
Message-ID: <20190116153839.GA3867@shao2-debian>
References: <20190115032444.GP17624@shao2-debian>
 <CAKfTPtB4cHpF2JcUiOLbmczDVSLEmBCpNDcYqCdAqwYZ2LAsRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKfTPtB4cHpF2JcUiOLbmczDVSLEmBCpNDcYqCdAqwYZ2LAsRg@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 02:13:47PM +0100, Vincent Guittot wrote:
> Hi Rong,
> 
> On Tue, 15 Jan 2019 at 04:24, kernel test robot <rong.a.chen@intel.com> wrote:
> >
> > Greeting,
> >
> > FYI, we noticed a -3.6% regression of will-it-scale.per_process_ops due to commit:
> >
> >
> > commit: 8234f6734c5d74ac794e5517437f51c57d65f865 ("PM-runtime: Switch autosuspend over to using hrtimers")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> >
> 
> Could you rerun with the patch :
> https://lore.kernel.org/patchwork/patch/1030857/ ?
> It optimizes autosuspend by reducing the number of call to ktime_get

Hi Vincent,

the regression of will-it-scale.per_process_ops is still exist according to the result.

commit:
   v4.20-rc7
   c534491102 ("PM/runtime: Do not needlessly call ktime_get")

       v4.20-rc7  c534491102b35a2075c78b72bb  
----------------  --------------------------  
         %stddev      change         %stddev
             \          |                \  
  25028944              -4%   23987264        will-it-scale.workload
    240662              -4%     230646        will-it-scale.per_process_ops
     80031                       78804        proc-vmstat.nr_zone_active_anon
     80031                       78804        proc-vmstat.nr_active_anon
      7649 ±173%     -6e+03       1870 ±133%  latency_stats.avg.rpc_wait_bit_killable.__rpc_execute.rpc_run_task.rpc_call_sync.nfs3_rpc_wrapper.nfs3_proc_lookup.nfs_lookup_revalidate_dentry.nfs_do_lookup_revalidate.__nfs_lookup_revalidate.lookup_fast.walk_component.link_path_walk
      7654 ±173%     -6e+03       1834 ±133%  latency_stats.avg.rpc_wait_bit_killable.__rpc_execute.rpc_run_task.rpc_call_sync.nfs3_rpc_wrapper.nfs3_proc_access.nfs_do_access.nfs_permission.inode_permission.link_path_walk.path_lookupat.filename_lookup
     13537 ±173%     -1e+04          0        latency_stats.avg.rpc_wait_bit_killable.__rpc_execute.rpc_run_task.rpc_call_sync.nfs3_get_acl.get_acl.posix_acl_create.nfs3_proc_create.nfs_create.path_openat.do_filp_open.do_sys_open
     66199 ±130%     -7e+04          0        latency_stats.avg.rpc_wait_bit_killable.__rpc_execute.rpc_run_task.rpc_call_sync.nfs3_rpc_wrapper.nfs3_proc_lookup.nfs_lookup.path_openat.do_filp_open.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
    389513 ±161%     -4e+05          0        latency_stats.avg.rpc_wait_bit_killable.__rpc_execute.rpc_run_task.rpc_call_sync.nfs3_rpc_wrapper.nfs3_do_create.nfs3_proc_create.nfs_create.path_openat.do_filp_open.do_sys_open.do_syscall_64
       629 ± 65%      4e+03       4446 ±123%  latency_stats.max.io_schedule.__lock_page.do_wp_page.__handle_mm_fault.handle_mm_fault.__do_page_fault.do_page_fault.page_fault
      7748 ±173%     -6e+03       1899 ±133%  latency_stats.max.rpc_wait_bit_killable.__rpc_execute.rpc_run_task.rpc_call_sync.nfs3_rpc_wrapper.nfs3_proc_lookup.nfs_lookup_revalidate_dentry.nfs_do_lookup_revalidate.__nfs_lookup_revalidate.lookup_fast.walk_component.link_path_walk
      7750 ±173%     -6e+03       1845 ±133%  latency_stats.max.rpc_wait_bit_killable.__rpc_execute.rpc_run_task.rpc_call_sync.nfs3_rpc_wrapper.nfs3_proc_access.nfs_do_access.nfs_permission.inode_permission.link_path_walk.path_lookupat.filename_lookup
     13537 ±173%     -1e+04          0        latency_stats.max.rpc_wait_bit_killable.__rpc_execute.rpc_run_task.rpc_call_sync.nfs3_get_acl.get_acl.posix_acl_create.nfs3_proc_create.nfs_create.path_openat.do_filp_open.do_sys_open
     66199 ±130%     -7e+04          0        latency_stats.max.rpc_wait_bit_killable.__rpc_execute.rpc_run_task.rpc_call_sync.nfs3_rpc_wrapper.nfs3_proc_lookup.nfs_lookup.path_openat.do_filp_open.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
    392739 ±159%     -4e+05          0        latency_stats.max.rpc_wait_bit_killable.__rpc_execute.rpc_run_task.rpc_call_sync.nfs3_rpc_wrapper.nfs3_do_create.nfs3_proc_create.nfs_create.path_openat.do_filp_open.do_sys_open.do_syscall_64
     15365 ± 41%      2e+05     194745 ±123%  latency_stats.sum.io_schedule.__lock_page.do_wp_page.__handle_mm_fault.handle_mm_fault.__do_page_fault.do_page_fault.page_fault
      9214 ± 30%      6e+04      71022 ± 22%  latency_stats.sum.pipe_wait.pipe_write.__vfs_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     15299 ±173%     -1e+04       3740 ±133%  latency_stats.sum.rpc_wait_bit_killable.__rpc_execute.rpc_run_task.rpc_call_sync.nfs3_rpc_wrapper.nfs3_proc_lookup.nfs_lookup_revalidate_dentry.nfs_do_lookup_revalidate.__nfs_lookup_revalidate.lookup_fast.walk_component.link_path_walk
     13537 ±173%     -1e+04          0        latency_stats.sum.rpc_wait_bit_killable.__rpc_execute.rpc_run_task.rpc_call_sync.nfs3_get_acl.get_acl.posix_acl_create.nfs3_proc_create.nfs_create.path_openat.do_filp_open.do_sys_open
     22963 ±173%     -2e+04       3668 ±133%  latency_stats.sum.rpc_wait_bit_killable.__rpc_execute.rpc_run_task.rpc_call_sync.nfs3_rpc_wrapper.nfs3_proc_access.nfs_do_access.nfs_permission.inode_permission.link_path_walk.path_lookupat.filename_lookup
     66199 ±130%     -7e+04          0        latency_stats.sum.rpc_wait_bit_killable.__rpc_execute.rpc_run_task.rpc_call_sync.nfs3_rpc_wrapper.nfs3_proc_lookup.nfs_lookup.path_openat.do_filp_open.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
    408736 ±151%     -4e+05          0        latency_stats.sum.rpc_wait_bit_killable.__rpc_execute.rpc_run_task.rpc_call_sync.nfs3_rpc_wrapper.nfs3_do_create.nfs3_proc_create.nfs_create.path_openat.do_filp_open.do_sys_open.do_syscall_64
     79146 ± 26%       626%     574528 ±  5%  perf-stat.i.iTLB-loads
      8211 ±  7%        56%      12770 ± 14%  perf-stat.i.node-store-misses
      0.28              15%       0.32        perf-stat.overall.branch-miss-rate%
  1.61e+08              11%  1.791e+08        perf-stat.i.branch-misses
     71.87              10%      79.18 ±  3%  perf-stat.overall.node-store-miss-rate%
     13107 ±  4%         7%      14023        perf-stat.i.node-loads
      1.04               5%       1.09        perf-stat.overall.cpi
     99.05                       97.63        perf-stat.i.iTLB-load-miss-rate%
     83.87                       82.36        perf-stat.overall.node-load-miss-rate%
     99.68                       97.65        perf-stat.overall.iTLB-load-miss-rate%
  24777147              -3%   23919344        perf-stat.i.iTLB-load-misses
 2.743e+11              -4%  2.646e+11        perf-stat.i.instructions
 5.791e+10              -4%  5.586e+10        perf-stat.i.branch-instructions
  2.89e+10              -4%  2.787e+10        perf-stat.i.dTLB-stores
 5.964e+10              -4%  5.752e+10        perf-stat.i.dTLB-loads
      0.96              -4%       0.92        perf-stat.i.ipc
 8.333e+13              -4%  7.976e+13        perf-stat.total.instructions
      0.96              -4%       0.92        perf-stat.overall.ipc
    355843 ±  4%       -12%     313369 ±  4%  perf-stat.i.cache-misses

Best Regards,
Rong Chen

> 
> Regards,
> Vincent
> 
> > in testcase: will-it-scale
> > on test machine: 104 threads Skylake with 192G memory
> > with following parameters:
> >
> >         nr_task: 100%
> >         mode: process
> >         test: poll2
> >         cpufreq_governor: performance
> >
> > test-description: Will It Scale takes a testcase and runs it from 1 through to n parallel copies to see if the testcase will scale. It builds both a process and threads based test in order to see any differences between the two.
> > test-url: https://github.com/antonblanchard/will-it-scale
> >
> >
> >
> > Details are as below:
> > -------------------------------------------------------------------------------------------------->
> >
> >
> > To reproduce:
> >
> >         git clone https://github.com/intel/lkp-tests.git
> >         cd lkp-tests
> >         bin/lkp install job.yaml  # job file is attached in this email
> >         bin/lkp run     job.yaml
> >
> > =========================================================================================
> > compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
> >   gcc-7/performance/x86_64-rhel-7.2/process/100%/debian-x86_64-2018-04-03.cgz/lkp-skl-fpga01/poll2/will-it-scale
> >
> > commit:
> >   v4.20-rc7
> >   8234f6734c ("PM-runtime: Switch autosuspend over to using hrtimers")
> >
> >        v4.20-rc7 8234f6734c5d74ac794e551743
> > ---------------- --------------------------
> >        fail:runs  %reproduction    fail:runs
> >            |             |             |
> >            :2           50%           1:4     dmesg.WARNING:at#for_ip_interrupt_entry/0x
> >          %stddev     %change         %stddev
> >              \          |                \
> >     240408            -3.6%     231711        will-it-scale.per_process_ops
> >   25002520            -3.6%   24097991        will-it-scale.workload
> >     351914            -1.7%     345882        interrupts.CAL:Function_call_interrupts
> >       1.77 ± 45%      -1.1        0.64        mpstat.cpu.idle%
> >     106164 ± 24%     -23.2%      81494 ± 28%  numa-meminfo.node0.AnonHugePages
> >     326430 ±  8%     -11.3%     289513        softirqs.SCHED
> >       1294            -2.0%       1268        vmstat.system.cs
> >       3178           +48.4%       4716 ± 16%  slabinfo.eventpoll_pwq.active_objs
> >       3178           +48.4%       4716 ± 16%  slabinfo.eventpoll_pwq.num_objs
> >     336.32          -100.0%       0.00        uptime.boot
> >       3192          -100.0%       0.00        uptime.idle
> >  3.456e+08 ± 76%     -89.9%   34913819 ± 62%  cpuidle.C1E.time
> >     747832 ± 72%     -87.5%      93171 ± 45%  cpuidle.C1E.usage
> >      16209 ± 26%     -38.2%      10021 ± 44%  cpuidle.POLL.time
> >       6352 ± 32%     -39.5%       3843 ± 48%  cpuidle.POLL.usage
> >     885259 ±  2%     -13.8%     763434 ±  7%  numa-vmstat.node0.numa_hit
> >     865117 ±  2%     -13.9%     744992 ±  7%  numa-vmstat.node0.numa_local
> >     405085 ±  7%     +38.0%     558905 ±  9%  numa-vmstat.node1.numa_hit
> >     254056 ± 11%     +59.7%     405824 ± 13%  numa-vmstat.node1.numa_local
> >     738158 ± 73%     -88.5%      85078 ± 47%  turbostat.C1E
> >       1.07 ± 76%      -1.0        0.11 ± 62%  turbostat.C1E%
> >       1.58 ± 49%     -65.4%       0.55 ±  6%  turbostat.CPU%c1
> >       0.15 ± 13%     -35.0%       0.10 ± 38%  turbostat.CPU%c6
> >     153.97 ± 16%     -54.7       99.31        turbostat.PKG_%
> >      64141            +1.5%      65072        proc-vmstat.nr_anon_pages
> >      19541            -7.0%      18178 ±  8%  proc-vmstat.nr_shmem
> >      18296            +1.1%      18506        proc-vmstat.nr_slab_reclaimable
> >     713938            -2.3%     697489        proc-vmstat.numa_hit
> >     693688            -2.4%     677228        proc-vmstat.numa_local
> >     772220            -1.9%     757334        proc-vmstat.pgalloc_normal
> >     798565            -1.8%     784042        proc-vmstat.pgfault
> >     732336            -2.7%     712661        proc-vmstat.pgfree
> >      20.33 ±  4%      -7.0%      18.92        sched_debug.cfs_rq:/.runnable_load_avg.max
> >     160603           -44.5%      89108 ± 38%  sched_debug.cfs_rq:/.spread0.avg
> >     250694           -29.3%     177358 ± 18%  sched_debug.cfs_rq:/.spread0.max
> >       1109 ±  4%      -7.0%       1031        sched_debug.cfs_rq:/.util_avg.max
> >      20.33 ±  4%      -7.2%      18.88        sched_debug.cpu.cpu_load[0].max
> >     -10.00           +35.0%     -13.50        sched_debug.cpu.nr_uninterruptible.min
> >       3.56 ± 10%     +44.2%       5.14 ± 18%  sched_debug.cpu.nr_uninterruptible.stddev
> >      87.10 ± 24%     -34.0%      57.44 ± 37%  sched_debug.cpu.sched_goidle.avg
> >     239.48           -25.6%     178.07 ± 18%  sched_debug.cpu.sched_goidle.stddev
> >     332.67 ±  7%     -25.5%     247.83 ± 13%  sched_debug.cpu.ttwu_count.min
> >     231.67 ±  8%     -15.4%     195.96 ± 12%  sched_debug.cpu.ttwu_local.min
> >      95.47           -95.5        0.00        perf-profile.calltrace.cycles-pp.poll
> >      90.26           -90.3        0.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.poll
> >      90.08           -90.1        0.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.poll
> >      89.84           -89.8        0.00        perf-profile.calltrace.cycles-pp.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_after_hwframe.poll
> >      88.04           -88.0        0.00        perf-profile.calltrace.cycles-pp.do_sys_poll.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_after_hwframe.poll
> >       2.66            -0.1        2.54        perf-profile.calltrace.cycles-pp._copy_from_user.do_sys_poll.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_after_hwframe
> >       1.90            -0.1        1.81        perf-profile.calltrace.cycles-pp.copy_user_enhanced_fast_string._copy_from_user.do_sys_poll.__x64_sys_poll.do_syscall_64
> >       2.56            +0.1        2.64        perf-profile.calltrace.cycles-pp.__fdget.do_sys_poll.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_after_hwframe
> >       0.00            +2.3        2.29        perf-profile.calltrace.cycles-pp.syscall_return_via_sysret
> >       0.00            +2.3        2.34        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64
> >      17.45            +3.8       21.24        perf-profile.calltrace.cycles-pp.__fget_light.do_sys_poll.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_after_hwframe
> >       0.00           +92.7       92.66        perf-profile.calltrace.cycles-pp.do_sys_poll.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_after_hwframe
> >       0.00           +94.5       94.51        perf-profile.calltrace.cycles-pp.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_after_hwframe
> >       0.00           +94.8       94.75        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
> >       0.00           +94.9       94.92        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
> >      96.03           -96.0        0.00        perf-profile.children.cycles-pp.poll
> >      90.29           -90.3        0.00        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
> >      90.11           -90.1        0.00        perf-profile.children.cycles-pp.do_syscall_64
> >      89.87           -89.9        0.00        perf-profile.children.cycles-pp.__x64_sys_poll
> >      89.39           -89.4        0.00        perf-profile.children.cycles-pp.do_sys_poll
> >      16.19           -16.2        0.00        perf-profile.children.cycles-pp.__fget_light
> >      68.59           -68.6        0.00        perf-profile.self.cycles-pp.do_sys_poll
> >      14.84           -14.8        0.00        perf-profile.self.cycles-pp.__fget_light
> >  1.759e+13          -100.0%       0.00        perf-stat.branch-instructions
> >       0.28            -0.3        0.00        perf-stat.branch-miss-rate%
> >  4.904e+10          -100.0%       0.00        perf-stat.branch-misses
> >       6.79 ±  3%      -6.8        0.00        perf-stat.cache-miss-rate%
> >  1.071e+08 ±  4%    -100.0%       0.00        perf-stat.cache-misses
> >  1.578e+09          -100.0%       0.00        perf-stat.cache-references
> >     385311 ±  2%    -100.0%       0.00        perf-stat.context-switches
> >       1.04          -100.0%       0.00        perf-stat.cpi
> >  8.643e+13          -100.0%       0.00        perf-stat.cpu-cycles
> >      13787          -100.0%       0.00        perf-stat.cpu-migrations
> >       0.00 ±  4%      -0.0        0.00        perf-stat.dTLB-load-miss-rate%
> >   23324811 ±  5%    -100.0%       0.00        perf-stat.dTLB-load-misses
> >  1.811e+13          -100.0%       0.00        perf-stat.dTLB-loads
> >       0.00            -0.0        0.00        perf-stat.dTLB-store-miss-rate%
> >    2478029          -100.0%       0.00        perf-stat.dTLB-store-misses
> >  8.775e+12          -100.0%       0.00        perf-stat.dTLB-stores
> >      99.66           -99.7        0.00        perf-stat.iTLB-load-miss-rate%
> >  7.527e+09          -100.0%       0.00        perf-stat.iTLB-load-misses
> >   25540468 ± 39%    -100.0%       0.00        perf-stat.iTLB-loads
> >   8.33e+13          -100.0%       0.00        perf-stat.instructions
> >      11066          -100.0%       0.00        perf-stat.instructions-per-iTLB-miss
> >       0.96          -100.0%       0.00        perf-stat.ipc
> >     777357          -100.0%       0.00        perf-stat.minor-faults
> >      81.69           -81.7        0.00        perf-stat.node-load-miss-rate%
> >   20040093          -100.0%       0.00        perf-stat.node-load-misses
> >    4491667 ±  7%    -100.0%       0.00        perf-stat.node-loads
> >      75.23 ± 10%     -75.2        0.00        perf-stat.node-store-miss-rate%
> >    3418662 ± 30%    -100.0%       0.00        perf-stat.node-store-misses
> >    1027183 ± 11%    -100.0%       0.00        perf-stat.node-stores
> >     777373          -100.0%       0.00        perf-stat.page-faults
> >    3331644          -100.0%       0.00        perf-stat.path-length
> >
> >
> >
> >                             will-it-scale.per_process_ops
> >
> >   242000 +-+----------------------------------------------------------------+
> >          |                      +.+..   .+..+.      .+.+..+.+.+.    .+.+..  |
> >   240000 +-+                   +     +.+      +.+..+            +..+      +.|
> >   238000 +-+..+.+.  .+.   .+..+                                             |
> >          |        +.   +.+                                                  |
> >   236000 +-+                                                                |
> >          |                                                                  |
> >   234000 +-+                                                                |
> >          |                                  O O O  O                        |
> >   232000 +-+             O O  O O                      O  O O O O  O O O  O |
> >   230000 +-+           O          O  O O O           O                      |
> >          |           O                                                      |
> >   228000 O-+    O O                                                         |
> >          | O  O                                                             |
> >   226000 +-+----------------------------------------------------------------+
> >
> >
> >                                 will-it-scale.workload
> >
> >   2.52e+07 +-+--------------------------------------------------------------+
> >            |                     +..+.   .+..+.      .+. .+.+..+.   .+..+.  |
> >    2.5e+07 +-+                  +     +.+      +.+.+.   +        +.+      +.|
> >   2.48e+07 +-+.+..+. .+.    .+.+                                            |
> >            |        +   +..+                                                |
> >   2.46e+07 +-+                                                              |
> >   2.44e+07 +-+                                                              |
> >            |                                                                |
> >   2.42e+07 +-+               O   O           O O O O        O        O      |
> >    2.4e+07 +-+          O  O   O                        O O    O O O    O O |
> >            |          O             O O O O           O                     |
> >   2.38e+07 O-+    O                                                         |
> >   2.36e+07 +-O O    O                                                       |
> >            |                                                                |
> >   2.34e+07 +-+--------------------------------------------------------------+
> >
> >
> > [*] bisect-good sample
> > [O] bisect-bad  sample
> >
> >
> >
> > Disclaimer:
> > Results have been estimated based on internal Intel analysis and are provided
> > for informational purposes only. Any difference in system hardware or software
> > design or configuration may affect actual performance.
> >
> >
> > Thanks,
> > Rong Chen
> _______________________________________________
> LKP mailing list
> LKP@lists.01.org
> https://lists.01.org/mailman/listinfo/lkp
