Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E62C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 00:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6744225752
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 00:42:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6744225752
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752305AbeF1AmQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 20:42:16 -0400
Received: from mga03.intel.com ([134.134.136.65]:30831 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752235AbeF1AmP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 20:42:15 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jun 2018 17:42:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,281,1526367600"; 
   d="scan'208";a="241236976"
Received: from yexl-desktop.sh.intel.com (HELO localhost) ([10.239.159.124])
  by fmsmga006.fm.intel.com with ESMTP; 27 Jun 2018 17:42:12 -0700
Date:   Thu, 28 Jun 2018 08:38:34 +0800
From:   Ye Xiaolong <xiaolong.ye@intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>, lkp@01.org,
        viro@zeniv.linux.org.uk
Subject: Re: [lkp-robot] [fs]  3deb642f0d:  will-it-scale.per_process_ops
 -8.8% regression
Message-ID: <20180628003834.GH18756@yexl-desktop>
References: <20180622082752.GX11011@yexl-desktop>
 <20180622150251.GA12802@lst.de>
 <20180626060338.GU12146@yexl-desktop>
 <20180627070745.GA9765@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180627070745.GA9765@lst.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/27, Christoph Hellwig wrote:
>On Tue, Jun 26, 2018 at 02:03:38PM +0800, Ye Xiaolong wrote:
>> Hi,
>> 
>> On 06/22, Christoph Hellwig wrote:
>> >Hi Xiaolong,
>> >
>> >can you retest this workload on the following branch:
>> >
>> >    git://git.infradead.org/users/hch/vfs.git remove-get-poll-head
>> >
>> >Gitweb:
>> >
>> >    http://git.infradead.org/users/hch/vfs.git/shortlog/refs/heads/remove-get-poll-head
>> 
>> Here is the comparison for commit 3deb642f0d and commit 8fbedc1 ("fs: replace f_ops->get_poll_head with a static ->f_poll_head pointer") in remove-get-poll-head branch.
>
>Especially the boot time ones and others look like they have additional
>changes.
>
>Can you compare the baseline of my tree, which is
>894b8c00 ("Merge tag 'for_v4.18-rc2' of
>git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs") against 8fbedc1
>(("fs: replace f_ops->get_poll_head with a static ->f_poll_head pointer") ?

Update the result:

testcase/path_params/tbox_group/run: will-it-scale/poll2-performance/lkp-sb03

894b8c000ae6c106  8fbedc19c94fd25a2b9b327015  
----------------  --------------------------  
         %stddev      change         %stddev
             \          |                \  
    404611 ±  4%         5%     424608        will-it-scale.per_process_ops
      1489 ± 21%        28%       1899 ± 18%  will-it-scale.time.voluntary_context_switches
  45828560                    46155690        will-it-scale.workload
      2337                        2342        will-it-scale.time.system_time
       806                         806        will-it-scale.time.percent_of_cpu_this_job_got
       310                         310        will-it-scale.time.elapsed_time
       310                         310        will-it-scale.time.elapsed_time.max
      4096                        4096        will-it-scale.time.page_size
    233917                      233862        will-it-scale.per_thread_ops
     17196                       17179        will-it-scale.time.minor_page_faults
      9901                        9862        will-it-scale.time.maximum_resident_set_size
     14705 ±  3%                 14397 ±  4%  will-it-scale.time.involuntary_context_switches
       167                         163        will-it-scale.time.user_time
      0.66 ± 25%       -17%       0.54        will-it-scale.scalability
    120508 ± 15%        -7%     112098 ±  5%  interrupts.CAL:Function_call_interrupts
      1670 ±  3%        10%       1845 ±  3%  vmstat.system.cs
     32707                       32635        vmstat.system.in
       121                         122        turbostat.CorWatt
       149                         150        turbostat.PkgWatt
      1573                        1573        turbostat.Avg_MHz
     17.54 ± 19%                 17.77 ± 19%  boot-time.kernel_boot
       824 ± 12%                   834 ± 12%  boot-time.idle
     27.45 ± 12%                 27.69 ± 12%  boot-time.boot
     16.96 ± 21%                 16.93 ± 21%  boot-time.dhcp
      1489 ± 21%        28%       1899 ± 18%  time.voluntary_context_switches
      2337                        2342        time.system_time
       806                         806        time.percent_of_cpu_this_job_got
       310                         310        time.elapsed_time
       310                         310        time.elapsed_time.max
      4096                        4096        time.page_size
     17196                       17179        time.minor_page_faults
      9901                        9862        time.maximum_resident_set_size
     14705 ±  3%                 14397 ±  4%  time.involuntary_context_switches
       167                         163        time.user_time
     18320               6%      19506 ±  8%  proc-vmstat.nr_slab_unreclaimable
      1518 ±  7%                  1558 ± 10%  proc-vmstat.numa_hint_faults
      1387 ±  8%                  1421 ±  9%  proc-vmstat.numa_hint_faults_local
      1873 ±  5%                  1917 ±  8%  proc-vmstat.numa_pte_updates
     19987                       20005        proc-vmstat.nr_anon_pages
      8464                        8471        proc-vmstat.nr_kernel_stack
    309815                      310062        proc-vmstat.nr_file_pages
     50828                       50828        proc-vmstat.nr_free_cma
  16065590                    16064831        proc-vmstat.nr_free_pages
   3194669                     3194517        proc-vmstat.nr_dirty_threshold
   1595384                     1595308        proc-vmstat.nr_dirty_background_threshold
    798886                      797937        proc-vmstat.pgfault
      6510                        6499        proc-vmstat.nr_mapped
    659089                      657491        proc-vmstat.numa_local
    665458                      663786        proc-vmstat.numa_hit
      1037                        1033        proc-vmstat.nr_page_table_pages
    669923                      665906        proc-vmstat.pgfree
    676982                      672385        proc-vmstat.pgalloc_normal
      6368                        6294        proc-vmstat.numa_other
     13013              -7%      12152 ± 11%  proc-vmstat.nr_slab_reclaimable
  51213164 ± 18%        23%   63014695 ± 25%  perf-stat.node-loads
  22096136 ± 28%        20%   26619357 ± 35%  perf-stat.node-load-misses
 2.079e+08 ±  9%        12%  2.323e+08 ± 11%  perf-stat.cache-misses
    515039 ±  3%        10%     568299 ±  3%  perf-stat.context-switches
 3.283e+08 ± 22%        10%  3.622e+08 ±  5%  perf-stat.iTLB-loads

Thanks,
Xiaolong
