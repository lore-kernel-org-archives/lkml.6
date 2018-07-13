Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3793BECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 08:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E82BA2124D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 08:00:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E82BA2124D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387718AbeGMINc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 04:13:32 -0400
Received: from mail-it0-f69.google.com ([209.85.214.69]:57254 "EHLO
        mail-it0-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729790AbeGMINc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 04:13:32 -0400
Received: by mail-it0-f69.google.com with SMTP id g4-v6so6713447itf.6
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 01:00:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=bKflRJUUmQUD769dL2iyBNnu91xIuj6vUQ3X3n9aLSU=;
        b=KRsikAmMwkT8WHa9meED1wu+PKujYoH2PDlrDrQs7pQQfjezYG0qz6M2S8fuUfCOzB
         fqIV5VhLC4bmso5Ew/Z8REOSL1osHT7cEaq+5FTy/R8Y/itt26sOaPp3vtEucBpnOJvT
         2aLbl17BVzKj+NMXNt3UQqM2s6es/VCOiRZHXu2H7/SJ2kn3iuv0P0wbne/uAGUeabNt
         6jCPlbZ09kmg89xEU7W3UBQju2wwljxvrQL3RE188z/j3NjMhcMteQvThFfV6Iueme2K
         Atqo9DUfGh/LnHLxeNsL87bMkKMR/XAmEQNksvSOrPd1Z9CR+8SSELXLYENHfx//Xx7s
         f18A==
X-Gm-Message-State: AOUpUlFKg91dAc8bFNHmzdHMz+OCzvmwcpBQQHTK1I23gQ3pmIDczxTh
        gtqqjJyBqihSItFhRBuliL9ZjAZn59N4Dcb2/liwYW+6e+T+
X-Google-Smtp-Source: AAOMgpdZJGB3OivbDUFAQMUTwLNL/tKs1wdrt+2Ztd9wDCzm0B0uOdSDz9GKtUtB43Io4gkNn4HKi8XKZBtQ3eWKmgze/dM6n5/z
MIME-Version: 1.0
X-Received: by 2002:a24:b14a:: with SMTP id c10-v6mr2089816itj.4.1531468802589;
 Fri, 13 Jul 2018 01:00:02 -0700 (PDT)
Date:   Fri, 13 Jul 2018 01:00:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f68d660570dcddd8@google.com>
Subject: kernel BUG at net/ipv4/ip_output.c:LINE!
From:   syzbot <syzbot+90d5ec0c05e708f3b66d@syzkaller.appspotmail.com>
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

HEAD commit:    c25c74b7476e Merge tag 'trace-v4.18-rc3-2' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1708b92c400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=25856fac4e580aa7
dashboard link: https://syzkaller.appspot.com/bug?extid=90d5ec0c05e708f3b66d
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+90d5ec0c05e708f3b66d@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at net/ipv4/ip_output.c:773!
invalid opcode: 0000 [#1] SMP KASAN
CPU: 0 PID: 15085 Comm: syz-executor7 Not tainted 4.18.0-rc4+ #143
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:ip_do_fragment+0x2468/0x2ae0 net/ipv4/ip_output.c:773
Code: 8b 8d 70 fe ff ff e9 67 e8 ff ff 4c 89 ef e8 df 7a 57 fb e9 49 e9 ff  
ff 4c 89 f7 e8 d2 7a 57 fb e9 c1 e5 ff ff e8 b8 a0 19 fb <0f> 0b 4c 89 e7  
e8 be 7a 57 fb e9 85 e8 ff ff 4c 89 f7 89 8d 70 fe
RSP: 0018:ffff880195016880 EFLAGS: 00010246
RAX: 0000000000040000 RBX: ffff8801ce7be940 RCX: ffffc90002a12000
RDX: 0000000000040000 RSI: ffffffff86626ae8 RDI: 0000000000000005
RBP: ffff880195016a58 R08: ffff8801c66e8180 R09: ffffed00323180ba
R10: ffffed00323180bc R11: ffff8801918c05e3 R12: ffff8801ce7bea04
R13: 00000000fffffff2 R14: ffff8801ce7bea10 R15: dffffc0000000000
FS:  00007effc88a9700(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffdeada9000 CR3: 00000001b3b5d000 CR4: 00000000001406f0
DR0: 0000000020000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
Call Trace:
  ip_fragment.constprop.49+0x179/0x240 net/ipv4/ip_output.c:546
  ip_finish_output+0x6e4/0xfa0 net/ipv4/ip_output.c:315
  NF_HOOK_COND include/linux/netfilter.h:276 [inline]
  ip_output+0x223/0x880 net/ipv4/ip_output.c:405
  dst_output include/net/dst.h:444 [inline]
  ip_local_out+0xc5/0x1b0 net/ipv4/ip_output.c:124
  iptunnel_xmit+0x567/0x850 net/ipv4/ip_tunnel_core.c:91
  ip_tunnel_xmit+0x1598/0x3af1 net/ipv4/ip_tunnel.c:778
  __gre_xmit+0x5e1/0x980 net/ipv4/ip_gre.c:449
  ipgre_xmit+0x3e8/0xb50 net/ipv4/ip_gre.c:701
  __netdev_start_xmit include/linux/netdevice.h:4148 [inline]
  netdev_start_xmit include/linux/netdevice.h:4157 [inline]
  xmit_one net/core/dev.c:3034 [inline]
  dev_hard_start_xmit+0x26c/0xc30 net/core/dev.c:3050
  __dev_queue_xmit+0x29ef/0x3910 net/core/dev.c:3569
  dev_queue_xmit+0x17/0x20 net/core/dev.c:3602
  __bpf_tx_skb net/core/filter.c:1952 [inline]
  __bpf_redirect_common net/core/filter.c:1990 [inline]
  __bpf_redirect+0x5b7/0xae0 net/core/filter.c:1997
  ____bpf_clone_redirect net/core/filter.c:2030 [inline]
  bpf_clone_redirect+0x2f6/0x490 net/core/filter.c:2002
  bpf_prog_bebbfe2050753572+0x12c/0x1000
Modules linked in:
Dumping ftrace buffer:
    (ftrace buffer empty)
---[ end trace 2c302777c0a564f9 ]---
RIP: 0010:ip_do_fragment+0x2468/0x2ae0 net/ipv4/ip_output.c:773
Code: 8b 8d 70 fe ff ff e9 67 e8 ff ff 4c 89 ef e8 df 7a 57 fb e9 49 e9 ff  
ff 4c 89 f7 e8 d2 7a 57 fb e9 c1 e5 ff ff e8 b8 a0 19 fb <0f> 0b 4c 89 e7  
e8 be 7a 57 fb e9 85 e8 ff ff 4c 89 f7 89 8d 70 fe
RSP: 0018:ffff880195016880 EFLAGS: 00010246
RAX: 0000000000040000 RBX: ffff8801ce7be940 RCX: ffffc90002a12000
RDX: 0000000000040000 RSI: ffffffff86626ae8 RDI: 0000000000000005
RBP: ffff880195016a58 R08: ffff8801c66e8180 R09: ffffed00323180ba
R10: ffffed00323180bc R11: ffff8801918c05e3 R12: ffff8801ce7bea04
R13: 00000000fffffff2 R14: ffff8801ce7bea10 R15: dffffc0000000000
FS:  00007effc88a9700(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffdeada9000 CR3: 00000001b3b5d000 CR4: 00000000001406f0
DR0: 0000000020000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
