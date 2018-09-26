Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A2EC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F81C20842
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:27:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F81C20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbeIZUkS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 16:40:18 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:53334 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727157AbeIZUkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 16:40:17 -0400
Received: by mail-io1-f71.google.com with SMTP id x7-v6so10753583iop.20
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 07:27:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=3b5j9il5ZKuMdtC0y6iOxsN7EnWrVjnS2X2XsjhgtHg=;
        b=HJra6BkXDD5MEohw3CybCe0emEAawBLwctqxJFgDdRoUZq20xZj4Vv5N7n1kQ5Q9Uq
         PuStE9S3N0JeCWtaY3ibvckFKs355cyfQ8QaacCrRji4pe/VLow734SxXX4T90O/9k2W
         m64UG8RHIpdZ/T1D/1ytSEiXCS3DV1zlUIBiFOlD5sIRlQUaXZeKADZTQ0YroyCW36D7
         bk0GwlRdmSFLz0nFNojwl4WYl1p56R5SiVgc8FdP+f7H/4zO9n+oW3Lmb0WwUbxaN2QV
         6OJWTGdYeC6hR3I7ak1TRrwL0LLqbprZ8NXrWw0oufHW4CzvUMnfmdVJROh/RFg1ND0D
         W3hA==
X-Gm-Message-State: ABuFfogg2vUuju5QG1czIZ0hil5nALV+DYmKzGQ0AjpvJy88spzu4+rn
        2UI/YmKRxUqmsSec/mMmZ6AiqgtGFzQ3bWrRrJIsBm/fbbpE
X-Google-Smtp-Source: ACcGV6243+nR4GEfH2YY4ILIBLJFTY2IWbA2uJj67HEJKQSGuCAHlm/plvU6n2aOgvBWp8dRkvdb8vC6HxshrtNCQELv78LW3A2V
MIME-Version: 1.0
X-Received: by 2002:a02:8a0a:: with SMTP id j10-v6mr4900386jak.32.1537972024034;
 Wed, 26 Sep 2018 07:27:04 -0700 (PDT)
Date:   Wed, 26 Sep 2018 07:27:04 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002ad1ad0576c70475@google.com>
Subject: KASAN: use-after-free Read in rdma_resolve_addr
From:   syzbot <syzbot+5013f86be1187ccf3800@syzkaller.appspotmail.com>
To:     danielj@mellanox.com, dledford@redhat.com, jgg@ziepe.ca,
        leon@kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, parav@mellanox.com,
        swise@opengridcomputing.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    846e8dd47c26 Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=113cfbfa400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dfb440e26f0a6f6f
dashboard link: https://syzkaller.appspot.com/bug?extid=5013f86be1187ccf3800
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+5013f86be1187ccf3800@syzkaller.appspotmail.com

binder: 12750:12764 transaction failed 29201/-71, size 0-8 line 2762
audit: type=1326 audit(1537939130.796:20382): auid=4294967295 uid=0 gid=0  
ses=4294967295 subj==unconfined pid=12758 comm="syz-executor4"  
exe="/root/syz-executor4" sig=0 arch=c000003e syscall=228 compat=0  
ip=0x45a3da code=0x50000
==================================================================
BUG: KASAN: use-after-free in rdma_resolve_addr+0x1e97/0x2730  
drivers/infiniband/core/cma.c:2981
Read of size 2 at addr ffff88018529b1e0 by task syz-executor2/12772

CPU: 1 PID: 12772 Comm: syz-executor2 Not tainted 4.19.0-rc5+ #254
audit: type=1326 audit(1537939130.846:20383): auid=4294967295 uid=0 gid=0  
ses=4294967295 subj==unconfined pid=12758 comm="syz-executor4"  
exe="/root/syz-executor4" sig=0 arch=c000003e syscall=202 compat=0  
ip=0x457579 code=0x50000
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c4/0x2b4 lib/dump_stack.c:113
  print_address_description.cold.8+0x9/0x1ff mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.9+0x242/0x309 mm/kasan/report.c:412
  __asan_report_load2_noabort+0x14/0x20 mm/kasan/report.c:431
  rdma_resolve_addr+0x1e97/0x2730 drivers/infiniband/core/cma.c:2981
audit: type=1326 audit(1537939130.846:20384): auid=4294967295 uid=0 gid=0  
ses=4294967295 subj==unconfined pid=12758 comm="syz-executor4"  
exe="/root/syz-executor4" sig=0 arch=c000003e syscall=228 compat=0  
ip=0x45a3da code=0x50000
  ucma_resolve_ip+0x242/0x2a0 drivers/infiniband/core/ucma.c:713
  ucma_write+0x336/0x420 drivers/infiniband/core/ucma.c:1686
audit: type=1326 audit(1537939130.866:20385): auid=4294967295 uid=0 gid=0  
ses=4294967295 subj==unconfined pid=12758 comm="syz-executor4"  
exe="/root/syz-executor4" sig=0 arch=c000003e syscall=298 compat=0  
ip=0x457579 code=0x50000
  __vfs_write+0x119/0x9f0 fs/read_write.c:485
