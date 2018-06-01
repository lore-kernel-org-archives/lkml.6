Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751329AbeFAVnX convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 17:43:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:53976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750750AbeFAVnV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 17:43:21 -0400
Date: Fri, 1 Jun 2018 17:43:19 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: kernel test robot <xiaolong.ye@intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>, lkp@01.org
Subject: Re: [lkp-robot] [tracing/x86]  1c758a2202:
 aim9.disk_rr.ops_per_sec -12.0% regression
Message-ID: <20180601174319.52646440@vmware.local.home>
In-Reply-To: <20180528113419.GE9904@yexl-desktop>
References: <20180528113419.GE9904@yexl-desktop>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 May 2018 19:34:19 +0800
kernel test robot <xiaolong.ye@intel.com> wrote:

> Greeting,
> 
> FYI, we noticed a -12.0% regression of aim9.disk_rr.ops_per_sec due to commit:
> 
> 
> commit: 1c758a2202a6b4624d0703013a2c6cfa6e7455aa ("tracing/x86: Update syscall trace events to handle new prefixed syscall func names")

How can this commit cause a run time regression. It changes code
in an __init call (that gets removed after boot)??

-- Steve
 

> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> in testcase: aim9
> on test machine: 144 threads Intel(R) Xeon(R) CPU E7-8890 v3 @ 2.50GHz with 512G memory
> with following parameters:
> 
> 	testtime: 300s
> 	test: disk_rr
> 	cpufreq_governor: performance
> 
> test-description: Suite IX is the "AIM Independent Resource Benchmark:" the famous synthetic benchmark.
> test-url: https://sourceforge.net/projects/aimbench/files/aim-suite9/
> 
> 
> Details are as below:
> -------------------------------------------------------------------------------------------------->  
> =========================================================================================
> compiler/cpufreq_governor/kconfig/rootfs/tbox_group/test/testcase/testtime:
>   gcc-7/performance/x86_64-rhel-7.2/debian-x86_64-2016-08-31.cgz/lkp-hsx04/disk_rr/aim9/300s
> 
> commit: 
>   1cdae042fc ("tracing: Add missing forward declaration")
>   1c758a2202 ("tracing/x86: Update syscall trace events to handle new prefixed syscall func names")
> 
> 1cdae042fc63dd98 1c758a2202a6b4624d0703013a 
> ---------------- -------------------------- 
>          %stddev     %change         %stddev
>              \          |                \  
>     633310           -12.0%     557268        aim9.disk_rr.ops_per_sec
>     244.24            +2.2%     249.57        aim9.time.system_time
>      55.76            -9.6%      50.43        aim9.time.user_time
>       8135 ± 39%     +73.2%      14091 ± 33%  numa-meminfo.node0.Shmem
>       1328           -11.9%       1171        pmeter.performance_per_watt
>     450606 ±  3%      -9.5%     407878 ±  5%  meminfo.Committed_AS
>     406.75 ±173%    +300.1%       1627        meminfo.Mlocked
>      20124 ±  4%      +8.4%      21819 ±  6%  softirqs.NET_RX
>    8237636 ±  6%     -15.4%    6965294 ±  2%  softirqs.RCU
>       2033 ± 39%     +73.0%       3518 ± 33%  numa-vmstat.node0.nr_shmem
>      21.25 ±173%    +378.8%     101.75 ± 27%  numa-vmstat.node2.nr_mlock
>      21.25 ±173%    +378.8%     101.75 ± 27%  numa-vmstat.node3.nr_mlock
>  9.408e+08 ±  6%     +53.3%  1.442e+09 ± 20%  perf-stat.dTLB-load-misses
>      47.39 ± 17%     -10.4       36.99 ±  8%  perf-stat.iTLB-load-miss-rate%
>       1279 ± 27%     +63.4%       2089 ± 21%  perf-stat.instructions-per-iTLB-miss
>      46.73 ±  5%      -5.4       41.33 ±  5%  perf-stat.node-store-miss-rate%
>      19240            +1.2%      19474        proc-vmstat.nr_indirectly_reclaimable
>      18868            +4.0%      19628        proc-vmstat.nr_slab_reclaimable
>   48395423           -11.8%   42700849        proc-vmstat.numa_hit
>   48314997           -11.8%   42620296        proc-vmstat.numa_local
>    3153408           -12.0%    2775642        proc-vmstat.pgactivate
>   48365477           -11.8%   42678780        proc-vmstat.pgfree
>       3060           +38.9%       4250        slabinfo.ftrace_event_field.active_objs
>       3060           +38.9%       4250        slabinfo.ftrace_event_field.num_objs
>       2748 ±  3%      -8.9%       2502 ±  3%  slabinfo.sighand_cache.active_objs
>       2763 ±  3%      -8.9%       2517 ±  3%  slabinfo.sighand_cache.num_objs
>       4125 ±  4%     -10.3%       3700 ±  2%  slabinfo.signal_cache.active_objs
>       4125 ±  4%     -10.3%       3700 ±  2%  slabinfo.signal_cache.num_objs
>       1104           +57.3%       1736        slabinfo.trace_event_file.active_objs
>       1104           +57.3%       1736        slabinfo.trace_event_file.num_objs
>       0.78 ±  4%      -0.1        0.67 ±  5%  perf-profile.calltrace.cycles-pp.rcu_process_callbacks.__softirqentry_text_start.irq_exit.smp_apic_timer_interrupt.apic_timer_interrupt
>       2.10 ±  2%      -0.1        2.00        perf-profile.calltrace.cycles-pp.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.smp_apic_timer_interrupt.apic_timer_interrupt
>       1.89            -0.1        1.79        perf-profile.calltrace.cycles-pp.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.smp_apic_timer_interrupt
>       1.71 ±  2%      -0.1        1.60        perf-profile.calltrace.cycles-pp.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt
>       0.53 ± 12%      -0.1        0.44 ±  4%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
>       0.17 ±  7%      -0.0        0.15 ±  4%  perf-profile.children.cycles-pp.leave_mm
>       0.09 ±  8%      -0.0        0.08 ± 11%  perf-profile.children.cycles-pp.cpu_load_update_active
>       0.17 ±  8%      +0.0        0.19 ±  4%  perf-profile.children.cycles-pp.irq_work_needs_cpu
>       0.43 ± 14%      -0.1        0.38 ±  3%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
>       0.17 ±  7%      -0.0        0.15 ±  4%  perf-profile.self.cycles-pp.leave_mm
>       0.30            +0.0        0.32 ±  2%  perf-profile.self.cycles-pp.get_next_timer_interrupt
>       0.17 ±  8%      +0.0        0.19 ±  4%  perf-profile.self.cycles-pp.irq_work_needs_cpu
>       0.06 ±  9%      +0.0        0.08 ± 15%  perf-profile.self.cycles-pp.sched_clock
>       4358 ± 15%     +25.0%       5446 ±  7%  sched_debug.cfs_rq:/.exec_clock.avg
>      24231 ±  7%     +12.3%      27202 ±  3%  sched_debug.cfs_rq:/.exec_clock.stddev
>      23637 ± 17%     +33.3%      31501 ± 14%  sched_debug.cfs_rq:/.load.avg
>      73299 ±  9%     +19.8%      87807 ±  8%  sched_debug.cfs_rq:/.load.stddev
>      35584 ±  7%     +13.2%      40294 ±  5%  sched_debug.cfs_rq:/.min_vruntime.stddev
>       0.09 ± 10%     +27.8%       0.12 ± 15%  sched_debug.cfs_rq:/.nr_running.avg
>      17.10 ± 18%     +36.5%      23.33 ± 18%  sched_debug.cfs_rq:/.runnable_load_avg.avg
>      63.20 ± 10%     +18.9%      75.11 ±  7%  sched_debug.cfs_rq:/.runnable_load_avg.stddev
>      23618 ± 17%     +33.3%      31477 ± 14%  sched_debug.cfs_rq:/.runnable_weight.avg
>      73217 ±  9%     +19.9%      87751 ±  8%  sched_debug.cfs_rq:/.runnable_weight.stddev
>      35584 ±  7%     +13.2%      40294 ±  5%  sched_debug.cfs_rq:/.spread0.stddev
>      95.02 ±  9%     +14.5%     108.82 ±  7%  sched_debug.cfs_rq:/.util_avg.avg
>      19.44 ±  9%     +23.0%      23.91 ± 10%  sched_debug.cfs_rq:/.util_est_enqueued.avg
>     323.02 ±  3%      -6.4%     302.21 ±  4%  sched_debug.cpu.ttwu_local.avg
> 
> 
>                                                                                 
>                               aim9.disk_rr.ops_per_sec                          
>                                                                                 
>   650000 +-+----------------------------------------------------------------+   
>   640000 +-+                  .+..                                          |   
>          |    .+.+..+..+..+..+    +..       .+..          .+..       .+..+..|   
>   630000 +-++.                       +..+..+    +..+..+.+.    +..+..+       |   
>   620000 +-+                                                                |   
>          |                                                                  |   
>   610000 +-+                                                                |   
>   600000 +-+                                                                |   
>   590000 +-+                                                                |   
>          |                                                                  |   
>   580000 +-+                                                                |   
>   570000 +-+                                                                |   
>          O     O O     O  O  O O        O  O                     O          |   
>   560000 +-+O       O             O  O       O  O  O  O O  O  O     O O     |   
>   550000 +-+----------------------------------------------------------------+   
>                                                                                 
>                                                                                                                                                                 
>                                aim9.time.user_time                              
>                                                                                 
>   57 +-+--------------------------------------------------------------------+   
>      |                      .+..+..     .+.           .+..                 .|   
>   56 +-+  .+..+..  .+..+..+.       +..+.   +..  .+..+.    +..  .+..  .+..+. |   
>   55 +-++.       +.                           +.             +.    +.       |   
>      |                                                                      |   
>   54 +-+                                                                    |   
>      |                                                                      |   
>   53 +-+                                                                    |   
>      |                                                                      |   
>   52 +-+                              O                                     |   
>   51 +-+                                                                    |   
>      |     O  O           O     O  O     O                O     O     O     |   
>   50 O-+O        O           O                O     O  O     O     O        |   
>      |              O  O                   O     O                          |   
>   49 +-+--------------------------------------------------------------------+   
>                                                                                 
>                                                                                                                                                                 
>                                aim9.time.system_time                            
>                                                                                 
>   251 +-+-------------------------------------------------------------------+   
>       |              O  O                   O     O                         |   
>   250 O-+O        O          O                 O     O  O    O     O        |   
>   249 +-+   O  O          O     O  O     O                 O    O     O     |   
>       |                                                                     |   
>   248 +-+                             O                                     |   
>       |                                                                     |   
>   247 +-+                                                                   |   
>       |                                                                     |   
>   246 +-+                                                                   |   
>   245 +-+                                                                   |   
>       | .+..     .+..                         .+..          .+..  .+..      |   
>   244 +-+   +..+.    +..+.+..     .+..+..+..+.    +..+..+..+    +.    +..+..|   
>       |                      +..+.                                          |   
>   243 +-+-------------------------------------------------------------------+   
>                                                                                 
>                                                                                 
>                                                                                 
> [*] bisect-good sample
> [O] bisect-bad  sample
> 
> 
> Disclaimer:
> Results have been estimated based on internal Intel analysis and are provided
> for informational purposes only. Any difference in system hardware or software
> design or configuration may affect actual performance.
> 
> 
> Thanks,
> Xiaolong
