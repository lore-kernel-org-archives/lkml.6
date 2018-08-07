Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C40DBC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 11:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74BD2217BD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 11:16:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74BD2217BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388719AbeHGN3x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 09:29:53 -0400
Received: from mail-io0-f198.google.com ([209.85.223.198]:33558 "EHLO
        mail-io0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727388AbeHGN3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 09:29:52 -0400
Received: by mail-io0-f198.google.com with SMTP id s14-v6so12110009ioc.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 04:16:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=5j7FWE/CBwyLgTBQcX8cHQ18EMQ7yeYvHSHfeDfDUBQ=;
        b=Sgzf7LXWWr6SeJ8rIPAnuafVdry3WWORnupa7Nhag2/5eqKzAbGcsqJBZCNQQ0na75
         s3ph0mU09O8dK5VVKVuO0Rmrxy/N+/S7luF4m5WK3sU8fVgdNdP7BTlA0XuOrR0XYmzm
         XavDfpPJ9HyPqu7H3ZRHvs2HUCgoVsQHFhjJH+WGpLWwCqmQTlKmQfHHcIV3/AkAdMZn
         HsOf+omc921xRBRQyvPqGUzLV1HTIIi/epjW2FpXahZXk1PSmjNEcl1HIen5BWiTwnDn
         vcXf16AAhaJNtiCrQmXODnM54uJFXkaKbN3U4HaKDMXnaJ4uzSW/UIO+hS8fHCeulVLd
         BhVA==
X-Gm-Message-State: AOUpUlGyJ/SgzxUtOUtld2a9o6at8GEF6Hhv/HyWO8NiyNFwyo7r7aXF
        i0YvzfURoQthgzHBx6Cj3onxAKjUYWFBW7UpqF5npl776iFD
X-Google-Smtp-Source: AA+uWPzOhRHYnCfTOdOwmchCrsVpLR98h86+WX2/dtE0XQUbDph5RaMpHbIR7tdScQYK3VOkwset08uMVoiEhv35/M6optU0wEV4
MIME-Version: 1.0
X-Received: by 2002:a6b:3f57:: with SMTP id m84-v6mr9384350ioa.57.1533640562148;
 Tue, 07 Aug 2018 04:16:02 -0700 (PDT)
Date:   Tue, 07 Aug 2018 04:16:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000eb92240572d68452@google.com>
Subject: KASAN: use-after-free Read in iotlb_access_ok
From:   syzbot <syzbot+c51e6736a1bf614b3272@syzkaller.appspotmail.com>
To:     jasowang@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mst@redhat.com,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    e30cb13c5a09 Merge git://git.kernel.org/pub/scm/linux/kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10a153e0400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2dc0cd7c2eefb46f
dashboard link: https://syzkaller.appspot.com/bug?extid=c51e6736a1bf614b3272
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+c51e6736a1bf614b3272@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in vhost_vq_meta_fetch drivers/vhost/vhost.c:702  
[inline]
BUG: KASAN: use-after-free in iotlb_access_ok+0x5c9/0x600  
drivers/vhost/vhost.c:1177
Read of size 8 at addr ffff880197df2fc0 by task vhost-8938/8941

CPU: 0 PID: 8941 Comm: vhost-8938 Not tainted 4.18.0-rc7+ #174
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
  print_address_description+0x6c/0x20b mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
  vhost_vq_meta_fetch drivers/vhost/vhost.c:702 [inline]
  iotlb_access_ok+0x5c9/0x600 drivers/vhost/vhost.c:1177
  vq_iotlb_prefetch+0x10e/0x230 drivers/vhost/vhost.c:1214
  handle_rx+0x247/0x1f80 drivers/vhost/net.c:799
  handle_rx_net+0x19/0x20 drivers/vhost/net.c:934
  vhost_worker+0x283/0x490 drivers/vhost/vhost.c:360
  kthread+0x345/0x410 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412

Allocated by task 8938:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:553
  kmem_cache_alloc_trace+0x152/0x780 mm/slab.c:3620
  kmalloc include/linux/slab.h:513 [inline]
  vhost_new_umem_range+0xcb/0x7c0 drivers/vhost/vhost.c:911
  vhost_process_iotlb_msg drivers/vhost/vhost.c:1000 [inline]
  vhost_chr_write_iter+0xe53/0x1a00 drivers/vhost/vhost.c:1043
  vhost_net_chr_write_iter+0x59/0x70 drivers/vhost/net.c:1399
  call_write_iter include/linux/fs.h:1793 [inline]
  new_sync_write fs/read_write.c:474 [inline]
  __vfs_write+0x6c6/0x9f0 fs/read_write.c:487
  vfs_write+0x1f8/0x560 fs/read_write.c:549
  ksys_write+0x101/0x260 fs/read_write.c:598
  __do_sys_write fs/read_write.c:610 [inline]
  __se_sys_write fs/read_write.c:607 [inline]
  __x64_sys_write+0x73/0xb0 fs/read_write.c:607
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 8950:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xd9/0x260 mm/slab.c:3813
  vhost_umem_free+0x944/0x14d0 drivers/vhost/vhost.c:576
  vhost_umem_clean+0x83/0xf0 drivers/vhost/vhost.c:588
  vhost_init_device_iotlb+0x1d7/0x290 drivers/vhost/vhost.c:1568
  vhost_net_set_features drivers/vhost/net.c:1292 [inline]
  vhost_net_ioctl+0xff3/0x1a80 drivers/vhost/net.c:1357
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:500 [inline]
  do_vfs_ioctl+0x1de/0x1720 fs/ioctl.c:684
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:701
  __do_sys_ioctl fs/ioctl.c:708 [inline]
  __se_sys_ioctl fs/ioctl.c:706 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:706
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff880197df2f80
  which belongs to the cache kmalloc-96 of size 96
The buggy address is located 64 bytes inside of
  96-byte region [ffff880197df2f80, ffff880197df2fe0)
The buggy address belongs to the page:
page:ffffea00065f7c80 count:1 mapcount:0 mapping:ffff8801dac004c0 index:0x0
flags: 0x2fffc0000000100(slab)
raw: 02fffc0000000100 ffffea0007530148 ffffea000663b888 ffff8801dac004c0
raw: 0000000000000000 ffff880197df2000 0000000100000020 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff880197df2e80: fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
  ffff880197df2f00: fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
> ffff880197df2f80: fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
                                            ^
  ffff880197df3000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
  ffff880197df3080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
