Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40777C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 04:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B7E120B1F
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 04:17:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbeLaERF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 23:17:05 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:39312 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbeLaERE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 23:17:04 -0500
Received: by mail-io1-f70.google.com with SMTP id q23so30896937ior.6
        for <linux-kernel@vger.kernel.org>; Sun, 30 Dec 2018 20:17:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=6BBKfIUc5mrBwUO4fLh7U7/bWZuYpkG3RZFZzn7X3cQ=;
        b=DAxXFrdA/0uEl1OK8p1djGoUB5EpebMWfVDRqoiSIbuxg08h6n9dOBvmgBE0TjigxA
         GYcKf0zzqoYTpUXm7vYLhFjv0NiHnw818IbOCg9/QxQHKXqM66KjtJDUJM12sYYeilPN
         hAWh1q74XLQ1fYu8Tu6LIvlRPFqX/W+VfMloNjlbLt7PBtLOT/Dz0q9iwNQWCkfTZL88
         eDWwZ3VFz8Wi79jpwjU62B7oZnJtyZcWiEFd7KNAcy7P9+4YHgRPFUeoxeZpOX548taP
         fJx3mYqUMp8jqjN7q/apUnMmhFQgOIB6KGvr1fQYXYcbe3Z8pV3wuDUxZE4Dbxd2XLcY
         cGLg==
X-Gm-Message-State: AA+aEWarKxL54DJUnND0D4Hbpe27bdJ1utFGqPTPybjAFNMmFATGJolW
        hdw/N9IqfGZhxYeIUkFKdhM4YT0PkaGzk2Sgp6/JUCn4FYhP
X-Google-Smtp-Source: ALg8bN441VE+y5Y31GpFFVxAiL66jcdUb9s8kIw1Cvctj49c2+17QZ9xgQmeYaRbQm2rdLq2uw2nyqLtUZ5LqMqgRcetv60ZJOUX
MIME-Version: 1.0
X-Received: by 2002:a24:138f:: with SMTP id 137mr26702483itz.18.1546229823313;
 Sun, 30 Dec 2018 20:17:03 -0800 (PST)
Date:   Sun, 30 Dec 2018 20:17:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005c2068057e49afcf@google.com>
Subject: WARNING in batadv_mcast_mla_update
From:   syzbot <syzbot+050927a651272b145a5d@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=10785d57400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fa5c63e12fd85b25
dashboard link: https://syzkaller.appspot.com/bug?extid=050927a651272b145a5d
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+050927a651272b145a5d@syzkaller.appspotmail.com

QAT: Invalid ioctl
bond0 (unregistering): Releasing backup interface bond_slave_0
bond0 (unregistering): Released all slaves
WARNING: CPU: 0 PID: 28 at net/batman-adv/multicast.c:371  
batadv_mcast_mla_tt_add net/batman-adv/multicast.c:371 [inline]
WARNING: CPU: 0 PID: 28 at net/batman-adv/multicast.c:371  
__batadv_mcast_mla_update net/batman-adv/multicast.c:636 [inline]
WARNING: CPU: 0 PID: 28 at net/batman-adv/multicast.c:371  
batadv_mcast_mla_update+0x248f/0x2da0 net/batman-adv/multicast.c:661
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 28 Comm: kworker/u4:2 Not tainted 4.20.0+ #390
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
RIP: 0010:batadv_mcast_mla_tt_add net/batman-adv/multicast.c:371 [inline]
RIP: 0010:__batadv_mcast_mla_update net/batman-adv/multicast.c:636 [inline]
RIP: 0010:batadv_mcast_mla_update+0x248f/0x2da0  
net/batman-adv/multicast.c:661
Code: 49 c1 ee 03 48 b8 00 00 00 00 00 fc ff df be f8 f8 ff ff 66 41 89 34  
06 48 c1 ea 03 c6 04 02 f8 e9 f7 e7 ff ff e8 41 f3 bf f9 <0f> 0b e9 b8 e3  
ff ff 48 8b bd 48 fc ff ff e8 1e fe 02 fa e9 99 df
RSP: 0018:ffff8880a9fe7338 EFLAGS: 00010293
RAX: ffff8880a9422000 RBX: 0000000000000001 RCX: ffffffff87bf0125
RDX: 0000000000000000 RSI: ffffffff87bf1d6f RDI: 0000000000000007
RBP: ffff8880a9fe7738 R08: ffff8880a9422000 R09: 0000000000000006
R10: 0000000000000000 R11: ffff8880a9422000 R12: ffff8880a9fe7490
R13: 0000000000000000 R14: 1ffff110153fce92 R15: ffff8880a9fe7710
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
