Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FE77C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 20:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCF032238F
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 20:02:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCF032238F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727155AbeHIW20 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 18:28:26 -0400
Received: from mail-io0-f198.google.com ([209.85.223.198]:53266 "EHLO
        mail-io0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbeHIW20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 18:28:26 -0400
Received: by mail-io0-f198.google.com with SMTP id o24-v6so5177433iob.20
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 13:02:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=AwQHUVdsm/0ybSlzEa27ZZ0Dgx/4eS74dKKOoXrMPZo=;
        b=l/58UEnrjIYvJWshpLWjA2hJEfk9veC+Mw17v2/fdNMO5gsigBtqYhETDyQfTxgepW
         Au7ybVk5vO0lt/9ClOze4BlGbTJ8OZe5zOp45MQz/KefPGVjw5tb3yxKSX2JACB8lJsh
         L9lCoZXOoB2oANfcBiBaNB9456j/TDWTn3LmMJHhDJynRNknebR2uvWmd108ujUSsUB0
         QzWw7ySibrStAGrOSnYw1UGWlkesAETCWljMJAw+qBlbeMZXV8YVDkXBhjgfFbS3j7Wa
         zXcUoEDaWJVD9FMUsmKXOKz8pF3cm0rNOPCBgbA8b5HwNyvPNC48k7UTYt1BOlSBag8a
         jt3Q==
X-Gm-Message-State: AOUpUlFXuO5oywq5kxWB4wMZ1mY/ARjFRwnsKyHOu68DrNcvssezQ4V8
        9ApFLOcbyO3pfQ6XCA2mnIhKk1XQmqQu37khKYKpy//1Cjzj
X-Google-Smtp-Source: AA+uWPzYKWPFK5odDtIKh3VLDiawnxAhVeLGc+oWHQw0ACZFCFt+L26DGg+r/bFOw7wv3KTUcDxQxc93JOjz6rMa3bwf+Cm76AIC
MIME-Version: 1.0
X-Received: by 2002:a5e:8819:: with SMTP id l25-v6mr1460932ioj.25.1533844923239;
 Thu, 09 Aug 2018 13:02:03 -0700 (PDT)
Date:   Thu, 09 Aug 2018 13:02:03 -0700
In-Reply-To: <000000000000f68d660570dcddd8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ca55900573061971@google.com>
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

HEAD commit:    112cbae26d18 Merge branch 'linus' of git://git.kernel.org/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1192ae72400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=152cb8ccd35b1f70
dashboard link: https://syzkaller.appspot.com/bug?extid=90d5ec0c05e708f3b66d
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=153ed6e2400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1539038c400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+90d5ec0c05e708f3b66d@syzkaller.appspotmail.com

IPv6: ADDRCONF(NETDEV_UP): veth0: link is not ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): bond0: link becomes ready
8021q: adding VLAN 0 to HW filter on device team0
------------[ cut here ]------------
kernel BUG at net/ipv4/ip_output.c:775!
invalid opcode: 0000 [#1] SMP KASAN
CPU: 1 PID: 4713 Comm: syz-executor450 Not tainted 4.18.0-rc8+ #182
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:ip_do_fragment+0x2436/0x2aa0 net/ipv4/ip_output.c:775
Code: 8b 8d 70 fe ff ff e9 99 e8 ff ff 4c 89 ef e8 a1 65 40 fc e9 7b e9 ff  
ff 4c 89 f7 e8 94 65 40 fc e9 f3 e5 ff ff e8 7a 89 02 fc <0f> 0b 4c 89 e7  
e8 80 65 40 fc e9 b7 e8 ff ff 4c 89 f7 89 8d 70 fe
RSP: 0018:ffff8801cfe3e880 EFLAGS: 00010293
RAX: ffff8801af542080 RBX: ffff8801c88eaa00 RCX: ffffffff85797886
RDX: 0000000000000000 RSI: ffffffff85798ed6 RDI: 0000000000000005
RBP: ffff8801cfe3ea58 R08: ffff8801af542080 R09: ffffed0039110032
R10: ffffed0039110034 R11: ffff8801c88801a3 R12: ffff8801c88eaac4
R13: 00000000fffffff2 R14: ffff8801c88eaad0 R15: dffffc0000000000
FS:  0000000001479880(0000) GS:ffff8801db100000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffff600400 CR3: 00000001cf669000 CR4: 00000000001406e0
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
  bpf_prog_bebbfe2050753572+0xef4/0x1000
Modules linked in:
Dumping ftrace buffer:
    (ftrace buffer empty)
---[ end trace b3cbe48b5e178b8d ]---
RIP: 0010:ip_do_fragment+0x2436/0x2aa0 net/ipv4/ip_output.c:775
Code: 8b 8d 70 fe ff ff e9 99 e8 ff ff 4c 89 ef e8 a1 65 40 fc e9 7b e9 ff  
ff 4c 89 f7 e8 94 65 40 fc e9 f3 e5 ff ff e8 7a 89 02 fc <0f> 0b 4c 89 e7  
e8 80 65 40 fc e9 b7 e8 ff ff 4c 89 f7 89 8d 70 fe
RSP: 0018:ffff8801cfe3e880 EFLAGS: 00010293
RAX: ffff8801af542080 RBX: ffff8801c88eaa00 RCX: ffffffff85797886
RDX: 0000000000000000 RSI: ffffffff85798ed6 RDI: 0000000000000005
RBP: ffff8801cfe3ea58 R08: ffff8801af542080 R09: ffffed0039110032
R10: ffffed0039110034 R11: ffff8801c88801a3 R12: ffff8801c88eaac4
R13: 00000000fffffff2 R14: ffff8801c88eaad0 R15: dffffc0000000000
FS:  0000000001479880(0000) GS:ffff8801db100000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffff600400 CR3: 00000001cf669000 CR4: 00000000001406e0

