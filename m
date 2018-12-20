Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0059C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 23:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D2DD218FD
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 23:04:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732100AbeLTXEF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 18:04:05 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:33179 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731692AbeLTXEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 18:04:04 -0500
Received: by mail-io1-f70.google.com with SMTP id b25so214866iot.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 15:04:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=bVidpHrIIB3+uyPZev6F+hGPiF2LIPcTtmFxAci36Mg=;
        b=NMPJ05pgGCip2vgSgiSIxueaA/RJuSpWbnOnbbn9Gk/9BV0gGJaYXT7kdoyHd5JDNF
         UU/1RJgNvtcOXvvcnNnqy9OvsCuOcmGtzZ5lT3hB74wEHq78jCR8UzwYZDOHb8JMsUWh
         MKFK4riV7sIRAwZanbKbEQmuFghKlHiomOK0mMvn6+O3j8xz8Ah92fTCi6CdgTKGsxTG
         OtrFqxnON4F88kIE5H9e2FeNXR4qdomGkSShenMgqnYNoZT/qQUZGiHu1BQ9w/OMhVR9
         HmQF3/KlSVE8S/0P33MX16fRadDvetEhEkZM1D93cHi8XfR+oWutwC+Q0tZy5DBC3Roa
         yZCA==
X-Gm-Message-State: AA+aEWbWGHOr8lPETZvCKsthKsLj4xYvQRC+H/9l9yqEZm+h0yyzjVio
        tv2rEl65z6dSahME/U/LOhcvAmEvPETVC8ihG/jGmmfRMcS5
X-Google-Smtp-Source: AFSGD/WiiQmD3jYd8g3RJKTlgEfVvsXKwtX/X84KO/nuS4okYRHJQfSpB5TqoKvlPySBqJXOyvj3VVjvorR6hrLzdwuXG6tHm7R4
MIME-Version: 1.0
X-Received: by 2002:a02:c55:: with SMTP id g82mr97630jad.17.1545347043243;
 Thu, 20 Dec 2018 15:04:03 -0800 (PST)
Date:   Thu, 20 Dec 2018 15:04:03 -0800
In-Reply-To: <000000000000f16b5e05714225b8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009142a1057d7c2528@google.com>
Subject: Re: KASAN: use-after-free Write in __xfrm_policy_unlink
From:   syzbot <syzbot+9d971dd21eb26567036b@syzkaller.appspotmail.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        steffen.klassert@secunet.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    a9cd3439e3c6 neighbor: Use nda_policy for validating attri..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16ff4a0d400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1f6442435a55ea09
dashboard link: https://syzkaller.appspot.com/bug?extid=9d971dd21eb26567036b
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=118c7e1b400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+9d971dd21eb26567036b@syzkaller.appspotmail.com

8021q: adding VLAN 0 to HW filter on device team0
8021q: adding VLAN 0 to HW filter on device team0
8021q: adding VLAN 0 to HW filter on device team0
8021q: adding VLAN 0 to HW filter on device team0
==================================================================
BUG: KASAN: use-after-free in __hlist_del include/linux/list.h:704 [inline]
BUG: KASAN: use-after-free in hlist_del_rcu include/linux/rculist.h:455  
[inline]
BUG: KASAN: use-after-free in __xfrm_policy_unlink+0xa09/0xa20  
net/xfrm/xfrm_policy.c:2215
Write of size 8 at addr ffff8881b7071b50 by task syz-executor3/7764

CPU: 0 PID: 7764 Comm: syz-executor3 Not tainted 4.20.0-rc6+ #355
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x39d lib/dump_stack.c:113
  print_address_description.cold.7+0x9/0x1ff mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.8+0x242/0x309 mm/kasan/report.c:412
  __asan_report_store8_noabort+0x17/0x20 mm/kasan/report.c:438
  __hlist_del include/linux/list.h:704 [inline]
  hlist_del_rcu include/linux/rculist.h:455 [inline]
  __xfrm_policy_unlink+0xa09/0xa20 net/xfrm/xfrm_policy.c:2215
  xfrm_policy_insert+0x20a/0x850 net/xfrm/xfrm_policy.c:1587
  pfkey_spdadd+0x10f8/0x19d0 net/key/af_key.c:2339
  pfkey_process+0x851/0x9a0 net/key/af_key.c:2844
  pfkey_sendmsg+0x5df/0xfb0 net/key/af_key.c:3683
  sock_sendmsg_nosec net/socket.c:621 [inline]
  sock_sendmsg+0xd5/0x120 net/socket.c:631
  ___sys_sendmsg+0x7fd/0x930 net/socket.c:2116
  __sys_sendmsg+0x11d/0x280 net/socket.c:2154
  __do_sys_sendmsg net/socket.c:2163 [inline]
  __se_sys_sendmsg net/socket.c:2161 [inline]
  __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2161
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457669
Code: fd b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fea87c1ac78 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457669
RDX: 0000000000000000 RSI: 0000000020000000 RDI: 0000000000000003
RBP: 000000000072bfa0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fea87c1b6d4
R13: 00000000004c443a R14: 00000000004d7410 R15: 00000000ffffffff

Allocated by task 7736:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc7/0xe0 mm/kasan/kasan.c:553
  kmem_cache_alloc_trace+0x152/0x750 mm/slab.c:3620
  kmalloc include/linux/slab.h:546 [inline]
  kzalloc include/linux/slab.h:741 [inline]
  xfrm_policy_alloc+0xfa/0x4f0 net/xfrm/xfrm_policy.c:383
  pfkey_spdadd+0x244/0x19d0 net/key/af_key.c:2272
  pfkey_process+0x851/0x9a0 net/key/af_key.c:2844
  pfkey_sendmsg+0x5df/0xfb0 net/key/af_key.c:3683
  sock_sendmsg_nosec net/socket.c:621 [inline]
  sock_sendmsg+0xd5/0x120 net/socket.c:631
  ___sys_sendmsg+0x7fd/0x930 net/socket.c:2116
  __sys_sendmsg+0x11d/0x280 net/socket.c:2154
  __do_sys_sendmsg net/socket.c:2163 [inline]
  __se_sys_sendmsg net/socket.c:2161 [inline]
  __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2161
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 7753:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xcf/0x230 mm/slab.c:3817
  xfrm_policy_destroy_rcu+0x4a/0x60 net/xfrm/xfrm_policy.c:407
  __rcu_reclaim kernel/rcu/rcu.h:240 [inline]
  rcu_do_batch kernel/rcu/tree.c:2437 [inline]
  invoke_rcu_callbacks kernel/rcu/tree.c:2716 [inline]
  rcu_process_callbacks+0x100a/0x1ac0 kernel/rcu/tree.c:2697
  __do_softirq+0x308/0xb7e kernel/softirq.c:292

The buggy address belongs to the object at ffff8881b7071b40
  which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 16 bytes inside of
  1024-byte region [ffff8881b7071b40, ffff8881b7071f40)
The buggy address belongs to the page:
page:ffffea0006dc1c00 count:1 mapcount:0 mapping:ffff8881da800ac0 index:0x0  
compound_mapcount: 0
flags: 0x2fffc0000010200(slab|head)
raw: 02fffc0000010200 ffffea0006da2088 ffffea0007624d08 ffff8881da800ac0
raw: 0000000000000000 ffff8881b7070040 0000000100000007 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8881b7071a00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8881b7071a80: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
> ffff8881b7071b00: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
                                                  ^
  ffff8881b7071b80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8881b7071c00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================

