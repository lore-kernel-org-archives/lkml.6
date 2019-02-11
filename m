Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3970AC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 17:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14C4D21B1A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 17:03:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728994AbfBKRDF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 12:03:05 -0500
Received: from mail-it1-f200.google.com ([209.85.166.200]:44124 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728837AbfBKRDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 12:03:05 -0500
Received: by mail-it1-f200.google.com with SMTP id x82so21546760ita.9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 09:03:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=9MWNKI7QPos2ZG1XKXr1tFwdrj+jca2f21/xI+Hfqs8=;
        b=F+YnGomkIf2aPL6SxuuqQAz4aaRpyUfKAN5ZKrb7u1AobXj5Rqb6X1HVlw6iIXd50N
         RS/8uY2e+P7oVJ2yRKVeu0/jIgrpFqr2/L2JeNjsGtDG2ilzW5dl4wlVmAAi6kPdyVWA
         OGqCTjyWUGFheG69Jd05FiGytBJs9AZvPaw0QHXpSRz5QotEviq3qKxYrthbezNNhgXW
         /eegi2w1Hm6BqZsX4U3fF3mDoY1EILYgRBH49HX0BmeRnN744bpWv8CNnub05G2GIvsy
         Ucht1sefTSkbWWCg3DPbSlDQuh5CFyjn0S9cCjCEbLBbYLaVAwscFDIAmg4H839omrVg
         yG/w==
X-Gm-Message-State: AHQUAuaVIk+DT+AKUDk0cKCkyGykzYM3pWHog5iQzJHplVTDFOMoj8sH
        npP5cDMdu2NeayNk5ha9vcdHqDVYZYmZWtTQ+OgWAiS062wY
X-Google-Smtp-Source: AHgI3IbCgEkDI6K449V048Raq5Tk+c3x0csAhMlk3lRk/amTFCB2D/jdtLYGpE0YZ+xBo/Q8rkvjSAas7mq3NKA19n1J0bZtAgrJ
MIME-Version: 1.0
X-Received: by 2002:a24:3653:: with SMTP id l80mr305597itl.3.1549904583953;
 Mon, 11 Feb 2019 09:03:03 -0800 (PST)
Date:   Mon, 11 Feb 2019 09:03:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002996510581a1487e@google.com>
Subject: general protection fault in qca_setup
From:   syzbot <syzbot+8c0dbf8843bb75efaa05@syzkaller.appspotmail.com>
To:     johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, marcel@holtmann.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    d13937116f1e Linux 5.0-rc6
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=143d98a7400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ee434566c893c7b1
dashboard link: https://syzkaller.appspot.com/bug?extid=8c0dbf8843bb75efaa05
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=130894af400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10799004c00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+8c0dbf8843bb75efaa05@syzkaller.appspotmail.com

audit: type=1800 audit(1549875669.720:29): pid=7626 uid=0 auid=4294967295  
ses=4294967295 subj=_ op=collect_data cause=failed(directio)  
comm="startpar" name="rc.local" dev="sda1" ino=2432 res=0
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 1170 Comm: kworker/u5:0 Not tainted 5.0.0-rc6 #67
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: hci0 hci_power_on
RIP: 0010:serdev_device_get_drvdata include/linux/serdev.h:125 [inline]
RIP: 0010:qca_setup+0x134/0x1550 drivers/bluetooth/hci_qca.c:1180
Code: c1 ea 03 80 3c 02 00 0f 85 08 12 00 00 48 b8 00 00 00 00 00 fc ff df  
4c 8b 63 08 49 8d bc 24 f8 00 00 00 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f  
85 d7 11 00 00 4d 8b ac 24 f8 00 00 00 49 8d 85 f0
RSP: 0018:ffff8880a793fa00 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffff8880a5f60040 RCX: ffffffff84ecfa52
RDX: 000000000000001f RSI: ffffffff84ee0c01 RDI: 00000000000000f8
RBP: ffff8880a793fb50 R08: ffff8880a79402c0 R09: 0000000000000004
R10: ffffed1011a8306d R11: ffff88808d41836f R12: 0000000000000000
R13: ffff8880906bd400 R14: ffff8880a793fb28 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2a8ce9c000 CR3: 0000000097f45000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  hci_uart_setup+0x1c4/0x490 drivers/bluetooth/hci_ldisc.c:418
  hci_dev_do_open+0x67e/0x14b0 net/bluetooth/hci_core.c:1423
  hci_power_on+0x10d/0x580 net/bluetooth/hci_core.c:2130
  process_one_work+0x98e/0x1790 kernel/workqueue.c:2173
  worker_thread+0x98/0xe40 kernel/workqueue.c:2319
  kthread+0x357/0x430 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
Modules linked in:
---[ end trace fc288de046e877c8 ]---
RIP: 0010:serdev_device_get_drvdata include/linux/serdev.h:125 [inline]
RIP: 0010:qca_setup+0x134/0x1550 drivers/bluetooth/hci_qca.c:1180
Code: c1 ea 03 80 3c 02 00 0f 85 08 12 00 00 48 b8 00 00 00 00 00 fc ff df  
4c 8b 63 08 49 8d bc 24 f8 00 00 00 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f  
85 d7 11 00 00 4d 8b ac 24 f8 00 00 00 49 8d 85 f0
RSP: 0018:ffff8880a793fa00 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffff8880a5f60040 RCX: ffffffff84ecfa52
RDX: 000000000000001f RSI: ffffffff84ee0c01 RDI: 00000000000000f8
RBP: ffff8880a793fb50 R08: ffff8880a79402c0 R09: 0000000000000004
R10: ffffed1011a8306d R11: ffff88808d41836f R12: 0000000000000000
R13: ffff8880906bd400 R14: ffff8880a793fb28 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2a8ce9c000 CR3: 0000000097f45000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
