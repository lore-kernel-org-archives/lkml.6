Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD47BC46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 12:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9495921756
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 12:54:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9495921756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729826AbeHMPgN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 11:36:13 -0400
Received: from mail-io0-f198.google.com ([209.85.223.198]:43530 "EHLO
        mail-io0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728966AbeHMPgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 11:36:13 -0400
Received: by mail-io0-f198.google.com with SMTP id w19-v6so13703013ioa.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 05:54:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=I2COuKOF6iflk6AxlWpmh8cCPIgdeSrsXgs0Ac4MA1g=;
        b=Lht41a7/3nB7K8LSO5k4UYWpGTyMzhzdBm+ZLGwjUSEkZShc+nmTQUoYYh8qjhsuJU
         zR+cV054Yw5kFJqYtXuT+IsICiRtZOV/kMNALSA3FZtOMEhKrm+KqYSx03ZJTn+AyVnK
         IhUjMLkr2YjLTC7UwdxJjrIvwblZmVegNb8sNELD7G5bBzf+ymv/SIFDkScD4k7bGcDx
         2dyNRlK95ZpmqxItKrP15sn32cK4WOsRKjiN/78D817EFlvZEBsXrq1wWFFmxUVhkN8X
         tlNWErFYlc9dblnqruNMX7z/uRLQhaCrh6Wk9uJHRFVM/iCsNTooPACelDGO+yeDSP85
         n5vw==
X-Gm-Message-State: AOUpUlG7cbtoJuzEvhKdmEA0R+1fS4aFhfecENNVVECIEQ0v2x5isadx
        XtFs5YoEEWeT0IMOOVrfkUeHsr3dV4GTe6qIWqd3OqP2MdmD
X-Google-Smtp-Source: AA+uWPylY9YRLDvyRpQsCX2FsiaJWLPJdseVfrgv3RrMMGCPsq/jaiJyFuPDco80dmn7im1x5xdS82qrxnMpCeJMRwjql7NP8AYw
MIME-Version: 1.0
X-Received: by 2002:a24:391:: with SMTP id e139-v6mr6337997ite.29.1534164843057;
 Mon, 13 Aug 2018 05:54:03 -0700 (PDT)
Date:   Mon, 13 Aug 2018 05:54:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007f59610573509684@google.com>
Subject: general protection fault in send_sigurg_to_task
From:   syzbot <syzbot+1f371ca19b341a276761@syzkaller.appspotmail.com>
To:     bfields@fieldses.org, jlayton@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    5ed5da74de9e Add linux-next specific files for 20180813
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16c2a63c400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=18edf0289d1b5ab
dashboard link: https://syzkaller.appspot.com/bug?extid=1f371ca19b341a276761
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+1f371ca19b341a276761@syzkaller.appspotmail.com

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] SMP KASAN
CPU: 0 PID: 19114 Comm: syz-executor6 Not tainted 4.18.0-next-20180813+ #37
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:__read_once_size include/linux/compiler.h:188 [inline]
RIP: 0010:sigio_perm fs/fcntl.c:715 [inline]
RIP: 0010:send_sigurg_to_task+0xf5/0x4d0 fs/fcntl.c:810
Code: 61 af b1 ff 45 84 f6 0f 84 52 03 00 00 e8 83 ae b1 ff 49 8d bf 58 06  
00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f  
85 91 03 00 00 48 8d 43 c0 4d 8b b7 58 06 00 00 48
RSP: 0018:ffff88019afc74a8 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffff88019afc7518 RCX: ffffc9000643f000
RDX: 00000000000000cb RSI: ffffffff81cadf6d RDI: 0000000000000658
RBP: ffff88019afc7540 R08: ffff8801b16ae5c0 R09: ffffed003b6046d6
R10: ffffed003b6046d6 R11: ffff8801db0236b3 R12: 1ffff100335f8e97
R13: ffff8801cb8ddb48 R14: 0000000000000001 R15: 0000000000000000
FS:  00007f2e92a99700(0000) GS:ffff8801db000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa4f3c16e18 CR3: 00000001b2e21000 CR4: 00000000001406f0
Call Trace:
  send_sigurg+0x342/0x480 fs/fcntl.c:833
  sk_send_sigurg+0xd2/0x3d0 net/core/sock.c:2731
  tcp_check_urg net/ipv4/tcp_input.c:5266 [inline]
  tcp_urg+0x3c3/0xba0 net/ipv4/tcp_input.c:5307
  tcp_rcv_established+0xd45/0x2130 net/ipv4/tcp_input.c:5637
  tcp_v4_do_rcv+0x635/0x8f0 net/ipv4/tcp_ipv4.c:1532
  sk_backlog_rcv include/net/sock.h:931 [inline]
  __release_sock+0x12f/0x3a0 net/core/sock.c:2336
  release_sock+0xad/0x2c0 net/core/sock.c:2849
  tcp_sendmsg+0x3a/0x50 net/ipv4/tcp.c:1444
  inet_sendmsg+0x1a1/0x690 net/ipv4/af_inet.c:798
  sock_sendmsg_nosec net/socket.c:622 [inline]
  sock_sendmsg+0xd5/0x120 net/socket.c:632
  __sys_sendto+0x3d7/0x670 net/socket.c:1787
  __do_sys_sendto net/socket.c:1799 [inline]
  __se_sys_sendto net/socket.c:1795 [inline]
  __x64_sys_sendto+0xe1/0x1a0 net/socket.c:1795
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457089
Code: fd b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f2e92a98c78 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007f2e92a996d4 RCX: 0000000000457089
RDX: fffffffffffffd43 RSI: 0000000020de1fff RDI: 0000000000000004
RBP: 00000000009300a0 R08: 0000000020db4ff0 R09: 0000000000000010
R10: 0000000020008005 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000004d3d08 R14: 00000000004c898d R15: 0000000000000000
Modules linked in:
Dumping ftrace buffer:
    (ftrace buffer empty)
---[ end trace dc729739ab19eafd ]---
RIP: 0010:__read_once_size include/linux/compiler.h:188 [inline]
RIP: 0010:sigio_perm fs/fcntl.c:715 [inline]
RIP: 0010:send_sigurg_to_task+0xf5/0x4d0 fs/fcntl.c:810
Code: 61 af b1 ff 45 84 f6 0f 84 52 03 00 00 e8 83 ae b1 ff 49 8d bf 58 06  
00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f  
85 91 03 00 00 48 8d 43 c0 4d 8b b7 58 06 00 00 48
RSP: 0018:ffff88019afc74a8 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffff88019afc7518 RCX: ffffc9000643f000
RDX: 00000000000000cb RSI: ffffffff81cadf6d RDI: 0000000000000658
RBP: ffff88019afc7540 R08: ffff8801b16ae5c0 R09: ffffed003b6046d6
R10: ffffed003b6046d6 R11: ffff8801db0236b3 R12: 1ffff100335f8e97
R13: ffff8801cb8ddb48 R14: 0000000000000001 R15: 0000000000000000
FS:  00007f2e92a99700(0000) GS:ffff8801db000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa4f3c16e18 CR3: 00000001b2e21000 CR4: 00000000001406f0


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
