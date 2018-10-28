Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2027EC46475
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 01:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D844207DD
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 01:43:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D844207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729097AbeJ1K0O convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 06:26:14 -0400
Received: from mga06.intel.com ([134.134.136.31]:41493 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729073AbeJ1K0N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 06:26:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Oct 2018 18:43:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,434,1534834800"; 
   d="scan'208";a="86122482"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by orsmga006.jf.intel.com with ESMTP; 27 Oct 2018 18:43:13 -0700
Received: from fmsmsx113.amr.corp.intel.com (10.18.116.7) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Sat, 27 Oct 2018 18:43:13 -0700
Received: from shsmsx102.ccr.corp.intel.com (10.239.4.154) by
 FMSMSX113.amr.corp.intel.com (10.18.116.7) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Sat, 27 Oct 2018 18:43:12 -0700
Received: from shsmsx101.ccr.corp.intel.com ([169.254.1.102]) by
 shsmsx102.ccr.corp.intel.com ([169.254.2.84]) with mapi id 14.03.0415.000;
 Sun, 28 Oct 2018 09:43:04 +0800
From:   "Wang, Kemi" <kemi.wang@intel.com>
To:     Eric Dumazet <eric.dumazet@gmail.com>,
        "Chen, Rong A" <rong.a.chen@intel.com>,
        Yuchung Cheng <ycheng@google.com>
CC:     Soheil Hassas Yeganeh <soheil@google.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>, "lkp@01.org" <lkp@01.org>,
        Wei Wang <weiwan@google.com>,
        Neal Cardwell <ncardwell@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: RE: [LKP] [tcp] a337531b94: netperf.Throughput_Mbps -6.1% regression
Thread-Topic: [LKP] [tcp] a337531b94: netperf.Throughput_Mbps -6.1%
 regression
Thread-Index: AQHUa5MQe+4SDBcIYEaP1lHzVUjOs6Ut3UYAgAYIYeA=
Date:   Sun, 28 Oct 2018 01:43:02 +0000
Message-ID: <25017BF213203E48912DB000DE5F5E1E7632A249@SHSMSX101.ccr.corp.intel.com>
References: <20181024121358.GM24195@shao2-debian>
 <e22a09c4-8bbb-e482-6e1e-59ea1111eda3@gmail.com>
In-Reply-To: <e22a09c4-8bbb-e482-6e1e-59ea1111eda3@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNmE4YjY1OWUtZWMzNi00ZDcyLTlkY2YtNzhmMzg0YmFjMWFjIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiYkNXbDBkbXIwZnBKK0xjK3BVb01pYUE0b3R1WjEySTRFdURYUHordmNNQlpXMHZIcktSYkVUNTRxYkgxYVNjVyJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.0.116
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Eric
   Thanks for the info.
   We rerun the test and verified that this issue has been fixed with commit 041a14d2671573611ffd6412bc16e2f64469f7fb.
   Only about  0.1% performance difference was observed.
 


-----Original Message-----
From: LKP [mailto:lkp-bounces@lists.01.org] On Behalf Of Eric Dumazet
Sent: Wednesday, October 24, 2018 9:27 PM
To: Chen, Rong A <rong.a.chen@intel.com>; Yuchung Cheng <ycheng@google.com>
Cc: Soheil Hassas Yeganeh <soheil@google.com>; netdev@vger.kernel.org; LKML <linux-kernel@vger.kernel.org>; Eric Dumazet <edumazet@google.com>; lkp@01.org; Wei Wang <weiwan@google.com>; Neal Cardwell <ncardwell@google.com>; David S. Miller <davem@davemloft.net>
Subject: Re: [LKP] [tcp] a337531b94: netperf.Throughput_Mbps -6.1% regression

Hi Rong

This has been reported already, and we believe this has been fixed with :

commit 041a14d2671573611ffd6412bc16e2f64469f7fb
Author: Yuchung Cheng <ycheng@google.com>
Date:   Mon Oct 1 15:42:32 2018 -0700

    tcp: start receiver buffer autotuning sooner
    
    Previously receiver buffer auto-tuning starts after receiving
    one advertised window amount of data. After the initial receiver
    buffer was raised by patch a337531b942b ("tcp: up initial rmem to
    128KB and SYN rwin to around 64KB"), the reciver buffer may take
    too long to start raising. To address this issue, this patch lowers
    the initial bytes expected to receive roughly the expected sender's
    initial window.
    
    Fixes: a337531b942b ("tcp: up initial rmem to 128KB and SYN rwin to around 64KB")
    Signed-off-by: Yuchung Cheng <ycheng@google.com>
    Signed-off-by: Wei Wang <weiwan@google.com>
    Signed-off-by: Neal Cardwell <ncardwell@google.com>
    Signed-off-by: Eric Dumazet <edumazet@google.com>
    Reviewed-by: Soheil Hassas Yeganeh <soheil@google.com>
    Signed-off-by: David S. Miller <davem@davemloft.net>


Thanks

On 10/24/2018 05:13 AM, kernel test robot wrote:
> Greeting,
> 
> FYI, we noticed a -6.1% regression of netperf.Throughput_Mbps due to commit:
> 
> 
> commit: a337531b942bd8a03e7052444d7e36972aac2d92 ("tcp: up initial rmem to 128KB and SYN rwin to around 64KB")
> https://git.kernel.org/cgit/linux/kernel/git/davem/net-next.git master
> 
> in testcase: netperf
> on test machine: 16 threads Intel(R) Xeon(R) CPU D-1541 @ 2.10GHz with 8G memory
> with following parameters:
> 
> 	ip: ipv4
> 	runtime: 900s
> 	nr_threads: 200%
> 	cluster: cs-localhost
> 	test: TCP_STREAM
> 	ucode: 0x7000013
> 	cpufreq_governor: performance
> 
> test-description: Netperf is a benchmark that can be use to measure various aspect of networking performance.
> test-url: http://www.netperf.org/netperf/
> 
> In addition to that, the commit also has significant impact on the following tests:
> 
> +------------------+-------------------------------------------------------------------+
> | testcase: change | netperf: netperf.Throughput_Mbps -1.0% regression                 |
> | test machine     | 16 threads Intel(R) Xeon(R) CPU D-1541 @ 2.10GHz with 8G memory   |
> | test parameters  | cluster=cs-localhost                                              |
> |                  | cpufreq_governor=performance                                      |
> |                  | ip=ipv4                                                           |
> |                  | nr_threads=200%                                                   |
> |                  | runtime=300s                                                      |
> |                  | send_size=5K                                                      |
> |                  | test=TCP_SENDFILE                                                 |
> |                  | ucode=0x7000013                                                   |
> +------------------+-------------------------------------------------------------------+
> | testcase: change | netperf: netperf.Throughput_Mbps -5.9% regression                 |
> | test machine     | 16 threads Intel(R) Xeon(R) CPU D-1541 @ 2.10GHz with 8G memory   |
> | test parameters  | cluster=cs-localhost                                              |
> |                  | cpufreq_governor=performance                                      |
> |                  | ip=ipv4                                                           |
> |                  | nr_threads=200%                                                   |
> |                  | runtime=900s                                                      |
> |                  | test=TCP_MAERTS                                                   |
> |                  | ucode=0x7000013                                                   |
> +------------------+-------------------------------------------------------------------+
> | testcase: change | netperf: netperf.Throughput_Mbps -3.2% regression                 |
> | test machine     | 4 threads Intel(R) Core(TM) i5-3317U CPU @ 1.70GHz with 4G memory |
> | test parameters  | cluster=cs-localhost                                              |
> |                  | cpufreq_governor=performance                                      |
> |                  | ip=ipv4                                                           |
> |                  | nr_threads=200%                                                   |
> |                  | runtime=900s                                                      |
> |                  | test=TCP_MAERTS                                                   |
> |                  | ucode=0x20                                                        |
> +------------------+-------------------------------------------------------------------+
> 
> 
> Details are as below:
> -------------------------------------------------------------------------------------------------->
> 
> 
> To reproduce:
> 
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp install job.yaml  # job file is attached in this email
>         bin/lkp run     job.yaml
> 
> =========================================================================================
> cluster/compiler/cpufreq_governor/ip/kconfig/nr_threads/rootfs/runtime/tbox_group/test/testcase/ucode:
>   cs-localhost/gcc-7/performance/ipv4/x86_64-rhel-7.2/200%/debian-x86_64-2018-04-03.cgz/900s/lkp-bdw-de1/TCP_STREAM/netperf/0x7000013
> 
> commit: 
>   3ff6cde846 ("hns3: Another build fix.")
>   a337531b94 ("tcp: up initial rmem to 128KB and SYN rwin to around 64KB")
> 
> 3ff6cde846857d45 a337531b942bd8a03e7052444d 
> ---------------- -------------------------- 
>        fail:runs  %reproduction    fail:runs
>            |             |             |    
>            :4           50%           2:4     dmesg.WARNING:at#for_ip_interrupt_entry/0x
>          %stddev     %change         %stddev
>              \          |                \  
>       2497            -6.1%       2345        netperf.Throughput_Mbps
>      79924            -6.1%      75061        netperf.Throughput_total_Mbps
>     186513           +11.3%     207590        netperf.time.involuntary_context_switches
>  5.488e+08            -6.1%  5.154e+08        netperf.workload
>       1172 ± 34%     -37.6%     731.75 ±  5%  cpuidle.C1E.usage
>       1137 ± 34%     -40.0%     682.25 ±  8%  turbostat.C1E
>       2775 ± 11%     +17.5%       3261 ±  9%  sched_debug.cpu.nr_switches.stddev
>       0.01 ± 17%     +28.2%       0.01 ± 10%  sched_debug.rt_rq:/.rt_time.avg
>       0.14 ± 17%     +28.2%       0.18 ± 10%  sched_debug.rt_rq:/.rt_time.max
>       0.03 ± 17%     +28.2%       0.04 ± 10%  sched_debug.rt_rq:/.rt_time.stddev
>      66336            +0.9%      66948        proc-vmstat.nr_anon_pages
>  2.755e+08            -6.1%  2.588e+08        proc-vmstat.numa_hit
>  2.755e+08            -6.1%  2.588e+08        proc-vmstat.numa_local
>  2.197e+09            -6.1%  2.064e+09        proc-vmstat.pgalloc_normal
>  2.197e+09            -6.1%  2.064e+09        proc-vmstat.pgfree
>  5.903e+11            -7.9%  5.438e+11        perf-stat.branch-instructions
>       2.68            -0.0        2.64        perf-stat.branch-miss-rate%
>  1.582e+10            -9.2%  1.436e+10        perf-stat.branch-misses
>   6.26e+11            -4.7%  5.964e+11        perf-stat.cache-misses
>   6.26e+11            -4.7%  5.964e+11        perf-stat.cache-references
>      11.69            +8.6%      12.69        perf-stat.cpi
>     123723            +2.1%     126291        perf-stat.cpu-migrations
>       0.09 ±  2%      +0.0        0.09        perf-stat.dTLB-load-miss-rate%
>  1.475e+12            -7.1%   1.37e+12        perf-stat.dTLB-loads
>  1.094e+12            -6.9%  1.018e+12        perf-stat.dTLB-stores
>  2.912e+08 ±  5%     -13.0%  2.533e+08        perf-stat.iTLB-loads
>  3.019e+12            -7.9%  2.781e+12        perf-stat.instructions
>       0.09            -7.9%       0.08        perf-stat.ipc
>       5500            -1.9%       5394        perf-stat.path-length
>       0.53 ±  2%      -0.2        0.38 ± 57%  perf-profile.calltrace.cycles-pp.ip_output.__ip_queue_xmit.__tcp_transmit_skb.tcp_write_xmit.__tcp_push_pending_frames
>       0.63 ±  2%      -0.1        0.58 ±  4%  perf-profile.calltrace.cycles-pp.syscall_return_via_sysret
>       0.73 ±  3%      +0.1        0.78 ±  2%  perf-profile.calltrace.cycles-pp.tcp_clean_rtx_queue.tcp_ack.tcp_rcv_established.tcp_v4_do_rcv.tcp_v4_rcv
>       0.96            +0.1        1.03        perf-profile.calltrace.cycles-pp.tcp_ack.tcp_rcv_established.tcp_v4_do_rcv.tcp_v4_rcv.ip_local_deliver_finish
>      98.02            +0.1       98.13        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
>      97.88            +0.1       98.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       0.70 ±  3%      -0.1        0.64 ±  4%  perf-profile.children.cycles-pp.syscall_return_via_sysret
>       0.26 ±  5%      -0.0        0.21 ±  6%  perf-profile.children.cycles-pp._raw_spin_lock_bh
>       0.28 ±  5%      -0.0        0.24 ±  6%  perf-profile.children.cycles-pp.lock_sock_nested
>       0.46 ±  4%      -0.0        0.43 ±  2%  perf-profile.children.cycles-pp.nf_hook_slow
>       0.21 ±  8%      -0.0        0.18 ±  5%  perf-profile.children.cycles-pp.tcp_rcv_space_adjust
>       0.08 ±  5%      -0.0        0.06        perf-profile.children.cycles-pp.entry_SYSCALL_64_stage2
>       0.08 ±  6%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.ip_finish_output
>       0.17 ±  6%      +0.0        0.20 ±  5%  perf-profile.children.cycles-pp.tcp_event_new_data_sent
>       0.24 ±  4%      +0.0        0.27 ±  2%  perf-profile.children.cycles-pp.mod_timer
>       0.15 ±  2%      +0.0        0.18 ±  2%  perf-profile.children.cycles-pp.__might_sleep
>       0.80 ±  3%      +0.0        0.84 ±  2%  perf-profile.children.cycles-pp.tcp_clean_rtx_queue
>       0.30 ±  3%      +0.1        0.36 ±  4%  perf-profile.children.cycles-pp.__might_fault
>       1.61 ±  4%      +0.1        1.69        perf-profile.children.cycles-pp.__release_sock
>       1.06 ±  2%      +0.1        1.14        perf-profile.children.cycles-pp.tcp_ack
>      98.24            +0.1       98.36        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
>      98.09            +0.1       98.23        perf-profile.children.cycles-pp.do_syscall_64
>      70.28            +0.6       70.86        perf-profile.children.cycles-pp.copy_user_enhanced_fast_string
>       1.56            -0.1        1.48 ±  3%  perf-profile.self.cycles-pp.copy_page_to_iter
>       0.70 ±  3%      -0.1        0.64 ±  4%  perf-profile.self.cycles-pp.syscall_return_via_sysret
>       1.37 ±  2%      -0.1        1.32 ±  2%  perf-profile.self.cycles-pp.__free_pages_ok
>       0.55 ±  3%      -0.0        0.50 ±  3%  perf-profile.self.cycles-pp.__alloc_skb
>       0.44 ±  3%      -0.0        0.40 ±  5%  perf-profile.self.cycles-pp.tcp_recvmsg
>       0.16 ±  9%      -0.0        0.14 ±  5%  perf-profile.self.cycles-pp.sock_has_perm
>       0.08 ±  6%      -0.0        0.06        perf-profile.self.cycles-pp.entry_SYSCALL_64_stage2
>       0.10 ±  4%      +0.0        0.12 ±  6%  perf-profile.self.cycles-pp.tcp_clean_rtx_queue
>       0.14 ±  6%      +0.0        0.17 ±  4%  perf-profile.self.cycles-pp.__might_sleep
>      69.25            +0.5       69.77        perf-profile.self.cycles-pp.copy_user_enhanced_fast_string
> 
> 
>                                                                                 
>                               netperf.Throughput_Mbps                           
>                                                                                 
>   3000 +-+------------------------------------------------------------------+   
>        |                                                                    |   
>   2500 +-+..+.+..+.+..+.+..+.+..+.+..+.+..+.+.+..+.+..+.+..+.+..+.+..+.+..+.|   
>        O O  O O  O O  O O  O O  O O  O O  O O O  O O  O O  O O  O O         |   
>        | :                                                                  |   
>   2000 +-+                                                                  |   
>        |:                                                                   |   
>   1500 +-+                                                                  |   
>        |:                                                                   |   
>   1000 +-+                                                                  |   
>        |:                                                                   |   
>        |:                                                                   |   
>    500 +-+                                                                  |   
>        |                                                                    |   
>      0 +-+------------------------------------------------------------------+   
>                                                                                 
>                                                                                                                                                                 
>                             netperf.Throughput_total_Mbps                       
>                                                                                 
>   90000 +-+-----------------------------------------------------------------+   
>         |                                                                   |   
>   80000 O-O..O.O..O.O..O.O.O..O.O..O.O..O.O.O..O.O..O.O..O.O.O..O.O..+.+..+.|   
>   70000 +-+                                                                 |   
>         | :                                                                 |   
>   60000 +-+                                                                 |   
>   50000 +-+                                                                 |   
>         |:                                                                  |   
>   40000 +-+                                                                 |   
>   30000 +-+                                                                 |   
>         |:                                                                  |   
>   20000 +-+                                                                 |   
>   10000 +-+                                                                 |   
>         |                                                                   |   
>       0 +-+-----------------------------------------------------------------+   
>                                                                                 
>                                                                                                                                                                 
>                                   netperf.workload                              
>                                                                                 
>   6e+08 +-+-----------------------------------------------------------------+   
>         | +..+.+..+.+..+.+.+..+.+..+.+..+.+.+..+.+..+.+..+.+.+..+.+..+.+..+.|   
>   5e+08 O-O  O O  O O  O O O  O O  O O  O O O  O O  O O  O O O  O O         |   
>         | :                                                                 |   
>         | :                                                                 |   
>   4e+08 +-+                                                                 |   
>         |:                                                                  |   
>   3e+08 +-+                                                                 |   
>         |:                                                                  |   
>   2e+08 +-+                                                                 |   
>         |:                                                                  |   
>         |                                                                   |   
>   1e+08 +-+                                                                 |   
>         |                                                                   |   
>       0 +-+-----------------------------------------------------------------+   
>                                                                                 
>                                                                                 
> [*] bisect-good sample
> [O] bisect-bad  sample
> 
> ***************************************************************************************************
> lkp-bdw-de1: 16 threads Intel(R) Xeon(R) CPU D-1541 @ 2.10GHz with 8G memory
> =========================================================================================
> cluster/compiler/cpufreq_governor/ip/kconfig/nr_threads/rootfs/runtime/send_size/tbox_group/test/testcase/ucode:
>   cs-localhost/gcc-7/performance/ipv4/x86_64-rhel-7.2/200%/debian-x86_64-2018-04-03.cgz/300s/5K/lkp-bdw-de1/TCP_SENDFILE/netperf/0x7000013
> 
> commit: 
>   3ff6cde846 ("hns3: Another build fix.")
>   a337531b94 ("tcp: up initial rmem to 128KB and SYN rwin to around 64KB")
> 
> 3ff6cde846857d45 a337531b942bd8a03e7052444d 
> ---------------- -------------------------- 
>        fail:runs  %reproduction    fail:runs
>            |             |             |    
>           1:4          -25%            :4     dmesg.WARNING:at#for_ip_interrupt_entry/0x
>          %stddev     %change         %stddev
>              \          |                \  
>       5211            -1.0%       5160        netperf.Throughput_Mbps
>     166777            -1.0%     165138        netperf.Throughput_total_Mbps
>       1268            -1.6%       1247        netperf.time.percent_of_cpu_this_job_got
>       3539            -1.6%       3481        netperf.time.system_time
>     282.77            -1.5%     278.54        netperf.time.user_time
>    1435875            -1.0%    1421780        netperf.time.voluntary_context_switches
>  1.222e+09            -1.0%   1.21e+09        netperf.workload
>      22728            -1.3%      22437        vmstat.system.cs
>    1218263 ±  3%      -5.6%    1150027 ±  4%  proc-vmstat.pgalloc_normal
>    1197588 ±  4%      -6.0%    1125684 ±  4%  proc-vmstat.pgfree
>       3424 ± 17%     -28.2%       2456 ± 21%  sched_debug.cpu.nr_load_updates.stddev
>       9.00 ± 11%     -19.9%       7.21 ± 11%  sched_debug.cpu.nr_uninterruptible.max
>   35344728 ± 33%     -94.5%    1954598 ±144%  cpuidle.C3.time
>      79217 ± 32%     -95.5%       3571 ±115%  cpuidle.C3.usage
>   13342584 ± 19%    +253.4%   47153200 ± 34%  cpuidle.C6.time
>      17886 ± 21%    +185.8%      51115 ± 34%  cpuidle.C6.usage
>       4295 ± 24%    +108.0%       8934 ± 53%  cpuidle.POLL.time
>      79180 ± 32%     -95.6%       3487 ±118%  turbostat.C3
>       0.73 ± 32%      -0.7        0.04 ±144%  turbostat.C3%
>      17693 ± 21%    +187.9%      50931 ± 34%  turbostat.C6
>       0.27 ± 19%      +0.7        0.97 ± 34%  turbostat.C6%
>       0.35 ± 30%     -89.9%       0.04 ±173%  turbostat.CPU%c3
>       0.08 ±  6%    +693.3%       0.59 ± 38%  turbostat.CPU%c6
>       2.95            +3.1%       3.04        turbostat.RAMWatt
>  1.711e+12            -1.3%  1.689e+12        perf-stat.branch-instructions
>  5.345e+10            -1.2%  5.283e+10        perf-stat.branch-misses
>  9.417e+10           +16.7%  1.099e+11        perf-stat.cache-misses
>  9.417e+10           +16.7%  1.099e+11        perf-stat.cache-references
>    6927335            -1.1%    6849494        perf-stat.context-switches
>  2.936e+12            -1.3%  2.899e+12        perf-stat.dTLB-loads
>  1.796e+12            -1.3%  1.773e+12        perf-stat.dTLB-stores
>      80.43            +3.5       83.95        perf-stat.iTLB-load-miss-rate%
>  3.809e+09 ±  4%      -4.7%  3.629e+09 ±  2%  perf-stat.iTLB-load-misses
>  9.248e+08 ±  3%     -25.0%  6.934e+08        perf-stat.iTLB-loads
>  8.835e+12            -1.3%  8.719e+12        perf-stat.instructions
>      69.17            -1.1       68.08        perf-profile.calltrace.cycles-pp.__x64_sys_sendfile64.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      65.80            -1.0       64.79        perf-profile.calltrace.cycles-pp.do_sendfile.__x64_sys_sendfile64.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      55.88            -0.8       55.04        perf-profile.calltrace.cycles-pp.do_splice_direct.do_sendfile.__x64_sys_sendfile64.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      52.32            -0.8       51.56        perf-profile.calltrace.cycles-pp.splice_direct_to_actor.do_splice_direct.do_sendfile.__x64_sys_sendfile64.do_syscall_64
>      35.71            -0.6       35.11        perf-profile.calltrace.cycles-pp.direct_splice_actor.splice_direct_to_actor.do_splice_direct.do_sendfile.__x64_sys_sendfile64
>      34.84            -0.6       34.26        perf-profile.calltrace.cycles-pp.splice_from_pipe.direct_splice_actor.splice_direct_to_actor.do_splice_direct.do_sendfile
>      33.94            -0.5       33.41        perf-profile.calltrace.cycles-pp.__splice_from_pipe.splice_from_pipe.direct_splice_actor.splice_direct_to_actor.do_splice_direct
>      26.16            -0.5       25.70        perf-profile.calltrace.cycles-pp.tcp_sendpage.inet_sendpage.kernel_sendpage.sock_sendpage.pipe_to_sendpage
>      30.02            -0.5       29.55        perf-profile.calltrace.cycles-pp.pipe_to_sendpage.__splice_from_pipe.splice_from_pipe.direct_splice_actor.splice_direct_to_actor
>      28.77            -0.4       28.34        perf-profile.calltrace.cycles-pp.sock_sendpage.pipe_to_sendpage.__splice_from_pipe.splice_from_pipe.direct_splice_actor
>      27.68            -0.4       27.27        perf-profile.calltrace.cycles-pp.inet_sendpage.kernel_sendpage.sock_sendpage.pipe_to_sendpage.__splice_from_pipe
>      27.98            -0.4       27.58        perf-profile.calltrace.cycles-pp.kernel_sendpage.sock_sendpage.pipe_to_sendpage.__splice_from_pipe.splice_from_pipe
>      20.30            -0.3       19.95        perf-profile.calltrace.cycles-pp.tcp_sendpage_locked.tcp_sendpage.inet_sendpage.kernel_sendpage.sock_sendpage
>      19.49            -0.3       19.16        perf-profile.calltrace.cycles-pp.do_tcp_sendpages.tcp_sendpage_locked.tcp_sendpage.inet_sendpage.kernel_sendpage
>       9.78            -0.2        9.53        perf-profile.calltrace.cycles-pp.tcp_write_xmit.__tcp_push_pending_frames.do_tcp_sendpages.tcp_sendpage_locked.tcp_sendpage
>       9.94            -0.2        9.70        perf-profile.calltrace.cycles-pp.__tcp_push_pending_frames.do_tcp_sendpages.tcp_sendpage_locked.tcp_sendpage.inet_sendpage
>       6.32            -0.2        6.09        perf-profile.calltrace.cycles-pp.__tcp_transmit_skb.tcp_write_xmit.__tcp_push_pending_frames.do_tcp_sendpages.tcp_sendpage_locked
>       5.59            -0.2        5.42        perf-profile.calltrace.cycles-pp.__ip_queue_xmit.__tcp_transmit_skb.tcp_write_xmit.__tcp_push_pending_frames.do_tcp_sendpages
>       5.19            -0.2        5.02        perf-profile.calltrace.cycles-pp.ip_output.__ip_queue_xmit.__tcp_transmit_skb.tcp_write_xmit.__tcp_push_pending_frames
>       4.79            -0.2        4.62        perf-profile.calltrace.cycles-pp.ip_rcv.__netif_receive_skb_one_core.process_backlog.net_rx_action.__softirqentry_text_start
>       5.51            -0.2        5.35        perf-profile.calltrace.cycles-pp.__softirqentry_text_start.do_softirq_own_stack.do_softirq.__local_bh_enable_ip.ip_finish_output2
>       5.00            -0.2        4.84        perf-profile.calltrace.cycles-pp.__netif_receive_skb_one_core.process_backlog.net_rx_action.__softirqentry_text_start.do_softirq_own_stack
>       5.52            -0.2        5.36        perf-profile.calltrace.cycles-pp.do_softirq_own_stack.do_softirq.__local_bh_enable_ip.ip_finish_output2.ip_output
>       5.37            -0.2        5.21        perf-profile.calltrace.cycles-pp.net_rx_action.__softirqentry_text_start.do_softirq_own_stack.do_softirq.__local_bh_enable_ip
>       4.68            -0.2        4.53        perf-profile.calltrace.cycles-pp.security_file_permission.do_sendfile.__x64_sys_sendfile64.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       5.61            -0.2        5.46        perf-profile.calltrace.cycles-pp.do_softirq.__local_bh_enable_ip.ip_finish_output2.ip_output.__ip_queue_xmit
>       5.21            -0.2        5.06        perf-profile.calltrace.cycles-pp.process_backlog.net_rx_action.__softirqentry_text_start.do_softirq_own_stack.do_softirq
>       4.58            -0.2        4.42        perf-profile.calltrace.cycles-pp.ip_finish_output2.ip_output.__ip_queue_xmit.__tcp_transmit_skb.tcp_write_xmit
>       5.66            -0.2        5.50        perf-profile.calltrace.cycles-pp.__local_bh_enable_ip.ip_finish_output2.ip_output.__ip_queue_xmit.__tcp_transmit_skb
>       4.39            -0.2        4.24        perf-profile.calltrace.cycles-pp.__entry_SYSCALL_64_trampoline
>       2.87 ±  2%      -0.1        2.76        perf-profile.calltrace.cycles-pp.selinux_file_permission.security_file_permission.do_sendfile.__x64_sys_sendfile64.do_syscall_64
>       1.25 ±  3%      -0.1        1.15        perf-profile.calltrace.cycles-pp.__inode_security_revalidate.selinux_file_permission.security_file_permission.do_sendfile.__x64_sys_sendfile64
>       4.30            -0.1        4.20        perf-profile.calltrace.cycles-pp.ip_local_deliver_finish.ip_local_deliver.ip_rcv.__netif_receive_skb_one_core.process_backlog
>       1.86            -0.1        1.77 ±  3%  perf-profile.calltrace.cycles-pp.release_sock.tcp_sendpage.inet_sendpage.kernel_sendpage.sock_sendpage
>       1.14            -0.1        1.08 ±  2%  perf-profile.calltrace.cycles-pp.file_has_perm.security_file_permission.do_splice_direct.do_sendfile.__x64_sys_sendfile64
>       0.69            -0.1        0.63        perf-profile.calltrace.cycles-pp.tcp_release_cb.release_sock.tcp_sendpage.inet_sendpage.kernel_sendpage
>       0.61 ±  2%      -0.1        0.56 ±  2%  perf-profile.calltrace.cycles-pp.__might_fault.__x64_sys_sendfile64.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       0.61 ±  2%      -0.0        0.57 ±  4%  perf-profile.calltrace.cycles-pp.avc_has_perm.file_has_perm.security_file_permission.do_splice_direct.do_sendfile
>       0.57 ±  2%      +0.0        0.61 ±  2%  perf-profile.calltrace.cycles-pp.___might_sleep.__might_fault.copy_page_to_iter.skb_copy_datagram_iter.tcp_recvmsg
>      90.63            +0.2       90.83        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      91.39            +0.2       91.62        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
>      20.12            +1.3       21.46        perf-profile.calltrace.cycles-pp.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      20.10            +1.3       21.44        perf-profile.calltrace.cycles-pp.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      19.84            +1.4       21.24        perf-profile.calltrace.cycles-pp.tcp_recvmsg.inet_recvmsg.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64
>      19.89            +1.4       21.30        perf-profile.calltrace.cycles-pp.inet_recvmsg.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      15.07            +1.6       16.65        perf-profile.calltrace.cycles-pp.skb_copy_datagram_iter.tcp_recvmsg.inet_recvmsg.__sys_recvfrom.__x64_sys_recvfrom
>      14.25            +1.6       15.82        perf-profile.calltrace.cycles-pp.copy_page_to_iter.skb_copy_datagram_iter.tcp_recvmsg.inet_recvmsg.__sys_recvfrom
>      11.15            +1.6       12.74        perf-profile.calltrace.cycles-pp.copyout.copy_page_to_iter.skb_copy_datagram_iter.tcp_recvmsg.inet_recvmsg
>      10.84            +1.6       12.45        perf-profile.calltrace.cycles-pp.copy_user_enhanced_fast_string.copyout.copy_page_to_iter.skb_copy_datagram_iter.tcp_recvmsg
>      69.33            -1.1       68.23        perf-profile.children.cycles-pp.__x64_sys_sendfile64
>      65.94            -1.0       64.92        perf-profile.children.cycles-pp.do_sendfile
>      55.98            -0.8       55.14        perf-profile.children.cycles-pp.do_splice_direct
>      52.38            -0.8       51.60        perf-profile.children.cycles-pp.splice_direct_to_actor
>      35.77            -0.6       35.16        perf-profile.children.cycles-pp.direct_splice_actor
>      34.91            -0.6       34.33        perf-profile.children.cycles-pp.splice_from_pipe
>      34.07            -0.5       33.53        perf-profile.children.cycles-pp.__splice_from_pipe
>      30.09            -0.5       29.62        perf-profile.children.cycles-pp.pipe_to_sendpage
>      26.31            -0.5       25.86        perf-profile.children.cycles-pp.tcp_sendpage
>      28.85            -0.4       28.42        perf-profile.children.cycles-pp.sock_sendpage
>      27.75            -0.4       27.33        perf-profile.children.cycles-pp.inet_sendpage
>      28.05            -0.4       27.65        perf-profile.children.cycles-pp.kernel_sendpage
>      20.38            -0.3       20.03        perf-profile.children.cycles-pp.tcp_sendpage_locked
>      19.62            -0.3       19.29        perf-profile.children.cycles-pp.do_tcp_sendpages
>       9.69            -0.3        9.42        perf-profile.children.cycles-pp.security_file_permission
>       8.60            -0.2        8.38        perf-profile.children.cycles-pp.__tcp_transmit_skb
>      10.66            -0.2       10.43        perf-profile.children.cycles-pp.tcp_write_xmit
>      10.79            -0.2       10.56        perf-profile.children.cycles-pp.__tcp_push_pending_frames
>       7.82            -0.2        7.64        perf-profile.children.cycles-pp.__ip_queue_xmit
>       7.38            -0.2        7.20        perf-profile.children.cycles-pp.ip_output
>       6.36            -0.2        6.19        perf-profile.children.cycles-pp.__local_bh_enable_ip
>       5.95            -0.2        5.78        perf-profile.children.cycles-pp.__entry_SYSCALL_64_trampoline
>       4.86            -0.2        4.69        perf-profile.children.cycles-pp.ip_rcv
>       5.07            -0.2        4.91        perf-profile.children.cycles-pp.__netif_receive_skb_one_core
>       5.44            -0.2        5.29        perf-profile.children.cycles-pp.net_rx_action
>       5.58            -0.2        5.42        perf-profile.children.cycles-pp.do_softirq_own_stack
>       5.28            -0.2        5.13        perf-profile.children.cycles-pp.process_backlog
>       6.70            -0.2        6.55        perf-profile.children.cycles-pp.ip_finish_output2
>       5.67            -0.1        5.52        perf-profile.children.cycles-pp.do_softirq
>       2.76 ±  3%      -0.1        2.62        perf-profile.children.cycles-pp.__inode_security_revalidate
>       1.39 ±  4%      -0.1        1.27 ±  2%  perf-profile.children.cycles-pp._cond_resched
>       4.45            -0.1        4.34        perf-profile.children.cycles-pp.ip_local_deliver
>       0.73 ±  5%      -0.1        0.64 ±  3%  perf-profile.children.cycles-pp.rcu_all_qs
>       0.72            -0.1        0.65        perf-profile.children.cycles-pp.tcp_release_cb
>       0.30 ±  5%      -0.1        0.24 ±  3%  perf-profile.children.cycles-pp.tcp_rcv_space_adjust
>       0.43 ±  4%      -0.0        0.39 ±  5%  perf-profile.children.cycles-pp.copy_user_generic_unrolled
>       0.17 ±  7%      -0.0        0.12 ±  6%  perf-profile.children.cycles-pp.ip_rcv_finish_core
>       0.19 ±  7%      -0.0        0.15 ±  6%  perf-profile.children.cycles-pp.ip_rcv_finish
>       0.14 ±  5%      -0.0        0.11 ±  8%  perf-profile.children.cycles-pp.tcp_rearm_rto
>       0.10 ± 11%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.sockfd_lookup_light
>       0.07 ±  5%      +0.0        0.09 ±  5%  perf-profile.children.cycles-pp.skb_entail
>       0.11 ±  3%      +0.0        0.13 ±  6%  perf-profile.children.cycles-pp.scheduler_tick
>       0.51 ±  3%      +0.0        0.55 ±  3%  perf-profile.children.cycles-pp.tcp_established_options
>      90.70            +0.2       90.90        perf-profile.children.cycles-pp.do_syscall_64
>      91.47            +0.2       91.70        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
>      20.13            +1.3       21.47        perf-profile.children.cycles-pp.__x64_sys_recvfrom
>      20.10            +1.3       21.44        perf-profile.children.cycles-pp.__sys_recvfrom
>      19.89            +1.4       21.30        perf-profile.children.cycles-pp.inet_recvmsg
>      19.84            +1.4       21.26        perf-profile.children.cycles-pp.tcp_recvmsg
>      16.63            +1.6       18.19        perf-profile.children.cycles-pp.copy_page_to_iter
>      15.08            +1.6       16.66        perf-profile.children.cycles-pp.skb_copy_datagram_iter
>      11.24            +1.6       12.82        perf-profile.children.cycles-pp.copyout
>      11.24            +1.6       12.82        perf-profile.children.cycles-pp.copy_user_enhanced_fast_string
>       5.68            -0.2        5.51        perf-profile.self.cycles-pp.__entry_SYSCALL_64_trampoline
>       0.67            -0.1        0.60 ±  2%  perf-profile.self.cycles-pp.tcp_release_cb
>       0.93 ±  2%      -0.1        0.86 ±  2%  perf-profile.self.cycles-pp.__inode_security_revalidate
>       1.09 ±  2%      -0.0        1.05 ±  2%  perf-profile.self.cycles-pp.do_syscall_64
>       0.16 ±  9%      -0.0        0.12 ±  7%  perf-profile.self.cycles-pp.ip_rcv_finish_core
>       0.09 ± 11%      -0.0        0.05 ± 62%  perf-profile.self.cycles-pp.__tcp_ack_snd_check
>       0.40 ±  3%      -0.0        0.36 ±  7%  perf-profile.self.cycles-pp.copy_user_generic_unrolled
>       0.80            -0.0        0.77 ±  2%  perf-profile.self.cycles-pp.current_time
>       0.28 ±  2%      -0.0        0.25 ±  3%  perf-profile.self.cycles-pp.tcp_recvmsg
>       0.27 ±  6%      -0.0        0.24 ±  5%  perf-profile.self.cycles-pp.__alloc_skb
>       0.18 ±  6%      -0.0        0.15 ±  7%  perf-profile.self.cycles-pp.tcp_mstamp_refresh
>       0.10 ±  5%      -0.0        0.08 ±  5%  perf-profile.self.cycles-pp.__tcp_select_window
>       0.22 ±  3%      +0.0        0.24 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
>       0.46 ±  5%      +0.0        0.51 ±  4%  perf-profile.self.cycles-pp.tcp_established_options
>      11.14            +1.5       12.68        perf-profile.self.cycles-pp.copy_user_enhanced_fast_string
> 
> 
> 
> ***************************************************************************************************
> lkp-bdw-de1: 16 threads Intel(R) Xeon(R) CPU D-1541 @ 2.10GHz with 8G memory
> =========================================================================================
> cluster/compiler/cpufreq_governor/ip/kconfig/nr_threads/rootfs/runtime/tbox_group/test/testcase/ucode:
>   cs-localhost/gcc-7/performance/ipv4/x86_64-rhel-7.2/200%/debian-x86_64-2018-04-03.cgz/900s/lkp-bdw-de1/TCP_MAERTS/netperf/0x7000013
> 
> commit: 
>   3ff6cde846 ("hns3: Another build fix.")
>   a337531b94 ("tcp: up initial rmem to 128KB and SYN rwin to around 64KB")
> 
> 3ff6cde846857d45 a337531b942bd8a03e7052444d 
> ---------------- -------------------------- 
>        fail:runs  %reproduction    fail:runs
>            |             |             |    
>           1:4            2%           1:4     perf-profile.children.cycles-pp.schedule_timeout
>          %stddev     %change         %stddev
>              \          |                \  
>       2497            -5.9%       2349        netperf.Throughput_Mbps
>      79914            -5.9%      75172        netperf.Throughput_total_Mbps
>       2472            +4.7%       2588        netperf.time.maximum_resident_set_size
>       8998            +8.0%       9715        netperf.time.minor_page_faults
>      88.91           -13.7%      76.77        netperf.time.user_time
>  5.487e+08            -5.9%  5.162e+08        netperf.workload
>   50507215 ± 49%     -63.0%   18671277 ± 27%  cpuidle.C3.time
>     111760 ±  6%     +12.4%     125584 ±  3%  meminfo.DirectMap4k
>       0.35 ± 49%      -0.2        0.13 ± 29%  turbostat.C3%
>      42.19            -1.2%      41.70        turbostat.PkgWatt
>       1988            +9.6%       2180 ±  2%  sched_debug.cfs_rq:/.util_est_enqueued.max
>     401.62 ±  3%     +11.2%     446.64 ±  4%  sched_debug.cfs_rq:/.util_est_enqueued.stddev
>       3.91 ± 12%     -18.4%       3.19 ± 14%  sched_debug.cpu.nr_uninterruptible.stddev
>     697.25 ±  4%     +48.3%       1034 ± 19%  slabinfo.dmaengine-unmap-16.active_objs
>     697.25 ±  4%     +48.3%       1034 ± 19%  slabinfo.dmaengine-unmap-16.num_objs
>       1464 ± 11%     -20.9%       1157 ±  9%  slabinfo.skbuff_head_cache.active_objs
>       1464 ± 11%     -20.9%       1157 ±  9%  slabinfo.skbuff_head_cache.num_objs
>      70462            +1.3%      71390        proc-vmstat.nr_active_anon
>      66190            +1.5%      67154        proc-vmstat.nr_anon_pages
>      70462            +1.3%      71390        proc-vmstat.nr_zone_active_anon
>  2.756e+08            -6.0%  2.592e+08        proc-vmstat.numa_hit
>  2.756e+08            -6.0%  2.592e+08        proc-vmstat.numa_local
>  2.197e+09            -6.0%  2.067e+09        proc-vmstat.pgalloc_normal
>  2.197e+09            -6.0%  2.066e+09        proc-vmstat.pgfree
>  5.831e+11            -7.8%  5.377e+11        perf-stat.branch-instructions
>  1.567e+10            -8.9%  1.428e+10        perf-stat.branch-misses
>  6.246e+11            -4.4%  5.974e+11        perf-stat.cache-misses
>  6.246e+11            -4.4%  5.974e+11        perf-stat.cache-references
>      11.79            +8.4%      12.78        perf-stat.cpi
>     122574            +2.4%     125502        perf-stat.cpu-migrations
>  1.473e+12            -7.0%  1.369e+12        perf-stat.dTLB-loads
>       0.07 ± 13%      +0.0        0.09 ±  6%  perf-stat.dTLB-store-miss-rate%
>   7.83e+08 ± 13%     +15.6%  9.049e+08 ±  6%  perf-stat.dTLB-store-misses
>  1.092e+12            -6.8%  1.017e+12        perf-stat.dTLB-stores
>  1.153e+09           -10.1%  1.037e+09        perf-stat.iTLB-load-misses
>   2.66e+08 ±  4%      -7.0%  2.474e+08        perf-stat.iTLB-loads
>  2.994e+12            -7.8%  2.761e+12        perf-stat.instructions
>       0.08            -7.8%       0.08        perf-stat.ipc
>       5456            -2.0%       5348        perf-stat.path-length
>       2.62            -0.1        2.49        perf-profile.calltrace.cycles-pp.tcp_write_xmit.__tcp_push_pending_frames.tcp_rcv_established.tcp_v4_do_rcv.tcp_v4_rcv
>       2.64            -0.1        2.51        perf-profile.calltrace.cycles-pp.__tcp_push_pending_frames.tcp_rcv_established.tcp_v4_do_rcv.tcp_v4_rcv.ip_local_deliver_finish
>       2.83            -0.1        2.73        perf-profile.calltrace.cycles-pp.__free_pages_ok.skb_release_data.__kfree_skb.tcp_recvmsg.inet_recvmsg
>       3.64            -0.1        3.54        perf-profile.calltrace.cycles-pp.__kfree_skb.tcp_recvmsg.inet_recvmsg.__sys_recvfrom.__x64_sys_recvfrom
>       3.27            -0.1        3.18        perf-profile.calltrace.cycles-pp.skb_release_data.__kfree_skb.tcp_recvmsg.inet_recvmsg.__sys_recvfrom
>      98.03            +0.1       98.11        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
>      97.89            +0.1       97.96        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       0.44 ± 58%      +0.3        0.71 ±  5%  perf-profile.calltrace.cycles-pp.smp_apic_timer_interrupt.apic_timer_interrupt.copy_user_enhanced_fast_string.copyout.copy_page_to_iter
>       2.92 ±  6%      +0.4        3.29 ±  4%  perf-profile.calltrace.cycles-pp.apic_timer_interrupt.copy_user_enhanced_fast_string.copyout.copy_page_to_iter.skb_copy_datagram_iter
>       0.00            +0.5        0.55 ±  6%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.smp_apic_timer_interrupt.apic_timer_interrupt.copy_user_enhanced_fast_string.copyout
>       3.64            -0.1        3.52        perf-profile.children.cycles-pp.tcp_write_xmit
>       3.60            -0.1        3.48        perf-profile.children.cycles-pp.__tcp_push_pending_frames
>       2.84            -0.1        2.74        perf-profile.children.cycles-pp.__free_pages_ok
>       4.08            -0.1        4.00        perf-profile.children.cycles-pp.__kfree_skb
>       0.80 ±  2%      -0.1        0.74 ±  3%  perf-profile.children.cycles-pp.__entry_SYSCALL_64_trampoline
>       0.23 ±  4%      -0.0        0.20 ±  5%  perf-profile.children.cycles-pp.__sk_mem_schedule
>       0.22 ±  4%      -0.0        0.19 ±  5%  perf-profile.children.cycles-pp.__sk_mem_raise_allocated
>       0.06            -0.0        0.04 ± 57%  perf-profile.children.cycles-pp.tcp_release_cb
>       0.08 ±  6%      -0.0        0.06 ± 15%  perf-profile.children.cycles-pp.__tcp_select_window
>       0.23            +0.0        0.24 ±  2%  perf-profile.children.cycles-pp.__tcp_send_ack
>       0.06 ± 11%      +0.0        0.08 ±  5%  perf-profile.children.cycles-pp.___perf_sw_event
>       0.06 ± 14%      +0.0        0.09 ± 13%  perf-profile.children.cycles-pp.tcp_write_timer_handler
>       0.12 ±  7%      +0.0        0.15 ±  5%  perf-profile.children.cycles-pp.update_curr
>       0.06 ± 11%      +0.0        0.09 ± 17%  perf-profile.children.cycles-pp.call_timer_fn
>       0.17 ±  4%      +0.0        0.20 ±  3%  perf-profile.children.cycles-pp.___slab_alloc
>       0.18 ±  4%      +0.0        0.21 ±  3%  perf-profile.children.cycles-pp.__slab_alloc
>       0.05 ± 58%      +0.0        0.08 ± 15%  perf-profile.children.cycles-pp.tcp_write_timer
>       0.04 ± 58%      +0.0        0.08 ± 16%  perf-profile.children.cycles-pp.tcp_send_loss_probe
>       0.32 ±  3%      +0.0        0.35        perf-profile.children.cycles-pp.kmem_cache_alloc_node
>       0.14 ±  7%      +0.0        0.19 ± 16%  perf-profile.children.cycles-pp.preempt_schedule_common
>       0.21 ± 12%      +0.1        0.27 ±  6%  perf-profile.children.cycles-pp.task_tick_fair
>       0.00            +0.1        0.06 ± 11%  perf-profile.children.cycles-pp.__tcp_retransmit_skb
>       0.51 ±  3%      +0.1        0.57 ±  6%  perf-profile.children.cycles-pp.__sched_text_start
>       1.61            +0.1        1.68 ±  2%  perf-profile.children.cycles-pp.__release_sock
>       1.06 ±  3%      +0.1        1.14 ±  2%  perf-profile.children.cycles-pp.tcp_ack
>       0.28 ±  9%      +0.1        0.36 ±  4%  perf-profile.children.cycles-pp.scheduler_tick
>      98.09            +0.1       98.18        perf-profile.children.cycles-pp.do_syscall_64
>      98.23            +0.1       98.32        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
>       0.49 ±  8%      +0.1        0.58 ±  5%  perf-profile.children.cycles-pp.update_process_times
>       0.50 ±  8%      +0.1        0.61 ±  6%  perf-profile.children.cycles-pp.tick_sched_handle
>       0.54 ±  9%      +0.1        0.67 ±  5%  perf-profile.children.cycles-pp.tick_sched_timer
>       0.79 ±  8%      +0.1        0.93 ±  3%  perf-profile.children.cycles-pp.__hrtimer_run_queues
>       0.93 ±  9%      +0.2        1.09 ±  2%  perf-profile.children.cycles-pp.hrtimer_interrupt
>       1.13 ± 10%      +0.2        1.37 ±  4%  perf-profile.children.cycles-pp.smp_apic_timer_interrupt
>       2.51 ±  6%      +0.4        2.87 ±  3%  perf-profile.children.cycles-pp.apic_timer_interrupt
>      70.21            +0.4       70.63        perf-profile.children.cycles-pp.copy_user_enhanced_fast_string
>       1.61            -0.1        1.49 ±  2%  perf-profile.self.cycles-pp.copy_page_to_iter
>       0.78 ±  2%      -0.1        0.72 ±  3%  perf-profile.self.cycles-pp.__entry_SYSCALL_64_trampoline
>       1.37            -0.1        1.32        perf-profile.self.cycles-pp.__free_pages_ok
>       0.21 ±  5%      -0.0        0.18 ±  4%  perf-profile.self.cycles-pp.__sk_mem_raise_allocated
>       0.65 ±  2%      -0.0        0.62        perf-profile.self.cycles-pp.free_one_page
>       0.41 ±  2%      -0.0        0.39 ±  4%  perf-profile.self.cycles-pp.skb_copy_datagram_iter
>       0.08 ±  6%      -0.0        0.06 ± 15%  perf-profile.self.cycles-pp.__tcp_select_window
>       0.10 ±  5%      -0.0        0.08 ±  8%  perf-profile.self.cycles-pp.import_single_range
>       0.14 ±  5%      +0.0        0.16 ±  5%  perf-profile.self.cycles-pp.___slab_alloc
>       0.19 ±  3%      +0.0        0.21 ±  3%  perf-profile.self.cycles-pp.kmem_cache_alloc_node
>       0.15 ±  4%      +0.0        0.17 ±  4%  perf-profile.self.cycles-pp.__might_sleep
>       0.03 ±100%      +0.0        0.07 ± 13%  perf-profile.self.cycles-pp.___perf_sw_event
> 
> 
> 
> ***************************************************************************************************
> lkp-u410: 4 threads Intel(R) Core(TM) i5-3317U CPU @ 1.70GHz with 4G memory
> =========================================================================================
> cluster/compiler/cpufreq_governor/ip/kconfig/nr_threads/rootfs/runtime/tbox_group/test/testcase/ucode:
>   cs-localhost/gcc-7/performance/ipv4/x86_64-rhel-7.2/200%/debian-x86_64-2018-04-03.cgz/900s/lkp-u410/TCP_MAERTS/netperf/0x20
> 
> commit: 
>   3ff6cde846 ("hns3: Another build fix.")
>   a337531b94 ("tcp: up initial rmem to 128KB and SYN rwin to around 64KB")
> 
> 3ff6cde846857d45 a337531b942bd8a03e7052444d 
> ---------------- -------------------------- 
>        fail:runs  %reproduction    fail:runs
>            |             |             |    
>           4:4         -100%            :4     dmesg.RIP:intel_modeset_init[i915]
>           4:4         -100%            :4     dmesg.WARNING:at_drivers/gpu/drm/i915/intel_display.c:#intel_modeset_init[i915]
>           2:4           -3%           2:4     perf-profile.children.cycles-pp.schedule_timeout
>          %stddev     %change         %stddev
>              \          |                \  
>       3879            -3.2%       3753        netperf.Throughput_Mbps
>      31036            -3.2%      30030        netperf.Throughput_total_Mbps
>       2463            +3.6%       2552        netperf.time.maximum_resident_set_size
>       2499            +7.5%       2685        netperf.time.minor_page_faults
>      24.96           -14.8%      21.28 ±  8%  netperf.time.user_time
>     543040 ± 13%     -15.9%     456816 ±  2%  netperf.time.voluntary_context_switches
>  2.131e+08            -3.2%  2.062e+08        netperf.workload
>      21274            +3.3%      21986        interrupts.CAL:Function_call_interrupts
>     826.00 ±  6%     -27.1%     602.00 ± 23%  slabinfo.skbuff_head_cache.active_objs
>       3904 ±  2%      -4.5%       3728        vmstat.system.cs
>      56.50 ±  2%      +8.8%      61.50 ±  5%  turbostat.CoreTmp
>      56.75 ±  2%      +8.4%      61.50 ±  5%  turbostat.PkgTmp
>       4224 ±173%    +294.2%      16653 ± 52%  sched_debug.cfs_rq:/.spread0.avg
>     110.92 ±  8%     -22.2%      86.34 ± 10%  sched_debug.cfs_rq:/.util_avg.stddev
>     896147 ±  3%     -11.3%     795033 ±  4%  sched_debug.cpu.avg_idle.max
>     162406 ±  9%     -26.1%     119960 ± 21%  sched_debug.cpu.avg_idle.stddev
>      59886 ±  3%      -3.8%      57590        proc-vmstat.nr_dirty_background_threshold
>     119920 ±  3%      -3.8%     115322        proc-vmstat.nr_dirty_threshold
>     628429 ±  3%      -3.7%     605425        proc-vmstat.nr_free_pages
>  1.071e+08            -3.2%  1.036e+08        proc-vmstat.numa_hit
>  1.071e+08            -3.2%  1.036e+08        proc-vmstat.numa_local
>  8.503e+08            -3.2%  8.229e+08        proc-vmstat.pgfree
>  2.265e+11            -5.7%  2.135e+11        perf-stat.branch-instructions
>       3.01            -0.1        2.94        perf-stat.branch-miss-rate%
>  6.809e+09            -7.8%  6.279e+09 ±  3%  perf-stat.branch-misses
>      30.13            +2.0       32.13        perf-stat.cache-miss-rate%
>  5.149e+10            +3.2%  5.314e+10        perf-stat.cache-misses
>  1.709e+11            -3.2%  1.654e+11        perf-stat.cache-references
>    3532029 ±  2%      -4.5%    3373137        perf-stat.context-switches
>       7.31            +6.2%       7.76        perf-stat.cpi
>  5.633e+09 ±  2%      -5.8%  5.308e+09        perf-stat.dTLB-load-misses
>  7.264e+11            -4.1%  6.964e+11        perf-stat.dTLB-loads
>   6.35e+11            -4.0%  6.097e+11        perf-stat.dTLB-stores
>  4.029e+08            -7.1%  3.743e+08 ±  2%  perf-stat.iTLB-load-misses
>  1.157e+12            -5.7%  1.091e+12        perf-stat.instructions
>       0.14            -5.8%       0.13        perf-stat.ipc
>       5426            -2.5%       5289        perf-stat.path-length
>       1.16 ±  6%      -0.2        0.99 ±  3%  perf-profile.calltrace.cycles-pp.__entry_SYSCALL_64_trampoline
>       0.99 ±  6%      -0.1        0.88 ± 10%  perf-profile.calltrace.cycles-pp.tcp_v4_do_rcv.__release_sock.release_sock.tcp_recvmsg.inet_recvmsg
>      96.58            +0.3       96.87        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
>      26.12 ±  2%      +1.3       27.40        perf-profile.calltrace.cycles-pp.copy_user_enhanced_fast_string.copyin._copy_from_iter_full.tcp_sendmsg_locked.tcp_sendmsg
>      26.39 ±  2%      +1.3       27.69        perf-profile.calltrace.cycles-pp.copyin._copy_from_iter_full.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg
>      27.12 ±  3%      +1.4       28.48        perf-profile.calltrace.cycles-pp._copy_from_iter_full.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg.__sys_sendto
>      41.73 ±  2%      +1.7       43.40 ±  2%  perf-profile.calltrace.cycles-pp.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg.__sys_sendto.__x64_sys_sendto
>      43.17 ±  2%      +1.7       44.87 ±  2%  perf-profile.calltrace.cycles-pp.tcp_sendmsg.sock_sendmsg.__sys_sendto.__x64_sys_sendto.do_syscall_64
>      43.75 ±  2%      +1.8       45.51        perf-profile.calltrace.cycles-pp.sock_sendmsg.__sys_sendto.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      44.88 ±  2%      +1.8       46.63        perf-profile.calltrace.cycles-pp.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      44.73 ±  2%      +1.8       46.53        perf-profile.calltrace.cycles-pp.__sys_sendto.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       1.38 ±  6%      -0.2        1.20 ±  3%  perf-profile.children.cycles-pp.__entry_SYSCALL_64_trampoline
>       0.42 ±  9%      -0.1        0.31 ±  9%  perf-profile.children.cycles-pp.tcp_queue_rcv
>       0.79 ±  6%      -0.1        0.68 ±  5%  perf-profile.children.cycles-pp.ktime_get_with_offset
>       0.32 ± 12%      -0.1        0.21 ± 33%  perf-profile.children.cycles-pp.scheduler_tick
>       0.35 ± 12%      -0.1        0.26 ± 11%  perf-profile.children.cycles-pp.tcp_try_coalesce
>       0.29 ± 10%      -0.1        0.20 ± 17%  perf-profile.children.cycles-pp.skb_try_coalesce
>       0.88 ±  2%      -0.1        0.79 ±  4%  perf-profile.children.cycles-pp.tcp_mstamp_refresh
>       0.32 ±  9%      -0.1        0.26 ± 18%  perf-profile.children.cycles-pp.ip_local_out
>       0.41 ±  3%      +0.0        0.45 ±  4%  perf-profile.children.cycles-pp.selinux_ip_postroute
>       0.03 ±102%      +0.1        0.09 ± 24%  perf-profile.children.cycles-pp.lock_timer_base
>       0.00            +0.1        0.08 ± 29%  perf-profile.children.cycles-pp.raw_local_deliver
>       0.57 ±  4%      +0.1        0.66 ±  7%  perf-profile.children.cycles-pp.tcp_event_new_data_sent
>       0.20 ± 28%      +0.1        0.29 ± 21%  perf-profile.children.cycles-pp._cond_resched
>      64.27            +0.5       64.78        perf-profile.children.cycles-pp.copy_user_enhanced_fast_string
>      26.41 ±  2%      +1.3       27.70        perf-profile.children.cycles-pp.copyin
>      27.16 ±  3%      +1.3       28.50        perf-profile.children.cycles-pp._copy_from_iter_full
>      41.76 ±  2%      +1.7       43.44 ±  2%  perf-profile.children.cycles-pp.tcp_sendmsg_locked
>      43.19 ±  2%      +1.7       44.88 ±  2%  perf-profile.children.cycles-pp.tcp_sendmsg
>      44.88 ±  2%      +1.8       46.65        perf-profile.children.cycles-pp.__x64_sys_sendto
>      43.75 ±  2%      +1.8       45.51        perf-profile.children.cycles-pp.sock_sendmsg
>      44.74 ±  2%      +1.8       46.54        perf-profile.children.cycles-pp.__sys_sendto
>       1.21 ±  8%      -0.2        0.99 ±  5%  perf-profile.self.cycles-pp.copy_page_to_iter
>       1.32 ±  6%      -0.2        1.15 ±  3%  perf-profile.self.cycles-pp.__entry_SYSCALL_64_trampoline
>       0.29 ±  9%      -0.1        0.20 ± 18%  perf-profile.self.cycles-pp.skb_try_coalesce
>       0.50 ±  9%      -0.1        0.42 ± 10%  perf-profile.self.cycles-pp.ktime_get_with_offset
>       0.19 ± 14%      -0.1        0.12 ± 10%  perf-profile.self.cycles-pp.__local_bh_enable_ip
>       0.08 ± 10%      -0.0        0.03 ±102%  perf-profile.self.cycles-pp.selinux_sock_rcv_skb_compat
>       0.13 ±  3%      -0.0        0.08 ± 57%  perf-profile.self.cycles-pp.__x64_sys_sendto
>       0.07 ± 12%      -0.0        0.03 ±100%  perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
>       0.11 ± 11%      -0.0        0.08 ± 22%  perf-profile.self.cycles-pp.__sys_recvfrom
>       0.05 ± 61%      +0.0        0.09 ± 11%  perf-profile.self.cycles-pp.selinux_ip_postroute
>       0.09 ± 20%      +0.1        0.15 ± 31%  perf-profile.self.cycles-pp.rcu_all_qs
>       0.00            +0.1        0.07 ± 28%  perf-profile.self.cycles-pp.raw_local_deliver
> 
> 
> 
> 
> 
> Disclaimer:
> Results have been estimated based on internal Intel analysis and are provided
> for informational purposes only. Any difference in system hardware or software
> design or configuration may affect actual performance.
> 
> 
> Thanks,
> Rong Chen
> 
_______________________________________________
LKP mailing list
LKP@lists.01.org
https://lists.01.org/mailman/listinfo/lkp
