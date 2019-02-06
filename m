Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 344D2C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 03:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCFF82184E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 03:28:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zg+5c0Yi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbfBFD2e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 22:28:34 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:56264 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbfBFD2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 22:28:33 -0500
Received: by mail-it1-f196.google.com with SMTP id m62so2961837ith.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 19:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iIIx/59Q/hhNxwvvy42Pl9sPCpxp1fDHgwBnKJpyAN4=;
        b=Zg+5c0YiBhwiaCxDY/4cDt7IUdjlafwUqeDcXokeF1CjZT46kQFLDc0I8unb22/05Q
         qHavr7wypCjrpyDPkunxs/imN6BpgyRcpNFyBFkzgImnmCh37NZwXNDL9Drez6wGr3In
         IwqSMiGrIBEX+BF+8iEWKX1SL4IxyucLef9uZWEXPUfFvIJ6ezbd7OolVC4wJbjms3KJ
         KJVCxyeC6Dysh5ocKu+py1PwwDd1Q7FgDYsIzUWNE1useakK/SsNAlWPMOmxwFrohwiN
         Dz4Ysy9ZWnK8PIy/WNFBBlTF9FvHRKDzJUbqzBag8/UD4aIKoT5V69mcgUER2nRxDtA+
         ZuNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iIIx/59Q/hhNxwvvy42Pl9sPCpxp1fDHgwBnKJpyAN4=;
        b=N25gsd4qOs31B8CYSenG+jIYSxueF0ygKU/taudRsgsAsThX++AJIYCsRMwyvCRo4u
         krYdNHiFNqO0pN7PXeEy4qfi2qkKRz9EkvE4s0vYcVcCGZS8v00NOjgKFEhOO/hzW72h
         vzbWhyhkN8O7c4LrzkzZssuNFePF63ZiO40Z0IMH5B2rF14PPZmUCc2lyK3ZkKSlvoBB
         Q1fRzkr0L+esnc0AiOhCjN+GGLQRMD9Fmqc1QxI4d9PnesIOGhyU2+anZ4GcivPPB1lm
         E/6fnkXd9csjjbaBS0wxM5Lbu1gVH6CAE0MiZV7AJfhFBFzaSpB9byuByhp7FSw4oCjH
         RK3w==
X-Gm-Message-State: AHQUAuawoSO1sVLbiCEaW9mA9CA1pHcSjpCHm0uSdS9LN+0ivUNcCAeo
        DKGRhwNDecPN54Ewith0D/JXXMyG0Hret804JQszog==
X-Google-Smtp-Source: AHgI3IY/ExadjdboNpm/1B28DoK97plHCZyv6I3n6DJEJMijBh3+2tFWtQRS6kpO5uMS6yxb+2HfDg/f8GVwxO98sN8=
X-Received: by 2002:a24:7351:: with SMTP id y78mr771989itb.12.1549423711998;
 Tue, 05 Feb 2019 19:28:31 -0800 (PST)
MIME-Version: 1.0
References: <000000000000c2e17f0580b3387c@google.com>
In-Reply-To: <000000000000c2e17f0580b3387c@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 6 Feb 2019 04:28:21 +0100
Message-ID: <CACT4Y+YOTSY=ZVw882tfDDPZ6Y5ZSX6HHn2M=Q2uTxjUtjb9=w@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in __wake_up_common_lock
To:     syzbot <syzbot+fb065bc06d3d4054be6f@syzkaller.appspotmail.com>,
        Eric Dumazet <edumazet@google.com>
Cc:     Karsten Keil <isdn@linux-pingi.de>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 10:02 PM syzbot
<syzbot+fb065bc06d3d4054be6f@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    62967898789d Merge git://git.kernel.org/pub/scm/linux/kern..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=10f0bf08c00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=4fceea9e2d99ac20
> dashboard link: https://syzkaller.appspot.com/bug?extid=fb065bc06d3d4054be6f
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
>
> Unfortunately, I don't have any reproducer for this crash yet.
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+fb065bc06d3d4054be6f@syzkaller.appspotmail.com

I assume this is also fixed by:

#syz fix: mISDN: fix a race in dev_expire_timer()

