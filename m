Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_MIXED_ES,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C1AC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 17:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4F2720851
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 17:17:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4F2720851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbeLLRRE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 12:17:04 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:39548 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727845AbeLLRRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 12:17:04 -0500
Received: by mail-io1-f72.google.com with SMTP id q23so17763903ior.6
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 09:17:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=NlG8O8yeToplRwJP8Bs7ZvjXEAr4RlUUvC3xZmpF5TI=;
        b=szM9DxbgIeFRxC1uUVKlRH06bmUKONfc2rpjE0O2OmIYkeYAxkzSpXLqQSi4MFfxzJ
         zo331wFvt92Vtm50UToersHpENNsLUX67NEi+0h24WLM8tM8svC6YmHDnlY9dzWt7uQJ
         EvQO7SEn+d3dTS8T3IgxJdl7lZVNxDlb0ZL5D9IrpgoyM29deP1WD6NUde9DHEbyKofZ
         yb9PGzuSBP5p0pNRZmc02OGkHipKBNPpzLJdAOv/pPLWFBXE82CKzx2/zql9W3DZia09
         kJ8a5waQm9EYClOu3tQs2Dnt5pAHCLa92tPHP/YnW7z41KoDv5ciZoiHPE56UPrbiqvX
         bfQA==
X-Gm-Message-State: AA+aEWbL6S+rhCH3OjRNkSEG9JoxuNC83faZsv8ZL8BIiCvj0nUctkJ6
        Luf1swVMna6wOR+076EOB62yUhAsVGwfvew0rXPs2JRoQndm
X-Google-Smtp-Source: AFSGD/Ut6QbJMYt8ydHd9E62/99OIikeje1iN1q6ynXoO9PTG1wZMb1b2UD+hchJQcI6yEIf2N4Yhpz6IkWmQeUWEHtlRVYZXpOU
MIME-Version: 1.0
X-Received: by 2002:a24:3a14:: with SMTP id m20mr5674383itm.1.1544635023088;
 Wed, 12 Dec 2018 09:17:03 -0800 (PST)
Date:   Wed, 12 Dec 2018 09:17:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dbe73a057cd65da2@google.com>
Subject: general protection fault in fib6_purge_rt
From:   syzbot <syzbot+a25307ad099309f1c2b9@syzkaller.appspotmail.com>
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

HEAD commit:    ee28b30cbbe0 r8169: fix crash if CONFIG_DEBUG_SHIRQ is ena..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=10c76ba3400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c8970c89a0efbb23
dashboard link: https://syzkaller.appspot.com/bug?extid=a25307ad099309f1c2b9
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+a25307ad099309f1c2b9@syzkaller.appspotmail.com

