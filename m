Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA021C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 06:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78F2926538
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 06:07:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78F2926538
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751636AbeFZGHR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 02:07:17 -0400
Received: from mga06.intel.com ([134.134.136.31]:58286 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751112AbeFZGHQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 02:07:16 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jun 2018 23:07:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,273,1526367600"; 
   d="scan'208";a="67290861"
Received: from yexl-desktop.sh.intel.com (HELO localhost) ([10.239.159.124])
  by fmsmga001.fm.intel.com with ESMTP; 25 Jun 2018 23:07:13 -0700
Date:   Tue, 26 Jun 2018 14:03:38 +0800
From:   Ye Xiaolong <xiaolong.ye@intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>, lkp@01.org,
        viro@zeniv.linux.org.uk
Subject: Re: [lkp-robot] [fs]  3deb642f0d:  will-it-scale.per_process_ops
 -8.8% regression
Message-ID: <20180626060338.GU12146@yexl-desktop>
References: <20180622082752.GX11011@yexl-desktop>
 <20180622150251.GA12802@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180622150251.GA12802@lst.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 06/22, Christoph Hellwig wrote:
>Hi Xiaolong,
>
>can you retest this workload on the following branch:
>
>    git://git.infradead.org/users/hch/vfs.git remove-get-poll-head
>
>Gitweb:
>
>    http://git.infradead.org/users/hch/vfs.git/shortlog/refs/heads/remove-get-poll-head

Here is the comparison for commit 3deb642f0d and commit 8fbedc1 ("fs: replace f_ops->get_poll_head with a static ->f_poll_head pointer") in remove-get-poll-head branch.

3deb642f0de4c14f  8fbedc19c94fd25a2b9b327015  
----------------  --------------------------  
         %stddev      change         %stddev
             \          |                \  
    457120              -7%     424608        will-it-scale.per_process_ops
    238978                      233862        will-it-scale.per_thread_ops
      1755 ± 13%         8%       1899 ± 18%  will-it-scale.time.voluntary_context_switches
      2332                        2342        will-it-scale.time.system_time
       310                         310        will-it-scale.time.elapsed_time
       310                         310        will-it-scale.time.elapsed_time.max
      4096                        4096        will-it-scale.time.page_size
      0.54                        0.54        will-it-scale.scalability
       807                         806        will-it-scale.time.percent_of_cpu_this_job_got
     17218                       17179        will-it-scale.time.minor_page_faults
      9931                        9862        will-it-scale.time.maximum_resident_set_size
       173              -6%        163        will-it-scale.time.user_time
  49024375              -6%   46155690        will-it-scale.workload
     17818 ± 10%       -19%      14397 ±  4%  will-it-scale.time.involuntary_context_switches
    116842 ± 12%        -4%     112098 ±  5%  interrupts.CAL:Function_call_interrupts
     32735                       32635        vmstat.system.in
      2112 ±  7%       -13%       1845 ±  3%  vmstat.system.cs
       150                         150        turbostat.PkgWatt
       123                         122        turbostat.CorWatt
      1573                        1573        turbostat.Avg_MHz
     15.73              13%      17.77 ± 19%  boot-time.kernel_boot
     15.07              12%      16.93 ± 21%  boot-time.dhcp
       771               8%        834 ± 12%  boot-time.idle
     25.69               8%      27.69 ± 12%  boot-time.boot
      1755 ± 13%         8%       1899 ± 18%  time.voluntary_context_switches
      2332                        2342        time.system_time
       310                         310        time.elapsed_time
       310                         310        time.elapsed_time.max
      4096                        4096        time.page_size
       807                         806        time.percent_of_cpu_this_job_got
     17218                       17179        time.minor_page_faults
      9931                        9862        time.maximum_resident_set_size
       173              -6%        163        time.user_time
     17818 ± 10%       -19%      14397 ±  4%  time.involuntary_context_switches
    428813 ±  9%        57%     672385        proc-vmstat.pgalloc_normal
     41736 ± 15%        22%      50828        proc-vmstat.nr_free_cma
     18116               8%      19506 ±  8%  proc-vmstat.nr_slab_unreclaimable
      1029                        1033        proc-vmstat.nr_page_table_pages
      8453                        8471        proc-vmstat.nr_kernel_stack
      6486                        6499        proc-vmstat.nr_mapped
   3193607                     3194517        proc-vmstat.nr_dirty_threshold
   1594853                     1595308        proc-vmstat.nr_dirty_background_threshold
  16061877                    16064831        proc-vmstat.nr_free_pages
     20009                       20005        proc-vmstat.nr_anon_pages
      6303                        6294        proc-vmstat.numa_other
    799772                      797937        proc-vmstat.pgfault
    667803                      665906        proc-vmstat.pgfree
    666440                      663786        proc-vmstat.numa_hit
    660136                      657491        proc-vmstat.numa_local
    313125                      310062        proc-vmstat.nr_file_pages
      1941 ±  5%                  1917 ±  8%  proc-vmstat.numa_pte_updates
      1448 ±  7%                  1421 ±  9%  proc-vmstat.numa_hint_faults_local
      1596 ±  6%                  1558 ± 10%  proc-vmstat.numa_hint_faults
     12893              -6%      12152 ± 11%  proc-vmstat.nr_slab_reclaimable
     22885            -100%          0        proc-vmstat.nr_indirectly_reclaimable
    245443 ± 16%      -100%          0        proc-vmstat.pgalloc_movable
  19861107 ± 14%        34%   26619357 ± 35%  perf-stat.node-load-misses
  51734389 ±  5%        22%   63014695 ± 25%  perf-stat.node-loads
 1.924e+09 ±  3%        21%   2.32e+09 ±  5%  perf-stat.iTLB-load-misses
 2.342e+09 ±  8%        15%  2.695e+09 ±  4%  perf-stat.cache-references
 3.251e+08 ±  7%        11%  3.622e+08 ±  5%  perf-stat.iTLB-loads
 2.106e+08 ±  4%        10%  2.323e+08 ± 11%  perf-stat.cache-misses
      0.74               7%       0.79        perf-stat.cpi
 1.605e+08 ±  7%         6%  1.703e+08 ±  6%  perf-stat.node-stores
  50804799 ± 16%         5%   53535896 ± 18%  perf-stat.node-store-misses
     27.63 ±  8%         5%      29.07 ±  8%  perf-stat.node-load-miss-rate%
     85.55                       86.49        perf-stat.iTLB-load-miss-rate%
      0.25                        0.25        perf-stat.branch-miss-rate%
    778741                      776946        perf-stat.minor-faults
    778753                      776948        perf-stat.page-faults
     23.93 ±  9%                 23.75 ± 12%  perf-stat.node-store-miss-rate%
      9117 ±  4%                  8969 ±  4%  perf-stat.cpu-migrations
  1.59e+13              -4%  1.533e+13        perf-stat.cpu-cycles
    439328 ±  3%        -5%     419250 ±  5%  perf-stat.path-length
      9.05 ±  8%        -5%       8.62 ±  9%  perf-stat.cache-miss-rate%
      0.44 ± 39%        -6%       0.42 ± 31%  perf-stat.dTLB-load-miss-rate%
      1.35              -7%       1.26        perf-stat.ipc
 3.294e+12 ±  3%        -9%  2.988e+12 ±  3%  perf-stat.dTLB-stores
 5.451e+12 ±  4%       -10%  4.905e+12 ±  4%  perf-stat.dTLB-loads
 4.667e+12 ±  3%       -10%  4.195e+12 ±  4%  perf-stat.branch-instructions
 2.154e+13 ±  3%       -10%  1.935e+13 ±  4%  perf-stat.instructions
 1.161e+10 ±  4%       -10%  1.043e+10 ±  5%  perf-stat.branch-misses
 2.401e+10 ± 34%       -13%  2.093e+10 ± 36%  perf-stat.dTLB-load-misses
    653927 ±  8%       -13%     568299 ±  3%  perf-stat.context-switches
     11203 ±  4%       -26%       8344        perf-stat.instructions-per-iTLB-miss
      0.02 ± 41%       -50%       0.01 ± 47%  perf-stat.dTLB-store-miss-rate%
 7.557e+08 ± 37%       -53%  3.521e+08 ± 49%  perf-stat.dTLB-store-misses

Thanks,
Xiaolong
