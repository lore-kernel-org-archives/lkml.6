Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF9EDC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 16:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D1B42084E
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 16:36:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gvg0LRoL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbfALQee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 11:34:34 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:45584 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfALQee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 11:34:34 -0500
Received: by mail-vk1-f196.google.com with SMTP id n126so3969945vke.12
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jan 2019 08:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mfFbuERIdyzJ1oQLdK7ncPgcVJeLdqT7x31N7nG8VRY=;
        b=gvg0LRoLCgvjaM0cyXuDytjGV+uTTelIWbb3O/uE1bh3ndLEPebD2wpbLA3NcwMBM0
         f/zXzfBpbk3nRHFE0++ziRw8Ztnw45inABm24bkRFcpkSbc8VS2dKp69kOpREYHOYfm4
         8uoqPXhEVENWBJlk0QmRTsQmUBkaintJPb7PM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mfFbuERIdyzJ1oQLdK7ncPgcVJeLdqT7x31N7nG8VRY=;
        b=gEpFKmQBv9P4JHjrhIJKysSxwSQkiI9THifXOjcsEvfgnhs0bOb4N1IwUW/T3yJYDs
         Tcw0O2cbEMtP29CLLiw5eg37t3FJXxEuOMX2Fmxy67px0M7+i5VA6SxfSjVW/bCVM0bR
         nfFRnEZtiYz7BIWUy5qAtpuUt/P+JJ4tN4hBLZr4kOScf+NPSzbhEw6VnZNunh4MIMxb
         HYsUmW5vfTaRiHOCFpHoC3Op0K3uG841ZhXCcOXQbBqKAB92bHzHYOuYXgqfPXJ5lzFq
         iapAYXFgxu7jLu74IbLO5+Is87lCDlRe1vx1ovfYov7pt/6+FizruWC1KrJTq6MsghRz
         QWFA==
X-Gm-Message-State: AJcUukfNMIWThNteOEMve8Aza77zkOQ6ySJIlBnbrBXWhJMKGYxm0hIK
        edmvMbAJCic/whfdebiREeoIQ9DdOt0=
X-Google-Smtp-Source: ALg8bN6gMKYA/A2qmRrTyMeVvPb7omRolKg74y5tCbfgeo8XJduTSRYi2lTDSg4BabE7xoaXZMLNcA==
X-Received: by 2002:a1f:f0d:: with SMTP id 13mr7409855vkp.21.1547310872377;
        Sat, 12 Jan 2019 08:34:32 -0800 (PST)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com. [209.85.217.47])
        by smtp.gmail.com with ESMTPSA id n206sm41983949vkn.36.2019.01.12.08.34.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Jan 2019 08:34:31 -0800 (PST)
Received: by mail-vs1-f47.google.com with SMTP id v205so11177586vsc.3
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jan 2019 08:34:30 -0800 (PST)
X-Received: by 2002:a67:848a:: with SMTP id g132mr7659390vsd.222.1547310870249;
 Sat, 12 Jan 2019 08:34:30 -0800 (PST)
MIME-Version: 1.0
References: <000000000000b6788f057f30b0ac@google.com>
In-Reply-To: <000000000000b6788f057f30b0ac@google.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Sat, 12 Jan 2019 08:34:17 -0800
X-Gmail-Original-Message-ID: <CAGXu5j+9ETYcavj2x3Up0FhvkopZohbJcS4CMvrrCWOwDurSFw@mail.gmail.com>
Message-ID: <CAGXu5j+9ETYcavj2x3Up0FhvkopZohbJcS4CMvrrCWOwDurSFw@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in seccomp_notify_release
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Will Drewry <wad@chromium.org>,
        syzbot <syzbot+981c26489b2d1c6316ba@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 7:53 AM syzbot
<syzbot+981c26489b2d1c6316ba@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    1bdbe2274920 Merge tag 'vfio-v5.0-rc2' of git://github.com..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=177ce96f400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=edf1c3031097c304
> dashboard link: https://syzkaller.appspot.com/bug?extid=981c26489b2d1c6316ba
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=134c5b9f400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1263027b400000

Oh, interesting. And a working reproducer!

16 threads alternating between these two seccomp calls:

  case 0:
    struct sock_filter = { .code = BPF_RET, .k = 0x7ffffffe };
    struct sock_fprog prog = { .len = 1, filter = &filter };
    syscall(__NR_seccomp, SECCOMP_SET_MODE_FILTER, 0, &prog);

  case 1:
    struct sock_filter = { .code = BPF_RET, };
    struct sock_fprog prog = { .len = 1, filter = &filter };
    syscall(__NR_seccomp, SECCOMP_SET_MODE_FILTER,
               SECCOMP_FILTER_FLAG_TSYNC | SECCOMP_FILTER_FLAG_NEW_LISTENER,
               &prog);


> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+981c26489b2d1c6316ba@syzkaller.appspotmail.com
>
> audit: type=1326 audit(1547207941.906:33): auid=4294967295 uid=0 gid=0
> ses=4294967295 subj=_ pid=7929 comm="syz-executor201"
> exe="/root/syz-executor201062921" sig=31 arch=c000003e syscall=202 compat=0
> ip=0x446349 code=0x0
> ==================================================================
> BUG: KASAN: use-after-free in __lock_acquire+0x3556/0x4a30
> kernel/locking/lockdep.c:3215
> Read of size 8 at addr ffff888098dd1280 by task syz-executor201/7925
>
> CPU: 1 PID: 7925 Comm: syz-executor201 Not tainted 5.0.0-rc1+ #19
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>   __dump_stack lib/dump_stack.c:77 [inline]
>   dump_stack+0x1db/0x2d0 lib/dump_stack.c:113
>   print_address_description.cold+0x7c/0x20d mm/kasan/report.c:187
>   kasan_report.cold+0x1b/0x40 mm/kasan/report.c:317
>   __asan_report_load8_noabort+0x14/0x20 mm/kasan/generic_report.c:135
>   __lock_acquire+0x3556/0x4a30 kernel/locking/lockdep.c:3215
>   lock_acquire+0x1db/0x570 kernel/locking/lockdep.c:3841
>   __mutex_lock_common kernel/locking/mutex.c:925 [inline]
>   __mutex_lock+0x12f/0x1670 kernel/locking/mutex.c:1072
>   mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1087
>   seccomp_notify_release+0x54/0x270 kernel/seccomp.c:979

Tycho, can you take a look at this? Maybe it's a bad interaction with TSYNC?

>   __fput+0x3c5/0xb10 fs/file_table.c:278
>   ____fput+0x16/0x20 fs/file_table.c:309
>   task_work_run+0x1f4/0x2b0 kernel/task_work.c:113
>   tracehook_notify_resume include/linux/tracehook.h:188 [inline]
>   exit_to_usermode_loop+0x32a/0x3b0 arch/x86/entry/common.c:166
>   prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
>   syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
>   do_syscall_64+0x696/0x800 arch/x86/entry/common.c:293
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x405451
> Code: 75 14 b8 03 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 94 17 00 00 c3 48
> 83 ec 08 e8 6a fc ff ff 48 89 04 24 b8 03 00 00 00 0f 05 <48> 8b 3c 24 48
> 89 c2 e8 b3 fc ff ff 48 89 d0 48 83 c4 08 48 3d 01
> RSP: 002b:00007ffe221b1d60 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
> RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000405451
> RDX: 0000000000000000 RSI: 0000000000000080 RDI: 0000000000000003
> RBP: 00000000000003e8 R08: 00000000000003e8 R09: 0000000000000000
> R10: 00007ffe221b1d70 R11: 0000000000000293 R12: 00000000006dac3c
> R13: 0000000000000002 R14: 000000000000002d R15: 00000000006dac30
>
> Allocated by task 7934:
>   save_stack+0x45/0xd0 mm/kasan/common.c:73
>   set_track mm/kasan/common.c:85 [inline]
>   __kasan_kmalloc mm/kasan/common.c:496 [inline]
>   __kasan_kmalloc.constprop.0+0xcf/0xe0 mm/kasan/common.c:469
>   kasan_kmalloc+0x9/0x10 mm/kasan/common.c:504
>   kmem_cache_alloc_trace+0x151/0x760 mm/slab.c:3609
>   kmalloc include/linux/slab.h:545 [inline]
>   kzalloc include/linux/slab.h:740 [inline]
>   seccomp_prepare_filter kernel/seccomp.c:451 [inline]
>   seccomp_prepare_user_filter kernel/seccomp.c:491 [inline]
>   seccomp_set_mode_filter kernel/seccomp.c:1257 [inline]
>   do_seccomp+0x941/0x2cc0 kernel/seccomp.c:1370
>   __do_sys_seccomp kernel/seccomp.c:1389 [inline]
>   __se_sys_seccomp kernel/seccomp.c:1386 [inline]
>   __x64_sys_seccomp+0x73/0xb0 kernel/seccomp.c:1386
>   do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
>
> Freed by task 7934:
>   save_stack+0x45/0xd0 mm/kasan/common.c:73
>   set_track mm/kasan/common.c:85 [inline]
>   __kasan_slab_free+0x102/0x150 mm/kasan/common.c:458
>   kasan_slab_free+0xe/0x10 mm/kasan/common.c:466
>   __cache_free mm/slab.c:3487 [inline]
>   kfree+0xcf/0x230 mm/slab.c:3806
>   seccomp_filter_free kernel/seccomp.c:565 [inline]
>   seccomp_filter_free kernel/seccomp.c:561 [inline]
>   seccomp_set_mode_filter kernel/seccomp.c:1311 [inline]
>   do_seccomp+0xda3/0x2cc0 kernel/seccomp.c:1370
>   __do_sys_seccomp kernel/seccomp.c:1389 [inline]
>   __se_sys_seccomp kernel/seccomp.c:1386 [inline]
>   __x64_sys_seccomp+0x73/0xb0 kernel/seccomp.c:1386
>   do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
>
> The buggy address belongs to the object at ffff888098dd1200
>   which belongs to the cache kmalloc-192 of size 192
> The buggy address is located 128 bytes inside of
>   192-byte region [ffff888098dd1200, ffff888098dd12c0)
> The buggy address belongs to the page:
> page:ffffea0002637440 count:1 mapcount:0 mapping:ffff88812c3f0040
> index:0xffff888098dd1e00
> flags: 0x1fffc0000000200(slab)
> raw: 01fffc0000000200 ffffea0002810748 ffffea0002614808 ffff88812c3f0040
> raw: ffff888098dd1e00 ffff888098dd1000 000000010000000f 0000000000000000
> page dumped because: kasan: bad access detected
>
> Memory state around the buggy address:
>   ffff888098dd1180: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>   ffff888098dd1200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > ffff888098dd1280: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>                     ^
>   ffff888098dd1300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>   ffff888098dd1380: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
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
> syzbot can test patches for this bug, for details see:
> https://goo.gl/tpsmEJ#testing-patches



-- 
Kees Cook