IPv6: ADDRCONF(NETDEV_UP): veth0_to_bridge: link is not ready
device bridge_slave_1 left promiscuous mode
bridge0: port 2(bridge_slave_1) entered disabled state
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 195 Comm: kworker/u4:3 Not tainted 4.20.0-rc6+ #227
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: netns cleanup_net
RIP: 0010:fib6_drop_pcpu_from net/ipv6/ip6_fib.c:920 [inline]
RIP: 0010:fib6_purge_rt+0x5ce/0x7e0 net/ipv6/ip6_fib.c:956
Code: 0f b6 35 99 f1 33 03 31 ff 44 89 f6 e8 bb b7 a0 fa 45 84 f6 0f 84 ec  
00 00 00 e8 dd b6 a0 fa 49 8d 47 70 48 89 c2 48 c1 ea 03 <42> 80 3c 22 00  
0f 85 b5 01 00 00 48 8b 8d e0 fe ff ff 48 89 c2 48
RSP: 0018:ffff8881d8cadf18 EFLAGS: 00010202
RAX: 0000000000003400 RBX: 0000000000000001 RCX: ffffffff86decea0
RDX: 0000000000000680 RSI: ffffffff86decd93 RDI: 0000000000000005
RBP: ffff8881d8cae048 R08: ffff8881d8ca05c0 R09: ffffed1036ea6e1d
R10: ffffed1036ea6e1d R11: ffff8881b75370ef R12: dffffc0000000000
R13: ffff8881b75370c0 R14: 0000000000000001 R15: 0000000000003390
FS:  0000000000000000(0000) GS:ffff8881daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000619570 CR3: 00000001c28ac000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  fib6_del_route net/ipv6/ip6_fib.c:1809 [inline]
  fib6_del+0xbe0/0x12e0 net/ipv6/ip6_fib.c:1840
  fib6_clean_node+0x44c/0x650 net/ipv6/ip6_fib.c:2002
  fib6_walk_continue+0x4b1/0x8e0 net/ipv6/ip6_fib.c:1924
  fib6_walk+0x95/0xf0 net/ipv6/ip6_fib.c:1972
  fib6_clean_tree+0x21c/0x420 net/ipv6/ip6_fib.c:2051
  __fib6_clean_all+0x235/0x440 net/ipv6/ip6_fib.c:2067
  fib6_clean_all+0x2a/0x40 net/ipv6/ip6_fib.c:2078
  rt6_sync_down_dev+0x17a/0x1b0 net/ipv6/route.c:4038
  rt6_disable_ip+0x87/0x720 net/ipv6/route.c:4043
  addrconf_ifdown+0x168/0x1650 net/ipv6/addrconf.c:3669
  addrconf_notify+0x6de/0x2770 net/ipv6/addrconf.c:3594
  notifier_call_chain+0x17e/0x380 kernel/notifier.c:93
  __raw_notifier_call_chain kernel/notifier.c:394 [inline]
  raw_notifier_call_chain+0x2d/0x40 kernel/notifier.c:401
  call_netdevice_notifiers_info+0x3f/0x90 net/core/dev.c:1733
  call_netdevice_notifiers net/core/dev.c:1751 [inline]
  dev_close_many+0x40e/0x860 net/core/dev.c:1503
  rollback_registered_many+0x543/0x1250 net/core/dev.c:7991
  unregister_netdevice_many+0xfa/0x4c0 net/core/dev.c:9119
  default_device_exit_batch+0x43a/0x540 net/core/dev.c:9588
  ops_exit_list.isra.5+0x105/0x160 net/core/net_namespace.c:156
  cleanup_net+0x555/0xb10 net/core/net_namespace.c:551
  process_one_work+0xc90/0x1c40 kernel/workqueue.c:2153
  worker_thread+0x17f/0x1390 kernel/workqueue.c:2296
  kthread+0x35a/0x440 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
Modules linked in:
---[ end trace 42ffb82098483a68 ]---
RIP: 0010:fib6_drop_pcpu_from net/ipv6/ip6_fib.c:920 [inline]
RIP: 0010:fib6_purge_rt+0x5ce/0x7e0 net/ipv6/ip6_fib.c:956
Code: 0f b6 35 99 f1 33 03 31 ff 44 89 f6 e8 bb b7 a0 fa 45 84 f6 0f 84 ec  
00 00 00 e8 dd b6 a0 fa 49 8d 47 70 48 89 c2 48 c1 ea 03 <42> 80 3c 22 00  
0f 85 b5 01 00 00 48 8b 8d e0 fe ff ff 48 89 c2 48
RSP: 0018:ffff8881d8cadf18 EFLAGS: 00010202
RAX: 0000000000003400 RBX: 0000000000000001 RCX: ffffffff86decea0
RDX: 0000000000000680 RSI: ffffffff86decd93 RDI: 0000000000000005
RBP: ffff8881d8cae048 R08: ffff8881d8ca05c0 R09: ffffed1036ea6e1d
R10: ffffed1036ea6e1d R11: ffff8881b75370ef R12: dffffc0000000000
R13: ffff8881b75370c0 R14: 0000000000000001 R15: 0000000000003390
FS:  0000000000000000(0000) GS:ffff8881daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000619570 CR3: 00000001c28ac000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
