Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33300C64E79
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 15:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B79621873
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 15:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725855AbeLXPYG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 10:24:06 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:45158 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbeLXPYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 10:24:05 -0500
Received: by mail-io1-f69.google.com with SMTP id r65so13341522iod.12
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 07:24:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=uMvOKlhpyzpTsHKV7RdGnzVYKF9eRVH1jyjiZOu+oWU=;
        b=SuSovkg9JJk9WaOmUCvoi0730bkhyl0ZN8CA8apppvdf0HJhsyhIGKiR6DLRyEXoHs
         jWJAmochbQD5N0lqAAbxO/oiI31jiyudlY9iMtAfPjMIWpq9t8BNCaNDg2llTWdYGzlr
         oH6N4rnSbXIkGxBn78VszXjZlDCXAfatC3VwmUbtmpIWw9B6Mq37ZuNl/Tj+pgGUR9Nu
         hI6OUGx33oFHm2BOUMj5uzOQJai+GVykulHUIpPXWQj/VJYFRM3VbTJJyxgvGnxs+vS0
         o1p1JEu10PnUCNX1pHmZi5LNOZO6qNjrP4NanKMONteCi8+G+O1qjPmIn7zl4VBS2mkf
         ZIhg==
X-Gm-Message-State: AJcUukcuK65zxB2xB+VpOhylgb5CIKrAG3Lq2mmrvw1o54EuOXHGj7jb
        KFVhPGJXNFVMAg3CWhDeeHFOO6XmE60zhjPGoQzV1xw49RdC
X-Google-Smtp-Source: ALg8bN7P2MvB6JskFfq2QUpel85kKSvtsQiq8mk1CvuK9ggW9F2ZghDoUUbF44cBRjcTFWiFDoRzqpqMzDzJ6KjmxCrzRtwlAY68
MIME-Version: 1.0
X-Received: by 2002:a6b:c84a:: with SMTP id y71mr12681199iof.10.1545665044173;
 Mon, 24 Dec 2018 07:24:04 -0800 (PST)
Date:   Mon, 24 Dec 2018 07:24:04 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e66233057dc62ff3@google.com>
Subject: general protection fault in xfrm_policy_insert_list
From:   syzbot <syzbot+e879931aaae5c1abca56@syzkaller.appspotmail.com>
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

HEAD commit:    ce28bb445388 Merge git://git.kernel.org/pub/scm/linux/kern..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17803ac3400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=67a2081147a23142
dashboard link: https://syzkaller.appspot.com/bug?extid=e879931aaae5c1abca56
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+e879931aaae5c1abca56@syzkaller.appspotmail.com

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 6146 Comm: syz-executor5 Not tainted 4.20.0-rc7+ #358
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:xfrm_policy_insert_list+0x174/0x1020 net/xfrm/xfrm_policy.c:1532
kobject: 'loop0' (000000008b3a9204): kobject_uevent_env
Code: ff ff ff 48 c1 e8 03 4c 01 e0 48 89 85 20 ff ff ff e8 40 d6 b3 fa 48  
8d bb 19 02 00 00 48 89 f8 48 89 fa 48 c1 e8 03 83 e2 07 <42> 0f b6 04 20  
38 d0 7f 08 84 c0 0f 85 f5 0b 00 00 44 0f b6 ab 19
RSP: 0018:ffff88819772f098 EFLAGS: 00010202
RAX: 00000025800000bf RBX: 0000012c000003e0 RCX: ffffc9000fe54000
RDX: 0000000000000001 RSI: ffffffff86cae280 RDI: 0000012c000005f9
kobject: 'loop0' (000000008b3a9204): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
RBP: ffff88819772f1c0 R08: ffff8881d32c2480 R09: 1ffff11037615f21
R10: 0000000000000003 R11: ffff888192b2a600 R12: dffffc0000000000
R13: 0000000000000000 R14: 000000008bc53300 R15: 0000000000000000
FS:  00007fb18f7ca700(0000) GS:ffff8881daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
kobject: 'loop3' (00000000bef5b68b): kobject_uevent_env
CR2: 00000000004d9300 CR3: 0000000180ff1000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
kobject: 'loop3' (00000000bef5b68b): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
  xfrm_policy_inexact_insert+0x166/0xee0 net/xfrm/xfrm_policy.c:1195
