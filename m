Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59922C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 04:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3428420815
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 04:11:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbeLaELG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 23:11:06 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:48489 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbeLaELF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 23:11:05 -0500
Received: by mail-io1-f72.google.com with SMTP id s3so25278487iob.15
        for <linux-kernel@vger.kernel.org>; Sun, 30 Dec 2018 20:11:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=00J0HB6kHwqkqtUUrgwRfqdgmVsV/Gxz+mkp1Mv+CJE=;
        b=FfACnaFS7rUT2yq7i0gpKjmiscfnK1tlytE9YsophbXZs9lEjXX3pJR3NUroc7+D3R
         ObLsjt1sBmcZnpi9VwO0mUPVzmcRIgzSe+e11PluNo+phejFkk7qhR7IjaMXZ3ENbmEk
         VKZ50k5D/nPF871voU7LSEORRJYI9m929J6xtuicjTo3qF5dnwajvH1W1Ll17+EsskRj
         D5jF0csn+jKL7386XVoYjrU25a60Hj5eP+puyYY7ykjFt202g3bYHjbEJ4e5i4Uj6b4h
         Yj5I4CJp/qulO4cl1jMbomufJhtnedK6O6RwWGV03Y1arljkHJstnVhCOkfqYcnsr+/i
         rnGQ==
X-Gm-Message-State: AA+aEWZ4EtDDLnoo56aOAMdHn1Hz5a2VQu+isxSYjDxZF+1X47Afj+yQ
        FlheD3rpzwiF9Sm+sMZPdDobPx93NcFuWvFWprmUq67hcjA7
X-Google-Smtp-Source: AFSGD/Vo+zYsw3ktgf/bUGzRrL78L1PPsgz7e06JDepBQuAmIG28jBKVfF2oB+YqxO08ePfJDyyCPWGg10xHAx5B0RYSr9+ySwYg
MIME-Version: 1.0
X-Received: by 2002:a24:f986:: with SMTP id l128mr26619541ith.5.1546229464582;
 Sun, 30 Dec 2018 20:11:04 -0800 (PST)
Date:   Sun, 30 Dec 2018 20:11:04 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fa4f60057e499989@google.com>
Subject: WARNING in batadv_mcast_mla_tt_retract
From:   syzbot <syzbot+83f2d54ec6b7e417e13f@syzkaller.appspotmail.com>
To:     a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org,
        davem@davemloft.net, linux-kernel@vger.kernel.org,
        mareklindner@neomailbox.ch, netdev@vger.kernel.org,
        sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    eed9688f8513 Merge branch 'ras-core-for-linus' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=103bffaf400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fa5c63e12fd85b25
dashboard link: https://syzkaller.appspot.com/bug?extid=83f2d54ec6b7e417e13f
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+83f2d54ec6b7e417e13f@syzkaller.appspotmail.com

bond0 (unregistering): Releasing backup interface bond_slave_0
bond0 (unregistering): Released all slaves
WARNING: CPU: 1 PID: 7 at net/batman-adv/multicast.c:337  
batadv_mcast_mla_tt_retract+0x476/0x590 net/batman-adv/multicast.c:337
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 7 Comm: kworker/u4:0 Not tainted 4.20.0+ #169
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: bat_events batadv_mcast_mla_update
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1d3/0x2c6 lib/dump_stack.c:113
  panic+0x2ad/0x55c kernel/panic.c:188
  __warn.cold.8+0x20/0x45 kernel/panic.c:540
  report_bug+0x254/0x2d0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:178 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:271
  do_invalid_op+0x36/0x40 arch/x86/kernel/traps.c:290
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:973
RIP: 0010:batadv_mcast_mla_tt_retract+0x476/0x590  
net/batman-adv/multicast.c:337
Code: 00 00 ad de 4c 89 ff 49 89 47 08 e8 b4 0f 03 fa e9 b6 fe ff ff 49 8d  
47 10 48 89 85 60 ff ff ff e9 05 ff ff ff e8 4a 30 c0 f9 <0f> 0b e9 3f fc  
ff ff e8 6e 3b 03 fa e9 44 fe ff ff 4c 89 f7 e8 81
RSP: 0018:ffff8880a9e1f260 EFLAGS: 00010293
RAX: ffff8880a9e041c0 RBX: 0000000000000001 RCX: ffffffff87bedca3
RDX: 0000000000000000 RSI: ffffffff87bee066 RDI: 0000000000000007
RBP: ffff8880a9e1f328 R08: ffff8880a9e041c0 R09: ffffed1015ce5b8f
R10: 0000000000000003 R11: ffff8880ae72dc7b R12: ffff8880a9e1f490
R13: 0000000000000000 R14: ffff888055b95fc0 R15: ffff8880a9e1f710
  __batadv_mcast_mla_update net/batman-adv/multicast.c:635 [inline]
  batadv_mcast_mla_update+0x819/0x2da0 net/batman-adv/multicast.c:661
  process_one_work+0xc90/0x1c40 kernel/workqueue.c:2153
  worker_thread+0x17f/0x1390 kernel/workqueue.c:2296
  kthread+0x35a/0x440 kernel/kthread.c:246
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
