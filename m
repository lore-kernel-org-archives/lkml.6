Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B0D9C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 03:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48CE72086C
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 03:43:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbfAMDnF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 22:43:05 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:50084 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbfAMDnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 22:43:05 -0500
Received: by mail-io1-f71.google.com with SMTP id c4so16906638ioh.16
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jan 2019 19:43:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=z6cEJsiELFw/+z00F7p6l5AyBLc0P/kEisQiUaVstkE=;
        b=n2bpLwREb5veGqXivQM/chKUd7hhxdRe21Qbnq3KaJesY6Vwo0EElImMnaf6p6NkUX
         SmcONdNWtP0y9+fdrMN8HsfwKOyqeflcpIMvL8HmXABPbq4Voip8T1Hr1yq6QvxvozV3
         IcmDavVR3zVHVquysvbHgFCkILjGK1PYncyVi+ntsqWvHHzdolXP4vpTl3uNOUQK0ZUG
         KNHNkxlxET3QUGi/mxG3z3BGQohWxZhOR14bhA+z1Dd61YFMspy0PA5M6rpJBK7yHwLK
         tC35qmGdxqYZ4VarfTqs3EI9HqUs9+A3ApMNF4aKwXWQhV/vYlC6JdRVAGTfeOs9Q7v9
         brmQ==
X-Gm-Message-State: AJcUukeV2UNEeWSClomi7JKHgQtyctq3AGOW+BdBkO3EnxtEGdYIZBDu
        Wxf6kRP/ZNuMUhCyd5jgx88uwBeDF3pspNo798H/GuaAhxwR
X-Google-Smtp-Source: ALg8bN60AsZEvihc9AVoVBzqqXcAXp3EFTKnSG9jnYrb6Xv7sysxMHhsns6Jl4J0BG7Ta4lLepxIJG3EEfuxp+EeRVt2tg55IT9X
MIME-Version: 1.0
X-Received: by 2002:a24:a94:: with SMTP id 142mr5295600itw.15.1547350983887;
 Sat, 12 Jan 2019 19:43:03 -0800 (PST)
Date:   Sat, 12 Jan 2019 19:43:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bcd434057f4eb905@google.com>
Subject: WARNING in tty_set_termios
From:   syzbot <syzbot+a950165cbb86bdd023a4@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    66c56cfa64d9 Merge tag 'remove-dma_zalloc_coherent-5.0' of..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=167fd6d8c00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b05cfdb4ee8ab9b2
dashboard link: https://syzkaller.appspot.com/bug?extid=a950165cbb86bdd023a4
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=121cee07400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16fdaed8c00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+a950165cbb86bdd023a4@syzkaller.appspotmail.com

WARNING: CPU: 0 PID: 1171 at drivers/tty/tty_ioctl.c:319  
tty_set_termios+0x93a/0xac0 drivers/tty/tty_ioctl.c:319
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 1171 Comm: kworker/u5:0 Not tainted 5.0.0-rc1+ #22
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: hci0 hci_power_on
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1db/0x2d0 lib/dump_stack.c:113
  panic+0x2cb/0x65c kernel/panic.c:214
  __warn.cold+0x20/0x48 kernel/panic.c:571
  report_bug+0x263/0x2b0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:178 [inline]
  fixup_bug arch/x86/kernel/traps.c:173 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:271
  do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:290
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:973
RIP: 0010:tty_set_termios+0x93a/0xac0 drivers/tty/tty_ioctl.c:319
Code: 0f b6 14 02 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 ec 00  
00 00 41 89 9f d0 03 00 00 e9 f6 fd ff ff e8 d6 18 a8 fd <0f> 0b e9 a9 f7  
ff ff e8 4a 04 ec fd e9 48 f9 ff ff 4c 89 ef e8 9d
RSP: 0018:ffff8880a74f7600 EFLAGS: 00010293
RAX: ffff8880a74d4300 RBX: ffff8880a74f76c0 RCX: ffffffff83d9d62d
RDX: 0000000000000000 RSI: ffffffff83d9de8a RDI: 0000000000000005
RBP: ffff8880a74f76e8 R08: ffff8880a74d4300 R09: fffffbfff181d7b5
R10: fffffbfff181d7b4 R11: 0000000000000003 R12: ffff8880a74f7728
R13: 0000000000010004 R14: 000000000001c200 R15: ffff88808e3e60c0
  hci_uart_set_baudrate+0x1cc/0x250 drivers/bluetooth/hci_ldisc.c:378
  hci_uart_setup+0xa2/0x490 drivers/bluetooth/hci_ldisc.c:401
  hci_dev_do_open+0x6b1/0x1920 net/bluetooth/hci_core.c:1423
  hci_power_on+0x10d/0x880 net/bluetooth/hci_core.c:2130
  process_one_work+0xd0c/0x1ce0 kernel/workqueue.c:2153
  worker_thread+0x143/0x14a0 kernel/workqueue.c:2296
  kthread+0x357/0x430 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
