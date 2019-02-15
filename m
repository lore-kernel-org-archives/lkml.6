Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61238C10F02
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33EC221924
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:01:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730041AbfBORBF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 12:01:05 -0500
Received: from mail-it1-f197.google.com ([209.85.166.197]:42429 "EHLO
        mail-it1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbfBORBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 12:01:04 -0500
Received: by mail-it1-f197.google.com with SMTP id f137so16791456ita.7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 09:01:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=KteYzMvWyG9TmkbFHnYckwr9o0LX8eTxZPUT2QFGTtU=;
        b=Rb3l2A1vFddLjmxa2IaiqW1XV3O2fJixzd1TjImD6V6Gi2rOwe5y+DfooOaFBks2+F
         0GmIXtef8mhgxElJwTInvS38xgyH3dqM0PgrwkliO/RktsTzYcPFblbMdskExz+oBuye
         tgdWz0LiOg79pjYjqyAPZT/dNSCLKjcEbzML2ghPMd+X9XCMDLnW/efHpopuuyYQDpPL
         j7fnQe/gkz/C7p10qCzt78V74rUzBEQvF2BC1eMJSBlJqERa7OlXqw5UfZSe1zeEHChd
         3YUurzZUk/H0svJgfeUg0idc93esldEasydtSmHm8jrPtrfbx+5c/fEVAot0M4eZQ4gx
         uijQ==
X-Gm-Message-State: AHQUAuZAWry0+hLLKNFTG2qJ2B56X8iNwpb5wfuOSYO05JTxMd7DcuXJ
        FmZhLpkKLKGJBJtkZmSaQ3ESGuaolR6gx4nq2pNl6xhEmn0k
X-Google-Smtp-Source: AHgI3IYUP0YCC4C4T9FkXnBjhiIkx9JDaaZwFZ4AQs6wNJVy5jLi70Sc5SWeQn//acQZFVtb+Hcg7lUMOC/wMZEZt1dFA6pHPygu
MIME-Version: 1.0
X-Received: by 2002:a6b:ea12:: with SMTP id m18mr7823472ioc.35.1550250063721;
 Fri, 15 Feb 2019 09:01:03 -0800 (PST)
Date:   Fri, 15 Feb 2019 09:01:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005c7e6f0581f1b86a@google.com>
Subject: WARNING: locking bug in flush_workqueue_prep_pwqs
From:   syzbot <syzbot+0c4264acb66ea0484d11@syzkaller.appspotmail.com>
To:     davem@davemloft.net, dhowells@redhat.com,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    cb5b020a8d38 Revert "exec: load_script: don't blindly trun..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1016c0f3400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ee434566c893c7b1
dashboard link: https://syzkaller.appspot.com/bug?extid=0c4264acb66ea0484d11
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+0c4264acb66ea0484d11@syzkaller.appspotmail.com

Enabled bearer <udp:syz1>, priority 10
Enabling of bearer <udp:syz1> rejected, already enabled
------------[ cut here ]------------
kobject: 'loop0' (0000000099a84316): kobject_uevent_env
DEBUG_LOCKS_WARN_ON(class_idx > MAX_LOCKDEP_KEYS)
WARNING: CPU: 0 PID: 23993 at kernel/locking/lockdep.c:3315  
__lock_acquire+0x13bf/0x4700 kernel/locking/lockdep.c:3315
kobject: 'loop0' (0000000099a84316): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 23993 Comm: syz-executor.5 Not tainted 5.0.0-rc6+ #72
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
kobject: 'loop4' (00000000ed7cfd88): kobject_uevent_env
  panic+0x2cb/0x65c kernel/panic.c:214
kobject: 'loop4' (00000000ed7cfd88): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
  __warn.cold+0x20/0x45 kernel/panic.c:571
  report_bug+0x263/0x2b0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:178 [inline]
  fixup_bug arch/x86/kernel/traps.c:173 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:271
  do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:290
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:973
RIP: 0010:__lock_acquire+0x13bf/0x4700 kernel/locking/lockdep.c:3315
Code: 8b 1d 69 a5 05 08 45 85 db 0f 85 d6 f4 ff ff 48 c7 c6 e0 a3 6b 87 48  
c7 c7 40 78 6b 87 44 89 9c 24 98 00 00 00 e8 df 29 ec ff <0f> 0b 44 8b 9c  
24 98 00 00 00 e9 af f4 ff ff 8b 3d dc 67 fe 08 85
RSP: 0018:ffff88806836f900 EFLAGS: 00010082
RAX: 0000000000000000 RBX: 00000000339133e8 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff815a9266 RDI: ffffed100d06df12
RBP: ffff88806836fac8 R08: ffff88808d184100 R09: fffffbfff1133341
R10: fffffbfff1133340 R11: ffffffff88999a03 R12: ffff88808d1849e8
R13: ffff88808d1849f2 R14: 00000000339133e8 R15: ffff88808d184100
  lock_acquire+0x16f/0x3f0 kernel/locking/lockdep.c:3841
  __raw_spin_lock_irq include/linux/spinlock_api_smp.h:128 [inline]
  _raw_spin_lock_irq+0x60/0x80 kernel/locking/spinlock.c:160
  spin_lock_irq include/linux/spinlock.h:354 [inline]
  flush_workqueue_prep_pwqs+0x1c5/0x590 kernel/workqueue.c:2633
  flush_workqueue+0x54b/0x14c0 kernel/workqueue.c:2704
  rxrpc_release_sock net/rxrpc/af_rxrpc.c:870 [inline]
  rxrpc_release+0x409/0x830 net/rxrpc/af_rxrpc.c:901
  __sock_release+0xd3/0x250 net/socket.c:579
  sock_close+0x1b/0x30 net/socket.c:1139
  __fput+0x2df/0x8d0 fs/file_table.c:278
  ____fput+0x16/0x20 fs/file_table.c:309
  task_work_run+0x14a/0x1c0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:188 [inline]
  exit_to_usermode_loop+0x273/0x2c0 arch/x86/entry/common.c:166
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x52d/0x610 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x411d31
Code: 75 14 b8 03 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 94 19 00 00 c3 48  
83 ec 08 e8 0a fc ff ff 48 89 04 24 b8 03 00 00 00 0f 05 <48> 8b 3c 24 48  
89 c2 e8 53 fc ff ff 48 89 d0 48 83 c4 08 48 3d 01
RSP: 002b:0000000000a4fd90 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 000000000000000a RCX: 0000000000411d31
RDX: 0000000000000000 RSI: 0000000000743038 RDI: 0000000000000009
RBP: 0000000000000000 R08: ffffffff8100a15d R09: 0000000021576e54
R10: 0000000000a4fcc0 R11: 0000000000000293 R12: 0000000000000000
R13: 0000000000000001 R14: 00000000000000bd R15: 0000000000000005
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
