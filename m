Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 543ADC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 19:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D49F12087D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 19:42:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oz/kUuZu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D49F12087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbeJKDGT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 23:06:19 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:39337 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727348AbeJKDGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 23:06:18 -0400
Received: by mail-io1-f66.google.com with SMTP id z16-v6so4815465iol.6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 12:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=aR4A3P9E1esLql8CCFz0OBoLMZBuz7UmJjdbO49H3No=;
        b=oz/kUuZu+cnPND4LYX2IlEeZJkaOyz6KwQurZ1eG7gsAA+dAIsZx5P1fxuIjZSOOlL
         Cxry4Al78iZJg5g7w1t8VVfjHFzKTXjaMyrIHGpt71ik1VYHMdtiNVMQlXXGJfUdxySb
         nt7YhM73qdDU5cZBld8ax1p0QReRh4YbkQXpPhQaxNzqrp+IHZPUH+ChRtTXwVMJ5iJa
         sMLsk9tEfS1r67vqqswiTCkrzEeOczsllbcA2fTMgksVdDK2IKe2Ut7cRaeVIVjYTcm8
         wuJbXD5Cd/buF8bpa3K4dFC1solhNcZOFUJv8z9GqFX/X/tUCEn9E4OVz0uk7wAqgbgd
         xECw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=aR4A3P9E1esLql8CCFz0OBoLMZBuz7UmJjdbO49H3No=;
        b=LmsF6T/geFXk4Pa2Z6DEOoPm5wHa+U9kn14DesOypu+vYsXJPrk3UeDLBdoffOCOts
         TjXJOzdShFgGEio0tUXAmqVdn8cvN2YyMC8AB6vfglsG/+o1/el2s8muzI0K2Y70T/V1
         NZvV4RyFDChyk7kmd4eZAXGFH8OFPJ2AaLFzIp8rbCEf6XCyaF/cD7d/220odj4RxL6/
         gDaMJgYyQfXyKUlM0fPIJsWCK/unTLcBMOgITLDKDQA1xzyuXGX3KPqZ4JwBF3/59mx/
         NJ5OXzTZclwvbNXz5nWNYk5wrhLIORHGsmDmdmjoDqjgFDjZT8IqS2apY3WoDH5hqKga
         5JFQ==
X-Gm-Message-State: ABuFfohlnS+MpOu+4UbD3ojna043KubHT21SIQoD+bn3ktL0BhC3b+rH
        dFuUv1zngHZXHiBy/OJEFP4m1yL8t/dviNysxA+gsA==
X-Google-Smtp-Source: ACcGV624+Yc+4+8LUY3LRHNsMdOvpWfMOJO6K/dYnTAZRiL/s37fF9ZQ1vS9lbDFVZckwx3kp5Mt6PZj+mP22mTCiUE=
X-Received: by 2002:a6b:f10f:: with SMTP id e15-v6mr21385061iog.271.1539200559277;
 Wed, 10 Oct 2018 12:42:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:1003:0:0:0:0:0 with HTTP; Wed, 10 Oct 2018 12:42:18
 -0700 (PDT)
In-Reply-To: <62457d9f-0732-3886-0381-bbf5df738467@kernel.org>
References: <0000000000004643360575102706@google.com> <62457d9f-0732-3886-0381-bbf5df738467@kernel.org>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 10 Oct 2018 21:42:18 +0200
Message-ID: <CACT4Y+ZeN-acGM_Y+W_sWLcd-0NAjQ9qfBfGGrwE85AhB+ne0A@mail.gmail.com>
Subject: Re: KASAN: slab-out-of-bounds Read in vhci_hub_control
To:     Shuah Khan <shuah@kernel.org>
Cc:     syzbot <syzbot+bccc1fe10b70fadc78d0@syzkaller.appspotmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Valentina Manea <valentina.manea.m@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 2, 2018 at 6:04 PM, Shuah Khan <shuah@kernel.org> wrote:
> On 09/04/2018 12:52 PM, syzbot wrote:
>> Hello,
>>
>> syzbot found the following crash on:
>>
>> HEAD commit:    420f51f4ab6b Merge tag 'arm64-fixes' of git://git.kernel.o..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=126a6f0e400000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=531a917630d2a492
>> dashboard link: https://syzkaller.appspot.com/bug?extid=bccc1fe10b70fadc78d0
>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=121caa46400000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14ed8ab6400000
>
> C producer doesn't reproduce the problem on 4.19-rc5. Does this C producer
> depend on state of the machine? i.e what is the status of vhci_hcd - are
> there any devices attached?
>
> I can see the problem looking at the code and fix is easy. However, I would
> like be able to reproduce it and verify the fix works. Also this would be a
> good regression for the driver I could consider adding to selftests.



Are you sure you used the provided config/commit?
I've followed these instructions:
https://github.com/google/syzkaller/blob/master/docs/syzbot.md#crash-does-not-reproduce
and the C repro gave me this in a second:

