Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0850C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 14:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A2BF20862
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 14:55:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A2BF20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbeK0BtZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 20:49:25 -0500
Received: from mail-it1-f199.google.com ([209.85.166.199]:38510 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbeK0BtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 20:49:25 -0500
Received: by mail-it1-f199.google.com with SMTP id j190-v6so23016104itj.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 06:55:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=F3Q/ZwxAczt8tr6CmXA9kiyz31TX/ENibbWDO5W5yLE=;
        b=NFYrwU3LeV1C5OFCwdSgJlfIktPgSwnVoTcEQ81NHhBgFD8LedagKMfszqGonJvhip
         sX1JH8YEIhPzRz2CCT+o/HOdnjTwDUGNprd9M0JsRoWgX6DUDDQd97pWb+ai0+MS3eVf
         J/VEgBI6fmjT09ASIyQ/q/TQNTp/KvItoNjI7n8p10ojuCsHJY6p1r9bNW/cM4HhN2DV
         m3HeHf173WWJkO1laU0NoDlINt6WC18yK1ez1aDqym1huFvrE4QsDJ7+x7geraQwMVA7
         OI/AvV/vMErVNTVpaUFr1JcEXNJ3xWeh1+XAtH7thqIiHelRqD26dd5EDueOoLWyTAFf
         jfKQ==
X-Gm-Message-State: AGRZ1gI835sMUzp2dWXabzUBO2uGBeu7dw0OxL38gC6ge7WkPvD6FAad
        iH+NgHUnqDSZNhD/Js8W2zIksOGBOYcyOeWbB93iSDX9BUTC
X-Google-Smtp-Source: AFSGD/U4H9F5fFH48mlsDdfR156EM0na8leMIfad9aupQr+1cwEiJW3W6TRBzxw0HFR6mAUV6u5ssDLoxf/B7wmr3PvFMOfL+Bx9
MIME-Version: 1.0
X-Received: by 2002:a24:1f0f:: with SMTP id d15mr17640482itd.31.1543244103311;
 Mon, 26 Nov 2018 06:55:03 -0800 (PST)
Date:   Mon, 26 Nov 2018 06:55:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000094bcc5057b92843f@google.com>
Subject: KASAN: invalid-free in hub_event
From:   syzbot <syzbot+98881958e1410ec7e53c@syzkaller.appspotmail.com>
To:     drinkcat@chromium.org, felipe.balbi@linux.intel.com,
        gregkh@linuxfoundation.org, jflat@chromium.org, joe@perches.com,
        kai.heng.feng@canonical.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, mathias.nyman@linux.intel.com,
        stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    d6d460b89378 Merge tag 'dma-mapping-4.20-3' of git://git.i..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17bd99eb400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=73e2bc0cb6463446
dashboard link: https://syzkaller.appspot.com/bug?extid=98881958e1410ec7e53c
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+98881958e1410ec7e53c@syzkaller.appspotmail.com

erofs: read_super, device -> /dev/loop5
erofs: options ->  
nouser_xattr,fault_injection=0x00000000000007ff,fowner>00000000000000000000,uid<00000000000000000000,subj_type=ntfs
erofs: cannot find valid erofs superblock
vhci_hcd: default hub control req: 0080 v0400 i0000 l0
==================================================================
BUG: KASAN: double-free or invalid-free in port_over_current_notify  
drivers/usb/core/hub.c:5192 [inline]
BUG: KASAN: double-free or invalid-free in port_event  
drivers/usb/core/hub.c:5241 [inline]
BUG: KASAN: double-free or invalid-free in hub_event+0xd97/0x4140  
drivers/usb/core/hub.c:5384

CPU: 1 PID: 32710 Comm: kworker/1:3 Not tainted 4.20.0-rc3+ #129
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x39d lib/dump_stack.c:113
  print_address_description.cold.7+0x9/0x1ff mm/kasan/report.c:256
  kasan_report_invalid_free+0x64/0xa0 mm/kasan/report.c:336
  __kasan_slab_free+0x13a/0x150 mm/kasan/kasan.c:501
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xcf/0x230 mm/slab.c:3817
  port_over_current_notify drivers/usb/core/hub.c:5192 [inline]
  port_event drivers/usb/core/hub.c:5241 [inline]
  hub_event+0xd97/0x4140 drivers/usb/core/hub.c:5384
  process_one_work+0xc90/0x1c40 kernel/workqueue.c:2153
  worker_thread+0x17f/0x1390 kernel/workqueue.c:2296
  kthread+0x35a/0x440 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352

Allocated by task 32710:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc7/0xe0 mm/kasan/kasan.c:553
  __do_kmalloc mm/slab.c:3722 [inline]
  __kmalloc_track_caller+0x157/0x760 mm/slab.c:3737
  kvasprintf+0xb5/0x150 lib/kasprintf.c:25
  kasprintf+0xab/0xe0 lib/kasprintf.c:59
  port_over_current_notify drivers/usb/core/hub.c:5185 [inline]
  port_event drivers/usb/core/hub.c:5241 [inline]
  hub_event+0xd5e/0x4140 drivers/usb/core/hub.c:5384
  process_one_work+0xc90/0x1c40 kernel/workqueue.c:2153
  worker_thread+0x17f/0x1390 kernel/workqueue.c:2296
  kthread+0x35a/0x440 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352

Freed by task 32580:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xcf/0x230 mm/slab.c:3817
  port_over_current_notify drivers/usb/core/hub.c:5192 [inline]
  port_event drivers/usb/core/hub.c:5241 [inline]
  hub_event+0xd97/0x4140 drivers/usb/core/hub.c:5384
  process_one_work+0xc90/0x1c40 kernel/workqueue.c:2153
  worker_thread+0x17f/0x1390 kernel/workqueue.c:2296
  kthread+0x35a/0x440 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352

The buggy address belongs to the object at ffff8881bf0d01c0
  which belongs to the cache kmalloc-32 of size 32
The buggy address is located 0 bytes inside of
  32-byte region [ffff8881bf0d01c0, ffff8881bf0d01e0)
The buggy address belongs to the page:
page:ffffea0006fc3400 count:1 mapcount:0 mapping:ffff8881da8001c0  
index:0xffff8881bf0d0fc1
flags: 0x2fffc0000000200(slab)
raw: 02fffc0000000200 ffffea00074d4b88 ffffea0007528bc8 ffff8881da8001c0
raw: ffff8881bf0d0fc1 ffff8881bf0d0000 000000010000003d 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8881bf0d0080: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
  ffff8881bf0d0100: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
> ffff8881bf0d0180: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
                                            ^
  ffff8881bf0d0200: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
  ffff8881bf0d0280: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
