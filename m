Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27552C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 06:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E74E12087E
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 06:41:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728055AbfAHGlG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 01:41:06 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:34796 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727927AbfAHGlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 01:41:04 -0500
Received: by mail-io1-f71.google.com with SMTP id q16so2441723ios.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 22:41:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=YGzTGMSTMWR5RM3X0S7BndkhUMgQwpYf2pl9MNeMXdg=;
        b=jTFu9lvAMJcPyt+QCNdS3E8ejLG8vYHszkDmaaUfoMgS4FQPSQP0OV6sFFDUur1E8G
         VOzu+jo9dj6VnjMtUFx7npSFjIuRkMmobNLQsYAKkYBK7MNGkM7LQhPkkpyVOoSIqwkF
         XKh0AaLqrAbOAumGCkcXByH1DmwtsHdPT7UDijvmTDMdkbS/MIgqqoeMQeuS2CQEXfvH
         ARzbS5Yide1QZcrGCscAYvD8h0lkIyQmBoYnyN5/jf+S+C1C3mR4Q++Q6RxPc33uFY6A
         1ZvgLntohIfiGC6uXX0po18Z9Bb6slZIs1m+jCkMyvz+p4BegLicV3u93TzBGFVVvF16
         tp/Q==
X-Gm-Message-State: AJcUukfpmB2CJqMVR7X91Erq54V1xEqb7+gKBFqBRFURhOXVYBaYXKKm
        faMKK9c86m+0/Ttp4+YdugjjCzuKgmm3lDLpOyEE338C/M5L
X-Google-Smtp-Source: ALg8bN4o4teqKexAzsTaIoDhd6aPXjHONZeoGjGDp0ueU6HtC3846c9aWAo2QDbmrd7Z7rwZLGP/1mWthXlnk38x2d2SP4r/0glI
MIME-Version: 1.0
X-Received: by 2002:a02:b807:: with SMTP id o7mr344427jam.23.1546929663721;
 Mon, 07 Jan 2019 22:41:03 -0800 (PST)
Date:   Mon, 07 Jan 2019 22:41:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000194b2a057eeca129@google.com>
Subject: general protection fault in ipcomp_init_state
From:   syzbot <syzbot+0864346ae616fffdd602@syzkaller.appspotmail.com>
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