[   57.259910] ==================================================================
[   57.262304] BUG: KASAN: slab-out-of-bounds in vhci_hub_control+0x169c/0x1a70
[   57.264508] Read of size 4 at addr ffff880064641fbc by task a.out/4253
[   57.266581]
[   57.267093] CPU: 3 PID: 4253 Comm: a.out Not tainted 4.19.0-rc5+ #13
[   57.269107] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.10.2-1 04/01/2014
[   57.271324] Call Trace:
[   57.271786]  dump_stack+0x1af/0x295
[   57.272449]  ? arch_local_irq_restore+0x53/0x53
[   57.273249]  ? kmsg_dump_rewind_nolock+0xe4/0xe4
[   57.274049]  ? trace_hardirqs_off_caller+0x270/0x270
[   57.274920]  print_address_description+0x73/0x250
[   57.275735]  kasan_report+0x256/0x380
[   57.276373]  ? vhci_hub_control+0x169c/0x1a70
[   57.277139]  __asan_report_load4_noabort+0x14/0x20
[   57.277982]  vhci_hub_control+0x169c/0x1a70
[   57.278731]  ? vhci_hcd_probe+0x330/0x330
[   57.279453]  ? rcu_read_lock_sched_held+0x108/0x120
[   57.280308]  ? __kmalloc+0x312/0x710
[   57.280945]  ? kasan_check_write+0x14/0x20
[   57.281669]  ? do_raw_spin_lock+0xc1/0x230
[   57.282425]  ? usb_hcd_submit_urb+0x689/0x1e70
[   57.283209]  usb_hcd_submit_urb+0x161f/0x1e70
[   57.283967]  ? vhci_hcd_probe+0x330/0x330
[   57.284672]  ? __asan_alloca_poison+0x14/0xa0
[   57.285437]  ? usb_create_hcd+0x40/0x40
[   57.286113]  ? __x64_sys_ioctl+0x73/0xb0
[   57.286810]  ? do_syscall_64+0x192/0x770
[   57.287502]  ? entry_SYSCALL_64_after_hwframe+0x49/0xbe
[   57.288413]  ? find_held_lock+0x35/0x1d0
[   57.289104]  ? __lockdep_init_map+0xe4/0x650
[   57.289856]  ? __lockdep_init_map+0xe4/0x650
[   57.290611]  ? lockdep_init_map+0x9/0x10
[   57.291303]  usb_submit_urb+0x829/0x11a0
[   57.292017]  ? rcu_pm_notify+0xc0/0xc0
[   57.292676]  usb_start_wait_urb+0x140/0x330
[   57.293422]  ? sg_clean+0x220/0x220
[   57.294046]  usb_control_msg+0x334/0x4c0
[   57.294779]  ? usb_start_wait_urb+0x330/0x330
[   57.295542]  proc_control+0x913/0xe50
[   57.296189]  ? proc_bulk+0x9d0/0x9d0
[   57.296822]  usbdev_do_ioctl+0x2260/0x3690
[   57.297576]  ? processcompl_compat+0x5e0/0x5e0
[   57.298366]  ? mark_held_locks+0x100/0x100
[   57.299086]  ? futex_wait_setup+0x410/0x410
[   57.299821]  ? kasan_check_write+0x14/0x20
[   57.300539]  ? wake_up_q+0x9d/0xf0
[   57.301139]  ? drop_futex_key_refs.isra.14+0x71/0xc0
[   57.302016]  ? futex_wake+0x2e5/0x6b0
[   57.302671]  ? lock_downgrade+0x9a0/0x9a0
[   57.303372]  ? check_noncircular+0x20/0x20
[   57.304115]  ? kasan_check_read+0x11/0x20
[   57.304816]  ? do_futex+0x874/0x22c0
[   57.305445]  ? find_held_lock+0x35/0x1d0
[   57.306130]  ? lock_acquire+0x1db/0x520
[   57.306834]  ? lock_downgrade+0x9a0/0x9a0
[   57.307535]  ? kasan_check_read+0x11/0x20
[   57.308231]  ? rcu_is_watching+0x8c/0x150
[   57.308930]  ? rcu_cleanup_dead_rnp+0x210/0x210
[   57.309724]  ? __fget+0x428/0x660
[   57.310310]  ? iterate_fd+0x400/0x400
[   57.310957]  ? kasan_check_write+0x14/0x20
[   57.311670]  ? do_raw_spin_lock+0xc1/0x230
[   57.312396]  ? trace_hardirqs_off+0x9c/0x280
[   57.313135]  ? usbdev_compat_ioctl+0x30/0x30
[   57.313871]  usbdev_ioctl+0x25/0x30
[   57.314488]  do_vfs_ioctl+0x1c2/0x15b0
[   57.315147]  ? rcu_is_watching+0x8c/0x150
[   57.315839]  ? trace_hardirqs_on+0xa1/0x280
[   57.316564]  ? ioctl_preallocate+0x2d0/0x2d0
[   57.317302]  ? __fget_light+0x2c4/0x410
[   57.317968]  ? fget_raw+0x20/0x20
[   57.318561]  ? putname+0xee/0x130
[   57.319140]  ? rcu_read_lock_sched_held+0x108/0x120
[   57.319987]  ? kmem_cache_free+0x21d/0x270
[   57.320702]  ? __x64_sys_futex+0x344/0x4b0
[   57.321411]  ? do_syscall_64+0x9a/0x770
[   57.322082]  ? do_syscall_64+0x9a/0x770
[   57.322780]  ? lockdep_hardirqs_on+0x421/0x5c0
[   57.323541]  ? security_file_ioctl+0x87/0xb0
[   57.324268]  ksys_ioctl+0x94/0xb0
[   57.324837]  __x64_sys_ioctl+0x73/0xb0
[   57.325478]  do_syscall_64+0x192/0x770
[   57.326117]  ? entry_SYSCALL_64_after_hwframe+0x3e/0xbe
[   57.327038]  ? syscall_return_slowpath+0x560/0x560
[   57.327880]  ? trace_hardirqs_off_thunk+0x1a/0x1c
[   57.328709]  ? trace_hardirqs_on+0x280/0x280
[   57.329462]  ? prepare_exit_to_usermode+0x360/0x360
[   57.330319]  ? recalc_sigpending_tsk+0x150/0x150
[   57.331148]  ? prepare_exit_to_usermode+0x22f/0x360
[   57.332006]  ? trace_hardirqs_off_thunk+0x1a/0x1c
[   57.332843]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[   57.333731] RIP: 0033:0x4417c9
[   57.334280] Code: e8 9c 5a 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00
00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24
08 0f 05 <48> 3d 01 f0 ff ff 0f 83 0b 9c fc ff c3 66 2e 0f 1f 84 00 00
00 00
[   57.337498] RSP: 002b:00007ff768d47d78 EFLAGS: 00000246 ORIG_RAX:
0000000000000010
[   57.338782] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00000000004417c9
[   57.339980] RDX: 0000000020000100 RSI: 00000000c0185500 RDI: 0000000000000003
[   57.341179] RBP: 00007ff768d47da0 R08: 0000000000000000 R09: 0000000000000000
[   57.342411] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
[   57.343607] R13: 00007ffdc26d041f R14: 00007ff768d48700 R15: 0000000000000000
[   57.344809]
[   57.345081] Allocated by task 4081:
[   57.345684]  save_stack+0x43/0xd0
[   57.346257]  kasan_kmalloc+0xad/0xe0
[   57.346877]  kasan_slab_alloc+0x12/0x20
[   57.347518]  kmem_cache_alloc+0x12e/0x700
[   57.348192]  getname_flags+0xcb/0x580
[   57.348810]  __x64_sys_unlinkat+0x9e/0x100
[   57.349502]  do_syscall_64+0x192/0x770
[   57.350139]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[   57.350985]
[   57.351252] Freed by task 4081:
[   57.351790]  save_stack+0x43/0xd0
[   57.352358]  __kasan_slab_free+0x11a/0x170
[   57.353050]  kasan_slab_free+0xe/0x10
[   57.353677]  kmem_cache_free+0x83/0x270
[   57.354325]  putname+0xee/0x130
[   57.354876]  filename_parentat+0x46d/0x570
[   57.355566]  do_unlinkat+0x160/0x970
[   57.356169]  __x64_sys_unlinkat+0xa8/0x100
[   57.356865]  do_syscall_64+0x192/0x770
[   57.357498]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[   57.358351]
[   57.358630] The buggy address belongs to the object at ffff880064640880
[   57.358630]  which belongs to the cache names_cache of size 4096
[   57.360718] The buggy address is located 1852 bytes to the right of
[   57.360718]  4096-byte region [ffff880064640880, ffff880064641880)
[   57.362785] The buggy address belongs to the page:
[   57.363599] page:ffffea0001919000 count:1 mapcount:0
mapping:ffff88006c56bd80 index:0x0 compound_mapcount: 0
[   57.365241] flags: 0x1fffc0000008100(slab|head)
[   57.366014] raw: 01fffc0000008100 ffffea0001764388 ffffea0001ac7b08
ffff88006c56bd80
[   57.367322] raw: 0000000000000000 ffff880064640880 0000000100000001
0000000000000000
[   57.368608] page dumped because: kasan: bad access detected
[   57.369518]
[   57.369796] Memory state around the buggy address:
[   57.370638]  ffff880064641e80: fc fc fc fc fc fc fc fc fc fc fc fc
fc fc fc fc
[   57.371838]  ffff880064641f00: fc fc fc fc fc fc fc fc fc fc fc fc
fc fc fc fc
[   57.373132] >ffff880064641f80: fc fc fc fc fc fc fc fc fc fc fc fc
fc fc fc fc
[   57.374320]                                         ^
[   57.375179]  ffff880064642000: fc fc fc fc fc fc fc fc fc fc fc fc
fc fc fc fc
[   57.376380]  ffff880064642080: fc fc fc fc fc fc fc fc fc fc fc fc
fc fc fc fc
[   57.377563] ==================================================================
