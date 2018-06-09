Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id uo9xKxMxHFs0AgAAmS7hNA
	; Sat, 09 Jun 2018 19:57:07 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 97246608C1; Sat,  9 Jun 2018 19:57:07 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,FROM_LOCAL_HEX,
	MAILING_LIST_MULTI autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id E9D10600D0;
	Sat,  9 Jun 2018 19:57:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E9D10600D0
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753989AbeFIT5E (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 15:57:04 -0400
Received: from mail-it0-f72.google.com ([209.85.214.72]:60381 "EHLO
        mail-it0-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751138AbeFIT5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 15:57:02 -0400
Received: by mail-it0-f72.google.com with SMTP id v127-v6so4665005ith.9
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jun 2018 12:57:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Jp4tiGcrYQjrTH+xqL0FXwauj6ep6WXj6tNEEk552b4=;
        b=W/TGojr2nFIuHxb7Wkst3K0VQkqvdRdg1hwMBMQWwdY8u7NWElA4yspYjGSgyDzv/j
         uGVJSsokHBoofYjZjXC8NcICXnIqbXwPE/Ug3/lj64Voa44L7fi3YpS2AmaMqu6seqZ0
         9MixKStSqyEtKyK+R7Hl79b2Mx/VsNqBCmQ1l+5Ch58ByaSkpbaMPCIQQd8FOC0qheFA
         F0O5vYCmiX/OHFEy8X1CXcIiZ8NglIvzwP6EcBowAt9kxGgC+LmEAFPgAg9BbPgKlcfN
         vm/iTQ1hXBFjjlg4518aOKi4cwMw0EvAN/tT6O7Hg8h9e7x2GEJi+sTAfgIdtJh9YBqQ
         /Kzw==
X-Gm-Message-State: APt69E2Ag+vmoJtdh0o/sJqm/50rHlBHT9ccfZzsY6K2I9debJJmLFxQ
        Ky7/lMqd2ljLM2xoKKuCkdY6nKLm1p1ORLFTVeduAljkf4gd
X-Google-Smtp-Source: ADUXVKKR6/yjkCEdbqzDLuAUDbdqGclEQ7ZHKsq39/9qD/uCiLEWjL2DPGPLBA4z8jsU8DMOg9zqw6/IeOAdKI/ZVgn+UjbTfFVX
MIME-Version: 1.0
X-Received: by 2002:a6b:c747:: with SMTP id x68-v6mr5159283iof.125.1528574221799;
 Sat, 09 Jun 2018 12:57:01 -0700 (PDT)
Date: Sat, 09 Jun 2018 12:57:01 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000080d9a6056e3aeb35@google.com>
Subject: BUG: unable to handle kernel NULL pointer dereference in sock_poll
From: syzbot <syzbot+344bb0f46d7719cd9483@syzkaller.appspotmail.com>
To: davem@davemloft.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    7d3bf613e99a Merge tag 'libnvdimm-for-4.18' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1188a05f800000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f04d8d0a2afb789a
dashboard link: https://syzkaller.appspot.com/bug?extid=344bb0f46d7719cd9483
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=12b5841f800000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17f4005f800000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+344bb0f46d7719cd9483@syzkaller.appspotmail.com

random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
PGD 1b2931067 P4D 1b2931067 PUD 1d0ae1067 PMD 0
Oops: 0010 [#1] SMP KASAN
CPU: 0 PID: 4493 Comm: syz-executor249 Not tainted 4.17.0+ #92
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:          (null)
Code: Bad RIP value.
RSP: 0018:ffff8801b3bd7590 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff8801b2994800 RCX: 1ffffffff10ea8e5
RDX: ffff8801b3bd7ab0 RSI: ffff8801ace8c980 RDI: ffff8801b378d800
RBP: ffff8801b3bd7700 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 1ffff1003677aeb7
R13: ffff8801b3bd7ab0 R14: ffff8801b2994812 R15: ffff8801b2994c58
FS:  00000000018d6880(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 00000001b2a10000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  sock_poll+0x1d1/0x710 net/socket.c:1156
  vfs_poll+0x77/0x2a0 fs/select.c:40
  do_pollfd fs/select.c:848 [inline]
  do_poll fs/select.c:896 [inline]
  do_sys_poll+0x6fd/0x1100 fs/select.c:990
  __do_sys_poll fs/select.c:1048 [inline]
  __se_sys_poll fs/select.c:1036 [inline]
  __x64_sys_poll+0x189/0x510 fs/select.c:1036
  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x43fcc9
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 6b 45 00 00 c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffc32252d08 EFLAGS: 00000213 ORIG_RAX: 0000000000000007
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 000000000043fcc9
RDX: 0000000000000003 RSI: 0000000000000001 RDI: 0000000020000040
RBP: 00000000006ca018 R08: 00000000004002c8 R09: 00000000004002c8
R10: 00000000004002c8 R11: 0000000000000213 R12: 00000000004015f0
R13: 0000000000401680 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
Dumping ftrace buffer:
    (ftrace buffer empty)
CR2: 0000000000000000
---[ end trace c755e9b5f9cf1fa4 ]---
RIP: 0010:          (null)
Code: Bad RIP value.
RSP: 0018:ffff8801b3bd7590 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff8801b2994800 RCX: 1ffffffff10ea8e5
RDX: ffff8801b3bd7ab0 RSI: ffff8801ace8c980 RDI: ffff8801b378d800
RBP: ffff8801b3bd7700 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 1ffff1003677aeb7
R13: ffff8801b3bd7ab0 R14: ffff8801b2994812 R15: ffff8801b2994c58
FS:  00000000018d6880(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 00000001b2a10000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
