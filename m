Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC57C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 22:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34E202086A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 22:09:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34E202086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729614AbeKQIXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 03:23:14 -0500
Received: from mail-it1-f198.google.com ([209.85.166.198]:54534 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbeKQIXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 03:23:14 -0500
Received: by mail-it1-f198.google.com with SMTP id v3so48647itf.4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 14:09:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=tT+87fgesKm676iWL3RZh34enhFWbIQZ2G6YnnUHq9Q=;
        b=Mdl9VoK+sj/ZNsWaIjT41fP5Iw1s7jiLocNmhTq1eCkFEdH9+FMs6ilibbDwdN96Hf
         Ke3ZBiYIxbzpEA7bMoaA7sD3L0fzMd/VK26KBb4XdhWtOA14nkxdwpc1nv31dqTsrz6j
         RGZrRC41rYl0Nr9YMD41e9qChfhZ1uz7zZIR7h4HNSzxkt7EmN1NHod6l4qspGV0LCvA
         dwNUtz5MgW1arYWk+YLzQZFviwWLRXrRbP1e900lR3/CnFCwjD++is0XNXGS7J1eVamn
         C4TqfcnpUv3zAFb8P3o3wcRgXXHtELn4Dbt1m3UJYOdhgD/ST339dC1DYh04JHZtPRlO
         /UNA==
X-Gm-Message-State: AA+aEWZZsouOWBlP88khzqUFcTccZBGUzq2P+9ZJ1/+bkOzJmTX+xH6H
        FVy3Si/Ai/YNqbky4puAifWv+U44o28NLGFxCd+9n6VFi5W+
X-Google-Smtp-Source: AFSGD/WAmI6pmOXA0GaPCDUDjyBU0O5EJpYzrLbj9ck7tEC/4gFrLGUIWnHaCpd1is7eobL+8XfgjA9FCQKgbUUiI7UFE3sogP5b
MIME-Version: 1.0
X-Received: by 2002:a6b:8e83:: with SMTP id q125mr4737413iod.9.1542406143954;
 Fri, 16 Nov 2018 14:09:03 -0800 (PST)
Date:   Fri, 16 Nov 2018 14:09:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004f5883057acf6af2@google.com>
Subject: WARNING in cttimeout_default_get
From:   syzbot <syzbot+2fae8fa157dd92618cae@syzkaller.appspotmail.com>
To:     coreteam@netfilter.org, davem@davemloft.net, fw@strlen.de,
        kadlec@blackhole.kfki.hu, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        pablo@netfilter.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    da5322e65940 Merge tag 'selinux-pr-20181115' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15d719eb400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4a0a89f12ca9b0f5
dashboard link: https://syzkaller.appspot.com/bug?extid=2fae8fa157dd92618cae
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=129e0893400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=125f66a3400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+2fae8fa157dd92618cae@syzkaller.appspotmail.com

audit: type=1800 audit(1542315810.422:30): pid=5877 uid=0 auid=4294967295  
ses=4294967295 subj==unconfined op=collect_data cause=failed(directio)  
comm="startpar" name="rmnologin" dev="sda1" ino=2423 res=0
netlink: 'syz-executor298': attribute type 3 has an invalid length.
netlink: 'syz-executor298': attribute type 2 has an invalid length.
WARNING: CPU: 0 PID: 6032 at net/netfilter/nfnetlink_cttimeout.c:478  
cttimeout_default_get+0x1df/0xb30 net/netfilter/nfnetlink_cttimeout.c:478
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 6032 Comm: syz-executor298 Not tainted 4.20.0-rc2+ #336
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x39d lib/dump_stack.c:113
  panic+0x2ad/0x55c kernel/panic.c:188
  __warn.cold.8+0x20/0x45 kernel/panic.c:540
  report_bug+0x254/0x2d0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:178 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:271
  do_invalid_op+0x36/0x40 arch/x86/kernel/traps.c:290
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:969
RIP: 0010:cttimeout_default_get+0x1df/0xb30  
net/netfilter/nfnetlink_cttimeout.c:478
Code: 00 0f 87 8d 00 00 00 41 80 ff 06 0f 84 94 07 00 00 41 80 ff 11 0f 84  
6c 07 00 00 41 80 ff 01 0f 84 44 07 00 00 e8 91 f1 20 fb <0f> 0b 41 bd a1  
ff ff ff eb 06 41 bd a1 ff ff ff e8 7c f1 20 fb 48
RSP: 0018:ffff8881b64c72b0 EFLAGS: 00010293
RAX: ffff8881c1686380 RBX: ffffffff88bf58e0 RCX: ffffffff865e961c
RDX: 0000000000000000 RSI: ffffffff865e964f RDI: 0000000000000001
RBP: ffff8881b64c73c0 R08: ffff8881c1686380 R09: ffffed103b5c5b67
R10: 0000000000000002 R11: ffff8881dae2db3b R12: 0000000000000088
R13: ffff8881bf42b300 R14: 0000000000000000 R15: 0000000000000088
  nfnetlink_rcv_msg+0xdd3/0x10c0 net/netfilter/nfnetlink.c:228
  netlink_rcv_skb+0x172/0x440 net/netlink/af_netlink.c:2477
  nfnetlink_rcv+0x1c0/0x4d0 net/netfilter/nfnetlink.c:560
  netlink_unicast_kernel net/netlink/af_netlink.c:1310 [inline]
  netlink_unicast+0x5a5/0x760 net/netlink/af_netlink.c:1336
  netlink_sendmsg+0xa18/0xfc0 net/netlink/af_netlink.c:1917
  sock_sendmsg_nosec net/socket.c:621 [inline]
  sock_sendmsg+0xd5/0x120 net/socket.c:631
  ___sys_sendmsg+0x7fd/0x930 net/socket.c:2116
  __sys_sendmsg+0x11d/0x280 net/socket.c:2154
  __do_sys_sendmsg net/socket.c:2163 [inline]
  __se_sys_sendmsg net/socket.c:2161 [inline]
  __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2161
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4400d9
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 fb 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffc704c30c8 EFLAGS: 00000213 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 00000000004400d9
RDX: 0000000000000000 RSI: 0000000020dddfc8 RDI: 0000000000000003
RBP: 00000000006ca018 R08: 0000000000000000 R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000213 R12: 0000000000401960
R13: 00000000004019f0 R14: 0000000000000000 R15: 0000000000000000
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
