Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C8B6C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 15:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED0C021486
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 15:26:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED0C021486
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391984AbeHPSZN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 14:25:13 -0400
Received: from mail-io0-f200.google.com ([209.85.223.200]:47134 "EHLO
        mail-io0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbeHPSZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 14:25:13 -0400
Received: by mail-io0-f200.google.com with SMTP id l25-v6so4264353iog.14
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 08:26:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=90TRrqHAL/lvgM+ZLlTDstoUhIiytd1xwUTjW/2CX2s=;
        b=quvW2MYK7AXBRmwyi6NaQWVEGnm3kfIdIVv/W+SfJ/Gou1I9+YkIaZZuvmzD/T8V82
         oDPina20RnTIAVZMPyh09x4R8ohqubxi3APmcw887gYDjnS0amTCl2UjeqtkR/ZyfQ0C
         6cLw05xiUufLuppPzK0ZdHjWwlXUvs3oXJOWBwOmvehZwzUgMhG39+CpheyfIHtvLc5D
         PSMoNbp7JwP3ba9sYFc62wUzSy3ec0CRK8R2NeGiy7VXTWWFN5lXvSmJ53Orvz93o/FB
         ucozp40bmanW2xXKxc7nd9XCdcCHG2OA2XBkgeBCvVBHq2vO8tAKI/T6bzIJwnj8acc/
         Cc6A==
X-Gm-Message-State: AOUpUlH37qr0sEvIGpDMJhjWuQ5VcGeVMuGgKtpasGb4wONBpRVppxU5
        63XuZjf9Dt1UZIOpMzw+amx17dParDDk23JKQPhG3iFTrQsP
X-Google-Smtp-Source: AA+uWPz+rWjo3PLBn6lyXVqWprYDr2rcIEZ4YXbEF4+mvo9TEy5QWtpopg9602M59QsQeOsDb31/i2sTJTB/K38wmj8QM6vYwwrX
MIME-Version: 1.0
X-Received: by 2002:a24:fa44:: with SMTP id v65-v6mr9437039ith.17.1534433163353;
 Thu, 16 Aug 2018 08:26:03 -0700 (PDT)
Date:   Thu, 16 Aug 2018 08:26:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a22cb205738f0f76@google.com>
Subject: KASAN: invalid-free in fscache_free_cookie
From:   syzbot <syzbot+c441f41d7e2f04ef32d2@syzkaller.appspotmail.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    31130a16d459 Merge tag 'for-linus-4.19-rc1-tag' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16676be2400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e8d52931cda051de
dashboard link: https://syzkaller.appspot.com/bug?extid=c441f41d7e2f04ef32d2
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+c441f41d7e2f04ef32d2@syzkaller.appspotmail.com

RDX: 0000000020000380 RSI: 0000000020000c80 RDI: 0000000000000000
RBP: 00000000009300a0 R08: 0000000020000cc0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000006
R13: 00000000004d2768 R14: 00000000004c7be5 R15: 000000000000001f
==================================================================
BUG: KASAN: double-free or invalid-free in fscache_free_cookie+0x230/0x280  
fs/fscache/cookie.c:67

CPU: 0 PID: 19158 Comm: syz-executor4 Not tainted 4.18.0+ #190
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
  print_address_description+0x6c/0x20b mm/kasan/report.c:256
  kasan_report_invalid_free+0x64/0xa0 mm/kasan/report.c:336
  __kasan_slab_free+0x150/0x170 mm/kasan/kasan.c:501
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xd9/0x260 mm/slab.c:3813
  fscache_free_cookie+0x230/0x280 fs/fscache/cookie.c:67
  fscache_alloc_cookie+0x74c/0x880 fs/fscache/cookie.c:202
  __fscache_acquire_cookie+0x230/0xb00 fs/fscache/cookie.c:303
  fscache_acquire_cookie include/linux/fscache.h:338 [inline]
  v9fs_cache_session_get_cookie+0xc4/0x270 fs/9p/cache.c:73
  v9fs_session_init+0x1013/0x1a80 fs/9p/v9fs.c:464
  v9fs_mount+0x7c/0x900 fs/9p/vfs_super.c:135
  mount_fs+0xae/0x328 fs/super.c:1277
  vfs_kern_mount.part.34+0xdc/0x4e0 fs/namespace.c:1046
  vfs_kern_mount fs/namespace.c:1036 [inline]
  do_new_mount fs/namespace.c:2542 [inline]
  do_mount+0x581/0x30e0 fs/namespace.c:2872
  ksys_mount+0x12d/0x140 fs/namespace.c:3088
  __do_sys_mount fs/namespace.c:3102 [inline]
  __se_sys_mount fs/namespace.c:3099 [inline]
  __x64_sys_mount+0xbe/0x150 fs/namespace.c:3099
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457089
Code: fd b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f7c72566c78 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f7c725676d4 RCX: 0000000000457089
RDX: 0000000020000380 RSI: 0000000020000c80 RDI: 0000000000000000
RBP: 00000000009300a0 R08: 0000000020000cc0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000006
R13: 00000000004d2768 R14: 00000000004c7be5 R15: 000000000000001f

Allocated by task 17919:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:553
  __do_kmalloc mm/slab.c:3718 [inline]
  __kmalloc+0x14e/0x760 mm/slab.c:3727
  kmalloc include/linux/slab.h:518 [inline]
  kzalloc include/linux/slab.h:707 [inline]
  fscache_set_key fs/fscache/cookie.c:101 [inline]
  fscache_alloc_cookie+0x701/0x880 fs/fscache/cookie.c:171
  __fscache_acquire_cookie+0x230/0xb00 fs/fscache/cookie.c:303
  fscache_acquire_cookie include/linux/fscache.h:338 [inline]
  v9fs_cache_session_get_cookie+0xc4/0x270 fs/9p/cache.c:73
  v9fs_session_init+0x1013/0x1a80 fs/9p/v9fs.c:464
  v9fs_mount+0x7c/0x900 fs/9p/vfs_super.c:135
  mount_fs+0xae/0x328 fs/super.c:1277
  vfs_kern_mount.part.34+0xdc/0x4e0 fs/namespace.c:1046
  vfs_kern_mount fs/namespace.c:1036 [inline]
  do_new_mount fs/namespace.c:2542 [inline]
  do_mount+0x581/0x30e0 fs/namespace.c:2872
  ksys_mount+0x12d/0x140 fs/namespace.c:3088
  __do_sys_mount fs/namespace.c:3102 [inline]
  __se_sys_mount fs/namespace.c:3099 [inline]
  __x64_sys_mount+0xbe/0x150 fs/namespace.c:3099
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 17919:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xd9/0x260 mm/slab.c:3813
  fscache_free_cookie+0x230/0x280 fs/fscache/cookie.c:67
  fscache_cookie_put+0x39d/0x850 fs/fscache/cookie.c:889
  __fscache_relinquish_cookie+0x494/0x911 fs/fscache/cookie.c:846
  fscache_relinquish_cookie include/linux/fscache.h:367 [inline]
  v9fs_cache_session_put_cookie+0x46/0x90 fs/9p/cache.c:87
  v9fs_session_close+0xf4/0x420 fs/9p/v9fs.c:498
  v9fs_kill_super+0x4e/0xa0 fs/9p/vfs_super.c:233
  deactivate_locked_super+0x97/0x100 fs/super.c:326
  v9fs_mount+0x461/0x900 fs/9p/vfs_super.c:214
  mount_fs+0xae/0x328 fs/super.c:1277
  vfs_kern_mount.part.34+0xdc/0x4e0 fs/namespace.c:1046
  vfs_kern_mount fs/namespace.c:1036 [inline]
  do_new_mount fs/namespace.c:2542 [inline]
  do_mount+0x581/0x30e0 fs/namespace.c:2872
  ksys_mount+0x12d/0x140 fs/namespace.c:3088
  __do_sys_mount fs/namespace.c:3102 [inline]
  __se_sys_mount fs/namespace.c:3099 [inline]
  __x64_sys_mount+0xbe/0x150 fs/namespace.c:3099
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8801d8a4a000
  which belongs to the cache kmalloc-64 of size 64
The buggy address is located 0 bytes inside of
  64-byte region [ffff8801d8a4a000, ffff8801d8a4a040)
The buggy address belongs to the page:
page:ffffea0007629280 count:1 mapcount:0 mapping:ffff8801dac00340 index:0x0
flags: 0x2fffc0000000100(slab)
raw: 02fffc0000000100 ffffea0007234b88 ffffea00072fb488 ffff8801dac00340
raw: 0000000000000000 ffff8801d8a4a000 0000000100000020 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801d8a49f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff8801d8a49f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ffff8801d8a4a000: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
                    ^
  ffff8801d8a4a080: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
  ffff8801d8a4a100: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
