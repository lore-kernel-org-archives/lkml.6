Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id PqXqLN4iGVvQSgAAmS7hNA
	; Thu, 07 Jun 2018 12:19:42 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 9B837608C1; Thu,  7 Jun 2018 12:19:42 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f3POxDmi"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id BD88160115;
	Thu,  7 Jun 2018 12:19:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BD88160115
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932378AbeFGMTj (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 08:19:39 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:43054 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932108AbeFGMTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 08:19:38 -0400
Received: by mail-pg0-f68.google.com with SMTP id a14-v6so4069060pgw.10
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 05:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6cCjIslcEfxJZODtroAg+3gRumE/5Fn6SMz7mbSNER4=;
        b=f3POxDmixwkMBdZuj5fQSLPUcXUFTty9NkXKxU5w2ZFZ1ivE4RHxfGj8pf4qjCcp2B
         DgfDiey8viPT/3v1TCf/t7RCctkQWJSO62zNrrnDLmci8BqLWUOwlMhgqooWJ87wdMyK
         V5Ptho330fYcIPXtTT89yUNPbdWprXHCrOQyPyvn8VFKbLbyty5Pt9wO3tWT3kwMpFvK
         /oNDpWQaumzhNjHFB3k+KTYBfHsB/t89W3XXXrtj6BhIqPIl88iScFLw/cTONjfBmg9c
         MTp0Mowd383lLB08GiL/a4OEZtxApAQlFcMXuLRN5tCkFGbWnI/QK80XWTcG+8057YLl
         ijGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6cCjIslcEfxJZODtroAg+3gRumE/5Fn6SMz7mbSNER4=;
        b=YfmVsmAPcK2gwqKYybEzuth+Fdw7uAMTCw77x1p2OOQgGa0bRyrtHC/JUpcFBJItls
         jIkfeKrrC2Xj56CuVF9KnfGNprZG7qjETLS8CzbSRCiDwK5xE4Zro2IquDITSMdF9eJ2
         hCh9+Rhty1Nf3a99Es3t/+16rwMhWeih+FQVLRi7Og6fGv7KJ1LnjBRazXVurkEJ3F34
         pt9fyI/uTGBVhyNcTHQ05zR3Q4gfItt25BVOPhHbI7G9l5ZDSfI1N55zr5b4Pxe4Dy+9
         oVLy0tCGTjene1xmEMpRd0Om2fgBLz709VPSHiXDRKNfbTtIfMFrmDEmG0ywZW2ytpuW
         AjYA==
X-Gm-Message-State: APt69E2/ge4bBYlFVUBztjofb7ZkT3BTtFWv0T+l0Op5WM+L2UkPHARc
        WuZ68IUrXH0mSN2nC9kaxoK1QTjwPUGIvZbI2x0WfA==
X-Google-Smtp-Source: ADUXVKJYUM28TeAE7w4xu13IK2vv3m00KJ02k60NOIMZgCfJqu5t4amBBCARC81GGusF2q8KrtH/+jrUWBTkQfPZcT4=
X-Received: by 2002:a65:4bcd:: with SMTP id p13-v6mr1425321pgr.114.1528373977123;
 Thu, 07 Jun 2018 05:19:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:d42:0:0:0:0 with HTTP; Thu, 7 Jun 2018 05:19:16
 -0700 (PDT)
In-Reply-To: <000000000000271c83056dd6acc6@google.com>
References: <000000000000271c83056dd6acc6@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Thu, 7 Jun 2018 14:19:16 +0200
Message-ID: <CACT4Y+ZO9pbQ+5gyZPW4DZFKtJbciwmx=gWGxzx2sp2fy8+d6Q@mail.gmail.com>
Subject: Re: bpf-next boot error: KASAN: use-after-free Write in call_usermodehelper_exec_work
To: syzbot <syzbot+2c73319c406f1987d156@syzkaller.appspotmail.com>,
        Alexei Starovoitov <ast@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, mcgrof@kernel.org,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 4, 2018 at 10:21 PM, syzbot
<syzbot+2c73319c406f1987d156@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    69b450789136 Merge branch 'misc-BPF-improvements'
> git tree:       bpf-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=1080d1d7800000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=e4078980b886800c
> dashboard link: https://syzkaller.appspot.com/bug?extid=2c73319c406f1987d156
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>
> Unfortunately, I don't have any reproducer for this crash yet.
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+2c73319c406f1987d156@syzkaller.appspotmail.com


This crash now happens on every other boot of mainline tree. This
prevents syzbot testing of new code, and just boots machine with
corrupted memory. Were there any recent changes in umh? +Alexei, you
seem to touch it last. Could your change cause this?



> kworker/u4:1 (36) used greatest stack depth: 23056 bytes left
> cpuidle: using governor menu
> ACPI: bus type PCI registered
> PCI: Using configuration type 1 for base access
> ==================================================================
> BUG: KASAN: use-after-free in call_usermodehelper_exec_work+0x2d3/0x310
> kernel/umh.c:195
> Write of size 4 at addr ffff8801d9202370 by task kworker/u4:2/50
>
> CPU: 0 PID: 50 Comm: kworker/u4:2 Not tainted 4.17.0-rc6+ #32
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Workqueue: events_unbound call_usermodehelper_exec_work
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
>  print_address_description+0x6c/0x20b mm/kasan/report.c:256
>  kasan_report_error mm/kasan/report.c:354 [inline]
>  kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
>  __asan_report_store4_noabort+0x17/0x20 mm/kasan/report.c:437
>  call_usermodehelper_exec_work+0x2d3/0x310 kernel/umh.c:195
>  process_one_work+0xc1e/0x1b50 kernel/workqueue.c:2145
>  worker_thread+0x1cc/0x1440 kernel/workqueue.c:2279
>  kthread+0x345/0x410 kernel/kthread.c:240
>  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412
>
> Allocated by task 1:
>  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
>  set_track mm/kasan/kasan.c:460 [inline]
>  kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:553
>  kmem_cache_alloc_trace+0x152/0x780 mm/slab.c:3620
>  kmalloc include/linux/slab.h:512 [inline]
>  kzalloc include/linux/slab.h:701 [inline]
>  call_usermodehelper_setup+0xe8/0x400 kernel/umh.c:382
>  kobject_uevent_env+0xb21/0x1110 lib/kobject_uevent.c:608
>  kobject_uevent+0x1f/0x30 lib/kobject_uevent.c:636
>  kernel_add_sysfs_param kernel/params.c:798 [inline]
>  param_sysfs_builtin kernel/params.c:833 [inline]
>  param_sysfs_init+0x3f9/0x486 kernel/params.c:954
>  do_one_initcall+0x127/0x913 init/main.c:884
>  do_initcall_level init/main.c:952 [inline]
>  do_initcalls init/main.c:960 [inline]
>  do_basic_setup init/main.c:978 [inline]
>  kernel_init_freeable+0x49b/0x58e init/main.c:1135
>  kernel_init+0x11/0x1b3 init/main.c:1061
>  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412
>
> Freed by task 208:
>  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
>  set_track mm/kasan/kasan.c:460 [inline]
>  __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:521
>  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
>  __cache_free mm/slab.c:3498 [inline]
>  kfree+0xd9/0x260 mm/slab.c:3813
>  call_usermodehelper_freeinfo kernel/umh.c:45 [inline]
>  umh_complete+0x7b/0x90 kernel/umh.c:59
>  call_usermodehelper_exec_async+0x6e8/0x9e0 kernel/umh.c:116
>  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412
>
> The buggy address belongs to the object at ffff8801d9202300
>  which belongs to the cache kmalloc-192 of size 192
> The buggy address is located 112 bytes inside of
>  192-byte region [ffff8801d9202300, ffff8801d92023c0)
> The buggy address belongs to the page:
> page:ffffea0007648080 count:1 mapcount:0 mapping:ffff8801d9202000 index:0x0
> flags: 0x2fffc0000000100(slab)
> raw: 02fffc0000000100 ffff8801d9202000 0000000000000000 0000000100000010
> raw: ffffea0007647f60 ffff8801da801148 ffff8801da800040 0000000000000000
> page dumped because: kasan: bad access detected
>
> Memory state around the buggy address:
>  ffff8801d9202200: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>  ffff8801d9202280: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>                                                              ^
>  ffff8801d9202380: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>  ffff8801d9202400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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
> You received this message because you are subscribed to the Google Groups
> "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an
> email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit
> https://groups.google.com/d/msgid/syzkaller-bugs/000000000000271c83056dd6acc6%40google.com.
> For more options, visit https://groups.google.com/d/optout.
