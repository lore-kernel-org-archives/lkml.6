Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NORMAL_HTTP_TO_IP,SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D95ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 11:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2723E206B7
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 11:45:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DN8slqHi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2723E206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731110AbeGRMXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 08:23:14 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:45352 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbeGRMXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 08:23:14 -0400
Received: by mail-pl0-f65.google.com with SMTP id 94-v6so1920682ple.12
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 04:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/K8l9IeCdkC8SQ35FvjYAVt6jJuQ8Q7iIfuEks2fRM4=;
        b=DN8slqHipMCWeype9bN/FBXoJgXOz8U98OVaX4LLdahviXE5aKLMLCI02HhXbGslIi
         98Bo2BP+8wF41/PgVQSqwjUUpKMZOMpVAJUuV8RSSwhR95KnG1Ut31aulQM2KRnEFB3L
         kY4bvvBT9PowL/yvmFsFiOKJd18AIwsueNPr+fdsU5tS+nX8dg7sfetFeQkvOnIFCfBD
         mzzPypt0v+9D8RyfrWAjOQTO7gv3Hi4uDK9nva6x7X73LkvlTN5ifj7WDuLTfTXeBc8j
         DjpWOvQ16fiEZnUL8UqVDjHqTQ06aooogYBmCfxPNVe4CH2IWLKQfln4lHWz24nG5J/n
         ZsuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/K8l9IeCdkC8SQ35FvjYAVt6jJuQ8Q7iIfuEks2fRM4=;
        b=RMeIPDUlrBIhirQziPQASwI+DIGmkA1GIcOOuUCcXuA8zv6Lz3QIIX6nvhrpmYoJOj
         a7KHKb0rikJI1Gm/fNmty9r2cGnD2n3ulH1SOMo1frqoOtzpA/Ox+Xqv7Vl9VGjA/D8L
         1Qnxlp/b0GcIlmOUWwEBjIJxCctHSVGVImiWpmGD8MjDgIbRaQtB8PlcZ0vIXZGXxP0F
         OweTLCcebLqvU6xGSfQx9JhsbWmoFncABOnUFbKEPZT7AeIqrdpHgHDmuUhTPE5O8OWa
         RssrQxyICZWaZ9DzDUYqTldY8Mqy3sahvMaCV4vjkyqFxi8IKyH36ICOC9XCBywmkCRc
         LJTA==
X-Gm-Message-State: AOUpUlEghY52NuSU3rbyHxM+WM+6mm+PwZKoFKW1t+eWPeTfik0/pY2v
        ndvCdXG+uzHZr7vPPpBKEpBJfRgfDsXB87UWaQ4uHA==
X-Google-Smtp-Source: AAOMgpecE2+P759oVZw36yCFrf9TZOtxzIkfcE79JxDP4wljpDFgFMG1t2HtQ4GZ1jZZ+mFC/JluIWkC8G/2p2Fn05E=
X-Received: by 2002:a17:902:8c88:: with SMTP id t8-v6mr5582262plo.117.1531914342751;
 Wed, 18 Jul 2018 04:45:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:ac14:0:0:0:0 with HTTP; Wed, 18 Jul 2018 04:45:22
 -0700 (PDT)
In-Reply-To: <CACT4Y+YJmoeBtdg6KB38pOHWiuFLGxgbkD5v4Oex2rbuxN=YWQ@mail.gmail.com>
References: <000000000000cec1940570940acf@google.com> <CACT4Y+YJmoeBtdg6KB38pOHWiuFLGxgbkD5v4Oex2rbuxN=YWQ@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 18 Jul 2018 13:45:22 +0200
Message-ID: <CACT4Y+aw-JFtNNhsvGo3eMdhDS-oHE2=HrZscEhkkf9addNCpw@mail.gmail.com>
Subject: Re: INFO: task hung in vfs_removexattr
To:     syzbot <syzbot+9d0373cdac2be4979750@syzkaller.appspotmail.com>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Ron Minnich <rminnich@sandia.gov>,
        Latchesar Ionkov <lucho@ionkov.net>,
        David Miller <davem@davemloft.net>,
        v9fs-developer@lists.sourceforge.net,
        netdev <netdev@vger.kernel.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 9, 2018 at 7:08 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
