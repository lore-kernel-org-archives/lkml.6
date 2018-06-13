Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SORTED_RECIPS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 2BD20C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 07:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFAC0208BA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 07:51:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFAC0208BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754552AbeFMHvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 03:51:04 -0400
Received: from mail-it0-f70.google.com ([209.85.214.70]:35773 "EHLO
        mail-it0-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754495AbeFMHvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 03:51:02 -0400
Received: by mail-it0-f70.google.com with SMTP id k18-v6so1831051itb.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 00:51:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=RnzQKRQmFgM7THym9N3SG7ATiv5ZtfNTrCX7t8Ljx08=;
        b=XzYzlQ+w2XgHV+wfes9qOyvSFItFcSZmVTaVd0sOsaEmmJElSO7Vtys69QOpAJjBAy
         17D1HNSYSLBWhpuZ/vQ0IUYueXatuyZawu3f26lgTDwMGAUdSl54lbA/Z4X7HW16Zszl
         j15/b3dLoBj5zqMBQuz/SNp2tpmuBOj23T2rpF+n9EgjYqYDs0Vxx6Miv//mFXCabR2Y
         mGwdy6/Fc0LSj/ZXd/T7nV6s4vFrEpAMRNHTOcECyiNGVySe6ezzM4Hsa5RxybzN+oM6
         MuFlxecLuUrqg46QymTTXyuKdPX9dAx6leTd35TWUISKVoUk5avLyI3nNagbEBiU2zfV
         Jj1A==
X-Gm-Message-State: APt69E3fhi/pDjsQy1Z0NxDSfPAQGx6wVT09xZtO7Ujezm8slfiKrzi8
        Bw4Bfpcy3ec1RepdFoyXqs68X4QrB8yKB8SkhM7wqMIxoVPP
X-Google-Smtp-Source: ADUXVKJLi5SeA+e54ZnxC7KYCE6/WQ5o7swxRIqu3eNIhK51qSKFH8beCodT7OoQyx5ONO72SpGH7dwWlOHj1OJQ5Pbqp6/wT2Py
MIME-Version: 1.0
X-Received: by 2002:a6b:b744:: with SMTP id h65-v6mr1633586iof.110.1528876262076;
 Wed, 13 Jun 2018 00:51:02 -0700 (PDT)
Date:   Wed, 13 Jun 2018 00:51:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000081bd9d056e813e48@google.com>
Subject: KASAN: out-of-bounds Read in rds_cong_queue_updates (2)
From:   syzbot <syzbot+287843ad8a4d2870e538@syzkaller.appspotmail.com>
To:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
        rds-devel@oss.oracle.com, santosh.shilimkar@oracle.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    0adb32858b0b Linux 4.16
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=138f2d0b800000
kernel config:  https://syzkaller.appspot.com/x/.config?x=df0c336cc3b55d45
dashboard link: https://syzkaller.appspot.com/bug?extid=287843ad8a4d2870e538
compiler:       gcc (GCC) 7.1.1 20170620

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+287843ad8a4d2870e538@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: out-of-bounds in __read_once_size include/linux/compiler.h:188  
[inline]
BUG: KASAN: out-of-bounds in atomic_read arch/x86/include/asm/atomic.h:27  
[inline]
BUG: KASAN: out-of-bounds in refcount_read include/linux/refcount.h:42  
[inline]
BUG: KASAN: out-of-bounds in check_net include/net/net_namespace.h:228  
[inline]
BUG: KASAN: out-of-bounds in rds_destroy_pending net/rds/rds.h:868 [inline]
BUG: KASAN: out-of-bounds in rds_cong_queue_updates+0x4d3/0x4f0  
net/rds/cong.c:226
Read of size 4 at addr ffff88018d7f2204 by task kworker/u4:6/10561

CPU: 1 PID: 10561 Comm: kworker/u4:6 Not tainted 4.16.0+ #10
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: krdsd rds_send_worker
Call Trace:
  __dump_stack lib/dump_stack.c:17 [inline]
  dump_stack+0x194/0x24d lib/dump_stack.c:53
kernel msg: ebtables bug: please report to author: Wrong len argument
  print_address_description+0x73/0x250 mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report+0x23c/0x360 mm/kasan/report.c:412
  __asan_report_load4_noabort+0x14/0x20 mm/kasan/report.c:432
  __read_once_size include/linux/compiler.h:188 [inline]
  atomic_read arch/x86/include/asm/atomic.h:27 [inline]
  refcount_read include/linux/refcount.h:42 [inline]
  check_net include/net/net_namespace.h:228 [inline]
  rds_destroy_pending net/rds/rds.h:868 [inline]
  rds_cong_queue_updates+0x4d3/0x4f0 net/rds/cong.c:226
  rds_recv_rcvbuf_delta.part.2+0x289/0x320 net/rds/recv.c:118
  rds_recv_rcvbuf_delta net/rds/recv.c:377 [inline]
  rds_recv_incoming+0xeb4/0x11d0 net/rds/recv.c:377
  rds_loop_xmit+0x149/0x320 net/rds/loop.c:82
  rds_send_xmit+0xbcd/0x26b0 net/rds/send.c:355
  rds_send_worker+0x115/0x2a0 net/rds/threads.c:199
  process_one_work+0xc47/0x1bb0 kernel/workqueue.c:2113
  worker_thread+0x223/0x1990 kernel/workqueue.c:2247
  kthread+0x33c/0x400 kernel/kthread.c:238
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:406

The buggy address belongs to the page:
page:ffffea000635fc80 count:3 mapcount:2 mapping:0000000000000000 index:0x0
flags: 0x2fffc0000000000()
raw: 02fffc0000000000 0000000000000000 0000000000000000 0000000300000001
raw: dead000000000100 dead000000000200 0000000000000000 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff88018d7f2100: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  ffff88018d7f2180: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ffff88018d7f2200: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
                       ^
  ffff88018d7f2280: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  ffff88018d7f2300: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================
Kernel panic - not syncing: panic_on_warn set ...

CPU: 1 PID: 10561 Comm: kworker/u4:6 Tainted: G    B            4.16.0+ #10
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: krdsd rds_send_worker
Call Trace:
  __dump_stack lib/dump_stack.c:17 [inline]
  dump_stack+0x194/0x24d lib/dump_stack.c:53
  panic+0x1e4/0x41c kernel/panic.c:183
  kasan_end_report+0x50/0x50 mm/kasan/report.c:180
  kasan_report_error mm/kasan/report.c:359 [inline]
  kasan_report+0x149/0x360 mm/kasan/report.c:412
  __asan_report_load4_noabort+0x14/0x20 mm/kasan/report.c:432
  __read_once_size include/linux/compiler.h:188 [inline]
  atomic_read arch/x86/include/asm/atomic.h:27 [inline]
  refcount_read include/linux/refcount.h:42 [inline]
  check_net include/net/net_namespace.h:228 [inline]
  rds_destroy_pending net/rds/rds.h:868 [inline]
  rds_cong_queue_updates+0x4d3/0x4f0 net/rds/cong.c:226
  rds_recv_rcvbuf_delta.part.2+0x289/0x320 net/rds/recv.c:118
  rds_recv_rcvbuf_delta net/rds/recv.c:377 [inline]
  rds_recv_incoming+0xeb4/0x11d0 net/rds/recv.c:377
  rds_loop_xmit+0x149/0x320 net/rds/loop.c:82
  rds_send_xmit+0xbcd/0x26b0 net/rds/send.c:355
  rds_send_worker+0x115/0x2a0 net/rds/threads.c:199
  process_one_work+0xc47/0x1bb0 kernel/workqueue.c:2113
  worker_thread+0x223/0x1990 kernel/workqueue.c:2247
  kthread+0x33c/0x400 kernel/kthread.c:238
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:406
Dumping ftrace buffer:
    (ftrace buffer empty)
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