> QAT: Invalid ioctl
> ==================================================================
> BUG: KASAN: use-after-free in debug_spin_lock_before
> kernel/locking/spinlock_debug.c:83 [inline]
> BUG: KASAN: use-after-free in do_raw_spin_lock+0x303/0x360
> kernel/locking/spinlock_debug.c:112
> Read of size 4 at addr ffff88808738e92c by task syz-executor1/8644
>
> CPU: 1 PID: 8644 Comm: syz-executor1 Not tainted 5.0.0-rc4+ #50
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>   <IRQ>
>   __dump_stack lib/dump_stack.c:77 [inline]
>   dump_stack+0x1db/0x2d0 lib/dump_stack.c:113
>   print_address_description.cold+0x7c/0x20d mm/kasan/report.c:187
>   kasan_report.cold+0x1b/0x40 mm/kasan/report.c:317
>   __asan_report_load4_noabort+0x14/0x20 mm/kasan/generic_report.c:134
>   debug_spin_lock_before kernel/locking/spinlock_debug.c:83 [inline]
>   do_raw_spin_lock+0x303/0x360 kernel/locking/spinlock_debug.c:112
>   __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:117 [inline]
>   _raw_spin_lock_irqsave+0x9d/0xcd kernel/locking/spinlock.c:152
>   __wake_up_common_lock+0x19b/0x390 kernel/sched/wait.c:120
>   __wake_up+0xe/0x10 kernel/sched/wait.c:145
>   dev_expire_timer+0x14b/0x570 drivers/isdn/mISDN/timerdev.c:174
>   call_timer_fn+0x254/0x900 kernel/time/timer.c:1325
>   expire_timers kernel/time/timer.c:1362 [inline]
>   __run_timers+0x6fc/0xd50 kernel/time/timer.c:1681
> IPVS: ftp: loaded support on port[0] = 21
>   run_timer_softirq+0x52/0xb0 kernel/time/timer.c:1694
>   __do_softirq+0x30b/0xb11 kernel/softirq.c:292
>   invoke_softirq kernel/softirq.c:373 [inline]
>   irq_exit+0x180/0x1d0 kernel/softirq.c:413
>   exiting_irq arch/x86/include/asm/apic.h:536 [inline]
>   smp_apic_timer_interrupt+0x1b7/0x760 arch/x86/kernel/apic/apic.c:1062
>   apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:807
>   </IRQ>
> RIP: 0010:arch_local_irq_restore arch/x86/include/asm/paravirt.h:766
> [inline]
> RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:160
> [inline]
> RIP: 0010:_raw_spin_unlock_irqrestore+0x95/0xe0
> kernel/locking/spinlock.c:184
> Code: 48 c7 c0 30 82 92 89 48 ba 00 00 00 00 00 fc ff df 48 c1 e8 03 80 3c
> 10 00 75 39 48 83 3d 12 d0 9d 01 00 74 24 48 89 df 57 9d <0f> 1f 44 00 00
> bf 01 00 00 00 e8 dc 75 63 f9 65 8b 05 95 3b 0d 78
> RSP: 0018:ffff888050a7f360 EFLAGS: 00000282 ORIG_RAX: ffffffffffffff13
> RAX: 1ffffffff1325046 RBX: 0000000000000282 RCX: 0000000000000000
> RDX: dffffc0000000000 RSI: 0000000000000001 RDI: 0000000000000282
> RBP: ffff888050a7f370 R08: ffff888088b9e000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff8b72b128
> R13: ffff888088b9e000 R14: 00000000000d7480 R15: ffffffff8b72b128
>   __debug_object_init+0x1c0/0x12d0 lib/debugobjects.c:418
>   debug_object_init+0x16/0x20 lib/debugobjects.c:431
>   __init_work+0x50/0x60 kernel/workqueue.c:504
>   call_usermodehelper_setup+0x133/0x410 kernel/umh.c:389
>   call_modprobe kernel/kmod.c:94 [inline]
>   __request_module+0x4f5/0xeea kernel/kmod.c:171
>   crypto_larval_lookup crypto/api.c:237 [inline]
>   crypto_alg_mod_lookup+0x54e/0x6d0 crypto/api.c:280
> QAT: Invalid ioctl
>   crypto_find_alg crypto/api.c:504 [inline]
>   crypto_alloc_tfm+0xd9/0x2f0 crypto/api.c:537
>   crypto_alloc_skcipher+0x2d/0x40 crypto/skcipher.c:945
>   cryptd_alloc_skcipher+0x121/0x270 crypto/cryptd.c:1226
> IPVS: ftp: loaded support on port[0] = 21
>   simd_skcipher_init+0x6c/0x1c0 crypto/simd.c:119
>   crypto_skcipher_init_tfm+0x299/0x8c0 crypto/skcipher.c:862
>   crypto_create_tfm+0xec/0x310 crypto/api.c:471
>   crypto_alloc_tfm+0x104/0x2f0 crypto/api.c:543
>   crypto_alloc_skcipher+0x2d/0x40 crypto/skcipher.c:945
> QAT: Invalid ioctl
>   skcipher_bind+0x26/0x30 crypto/algif_skcipher.c:310
>   alg_bind+0x25d/0x570 crypto/af_alg.c:183
>   __sys_bind+0x30b/0x420 net/socket.c:1483
>   __do_sys_bind net/socket.c:1494 [inline]
>   __se_sys_bind net/socket.c:1492 [inline]
>   __x64_sys_bind+0x73/0xb0 net/socket.c:1492
>   do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x458089
> Code: 6d b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7
> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff
> ff 0f 83 3b b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007f7508d5ac78 EFLAGS: 00000246 ORIG_RAX: 0000000000000031
> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000458089
> RDX: 0000000000000058 RSI: 0000000020000340 RDI: 000000000000000a
> RBP: 000000000073bf00 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007f7508d5b6d4
> R13: 00000000004be0ca R14: 00000000004ce420 R15: 00000000ffffffff
>
> Allocated by task 8647:
>   save_stack+0x45/0xd0 mm/kasan/common.c:73
>   set_track mm/kasan/common.c:85 [inline]
>   __kasan_kmalloc mm/kasan/common.c:496 [inline]
>   __kasan_kmalloc.constprop.0+0xcf/0xe0 mm/kasan/common.c:469
>   kasan_kmalloc+0x9/0x10 mm/kasan/common.c:504
>   kmem_cache_alloc_trace+0x151/0x760 mm/slab.c:3609
>   kmalloc include/linux/slab.h:545 [inline]
>   mISDN_open+0x104/0x3f0 drivers/isdn/mISDN/timerdev.c:59
>   misc_open+0x398/0x4c0 drivers/char/misc.c:141
>   chrdev_open+0x270/0x7c0 fs/char_dev.c:417
>   do_dentry_open+0x48a/0x1210 fs/open.c:771
>   vfs_open+0xa0/0xd0 fs/open.c:880
>   do_last fs/namei.c:3418 [inline]
>   path_openat+0x144f/0x5650 fs/namei.c:3534
>   do_filp_open+0x26f/0x370 fs/namei.c:3564
>   do_sys_open+0x59a/0x7c0 fs/open.c:1063
>   __do_sys_openat fs/open.c:1090 [inline]
>   __se_sys_openat fs/open.c:1084 [inline]
>   __x64_sys_openat+0x9d/0x100 fs/open.c:1084
>   do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
>
> Freed by task 8649:
>   save_stack+0x45/0xd0 mm/kasan/common.c:73
>   set_track mm/kasan/common.c:85 [inline]
>   __kasan_slab_free+0x102/0x150 mm/kasan/common.c:458
>   kasan_slab_free+0xe/0x10 mm/kasan/common.c:466
>   __cache_free mm/slab.c:3487 [inline]
>   kfree+0xcf/0x230 mm/slab.c:3806
>   mISDN_close+0x39b/0x530 drivers/isdn/mISDN/timerdev.c:97
>   __fput+0x3c5/0xb10 fs/file_table.c:278
>   ____fput+0x16/0x20 fs/file_table.c:309
>   task_work_run+0x1f4/0x2b0 kernel/task_work.c:113
>   tracehook_notify_resume include/linux/tracehook.h:188 [inline]
>   exit_to_usermode_loop+0x32a/0x3b0 arch/x86/entry/common.c:166
>   prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
>   syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
>   do_syscall_64+0x696/0x800 arch/x86/entry/common.c:293
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
>
> The buggy address belongs to the object at ffff88808738e900
>   which belongs to the cache kmalloc-192 of size 192
> The buggy address is located 44 bytes inside of
>   192-byte region [ffff88808738e900, ffff88808738e9c0)
> The buggy address belongs to the page:
> page:ffffea00021ce380 count:1 mapcount:0 mapping:ffff88812c3f0040 index:0x0
> flags: 0x1fffc0000000200(slab)
> raw: 01fffc0000000200 ffffea0002927088 ffffea000298ecc8 ffff88812c3f0040
> raw: 0000000000000000 ffff88808738e000 0000000100000010 0000000000000000
> page dumped because: kasan: bad access detected
>
> Memory state around the buggy address:
>   ffff88808738e800: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>   ffff88808738e880: 00 00 fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> > ffff88808738e900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                                    ^
>   ffff88808738e980: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>   ffff88808738ea00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ==================================================================
>
>
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with
> syzbot.
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/000000000000c2e17f0580b3387c%40google.com.
> For more options, visit https://groups.google.com/d/optout.
