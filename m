Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6331BC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 12:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 112EE20989
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 12:07:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B5O6b80I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 112EE20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731161AbeK0XFe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 18:05:34 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:52387 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729261AbeK0XFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 18:05:33 -0500
Received: by mail-it1-f196.google.com with SMTP id i7so33810663iti.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 04:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vZMJ2YpXteFXyRWm0Bym8iUqvVbPnazSrvkxlKUt9GA=;
        b=B5O6b80IiD/2MJFfMGmjnNhs0U7H/NIjdQdQcijLWZHlpqfx+HQZCMe98nKs67wEe0
         rz/uB7I+cMUYW1L4SzNMHwkAzAEavEHyHrRl1dVExdXB+eNVvn1qjHXCcIN1wz1TFTM9
         r/zOD2KmCj/tgMVaRJrb8j8iGSlowhtUFa2ZtcLTHA5Mfbnl9JrZGOjFxjjgmBm+2nxc
         zFw3U6K920I/vZ0q67dusesIQcltQCIHLmOJ3tWtnhDoUsClbVPZQq/+gS2ZUEX2lVFk
         +Nz6BliDx4xSXvRkpOM0blsAHbVrTGG3dNXC9t/IOFdtUqd0kRZrvviNdQyFobF3DQjy
         fNqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vZMJ2YpXteFXyRWm0Bym8iUqvVbPnazSrvkxlKUt9GA=;
        b=qkVqMn2k3pgJ2p4cyZSddJeECTj2BCY1eiCFK2/nimdvYRmLiDp9uqUdy6CpayDOs5
         yE/eqaIMRw/1Tsp9i+bi+lhGYRPWC0lsZv2ZoNr4EsoL7MfQ+4Ipr1e8HewDDvWAhKYw
         PJJha8ANn5PskS1GUx7sSak87xnHDtUhqpeRbOqKbxE2cmRyzLHib8EMLq+FNBZfm4T2
         H/3WzLAod4lZeNdRDk1PQjG6JDwUwTTercvRf+5mEC3amfIBN2vvtBO9xEYU8zGKx39S
         GbRQd8Qo365x4rTDJVNj4fnAZ8z0DyyCvhGvhJciPA6v78JXon9/6/RcqJCduGiNLo6C
         hv6g==
X-Gm-Message-State: AA+aEWYpOmyaS1REUAVlgg5QpvqGDhLCRWs19wmcTG96NVa85USsFcBI
        VhYAAyZ6tbT+wwtqvHywvIk03qM3aOx/FDGzVk/G1w==
X-Google-Smtp-Source: AJdET5cXKhOxGKoyV3fiXoudmr5Zt8I0aHNU9cvRuQDAFhsPm2gl+1tU2RXxqf253t66Ppx77juKY3/4i/safudsjkQ=
X-Received: by 2002:a02:b19b:: with SMTP id t27mr26308223jah.72.1543320470785;
 Tue, 27 Nov 2018 04:07:50 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a02:b003:0:0:0:0:0 with HTTP; Tue, 27 Nov 2018 04:07:30
 -0800 (PST)
In-Reply-To: <CANRm+CykdB1-g0j0y+2AngDBkdeX=L4c6KxF_Yup4EN0QTJpEA@mail.gmail.com>
References: <000000000000ce78d7057b9e2ee1@google.com> <CANRm+CykdB1-g0j0y+2AngDBkdeX=L4c6KxF_Yup4EN0QTJpEA@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 27 Nov 2018 13:07:30 +0100
Message-ID: <CACT4Y+ZicTdyJpmy6DKw2wu5uWtS4epWNVUT0Hox1JSpuu69dA@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in kvm_write_guest_offset_cached
To:     Wanpeng Li <kernellwp@gmail.com>
Cc:     syzbot+ff40b9bc4835ea83211c@syzkaller.appspotmail.com,
        kvm <kvm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 7:14 AM, Wanpeng Li <kernellwp@gmail.com> wrote:
>
> On Tue, 27 Nov 2018 at 12:51, syzbot
> <syzbot+ff40b9bc4835ea83211c@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
>
> Is there beauty C codes?

syzbot does not have code like:

if (rand() % 2)
  send_C_repro();

:)