> On Mon, Jul 9, 2018 at 7:07 PM, syzbot
> <syzbot+9d0373cdac2be4979750@syzkaller.appspotmail.com> wrote:
>> Hello,
>>
>> syzbot found the following crash on:
>>
>> HEAD commit:    1e4b044d2251 Linux 4.18-rc4
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=14dc81b2400000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=25856fac4e580aa7
>> dashboard link: https://syzkaller.appspot.com/bug?extid=9d0373cdac2be4979750
>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>>
>> Unfortunately, I don't have any reproducer for this crash yet.
>>
>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> Reported-by: syzbot+9d0373cdac2be4979750@syzkaller.appspotmail.com
>
> This looks suspiciously similar to "INFO: task hung in vfs_setxattr":
> https://syzkaller.appspot.com/bug?id=719b006d5ff2c98e95b3db1d442771de9fcbfb93
>
> Also caused by 9p program:
>
> 14:02:00 executing program 5:
> pipe2$9p(&(0x7f0000000100)={<r0=>0xffffffffffffffff,
> <r1=>0xffffffffffffffff}, 0x0)
> write$P9_RUNLINKAT(r1, &(0x7f0000000040)={0xffffffffffffffca, 0x4d}, 0x7)
> mkdir(&(0x7f0000000140)='./file0\x00', 0x0)
> mount$9p_fd(0x0, &(0x7f00000000c0)='./file0\x00',
> &(0x7f0000000340)='9p\x00', 0x0, &(0x7f00000001c0)={'trans=fd,',
> {'rfdno', 0x3d, r0}, 0x2c, {'wfdno', 0x3d, r1}, 0x2c})
> write$P9_RREADDIR(r1, &(0x7f0000000480)={0x2a, 0x29, 0x1, {0x0, [{{},
> 0x0, 0x0, 0x7, './file0'}]}}, 0x2a)
> write$P9_RGETATTR(r1, &(0x7f0000000200)={0xa0, 0x19, 0x1}, 0xa0)
> write$P9_RREADDIR(r1, &(0x7f00000004c0)={0x313, 0x29, 0x1, {0x0,
> [{{0x2, 0x3, 0x7}, 0x10001, 0x3, 0x7, './file0'}, {{0x1d, 0x4, 0x5},
> 0x100000000, 0x8, 0x7, './file1'}, {{0x4, 0x2, 0x4}, 0x3, 0x6, 0x7,
> './file0'}, {{0x120, 0x2, 0x2}, 0x979, 0x4, 0x7, './file0'},
> {{0x4f5f4daf2e09cfcf, 0x4, 0x6}, 0x1000, 0x1, 0x7, './file0'}, {{0x82,
> 0x1, 0x2}, 0x5, 0x2, 0x7, './file0'}, {{0x40, 0x1, 0x7}, 0x2, 0x6,
> 0x7, './file0'}, {{0x40, 0x1, 0x2}, 0x7fffffff, 0x983d, 0x7,
> './file0'}, {{0x40, 0x3, 0x4}, 0x2, 0x5, 0x7, './file0'}, {{0x60, 0x1,
> 0x3}, 0x7ff, 0x7, 0x7, './file0'}]}}, 0x141)
> r2 = openat$pfkey(0xffffffffffffff9c,
> &(0x7f0000000300)='/proc/self/net/pfkey\x00', 0x1, 0x0)
> bind(r2, &(0x7f0000000780)=@ethernet={0x306, @broadcast=[0xff, 0xff,
> 0xff, 0xff, 0xff, 0xff]}, 0x80)
> write$P9_RWSTAT(r1, &(0x7f00000002c0)={0x7, 0x7f, 0x1}, 0x7)
> mount$9p_fd(0x0, &(0x7f0000000000)='./file0\x00',
> &(0x7f0000000900)='9p\x00', 0x0, &(0x7f0000000840)={'trans=fd,',
> {'rfdno', 0x3d, r0}, 0x2c, {'wfdno', 0x3d, r1}, 0x2c,
> {[{@access_uid={'access', 0x3d}, 0x2c}]}})
> removexattr(&(0x7f0000000380)='./file0\x00',
> &(0x7f0000000400)=@known='system.posix_acl_default\x00')
> r3 = syz_open_dev$midi(&(0x7f0000000080)='/dev/midi#\x00', 0x1ff, 0x400)
> r4 = fcntl$getown(r1, 0x9)
> accept4$alg(r2, 0x0, 0x0, 0x0)
> ioctl$SNDRV_CTL_IOCTL_ELEM_INFO(r3, 0xc1105511,
> &(0x7f0000000640)={{0x4, 0x1, 0x81, 0x5b94, '\x00', 0x3b2}, 0x2, 0x1,
> 0x90, r4, 0x3, 0x8, 'syz0\x00', &(0x7f0000000180)=['\x00', '+@,\x00',
> ')\x00'], 0x7, [], [0x6, 0x10000, 0x2, 0x8]})


