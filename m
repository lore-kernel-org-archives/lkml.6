Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB31C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 18:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 680F420824
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 18:03:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 680F420824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437680AbeKWEnb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 23:43:31 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:32954 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732278AbeKWEnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 23:43:31 -0500
Received: by mail-io1-f70.google.com with SMTP id u13-v6so9179484iob.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 10:03:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=+NdZJj1V8I9MZkQ0QUMQVfLUIOadmpfUNODSzGWGvG4=;
        b=YGRV0L6b1KXiaOgY7249+eRw1p7BseGaY7mWut2hHEVBTDr/2RlRoMyi0i+wTF/Rn2
         jSDiLwPiHOu7TrDL3Kd2kZZ6a08ld4Gk03Clu2ub13SlHCQPda7xfI34CZAzqiPnOlbd
         jbpFoZLLIaKiIPkII0/xCqY4fNf5ZLy1/O5qkbPdMXn7v34Iv4hVCGaHBhHzPT/BW+lf
         ecR5Alsd6SNsnVFP9b3NSHysUZuGPqEpTgH1Vbnm8Ok8cr8KbFHV6zvk89jlXmWrZj/k
         NPLBQ8mfDZ270mone/U+4eu0Q3EDVZUaRNwegWLr0vlW+xGEmMwRizXpKhsIvRIX1NJn
         foEw==
X-Gm-Message-State: AGRZ1gIlzWOBke2nZsF7/wHg3A4mN/l32rYPEPPplEu70GXzPkMyfA2e
        YQ8k0eSmxYlz6YbnvN8oQoeS+nl0f5A3B8dh3BwuxoiUh6yi
X-Google-Smtp-Source: AJdET5eTdxQ19G47zBVCE76KRCsw7ZkZsyWJRyVQcPdhOCs+VagPVJnkJNcJPa+tVyf/aSOWgx+O6ciMiVoysuIgEaR+SBOu8Ir/
MIME-Version: 1.0
X-Received: by 2002:a24:5dd4:: with SMTP id w203mr7719185ita.8.1542909782760;
 Thu, 22 Nov 2018 10:03:02 -0800 (PST)
Date:   Thu, 22 Nov 2018 10:03:02 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000085abf7057b44ad08@google.com>
Subject: invalid opcode in ip_do_fragment
From:   syzbot <syzbot+865704dc4f7ff5d1a04b@syzkaller.appspotmail.com>
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

HEAD commit:    92b419289cee Merge tag 'riscv-for-linus-4.20-rc4' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12243093400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=73e2bc0cb6463446
dashboard link: https://syzkaller.appspot.com/bug?extid=865704dc4f7ff5d1a04b
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+865704dc4f7ff5d1a04b@syzkaller.appspotmail.com

invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 21078 Comm: syz-executor1 Not tainted 4.20.0-rc3+ #344
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:ip_do_fragment+0x2447/0x2ad0 net/ipv4/ip_output.c:776
Code: ff 48 89 cf e8 2a 36 23 fb e9 dc ea ff ff 48 89 df e8 5d 36 23 fb e9  
02 e7 ff ff e8 b3 36 23 fb e9 97 e6 ff ff e8 29 e7 df fa <0f> 0b 4c 89 f7  
e8 ff 35 23 fb e9 2f e6 ff ff 4c 89 e7 e8 f2 35 23
RSP: 0018:ffff88818232e7b8 EFLAGS: 00010246
RAX: 0000000000040000 RBX: ffff8881d3af0800 RCX: ffffc9000c0db000
RDX: 0000000000040000 RSI: ffffffff869fa3c7 RDI: 0000000000000005
RBP: ffff88818232e990 R08: ffff88816ba06580 R09: ffffed10342f86ca
R10: ffffed10342f86cc R11: ffff8881a17c3663 R12: ffff8881d3af08c4
R13: 00000000fffffff2 R14: ffff8881d3af08d0 R15: dffffc0000000000
FS:  00007fa003fcd700(0000) GS:ffff8881dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000004ccd10 CR3: 0000000199f89000 CR4: 00000000001426f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  ip_fragment.constprop.50+0x179/0x240 net/ipv4/ip_output.c:549
  ip_finish_output+0x6b4/0xfa0 net/ipv4/ip_output.c:315
  NF_HOOK_COND include/linux/netfilter.h:278 [inline]
  ip_output+0x21d/0x8d0 net/ipv4/ip_output.c:405
  dst_output include/net/dst.h:444 [inline]
  ip_local_out+0xc5/0x1b0 net/ipv4/ip_output.c:124
  iptunnel_xmit+0x63b/0x9c0 net/ipv4/ip_tunnel_core.c:91
  ip_tunnel_xmit+0x15b8/0x3c04 net/ipv4/ip_tunnel.c:787
  __gre_xmit+0x5e1/0x980 net/ipv4/ip_gre.c:451
  ipgre_xmit+0x3e7/0xba0 net/ipv4/ip_gre.c:705
  __netdev_start_xmit include/linux/netdevice.h:4356 [inline]
  netdev_start_xmit include/linux/netdevice.h:4365 [inline]
  xmit_one net/core/dev.c:3252 [inline]
  dev_hard_start_xmit+0x295/0xc80 net/core/dev.c:3268
  __dev_queue_xmit+0x2f71/0x3ad0 net/core/dev.c:3838
  dev_queue_xmit+0x17/0x20 net/core/dev.c:3871
  __bpf_tx_skb net/core/filter.c:2017 [inline]
  __bpf_redirect_common net/core/filter.c:2055 [inline]
  __bpf_redirect+0x5cf/0xb20 net/core/filter.c:2062
  ____bpf_clone_redirect net/core/filter.c:2095 [inline]
  bpf_clone_redirect+0x2f6/0x490 net/core/filter.c:2067
  bpf_prog_bebbfe2050753572+0x7dd/0x1000
Modules linked in:
---[ end trace 0d51d2ed64b21356 ]---
RIP: 0010:ip_do_fragment+0x2447/0x2ad0 net/ipv4/ip_output.c:776
Code: ff 48 89 cf e8 2a 36 23 fb e9 dc ea ff ff 48 89 df e8 5d 36 23 fb e9  
02 e7 ff ff e8 b3 36 23 fb e9 97 e6 ff ff e8 29 e7 df fa <0f> 0b 4c 89 f7  
e8 ff 35 23 fb e9 2f e6 ff ff 4c 89 e7 e8 f2 35 23
RSP: 0018:ffff88818232e7b8 EFLAGS: 00010246
RAX: 0000000000040000 RBX: ffff8881d3af0800 RCX: ffffc9000c0db000
RDX: 0000000000040000 RSI: ffffffff869fa3c7 RDI: 0000000000000005
RBP: ffff88818232e990 R08: ffff88816ba06580 R09: ffffed10342f86ca
R10: ffffed10342f86cc R11: ffff8881a17c3663 R12: ffff8881d3af08c4
R13: 00000000fffffff2 R14: ffff8881d3af08d0 R15: dffffc0000000000
FS:  00007fa003fcd700(0000) GS:ffff8881dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000004ccd10 CR3: 0000000199f89000 CR4: 00000000001426f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
