Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB45C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41A632075B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:54:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uU8AJEYJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbfBTPyz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 10:54:55 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:39327 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbfBTPyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 10:54:55 -0500
Received: by mail-it1-f195.google.com with SMTP id l15so16600927iti.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 07:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l2lWFaWGOBwA8qeTCGPeF2euqRIGcBBkcHEDh68Y5WM=;
        b=uU8AJEYJHJXgp0Ev6FbgyWzi5E/xFEDj0M10mzoYER+epj+7X7YPm9igdgTc1Y0vqn
         Wxo28TVXbC8pv7paRTBajs8iq0lDwovtZDM+11qx8sOdK7YAu1qD6mIKAo7dk4MA5Lt5
         LBZzrpmvWF3BVagJ7ra6mfURgULLFo9v6kSnwbv22fdmFQJzDxnEXyEBHuLWMLfHIKfn
         u+0QrU5mkAPOPeWB+7Clp6t59CqzbI7DQrV+GpLGCVAsWyTpARIc1uYw4DYJaynM/RQb
         RT+V1mJesZjUvF8fxDkbslkQhA3BlbaFzcVDwiVVLgGUrX5ZgyJ00/gXSEvwI5Jxuff2
         NGuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l2lWFaWGOBwA8qeTCGPeF2euqRIGcBBkcHEDh68Y5WM=;
        b=cRcvdXeBsyjVyMFFJhOzFeUTHDcndkO06IsG65ym9Vr5StJsAkvF89of9v/NgrALG5
         ht+JIk5Q/vskwqgKbLi8uFpuEVEXf3aCmhv5MS4SQymxPQ71KNl3yZLoS97+JCQvA7rW
         HQ18xVzkYBTchaNHX6UcJ9ZDC53/UUo5vG1Fwd7TzAvqCZ3Rx2DRZSsnG5IaPNqOysez
         v55MYUzwRnyLr4aYZy0dFditXqHKGSD9KwlJUiDnz8/pwCGDaEF96V7YcbrzU10DZOsq
         XuJb8N4dnBWTRYEVt18uV6Xj9NuwiqphfhKhDi3eSB0squ9ruj94I6SelaQLaDay5EHu
         GCsA==
X-Gm-Message-State: AHQUAuZvs5HwJG4ZzRAxiKcJerjgtIPbUxrHJZSe468obpbhCOqW/nbz
        G01k2g6BbQ448ncNGtp67H+XqLrkP+htVvK2CEQ9lQ==
X-Google-Smtp-Source: AHgI3IaKiT7cdKSKX7v/EAS07M4tiPILIpAdH6sJQthTzSx1g2kKPq96Zc4/Jrv8lMlMFNrALM5rrR7YF1hZO6hb6bg=
X-Received: by 2002:a05:660c:3ce:: with SMTP id c14mr2609862itl.166.1550678093409;
 Wed, 20 Feb 2019 07:54:53 -0800 (PST)
MIME-Version: 1.0
References: <00000000000087c36f05727375d2@google.com>
In-Reply-To: <00000000000087c36f05727375d2@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 20 Feb 2019 16:54:42 +0100
Message-ID: <CACT4Y+YBh3FW8gFEAWm7+HArgz=pEoWXXWVYCxgzZspu1zzYYg@mail.gmail.com>
Subject: Re: KASAN: slab-out-of-bounds Write in tls_push_record (2)
To:     syzbot <syzbot+3d650eba9d63b8de7478@syzkaller.appspotmail.com>
Cc:     aviadye@mellanox.com, borisp@mellanox.com, davejwatson@fb.com,
        David Miller <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 2, 2018 at 3:05 PM syzbot
<syzbot+3d650eba9d63b8de7478@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    44960f2a7b63 staging: ashmem: Fix SIGBUS crash when traver..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=10f7ea72400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=2dc0cd7c2eefb46f
> dashboard link: https://syzkaller.appspot.com/bug?extid=3d650eba9d63b8de7478
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>
> Unfortunately, I don't have any reproducer for this crash yet.
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+3d650eba9d63b8de7478@syzkaller.appspotmail.com

This is probably:

#syz dup: KASAN: out-of-bounds Write in tls_push_record