#syz dup: INFO: task hung in flush_work

>> netlink: 16 bytes leftover after parsing attributes in process
>> `syz-executor0'.
>> netlink: 16 bytes leftover after parsing attributes in process
>> `syz-executor0'.
>> INFO: task syz-executor5:14548 blocked for more than 140 seconds.
>>       Not tainted 4.18.0-rc4+ #138
>> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>> syz-executor5   D24752 14548   4547 0x00000004
>> Call Trace:
>>  context_switch kernel/sched/core.c:2853 [inline]
>>  __schedule+0x87c/0x1ed0 kernel/sched/core.c:3501
>>  schedule+0xfb/0x450 kernel/sched/core.c:3545
>>  __rwsem_down_write_failed_common+0x95d/0x1630
>> kernel/locking/rwsem-xadd.c:566
>>  rwsem_down_write_failed+0xe/0x10 kernel/locking/rwsem-xadd.c:595
>>  call_rwsem_down_write_failed+0x17/0x30 arch/x86/lib/rwsem.S:117
>>  __down_write arch/x86/include/asm/rwsem.h:142 [inline]
>>  down_write+0xaa/0x130 kernel/locking/rwsem.c:72
>>  inode_lock include/linux/fs.h:715 [inline]
>>  vfs_removexattr+0x82/0x1c0 fs/xattr.c:391
>>  removexattr+0xd3/0x130 fs/xattr.c:691
>>  path_removexattr+0x1b9/0x210 fs/xattr.c:705
>>  __do_sys_removexattr fs/xattr.c:719 [inline]
>>  __se_sys_removexattr fs/xattr.c:716 [inline]
>>  __x64_sys_removexattr+0x59/0x80 fs/xattr.c:716
>>  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>> RIP: 0033:0x455e29
>> Code: cc 64 48 8b 0c 25 f8 ff ff ff 48 3b 61 10 0f 86 ab 04 00 00 48 83 ec
>> 58 48 89 6c 24 50 48 8d 6c 24 50 48 8b 44 24 60 c6 00 00 <48> 8b 4c 24 68 48
>> 89 ca 48 89 50 08 48 8b 59 20 48 01 da 31 db 31
>> RSP: 002b:00007f4465180c68 EFLAGS: 00000246 ORIG_RAX: 00000000000000c5
>> RAX: ffffffffffffffda RBX: 00007f44651816d4 RCX: 0000000000455e29
>> RDX: 0000000000000000 RSI: 0000000020000400 RDI: 0000000020000380
>> RBP: 000000000072bf48 R08: 0000000000000000 R09: 0000000000000000
>> R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
>> R13: 00000000004bbfeb R14: 00000000004d1108 R15: 0000000000000001
>>
>> Showing all locks held in the system:
>> 1 lock held by khungtaskd/901:
>>  #0: 00000000ebf24c36 (rcu_read_lock){....}, at:
>> debug_show_all_locks+0xd0/0x428 kernel/locking/lockdep.c:4461
>> 1 lock held by rsyslogd/4405:
>> 2 locks held by getty/4495:
>>  #0: 00000000692a9d2f (&tty->ldisc_sem){++++}, at: ldsem_down_read+0x37/0x40
>> drivers/tty/tty_ldsem.c:365
>>  #1: 0000000072fe5412 (&ldata->atomic_read_lock){+.+.}, at:
>> n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
>> 2 locks held by getty/4496:
>>  #0: 000000002b623882 (&tty->ldisc_sem){++++}, at: ldsem_down_read+0x37/0x40
>> drivers/tty/tty_ldsem.c:365
>>  #1: 0000000056c15f7c (&ldata->atomic_read_lock){+.+.}, at:
>> n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
>> 2 locks held by getty/4497:
>>  #0: 000000002c1f858b (&tty->ldisc_sem){++++}, at: ldsem_down_read+0x37/0x40
>> drivers/tty/tty_ldsem.c:365
>>  #1: 0000000048aba06b (&ldata->atomic_read_lock){+.+.}, at:
>> n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
>> 2 locks held by getty/4498:
>>  #0: 00000000da02f89a (&tty->ldisc_sem){++++}, at: ldsem_down_read+0x37/0x40
>> drivers/tty/tty_ldsem.c:365
>>  #1: 000000004a06c40f (&ldata->atomic_read_lock){+.+.}, at:
>> n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
>> 2 locks held by getty/4499:
>>  #0: 0000000017508207 (&tty->ldisc_sem){++++}, at: ldsem_down_read+0x37/0x40
>> drivers/tty/tty_ldsem.c:365
>>  #1: 00000000a4b24877 (&ldata->atomic_read_lock){+.+.}, at:
>> n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
>> 2 locks held by getty/4500:
>>  #0: 0000000079a247d3 (&tty->ldisc_sem){++++}, at: ldsem_down_read+0x37/0x40
>> drivers/tty/tty_ldsem.c:365
>>  #1: 000000009bcfd45d (&ldata->atomic_read_lock){+.+.}, at:
>> n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
>> 2 locks held by getty/4501:
>>  #0: 00000000e73958a9 (&tty->ldisc_sem){++++}, at: ldsem_down_read+0x37/0x40
>> drivers/tty/tty_ldsem.c:365
>>  #1: 000000007d96a629 (&ldata->atomic_read_lock){+.+.}, at:
>> n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
>> 2 locks held by syz-executor5/14500:
>>  #0: 00000000ba1ef7f9 (sb_writers#19){.+.+}, at: sb_start_write
>> include/linux/fs.h:1554 [inline]
>>  #0: 00000000ba1ef7f9 (sb_writers#19){.+.+}, at: mnt_want_write+0x3f/0xc0
>> fs/namespace.c:386
>>  #1: 00000000e4cbde96 (&sb->s_type->i_mutex_key#25){++++}, at: inode_lock
>> include/linux/fs.h:715 [inline]
>>  #1: 00000000e4cbde96 (&sb->s_type->i_mutex_key#25){++++}, at:
>> vfs_removexattr+0x82/0x1c0 fs/xattr.c:391
>> 2 locks held by syz-executor5/14548:
>>  #0: 00000000ba1ef7f9 (sb_writers#19){.+.+}, at: sb_start_write
>> include/linux/fs.h:1554 [inline]
>>  #0: 00000000ba1ef7f9 (sb_writers#19){.+.+}, at: mnt_want_write+0x3f/0xc0
>> fs/namespace.c:386
>>  #1: 00000000e4cbde96 (&sb->s_type->i_mutex_key#25){++++}, at: inode_lock
>> include/linux/fs.h:715 [inline]
>>  #1: 00000000e4cbde96 (&sb->s_type->i_mutex_key#25){++++}, at:
>> vfs_removexattr+0x82/0x1c0 fs/xattr.c:391
>>
>> =============================================
>>
>> NMI backtrace for cpu 0
>> CPU: 0 PID: 901 Comm: khungtaskd Not tainted 4.18.0-rc4+ #138
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
>> Google 01/01/2011
>> Call Trace:
>>  __dump_stack lib/dump_stack.c:77 [inline]
>>  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
>>  nmi_cpu_backtrace.cold.4+0x19/0xce lib/nmi_backtrace.c:103
>>  nmi_trigger_cpumask_backtrace+0x151/0x192 lib/nmi_backtrace.c:62
>>  arch_trigger_cpumask_backtrace+0x14/0x20 arch/x86/kernel/apic/hw_nmi.c:38
>>  trigger_all_cpu_backtrace include/linux/nmi.h:138 [inline]
>>  check_hung_uninterruptible_tasks kernel/hung_task.c:196 [inline]
>>  watchdog+0x9c4/0xf80 kernel/hung_task.c:252
>>  kthread+0x345/0x410 kernel/kthread.c:246
>>  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412
>> Sending NMI from CPU 0 to CPUs 1:
>> NMI backtrace for cpu 1 skipped: idling at native_safe_halt+0x6/0x10
>> arch/x86/include/asm/irqflags.h:54
>>
>>
>> ---
>> This bug is generated by a bot. It may contain errors.
>> See https://goo.gl/tpsmEJ for more information about syzbot.
>> syzbot engineers can be reached at syzkaller@googlegroups.com.
>>
>> syzbot will keep track of this bug report. See:
>> https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with
>> syzbot.
>>
>> --
>> You received this message because you are subscribed to the Google Groups
>> "syzkaller-bugs" group.
>> To unsubscribe from this group and stop receiving emails from it, send an
>> email to syzkaller-bugs+unsubscribe@googlegroups.com.
>> To view this discussion on the web visit
>> https://groups.google.com/d/msgid/syzkaller-bugs/000000000000cec1940570940acf%40google.com.
>> For more options, visit https://groups.google.com/d/optout.
