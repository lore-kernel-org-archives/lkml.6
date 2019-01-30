Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 492D3C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 14:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EF7B218A3
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 14:03:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731178AbfA3ODF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 09:03:05 -0500
Received: from mail-it1-f200.google.com ([209.85.166.200]:53831 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfA3ODF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 09:03:05 -0500
Received: by mail-it1-f200.google.com with SMTP id i12so18996570ita.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 06:03:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=WMHcGiKFsUeQeZvwHOAs2UVlqtzrvpVZ1Nuxx8Ua6dI=;
        b=s9KQiUe/2TB4ZWc1a6PQeS7UPgG/aclIanrNkB5HV37kjPPQTY5toOwl06yuZ2sLZX
         HxVA8ROq97h9mLm+zfkjrW5sbdseyw/nIvxk12FpP+2qXWA5TH861UyWprHa4I2nvp08
         LhoM08MP/mcUBJRCmVAgx+AWOpz+1RLM52QC5MmFgp+SMrUQV/X/CCN72wcpUtRMxihX
         6OZ39Z0XFYOTeCxTuUAupjmJq+c1sEqxFJBZWjEa7yn/7432taeYXP5sR0/21+Rjq79R
         ZRk3uzYKemGwjlDZpz6xUkAg69isFAhGXTJ37NiXYPqNXXB5mzoHhXN206eVd6/oFoo1
         v9EQ==
X-Gm-Message-State: AHQUAuZiI1Vb+g0qsOnCnyuBppeKD53YDFEVx9GapQZyxe0RhCqDFDzU
        QHzJvknX+Hk2PS6Uf+TDPR2o2OZqX8W20tStrM3772j1XvMW
X-Google-Smtp-Source: AHgI3IbLCw9Xg0IccVFWA+oFbi471+eenRcYBBt0ygEaUXIQVEF1lDvCEngijIEiuDXT+FpFlAwbv/XmCk1Qk13EGru4yvTzt72T
MIME-Version: 1.0
X-Received: by 2002:a24:1d01:: with SMTP id 1mr6040872itj.39.1548856983917;
 Wed, 30 Jan 2019 06:03:03 -0800 (PST)
Date:   Wed, 30 Jan 2019 06:03:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000559d460580ad5eeb@google.com>
Subject: general protection fault in __sock_release (2)
From:   syzbot <syzbot+38b29941610a1cc735dc@syzkaller.appspotmail.com>
To:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    30e5c2c6bf28 net: Revert devlink health changes.
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1249a2b8c00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=505743eba4e4f68
dashboard link: https://syzkaller.appspot.com/bug?extid=38b29941610a1cc735dc
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+38b29941610a1cc735dc@syzkaller.appspotmail.com

bond0 (unregistering): Releasing backup interface bond_slave_1
bond0 (unregistering): Releasing backup interface bond_slave_0
bond0 (unregistering): Released all slaves
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 8762 Comm: syz-executor0 Not tainted 5.0.0-rc3+ #21
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:__sock_release+0x2d/0x250 net/socket.c:574
Code: e5 41 57 41 56 41 55 41 54 49 89 f4 53 48 89 fb e8 38 d4 6c fb 4c 8d  
73 28 48 b8 00 00 00 00 00 fc ff df 4c 89 f2 48 c1 ea 03 <80> 3c 02 00 0f  
85 b1 01 00 00 4c 8b 6b 28 4d 85 ed 0f 84 c7 00 00
RSP: 0018:ffff8880a53bf8f8 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffc90005ff4000
RDX: 0000000000000005 RSI: ffffffff86152ab8 RDI: 0000000000000000
RBP: ffff8880a53bf920 R08: ffff8880a51e2500 R09: fffffbfff1462b55
R10: fffffbfff1462b54 R11: ffffffff8a315aa7 R12: 0000000000000000
R13: 0000000000000007 R14: 0000000000000028 R15: ffff88809fc0eb88
FS:  00007fabf4208700(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000402e9d CR3: 00000000a585c000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  sock_release+0x18/0x20 net/socket.c:598
  inet_ctl_sock_destroy include/net/inet_common.h:56 [inline]
  icmp_sk_exit+0x11f/0x1f0 net/ipv4/icmp.c:1187
  ops_exit_list.isra.0+0xb0/0x160 net/core/net_namespace.c:153
  setup_net+0x4b2/0x8c0 net/core/net_namespace.c:331
  copy_net_ns+0x2ae/0x4b0 net/core/net_namespace.c:437
  create_new_namespaces+0x4ce/0x930 kernel/nsproxy.c:107
  unshare_nsproxy_namespaces+0xc2/0x200 kernel/nsproxy.c:206
  ksys_unshare+0x6d7/0xfb0 kernel/fork.c:2550
  __do_sys_unshare kernel/fork.c:2618 [inline]
  __se_sys_unshare kernel/fork.c:2616 [inline]
  __x64_sys_unshare+0x31/0x40 kernel/fork.c:2616
  do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x458099
Code: 6d b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 3b b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fabf4207c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000110
RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 0000000000458099
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000040000000
RBP: 000000000073bfa0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fabf42086d4
R13: 00000000004c6de4 R14: 00000000004dc408 R15: 00000000ffffffff
Modules linked in:
---[ end trace 320ccc001dc11318 ]---
RIP: 0010:__sock_release+0x2d/0x250 net/socket.c:574
Code: e5 41 57 41 56 41 55 41 54 49 89 f4 53 48 89 fb e8 38 d4 6c fb 4c 8d  
73 28 48 b8 00 00 00 00 00 fc ff df 4c 89 f2 48 c1 ea 03 <80> 3c 02 00 0f  
85 b1 01 00 00 4c 8b 6b 28 4d 85 ed 0f 84 c7 00 00
RSP: 0018:ffff8880a53bf8f8 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffc90005ff4000
RDX: 0000000000000005 RSI: ffffffff86152ab8 RDI: 0000000000000000
RBP: ffff8880a53bf920 R08: ffff8880a51e2500 R09: fffffbfff1462b55
R10: fffffbfff1462b54 R11: ffffffff8a315aa7 R12: 0000000000000000
R13: 0000000000000007 R14: 0000000000000028 R15: ffff88809fc0eb88
FS:  00007fabf4208700(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000402e9d CR3: 00000000a585c000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
