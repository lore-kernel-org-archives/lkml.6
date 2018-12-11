Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15CB6C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF9F42081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:05:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF9F42081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbeLKOFh convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 09:05:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:57018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726454AbeLKOFh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 09:05:37 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 032732081B;
        Tue, 11 Dec 2018 14:05:34 +0000 (UTC)
Date:   Tue, 11 Dec 2018 09:05:32 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>, lkp@01.org
Subject: Re: [LKP] [function_graph] 8114865ff8:  netperf.Throughput_tps
 -1.1% regression
Message-ID: <20181211090532.56284ee4@gandalf.local.home>
In-Reply-To: <20181211091631.GQ23332@shao2-debian>
References: <20181211091631.GQ23332@shao2-debian>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Dec 2018 17:16:31 +0800
kernel test robot <rong.a.chen@intel.com> wrote:

> Greeting,
> 
> FYI, we noticed a -1.1% regression of netperf.Throughput_tps due to commit:
> 
> 
> commit: 8114865ff82e200b383e46821c25cb0625b842b5 ("function_graph: Create function_graph_enter() to consolidate architecture code")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

This must be a false positive, as the commit in question simply adds a
function that nothing calls.

-- Steve

> 
> in testcase: netperf
> on test machine: 8 threads Intel(R) Core(TM) i7-4770 CPU @ 3.40GHz with 8G memory
> with following parameters:
> 
> 	ip: ipv4
> 	runtime: 300s
> 	nr_threads: 200%
> 	cluster: cs-localhost
> 	test: TCP_CRR
> 	ucode: 0x25
> 	cpufreq_governor: performance
> 
> test-description: Netperf is a benchmark that can be use to measure various aspect of networking performance.
> test-url: http://www.netperf.org/netperf/
> 
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
>   cs-localhost/gcc-7/performance/ipv4/x86_64-rhel-7.2/200%/debian-x86_64-2018-04-03.cgz/300s/lkp-hsw-d01/TCP_CRR/netperf/0x25
> 
> commit: 
>   v4.20-rc3
>   8114865ff8 ("function_graph: Create function_graph_enter() to consolidate architecture code")
> 
>        v4.20-rc3 8114865ff82e200b383e46821c 
> ---------------- -------------------------- 
>        fail:runs  %reproduction    fail:runs
>            |             |             |    
>           2:5          -40%            :4     dmesg.WARNING:at#for_ip_swapgs_restore_regs_and_return_to_usermode/0x
>           2:5          -40%            :4     dmesg.WARNING:stack_recursion
>            :5           20%           1:4     kmsg.drm:drm_atomic_helper_wait_for_dependencies[drm_kms_helper]]*ERROR*[CONNECTOR:#:VGA-#]flip_done_timed_out
>            :5           20%           1:4     kmsg.drm:drm_atomic_helper_wait_for_dependencies[drm_kms_helper]]*ERROR*[CRTC:#:pipe_A]flip_done_timed_out
>            :5           20%           1:4     kmsg.drm:drm_atomic_helper_wait_for_dependencies[drm_kms_helper]]*ERROR*[PLANE:#:primary_A]flip_done_timed_out
>            :5           20%           1:4     kmsg.drm:drm_atomic_helper_wait_for_flip_done[drm_kms_helper]]*ERROR*[CRTC:#:pipe_A]flip_done_timed_out
>           1:5          -10%           1:4     perf-profile.calltrace.cycles-pp.dequeue_entity.dequeue_task_fair.__sched_text_start.schedule.schedule_timeout
>          26:5          -93%          21:4     perf-profile.children.cycles-pp.schedule_timeout
>           0:5           -1%           0:4     perf-profile.self.cycles-pp.schedule_timeout
>          %stddev     %change         %stddev
>              \          |                \  
>     131277            -1.1%     129833        netperf.Throughput_total_tps
>       8204            -1.1%       8114        netperf.Throughput_tps
>     104.96            -1.6%     103.25        netperf.time.user_time
>   39321448            -1.1%   38880992        netperf.time.voluntary_context_switches
>   39383220            -1.1%   38949992        netperf.workload
>     327.02          -100.0%       0.00        uptime.boot
>     179.66 ±  8%    -100.0%       0.00        uptime.idle
>       4174 ± 10%     +12.4%       4692 ± 12%  slabinfo.anon_vma.active_objs
>       4174 ± 10%     +12.4%       4692 ± 12%  slabinfo.anon_vma.num_objs
>      39.00          +229.5%     128.50 ± 27%  slabinfo.buffer_head.active_objs
>      39.00          +229.5%     128.50 ± 27%  slabinfo.buffer_head.num_objs
>       0.43 ±  9%     -19.6%       0.34 ± 13%  sched_debug.cfs_rq:/.nr_running.stddev
>      12140 ±114%    +330.4%      52248 ± 73%  sched_debug.cpu.avg_idle.min
>       0.88 ±  8%     +24.1%       1.09 ±  4%  sched_debug.cpu.clock.stddev
>       0.88 ±  8%     +24.1%       1.09 ±  4%  sched_debug.cpu.clock_task.stddev
>     163.75 ±  2%      +6.7%     174.67 ±  4%  sched_debug.cpu.cpu_load[0].avg
>     238.17 ±  3%     +24.7%     296.96 ± 17%  sched_debug.cpu.cpu_load[0].max
>     215.03 ±  2%     +16.7%     251.04 ±  8%  sched_debug.cpu.cpu_load[1].max
>      20.65 ± 12%     +19.2%      24.61 ±  7%  sched_debug.cpu.cpu_load[2].stddev
>      62804            +2.0%      64053        proc-vmstat.nr_active_anon
>       1.00        +10950.0%     110.50 ± 73%  proc-vmstat.nr_active_file
>      61258            +2.0%      62489        proc-vmstat.nr_anon_pages
>      23.00          +303.3%      92.75 ± 38%  proc-vmstat.nr_inactive_file
>       3854            +8.2%       4170        proc-vmstat.nr_kernel_stack
>       9474            +2.0%       9666        proc-vmstat.nr_slab_reclaimable
>       8753            +2.7%       8988        proc-vmstat.nr_slab_unreclaimable
>      62807            +2.0%      64055        proc-vmstat.nr_zone_active_anon
>       1.00        +10950.0%     110.50 ± 73%  proc-vmstat.nr_zone_active_file
>      23.00          +303.3%      92.75 ± 38%  proc-vmstat.nr_zone_inactive_file
>     461366            +4.9%     483771 ±  2%  proc-vmstat.numa_hit
>     461366            +4.9%     483771 ±  2%  proc-vmstat.numa_local
>  8.459e+11            -1.3%  8.347e+11        perf-stat.branch-instructions
>   81655384            -1.1%   80758043        perf-stat.context-switches
>       2.04            +1.3%       2.07        perf-stat.cpi
>      56426 ±  3%      -8.7%      51533 ±  5%  perf-stat.cpu-migrations
>       0.10 ±  2%      +0.0        0.10 ±  3%  perf-stat.dTLB-store-miss-rate%
>  8.433e+11            -1.1%  8.337e+11        perf-stat.dTLB-stores
>      75.15            +1.9       77.05        perf-stat.iTLB-load-miss-rate%
>  8.967e+08           -10.2%  8.056e+08        perf-stat.iTLB-loads
>  4.324e+12            -1.3%  4.267e+12        perf-stat.instructions
>       0.49            -1.2%       0.48        perf-stat.ipc
>     390422            +0.8%     393664        perf-stat.minor-faults
>   17227761 ±  3%     +15.0%   19812916 ±  2%  perf-stat.node-stores
>     390422            +0.8%     393654        perf-stat.page-faults
>       1.74 ± 15%      -0.3        1.43 ±  2%  perf-profile.calltrace.cycles-pp.security_sock_rcv_skb.sk_filter_trim_cap.tcp_filter.tcp_v4_rcv.ip_local_deliver_finish
>       1.53 ±  6%      -0.2        1.35 ±  2%  perf-profile.calltrace.cycles-pp.selinux_socket_sock_rcv_skb.security_sock_rcv_skb.sk_filter_trim_cap.tcp_filter.tcp_v4_rcv
>       1.06 ±  3%      -0.1        0.99 ±  2%  perf-profile.calltrace.cycles-pp.tcp_send_fin.tcp_close.inet_release.__sock_release.sock_close
>       2.24            +0.1        2.30        perf-profile.calltrace.cycles-pp.tcp_rcv_established.tcp_v4_do_rcv.__release_sock.release_sock.tcp_sendmsg
>       0.88 ±  2%      +0.1        0.95 ±  5%  perf-profile.calltrace.cycles-pp.__ip_queue_xmit.__tcp_transmit_skb.tcp_fin.tcp_data_queue.tcp_rcv_state_process
>       1.08 ±  2%      +0.1        1.17 ±  4%  perf-profile.calltrace.cycles-pp.__tcp_transmit_skb.tcp_fin.tcp_data_queue.tcp_rcv_state_process.tcp_v4_do_rcv
>       2.54            +0.1        2.65        perf-profile.calltrace.cycles-pp.__release_sock.release_sock.tcp_sendmsg.sock_sendmsg.__sys_sendto
>       2.68 ±  2%      +0.1        2.80        perf-profile.calltrace.cycles-pp.release_sock.tcp_sendmsg.sock_sendmsg.__sys_sendto.__x64_sys_sendto
>       3.03 ±  2%      +0.1        3.16        perf-profile.calltrace.cycles-pp.tcp_fin.tcp_data_queue.tcp_rcv_state_process.tcp_v4_do_rcv.tcp_v4_rcv
>       0.71 ±  7%      +0.1        0.84 ± 14%  perf-profile.calltrace.cycles-pp.ip_output.tcp_v4_send_synack.tcp_conn_request.tcp_rcv_state_process.tcp_v4_do_rcv
>       3.19 ±  2%      +0.2        3.36        perf-profile.calltrace.cycles-pp.tcp_data_queue.tcp_rcv_state_process.tcp_v4_do_rcv.tcp_v4_rcv.ip_local_deliver_finish
>       0.33 ± 82%      +0.3        0.63 ± 13%  perf-profile.calltrace.cycles-pp.ret_from_fork
>       0.33 ± 82%      +0.3        0.63 ± 13%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork
>      12.33            +0.4       12.77 ±  2%  perf-profile.calltrace.cycles-pp.tcp_v4_connect.__inet_stream_connect.inet_stream_connect.__sys_connect.__x64_sys_connect
>      30.28            +0.5       30.73        perf-profile.calltrace.cycles-pp.ip_local_deliver.ip_rcv.__netif_receive_skb_one_core.process_backlog.net_rx_action
>       7.34 ±  2%      +0.5        7.79 ±  2%  perf-profile.calltrace.cycles-pp.ip_output.__ip_queue_xmit.__tcp_transmit_skb.tcp_connect.tcp_v4_connect
>      32.67            +0.5       33.13        perf-profile.calltrace.cycles-pp.__netif_receive_skb_one_core.process_backlog.net_rx_action.__softirqentry_text_start.do_softirq_own_stack
>       7.21 ±  2%      +0.5        7.69 ±  3%  perf-profile.calltrace.cycles-pp.ip_finish_output2.ip_output.__ip_queue_xmit.__tcp_transmit_skb.tcp_connect
>       8.80 ±  2%      +0.5        9.28        perf-profile.calltrace.cycles-pp.tcp_rcv_state_process.tcp_v4_do_rcv.tcp_v4_rcv.ip_local_deliver_finish.ip_local_deliver
>      10.34            +0.5       10.88 ±  3%  perf-profile.calltrace.cycles-pp.tcp_connect.tcp_v4_connect.__inet_stream_connect.inet_stream_connect.__sys_connect
>      34.75            +0.5       35.30        perf-profile.calltrace.cycles-pp.__softirqentry_text_start.do_softirq_own_stack.do_softirq.__local_bh_enable_ip.ip_finish_output2
>      34.88            +0.6       35.43        perf-profile.calltrace.cycles-pp.do_softirq_own_stack.do_softirq.__local_bh_enable_ip.ip_finish_output2.ip_output
>      16.15            +0.6       16.70 ±  2%  perf-profile.calltrace.cycles-pp.tcp_v4_do_rcv.tcp_v4_rcv.ip_local_deliver_finish.ip_local_deliver.ip_rcv
>       8.86 ±  2%      +0.6        9.44 ±  2%  perf-profile.calltrace.cycles-pp.__tcp_transmit_skb.tcp_connect.tcp_v4_connect.__inet_stream_connect.inet_stream_connect
>      35.25            +0.6       35.84        perf-profile.calltrace.cycles-pp.do_softirq.__local_bh_enable_ip.ip_finish_output2.ip_output.__ip_queue_xmit
>      34.18            +0.6       34.78        perf-profile.calltrace.cycles-pp.net_rx_action.__softirqentry_text_start.do_softirq_own_stack.do_softirq.__local_bh_enable_ip
>       8.31 ±  2%      +0.6        8.92 ±  2%  perf-profile.calltrace.cycles-pp.__ip_queue_xmit.__tcp_transmit_skb.tcp_connect.tcp_v4_connect.__inet_stream_connect
>      35.35            +0.7       36.01        perf-profile.calltrace.cycles-pp.__local_bh_enable_ip.ip_finish_output2.ip_output.__ip_queue_xmit.__tcp_transmit_skb
>       2.33 ±  5%      -0.2        2.10        perf-profile.children.cycles-pp.security_sock_rcv_skb
>       2.21 ±  5%      -0.2        1.99        perf-profile.children.cycles-pp.selinux_socket_sock_rcv_skb
>       2.51 ±  5%      -0.2        2.30        perf-profile.children.cycles-pp.sk_filter_trim_cap
>       1.59 ±  6%      -0.2        1.42        perf-profile.children.cycles-pp.selinux_sock_rcv_skb_compat
>       1.91 ±  6%      -0.2        1.75        perf-profile.children.cycles-pp._raw_spin_lock
>       1.49 ±  4%      -0.1        1.36 ±  2%  perf-profile.children.cycles-pp.__kfree_skb
>       0.61 ±  9%      -0.1        0.50 ±  9%  perf-profile.children.cycles-pp.sock_def_wakeup
>       0.97 ±  3%      -0.1        0.88 ±  6%  perf-profile.children.cycles-pp.avc_has_perm
>       0.56 ±  6%      -0.1        0.47 ±  4%  perf-profile.children.cycles-pp.__x64_sys_close
>       0.37 ± 10%      -0.1        0.29 ± 12%  perf-profile.children.cycles-pp._copy_from_iter_full
>       0.62 ±  3%      -0.1        0.54 ±  3%  perf-profile.children.cycles-pp.__fget_light
>       0.26 ± 13%      -0.1        0.19 ±  9%  perf-profile.children.cycles-pp.security_file_alloc
>       0.42 ±  2%      -0.1        0.35 ± 13%  perf-profile.children.cycles-pp.copy_user_generic_unrolled
>       0.23 ± 11%      -0.1        0.16 ±  9%  perf-profile.children.cycles-pp.selinux_file_alloc_security
>       1.06 ±  3%      -0.1        1.00 ±  2%  perf-profile.children.cycles-pp.tcp_send_fin
>       0.11 ± 18%      -0.1        0.05 ± 58%  perf-profile.children.cycles-pp.sel_netnode_find
>       0.13 ± 16%      -0.1        0.07 ±  6%  perf-profile.children.cycles-pp.sel_netnode_sid
>       0.39 ±  6%      -0.1        0.34 ±  4%  perf-profile.children.cycles-pp.skb_release_data
>       0.34 ± 10%      -0.1        0.29 ± 11%  perf-profile.children.cycles-pp.filp_close
>       0.20 ±  5%      -0.0        0.15 ± 12%  perf-profile.children.cycles-pp.tcp_update_skb_after_send
>       0.36 ±  7%      -0.0        0.32 ±  5%  perf-profile.children.cycles-pp.__update_load_avg_se
>       0.12 ± 14%      -0.0        0.09 ± 16%  perf-profile.children.cycles-pp.__tcp_ack_snd_check
>       0.15 ± 14%      -0.0        0.11 ±  9%  perf-profile.children.cycles-pp.init_timer_key
>       0.15 ±  4%      -0.0        0.12 ± 10%  perf-profile.children.cycles-pp.remove_wait_queue
>       0.08 ± 17%      -0.0        0.06        perf-profile.children.cycles-pp.ip_build_and_send_pkt
>       0.15 ±  6%      +0.0        0.17 ±  3%  perf-profile.children.cycles-pp.__usecs_to_jiffies
>       0.04 ± 51%      +0.0        0.07 ±  6%  perf-profile.children.cycles-pp.find_exception
>       0.09 ± 11%      +0.0        0.11 ± 17%  perf-profile.children.cycles-pp.tcp_newly_delivered
>       0.09 ± 15%      +0.0        0.11 ±  7%  perf-profile.children.cycles-pp.xfrm_lookup_with_ifid
>       0.12 ± 15%      +0.0        0.15 ± 11%  perf-profile.children.cycles-pp.get_nohz_timer_target
>       0.17 ± 11%      +0.0        0.20 ± 11%  perf-profile.children.cycles-pp.tcp_md5_do_lookup
>       0.02 ±123%      +0.0        0.06 ± 16%  perf-profile.children.cycles-pp.security_sk_classify_flow
>       0.08 ± 21%      +0.0        0.11 ±  4%  perf-profile.children.cycles-pp._raw_spin_trylock
>       0.04 ± 83%      +0.0        0.08 ± 14%  perf-profile.children.cycles-pp.activate_task
>       0.05 ± 54%      +0.0        0.09 ± 24%  perf-profile.children.cycles-pp.tcp_urg
>       0.19 ±  8%      +0.0        0.23 ±  8%  perf-profile.children.cycles-pp.tcp_rearm_rto
>       0.01 ±200%      +0.0        0.06 ±  9%  perf-profile.children.cycles-pp.skb_free_head
>       0.10 ±  9%      +0.0        0.15 ±  8%  perf-profile.children.cycles-pp.xfrm_lookup_route
>       0.39 ±  5%      +0.1        0.44 ±  8%  perf-profile.children.cycles-pp.ip_rcv_core
>       0.14 ± 19%      +0.1        0.19 ± 22%  perf-profile.children.cycles-pp.__inet_lookup_listener
>       0.01 ±200%      +0.1        0.06 ± 20%  perf-profile.children.cycles-pp.blkcg_maybe_throttle_current
>       0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.ip_mc_drop_socket
>       0.58 ±  4%      +0.1        0.64 ±  3%  perf-profile.children.cycles-pp.sk_prot_alloc
>       0.60 ±  4%      +0.1        0.66 ±  4%  perf-profile.children.cycles-pp.__might_sleep
>       0.15 ± 25%      +0.1        0.21 ± 20%  perf-profile.children.cycles-pp.eth_type_trans
>       1.13 ±  2%      +0.1        1.21 ±  2%  perf-profile.children.cycles-pp.inet_csk_destroy_sock
>       0.78 ±  2%      +0.1        0.87 ±  8%  perf-profile.children.cycles-pp.tcp_mstamp_refresh
>       0.52 ±  8%      +0.1        0.63 ± 13%  perf-profile.children.cycles-pp.kthread
>       0.52 ±  8%      +0.1        0.64 ± 13%  perf-profile.children.cycles-pp.ret_from_fork
>       0.56 ± 11%      +0.1        0.68 ±  6%  perf-profile.children.cycles-pp.ip_finish_output
>       3.44            +0.1        3.57        perf-profile.children.cycles-pp.tcp_fin
>       4.81            +0.1        4.95        perf-profile.children.cycles-pp.tcp_data_queue
>      12.35            +0.4       12.78 ±  2%  perf-profile.children.cycles-pp.tcp_v4_connect
>      32.75            +0.5       33.20        perf-profile.children.cycles-pp.__netif_receive_skb_one_core
>      10.35            +0.5       10.89 ±  3%  perf-profile.children.cycles-pp.tcp_connect
>      34.90            +0.6       35.45        perf-profile.children.cycles-pp.do_softirq_own_stack
>      34.29            +0.6       34.86        perf-profile.children.cycles-pp.net_rx_action
>      45.59            +0.6       46.19        perf-profile.children.cycles-pp.__tcp_transmit_skb
>      35.37            +0.6       35.99        perf-profile.children.cycles-pp.__softirqentry_text_start
>      42.97            +0.7       43.69        perf-profile.children.cycles-pp.__ip_queue_xmit
>      35.89            +0.7       36.62        perf-profile.children.cycles-pp.__local_bh_enable_ip
>      41.33            +0.8       42.10        perf-profile.children.cycles-pp.ip_output
>      39.17            +0.8       39.94        perf-profile.children.cycles-pp.ip_finish_output2
>       0.88 ±  4%      -0.1        0.74 ±  3%  perf-profile.self.cycles-pp.tcp_write_xmit
>       0.61 ±  2%      -0.1        0.54 ±  3%  perf-profile.self.cycles-pp.__fget_light
>       0.23 ±  5%      -0.1        0.15 ± 18%  perf-profile.self.cycles-pp.tcp_v4_connect
>       0.93 ±  3%      -0.1        0.86 ±  6%  perf-profile.self.cycles-pp.avc_has_perm
>       0.41 ±  2%      -0.1        0.34 ± 12%  perf-profile.self.cycles-pp.copy_user_generic_unrolled
>       0.11 ± 18%      -0.1        0.05 ± 58%  perf-profile.self.cycles-pp.sel_netnode_find
>       0.39 ±  8%      -0.1        0.32 ±  6%  perf-profile.self.cycles-pp.selinux_ip_postroute
>       0.11 ± 24%      -0.1        0.05 ± 58%  perf-profile.self.cycles-pp.security_d_instantiate
>       0.16 ±  7%      -0.1        0.11 ± 13%  perf-profile.self.cycles-pp.tcp_send_fin
>       0.35 ±  6%      -0.1        0.30 ±  6%  perf-profile.self.cycles-pp.__update_load_avg_se
>       0.10 ± 15%      -0.0        0.06 ± 58%  perf-profile.self.cycles-pp.__x64_sys_close
>       0.07 ± 16%      -0.0        0.03 ±100%  perf-profile.self.cycles-pp.inet_release
>       0.35 ±  7%      -0.0        0.31 ±  2%  perf-profile.self.cycles-pp.tcp_parse_options
>       0.09 ± 15%      -0.0        0.05 ± 58%  perf-profile.self.cycles-pp.__sys_socket
>       0.13 ±  8%      -0.0        0.10 ± 17%  perf-profile.self.cycles-pp.sk_stream_alloc_skb
>       0.12 ± 13%      -0.0        0.08 ± 19%  perf-profile.self.cycles-pp.__tcp_ack_snd_check
>       0.14 ± 12%      -0.0        0.10 ± 12%  perf-profile.self.cycles-pp.skb_release_all
>       0.16 ± 10%      -0.0        0.13 ±  3%  perf-profile.self.cycles-pp.__inet_bind
>       0.18 ±  8%      -0.0        0.15 ±  5%  perf-profile.self.cycles-pp.sk_clone_lock
>       0.16 ±  5%      -0.0        0.14 ± 11%  perf-profile.self.cycles-pp.__wake_up_common
>       0.09 ±  8%      +0.0        0.11 ± 11%  perf-profile.self.cycles-pp.ip_local_out
>       0.08 ± 12%      +0.0        0.11 ±  9%  perf-profile.self.cycles-pp.xfrm_lookup_with_ifid
>       0.11 ±  8%      +0.0        0.14 ±  8%  perf-profile.self.cycles-pp.__usecs_to_jiffies
>       0.16 ± 10%      +0.0        0.19 ±  4%  perf-profile.self.cycles-pp.tcp_rearm_rto
>       0.07 ±  6%      +0.0        0.11 ± 14%  perf-profile.self.cycles-pp.__dentry_kill
>       0.24 ±  7%      +0.0        0.28 ±  6%  perf-profile.self.cycles-pp.tcp_ack_update_rtt
>       0.08 ± 12%      +0.0        0.11 ± 15%  perf-profile.self.cycles-pp.tcp_newly_delivered
>       0.14 ± 16%      +0.0        0.17 ± 13%  perf-profile.self.cycles-pp.skb_push
>       0.06 ± 54%      +0.0        0.10 ± 11%  perf-profile.self.cycles-pp._raw_spin_unlock_bh
>       0.08 ± 11%      +0.0        0.12 ± 17%  perf-profile.self.cycles-pp.tcp_init_transfer
>       0.07 ± 23%      +0.0        0.11 ±  4%  perf-profile.self.cycles-pp._raw_spin_trylock
>       0.14 ± 13%      +0.0        0.18 ±  9%  perf-profile.self.cycles-pp.account_entity_dequeue
>       0.01 ±200%      +0.0        0.06 ±  9%  perf-profile.self.cycles-pp.skb_free_head
>       0.38 ±  5%      +0.1        0.43 ±  7%  perf-profile.self.cycles-pp.ip_rcv_core
>       0.06 ± 12%      +0.1        0.11 ± 25%  perf-profile.self.cycles-pp.tcp_filter
>       0.14 ± 19%      +0.1        0.19 ± 22%  perf-profile.self.cycles-pp.__inet_lookup_listener
>       0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp.ip_mc_drop_socket
>       0.10 ± 26%      +0.1        0.15 ± 11%  perf-profile.self.cycles-pp.tcp_make_synack
>       0.03 ± 82%      +0.1        0.09 ± 24%  perf-profile.self.cycles-pp.tcp_urg
>       0.51 ±  6%      +0.1        0.57 ±  3%  perf-profile.self.cycles-pp.__might_sleep
>       0.14 ± 28%      +0.1        0.21 ± 20%  perf-profile.self.cycles-pp.eth_type_trans
>       0.54 ±  5%      +0.1        0.61 ±  4%  perf-profile.self.cycles-pp.__kmalloc_node_track_caller
>       0.44 ±  5%      +0.1        0.51 ±  4%  perf-profile.self.cycles-pp.enqueue_to_backlog
>       0.45 ± 10%      +0.1        0.53        perf-profile.self.cycles-pp.net_rx_action
>       0.28 ±  8%      +0.1        0.36 ±  6%  perf-profile.self.cycles-pp.ip_local_deliver_finish
>       0.70 ±  7%      +0.1        0.79 ±  6%  perf-profile.self.cycles-pp.__dev_queue_xmit
>       0.52 ±  4%      +0.1        0.64 ±  9%  perf-profile.self.cycles-pp.mod_timer
>       1.54 ±  3%      +0.1        1.67 ±  3%  perf-profile.self.cycles-pp.__tcp_transmit_skb
>       0.28 ±  5%      +0.1        0.41 ±  8%  perf-profile.self.cycles-pp.ip_finish_output
>       0.68 ±  5%      +0.1        0.83 ±  4%  perf-profile.self.cycles-pp.__local_bh_enable_ip
>       0.22 ± 10%      +0.3        0.49 ±  3%  perf-profile.self.cycles-pp.dev_hard_start_xmit
> 
> 
>                                                                                 
>                         netperf.time.voluntary_context_switches                 
>                                                                                 
>     4e+07 O-+O-O--O--O-O----O--O------------O--O--O-O--O--O-O--O-O--O-------+   
>           |                         O     O                                 |   
>   3.5e+07 +-+                                                               |   
>     3e+07 +-+                                                               |   
>           |                                                                 |   
>   2.5e+07 +-+                                                               |   
>           |                                                                 |   
>     2e+07 +-+                                                               |   
>           |                                                                 |   
>   1.5e+07 +-+                                                               |   
>     1e+07 +-+                                                               |   
>           |                                                                 |   
>     5e+06 +-+                                                               |   
>           |                                                                 |   
>         0 +-+-------------O-------O----O------------------------------------+   
>                                                                                 
>                                                                                 
> [*] bisect-good sample
> [O] bisect-bad  sample
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

