Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC114C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 13:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8540B20865
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 13:50:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8540B20865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbeKZAlM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 19:41:12 -0500
Received: from mail-it1-f199.google.com ([209.85.166.199]:59584 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbeKZAlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 19:41:12 -0500
Received: by mail-it1-f199.google.com with SMTP id 66-v6so19830598itz.9
        for <linux-kernel@vger.kernel.org>; Sun, 25 Nov 2018 05:50:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=ifSBFN6F5IyZkGwJsTXU4hExyPSNPuv1Ot1Wjfylo0M=;
        b=ch7vnuGtWM9aGnXUj9w2GZj70mzN2tR3dEIyftarXtH6xVfMpAIHBWtFx1VWyzlIAU
         Wvzc2dViEO9KlYZh8JIW5mKORMVeA+g7QyMsbaPe7HElnWHGVnCz0UFOevNp7YgwBXZy
         EfAMbfFv7G7Dto2mrsq0sttBMItrJe6H8dtuMQPk2WHT1grnVwickkogrTYTAxRiFS4S
         uWRxIUAhJjrJrL8eCkAzvXdPi2kcoMHuu9ZPIeUx2WaVuEJHD1FL/vGzIZDzCMwpNTFj
         9m4OD7luscWSl7vfyd0k+1QTjIcLChupGe4JJ4qfd9MldTOZ4/jvQZybC9yADZCjZ15i
         YG+A==
X-Gm-Message-State: AA+aEWYgFSp7De9y5YslOx/SXNneO4HUyjCnp87EmkZ8KtyK4rUe69xw
        qMXWDpL/8D9fSli2vEggNKXvpgqV7B+ChQPmSnJAUbeXDDaE
X-Google-Smtp-Source: AFSGD/UAk/rjZJhjjcKCphRkxwf90pWuPR/RnrIZx6icnKAKpdWYcwQ6jlCDcIcLJQQS8DiCAm7EbwulalHXs+txoSgHRHA5y6e8
MIME-Version: 1.0
X-Received: by 2002:a02:97da:: with SMTP id v26mr12116395jaj.1.1543153804477;
 Sun, 25 Nov 2018 05:50:04 -0800 (PST)
Date:   Sun, 25 Nov 2018 05:50:04 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000059915f057b7d7e66@google.com>
Subject: KASAN: slab-out-of-bounds Write in queue_stack_map_push_elem
From:   syzbot <syzbot+36cf9e58446a643bfa14@syzkaller.appspotmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    e195ca6cb6f2 Merge branch 'for-linus' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12af0d33400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=73e2bc0cb6463446
dashboard link: https://syzkaller.appspot.com/bug?extid=36cf9e58446a643bfa14
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12baac5d400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1471df7b400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+36cf9e58446a643bfa14@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in memcpy include/linux/string.h:352 [inline]
BUG: KASAN: slab-out-of-bounds in queue_stack_map_push_elem+0x185/0x290  
kernel/bpf/queue_stack_maps.c:230
Write of size 262146 at addr ffff8881cce14448 by task syz-executor005/6050

CPU: 1 PID: 6050 Comm: syz-executor005 Not tainted 4.20.0-rc3+ #348
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x39d lib/dump_stack.c:113
  print_address_description.cold.7+0x9/0x1ff mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.8+0x242/0x309 mm/kasan/report.c:412
  check_memory_region_inline mm/kasan/kasan.c:260 [inline]
  check_memory_region+0x13e/0x1b0 mm/kasan/kasan.c:267
  memcpy+0x37/0x50 mm/kasan/kasan.c:303
  memcpy include/linux/string.h:352 [inline]
  queue_stack_map_push_elem+0x185/0x290 kernel/bpf/queue_stack_maps.c:230
  map_update_elem+0x605/0xf60 kernel/bpf/syscall.c:865
  __do_sys_bpf kernel/bpf/syscall.c:2495 [inline]
  __se_sys_bpf kernel/bpf/syscall.c:2466 [inline]
  __x64_sys_bpf+0x32d/0x520 kernel/bpf/syscall.c:2466
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4400e9
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 fb 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffc7a0f28d8 EFLAGS: 00000213 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 00000000004400e9
RDX: 0000000000000020 RSI: 0000000020000040 RDI: 0000000000000002
RBP: 00000000006ca018 R08: 0000000000000000 R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000213 R12: 0000000000401970
R13: 0000000000401a00 R14: 0000000000000000 R15: 0000000000000000

Allocated by task 6050:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc7/0xe0 mm/kasan/kasan.c:553
  __do_kmalloc_node mm/slab.c:3684 [inline]
  __kmalloc_node+0x50/0x70 mm/slab.c:3691
  kmalloc_node include/linux/slab.h:589 [inline]
  bpf_map_area_alloc+0x3f/0x90 kernel/bpf/syscall.c:147
  queue_stack_map_alloc+0x192/0x290 kernel/bpf/queue_stack_maps.c:84
  find_and_alloc_map kernel/bpf/syscall.c:129 [inline]
  map_create+0x3bd/0x1110 kernel/bpf/syscall.c:509
  __do_sys_bpf kernel/bpf/syscall.c:2489 [inline]
  __se_sys_bpf kernel/bpf/syscall.c:2466 [inline]
  __x64_sys_bpf+0x303/0x520 kernel/bpf/syscall.c:2466
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 3716:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xcf/0x230 mm/slab.c:3817
  skb_free_head+0x99/0xc0 net/core/skbuff.c:550
  skb_release_data+0x70c/0x9a0 net/core/skbuff.c:570
  skb_release_all+0x4a/0x60 net/core/skbuff.c:627
  __kfree_skb net/core/skbuff.c:641 [inline]
  consume_skb+0x1ae/0x570 net/core/skbuff.c:701
  skb_free_datagram+0x1a/0xf0 net/core/datagram.c:329
  unix_dgram_recvmsg+0xd6d/0x1b10 net/unix/af_unix.c:2181
  sock_recvmsg_nosec net/socket.c:794 [inline]
  sock_recvmsg+0xd0/0x110 net/socket.c:801
  __sys_recvfrom+0x311/0x5d0 net/socket.c:1845
  __do_sys_recvfrom net/socket.c:1863 [inline]
  __se_sys_recvfrom net/socket.c:1859 [inline]
  __x64_sys_recvfrom+0xe1/0x1a0 net/socket.c:1859
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8881cce14300
  which belongs to the cache kmalloc-512 of size 512
The buggy address is located 328 bytes inside of
  512-byte region [ffff8881cce14300, ffff8881cce14500)
The buggy address belongs to the page:
page:ffffea0007338500 count:1 mapcount:0 mapping:ffff8881da800940  
index:0xffff8881cce14580
flags: 0x2fffc0000000200(slab)
raw: 02fffc0000000200 ffffea0006e31bc8 ffffea00071b4608 ffff8881da800940
raw: ffff8881cce14580 ffff8881cce14080 0000000100000005 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8881cce14380: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  ffff8881cce14400: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ffff8881cce14480: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                    ^
  ffff8881cce14500: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff8881cce14580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
