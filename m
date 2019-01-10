Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D2DC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 482E7208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:38:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730540AbfAJRiI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 12:38:08 -0500
Received: from mail-it1-f199.google.com ([209.85.166.199]:35529 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730201AbfAJRiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 12:38:07 -0500
Received: by mail-it1-f199.google.com with SMTP id v188so11751540ita.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 09:38:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=VpgJacbwy6HOU6enKZRVZ81B6E/eE7XNDKDnzztw/xw=;
        b=C/yAd1QTB91BK32BEA7/TV+RlP39SqlIrPHU7tzuU5L0MA0zraPAbPzmr8mSd4BK3H
         tDpSDNNPlVwOV5fzScHOjtmHE01eCS7KyxWuvHfP9MR3H7leu8dF7vdiTkVS5dVmMbtw
         q1L03v/ocgBV6bOPbF81fe8zmW9vk0IW85bYxTR9suAKaxR1R8JTHVmDhc4ffm+IsDzV
         nYdQXzwKqlfzOWNfIcBi14y95v2dfCRhSrsxpQJ1CPlg8vjilpWG70Yw1JYTed9eBgBl
         tUS7K8UQEWZEij6mwcH2P4qVjqgUfDW1/M0he7zSmlih9kyJBZBHOze6da3zS0uS0Akj
         UV7w==
X-Gm-Message-State: AJcUukf2Pe3q9md52OQpxo/rG9T7X+bUbVa1lLzewXlHlLiUxfiOdkcM
        yInOe2Pra95WpWzI8oExasMhUpX7+CNBZTvyTEXlDbcYyyiv
X-Google-Smtp-Source: ALg8bN6SzTMtDEkAfST6DutDCUz0r7kx2zWTvdoBcHjCo9BGvM0h0P58395G5XXtDSKLe8hWM4dCAjggXRSvwxUAF412gGSuSByX
MIME-Version: 1.0
X-Received: by 2002:a02:b5e5:: with SMTP id y34mr4923711jaj.21.1547141886084;
 Thu, 10 Jan 2019 09:38:06 -0800 (PST)
Date:   Thu, 10 Jan 2019 09:38:06 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000089904d057f1e0ae0@google.com>
Subject: general protection fault in rose_send_frame
From:   syzbot <syzbot+7078ae989d857fe17988@syzkaller.appspotmail.com>
To:     davem@davemloft.net, linux-hams@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        ralf@linux-mips.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    b71acb0e3721 Merge branch 'linus' of git://git.kernel.org/..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13a9acf7400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b03c5892bb940c76
dashboard link: https://syzkaller.appspot.com/bug?extid=7078ae989d857fe17988
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+7078ae989d857fe17988@syzkaller.appspotmail.com

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 10446 Comm: syz-executor4 Not tainted 4.20.0+ #3
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:rose_send_frame+0x1a8/0x280 net/rose/rose_link.c:104
Code: c1 ea 03 80 3c 02 00 0f 85 8d 00 00 00 48 b8 00 00 00 00 00 fc ff df  
4c 8b 63 20 49 8d bc 24 58 03 00 00 48 89 fa 48 c1 ea 03 <80> 3c 02 00 75  
7e 49 8b 94 24 58 03 00 00 e9 b8 fe ff ff e8 d0 e3
RSP: 0018:ffff8880ae707780 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffff8882167d4540 RCX: ffffffff8703c0bb
RDX: 000000000000006b RSI: ffffffff8703c1ec RDI: 0000000000000358
kobject: 'loop1' (000000008f9686c7): kobject_uevent_env
RBP: ffff8880ae7077b0 R08: ffff888089dc0480 R09: ffffed1014360d0d
kobject: 'loop1' (000000008f9686c7): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
R10: ffffed1014360d0c R11: ffff8880a1b06863 R12: 0000000000000000
R13: 0000000000000078 R14: 0000000000000005 R15: ffff888096c38a40
FS:  00007fb08678e700(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000625208 CR3: 00000000645e0000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  <IRQ>
  rose_transmit_clear_request+0x1de/0x2a0 net/rose/rose_link.c:258
  rose_rx_call_request+0x4f8/0x1c40 net/rose/af_rose.c:999
  rose_loopback_timer+0x26a/0x3f0 net/rose/rose_loopback.c:100
  call_timer_fn+0x254/0x900 kernel/time/timer.c:1325
  expire_timers kernel/time/timer.c:1362 [inline]
  __run_timers+0x6fc/0xd50 kernel/time/timer.c:1681
  run_timer_softirq+0x52/0xb0 kernel/time/timer.c:1694
  __do_softirq+0x30b/0xb11 kernel/softirq.c:292
  invoke_softirq kernel/softirq.c:373 [inline]
  irq_exit+0x180/0x1d0 kernel/softirq.c:413
  exiting_irq arch/x86/include/asm/apic.h:536 [inline]
  smp_apic_timer_interrupt+0x1b7/0x760 arch/x86/kernel/apic/apic.c:1062
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:807
  </IRQ>
RIP: 0010:arch_local_irq_restore arch/x86/include/asm/paravirt.h:766  
[inline]
RIP: 0010:lock_is_held_type+0x17e/0x210 kernel/locking/lockdep.c:3881
Code: 00 00 00 fc ff df 41 c7 85 7c 08 00 00 00 00 00 00 48 c1 e8 03 80 3c  
10 00 75 63 48 83 3d b9 0a 2f 08 00 74 30 48 89 df 57 9d <0f> 1f 44 00 00  
48 83 c4 08 44 89 e0 5b 41 5c 41 5d 5d c3 48 83 c4
RSP: 0018:ffff888065f8eea8 EFLAGS: 00000282 ORIG_RAX: ffffffffffffff13
RAX: 1ffffffff1324a06 RBX: 0000000000000282 RCX: dffffc0000000000
RDX: dffffc0000000000 RSI: 0000000000000000 RDI: 0000000000000282
RBP: ffff888065f8eec8 R08: ffff888089dc0480 R09: ffffed100cbf1df3
R10: ffffed100cbf1df2 R11: 0000000000000003 R12: 0000000000000000
R13: ffff888089dc0480 R14: dffffc0000000000 R15: ffffea0001de25c0
  lock_is_held include/linux/lockdep.h:337 [inline]
  xa_entry include/linux/xarray.h:902 [inline]
  xas_reload include/linux/xarray.h:1250 [inline]
  find_get_pages_range_tag+0x1166/0x1540 mm/filemap.c:1848
  pagevec_lookup_range_tag+0x40/0x80 mm/swap.c:1005
  mpage_prepare_extent_to_map+0x402/0x1950 fs/ext4/inode.c:2661
  ext4_writepages+0x1a5e/0x4180 fs/ext4/inode.c:2881
  do_writepages+0x99/0x1a0 mm/page-writeback.c:2328
  __filemap_fdatawrite_range+0x352/0x470 mm/filemap.c:411
  filemap_write_and_wait_range mm/filemap.c:633 [inline]
  filemap_write_and_wait_range+0x4b/0xd0 mm/filemap.c:627
  __generic_file_write_iter+0x4ea/0x630 mm/filemap.c:3251
  ext4_file_write_iter+0x37a/0x1410 fs/ext4/file.c:266
  call_write_iter include/linux/fs.h:1857 [inline]
  new_sync_write fs/read_write.c:474 [inline]
  __vfs_write+0x6e5/0xa80 fs/read_write.c:487
  vfs_write+0x20c/0x560 fs/read_write.c:549
  ksys_write+0x105/0x260 fs/read_write.c:598
  __do_sys_write fs/read_write.c:610 [inline]
  __se_sys_write fs/read_write.c:607 [inline]
  __x64_sys_write+0x73/0xb0 fs/read_write.c:607
  do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457ec9
Code: 6d b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 3b b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fb08678dc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457ec9
RDX: 00000000fffffcbe RSI: 0000000020000000 RDI: 0000000000000004
RBP: 000000000073bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fb08678e6d4
R13: 00000000004c7155 R14: 00000000004dc898 R15: 00000000ffffffff
Modules linked in:
---[ end trace bd566e08b493d14b ]---
RIP: 0010:rose_send_frame+0x1a8/0x280 net/rose/rose_link.c:104
Code: c1 ea 03 80 3c 02 00 0f 85 8d 00 00 00 48 b8 00 00 00 00 00 fc ff df  
4c 8b 63 20 49 8d bc 24 58 03 00 00 48 89 fa 48 c1 ea 03 <80> 3c 02 00 75  
7e 49 8b 94 24 58 03 00 00 e9 b8 fe ff ff e8 d0 e3
RSP: 0018:ffff8880ae707780 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffff8882167d4540 RCX: ffffffff8703c0bb
RDX: 000000000000006b RSI: ffffffff8703c1ec RDI: 0000000000000358
RBP: ffff8880ae7077b0 R08: ffff888089dc0480 R09: ffffed1014360d0d
R10: ffffed1014360d0c R11: ffff8880a1b06863 R12: 0000000000000000
R13: 0000000000000078 R14: 0000000000000005 R15: ffff888096c38a40
FS:  00007fb08678e700(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000625208 CR3: 00000000645e0000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
