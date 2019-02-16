Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EDD8C10F06
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 07:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31DD7222D0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 07:01:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728550AbfBPHBX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 02:01:23 -0500
Received: from mail-it1-f200.google.com ([209.85.166.200]:33355 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727760AbfBPHBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 02:01:07 -0500
Received: by mail-it1-f200.google.com with SMTP id a184so6450336itc.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 23:01:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=zKl1p0ajRD3ywxiftVearWUgogTF5nrGkZGzKH8oFLI=;
        b=tkcrBK184BgdjFOVBNeIeT9/4pSwSYzDuQLLqrt+wC69WGcjNxKhYD1Fr/fnmqLxa6
         QfSxi/zXirriigtn/Wsb4edXuFMAuXgNaPB3uSn+MvyCR85W670rNYvmS8yuK/RXe4xG
         eZe1NTMhSxnFrNXl2V/ETXDzCAWl+pLfp50hzGNVvH8bVXl433qB70Nw+WR2Ig6Bz5GV
         FJi8X2i5ldHLw3kxqlgV5FoMrxodFGf4l2AIpqqWYrZ3PPf9fBABYdelwuyumX+95Eli
         77cKJWyHJtbOQ9Kp3SGJRKPqnhh6xvmtKe8lkqavEYFlRB6vljvkN8bf+PJZjogO65v4
         VYNA==
X-Gm-Message-State: AHQUAuYTHTkVopkJnEQMKEIOsjuva3Y0WWlV/5ki7eLT9lGZ43kFF481
        GHyvqWBeL23gsctUMdIyfyZlyQTZjGmZnJVFokvlbo8ggrvw
X-Google-Smtp-Source: AHgI3IaKY+V4jyqfphhn1YOx7pAvrFdAfWSVJgzlucoUQCq3MAOK7vAyGJBIQ/mZYphoN0yjQEKFCzXdBuwhMTDHPUpUSnNOPCMd
MIME-Version: 1.0
X-Received: by 2002:a24:3a14:: with SMTP id m20mr7866969itm.1.1550300466511;
 Fri, 15 Feb 2019 23:01:06 -0800 (PST)
Date:   Fri, 15 Feb 2019 23:01:06 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009a0bd40581fd747b@google.com>
Subject: general protection fault in __vunmap
From:   syzbot <syzbot+39d3a56f2f717d237007@syzkaller.appspotmail.com>
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

HEAD commit:    cb5b020a8d38 Revert "exec: load_script: don't blindly trun..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13c2886cc00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ee434566c893c7b1
dashboard link: https://syzkaller.appspot.com/bug?extid=39d3a56f2f717d237007
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+39d3a56f2f717d237007@syzkaller.appspotmail.com

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 23956 Comm: syz-executor.3 Not tainted 5.0.0-rc6+ #72
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:__vunmap+0x68/0x400 mm/vmalloc.c:1508
Code: 85 e4 0f 85 de 02 00 00 e8 45 c7 d0 ff 4c 89 ef e8 9d 82 ff ff 48 ba  
00 00 00 00 00 fc ff df 48 8d 78 48 48 89 f9 48 c1 e9 03 <80> 3c 11 00 0f  
85 50 03 00 00 4c 8b 60 48 4d 85 e4 0f 84 bd 02 00
RSP: 0018:ffff88809613f4b0 EFLAGS: 00010206
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000009
RDX: dffffc0000000000 RSI: 0000000000000004 RDI: 0000000000000048
RBP: ffff88809613f4f0 R08: 1ffffffff1146d18 R09: fffffbfff1146d19
R10: fffffbfff1146d18 R11: ffffffff88a368c3 R12: 0000000000000000
R13: 0000004e00000000 R14: ffffe8ffffc71948 R15: 0000607f51471948
FS:  00007fa9e49b6700(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc7182d2000 CR3: 000000004b7bb000 CR4: 00000000001426f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  vfree+0x8d/0x140 mm/vmalloc.c:1597
  ipcomp_free_scratches+0xc0/0x150 net/xfrm/xfrm_ipcomp.c:216
  ipcomp_free_data net/xfrm/xfrm_ipcomp.c:325 [inline]
  ipcomp_init_state+0x76d/0xa10 net/xfrm/xfrm_ipcomp.c:377
  ipcomp6_init_state+0xc9/0x880 net/ipv6/ipcomp6.c:165
  __xfrm_init_state+0x557/0xef0 net/xfrm/xfrm_state.c:2302
  xfrm_init_state+0x1e/0x80 net/xfrm/xfrm_state.c:2328
  pfkey_msg2xfrm_state net/key/af_key.c:1307 [inline]
  pfkey_add+0x1da7/0x2fd0 net/key/af_key.c:1524
  pfkey_process+0x6d2/0x810 net/key/af_key.c:2844
  pfkey_sendmsg+0x40b/0xbe0 net/key/af_key.c:3683
  sock_sendmsg_nosec net/socket.c:621 [inline]
  sock_sendmsg+0xdd/0x130 net/socket.c:631
  ___sys_sendmsg+0x3e2/0x930 net/socket.c:2114
  __sys_sendmmsg+0x1c3/0x4e0 net/socket.c:2209
  __do_sys_sendmmsg net/socket.c:2238 [inline]
  __se_sys_sendmmsg net/socket.c:2235 [inline]
  __x64_sys_sendmmsg+0x9d/0x100 net/socket.c:2235
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457e29
Code: ad b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fa9e49b5c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000133
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 0000000000457e29
RDX: 0400000000000142 RSI: 0000000020000180 RDI: 0000000000000004
RBP: 000000000073c040 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fa9e49b66d4
R13: 00000000004c4dd8 R14: 00000000004d8a70 R15: 00000000ffffffff
Modules linked in:
kobject: 'loop4' (00000000647dbe39): kobject_uevent_env
kobject: 'loop4' (00000000647dbe39): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'kvm' (0000000078525e49): kobject_uevent_env
kobject: 'kvm' (0000000078525e49): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
---[ end trace 25e2186da6a07104 ]---
RIP: 0010:__vunmap+0x68/0x400 mm/vmalloc.c:1508
IPVS: ftp: loaded support on port[0] = 21
Code: 85 e4 0f 85 de 02 00 00 e8 45 c7 d0 ff 4c 89 ef e8 9d 82 ff ff 48 ba  
00 00 00 00 00 fc ff df 48 8d 78 48 48 89 f9 48 c1 e9 03 <80> 3c 11 00 0f  
85 50 03 00 00 4c 8b 60 48 4d 85 e4 0f 84 bd 02 00
kobject: 'kvm' (0000000078525e49): kobject_uevent_env
kobject: 'lo' (00000000532a5fa3): kobject_add_internal: parent: 'net',  
set: 'devices'
kobject: 'kvm' (0000000078525e49): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
RSP: 0018:ffff88809613f4b0 EFLAGS: 00010206
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000009
kobject: 'kvm' (0000000078525e49): kobject_uevent_env
kobject: 'lo' (00000000532a5fa3): kobject_uevent_env
RDX: dffffc0000000000 RSI: 0000000000000004 RDI: 0000000000000048
kobject: 'kvm' (0000000078525e49): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
RBP: ffff88809613f4f0 R08: 1ffffffff1146d18 R09: fffffbfff1146d19
kobject: 'lo' (00000000532a5fa3): fill_kobj_path: path  
= '/devices/virtual/net/lo'
R10: fffffbfff1146d18 R11: ffffffff88a368c3 R12: 0000000000000000
R13: 0000004e00000000 R14: ffffe8ffffc71948 R15: 0000607f51471948
kobject: 'loop4' (00000000647dbe39): kobject_uevent_env
kobject: 'loop4' (00000000647dbe39): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
FS:  00007fa9e49b6700(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
kobject: 'queues' (00000000ae77e0e8): kobject_add_internal: parent: 'lo',  
set: '<NULL>'
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000070a158 CR3: 000000004b7bb000 CR4: 00000000001406e0
kobject: 'loop5' (00000000975607f3): kobject_uevent_env
kobject: 'queues' (00000000ae77e0e8): kobject_uevent_env
kobject: 'loop5' (00000000975607f3): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'queues' (00000000ae77e0e8): kobject_uevent_env: filter function  
caused the event to drop!
kobject: 'rx-0' (000000002f4df33a): kobject_add_internal: parent: 'queues',  
set: 'queues'
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