> > syzbot found the following crash on:
> >
> > HEAD commit:    442b8cea2477 Add linux-next specific files for 20181109
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=174d326d400000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=2f72bdb11df9fbe8
> > dashboard link: https://syzkaller.appspot.com/bug?extid=ff40b9bc4835ea83211c
> > compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14f5df7b400000
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+ff40b9bc4835ea83211c@syzkaller.appspotmail.com
> >
> > ==================================================================
> > BUG: KASAN: use-after-free in mark_page_dirty_in_slot
> > arch/x86/kvm/../../../virt/kvm/kvm_main.c:2056 [inline]
> > BUG: KASAN: use-after-free in kvm_write_guest_offset_cached+0x693/0x6b0
> > arch/x86/kvm/../../../virt/kvm/kvm_main.c:1988
> > Read of size 8 at addr ffff8801b9363778 by task syz-executor1/30438
> >
> > CPU: 1 PID: 30438 Comm: syz-executor1 Not tainted 4.20.0-rc1-next-20181109+
> > #110
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> > Google 01/01/2011
> > Call Trace:
> >   __dump_stack lib/dump_stack.c:77 [inline]
> >   dump_stack+0x244/0x39d lib/dump_stack.c:113
> >   print_address_description.cold.7+0x9/0x1ff mm/kasan/report.c:256
> >   kasan_report_error mm/kasan/report.c:354 [inline]
> >   kasan_report.cold.8+0x242/0x309 mm/kasan/report.c:412
> >   __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
> >   mark_page_dirty_in_slot arch/x86/kvm/../../../virt/kvm/kvm_main.c:2056
> > [inline]
> >   kvm_write_guest_offset_cached+0x693/0x6b0
> > arch/x86/kvm/../../../virt/kvm/kvm_main.c:1988
> >   kvm_steal_time_set_preempted arch/x86/kvm/x86.c:3241 [inline]
> >   kvm_arch_vcpu_put+0x365/0x420 arch/x86/kvm/x86.c:3268
> >   kvm_sched_out+0x91/0xb0 arch/x86/kvm/../../../virt/kvm/kvm_main.c:3993
> >   __fire_sched_out_preempt_notifiers kernel/sched/core.c:2503 [inline]
> >   fire_sched_out_preempt_notifiers kernel/sched/core.c:2511 [inline]
> >   prepare_task_switch kernel/sched/core.c:2617 [inline]
> >   context_switch kernel/sched/core.c:2796 [inline]
> >   __schedule+0x11ca/0x21d0 kernel/sched/core.c:3472
> >   preempt_schedule_irq+0xb9/0x140 kernel/sched/core.c:3699
> >   retint_kernel+0x1b/0x2d
> > RIP: 0010:search_memslots include/linux/kvm_host.h:955 [inline]
> > RIP: 0010:__gfn_to_memslot include/linux/kvm_host.h:976 [inline]
> > RIP: 0010:__kvm_gfn_to_hva_cache_init+0x2ed/0xd10
> > arch/x86/kvm/../../../virt/kvm/kvm_main.c:1935
> > Code: 3c 02 00 0f 85 0d 0a 00 00 4d 03 6c 24 08 48 89 df 4c 89 ee e8 04 16
> > 78 00 4c 39 eb 0f 82 6e 01 00 00 45 31 ed e8 43 15 78 00 <44> 89 fe 44 89
> > ef e8 c8 15 78 00 45 39 fd 0f 8d cf 00 00 00 e8 2a
> > RSP: 0018:ffff8801cbfee970 EFLAGS: 00000293 ORIG_RAX: ffffffffffffff13
> > RAX: ffff8801b9a4c280 RBX: 0000000000000000 RCX: ffffffff8107942f
> > RDX: 0000000000000000 RSI: ffffffff8107936d RDI: 0000000000000006
> > RBP: ffff8801cbfeeb60 R08: ffff8801b9a4c280 R09: ffffed00342bb209
> > R10: ffffed00342bb209 R11: ffff8801a15d904b R12: 0000000000000017
> > R13: 0000000000000017 R14: 0000000000000016 R15: 0000000000000017
> >   kvm_gfn_to_hva_cache_init+0x15a/0x340
> > arch/x86/kvm/../../../virt/kvm/kvm_main.c:1963
> >   kvm_set_msr_common+0x1a0c/0x2670 arch/x86/kvm/x86.c:2549
> >   vmx_set_msr+0x759/0x1f90 arch/x86/kvm/vmx.c:4360
> >   kvm_set_msr+0x18a/0x370 arch/x86/kvm/x86.c:1324
> >   do_set_msr+0x10d/0x1a0 arch/x86/kvm/x86.c:1353
> >   __msr_io arch/x86/kvm/x86.c:2905 [inline]
> >   msr_io+0x222/0x380 arch/x86/kvm/x86.c:2941
> >   kvm_arch_vcpu_ioctl+0x961/0x3b00 arch/x86/kvm/x86.c:3956
> >   kvm_vcpu_ioctl+0x278/0x1150 arch/x86/kvm/../../../virt/kvm/kvm_main.c:2748
> >   vfs_ioctl fs/ioctl.c:46 [inline]
> >   file_ioctl fs/ioctl.c:509 [inline]
> >   do_vfs_ioctl+0x1de/0x1790 fs/ioctl.c:696
> >   ksys_ioctl+0xa9/0xd0 fs/ioctl.c:713
> >   __do_sys_ioctl fs/ioctl.c:720 [inline]
> >   __se_sys_ioctl fs/ioctl.c:718 [inline]
> >   __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
> >   do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
> >   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > RIP: 0033:0x457569
> > Code: fd b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7
> > 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff
> > ff 0f 83 cb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> > RSP: 002b:00007fc292e62c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> > RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457569
> > RDX: 0000000020000280 RSI: 000000004008ae89 RDI: 0000000000000005
> > RBP: 000000000072c040 R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000246 R12: 00007fc292e636d4
> > R13: 00000000004bff9d R14: 00000000004d0970 R15: 00000000ffffffff
> >
> > Allocated by task 30427:
> >   save_stack+0x43/0xd0 mm/kasan/kasan.c:448
> >   set_track mm/kasan/kasan.c:460 [inline]
> >   kasan_kmalloc+0xc7/0xe0 mm/kasan/kasan.c:553
> >   __do_kmalloc_node mm/slab.c:3684 [inline]
> >   __kmalloc_node+0x50/0x70 mm/slab.c:3691
> >   kmalloc_node include/linux/slab.h:589 [inline]
> >   kvmalloc_node+0xb9/0xf0 mm/util.c:416
> >   kvmalloc include/linux/mm.h:577 [inline]
> >   kvzalloc include/linux/mm.h:585 [inline]
> >   __kvm_set_memory_region+0x116e/0x2d50
> > arch/x86/kvm/../../../virt/kvm/kvm_main.c:1023
> >   kvm_set_memory_region+0x2e/0x50
> > arch/x86/kvm/../../../virt/kvm/kvm_main.c:1085
> >   kvm_vm_ioctl_set_memory_region
> > arch/x86/kvm/../../../virt/kvm/kvm_main.c:1097 [inline]
> >   kvm_vm_ioctl+0x652/0x1d60 arch/x86/kvm/../../../virt/kvm/kvm_main.c:2995
> >   vfs_ioctl fs/ioctl.c:46 [inline]
> >   file_ioctl fs/ioctl.c:509 [inline]
> >   do_vfs_ioctl+0x1de/0x1790 fs/ioctl.c:696
> >   ksys_ioctl+0xa9/0xd0 fs/ioctl.c:713
> >   __do_sys_ioctl fs/ioctl.c:720 [inline]
> >   __se_sys_ioctl fs/ioctl.c:718 [inline]
> >   __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
> >   do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
> >   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> >
> > Freed by task 30427:
> >   save_stack+0x43/0xd0 mm/kasan/kasan.c:448
> >   set_track mm/kasan/kasan.c:460 [inline]
> >   __kasan_slab_free+0x102/0x150 mm/kasan/kasan.c:521
> >   kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
> >   __cache_free mm/slab.c:3498 [inline]
> >   kfree+0xcf/0x230 mm/slab.c:3817
> >   kvfree+0x61/0x70 mm/util.c:445
> >   __kvm_set_memory_region+0x1cb3/0x2d50
> > arch/x86/kvm/../../../virt/kvm/kvm_main.c:1067
> >   kvm_set_memory_region+0x2e/0x50
> > arch/x86/kvm/../../../virt/kvm/kvm_main.c:1085
> >   kvm_vm_ioctl_set_memory_region
> > arch/x86/kvm/../../../virt/kvm/kvm_main.c:1097 [inline]
> >   kvm_vm_ioctl+0x652/0x1d60 arch/x86/kvm/../../../virt/kvm/kvm_main.c:2995
> >   vfs_ioctl fs/ioctl.c:46 [inline]
> >   file_ioctl fs/ioctl.c:509 [inline]
> >   do_vfs_ioctl+0x1de/0x1790 fs/ioctl.c:696
> >   ksys_ioctl+0xa9/0xd0 fs/ioctl.c:713
> >   __do_sys_ioctl fs/ioctl.c:720 [inline]
> >   __se_sys_ioctl fs/ioctl.c:718 [inline]
> >   __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
> >   do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
> >   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> >
> > The buggy address belongs to the object at ffff8801b9363080
> >   which belongs to the cache kmalloc-64k of size 65536
> > The buggy address is located 1784 bytes inside of
> >   65536-byte region [ffff8801b9363080, ffff8801b9373080)
> > The buggy address belongs to the page:
> > page:ffffea0006e4d800 count:1 mapcount:0 mapping:ffff8801da802500 index:0x0
> > compound_mapcount: 0
> > flags: 0x2fffc0000010200(slab|head)
> > raw: 02fffc0000010200 ffffea0006906808 ffffea0007034808 ffff8801da802500
> > raw: 0000000000000000 ffff8801b9363080 0000000100000001 0000000000000000
> > page dumped because: kasan: bad access detected
> >
> > Memory state around the buggy address:
> >   ffff8801b9363600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >   ffff8801b9363680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > > ffff8801b9363700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >                                                                  ^
> >   ffff8801b9363780: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >   ffff8801b9363800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > ==================================================================
> >
> >
> > ---
> > This bug is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > syzbot will keep track of this bug report. See:
> > https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with
> > syzbot.
> > syzbot can test patches for this bug, for details see:
> > https://goo.gl/tpsmEJ#testing-patches
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/CANRm%2BCykdB1-g0j0y%2B2AngDBkdeX%3DL4c6KxF_Yup4EN0QTJpEA%40mail.gmail.com.
> For more options, visit https://groups.google.com/d/optout.
