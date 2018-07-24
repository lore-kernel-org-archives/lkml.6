Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C60C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4014920874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:26:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4014920874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388488AbeGXRdu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 13:33:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44970 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388324AbeGXRdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 13:33:50 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6OGOaM2080529
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 12:26:23 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ke6srjmw3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 12:26:21 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 24 Jul 2018 12:26:21 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 24 Jul 2018 12:26:19 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6OGQI1P14549248
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 24 Jul 2018 16:26:19 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C25EDB205F;
        Tue, 24 Jul 2018 12:26:01 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5B0EAB2065;
        Tue, 24 Jul 2018 12:26:01 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 24 Jul 2018 12:26:01 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 9382216C1945; Tue, 24 Jul 2018 09:26:19 -0700 (PDT)
Date:   Tue, 24 Jul 2018 09:26:19 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, lkp@01.org
Subject: Re: [LKP] [rcu]  baf24235a0:
 page_allocation_failure:order:#,mode:#(),nodemask=(null)
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180724072956.GE19722@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180724072956.GE19722@shao2-debian>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18072416-0068-0000-0000-0000031CC87D
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009423; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01065513; UDB=6.00547344; IPR=6.00843370;
 MB=3.00022304; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-24 16:26:20
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18072416-0069-0000-0000-000045250743
Message-Id: <20180724162619.GK12945@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-24_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807240173
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 03:29:56PM +0800, kernel test robot wrote:
> 
> FYI, we noticed the following commit (built with gcc-6):
> 
> commit: baf24235a013d547c2a8be2de9c1cf37a290d56e ("rcu: Define RCU-sched API in terms of RCU for Tree RCU PREEMPT builds")
> https://git.kernel.org/cgit/linux/kernel/git/paulmck/linux-rcu.git dev
> 
> in testcase: boot
> 
> on test machine: qemu-system-x86_64 -enable-kvm -smp 2 -m 512M
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):

This happens before rcu_init() is invoked, so I am having some trouble
believeing that it is my fault.  Besides, it looks like you are just
getting a different distribution of failures between the two commits,
not a good commit and a bad commit.

What am I missing here?

							Thanx, Paul