> ==================================================================
> BUG: KASAN: slab-out-of-bounds in tls_fill_prepend include/net/tls.h:339
> [inline]
> BUG: KASAN: slab-out-of-bounds in tls_push_record+0x1091/0x1400
> net/tls/tls_sw.c:239
> Write of size 1 at addr ffff88019c5d8000 by task syz-executor2/11760
>
> CPU: 0 PID: 11760 Comm: syz-executor2 Not tainted 4.18.0-rc7+ #172
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>   __dump_stack lib/dump_stack.c:77 [inline]
>   dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
>   print_address_description+0x6c/0x20b mm/kasan/report.c:256
>   kasan_report_error mm/kasan/report.c:354 [inline]
>   kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
>   __asan_report_store1_noabort+0x17/0x20 mm/kasan/report.c:435
>   tls_fill_prepend include/net/tls.h:339 [inline]
>   tls_push_record+0x1091/0x1400 net/tls/tls_sw.c:239
>   tls_sw_push_pending_record+0x22/0x30 net/tls/tls_sw.c:276
>   tls_handle_open_record net/tls/tls_main.c:164 [inline]
>   tls_sk_proto_close+0x74c/0xae0 net/tls/tls_main.c:264
>   inet_release+0x104/0x1f0 net/ipv4/af_inet.c:427
>   inet6_release+0x50/0x70 net/ipv6/af_inet6.c:459
>   __sock_release+0xd7/0x260 net/socket.c:600
>   sock_close+0x19/0x20 net/socket.c:1151
>   __fput+0x355/0x8b0 fs/file_table.c:209
>   ____fput+0x15/0x20 fs/file_table.c:243
>   task_work_run+0x1ec/0x2a0 kernel/task_work.c:113
>   tracehook_notify_resume include/linux/tracehook.h:192 [inline]
>   exit_to_usermode_loop+0x313/0x370 arch/x86/entry/common.c:166
>   prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
>   syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
>   do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x4105c1
> Code: 75 14 b8 03 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 34 19 00 00 c3 48
> 83 ec 08 e8 0a fc ff ff 48 89 04 24 b8 03 00 00 00 0f 05 <48> 8b 3c 24 48
> 89 c2 e8 53 fc ff ff 48 89 d0 48 83 c4 08 48 3d 01
> RSP: 002b:0000000000a3feb0 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
> RAX: 0000000000000000 RBX: 0000000000000014 RCX: 00000000004105c1
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000013
> RBP: 0000000000000010 R08: 0000000000000000 R09: 0000000000000001
> R10: 0000000000a3fde0 R11: 0000000000000293 R12: 0000000000000000
> R13: 000000000002fd87 R14: 0000000000000094 R15: badc0ffeebadface
>
> Allocated by task 2597:
>   save_stack+0x43/0xd0 mm/kasan/kasan.c:448
>   set_track mm/kasan/kasan.c:460 [inline]
>   kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:553
>   kasan_slab_alloc+0x12/0x20 mm/kasan/kasan.c:490
>   kmem_cache_alloc+0x12e/0x760 mm/slab.c:3554
>   getname_flags+0xd0/0x5a0 fs/namei.c:140
>   user_path_at_empty+0x2d/0x50 fs/namei.c:2584
>   user_path_at include/linux/namei.h:57 [inline]
>   vfs_statx+0x129/0x210 fs/stat.c:185
>   vfs_stat include/linux/fs.h:3102 [inline]
>   __do_sys_newstat+0x8f/0x110 fs/stat.c:337
>   __se_sys_newstat fs/stat.c:333 [inline]
>   __x64_sys_newstat+0x54/0x80 fs/stat.c:333
>   do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
>
> Freed by task 2597:
>   save_stack+0x43/0xd0 mm/kasan/kasan.c:448
>   set_track mm/kasan/kasan.c:460 [inline]
>   __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:521
>   kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
>   __cache_free mm/slab.c:3498 [inline]
>   kmem_cache_free+0x86/0x2d0 mm/slab.c:3756
>   putname+0xf2/0x130 fs/namei.c:261
>   filename_lookup+0x397/0x510 fs/namei.c:2330
>   user_path_at_empty+0x40/0x50 fs/namei.c:2584
>   user_path_at include/linux/namei.h:57 [inline]
>   vfs_statx+0x129/0x210 fs/stat.c:185
>   vfs_stat include/linux/fs.h:3102 [inline]
>   __do_sys_newstat+0x8f/0x110 fs/stat.c:337
>   __se_sys_newstat fs/stat.c:333 [inline]
>   __x64_sys_newstat+0x54/0x80 fs/stat.c:333
>   do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
>
> The buggy address belongs to the object at ffff88019c5d8980
>   which belongs to the cache names_cache of size 4096
> The buggy address is located 2432 bytes to the left of
>   4096-byte region [ffff88019c5d8980, ffff88019c5d9980)
> The buggy address belongs to the page:
> page:ffffea0006717600 count:1 mapcount:0 mapping:ffff8801dad85dc0 index:0x0
> compound_mapcount: 0
> flags: 0x2fffc0000008100(slab|head)
> raw: 02fffc0000008100 ffffea0006470d88 ffffea0006717688 ffff8801dad85dc0
> raw: 0000000000000000 ffff88019c5d8980 0000000100000001 0000000000000000
> page dumped because: kasan: bad access detected
>
> Memory state around the buggy address:
>   ffff88019c5d7f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>   ffff88019c5d7f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > ffff88019c5d8000: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>                     ^
>   ffff88019c5d8080: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>   ffff88019c5d8100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
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
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/00000000000087c36f05727375d2%40google.com.
> For more options, visit https://groups.google.com/d/optout.