HEAD commit:    b71acb0e3721 Merge branch 'linus' of git://git.kernel.org/..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17f383bb400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b03c5892bb940c76
dashboard link: https://syzkaller.appspot.com/bug?extid=0864346ae616fffdd602
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+0864346ae616fffdd602@syzkaller.appspotmail.com

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
sit: non-ECT from 172.20.255.187 with TOS=0x1
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 25310 Comm: syz-executor0 Not tainted 4.20.0+ #3
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:strcmp+0x3a/0xb0 lib/string.c:328
Code: 41 55 41 54 53 48 89 fb 48 83 ec 08 eb 08 45 84 e4 74 5f 4c 89 ee 48  
89 df 48 83 c3 01 48 89 f8 48 89 fa 48 c1 e8 03 83 e2 07 <42> 0f b6 04 30  
38 d0 7f 04 84 c0 75 54 44 0f b6 63 ff 4c 8d 6e 01
RSP: 0018:ffff88806190f3b0 EFLAGS: 00010246
RAX: 0000000000000007 RBX: 0000000000000039 RCX: 1ffff11010bdaced
RDX: 0000000000000000 RSI: ffff88809c33d000 RDI: 0000000000000038
RBP: ffff88806190f3d8 R08: ffff8880642ba040 R09: fffffbfff1478e45
R10: ffff88806190f3d8 R11: ffffffff8a3c7227 R12: dffffc0000000000
R13: ffff8880a6199380 R14: dffffc0000000000 R15: ffff88806190f4a8
FS:  00007f6f19d31700(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000002908c10 CR3: 0000000090cb7000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  ipcomp_alloc_tfms net/xfrm/xfrm_ipcomp.c:288 [inline]
  ipcomp_init_state+0x244/0xbc0 net/xfrm/xfrm_ipcomp.c:363
  ipcomp4_init_state+0x10d/0xb10 net/ipv4/ipcomp.c:137
  __xfrm_init_state+0x62a/0x1060 net/xfrm/xfrm_state.c:2302
  xfrm_init_state+0x1e/0x80 net/xfrm/xfrm_state.c:2328
  pfkey_msg2xfrm_state net/key/af_key.c:1307 [inline]
  pfkey_add+0x1da8/0x3180 net/key/af_key.c:1524
  pfkey_process+0x6d2/0x810 net/key/af_key.c:2844
  pfkey_sendmsg+0x5bb/0xfc0 net/key/af_key.c:3683
  sock_sendmsg_nosec net/socket.c:621 [inline]
  sock_sendmsg+0xdd/0x130 net/socket.c:631
sit: non-ECT from 172.20.255.187 with TOS=0x1
  ___sys_sendmsg+0x7ec/0x910 net/socket.c:2116
  __sys_sendmsg+0x112/0x270 net/socket.c:2154
  __do_sys_sendmsg net/socket.c:2163 [inline]
  __se_sys_sendmsg net/socket.c:2161 [inline]
  __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2161
  do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457ec9
Code: 6d b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 3b b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
kobject: 'loop3' (00000000958bbf02): kobject_uevent_env
RSP: 002b:00007f6f19d30c78 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457ec9
RDX: 0000000000000000 RSI: 0000000020000000 RDI: 0000000000000005
RBP: 000000000073bfa0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f6f19d316d4
R13: 00000000004c5305 R14: 00000000004d8d70 R15: 00000000ffffffff
Modules linked in:
---[ end trace b27bff8084733df2 ]---
kobject: 'loop3' (00000000958bbf02): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
RIP: 0010:strcmp+0x3a/0xb0 lib/string.c:328
kobject: 'loop4' (00000000a9a61426): kobject_uevent_env
Code: 41 55 41 54 53 48 89 fb 48 83 ec 08 eb 08 45 84 e4 74 5f 4c 89 ee 48  
89 df 48 83 c3 01 48 89 f8 48 89 fa 48 c1 e8 03 83 e2 07 <42> 0f b6 04 30  
38 d0 7f 04 84 c0 75 54 44 0f b6 63 ff 4c 8d 6e 01
TCP: request_sock_TCPv6: Possible SYN flooding on port 20002. Sending  
cookies.  Check SNMP counters.
netlink: 'syz-executor1': attribute type 1 has an invalid length.
kobject: 'loop4' (00000000a9a61426): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
sit: non-ECT from 172.20.255.187 with TOS=0x1
netlink: 'syz-executor1': attribute type 1 has an invalid length.
kobject: 'loop1' (0000000079f16328): kobject_uevent_env
RSP: 0018:ffff88806190f3b0 EFLAGS: 00010246
kobject: 'loop1' (0000000079f16328): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
RAX: 0000000000000007 RBX: 0000000000000039 RCX: 1ffff11010bdaced
kobject: 'loop2' (00000000ab521588): kobject_uevent_env
sit: non-ECT from 172.20.255.187 with TOS=0x1
RDX: 0000000000000000 RSI: ffff88809c33d000 RDI: 0000000000000038
kobject: 'loop2' (00000000ab521588): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
netlink: 'syz-executor1': attribute type 1 has an invalid length.
RBP: ffff88806190f3d8 R08: ffff8880642ba040 R09: fffffbfff1478e45
kobject: 'loop2' (00000000ab521588): kobject_uevent_env
kobject: 'loop2' (00000000ab521588): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
R10: ffff88806190f3d8 R11: ffffffff8a3c7227 R12: dffffc0000000000
R13: ffff8880a6199380 R14: dffffc0000000000 R15: ffff88806190f4a8
kobject: 'loop1' (0000000079f16328): kobject_uevent_env
FS:  00007f6f19d31700(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
kobject: 'loop1' (0000000079f16328): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000070a158 CR3: 0000000090cb7000 CR4: 00000000001406e0
kobject: 'loop5' (00000000a2544941): kobject_uevent_env
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
kobject: 'loop5' (00000000a2544941): fill_kobj_path: path  
= '/devices/virtual/block/loop5'


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
