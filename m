Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE2FFF05E1
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 11:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC72E20873
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 11:12:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC72E20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbeG2MmI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 08:42:08 -0400
Received: from mail-io0-f197.google.com ([209.85.223.197]:41217 "EHLO
        mail-io0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbeG2MmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 08:42:08 -0400
Received: by mail-io0-f197.google.com with SMTP id p12-v6so6886810iog.8
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 04:12:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=JzOQSTRfKvcdJubdCttL0qa6DJPhvUEvBDQms7qBVRQ=;
        b=G84tYTf03o9ZHF5B1sF2ooFKsvPO77ZL5Hv0RV0vf7l1FaLn6oxHiCHbPgS77ixJTe
         j8d93/TxBNPutWcTW9eFFKgM3QB466DgTSz9KoxuL1NJm0RLWluU6wgtZApMRVh0/sKx
         +IN3U4qF1lX9FJS/AYRVzqHQL5IQpvYruVkNZyQaeFhM6kKOWBd3/bVCnSii82u03f13
         2eV8UDN9og3wTQIxLLnrnDNINkNrV2xIhkkuWyOUOvbzILUbV4fjSMsBTT5RP1iO+NRf
         a8u98s0hQKZ+HyZ4y54Y26c9G3n3GhX9OVNGw8JC+R8Dktc+zDvFYxDu4cvsIBEyAFbE
         QHCw==
X-Gm-Message-State: AOUpUlGgEm2+OfXwYWyZaDd5k4bGWrojfHw/Ze2THXkp9VtRblB7XVJh
        cFdtvUQersayqrEDBgpdindG3GJh+ZpJugNlyTF7IrI/z8ht
X-Google-Smtp-Source: AAOMgpfiekYDwy4ywSDuodisTa+DY36P4qokhrO1lgBbm1d8gYLIzNSKwzjFFmXUEIeQYmcF6T2IX+Xbtzd8KIeDmG/JxCn5VdAO
MIME-Version: 1.0
X-Received: by 2002:a6b:28d4:: with SMTP id o203-v6mr4949169ioo.135.1532862722908;
 Sun, 29 Jul 2018 04:12:02 -0700 (PDT)
Date:   Sun, 29 Jul 2018 04:12:02 -0700
In-Reply-To: <000000000000f68d660570dcddd8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000016abfe0572216a0d@google.com>
Subject: Re: kernel BUG at net/ipv4/ip_output.c:LINE!
From:   syzbot <syzbot+90d5ec0c05e708f3b66d@syzkaller.appspotmail.com>
To:     davem@davemloft.net, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    71eb5255f55b bpf: use GFP_ATOMIC instead of GFP_KERNEL in ..
git tree:       bpf
console output: https://syzkaller.appspot.com/x/log.txt?x=14d07f94400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=75c10f3ddcafec09
dashboard link: https://syzkaller.appspot.com/bug?extid=90d5ec0c05e708f3b66d
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=113514b4400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+90d5ec0c05e708f3b66d@syzkaller.appspotmail.com

hrtimer: interrupt took 252517 ns
------------[ cut here ]------------
kernel BUG at net/ipv4/ip_output.c:775!
invalid opcode: 0000 [#1] SMP KASAN
CPU: 1 PID: 17086 Comm: syz-executor0 Not tainted 4.18.0-rc5+ #22
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:ip_do_fragment+0x2436/0x2aa0 net/ipv4/ip_output.c:775
Code: 8b 8d 70 fe ff ff e9 99 e8 ff ff 4c 89 ef e8 a1 8b 40 fc e9 7b e9 ff  
ff 4c 89 f7 e8 94 8b 40 fc e9 f3 e5 ff ff e8 ca a9 02 fc <0f> 0b 4c 89 e7  
e8 80 8b 40 fc e9 b7 e8 ff ff 4c 89 f7 89 8d 70 fe
RSP: 0018:ffff8801b17f6880 EFLAGS: 00010293
RAX: ffff8801d4688100 RBX: ffff8801a8ead7c0 RCX: ffffffff85794b66
RDX: 0000000000000000 RSI: ffffffff857961b6 RDI: 0000000000000005
RBP: ffff8801b17f6a58 R08: ffff8801d4688100 R09: ffffed0039188032
R10: ffffed0039188034 R11: ffff8801c8c401a3 R12: ffff8801a8ead884
R13: 00000000fffffff2 R14: ffff8801a8ead890 R15: dffffc0000000000
FS:  00007f00d6501700(0000) GS:ffff8801db100000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000072c081 CR3: 00000001cb927000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  ip_fragment.constprop.49+0x179/0x240 net/ipv4/ip_output.c:548
  ip_finish_output+0x6e4/0xfa0 net/ipv4/ip_output.c:315
  NF_HOOK_COND include/linux/netfilter.h:276 [inline]
  ip_output+0x223/0x880 net/ipv4/ip_output.c:405
  dst_output include/net/dst.h:444 [inline]
  ip_local_out+0xc5/0x1b0 net/ipv4/ip_output.c:124
  iptunnel_xmit+0x53b/0x800 net/ipv4/ip_tunnel_core.c:91
  ip_tunnel_xmit+0x1598/0x3af1 net/ipv4/ip_tunnel.c:778
  __gre_xmit+0x5b7/0x950 net/ipv4/ip_gre.c:449
  ipgre_xmit+0x3e8/0xb50 net/ipv4/ip_gre.c:701
  __netdev_start_xmit include/linux/netdevice.h:4148 [inline]
  netdev_start_xmit include/linux/netdevice.h:4157 [inline]
  xmit_one net/core/dev.c:3034 [inline]
  dev_hard_start_xmit+0x26c/0xc30 net/core/dev.c:3050
  __dev_queue_xmit+0x29c2/0x38e0 net/core/dev.c:3569
  dev_queue_xmit+0x17/0x20 net/core/dev.c:3602
  __bpf_tx_skb net/core/filter.c:1995 [inline]
  __bpf_redirect_common net/core/filter.c:2033 [inline]
  __bpf_redirect+0x563/0xa80 net/core/filter.c:2040
  ____bpf_clone_redirect net/core/filter.c:2073 [inline]
  bpf_clone_redirect+0x2f6/0x490 net/core/filter.c:2045
  bpf_prog_bebbfe2050753572+0x359/0x1000
Modules linked in:
Dumping ftrace buffer:
    (ftrace buffer empty)
---[ end trace ee1a333a6a4f77b3 ]---
RIP: 0010:ip_do_fragment+0x2436/0x2aa0 net/ipv4/ip_output.c:775
Code: 8b 8d 70 fe ff ff e9 99 e8 ff ff 4c 89 ef e8 a1 8b 40 fc e9 7b e9 ff  
ff 4c 89 f7 e8 94 8b 40 fc e9 f3 e5 ff ff e8 ca a9 02 fc <0f> 0b 4c 89 e7  
e8 80 8b 40 fc e9 b7 e8 ff ff 4c 89 f7 89 8d 70 fe
RSP: 0018:ffff8801b17f6880 EFLAGS: 00010293
RAX: ffff8801d4688100 RBX: ffff8801a8ead7c0 RCX: ffffffff85794b66
RDX: 0000000000000000 RSI: ffffffff857961b6 RDI: 0000000000000005
RBP: ffff8801b17f6a58 R08: ffff8801d4688100 R09: ffffed0039188032
R10: ffffed0039188034 R11: ffff8801c8c401a3 R12: ffff8801a8ead884
R13: 00000000fffffff2 R14: ffff8801a8ead890 R15: dffffc0000000000
FS:  00007f00d6501700(0000) GS:ffff8801db100000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000072c081 CR3: 00000001cb927000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