kobject: 'loop0' (000000008b3a9204): kobject_uevent_env
kobject: 'loop0' (000000008b3a9204): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
  xfrm_policy_insert+0x639/0x850 net/xfrm/xfrm_policy.c:1570
  xfrm_add_policy+0x2a0/0x6f0 net/xfrm/xfrm_user.c:1657
kobject: 'loop2' (000000000496a7a1): kobject_uevent_env
  xfrm_user_rcv_msg+0x44c/0x8e0 net/xfrm/xfrm_user.c:2663
kobject: 'loop2' (000000000496a7a1): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
  netlink_rcv_skb+0x16c/0x430 net/netlink/af_netlink.c:2477
  xfrm_netlink_rcv+0x6f/0x90 net/xfrm/xfrm_user.c:2671
  netlink_unicast_kernel net/netlink/af_netlink.c:1310 [inline]
  netlink_unicast+0x59f/0x750 net/netlink/af_netlink.c:1336
  netlink_sendmsg+0xa18/0xfc0 net/netlink/af_netlink.c:1917
kobject: 'loop2' (000000000496a7a1): kobject_uevent_env
  sock_sendmsg_nosec net/socket.c:621 [inline]
  sock_sendmsg+0xd5/0x120 net/socket.c:631
  ___sys_sendmsg+0x7fd/0x930 net/socket.c:2116
kobject: 'loop2' (000000000496a7a1): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop0' (000000008b3a9204): kobject_uevent_env
kobject: 'loop0' (000000008b3a9204): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
  __sys_sendmsg+0x11d/0x280 net/socket.c:2154
kobject: 'loop2' (000000000496a7a1): kobject_uevent_env
  __do_sys_sendmsg net/socket.c:2163 [inline]
  __se_sys_sendmsg net/socket.c:2161 [inline]
  __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2161
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
kobject: 'loop2' (000000000496a7a1): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop0' (000000008b3a9204): kobject_uevent_env
kobject: 'loop0' (000000008b3a9204): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457669
Code: fd b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fb18f7c9c78 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457669
kobject: 'loop2' (000000000496a7a1): kobject_uevent_env
RDX: 0000000000000000 RSI: 000000002014f000 RDI: 0000000000000003
RBP: 000000000072bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fb18f7ca6d4
R13: 00000000004c44d8 R14: 00000000004d74e8 R15: 00000000ffffffff
Modules linked in:
---[ end trace 818a477ec48fd0a4 ]---
kobject: 'loop2' (000000000496a7a1): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
RIP: 0010:xfrm_policy_insert_list+0x174/0x1020 net/xfrm/xfrm_policy.c:1532
Code: ff ff ff 48 c1 e8 03 4c 01 e0 48 89 85 20 ff ff ff e8 40 d6 b3 fa 48  
8d bb 19 02 00 00 48 89 f8 48 89 fa 48 c1 e8 03 83 e2 07 <42> 0f b6 04 20  
38 d0 7f 08 84 c0 0f 85 f5 0b 00 00 44 0f b6 ab 19
RSP: 0018:ffff88819772f098 EFLAGS: 00010202
RAX: 00000025800000bf RBX: 0000012c000003e0 RCX: ffffc9000fe54000
RDX: 0000000000000001 RSI: ffffffff86cae280 RDI: 0000012c000005f9
RBP: ffff88819772f1c0 R08: ffff8881d32c2480 R09: 1ffff11037615f21
R10: 0000000000000003 R11: ffff888192b2a600 R12: dffffc0000000000
R13: 0000000000000000 R14: 000000008bc53300 R15: 0000000000000000
FS:  00007fb18f7ca700(0000) GS:ffff8881daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000004d9300 CR3: 0000000180ff1000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
kobject: 'loop2' (000000000496a7a1): kobject_uevent_env
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
