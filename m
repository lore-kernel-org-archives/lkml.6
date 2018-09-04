Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B865C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 19:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 218872073D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 19:32:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 218872073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbeIDX7W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 19:59:22 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60674 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbeIDX7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 19:59:22 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 485B9C96;
        Tue,  4 Sep 2018 19:32:49 +0000 (UTC)
Date:   Tue, 4 Sep 2018 21:32:46 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>
Subject: Re: [PATCH 4.14 000/165] 4.14.68-stable review
Message-ID: <20180904193246.GB17846@kroah.com>
References: <20180903165655.003605184@linuxfoundation.org>
 <CA+G9fYtAu2Hs5vpT0+P03LRfa_cvwresMT48HgH0HsHQEaEujQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYtAu2Hs5vpT0+P03LRfa_cvwresMT48HgH0HsHQEaEujQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 04, 2018 at 09:49:43AM +0530, Naresh Kamboju wrote:
> On 3 September 2018 at 22:24, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > This is the start of the stable review cycle for the 4.14.68 release.
> > There are 165 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Wed Sep  5 16:56:19 UTC 2018.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.68-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
> 
> Running kselftest
> selftests: bpf: test_tunnel.sh reported kernel crash on i386 device
> running 4.14.68-rc1
> and similar issue reported on 4.18.6-rc1.
> 
> [   92.244007] low stack detected by irq handler
> [   92.244145] BUG: unable to handle kernel paging request at c4fb1f64
> [   92.244161] IP: __call_rcu.constprop.76+0x27/0x4b0
> [   92.244164] *pde = 35c05063 *pte = 04fb1161
> [   92.244172] Oops: 0003 [#1] SMP
> [   92.244176] Modules linked in: veth x86_pkg_temp_thermal fuse
> [   92.244187] CPU: 2 PID: 19 Comm: ksoftirqd/2 Not tainted 4.14.68-rc1 #1
> [   92.244190] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
> 2.0b 07/27/2017
> [   92.244192] task: f5db8000 task.stack: f5db4000
> [   92.244198] EIP: __call_rcu.constprop.76+0x27/0x4b0
> [   92.244201] EFLAGS: 00210246 CPU: 2
> [   92.244204] EAX: 00000000 EBX: c4fb17a0 ECX: c5c2d640 EDX: c4fb17a0
> [   92.244206] ESI: c4fb1f60 EDI: c4fb1f60 EBP: f5db5ee4 ESP: f5db5eb0
> [   92.244209]  DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068
> [   92.244212] CR0: 80050033 CR2: c4fb1f64 CR3: 05dff000 CR4: 003406d0
> [   92.244215] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
> [   92.244216] DR6: fffe0ff0 DR7: 00000400
> [   92.244218] Call Trace:
> [   92.244228]  ? rcu_process_callbacks+0x200/0xdd0
> [   92.244234]  ? __lock_is_held+0x48/0x80
> [   92.244242]  ? tlb_table_flush.part.118+0x10/0x30
> [   92.244248]  call_rcu_sched+0x14/0x20
> [   92.244252]  tlb_table_flush.part.118+0x1d/0x30
> [   92.244257]  ? rcu_process_callbacks+0x254/0xdd0
> [   92.244264]  ? finish_task_switch+0x87/0x1d0
> [   92.244276]  __do_softirq+0xac/0x426
> [   92.244288]  run_ksoftirqd+0x1f/0x60
> [   92.244295]  smpboot_thread_fn+0x120/0x1d0
> [   92.244300]  kthread+0xfa/0x110
> [   92.244305]  ? sort_range+0x20/0x20
> [   92.244310]  ? kthread_create_on_node+0x20/0x20
> [   92.244316]  ret_from_fork+0x2e/0x38
> [   92.244325] Code: 00 00 00 00 3e 8d 74 26 00 55 89 e5 57 56 53 89
> c6 89 d3 83 ec 28 8b 45 08 f7 c6 03 00 00 00 89 4d ec 89 45 e4 0f 85
> 39 03 00 00 <89> 5e 04 c7 06 00 00 00 00 9c 8f 45 f0 fa e8 66 69 fd ff
> 8b 55
> [   92.244413] EIP: __call_rcu.constprop.76+0x27/0x4b0 SS:ESP: 0068:f5db5eb0
> [   92.244415] CR2: 00000000c4fb1f64
> [   92.244425] ---[ end trace df3b7c276e7f3926 ]---
> [   92.244427] Kernel panic - not syncing: Fatal exception in interrupt
> [   92.432150] CPU: 0 PID: 2388 Comm: named Tainted: G      D
> 4.14.68-rc1 #1
> [   92.439620] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
> 2.0b 07/27/2017
> [   92.447090] Call Trace:
> [   92.449535]  <IRQ>
> [   92.451547]  dump_stack+0x66/0x92
> [   92.454865]  print_stack_overflow+0x17/0x30
> [   92.459052]  call_on_stack+0x45/0x50
> [   92.462628]  </IRQ>
> [   92.464730] Kernel Offset: 0x3e00000 from 0xc1000000 (relocation
> range: 0xc0000000-0xf7bfdfff)
> [   92.473333] ---[ end Kernel panic - not syncing: Fatal exception in interrupt
> [   92.480458] sched: Unexpected reschedule of offline CPU#3!
> [   92.485943] ------------[ cut here ]------------
> [   92.490563] WARNING: CPU: 2 PID: 19 at
> /srv/oe/build/tmp-rpb-glibc/work-shared/intel-core2-32/kernel-source/arch/x86/kernel/smp.c:128
> native_smp_send_reschedule+0x33/0x40
> [   92.505752] Modules linked in: veth x86_pkg_temp_thermal fuse
> [   92.511490] CPU: 2 PID: 19 Comm: ksoftirqd/2 Tainted: G      D
>    4.14.68-rc1 #1
> [   92.519305] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
> 2.0b 07/27/2017
> [   92.526779] task: f5db8000 task.stack: f5db4000
> [   92.531303] EIP: native_smp_send_reschedule+0x33/0x40
> [   92.536355] EFLAGS: 00210086 CPU: 2
> [   92.539837] EAX: 0000002e EBX: 00000003 ECX: f61d9900 EDX: f61d2d34
> [   92.546095] ESI: f5d85500 EDI: f5d85500 EBP: f5db5b44 ESP: f5db5b3c
> [   92.552352]  DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068
> [   92.557744] CR0: 80050033 CR2: c4fb1f64 CR3: 05dff000 CR4: 003406d0
> [   92.563998] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
> [   92.570256] DR6: fffe0ff0 DR7: 00000400
> [   92.574087] Call Trace:
> [   92.576534]  resched_curr+0x59/0x180
> [   92.580112]  check_preempt_curr+0x8d/0xb0
> [   92.584115]  ttwu_do_wakeup+0x17/0x240
> [   92.587857]  ? activate_task+0x52/0xc0
> [   92.591602]  ttwu_do_activate+0x6c/0x90
> [   92.595433]  try_to_wake_up+0x2ed/0x570
> [   92.599265]  default_wake_function+0x10/0x20
> [   92.603536]  autoremove_wake_function+0x14/0x40
> [   92.608059]  __wake_up_common+0x68/0x110
> [   92.611978]  __wake_up_common_lock+0x57/0x80
> [   92.616243]  __wake_up+0x12/0x20
> [   92.619476]  wake_up_klogd_work_func+0x3c/0x60
> [   92.623920]  irq_work_run_list+0x38/0x60
> [   92.627836]  irq_work_tick+0x31/0x40
> [   92.631408]  update_process_times+0x3a/0x50
> [   92.635586]  tick_sched_handle+0x40/0x60
> [   92.639511]  tick_sched_timer+0x38/0x90
> [   92.643342]  __hrtimer_run_queues+0xe0/0x490
> [   92.647606]  ? tick_sched_do_timer+0x60/0x60
> [   92.651878]  hrtimer_interrupt+0x8f/0x190
> [   92.655884]  smp_apic_timer_interrupt+0x68/0x290
> [   92.660501]  apic_timer_interrupt+0x3a/0x40
> [   92.664678] EIP: panic+0x186/0x1cc
> [   92.668073] EFLAGS: 00200246 CPU: 2
> [   92.671558] EAX: c5ad3108 EBX: 00000000 ECX: f61d2d30 EDX: 00000000
> [   92.677815] ESI: 00000000 EDI: 00000000 EBP: f5db5d8c ESP: f5db5d78
> [   92.684072]  DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068
> [   92.689465]  ? freeze_processes+0x3b/0xe0
> [   92.693477]  oops_end+0xa3/0xb0
> [   92.696614]  no_context+0xd9/0x200
> [   92.700010]  ? tlb_table_flush.part.118+0x14/0x30
> [   92.704706]  ? find_busiest_group+0x29/0x520
> [   92.708971]  ? tlb_table_flush.part.118+0x14/0x30
> [   92.713668]  __bad_area_nosemaphore+0xa4/0x130
> [   92.718107]  bad_area_nosemaphore+0x12/0x20
> [   92.722284]  __do_page_fault+0xb5/0x4b0
> [   92.726116]  ? __lock_acquire+0x1fe/0x1130
> [   92.730213]  ? tlb_table_flush.part.118+0x14/0x30
> [   92.734910]  ? tlb_table_flush.part.118+0x14/0x30
> [   92.739607]  do_page_fault+0x20/0x240
> [   92.743265]  ? tlb_flush_mmu_free+0x50/0x50
> [   92.747442]  ? tlb_table_flush.part.118+0x10/0x30
> [   92.752138]  ? __do_page_fault+0x4b0/0x4b0
> [   92.756229]  common_exception+0x7c/0x82
> [   92.760061] EIP: __call_rcu.constprop.76+0x27/0x4b0
> [   92.764930] EFLAGS: 00210246 CPU: 2
> [   92.768415] EAX: 00000000 EBX: c4fb17a0 ECX: c5c2d640 EDX: c4fb17a0
> [   92.774671] ESI: c4fb1f60 EDI: c4fb1f60 EBP: f5db5ee4 ESP: f5db5eb0
> [   92.780928]  DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068
> [   92.786320]  ? tlb_flush_mmu_free+0x50/0x50
> [   92.790497]  ? tlb_flush_mmu_free+0x50/0x50
> [   92.794674]  ? tlb_table_flush.part.118+0x10/0x30
> [   92.799371]  ? tlb_table_flush.part.118+0x10/0x30
> [   92.804069]  ? __init_swait_queue_head+0x3b/0x40
> [   92.808686]  ? __do_page_fault+0x4b0/0x4b0
> [   92.812778]  ? rcu_process_callbacks+0x200/0xdd0
> [   92.817388]  ? __lock_is_held+0x48/0x80
> [   92.821219]  ? tlb_table_flush.part.118+0x10/0x30
> [   92.825916]  call_rcu_sched+0x14/0x20
> [   92.829574]  tlb_table_flush.part.118+0x1d/0x30
> [   92.834098]  ? rcu_process_callbacks+0x254/0xdd0
> [   92.838715]  ? finish_task_switch+0x87/0x1d0
> [   92.842981]  __do_softirq+0xac/0x426
> [   92.846551]  run_ksoftirqd+0x1f/0x60
> [   92.850122]  smpboot_thread_fn+0x120/0x1d0
> [   92.854213]  kthread+0xfa/0x110
> [   92.857359]  ? sort_range+0x20/0x20
> [   92.860840]  ? kthread_create_on_node+0x20/0x20
> [   92.865365]  ret_from_fork+0x2e/0x38
> [   92.868938] Code: 0f a3 05 dc da ce c5 73 17 8b 0d 20 d6 ba c5 ba
> fd 00 00 00 ff 51 58 c9 c3 8d b4 26 00 00 00 00 50 68 e0 cc ac c5 e8
> 0a fa 07 00 <0f> 0b 58 5a c9 c3 8d b4 26 00 00 00 00 3e 8d 74 26 00 8b
> 15 f0
> [   92.887724] ---[ end trace df3b7c276e7f3927 ]---
> 
> Details for test full run,
> 
> 4.14 run,
> https://lkft.validation.linaro.org/scheduler/job/404796
> 
> 4.18.6-rc1 run,
> https://lkft.validation.linaro.org/scheduler/job/404027#L3244

I have pushed out a -rc2 to hopefully fix this problem.

thanks,

greg k-h
