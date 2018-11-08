Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DCB3ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 589402077B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:48:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 589402077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbeKICY1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 21:24:27 -0500
Received: from mail-it1-f200.google.com ([209.85.166.200]:40903 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbeKICY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 21:24:26 -0500
Received: by mail-it1-f200.google.com with SMTP id y144-v6so1847616itc.5
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 08:48:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to:cc;
        bh=m6RNL8XXq7qDZOmMDnO4GwdPzC98k7SoLoP6Zz+uK3w=;
        b=aoSii+YLEglbnTMYvzyyK1W6i3S6hk/L4Jjv/FLBr9MhIa6t1a9jf5A1PNYWpO/RP+
         C++I5jB0kpGSJBgxeH+e1JSiwn5mGb2ZCayZNUksUyrpX2kDl1hgH5tZqTKro0EzDzid
         JBc1qwerHyB8qAUPMgr3nvMUUaFa2N0i6WwnFCRqdxE5cEieuwkMQRboF0mQVUO3Zfzn
         R2VIkWBugP6ii8NQXbO3uJhPZ/dXb0o195lMrLv1kZlSX7Hi6EBwmVoTUNdfr4O8DSCx
         UT/Lca74tI8g8ntRGP0UJXkLSifOd59ikhWLP0vGWzZnL9qWKy72jh+hPlbYXVkhXBwU
         QDOw==
X-Gm-Message-State: AGRZ1gJv1ihuI17puzlliKrf3gHWMS23vAdNIAzelR4uKsGkFoFifnCG
        KYXu3Ou9EL9QP9RIxTwsZyKJWoR/ywv5oxsCP9gkY9uNWUmV
X-Google-Smtp-Source: AJdET5capwC/ITKBO/74n5+35qXu8Z6Ps+mcdKXUyQKYgore8Okkfxh434yB0tZloFICLuzI9vJq7cWNuNOwydjA0UljrwHU+Nmi
MIME-Version: 1.0
X-Received: by 2002:a24:2793:: with SMTP id g141-v6mr1472610ita.39.1541695685980;
 Thu, 08 Nov 2018 08:48:05 -0800 (PST)
Date:   Thu, 08 Nov 2018 08:48:05 -0800
In-Reply-To: <CACT4Y+YTYwE2buUYADuhuqYHb1b68JYBbG8hejn0G=6xCGFg9A@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b6f7c3057a29ffb1@google.com>
Subject: Re: Re: KMSAN: uninit-value in vcs_read
From:   syzbot <syzbot+fed4435f163beccc67eb@syzkaller.appspotmail.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     dvyukov@google.com, glider@google.com, gregkh@linuxfoundation.org,
        jslaby@suse.com, kstewart@linuxfoundation.org,
        linux-kernel@vger.kernel.org, pombredanne@nexb.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, May 15, 2018 at 9:26 AM, syzbot
> <syzbot+fed4435f163beccc67eb@syzkaller.appspotmail.com> wrote:
>> Hello,

>> syzbot found the following crash on:

>> HEAD commit:    e2ab7e8abba4 kmsan: temporarily disable  
>> visitAsmInstructio..
>> git tree:       https://github.com/google/kmsan.git/master
>> console output: https://syzkaller.appspot.com/x/log.txt?x=158135db800000
>> kernel config:   
>> https://syzkaller.appspot.com/x/.config?x=5bf8b7964e37a698
>> dashboard link:  
>> https://syzkaller.appspot.com/bug?extid=fed4435f163beccc67eb
>> compiler:       clang version 7.0.0 (trunk 329391)
>> syzkaller  
>> repro:https://syzkaller.appspot.com/x/repro.syz?x=17a2f91b800000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17bd452b800000

>> IMPORTANT: if you fix the bug, please add the following tag to the  
>> commit:
>> Reported-by: syzbot+fed4435f163beccc67eb@syzkaller.appspotmail.com

> #syz dup: KMSAN: kernel-infoleak in vcs_read

Can't dup bug to a bug in different reporting (upstream->moderation).Please  
dup syzbot bugs only onto syzbot bugs for the same kernel/reporting.


>> ==================================================================
>> BUG: KMSAN: uninit-value in copy_to_user include/linux/uaccess.h:184
>> [inline]
>> BUG: KMSAN: uninit-value in vcs_read+0x18ba/0x1cc0
>> drivers/tty/vt/vc_screen.c:352
>> CPU: 1 PID: 3501 Comm: syzkaller315412 Not tainted 4.16.0+ #82
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
>> Google 01/01/2011
>> Call Trace:
>>   __dump_stack lib/dump_stack.c:17 [inline]
>>   dump_stack+0x185/0x1d0 lib/dump_stack.c:53
>>   kmsan_report+0x142/0x240 mm/kmsan/kmsan.c:1067
>>   kmsan_internal_check_memory+0x125/0x1d0 mm/kmsan/kmsan.c:1157
>>   kmsan_copy_to_user+0x69/0x160 mm/kmsan/kmsan.c:1199
>>   copy_to_user include/linux/uaccess.h:184 [inline]
>>   vcs_read+0x18ba/0x1cc0 drivers/tty/vt/vc_screen.c:352
>>   __vfs_read+0x19f/0x8e0 fs/read_write.c:411
>>   vfs_read+0x36c/0x6c0 fs/read_write.c:447
>>   SYSC_pread64+0x275/0x310 fs/read_write.c:611
>>   SyS_pread64+0x65/0x90 fs/read_write.c:598
>>   do_syscall_64+0x309/0x430 arch/x86/entry/common.c:287
>>   entry_SYSCALL_64_after_hwframe+0x3d/0xa2
>> RIP: 0033:0x443d39
>> RSP: 002b:00007ffcbd3c35f8 EFLAGS: 00000213 ORIG_RAX: 0000000000000011
>> RAX: ffffffffffffffda RBX: 00000000004002e0 RCX: 0000000000443d39
>> RDX: 0000000000000083 RSI: 0000000020000140 RDI: 0000000000000003
>> RBP: 00000000006ce018 R08: 00000000004002e0 R09: 00000000004002e0
>> R10: 0000000000000000 R11: 0000000000000213 R12: 00000000004019e0
>> R13: 0000000000401a70 R14: 0000000000000000 R15: 0000000000000000

>> Uninit was stored to memory at:
>>   kmsan_save_stack_with_flags mm/kmsan/kmsan.c:278 [inline]
>>   kmsan_save_stack mm/kmsan/kmsan.c:293 [inline]
>>   kmsan_internal_chain_origin+0x12b/0x210 mm/kmsan/kmsan.c:684
>>   __msan_chain_origin+0x69/0xc0 mm/kmsan/kmsan_instr.c:521
>>   vcs_read+0xd01/0x1cc0 drivers/tty/vt/vc_screen.c:274
>>   __vfs_read+0x19f/0x8e0 fs/read_write.c:411
>>   vfs_read+0x36c/0x6c0 fs/read_write.c:447
>>   SYSC_pread64+0x275/0x310 fs/read_write.c:611
>>   SyS_pread64+0x65/0x90 fs/read_write.c:598
>>   do_syscall_64+0x309/0x430 arch/x86/entry/common.c:287
>>   entry_SYSCALL_64_after_hwframe+0x3d/0xa2
>> Uninit was created at:
>>   kmsan_save_stack_with_flags mm/kmsan/kmsan.c:278 [inline]
>>   kmsan_internal_poison_shadow+0xb8/0x1b0 mm/kmsan/kmsan.c:188
>>   kmsan_kmalloc+0x94/0x100 mm/kmsan/kmsan.c:314
>>   __kmalloc+0x23c/0x350 mm/slub.c:3791
>>   kmalloc include/linux/slab.h:517 [inline]
>>   vc_allocate+0x438/0x800 drivers/tty/vt/vt.c:787
>>   con_install+0x8c/0x640 drivers/tty/vt/vt.c:2876
>>   tty_driver_install_tty drivers/tty/tty_io.c:1224 [inline]
>>   tty_init_dev+0x1b0/0x1020 drivers/tty/tty_io.c:1324
>>   tty_open_by_driver drivers/tty/tty_io.c:1959 [inline]
>>   tty_open+0x15e9/0x2ea0 drivers/tty/tty_io.c:2007
>>   chrdev_open+0xc20/0xd90 fs/char_dev.c:417
>>   do_dentry_open+0xcc6/0x1430 fs/open.c:752
>>   vfs_open+0x1b7/0x2e0 fs/open.c:866
>>   do_last fs/namei.c:3379 [inline]
>>   path_openat+0x460a/0x6520 fs/namei.c:3520
>>   do_filp_open+0x261/0x640 fs/namei.c:3554
>>   do_sys_open+0x624/0x960 fs/open.c:1059
>>   SYSC_open+0xab/0xc0 fs/open.c:1077
>>   SyS_open+0x54/0x80 fs/open.c:1072
>>   do_syscall_64+0x309/0x430 arch/x86/entry/common.c:287
>>   entry_SYSCALL_64_after_hwframe+0x3d/0xa2

>> Bytes 0-79 of 131 are uninitialized
>> ==================================================================


>> ---
>> This bug is generated by a bot. It may contain errors.
>> See https://goo.gl/tpsmEJ for more information about syzbot.
>> syzbot engineers can be reached at syzkaller@googlegroups.com.

>> syzbot will keep track of this bug report. See:
>> https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with
>> syzbot.
>> syzbot can test patches for this bug, for details see:
>> https://goo.gl/tpsmEJ#testing-patches

>> --
>> You received this message because you are subscribed to the Google Groups
>> "syzkaller-bugs" group.
>> To unsubscribe from this group and stop receiving emails from it, send an
>> email to syzkaller-bugs+unsubscribe@googlegroups.com.
>> To view this discussion on the web visit
>> https://groups.google.com/d/msgid/syzkaller-bugs/000000000000da269e056c410efd%40google.com.
>> For more options, visit https://groups.google.com/d/optout.
