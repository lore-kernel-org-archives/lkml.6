Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E07CC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 016C120870
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:57:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 016C120870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbeLLK5F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 05:57:05 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:42177 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727200AbeLLK5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 05:57:04 -0500
Received: by mail-io1-f69.google.com with SMTP id y25so3528791ioc.9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 02:57:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=tlOuxyz7IKwsmsPWshgv/y8DUUv7+pveblDPEAIV9kc=;
        b=mnNDpCN7a+Y8ceJGA2//AHN2VJ+yfpfHb7zUE0MTgjfiIyRizKEMJzmk98QqU6weyl
         s0HK0KtMJoFcRWbbUjILWphLCuRIfvQ0TXlvgg4yXAaFk8/Mc6Qf9c2DLG2E4iJwTMp2
         JY98x6CFsCmEvAbZxGlq9WryOUsxiQI0IaTpS2CY1JR9RNt7jXZR1T/zY0oNoObbaWaH
         r6P+NRM67mGHW8pXmo/j41TQVlySOwarhX/6PaMzP8pev5sbVFADWWEL11jjrnebt/tO
         wxDhVODO68MdIt9iD4InteLkuXSbaRQVrdXg+UeHEuC+O4/KJMN5EgKETOyHG7ECw/9k
         24Xw==
X-Gm-Message-State: AA+aEWZef4nWmvAQtRoB9BV4mOGLgSd0kTvypbUxUKGyO49TpidMk+pp
        jJZ9xtwoVr2Cndq5wgfCLxhO/T3b4l6xci4xVU2kvQMjoe0B
X-Google-Smtp-Source: AFSGD/VuQpdqTddSXMFgmaQI0mNzC8gMEBjv+cWjr/+JM+31DHCuHqDUZqp1Tlvab+kkTjBeJtgU/S2N7i7h0omIJnFNPJQuzQPi
MIME-Version: 1.0
X-Received: by 2002:a6b:8e83:: with SMTP id q125mr15050188iod.9.1544612223547;
 Wed, 12 Dec 2018 02:57:03 -0800 (PST)
Date:   Wed, 12 Dec 2018 02:57:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e68826057cd10e99@google.com>
Subject: general protection fault in __ip_append_data
From:   syzbot <syzbot+aab62b9c7b12e7c6ab0b@syzkaller.appspotmail.com>
To:     davem@davemloft.net, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    f5d582777bcb Merge branch 'for-linus' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16e03afb400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c8970c89a0efbb23
dashboard link: https://syzkaller.appspot.com/bug?extid=aab62b9c7b12e7c6ab0b
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13bb9c8b400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1261667d400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+aab62b9c7b12e7c6ab0b@syzkaller.appspotmail.com

Enabling of bearer <udp:syz1> rejected, already enabled
Enabling of bearer <udp:syz1> rejected, already enabled
Enabling of bearer <udp:syz1> rejected, already enabled
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 16 Comm: ksoftirqd/1 Not tainted 4.20.0-rc6+ #371
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:__ip_append_data.isra.48+0x31a/0x29b0 net/ipv4/ip_output.c:896
Code: c7 85 c8 fd ff ff 00 00 00 00 0f 85 12 10 00 00 e8 7b c1 e0 fa 48 8b  
95 48 fe ff ff 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80> 3c 02 00 0f  
85 e5 22 00 00 48 8b 85 48 fe ff ff 48 8b 18 48 b8
RSP: 0018:ffff8881d9b569c0 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff869ec275
RDX: 0000000000000000 RSI: ffffffff869ec2f5 RDI: 0000000000000001
RBP: ffff8881d9b56c28 R08: ffff8881d9b4a440 R09: ffffffff86b113b0
R10: ffff8881d9b56da0 R11: 0000000000000000 R12: ffff8881d2c18a88
R13: ffffffff86258ba0 R14: ffffffff8bc37110 R15: ffff8881d2c18cd8
FS:  0000000000000000(0000) GS:ffff8881daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020001ac0 CR3: 00000001cb6ea000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  ip_append_data.part.49+0xef/0x170 net/ipv4/ip_output.c:1197
  ip_append_data+0x6d/0x90 net/ipv4/ip_output.c:1186
  icmp_push_reply+0x18e/0x540 net/ipv4/icmp.c:375
  icmp_send+0x1544/0x1bd0 net/ipv4/icmp.c:736
  __udp4_lib_rcv+0x2484/0x32e0 net/ipv4/udp.c:2233
  udp_rcv+0x21/0x30 net/ipv4/udp.c:2392
  ip_local_deliver_finish+0x2e9/0xda0 net/ipv4/ip_input.c:215
  NF_HOOK include/linux/netfilter.h:289 [inline]
  ip_local_deliver+0x1e9/0x750 net/ipv4/ip_input.c:256
  dst_input include/net/dst.h:450 [inline]
  ip_rcv_finish+0x1f9/0x300 net/ipv4/ip_input.c:415
  NF_HOOK include/linux/netfilter.h:289 [inline]
  ip_rcv+0xed/0x600 net/ipv4/ip_input.c:524
  __netif_receive_skb_one_core+0x14d/0x200 net/core/dev.c:4946
  __netif_receive_skb+0x2c/0x1e0 net/core/dev.c:5056
  process_backlog+0x24e/0x7a0 net/core/dev.c:5864
  napi_poll net/core/dev.c:6287 [inline]
  net_rx_action+0x7fa/0x19b0 net/core/dev.c:6353
  __do_softirq+0x308/0xb7e kernel/softirq.c:292
  run_ksoftirqd+0x5e/0x100 kernel/softirq.c:654
  smpboot_thread_fn+0x68b/0xa00 kernel/smpboot.c:164
  kthread+0x35a/0x440 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
Modules linked in:
---[ end trace 762165cda5fdc138 ]---
Enabling of bearer <udp:syz1> rejected, already enabled
RIP: 0010:__ip_append_data.isra.48+0x31a/0x29b0 net/ipv4/ip_output.c:896
Code: c7 85 c8 fd ff ff 00 00 00 00 0f 85 12 10 00 00 e8 7b c1 e0 fa 48 8b  
95 48 fe ff ff 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80> 3c 02 00 0f  
85 e5 22 00 00 48 8b 85 48 fe ff ff 48 8b 18 48 b8
Enabling of bearer <udp:syz1> rejected, already enabled
RSP: 0018:ffff8881d9b569c0 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff869ec275
RDX: 0000000000000000 RSI: ffffffff869ec2f5 RDI: 0000000000000001
RBP: ffff8881d9b56c28 R08: ffff8881d9b4a440 R09: ffffffff86b113b0
R10: ffff8881d9b56da0 R11: 0000000000000000 R12: ffff8881d2c18a88
R13: ffffffff86258ba0 R14: ffffffff8bc37110 R15: ffff8881d2c18cd8
Enabling of bearer <udp:syz1> rejected, already enabled
FS:  0000000000000000(0000) GS:ffff8881daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020001ac0 CR3: 000000000946a000 CR4: 00000000001406e0
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
