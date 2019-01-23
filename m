Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C2DC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 20:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4943C21872
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 20:45:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbfAWUpG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 15:45:06 -0500
Received: from mail-it1-f197.google.com ([209.85.166.197]:33103 "EHLO
        mail-it1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbfAWUpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 15:45:05 -0500
Received: by mail-it1-f197.google.com with SMTP id w68so603165ith.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 12:45:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=dva49NZOI3fp66t5/oKG0VYBdsmmT1OB1Krg20DfNps=;
        b=SE2mWx/kDX4SOREcHWdgjhwm/atgDkykM3wj5p0OaLD+n9QGPVj1pjS3xmPHxg3pbx
         8HPasqzPg95nFJVzIVEGbLLPR/rBnyTCbRNr6m8GONaixuDwNNSa6f3oLuGQ1HZN3SUT
         XpchiaBYnkKpbOhBJhE91MLozPlHK60TOdq24yIgtnFG6CEk00RCSVcWyIcvC26vbOSY
         UUO9pCFd1s7HO4LVOsWgNXL1xXpXDlN+9nT9vrAjbZQe+fxHdtfEvWyDju4E91onedqs
         Xr/UypXFuPnaa8VeStgbWl3fdpngALeclfnTWrN2kpVBtTAF58Nbt5QSShnlsxUnKtnF
         O9mQ==
X-Gm-Message-State: AHQUAuYjvh6lao5YHXUea8o/X/DPywgpiQvlCvZCuYDe9MqflIv/s0Tw
        GXxJ39ZzIftYXvV3kcHRXKBnuqfHkzdRrkPdX80TE8cWKoGX
X-Google-Smtp-Source: ALg8bN4TM0Ujhea6qNm3fa9j8WN29roJgXyU6axWC0uTCuPTT1v90sVyoXhBjHZkDf7y0j5Tkzei1G6+ZWQVz6T1oC7lNYCJFrhQ
MIME-Version: 1.0
X-Received: by 2002:a24:4e4b:: with SMTP id r72mr3274597ita.18.1548276303930;
 Wed, 23 Jan 2019 12:45:03 -0800 (PST)
Date:   Wed, 23 Jan 2019 12:45:03 -0800
In-Reply-To: <000000000000d78798057e773261@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001c337b0580262b5d@google.com>
Subject: Re: KASAN: use-after-free Read in refcount_inc_not_zero_checked
From:   syzbot <syzbot+defa700d16f1bd1b9a05@syzkaller.appspotmail.com>
To:     davem@davemloft.net, linux-hams@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        ralf@linux-mips.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    333478a7eb21 Merge branch 'for-rc' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14ec4628c00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=505743eba4e4f68
dashboard link: https://syzkaller.appspot.com/bug?extid=defa700d16f1bd1b9a05
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=142f7590c00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+defa700d16f1bd1b9a05@syzkaller.appspotmail.com

IPv6: ADDRCONF(NETDEV_UP): vxcan1: link is not ready
8021q: adding VLAN 0 to HW filter on device batadv0
IPVS: ftp: loaded support on port[0] = 21
chnl_net:caif_netlink_parms(): no params data found
==================================================================
BUG: KASAN: use-after-free in atomic_read  
include/asm-generic/atomic-instrumented.h:21 [inline]
BUG: KASAN: use-after-free in refcount_inc_not_zero_checked+0x91/0x2e0  
lib/refcount.c:120
Read of size 4 at addr ffff888089bba440 by task syz-executor5/11381

CPU: 1 PID: 11381 Comm: syz-executor5 Not tainted 5.0.0-rc3+ #40
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1db/0x2d0 lib/dump_stack.c:113
  print_address_description.cold+0x7c/0x20d mm/kasan/report.c:187
  kasan_report.cold+0x1b/0x40 mm/kasan/report.c:317
  check_memory_region_inline mm/kasan/generic.c:185 [inline]
  check_memory_region+0x123/0x190 mm/kasan/generic.c:191
  kasan_check_read+0x11/0x20 mm/kasan/common.c:100
  atomic_read include/asm-generic/atomic-instrumented.h:21 [inline]
  refcount_inc_not_zero_checked+0x91/0x2e0 lib/refcount.c:120
  refcount_inc_checked+0x17/0x70 lib/refcount.c:153
  sock_hold include/net/sock.h:647 [inline]
  nr_release+0x62/0x3c0 net/netrom/af_netrom.c:523
  __sock_release+0xd3/0x250 net/socket.c:579
  sock_close+0x1b/0x30 net/socket.c:1141
  __fput+0x3c5/0xb10 fs/file_table.c:278
  ____fput+0x16/0x20 fs/file_table.c:309
  task_work_run+0x1f4/0x2b0 kernel/task_work.c:113
  exit_task_work include/linux/task_work.h:22 [inline]
  do_exit+0xad7/0x26e0 kernel/exit.c:867
  do_group_exit+0x177/0x430 kernel/exit.c:971
  get_signal+0x8b4/0x19b0 kernel/signal.c:2517
  do_signal+0x91/0x1ea0 arch/x86/kernel/signal.c:816
  exit_to_usermode_loop+0x2f7/0x3b0 arch/x86/entry/common.c:162
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x696/0x800 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x458099
Code: 6d b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 3b b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f7c8a6a7cf8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 000000000073c228 RCX: 0000000000458099
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 000000000073c228
RBP: 000000000073c220 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000073c22c
R13: 00007ffc1cd8e9ef R14: 00007f7c8a6a89c0 R15: 0000000000000005

Allocated by task 11350:
  save_stack+0x45/0xd0 mm/kasan/common.c:73
  set_track mm/kasan/common.c:85 [inline]
  __kasan_kmalloc mm/kasan/common.c:496 [inline]
  __kasan_kmalloc.constprop.0+0xcf/0xe0 mm/kasan/common.c:469
  kasan_kmalloc+0x9/0x10 mm/kasan/common.c:504
  __do_kmalloc mm/slab.c:3711 [inline]
  __kmalloc+0x15c/0x740 mm/slab.c:3720
  kmalloc include/linux/slab.h:550 [inline]
  sk_prot_alloc+0x19c/0x2e0 net/core/sock.c:1477
  sk_alloc+0xd7/0x1690 net/core/sock.c:1531
  nr_create+0xb9/0x5e0 net/netrom/af_netrom.c:436
  __sock_create+0x532/0x930 net/socket.c:1277
  sock_create net/socket.c:1317 [inline]
  __sys_socket+0x106/0x260 net/socket.c:1347
  __do_sys_socket net/socket.c:1356 [inline]
  __se_sys_socket net/socket.c:1354 [inline]
  __x64_sys_socket+0x73/0xb0 net/socket.c:1354
  do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 11170:
  save_stack+0x45/0xd0 mm/kasan/common.c:73
  set_track mm/kasan/common.c:85 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/common.c:458
  kasan_slab_free+0xe/0x10 mm/kasan/common.c:466
  __cache_free mm/slab.c:3487 [inline]
  kfree+0xcf/0x230 mm/slab.c:3806
  sk_prot_free net/core/sock.c:1514 [inline]
  __sk_destruct+0x76d/0xa60 net/core/sock.c:1596
  sk_destruct+0x7b/0x90 net/core/sock.c:1604
  __sk_free+0xce/0x300 net/core/sock.c:1615
  sk_free+0x42/0x50 net/core/sock.c:1626
  sock_put include/net/sock.h:1707 [inline]
  nr_heartbeat_expiry+0x489/0x520 net/netrom/nr_timer.c:130
  call_timer_fn+0x254/0x900 kernel/time/timer.c:1325
  expire_timers kernel/time/timer.c:1362 [inline]
  __run_timers+0x6fc/0xd50 kernel/time/timer.c:1681
  run_timer_softirq+0x52/0xb0 kernel/time/timer.c:1694
  __do_softirq+0x30b/0xb11 kernel/softirq.c:292

The buggy address belongs to the object at ffff888089bba3c0
  which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 128 bytes inside of
  2048-byte region [ffff888089bba3c0, ffff888089bbabc0)
The buggy address belongs to the page:
page:ffffea000226ee80 count:1 mapcount:0 mapping:ffff88812c3f0c40  
index:0xffff888089bbb4c0 compound_mapcount: 0
flags: 0x1fffc0000010200(slab|head)
raw: 01fffc0000010200 ffffea0002608f08 ffffea0002501688 ffff88812c3f0c40
raw: ffff888089bbb4c0 ffff888089bba3c0 0000000100000001 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff888089bba300: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff888089bba380: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
> ffff888089bba400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                            ^
  ffff888089bba480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff888089bba500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================