> +-----------------------------------------------------------------------------------------------------------+------------+------------+
> |                                                                                                           | 77401241ff | baf24235a0 |
> +-----------------------------------------------------------------------------------------------------------+------------+------------+
> | boot_successes                                                                                            | 0          | 0          |
> | boot_failures                                                                                             | 12         | 30         |
> | Kernel_panic-not_syncing:cannot_initialize_percpu_area(err=-#)                                            | 8          |            |
> | Kernel_panic-not_syncing:cannot_initialize_percpu_area(err=-#)]                                           | 8          |            |
> | Kernel_panic-not_syncing:memblock_virt_alloc_try_nid:Failed_to_allocate#bytes_align=#nid=#from=#max_addr= | 2          | 2          |
> | invoked_oom-killer:gfp_mask=0x                                                                            | 2          |            |
> | Mem-Info                                                                                                  | 2          | 28         |
> | Kernel_panic-not_syncing:Out_of_memory_and_no_killable_processes                                          | 2          |            |
> | page_allocation_failure:order:#,mode:#(),nodemask=(null)                                                  | 0          | 28         |
> | page_allocation_failure:order:#,mode:#(__GFP_COMP),nodemask=(null)                                        | 0          | 28         |
> | BUG:KASAN:null-ptr-deref_in_c                                                                             | 0          | 28         |
> | BUG:unable_to_handle_kernel                                                                               | 0          | 28         |
> | Oops:#[##]                                                                                                | 0          | 28         |
> | RIP:cpupri_set                                                                                            | 0          | 28         |
> | Kernel_panic-not_syncing:Fatal_exception                                                                  | 0          | 28         |
> +-----------------------------------------------------------------------------------------------------------+------------+------------+
> 
> 
> 
> [    0.000000] ** If you see this message and you are not debugging    **
> [    0.000000] ** the kernel, report this immediately to your vendor!  **
> [    0.000000] **                                                      **
> [    0.000000] **   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **
> [    0.000000] **********************************************************
> [    0.000000] swapper: page allocation failure: order:0, mode:0x0(), nodemask=(null)
> [    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G                T 4.18.0-rc5-00186-gbaf2423 #2
> [    0.000000] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
> [    0.000000] Call Trace:
> [    0.000000]  dump_stack+0x15a/0x218
> [    0.000000]  warn_alloc+0x1fc/0x2e0
> [    0.000000]  ? zone_watermark_ok_safe+0x1c0/0x1c0
> [    0.000000]  ? __asan_loadN+0xf/0x20
> [    0.000000]  ? __asan_loadN+0xf/0x20
> [    0.000000]  ? ftrace_likely_update+0x2c9/0x320
> [    0.000000]  ? __isolate_free_page+0x420/0x420
> [    0.000000]  ? __asan_loadN+0xf/0x20
> [    0.000000]  ? ftrace_likely_update+0x2c9/0x320
> [    0.000000]  __alloc_pages_nodemask+0x21e9/0x2d20
> [    0.000000]  ? start_kernel+0x31a/0x830
> [    0.000000]  ? lock_release+0x745/0x7d0
> [    0.000000]  ? __native_queued_spin_unlock+0xd/0x20
> [    0.000000]  ? gfp_pfmemalloc_allowed+0x1e0/0x1e0
> [    0.000000]  ? ftrace_likely_update+0x2c9/0x320
> [    0.000000]  ? cache_alloc_refill+0x35d/0x5d0
> [    0.000000]  ? kmem_cache_alloc_node_trace+0x4a2/0x570
> [    0.000000]  ? __kmalloc_node+0x62/0x90
> [    0.000000]  ? __kmalloc_node+0x76/0x90
> [    0.000000]  rb_allocate_cpu_buffer+0x32e/0x5d0
> [    0.000000]  ? rb_check_pages+0x360/0x360
> [    0.000000]  ? __kmalloc+0x438/0x550
> [    0.000000]  ? __ring_buffer_alloc+0x169/0x320
> [    0.000000]  __ring_buffer_alloc+0x1d4/0x320
> [    0.000000]  early_trace_init+0x246/0x533
> [    0.000000]  start_kernel+0x31a/0x830
> [    0.000000]  ? mem_encrypt_init+0x10/0x10
> [    0.000000]  x86_64_start_reservations+0x2a/0x2c
> [    0.000000]  x86_64_start_kernel+0x77/0x7a
> [    0.000000]  secondary_startup_64+0xa5/0xb0
> [    0.000000] Mem-Info:
> [    0.000000] active_anon:0 inactive_anon:0 isolated_anon:0
> [    0.000000]  active_file:0 inactive_file:0 isolated_file:0
> [    0.000000]  unevictable:0 dirty:0 writeback:0 unstable:0
> [    0.000000]  slab_reclaimable:0 slab_unreclaimable:11
> [    0.000000]  mapped:0 shmem:0 pagetables:0 bounce:0
> [    0.000000]  free:0 free_pcp:0 free_cma:0
> [    0.000000] Node 0 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:0kB writeback:0kB shmem:0kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:0kB unstable:0kB all_unreclaimable? no
> [    0.000000] Node 0 DMA free:0kB min:0kB low:0kB high:0kB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:88kB mlocked:0kB kernel_stack:0kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
> [    0.000000] lowmem_reserve[]: 0 0 0 0
> [    0.000000] Node 0 DMA32 free:0kB min:0kB low:0kB high:0kB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:507776kB managed:0kB mlocked:0kB kernel_stack:0kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
> [    0.000000] lowmem_reserve[]: 0 0 0 0
> [    0.000000] Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 0kB
> [    0.000000] Node 0 DMA32: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 0kB
> [    0.000000] 0 total pagecache pages
> [    0.000000] 130942 pages RAM
> [    0.000000] 0 pages HighMem/MovableOnly
> [    0.000000] 130920 pages reserved
> [    0.000000] 0 pages cma reserved
> [    0.003333] swapper: page allocation failure: order:0, mode:0x4000(__GFP_COMP), nodemask=(null)
> [    0.003333] CPU: 0 PID: 0 Comm: swapper Tainted: G                T 4.18.0-rc5-00186-gbaf2423 #2
> [    0.003333] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
> [    0.003333] Call Trace:
> [    0.003333]  dump_stack+0x15a/0x218
> [    0.003333]  warn_alloc+0x1fc/0x2e0
> [    0.003333]  ? zone_watermark_ok_safe+0x1c0/0x1c0
> [    0.003333]  ? ftrace_likely_update+0x2c9/0x320
> [    0.003333]  ? __isolate_free_page+0x420/0x420
> [    0.003333]  ? __asan_loadN+0xf/0x20
> [    0.003333]  ? ftrace_likely_update+0x2c9/0x320
> [    0.003333]  __alloc_pages_nodemask+0x21e9/0x2d20
> [    0.003333]  ? ftrace_likely_update+0x2c9/0x320
> [    0.003333]  ? gfp_pfmemalloc_allowed+0x1e0/0x1e0
> [    0.003333]  ? gfp_pfmemalloc_allowed+0x1e0/0x1e0
> [    0.003333]  ? kvm_clock_read+0x64/0x90
> [    0.003333]  ? check_chain_key+0x191/0x1f0
> [    0.003333]  ? ftrace_likely_update+0x2c9/0x320
> [    0.003333]  cache_grow_begin+0x7be/0x8a0
> [    0.003333]  ? ftrace_likely_update+0x2c9/0x320
> [    0.003333]  ? __asan_loadN+0xf/0x20
> [    0.003333]  fallback_alloc+0x26b/0x2b0
> [    0.003333]  ____cache_alloc_node+0x295/0x2c0
> [    0.003333]  kmem_cache_alloc_node_trace+0x1d2/0x570
> [    0.003333]  __kmalloc_node+0x62/0x90
> [    0.003333]  alloc_cpumask_var_node+0x40/0x60
> [    0.003333]  zalloc_cpumask_var+0x23/0x30
> [    0.003333]  cpupri_init+0x53/0x1c0
> [    0.003333]  init_rootdomain+0x1ea/0x290
> [    0.003333]  ? __raw_spin_lock_init+0x6d/0x80
> [    0.003333]  init_defrootdomain+0x15/0x40
> [    0.003333]  sched_init+0x1ec/0x639
> [    0.003333]  start_kernel+0x31f/0x830
> [    0.003333]  ? mem_encrypt_init+0x10/0x10
> [    0.003333]  x86_64_start_reservations+0x2a/0x2c
> [    0.003333]  x86_64_start_kernel+0x77/0x7a
> [    0.003333]  secondary_startup_64+0xa5/0xb0
> [    0.003333] ==================================================================
> [    0.003333] BUG: KASAN: null-ptr-deref in cpupri_set+0x41/0x250
> [    0.003333] Read of size 4 at addr 0000000000000000 by task swapper/0
> [    0.003333] 
> [    0.003333] CPU: 0 PID: 0 Comm: swapper Tainted: G                T 4.18.0-rc5-00186-gbaf2423 #2
> [    0.003333] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
> [    0.003333] Call Trace:
> [    0.003333]  dump_stack+0x15a/0x218
> [    0.003333]  ? cpupri_set+0x41/0x250
> [    0.003333]  kasan_report+0x321/0x3a0
> [    0.003333]  __asan_load4+0x78/0x80
> [    0.003333]  cpupri_set+0x41/0x250
> [    0.003333]  rq_online_rt+0x229/0x240
> [    0.003333]  ? rq_offline_rt+0x560/0x560
> [    0.003333]  set_rq_online+0xf7/0x120
> [    0.003333]  rq_attach_root+0x1fd/0x260
> [    0.003333]  sched_init+0x49b/0x639
> [    0.003333]  start_kernel+0x31f/0x830
> [    0.003333]  ? mem_encrypt_init+0x10/0x10
> [    0.003333]  x86_64_start_reservations+0x2a/0x2c
> [    0.003333]  x86_64_start_kernel+0x77/0x7a
> [    0.003333]  secondary_startup_64+0xa5/0xb0
> [    0.003333] ==================================================================
> [    0.003333] Disabling lock debugging due to kernel taint
> [    0.003333] BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
> [    0.003333] PGD 0 P4D 0 
> [    0.003333] Oops: 0000 [#1] PREEMPT SMP DEBUG_PAGEALLOC KASAN
> [    0.003333] CPU: 0 PID: 0 Comm: swapper Tainted: G    B           T 4.18.0-rc5-00186-gbaf2423 #2
> [    0.003333] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
> [    0.003333] RIP: 0010:cpupri_set+0x43/0x250
> [    0.003333] Code: 06 00 00 41 89 f7 89 d3 48 83 ec 10 e8 b6 f2 31 00 49 8b 84 24 60 06 00 00 49 63 d7 4c 8d 34 90 4c 89 f7 e8 9f f1 31 00 89 df <4d> 63 2e e8 75 fc ff ff 83 f8 65 89 c3 48 c7 c7 48 99 dc 89 0f 9f 
> [    0.003333] RSP: 0000:ffffffff88407d38 EFLAGS: 00010086
> [    0.003333] RAX: ffffffff8847d8c0 RBX: 0000000000000064 RCX: ffffffff85cb57f7
> [    0.003333] RDX: 0000000000000000 RSI: 0000000000000008 RDI: 0000000000000064
> [    0.003333] RBP: ffffffff88407d70 R08: fffffbfff140a636 R09: fffffbfff140a635
> [    0.003333] R10: ffffffff8a0531af R11: fffffbfff140a636 R12: ffffffff8b64cd30
> [    0.003333] R13: ffffc900001ed2e0 R14: 0000000000000000 R15: 0000000000000000
> [    0.003333] FS:  0000000000000000(0000) GS:ffffc90000000000(0000) knlGS:0000000000000000
> [    0.003333] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    0.003333] CR2: 0000000000000000 CR3: 0000000008472000 CR4: 00000000000006b0
> [    0.003333] Call Trace:
> [    0.003333]  rq_online_rt+0x229/0x240
> [    0.003333]  ? rq_offline_rt+0x560/0x560
> [    0.003333]  set_rq_online+0xf7/0x120
> [    0.003333]  rq_attach_root+0x1fd/0x260
> [    0.003333]  sched_init+0x49b/0x639
> [    0.003333]  start_kernel+0x31f/0x830
> [    0.003333]  ? mem_encrypt_init+0x10/0x10
> [    0.003333]  x86_64_start_reservations+0x2a/0x2c
> [    0.003333]  x86_64_start_kernel+0x77/0x7a
> [    0.003333]  secondary_startup_64+0xa5/0xb0
> [    0.003333] CR2: 0000000000000000
> [    0.003333] ---[ end trace da0df213fc649136 ]---
> [    0.003333] RIP: 0010:cpupri_set+0x43/0x250
> [    0.003333] Code: 06 00 00 41 89 f7 89 d3 48 83 ec 10 e8 b6 f2 31 00 49 8b 84 24 60 06 00 00 49 63 d7 4c 8d 34 90 4c 89 f7 e8 9f f1 31 00 89 df <4d> 63 2e e8 75 fc ff ff 83 f8 65 89 c3 48 c7 c7 48 99 dc 89 0f 9f 
> [    0.003333] RSP: 0000:ffffffff88407d38 EFLAGS: 00010086
> [    0.003333] RAX: ffffffff8847d8c0 RBX: 0000000000000064 RCX: ffffffff85cb57f7
> [    0.003333] RDX: 0000000000000000 RSI: 0000000000000008 RDI: 0000000000000064
> [    0.003333] RBP: ffffffff88407d70 R08: fffffbfff140a636 R09: fffffbfff140a635
> [    0.003333] R10: ffffffff8a0531af R11: fffffbfff140a636 R12: ffffffff8b64cd30
> [    0.003333] R13: ffffc900001ed2e0 R14: 0000000000000000 R15: 0000000000000000
> [    0.003333] FS:  0000000000000000(0000) GS:ffffc90000000000(0000) knlGS:0000000000000000
> [    0.003333] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    0.003333] CR2: 0000000000000000 CR3: 0000000008472000 CR4: 00000000000006b0
> [    0.003333] Kernel panic - not syncing: Fatal exception
> 
> Elapsed time: 10
> 
> #!/bin/bash
> 
> 
> 
> To reproduce:
> 
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp qemu -k <bzImage> job-script # job-script is attached in this email
> 
> 
> 
> Thanks,
> Rong, Chen

> #
> # Automatically generated file; DO NOT EDIT.
> # Linux/x86_64 4.18.0-rc5 Kernel Configuration
> #
> 
> #
> # Compiler: gcc-6 (Debian 6.4.0-9) 6.4.0 20171026
> #
> CONFIG_64BIT=y
> CONFIG_X86_64=y
> CONFIG_X86=y
> CONFIG_INSTRUCTION_DECODER=y
> CONFIG_OUTPUT_FORMAT="elf64-x86-64"
> CONFIG_ARCH_DEFCONFIG="arch/x86/configs/x86_64_defconfig"
> CONFIG_LOCKDEP_SUPPORT=y
> CONFIG_STACKTRACE_SUPPORT=y
> CONFIG_MMU=y
> CONFIG_ARCH_MMAP_RND_BITS_MIN=28
> CONFIG_ARCH_MMAP_RND_BITS_MAX=32
> CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
> CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
> CONFIG_GENERIC_ISA_DMA=y
> CONFIG_GENERIC_BUG=y
> CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
> CONFIG_GENERIC_HWEIGHT=y
> CONFIG_ARCH_MAY_HAVE_PC_FDC=y
> CONFIG_RWSEM_XCHGADD_ALGORITHM=y
> CONFIG_GENERIC_CALIBRATE_DELAY=y
> CONFIG_ARCH_HAS_CPU_RELAX=y
> CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
> CONFIG_ARCH_HAS_FILTER_PGPROT=y
> CONFIG_HAVE_SETUP_PER_CPU_AREA=y
> CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
> CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
> CONFIG_ARCH_HIBERNATION_POSSIBLE=y
> CONFIG_ARCH_SUSPEND_POSSIBLE=y
> CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
> CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
> CONFIG_ZONE_DMA32=y
> CONFIG_AUDIT_ARCH=y
> CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING=y
> CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
> CONFIG_KASAN_SHADOW_OFFSET=0xdffffc0000000000
> CONFIG_X86_64_SMP=y
> CONFIG_ARCH_SUPPORTS_UPROBES=y
> CONFIG_FIX_EARLYCON_MEM=y
> CONFIG_PGTABLE_LEVELS=4
> CONFIG_CC_IS_GCC=y
> CONFIG_GCC_VERSION=60400
> CONFIG_CLANG_VERSION=0
> CONFIG_CONSTRUCTORS=y
> CONFIG_IRQ_WORK=y
> CONFIG_BUILDTIME_EXTABLE_SORT=y
> CONFIG_THREAD_INFO_IN_TASK=y
> 
> #
> # General setup
> #
> CONFIG_INIT_ENV_ARG_LIMIT=32
> # CONFIG_COMPILE_TEST is not set
> CONFIG_LOCALVERSION=""
> CONFIG_LOCALVERSION_AUTO=y
> CONFIG_HAVE_KERNEL_GZIP=y
> CONFIG_HAVE_KERNEL_BZIP2=y
> CONFIG_HAVE_KERNEL_LZMA=y
> CONFIG_HAVE_KERNEL_XZ=y
> CONFIG_HAVE_KERNEL_LZO=y
> CONFIG_HAVE_KERNEL_LZ4=y
> # CONFIG_KERNEL_GZIP is not set
> # CONFIG_KERNEL_BZIP2 is not set
> # CONFIG_KERNEL_LZMA is not set
> # CONFIG_KERNEL_XZ is not set
> # CONFIG_KERNEL_LZO is not set
> CONFIG_KERNEL_LZ4=y
> CONFIG_DEFAULT_HOSTNAME="(none)"
> # CONFIG_SWAP is not set
> # CONFIG_SYSVIPC is not set
> # CONFIG_POSIX_MQUEUE is not set
> CONFIG_CROSS_MEMORY_ATTACH=y
> CONFIG_USELIB=y
> CONFIG_AUDIT=y
> CONFIG_HAVE_ARCH_AUDITSYSCALL=y
> CONFIG_AUDITSYSCALL=y
> CONFIG_AUDIT_WATCH=y
> CONFIG_AUDIT_TREE=y
> 
> #
> # IRQ subsystem
> #
> CONFIG_GENERIC_IRQ_PROBE=y
> CONFIG_GENERIC_IRQ_SHOW=y
> CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
> CONFIG_GENERIC_PENDING_IRQ=y
> CONFIG_GENERIC_IRQ_MIGRATION=y
> CONFIG_GENERIC_IRQ_CHIP=y
> CONFIG_IRQ_DOMAIN=y
> CONFIG_IRQ_DOMAIN_HIERARCHY=y
> CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
> CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
> CONFIG_IRQ_FORCED_THREADING=y
> CONFIG_SPARSE_IRQ=y
> CONFIG_GENERIC_IRQ_DEBUGFS=y
> CONFIG_CLOCKSOURCE_WATCHDOG=y
> CONFIG_ARCH_CLOCKSOURCE_DATA=y
> CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
> CONFIG_GENERIC_TIME_VSYSCALL=y
> CONFIG_GENERIC_CLOCKEVENTS=y
> CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
> CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
> CONFIG_GENERIC_CMOS_UPDATE=y
> 
> #
> # Timers subsystem
> #
> CONFIG_TICK_ONESHOT=y
> CONFIG_NO_HZ_COMMON=y
> # CONFIG_HZ_PERIODIC is not set
> CONFIG_NO_HZ_IDLE=y
> # CONFIG_NO_HZ_FULL is not set
> CONFIG_NO_HZ=y
> # CONFIG_HIGH_RES_TIMERS is not set
> 
> #
> # CPU/Task time and stats accounting
> #
> CONFIG_VIRT_CPU_ACCOUNTING=y
> # CONFIG_TICK_CPU_ACCOUNTING is not set
> CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
> CONFIG_IRQ_TIME_ACCOUNTING=y
> CONFIG_BSD_PROCESS_ACCT=y
> CONFIG_BSD_PROCESS_ACCT_V3=y
> CONFIG_TASKSTATS=y
> CONFIG_TASK_DELAY_ACCT=y
> CONFIG_TASK_XACCT=y
> # CONFIG_TASK_IO_ACCOUNTING is not set
> # CONFIG_CPU_ISOLATION is not set
> 
> #
> # RCU Subsystem
> #
> CONFIG_PREEMPT_RCU=y
> # CONFIG_RCU_EXPERT is not set
> CONFIG_SRCU=y
> CONFIG_TREE_SRCU=y
> CONFIG_TASKS_RCU=y
> CONFIG_RCU_STALL_COMMON=y
> CONFIG_RCU_NEED_SEGCBLIST=y
> CONFIG_CONTEXT_TRACKING=y
> # CONFIG_CONTEXT_TRACKING_FORCE is not set
> CONFIG_BUILD_BIN2C=y
> CONFIG_IKCONFIG=y
> CONFIG_IKCONFIG_PROC=y
> CONFIG_LOG_BUF_SHIFT=20
> CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
> CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
> CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
> CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
> CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
> CONFIG_ARCH_SUPPORTS_INT128=y
> CONFIG_NUMA_BALANCING=y
> CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=y
> CONFIG_CGROUPS=y
> # CONFIG_MEMCG is not set
> # CONFIG_BLK_CGROUP is not set
> # CONFIG_CGROUP_SCHED is not set
> # CONFIG_CGROUP_PIDS is not set
> # CONFIG_CGROUP_RDMA is not set
> # CONFIG_CGROUP_FREEZER is not set
> # CONFIG_CPUSETS is not set
> CONFIG_CGROUP_DEVICE=y
> # CONFIG_CGROUP_CPUACCT is not set
> # CONFIG_CGROUP_PERF is not set
> # CONFIG_CGROUP_BPF is not set
> CONFIG_CGROUP_DEBUG=y
> CONFIG_SOCK_CGROUP_DATA=y
> CONFIG_NAMESPACES=y
> CONFIG_UTS_NS=y
> CONFIG_USER_NS=y
> # CONFIG_PID_NS is not set
> CONFIG_NET_NS=y
> # CONFIG_SCHED_AUTOGROUP is not set
> # CONFIG_SYSFS_DEPRECATED is not set
> CONFIG_RELAY=y
> CONFIG_BLK_DEV_INITRD=y
> CONFIG_INITRAMFS_SOURCE=""
> CONFIG_RD_GZIP=y
> CONFIG_RD_BZIP2=y
> CONFIG_RD_LZMA=y
> CONFIG_RD_XZ=y
> CONFIG_RD_LZO=y
> CONFIG_RD_LZ4=y
> CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
> # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
> CONFIG_SYSCTL=y
> CONFIG_ANON_INODES=y
> CONFIG_HAVE_UID16=y
> CONFIG_SYSCTL_EXCEPTION_TRACE=y
> CONFIG_HAVE_PCSPKR_PLATFORM=y
> CONFIG_BPF=y
> # CONFIG_EXPERT is not set
> CONFIG_UID16=y
> CONFIG_MULTIUSER=y
> CONFIG_SGETMASK_SYSCALL=y
> CONFIG_SYSFS_SYSCALL=y
> CONFIG_FHANDLE=y
> CONFIG_POSIX_TIMERS=y
> CONFIG_PRINTK=y
> CONFIG_PRINTK_NMI=y
> CONFIG_BUG=y
> CONFIG_ELF_CORE=y
> CONFIG_PCSPKR_PLATFORM=y
> CONFIG_BASE_FULL=y
> CONFIG_FUTEX=y
> CONFIG_FUTEX_PI=y
> CONFIG_EPOLL=y
> CONFIG_SIGNALFD=y
> CONFIG_TIMERFD=y
> CONFIG_EVENTFD=y
> CONFIG_SHMEM=y
> CONFIG_AIO=y
> CONFIG_ADVISE_SYSCALLS=y
> CONFIG_MEMBARRIER=y
> CONFIG_KALLSYMS=y
> CONFIG_KALLSYMS_ALL=y
> CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
> CONFIG_KALLSYMS_BASE_RELATIVE=y
> CONFIG_BPF_SYSCALL=y
> # CONFIG_USERFAULTFD is not set
> CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
> CONFIG_RSEQ=y
> # CONFIG_EMBEDDED is not set
> CONFIG_HAVE_PERF_EVENTS=y
> CONFIG_PERF_USE_VMALLOC=y
> 
> #
> # Kernel Performance Events And Counters
> #
> CONFIG_PERF_EVENTS=y
> CONFIG_DEBUG_PERF_USE_VMALLOC=y
> CONFIG_VM_EVENT_COUNTERS=y
> # CONFIG_COMPAT_BRK is not set
> CONFIG_SLAB=y
> # CONFIG_SLUB is not set
> # CONFIG_SLAB_MERGE_DEFAULT is not set
> CONFIG_SLAB_FREELIST_RANDOM=y
> CONFIG_SYSTEM_DATA_VERIFICATION=y
> CONFIG_PROFILING=y
> CONFIG_TRACEPOINTS=y
> CONFIG_CRASH_CORE=y
> CONFIG_KEXEC_CORE=y
> CONFIG_OPROFILE=y
> # CONFIG_OPROFILE_EVENT_MULTIPLEX is not set
> CONFIG_HAVE_OPROFILE=y
> CONFIG_OPROFILE_NMI_TIMER=y
> # CONFIG_JUMP_LABEL is not set
> CONFIG_UPROBES=y
> CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
> CONFIG_ARCH_USE_BUILTIN_BSWAP=y
> CONFIG_HAVE_IOREMAP_PROT=y
> CONFIG_HAVE_KPROBES=y
> CONFIG_HAVE_KRETPROBES=y
> CONFIG_HAVE_OPTPROBES=y
> CONFIG_HAVE_KPROBES_ON_FTRACE=y
> CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
> CONFIG_HAVE_NMI=y
> CONFIG_HAVE_ARCH_TRACEHOOK=y
> CONFIG_HAVE_DMA_CONTIGUOUS=y
> CONFIG_GENERIC_SMP_IDLE_THREAD=y
> CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
> CONFIG_ARCH_HAS_SET_MEMORY=y
> CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
> CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
> CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
> CONFIG_HAVE_RSEQ=y
> CONFIG_HAVE_CLK=y
> CONFIG_HAVE_HW_BREAKPOINT=y
> CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
> CONFIG_HAVE_USER_RETURN_NOTIFIER=y
> CONFIG_HAVE_PERF_EVENTS_NMI=y
> CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
> CONFIG_HAVE_PERF_REGS=y
> CONFIG_HAVE_PERF_USER_STACK_DUMP=y
> CONFIG_HAVE_ARCH_JUMP_LABEL=y
> CONFIG_HAVE_RCU_TABLE_FREE=y
> CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
> CONFIG_HAVE_CMPXCHG_LOCAL=y
> CONFIG_HAVE_CMPXCHG_DOUBLE=y
> CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
> CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
> CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
> CONFIG_PLUGIN_HOSTCC="g++"
> CONFIG_HAVE_GCC_PLUGINS=y
> CONFIG_GCC_PLUGINS=y
> # CONFIG_GCC_PLUGIN_LATENT_ENTROPY is not set
> CONFIG_GCC_PLUGIN_STRUCTLEAK=y
> # CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL is not set
> # CONFIG_GCC_PLUGIN_STRUCTLEAK_VERBOSE is not set
> CONFIG_GCC_PLUGIN_RANDSTRUCT=y
> # CONFIG_GCC_PLUGIN_RANDSTRUCT_PERFORMANCE is not set
> CONFIG_HAVE_STACKPROTECTOR=y
> CONFIG_CC_HAS_STACKPROTECTOR_NONE=y
> # CONFIG_STACKPROTECTOR is not set
> CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
> CONFIG_HAVE_CONTEXT_TRACKING=y
> CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
> CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
> CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
> CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
> CONFIG_HAVE_ARCH_HUGE_VMAP=y
> CONFIG_HAVE_ARCH_SOFT_DIRTY=y
> CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
> CONFIG_MODULES_USE_ELF_RELA=y
> CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
> CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
> CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
> CONFIG_HAVE_EXIT_THREAD=y
> CONFIG_ARCH_MMAP_RND_BITS=28
> CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
> CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
> CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
> CONFIG_HAVE_COPY_THREAD_TLS=y
> CONFIG_HAVE_STACK_VALIDATION=y
> CONFIG_HAVE_RELIABLE_STACKTRACE=y
> CONFIG_ISA_BUS_API=y
> CONFIG_OLD_SIGSUSPEND3=y
> CONFIG_COMPAT_OLD_SIGACTION=y
> CONFIG_COMPAT_32BIT_TIME=y
> CONFIG_HAVE_ARCH_VMAP_STACK=y
> CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
> CONFIG_STRICT_KERNEL_RWX=y
> CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
> CONFIG_ARCH_HAS_REFCOUNT=y
> # CONFIG_REFCOUNT_FULL is not set
> 
> #
> # GCOV-based kernel profiling
> #
> # CONFIG_GCOV_KERNEL is not set
> CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
> CONFIG_RT_MUTEXES=y
> CONFIG_BASE_SMALL=0
> # CONFIG_MODULES is not set
> CONFIG_MODULES_TREE_LOOKUP=y
> CONFIG_BLOCK=y
> CONFIG_BLK_SCSI_REQUEST=y
> CONFIG_BLK_DEV_BSG=y
> CONFIG_BLK_DEV_BSGLIB=y
> CONFIG_BLK_DEV_INTEGRITY=y
> # CONFIG_BLK_DEV_ZONED is not set
> CONFIG_BLK_CMDLINE_PARSER=y
> CONFIG_BLK_WBT=y
> CONFIG_BLK_WBT_SQ=y
> # CONFIG_BLK_WBT_MQ is not set
> CONFIG_BLK_DEBUG_FS=y
> # CONFIG_BLK_SED_OPAL is not set
> 
> #
> # Partition Types
> #
> # CONFIG_PARTITION_ADVANCED is not set
> CONFIG_AMIGA_PARTITION=y
> CONFIG_MSDOS_PARTITION=y
> CONFIG_EFI_PARTITION=y
> CONFIG_BLOCK_COMPAT=y
> CONFIG_BLK_MQ_PCI=y
> CONFIG_BLK_MQ_VIRTIO=y
> 
> #
> # IO Schedulers
> #
> CONFIG_IOSCHED_NOOP=y
> # CONFIG_IOSCHED_DEADLINE is not set
> # CONFIG_IOSCHED_CFQ is not set
> CONFIG_DEFAULT_NOOP=y
> CONFIG_DEFAULT_IOSCHED="noop"
> CONFIG_MQ_IOSCHED_DEADLINE=y
> CONFIG_MQ_IOSCHED_KYBER=y
> # CONFIG_IOSCHED_BFQ is not set
> CONFIG_PADATA=y
> CONFIG_ASN1=y
> CONFIG_UNINLINE_SPIN_UNLOCK=y
> CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
> CONFIG_MUTEX_SPIN_ON_OWNER=y
> CONFIG_RWSEM_SPIN_ON_OWNER=y
> CONFIG_LOCK_SPIN_ON_OWNER=y
> CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
> CONFIG_QUEUED_SPINLOCKS=y
> CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
> CONFIG_QUEUED_RWLOCKS=y
> CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
> CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
> CONFIG_CC_HAS_SANE_STACKPROTECTOR=y
> CONFIG_FREEZER=y
> 
> #
> # Processor type and features
> #
> CONFIG_ZONE_DMA=y
> CONFIG_SMP=y
> CONFIG_X86_FEATURE_NAMES=y
> # CONFIG_X86_X2APIC is not set
> # CONFIG_X86_MPPARSE is not set
> CONFIG_GOLDFISH=y
> CONFIG_RETPOLINE=y
> # CONFIG_INTEL_RDT is not set
> # CONFIG_X86_EXTENDED_PLATFORM is not set
> CONFIG_X86_INTEL_LPSS=y
> # CONFIG_X86_AMD_PLATFORM_DEVICE is not set
> CONFIG_IOSF_MBI=y
> CONFIG_IOSF_MBI_DEBUG=y
> # CONFIG_SCHED_OMIT_FRAME_POINTER is not set
> CONFIG_HYPERVISOR_GUEST=y
> CONFIG_PARAVIRT=y
> # CONFIG_PARAVIRT_DEBUG is not set
> CONFIG_PARAVIRT_SPINLOCKS=y
> # CONFIG_QUEUED_LOCK_STAT is not set
> CONFIG_XEN=y
> CONFIG_XEN_PV=y
> CONFIG_XEN_PV_SMP=y
> # CONFIG_XEN_DOM0 is not set
> CONFIG_XEN_PVHVM=y
> CONFIG_XEN_PVHVM_SMP=y
> # CONFIG_XEN_512GB is not set
> CONFIG_XEN_SAVE_RESTORE=y
> # CONFIG_XEN_DEBUG_FS is not set
> # CONFIG_XEN_PVH is not set
> CONFIG_KVM_GUEST=y
> # CONFIG_KVM_DEBUG_FS is not set
> # CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
> CONFIG_PARAVIRT_CLOCK=y
> CONFIG_JAILHOUSE_GUEST=y
> CONFIG_NO_BOOTMEM=y
> # CONFIG_MK8 is not set
> # CONFIG_MPSC is not set
> # CONFIG_MCORE2 is not set
> # CONFIG_MATOM is not set
> CONFIG_GENERIC_CPU=y
> CONFIG_X86_INTERNODE_CACHE_SHIFT=6
> CONFIG_X86_L1_CACHE_SHIFT=6
> CONFIG_X86_TSC=y
> CONFIG_X86_CMPXCHG64=y
> CONFIG_X86_CMOV=y
> CONFIG_X86_MINIMUM_CPU_FAMILY=64
> CONFIG_X86_DEBUGCTLMSR=y
> CONFIG_CPU_SUP_INTEL=y
> CONFIG_CPU_SUP_AMD=y
> CONFIG_CPU_SUP_CENTAUR=y
> CONFIG_HPET_TIMER=y
> CONFIG_DMI=y
> # CONFIG_GART_IOMMU is not set
> CONFIG_CALGARY_IOMMU=y
> # CONFIG_CALGARY_IOMMU_ENABLED_BY_DEFAULT is not set
> CONFIG_MAXSMP=y
> CONFIG_NR_CPUS_RANGE_BEGIN=8192
> CONFIG_NR_CPUS_RANGE_END=8192
> CONFIG_NR_CPUS_DEFAULT=8192
> CONFIG_NR_CPUS=8192
> # CONFIG_SCHED_SMT is not set
> # CONFIG_SCHED_MC is not set
> # CONFIG_PREEMPT_NONE is not set
> # CONFIG_PREEMPT_VOLUNTARY is not set
> CONFIG_PREEMPT=y
> CONFIG_PREEMPT_COUNT=y
> CONFIG_X86_LOCAL_APIC=y
> CONFIG_X86_IO_APIC=y
> CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
> # CONFIG_X86_MCE is not set
> 
> #
> # Performance monitoring
> #
> CONFIG_PERF_EVENTS_INTEL_UNCORE=y
> # CONFIG_PERF_EVENTS_INTEL_RAPL is not set
> CONFIG_PERF_EVENTS_INTEL_CSTATE=y
> CONFIG_PERF_EVENTS_AMD_POWER=y
> CONFIG_X86_16BIT=y
> CONFIG_X86_ESPFIX64=y
> CONFIG_X86_VSYSCALL_EMULATION=y
> # CONFIG_I8K is not set
> CONFIG_MICROCODE=y
> CONFIG_MICROCODE_INTEL=y
> CONFIG_MICROCODE_AMD=y
> CONFIG_MICROCODE_OLD_INTERFACE=y
> CONFIG_X86_MSR=y
> CONFIG_X86_CPUID=y
> # CONFIG_X86_5LEVEL is not set
> CONFIG_ARCH_HAS_MEM_ENCRYPT=y
> # CONFIG_AMD_MEM_ENCRYPT is not set
> CONFIG_NUMA=y
> # CONFIG_AMD_NUMA is not set
> CONFIG_X86_64_ACPI_NUMA=y
> CONFIG_NODES_SPAN_OTHER_NODES=y
> # CONFIG_NUMA_EMU is not set
> CONFIG_NODES_SHIFT=10
> CONFIG_ARCH_SPARSEMEM_ENABLE=y
> CONFIG_ARCH_SPARSEMEM_DEFAULT=y
> CONFIG_ARCH_SELECT_MEMORY_MODEL=y
> CONFIG_ARCH_MEMORY_PROBE=y
> CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
> CONFIG_SELECT_MEMORY_MODEL=y
> CONFIG_SPARSEMEM_MANUAL=y
> CONFIG_SPARSEMEM=y
> CONFIG_NEED_MULTIPLE_NODES=y
> CONFIG_HAVE_MEMORY_PRESENT=y
> CONFIG_SPARSEMEM_EXTREME=y
> CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
> CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER=y
> CONFIG_SPARSEMEM_VMEMMAP=y
> CONFIG_HAVE_MEMBLOCK=y
> CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
> CONFIG_HAVE_GENERIC_GUP=y
> CONFIG_ARCH_DISCARD_MEMBLOCK=y
> CONFIG_MEMORY_ISOLATION=y
> CONFIG_MEMORY_HOTPLUG=y
> CONFIG_MEMORY_HOTPLUG_SPARSE=y
> CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE=y
> # CONFIG_MEMORY_HOTREMOVE is not set
> CONFIG_SPLIT_PTLOCK_CPUS=4
> CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
> CONFIG_COMPACTION=y
> CONFIG_MIGRATION=y
> CONFIG_ARCH_ENABLE_THP_MIGRATION=y
> CONFIG_PHYS_ADDR_T_64BIT=y
> CONFIG_BOUNCE=y
> CONFIG_VIRT_TO_BUS=y
> CONFIG_MMU_NOTIFIER=y
> CONFIG_KSM=y
> CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
> CONFIG_TRANSPARENT_HUGEPAGE=y
> # CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS is not set
> CONFIG_TRANSPARENT_HUGEPAGE_MADVISE=y
> CONFIG_ARCH_WANTS_THP_SWAP=y
> CONFIG_THP_SWAP=y
> CONFIG_TRANSPARENT_HUGE_PAGECACHE=y
> CONFIG_CLEANCACHE=y
> CONFIG_CMA=y
> # CONFIG_CMA_DEBUG is not set
> CONFIG_CMA_DEBUGFS=y
> CONFIG_CMA_AREAS=7
> CONFIG_ZPOOL=y
> CONFIG_ZBUD=y
> CONFIG_Z3FOLD=y
> CONFIG_ZSMALLOC=y
> CONFIG_PGTABLE_MAPPING=y
> # CONFIG_ZSMALLOC_STAT is not set
> CONFIG_GENERIC_EARLY_IOREMAP=y
> # CONFIG_DEFERRED_STRUCT_PAGE_INIT is not set
> CONFIG_IDLE_PAGE_TRACKING=y
> CONFIG_ARCH_HAS_ZONE_DEVICE=y
> CONFIG_FRAME_VECTOR=y
> # CONFIG_PERCPU_STATS is not set
> # CONFIG_GUP_BENCHMARK is not set
> CONFIG_ARCH_HAS_PTE_SPECIAL=y
> # CONFIG_X86_PMEM_LEGACY is not set
> CONFIG_X86_CHECK_BIOS_CORRUPTION=y
> CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK=y
> CONFIG_X86_RESERVE_LOW=64
> CONFIG_MTRR=y
> # CONFIG_MTRR_SANITIZER is not set
> CONFIG_X86_PAT=y
> CONFIG_ARCH_USES_PG_UNCACHED=y
> CONFIG_ARCH_RANDOM=y
> CONFIG_X86_SMAP=y
> CONFIG_X86_INTEL_UMIP=y
> # CONFIG_X86_INTEL_MPX is not set
> # CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS is not set
> # CONFIG_EFI is not set
> # CONFIG_SECCOMP is not set
> # CONFIG_HZ_100 is not set
> # CONFIG_HZ_250 is not set
> CONFIG_HZ_300=y
> # CONFIG_HZ_1000 is not set
> CONFIG_HZ=300
> CONFIG_KEXEC=y
> # CONFIG_KEXEC_FILE is not set
> CONFIG_CRASH_DUMP=y
> CONFIG_PHYSICAL_START=0x1000000
> CONFIG_RELOCATABLE=y
> # CONFIG_RANDOMIZE_BASE is not set
> CONFIG_PHYSICAL_ALIGN=0x200000
> CONFIG_HOTPLUG_CPU=y
> # CONFIG_BOOTPARAM_HOTPLUG_CPU0 is not set
> # CONFIG_DEBUG_HOTPLUG_CPU0 is not set
> CONFIG_COMPAT_VDSO=y
> CONFIG_LEGACY_VSYSCALL_EMULATE=y
> # CONFIG_LEGACY_VSYSCALL_NONE is not set
> # CONFIG_CMDLINE_BOOL is not set
> CONFIG_MODIFY_LDT_SYSCALL=y
> CONFIG_HAVE_LIVEPATCH=y
> CONFIG_ARCH_HAS_ADD_PAGES=y
> CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
> CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
> CONFIG_USE_PERCPU_NUMA_NODE_ID=y
> 
> #
> # Power management and ACPI options
> #
> # CONFIG_SUSPEND is not set
> CONFIG_HIBERNATE_CALLBACKS=y
> CONFIG_PM_SLEEP=y
> CONFIG_PM_SLEEP_SMP=y
> # CONFIG_PM_AUTOSLEEP is not set
> # CONFIG_PM_WAKELOCKS is not set
> CONFIG_PM=y
> CONFIG_PM_DEBUG=y
> CONFIG_PM_ADVANCED_DEBUG=y
> CONFIG_PM_SLEEP_DEBUG=y
> # CONFIG_PM_TRACE_RTC is not set
> CONFIG_PM_CLK=y
> # CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
> CONFIG_ACPI=y
> CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
> CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
> CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
> # CONFIG_ACPI_DEBUGGER is not set
> CONFIG_ACPI_SPCR_TABLE=y
> CONFIG_ACPI_LPIT=y
> # CONFIG_ACPI_PROCFS_POWER is not set
> CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
> CONFIG_ACPI_EC_DEBUGFS=y
> CONFIG_ACPI_AC=y
> # CONFIG_ACPI_BATTERY is not set
> CONFIG_ACPI_BUTTON=y
> CONFIG_ACPI_VIDEO=y
> CONFIG_ACPI_FAN=y
> CONFIG_ACPI_TAD=y
> # CONFIG_ACPI_DOCK is not set
> CONFIG_ACPI_CPU_FREQ_PSS=y
> CONFIG_ACPI_PROCESSOR_CSTATE=y
> CONFIG_ACPI_PROCESSOR_IDLE=y
> CONFIG_ACPI_PROCESSOR=y
> CONFIG_ACPI_HOTPLUG_CPU=y
> CONFIG_ACPI_PROCESSOR_AGGREGATOR=y
> CONFIG_ACPI_THERMAL=y
> CONFIG_ACPI_NUMA=y
> CONFIG_ACPI_CUSTOM_DSDT_FILE=""
> CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
> CONFIG_ACPI_TABLE_UPGRADE=y
> CONFIG_ACPI_DEBUG=y
> # CONFIG_ACPI_PCI_SLOT is not set
> CONFIG_ACPI_CONTAINER=y
> CONFIG_ACPI_HOTPLUG_MEMORY=y
> CONFIG_ACPI_HOTPLUG_IOAPIC=y
> CONFIG_ACPI_SBS=y
> CONFIG_ACPI_HED=y
> CONFIG_ACPI_CUSTOM_METHOD=y
> # CONFIG_ACPI_NFIT is not set
> CONFIG_HAVE_ACPI_APEI=y
> CONFIG_HAVE_ACPI_APEI_NMI=y
> # CONFIG_ACPI_APEI is not set
> CONFIG_DPTF_POWER=y
> CONFIG_ACPI_WATCHDOG=y
> # CONFIG_PMIC_OPREGION is not set
> CONFIG_ACPI_CONFIGFS=y
> # CONFIG_TPS68470_PMIC_OPREGION is not set
> CONFIG_X86_PM_TIMER=y
> # CONFIG_SFI is not set
> 
> #
> # CPU Frequency scaling
> #
> # CONFIG_CPU_FREQ is not set
> 
> #
> # CPU Idle
> #
> CONFIG_CPU_IDLE=y
> # CONFIG_CPU_IDLE_GOV_LADDER is not set
> CONFIG_CPU_IDLE_GOV_MENU=y
> CONFIG_INTEL_IDLE=y
> 
> #
> # Bus options (PCI etc.)
> #
> CONFIG_PCI=y
> CONFIG_PCI_DIRECT=y
> CONFIG_PCI_MMCONFIG=y
> CONFIG_PCI_XEN=y
> CONFIG_PCI_DOMAINS=y
> CONFIG_MMCONF_FAM10H=y
> CONFIG_PCIEPORTBUS=y
> CONFIG_HOTPLUG_PCI_PCIE=y
> CONFIG_PCIEAER=y
> CONFIG_PCIEAER_INJECT=y
> CONFIG_PCIE_ECRC=y
> CONFIG_PCIEASPM=y
> # CONFIG_PCIEASPM_DEBUG is not set
> # CONFIG_PCIEASPM_DEFAULT is not set
> CONFIG_PCIEASPM_POWERSAVE=y
> # CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
> # CONFIG_PCIEASPM_PERFORMANCE is not set
> CONFIG_PCIE_PME=y
> CONFIG_PCIE_DPC=y
> # CONFIG_PCIE_PTM is not set
> # CONFIG_PCI_MSI is not set
> CONFIG_PCI_QUIRKS=y
> # CONFIG_PCI_DEBUG is not set
> CONFIG_PCI_REALLOC_ENABLE_AUTO=y
> CONFIG_PCI_STUB=y
> CONFIG_PCI_PF_STUB=y
> CONFIG_XEN_PCIDEV_FRONTEND=y
> CONFIG_PCI_ATS=y
> CONFIG_PCI_LOCKLESS_CONFIG=y
> CONFIG_PCI_IOV=y
> # CONFIG_PCI_PRI is not set
> CONFIG_PCI_PASID=y
> CONFIG_PCI_LABEL=y
> CONFIG_HOTPLUG_PCI=y
> # CONFIG_HOTPLUG_PCI_ACPI is not set
> CONFIG_HOTPLUG_PCI_CPCI=y
> CONFIG_HOTPLUG_PCI_CPCI_ZT5550=y
> CONFIG_HOTPLUG_PCI_CPCI_GENERIC=y
> CONFIG_HOTPLUG_PCI_SHPC=y
> 
> #
> # PCI controller drivers
> #
> 
> #
> # Cadence PCIe controllers support
> #
> 
> #
> # DesignWare PCI Core Support
> #
> 
> #
> # PCI Endpoint
> #
> CONFIG_PCI_ENDPOINT=y
> # CONFIG_PCI_ENDPOINT_CONFIGFS is not set
> CONFIG_PCI_EPF_TEST=y
> 
> #
> # PCI switch controller drivers
> #
> # CONFIG_PCI_SW_SWITCHTEC is not set
> CONFIG_ISA_DMA_API=y
> CONFIG_AMD_NB=y
> # CONFIG_PCCARD is not set
> CONFIG_RAPIDIO=y
> # CONFIG_RAPIDIO_TSI721 is not set
> CONFIG_RAPIDIO_DISC_TIMEOUT=30
> # CONFIG_RAPIDIO_ENABLE_RX_TX_PORTS is not set
> CONFIG_RAPIDIO_DMA_ENGINE=y
> CONFIG_RAPIDIO_DEBUG=y
> CONFIG_RAPIDIO_ENUM_BASIC=y
> # CONFIG_RAPIDIO_CHMAN is not set
> # CONFIG_RAPIDIO_MPORT_CDEV is not set
> 
> #
> # RapidIO Switch drivers
> #
> # CONFIG_RAPIDIO_TSI57X is not set
> # CONFIG_RAPIDIO_CPS_XX is not set
> CONFIG_RAPIDIO_TSI568=y
> # CONFIG_RAPIDIO_CPS_GEN2 is not set
> # CONFIG_RAPIDIO_RXS_GEN3 is not set
> # CONFIG_X86_SYSFB is not set
> 
> #
> # Executable file formats / Emulations
> #
> CONFIG_BINFMT_ELF=y
> CONFIG_COMPAT_BINFMT_ELF=y
> CONFIG_ELFCORE=y
> # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
> CONFIG_BINFMT_SCRIPT=y
> CONFIG_BINFMT_MISC=y
> CONFIG_COREDUMP=y
> CONFIG_IA32_EMULATION=y
> # CONFIG_IA32_AOUT is not set
> # CONFIG_X86_X32 is not set
> CONFIG_COMPAT_32=y
> CONFIG_COMPAT=y
> CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
> CONFIG_X86_DEV_DMA_OPS=y
> CONFIG_NET=y
> CONFIG_COMPAT_NETLINK_MESSAGES=y
> 
> #
> # Networking options
> #
> # CONFIG_PACKET is not set
> CONFIG_UNIX=y
> CONFIG_UNIX_DIAG=y
> # CONFIG_TLS is not set
> CONFIG_XFRM=y
> # CONFIG_XFRM_USER is not set
> # CONFIG_XFRM_SUB_POLICY is not set
> # CONFIG_XFRM_MIGRATE is not set
> # CONFIG_XFRM_STATISTICS is not set
> # CONFIG_NET_KEY is not set
> # CONFIG_XDP_SOCKETS is not set
> CONFIG_INET=y
> # CONFIG_IP_MULTICAST is not set
> # CONFIG_IP_ADVANCED_ROUTER is not set
> CONFIG_IP_PNP=y
> CONFIG_IP_PNP_DHCP=y
> # CONFIG_IP_PNP_BOOTP is not set
> # CONFIG_IP_PNP_RARP is not set
> # CONFIG_NET_IPIP is not set
> # CONFIG_NET_IPGRE_DEMUX is not set
> CONFIG_NET_IP_TUNNEL=y
> # CONFIG_SYN_COOKIES is not set
> # CONFIG_NET_IPVTI is not set
> # CONFIG_NET_FOU is not set
> # CONFIG_NET_FOU_IP_TUNNELS is not set
> # CONFIG_INET_AH is not set
> # CONFIG_INET_ESP is not set
> # CONFIG_INET_IPCOMP is not set
> CONFIG_INET_TUNNEL=y
> CONFIG_INET_XFRM_MODE_TRANSPORT=y
> CONFIG_INET_XFRM_MODE_TUNNEL=y
> CONFIG_INET_XFRM_MODE_BEET=y
> CONFIG_INET_DIAG=y
> CONFIG_INET_TCP_DIAG=y
> # CONFIG_INET_UDP_DIAG is not set
> # CONFIG_INET_RAW_DIAG is not set
> # CONFIG_INET_DIAG_DESTROY is not set
> # CONFIG_TCP_CONG_ADVANCED is not set
> CONFIG_TCP_CONG_CUBIC=y
> CONFIG_DEFAULT_TCP_CONG="cubic"
> # CONFIG_TCP_MD5SIG is not set
> CONFIG_IPV6=y
> # CONFIG_IPV6_ROUTER_PREF is not set
> # CONFIG_IPV6_OPTIMISTIC_DAD is not set
> # CONFIG_INET6_AH is not set
> # CONFIG_INET6_ESP is not set
> # CONFIG_INET6_IPCOMP is not set
> # CONFIG_IPV6_MIP6 is not set
> CONFIG_INET6_XFRM_MODE_TRANSPORT=y
> CONFIG_INET6_XFRM_MODE_TUNNEL=y
> CONFIG_INET6_XFRM_MODE_BEET=y
> # CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION is not set
> # CONFIG_IPV6_VTI is not set
> CONFIG_IPV6_SIT=y
> # CONFIG_IPV6_SIT_6RD is not set
> CONFIG_IPV6_NDISC_NODETYPE=y
> # CONFIG_IPV6_TUNNEL is not set
> # CONFIG_IPV6_MULTIPLE_TABLES is not set
> # CONFIG_IPV6_MROUTE is not set
> # CONFIG_IPV6_SEG6_LWTUNNEL is not set
> # CONFIG_IPV6_SEG6_HMAC is not set
> CONFIG_NETWORK_SECMARK=y
> CONFIG_NET_PTP_CLASSIFY=y
> CONFIG_NETWORK_PHY_TIMESTAMPING=y
> # CONFIG_NETFILTER is not set
> # CONFIG_BPFILTER is not set
> # CONFIG_IP_DCCP is not set
> # CONFIG_IP_SCTP is not set
> # CONFIG_RDS is not set
> # CONFIG_TIPC is not set
> # CONFIG_ATM is not set
> # CONFIG_L2TP is not set
> CONFIG_STP=y
> CONFIG_BRIDGE=y
> CONFIG_BRIDGE_IGMP_SNOOPING=y
> CONFIG_HAVE_NET_DSA=y
> # CONFIG_NET_DSA is not set
> # CONFIG_VLAN_8021Q is not set
> CONFIG_DECNET=y
> CONFIG_DECNET_ROUTER=y
> CONFIG_LLC=y
> CONFIG_LLC2=y
> CONFIG_ATALK=y
> CONFIG_DEV_APPLETALK=y
> CONFIG_IPDDP=y
> # CONFIG_IPDDP_ENCAP is not set
> CONFIG_X25=y
> CONFIG_LAPB=y
> CONFIG_PHONET=y
> # CONFIG_6LOWPAN is not set
> # CONFIG_IEEE802154 is not set
> # CONFIG_NET_SCHED is not set
> # CONFIG_DCB is not set
> CONFIG_DNS_RESOLVER=y
> CONFIG_BATMAN_ADV=y
> # CONFIG_BATMAN_ADV_BATMAN_V is not set
> CONFIG_BATMAN_ADV_BLA=y
> # CONFIG_BATMAN_ADV_DAT is not set
> # CONFIG_BATMAN_ADV_NC is not set
> # CONFIG_BATMAN_ADV_MCAST is not set
> # CONFIG_BATMAN_ADV_DEBUGFS is not set
> # CONFIG_OPENVSWITCH is not set
> CONFIG_VSOCKETS=y
> # CONFIG_VSOCKETS_DIAG is not set
> CONFIG_VMWARE_VMCI_VSOCKETS=y
> # CONFIG_VIRTIO_VSOCKETS is not set
> CONFIG_VIRTIO_VSOCKETS_COMMON=y
> CONFIG_HYPERV_VSOCKETS=y
> # CONFIG_NETLINK_DIAG is not set
> # CONFIG_MPLS is not set
> # CONFIG_NET_NSH is not set
> CONFIG_HSR=y
> # CONFIG_NET_SWITCHDEV is not set
> # CONFIG_NET_L3_MASTER_DEV is not set
> # CONFIG_NET_NCSI is not set
> CONFIG_RPS=y
> CONFIG_RFS_ACCEL=y
> CONFIG_XPS=y
> CONFIG_CGROUP_NET_PRIO=y
> # CONFIG_CGROUP_NET_CLASSID is not set
> CONFIG_NET_RX_BUSY_POLL=y
> CONFIG_BQL=y
> # CONFIG_BPF_STREAM_PARSER is not set
> CONFIG_NET_FLOW_LIMIT=y
> 
> #
> # Network testing
> #
> # CONFIG_NET_PKTGEN is not set
> # CONFIG_NET_DROP_MONITOR is not set
> CONFIG_HAMRADIO=y
> 
> #
> # Packet Radio protocols
> #
> CONFIG_AX25=y
> CONFIG_AX25_DAMA_SLAVE=y
> # CONFIG_NETROM is not set
> CONFIG_ROSE=y
> 
> #
> # AX.25 network device drivers
> #
> # CONFIG_MKISS is not set
> CONFIG_6PACK=y
> CONFIG_BPQETHER=y
> CONFIG_BAYCOM_SER_FDX=y
> CONFIG_BAYCOM_SER_HDX=y
> CONFIG_YAM=y
> # CONFIG_CAN is not set
> CONFIG_BT=y
> CONFIG_BT_BREDR=y
> CONFIG_BT_RFCOMM=y
> CONFIG_BT_RFCOMM_TTY=y
> CONFIG_BT_BNEP=y
> CONFIG_BT_BNEP_MC_FILTER=y
> CONFIG_BT_BNEP_PROTO_FILTER=y
> CONFIG_BT_HIDP=y
> # CONFIG_BT_HS is not set
> CONFIG_BT_LE=y
> CONFIG_BT_LEDS=y
> CONFIG_BT_SELFTEST=y
> CONFIG_BT_SELFTEST_ECDH=y
> # CONFIG_BT_SELFTEST_SMP is not set
> CONFIG_BT_DEBUGFS=y
> 
> #
> # Bluetooth device drivers
> #
> CONFIG_BT_INTEL=y
> CONFIG_BT_BCM=y
> CONFIG_BT_RTL=y
> CONFIG_BT_QCA=y
> CONFIG_BT_HCIBTUSB=y
> # CONFIG_BT_HCIBTUSB_AUTOSUSPEND is not set
> CONFIG_BT_HCIBTUSB_BCM=y
> CONFIG_BT_HCIBTUSB_RTL=y
> # CONFIG_BT_HCIBTSDIO is not set
> CONFIG_BT_HCIUART=y
> CONFIG_BT_HCIUART_SERDEV=y
> CONFIG_BT_HCIUART_H4=y
> # CONFIG_BT_HCIUART_NOKIA is not set
> # CONFIG_BT_HCIUART_BCSP is not set
> CONFIG_BT_HCIUART_ATH3K=y
> CONFIG_BT_HCIUART_LL=y
> CONFIG_BT_HCIUART_3WIRE=y
> # CONFIG_BT_HCIUART_INTEL is not set
> CONFIG_BT_HCIUART_QCA=y
> # CONFIG_BT_HCIUART_AG6XX is not set
> CONFIG_BT_HCIUART_MRVL=y
> # CONFIG_BT_HCIBCM203X is not set
> # CONFIG_BT_HCIBPA10X is not set
> # CONFIG_BT_HCIBFUSB is not set
> # CONFIG_BT_HCIVHCI is not set
> CONFIG_BT_MRVL=y
> CONFIG_BT_MRVL_SDIO=y
> # CONFIG_BT_ATH3K is not set
> # CONFIG_BT_WILINK is not set
> # CONFIG_AF_RXRPC is not set
> # CONFIG_AF_KCM is not set
> CONFIG_FIB_RULES=y
> CONFIG_WIRELESS=y
> CONFIG_WIRELESS_EXT=y
> CONFIG_WEXT_CORE=y
> CONFIG_WEXT_PROC=y
> CONFIG_WEXT_SPY=y
> CONFIG_WEXT_PRIV=y
> CONFIG_CFG80211=y
> CONFIG_NL80211_TESTMODE=y
> CONFIG_CFG80211_DEVELOPER_WARNINGS=y
> CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
> CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
> # CONFIG_CFG80211_DEFAULT_PS is not set
> CONFIG_CFG80211_DEBUGFS=y
> CONFIG_CFG80211_CRDA_SUPPORT=y
> CONFIG_CFG80211_WEXT=y
> CONFIG_CFG80211_WEXT_EXPORT=y
> CONFIG_LIB80211=y
> CONFIG_LIB80211_CRYPT_WEP=y
> CONFIG_LIB80211_CRYPT_CCMP=y
> CONFIG_LIB80211_CRYPT_TKIP=y
> CONFIG_LIB80211_DEBUG=y
> CONFIG_MAC80211=y
> CONFIG_MAC80211_HAS_RC=y
> CONFIG_MAC80211_RC_MINSTREL=y
> CONFIG_MAC80211_RC_MINSTREL_HT=y
> CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
> CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
> CONFIG_MAC80211_MESH=y
> CONFIG_MAC80211_LEDS=y
> # CONFIG_MAC80211_DEBUGFS is not set
> CONFIG_MAC80211_MESSAGE_TRACING=y
> CONFIG_MAC80211_DEBUG_MENU=y
> CONFIG_MAC80211_NOINLINE=y
> CONFIG_MAC80211_VERBOSE_DEBUG=y
> # CONFIG_MAC80211_MLME_DEBUG is not set
> CONFIG_MAC80211_STA_DEBUG=y
> # CONFIG_MAC80211_HT_DEBUG is not set
> # CONFIG_MAC80211_OCB_DEBUG is not set
> # CONFIG_MAC80211_IBSS_DEBUG is not set
> # CONFIG_MAC80211_PS_DEBUG is not set
> # CONFIG_MAC80211_MPL_DEBUG is not set
> # CONFIG_MAC80211_MPATH_DEBUG is not set
> CONFIG_MAC80211_MHWMP_DEBUG=y
> # CONFIG_MAC80211_MESH_SYNC_DEBUG is not set
> CONFIG_MAC80211_MESH_CSA_DEBUG=y
> # CONFIG_MAC80211_MESH_PS_DEBUG is not set
> # CONFIG_MAC80211_TDLS_DEBUG is not set
> CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
> # CONFIG_WIMAX is not set
> CONFIG_RFKILL=y
> CONFIG_RFKILL_LEDS=y
> CONFIG_RFKILL_INPUT=y
> CONFIG_RFKILL_GPIO=y
> CONFIG_NET_9P=y
> CONFIG_NET_9P_VIRTIO=y
> CONFIG_NET_9P_XEN=y
> # CONFIG_NET_9P_DEBUG is not set
> CONFIG_CAIF=y
> CONFIG_CAIF_DEBUG=y
> CONFIG_CAIF_NETDEV=y
> # CONFIG_CAIF_USB is not set
> # CONFIG_CEPH_LIB is not set
> # CONFIG_NFC is not set
> CONFIG_PSAMPLE=y
> # CONFIG_NET_IFE is not set
> CONFIG_LWTUNNEL=y
> CONFIG_LWTUNNEL_BPF=y
> CONFIG_DST_CACHE=y
> CONFIG_GRO_CELLS=y
> # CONFIG_NET_DEVLINK is not set
> CONFIG_MAY_USE_DEVLINK=y
> CONFIG_FAILOVER=y
> CONFIG_HAVE_EBPF_JIT=y
> 
> #
> # Device Drivers
> #
> 
> #
> # Generic Driver Options
> #
> CONFIG_UEVENT_HELPER=y
> CONFIG_UEVENT_HELPER_PATH=""
> CONFIG_DEVTMPFS=y
> # CONFIG_DEVTMPFS_MOUNT is not set
> # CONFIG_STANDALONE is not set
> CONFIG_PREVENT_FIRMWARE_BUILD=y
> 
> #
> # Firmware loader
> #
> CONFIG_FW_LOADER=y
> CONFIG_EXTRA_FIRMWARE=""
> CONFIG_FW_LOADER_USER_HELPER=y
> # CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
> CONFIG_WANT_DEV_COREDUMP=y
> CONFIG_ALLOW_DEV_COREDUMP=y
> CONFIG_DEV_COREDUMP=y
> # CONFIG_DEBUG_DRIVER is not set
> # CONFIG_DEBUG_DEVRES is not set
> # CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
> CONFIG_GENERIC_CPU_AUTOPROBE=y
> CONFIG_GENERIC_CPU_VULNERABILITIES=y
> CONFIG_REGMAP=y
> CONFIG_REGMAP_I2C=y
> CONFIG_REGMAP_W1=y
> CONFIG_REGMAP_MMIO=y
> CONFIG_REGMAP_IRQ=y
> CONFIG_DMA_SHARED_BUFFER=y
> CONFIG_DMA_FENCE_TRACE=y
> CONFIG_DMA_CMA=y
> 
> #
> # Default contiguous memory area size:
> #
> CONFIG_CMA_SIZE_MBYTES=0
> CONFIG_CMA_SIZE_SEL_MBYTES=y
> # CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
> # CONFIG_CMA_SIZE_SEL_MIN is not set
> # CONFIG_CMA_SIZE_SEL_MAX is not set
> CONFIG_CMA_ALIGNMENT=8
> 
> #
> # Bus devices
> #
> CONFIG_CONNECTOR=y
> # CONFIG_PROC_EVENTS is not set
> CONFIG_MTD=y
> # CONFIG_MTD_REDBOOT_PARTS is not set
> CONFIG_MTD_CMDLINE_PARTS=y
> CONFIG_MTD_AR7_PARTS=y
> 
> #
> # Partition parsers
> #
> 
> #
> # User Modules And Translation Layers
> #
> CONFIG_MTD_BLKDEVS=y
> CONFIG_MTD_BLOCK=y
> # CONFIG_FTL is not set
> CONFIG_NFTL=y
> # CONFIG_NFTL_RW is not set
> CONFIG_INFTL=y
> # CONFIG_RFD_FTL is not set
> # CONFIG_SSFDC is not set
> # CONFIG_SM_FTL is not set
> # CONFIG_MTD_OOPS is not set
> CONFIG_MTD_PARTITIONED_MASTER=y
> 
> #
> # RAM/ROM/Flash chip drivers
> #
> # CONFIG_MTD_CFI is not set
> # CONFIG_MTD_JEDECPROBE is not set
> CONFIG_MTD_MAP_BANK_WIDTH_1=y
> CONFIG_MTD_MAP_BANK_WIDTH_2=y
> CONFIG_MTD_MAP_BANK_WIDTH_4=y
> CONFIG_MTD_CFI_I1=y
> CONFIG_MTD_CFI_I2=y
> CONFIG_MTD_RAM=y
> CONFIG_MTD_ROM=y
> CONFIG_MTD_ABSENT=y
> 
> #
> # Mapping drivers for chip access
> #
> # CONFIG_MTD_COMPLEX_MAPPINGS is not set
> CONFIG_MTD_PHYSMAP=y
> CONFIG_MTD_PHYSMAP_COMPAT=y
> CONFIG_MTD_PHYSMAP_START=0x8000000
> CONFIG_MTD_PHYSMAP_LEN=0
> CONFIG_MTD_PHYSMAP_BANKWIDTH=2
> CONFIG_MTD_INTEL_VR_NOR=y
> CONFIG_MTD_PLATRAM=y
> 
> #
> # Self-contained MTD device drivers
> #
> CONFIG_MTD_PMC551=y
> # CONFIG_MTD_PMC551_BUGFIX is not set
> CONFIG_MTD_PMC551_DEBUG=y
> CONFIG_MTD_SLRAM=y
> CONFIG_MTD_PHRAM=y
> # CONFIG_MTD_MTDRAM is not set
> # CONFIG_MTD_BLOCK2MTD is not set
> 
> #
> # Disk-On-Chip Device Drivers
> #
> # CONFIG_MTD_DOCG3 is not set
> # CONFIG_MTD_ONENAND is not set
> CONFIG_MTD_NAND_ECC=y
> # CONFIG_MTD_NAND_ECC_SMC is not set
> CONFIG_MTD_NAND=y
> # CONFIG_MTD_NAND_ECC_BCH is not set
> CONFIG_MTD_SM_COMMON=y
> CONFIG_MTD_NAND_DENALI=y
> CONFIG_MTD_NAND_DENALI_PCI=y
> CONFIG_MTD_NAND_GPIO=y
> CONFIG_MTD_NAND_RICOH=y
> CONFIG_MTD_NAND_DISKONCHIP=y
> CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADVANCED=y
> CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADDRESS=0
> CONFIG_MTD_NAND_DISKONCHIP_PROBE_HIGH=y
> # CONFIG_MTD_NAND_DISKONCHIP_BBTWRITE is not set
> CONFIG_MTD_NAND_DOCG4=y
> CONFIG_MTD_NAND_CAFE=y
> # CONFIG_MTD_NAND_NANDSIM is not set
> # CONFIG_MTD_NAND_PLATFORM is not set
> 
> #
> # LPDDR & LPDDR2 PCM memory drivers
> #
> CONFIG_MTD_LPDDR=y
> CONFIG_MTD_QINFO_PROBE=y
> CONFIG_MTD_SPI_NOR=y
> # CONFIG_MTD_MT81xx_NOR is not set
> CONFIG_MTD_SPI_NOR_USE_4K_SECTORS=y
> CONFIG_SPI_INTEL_SPI=y
> CONFIG_SPI_INTEL_SPI_PCI=y
> CONFIG_SPI_INTEL_SPI_PLATFORM=y
> CONFIG_MTD_UBI=y
> CONFIG_MTD_UBI_WL_THRESHOLD=4096
> CONFIG_MTD_UBI_BEB_LIMIT=20
> # CONFIG_MTD_UBI_FASTMAP is not set
> CONFIG_MTD_UBI_GLUEBI=y
> # CONFIG_MTD_UBI_BLOCK is not set
> # CONFIG_OF is not set
> CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
> # CONFIG_PARPORT is not set
> CONFIG_PNP=y
> CONFIG_PNP_DEBUG_MESSAGES=y
> 
> #
> # Protocols
> #
> CONFIG_PNPACPI=y
> CONFIG_BLK_DEV=y
> # CONFIG_BLK_DEV_NULL_BLK is not set
> # CONFIG_BLK_DEV_FD is not set
> # CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
> # CONFIG_ZRAM is not set
> # CONFIG_BLK_DEV_DAC960 is not set
> # CONFIG_BLK_DEV_UMEM is not set
> # CONFIG_BLK_DEV_LOOP is not set
> # CONFIG_BLK_DEV_DRBD is not set
> # CONFIG_BLK_DEV_NBD is not set
> # CONFIG_BLK_DEV_SKD is not set
> # CONFIG_BLK_DEV_SX8 is not set
> # CONFIG_BLK_DEV_RAM is not set
> # CONFIG_CDROM_PKTCDVD is not set
> # CONFIG_ATA_OVER_ETH is not set
> CONFIG_XEN_BLKDEV_FRONTEND=y
> # CONFIG_VIRTIO_BLK is not set
> # CONFIG_BLK_DEV_RBD is not set
> # CONFIG_BLK_DEV_RSXX is not set
> 
> #
> # NVME Support
> #
> CONFIG_NVME_CORE=y
> CONFIG_BLK_DEV_NVME=y
> # CONFIG_NVME_MULTIPATH is not set
> # CONFIG_NVME_FC is not set
> # CONFIG_NVME_TARGET is not set
> 
> #
> # Misc devices
> #
> CONFIG_SENSORS_LIS3LV02D=y
> # CONFIG_AD525X_DPOT is not set
> CONFIG_DUMMY_IRQ=y
> CONFIG_IBM_ASM=y
> # CONFIG_PHANTOM is not set
> CONFIG_SGI_IOC4=y
> CONFIG_TIFM_CORE=y
> CONFIG_TIFM_7XX1=y
> CONFIG_ICS932S401=y
> CONFIG_ENCLOSURE_SERVICES=y
> # CONFIG_HP_ILO is not set
> # CONFIG_APDS9802ALS is not set
> # CONFIG_ISL29003 is not set
> CONFIG_ISL29020=y
> CONFIG_SENSORS_TSL2550=y
> # CONFIG_SENSORS_BH1770 is not set
> # CONFIG_SENSORS_APDS990X is not set
> # CONFIG_HMC6352 is not set
> CONFIG_DS1682=y
> # CONFIG_VMWARE_BALLOON is not set
> CONFIG_USB_SWITCH_FSA9480=y
> CONFIG_SRAM=y
> CONFIG_PCI_ENDPOINT_TEST=y
> CONFIG_MISC_RTSX=y
> CONFIG_C2PORT=y
> CONFIG_C2PORT_DURAMAR_2150=y
> 
> #
> # EEPROM support
> #
> # CONFIG_EEPROM_AT24 is not set
> CONFIG_EEPROM_LEGACY=y
> CONFIG_EEPROM_MAX6875=y
> CONFIG_EEPROM_93CX6=y
> # CONFIG_EEPROM_IDT_89HPESX is not set
> CONFIG_CB710_CORE=y
> CONFIG_CB710_DEBUG=y
> CONFIG_CB710_DEBUG_ASSUMPTIONS=y
> 
> #
> # Texas Instruments shared transport line discipline
> #
> CONFIG_TI_ST=y
> CONFIG_SENSORS_LIS3_I2C=y
> # CONFIG_ALTERA_STAPL is not set
> CONFIG_INTEL_MEI=y
> # CONFIG_INTEL_MEI_ME is not set
> CONFIG_INTEL_MEI_TXE=y
> CONFIG_VMWARE_VMCI=y
> 
> #
> # Intel MIC & related support
> #
> 
> #
> # Intel MIC Bus Driver
> #
> CONFIG_INTEL_MIC_BUS=y
> 
> #
> # SCIF Bus Driver
> #
> CONFIG_SCIF_BUS=y
> 
> #
> # VOP Bus Driver
> #
> # CONFIG_VOP_BUS is not set
> 
> #
> # Intel MIC Host Driver
> #
> 
> #
> # Intel MIC Card Driver
> #
> 
> #
> # SCIF Driver
> #
> CONFIG_SCIF=y
> 
> #
> # Intel MIC Coprocessor State Management (COSM) Drivers
> #
> CONFIG_MIC_COSM=y
> 
> #
> # VOP Driver
> #
> CONFIG_GENWQE=y
> CONFIG_GENWQE_PLATFORM_ERROR_RECOVERY=0
> CONFIG_ECHO=y
> CONFIG_MISC_RTSX_PCI=y
> CONFIG_MISC_RTSX_USB=y
> CONFIG_HAVE_IDE=y
> # CONFIG_IDE is not set
> 
> #
> # SCSI device support
> #
> CONFIG_SCSI_MOD=y
> CONFIG_RAID_ATTRS=y
> CONFIG_SCSI=y
> CONFIG_SCSI_DMA=y
> CONFIG_SCSI_NETLINK=y
> CONFIG_SCSI_MQ_DEFAULT=y
> CONFIG_SCSI_PROC_FS=y
> 
> #
> # SCSI support type (disk, tape, CD-ROM)
> #
> # CONFIG_BLK_DEV_SD is not set
> CONFIG_CHR_DEV_ST=y
> CONFIG_CHR_DEV_OSST=y
> # CONFIG_BLK_DEV_SR is not set
> CONFIG_CHR_DEV_SG=y
> # CONFIG_CHR_DEV_SCH is not set
> # CONFIG_SCSI_ENCLOSURE is not set
> CONFIG_SCSI_CONSTANTS=y
> CONFIG_SCSI_LOGGING=y
> CONFIG_SCSI_SCAN_ASYNC=y
> 
> #
> # SCSI Transports
> #
> CONFIG_SCSI_SPI_ATTRS=y
> CONFIG_SCSI_FC_ATTRS=y
> CONFIG_SCSI_ISCSI_ATTRS=y
> CONFIG_SCSI_SAS_ATTRS=y
> CONFIG_SCSI_SAS_LIBSAS=y
> CONFIG_SCSI_SAS_ATA=y
> # CONFIG_SCSI_SAS_HOST_SMP is not set
> # CONFIG_SCSI_SRP_ATTRS is not set
> CONFIG_SCSI_LOWLEVEL=y
> # CONFIG_ISCSI_TCP is not set
> CONFIG_ISCSI_BOOT_SYSFS=y
> # CONFIG_SCSI_CXGB3_ISCSI is not set
> # CONFIG_SCSI_CXGB4_ISCSI is not set
> CONFIG_SCSI_BNX2_ISCSI=y
> CONFIG_BE2ISCSI=y
> # CONFIG_BLK_DEV_3W_XXXX_RAID is not set
> # CONFIG_SCSI_HPSA is not set
> CONFIG_SCSI_3W_9XXX=y
> CONFIG_SCSI_3W_SAS=y
> CONFIG_SCSI_ACARD=y
> # CONFIG_SCSI_AACRAID is not set
> CONFIG_SCSI_AIC7XXX=y
> CONFIG_AIC7XXX_CMDS_PER_DEVICE=32
> CONFIG_AIC7XXX_RESET_DELAY_MS=5000
> # CONFIG_AIC7XXX_DEBUG_ENABLE is not set
> CONFIG_AIC7XXX_DEBUG_MASK=0
> # CONFIG_AIC7XXX_REG_PRETTY_PRINT is not set
> # CONFIG_SCSI_AIC79XX is not set
> # CONFIG_SCSI_AIC94XX is not set
> CONFIG_SCSI_MVSAS=y
> # CONFIG_SCSI_MVSAS_DEBUG is not set
> # CONFIG_SCSI_MVSAS_TASKLET is not set
> # CONFIG_SCSI_MVUMI is not set
> CONFIG_SCSI_DPT_I2O=y
> CONFIG_SCSI_ADVANSYS=y
> CONFIG_SCSI_ARCMSR=y
> CONFIG_SCSI_ESAS2R=y
> CONFIG_MEGARAID_NEWGEN=y
> CONFIG_MEGARAID_MM=y
> CONFIG_MEGARAID_MAILBOX=y
> # CONFIG_MEGARAID_LEGACY is not set
> CONFIG_MEGARAID_SAS=y
> CONFIG_SCSI_MPT3SAS=y
> CONFIG_SCSI_MPT2SAS_MAX_SGE=128
> CONFIG_SCSI_MPT3SAS_MAX_SGE=128
> # CONFIG_SCSI_MPT2SAS is not set
> # CONFIG_SCSI_SMARTPQI is not set
> # CONFIG_SCSI_UFSHCD is not set
> CONFIG_SCSI_HPTIOP=y
> # CONFIG_SCSI_BUSLOGIC is not set
> # CONFIG_VMWARE_PVSCSI is not set
> # CONFIG_XEN_SCSI_FRONTEND is not set
> CONFIG_HYPERV_STORAGE=y
> # CONFIG_LIBFC is not set
> CONFIG_SCSI_SNIC=y
> CONFIG_SCSI_SNIC_DEBUG_FS=y
> CONFIG_SCSI_DMX3191D=y
> CONFIG_SCSI_GDTH=y
> CONFIG_SCSI_ISCI=y
> CONFIG_SCSI_IPS=y
> CONFIG_SCSI_INITIO=y
> CONFIG_SCSI_INIA100=y
> # CONFIG_SCSI_STEX is not set
> CONFIG_SCSI_SYM53C8XX_2=y
> CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=1
> CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=16
> CONFIG_SCSI_SYM53C8XX_MAX_TAGS=64
> CONFIG_SCSI_SYM53C8XX_MMIO=y
> CONFIG_SCSI_IPR=y
> # CONFIG_SCSI_IPR_TRACE is not set
> CONFIG_SCSI_IPR_DUMP=y
> CONFIG_SCSI_QLOGIC_1280=y
> CONFIG_SCSI_QLA_FC=y
> CONFIG_SCSI_QLA_ISCSI=y
> # CONFIG_QEDI is not set
> # CONFIG_SCSI_LPFC is not set
> CONFIG_SCSI_DC395x=y
> CONFIG_SCSI_AM53C974=y
> # CONFIG_SCSI_WD719X is not set
> # CONFIG_SCSI_DEBUG is not set
> # CONFIG_SCSI_PMCRAID is not set
> CONFIG_SCSI_PM8001=y
> CONFIG_SCSI_BFA_FC=y
> CONFIG_SCSI_VIRTIO=y
> CONFIG_SCSI_CHELSIO_FCOE=y
> # CONFIG_SCSI_DH is not set
> CONFIG_SCSI_OSD_INITIATOR=y
> CONFIG_SCSI_OSD_ULD=y
> CONFIG_SCSI_OSD_DPRINT_SENSE=1
> CONFIG_SCSI_OSD_DEBUG=y
> CONFIG_ATA=y
> # CONFIG_ATA_VERBOSE_ERROR is not set
> # CONFIG_ATA_ACPI is not set
> # CONFIG_SATA_PMP is not set
> 
> #
> # Controllers with non-SFF native interface
> #
> CONFIG_SATA_AHCI=y
> CONFIG_SATA_MOBILE_LPM_POLICY=0
> CONFIG_SATA_AHCI_PLATFORM=y
> CONFIG_SATA_INIC162X=y
> # CONFIG_SATA_ACARD_AHCI is not set
> # CONFIG_SATA_SIL24 is not set
> # CONFIG_ATA_SFF is not set
> # CONFIG_MD is not set
> # CONFIG_TARGET_CORE is not set
> CONFIG_FUSION=y
> CONFIG_FUSION_SPI=y
> CONFIG_FUSION_FC=y
> CONFIG_FUSION_SAS=y
> CONFIG_FUSION_MAX_SGE=128
> CONFIG_FUSION_CTL=y
> # CONFIG_FUSION_LAN is not set
> # CONFIG_FUSION_LOGGING is not set
> 
> #
> # IEEE 1394 (FireWire) support
> #
> CONFIG_FIREWIRE=y
> CONFIG_FIREWIRE_OHCI=y
> CONFIG_FIREWIRE_SBP2=y
> # CONFIG_FIREWIRE_NET is not set
> CONFIG_FIREWIRE_NOSY=y
> CONFIG_MACINTOSH_DRIVERS=y
> CONFIG_MAC_EMUMOUSEBTN=y
> CONFIG_NETDEVICES=y
> CONFIG_MII=y
> CONFIG_NET_CORE=y
> # CONFIG_BONDING is not set
> # CONFIG_DUMMY is not set
> CONFIG_EQUALIZER=y
> CONFIG_NET_FC=y
> CONFIG_NET_TEAM=y
> CONFIG_NET_TEAM_MODE_BROADCAST=y
> # CONFIG_NET_TEAM_MODE_ROUNDROBIN is not set
> CONFIG_NET_TEAM_MODE_RANDOM=y
> # CONFIG_NET_TEAM_MODE_ACTIVEBACKUP is not set
> CONFIG_NET_TEAM_MODE_LOADBALANCE=y
> CONFIG_MACVLAN=y
> # CONFIG_MACVTAP is not set
> # CONFIG_VXLAN is not set
> CONFIG_MACSEC=y
> CONFIG_NETCONSOLE=y
> # CONFIG_NETCONSOLE_DYNAMIC is not set
> CONFIG_NETPOLL=y
> CONFIG_NET_POLL_CONTROLLER=y
> CONFIG_RIONET=y
> CONFIG_RIONET_TX_SIZE=128
> CONFIG_RIONET_RX_SIZE=128
> # CONFIG_TUN is not set
> # CONFIG_TUN_VNET_CROSS_LE is not set
> CONFIG_VETH=y
> # CONFIG_VIRTIO_NET is not set
> # CONFIG_NLMON is not set
> # CONFIG_VSOCKMON is not set
> CONFIG_ARCNET=y
> # CONFIG_ARCNET_1201 is not set
> CONFIG_ARCNET_1051=y
> # CONFIG_ARCNET_RAW is not set
> CONFIG_ARCNET_CAP=y
> CONFIG_ARCNET_COM90xx=y
> # CONFIG_ARCNET_COM90xxIO is not set
> CONFIG_ARCNET_RIM_I=y
> CONFIG_ARCNET_COM20020=y
> # CONFIG_ARCNET_COM20020_PCI is not set
> 
> #
> # CAIF transport drivers
> #
> CONFIG_CAIF_TTY=y
> CONFIG_CAIF_SPI_SLAVE=y
> # CONFIG_CAIF_SPI_SYNC is not set
> CONFIG_CAIF_HSI=y
> # CONFIG_CAIF_VIRTIO is not set
> 
> #
> # Distributed Switch Architecture drivers
> #
> CONFIG_ETHERNET=y
> CONFIG_MDIO=y
> # CONFIG_NET_VENDOR_3COM is not set
> CONFIG_NET_VENDOR_ADAPTEC=y
> CONFIG_ADAPTEC_STARFIRE=y
> CONFIG_NET_VENDOR_AGERE=y
> # CONFIG_ET131X is not set
> # CONFIG_NET_VENDOR_ALACRITECH is not set
> CONFIG_NET_VENDOR_ALTEON=y
> CONFIG_ACENIC=y
> CONFIG_ACENIC_OMIT_TIGON_I=y
> CONFIG_ALTERA_TSE=y
> CONFIG_NET_VENDOR_AMAZON=y
> # CONFIG_NET_VENDOR_AMD is not set
> CONFIG_NET_VENDOR_AQUANTIA=y
> # CONFIG_AQTION is not set
> # CONFIG_NET_VENDOR_ARC is not set
> CONFIG_NET_VENDOR_ATHEROS=y
> # CONFIG_ATL2 is not set
> CONFIG_ATL1=y
> # CONFIG_ATL1E is not set
> # CONFIG_ATL1C is not set
> CONFIG_ALX=y
> # CONFIG_NET_VENDOR_AURORA is not set
> CONFIG_NET_VENDOR_BROADCOM=y
> # CONFIG_B44 is not set
> CONFIG_BNX2=y
> CONFIG_CNIC=y
> # CONFIG_TIGON3 is not set
> CONFIG_BNX2X=y
> # CONFIG_BNX2X_SRIOV is not set
> CONFIG_BNXT=y
> # CONFIG_BNXT_SRIOV is not set
> CONFIG_BNXT_FLOWER_OFFLOAD=y
> CONFIG_NET_VENDOR_BROCADE=y
> CONFIG_BNA=y
> CONFIG_NET_CADENCE=y
> CONFIG_MACB=y
> CONFIG_MACB_USE_HWSTAMP=y
> # CONFIG_MACB_PCI is not set
> # CONFIG_NET_VENDOR_CAVIUM is not set
> CONFIG_NET_VENDOR_CHELSIO=y
> # CONFIG_CHELSIO_T1 is not set
> # CONFIG_CHELSIO_T3 is not set
> CONFIG_CHELSIO_T4=y
> CONFIG_CHELSIO_T4VF=y
> # CONFIG_NET_VENDOR_CISCO is not set
> # CONFIG_NET_VENDOR_CORTINA is not set
> CONFIG_CX_ECAT=y
> CONFIG_DNET=y
> CONFIG_NET_VENDOR_DEC=y
> # CONFIG_NET_TULIP is not set
> CONFIG_NET_VENDOR_DLINK=y
> CONFIG_DL2K=y
> # CONFIG_SUNDANCE is not set
> # CONFIG_NET_VENDOR_EMULEX is not set
> CONFIG_NET_VENDOR_EZCHIP=y
> CONFIG_NET_VENDOR_HP=y
> CONFIG_HP100=y
> # CONFIG_NET_VENDOR_HUAWEI is not set
> CONFIG_NET_VENDOR_I825XX=y
> CONFIG_NET_VENDOR_INTEL=y
> # CONFIG_E100 is not set
> CONFIG_E1000=y
> CONFIG_E1000E=y
> CONFIG_E1000E_HWTS=y
> CONFIG_IGB=y
> CONFIG_IGB_HWMON=y
> CONFIG_IGB_DCA=y
> # CONFIG_IGBVF is not set
> # CONFIG_IXGB is not set
> CONFIG_IXGBE=y
> CONFIG_IXGBE_HWMON=y
> CONFIG_IXGBE_DCA=y
> # CONFIG_I40E is not set
> # CONFIG_NET_VENDOR_EXAR is not set
> CONFIG_JME=y
> # CONFIG_NET_VENDOR_MARVELL is not set
> CONFIG_NET_VENDOR_MELLANOX=y
> # CONFIG_MLX4_EN is not set
> CONFIG_MLX5_CORE=y
> # CONFIG_MLX5_FPGA is not set
> # CONFIG_MLX5_CORE_EN is not set
> # CONFIG_MLXSW_CORE is not set
> # CONFIG_MLXFW is not set
> CONFIG_NET_VENDOR_MICREL=y
> CONFIG_KS8842=y
> CONFIG_KS8851_MLL=y
> # CONFIG_KSZ884X_PCI is not set
> # CONFIG_NET_VENDOR_MICROSEMI is not set
> CONFIG_NET_VENDOR_MYRI=y
> # CONFIG_MYRI10GE is not set
> # CONFIG_FEALNX is not set
> # CONFIG_NET_VENDOR_NATSEMI is not set
> CONFIG_NET_VENDOR_NETRONOME=y
> CONFIG_NET_VENDOR_NI=y
> CONFIG_NET_VENDOR_NVIDIA=y
> CONFIG_FORCEDETH=y
> # CONFIG_NET_VENDOR_OKI is not set
> CONFIG_ETHOC=y
> CONFIG_NET_PACKET_ENGINE=y
> CONFIG_HAMACHI=y
> CONFIG_YELLOWFIN=y
> CONFIG_NET_VENDOR_QLOGIC=y
> CONFIG_QLA3XXX=y
> CONFIG_QLCNIC=y
> # CONFIG_QLCNIC_SRIOV is not set
> # CONFIG_QLCNIC_HWMON is not set
> CONFIG_QLGE=y
> # CONFIG_NETXEN_NIC is not set
> CONFIG_QED=y
> # CONFIG_QED_SRIOV is not set
> CONFIG_QEDE=y
> # CONFIG_NET_VENDOR_QUALCOMM is not set
> CONFIG_NET_VENDOR_RDC=y
> # CONFIG_R6040 is not set
> # CONFIG_NET_VENDOR_REALTEK is not set
> CONFIG_NET_VENDOR_RENESAS=y
> CONFIG_NET_VENDOR_ROCKER=y
> # CONFIG_NET_VENDOR_SAMSUNG is not set
> CONFIG_NET_VENDOR_SEEQ=y
> # CONFIG_NET_VENDOR_SOLARFLARE is not set
> # CONFIG_NET_VENDOR_SILAN is not set
> CONFIG_NET_VENDOR_SIS=y
> CONFIG_SIS900=y
> CONFIG_SIS190=y
> # CONFIG_NET_VENDOR_SMSC is not set
> CONFIG_NET_VENDOR_SOCIONEXT=y
> # CONFIG_NET_VENDOR_STMICRO is not set
> # CONFIG_NET_VENDOR_SUN is not set
> # CONFIG_NET_VENDOR_SYNOPSYS is not set
> # CONFIG_NET_VENDOR_TEHUTI is not set
> CONFIG_NET_VENDOR_TI=y
> # CONFIG_TI_CPSW_ALE is not set
> # CONFIG_TLAN is not set
> # CONFIG_NET_VENDOR_VIA is not set
> # CONFIG_NET_VENDOR_WIZNET is not set
> CONFIG_FDDI=y
> CONFIG_DEFXX=y
> # CONFIG_DEFXX_MMIO is not set
> # CONFIG_SKFP is not set
> # CONFIG_HIPPI is not set
> CONFIG_NET_SB1000=y
> CONFIG_MDIO_DEVICE=y
> CONFIG_MDIO_BUS=y
> CONFIG_MDIO_BITBANG=y
> # CONFIG_MDIO_GPIO is not set
> CONFIG_MDIO_MSCC_MIIM=y
> # CONFIG_MDIO_THUNDER is not set
> CONFIG_PHYLIB=y
> CONFIG_SWPHY=y
> # CONFIG_LED_TRIGGER_PHY is not set
> 
> #
> # MII PHY device drivers
> #
> CONFIG_AMD_PHY=y
> CONFIG_AQUANTIA_PHY=y
> CONFIG_ASIX_PHY=y
> CONFIG_AT803X_PHY=y
> CONFIG_BCM7XXX_PHY=y
> # CONFIG_BCM87XX_PHY is not set
> CONFIG_BCM_NET_PHYLIB=y
> # CONFIG_BROADCOM_PHY is not set
> CONFIG_CICADA_PHY=y
> CONFIG_CORTINA_PHY=y
> CONFIG_DAVICOM_PHY=y
> CONFIG_DP83822_PHY=y
> CONFIG_DP83TC811_PHY=y
> # CONFIG_DP83848_PHY is not set
> # CONFIG_DP83867_PHY is not set
> CONFIG_FIXED_PHY=y
> CONFIG_ICPLUS_PHY=y
> CONFIG_INTEL_XWAY_PHY=y
> CONFIG_LSI_ET1011C_PHY=y
> CONFIG_LXT_PHY=y
> CONFIG_MARVELL_PHY=y
> CONFIG_MARVELL_10G_PHY=y
> CONFIG_MICREL_PHY=y
> CONFIG_MICROCHIP_PHY=y
> CONFIG_MICROCHIP_T1_PHY=y
> CONFIG_MICROSEMI_PHY=y
> CONFIG_NATIONAL_PHY=y
> # CONFIG_QSEMI_PHY is not set
> # CONFIG_REALTEK_PHY is not set
> CONFIG_RENESAS_PHY=y
> CONFIG_ROCKCHIP_PHY=y
> # CONFIG_SMSC_PHY is not set
> CONFIG_STE10XP=y
> CONFIG_TERANETICS_PHY=y
> # CONFIG_VITESSE_PHY is not set
> CONFIG_XILINX_GMII2RGMII=y
> # CONFIG_PPP is not set
> # CONFIG_SLIP is not set
> CONFIG_USB_NET_DRIVERS=y
> CONFIG_USB_CATC=y
> CONFIG_USB_KAWETH=y
> CONFIG_USB_PEGASUS=y
> CONFIG_USB_RTL8150=y
> # CONFIG_USB_RTL8152 is not set
> CONFIG_USB_LAN78XX=y
> # CONFIG_USB_USBNET is not set
> # CONFIG_USB_HSO is not set
> CONFIG_USB_IPHETH=y
> CONFIG_WLAN=y
> CONFIG_WLAN_VENDOR_ADMTEK=y
> CONFIG_ADM8211=y
> # CONFIG_WLAN_VENDOR_ATH is not set
> # CONFIG_WLAN_VENDOR_ATMEL is not set
> CONFIG_WLAN_VENDOR_BROADCOM=y
> # CONFIG_B43 is not set
> # CONFIG_B43LEGACY is not set
> CONFIG_BRCMUTIL=y
> # CONFIG_BRCMSMAC is not set
> CONFIG_BRCMFMAC=y
> CONFIG_BRCMFMAC_PROTO_BCDC=y
> CONFIG_BRCMFMAC_SDIO=y
> CONFIG_BRCMFMAC_USB=y
> # CONFIG_BRCMFMAC_PCIE is not set
> CONFIG_BRCM_TRACING=y
> # CONFIG_BRCMDBG is not set
> CONFIG_WLAN_VENDOR_CISCO=y
> CONFIG_AIRO=y
> CONFIG_WLAN_VENDOR_INTEL=y
> CONFIG_IPW2100=y
> # CONFIG_IPW2100_MONITOR is not set
> # CONFIG_IPW2100_DEBUG is not set
> CONFIG_IPW2200=y
> CONFIG_IPW2200_MONITOR=y
> CONFIG_IPW2200_RADIOTAP=y
> CONFIG_IPW2200_PROMISCUOUS=y
> CONFIG_IPW2200_QOS=y
> # CONFIG_IPW2200_DEBUG is not set
> CONFIG_LIBIPW=y
> # CONFIG_LIBIPW_DEBUG is not set
> CONFIG_IWLEGACY=y
> CONFIG_IWL4965=y
> # CONFIG_IWL3945 is not set
> 
> #
> # iwl3945 / iwl4965 Debugging Options
> #
> # CONFIG_IWLEGACY_DEBUG is not set
> CONFIG_IWLWIFI=y
> CONFIG_IWLWIFI_LEDS=y
> CONFIG_IWLDVM=y
> CONFIG_IWLMVM=y
> # CONFIG_IWLWIFI_BCAST_FILTERING is not set
> 
> #
> # Debugging Options
> #
> # CONFIG_IWLWIFI_DEBUG is not set
> CONFIG_IWLWIFI_DEVICE_TRACING=y
> CONFIG_WLAN_VENDOR_INTERSIL=y
> CONFIG_HOSTAP=y
> # CONFIG_HOSTAP_FIRMWARE is not set
> CONFIG_HOSTAP_PLX=y
> CONFIG_HOSTAP_PCI=y
> CONFIG_HERMES=y
> # CONFIG_HERMES_PRISM is not set
> CONFIG_HERMES_CACHE_FW_ON_INIT=y
> CONFIG_PLX_HERMES=y
> CONFIG_TMD_HERMES=y
> CONFIG_NORTEL_HERMES=y
> CONFIG_ORINOCO_USB=y
> CONFIG_P54_COMMON=y
> CONFIG_P54_USB=y
> CONFIG_P54_PCI=y
> CONFIG_P54_LEDS=y
> CONFIG_PRISM54=y
> # CONFIG_WLAN_VENDOR_MARVELL is not set
> # CONFIG_WLAN_VENDOR_MEDIATEK is not set
> CONFIG_WLAN_VENDOR_RALINK=y
> CONFIG_RT2X00=y
> # CONFIG_RT2400PCI is not set
> # CONFIG_RT2500PCI is not set
> # CONFIG_RT61PCI is not set
> CONFIG_RT2800PCI=y
> CONFIG_RT2800PCI_RT33XX=y
> CONFIG_RT2800PCI_RT35XX=y
> # CONFIG_RT2800PCI_RT53XX is not set
> CONFIG_RT2800PCI_RT3290=y
> CONFIG_RT2500USB=y
> CONFIG_RT73USB=y
> CONFIG_RT2800USB=y
> CONFIG_RT2800USB_RT33XX=y
> CONFIG_RT2800USB_RT35XX=y
> # CONFIG_RT2800USB_RT3573 is not set
> # CONFIG_RT2800USB_RT53XX is not set
> # CONFIG_RT2800USB_RT55XX is not set
> # CONFIG_RT2800USB_UNKNOWN is not set
> CONFIG_RT2800_LIB=y
> CONFIG_RT2800_LIB_MMIO=y
> CONFIG_RT2X00_LIB_MMIO=y
> CONFIG_RT2X00_LIB_PCI=y
> CONFIG_RT2X00_LIB_USB=y
> CONFIG_RT2X00_LIB=y
> CONFIG_RT2X00_LIB_FIRMWARE=y
> CONFIG_RT2X00_LIB_CRYPTO=y
> CONFIG_RT2X00_LIB_LEDS=y
> CONFIG_RT2X00_DEBUG=y
> CONFIG_WLAN_VENDOR_REALTEK=y
> # CONFIG_RTL8180 is not set
> CONFIG_RTL8187=y
> CONFIG_RTL8187_LEDS=y
> CONFIG_RTL_CARDS=y
> # CONFIG_RTL8192CE is not set
> CONFIG_RTL8192SE=y
> # CONFIG_RTL8192DE is not set
> # CONFIG_RTL8723AE is not set
> # CONFIG_RTL8723BE is not set
> CONFIG_RTL8188EE=y
> # CONFIG_RTL8192EE is not set
> CONFIG_RTL8821AE=y
> # CONFIG_RTL8192CU is not set
> CONFIG_RTLWIFI=y
> CONFIG_RTLWIFI_PCI=y
> CONFIG_RTLWIFI_DEBUG=y
> CONFIG_RTLBTCOEXIST=y
> # CONFIG_RTL8XXXU is not set
> # CONFIG_WLAN_VENDOR_RSI is not set
> # CONFIG_WLAN_VENDOR_ST is not set
> # CONFIG_WLAN_VENDOR_TI is not set
> # CONFIG_WLAN_VENDOR_ZYDAS is not set
> CONFIG_WLAN_VENDOR_QUANTENNA=y
> CONFIG_QTNFMAC=y
> CONFIG_QTNFMAC_PEARL_PCIE=y
> CONFIG_MAC80211_HWSIM=y
> # CONFIG_USB_NET_RNDIS_WLAN is not set
> 
> #
> # Enable WiMAX (Networking options) to see the WiMAX drivers
> #
> # CONFIG_WAN is not set
> # CONFIG_XEN_NETDEV_FRONTEND is not set
> # CONFIG_VMXNET3 is not set
> # CONFIG_FUJITSU_ES is not set
> # CONFIG_THUNDERBOLT_NET is not set
> CONFIG_HYPERV_NET=y
> CONFIG_NETDEVSIM=y
> # CONFIG_NET_FAILOVER is not set
> # CONFIG_ISDN is not set
> CONFIG_NVM=y
> # CONFIG_NVM_DEBUG is not set
> # CONFIG_NVM_PBLK is not set
> 
> #
> # Input device support
> #
> CONFIG_INPUT=y
> # CONFIG_INPUT_LEDS is not set
> CONFIG_INPUT_FF_MEMLESS=y
> CONFIG_INPUT_POLLDEV=y
> CONFIG_INPUT_SPARSEKMAP=y
> CONFIG_INPUT_MATRIXKMAP=y
> 
> #
> # Userland interfaces
> #
> CONFIG_INPUT_MOUSEDEV=y
> # CONFIG_INPUT_MOUSEDEV_PSAUX is not set
> CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
> CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
> # CONFIG_INPUT_JOYDEV is not set
> CONFIG_INPUT_EVDEV=y
> # CONFIG_INPUT_EVBUG is not set
> 
> #
> # Input Device Drivers
> #
> CONFIG_INPUT_KEYBOARD=y
> CONFIG_KEYBOARD_ADP5588=y
> CONFIG_KEYBOARD_ADP5589=y
> CONFIG_KEYBOARD_ATKBD=y
> # CONFIG_KEYBOARD_QT1070 is not set
> CONFIG_KEYBOARD_QT2160=y
> CONFIG_KEYBOARD_DLINK_DIR685=y
> CONFIG_KEYBOARD_LKKBD=y
> CONFIG_KEYBOARD_GPIO=y
> CONFIG_KEYBOARD_GPIO_POLLED=y
> # CONFIG_KEYBOARD_TCA6416 is not set
> CONFIG_KEYBOARD_TCA8418=y
> CONFIG_KEYBOARD_MATRIX=y
> CONFIG_KEYBOARD_LM8323=y
> CONFIG_KEYBOARD_LM8333=y
> # CONFIG_KEYBOARD_MAX7359 is not set
> CONFIG_KEYBOARD_MCS=y
> CONFIG_KEYBOARD_MPR121=y
> CONFIG_KEYBOARD_NEWTON=y
> CONFIG_KEYBOARD_OPENCORES=y
> # CONFIG_KEYBOARD_SAMSUNG is not set
> CONFIG_KEYBOARD_GOLDFISH_EVENTS=y
> CONFIG_KEYBOARD_STOWAWAY=y
> CONFIG_KEYBOARD_SUNKBD=y
> CONFIG_KEYBOARD_TM2_TOUCHKEY=y
> # CONFIG_KEYBOARD_XTKBD is not set
> CONFIG_KEYBOARD_MTK_PMIC=y
> CONFIG_INPUT_MOUSE=y
> # CONFIG_MOUSE_PS2 is not set
> CONFIG_MOUSE_SERIAL=y
> CONFIG_MOUSE_APPLETOUCH=y
> CONFIG_MOUSE_BCM5974=y
> # CONFIG_MOUSE_CYAPA is not set
> CONFIG_MOUSE_ELAN_I2C=y
> # CONFIG_MOUSE_ELAN_I2C_I2C is not set
> CONFIG_MOUSE_ELAN_I2C_SMBUS=y
> CONFIG_MOUSE_VSXXXAA=y
> CONFIG_MOUSE_GPIO=y
> # CONFIG_MOUSE_SYNAPTICS_I2C is not set
> CONFIG_MOUSE_SYNAPTICS_USB=y
> CONFIG_INPUT_JOYSTICK=y
> CONFIG_JOYSTICK_ANALOG=y
> CONFIG_JOYSTICK_A3D=y
> # CONFIG_JOYSTICK_ADI is not set
> # CONFIG_JOYSTICK_COBRA is not set
> CONFIG_JOYSTICK_GF2K=y
> CONFIG_JOYSTICK_GRIP=y
> # CONFIG_JOYSTICK_GRIP_MP is not set
> CONFIG_JOYSTICK_GUILLEMOT=y
> # CONFIG_JOYSTICK_INTERACT is not set
> CONFIG_JOYSTICK_SIDEWINDER=y
> # CONFIG_JOYSTICK_TMDC is not set
> # CONFIG_JOYSTICK_IFORCE is not set
> CONFIG_JOYSTICK_WARRIOR=y
> # CONFIG_JOYSTICK_MAGELLAN is not set
> CONFIG_JOYSTICK_SPACEORB=y
> CONFIG_JOYSTICK_SPACEBALL=y
> CONFIG_JOYSTICK_STINGER=y
> # CONFIG_JOYSTICK_TWIDJOY is not set
> CONFIG_JOYSTICK_ZHENHUA=y
> CONFIG_JOYSTICK_AS5011=y
> # CONFIG_JOYSTICK_JOYDUMP is not set
> CONFIG_JOYSTICK_XPAD=y
> # CONFIG_JOYSTICK_XPAD_FF is not set
> CONFIG_JOYSTICK_XPAD_LEDS=y
> CONFIG_JOYSTICK_PXRC=y
> # CONFIG_INPUT_TABLET is not set
> # CONFIG_INPUT_TOUCHSCREEN is not set
> CONFIG_INPUT_MISC=y
> # CONFIG_INPUT_88PM860X_ONKEY is not set
> CONFIG_INPUT_88PM80X_ONKEY=y
> CONFIG_INPUT_AD714X=y
> # CONFIG_INPUT_AD714X_I2C is not set
> CONFIG_INPUT_BMA150=y
> # CONFIG_INPUT_E3X0_BUTTON is not set
> CONFIG_INPUT_PCSPKR=y
> CONFIG_INPUT_MAX8925_ONKEY=y
> # CONFIG_INPUT_MC13783_PWRBUTTON is not set
> # CONFIG_INPUT_MMA8450 is not set
> # CONFIG_INPUT_APANEL is not set
> CONFIG_INPUT_GP2A=y
> # CONFIG_INPUT_GPIO_BEEPER is not set
> CONFIG_INPUT_GPIO_DECODER=y
> # CONFIG_INPUT_ATLAS_BTNS is not set
> CONFIG_INPUT_ATI_REMOTE2=y
> CONFIG_INPUT_KEYSPAN_REMOTE=y
> CONFIG_INPUT_KXTJ9=y
> CONFIG_INPUT_KXTJ9_POLLED_MODE=y
> # CONFIG_INPUT_POWERMATE is not set
> CONFIG_INPUT_YEALINK=y
> # CONFIG_INPUT_CM109 is not set
> CONFIG_INPUT_REGULATOR_HAPTIC=y
> # CONFIG_INPUT_AXP20X_PEK is not set
> CONFIG_INPUT_UINPUT=y
> # CONFIG_INPUT_PALMAS_PWRBUTTON is not set
> # CONFIG_INPUT_PCF50633_PMU is not set
> CONFIG_INPUT_PCF8574=y
> CONFIG_INPUT_GPIO_ROTARY_ENCODER=y
> # CONFIG_INPUT_DA9052_ONKEY is not set
> # CONFIG_INPUT_DA9055_ONKEY is not set
> # CONFIG_INPUT_DA9063_ONKEY is not set
> # CONFIG_INPUT_WM831X_ON is not set
> CONFIG_INPUT_ADXL34X=y
> CONFIG_INPUT_ADXL34X_I2C=y
> CONFIG_INPUT_IMS_PCU=y
> # CONFIG_INPUT_CMA3000 is not set
> # CONFIG_INPUT_XEN_KBDDEV_FRONTEND is not set
> CONFIG_INPUT_IDEAPAD_SLIDEBAR=y
> CONFIG_INPUT_SOC_BUTTON_ARRAY=y
> CONFIG_INPUT_DRV260X_HAPTICS=y
> # CONFIG_INPUT_DRV2665_HAPTICS is not set
> CONFIG_INPUT_DRV2667_HAPTICS=y
> CONFIG_INPUT_RAVE_SP_PWRBUTTON=y
> CONFIG_RMI4_CORE=y
> CONFIG_RMI4_I2C=y
> CONFIG_RMI4_SMB=y
> CONFIG_RMI4_F03=y
> CONFIG_RMI4_F03_SERIO=y
> CONFIG_RMI4_2D_SENSOR=y
> CONFIG_RMI4_F11=y
> CONFIG_RMI4_F12=y
> CONFIG_RMI4_F30=y
> CONFIG_RMI4_F34=y
> # CONFIG_RMI4_F54 is not set
> CONFIG_RMI4_F55=y
> 
> #
> # Hardware I/O ports
> #
> CONFIG_SERIO=y
> CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
> CONFIG_SERIO_I8042=y
> CONFIG_SERIO_SERPORT=y
> # CONFIG_SERIO_CT82C710 is not set
> CONFIG_SERIO_PCIPS2=y
> CONFIG_SERIO_LIBPS2=y
> # CONFIG_SERIO_RAW is not set
> CONFIG_SERIO_ALTERA_PS2=y
> # CONFIG_SERIO_PS2MULT is not set
> CONFIG_SERIO_ARC_PS2=y
> CONFIG_HYPERV_KEYBOARD=y
> CONFIG_SERIO_GPIO_PS2=y
> CONFIG_USERIO=y
> CONFIG_GAMEPORT=y
> CONFIG_GAMEPORT_NS558=y
> # CONFIG_GAMEPORT_L4 is not set
> # CONFIG_GAMEPORT_EMU10K1 is not set
> # CONFIG_GAMEPORT_FM801 is not set
> 
> #
> # Character devices
> #
> CONFIG_TTY=y
> CONFIG_VT=y
> CONFIG_CONSOLE_TRANSLATIONS=y
> CONFIG_VT_CONSOLE=y
> CONFIG_VT_CONSOLE_SLEEP=y
> CONFIG_HW_CONSOLE=y
> CONFIG_VT_HW_CONSOLE_BINDING=y
> CONFIG_UNIX98_PTYS=y
> # CONFIG_LEGACY_PTYS is not set
> # CONFIG_SERIAL_NONSTANDARD is not set
> CONFIG_NOZOMI=y
> CONFIG_N_GSM=y
> # CONFIG_TRACE_SINK is not set
> CONFIG_GOLDFISH_TTY=y
> CONFIG_GOLDFISH_TTY_EARLY_CONSOLE=y
> CONFIG_DEVMEM=y
> # CONFIG_DEVKMEM is not set
> 
> #
> # Serial drivers
> #
> CONFIG_SERIAL_EARLYCON=y
> CONFIG_SERIAL_8250=y
> CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
> CONFIG_SERIAL_8250_PNP=y
> CONFIG_SERIAL_8250_FINTEK=y
> CONFIG_SERIAL_8250_CONSOLE=y
> CONFIG_SERIAL_8250_DMA=y
> CONFIG_SERIAL_8250_PCI=y
> CONFIG_SERIAL_8250_EXAR=y
> CONFIG_SERIAL_8250_NR_UARTS=4
> CONFIG_SERIAL_8250_RUNTIME_UARTS=4
> # CONFIG_SERIAL_8250_EXTENDED is not set
> CONFIG_SERIAL_8250_DW=y
> # CONFIG_SERIAL_8250_RT288X is not set
> # CONFIG_SERIAL_8250_LPSS is not set
> CONFIG_SERIAL_8250_MID=y
> # CONFIG_SERIAL_8250_MOXA is not set
> 
> #
> # Non-8250 serial port support
> #
> CONFIG_SERIAL_UARTLITE=y
> CONFIG_SERIAL_UARTLITE_CONSOLE=y
> CONFIG_SERIAL_UARTLITE_NR_UARTS=1
> CONFIG_SERIAL_CORE=y
> CONFIG_SERIAL_CORE_CONSOLE=y
> CONFIG_SERIAL_JSM=y
> # CONFIG_SERIAL_SCCNXP is not set
> # CONFIG_SERIAL_SC16IS7XX is not set
> CONFIG_SERIAL_ALTERA_JTAGUART=y
> # CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE is not set
> CONFIG_SERIAL_ALTERA_UART=y
> CONFIG_SERIAL_ALTERA_UART_MAXPORTS=4
> CONFIG_SERIAL_ALTERA_UART_BAUDRATE=115200
> CONFIG_SERIAL_ALTERA_UART_CONSOLE=y
> # CONFIG_SERIAL_ARC is not set
> CONFIG_SERIAL_RP2=y
> CONFIG_SERIAL_RP2_NR_UARTS=32
> CONFIG_SERIAL_FSL_LPUART=y
> # CONFIG_SERIAL_FSL_LPUART_CONSOLE is not set
> CONFIG_SERIAL_DEV_BUS=y
> # CONFIG_SERIAL_DEV_CTRL_TTYPORT is not set
> CONFIG_HVC_DRIVER=y
> # CONFIG_HVC_XEN is not set
> CONFIG_VIRTIO_CONSOLE=y
> # CONFIG_IPMI_HANDLER is not set
> CONFIG_HW_RANDOM=y
> CONFIG_HW_RANDOM_TIMERIOMEM=y
> # CONFIG_HW_RANDOM_INTEL is not set
> CONFIG_HW_RANDOM_AMD=y
> CONFIG_HW_RANDOM_VIA=y
> CONFIG_HW_RANDOM_VIRTIO=y
> # CONFIG_NVRAM is not set
> CONFIG_R3964=y
> # CONFIG_APPLICOM is not set
> CONFIG_MWAVE=y
> CONFIG_RAW_DRIVER=y
> CONFIG_MAX_RAW_DEVS=256
> # CONFIG_HPET is not set
> CONFIG_HANGCHECK_TIMER=y
> CONFIG_TCG_TPM=y
> # CONFIG_HW_RANDOM_TPM is not set
> CONFIG_TCG_TIS_CORE=y
> CONFIG_TCG_TIS=y
> # CONFIG_TCG_TIS_I2C_ATMEL is not set
> CONFIG_TCG_TIS_I2C_INFINEON=y
> CONFIG_TCG_TIS_I2C_NUVOTON=y
> CONFIG_TCG_NSC=y
> CONFIG_TCG_ATMEL=y
> # CONFIG_TCG_INFINEON is not set
> CONFIG_TCG_XEN=y
> CONFIG_TCG_CRB=y
> CONFIG_TCG_VTPM_PROXY=y
> # CONFIG_TCG_TIS_ST33ZP24_I2C is not set
> CONFIG_TELCLOCK=y
> CONFIG_DEVPORT=y
> CONFIG_XILLYBUS=y
> 
> #
> # I2C support
> #
> CONFIG_I2C=y
> # CONFIG_ACPI_I2C_OPREGION is not set
> CONFIG_I2C_BOARDINFO=y
> CONFIG_I2C_COMPAT=y
> # CONFIG_I2C_CHARDEV is not set
> CONFIG_I2C_MUX=y
> 
> #
> # Multiplexer I2C Chip support
> #
> CONFIG_I2C_MUX_GPIO=y
> CONFIG_I2C_MUX_LTC4306=y
> CONFIG_I2C_MUX_PCA9541=y
> CONFIG_I2C_MUX_PCA954x=y
> # CONFIG_I2C_MUX_REG is not set
> CONFIG_I2C_MUX_MLXCPLD=y
> CONFIG_I2C_HELPER_AUTO=y
> CONFIG_I2C_SMBUS=y
> CONFIG_I2C_ALGOBIT=y
> CONFIG_I2C_ALGOPCA=y
> 
> #
> # I2C Hardware Bus support
> #
> 
> #
> # PC SMBus host controller drivers
> #
> CONFIG_I2C_ALI1535=y
> # CONFIG_I2C_ALI1563 is not set
> # CONFIG_I2C_ALI15X3 is not set
> # CONFIG_I2C_AMD756 is not set
> CONFIG_I2C_AMD8111=y
> CONFIG_I2C_I801=y
> # CONFIG_I2C_ISCH is not set
> CONFIG_I2C_ISMT=y
> # CONFIG_I2C_PIIX4 is not set
> # CONFIG_I2C_CHT_WC is not set
> CONFIG_I2C_NFORCE2=y
> CONFIG_I2C_NFORCE2_S4985=y
> # CONFIG_I2C_SIS5595 is not set
> CONFIG_I2C_SIS630=y
> CONFIG_I2C_SIS96X=y
> CONFIG_I2C_VIA=y
> CONFIG_I2C_VIAPRO=y
> 
> #
> # ACPI drivers
> #
> CONFIG_I2C_SCMI=y
> 
> #
> # I2C system bus drivers (mostly embedded / system-on-chip)
> #
> CONFIG_I2C_CBUS_GPIO=y
> CONFIG_I2C_DESIGNWARE_CORE=y
> CONFIG_I2C_DESIGNWARE_PLATFORM=y
> # CONFIG_I2C_DESIGNWARE_SLAVE is not set
> # CONFIG_I2C_DESIGNWARE_PCI is not set
> CONFIG_I2C_DESIGNWARE_BAYTRAIL=y
> # CONFIG_I2C_EMEV2 is not set
> CONFIG_I2C_GPIO=y
> CONFIG_I2C_GPIO_FAULT_INJECTOR=y
> CONFIG_I2C_OCORES=y
> CONFIG_I2C_PCA_PLATFORM=y
> CONFIG_I2C_SIMTEC=y
> CONFIG_I2C_XILINX=y
> 
> #
> # External I2C/SMBus adapter drivers
> #
> # CONFIG_I2C_DIOLAN_U2C is not set
> CONFIG_I2C_PARPORT_LIGHT=y
> CONFIG_I2C_ROBOTFUZZ_OSIF=y
> CONFIG_I2C_TAOS_EVM=y
> # CONFIG_I2C_TINY_USB is not set
> 
> #
> # Other I2C/SMBus bus drivers
> #
> CONFIG_I2C_MLXCPLD=y
> CONFIG_I2C_SLAVE=y
> CONFIG_I2C_SLAVE_EEPROM=y
> # CONFIG_I2C_DEBUG_CORE is not set
> # CONFIG_I2C_DEBUG_ALGO is not set
> # CONFIG_I2C_DEBUG_BUS is not set
> # CONFIG_SPI is not set
> CONFIG_SPMI=y
> CONFIG_HSI=y
> CONFIG_HSI_BOARDINFO=y
> 
> #
> # HSI controllers
> #
> 
> #
> # HSI clients
> #
> # CONFIG_HSI_CHAR is not set
> CONFIG_PPS=y
> # CONFIG_PPS_DEBUG is not set
> 
> #
> # PPS clients support
> #
> CONFIG_PPS_CLIENT_KTIMER=y
> # CONFIG_PPS_CLIENT_LDISC is not set
> CONFIG_PPS_CLIENT_GPIO=y
> 
> #
> # PPS generators support
> #
> 
> #
> # PTP clock support
> #
> CONFIG_PTP_1588_CLOCK=y
> CONFIG_DP83640_PHY=y
> CONFIG_PTP_1588_CLOCK_KVM=y
> CONFIG_PINCTRL=y
> CONFIG_PINMUX=y
> CONFIG_PINCONF=y
> CONFIG_GENERIC_PINCONF=y
> CONFIG_DEBUG_PINCTRL=y
> CONFIG_PINCTRL_AMD=y
> # CONFIG_PINCTRL_MCP23S08 is not set
> CONFIG_PINCTRL_SX150X=y
> # CONFIG_PINCTRL_BAYTRAIL is not set
> # CONFIG_PINCTRL_CHERRYVIEW is not set
> CONFIG_PINCTRL_INTEL=y
> CONFIG_PINCTRL_BROXTON=y
> CONFIG_PINCTRL_CANNONLAKE=y
> CONFIG_PINCTRL_CEDARFORK=y
> CONFIG_PINCTRL_DENVERTON=y
> CONFIG_PINCTRL_GEMINILAKE=y
> CONFIG_PINCTRL_LEWISBURG=y
> CONFIG_PINCTRL_SUNRISEPOINT=y
> CONFIG_GPIOLIB=y
> CONFIG_GPIOLIB_FASTPATH_LIMIT=512
> CONFIG_GPIO_ACPI=y
> CONFIG_GPIOLIB_IRQCHIP=y
> # CONFIG_DEBUG_GPIO is not set
> CONFIG_GPIO_SYSFS=y
> CONFIG_GPIO_GENERIC=y
> CONFIG_GPIO_MAX730X=y
> 
> #
> # Memory mapped GPIO drivers
> #
> # CONFIG_GPIO_AMDPT is not set
> # CONFIG_GPIO_DWAPB is not set
> # CONFIG_GPIO_EXAR is not set
> CONFIG_GPIO_GENERIC_PLATFORM=y
> CONFIG_GPIO_ICH=y
> # CONFIG_GPIO_LYNXPOINT is not set
> CONFIG_GPIO_MB86S7X=y
> # CONFIG_GPIO_MOCKUP is not set
> CONFIG_GPIO_VX855=y
> 
> #
> # Port-mapped I/O GPIO drivers
> #
> CONFIG_GPIO_F7188X=y
> CONFIG_GPIO_IT87=y
> CONFIG_GPIO_SCH=y
> CONFIG_GPIO_SCH311X=y
> # CONFIG_GPIO_WINBOND is not set
> CONFIG_GPIO_WS16C48=y
> 
> #
> # I2C GPIO expanders
> #
> CONFIG_GPIO_ADP5588=y
> # CONFIG_GPIO_ADP5588_IRQ is not set
> CONFIG_GPIO_MAX7300=y
> CONFIG_GPIO_MAX732X=y
> # CONFIG_GPIO_MAX732X_IRQ is not set
> CONFIG_GPIO_PCA953X=y
> CONFIG_GPIO_PCA953X_IRQ=y
> CONFIG_GPIO_PCF857X=y
> # CONFIG_GPIO_TPIC2810 is not set
> 
> #
> # MFD GPIO expanders
> #
> CONFIG_GPIO_ARIZONA=y
> CONFIG_GPIO_BD9571MWV=y
> # CONFIG_GPIO_DA9052 is not set
> CONFIG_GPIO_DA9055=y
> CONFIG_GPIO_JANZ_TTL=y
> CONFIG_GPIO_LP873X=y
> # CONFIG_GPIO_PALMAS is not set
> CONFIG_GPIO_RC5T583=y
> CONFIG_GPIO_TPS65086=y
> CONFIG_GPIO_TPS6586X=y
> CONFIG_GPIO_TPS65910=y
> CONFIG_GPIO_TPS68470=y
> CONFIG_GPIO_WHISKEY_COVE=y
> # CONFIG_GPIO_WM831X is not set
> CONFIG_GPIO_WM8994=y
> 
> #
> # PCI GPIO expanders
> #
> CONFIG_GPIO_AMD8111=y
> CONFIG_GPIO_BT8XX=y
> CONFIG_GPIO_ML_IOH=y
> CONFIG_GPIO_PCI_IDIO_16=y
> # CONFIG_GPIO_PCIE_IDIO_24 is not set
> CONFIG_GPIO_RDC321X=y
> 
> #
> # USB GPIO expanders
> #
> CONFIG_W1=y
> CONFIG_W1_CON=y
> 
> #
> # 1-wire Bus Masters
> #
> CONFIG_W1_MASTER_MATROX=y
> CONFIG_W1_MASTER_DS2490=y
> CONFIG_W1_MASTER_DS2482=y
> # CONFIG_W1_MASTER_DS1WM is not set
> CONFIG_W1_MASTER_GPIO=y
> 
> #
> # 1-wire Slaves
> #
> CONFIG_W1_SLAVE_THERM=y
> CONFIG_W1_SLAVE_SMEM=y
> # CONFIG_W1_SLAVE_DS2405 is not set
> CONFIG_W1_SLAVE_DS2408=y
> CONFIG_W1_SLAVE_DS2408_READBACK=y
> CONFIG_W1_SLAVE_DS2413=y
> CONFIG_W1_SLAVE_DS2406=y
> CONFIG_W1_SLAVE_DS2423=y
> CONFIG_W1_SLAVE_DS2805=y
> # CONFIG_W1_SLAVE_DS2431 is not set
> CONFIG_W1_SLAVE_DS2433=y
> # CONFIG_W1_SLAVE_DS2433_CRC is not set
> CONFIG_W1_SLAVE_DS2438=y
> CONFIG_W1_SLAVE_DS2760=y
> CONFIG_W1_SLAVE_DS2780=y
> CONFIG_W1_SLAVE_DS2781=y
> CONFIG_W1_SLAVE_DS28E04=y
> # CONFIG_W1_SLAVE_DS28E17 is not set
> # CONFIG_POWER_AVS is not set
> # CONFIG_POWER_RESET is not set
> CONFIG_POWER_SUPPLY=y
> CONFIG_POWER_SUPPLY_DEBUG=y
> CONFIG_PDA_POWER=y
> # CONFIG_MAX8925_POWER is not set
> CONFIG_WM831X_BACKUP=y
> CONFIG_WM831X_POWER=y
> # CONFIG_TEST_POWER is not set
> CONFIG_BATTERY_88PM860X=y
> CONFIG_BATTERY_DS2760=y
> CONFIG_BATTERY_DS2780=y
> # CONFIG_BATTERY_DS2781 is not set
> CONFIG_BATTERY_DS2782=y
> CONFIG_BATTERY_SBS=y
> # CONFIG_CHARGER_SBS is not set
> # CONFIG_MANAGER_SBS is not set
> # CONFIG_BATTERY_BQ27XXX is not set
> CONFIG_BATTERY_DA9030=y
> CONFIG_BATTERY_DA9052=y
> # CONFIG_AXP288_CHARGER is not set
> CONFIG_BATTERY_MAX17040=y
> CONFIG_BATTERY_MAX17042=y
> CONFIG_BATTERY_MAX1721X=y
> CONFIG_CHARGER_88PM860X=y
> # CONFIG_CHARGER_PCF50633 is not set
> CONFIG_CHARGER_ISP1704=y
> # CONFIG_CHARGER_MAX8903 is not set
> # CONFIG_CHARGER_LP8727 is not set
> # CONFIG_CHARGER_GPIO is not set
> # CONFIG_CHARGER_MANAGER is not set
> CONFIG_CHARGER_LTC3651=y
> # CONFIG_CHARGER_MAX14577 is not set
> CONFIG_CHARGER_MAX77693=y
> # CONFIG_CHARGER_MAX8998 is not set
> # CONFIG_CHARGER_BQ2415X is not set
> CONFIG_CHARGER_BQ24190=y
> # CONFIG_CHARGER_BQ24257 is not set
> # CONFIG_CHARGER_BQ24735 is not set
> CONFIG_CHARGER_BQ25890=y
> # CONFIG_CHARGER_SMB347 is not set
> CONFIG_CHARGER_TPS65090=y
> CONFIG_BATTERY_GAUGE_LTC2941=y
> CONFIG_BATTERY_GOLDFISH=y
> CONFIG_BATTERY_RT5033=y
> CONFIG_CHARGER_RT9455=y
> CONFIG_HWMON=y
> CONFIG_HWMON_VID=y
> CONFIG_HWMON_DEBUG_CHIP=y
> 
> #
> # Native drivers
> #
> # CONFIG_SENSORS_ABITUGURU is not set
> CONFIG_SENSORS_ABITUGURU3=y
> # CONFIG_SENSORS_AD7414 is not set
> # CONFIG_SENSORS_AD7418 is not set
> CONFIG_SENSORS_ADM1021=y
> CONFIG_SENSORS_ADM1025=y
> CONFIG_SENSORS_ADM1026=y
> CONFIG_SENSORS_ADM1029=y
> CONFIG_SENSORS_ADM1031=y
> CONFIG_SENSORS_ADM9240=y
> CONFIG_SENSORS_ADT7X10=y
> CONFIG_SENSORS_ADT7410=y
> # CONFIG_SENSORS_ADT7411 is not set
> CONFIG_SENSORS_ADT7462=y
> CONFIG_SENSORS_ADT7470=y
> CONFIG_SENSORS_ADT7475=y
> CONFIG_SENSORS_ASC7621=y
> # CONFIG_SENSORS_K8TEMP is not set
> # CONFIG_SENSORS_K10TEMP is not set
> # CONFIG_SENSORS_FAM15H_POWER is not set
> # CONFIG_SENSORS_APPLESMC is not set
> CONFIG_SENSORS_ASB100=y
> CONFIG_SENSORS_ASPEED=y
> CONFIG_SENSORS_ATXP1=y
> CONFIG_SENSORS_DS620=y
> CONFIG_SENSORS_DS1621=y
> # CONFIG_SENSORS_DELL_SMM is not set
> CONFIG_SENSORS_DA9052_ADC=y
> # CONFIG_SENSORS_DA9055 is not set
> # CONFIG_SENSORS_I5K_AMB is not set
> # CONFIG_SENSORS_F71805F is not set
> CONFIG_SENSORS_F71882FG=y
> CONFIG_SENSORS_F75375S=y
> CONFIG_SENSORS_MC13783_ADC=y
> CONFIG_SENSORS_FSCHMD=y
> CONFIG_SENSORS_FTSTEUTATES=y
> CONFIG_SENSORS_GL518SM=y
> CONFIG_SENSORS_GL520SM=y
> CONFIG_SENSORS_G760A=y
> # CONFIG_SENSORS_G762 is not set
> CONFIG_SENSORS_HIH6130=y
> # CONFIG_SENSORS_I5500 is not set
> CONFIG_SENSORS_CORETEMP=y
> CONFIG_SENSORS_IT87=y
> CONFIG_SENSORS_JC42=y
> CONFIG_SENSORS_POWR1220=y
> # CONFIG_SENSORS_LINEAGE is not set
> CONFIG_SENSORS_LTC2945=y
> # CONFIG_SENSORS_LTC2990 is not set
> CONFIG_SENSORS_LTC4151=y
> # CONFIG_SENSORS_LTC4215 is not set
> CONFIG_SENSORS_LTC4222=y
> CONFIG_SENSORS_LTC4245=y
> CONFIG_SENSORS_LTC4260=y
> CONFIG_SENSORS_LTC4261=y
> CONFIG_SENSORS_MAX16065=y
> CONFIG_SENSORS_MAX1619=y
> CONFIG_SENSORS_MAX1668=y
> CONFIG_SENSORS_MAX197=y
> CONFIG_SENSORS_MAX6621=y
> CONFIG_SENSORS_MAX6639=y
> CONFIG_SENSORS_MAX6642=y
> CONFIG_SENSORS_MAX6650=y
> CONFIG_SENSORS_MAX6697=y
> CONFIG_SENSORS_MAX31790=y
> CONFIG_SENSORS_MCP3021=y
> CONFIG_SENSORS_TC654=y
> CONFIG_SENSORS_MENF21BMC_HWMON=y
> CONFIG_SENSORS_LM63=y
> CONFIG_SENSORS_LM73=y
> CONFIG_SENSORS_LM75=y
> CONFIG_SENSORS_LM77=y
> CONFIG_SENSORS_LM78=y
> # CONFIG_SENSORS_LM80 is not set
> # CONFIG_SENSORS_LM83 is not set
> CONFIG_SENSORS_LM85=y
> # CONFIG_SENSORS_LM87 is not set
> # CONFIG_SENSORS_LM90 is not set
> CONFIG_SENSORS_LM92=y
> CONFIG_SENSORS_LM93=y
> CONFIG_SENSORS_LM95234=y
> CONFIG_SENSORS_LM95241=y
> CONFIG_SENSORS_LM95245=y
> CONFIG_SENSORS_PC87360=y
> CONFIG_SENSORS_PC87427=y
> CONFIG_SENSORS_NTC_THERMISTOR=y
> CONFIG_SENSORS_NCT6683=y
> CONFIG_SENSORS_NCT6775=y
> # CONFIG_SENSORS_NCT7802 is not set
> # CONFIG_SENSORS_NCT7904 is not set
> CONFIG_SENSORS_PCF8591=y
> CONFIG_PMBUS=y
> CONFIG_SENSORS_PMBUS=y
> CONFIG_SENSORS_ADM1275=y
> CONFIG_SENSORS_IBM_CFFPS=y
> # CONFIG_SENSORS_IR35221 is not set
> CONFIG_SENSORS_LM25066=y
> CONFIG_SENSORS_LTC2978=y
> CONFIG_SENSORS_LTC2978_REGULATOR=y
> CONFIG_SENSORS_LTC3815=y
> CONFIG_SENSORS_MAX16064=y
> CONFIG_SENSORS_MAX20751=y
> # CONFIG_SENSORS_MAX31785 is not set
> # CONFIG_SENSORS_MAX34440 is not set
> # CONFIG_SENSORS_MAX8688 is not set
> # CONFIG_SENSORS_TPS40422 is not set
> # CONFIG_SENSORS_TPS53679 is not set
> CONFIG_SENSORS_UCD9000=y
> # CONFIG_SENSORS_UCD9200 is not set
> CONFIG_SENSORS_ZL6100=y
> CONFIG_SENSORS_SHT15=y
> CONFIG_SENSORS_SHT21=y
> CONFIG_SENSORS_SHT3x=y
> CONFIG_SENSORS_SHTC1=y
> # CONFIG_SENSORS_SIS5595 is not set
> CONFIG_SENSORS_DME1737=y
> # CONFIG_SENSORS_EMC1403 is not set
> # CONFIG_SENSORS_EMC2103 is not set
> CONFIG_SENSORS_EMC6W201=y
> # CONFIG_SENSORS_SMSC47M1 is not set
> CONFIG_SENSORS_SMSC47M192=y
> CONFIG_SENSORS_SMSC47B397=y
> CONFIG_SENSORS_SCH56XX_COMMON=y
> # CONFIG_SENSORS_SCH5627 is not set
> CONFIG_SENSORS_SCH5636=y
> # CONFIG_SENSORS_STTS751 is not set
> CONFIG_SENSORS_SMM665=y
> CONFIG_SENSORS_ADC128D818=y
> CONFIG_SENSORS_ADS1015=y
> CONFIG_SENSORS_ADS7828=y
> CONFIG_SENSORS_AMC6821=y
> CONFIG_SENSORS_INA209=y
> CONFIG_SENSORS_INA2XX=y
> CONFIG_SENSORS_INA3221=y
> # CONFIG_SENSORS_TC74 is not set
> CONFIG_SENSORS_THMC50=y
> CONFIG_SENSORS_TMP102=y
> CONFIG_SENSORS_TMP103=y
> CONFIG_SENSORS_TMP108=y
> CONFIG_SENSORS_TMP401=y
> CONFIG_SENSORS_TMP421=y
> # CONFIG_SENSORS_VIA_CPUTEMP is not set
> CONFIG_SENSORS_VIA686A=y
> CONFIG_SENSORS_VT1211=y
> # CONFIG_SENSORS_VT8231 is not set
> CONFIG_SENSORS_W83773G=y
> CONFIG_SENSORS_W83781D=y
> CONFIG_SENSORS_W83791D=y
> CONFIG_SENSORS_W83792D=y
> # CONFIG_SENSORS_W83793 is not set
> CONFIG_SENSORS_W83795=y
> # CONFIG_SENSORS_W83795_FANCTRL is not set
> CONFIG_SENSORS_W83L785TS=y
> CONFIG_SENSORS_W83L786NG=y
> CONFIG_SENSORS_W83627HF=y
> CONFIG_SENSORS_W83627EHF=y
> CONFIG_SENSORS_WM831X=y
> 
> #
> # ACPI drivers
> #
> CONFIG_SENSORS_ACPI_POWER=y
> CONFIG_SENSORS_ATK0110=y
> CONFIG_THERMAL=y
> # CONFIG_THERMAL_STATISTICS is not set
> CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
> # CONFIG_THERMAL_HWMON is not set
> CONFIG_THERMAL_WRITABLE_TRIPS=y
> CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
> # CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
> # CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
> # CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
> CONFIG_THERMAL_GOV_FAIR_SHARE=y
> CONFIG_THERMAL_GOV_STEP_WISE=y
> CONFIG_THERMAL_GOV_BANG_BANG=y
> CONFIG_THERMAL_GOV_USER_SPACE=y
> # CONFIG_THERMAL_GOV_POWER_ALLOCATOR is not set
> CONFIG_THERMAL_EMULATION=y
> # CONFIG_INTEL_POWERCLAMP is not set
> CONFIG_INTEL_SOC_DTS_IOSF_CORE=y
> CONFIG_INTEL_SOC_DTS_THERMAL=y
> 
> #
> # ACPI INT340X thermal drivers
> #
> CONFIG_INT340X_THERMAL=y
> CONFIG_ACPI_THERMAL_REL=y
> CONFIG_INT3406_THERMAL=y
> CONFIG_INTEL_BXT_PMIC_THERMAL=y
> CONFIG_INTEL_PCH_THERMAL=y
> CONFIG_WATCHDOG=y
> CONFIG_WATCHDOG_CORE=y
> # CONFIG_WATCHDOG_NOWAYOUT is not set
> # CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED is not set
> # CONFIG_WATCHDOG_SYSFS is not set
> 
> #
> # Watchdog Device Drivers
> #
> CONFIG_SOFT_WATCHDOG=y
> # CONFIG_DA9052_WATCHDOG is not set
> CONFIG_DA9055_WATCHDOG=y
> # CONFIG_DA9063_WATCHDOG is not set
> CONFIG_DA9062_WATCHDOG=y
> CONFIG_MENF21BMC_WATCHDOG=y
> CONFIG_WDAT_WDT=y
> # CONFIG_WM831X_WATCHDOG is not set
> # CONFIG_XILINX_WATCHDOG is not set
> CONFIG_ZIIRAVE_WATCHDOG=y
> CONFIG_RAVE_SP_WATCHDOG=y
> CONFIG_CADENCE_WATCHDOG=y
> CONFIG_DW_WATCHDOG=y
> CONFIG_MAX63XX_WATCHDOG=y
> CONFIG_ACQUIRE_WDT=y
> CONFIG_ADVANTECH_WDT=y
> CONFIG_ALIM1535_WDT=y
> # CONFIG_ALIM7101_WDT is not set
> CONFIG_EBC_C384_WDT=y
> # CONFIG_F71808E_WDT is not set
> # CONFIG_SP5100_TCO is not set
> # CONFIG_SBC_FITPC2_WATCHDOG is not set
> # CONFIG_EUROTECH_WDT is not set
> # CONFIG_IB700_WDT is not set
> # CONFIG_IBMASR is not set
> CONFIG_WAFER_WDT=y
> # CONFIG_I6300ESB_WDT is not set
> CONFIG_IE6XX_WDT=y
> CONFIG_ITCO_WDT=y
> CONFIG_ITCO_VENDOR_SUPPORT=y
> # CONFIG_IT8712F_WDT is not set
> # CONFIG_IT87_WDT is not set
> CONFIG_HP_WATCHDOG=y
> CONFIG_HPWDT_NMI_DECODING=y
> # CONFIG_SC1200_WDT is not set
> CONFIG_PC87413_WDT=y
> CONFIG_NV_TCO=y
> CONFIG_60XX_WDT=y
> CONFIG_CPU5_WDT=y
> CONFIG_SMSC_SCH311X_WDT=y
> CONFIG_SMSC37B787_WDT=y
> # CONFIG_VIA_WDT is not set
> CONFIG_W83627HF_WDT=y
> # CONFIG_W83877F_WDT is not set
> # CONFIG_W83977F_WDT is not set
> CONFIG_MACHZ_WDT=y
> CONFIG_SBC_EPX_C3_WATCHDOG=y
> CONFIG_INTEL_MEI_WDT=y
> # CONFIG_NI903X_WDT is not set
> # CONFIG_NIC7018_WDT is not set
> # CONFIG_MEN_A21_WDT is not set
> # CONFIG_XEN_WDT is not set
> 
> #
> # PCI-based Watchdog Cards
> #
> # CONFIG_PCIPCWATCHDOG is not set
> # CONFIG_WDTPCI is not set
> 
> #
> # USB-based Watchdog Cards
> #
> CONFIG_USBPCWATCHDOG=y
> 
> #
> # Watchdog Pretimeout Governors
> #
> # CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set
> CONFIG_SSB_POSSIBLE=y
> CONFIG_SSB=y
> CONFIG_SSB_PCIHOST_POSSIBLE=y
> # CONFIG_SSB_PCIHOST is not set
> CONFIG_SSB_SDIOHOST_POSSIBLE=y
> CONFIG_SSB_SDIOHOST=y
> CONFIG_SSB_DEBUG=y
> # CONFIG_SSB_DRIVER_GPIO is not set
> CONFIG_BCMA_POSSIBLE=y
> # CONFIG_BCMA is not set
> 
> #
> # Multifunction device drivers
> #
> CONFIG_MFD_CORE=y
> # CONFIG_MFD_AS3711 is not set
> # CONFIG_PMIC_ADP5520 is not set
> CONFIG_MFD_AAT2870_CORE=y
> CONFIG_MFD_BCM590XX=y
> CONFIG_MFD_BD9571MWV=y
> CONFIG_MFD_AXP20X=y
> CONFIG_MFD_AXP20X_I2C=y
> # CONFIG_MFD_CROS_EC is not set
> CONFIG_PMIC_DA903X=y
> CONFIG_PMIC_DA9052=y
> CONFIG_MFD_DA9052_I2C=y
> CONFIG_MFD_DA9055=y
> CONFIG_MFD_DA9062=y
> CONFIG_MFD_DA9063=y
> # CONFIG_MFD_DA9150 is not set
> # CONFIG_MFD_DLN2 is not set
> CONFIG_MFD_MC13XXX=y
> CONFIG_MFD_MC13XXX_I2C=y
> CONFIG_HTC_PASIC3=y
> # CONFIG_HTC_I2CPLD is not set
> # CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
> CONFIG_LPC_ICH=y
> CONFIG_LPC_SCH=y
> # CONFIG_INTEL_SOC_PMIC is not set
> CONFIG_INTEL_SOC_PMIC_BXTWC=y
> CONFIG_INTEL_SOC_PMIC_CHTWC=y
> CONFIG_INTEL_SOC_PMIC_CHTDC_TI=y
> CONFIG_MFD_INTEL_LPSS=y
> # CONFIG_MFD_INTEL_LPSS_ACPI is not set
> CONFIG_MFD_INTEL_LPSS_PCI=y
> CONFIG_MFD_JANZ_CMODIO=y
> # CONFIG_MFD_KEMPLD is not set
> CONFIG_MFD_88PM800=y
> CONFIG_MFD_88PM805=y
> CONFIG_MFD_88PM860X=y
> CONFIG_MFD_MAX14577=y
> CONFIG_MFD_MAX77693=y
> CONFIG_MFD_MAX77843=y
> # CONFIG_MFD_MAX8907 is not set
> CONFIG_MFD_MAX8925=y
> # CONFIG_MFD_MAX8997 is not set
> CONFIG_MFD_MAX8998=y
> CONFIG_MFD_MT6397=y
> CONFIG_MFD_MENF21BMC=y
> # CONFIG_MFD_VIPERBOARD is not set
> # CONFIG_MFD_RETU is not set
> CONFIG_MFD_PCF50633=y
> CONFIG_PCF50633_ADC=y
> CONFIG_PCF50633_GPIO=y
> CONFIG_MFD_RDC321X=y
> CONFIG_MFD_RT5033=y
> CONFIG_MFD_RC5T583=y
> # CONFIG_MFD_SEC_CORE is not set
> # CONFIG_MFD_SI476X_CORE is not set
> CONFIG_MFD_SM501=y
> CONFIG_MFD_SM501_GPIO=y
> CONFIG_MFD_SKY81452=y
> # CONFIG_MFD_SMSC is not set
> CONFIG_ABX500_CORE=y
> # CONFIG_AB3100_CORE is not set
> CONFIG_MFD_SYSCON=y
> # CONFIG_MFD_TI_AM335X_TSCADC is not set
> # CONFIG_MFD_LP3943 is not set
> CONFIG_MFD_LP8788=y
> CONFIG_MFD_TI_LMU=y
> CONFIG_MFD_PALMAS=y
> CONFIG_TPS6105X=y
> # CONFIG_TPS65010 is not set
> # CONFIG_TPS6507X is not set
> CONFIG_MFD_TPS65086=y
> CONFIG_MFD_TPS65090=y
> CONFIG_MFD_TPS68470=y
> CONFIG_MFD_TI_LP873X=y
> CONFIG_MFD_TPS6586X=y
> CONFIG_MFD_TPS65910=y
> # CONFIG_MFD_TPS65912_I2C is not set
> # CONFIG_MFD_TPS80031 is not set
> # CONFIG_TWL4030_CORE is not set
> # CONFIG_TWL6040_CORE is not set
> # CONFIG_MFD_WL1273_CORE is not set
> CONFIG_MFD_LM3533=y
> CONFIG_MFD_VX855=y
> CONFIG_MFD_ARIZONA=y
> CONFIG_MFD_ARIZONA_I2C=y
> # CONFIG_MFD_CS47L24 is not set
> CONFIG_MFD_WM5102=y
> # CONFIG_MFD_WM5110 is not set
> # CONFIG_MFD_WM8997 is not set
> # CONFIG_MFD_WM8998 is not set
> # CONFIG_MFD_WM8400 is not set
> CONFIG_MFD_WM831X=y
> CONFIG_MFD_WM831X_I2C=y
> # CONFIG_MFD_WM8350_I2C is not set
> CONFIG_MFD_WM8994=y
> CONFIG_RAVE_SP_CORE=y
> CONFIG_REGULATOR=y
> # CONFIG_REGULATOR_DEBUG is not set
> CONFIG_REGULATOR_FIXED_VOLTAGE=y
> CONFIG_REGULATOR_VIRTUAL_CONSUMER=y
> CONFIG_REGULATOR_USERSPACE_CONSUMER=y
> CONFIG_REGULATOR_88PG86X=y
> CONFIG_REGULATOR_88PM800=y
> CONFIG_REGULATOR_88PM8607=y
> CONFIG_REGULATOR_ACT8865=y
> CONFIG_REGULATOR_AD5398=y
> CONFIG_REGULATOR_ANATOP=y
> CONFIG_REGULATOR_AAT2870=y
> # CONFIG_REGULATOR_AXP20X is not set
> CONFIG_REGULATOR_BCM590XX=y
> CONFIG_REGULATOR_BD9571MWV=y
> CONFIG_REGULATOR_DA903X=y
> # CONFIG_REGULATOR_DA9052 is not set
> # CONFIG_REGULATOR_DA9055 is not set
> CONFIG_REGULATOR_DA9062=y
> CONFIG_REGULATOR_DA9063=y
> CONFIG_REGULATOR_DA9210=y
> CONFIG_REGULATOR_DA9211=y
> # CONFIG_REGULATOR_FAN53555 is not set
> CONFIG_REGULATOR_GPIO=y
> CONFIG_REGULATOR_ISL9305=y
> CONFIG_REGULATOR_ISL6271A=y
> # CONFIG_REGULATOR_LM363X is not set
> # CONFIG_REGULATOR_LP3971 is not set
> # CONFIG_REGULATOR_LP3972 is not set
> CONFIG_REGULATOR_LP872X=y
> CONFIG_REGULATOR_LP8755=y
> CONFIG_REGULATOR_LP8788=y
> CONFIG_REGULATOR_LTC3589=y
> CONFIG_REGULATOR_LTC3676=y
> CONFIG_REGULATOR_MAX14577=y
> CONFIG_REGULATOR_MAX1586=y
> CONFIG_REGULATOR_MAX8649=y
> CONFIG_REGULATOR_MAX8660=y
> # CONFIG_REGULATOR_MAX8925 is not set
> # CONFIG_REGULATOR_MAX8952 is not set
> CONFIG_REGULATOR_MAX8998=y
> CONFIG_REGULATOR_MAX77693=y
> CONFIG_REGULATOR_MC13XXX_CORE=y
> CONFIG_REGULATOR_MC13783=y
> # CONFIG_REGULATOR_MC13892 is not set
> CONFIG_REGULATOR_MT6311=y
> CONFIG_REGULATOR_MT6323=y
> # CONFIG_REGULATOR_MT6397 is not set
> # CONFIG_REGULATOR_PALMAS is not set
> CONFIG_REGULATOR_PCF50633=y
> CONFIG_REGULATOR_PFUZE100=y
> CONFIG_REGULATOR_PV88060=y
> CONFIG_REGULATOR_PV88080=y
> CONFIG_REGULATOR_PV88090=y
> CONFIG_REGULATOR_QCOM_SPMI=y
> # CONFIG_REGULATOR_RC5T583 is not set
> CONFIG_REGULATOR_RT5033=y
> # CONFIG_REGULATOR_SKY81452 is not set
> CONFIG_REGULATOR_TPS51632=y
> # CONFIG_REGULATOR_TPS6105X is not set
> CONFIG_REGULATOR_TPS62360=y
> CONFIG_REGULATOR_TPS65023=y
> CONFIG_REGULATOR_TPS6507X=y
> CONFIG_REGULATOR_TPS65086=y
> # CONFIG_REGULATOR_TPS65090 is not set
> # CONFIG_REGULATOR_TPS65132 is not set
> CONFIG_REGULATOR_TPS6586X=y
> CONFIG_REGULATOR_TPS65910=y
> CONFIG_REGULATOR_WM831X=y
> CONFIG_REGULATOR_WM8994=y
> CONFIG_CEC_CORE=y
> CONFIG_CEC_NOTIFIER=y
> CONFIG_RC_CORE=y
> # CONFIG_RC_MAP is not set
> CONFIG_LIRC=y
> # CONFIG_BPF_LIRC_MODE2 is not set
> # CONFIG_RC_DECODERS is not set
> # CONFIG_RC_DEVICES is not set
> CONFIG_MEDIA_SUPPORT=y
> 
> #
> # Multimedia core support
> #
> # CONFIG_MEDIA_CAMERA_SUPPORT is not set
> CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
> CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
> # CONFIG_MEDIA_RADIO_SUPPORT is not set
> CONFIG_MEDIA_SDR_SUPPORT=y
> # CONFIG_MEDIA_CEC_SUPPORT is not set
> CONFIG_MEDIA_CEC_RC=y
> # CONFIG_MEDIA_CONTROLLER is not set
> CONFIG_VIDEO_DEV=y
> CONFIG_VIDEO_V4L2=y
> CONFIG_VIDEO_ADV_DEBUG=y
> # CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
> CONFIG_VIDEO_PCI_SKELETON=y
> CONFIG_VIDEO_TUNER=y
> CONFIG_V4L2_FWNODE=y
> CONFIG_VIDEOBUF_GEN=y
> CONFIG_VIDEOBUF_DMA_SG=y
> CONFIG_VIDEOBUF_VMALLOC=y
> CONFIG_DVB_CORE=y
> CONFIG_DVB_MMAP=y
> CONFIG_DVB_NET=y
> CONFIG_TTPCI_EEPROM=y
> CONFIG_DVB_MAX_ADAPTERS=16
> CONFIG_DVB_DYNAMIC_MINORS=y
> CONFIG_DVB_DEMUX_SECTION_LOSS_LOG=y
> CONFIG_DVB_ULE_DEBUG=y
> 
> #
> # Media drivers
> #
> # CONFIG_MEDIA_USB_SUPPORT is not set
> CONFIG_MEDIA_PCI_SUPPORT=y
> 
> #
> # Media capture/analog TV support
> #
> # CONFIG_VIDEO_IVTV is not set
> CONFIG_VIDEO_HEXIUM_GEMINI=y
> CONFIG_VIDEO_HEXIUM_ORION=y
> # CONFIG_VIDEO_MXB is not set
> CONFIG_VIDEO_DT3155=y
> 
> #
> # Media capture/analog/hybrid TV support
> #
> CONFIG_VIDEO_CX18=y
> CONFIG_VIDEO_CX25821=y
> # CONFIG_VIDEO_CX88 is not set
> CONFIG_VIDEO_SAA7134=y
> CONFIG_VIDEO_SAA7134_RC=y
> CONFIG_VIDEO_SAA7134_DVB=y
> # CONFIG_VIDEO_SAA7164 is not set
> 
> #
> # Media digital TV PCI Adapters
> #
> # CONFIG_DVB_AV7110 is not set
> CONFIG_DVB_BUDGET_CORE=y
> CONFIG_DVB_BUDGET=y
> # CONFIG_DVB_BUDGET_CI is not set
> CONFIG_DVB_BUDGET_AV=y
> CONFIG_DVB_B2C2_FLEXCOP_PCI=y
> CONFIG_DVB_B2C2_FLEXCOP_PCI_DEBUG=y
> CONFIG_DVB_PLUTO2=y
> # CONFIG_DVB_DM1105 is not set
> CONFIG_DVB_PT1=y
> CONFIG_DVB_PT3=y
> CONFIG_MANTIS_CORE=y
> CONFIG_DVB_MANTIS=y
> CONFIG_DVB_HOPPER=y
> CONFIG_DVB_NGENE=y
> CONFIG_DVB_DDBRIDGE=y
> # CONFIG_DVB_SMIPCIE is not set
> # CONFIG_DVB_PLATFORM_DRIVERS is not set
> CONFIG_SDR_PLATFORM_DRIVERS=y
> 
> #
> # Supported MMC/SDIO adapters
> #
> # CONFIG_SMS_SDIO_DRV is not set
> 
> #
> # Supported FireWire (IEEE 1394) Adapters
> #
> # CONFIG_DVB_FIREDTV is not set
> CONFIG_VIDEO_CX2341X=y
> CONFIG_VIDEO_TVEEPROM=y
> CONFIG_CYPRESS_FIRMWARE=y
> CONFIG_VIDEOBUF2_CORE=y
> CONFIG_VIDEOBUF2_V4L2=y
> CONFIG_VIDEOBUF2_MEMOPS=y
> CONFIG_VIDEOBUF2_DMA_CONTIG=y
> CONFIG_VIDEOBUF2_VMALLOC=y
> CONFIG_VIDEOBUF2_DMA_SG=y
> CONFIG_VIDEOBUF2_DVB=y
> CONFIG_DVB_B2C2_FLEXCOP=y
> CONFIG_DVB_B2C2_FLEXCOP_DEBUG=y
> CONFIG_VIDEO_SAA7146=y
> CONFIG_VIDEO_SAA7146_VV=y
> 
> #
> # Media ancillary drivers (tuners, sensors, i2c, spi, frontends)
> #
> # CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set
> # CONFIG_VIDEO_IR_I2C is not set
> 
> #
> # I2C Encoders, decoders, sensors and other helper chips
> #
> 
> #
> # Audio decoders, processors and mixers
> #
> # CONFIG_VIDEO_TVAUDIO is not set
> CONFIG_VIDEO_TDA7432=y
> # CONFIG_VIDEO_TDA9840 is not set
> # CONFIG_VIDEO_TEA6415C is not set
> CONFIG_VIDEO_TEA6420=y
> CONFIG_VIDEO_MSP3400=y
> CONFIG_VIDEO_CS3308=y
> CONFIG_VIDEO_CS5345=y
> CONFIG_VIDEO_CS53L32A=y
> CONFIG_VIDEO_TLV320AIC23B=y
> CONFIG_VIDEO_UDA1342=y
> CONFIG_VIDEO_WM8775=y
> CONFIG_VIDEO_WM8739=y
> CONFIG_VIDEO_VP27SMPX=y
> CONFIG_VIDEO_SONY_BTF_MPX=y
> 
> #
> # RDS decoders
> #
> CONFIG_VIDEO_SAA6588=y
> 
> #
> # Video decoders
> #
> CONFIG_VIDEO_ADV7183=y
> CONFIG_VIDEO_BT819=y
> CONFIG_VIDEO_BT856=y
> # CONFIG_VIDEO_BT866 is not set
> CONFIG_VIDEO_KS0127=y
> CONFIG_VIDEO_ML86V7667=y
> CONFIG_VIDEO_SAA7110=y
> CONFIG_VIDEO_SAA711X=y
> # CONFIG_VIDEO_TVP514X is not set
> CONFIG_VIDEO_TVP5150=y
> # CONFIG_VIDEO_TVP7002 is not set
> # CONFIG_VIDEO_TW2804 is not set
> CONFIG_VIDEO_TW9903=y
> CONFIG_VIDEO_TW9906=y
> # CONFIG_VIDEO_TW9910 is not set
> CONFIG_VIDEO_VPX3220=y
> 
> #
> # Video and audio decoders
> #
> CONFIG_VIDEO_SAA717X=y
> CONFIG_VIDEO_CX25840=y
> 
> #
> # Video encoders
> #
> CONFIG_VIDEO_SAA7127=y
> # CONFIG_VIDEO_SAA7185 is not set
> CONFIG_VIDEO_ADV7170=y
> # CONFIG_VIDEO_ADV7175 is not set
> CONFIG_VIDEO_ADV7343=y
> CONFIG_VIDEO_ADV7393=y
> CONFIG_VIDEO_AK881X=y
> # CONFIG_VIDEO_THS8200 is not set
> 
> #
> # Camera sensor devices
> #
> CONFIG_VIDEO_MT9M111=y
> 
> #
> # Flash devices
> #
> 
> #
> # Video improvement chips
> #
> CONFIG_VIDEO_UPD64031A=y
> CONFIG_VIDEO_UPD64083=y
> 
> #
> # Audio/Video compression chips
> #
> # CONFIG_VIDEO_SAA6752HS is not set
> 
> #
> # SDR tuner chips
> #
> CONFIG_SDR_MAX2175=y
> 
> #
> # Miscellaneous helper chips
> #
> # CONFIG_VIDEO_THS7303 is not set
> CONFIG_VIDEO_M52790=y
> # CONFIG_VIDEO_I2C is not set
> 
> #
> # Sensors used on soc_camera driver
> #
> 
> #
> # SPI helper chips
> #
> CONFIG_MEDIA_TUNER=y
> 
> #
> # Customize TV tuners
> #
> # CONFIG_MEDIA_TUNER_SIMPLE is not set
> # CONFIG_MEDIA_TUNER_TDA18250 is not set
> CONFIG_MEDIA_TUNER_TDA8290=y
> CONFIG_MEDIA_TUNER_TDA827X=y
> CONFIG_MEDIA_TUNER_TDA18271=y
> # CONFIG_MEDIA_TUNER_TDA9887 is not set
> CONFIG_MEDIA_TUNER_TEA5761=y
> CONFIG_MEDIA_TUNER_TEA5767=y
> # CONFIG_MEDIA_TUNER_MT20XX is not set
> CONFIG_MEDIA_TUNER_MT2060=y
> CONFIG_MEDIA_TUNER_MT2063=y
> CONFIG_MEDIA_TUNER_MT2266=y
> CONFIG_MEDIA_TUNER_MT2131=y
> # CONFIG_MEDIA_TUNER_QT1010 is not set
> # CONFIG_MEDIA_TUNER_XC2028 is not set
> CONFIG_MEDIA_TUNER_XC5000=y
> CONFIG_MEDIA_TUNER_XC4000=y
> # CONFIG_MEDIA_TUNER_MXL5005S is not set
> CONFIG_MEDIA_TUNER_MXL5007T=y
> CONFIG_MEDIA_TUNER_MC44S803=y
> # CONFIG_MEDIA_TUNER_MAX2165 is not set
> CONFIG_MEDIA_TUNER_TDA18218=y
> # CONFIG_MEDIA_TUNER_FC0011 is not set
> # CONFIG_MEDIA_TUNER_FC0012 is not set
> # CONFIG_MEDIA_TUNER_FC0013 is not set
> CONFIG_MEDIA_TUNER_TDA18212=y
> # CONFIG_MEDIA_TUNER_E4000 is not set
> CONFIG_MEDIA_TUNER_FC2580=y
> # CONFIG_MEDIA_TUNER_M88RS6000T is not set
> CONFIG_MEDIA_TUNER_TUA9001=y
> # CONFIG_MEDIA_TUNER_SI2157 is not set
> # CONFIG_MEDIA_TUNER_IT913X is not set
> CONFIG_MEDIA_TUNER_R820T=y
> # CONFIG_MEDIA_TUNER_MXL301RF is not set
> CONFIG_MEDIA_TUNER_QM1D1C0042=y
> CONFIG_MEDIA_TUNER_QM1D1B0004=y
> 
> #
> # Customise DVB Frontends
> #
> 
> #
> # Multistandard (satellite) frontends
> #
> # CONFIG_DVB_STB0899 is not set
> CONFIG_DVB_STB6100=y
> CONFIG_DVB_STV090x=y
> CONFIG_DVB_STV0910=y
> CONFIG_DVB_STV6110x=y
> CONFIG_DVB_STV6111=y
> CONFIG_DVB_MXL5XX=y
> # CONFIG_DVB_M88DS3103 is not set
> 
> #
> # Multistandard (cable + terrestrial) frontends
> #
> # CONFIG_DVB_DRXK is not set
> # CONFIG_DVB_TDA18271C2DD is not set
> CONFIG_DVB_SI2165=y
> CONFIG_DVB_MN88472=y
> # CONFIG_DVB_MN88473 is not set
> 
> #
> # DVB-S (satellite) frontends
> #
> # CONFIG_DVB_CX24110 is not set
> # CONFIG_DVB_CX24123 is not set
> # CONFIG_DVB_MT312 is not set
> CONFIG_DVB_ZL10036=y
> # CONFIG_DVB_ZL10039 is not set
> # CONFIG_DVB_S5H1420 is not set
> # CONFIG_DVB_STV0288 is not set
> # CONFIG_DVB_STB6000 is not set
> CONFIG_DVB_STV0299=y
> # CONFIG_DVB_STV6110 is not set
> # CONFIG_DVB_STV0900 is not set
> CONFIG_DVB_TDA8083=y
> # CONFIG_DVB_TDA10086 is not set
> CONFIG_DVB_TDA8261=y
> # CONFIG_DVB_VES1X93 is not set
> # CONFIG_DVB_TUNER_ITD1000 is not set
> CONFIG_DVB_TUNER_CX24113=y
> # CONFIG_DVB_TDA826X is not set
> # CONFIG_DVB_TUA6100 is not set
> CONFIG_DVB_CX24116=y
> CONFIG_DVB_CX24117=y
> CONFIG_DVB_CX24120=y
> CONFIG_DVB_SI21XX=y
> CONFIG_DVB_TS2020=y
> CONFIG_DVB_DS3000=y
> CONFIG_DVB_MB86A16=y
> CONFIG_DVB_TDA10071=y
> 
> #
> # DVB-T (terrestrial) frontends
> #
> CONFIG_DVB_SP8870=y
> # CONFIG_DVB_SP887X is not set
> # CONFIG_DVB_CX22700 is not set
> CONFIG_DVB_CX22702=y
> CONFIG_DVB_S5H1432=y
> CONFIG_DVB_DRXD=y
> # CONFIG_DVB_L64781 is not set
> CONFIG_DVB_TDA1004X=y
> CONFIG_DVB_NXT6000=y
> CONFIG_DVB_MT352=y
> CONFIG_DVB_ZL10353=y
> CONFIG_DVB_DIB3000MB=y
> CONFIG_DVB_DIB3000MC=y
> # CONFIG_DVB_DIB7000M is not set
> CONFIG_DVB_DIB7000P=y
> CONFIG_DVB_DIB9000=y
> CONFIG_DVB_TDA10048=y
> # CONFIG_DVB_AF9013 is not set
> # CONFIG_DVB_EC100 is not set
> # CONFIG_DVB_STV0367 is not set
> CONFIG_DVB_CXD2820R=y
> # CONFIG_DVB_CXD2841ER is not set
> CONFIG_DVB_RTL2830=y
> # CONFIG_DVB_RTL2832 is not set
> # CONFIG_DVB_RTL2832_SDR is not set
> CONFIG_DVB_SI2168=y
> CONFIG_DVB_ZD1301_DEMOD=y
> 
> #
> # DVB-C (cable) frontends
> #
> CONFIG_DVB_VES1820=y
> CONFIG_DVB_TDA10021=y
> CONFIG_DVB_TDA10023=y
> CONFIG_DVB_STV0297=y
> 
> #
> # ATSC (North American/Korean Terrestrial/Cable DTV) frontends
> #
> CONFIG_DVB_NXT200X=y
> CONFIG_DVB_OR51211=y
> CONFIG_DVB_OR51132=y
> # CONFIG_DVB_BCM3510 is not set
> # CONFIG_DVB_LGDT330X is not set
> CONFIG_DVB_LGDT3305=y
> # CONFIG_DVB_LGDT3306A is not set
> CONFIG_DVB_LG2160=y
> CONFIG_DVB_S5H1409=y
> # CONFIG_DVB_AU8522_DTV is not set
> # CONFIG_DVB_AU8522_V4L is not set
> CONFIG_DVB_S5H1411=y
> 
> #
> # ISDB-T (terrestrial) frontends
> #
> # CONFIG_DVB_S921 is not set
> CONFIG_DVB_DIB8000=y
> CONFIG_DVB_MB86A20S=y
> 
> #
> # ISDB-S (satellite) & ISDB-T (terrestrial) frontends
> #
> # CONFIG_DVB_TC90522 is not set
> 
> #
> # Digital terrestrial only tuners/PLL
> #
> CONFIG_DVB_PLL=y
> CONFIG_DVB_TUNER_DIB0070=y
> # CONFIG_DVB_TUNER_DIB0090 is not set
> 
> #
> # SEC control devices for DVB-S
> #
> CONFIG_DVB_DRX39XYJ=y
> CONFIG_DVB_LNBH25=y
> # CONFIG_DVB_LNBP21 is not set
> # CONFIG_DVB_LNBP22 is not set
> # CONFIG_DVB_ISL6405 is not set
> CONFIG_DVB_ISL6421=y
> CONFIG_DVB_ISL6423=y
> # CONFIG_DVB_A8293 is not set
> CONFIG_DVB_LGS8GL5=y
> # CONFIG_DVB_LGS8GXX is not set
> CONFIG_DVB_ATBM8830=y
> CONFIG_DVB_TDA665x=y
> # CONFIG_DVB_IX2505V is not set
> CONFIG_DVB_M88RS2000=y
> # CONFIG_DVB_AF9033 is not set
> CONFIG_DVB_HORUS3A=y
> CONFIG_DVB_ASCOT2E=y
> CONFIG_DVB_HELENE=y
> 
> #
> # Common Interface (EN50221) controller drivers
> #
> # CONFIG_DVB_CXD2099 is not set
> CONFIG_DVB_SP2=y
> 
> #
> # Tools to develop new frontends
> #
> CONFIG_DVB_DUMMY_FE=y
> 
> #
> # Graphics support
> #
> CONFIG_AGP=y
> # CONFIG_AGP_AMD64 is not set
> CONFIG_AGP_INTEL=y
> CONFIG_AGP_SIS=y
> CONFIG_AGP_VIA=y
> CONFIG_INTEL_GTT=y
> CONFIG_VGA_ARB=y
> CONFIG_VGA_ARB_MAX_GPUS=16
> # CONFIG_VGA_SWITCHEROO is not set
> CONFIG_DRM=y
> CONFIG_DRM_MIPI_DSI=y
> CONFIG_DRM_DP_AUX_CHARDEV=y
> # CONFIG_DRM_DEBUG_MM is not set
> # CONFIG_DRM_DEBUG_SELFTEST is not set
> CONFIG_DRM_KMS_HELPER=y
> # CONFIG_DRM_FBDEV_EMULATION is not set
> CONFIG_DRM_LOAD_EDID_FIRMWARE=y
> CONFIG_DRM_TTM=y
> CONFIG_DRM_VM=y
> CONFIG_DRM_SCHED=y
> 
> #
> # I2C encoder or helper chips
> #
> CONFIG_DRM_I2C_CH7006=y
> CONFIG_DRM_I2C_SIL164=y
> CONFIG_DRM_I2C_NXP_TDA998X=y
> CONFIG_DRM_I2C_NXP_TDA9950=y
> # CONFIG_DRM_RADEON is not set
> CONFIG_DRM_AMDGPU=y
> # CONFIG_DRM_AMDGPU_SI is not set
> CONFIG_DRM_AMDGPU_CIK=y
> CONFIG_DRM_AMDGPU_USERPTR=y
> # CONFIG_DRM_AMDGPU_GART_DEBUGFS is not set
> 
> #
> # ACP (Audio CoProcessor) Configuration
> #
> # CONFIG_DRM_AMD_ACP is not set
> 
> #
> # Display Engine Configuration
> #
> # CONFIG_DRM_AMD_DC is not set
> 
> #
> # AMD Library routines
> #
> CONFIG_CHASH=y
> CONFIG_CHASH_STATS=y
> # CONFIG_CHASH_SELFTEST is not set
> CONFIG_DRM_NOUVEAU=y
> CONFIG_NOUVEAU_DEBUG=5
> CONFIG_NOUVEAU_DEBUG_DEFAULT=3
> CONFIG_NOUVEAU_DEBUG_MMU=y
> # CONFIG_DRM_NOUVEAU_BACKLIGHT is not set
> CONFIG_DRM_I915=y
> CONFIG_DRM_I915_ALPHA_SUPPORT=y
> CONFIG_DRM_I915_CAPTURE_ERROR=y
> # CONFIG_DRM_I915_COMPRESS_ERROR is not set
> CONFIG_DRM_I915_USERPTR=y
> CONFIG_DRM_I915_GVT=y
> CONFIG_DRM_VGEM=y
> CONFIG_DRM_VMWGFX=y
> CONFIG_DRM_VMWGFX_FBCON=y
> # CONFIG_DRM_GMA500 is not set
> CONFIG_DRM_UDL=y
> CONFIG_DRM_AST=y
> # CONFIG_DRM_MGAG200 is not set
> CONFIG_DRM_CIRRUS_QEMU=y
> # CONFIG_DRM_QXL is not set
> CONFIG_DRM_BOCHS=y
> CONFIG_DRM_VIRTIO_GPU=y
> CONFIG_DRM_PANEL=y
> 
> #
> # Display Panels
> #
> CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN=y
> CONFIG_DRM_BRIDGE=y
> CONFIG_DRM_PANEL_BRIDGE=y
> 
> #
> # Display Interface Bridges
> #
> CONFIG_DRM_ANALOGIX_ANX78XX=y
> # CONFIG_HSA_AMD is not set
> CONFIG_DRM_HISI_HIBMC=y
> # CONFIG_DRM_TINYDRM is not set
> CONFIG_DRM_XEN=y
> # CONFIG_DRM_XEN_FRONTEND is not set
> # CONFIG_DRM_LEGACY is not set
> CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
> 
> #
> # Frame buffer Devices
> #
> CONFIG_FB=y
> # CONFIG_FIRMWARE_EDID is not set
> CONFIG_FB_CMDLINE=y
> CONFIG_FB_NOTIFY=y
> CONFIG_FB_DDC=y
> CONFIG_FB_BOOT_VESA_SUPPORT=y
> CONFIG_FB_CFB_FILLRECT=y
> CONFIG_FB_CFB_COPYAREA=y
> CONFIG_FB_CFB_IMAGEBLIT=y
> CONFIG_FB_SYS_FILLRECT=y
> CONFIG_FB_SYS_COPYAREA=y
> CONFIG_FB_SYS_IMAGEBLIT=y
> CONFIG_FB_FOREIGN_ENDIAN=y
> # CONFIG_FB_BOTH_ENDIAN is not set
> # CONFIG_FB_BIG_ENDIAN is not set
> CONFIG_FB_LITTLE_ENDIAN=y
> CONFIG_FB_SYS_FOPS=y
> CONFIG_FB_DEFERRED_IO=y
> CONFIG_FB_HECUBA=y
> CONFIG_FB_SVGALIB=y
> CONFIG_FB_BACKLIGHT=y
> CONFIG_FB_MODE_HELPERS=y
> CONFIG_FB_TILEBLITTING=y
> 
> #
> # Frame buffer hardware drivers
> #
> CONFIG_FB_CIRRUS=y
> # CONFIG_FB_PM2 is not set
> CONFIG_FB_CYBER2000=y
> CONFIG_FB_CYBER2000_DDC=y
> CONFIG_FB_ARC=y
> CONFIG_FB_ASILIANT=y
> # CONFIG_FB_IMSTT is not set
> # CONFIG_FB_VGA16 is not set
> CONFIG_FB_UVESA=y
> CONFIG_FB_VESA=y
> CONFIG_FB_N411=y
> # CONFIG_FB_HGA is not set
> CONFIG_FB_OPENCORES=y
> CONFIG_FB_S1D13XXX=y
> # CONFIG_FB_NVIDIA is not set
> CONFIG_FB_RIVA=y
> CONFIG_FB_RIVA_I2C=y
> CONFIG_FB_RIVA_DEBUG=y
> # CONFIG_FB_RIVA_BACKLIGHT is not set
> # CONFIG_FB_I740 is not set
> CONFIG_FB_LE80578=y
> CONFIG_FB_CARILLO_RANCH=y
> CONFIG_FB_MATROX=y
> # CONFIG_FB_MATROX_MILLENIUM is not set
> CONFIG_FB_MATROX_MYSTIQUE=y
> # CONFIG_FB_MATROX_G is not set
> CONFIG_FB_MATROX_I2C=y
> CONFIG_FB_RADEON=y
> # CONFIG_FB_RADEON_I2C is not set
> # CONFIG_FB_RADEON_BACKLIGHT is not set
> CONFIG_FB_RADEON_DEBUG=y
> CONFIG_FB_ATY128=y
> CONFIG_FB_ATY128_BACKLIGHT=y
> # CONFIG_FB_ATY is not set
> # CONFIG_FB_S3 is not set
> # CONFIG_FB_SAVAGE is not set
> CONFIG_FB_SIS=y
> CONFIG_FB_SIS_300=y
> # CONFIG_FB_SIS_315 is not set
> # CONFIG_FB_VIA is not set
> CONFIG_FB_NEOMAGIC=y
> CONFIG_FB_KYRO=y
> CONFIG_FB_3DFX=y
> # CONFIG_FB_3DFX_ACCEL is not set
> # CONFIG_FB_3DFX_I2C is not set
> CONFIG_FB_VOODOO1=y
> # CONFIG_FB_VT8623 is not set
> CONFIG_FB_TRIDENT=y
> CONFIG_FB_ARK=y
> CONFIG_FB_PM3=y
> CONFIG_FB_CARMINE=y
> # CONFIG_FB_CARMINE_DRAM_EVAL is not set
> CONFIG_CARMINE_DRAM_CUSTOM=y
> CONFIG_FB_SM501=y
> CONFIG_FB_SMSCUFX=y
> # CONFIG_FB_UDL is not set
> # CONFIG_FB_IBM_GXT4500 is not set
> CONFIG_FB_GOLDFISH=y
> CONFIG_FB_VIRTUAL=y
> CONFIG_XEN_FBDEV_FRONTEND=y
> CONFIG_FB_METRONOME=y
> CONFIG_FB_MB862XX=y
> CONFIG_FB_MB862XX_PCI_GDC=y
> # CONFIG_FB_MB862XX_I2C is not set
> # CONFIG_FB_BROADSHEET is not set
> CONFIG_FB_HYPERV=y
> CONFIG_FB_SIMPLE=y
> CONFIG_FB_SM712=y
> CONFIG_BACKLIGHT_LCD_SUPPORT=y
> CONFIG_LCD_CLASS_DEVICE=y
> CONFIG_LCD_PLATFORM=y
> CONFIG_BACKLIGHT_CLASS_DEVICE=y
> CONFIG_BACKLIGHT_GENERIC=y
> # CONFIG_BACKLIGHT_LM3533 is not set
> CONFIG_BACKLIGHT_CARILLO_RANCH=y
> # CONFIG_BACKLIGHT_DA903X is not set
> # CONFIG_BACKLIGHT_DA9052 is not set
> # CONFIG_BACKLIGHT_MAX8925 is not set
> CONFIG_BACKLIGHT_APPLE=y
> CONFIG_BACKLIGHT_PM8941_WLED=y
> # CONFIG_BACKLIGHT_SAHARA is not set
> CONFIG_BACKLIGHT_WM831X=y
> CONFIG_BACKLIGHT_ADP8860=y
> CONFIG_BACKLIGHT_ADP8870=y
> CONFIG_BACKLIGHT_88PM860X=y
> CONFIG_BACKLIGHT_PCF50633=y
> # CONFIG_BACKLIGHT_AAT2870 is not set
> CONFIG_BACKLIGHT_LM3639=y
> # CONFIG_BACKLIGHT_SKY81452 is not set
> CONFIG_BACKLIGHT_GPIO=y
> CONFIG_BACKLIGHT_LV5207LP=y
> # CONFIG_BACKLIGHT_BD6107 is not set
> # CONFIG_BACKLIGHT_ARCXCNN is not set
> CONFIG_BACKLIGHT_RAVE_SP=y
> CONFIG_VGASTATE=y
> CONFIG_HDMI=y
> 
> #
> # Console display driver support
> #
> CONFIG_VGA_CONSOLE=y
> CONFIG_VGACON_SOFT_SCROLLBACK=y
> CONFIG_VGACON_SOFT_SCROLLBACK_SIZE=64
> CONFIG_VGACON_SOFT_SCROLLBACK_PERSISTENT_ENABLE_BY_DEFAULT=y
> CONFIG_DUMMY_CONSOLE=y
> CONFIG_DUMMY_CONSOLE_COLUMNS=80
> CONFIG_DUMMY_CONSOLE_ROWS=25
> # CONFIG_FRAMEBUFFER_CONSOLE is not set
> CONFIG_LOGO=y
> # CONFIG_LOGO_LINUX_MONO is not set
> CONFIG_LOGO_LINUX_VGA16=y
> CONFIG_LOGO_LINUX_CLUT224=y
> # CONFIG_SOUND is not set
> 
> #
> # HID support
> #
> CONFIG_HID=y
> # CONFIG_HID_BATTERY_STRENGTH is not set
> CONFIG_HIDRAW=y
> CONFIG_UHID=y
> CONFIG_HID_GENERIC=y
> 
> #
> # Special HID drivers
> #
> CONFIG_HID_A4TECH=y
> CONFIG_HID_ACCUTOUCH=y
> # CONFIG_HID_ACRUX is not set
> CONFIG_HID_APPLE=y
> CONFIG_HID_APPLEIR=y
> CONFIG_HID_ASUS=y
> # CONFIG_HID_AUREAL is not set
> CONFIG_HID_BELKIN=y
> CONFIG_HID_BETOP_FF=y
> # CONFIG_HID_CHERRY is not set
> CONFIG_HID_CHICONY=y
> # CONFIG_HID_CORSAIR is not set
> # CONFIG_HID_CMEDIA is not set
> # CONFIG_HID_CP2112 is not set
> # CONFIG_HID_CYPRESS is not set
> CONFIG_HID_DRAGONRISE=y
> CONFIG_DRAGONRISE_FF=y
> CONFIG_HID_EMS_FF=y
> # CONFIG_HID_ELAN is not set
> # CONFIG_HID_ELECOM is not set
> CONFIG_HID_ELO=y
> CONFIG_HID_EZKEY=y
> # CONFIG_HID_GEMBIRD is not set
> CONFIG_HID_GFRM=y
> CONFIG_HID_HOLTEK=y
> # CONFIG_HOLTEK_FF is not set
> CONFIG_HID_GOOGLE_HAMMER=y
> CONFIG_HID_GT683R=y
> # CONFIG_HID_KEYTOUCH is not set
> # CONFIG_HID_KYE is not set
> CONFIG_HID_UCLOGIC=y
> # CONFIG_HID_WALTOP is not set
> CONFIG_HID_GYRATION=y
> CONFIG_HID_ICADE=y
> CONFIG_HID_ITE=y
> CONFIG_HID_JABRA=y
> CONFIG_HID_TWINHAN=y
> CONFIG_HID_KENSINGTON=y
> CONFIG_HID_LCPOWER=y
> CONFIG_HID_LED=y
> CONFIG_HID_LENOVO=y
> # CONFIG_HID_LOGITECH is not set
> # CONFIG_HID_MAGICMOUSE is not set
> CONFIG_HID_MAYFLASH=y
> CONFIG_HID_REDRAGON=y
> # CONFIG_HID_MICROSOFT is not set
> # CONFIG_HID_MONTEREY is not set
> CONFIG_HID_MULTITOUCH=y
> CONFIG_HID_NTI=y
> CONFIG_HID_NTRIG=y
> # CONFIG_HID_ORTEK is not set
> CONFIG_HID_PANTHERLORD=y
> # CONFIG_PANTHERLORD_FF is not set
> CONFIG_HID_PENMOUNT=y
> CONFIG_HID_PETALYNX=y
> # CONFIG_HID_PICOLCD is not set
> CONFIG_HID_PLANTRONICS=y
> # CONFIG_HID_PRIMAX is not set
> # CONFIG_HID_RETRODE is not set
> # CONFIG_HID_ROCCAT is not set
> # CONFIG_HID_SAITEK is not set
> CONFIG_HID_SAMSUNG=y
> CONFIG_HID_SONY=y
> CONFIG_SONY_FF=y
> CONFIG_HID_SPEEDLINK=y
> CONFIG_HID_STEAM=y
> CONFIG_HID_STEELSERIES=y
> # CONFIG_HID_SUNPLUS is not set
> CONFIG_HID_RMI=y
> CONFIG_HID_GREENASIA=y
> # CONFIG_GREENASIA_FF is not set
> CONFIG_HID_HYPERV_MOUSE=y
> CONFIG_HID_SMARTJOYPLUS=y
> CONFIG_SMARTJOYPLUS_FF=y
> # CONFIG_HID_TIVO is not set
> # CONFIG_HID_TOPSEED is not set
> CONFIG_HID_THINGM=y
> # CONFIG_HID_THRUSTMASTER is not set
> CONFIG_HID_UDRAW_PS3=y
> CONFIG_HID_WACOM=y
> # CONFIG_HID_WIIMOTE is not set
> # CONFIG_HID_XINMO is not set
> CONFIG_HID_ZEROPLUS=y
> # CONFIG_ZEROPLUS_FF is not set
> CONFIG_HID_ZYDACRON=y
> # CONFIG_HID_SENSOR_HUB is not set
> # CONFIG_HID_ALPS is not set
> 
> #
> # USB HID support
> #
> CONFIG_USB_HID=y
> # CONFIG_HID_PID is not set
> # CONFIG_USB_HIDDEV is not set
> 
> #
> # I2C HID support
> #
> CONFIG_I2C_HID=y
> 
> #
> # Intel ISH HID support
> #
> # CONFIG_INTEL_ISH_HID is not set
> CONFIG_USB_OHCI_LITTLE_ENDIAN=y
> CONFIG_USB_SUPPORT=y
> CONFIG_USB_COMMON=y
> CONFIG_USB_ARCH_HAS_HCD=y
> CONFIG_USB=y
> # CONFIG_USB_PCI is not set
> CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
> 
> #
> # Miscellaneous USB options
> #
> # CONFIG_USB_DEFAULT_PERSIST is not set
> # CONFIG_USB_DYNAMIC_MINORS is not set
> CONFIG_USB_OTG=y
> # CONFIG_USB_OTG_WHITELIST is not set
> CONFIG_USB_OTG_BLACKLIST_HUB=y
> CONFIG_USB_OTG_FSM=y
> CONFIG_USB_LEDS_TRIGGER_USBPORT=y
> CONFIG_USB_MON=y
> CONFIG_USB_WUSB_CBAF=y
> # CONFIG_USB_WUSB_CBAF_DEBUG is not set
> 
> #
> # USB Host Controller Drivers
> #
> # CONFIG_USB_C67X00_HCD is not set
> CONFIG_USB_XHCI_HCD=y
> # CONFIG_USB_XHCI_DBGCAP is not set
> CONFIG_USB_XHCI_PLATFORM=y
> CONFIG_USB_EHCI_HCD=y
> CONFIG_USB_EHCI_ROOT_HUB_TT=y
> # CONFIG_USB_EHCI_TT_NEWSCHED is not set
> CONFIG_USB_EHCI_HCD_PLATFORM=y
> CONFIG_USB_OXU210HP_HCD=y
> # CONFIG_USB_ISP116X_HCD is not set
> CONFIG_USB_FOTG210_HCD=y
> CONFIG_USB_OHCI_HCD=y
> CONFIG_USB_OHCI_HCD_SSB=y
> CONFIG_USB_OHCI_HCD_PLATFORM=y
> CONFIG_USB_U132_HCD=y
> # CONFIG_USB_SL811_HCD is not set
> # CONFIG_USB_R8A66597_HCD is not set
> CONFIG_USB_HCD_SSB=y
> CONFIG_USB_HCD_TEST_MODE=y
> 
> #
> # USB Device Class drivers
> #
> CONFIG_USB_ACM=y
> CONFIG_USB_PRINTER=y
> # CONFIG_USB_WDM is not set
> # CONFIG_USB_TMC is not set
> 
> #
> # NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
> #
> 
> #
> # also be needed; see USB_STORAGE Help for more info
> #
> # CONFIG_USB_STORAGE is not set
> 
> #
> # USB Imaging devices
> #
> # CONFIG_USB_MDC800 is not set
> CONFIG_USB_MICROTEK=y
> CONFIG_USBIP_CORE=y
> CONFIG_USBIP_VHCI_HCD=y
> CONFIG_USBIP_VHCI_HC_PORTS=8
> CONFIG_USBIP_VHCI_NR_HCS=1
> CONFIG_USBIP_HOST=y
> CONFIG_USBIP_VUDC=y
> CONFIG_USBIP_DEBUG=y
> # CONFIG_USB_MUSB_HDRC is not set
> # CONFIG_USB_DWC3 is not set
> # CONFIG_USB_DWC2 is not set
> CONFIG_USB_CHIPIDEA=y
> CONFIG_USB_CHIPIDEA_UDC=y
> # CONFIG_USB_CHIPIDEA_HOST is not set
> CONFIG_USB_ISP1760=y
> CONFIG_USB_ISP1761_UDC=y
> # CONFIG_USB_ISP1760_HOST_ROLE is not set
> CONFIG_USB_ISP1760_GADGET_ROLE=y
> # CONFIG_USB_ISP1760_DUAL_ROLE is not set
> 
> #
> # USB port drivers
> #
> CONFIG_USB_SERIAL=y
> # CONFIG_USB_SERIAL_CONSOLE is not set
> # CONFIG_USB_SERIAL_GENERIC is not set
> CONFIG_USB_SERIAL_SIMPLE=y
> CONFIG_USB_SERIAL_AIRCABLE=y
> CONFIG_USB_SERIAL_ARK3116=y
> CONFIG_USB_SERIAL_BELKIN=y
> # CONFIG_USB_SERIAL_CH341 is not set
> CONFIG_USB_SERIAL_WHITEHEAT=y
> CONFIG_USB_SERIAL_DIGI_ACCELEPORT=y
> CONFIG_USB_SERIAL_CP210X=y
> CONFIG_USB_SERIAL_CYPRESS_M8=y
> CONFIG_USB_SERIAL_EMPEG=y
> CONFIG_USB_SERIAL_FTDI_SIO=y
> # CONFIG_USB_SERIAL_VISOR is not set
> CONFIG_USB_SERIAL_IPAQ=y
> # CONFIG_USB_SERIAL_IR is not set
> # CONFIG_USB_SERIAL_EDGEPORT is not set
> CONFIG_USB_SERIAL_EDGEPORT_TI=y
> CONFIG_USB_SERIAL_F81232=y
> # CONFIG_USB_SERIAL_F8153X is not set
> # CONFIG_USB_SERIAL_GARMIN is not set
> CONFIG_USB_SERIAL_IPW=y
> # CONFIG_USB_SERIAL_IUU is not set
> CONFIG_USB_SERIAL_KEYSPAN_PDA=y
> CONFIG_USB_SERIAL_KEYSPAN=y
> # CONFIG_USB_SERIAL_KLSI is not set
> CONFIG_USB_SERIAL_KOBIL_SCT=y
> # CONFIG_USB_SERIAL_MCT_U232 is not set
> CONFIG_USB_SERIAL_METRO=y
> CONFIG_USB_SERIAL_MOS7720=y
> # CONFIG_USB_SERIAL_MOS7840 is not set
> CONFIG_USB_SERIAL_MXUPORT=y
> CONFIG_USB_SERIAL_NAVMAN=y
> CONFIG_USB_SERIAL_PL2303=y
> CONFIG_USB_SERIAL_OTI6858=y
> # CONFIG_USB_SERIAL_QCAUX is not set
> CONFIG_USB_SERIAL_QUALCOMM=y
> # CONFIG_USB_SERIAL_SPCP8X5 is not set
> CONFIG_USB_SERIAL_SAFE=y
> # CONFIG_USB_SERIAL_SAFE_PADDED is not set
> CONFIG_USB_SERIAL_SIERRAWIRELESS=y
> CONFIG_USB_SERIAL_SYMBOL=y
> # CONFIG_USB_SERIAL_TI is not set
> CONFIG_USB_SERIAL_CYBERJACK=y
> CONFIG_USB_SERIAL_XIRCOM=y
> CONFIG_USB_SERIAL_WWAN=y
> # CONFIG_USB_SERIAL_OPTION is not set
> # CONFIG_USB_SERIAL_OMNINET is not set
> CONFIG_USB_SERIAL_OPTICON=y
> CONFIG_USB_SERIAL_XSENS_MT=y
> CONFIG_USB_SERIAL_WISHBONE=y
> # CONFIG_USB_SERIAL_SSU100 is not set
> CONFIG_USB_SERIAL_QT2=y
> CONFIG_USB_SERIAL_UPD78F0730=y
> CONFIG_USB_SERIAL_DEBUG=y
> 
> #
> # USB Miscellaneous drivers
> #
> CONFIG_USB_EMI62=y
> CONFIG_USB_EMI26=y
> CONFIG_USB_ADUTUX=y
> CONFIG_USB_SEVSEG=y
> CONFIG_USB_RIO500=y
> CONFIG_USB_LEGOTOWER=y
> CONFIG_USB_LCD=y
> CONFIG_USB_CYPRESS_CY7C63=y
> # CONFIG_USB_CYTHERM is not set
> CONFIG_USB_IDMOUSE=y
> CONFIG_USB_FTDI_ELAN=y
> # CONFIG_USB_APPLEDISPLAY is not set
> CONFIG_USB_SISUSBVGA=y
> CONFIG_USB_SISUSBVGA_CON=y
> # CONFIG_USB_LD is not set
> CONFIG_USB_TRANCEVIBRATOR=y
> CONFIG_USB_IOWARRIOR=y
> CONFIG_USB_TEST=y
> # CONFIG_USB_EHSET_TEST_FIXTURE is not set
> CONFIG_USB_ISIGHTFW=y
> CONFIG_USB_YUREX=y
> CONFIG_USB_EZUSB_FX2=y
> CONFIG_USB_HUB_USB251XB=y
> CONFIG_USB_HSIC_USB3503=y
> # CONFIG_USB_HSIC_USB4604 is not set
> CONFIG_USB_LINK_LAYER_TEST=y
> # CONFIG_USB_CHAOSKEY is not set
> 
> #
> # USB Physical Layer drivers
> #
> CONFIG_USB_PHY=y
> # CONFIG_NOP_USB_XCEIV is not set
> CONFIG_USB_GPIO_VBUS=y
> CONFIG_USB_ISP1301=y
> CONFIG_USB_GADGET=y
> # CONFIG_USB_GADGET_DEBUG is not set
> CONFIG_USB_GADGET_DEBUG_FILES=y
> # CONFIG_USB_GADGET_DEBUG_FS is not set
> CONFIG_USB_GADGET_VBUS_DRAW=2
> CONFIG_USB_GADGET_STORAGE_NUM_BUFFERS=2
> 
> #
> # USB Peripheral Controller
> #
> CONFIG_USB_FOTG210_UDC=y
> CONFIG_USB_GR_UDC=y
> CONFIG_USB_R8A66597=y
> CONFIG_USB_PXA27X=y
> CONFIG_USB_MV_UDC=y
> # CONFIG_USB_MV_U3D is not set
> CONFIG_USB_M66592=y
> CONFIG_USB_BDC_UDC=y
> 
> #
> # Platform Support
> #
> CONFIG_USB_NET2272=y
> # CONFIG_USB_NET2272_DMA is not set
> CONFIG_USB_DUMMY_HCD=y
> # CONFIG_USB_CONFIGFS is not set
> CONFIG_TYPEC=y
> # CONFIG_TYPEC_TCPM is not set
> # CONFIG_TYPEC_UCSI is not set
> CONFIG_TYPEC_TPS6598X=y
> 
> #
> # USB Type-C Multiplexer/DeMultiplexer Switch support
> #
> CONFIG_TYPEC_MUX_PI3USB30532=y
> # CONFIG_USB_ROLES_INTEL_XHCI is not set
> CONFIG_USB_LED_TRIG=y
> # CONFIG_USB_ULPI_BUS is not set
> CONFIG_USB_ROLE_SWITCH=y
> # CONFIG_UWB is not set
> CONFIG_MMC=y
> CONFIG_MMC_BLOCK=y
> CONFIG_MMC_BLOCK_MINORS=8
> CONFIG_SDIO_UART=y
> # CONFIG_MMC_TEST is not set
> 
> #
> # MMC/SD/SDIO Host Controller Drivers
> #
> CONFIG_MMC_DEBUG=y
> CONFIG_MMC_SDHCI=y
> # CONFIG_MMC_SDHCI_PCI is not set
> CONFIG_MMC_SDHCI_ACPI=y
> # CONFIG_MMC_SDHCI_PLTFM is not set
> CONFIG_MMC_WBSD=y
> CONFIG_MMC_TIFM_SD=y
> # CONFIG_MMC_GOLDFISH is not set
> CONFIG_MMC_CB710=y
> # CONFIG_MMC_VIA_SDMMC is not set
> CONFIG_MMC_VUB300=y
> # CONFIG_MMC_USHC is not set
> # CONFIG_MMC_USDHI6ROL0 is not set
> CONFIG_MMC_REALTEK_PCI=y
> CONFIG_MMC_REALTEK_USB=y
> # CONFIG_MMC_CQHCI is not set
> CONFIG_MMC_TOSHIBA_PCI=y
> CONFIG_MMC_MTK=y
> CONFIG_MEMSTICK=y
> CONFIG_MEMSTICK_DEBUG=y
> 
> #
> # MemoryStick drivers
> #
> # CONFIG_MEMSTICK_UNSAFE_RESUME is not set
> # CONFIG_MSPRO_BLOCK is not set
> CONFIG_MS_BLOCK=y
> 
> #
> # MemoryStick Host Controller Drivers
> #
> CONFIG_MEMSTICK_TIFM_MS=y
> CONFIG_MEMSTICK_JMICRON_38X=y
> # CONFIG_MEMSTICK_R592 is not set
> # CONFIG_MEMSTICK_REALTEK_PCI is not set
> CONFIG_MEMSTICK_REALTEK_USB=y
> CONFIG_NEW_LEDS=y
> CONFIG_LEDS_CLASS=y
> CONFIG_LEDS_CLASS_FLASH=y
> CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=y
> 
> #
> # LED drivers
> #
> CONFIG_LEDS_88PM860X=y
> CONFIG_LEDS_APU=y
> CONFIG_LEDS_AS3645A=y
> # CONFIG_LEDS_LM3530 is not set
> CONFIG_LEDS_LM3533=y
> CONFIG_LEDS_LM3642=y
> CONFIG_LEDS_LM3601X=y
> # CONFIG_LEDS_MT6323 is not set
> CONFIG_LEDS_PCA9532=y
> # CONFIG_LEDS_PCA9532_GPIO is not set
> CONFIG_LEDS_GPIO=y
> # CONFIG_LEDS_LP3944 is not set
> CONFIG_LEDS_LP3952=y
> CONFIG_LEDS_LP55XX_COMMON=y
> # CONFIG_LEDS_LP5521 is not set
> CONFIG_LEDS_LP5523=y
> CONFIG_LEDS_LP5562=y
> CONFIG_LEDS_LP8501=y
> CONFIG_LEDS_LP8788=y
> CONFIG_LEDS_CLEVO_MAIL=y
> CONFIG_LEDS_PCA955X=y
> # CONFIG_LEDS_PCA955X_GPIO is not set
> # CONFIG_LEDS_PCA963X is not set
> # CONFIG_LEDS_WM831X_STATUS is not set
> # CONFIG_LEDS_DA903X is not set
> # CONFIG_LEDS_DA9052 is not set
> CONFIG_LEDS_REGULATOR=y
> CONFIG_LEDS_BD2802=y
> # CONFIG_LEDS_INTEL_SS4200 is not set
> CONFIG_LEDS_LT3593=y
> CONFIG_LEDS_MC13783=y
> CONFIG_LEDS_TCA6507=y
> CONFIG_LEDS_TLC591XX=y
> # CONFIG_LEDS_LM355x is not set
> CONFIG_LEDS_MENF21BMC=y
> 
> #
> # LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
> #
> CONFIG_LEDS_BLINKM=y
> CONFIG_LEDS_MLXCPLD=y
> CONFIG_LEDS_MLXREG=y
> # CONFIG_LEDS_USER is not set
> CONFIG_LEDS_NIC78BX=y
> 
> #
> # LED Triggers
> #
> CONFIG_LEDS_TRIGGERS=y
> CONFIG_LEDS_TRIGGER_TIMER=y
> # CONFIG_LEDS_TRIGGER_ONESHOT is not set
> # CONFIG_LEDS_TRIGGER_DISK is not set
> CONFIG_LEDS_TRIGGER_MTD=y
> CONFIG_LEDS_TRIGGER_HEARTBEAT=y
> CONFIG_LEDS_TRIGGER_BACKLIGHT=y
> # CONFIG_LEDS_TRIGGER_CPU is not set
> # CONFIG_LEDS_TRIGGER_ACTIVITY is not set
> CONFIG_LEDS_TRIGGER_GPIO=y
> # CONFIG_LEDS_TRIGGER_DEFAULT_ON is not set
> 
> #
> # iptables trigger is under Netfilter config (LED target)
> #
> # CONFIG_LEDS_TRIGGER_TRANSIENT is not set
> CONFIG_LEDS_TRIGGER_CAMERA=y
> CONFIG_LEDS_TRIGGER_PANIC=y
> # CONFIG_LEDS_TRIGGER_NETDEV is not set
> # CONFIG_ACCESSIBILITY is not set
> # CONFIG_INFINIBAND is not set
> CONFIG_EDAC_ATOMIC_SCRUB=y
> CONFIG_EDAC_SUPPORT=y
> # CONFIG_EDAC is not set
> CONFIG_RTC_LIB=y
> CONFIG_RTC_MC146818_LIB=y
> # CONFIG_RTC_CLASS is not set
> CONFIG_DMADEVICES=y
> # CONFIG_DMADEVICES_DEBUG is not set
> 
> #
> # DMA Devices
> #
> CONFIG_DMA_ENGINE=y
> CONFIG_DMA_VIRTUAL_CHANNELS=y
> CONFIG_DMA_ACPI=y
> # CONFIG_ALTERA_MSGDMA is not set
> # CONFIG_INTEL_IDMA64 is not set
> CONFIG_INTEL_IOATDMA=y
> CONFIG_INTEL_MIC_X100_DMA=y
> CONFIG_QCOM_HIDMA_MGMT=y
> CONFIG_QCOM_HIDMA=y
> CONFIG_DW_DMAC_CORE=y
> CONFIG_DW_DMAC=y
> CONFIG_DW_DMAC_PCI=y
> CONFIG_HSU_DMA=y
> 
> #
> # DMA Clients
> #
> CONFIG_ASYNC_TX_DMA=y
> CONFIG_DMATEST=y
> CONFIG_DMA_ENGINE_RAID=y
> 
> #
> # DMABUF options
> #
> CONFIG_SYNC_FILE=y
> # CONFIG_SW_SYNC is not set
> CONFIG_DCA=y
> CONFIG_AUXDISPLAY=y
> CONFIG_HD44780=y
> CONFIG_IMG_ASCII_LCD=y
> CONFIG_CHARLCD=y
> CONFIG_UIO=y
> CONFIG_UIO_CIF=y
> CONFIG_UIO_PDRV_GENIRQ=y
> CONFIG_UIO_DMEM_GENIRQ=y
> CONFIG_UIO_AEC=y
> CONFIG_UIO_SERCOS3=y
> # CONFIG_UIO_PCI_GENERIC is not set
> # CONFIG_UIO_NETX is not set
> # CONFIG_UIO_PRUSS is not set
> # CONFIG_UIO_MF624 is not set
> CONFIG_UIO_HV_GENERIC=y
> CONFIG_VIRT_DRIVERS=y
> CONFIG_VBOXGUEST=y
> CONFIG_VIRTIO=y
> CONFIG_VIRTIO_MENU=y
> CONFIG_VIRTIO_PCI=y
> CONFIG_VIRTIO_PCI_LEGACY=y
> # CONFIG_VIRTIO_BALLOON is not set
> CONFIG_VIRTIO_INPUT=y
> # CONFIG_VIRTIO_MMIO is not set
> 
> #
> # Microsoft Hyper-V guest support
> #
> CONFIG_HYPERV=y
> CONFIG_HYPERV_TSCPAGE=y
> # CONFIG_HYPERV_UTILS is not set
> CONFIG_HYPERV_BALLOON=y
> 
> #
> # Xen driver support
> #
> # CONFIG_XEN_BALLOON is not set
> CONFIG_XEN_DEV_EVTCHN=y
> CONFIG_XENFS=y
> # CONFIG_XEN_COMPAT_XENFS is not set
> # CONFIG_XEN_SYS_HYPERVISOR is not set
> CONFIG_XEN_XENBUS_FRONTEND=y
> CONFIG_XEN_GNTDEV=y
> # CONFIG_XEN_GRANT_DEV_ALLOC is not set
> CONFIG_SWIOTLB_XEN=y
> CONFIG_XEN_TMEM=y
> # CONFIG_XEN_PVCALLS_FRONTEND is not set
> CONFIG_XEN_PRIVCMD=y
> CONFIG_XEN_HAVE_PVMMU=y
> CONFIG_XEN_AUTO_XLATE=y
> CONFIG_XEN_ACPI=y
> CONFIG_XEN_HAVE_VPMU=y
> CONFIG_STAGING=y
> # CONFIG_PRISM2_USB is not set
> # CONFIG_COMEDI is not set
> CONFIG_R8712U=y
> CONFIG_RTS5208=y
> # CONFIG_FB_SM750 is not set
> # CONFIG_FB_XGI is not set
> 
> #
> # Speakup console speech
> #
> CONFIG_SPEAKUP=y
> # CONFIG_SPEAKUP_SYNTH_ACNTSA is not set
> # CONFIG_SPEAKUP_SYNTH_APOLLO is not set
> CONFIG_SPEAKUP_SYNTH_AUDPTR=y
> CONFIG_SPEAKUP_SYNTH_BNS=y
> # CONFIG_SPEAKUP_SYNTH_DECTLK is not set
> CONFIG_SPEAKUP_SYNTH_DECEXT=y
> # CONFIG_SPEAKUP_SYNTH_LTLK is not set
> # CONFIG_SPEAKUP_SYNTH_SOFT is not set
> CONFIG_SPEAKUP_SYNTH_SPKOUT=y
> CONFIG_SPEAKUP_SYNTH_TXPRT=y
> CONFIG_SPEAKUP_SYNTH_DUMMY=y
> CONFIG_STAGING_MEDIA=y
> CONFIG_VIDEO_ZORAN=y
> # CONFIG_VIDEO_ZORAN_DC30 is not set
> CONFIG_VIDEO_ZORAN_ZR36060=y
> CONFIG_VIDEO_ZORAN_BUZ=y
> CONFIG_VIDEO_ZORAN_DC10=y
> # CONFIG_VIDEO_ZORAN_LML33 is not set
> CONFIG_VIDEO_ZORAN_LML33R10=y
> # CONFIG_VIDEO_ZORAN_AVS6EYES is not set
> 
> #
> # Android
> #
> # CONFIG_FIREWIRE_SERIAL is not set
> CONFIG_GOLDFISH_AUDIO=y
> CONFIG_DGNC=y
> CONFIG_GS_FPGABOOT=y
> # CONFIG_CRYPTO_SKEIN is not set
> # CONFIG_UNISYSSPAR is not set
> # CONFIG_WILC1000_SDIO is not set
> CONFIG_MOST=y
> CONFIG_MOST_CDEV=y
> CONFIG_MOST_NET=y
> CONFIG_MOST_VIDEO=y
> CONFIG_MOST_I2C=y
> CONFIG_MOST_USB=y
> CONFIG_KS7010=y
> # CONFIG_GREYBUS is not set
> 
> #
> # USB Power Delivery and Type-C drivers
> #
> CONFIG_DRM_VBOXVIDEO=y
> CONFIG_MTK_MMC=y
> # CONFIG_MTK_AEE_KDUMP is not set
> # CONFIG_MTK_MMC_CD_POLL is not set
> CONFIG_X86_PLATFORM_DEVICES=y
> CONFIG_ACER_WMI=y
> CONFIG_ACER_WIRELESS=y
> CONFIG_ACERHDF=y
> CONFIG_ALIENWARE_WMI=y
> CONFIG_ASUS_LAPTOP=y
> CONFIG_DELL_SMBIOS=y
> # CONFIG_DELL_SMBIOS_WMI is not set
> CONFIG_DELL_LAPTOP=y
> # CONFIG_DELL_WMI is not set
> # CONFIG_DELL_WMI_AIO is not set
> CONFIG_DELL_WMI_LED=y
> CONFIG_DELL_SMO8800=y
> CONFIG_DELL_RBTN=y
> CONFIG_FUJITSU_LAPTOP=y
> CONFIG_FUJITSU_TABLET=y
> CONFIG_AMILO_RFKILL=y
> CONFIG_GPD_POCKET_FAN=y
> CONFIG_HP_ACCEL=y
> CONFIG_HP_WIRELESS=y
> CONFIG_HP_WMI=y
> CONFIG_MSI_LAPTOP=y
> # CONFIG_PANASONIC_LAPTOP is not set
> # CONFIG_COMPAL_LAPTOP is not set
> CONFIG_SONY_LAPTOP=y
> # CONFIG_SONYPI_COMPAT is not set
> # CONFIG_IDEAPAD_LAPTOP is not set
> # CONFIG_SENSORS_HDAPS is not set
> # CONFIG_INTEL_MENLOW is not set
> CONFIG_EEEPC_LAPTOP=y
> CONFIG_ASUS_WMI=y
> # CONFIG_ASUS_NB_WMI is not set
> # CONFIG_EEEPC_WMI is not set
> # CONFIG_ASUS_WIRELESS is not set
> CONFIG_ACPI_WMI=y
> CONFIG_WMI_BMOF=y
> # CONFIG_INTEL_WMI_THUNDERBOLT is not set
> CONFIG_MSI_WMI=y
> CONFIG_PEAQ_WMI=y
> # CONFIG_TOPSTAR_LAPTOP is not set
> CONFIG_TOSHIBA_BT_RFKILL=y
> CONFIG_TOSHIBA_HAPS=y
> # CONFIG_TOSHIBA_WMI is not set
> CONFIG_ACPI_CMPC=y
> CONFIG_INTEL_CHT_INT33FE=y
> CONFIG_INTEL_INT0002_VGPIO=y
> CONFIG_INTEL_HID_EVENT=y
> # CONFIG_INTEL_VBTN is not set
> # CONFIG_INTEL_IPS is not set
> # CONFIG_INTEL_PMC_CORE is not set
> CONFIG_IBM_RTL=y
> CONFIG_SAMSUNG_LAPTOP=y
> CONFIG_MXM_WMI=y
> # CONFIG_INTEL_OAKTRAIL is not set
> CONFIG_SAMSUNG_Q10=y
> # CONFIG_APPLE_GMUX is not set
> # CONFIG_INTEL_RST is not set
> CONFIG_INTEL_SMARTCONNECT=y
> # CONFIG_PVPANIC is not set
> CONFIG_INTEL_PMC_IPC=y
> CONFIG_INTEL_BXTWC_PMIC_TMU=y
> # CONFIG_SURFACE_PRO3_BUTTON is not set
> CONFIG_SURFACE_3_BUTTON=y
> CONFIG_INTEL_PUNIT_IPC=y
> CONFIG_INTEL_TELEMETRY=y
> CONFIG_MLX_PLATFORM=y
> CONFIG_INTEL_CHTDC_TI_PWRBTN=y
> CONFIG_PMC_ATOM=y
> CONFIG_GOLDFISH_BUS=y
> # CONFIG_GOLDFISH_PIPE is not set
> # CONFIG_CHROME_PLATFORMS is not set
> # CONFIG_MELLANOX_PLATFORM is not set
> CONFIG_CLKDEV_LOOKUP=y
> CONFIG_HAVE_CLK_PREPARE=y
> CONFIG_COMMON_CLK=y
> 
> #
> # Common Clock Framework
> #
> # CONFIG_COMMON_CLK_WM831X is not set
> # CONFIG_COMMON_CLK_SI5351 is not set
> CONFIG_COMMON_CLK_SI544=y
> CONFIG_COMMON_CLK_CDCE706=y
> CONFIG_COMMON_CLK_CS2000_CP=y
> # CONFIG_COMMON_CLK_PALMAS is not set
> # CONFIG_HWSPINLOCK is not set
> 
> #
> # Clock Source drivers
> #
> CONFIG_CLKEVT_I8253=y
> CONFIG_I8253_LOCK=y
> CONFIG_CLKBLD_I8253=y
> # CONFIG_MAILBOX is not set
> CONFIG_IOMMU_SUPPORT=y
> 
> #
> # Generic IOMMU Pagetable Support
> #
> CONFIG_IOMMU_IOVA=y
> # CONFIG_AMD_IOMMU is not set
> 
> #
> # Remoteproc drivers
> #
> CONFIG_REMOTEPROC=y
> 
> #
> # Rpmsg drivers
> #
> CONFIG_RPMSG=y
> CONFIG_RPMSG_CHAR=y
> CONFIG_RPMSG_VIRTIO=y
> # CONFIG_SOUNDWIRE is not set
> 
> #
> # SOC (System On Chip) specific Drivers
> #
> 
> #
> # Amlogic SoC drivers
> #
> 
> #
> # Broadcom SoC drivers
> #
> 
> #
> # i.MX SoC drivers
> #
> 
> #
> # Qualcomm SoC drivers
> #
> CONFIG_SOC_TI=y
> 
> #
> # Xilinx SoC drivers
> #
> CONFIG_XILINX_VCU=y
> # CONFIG_PM_DEVFREQ is not set
> CONFIG_EXTCON=y
> 
> #
> # Extcon Device Drivers
> #
> CONFIG_EXTCON_AXP288=y
> # CONFIG_EXTCON_GPIO is not set
> CONFIG_EXTCON_INTEL_INT3496=y
> CONFIG_EXTCON_INTEL_CHT_WC=y
> CONFIG_EXTCON_MAX14577=y
> # CONFIG_EXTCON_MAX3355 is not set
> CONFIG_EXTCON_MAX77693=y
> # CONFIG_EXTCON_MAX77843 is not set
> # CONFIG_EXTCON_PALMAS is not set
> CONFIG_EXTCON_RT8973A=y
> # CONFIG_EXTCON_SM5502 is not set
> # CONFIG_EXTCON_USB_GPIO is not set
> # CONFIG_MEMORY is not set
> # CONFIG_IIO is not set
> # CONFIG_NTB is not set
> CONFIG_VME_BUS=y
> 
> #
> # VME Bridge Drivers
> #
> CONFIG_VME_CA91CX42=y
> # CONFIG_VME_TSI148 is not set
> # CONFIG_VME_FAKE is not set
> 
> #
> # VME Board Drivers
> #
> CONFIG_VMIVME_7805=y
> 
> #
> # VME Device Drivers
> #
> CONFIG_VME_USER=y
> # CONFIG_PWM is not set
> 
> #
> # IRQ chip support
> #
> CONFIG_ARM_GIC_MAX_NR=1
> CONFIG_IPACK_BUS=y
> CONFIG_BOARD_TPCI200=y
> CONFIG_SERIAL_IPOCTAL=y
> CONFIG_RESET_CONTROLLER=y
> CONFIG_RESET_TI_SYSCON=y
> CONFIG_FMC=y
> CONFIG_FMC_FAKEDEV=y
> CONFIG_FMC_TRIVIAL=y
> CONFIG_FMC_WRITE_EEPROM=y
> CONFIG_FMC_CHARDEV=y
> 
> #
> # PHY Subsystem
> #
> CONFIG_GENERIC_PHY=y
> CONFIG_BCM_KONA_USB2_PHY=y
> CONFIG_PHY_PXA_28NM_HSIC=y
> CONFIG_PHY_PXA_28NM_USB2=y
> # CONFIG_POWERCAP is not set
> # CONFIG_MCB is not set
> 
> #
> # Performance monitor support
> #
> CONFIG_RAS=y
> CONFIG_THUNDERBOLT=y
> 
> #
> # Android
> #
> # CONFIG_ANDROID is not set
> # CONFIG_LIBNVDIMM is not set
> CONFIG_DAX=y
> CONFIG_DEV_DAX=y
> CONFIG_NVMEM=y
> CONFIG_RAVE_SP_EEPROM=y
> 
> #
> # HW tracing support
> #
> CONFIG_STM=y
> CONFIG_STM_DUMMY=y
> CONFIG_STM_SOURCE_CONSOLE=y
> CONFIG_STM_SOURCE_HEARTBEAT=y
> CONFIG_STM_SOURCE_FTRACE=y
> # CONFIG_INTEL_TH is not set
> CONFIG_FPGA=y
> CONFIG_ALTERA_PR_IP_CORE=y
> CONFIG_FPGA_MGR_ALTERA_CVP=y
> CONFIG_FPGA_BRIDGE=y
> CONFIG_XILINX_PR_DECOUPLER=y
> CONFIG_FPGA_REGION=y
> # CONFIG_UNISYS_VISORBUS is not set
> CONFIG_SIOX=y
> CONFIG_SIOX_BUS_GPIO=y
> # CONFIG_SLIMBUS is not set
> 
> #
> # Firmware Drivers
> #
> CONFIG_EDD=y
> CONFIG_EDD_OFF=y
> CONFIG_FIRMWARE_MEMMAP=y
> # CONFIG_DELL_RBU is not set
> # CONFIG_DCDBAS is not set
> # CONFIG_DMIID is not set
> # CONFIG_DMI_SYSFS is not set
> CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
> # CONFIG_ISCSI_IBFT_FIND is not set
> # CONFIG_FW_CFG_SYSFS is not set
> CONFIG_GOOGLE_FIRMWARE=y
> # CONFIG_GOOGLE_COREBOOT_TABLE_ACPI is not set
> CONFIG_GOOGLE_MEMCONSOLE=y
> CONFIG_GOOGLE_MEMCONSOLE_X86_LEGACY=y
> 
> #
> # Tegra firmware driver
> #
> 
> #
> # File systems
> #
> CONFIG_DCACHE_WORD_ACCESS=y
> CONFIG_FS_IOMAP=y
> CONFIG_EXT2_FS=y
> CONFIG_EXT2_FS_XATTR=y
> CONFIG_EXT2_FS_POSIX_ACL=y
> CONFIG_EXT2_FS_SECURITY=y
> CONFIG_EXT3_FS=y
> # CONFIG_EXT3_FS_POSIX_ACL is not set
> # CONFIG_EXT3_FS_SECURITY is not set
> CONFIG_EXT4_FS=y
> CONFIG_EXT4_FS_POSIX_ACL=y
> CONFIG_EXT4_FS_SECURITY=y
> CONFIG_EXT4_ENCRYPTION=y
> CONFIG_EXT4_FS_ENCRYPTION=y
> CONFIG_EXT4_DEBUG=y
> CONFIG_JBD2=y
> CONFIG_JBD2_DEBUG=y
> CONFIG_FS_MBCACHE=y
> CONFIG_REISERFS_FS=y
> # CONFIG_REISERFS_CHECK is not set
> CONFIG_REISERFS_PROC_INFO=y
> # CONFIG_REISERFS_FS_XATTR is not set
> # CONFIG_JFS_FS is not set
> CONFIG_XFS_FS=y
> CONFIG_XFS_QUOTA=y
> CONFIG_XFS_POSIX_ACL=y
> # CONFIG_XFS_RT is not set
> CONFIG_XFS_ONLINE_SCRUB=y
> # CONFIG_XFS_ONLINE_REPAIR is not set
> # CONFIG_XFS_WARN is not set
> # CONFIG_XFS_DEBUG is not set
> CONFIG_GFS2_FS=y
> CONFIG_OCFS2_FS=y
> CONFIG_OCFS2_FS_O2CB=y
> CONFIG_OCFS2_FS_STATS=y
> CONFIG_OCFS2_DEBUG_MASKLOG=y
> CONFIG_OCFS2_DEBUG_FS=y
> # CONFIG_BTRFS_FS is not set
> CONFIG_NILFS2_FS=y
> CONFIG_F2FS_FS=y
> CONFIG_F2FS_STAT_FS=y
> CONFIG_F2FS_FS_XATTR=y
> # CONFIG_F2FS_FS_POSIX_ACL is not set
> CONFIG_F2FS_FS_SECURITY=y
> # CONFIG_F2FS_CHECK_FS is not set
> # CONFIG_F2FS_FS_ENCRYPTION is not set
> CONFIG_F2FS_IO_TRACE=y
> CONFIG_F2FS_FAULT_INJECTION=y
> CONFIG_FS_DAX=y
> CONFIG_FS_POSIX_ACL=y
> CONFIG_EXPORTFS=y
> # CONFIG_EXPORTFS_BLOCK_OPS is not set
> CONFIG_FILE_LOCKING=y
> CONFIG_MANDATORY_FILE_LOCKING=y
> CONFIG_FS_ENCRYPTION=y
> CONFIG_FSNOTIFY=y
> # CONFIG_DNOTIFY is not set
> CONFIG_INOTIFY_USER=y
> CONFIG_FANOTIFY=y
> CONFIG_QUOTA=y
> # CONFIG_QUOTA_NETLINK_INTERFACE is not set
> CONFIG_PRINT_QUOTA_WARNING=y
> # CONFIG_QUOTA_DEBUG is not set
> CONFIG_QUOTA_TREE=y
> CONFIG_QFMT_V1=y
> # CONFIG_QFMT_V2 is not set
> CONFIG_QUOTACTL=y
> CONFIG_QUOTACTL_COMPAT=y
> # CONFIG_AUTOFS4_FS is not set
> CONFIG_AUTOFS_FS=y
> CONFIG_FUSE_FS=y
> # CONFIG_CUSE is not set
> CONFIG_OVERLAY_FS=y
> # CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
> # CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
> # CONFIG_OVERLAY_FS_INDEX is not set
> # CONFIG_OVERLAY_FS_XINO_AUTO is not set
> 
> #
> # Caches
> #
> CONFIG_FSCACHE=y
> CONFIG_FSCACHE_STATS=y
> CONFIG_FSCACHE_HISTOGRAM=y
> CONFIG_FSCACHE_DEBUG=y
> # CONFIG_FSCACHE_OBJECT_LIST is not set
> CONFIG_CACHEFILES=y
> # CONFIG_CACHEFILES_DEBUG is not set
> CONFIG_CACHEFILES_HISTOGRAM=y
> 
> #
> # CD-ROM/DVD Filesystems
> #
> # CONFIG_ISO9660_FS is not set
> CONFIG_UDF_FS=y
> 
> #
> # DOS/FAT/NT Filesystems
> #
> CONFIG_FAT_FS=y
> CONFIG_MSDOS_FS=y
> CONFIG_VFAT_FS=y
> CONFIG_FAT_DEFAULT_CODEPAGE=437
> CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
> CONFIG_FAT_DEFAULT_UTF8=y
> CONFIG_NTFS_FS=y
> # CONFIG_NTFS_DEBUG is not set
> # CONFIG_NTFS_RW is not set
> 
> #
> # Pseudo filesystems
> #
> CONFIG_PROC_FS=y
> # CONFIG_PROC_KCORE is not set
> # CONFIG_PROC_VMCORE is not set
> CONFIG_PROC_SYSCTL=y
> CONFIG_PROC_PAGE_MONITOR=y
> CONFIG_PROC_CHILDREN=y
> CONFIG_KERNFS=y
> CONFIG_SYSFS=y
> CONFIG_TMPFS=y
> CONFIG_TMPFS_POSIX_ACL=y
> CONFIG_TMPFS_XATTR=y
> # CONFIG_HUGETLBFS is not set
> CONFIG_MEMFD_CREATE=y
> CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
> CONFIG_CONFIGFS_FS=y
> CONFIG_MISC_FILESYSTEMS=y
> # CONFIG_ORANGEFS_FS is not set
> CONFIG_ADFS_FS=y
> CONFIG_ADFS_FS_RW=y
> CONFIG_AFFS_FS=y
> CONFIG_ECRYPT_FS=y
> CONFIG_ECRYPT_FS_MESSAGING=y
> CONFIG_HFS_FS=y
> CONFIG_HFSPLUS_FS=y
> # CONFIG_HFSPLUS_FS_POSIX_ACL is not set
> # CONFIG_BEFS_FS is not set
> CONFIG_BFS_FS=y
> CONFIG_EFS_FS=y
> CONFIG_JFFS2_FS=y
> CONFIG_JFFS2_FS_DEBUG=0
> CONFIG_JFFS2_FS_WRITEBUFFER=y
> CONFIG_JFFS2_FS_WBUF_VERIFY=y
> # CONFIG_JFFS2_SUMMARY is not set
> CONFIG_JFFS2_FS_XATTR=y
> CONFIG_JFFS2_FS_POSIX_ACL=y
> # CONFIG_JFFS2_FS_SECURITY is not set
> # CONFIG_JFFS2_COMPRESSION_OPTIONS is not set
> CONFIG_JFFS2_ZLIB=y
> CONFIG_JFFS2_RTIME=y
> CONFIG_UBIFS_FS=y
> CONFIG_UBIFS_FS_ADVANCED_COMPR=y
> CONFIG_UBIFS_FS_LZO=y
> # CONFIG_UBIFS_FS_ZLIB is not set
> CONFIG_UBIFS_ATIME_SUPPORT=y
> # CONFIG_UBIFS_FS_ENCRYPTION is not set
> # CONFIG_UBIFS_FS_SECURITY is not set
> CONFIG_CRAMFS=y
> CONFIG_CRAMFS_BLOCKDEV=y
> CONFIG_CRAMFS_MTD=y
> CONFIG_SQUASHFS=y
> CONFIG_SQUASHFS_FILE_CACHE=y
> # CONFIG_SQUASHFS_FILE_DIRECT is not set
> # CONFIG_SQUASHFS_DECOMP_SINGLE is not set
> CONFIG_SQUASHFS_DECOMP_MULTI=y
> # CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU is not set
> CONFIG_SQUASHFS_XATTR=y
> CONFIG_SQUASHFS_ZLIB=y
> CONFIG_SQUASHFS_LZ4=y
> CONFIG_SQUASHFS_LZO=y
> CONFIG_SQUASHFS_XZ=y
> # CONFIG_SQUASHFS_ZSTD is not set
> CONFIG_SQUASHFS_4K_DEVBLK_SIZE=y
> # CONFIG_SQUASHFS_EMBEDDED is not set
> CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
> CONFIG_VXFS_FS=y
> # CONFIG_MINIX_FS is not set
> CONFIG_OMFS_FS=y
> # CONFIG_HPFS_FS is not set
> CONFIG_QNX4FS_FS=y
> # CONFIG_QNX6FS_FS is not set
> CONFIG_ROMFS_FS=y
> # CONFIG_ROMFS_BACKED_BY_BLOCK is not set
> CONFIG_ROMFS_BACKED_BY_MTD=y
> # CONFIG_ROMFS_BACKED_BY_BOTH is not set
> CONFIG_ROMFS_ON_MTD=y
> # CONFIG_PSTORE is not set
> CONFIG_SYSV_FS=y
> # CONFIG_UFS_FS is not set
> CONFIG_EXOFS_FS=y
> # CONFIG_EXOFS_DEBUG is not set
> CONFIG_ORE=y
> CONFIG_NETWORK_FILESYSTEMS=y
> CONFIG_NFS_FS=y
> CONFIG_NFS_V2=y
> CONFIG_NFS_V3=y
> # CONFIG_NFS_V3_ACL is not set
> CONFIG_NFS_V4=y
> # CONFIG_NFS_SWAP is not set
> # CONFIG_NFS_V4_1 is not set
> # CONFIG_ROOT_NFS is not set
> # CONFIG_NFS_FSCACHE is not set
> # CONFIG_NFS_USE_LEGACY_DNS is not set
> CONFIG_NFS_USE_KERNEL_DNS=y
> # CONFIG_NFSD is not set
> CONFIG_GRACE_PERIOD=y
> CONFIG_LOCKD=y
> CONFIG_LOCKD_V4=y
> CONFIG_NFS_COMMON=y
> CONFIG_SUNRPC=y
> CONFIG_SUNRPC_GSS=y
> CONFIG_RPCSEC_GSS_KRB5=y
> # CONFIG_SUNRPC_DEBUG is not set
> # CONFIG_CEPH_FS is not set
> CONFIG_CIFS=y
> # CONFIG_CIFS_STATS is not set
> # CONFIG_CIFS_WEAK_PW_HASH is not set
> # CONFIG_CIFS_UPCALL is not set
> # CONFIG_CIFS_XATTR is not set
> CONFIG_CIFS_DEBUG=y
> # CONFIG_CIFS_DEBUG2 is not set
> # CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
> # CONFIG_CIFS_DFS_UPCALL is not set
> # CONFIG_CIFS_SMB311 is not set
> # CONFIG_CIFS_FSCACHE is not set
> # CONFIG_CODA_FS is not set
> # CONFIG_AFS_FS is not set
> # CONFIG_9P_FS is not set
> CONFIG_NLS=y
> CONFIG_NLS_DEFAULT="iso8859-1"
> # CONFIG_NLS_CODEPAGE_437 is not set
> CONFIG_NLS_CODEPAGE_737=y
> CONFIG_NLS_CODEPAGE_775=y
> # CONFIG_NLS_CODEPAGE_850 is not set
> # CONFIG_NLS_CODEPAGE_852 is not set
> CONFIG_NLS_CODEPAGE_855=y
> # CONFIG_NLS_CODEPAGE_857 is not set
> CONFIG_NLS_CODEPAGE_860=y
> CONFIG_NLS_CODEPAGE_861=y
> # CONFIG_NLS_CODEPAGE_862 is not set
> # CONFIG_NLS_CODEPAGE_863 is not set
> # CONFIG_NLS_CODEPAGE_864 is not set
> CONFIG_NLS_CODEPAGE_865=y
> # CONFIG_NLS_CODEPAGE_866 is not set
> CONFIG_NLS_CODEPAGE_869=y
> CONFIG_NLS_CODEPAGE_936=y
> CONFIG_NLS_CODEPAGE_950=y
> CONFIG_NLS_CODEPAGE_932=y
> # CONFIG_NLS_CODEPAGE_949 is not set
> # CONFIG_NLS_CODEPAGE_874 is not set
> CONFIG_NLS_ISO8859_8=y
> CONFIG_NLS_CODEPAGE_1250=y
> CONFIG_NLS_CODEPAGE_1251=y
> # CONFIG_NLS_ASCII is not set
> # CONFIG_NLS_ISO8859_1 is not set
> CONFIG_NLS_ISO8859_2=y
> # CONFIG_NLS_ISO8859_3 is not set
> # CONFIG_NLS_ISO8859_4 is not set
> # CONFIG_NLS_ISO8859_5 is not set
> CONFIG_NLS_ISO8859_6=y
> CONFIG_NLS_ISO8859_7=y
> CONFIG_NLS_ISO8859_9=y
> CONFIG_NLS_ISO8859_13=y
> CONFIG_NLS_ISO8859_14=y
> # CONFIG_NLS_ISO8859_15 is not set
> CONFIG_NLS_KOI8_R=y
> # CONFIG_NLS_KOI8_U is not set
> CONFIG_NLS_MAC_ROMAN=y
> # CONFIG_NLS_MAC_CELTIC is not set
> CONFIG_NLS_MAC_CENTEURO=y
> CONFIG_NLS_MAC_CROATIAN=y
> CONFIG_NLS_MAC_CYRILLIC=y
> CONFIG_NLS_MAC_GAELIC=y
> CONFIG_NLS_MAC_GREEK=y
> # CONFIG_NLS_MAC_ICELAND is not set
> # CONFIG_NLS_MAC_INUIT is not set
> CONFIG_NLS_MAC_ROMANIAN=y
> # CONFIG_NLS_MAC_TURKISH is not set
> CONFIG_NLS_UTF8=y
> # CONFIG_DLM is not set
> 
> #
> # Kernel hacking
> #
> CONFIG_TRACE_IRQFLAGS_SUPPORT=y
> 
> #
> # printk and dmesg options
> #
> CONFIG_PRINTK_TIME=y
> CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
> CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
> CONFIG_BOOT_PRINTK_DELAY=y
> # CONFIG_DYNAMIC_DEBUG is not set
> 
> #
> # Compile-time checks and compiler options
> #
> CONFIG_DEBUG_INFO=y
> CONFIG_DEBUG_INFO_REDUCED=y
> # CONFIG_DEBUG_INFO_SPLIT is not set
> # CONFIG_DEBUG_INFO_DWARF4 is not set
> # CONFIG_GDB_SCRIPTS is not set
> CONFIG_ENABLE_WARN_DEPRECATED=y
> # CONFIG_ENABLE_MUST_CHECK is not set
> CONFIG_FRAME_WARN=8192
> # CONFIG_STRIP_ASM_SYMS is not set
> CONFIG_READABLE_ASM=y
> # CONFIG_UNUSED_SYMBOLS is not set
> # CONFIG_PAGE_OWNER is not set
> CONFIG_DEBUG_FS=y
> CONFIG_HEADERS_CHECK=y
> # CONFIG_DEBUG_SECTION_MISMATCH is not set
> # CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
> CONFIG_FRAME_POINTER=y
> CONFIG_STACK_VALIDATION=y
> CONFIG_DEBUG_FORCE_WEAK_PER_CPU=y
> CONFIG_MAGIC_SYSRQ=y
> CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
> CONFIG_MAGIC_SYSRQ_SERIAL=y
> CONFIG_DEBUG_KERNEL=y
> 
> #
> # Memory Debugging
> #
> CONFIG_PAGE_EXTENSION=y
> CONFIG_DEBUG_PAGEALLOC=y
> CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT=y
> # CONFIG_PAGE_POISONING is not set
> # CONFIG_DEBUG_PAGE_REF is not set
> # CONFIG_DEBUG_RODATA_TEST is not set
> CONFIG_DEBUG_OBJECTS=y
> # CONFIG_DEBUG_OBJECTS_SELFTEST is not set
> CONFIG_DEBUG_OBJECTS_FREE=y
> # CONFIG_DEBUG_OBJECTS_TIMERS is not set
> CONFIG_DEBUG_OBJECTS_WORK=y
> # CONFIG_DEBUG_OBJECTS_RCU_HEAD is not set
> CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER=y
> CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
> # CONFIG_DEBUG_SLAB is not set
> CONFIG_HAVE_DEBUG_KMEMLEAK=y
> # CONFIG_DEBUG_KMEMLEAK is not set
> # CONFIG_DEBUG_STACK_USAGE is not set
> # CONFIG_DEBUG_VM is not set
> CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
> CONFIG_DEBUG_VIRTUAL=y
> CONFIG_DEBUG_MEMORY_INIT=y
> # CONFIG_DEBUG_PER_CPU_MAPS is not set
> CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
> CONFIG_DEBUG_STACKOVERFLOW=y
> CONFIG_HAVE_ARCH_KASAN=y
> CONFIG_KASAN=y
> # CONFIG_KASAN_EXTRA is not set
> CONFIG_KASAN_OUTLINE=y
> # CONFIG_KASAN_INLINE is not set
> CONFIG_ARCH_HAS_KCOV=y
> CONFIG_CC_HAS_SANCOV_TRACE_PC=y
> CONFIG_KCOV=y
> CONFIG_KCOV_INSTRUMENT_ALL=y
> CONFIG_DEBUG_SHIRQ=y
> 
> #
> # Debug Lockups and Hangs
> #
> CONFIG_LOCKUP_DETECTOR=y
> CONFIG_SOFTLOCKUP_DETECTOR=y
> CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
> CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=1
> CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
> # CONFIG_HARDLOCKUP_DETECTOR is not set
> # CONFIG_DETECT_HUNG_TASK is not set
> CONFIG_WQ_WATCHDOG=y
> # CONFIG_PANIC_ON_OOPS is not set
> CONFIG_PANIC_ON_OOPS_VALUE=0
> CONFIG_PANIC_TIMEOUT=0
> # CONFIG_SCHED_DEBUG is not set
> CONFIG_SCHED_INFO=y
> CONFIG_SCHEDSTATS=y
> CONFIG_SCHED_STACK_END_CHECK=y
> # CONFIG_DEBUG_TIMEKEEPING is not set
> # CONFIG_DEBUG_PREEMPT is not set
> 
> #
> # Lock Debugging (spinlocks, mutexes, etc...)
> #
> CONFIG_LOCK_DEBUGGING_SUPPORT=y
> # CONFIG_PROVE_LOCKING is not set
> CONFIG_LOCK_STAT=y
> CONFIG_DEBUG_RT_MUTEXES=y
> CONFIG_DEBUG_SPINLOCK=y
> CONFIG_DEBUG_MUTEXES=y
> # CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
> # CONFIG_DEBUG_RWSEMS is not set
> CONFIG_DEBUG_LOCK_ALLOC=y
> CONFIG_LOCKDEP=y
> CONFIG_DEBUG_LOCKDEP=y
> CONFIG_DEBUG_ATOMIC_SLEEP=y
> CONFIG_DEBUG_LOCKING_API_SELFTESTS=y
> CONFIG_LOCK_TORTURE_TEST=y
> # CONFIG_WW_MUTEX_SELFTEST is not set
> CONFIG_TRACE_IRQFLAGS=y
> CONFIG_STACKTRACE=y
> # CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
> # CONFIG_DEBUG_KOBJECT is not set
> CONFIG_DEBUG_BUGVERBOSE=y
> CONFIG_DEBUG_LIST=y
> CONFIG_DEBUG_PI_LIST=y
> # CONFIG_DEBUG_SG is not set
> # CONFIG_DEBUG_NOTIFIERS is not set
> # CONFIG_DEBUG_CREDENTIALS is not set
> 
> #
> # RCU Debugging
> #
> CONFIG_TORTURE_TEST=y
> CONFIG_RCU_PERF_TEST=y
> # CONFIG_RCU_TORTURE_TEST is not set
> CONFIG_RCU_CPU_STALL_TIMEOUT=21
> # CONFIG_RCU_TRACE is not set
> # CONFIG_RCU_EQS_DEBUG is not set
> # CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
> # CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
> # CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
> # CONFIG_NOTIFIER_ERROR_INJECTION is not set
> # CONFIG_FAULT_INJECTION is not set
> # CONFIG_LATENCYTOP is not set
> CONFIG_USER_STACKTRACE_SUPPORT=y
> CONFIG_NOP_TRACER=y
> CONFIG_HAVE_FUNCTION_TRACER=y
> CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
> CONFIG_HAVE_DYNAMIC_FTRACE=y
> CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
> CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
> CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
> CONFIG_HAVE_FENTRY=y
> CONFIG_HAVE_C_RECORDMCOUNT=y
> CONFIG_TRACER_MAX_TRACE=y
> CONFIG_TRACE_CLOCK=y
> CONFIG_RING_BUFFER=y
> CONFIG_EVENT_TRACING=y
> CONFIG_CONTEXT_SWITCH_TRACER=y
> CONFIG_RING_BUFFER_ALLOW_SWAP=y
> CONFIG_TRACING=y
> CONFIG_GENERIC_TRACER=y
> CONFIG_TRACING_SUPPORT=y
> CONFIG_FTRACE=y
> CONFIG_FUNCTION_TRACER=y
> CONFIG_FUNCTION_GRAPH_TRACER=y
> CONFIG_PREEMPTIRQ_EVENTS=y
> # CONFIG_IRQSOFF_TRACER is not set
> CONFIG_PREEMPT_TRACER=y
> # CONFIG_SCHED_TRACER is not set
> CONFIG_HWLAT_TRACER=y
> # CONFIG_FTRACE_SYSCALLS is not set
> CONFIG_TRACER_SNAPSHOT=y
> CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP=y
> CONFIG_TRACE_BRANCH_PROFILING=y
> # CONFIG_BRANCH_PROFILE_NONE is not set
> # CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
> CONFIG_PROFILE_ALL_BRANCHES=y
> CONFIG_TRACING_BRANCHES=y
> CONFIG_BRANCH_TRACER=y
> CONFIG_STACK_TRACER=y
> # CONFIG_BLK_DEV_IO_TRACE is not set
> CONFIG_UPROBE_EVENTS=y
> CONFIG_BPF_EVENTS=y
> CONFIG_PROBE_EVENTS=y
> # CONFIG_DYNAMIC_FTRACE is not set
> # CONFIG_FUNCTION_PROFILER is not set
> # CONFIG_FTRACE_STARTUP_TEST is not set
> # CONFIG_MMIOTRACE is not set
> CONFIG_TRACING_MAP=y
> CONFIG_HIST_TRIGGERS=y
> # CONFIG_TRACEPOINT_BENCHMARK is not set
> CONFIG_RING_BUFFER_BENCHMARK=y
> # CONFIG_RING_BUFFER_STARTUP_TEST is not set
> CONFIG_TRACE_EVAL_MAP_FILE=y
> CONFIG_TRACING_EVENTS_GPIO=y
> CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
> # CONFIG_DMA_API_DEBUG is not set
> # CONFIG_RUNTIME_TESTING_MENU is not set
> # CONFIG_MEMTEST is not set
> CONFIG_BUG_ON_DATA_CORRUPTION=y
> # CONFIG_SAMPLES is not set
> CONFIG_HAVE_ARCH_KGDB=y
> # CONFIG_KGDB is not set
> CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
> CONFIG_UBSAN=y
> # CONFIG_UBSAN_SANITIZE_ALL is not set
> # CONFIG_UBSAN_ALIGNMENT is not set
> # CONFIG_UBSAN_NULL is not set
> CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
> CONFIG_STRICT_DEVMEM=y
> CONFIG_IO_STRICT_DEVMEM=y
> CONFIG_EARLY_PRINTK_USB=y
> CONFIG_X86_VERBOSE_BOOTUP=y
> CONFIG_EARLY_PRINTK=y
> CONFIG_EARLY_PRINTK_DBGP=y
> # CONFIG_EARLY_PRINTK_USB_XDBC is not set
> CONFIG_X86_PTDUMP_CORE=y
> CONFIG_X86_PTDUMP=y
> CONFIG_DEBUG_WX=y
> CONFIG_DOUBLEFAULT=y
> CONFIG_DEBUG_TLBFLUSH=y
> CONFIG_HAVE_MMIOTRACE_SUPPORT=y
> CONFIG_IO_DELAY_TYPE_0X80=0
> CONFIG_IO_DELAY_TYPE_0XED=1
> CONFIG_IO_DELAY_TYPE_UDELAY=2
> CONFIG_IO_DELAY_TYPE_NONE=3
> # CONFIG_IO_DELAY_0X80 is not set
> # CONFIG_IO_DELAY_0XED is not set
> CONFIG_IO_DELAY_UDELAY=y
> # CONFIG_IO_DELAY_NONE is not set
> CONFIG_DEFAULT_IO_DELAY_TYPE=2
> CONFIG_DEBUG_BOOT_PARAMS=y
> # CONFIG_CPA_DEBUG is not set
> # CONFIG_OPTIMIZE_INLINING is not set
> # CONFIG_DEBUG_ENTRY is not set
> CONFIG_DEBUG_NMI_SELFTEST=y
> # CONFIG_X86_DEBUG_FPU is not set
> CONFIG_PUNIT_ATOM_DEBUG=y
> # CONFIG_UNWINDER_ORC is not set
> CONFIG_UNWINDER_FRAME_POINTER=y
> 
> #
> # Security options
> #
> CONFIG_KEYS=y
> CONFIG_KEYS_COMPAT=y
> CONFIG_PERSISTENT_KEYRINGS=y
> # CONFIG_BIG_KEYS is not set
> CONFIG_TRUSTED_KEYS=y
> # CONFIG_ENCRYPTED_KEYS is not set
> CONFIG_KEY_DH_OPERATIONS=y
> # CONFIG_SECURITY_DMESG_RESTRICT is not set
> # CONFIG_SECURITY is not set
> CONFIG_SECURITYFS=y
> # CONFIG_PAGE_TABLE_ISOLATION is not set
> CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
> CONFIG_HARDENED_USERCOPY=y
> # CONFIG_HARDENED_USERCOPY_FALLBACK is not set
> # CONFIG_FORTIFY_SOURCE is not set
> # CONFIG_STATIC_USERMODEHELPER is not set
> CONFIG_DEFAULT_SECURITY_DAC=y
> CONFIG_DEFAULT_SECURITY=""
> CONFIG_XOR_BLOCKS=y
> CONFIG_ASYNC_CORE=y
> CONFIG_ASYNC_XOR=y
> CONFIG_ASYNC_PQ=y
> CONFIG_CRYPTO=y
> 
> #
> # Crypto core or helper
> #
> CONFIG_CRYPTO_ALGAPI=y
> CONFIG_CRYPTO_ALGAPI2=y
> CONFIG_CRYPTO_AEAD=y
> CONFIG_CRYPTO_AEAD2=y
> CONFIG_CRYPTO_BLKCIPHER=y
> CONFIG_CRYPTO_BLKCIPHER2=y
> CONFIG_CRYPTO_HASH=y
> CONFIG_CRYPTO_HASH2=y
> CONFIG_CRYPTO_RNG=y
> CONFIG_CRYPTO_RNG2=y
> CONFIG_CRYPTO_RNG_DEFAULT=y
> CONFIG_CRYPTO_AKCIPHER2=y
> CONFIG_CRYPTO_AKCIPHER=y
> CONFIG_CRYPTO_KPP2=y
> CONFIG_CRYPTO_KPP=y
> CONFIG_CRYPTO_ACOMP2=y
> CONFIG_CRYPTO_RSA=y
> CONFIG_CRYPTO_DH=y
> CONFIG_CRYPTO_ECDH=y
> CONFIG_CRYPTO_MANAGER=y
> CONFIG_CRYPTO_MANAGER2=y
> CONFIG_CRYPTO_USER=y
> CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
> CONFIG_CRYPTO_GF128MUL=y
> CONFIG_CRYPTO_NULL=y
> CONFIG_CRYPTO_NULL2=y
> CONFIG_CRYPTO_PCRYPT=y
> CONFIG_CRYPTO_WORKQUEUE=y
> CONFIG_CRYPTO_CRYPTD=y
> CONFIG_CRYPTO_MCRYPTD=y
> CONFIG_CRYPTO_AUTHENC=y
> CONFIG_CRYPTO_SIMD=y
> CONFIG_CRYPTO_GLUE_HELPER_X86=y
> 
> #
> # Authenticated Encryption with Associated Data
> #
> CONFIG_CRYPTO_CCM=y
> CONFIG_CRYPTO_GCM=y
> # CONFIG_CRYPTO_CHACHA20POLY1305 is not set
> # CONFIG_CRYPTO_AEGIS128 is not set
> CONFIG_CRYPTO_AEGIS128L=y
> CONFIG_CRYPTO_AEGIS256=y
> CONFIG_CRYPTO_AEGIS128_AESNI_SSE2=y
> # CONFIG_CRYPTO_AEGIS128L_AESNI_SSE2 is not set
> CONFIG_CRYPTO_AEGIS256_AESNI_SSE2=y
> CONFIG_CRYPTO_MORUS640=y
> # CONFIG_CRYPTO_MORUS640_SSE2 is not set
> CONFIG_CRYPTO_MORUS1280=y
> CONFIG_CRYPTO_MORUS1280_GLUE=y
> # CONFIG_CRYPTO_MORUS1280_SSE2 is not set
> CONFIG_CRYPTO_MORUS1280_AVX2=y
> CONFIG_CRYPTO_SEQIV=y
> CONFIG_CRYPTO_ECHAINIV=y
> 
> #
> # Block modes
> #
> CONFIG_CRYPTO_CBC=y
> # CONFIG_CRYPTO_CFB is not set
> CONFIG_CRYPTO_CTR=y
> CONFIG_CRYPTO_CTS=y
> CONFIG_CRYPTO_ECB=y
> # CONFIG_CRYPTO_LRW is not set
> CONFIG_CRYPTO_PCBC=y
> CONFIG_CRYPTO_XTS=y
> # CONFIG_CRYPTO_KEYWRAP is not set
> 
> #
> # Hash modes
> #
> CONFIG_CRYPTO_CMAC=y
> CONFIG_CRYPTO_HMAC=y
> CONFIG_CRYPTO_XCBC=y
> CONFIG_CRYPTO_VMAC=y
> 
> #
> # Digest
> #
> CONFIG_CRYPTO_CRC32C=y
> CONFIG_CRYPTO_CRC32C_INTEL=y
> CONFIG_CRYPTO_CRC32=y
> CONFIG_CRYPTO_CRC32_PCLMUL=y
> CONFIG_CRYPTO_CRCT10DIF=y
> CONFIG_CRYPTO_CRCT10DIF_PCLMUL=y
> CONFIG_CRYPTO_GHASH=y
> CONFIG_CRYPTO_POLY1305=y
> # CONFIG_CRYPTO_POLY1305_X86_64 is not set
> CONFIG_CRYPTO_MD4=y
> CONFIG_CRYPTO_MD5=y
> CONFIG_CRYPTO_MICHAEL_MIC=y
> # CONFIG_CRYPTO_RMD128 is not set
> # CONFIG_CRYPTO_RMD160 is not set
> CONFIG_CRYPTO_RMD256=y
> CONFIG_CRYPTO_RMD320=y
> CONFIG_CRYPTO_SHA1=y
> CONFIG_CRYPTO_SHA1_SSSE3=y
> CONFIG_CRYPTO_SHA256_SSSE3=y
> CONFIG_CRYPTO_SHA512_SSSE3=y
> CONFIG_CRYPTO_SHA1_MB=y
> CONFIG_CRYPTO_SHA256_MB=y
> # CONFIG_CRYPTO_SHA512_MB is not set
> CONFIG_CRYPTO_SHA256=y
> CONFIG_CRYPTO_SHA512=y
> CONFIG_CRYPTO_SHA3=y
> CONFIG_CRYPTO_SM3=y
> CONFIG_CRYPTO_TGR192=y
> # CONFIG_CRYPTO_WP512 is not set
> CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=y
> 
> #
> # Ciphers
> #
> CONFIG_CRYPTO_AES=y
> CONFIG_CRYPTO_AES_TI=y
> CONFIG_CRYPTO_AES_X86_64=y
> CONFIG_CRYPTO_AES_NI_INTEL=y
> CONFIG_CRYPTO_ANUBIS=y
> CONFIG_CRYPTO_ARC4=y
> CONFIG_CRYPTO_BLOWFISH=y
> CONFIG_CRYPTO_BLOWFISH_COMMON=y
> CONFIG_CRYPTO_BLOWFISH_X86_64=y
> CONFIG_CRYPTO_CAMELLIA=y
> CONFIG_CRYPTO_CAMELLIA_X86_64=y
> CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=y
> CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=y
> CONFIG_CRYPTO_CAST_COMMON=y
> CONFIG_CRYPTO_CAST5=y
> CONFIG_CRYPTO_CAST5_AVX_X86_64=y
> CONFIG_CRYPTO_CAST6=y
> # CONFIG_CRYPTO_CAST6_AVX_X86_64 is not set
> CONFIG_CRYPTO_DES=y
> # CONFIG_CRYPTO_DES3_EDE_X86_64 is not set
> # CONFIG_CRYPTO_FCRYPT is not set
> # CONFIG_CRYPTO_KHAZAD is not set
> # CONFIG_CRYPTO_SALSA20 is not set
> CONFIG_CRYPTO_CHACHA20=y
> CONFIG_CRYPTO_CHACHA20_X86_64=y
> CONFIG_CRYPTO_SEED=y
> CONFIG_CRYPTO_SERPENT=y
> # CONFIG_CRYPTO_SERPENT_SSE2_X86_64 is not set
> CONFIG_CRYPTO_SERPENT_AVX_X86_64=y
> CONFIG_CRYPTO_SERPENT_AVX2_X86_64=y
> CONFIG_CRYPTO_SM4=y
> CONFIG_CRYPTO_SPECK=y
> CONFIG_CRYPTO_TEA=y
> CONFIG_CRYPTO_TWOFISH=y
> CONFIG_CRYPTO_TWOFISH_COMMON=y
> CONFIG_CRYPTO_TWOFISH_X86_64=y
> CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=y
> CONFIG_CRYPTO_TWOFISH_AVX_X86_64=y
> 
> #
> # Compression
> #
> CONFIG_CRYPTO_DEFLATE=y
> CONFIG_CRYPTO_LZO=y
> CONFIG_CRYPTO_842=y
> CONFIG_CRYPTO_LZ4=y
> CONFIG_CRYPTO_LZ4HC=y
> # CONFIG_CRYPTO_ZSTD is not set
> 
> #
> # Random Number Generation
> #
> CONFIG_CRYPTO_ANSI_CPRNG=y
> CONFIG_CRYPTO_DRBG_MENU=y
> CONFIG_CRYPTO_DRBG_HMAC=y
> # CONFIG_CRYPTO_DRBG_HASH is not set
> # CONFIG_CRYPTO_DRBG_CTR is not set
> CONFIG_CRYPTO_DRBG=y
> CONFIG_CRYPTO_JITTERENTROPY=y
> CONFIG_CRYPTO_USER_API=y
> # CONFIG_CRYPTO_USER_API_HASH is not set
> # CONFIG_CRYPTO_USER_API_SKCIPHER is not set
> # CONFIG_CRYPTO_USER_API_RNG is not set
> CONFIG_CRYPTO_USER_API_AEAD=y
> CONFIG_CRYPTO_HASH_INFO=y
> # CONFIG_CRYPTO_HW is not set
> CONFIG_ASYMMETRIC_KEY_TYPE=y
> CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
> CONFIG_X509_CERTIFICATE_PARSER=y
> CONFIG_PKCS7_MESSAGE_PARSER=y
> CONFIG_PKCS7_TEST_KEY=y
> # CONFIG_SIGNED_PE_FILE_VERIFICATION is not set
> 
> #
> # Certificates for signature checking
> #
> CONFIG_SYSTEM_TRUSTED_KEYRING=y
> CONFIG_SYSTEM_TRUSTED_KEYS=""
> # CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
> CONFIG_SECONDARY_TRUSTED_KEYRING=y
> CONFIG_SYSTEM_BLACKLIST_KEYRING=y
> CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
> CONFIG_HAVE_KVM=y
> CONFIG_VIRTUALIZATION=y
> CONFIG_VHOST_NET=y
> CONFIG_VHOST_VSOCK=y
> CONFIG_VHOST=y
> CONFIG_VHOST_CROSS_ENDIAN_LEGACY=y
> CONFIG_BINARY_PRINTF=y
> 
> #
> # Library routines
> #
> CONFIG_RAID6_PQ=y
> CONFIG_BITREVERSE=y
> CONFIG_RATIONAL=y
> CONFIG_GENERIC_STRNCPY_FROM_USER=y
> CONFIG_GENERIC_STRNLEN_USER=y
> CONFIG_GENERIC_NET_UTILS=y
> CONFIG_GENERIC_FIND_FIRST_BIT=y
> CONFIG_GENERIC_PCI_IOMAP=y
> CONFIG_GENERIC_IOMAP=y
> CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
> CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
> CONFIG_CRC_CCITT=y
> CONFIG_CRC16=y
> CONFIG_CRC_T10DIF=y
> CONFIG_CRC_ITU_T=y
> CONFIG_CRC32=y
> # CONFIG_CRC32_SELFTEST is not set
> # CONFIG_CRC32_SLICEBY8 is not set
> CONFIG_CRC32_SLICEBY4=y
> # CONFIG_CRC32_SARWATE is not set
> # CONFIG_CRC32_BIT is not set
> CONFIG_CRC4=y
> # CONFIG_CRC7 is not set
> CONFIG_LIBCRC32C=y
> CONFIG_CRC8=y
> CONFIG_RANDOM32_SELFTEST=y
> CONFIG_842_COMPRESS=y
> CONFIG_842_DECOMPRESS=y
> CONFIG_ZLIB_INFLATE=y
> CONFIG_ZLIB_DEFLATE=y
> CONFIG_LZO_COMPRESS=y
> CONFIG_LZO_DECOMPRESS=y
> CONFIG_LZ4_COMPRESS=y
> CONFIG_LZ4HC_COMPRESS=y
> CONFIG_LZ4_DECOMPRESS=y
> CONFIG_XZ_DEC=y
> CONFIG_XZ_DEC_X86=y
> CONFIG_XZ_DEC_POWERPC=y
> CONFIG_XZ_DEC_IA64=y
> CONFIG_XZ_DEC_ARM=y
> CONFIG_XZ_DEC_ARMTHUMB=y
> CONFIG_XZ_DEC_SPARC=y
> CONFIG_XZ_DEC_BCJ=y
> CONFIG_XZ_DEC_TEST=y
> CONFIG_DECOMPRESS_GZIP=y
> CONFIG_DECOMPRESS_BZIP2=y
> CONFIG_DECOMPRESS_LZMA=y
> CONFIG_DECOMPRESS_XZ=y
> CONFIG_DECOMPRESS_LZO=y
> CONFIG_DECOMPRESS_LZ4=y
> CONFIG_GENERIC_ALLOCATOR=y
> CONFIG_REED_SOLOMON=y
> CONFIG_REED_SOLOMON_DEC16=y
> CONFIG_BCH=y
> CONFIG_BTREE=y
> CONFIG_INTERVAL_TREE=y
> CONFIG_RADIX_TREE_MULTIORDER=y
> CONFIG_ASSOCIATIVE_ARRAY=y
> CONFIG_HAS_IOMEM=y
> CONFIG_HAS_IOPORT_MAP=y
> CONFIG_HAS_DMA=y
> CONFIG_NEED_SG_DMA_LENGTH=y
> CONFIG_NEED_DMA_MAP_STATE=y
> CONFIG_ARCH_DMA_ADDR_T_64BIT=y
> CONFIG_DMA_DIRECT_OPS=y
> CONFIG_SWIOTLB=y
> CONFIG_SGL_ALLOC=y
> CONFIG_IOMMU_HELPER=y
> CONFIG_CHECK_SIGNATURE=y
> CONFIG_CPUMASK_OFFSTACK=y
> CONFIG_CPU_RMAP=y
> CONFIG_DQL=y
> CONFIG_GLOB=y
> CONFIG_GLOB_SELFTEST=y
> CONFIG_NLATTR=y
> CONFIG_CLZ_TAB=y
> CONFIG_CORDIC=y
> # CONFIG_DDR is not set
> CONFIG_IRQ_POLL=y
> CONFIG_MPILIB=y
> CONFIG_OID_REGISTRY=y
> CONFIG_UCS2_STRING=y
> CONFIG_FONT_SUPPORT=y
> CONFIG_FONT_8x16=y
> CONFIG_FONT_AUTOSELECT=y
> CONFIG_SG_POOL=y
> CONFIG_ARCH_HAS_SG_CHAIN=y
> CONFIG_ARCH_HAS_PMEM_API=y
> CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
> CONFIG_ARCH_HAS_UACCESS_MCSAFE=y
> CONFIG_STACKDEPOT=y
> CONFIG_SBITMAP=y
> CONFIG_STRING_SELFTEST=y

> #!/bin/sh
> 
> export_top_env()
> {
> 	export suite='boot'
> 	export testcase='boot'
> 	export timeout='10m'
> 	export job_origin='/lkp/lkp/src/jobs/boot.yaml'
> 	export queue='bisect'
> 	export testbox='vm-ivb41-quantal-x86_64-12'
> 	export tbox_group='vm-ivb41-quantal-x86_64'
> 	export branch='linux-devel/devel-spot-201807210929'
> 	export commit='baf24235a013d547c2a8be2de9c1cf37a290d56e'
> 	export kconfig='x86_64-randconfig-s1-07211158'
> 	export submit_id='5b55b24a0b9a93b049192a92'
> 	export job_file='/lkp/scheduled/vm-ivb41-quantal-x86_64-12/boot-1-quantal-core-x86_64.cgz-baf24235a013d547c2a8be2de9c1cf37a290d56e-20180723-45129-1pg13h6-0.yaml'
> 	export id='e513da5cdfe65b60eaf3f408d6cfda2f79d65c68'
> 	export model='qemu-system-x86_64 -enable-kvm'
> 	export nr_vm=32
> 	export nr_cpu=2
> 	export memory='512M'
> 	export rootfs='quantal-core-x86_64.cgz'
> 	export need_kconfig='CONFIG_KVM_GUEST=y'
> 	export compiler='gcc-6'
> 	export enqueue_time='2018-07-23 18:47:38 +0800'
> 	export _id='5b55b24a0b9a93b049192a92'
> 	export _rt='/result/boot/1/vm-ivb41-quantal-x86_64/quantal-core-x86_64.cgz/x86_64-randconfig-s1-07211158/gcc-6/baf24235a013d547c2a8be2de9c1cf37a290d56e'
> 	export user='lkp'
> 	export result_root='/result/boot/1/vm-ivb41-quantal-x86_64/quantal-core-x86_64.cgz/x86_64-randconfig-s1-07211158/gcc-6/baf24235a013d547c2a8be2de9c1cf37a290d56e/0'
> 	export LKP_SERVER='inn'
> 	export max_uptime=600
> 	export initrd='/osimage/quantal/quantal-core-x86_64.cgz'
> 	export bootloader_append='root=/dev/ram0
> user=lkp
> job=/lkp/scheduled/vm-ivb41-quantal-x86_64-12/boot-1-quantal-core-x86_64.cgz-baf24235a013d547c2a8be2de9c1cf37a290d56e-20180723-45129-1pg13h6-0.yaml
> ARCH=x86_64
> kconfig=x86_64-randconfig-s1-07211158
> branch=linux-devel/devel-spot-201807210929
> commit=baf24235a013d547c2a8be2de9c1cf37a290d56e
> BOOT_IMAGE=/pkg/linux/x86_64-randconfig-s1-07211158/gcc-6/baf24235a013d547c2a8be2de9c1cf37a290d56e/vmlinuz-4.18.0-rc5-00186-gbaf2423
> max_uptime=600
> RESULT_ROOT=/result/boot/1/vm-ivb41-quantal-x86_64/quantal-core-x86_64.cgz/x86_64-randconfig-s1-07211158/gcc-6/baf24235a013d547c2a8be2de9c1cf37a290d56e/0
> LKP_SERVER=inn
> debug
> apic=debug
> sysrq_always_enabled
> rcupdate.rcu_cpu_stall_timeout=100
> net.ifnames=0
> printk.devkmsg=on
> panic=-1
> softlockup_panic=1
> nmi_watchdog=panic
> oops=panic
> load_ramdisk=2
> prompt_ramdisk=0
> drbd.minor_count=8
> systemd.log_level=err
> ignore_loglevel
> console=tty0
> earlyprintk=ttyS0,115200
> console=ttyS0,115200
> vga=normal
> rw'
> 	export lkp_initrd='/lkp/lkp/lkp-x86_64.cgz'
> 	export site='inn'
> 	export LKP_CGI_PORT=80
> 	export LKP_CIFS_PORT=139
> 	export kernel='/pkg/linux/x86_64-randconfig-s1-07211158/gcc-6/baf24235a013d547c2a8be2de9c1cf37a290d56e/vmlinuz-4.18.0-rc5-00186-gbaf2423'
> 	export dequeue_time='2018-07-23 19:17:46 +0800'
> 	export job_initrd='/lkp/scheduled/vm-ivb41-quantal-x86_64-12/boot-1-quantal-core-x86_64.cgz-baf24235a013d547c2a8be2de9c1cf37a290d56e-20180723-45129-1pg13h6-0.cgz'
> 
> 	[ -n "$LKP_SRC" ] ||
> 	export LKP_SRC=/lkp/${user:-lkp}/src
> }
> 
> run_job()
> {
> 	echo $$ > $TMP/run-job.pid
> 
> 	. $LKP_SRC/lib/http.sh
> 	. $LKP_SRC/lib/job.sh
> 	. $LKP_SRC/lib/env.sh
> 
> 	export_top_env
> 
> 	run_monitor $LKP_SRC/monitors/one-shot/wrapper boot-slabinfo
> 	run_monitor $LKP_SRC/monitors/one-shot/wrapper boot-meminfo
> 	run_monitor $LKP_SRC/monitors/one-shot/wrapper memmap
> 	run_monitor $LKP_SRC/monitors/no-stdout/wrapper boot-time
> 	run_monitor $LKP_SRC/monitors/wrapper kmsg
> 	run_monitor $LKP_SRC/monitors/wrapper oom-killer
> 	run_monitor $LKP_SRC/monitors/plain/watchdog
> 
> 	run_test $LKP_SRC/tests/wrapper sleep 1
> }
> 
> extract_stats()
> {
> 	$LKP_SRC/stats/wrapper boot-slabinfo
> 	$LKP_SRC/stats/wrapper boot-meminfo
> 	$LKP_SRC/stats/wrapper memmap
> 	$LKP_SRC/stats/wrapper boot-memory
> 	$LKP_SRC/stats/wrapper boot-time
> 	$LKP_SRC/stats/wrapper kernel-size
> 	$LKP_SRC/stats/wrapper kmsg
> 
> 	$LKP_SRC/stats/wrapper time sleep.time
> 	$LKP_SRC/stats/wrapper time
> 	$LKP_SRC/stats/wrapper dmesg
> 	$LKP_SRC/stats/wrapper kmsg
> 	$LKP_SRC/stats/wrapper stderr
> 	$LKP_SRC/stats/wrapper last_state
> }
> 
> "$@"


