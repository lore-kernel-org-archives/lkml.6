Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB2DCC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 12:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 559DE20673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 12:35:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=contabo.de header.i=@contabo.de header.b="4s4CtT2i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 559DE20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=contabo.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730280AbeGZNwB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 09:52:01 -0400
Received: from mail.contabo.com ([91.205.175.50]:33778 "EHLO mail.contabo.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729479AbeGZNwB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 09:52:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=contabo.de;
         s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version
        :Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=dFowpv6DW/o5f/pDxdU6SX2cFtfP/608JibRv/6upyQ=; b=4s4CtT2isJF6tmBfq3+a8XJSOM
        F4V3uygxRtWacXpr/A1rRt9nCVfTg4BjVfYtq2bnHLpl4hWcmCmobYrUfe9lZ5gcOV4jT0g9SbNwY
        +2c+QBISa34fGtyWlIGj3FZhPTKA6RItivKMmJ/sgrEyDYtgEeeccCaAenNczzSi3Naed54HKqtXN
        S9EQrHl6r8sw4gEKWfGQGTrM3l7Z6zwhh1JTwECJoIH9Sn/Sg7d/ejT9ZUiH3cg1WW5u+ClXZaCVY
        AloPRNDTOHmN4KMUWqTHdJ2RuklK9udixTaVZEwUmovcxlrOasZlub0VPqmyPjRiYljtcwzMYLTLd
        rhDMH/zw==;
Received: from [178.238.239.246] (port=10396 helo=[192.168.178.123])
        by mail.contabo.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <tino.lehnig@contabo.de>)
        id 1fifUB-00061Y-1I; Thu, 26 Jul 2018 14:35:15 +0200
Subject: Re: Zram writeback feature unstable with heavy swap utilization -
 BUG: Bad page state in process...
To:     Minchan Kim <minchan@kernel.org>
Cc:     ngupta@vflare.org, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <0516ae2d-b0fd-92c5-aa92-112ba7bd32fc@contabo.de>
 <20180724010342.GA195675@rodete-desktop-imager.corp.google.com>
 <d4f4b5a1-9e31-375d-0599-b6d8b0ebc9df@contabo.de>
 <20180725132126.GA2893@rodete-laptop-imager.corp.google.com>
 <d07348bb-3102-30f0-d138-de23449e23df@contabo.de>
 <20180726020351.GA221405@rodete-desktop-imager.corp.google.com>
 <1684cefc-c920-d53c-8d2d-c32da213a045@contabo.de>
 <15e3a0af-7e02-83fb-4b72-b05f6d7ded71@contabo.de>
 <20180726103001.GC221405@rodete-desktop-imager.corp.google.com>
From:   Tino Lehnig <tino.lehnig@contabo.de>
Message-ID: <b914205b-f3eb-7c0e-cd60-88c34341f84a@contabo.de>
Date:   Thu, 26 Jul 2018 14:35:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180726103001.GC221405@rodete-desktop-imager.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - mail.contabo.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - contabo.de
X-Get-Message-Sender-Via: mail.contabo.com: authenticated_id: tino.lehnig@contabo.de
X-Authenticated-Sender: mail.contabo.com: tino.lehnig@contabo.de
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/26/2018 12:30 PM, Minchan Kim wrote:
> Huh, you see it without writeback? It's weird. Without writeback feature,
> zram operaion is always synchronous on memory compression/decompression
> so you shouldn't see below io_schedule logic which happens only for
> asynchronous IO operation.
> Could you check one more time that it happens without writeback?

Confirmed. More kernel logs below. backing_dev was not set in this run. 
This does not happen with 4.15-rc9 and newer.

> So, you mean you couldn't se bad page state bug until 4.15-rc8?
> You just see below hung message until 4.15-rc8, not bad page bug?
> 

I did see the bad page state bug first in 4.15-rc2, but only very 
rarely. I have attached the log below the other one. Most test runs from 
commit 0bcac06f27d75 through 4.15-rc8 just resulted in hung task errors.

--

