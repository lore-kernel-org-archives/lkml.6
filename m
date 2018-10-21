Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C58ECDE43
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 09:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E546B20843
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 09:40:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E546B20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbeJURxr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 13:53:47 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:40199 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727388AbeJURxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 13:53:46 -0400
Received: by mail-io1-f70.google.com with SMTP id p22-v6so34664387ioh.7
        for <linux-kernel@vger.kernel.org>; Sun, 21 Oct 2018 02:40:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=yHozoALBQIMdtGV0ChbvqBxpHBY6EOc9aCXnDyCCr3M=;
        b=uel0ogZo8yK9HQDQ0tcK7ng/gJIdeS+gM9p6pwg+6IGYMijgoHjVf/zIpzpr/fgiW0
         vPb6uKVOQwEWvXVu1dJb3sV6L3z++KskVYHCO1TuIlpH6NXlnr+Fg3hNuKnTdKFaQC6V
         6aa6ymaXfZP6UWz4VbiOq94qw3EKk1p+kYfUzVFOukz1/8hQMSXmSK3uCruVSWxPC0Vo
         HYTPS7J8t8iOX9bugtTopXWbFaaJZbzo3akd98Bu9HIbDnKYo2PcGUaw2HYiacCLoNBi
         LzijurhpFQkCFe9+jGkUHJcbtBqFyDbtc+OvqUcchqbTw43ydoH3gjsmObELMfJUS3J0
         NJBQ==
X-Gm-Message-State: ABuFfoipkWr5liQWqQ/KAAasBQxF5zku+D59HiR/+mXkwHxps7r8/kvB
        Z3Kol7ISa3DEiqDEZHzy+3jqXNBjyjvBu6+5NuiWd+FvIin9
X-Google-Smtp-Source: ACcGV623hPqANEnT0il9paJ5OfJKgbHfBG7g/p8aogXq3FhNwrLBAfFkDY3k9NBgkGqOZLWqhOTMfE7mcf61TPaYUb7CPBJ44C4u
MIME-Version: 1.0
X-Received: by 2002:a24:7bcd:: with SMTP id q196-v6mr8825165itc.3.1540114803420;
 Sun, 21 Oct 2018 02:40:03 -0700 (PDT)
Date:   Sun, 21 Oct 2018 02:40:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c57a190578b9eb98@google.com>
Subject: KASAN: use-after-free Read in wait_for_completion
From:   syzbot <syzbot+f25db12f1fd508824eac@syzkaller.appspotmail.com>
To:     dledford@redhat.com, jgg@ziepe.ca, leon@kernel.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        parav@mellanox.com, roland@purestorage.com,
        swise@opengridcomputing.com, syzkaller-bugs@googlegroups.com,
        xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    270b77a0f30e Merge tag 'drm-fixes-2018-10-20-1' of git://a..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=152bb709400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b3f55cb3dfcc6c33
dashboard link: https://syzkaller.appspot.com/bug?extid=f25db12f1fd508824eac
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+f25db12f1fd508824eac@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in __lock_acquire+0x37c2/0x4ec0  
kernel/locking/lockdep.c:3290
Read of size 8 at addr ffff8801d28a81a8 by task syz-executor4/12225

CPU: 1 PID: 12225 Comm: syz-executor4 Not tainted 4.19.0-rc8+ #72
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
  __raw_spin_lock_irq include/linux/spinlock_api_smp.h:128 [inline]
  _raw_spin_lock_irq+0x61/0x80 kernel/locking/spinlock.c:160
  spin_lock_irq include/linux/spinlock.h:354 [inline]
  do_wait_for_common kernel/sched/completion.c:84 [inline]
  __wait_for_common kernel/sched/completion.c:104 [inline]
  wait_for_common kernel/sched/completion.c:115 [inline]
  wait_for_completion+0x436/0x8a0 kernel/sched/completion.c:136
  ucma_destroy_id+0x38a/0x550 drivers/infiniband/core/ucma.c:637
  ucma_write+0x365/0x460 drivers/infiniband/core/ucma.c:1689
  __vfs_write+0x119/0x9f0 fs/read_write.c:485
  vfs_write+0x1fc/0x560 fs/read_write.c:549
  ksys_write+0x101/0x260 fs/read_write.c:598
  __do_sys_write fs/read_write.c:610 [inline]
  __se_sys_write fs/read_write.c:607 [inline]
  __x64_sys_write+0x73/0xb0 fs/read_write.c:607
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457569
Code: fd b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fe8a3f8ec78 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457569
RDX: 0000000000000018 RSI: 0000000020000280 RDI: 0000000000000005
RBP: 000000000072bfa0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fe8a3f8f6d4
R13: 00000000004cb4f8 R14: 00000000004d8b68 R15: 00000000ffffffff

Allocated by task 12210:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc7/0xe0 mm/kasan/kasan.c:553
  kmem_cache_alloc_trace+0x152/0x750 mm/slab.c:3620
  kmalloc include/linux/slab.h:513 [inline]
  kzalloc include/linux/slab.h:707 [inline]
  ucma_alloc_ctx+0xce/0x690 drivers/infiniband/core/ucma.c:209
  ucma_create_id+0x27d/0x990 drivers/infiniband/core/ucma.c:500
  ucma_write+0x365/0x460 drivers/infiniband/core/ucma.c:1689
  __vfs_write+0x119/0x9f0 fs/read_write.c:485
  vfs_write+0x1fc/0x560 fs/read_write.c:549
  ksys_write+0x101/0x260 fs/read_write.c:598
  __do_sys_write fs/read_write.c:610 [inline]
  __se_sys_write fs/read_write.c:607 [inline]
  __x64_sys_write+0x73/0xb0 fs/read_write.c:607
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 12210:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xcf/0x230 mm/slab.c:3813
  ucma_free_ctx+0x9e6/0xdb0 drivers/infiniband/core/ucma.c:599
  ucma_close+0x121/0x310 drivers/infiniband/core/ucma.c:1775
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

The buggy address belongs to the object at ffff8801d28a8180
  which belongs to the cache kmalloc-256 of size 256
The buggy address is located 40 bytes inside of
  256-byte region [ffff8801d28a8180, ffff8801d28a8280)
The buggy address belongs to the page:
page:ffffea00074a2a00 count:1 mapcount:0 mapping:ffff8801da8007c0 index:0x0
flags: 0x2fffc0000000100(slab)
raw: 02fffc0000000100 ffffea000760b108 ffffea0007491148 ffff8801da8007c0
raw: 0000000000000000 ffff8801d28a8040 000000010000000c 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801d28a8080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  ffff8801d28a8100: 00 00 fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ffff8801d28a8180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                   ^
  ffff8801d28a8200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8801d28a8280: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