audit: type=1326 audit(1537939130.866:20386): auid=4294967295 uid=0 gid=0  
ses=4294967295 subj==unconfined pid=12758 comm="syz-executor4"  
exe="/root/syz-executor4" sig=0 arch=c000003e syscall=228 compat=0  
ip=0x45a3da code=0x50000
  vfs_write+0x1fc/0x560 fs/read_write.c:549
  ksys_write+0x101/0x260 fs/read_write.c:598
  __do_sys_write fs/read_write.c:610 [inline]
  __se_sys_write fs/read_write.c:607 [inline]
  __x64_sys_write+0x73/0xb0 fs/read_write.c:607
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
audit: type=1326 audit(1537939130.876:20387): auid=4294967295 uid=0 gid=0  
ses=4294967295 subj==unconfined pid=12758 comm="syz-executor4"  
exe="/root/syz-executor4" sig=0 arch=c000003e syscall=202 compat=0  
ip=0x457579 code=0x50000
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457579
Code: 1d b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 eb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
audit: type=1326 audit(1537939130.876:20388): auid=4294967295 uid=0 gid=0  
ses=4294967295 subj==unconfined pid=12758 comm="syz-executor4"  
exe="/root/syz-executor4" sig=0 arch=c000003e syscall=202 compat=0  
ip=0x457579 code=0x50000
RSP: 002b:00007f451b87cc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457579
RDX: 0000000000000048 RSI: 0000000020000240 RDI: 0000000000000009
RBP: 000000000072bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f451b87d6d4
R13: 00000000004cb6a0 R14: 00000000004d8cb8 R15: 00000000ffffffff

binder: BINDER_SET_CONTEXT_MGR already set
Allocated by task 12777:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc7/0xe0 mm/kasan/kasan.c:553
  kmem_cache_alloc_trace+0x152/0x750 mm/slab.c:3620
  kmalloc include/linux/slab.h:513 [inline]
  kzalloc include/linux/slab.h:707 [inline]
  __rdma_create_id+0xdf/0x790 drivers/infiniband/core/cma.c:784
  ucma_create_id+0x39b/0x990 drivers/infiniband/core/ucma.c:504
binder: 12750:12773 ioctl 40046207 0 returned -16
  ucma_write+0x336/0x420 drivers/infiniband/core/ucma.c:1686
  __vfs_write+0x119/0x9f0 fs/read_write.c:485
  vfs_write+0x1fc/0x560 fs/read_write.c:549
  ksys_write+0x101/0x260 fs/read_write.c:598
  __do_sys_write fs/read_write.c:610 [inline]
  __se_sys_write fs/read_write.c:607 [inline]
  __x64_sys_write+0x73/0xb0 fs/read_write.c:607
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

audit: type=1326 audit(1537939130.886:20389): auid=4294967295 uid=0 gid=0  
ses=4294967295 subj==unconfined pid=12758 comm="syz-executor4"  
exe="/root/syz-executor4" sig=0 arch=c000003e syscall=202 compat=0  
ip=0x457579 code=0x50000
Freed by task 12770:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xcf/0x230 mm/slab.c:3813
  rdma_destroy_id+0x835/0xcc0 drivers/infiniband/core/cma.c:1739
  ucma_close+0x100/0x300 drivers/infiniband/core/ucma.c:1765
  __fput+0x385/0xa30 fs/file_table.c:278
  ____fput+0x15/0x20 fs/file_table.c:309
  task_work_run+0x1e8/0x2a0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:193 [inline]
  exit_to_usermode_loop+0x318/0x380 arch/x86/entry/common.c:166
audit: type=1326 audit(1537939130.926:20390): auid=4294967295 uid=0 gid=0  
ses=4294967295 subj==unconfined pid=12758 comm="syz-executor4"  
exe="/root/syz-executor4" sig=0 arch=c000003e syscall=202 compat=0  
ip=0x457579 code=0x50000
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

audit: type=1326 audit(1537939130.926:20391): auid=4294967295 uid=0 gid=0  
ses=4294967295 subj==unconfined pid=12758 comm="syz-executor4"  
exe="/root/syz-executor4" sig=0 arch=c000003e syscall=202 compat=0  
ip=0x457579 code=0x50000
The buggy address belongs to the object at ffff88018529b1c0
  which belongs to the cache kmalloc-2048 of size 2048
The buggy address is located 32 bytes inside of
  2048-byte region [ffff88018529b1c0, ffff88018529b9c0)
The buggy address belongs to the page:
page:ffffea000614a680 count:1 mapcount:0 mapping:ffff8801da800c40  
index:0xffff88018529a940
binder: 12750:12764 ERROR: BC_REGISTER_LOOPER called without request
  compound_mapcount: 0
flags: 0x2fffc0000008100(slab|head)
raw: 02fffc0000008100 ffffea00061c4188 ffffea000632af08 ffff8801da800c40
raw: ffff88018529a940 ffff88018529a0c0 0000000100000002 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff88018529b080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff88018529b100: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
> ffff88018529b180: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
                                                        ^
  ffff88018529b200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff88018529b280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================
kobject: 'loop5' (000000002cf6e86e): kobject_uevent_env


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
