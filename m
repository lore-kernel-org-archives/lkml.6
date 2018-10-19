Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4677BECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 15:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A79F20869
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 15:54:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A79F20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbeJTAAq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 20:00:46 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:37540 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727141AbeJTAAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 20:00:46 -0400
Received: by mail-io1-f69.google.com with SMTP id t4-v6so20519717iof.4
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 08:54:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Qubo3e6MuwXqT6hclakwRXd0usKZlVuzRqE2toN/hTI=;
        b=pIcov/045xb9UY6icclf4NmI4JFQbruiDe4Ob4VHs10dJ+YOmLGYnP/RzpLMF/6gOB
         fPYbl0HpWdSBmG38ApcdHnUwyIfjwtcyKQCVuV+U5rWnZ+RXUn3ga+iHCRJkK90MNq99
         ED1Lepw07y+1aZCRX9YZVgegwKb9IS6SGSObqygp+M0H5TZqY5o/uWgeQFZkBxkHZhqv
         o6CISoXO54CsBI1FOr9akX59dnOT+gHnnpcxer7+hCmInjBTi312jFYtl7PUgrihKIDV
         XjaGSs5wzq+Oy0U9WhGnXf5X6BjHY304kwzzpDSCYD4eI/4Yx4UaY+qAuQFBV9A3b0k+
         M9Cw==
X-Gm-Message-State: AGRZ1gJ1nZpT+zPs/Q79SHpQ1/+CibUxqiIt3X85EZsv4R4MowFHKvdh
        LaW48hcKTRNA2nPJUXVtXlkRLEnUtEWO5i1tIarpdG1/Xt1+
X-Google-Smtp-Source: AJdET5e9hnnp7FBwnH0BRApalbSscQhN8lKCnRV9DHTGRKMItMtnWuGA5XqphgfRoN7XPpMliJt/2OgrJSgUjPAhS0qnd1Rc4d31
MIME-Version: 1.0
X-Received: by 2002:a5e:c804:: with SMTP id y4-v6mr1584094iol.5.1539964443963;
 Fri, 19 Oct 2018 08:54:03 -0700 (PDT)
Date:   Fri, 19 Oct 2018 08:54:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a6391e057896e940@google.com>
Subject: KASAN: use-after-free Read in sk_psock_link_pop
From:   syzbot <syzbot+1651eee005f9de26ec35@syzkaller.appspotmail.com>
To:     daniel@iogearbox.net, davem@davemloft.net,
        john.fastabend@gmail.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    3a3295bfa6f4 Merge branch 'sctp-fix-sk_wmem_queued-and-use..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10a09791400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=133950703f7759f9
dashboard link: https://syzkaller.appspot.com/bug?extid=1651eee005f9de26ec35
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+1651eee005f9de26ec35@syzkaller.appspotmail.com

__nla_parse: 2 callbacks suppressed
netlink: 20 bytes leftover after parsing attributes in process  
`syz-executor0'.
==================================================================
BUG: KASAN: use-after-free in __lock_acquire+0x37c2/0x4ec0  
kernel/locking/lockdep.c:3290
Read of size 8 at addr ffff8801bcae2ff8 by task syz-executor3/30186

CPU: 0 PID: 30186 Comm: syz-executor3 Not tainted 4.19.0-rc7+ #266
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c4/0x2b4 lib/dump_stack.c:113
  print_address_description.cold.8+0x9/0x1ff mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.9+0x242/0x309 mm/kasan/report.c:412
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
  __lock_acquire+0x37c2/0x4ec0 kernel/locking/lockdep.c:3290
  lock_acquire+0x1ed/0x520 kernel/locking/lockdep.c:3900
  __raw_spin_lock_bh include/linux/spinlock_api_smp.h:135 [inline]
  _raw_spin_lock_bh+0x31/0x40 kernel/locking/spinlock.c:168
  spin_lock_bh include/linux/spinlock.h:334 [inline]
  sk_psock_link_pop+0x93/0x3b0 net/core/skmsg.c:504
  tcp_bpf_remove+0xe5/0x130 net/ipv4/tcp_bpf.c:497
  tcp_bpf_close+0x1c6/0x4a0 net/ipv4/tcp_bpf.c:538
  inet_release+0x104/0x1f0 net/ipv4/af_inet.c:428
  __sock_release+0xd7/0x250 net/socket.c:579
  sock_close+0x19/0x20 net/socket.c:1141
  __fput+0x385/0xa30 fs/file_table.c:278
  ____fput+0x15/0x20 fs/file_table.c:309
  task_work_run+0x1e8/0x2a0 kernel/task_work.c:113
  get_signal+0x155e/0x1980 kernel/signal.c:2343
  do_signal+0x9c/0x21e0 arch/x86/kernel/signal.c:816
  exit_to_usermode_loop+0x2e5/0x380 arch/x86/entry/common.c:162
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457569
Code: fd b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f386588dc78 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: 0000000000280000 RBX: 0000000000000006 RCX: 0000000000457569
RDX: fffffffffffffe6e RSI: 0000000020a88f88 RDI: 0000000000000004
RBP: 000000000072bf00 R08: 0000000020e68000 R09: 0000000000000010
R10: 0000000020000000 R11: 0000000000000246 R12: 00007f386588e6d4
R13: 00000000004c3915 R14: 00000000004d57c0 R15: 00000000ffffffff

Allocated by task 30195:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc7/0xe0 mm/kasan/kasan.c:553
  kmem_cache_alloc_node_trace+0x14c/0x740 mm/slab.c:3663
  kmalloc_node include/linux/slab.h:551 [inline]
  kzalloc_node include/linux/slab.h:718 [inline]
  sk_psock_init+0xe4/0x630 net/core/skmsg.c:474
  sock_map_link.isra.6+0xa6b/0xe30 net/core/sock_map.c:191
  sock_hash_update_common+0x19b/0x11e0 net/core/sock_map.c:669
  sock_hash_update_elem+0x306/0x470 net/core/sock_map.c:738
  map_update_elem+0x819/0xdf0 kernel/bpf/syscall.c:818
  __do_sys_bpf kernel/bpf/syscall.c:2400 [inline]
  __se_sys_bpf kernel/bpf/syscall.c:2371 [inline]
  __x64_sys_bpf+0x32d/0x510 kernel/bpf/syscall.c:2371
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 14:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xcf/0x230 mm/slab.c:3813
  sk_psock_destroy_deferred+0x5f0/0x850 net/core/skmsg.c:559
  process_one_work+0xc90/0x1b90 kernel/workqueue.c:2153
  worker_thread+0x17f/0x1390 kernel/workqueue.c:2296
  kthread+0x35a/0x420 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:413

The buggy address belongs to the object at ffff8801bcae2dc0
  which belongs to the cache kmalloc-1024 of size 1024
The buggy address is located 568 bytes inside of
  1024-byte region [ffff8801bcae2dc0, ffff8801bcae31c0)
The buggy address belongs to the page:
page:ffffea0006f2b880 count:1 mapcount:0 mapping:ffff8801da800ac0 index:0x0  
compound_mapcount: 0
flags: 0x2fffc0000008100(slab|head)
raw: 02fffc0000008100 ffffea0007238b08 ffffea0006deca08 ffff8801da800ac0
raw: 0000000000000000 ffff8801bcae2040 0000000100000007 0000000000000000
page dumped because: kasan: bad access detected

netlink: 20 bytes leftover after parsing attributes in process  
`syz-executor0'.
Memory state around the buggy address:
  ffff8801bcae2e80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8801bcae2f00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff8801bcae2f80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                                 ^
  ffff8801bcae3000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8801bcae3080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
