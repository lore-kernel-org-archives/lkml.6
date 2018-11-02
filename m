Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF51FC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 15:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DFC02081B
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 15:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f+zFNpoh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DFC02081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbeKCAl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 20:41:26 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:35014 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbeKCAl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 20:41:26 -0400
Received: by mail-io1-f65.google.com with SMTP id 79-v6so1664131iou.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 08:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=JAQNiFxqFbFrwUH2Z38QALNVHhI/MHgN0N6on1LwkS8=;
        b=f+zFNpohPycaOTt3vEkLhKJ+IIAzKye5/G8sgY3EQtpt5Ny9NYhQaWJYgIOIKQ3kAo
         JclAUeqSgudzYnrKvW2Mr5ahzLv04qFTssgx00g0WVajrY2ZdRgSpfOlhvwHp1PaxSb2
         t/2Na4XscdT3ulbk9+f8KcNtlum3rB2sqPo62A7KaeNCZNXaS5vhhWJIPJ6mCKrrgsvo
         64FVNqeIxdnHw5+rdOkb++BVkBRrn2aHIJUUgQPVSttpEeDncz/z0/dlGBp6dDT0cNzC
         mPcC0+2zV+/GC49Ytrn/tgsUF+bjmLP2l+srKrSgDHvsGh1jbE9NxL6zShyez5DgzCPD
         GRkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=JAQNiFxqFbFrwUH2Z38QALNVHhI/MHgN0N6on1LwkS8=;
        b=tbcUZAaX93+9cC6gKKB5NecWJZpcQhhZVnQ9LmVhSk/ltZ67+2KtuXDc871c68c3G1
         AZgayzSK9v4sn/8Uo8zH65JriqvZF87/9pDT3EGi9g+WnY94lkh0ZInN7rAXHK83dSp6
         NrHgqQU1LcptsnPAtQ0FeNcjZDrSgkJ1wyA0WKdpTzBSv+weZPzkgXdANCJf+LDFy/0n
         3vPkwaSE8a6S9tJ88EOKujp/EWyUhcLzCaDZyPYTrx723jYmKC4P5VSh3KzoZjmelaf/
         oPNy70UbFe0LAcrm1D3PYxllXJGHkmGH/gIVXfYJwwa6HD8fuS27ftnLvfr6VQ8SixuF
         g4lA==
X-Gm-Message-State: AGRZ1gLk1G7UurBcFud4sHbThHPI8upY/aIw6ncEz0OR1cStpXcOH3eR
        lJY4YnM5eid0Cf9k/o6AA59tsvkn1RBgTJN73mUPCuTUQI0=
X-Google-Smtp-Source: AJdET5cpitMN2c7UV7w4zWw8aQlGPIfrDJuY1cNT8lbH/ra0pUe5/cNNBGn07XMZXNGmlZXiLf+Ki+ZdjQMwJXYPqJE=
X-Received: by 2002:a6b:620d:: with SMTP id f13-v6mr512852iog.11.1541172837716;
 Fri, 02 Nov 2018 08:33:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:b01b:0:0:0:0:0 with HTTP; Fri, 2 Nov 2018 08:33:37 -0700 (PDT)
In-Reply-To: <0000000000001c5bd90579b039b8@google.com>
References: <0000000000001c5bd90579b039b8@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 2 Nov 2018 16:33:37 +0100
Message-ID: <CACT4Y+YiQ47gUDfJeo5A-YWaGE_a84nZY+dntr8sazEb=+bq5g@mail.gmail.com>
Subject: Re: WARNING: refcount bug in kobject_put
To:     syzbot <syzbot+3ed2626dbfac197ce4d4@syzkaller.appspotmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>, rafael@kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 2, 2018 at 4:31 PM, syzbot
<syzbot+3ed2626dbfac197ce4d4@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    e468f5c06b5e Merge tag 'compiler-attributes-for-linus-4.20..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=17ad34b9400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=9384ecb1c973baed
> dashboard link: https://syzkaller.appspot.com/bug?extid=3ed2626dbfac197ce4d4
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16f6882b400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1423f983400000

Looks the same as:

https://syzkaller.appspot.com/bug?id=b52dec65c1aaaec9b3893458b13a3304303de321

#syz dup: WARNING in kernfs_get


> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+3ed2626dbfac197ce4d4@syzkaller.appspotmail.com
>
> ------------[ cut here ]------------
> refcount_t: underflow; use-after-free.
> WARNING: CPU: 1 PID: 7046 at lib/refcount.c:187
> refcount_sub_and_test_checked+0x2c9/0x310 lib/refcount.c:187
> Kernel panic - not syncing: panic_on_warn set ...
> CPU: 1 PID: 7046 Comm: syz-executor895 Not tainted 4.19.0+ #315
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x244/0x39d lib/dump_stack.c:113
>  panic+0x2ad/0x55c kernel/panic.c:188
>  __warn.cold.8+0x20/0x45 kernel/panic.c:540
>  report_bug+0x254/0x2d0 lib/bug.c:186
>  fixup_bug arch/x86/kernel/traps.c:178 [inline]
>  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:271
>  do_invalid_op+0x36/0x40 arch/x86/kernel/traps.c:290
>  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:969
> RIP: 0010:refcount_sub_and_test_checked+0x2c9/0x310 lib/refcount.c:187
> Code: 89 de e8 0a 87 ed fd 84 db 74 07 31 db e9 4d ff ff ff e8 2a 86 ed fd
> 48 c7 c7 20 9d 60 88 c6 05 85 5e 7f 06 01 e8 c7 e6 b6 fd <0f> 0b 31 db e9 2c
> ff ff ff 48 89 cf e8 56 cd 30 fe e9 41 fe ff ff
> RSP: 0018:ffff8801bcdd76a8 EFLAGS: 00010286
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: ffffffff8165d6c5 RDI: 0000000000000005
> RBP: ffff8801bcdd7790 R08: ffff8801bcb98700 R09: ffffed003b5e5020
> R10: ffffed003b5e5020 R11: ffff8801daf28107 R12: ffff8801d72459b8
> R13: 00000000ffffffff R14: ffff8801bcdd7768 R15: ffff8801bcdfa620
>  refcount_dec_and_test_checked+0x1a/0x20 lib/refcount.c:212
>  kref_put include/linux/kref.h:69 [inline]
>  kobject_put+0x6c/0xe0 lib/kobject.c:708
>  kset_put include/linux/kobject.h:218 [inline]
>  kobj_kset_leave+0x25b/0x3f0 lib/kobject.c:201
>  kobject_del.part.4+0x79/0xf0 lib/kobject.c:596
>  kobject_del+0x1f/0x30 lib/kobject.c:588
>  cleanup_glue_dir.part.19+0x1c2/0x210 drivers/base/core.c:1651
>  cleanup_glue_dir drivers/base/core.c:681 [inline]
>  device_del+0x813/0xb70 drivers/base/core.c:2094
>  hci_unregister_dev+0x3a2/0x990 net/bluetooth/hci_core.c:3355
>  vhci_release+0x76/0xf0 drivers/bluetooth/hci_vhci.c:354
>  __fput+0x385/0xa30 fs/file_table.c:278
>  ____fput+0x15/0x20 fs/file_table.c:309
>  task_work_run+0x1e8/0x2a0 kernel/task_work.c:113
>  tracehook_notify_resume include/linux/tracehook.h:188 [inline]
>  exit_to_usermode_loop+0x318/0x380 arch/x86/entry/common.c:166
>  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
>  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
>  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x400dd0
> Code: 01 f0 ff ff 0f 83 b0 0a 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f
> 44 00 00 83 3d fd 18 2d 00 00 75 14 b8 03 00 00 00 0f 05 <48> 3d 01 f0 ff ff
> 0f 83 84 0a 00 00 c3 48 83 ec 08 e8 3a 01 00 00
> RSP: 002b:00007ffc5caf19d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
> RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000400dd0
> RDX: 0000000000000002 RSI: 00000000200000c0 RDI: 0000000000000003
> RBP: 0000000000000000 R08: 00000000004002c8 R09: 00000000004002c8
> R10: 0000000000b0c880 R11: 0000000000000246 R12: 000000000000b95f
> R13: 0000000000401d70 R14: 0000000000000000 R15: 0000000000000000
> Kernel Offset: disabled
> Rebooting in 86400 seconds..
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
>
> --
> You received this message because you are subscribed to the Google Groups
> "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an
> email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit
> https://groups.google.com/d/msgid/syzkaller-bugs/0000000000001c5bd90579b039b8%40google.com.
> For more options, visit https://groups.google.com/d/optout.
