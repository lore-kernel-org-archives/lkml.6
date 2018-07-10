Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E410C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 08:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D78282089D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 08:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CY2p4ytL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D78282089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933324AbeGJIJz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 04:09:55 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36529 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751515AbeGJIJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 04:09:51 -0400
Received: by mail-pg1-f194.google.com with SMTP id m19-v6so1847262pgv.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 01:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=OPZ8D7Z0rE8UPb8ZHFTs6xXqesYtcjp0ILaCERU7JHU=;
        b=CY2p4ytLgmsaFgpc/2MjQfN30oST9iZg2Pz4HCC0MjlD+BINB3xDwSxDE/8N3ZOfKK
         msmOka7ULQ7gxSmz17p2UUNRFudRuju5+OXuXNYdedRQrT8LsCRMXLbg1UfgoZ5viglr
         wEy2ZpIxt1z8jOkE24RUaznoujUCHOwcuinq3BMZwMkfcA/dW2rcdi5WC9ccTAb1b7X1
         UFMztKvpoh581VBLNPHzbLgYLUN1220usYQKxUR26oT4l7nSEEA7DigRBI6fy8GnMpVc
         RCaHQ2hEGm3wHCMR8t6DtIF/wb41FeJqo6pAJlkuDe0oF++w9C3WcgfeeUhRBVmmjSc7
         LANQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=OPZ8D7Z0rE8UPb8ZHFTs6xXqesYtcjp0ILaCERU7JHU=;
        b=pqmILrsgB+LBHROFvnk9u8MbwrzXjmU5An7DO4WeE2W2X35KsfOZsd+gczJvi5y2S1
         U4Aqud4LyoHyOVirYJtjaXDEGVXOuVFOZNeDnfZAyfqOLxWG/hGVo8p0cyWqa6naMeI9
         T76ny5JkPbEaIS0IaoxK38k+/CAOIawPDpOEagPO8v6/+4Qz2mP06CbIyCpQUSxfqoJc
         WCVpGr0U3RwAypVRZ0gEqIECLFXth29A4ywzEL0fqsoaVAVf/SGUQlvEODqVr60h2oEB
         e3S6Ttu5EVc8+LoKIzcjqJrLcOxEazBZtAvsxyANbV0VoeHowDOd1Fw6lWjn+MZLkSOf
         Q9Gg==
X-Gm-Message-State: APt69E1avh88cpOJH6ikOBA53fB55m/kskLbhGQAjwMT7iMBZJrjGZre
        MOFkP3QPlf9++n6p/BGz29DRf5Ots9slTeb/MLoiWQ==
X-Google-Smtp-Source: AAOMgpc3A8ZPkwwDrEPyf4P7Vq5EOREb4JKGInH1TzUo1RFteVKOtPUxK7nDrrWoUhY373OZl3MJvE8Xbq5xjWDFmwU=
X-Received: by 2002:a62:3184:: with SMTP id x126-v6mr6503924pfx.49.1531210190953;
 Tue, 10 Jul 2018 01:09:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:950a:0:0:0:0 with HTTP; Tue, 10 Jul 2018 01:09:30
 -0700 (PDT)
In-Reply-To: <0000000000000bafc80570a0a1db@google.com>
References: <0000000000000bafc80570a0a1db@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 10 Jul 2018 10:09:30 +0200
Message-ID: <CACT4Y+aaKr4z1eTJ0ROfozcr2yt7_PfS3+R6S0t75WY2Ejnh2g@mail.gmail.com>
Subject: Re: INFO: task hung in utimes_common
To:     syzbot <syzbot+3a0570f93c0d6ca388f5@syzkaller.appspotmail.com>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Ron Minnich <rminnich@sandia.gov>,
        Latchesar Ionkov <lucho@ionkov.net>,
        v9fs-developer@lists.sourceforge.net
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 10:08 AM, syzbot
<syzbot+3a0570f93c0d6ca388f5@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    d00d6d9a339d Add linux-next specific files for 20180709
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=17fdd90c400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=94fe2b586beccacd
> dashboard link: https://syzkaller.appspot.com/bug?extid=3a0570f93c0d6ca388f5
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>
> Unfortunately, I don't have any reproducer for this crash yet.
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+3a0570f93c0d6ca388f5@syzkaller.appspotmail.com


Look similar to the other hangs in 9p, this time caused by the
following program:

