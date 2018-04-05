Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751365AbeDEHsZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 03:48:25 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54147 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751280AbeDEHsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 03:48:24 -0400
X-Google-Smtp-Source: AIpwx48ffXIhZOqy8M6wzfsy7qkpJf0FNyWVxhRuuSJUakvMJeirAXzcDTRdU1+14ak8/UNrqOuLE2WJVotKU6Nx1nc=
MIME-Version: 1.0
In-Reply-To: <20180109071628.GA24741@js1304-P5Q-DELUXE>
References: <20180102063528.GG30397@yexl-desktop> <20180103020525.GA26517@js1304-P5Q-DELUXE>
 <20180106092630.GA27910@yexl-desktop> <20180109071628.GA24741@js1304-P5Q-DELUXE>
From: Joonsoo Kim <js1304@gmail.com>
Date: Thu, 5 Apr 2018 16:48:21 +0900
Message-ID: <CAAmzW4OhAdBKy1m1mTyM36hm6vd-tVj31d25yLXfC1x4Sx+dDg@mail.gmail.com>
Subject: Re: [lkp-robot] [mm/cma] 2b0f904a5a: fio.read_bw_MBps -16.1% regression
To: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Ye Xiaolong <xiaolong.ye@intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Tony Lindgren <tony@atomide.com>, Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Laura Abbott <lauraa@codeaurora.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>, Michal Nazarewicz <mina86@mina86.com>,
        Minchan Kim <minchan@kernel.org>, Rik van Riel <riel@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@01.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w357mWJq004774

Hello,
sorry for bothering you.

