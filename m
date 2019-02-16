Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B09C10F06
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 07:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2997B222D0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 07:01:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728233AbfBPHBK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 02:01:10 -0500
Received: from mail-it1-f197.google.com ([209.85.166.197]:50867 "EHLO
        mail-it1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727769AbfBPHBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 02:01:08 -0500
Received: by mail-it1-f197.google.com with SMTP id p66so19987614itc.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 23:01:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=gKDBJiKNcKYQss7Fan3UQvZdUd/CzjdtPIMwKhQDsBs=;
        b=SaD53n0zi5xT9OzoqP5fpLxThM7bMX5H4nRA3L34ycEnIF3I7YDZzqzXbuNgQYTidm
         rVsZ9X2wbJeGoClGTXKpnZetQ4zM5i5ELvdxyv9+hvIh0E6+Wau6d4zAkrzsfOlWZUf0
         mnoFz24dYWgaM2M9sP6UsqUE4dzmE5J0lylPFfZQpfbWs3+z/hbJF+apxEnmAPrgSHNb
         /TtisMMWYc5V2YamRrWlOClMD9qylFTfPR2m2ucLxs6hlFWOXtFNfbRutGji+Uh3z8+V
         LmibnBqAyuYej9DbKFavaH87g4Oho4sxKPxU+ZWyXjWz+kC+EwYfdng19YQvoYcyJbDo
         zk+w==
X-Gm-Message-State: AHQUAuYTcZvLqSNKBLT5u93X+DjPw4a+E4HByDrLsx9tSZWaWYN8mhcf
        CG/u/BZjjQw/oD0xeL/OeXpdjU39Bd+3YlqLgkm92+yVRMCr
X-Google-Smtp-Source: AHgI3IZLvvJ/LZHBGh2KNNzJVDa8f3FeiWVaIOzjAxYHR4IDHq1zZ1tlvB9pUrYXPpU8jPUozFk0SleiEyYNEw0rxGQ6NPjZigLW
MIME-Version: 1.0
X-Received: by 2002:a24:6852:: with SMTP id v79mr7623043itb.29.1550300466786;
 Fri, 15 Feb 2019 23:01:06 -0800 (PST)
Date:   Fri, 15 Feb 2019 23:01:06 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009e38f10581fd7499@google.com>
Subject: general protection fault in reuseport_add_sock
From:   syzbot <syzbot+675ee297acac988852c1@syzkaller.appspotmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
        kafai@fb.com, linux-kernel@vger.kernel.org, lucien.xin@gmail.com,
        netdev@vger.kernel.org, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    f9bcc9f3ee4f net: ethernet: freescale: set FEC ethtool reg..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=158a10f3400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f00801d7b7c4fe6
dashboard link: https://syzkaller.appspot.com/bug?extid=675ee297acac988852c1
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+675ee297acac988852c1@syzkaller.appspotmail.com

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
kobject: 'loop2' (000000005809b865): kobject_uevent_env
CPU: 1 PID: 14725 Comm: syz-executor.3 Not tainted 5.0.0-rc5+ #78
kobject: 'loop2' (000000005809b865): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:reuseport_add_sock+0x187/0x8f0 net/core/sock_reuseport.c:170
Code: e8 ce 4e f2 fb 66 83 fb 01 0f 85 54 06 00 00 e8 5f 4d f2 fb 4d 8d 74  
24 12 48 b8 00 00 00 00 00 fc ff df 4c 89 f2 48 c1 ea 03 <0f> b6 14 02 4c  
89 f0 83 e0 07 83 c0 01 38 d0 7c 08 84 d2 0f 85 fc
RSP: 0018:ffff888066abfca0 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000000000001 RCX: ffffc9000c432000
RDX: 0000000000000002 RSI: ffffffff857d8dc1 RDI: 0000000000000005
kobject: 'loop4' (00000000b88abefc): kobject_uevent_env
RBP: ffff888066abfd08 R08: ffff888064ff43c0 R09: fffffbfff1264fcd
R10: fffffbfff1264fcc R11: ffffffff89327e63 R12: 0000000000000000
R13: ffff888098d9c800 R14: 0000000000000012 R15: 0000000000000000
kobject: 'loop4' (00000000b88abefc): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
FS:  00007f02a40cf700(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000004563fa CR3: 000000009ae04000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  __sctp_hash_endpoint net/sctp/input.c:758 [inline]
  sctp_hash_endpoint+0x523/0x5d0 net/sctp/input.c:786
  sctp_listen_start net/sctp/socket.c:7967 [inline]
  sctp_inet_listen+0x5b2/0x880 net/sctp/socket.c:8022
kobject: 'loop5' (0000000099e34deb): kobject_uevent_env
  __sys_listen+0x19b/0x270 net/socket.c:1515
kobject: 'loop5' (0000000099e34deb): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
  __do_sys_listen net/socket.c:1524 [inline]
  __se_sys_listen net/socket.c:1522 [inline]
  __x64_sys_listen+0x54/0x80 net/socket.c:1522
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457e29
kobject: 'loop1' (00000000259faa1c): kobject_uevent_env
Code: ad b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f02a40cec78 EFLAGS: 00000246 ORIG_RAX: 0000000000000032
kobject: 'loop1' (00000000259faa1c): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 0000000000457e29
RDX: 0000000000000000 RSI: 0000000100000001 RDI: 0000000000000005
RBP: 000000000073bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f02a40cf6d4
R13: 00000000004c3a2d R14: 00000000004d6940 R15: 00000000ffffffff
Modules linked in:
---[ end trace 3ce5847aad8cc1f0 ]---
RIP: 0010:reuseport_add_sock+0x187/0x8f0 net/core/sock_reuseport.c:170
Code: e8 ce 4e f2 fb 66 83 fb 01 0f 85 54 06 00 00 e8 5f 4d f2 fb 4d 8d 74  
24 12 48 b8 00 00 00 00 00 fc ff df 4c 89 f2 48 c1 ea 03 <0f> b6 14 02 4c  
89 f0 83 e0 07 83 c0 01 38 d0 7c 08 84 d2 0f 85 fc
RSP: 0018:ffff888066abfca0 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000000000001 RCX: ffffc9000c432000
RDX: 0000000000000002 RSI: ffffffff857d8dc1 RDI: 0000000000000005
RBP: ffff888066abfd08 R08: ffff888064ff43c0 R09: fffffbfff1264fcd
R10: fffffbfff1264fcc R11: ffffffff89327e63 R12: 0000000000000000
R13: ffff888098d9c800 R14: 0000000000000012 R15: 0000000000000000
FS:  00007f02a40cf700(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000004563fa CR3: 000000009ae04000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
