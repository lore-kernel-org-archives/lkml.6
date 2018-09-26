Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 646B6C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 07:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16E6D208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 07:41:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16E6D208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbeIZNwj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 09:52:39 -0400
Received: from mail-it1-f199.google.com ([209.85.166.199]:53823 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbeIZNwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 09:52:39 -0400
Received: by mail-it1-f199.google.com with SMTP id f134-v6so2089121ite.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 00:41:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=UM7XsjehrRM78Wm14zvuhii+vTTa5BHmS5bBYx8RaQg=;
        b=USAcrj+uqvE42jaLtV+df60JDNpoh8lQk+Mdpez2FjMxpWXwGa0P5QOQFgmka83er+
         EFDL59BP5vhiFXRx26JC/jaKkw10Jts+YvPWg+1+1uzZoytJYpqAE06RvYUWQHtdRXSX
         6kgMnJvNZxnrBI/dMwRyGtV4vwJ6bYmUl6UO09Vi6zFCPEY4G0CfcVLejuh14vbxBU2Q
         UCOx7vtPB3GmTHbCWtEoMECcnMcS477OIKzmxfgqyEUnOGtZWaKTArrlHIUL6yOdmUrI
         McN2CO9e2IX8SFFBmRYO+oaNc/JMHWUY9BwG3BhcE3O0HZelTs1acS48N7IqEPmCxIMZ
         LoFA==
X-Gm-Message-State: ABuFfog86c96f0uD4raoAuQYmgzs4WTF6tNCdhMSnfeOuTuBXl1HIIdt
        Vcuts1nZsz8qJk2Mx9wYkCUPNI0HsO1ZgLHjiobhuwsTI0aW
X-Google-Smtp-Source: ACcGV60GmKXFYjk38uEvpghSl5YUU9uG1G/Z7ncIUYWZoKGvlzjwfKNsoSEqh7YuhajmOCZK0M6O4rEk//RWMCTuC5KqCmINnca8
MIME-Version: 1.0
X-Received: by 2002:a6b:e0b:: with SMTP id 11-v6mr3343240ioo.3.1537947663566;
 Wed, 26 Sep 2018 00:41:03 -0700 (PDT)
Date:   Wed, 26 Sep 2018 00:41:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002b8eb70576c15840@google.com>
Subject: WARNING in pfkey_sock_destruct
From:   syzbot <syzbot+4acf0d9092f91bb60431@syzkaller.appspotmail.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        steffen.klassert@secunet.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    10dc890d4228 Merge tag 'pinctrl-v4.19-3' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=126e7111400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5fa12be50bca08d8
dashboard link: https://syzkaller.appspot.com/bug?extid=4acf0d9092f91bb60431
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+4acf0d9092f91bb60431@syzkaller.appspotmail.com

WARNING: CPU: 1 PID: 18415 at net/key/af_key.c:111  
pfkey_sock_destruct+0x574/0x610 net/key/af_key.c:111
Kernel panic - not syncing: panic_on_warn set ...

CPU: 1 PID: 18415 Comm: syz-executor3 Not tainted 4.19.0-rc4+ #28
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c4/0x2b4 lib/dump_stack.c:113
  panic+0x238/0x4e7 kernel/panic.c:184
  __warn.cold.8+0x163/0x1ba kernel/panic.c:536
  report_bug+0x254/0x2d0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:178 [inline]
  do_error_trap+0x1fc/0x4d0 arch/x86/kernel/traps.c:296
  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:316
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:993
RIP: 0010:pfkey_sock_destruct+0x574/0x610 net/key/af_key.c:111
Code: 00 48 c7 c7 a0 14 b4 88 c6 05 9e 48 40 03 01 e8 6d bc 80 fa e9 70 fc  
ff ff e8 78 69 9e fa 0f 0b e9 a8 fe ff ff e8 6c 69 9e fa <0f> 0b e9 ed fd  
ff ff 48 89 c7 e8 2d ca e1 fa e9 40 fe ff ff 4c 89
RSP: 0018:ffff880199627660 EFLAGS: 00010293
RAX: ffff88011e2a0680 RBX: ffff8801c5053100 RCX: ffffffff86e078fa
RDX: 0000000000000000 RSI: ffffffff86e07b14 RDI: 0000000000000005
RBP: ffff880199627770 R08: ffff88011e2a0680 R09: ffffed0038a0a65b
R10: ffffed0038a0a65b R11: ffff8801c50532db R12: 1ffff100332c4ecd
R13: ffff880199627748 R14: 1ffff100332c4ed1 R15: ffff8801cd7d4b40
  __sk_destruct+0x115/0xbd0 net/core/sock.c:1560
  sk_destruct+0x78/0x90 net/core/sock.c:1595
  __sk_free+0xcf/0x300 net/core/sock.c:1606
  sk_free+0x42/0x50 net/core/sock.c:1617
  sock_put include/net/sock.h:1691 [inline]
  pfkey_release+0x409/0x570 net/key/af_key.c:194
  __sock_release+0xd7/0x250 net/socket.c:579
  sock_close+0x19/0x20 net/socket.c:1141
  __fput+0x385/0xa30 fs/file_table.c:278
  ____fput+0x15/0x20 fs/file_table.c:309
  task_work_run+0x1e8/0x2a0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:193 [inline]
  exit_to_usermode_loop+0x318/0x380 arch/x86/entry/common.c:166
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x411151
Code: 75 14 b8 03 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 34 19 00 00 c3 48  
83 ec 08 e8 0a fc ff ff 48 89 04 24 b8 03 00 00 00 0f 05 <48> 8b 3c 24 48  
89 c2 e8 53 fc ff ff 48 89 d0 48 83 c4 08 48 3d 01
kobject: 'loop4' (000000003d24b0c2): kobject_uevent_env
RSP: 002b:00007ffd93469000 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
kobject: 'loop4' (000000003d24b0c2): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
RAX: 0000000000000000 RBX: 0000000000000006 RCX: 0000000000411151
RDX: 0000000000000000 RSI: 00000000007317f8 RDI: 0000000000000005
RBP: 0000000000000000 R08: 00000000000000a0 R09: ffffffffffffffff
R10: 000000000072bfa0 R11: 0000000000000293 R12: 000000000000000b
R13: 000000000006a9d7 R14: 0000000000000167 R15: badc0ffeebadface
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