[  363.116153] INFO: task kworker/0:1:130 blocked for more than 120 seconds.
[  363.116237]       Not tainted 4.15.0-rc8-zram #22
[  363.116311] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[  363.116392] kworker/0:1     D    0   130      2 0x80000000
[  363.116405] Workqueue: events async_pf_execute
[  363.116407] Call Trace:
[  363.116416]  ? __schedule+0x3d0/0x850
[  363.116419]  schedule+0x32/0x80
[  363.116426]  io_schedule+0x12/0x40
[  363.116433]  __lock_page_or_retry+0x302/0x320
[  363.116437]  ? page_cache_tree_insert+0xb0/0xb0
[  363.116442]  do_swap_page+0x4dd/0x870
[  363.116446]  __handle_mm_fault+0x790/0x10c0
[  363.116450]  handle_mm_fault+0xc6/0x1b0
[  363.116453]  __get_user_pages+0xf9/0x620
[  363.116457]  get_user_pages_remote+0x137/0x1f0
[  363.116462]  async_pf_execute+0x62/0x180
[  363.116469]  process_one_work+0x189/0x380
[  363.116474]  worker_thread+0x4d/0x3c0
[  363.116478]  kthread+0xf8/0x130
[  363.116482]  ? process_one_work+0x380/0x380
[  363.116486]  ? kthread_create_worker_on_cpu+0x50/0x50
[  363.116492]  ret_from_fork+0x32/0x40
[  363.116498] INFO: task kswapd0:159 blocked for more than 120 seconds.
[  363.116576]       Not tainted 4.15.0-rc8-zram #22
[  363.116650] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[  363.116731] kswapd0         D    0   159      2 0x80000000
[  363.116734] Call Trace:
[  363.116738]  ? __schedule+0x3d0/0x850
[  363.116741]  schedule+0x32/0x80
[  363.116745]  io_schedule+0x12/0x40
[  363.116749]  __lock_page+0x109/0x130
[  363.116753]  ? page_cache_tree_insert+0xb0/0xb0
[  363.116759]  deferred_split_scan+0x1e9/0x2a0
[  363.116762]  shrink_slab.part.49+0x1e6/0x3d0
[  363.116768]  shrink_node+0x2e7/0x2f0
[  363.116771]  kswapd+0x35b/0x6f0
[  363.116776]  kthread+0xf8/0x130
[  363.116779]  ? mem_cgroup_shrink_node+0x150/0x150
[  363.116782]  ? kthread_create_worker_on_cpu+0x50/0x50
[  363.116786]  ret_from_fork+0x32/0x40
[  363.116790] INFO: task kworker/9:1:196 blocked for more than 120 seconds.
[  363.116869]       Not tainted 4.15.0-rc8-zram #22
[  363.116942] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[  363.117023] kworker/9:1     D    0   196      2 0x80000000
[  363.117029] Workqueue: events async_pf_execute
[  363.117031] Call Trace:
[  363.117034]  ? __schedule+0x3d0/0x850
[  363.117037]  schedule+0x32/0x80
[  363.117041]  io_schedule+0x12/0x40
[  363.117046]  __lock_page_or_retry+0x302/0x320
[  363.117050]  ? page_cache_tree_insert+0xb0/0xb0
[  363.117053]  do_swap_page+0x4dd/0x870
[  363.117057]  __handle_mm_fault+0x790/0x10c0
[  363.117061]  handle_mm_fault+0xc6/0x1b0
[  363.117063]  __get_user_pages+0xf9/0x620
[  363.117068]  ? update_load_avg+0x5c0/0x6f0
[  363.117071]  get_user_pages_remote+0x137/0x1f0
[  363.117076]  async_pf_execute+0x62/0x180
[  363.117081]  process_one_work+0x189/0x380
[  363.117085]  worker_thread+0x4d/0x3c0
[  363.117089]  kthread+0xf8/0x130
[  363.117093]  ? process_one_work+0x380/0x380
[  363.117096]  ? kthread_create_worker_on_cpu+0x50/0x50
[  363.117100]  ret_from_fork+0x32/0x40
[  363.117104] INFO: task kworker/19:1:201 blocked for more than 120 
seconds.
[  363.117183]       Not tainted 4.15.0-rc8-zram #22
[  363.117256] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[  363.117337] kworker/19:1    D    0   201      2 0x80000000
[  363.117343] Workqueue: events async_pf_execute
[  363.117345] Call Trace:
[  363.117349]  ? __schedule+0x3d0/0x850
[  363.117352]  schedule+0x32/0x80
[  363.117356]  io_schedule+0x12/0x40
[  363.117360]  __lock_page_or_retry+0x302/0x320
[  363.117364]  ? page_cache_tree_insert+0xb0/0xb0
[  363.117367]  do_swap_page+0x4dd/0x870
[  363.117370]  __handle_mm_fault+0x790/0x10c0
[  363.117374]  handle_mm_fault+0xc6/0x1b0
[  363.117377]  __get_user_pages+0xf9/0x620
[  363.117380]  ? update_load_avg+0x5c0/0x6f0
[  363.117383]  get_user_pages_remote+0x137/0x1f0
[  363.117388]  async_pf_execute+0x62/0x180
[  363.117393]  process_one_work+0x189/0x380
[  363.117397]  worker_thread+0x4d/0x3c0
[  363.117401]  kthread+0xf8/0x130
[  363.117404]  ? process_one_work+0x380/0x380
[  363.117407]  ? kthread_create_worker_on_cpu+0x50/0x50
[  363.117411]  ret_from_fork+0x32/0x40
[  363.117415] INFO: task kworker/5:1:207 blocked for more than 120 seconds.
[  363.117494]       Not tainted 4.15.0-rc8-zram #22
[  363.117567] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[  363.117648] kworker/5:1     D    0   207      2 0x80000000
[  363.117654] Workqueue: events async_pf_execute
[  363.117655] Call Trace:
[  363.117659]  ? __schedule+0x3d0/0x850
[  363.117662]  schedule+0x32/0x80
[  363.117665]  io_schedule+0x12/0x40
[  363.117669]  __lock_page_or_retry+0x302/0x320
[  363.117673]  ? page_cache_tree_insert+0xb0/0xb0
[  363.117676]  do_swap_page+0x4dd/0x870
[  363.117680]  ? check_preempt_curr+0x83/0x90
[  363.117683]  __handle_mm_fault+0x790/0x10c0
[  363.117687]  handle_mm_fault+0xc6/0x1b0
[  363.117689]  __get_user_pages+0xf9/0x620
[  363.117693]  ? update_load_avg+0x5c0/0x6f0
[  363.117695]  get_user_pages_remote+0x137/0x1f0
[  363.117700]  async_pf_execute+0x62/0x180
[  363.117705]  process_one_work+0x189/0x380
[  363.117709]  worker_thread+0x4d/0x3c0
[  363.117713]  kthread+0xf8/0x130
[  363.117717]  ? process_one_work+0x380/0x380
[  363.117720]  ? kthread_create_worker_on_cpu+0x50/0x50
[  363.117723]  ret_from_fork+0x32/0x40
[  363.117731] INFO: task kworker/5:2:437 blocked for more than 120 seconds.
[  363.117828]       Not tainted 4.15.0-rc8-zram #22
[  363.117920] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[  363.118039] kworker/5:2     D    0   437      2 0x80000000
[  363.118044] Workqueue: events async_pf_execute
[  363.118046] Call Trace:
[  363.118049]  ? __schedule+0x3d0/0x850
[  363.118052]  schedule+0x32/0x80
[  363.118056]  io_schedule+0x12/0x40
[  363.118060]  __lock_page_or_retry+0x302/0x320
[  363.118064]  ? page_cache_tree_insert+0xb0/0xb0
[  363.118067]  do_swap_page+0x4dd/0x870
[  363.118070]  __handle_mm_fault+0x790/0x10c0
[  363.118074]  handle_mm_fault+0xc6/0x1b0
[  363.118077]  __get_user_pages+0xf9/0x620
[  363.118080]  ? update_load_avg+0x5c0/0x6f0
[  363.118083]  get_user_pages_remote+0x137/0x1f0
[  363.118087]  async_pf_execute+0x62/0x180
[  363.118092]  process_one_work+0x189/0x380
[  363.118096]  worker_thread+0x4d/0x3c0
[  363.118100]  kthread+0xf8/0x130
[  363.118104]  ? process_one_work+0x380/0x380
[  363.118107]  ? kthread_create_worker_on_cpu+0x50/0x50
[  363.118113]  ? do_group_exit+0x3a/0xa0
[  363.118116]  ret_from_fork+0x32/0x40
[  363.118120] INFO: task kworker/8:2:501 blocked for more than 120 seconds.
[  363.118217]       Not tainted 4.15.0-rc8-zram #22
[  363.118309] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[  363.118427] kworker/8:2     D    0   501      2 0x80000000
[  363.118433] Workqueue: events async_pf_execute
[  363.118435] Call Trace:
[  363.118438]  ? __schedule+0x3d0/0x850
[  363.118441]  schedule+0x32/0x80
[  363.118445]  io_schedule+0x12/0x40
[  363.118448]  __lock_page_or_retry+0x302/0x320
[  363.118452]  ? page_cache_tree_insert+0xb0/0xb0
[  363.118455]  do_swap_page+0x4dd/0x870
[  363.118459]  __handle_mm_fault+0x790/0x10c0
[  363.118463]  handle_mm_fault+0xc6/0x1b0
[  363.118465]  __get_user_pages+0xf9/0x620
[  363.118469]  ? update_load_avg+0x5c0/0x6f0
[  363.118471]  get_user_pages_remote+0x137/0x1f0
[  363.118476]  async_pf_execute+0x62/0x180
[  363.118481]  process_one_work+0x189/0x380
[  363.118485]  worker_thread+0x4d/0x3c0
[  363.118489]  kthread+0xf8/0x130
[  363.118492]  ? process_one_work+0x380/0x380
[  363.118495]  ? kthread_create_worker_on_cpu+0x50/0x50
[  363.118498]  ? kthread_create_worker_on_cpu+0x50/0x50
[  363.118502]  ret_from_fork+0x32/0x40
[  363.118511] INFO: task qemu-system-x86:943 blocked for more than 120 
seconds.
[  363.118609]       Not tainted 4.15.0-rc8-zram #22
[  363.118701] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[  363.118820] qemu-system-x86 D    0   943    931 0x00000000
[  363.118822] Call Trace:
[  363.118826]  ? __schedule+0x3d0/0x850
[  363.118829]  schedule+0x32/0x80
[  363.118833]  io_schedule+0x12/0x40
[  363.118837]  __lock_page+0x109/0x130
[  363.118840]  ? page_cache_tree_insert+0xb0/0xb0
[  363.118844]  deferred_split_scan+0x1e9/0x2a0
[  363.118848]  shrink_slab.part.49+0x1e6/0x3d0
[  363.118852]  shrink_node+0x2e7/0x2f0
[  363.118856]  do_try_to_free_pages+0xd5/0x320
[  363.118859]  try_to_free_pages+0xd6/0x190
[  363.118864]  __alloc_pages_slowpath+0x34d/0xdc0
[  363.118869]  __alloc_pages_nodemask+0x214/0x230
[  363.118873]  do_huge_pmd_anonymous_page+0x13a/0x610
[  363.118877]  __handle_mm_fault+0xe04/0x10c0
[  363.118879]  ? kvm_vcpu_mmap+0x20/0x20
[  363.118884]  ? bsearch+0x52/0x90
[  363.118887]  handle_mm_fault+0xc6/0x1b0
[  363.118890]  __get_user_pages+0xf9/0x620
[  363.118893]  get_user_pages+0x3e/0x50
[  363.118898]  __gfn_to_pfn_memslot+0xff/0x3d0
[  363.118903]  try_async_pf+0x53/0x1d0
[  363.118907]  tdp_page_fault+0x10e/0x260
[  363.118912]  ? vmexit_fill_RSB+0x11/0x30
[  363.118915]  kvm_mmu_page_fault+0x59/0x130
[  363.118920]  vmx_handle_exit+0x9f/0x1530
[  363.118924]  ? vmexit_fill_RSB+0x11/0x30
[  363.118927]  ? vmx_vcpu_run+0x32f/0x4d0
[  363.118932]  kvm_arch_vcpu_ioctl_run+0x90c/0x1670
[  363.118936]  ? handle_machine_check+0x10/0x10
[  363.118938]  ? kvm_arch_vcpu_load+0x68/0x250
[  363.118943]  ? kvm_vcpu_ioctl+0x2e8/0x580
[  363.118946]  kvm_vcpu_ioctl+0x2e8/0x580
[  363.118952]  do_vfs_ioctl+0x92/0x5f0
[  363.118955]  ? handle_mm_fault+0xc6/0x1b0
[  363.118960]  ? kvm_on_user_return+0x68/0xa0
[  363.118964]  SyS_ioctl+0x74/0x80
[  363.118969]  entry_SYSCALL_64_fastpath+0x24/0x87
[  363.118972] RIP: 0033:0x7fcc51943dd7