2018-01-09 16:16 GMT+09:00 Joonsoo Kim <iamjoonsoo.kim@lge.com>:
> On Sat, Jan 06, 2018 at 05:26:31PM +0800, Ye Xiaolong wrote:
>> Hi,
>>
>> On 01/03, Joonsoo Kim wrote:
>> >Hello!
>> >
>> >On Tue, Jan 02, 2018 at 02:35:28PM +0800, kernel test robot wrote:
>> >>
>> >> Greeting,
>> >>
>> >> FYI, we noticed a -16.1% regression of fio.read_bw_MBps due to commit:
>> >>
>> >>
>> >> commit: 2b0f904a5a8781498417d67226fd12c5e56053ae ("mm/cma: manage the memory of the CMA area by using the ZONE_MOVABLE")
>> >> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
>> >>
>> >> in testcase: fio-basic
>> >> on test machine: 56 threads Intel(R) Xeon(R) CPU E5-2695 v3 @ 2.30GHz with 256G memory
>> >> with following parameters:
>> >>
>> >>    disk: 2pmem
>> >>    fs: ext4
>> >>    runtime: 200s
>> >>    nr_task: 50%
>> >>    time_based: tb
>> >>    rw: randread
>> >>    bs: 2M
>> >>    ioengine: mmap
>> >>    test_size: 200G
>> >>    cpufreq_governor: performance
>> >>
>> >> test-description: Fio is a tool that will spawn a number of threads or processes doing a particular type of I/O action as specified by the user.
>> >> test-url: https://github.com/axboe/fio
>> >>
>> >>
>> >>
>> >> Details are as below:
>> >> -------------------------------------------------------------------------------------------------->
>> >>
>> >>
>> >> To reproduce:
>> >>
>> >>         git clone https://github.com/intel/lkp-tests.git
>> >>         cd lkp-tests
>> >>         bin/lkp install job.yaml  # job file is attached in this email
>> >>         bin/lkp run     job.yaml
>> >>
>> >> =========================================================================================
>> >> bs/compiler/cpufreq_governor/disk/fs/ioengine/kconfig/nr_task/rootfs/runtime/rw/tbox_group/test_size/testcase/time_based:
>> >>   2M/gcc-7/performance/2pmem/ext4/mmap/x86_64-rhel-7.2/50%/debian-x86_64-2016-08-31.cgz/200s/randread/lkp-hsw-ep6/200G/fio-basic/tb
>> >>
>> >> commit:
>> >>   f6572f9cd2 ("mm/page_alloc: don't reserve ZONE_HIGHMEM for ZONE_MOVABLE request")
>> >>   2b0f904a5a ("mm/cma: manage the memory of the CMA area by using the ZONE_MOVABLE")
>> >>
>> >> f6572f9cd248df2c 2b0f904a5a8781498417d67226
>> >> ---------------- --------------------------
>> >>          %stddev     %change         %stddev
>> >>              \          |                \
>> >>      11451           -16.1%       9605        fio.read_bw_MBps
>> >>       0.29 ą  5%      +0.1        0.40 ą  3%  fio.latency_1000us%
>> >>      19.35 ą  5%      -4.7       14.69 ą  3%  fio.latency_10ms%
>> >>       7.92 ą  3%     +12.2       20.15        fio.latency_20ms%
>> >>       0.05 ą 11%      +0.0        0.09 ą  8%  fio.latency_2ms%
>> >>      70.22            -8.9       61.36        fio.latency_4ms%
>> >>       0.29 ą 13%      +0.0        0.33 ą  3%  fio.latency_500us%
>> >>       0.45 ą 29%      +1.0        1.45 ą  4%  fio.latency_50ms%
>> >>       1.37            +0.1        1.44        fio.latency_750us%
>> >>       9792           +31.7%      12896        fio.read_clat_90%_us
>> >>      10560           +33.0%      14048        fio.read_clat_95%_us
>> >>      15376 ą 10%     +46.9%      22592        fio.read_clat_99%_us
>> >>       4885           +19.2%       5825        fio.read_clat_mean_us
>> >>       5725           -16.1%       4802        fio.read_iops
>> >>  4.598e+09           -16.4%  3.845e+09        fio.time.file_system_inputs
>> >>     453153            -8.4%     415215        fio.time.involuntary_context_switches
>> >>  5.748e+08           -16.4%  4.806e+08        fio.time.major_page_faults
>> >>    1822257           +23.7%    2254706        fio.time.maximum_resident_set_size
>> >>       5089            +1.6%       5172        fio.time.system_time
>> >>     514.50           -16.3%     430.48        fio.time.user_time
>> >
>> >System time is increased and user time is decreased. On the below, there is a clue.
>> >
>> >>      24569 ą  2%      +9.6%      26917 ą  2%  fio.time.voluntary_context_switches
>> >>   54443725           -14.9%   46353339        interrupts.CAL:Function_call_interrupts
>> >>       0.00 ą 79%      -0.0        0.00 ą 17%  mpstat.cpu.iowait%
>> >>       4.45            -0.7        3.71        mpstat.cpu.usr%
>> >>    1467516           +21.3%    1779543 ą  3%  meminfo.Active
>> >>    1276031           +23.7%    1578443 ą  4%  meminfo.Active(file)
>> >>      25789 ą  3%     -76.7%       6013 ą  4%  meminfo.CmaFree
>> >>  1.296e+08           -12.6%  1.133e+08        turbostat.IRQ
>> >>      41.89            -3.4%      40.47        turbostat.RAMWatt
>> >>      17444 ą  2%     -13.5%      15092 ą  3%  turbostat.SMI
>> >>   10896428           -16.4%    9111830        vmstat.io.bi
>> >>       6010            -6.2%       5637        vmstat.system.cs
>> >>     317438           -12.1%     278980        vmstat.system.in
>> >>    1072892 ą  3%     +21.5%    1303487        numa-meminfo.node0.Active
>> >>     978318           +21.6%    1189809 ą  2%  numa-meminfo.node0.Active(file)
>> >>     222968           -25.2%     166818        numa-meminfo.node0.PageTables
>> >>      47374 ą  2%     +10.6%      52402 ą  7%  numa-meminfo.node0.SUnreclaim
>> >>     165213           +31.9%     217870        numa-meminfo.node1.PageTables
>> >>     222405           +10.4%     245633 ą  2%  numa-meminfo.node1.SReclaimable
>> >>     102992 ą 46%     -80.8%      19812 ą 38%  numa-meminfo.node1.Shmem
>> >>  2.475e+08 ą  2%     -24.0%  1.881e+08        numa-numastat.node0.local_node
>> >>   39371795 ą 14%    +167.1%  1.052e+08 ą  2%  numa-numastat.node0.numa_foreign
>> >>  2.475e+08 ą  2%     -24.0%  1.881e+08        numa-numastat.node0.numa_hit
>> >>   31890417 ą 17%     +40.2%   44705135 ą  8%  numa-numastat.node0.numa_miss
>> >>   31899482 ą 17%     +40.2%   44713255 ą  8%  numa-numastat.node0.other_node
>> >>  2.566e+08 ą  2%     -44.2%  1.433e+08        numa-numastat.node1.local_node
>> >>   31890417 ą 17%     +40.2%   44705135 ą  8%  numa-numastat.node1.numa_foreign
>> >>  2.566e+08 ą  2%     -44.2%  1.433e+08        numa-numastat.node1.numa_hit
>> >>   39371795 ą 14%    +167.1%  1.052e+08 ą  2%  numa-numastat.node1.numa_miss
>> >>   39373660 ą 14%    +167.1%  1.052e+08 ą  2%  numa-numastat.node1.other_node
>> >>       6047 ą 39%     -66.5%       2028 ą 63%  sched_debug.cfs_rq:/.exec_clock.min
>> >>     461.37 ą  8%     +64.9%     760.74 ą 20%  sched_debug.cfs_rq:/.load_avg.avg
>> >>       1105 ą 13%   +1389.3%      16467 ą 56%  sched_debug.cfs_rq:/.load_avg.max
>> >>     408.99 ą  3%    +495.0%       2433 ą 49%  sched_debug.cfs_rq:/.load_avg.stddev
>> >>      28746 ą 12%     -18.7%      23366 ą 14%  sched_debug.cfs_rq:/.min_vruntime.min
>> >>     752426 ą  3%     -12.7%     656636 ą  4%  sched_debug.cpu.avg_idle.avg
>> >>     144956 ą 61%     -85.4%      21174 ą 26%  sched_debug.cpu.avg_idle.min
>> >>     245684 ą 11%     +44.6%     355257 ą  2%  sched_debug.cpu.avg_idle.stddev
>> >>     236035 ą 15%     +51.8%     358264 ą 16%  sched_debug.cpu.nr_switches.max
>> >>      42039 ą 22%     +34.7%      56616 ą  8%  sched_debug.cpu.nr_switches.stddev
>> >>       3204 ą 24%     -48.1%       1663 ą 30%  sched_debug.cpu.sched_count.min
>> >>       2132 ą 25%     +38.7%       2957 ą 11%  sched_debug.cpu.sched_count.stddev
>> >>      90.67 ą 32%     -71.8%      25.58 ą 26%  sched_debug.cpu.sched_goidle.min
>> >>       6467 ą 15%     +22.3%       7912 ą 15%  sched_debug.cpu.ttwu_count.max
>> >>       1513 ą 27%     -55.7%     670.92 ą 22%  sched_debug.cpu.ttwu_count.min
>> >>       1025 ą 20%     +68.4%       1727 ą  9%  sched_debug.cpu.ttwu_count.stddev
>> >>       1057 ą 16%     -62.9%     391.85 ą 31%  sched_debug.cpu.ttwu_local.min
>> >>     244876           +21.6%     297770 ą  2%  numa-vmstat.node0.nr_active_file
>> >>      88.00 ą  5%     +19.3%     105.00 ą  5%  numa-vmstat.node0.nr_isolated_file
>> >>      55778           -25.1%      41765        numa-vmstat.node0.nr_page_table_pages
>> >>      11843 ą  2%     +10.6%      13100 ą  7%  numa-vmstat.node0.nr_slab_unreclaimable
>> >>     159.25 ą 42%     -74.9%      40.00 ą 52%  numa-vmstat.node0.nr_vmscan_immediate_reclaim
>> >>     244862           +21.6%     297739 ą  2%  numa-vmstat.node0.nr_zone_active_file
>> >>   19364320 ą 19%    +187.2%   55617595 ą  2%  numa-vmstat.node0.numa_foreign
>> >>     268155 ą  3%     +49.6%     401089 ą  4%  numa-vmstat.node0.workingset_activate
>> >>  1.229e+08           -19.0%   99590617        numa-vmstat.node0.workingset_refault
>> >>       6345 ą  3%     -76.5%       1489 ą  3%  numa-vmstat.node1.nr_free_cma
>> >>      41335           +32.0%      54552        numa-vmstat.node1.nr_page_table_pages
>> >>      25770 ą 46%     -80.8%       4956 ą 38%  numa-vmstat.node1.nr_shmem
>> >>      55684           +10.4%      61475 ą  2%  numa-vmstat.node1.nr_slab_reclaimable
>> >>  1.618e+08 ą  8%     -47.6%   84846798 ą 17%  numa-vmstat.node1.numa_hit
>> >>  1.617e+08 ą  8%     -47.6%   84676284 ą 17%  numa-vmstat.node1.numa_local
>> >>   19365342 ą 19%    +187.2%   55620100 ą  2%  numa-vmstat.node1.numa_miss
>> >>   19534837 ą 19%    +185.6%   55790654 ą  2%  numa-vmstat.node1.numa_other
>> >>  1.296e+08           -21.0%  1.024e+08        numa-vmstat.node1.workingset_refault
>> >>  1.832e+12            -7.5%  1.694e+12        perf-stat.branch-instructions
>> >>       0.25            -0.0        0.23        perf-stat.branch-miss-rate%
>> >>  4.666e+09           -16.0%  3.918e+09        perf-stat.branch-misses
>> >>      39.88            +1.1       40.98        perf-stat.cache-miss-rate%
>> >>  2.812e+10           -11.6%  2.485e+10        perf-stat.cache-misses
>> >>  7.051e+10           -14.0%  6.064e+10        perf-stat.cache-references
>> >>    1260521            -6.1%    1183071        perf-stat.context-switches
>> >>       1.87            +9.6%       2.05        perf-stat.cpi
>> >>       6707 ą  2%      -5.2%       6359        perf-stat.cpu-migrations
>> >>       1.04 ą 11%      -0.3        0.77 ą  4%  perf-stat.dTLB-load-miss-rate%
>> >>  2.365e+10 ą  7%     -25.9%  1.751e+10 ą  9%  perf-stat.dTLB-load-misses
>> >>   1.05e+12 ą  4%      -9.5%  9.497e+11 ą  2%  perf-stat.dTLB-stores
>> >>      28.16            +2.2       30.35 ą  2%  perf-stat.iTLB-load-miss-rate%
>> >>   2.56e+08           -10.4%  2.295e+08        perf-stat.iTLB-loads
>> >>  8.974e+12            -9.2%  8.151e+12        perf-stat.instructions
>> >>      89411            -8.8%      81529        perf-stat.instructions-per-iTLB-miss
>> >>       0.54            -8.8%       0.49        perf-stat.ipc
>> >>  5.748e+08           -16.4%  4.806e+08        perf-stat.major-faults
>> >>      52.82            +5.8       58.61 ą  2%  perf-stat.node-load-miss-rate%
>> >>  7.206e+09 ą  2%     -18.6%  5.867e+09 ą  3%  perf-stat.node-loads
>> >>      17.96 ą  8%     +15.7       33.69 ą  2%  perf-stat.node-store-miss-rate%
>> >>  2.055e+09 ą  8%     +65.1%  3.393e+09 ą  4%  perf-stat.node-store-misses
>> >>  9.391e+09 ą  2%     -28.9%  6.675e+09        perf-stat.node-stores
>> >>  5.753e+08           -16.4%  4.811e+08        perf-stat.page-faults
>> >>     305865           -16.3%     256108        proc-vmstat.allocstall_movable
>> >>       1923 ą 14%     -72.1%     537.00 ą 12%  proc-vmstat.allocstall_normal
>> >>       0.00            +Inf%       1577 ą 67%  proc-vmstat.compact_isolated
>> >>       1005 ą  4%     -65.8%     344.00 ą  7%  proc-vmstat.kswapd_low_wmark_hit_quickly
>> >>     320062           +23.2%     394374 ą  4%  proc-vmstat.nr_active_file
>> >>       6411 ą  2%     -76.4%       1511 ą  4%  proc-vmstat.nr_free_cma
>> >>     277.00 ą 12%     -51.4%     134.75 ą 52%  proc-vmstat.nr_vmscan_immediate_reclaim
>> >>     320049           +23.2%     394353 ą  4%  proc-vmstat.nr_zone_active_file
>> >>   71262212 ą 15%    +110.3%  1.499e+08 ą  3%  proc-vmstat.numa_foreign
>> >>  5.042e+08 ą  2%     -34.3%  3.314e+08        proc-vmstat.numa_hit
>> >>  5.041e+08 ą  2%     -34.3%  3.314e+08        proc-vmstat.numa_local
>> >>   71262212 ą 15%    +110.3%  1.499e+08 ą  3%  proc-vmstat.numa_miss
>> >>   71273176 ą 15%    +110.3%  1.499e+08 ą  3%  proc-vmstat.numa_other
>> >>       1007 ą  4%     -65.6%     346.25 ą  7%  proc-vmstat.pageoutrun
>> >>   23070268           -16.0%   19386190        proc-vmstat.pgalloc_dma32
>> >>  5.525e+08           -16.7%  4.603e+08        proc-vmstat.pgalloc_normal
>> >>  5.753e+08           -16.4%  4.812e+08        proc-vmstat.pgfault
>> >>  5.751e+08           -16.3%  4.813e+08        proc-vmstat.pgfree
>> >>  5.748e+08           -16.4%  4.806e+08        proc-vmstat.pgmajfault
>> >>  2.299e+09           -16.4%  1.923e+09        proc-vmstat.pgpgin
>> >>  8.396e+08           -17.8%  6.901e+08        proc-vmstat.pgscan_direct
>> >>  3.018e+08 ą  2%     -13.0%  2.627e+08        proc-vmstat.pgscan_kswapd
>> >>    4.1e+08           -15.1%   3.48e+08        proc-vmstat.pgsteal_direct
>> >>  1.542e+08 ą  3%     -20.9%   1.22e+08 ą  3%  proc-vmstat.pgsteal_kswapd
>> >>      23514 ą  4%     -23.1%      18076 ą 16%  proc-vmstat.slabs_scanned
>> >>     343040 ą  2%     +40.3%     481253 ą  2%  proc-vmstat.workingset_activate
>> >>  2.525e+08           -20.1%  2.018e+08        proc-vmstat.workingset_refault
>> >>      13.64 ą  3%      -1.7       11.96 ą  2%  perf-profile.calltrace.cycles-pp.ext4_mpage_readpages.filemap_fault.ext4_filemap_fault.__do_fault.__handle_mm_fault
>> >>      11.67 ą  3%      -1.4       10.29 ą  2%  perf-profile.calltrace.cycles-pp.submit_bio.ext4_mpage_readpages.filemap_fault.ext4_filemap_fault.__do_fault
>> >>      11.64 ą  3%      -1.4       10.25 ą  2%  perf-profile.calltrace.cycles-pp.generic_make_request.submit_bio.ext4_mpage_readpages.filemap_fault.ext4_filemap_fault
>> >>      11.10 ą  3%      -1.3        9.82 ą  2%  perf-profile.calltrace.cycles-pp.pmem_make_request.generic_make_request.submit_bio.ext4_mpage_readpages.filemap_fault
>> >>       9.21 ą  3%      -1.2        8.04 ą  3%  perf-profile.calltrace.cycles-pp.pmem_do_bvec.pmem_make_request.generic_make_request.submit_bio.ext4_mpage_readpages
>> >>      27.33 ą  4%      -1.0       26.35 ą  5%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64
>> >>      27.33 ą  4%      -1.0       26.35 ą  5%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
>> >>      27.33 ą  4%      -1.0       26.35 ą  5%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
>> >>      27.33 ą  4%      -1.0       26.35 ą  5%  perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64
>> >>      26.79 ą  4%      -0.8       25.98 ą  5%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.do_idle.cpu_startup_entry.start_secondary
>> >>      27.98 ą  3%      -0.8       27.22 ą  4%  perf-profile.calltrace.cycles-pp.secondary_startup_64
>> >>       5.36 ą 12%      -0.6        4.76 ą  7%  perf-profile.calltrace.cycles-pp.kswapd.kthread.ret_from_fork
>> >>       5.36 ą 12%      -0.6        4.76 ą  7%  perf-profile.calltrace.cycles-pp.shrink_node.kswapd.kthread.ret_from_fork
>> >>       5.30 ą 12%      -0.6        4.71 ą  7%  perf-profile.calltrace.cycles-pp.shrink_inactive_list.shrink_node_memcg.shrink_node.kswapd.kthread
>> >>       5.35 ą 12%      -0.6        4.76 ą  7%  perf-profile.calltrace.cycles-pp.shrink_node_memcg.shrink_node.kswapd.kthread.ret_from_fork
>> >>       5.43 ą 12%      -0.5        4.88 ą  7%  perf-profile.calltrace.cycles-pp.ret_from_fork
>> >>       5.43 ą 12%      -0.5        4.88 ą  7%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork
>> >>      11.04 ą  2%      -0.2       10.82 ą  2%  perf-profile.calltrace.cycles-pp.shrink_page_list.shrink_inactive_list.shrink_node_memcg.shrink_node.do_try_to_free_pages
>> >>      62.44 ą  2%      +1.9       64.38        perf-profile.calltrace.cycles-pp.page_fault
>> >>      62.38 ą  2%      +2.0       64.33        perf-profile.calltrace.cycles-pp.__do_page_fault.do_page_fault.page_fault
>> >>      62.38 ą  2%      +2.0       64.34        perf-profile.calltrace.cycles-pp.do_page_fault.page_fault
>> >>      61.52 ą  2%      +2.1       63.58        perf-profile.calltrace.cycles-pp.handle_mm_fault.__do_page_fault.do_page_fault.page_fault
>> >>      61.34 ą  2%      +2.1       63.44        perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.__do_page_fault.do_page_fault.page_fault
>> >>      30.18 ą  3%      +2.3       32.45 ą  2%  perf-profile.calltrace.cycles-pp.shrink_inactive_list.shrink_node_memcg.shrink_node.do_try_to_free_pages.try_to_free_pages
>> >>       7.98 ą  3%      +2.3       10.33 ą  2%  perf-profile.calltrace.cycles-pp.add_to_page_cache_lru.filemap_fault.ext4_filemap_fault.__do_fault.__handle_mm_fault
>> >>      30.48 ą  3%      +2.4       32.83 ą  2%  perf-profile.calltrace.cycles-pp.try_to_free_pages.__alloc_pages_slowpath.__alloc_pages_nodemask.filemap_fault.ext4_filemap_fault
>> >>      30.46 ą  3%      +2.4       32.81 ą  2%  perf-profile.calltrace.cycles-pp.do_try_to_free_pages.try_to_free_pages.__alloc_pages_slowpath.__alloc_pages_nodemask.filemap_fault
>> >>      30.46 ą  3%      +2.4       32.81 ą  2%  perf-profile.calltrace.cycles-pp.shrink_node.do_try_to_free_pages.try_to_free_pages.__alloc_pages_slowpath.__alloc_pages_nodemask
>> >>      30.37 ą  3%      +2.4       32.75 ą  2%  perf-profile.calltrace.cycles-pp.shrink_node_memcg.shrink_node.do_try_to_free_pages.try_to_free_pages.__alloc_pages_slowpath
>> >>       5.58 ą  4%      +2.5        8.08 ą  2%  perf-profile.calltrace.cycles-pp.__lru_cache_add.add_to_page_cache_lru.filemap_fault.ext4_filemap_fault.__do_fault
>> >>      32.88 ą  3%      +2.5       35.38 ą  2%  perf-profile.calltrace.cycles-pp.__alloc_pages_nodemask.filemap_fault.ext4_filemap_fault.__do_fault.__handle_mm_fault
>> >>       5.51 ą  4%      +2.5        8.02 ą  2%  perf-profile.calltrace.cycles-pp.pagevec_lru_move_fn.__lru_cache_add.add_to_page_cache_lru.filemap_fault.ext4_filemap_fault
>> >>       4.24 ą  4%      +2.5        6.76 ą  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.pagevec_lru_move_fn.__lru_cache_add.add_to_page_cache_lru.filemap_fault
>> >>       4.18 ą  4%      +2.5        6.70 ą  2%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.pagevec_lru_move_fn.__lru_cache_add.add_to_page_cache_lru
>> >>      18.64 ą  3%      +2.5       21.16 ą  2%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irq.shrink_inactive_list.shrink_node_memcg.shrink_node
>> >>      31.65 ą  3%      +2.7       34.31 ą  2%  perf-profile.calltrace.cycles-pp.__alloc_pages_slowpath.__alloc_pages_nodemask.filemap_fault.ext4_filemap_fault.__do_fault
>> >>      17.21 ą  3%      +2.7       19.93 ą  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irq.shrink_inactive_list.shrink_node_memcg.shrink_node.do_try_to_free_pages
>> >
>> >It looks like there is more lru lock contention. It would be caused by
>> >using a movable zone for the CMA memory by this patch. In this case,
>> >reclaim for normal memory skips the lru page on the movable zone so needs
>> >more time to find enough reclaim target pages. It would increase lru lock
>> >holding time and then cause contention.
>> >
>> >Could you give me another stat 'pgskip_XXX' in /proc/vmstat to confirm
>> >my theory?
>>
>> Attached is the /proc/vmstat sample file during the test, sample interval is 1s.
>
> Thanks!
>
> pgskip_XXX is low so my theory would be wrong. The other theory is
> that numa miss is the reason of the regression. Could you test the
> same test on the system without numa? I cannot test it since I
> don't have pmem.

I may find the reason of this regression. Could you test this patch on
top of this patchset?

http://lkml.kernel.org/r/<1522913236-15776-1-git-send-email-iamjoonsoo.kim@lge.com>

Thanks.
