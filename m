Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D61AC43610
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 19:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63D5620869
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 19:23:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63D5620869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbeKSFoK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 00:44:10 -0500
Received: from mail-it1-f199.google.com ([209.85.166.199]:56582 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbeKSFoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 00:44:10 -0500
Received: by mail-it1-f199.google.com with SMTP id m123-v6so5655629ite.6
        for <linux-kernel@vger.kernel.org>; Sun, 18 Nov 2018 11:23:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=HweNna4bwP6ztw1aZjQL6sdAmjl1MIjq6fDmnf453FI=;
        b=KFqhrtPvbGn4ZVR7+mCUtShfSgnyIMJ62yOEpeZjmvrWl2WbVhtel+hrFv7KE/MCZk
         bTKxh2VR0sxcS6yKDReZpRYeetwsFuVprQU3zEjECDl6MbfaWfvMJRi65vPMd8D+OXet
         2/14PIgQmjaOZEdZUYNrNhBNm1M8VI5/bfNgYhaN1Gyx/PAEyKV9P/8uXAAP0175U7R9
         NhZhlryd3G7RmkWkwB2S+ScIW77c/ujSLjQbf78sOx9zNtwF91m7JF031me+eK5193zN
         MCypCH58g5Ehppnn1KGFIXnKDKAhe1pgaB2sMjkozrmGc2CJP4fYxpDWMMm20Xb+zsGH
         XARg==
X-Gm-Message-State: AA+aEWa+MnlAATYav3CMhm7Sswh3Q6fTfqS5bj18V2iDjQ5U6wjoludp
        WFeampfOhzXgh7d7RqkLHJ+FcQps7V9wzcoJImi3LHxRFWuW
X-Google-Smtp-Source: AFSGD/UkG84MAE7wQ3V5HML8zRZyrgONmns+8fbq3PCpbiBj22SjHAMyl82+AKokzb8oIWTKYU0I/tEc0eXRbryM3mXaQvwlSiTA
MIME-Version: 1.0
X-Received: by 2002:a5e:9e05:: with SMTP id i5-v6mr10019397ioq.14.1542568982926;
 Sun, 18 Nov 2018 11:23:02 -0800 (PST)
Date:   Sun, 18 Nov 2018 11:23:02 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000044e23f057af554d7@google.com>
Subject: KASAN: use-after-free Read in sctp_hash_transport
From:   syzbot <syzbot+0b05d8aa7cb185107483@syzkaller.appspotmail.com>
To:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        linux-sctp@vger.kernel.org, marcelo.leitner@gmail.com,
        netdev@vger.kernel.org, nhorman@tuxdriver.com,
        syzkaller-bugs@googlegroups.com, vyasevich@gmail.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    e119a369b0f1 Merge branch 'SMSC95xx-driver-updates'
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=124f5f7b400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d86f24333880b605
dashboard link: https://syzkaller.appspot.com/bug?extid=0b05d8aa7cb185107483
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+0b05d8aa7cb185107483@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in sctp_hash_transport+0x803/0x810  
net/sctp/input.c:958
Read of size 8 at addr ffff8881c6b98cb0 by task syz-executor5/3552

CPU: 0 PID: 3552 Comm: syz-executor5 Not tainted 4.20.0-rc2+ #299
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x39d lib/dump_stack.c:113
  print_address_description.cold.7+0x9/0x1ff mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.8+0x242/0x309 mm/kasan/report.c:412
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
  sctp_hash_transport+0x803/0x810 net/sctp/input.c:958
  sctp_assoc_add_peer+0xa21/0x10d0 net/sctp/associola.c:724
  sctp_sendmsg_new_asoc+0x5da/0x11f0 net/sctp/socket.c:1757
  sctp_sendmsg+0x18a5/0x1da0 net/sctp/socket.c:2086
  inet_sendmsg+0x1a1/0x690 net/ipv4/af_inet.c:798
  sock_sendmsg_nosec net/socket.c:621 [inline]
  sock_sendmsg+0xd5/0x120 net/socket.c:631
  ___sys_sendmsg+0x7fd/0x930 net/socket.c:2116
  __sys_sendmsg+0x11d/0x280 net/socket.c:2154
  __do_sys_sendmsg net/socket.c:2163 [inline]
  __se_sys_sendmsg net/socket.c:2161 [inline]
  __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2161
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457569
Code: fd b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f45462c7c78 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457569
RDX: 0000000000000000 RSI: 000000002001afc8 RDI: 0000000000000005
RBP: 000000000072c0e0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f45462c86d4
R13: 00000000004c381e R14: 00000000004d59e8 R15: 00000000ffffffff

Allocated by task 3509:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc7/0xe0 mm/kasan/kasan.c:553
  kmem_cache_alloc_trace+0x152/0x750 mm/slab.c:3620
  kmalloc include/linux/slab.h:546 [inline]
  kzalloc include/linux/slab.h:741 [inline]
  sctp_association_new+0x14e/0x2290 net/sctp/associola.c:311
  sctp_sendmsg_new_asoc+0x39c/0x11f0 net/sctp/socket.c:1723
  sctp_sendmsg+0x18a5/0x1da0 net/sctp/socket.c:2086
  inet_sendmsg+0x1a1/0x690 net/ipv4/af_inet.c:798
  sock_sendmsg_nosec net/socket.c:621 [inline]
  sock_sendmsg+0xd5/0x120 net/socket.c:631
  ___sys_sendmsg+0x7fd/0x930 net/socket.c:2116
  __sys_sendmsg+0x11d/0x280 net/socket.c:2154
  __do_sys_sendmsg net/socket.c:2163 [inline]
  __se_sys_sendmsg net/socket.c:2161 [inline]
  __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2161
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 3552:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xcf/0x230 mm/slab.c:3817
  sctp_association_destroy net/sctp/associola.c:437 [inline]
  sctp_association_put+0x264/0x350 net/sctp/associola.c:889
  sctp_transport_destroy net/sctp/transport.c:180 [inline]
  sctp_transport_put+0x186/0x1f0 net/sctp/transport.c:340
  sctp_hash_cmp+0x1ef/0x260 net/sctp/input.c:901
  __rhashtable_lookup.isra.24.constprop.29+0x3b6/0x7d0  
include/linux/rhashtable.h:483
  rhltable_lookup include/linux/rhashtable.h:566 [inline]
  sctp_hash_transport+0x2f6/0x810 net/sctp/input.c:954
  sctp_assoc_add_peer+0xa21/0x10d0 net/sctp/associola.c:724
  sctp_sendmsg_new_asoc+0x5da/0x11f0 net/sctp/socket.c:1757
  sctp_sendmsg+0x18a5/0x1da0 net/sctp/socket.c:2086
  inet_sendmsg+0x1a1/0x690 net/ipv4/af_inet.c:798
  sock_sendmsg_nosec net/socket.c:621 [inline]
  sock_sendmsg+0xd5/0x120 net/socket.c:631
  ___sys_sendmsg+0x7fd/0x930 net/socket.c:2116
  __sys_sendmsg+0x11d/0x280 net/socket.c:2154
  __do_sys_sendmsg net/socket.c:2163 [inline]
  __se_sys_sendmsg net/socket.c:2161 [inline]
  __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2161
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8881c6b98c00
  which belongs to the cache kmalloc-4k of size 4096
The buggy address is located 176 bytes inside of
  4096-byte region [ffff8881c6b98c00, ffff8881c6b99c00)
The buggy address belongs to the page:
page:ffffea00071ae600 count:1 mapcount:0 mapping:ffff8881da800dc0 index:0x0  
compound_mapcount: 0
flags: 0x2fffc0000010200(slab|head)
raw: 02fffc0000010200 ffffea0007175888 ffffea0006421308 ffff8881da800dc0
raw: 0000000000000000 ffff8881c6b98c00 0000000100000001 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8881c6b98b80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff8881c6b98c00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff8881c6b98c80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                      ^
  ffff8881c6b98d00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8881c6b98d80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
