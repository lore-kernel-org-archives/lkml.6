Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC45C61CE8
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 19:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD01A2086D
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 19:00:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H4SGfrn4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729039AbfASTAZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 14:00:25 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:51425 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728853AbfASTAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 14:00:24 -0500
Received: by mail-it1-f196.google.com with SMTP id w18so11410147ite.1
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jan 2019 11:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k8fTmXJn5DU9whaOG4jPK9bMsdvtCO++x860I3kcQQU=;
        b=H4SGfrn4oVhHy39Q6dMwkB4cqlrHVHZREcKlTS41MdrXvkTvihtBaUwZTzr0BxWAxD
         ANJofFETlbOO4E+CZuvhzA/mbc7QgXs87ensXD4qwPth2eKMguQTuV2z9SzXIpcpsx1C
         CeVMsSvkirnwyTmFoSNwMdWGh1MFTExYa9YI/58zuMmjg+KNlfO8KpDdZ/cFC9NNSWWD
         nIN/qDYqGMAT2CO7OHAoG2mEUkvDEbmLpBMQhyM5Mv9pH/nMarHxw8pu/xysOF+afNyl
         IWnWrwiBbWIRtYm6nAFowIBPnWQMEQrWPF7EZ6KgcaFS1oW6zZ55A4YTzaDLkdcwLWZY
         bQAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k8fTmXJn5DU9whaOG4jPK9bMsdvtCO++x860I3kcQQU=;
        b=T2Oocyf0wvCRHQ63T5sk6+cYIu3sVbW+epwpy+jbLR4ZOxtUb1ouWeAAY1uMkeR0/s
         6nP9nnL6H1qt+O/SS0LFfnNkm5uFLqzHLeq1roZsCyF/VxuAoK5UUrSEy2YTpXZugzM5
         qyuSFcNDx6thhXw0KGzvPzUjVCIqEWHHCdEIag5HMIlxSE2AjS36kj1aRMbrrk2jD+9T
         LTbZu3SzF09+34qFYgVjLUq4tVxdP6rVXsAtYZGvgTDmo7RKJ04TMKco4fNYWtOi0YPG
         bNM13boOcTSbA6LcWfHMSbkhVbf38GKmm4ttdw2mBU+h2kSDNvITbmH6TUxTpdMNeJLI
         tbSw==
X-Gm-Message-State: AJcUukdu5IvsAb2n2MPJASUsmgu/rIH9G1uVlzUlcz+Q/wl7Jrjf+UGR
        tHKa1OnrWO3mm8J2lCzyntelnbTC+QNhIM/PjrcPE4WZ8wQ=
X-Google-Smtp-Source: ALg8bN6nsqKvPHzeNN+5S69vvRnpieSrQpRzcF4DIALoK+NuxC55NGRkT22C/eq/h97oivzw8T0Am6K7wUXdw7FVEA8=
X-Received: by 2002:a24:6511:: with SMTP id u17mr13958069itb.12.1547924421003;
 Sat, 19 Jan 2019 11:00:21 -0800 (PST)
MIME-Version: 1.0
References: <000000000000f93b510578c046bc@google.com>
In-Reply-To: <000000000000f93b510578c046bc@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sat, 19 Jan 2019 20:00:10 +0100
Message-ID: <CACT4Y+YC-=7+1DYeWD=Z53Tr-KBLTo3LG61i_8-_h3MY36rquw@mail.gmail.com>
Subject: Re: INFO: rcu detected stall in sys_creat
To:     syzbot <syzbot+3155335ece2c94bead44@syzkaller.appspotmail.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"On Sun, Oct 21, 2018 at 7:15 PM syzbot
<syzbot+3155335ece2c94bead44@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    8c60c36d0b8c Add linux-next specific files for 20181019
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=160c9245400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=8b6d7c4c81535e89
> dashboard link: https://syzkaller.appspot.com/bug?extid=3155335ece2c94bead44
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>
> Unfortunately, I don't have any reproducer for this crash yet.

+Tetsuo, Jan, Jens

This is a stall, but it involves __getblk_gfp. Is it the same bug as
"INFO: task hung in generic_file_write_iter":
https://syzkaller.appspot.com/bug?id=8afdd02539e35fc02ac7699014bc54a87fdd8dc0
which will be fixed with "blockdev: Fix livelocks on loop device".

This bug also has 10 other duplicates:
https://syzkaller.appspot.com/bug?extid=3155335ece2c94bead44

> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+3155335ece2c94bead44@syzkaller.appspotmail.com
>
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> rcu: INFO: rcu_preempt self-detected stall on CPU
> rcu:    1-....: (10499 ticks this GP) idle=bba/1/0x4000000000000002
> softirq=14204/14204 fqs=5249
> rcu:     (t=10500 jiffies g=17325 q=1324)
> NMI backtrace for cpu 1
> CPU: 1 PID: 10448 Comm: syz-executor0 Not tainted 4.19.0-rc8-next-20181019+
> #98
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>   <IRQ>
>   __dump_stack lib/dump_stack.c:77 [inline]
>   dump_stack+0x244/0x39d lib/dump_stack.c:113
>   nmi_cpu_backtrace.cold.2+0x5c/0xa1 lib/nmi_backtrace.c:101
>   nmi_trigger_cpumask_backtrace+0x1e8/0x22a lib/nmi_backtrace.c:62
>   arch_trigger_cpumask_backtrace+0x14/0x20 arch/x86/kernel/apic/hw_nmi.c:38
>   trigger_single_cpu_backtrace include/linux/nmi.h:162 [inline]
>   rcu_dump_cpu_stacks+0x16f/0x1bc kernel/rcu/tree.c:1195
>   print_cpu_stall.cold.67+0x1f3/0x3c7 kernel/rcu/tree.c:1334
>   check_cpu_stall kernel/rcu/tree.c:1408 [inline]
>   rcu_pending kernel/rcu/tree.c:2961 [inline]
>   rcu_check_callbacks+0xf3b/0x13f0 kernel/rcu/tree.c:2506
>   update_process_times+0x2d/0x70 kernel/time/timer.c:1636
>   tick_sched_handle+0x9f/0x180 kernel/time/tick-sched.c:164
>   tick_sched_timer+0x45/0x130 kernel/time/tick-sched.c:1274
>   __run_hrtimer kernel/time/hrtimer.c:1398 [inline]
>   __hrtimer_run_queues+0x412/0x10c0 kernel/time/hrtimer.c:1460
>   hrtimer_interrupt+0x313/0x780 kernel/time/hrtimer.c:1518
>   local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1034 [inline]
>   smp_apic_timer_interrupt+0x1a1/0x760 arch/x86/kernel/apic/apic.c:1059
>   apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:804
>   </IRQ>
> RIP: 0010:arch_local_irq_restore arch/x86/include/asm/paravirt.h:761
> [inline]
> RIP: 0010:console_unlock+0xf3c/0x1190 kernel/printk/printk.c:2422
> Code: 48 89 f8 48 c1 e8 03 42 80 3c 30 00 0f 85 54 02 00 00 48 83 3d 54 df
> cc 07 00 74 72 e8 6d 16 1a 00 48 8b bd b0 fe ff ff 57 9d <0f> 1f 44 00 00
> e9 f8 f2 ff ff e8 55 16 1a 00 0f 0b e8 4e 16 1a 00
> RSP: 0018:ffff880189396840 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
> RAX: 0000000000040000 RBX: 0000000000000200 RCX: ffffc90001e72000
> RDX: 0000000000040000 RSI: ffffffff81651d63 RDI: 0000000000000246
> RBP: ffff8801893969b0 R08: ffff8801c6600f40 R09: 0000000000000006
> R10: 0000000000000000 R11: ffff8801c6600600 R12: 0000000000000000
> R13: ffffffff848effd0 R14: dffffc0000000000 R15: ffffffff89947610
>   vprintk_emit+0x391/0x990 kernel/printk/printk.c:1922
>   vprintk_default+0x28/0x30 kernel/printk/printk.c:1964
>   vprintk_func+0x7e/0x181 kernel/printk/printk_safe.c:398
>   printk+0xa7/0xcf kernel/printk/printk.c:1997
>   __find_get_block_slow fs/buffer.c:231 [inline]
>   __find_get_block.cold.58+0x3a/0xff fs/buffer.c:1325
>   __getblk_slow fs/buffer.c:1058 [inline]
>   __getblk_gfp+0x3d3/0x1030 fs/buffer.c:1351
>   __bread_gfp+0x2d/0x310 fs/buffer.c:1385
>   sb_bread include/linux/buffer_head.h:307 [inline]
>   fat__get_entry+0x5a6/0xa40 fs/fat/dir.c:101
>   fat_get_entry fs/fat/dir.c:129 [inline]
>   fat_search_long+0x33b/0x1570 fs/fat/dir.c:479
>   vfat_find+0x16d/0x1a0 fs/fat/namei_vfat.c:697
>   vfat_lookup+0x107/0x640 fs/fat/namei_vfat.c:711
>   lookup_open+0x72e/0x1b90 fs/namei.c:3213
>   do_last fs/namei.c:3324 [inline]
>   path_openat+0x15e4/0x5150 fs/namei.c:3534
>   do_filp_open+0x255/0x380 fs/namei.c:3564
>   do_sys_open+0x568/0x700 fs/open.c:1063
>   ksys_open include/linux/syscalls.h:1292 [inline]
>   __do_sys_creat fs/open.c:1121 [inline]
>   __se_sys_creat fs/open.c:1119 [inline]
>   __x64_sys_creat+0x61/0x80 fs/open.c:1119
>   do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x457569
> Code: fd b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7
> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff
> ff 0f 83 cb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007f234767cc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000055
> RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 0000000000457569
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000180
> RBP: 000000000072bf00 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007f234767d6d4
> R13: 00000000004bdb2f R14: 00000000004cc688 R15: 00000000ffffffff
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> syz-executor0(10448): getblk(): executed=9 bh_count=0 bh_state=0
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> syz-executor0(10448): getblk(): executed=9 bh_count=0 bh_state=0
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> syz-executor0(10448): getblk(): executed=9 bh_count=0 bh_state=0
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=8
> b_state=0x00000029, b_size=512
> device loop0 blocksize: 4096
> __find_get_block_slow() failed. block=1, b_blocknr=
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
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/000000000000f93b510578c046bc%40google.com.
> For more options, visit https://groups.google.com/d/optout.