--

[  967.078557] BUG: Bad page state in process qemu-system-x86  pfn:3f6d853
[  967.078637] page:000000004d26db38 count:0 mapcount:0 mapping: 
  (null) index:0x1
[  967.078715] flags: 0x17fffc000000008(uptodate)
[  967.078786] raw: 017fffc000000008 0000000000000000 0000000000000001 
00000000ffffffff
[  967.078863] raw: dead000000000100 dead000000000200 0000000000000000 
0000000000000000
[  967.078939] page dumped because: PAGE_FLAGS_CHECK_AT_PREP flag set
[  967.079012] bad because of flags: 0x8(uptodate)
[  967.079081] Modules linked in: lz4 lz4_compress zram
[  967.079085] CPU: 2 PID: 946 Comm: qemu-system-x86 Not tainted 
4.15.0-rc2-zram #4
[  967.079086] Hardware name: Supermicro Super Server/X10SRL-F, BIOS 
2.0b 05/02/2017
[  967.079087] Call Trace:
[  967.079093]  dump_stack+0x5c/0x84
[  967.079097]  bad_page+0xba/0x120
[  967.079098]  get_page_from_freelist+0xfe7/0x1230
[  967.079101]  __alloc_pages_nodemask+0xea/0x230
[  967.079104]  alloc_pages_vma+0x7c/0x1c0
[  967.079106]  do_swap_page+0x474/0x870
[  967.079109]  ? do_huge_pmd_anonymous_page+0x417/0x610
[  967.079110]  __handle_mm_fault+0xa53/0x1160
[  967.079112]  handle_mm_fault+0xc6/0x1b0
[  967.079114]  __get_user_pages+0xf9/0x620
[  967.079117]  get_user_pages+0x3e/0x50
[  967.079119]  __gfn_to_pfn_memslot+0xff/0x3d0
[  967.079122]  try_async_pf+0x53/0x1c0
[  967.079124]  tdp_page_fault+0x10e/0x260
[  967.079125]  kvm_mmu_page_fault+0x53/0x130
[  967.079128]  vmx_handle_exit+0x9c/0x1500
[  967.079129]  ? atomic_switch_perf_msrs+0x5f/0x80
[  967.079130]  ? vmx_vcpu_run+0x30a/0x4b0
[  967.079133]  kvm_arch_vcpu_ioctl_run+0x8dc/0x15e0
[  967.079135]  ? kvm_arch_vcpu_load+0x62/0x230
[  967.079136]  ? kvm_vcpu_ioctl+0x2e8/0x580
[  967.079137]  kvm_vcpu_ioctl+0x2e8/0x580
[  967.079141]  ? wake_up_q+0x70/0x70
[  967.079144]  do_vfs_ioctl+0x8f/0x5e0
[  967.079147]  ? kvm_on_user_return+0x68/0xa0
[  967.079148]  SyS_ioctl+0x74/0x80
[  967.079152]  entry_SYSCALL_64_fastpath+0x1e/0x81
[  967.079154] RIP: 0033:0x7f4410161dd7
[  967.079154] RSP: 002b:00007f43eeffc8b8 EFLAGS: 00000246 ORIG_RAX: 
0000000000000010
[  967.079156] RAX: ffffffffffffffda RBX: 000000000000ae80 RCX: 
00007f4410161dd7
[  967.079156] RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 
0000000000000013
[  967.079157] RBP: 000055c5a36f8e50 R08: 000055c5a0fa73d0 R09: 
00000000ffffffff
[  967.079158] R10: 003b83305f306bdf R11: 0000000000000246 R12: 
0000000000000000
[  967.079158] R13: 00007f44157ad000 R14: 0000000000000000 R15: 
000055c5a36f8e50
[  967.079160] Disabling lock debugging due to kernel taint

-- 
Kind regards,

Tino Lehnig