21:30:55 executing program 0:
pipe2$9p(&(0x7f0000000100)={<r0=>0xffffffffffffffff,
<r1=>0xffffffffffffffff}, 0x0)
write$P9_RUNLINKAT(r1, &(0x7f0000000040)={0xffffffffffffffca, 0x4d}, 0x7)
mkdir(&(0x7f0000000300)='./file0\x00', 0x0)
mount$9p_fd(0x0, &(0x7f00000000c0)='./file0\x00',
&(0x7f0000000340)='9p\x00', 0x0, &(0x7f00000001c0)={'trans=fd,',
{'rfdno', 0x3d, r0}, 0x2c, {'wfdno', 0x3d, r1}, 0x2c})
write$P9_RREADDIR(r1, &(0x7f0000000480)={0x2a, 0x29, 0x1, {0x0, [{{},
0x0, 0x0, 0x7, './file0'}]}}, 0x2a)
write$P9_RGETATTR(r1, &(0x7f0000000200)={0xa0, 0x19, 0x1}, 0xa0)
write$P9_RWALK(r1, &(0x7f0000000500)=ANY=[@ANYBLOB="090100006f01000000"], 0x9)
mount$9p_fd(0x0, &(0x7f0000000080)='./file0\x00',
&(0x7f0000000900)='9p\x00', 0x0, &(0x7f0000000840)={'trans=fd,',
{'rfdno', 0x3d, r0}, 0x2c, {'wfdno', 0x3d, r1}, 0x2c,
{[{@access_uid={'access', 0x3d}, 0x2c}]}})
r2 = socket$inet6(0xa, 0x1000000000002, 0x0)
ioctl(r2, 0x8912, &(0x7f0000000280)="025cc83d6d345f8f762070")
utimes(&(0x7f0000000180)='./file0\x00', &(0x7f0000000380))


> 9pnet_virtio: no channels available for device (null)
> Unknown ioctl 44801
> 9pnet_virtio: no channels available for device (null)
> 9pnet: Insufficient options for proto=fd
> 9pnet: Insufficient options for proto=fd
> INFO: task syz-executor0:12044 blocked for more than 140 seconds.
>       Not tainted 4.18.0-rc3-next-20180709+ #2
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> syz-executor0   D25408 12044   4539 0x00000004
> Call Trace:
>  context_switch kernel/sched/core.c:2853 [inline]
>  __schedule+0x87c/0x1ed0 kernel/sched/core.c:3501
>  schedule+0xfb/0x450 kernel/sched/core.c:3545
>  __rwsem_down_write_failed_common+0x95d/0x1630
> kernel/locking/rwsem-xadd.c:566
>  rwsem_down_write_failed+0xe/0x10 kernel/locking/rwsem-xadd.c:595
>  call_rwsem_down_write_failed+0x17/0x30 arch/x86/lib/rwsem.S:117
>  __down_write arch/x86/include/asm/rwsem.h:142 [inline]
>  down_write+0xaa/0x130 kernel/locking/rwsem.c:72
>  inode_lock include/linux/fs.h:748 [inline]
>  utimes_common.isra.1+0x45c/0x8e0 fs/utimes.c:90
>  do_utimes+0x1f7/0x380 fs/utimes.c:156
>  do_futimesat+0x249/0x350 fs/utimes.c:212
>  __do_sys_utimes fs/utimes.c:225 [inline]
>  __se_sys_utimes fs/utimes.c:222 [inline]
>  __x64_sys_utimes+0x59/0x80 fs/utimes.c:222
>  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x455e29
> Code: cc 64 48 8b 0c 25 f8 ff ff ff 48 3b 61 10 0f 86 ab 04 00 00 48 83 ec
> 58 48 89 6c 24 50 48 8d 6c 24 50 48 8b 44 24 60 c6 00 00 <48> 8b 4c 24 68 48
> 89 ca 48 89 50 08 48 8b 59 20 48 01 da 31 db 31
> RSP: 002b:00007fac7c8b4c68 EFLAGS: 00000246 ORIG_RAX: 00000000000000eb
> RAX: ffffffffffffffda RBX: 00007fac7c8b56d4 RCX: 0000000000455e29
> RDX: 0000000000000000 RSI: 0000000020000380 RDI: 0000000020000180
> RBP: 000000000072bff0 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
> R13: 00000000004c2af0 R14: 00000000004d4600 R15: 0000000000000002
> INFO: lockdep is turned off.
> NMI backtrace for cpu 1
> CPU: 1 PID: 898 Comm: khungtaskd Not tainted 4.18.0-rc3-next-20180709+ #2
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
>  nmi_cpu_backtrace.cold.5+0x19/0xce lib/nmi_backtrace.c:103
>  nmi_trigger_cpumask_backtrace+0x151/0x192 lib/nmi_backtrace.c:62
>  arch_trigger_cpumask_backtrace+0x14/0x20 arch/x86/kernel/apic/hw_nmi.c:38
>  trigger_all_cpu_backtrace include/linux/nmi.h:143 [inline]
>  check_hung_uninterruptible_tasks kernel/hung_task.c:204 [inline]
>  watchdog+0xb39/0x10b0 kernel/hung_task.c:265
>  kthread+0x345/0x410 kernel/kthread.c:246
>  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:415
> Sending NMI from CPU 1 to CPUs 0:
> NMI backtrace for cpu 0 skipped: idling at native_safe_halt+0x6/0x10
> arch/x86/include/asm/irqflags.h:54
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
> https://groups.google.com/d/msgid/syzkaller-bugs/0000000000000bafc80570a0a1db%40google.com.
> For more options, visit https://groups.google.com/d/optout.
