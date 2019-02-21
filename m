Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 564AEC10F07
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 03:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FDA02086C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 03:14:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbfBUDOc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 22:14:32 -0500
Received: from mga04.intel.com ([192.55.52.120]:60590 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726016AbfBUDOc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 22:14:32 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Feb 2019 19:14:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,393,1544515200"; 
   d="scan'208";a="119595210"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.107])
  by orsmga008.jf.intel.com with ESMTP; 20 Feb 2019 19:14:28 -0800
Date:   Thu, 21 Feb 2019 11:14:46 +0800
From:   kernel test robot <rong.a.chen@intel.com>
To:     "Schmauss, Erik" <erik.schmauss@intel.com>
Cc:     "Moore, Robert" <robert.moore@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "lkp@01.org" <lkp@01.org>
Subject: Re: [LKP] [ACPICA]  4c1379d7bb:  reaim.jobs_per_min -2.8% regression
Message-ID: <20190221031446.GF28258@shao2-debian>
References: <20190218013602.GA29177@shao2-debian>
 <CF6A88132359CE47947DB4C6E1709ED53C58713D@ORSMSX122.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CF6A88132359CE47947DB4C6E1709ED53C58713D@ORSMSX122.amr.corp.intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 08:28:49AM +0800, Schmauss, Erik wrote:
> 
> 
> > -----Original Message-----
> > From: Chen, Rong A
> > Sent: Sunday, February 17, 2019 5:36 PM
> > To: Moore, Robert <robert.moore@intel.com>
> > Cc: Wysocki, Rafael J <rafael.j.wysocki@intel.com>; Schmauss, Erik
> > <erik.schmauss@intel.com>; LKML <linux-kernel@vger.kernel.org>; Linus
> > Torvalds <torvalds@linux-foundation.org>; lkp@01.org
> > Subject: [LKP] [ACPICA] 4c1379d7bb: reaim.jobs_per_min -2.8% regression
> > 
> > Greeting,
> > 
> > FYI, we noticed a -2.8% regression of reaim.jobs_per_min due to commit:
> > 
> > 
> > commit: 4c1379d7bb42fa664e0784539208ed74108c53f1 ("ACPICA: Debug
> > output: Add option to display method/object evaluation")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> Hi, 
> 
> Does the performance get back to normal when you apply the following changes? I've added this as an attachment as well...

No, the regression is still exist.

commit:
   73a049a90f ("ACPICA: disassembler: disassemble OEMx tables as AML")
   40a76ed786 ("es-dbg-experiement-01")

testcase/path_params/tbox_group/run: reaim/performance-1500-100%-300s-all_utime-ucode=0x3d/lkp-hsw-ep2

73a049a90fb241af  40a76ed786180150065d02ae1f  
----------------  --------------------------  
         %stddev      change         %stddev
             \          |                \  
      0.09 ±  8%        79%       0.17 ±  4%  reaim.std_dev_time
      0.45 ±  8%        79%       0.80 ±  4%  reaim.std_dev_percent
    127078              28%     163173 ±  3%  reaim.time.involuntary_context_switches
      0.07 ±  5%        13%       0.08        reaim.child_systime
     20.93                       21.42        reaim.parent_time
    314488                      307615        reaim.max_jobs_per_min
      6445                        6303        reaim.time.percent_of_cpu_this_job_got
    308795                      301705        reaim.jobs_per_min
      4288                        4190        reaim.jobs_per_min_child
       321              -5%        304        reaim.time.elapsed_time
       321              -5%        304        reaim.time.elapsed_time.max
      4928              -7%       4599        reaim.time.voluntary_context_switches
   1512000              -7%    1404000        reaim.workload
     92671              -7%      86028        reaim.time.minor_page_faults
     20720              -7%      19216        reaim.time.user_time

Best Regards,
Rong Chen

> 
> diff --git a/drivers/acpi/acpica/dsmethod.c b/drivers/acpi/acpica/dsmethod.c
> index f59b4d944f7f..b524b4273d9f 100644
> --- a/drivers/acpi/acpica/dsmethod.c
> +++ b/drivers/acpi/acpica/dsmethod.c
> @@ -552,9 +552,11 @@ acpi_ds_call_control_method(struct acpi_thread_state *thread,
>                           "**** Begin nested execution of [%4.4s] **** WalkState=%p\n",
>                           method_node->name.ascii, next_walk_state));
> 
> +#if 0
>         this_walk_state->method_pathname =
>             acpi_ns_get_normalized_pathname(method_node, TRUE);
>         this_walk_state->method_is_nested = TRUE;
> +#endif
> 
>         /* Optional object evaluation log */
> 
> diff --git a/drivers/acpi/acpica/psparse.c b/drivers/acpi/acpica/psparse.c
> index 9b386530ffbe..c39db1a83222 100644
> --- a/drivers/acpi/acpica/psparse.c
> +++ b/drivers/acpi/acpica/psparse.c
> @@ -483,6 +483,7 @@ acpi_status acpi_ps_parse_aml(struct acpi_walk_state *walk_state)
> 
>                         /* Optional object evaluation log */
> 
> +#if 0
>                         ACPI_DEBUG_PRINT_RAW((ACPI_DB_EVALUATION,
>                                               "%-26s:  %*s%s\n",
>                                               "   Exit nested method",
> @@ -492,6 +493,7 @@ acpi_status acpi_ps_parse_aml(struct acpi_walk_state *walk_state)
>                                               &walk_state->method_pathname[1]));
> 
>                         ACPI_FREE(walk_state->method_pathname);
> +#endif
>                         walk_state->method_is_nested = FALSE;
>                 }
>                 if (status == AE_CTRL_TRANSFER) {
> > 
> > in testcase: ftq
> > on test machine: 256 threads Phi with 96G memory with following
> > parameters:
> > 
> > 	nr_task: 100%
> > 	samples: 6000ss
> > 	test: cache
> > 	freq: 20
> > 	cpufreq_governor: performance
> > 
> > test-description: The FTQ benchmarks measure hardware and software
> > interference or 'noise' on a node from the applications perspective.
> > test-url: https://github.com/rminnich/ftq
> > 
> > In addition to that, the commit also has significant impact on the following
> > tests:
> > 
> > +------------------+------------------------------------------------------------------------
> > ---+
> > | testcase: change | perf_test:
> > perf_test.msr_test.round1.cpu_util_zero.pass -100.0% undefined |
> > | test machine     | 72 threads Intel(R) Xeon(R) CPU E5-2699 v3 @ 2.30GHz
> > with 128G memory     |
> > | test parameters  | type=lkp                                                                  |
> > |                  | ucode=0x3d                                                                |
> > +------------------+------------------------------------------------------------------------
> > ---+
> > 
> > 
> > Details are as below:
> > ----------------------------------------------------------------------------------------------
> > ---->
> > 
> > 
> > To reproduce:
> > 
> >         git clone https://github.com/intel/lkp-tests.git
> >         cd lkp-tests
> >         bin/lkp install job.yaml  # job file is attached in this email
> >         bin/lkp run     job.yaml
> > 
> > ==========================================================
> > ===============================
> > compiler/cpufreq_governor/kconfig/nr_job/nr_task/rootfs/runtime/tbox_g
> > roup/test/testcase/ucode:
> >   gcc-7/performance/x86_64-rhel-7.2/1500/100%/debian-x86_64-2018-04-
> > 03.cgz/300s/lkp-hsw-ep2/all_utime/reaim/0x3d
> > 
> > commit:
> >   73a049a90f ("ACPICA: disassembler: disassemble OEMx tables as AML")
> >   4c1379d7bb ("ACPICA: Debug output: Add option to display method/object
> > evaluation")
> > 
> > 73a049a90fb241af 4c1379d7bb42fa664e07845392
> > ---------------- --------------------------
> >          %stddev     %change         %stddev
> >              \          |                \
> >       0.07 ±  3%     +20.2%       0.09 ± 12%  reaim.child_systime
> >     308866            -2.8%     300200        reaim.jobs_per_min
> >       4289            -2.8%       4169        reaim.jobs_per_min_child
> >     314258            -2.7%     305679        reaim.max_jobs_per_min
> >      20.93            +2.9%      21.53        reaim.parent_time
> >       0.44 ±  9%     +84.5%       0.82 ±  6%  reaim.std_dev_percent
> >       0.09 ±  9%     +83.7%       0.17 ±  6%  reaim.std_dev_time
> >     321.38            -4.7%     306.29        reaim.time.elapsed_time
> >     321.38            -4.7%     306.29        reaim.time.elapsed_time.max
> >     127264 ±  2%     +40.6%     178887
> > reaim.time.involuntary_context_switches
> >      93024 ±  2%      -8.4%      85173        reaim.time.minor_page_faults
> >       6448            -2.6%       6282        reaim.time.percent_of_cpu_this_job_got
> >      20724            -7.2%      19241        reaim.time.user_time
> >       4929            -6.9%       4591        reaim.time.voluntary_context_switches
> >    1512000            -7.1%    1404000        reaim.workload
> >     442.00 ±158%    -100.0%       0.00        meminfo.Mlocked
> >       0.03 ±  2%      +0.1        0.11        mpstat.cpu.sys%
> >       1231           +56.9%       1932 ±  3%  vmstat.system.cs
> >      63.75 ±158%    -100.0%       0.00        numa-vmstat.node0.nr_mlock
> >      46.25 ±159%    -100.0%       0.00        numa-vmstat.node1.nr_mlock
> >       1.50 ± 15%      -0.3        1.24 ± 15%  perf-stat.overall.cache-miss-rate%
> >      50.13 ±  3%      +6.4       56.58 ±  5%  perf-stat.overall.iTLB-load-miss-rate%
> >     566199 ±  6%     -23.7%     432237 ±  7%  perf-stat.overall.instructions-per-
> > iTLB-miss
> >      59.86 ±  3%     -23.1       36.79 ± 10%  perf-stat.overall.node-store-miss-rate%
> >    6653969 ±  8%     +25.4%    8340919 ± 14%  perf-stat.ps.cache-references
> >       1202           +56.7%       1884 ±  4%  perf-stat.ps.context-switches
> >     185718 ±  5%     +28.9%     239386 ±  7%  perf-stat.ps.iTLB-load-misses
> >       2755            -1.5%       2713        perf-stat.ps.minor-faults
> >      22055 ± 22%     -41.6%      12879 ± 11%  perf-stat.ps.node-store-misses
> >      14552 ± 12%     +53.3%      22311 ± 14%  perf-stat.ps.node-stores
> >       2755            -1.5%       2713        perf-stat.ps.page-faults
> >  3.414e+13            -7.1%  3.172e+13        perf-stat.total.instructions
> >      69181            -1.7%      67973        proc-vmstat.nr_active_anon
> >       6177            +4.6%       6461        proc-vmstat.nr_mapped
> >     109.50 ±159%    -100.0%       0.00        proc-vmstat.nr_mlock
> >      69181            -1.7%      67973        proc-vmstat.nr_zone_active_anon
> >      17125 ± 10%     -55.2%       7668 ± 20%  proc-vmstat.numa_hint_faults
> >       4847 ± 80%     -81.0%     920.75 ± 85%  proc-vmstat.numa_hint_faults_local
> >     799546            -5.8%     753399        proc-vmstat.numa_hit
> >     785482            -5.9%     739309        proc-vmstat.numa_local
> >      63641 ± 34%     -57.8%      26863 ± 93%  proc-vmstat.numa_pte_updates
> >     861155            -5.6%     812594        proc-vmstat.pgalloc_normal
> >     922986            -6.5%     863086        proc-vmstat.pgfault
> >     833697            -5.8%     785608        proc-vmstat.pgfree
> >      17.88 ±  5%      -4.2       13.72 ± 21%  perf-profile.calltrace.cycles-
> > pp.scheduler_tick.update_process_times.tick_sched_handle.tick_sched_tim
> > er.__hrtimer_run_queues
> >       8.65 ± 10%      -2.8        5.83 ± 26%  perf-profile.calltrace.cycles-
> > pp.clockevents_program_event.hrtimer_interrupt.smp_apic_timer_interrup
> > t.apic_timer_interrupt
> >       3.81 ± 39%      -1.9        1.89 ± 30%  perf-profile.calltrace.cycles-
> > pp.ktime_get.clockevents_program_event.hrtimer_interrupt.smp_apic_tim
> > er_interrupt.apic_timer_interrupt
> >       4.05 ±  6%      -1.3        2.72 ± 25%  perf-profile.calltrace.cycles-
> > pp.ktime_get_update_offsets_now.hrtimer_interrupt.smp_apic_timer_inte
> > rrupt.apic_timer_interrupt
> >       3.42 ±100%      -1.3        2.11 ±173%  perf-profile.calltrace.cycles-
> > pp.irq_work_interrupt
> >       3.42 ±100%      -1.3        2.11 ±173%  perf-profile.calltrace.cycles-
> > pp.smp_irq_work_interrupt.irq_work_interrupt
> >       3.40 ±100%      -1.3        2.11 ±173%  perf-profile.calltrace.cycles-
> > pp.irq_work_run_list.irq_work_run.smp_irq_work_interrupt.irq_work_inter
> > rupt
> >       3.40 ±100%      -1.3        2.11 ±173%  perf-profile.calltrace.cycles-
> > pp.irq_work_run.smp_irq_work_interrupt.irq_work_interrupt
> >       3.40 ±100%      -1.1        2.27 ±173%  perf-profile.calltrace.cycles-
> > pp.printk.irq_work_run_list.irq_work_run.smp_irq_work_interrupt.irq_wor
> > k_interrupt
> >       3.40 ±100%      -1.1        2.27 ±173%  perf-profile.calltrace.cycles-
> > pp.vprintk_emit.printk.irq_work_run_list.irq_work_run.smp_irq_work_inter
> > rupt
> >       3.40 ±100%      -1.1        2.27 ±173%  perf-profile.calltrace.cycles-
> > pp.console_unlock.vprintk_emit.printk.irq_work_run_list.irq_work_run
> >       3.38 ±100%      -1.1        2.30 ±173%  perf-profile.calltrace.cycles-
> > pp.secondary_startup_64
> >       3.38 ±100%      -1.1        2.30 ±173%  perf-profile.calltrace.cycles-
> > pp.start_secondary.secondary_startup_64
> >       3.38 ±100%      -1.1        2.30 ±173%  perf-profile.calltrace.cycles-
> > pp.cpu_startup_entry.start_secondary.secondary_startup_64
> >       3.37 ±100%      -1.1        2.30 ±173%  perf-profile.calltrace.cycles-
> > pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
> >       3.33 ±100%      -1.0        2.29 ±173%  perf-profile.calltrace.cycles-
> > pp.cpuidle_enter_state.do_idle.cpu_startup_entry.start_secondary.second
> > ary_startup_64
> >       3.29 ±101%      -1.0        2.29 ±173%  perf-profile.calltrace.cycles-
> > pp.intel_idle.cpuidle_enter_state.do_idle.cpu_startup_entry.start_seconda
> > ry
> >       2.59 ± 13%      -0.8        1.78 ± 20%  perf-profile.calltrace.cycles-
> > pp.__update_load_avg_se.task_tick_fair.scheduler_tick.update_process_ti
> > mes.tick_sched_handle
> >       1.37 ± 11%      -0.7        0.65 ± 64%  perf-profile.calltrace.cycles-
> > pp.timerqueue_del.__remove_hrtimer.__hrtimer_run_queues.hrtimer_int
> > errupt.smp_apic_timer_interrupt
> >       2.93 ±101%      -0.7        2.21 ±173%  perf-profile.calltrace.cycles-
> > pp.serial8250_console_write.console_unlock.vprintk_emit.printk.irq_work_r
> > un_list
> >       2.04 ± 13%      -0.7        1.35 ± 30%  perf-profile.calltrace.cycles-
> > pp.update_curr.task_tick_fair.scheduler_tick.update_process_times.tick_sc
> > hed_handle
> >       0.80 ± 16%      -0.5        0.30 ±100%  perf-profile.calltrace.cycles-
> > pp._raw_spin_lock_irq.__hrtimer_run_queues.hrtimer_interrupt.smp_apic
> > _timer_interrupt.apic_timer_interrupt
> >       0.00        +5.5e+11%       5530 ±110%
> > sched_debug.cfs_rq:/.MIN_vruntime.avg
> >      12338           +45.3%      17924 ±  7%  sched_debug.cfs_rq:/.load.avg
> >      39464 ± 43%    +709.9%     319609 ± 46%  sched_debug.cfs_rq:/.load.max
> >       5132 ± 59%    +704.6%      41295 ± 41%  sched_debug.cfs_rq:/.load.stddev
> >     299.73 ± 28%     +60.1%     479.92 ± 19%
> > sched_debug.cfs_rq:/.load_avg.max
> >      52.90 ± 37%     +48.5%      78.55 ± 11%
> > sched_debug.cfs_rq:/.load_avg.stddev
> >       0.00        +5.5e+11%       5530 ±110%
> > sched_debug.cfs_rq:/.max_vruntime.avg
> >      56400 ± 32%    +258.5%     202169 ±  5%
> > sched_debug.cfs_rq:/.min_vruntime.stddev
> >       0.08 ± 13%     +26.3%       0.10 ± 11%
> > sched_debug.cfs_rq:/.nr_running.stddev
> >      11.16 ±  6%     +26.1%      14.08 ±  4%
> > sched_debug.cfs_rq:/.runnable_load_avg.avg
> >      34.70 ± 30%    +486.6%     203.54 ± 30%
> > sched_debug.cfs_rq:/.runnable_load_avg.max
> >       3.74 ± 31%    +599.1%      26.17 ± 30%
> > sched_debug.cfs_rq:/.runnable_load_avg.stddev
> >      12213           +46.1%      17837 ±  7%
> > sched_debug.cfs_rq:/.runnable_weight.avg
> >      35964 ± 43%    +788.0%     319358 ± 46%
> > sched_debug.cfs_rq:/.runnable_weight.max
> >       4732 ± 62%    +770.0%      41175 ± 42%
> > sched_debug.cfs_rq:/.runnable_weight.stddev
> >      40678 ±144%   +3754.8%    1568088 ±  2%
> > sched_debug.cfs_rq:/.spread0.avg
> >     127330 ± 55%   +1238.0%    1703696 ±  3%
> > sched_debug.cfs_rq:/.spread0.max
> >     -87205           -98.1%      -1677        sched_debug.cfs_rq:/.spread0.min
> >      56217 ± 32%    +259.5%     202080 ±  5%
> > sched_debug.cfs_rq:/.spread0.stddev
> >     698851 ±  8%     -16.4%     584422 ±  9%  sched_debug.cpu.avg_idle.min
> >     165933 ±  7%     +13.4%     188123        sched_debug.cpu.clock.avg
> >     165941 ±  7%     +13.4%     188129        sched_debug.cpu.clock.max
> >     165919 ±  7%     +13.4%     188115        sched_debug.cpu.clock.min
> >       5.35 ± 23%     -32.9%       3.59 ±  7%  sched_debug.cpu.clock.stddev
> >     165933 ±  7%     +13.4%     188123        sched_debug.cpu.clock_task.avg
> >     165941 ±  7%     +13.4%     188129        sched_debug.cpu.clock_task.max
> >     165919 ±  7%     +13.4%     188115        sched_debug.cpu.clock_task.min
> >       5.35 ± 23%     -32.9%       3.59 ±  7%  sched_debug.cpu.clock_task.stddev
> >      11.33 ±  4%     +19.3%      13.51 ±  9%  sched_debug.cpu.cpu_load[0].avg
> >      38.97 ± 28%    +418.2%     201.92 ± 30%  sched_debug.cpu.cpu_load[0].max
> >       4.46 ± 41%    +443.0%      24.23 ± 33%
> > sched_debug.cpu.cpu_load[0].stddev
> >      11.43 ±  4%     +17.6%      13.44 ±  8%  sched_debug.cpu.cpu_load[1].avg
> >      37.25 ± 26%    +418.9%     193.29 ± 30%  sched_debug.cpu.cpu_load[1].max
> >       4.08 ± 36%    +463.5%      23.00 ± 35%
> > sched_debug.cpu.cpu_load[1].stddev
> >      11.49 ±  4%     +16.2%      13.34 ±  7%  sched_debug.cpu.cpu_load[2].avg
> >      35.41 ± 21%    +398.6%     176.54 ± 30%  sched_debug.cpu.cpu_load[2].max
> >       3.74 ± 31%    +460.0%      20.96 ± 34%
> > sched_debug.cpu.cpu_load[2].stddev
> >      34.54 ± 14%    +336.3%     150.71 ± 21%  sched_debug.cpu.cpu_load[3].max
> >       3.51 ± 22%    +407.6%      17.84 ± 27%
> > sched_debug.cpu.cpu_load[3].stddev
> >      55.55          +164.1%     146.71 ± 15%  sched_debug.cpu.cpu_load[4].max
> >       5.57 ±  6%    +202.7%      16.85 ± 18%  sched_debug.cpu.cpu_load[4].stddev
> >       4396 ±  6%     +13.1%       4974 ±  7%  sched_debug.cpu.curr->pid.avg
> >       3517 ± 17%     -47.9%       1832 ± 34%  sched_debug.cpu.curr->pid.min
> >     305.14 ± 37%     +98.3%     604.98 ± 22%  sched_debug.cpu.curr->pid.stddev
> >      12364           +39.5%      17254 ± 14%  sched_debug.cpu.load.avg
> >      39007 ± 44%    +721.4%     320411 ± 46%  sched_debug.cpu.load.max
> >       5044 ± 63%    +681.3%      39414 ± 48%  sched_debug.cpu.load.stddev
> >     133158 ±  9%     +16.9%     155714
> > sched_debug.cpu.nr_load_updates.avg
> >     140928 ±  9%     +15.6%     162887
> > sched_debug.cpu.nr_load_updates.max
> >       1369 ± 37%     +66.8%       2283 ±  4%
> > sched_debug.cpu.nr_load_updates.stddev
> >       0.19 ±  3%     +22.7%       0.23 ± 15%  sched_debug.cpu.nr_running.stddev
> >       3143 ±  6%     +52.3%       4788 ±  3%  sched_debug.cpu.nr_switches.avg
> >      11472 ± 19%     +67.3%      19197 ±  3%  sched_debug.cpu.nr_switches.max
> >       2464 ± 19%     +73.5%       4275 ±  6%  sched_debug.cpu.nr_switches.stddev
> >     165920 ±  7%     +13.4%     188116        sched_debug.cpu_clk
> >     162590 ±  7%     +13.6%     184783        sched_debug.ktime
> >     167206 ±  6%     +13.6%     189868        sched_debug.sched_clk
> > 
> > 
> > 
> >                         ftq.time.involuntary_context_switches
> > 
> >   260000 +-+----------------------------------------------------------------+
> >          |O                                                                 |
> >   240000 +-+ O                                                              |
> >   220000 O-+   O   O                                                        |
> >          |  O   O O  O                                          O           |
> >   200000 +-+                                            O                   |
> >   180000 +-+                                 O OO OO OO  O OOO O  OO OO OO OO
> >          |                  O         O  O                                  |
> >   160000 +-+          O OOO  O  O  O O  O  O                                |
> >   140000 +-+                   O  O         O                               |
> >          |                                                                  |
> >   120000 +-+                          +                                     |
> >   100000 +-+ +.           +.     .+   :+                                    |
> >          |+.+  ++.++.++.++  ++.++  +.+  ++.+++.++.++.++.++.+++.++           |
> >    80000 +-+----------------------------------------------------------------+
> > 
> > 
> > [*] bisect-good sample
> > [O] bisect-bad  sample
> > 
> > **********************************************************
> > *****************************************
> > lkp-hsw-ep2: 72 threads Intel(R) Xeon(R) CPU E5-2699 v3 @ 2.30GHz with
> > 128G memory
> > ==========================================================
> > ===============================
> > compiler/kconfig/rootfs/tbox_group/testcase/type/ucode:
> >   gcc-7/x86_64-rhel-7.2/debian-x86_64-2018-04-03.cgz/lkp-hsw-
> > ep2/perf_test/lkp/0x3d
> > 
> > commit:
> >   73a049a90f ("ACPICA: disassembler: disassemble OEMx tables as AML")
> >   4c1379d7bb ("ACPICA: Debug output: Add option to display method/object
> > evaluation")
> > 
> > 73a049a90fb241af 4c1379d7bb42fa664e07845392
> > ---------------- --------------------------
> >        fail:runs  %reproduction    fail:runs
> >            |             |             |
> >            :8          100%           8:8     perf_test.msr_test.round1.cpu_util_zero.fail
> >          %stddev     %change         %stddev
> >              \          |                \
> >       1.00          -100.0%       0.00
> > perf_test.msr_test.round1.cpu_util_zero.pass
> >       1432           +13.1%       1620 ±  3%  perf_test.time.elapsed_time
> >       1432           +13.1%       1620 ±  3%  perf_test.time.elapsed_time.max
> >      43385            -6.9%      40403 ±  2%
> > perf_test.time.involuntary_context_switches
> >      76.62 ±  2%     +16.3%      89.12 ±  2%
> > perf_test.time.percent_of_cpu_this_job_got
> >     295.24           +17.2%     346.06 ± 13%  perf_test.time.system_time
> >     810.50           +36.5%       1106 ±  2%  perf_test.time.user_time
> >     360596           +43.1%     515953 ± 17%
> > perf_test.time.voluntary_context_switches
> >      16568           +46.1%      24206        meminfo.Inactive(anon)
> >      30398           +16.8%      35515        meminfo.Mapped
> >       1843 ± 10%      +9.1%       2010 ±  7%  meminfo.Mlocked
> >      19473           +39.3%      27124        meminfo.Shmem
> >       2897           -11.6%       2561 ±  3%  meminfo.max_used_kB
> > 
> > 
> > 
> > 
> > 
> > Disclaimer:
> > Results have been estimated based on internal Intel analysis and are
> > provided
> > for informational purposes only. Any difference in system hardware or
> > software
> > design or configuration may affect actual performance.
> > 
> > 
> > Thanks,
> > Rong Chen


