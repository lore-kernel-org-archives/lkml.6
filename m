Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D97C6787C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 22:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 696212087D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 22:15:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 696212087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbeJMFtf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 01:49:35 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:48527 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbeJMFte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 01:49:34 -0400
Received: by mail-io1-f70.google.com with SMTP id v12-v6so12433408iob.15
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 15:15:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=7Y6TXHJUpay/L+W9IZFVkAz4GobhaPzSQJUaScGDC9A=;
        b=EyHXsJWGZ1oMLMds6biZpUbtp8notC2uGoWZbyyS5lzNU4KFP19Y1vD+ycqmBXKZ5F
         NbHKCoih8oUuEzIWPqV52VD8wvBtQRQ8b5jNJqv/65YIpRUn+A3Ir2pkkOeLvJQxAkWx
         1wcz4dSA80UlX2PwHh3blCL7VP5EPjIibAq8TIQEVpqnpSnwJA+ZUYXjiriXJdvldz9K
         QqB5p6sj4rX7HbzY92bpQYfSeFqjdB9/SgI7NerVfxlLa0VIZIrZJliP+Uv40PH+lpYn
         C5ziVloPjQiTlLM4i1+jw6lJVROm8ntvVGTqbaRa129zUNErd5+zmPaEZ38BscEjJr+C
         Oiew==
X-Gm-Message-State: ABuFfoi3ftuiUWMsJRaPf0ehBDqY3WgZsTT4XF0SFhUxKMqqx/k+CAZN
        sfb7SNESCiZFTaNc0ciu0DqRxM6Zet7I8/RV+3PlZwdsKlUH
X-Google-Smtp-Source: ACcGV61yVag82QDPpu8M6IlnyXPRK111eNdVMlvUomcu8/LsqiHKT8Hn5wDXYL1aQ/otQYKrX1tg4rh3ZNDgq8mkBCVhUwjkPW/g
MIME-Version: 1.0
X-Received: by 2002:a24:6ecd:: with SMTP id w196-v6mr6633572itc.24.1539382503848;
 Fri, 12 Oct 2018 15:15:03 -0700 (PDT)
Date:   Fri, 12 Oct 2018 15:15:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000050c44f05780f6bbe@google.com>
Subject: WARNING in usb_submit_urb (3)
From:   syzbot <syzbot+24a30223a4b609bb802e@syzkaller.appspotmail.com>
To:     Thinh.Nguyen@synopsys.com, felipe.balbi@linux.intel.com,
        garsilva@embeddedor.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    9dcd936c5312 Merge tag 'for-4.19/dm-fixes-4' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=123b8da1400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=88e9a8a39dc0be2d
dashboard link: https://syzkaller.appspot.com/bug?extid=24a30223a4b609bb802e
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13888991400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1476e5e6400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+24a30223a4b609bb802e@syzkaller.appspotmail.com

IPVS: ftp: loaded support on port[0] = 21
------------[ cut here ]------------
usb usb7: BOGUS urb flags, 1 --> 0
WARNING: CPU: 0 PID: 5828 at drivers/usb/core/urb.c:503  
usb_submit_urb+0x717/0x14e0 drivers/usb/core/urb.c:502
Kernel panic - not syncing: panic_on_warn set ...

CPU: 0 PID: 5828 Comm: syz-executor149 Not tainted 4.19.0-rc7+ #278
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c4/0x2b4 lib/dump_stack.c:113
  panic+0x238/0x4e7 kernel/panic.c:184
  __warn.cold.8+0x163/0x1ba kernel/panic.c:536
  report_bug+0x254/0x2d0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:178 [inline]
  do_error_trap+0x1fc/0x4d0 arch/x86/kernel/traps.c:296
  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:316
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:993
RIP: 0010:usb_submit_urb+0x717/0x14e0 drivers/usb/core/urb.c:502
Code: 83 fc 48 8b 45 d0 48 8d b8 a0 00 00 00 e8 d1 be 44 ff 45 89 e0 44 89  
e9 4c 89 fa 48 89 c6 48 c7 c7 00 72 71 88 e8 09 b3 4d fc <0f> 0b e8 12 e0  
83 fc 48 c7 c6 00 73 71 88 4c 89 f7 e8 53 e1 83 fc
RSP: 0018:ffff8801bb42f268 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff8801d754d300 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff81650405 RDI: 0000000000000005
RBP: ffff8801bb42f2d8 R08: ffff8801d8fa6200 R09: fffffbfff12720fc
R10: fffffbfff12720fc R11: ffffffff893907e3 R12: 0000000000000000
R13: 0000000000000001 R14: 0000000000000000 R15: ffff8801cdc41bc0
  proc_do_submiturb+0x1b7d/0x4020 drivers/usb/core/devio.c:1781
  proc_submiturb_compat+0x544/0x800 drivers/usb/core/devio.c:2015
  usbdev_do_ioctl+0x19a2/0x3b50 drivers/usb/core/devio.c:2492
  usbdev_ioctl+0x25/0x30 drivers/usb/core/devio.c:2569
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:501 [inline]
  do_vfs_ioctl+0x1de/0x1720 fs/ioctl.c:685
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:702
  __do_sys_ioctl fs/ioctl.c:709 [inline]
  __se_sys_ioctl fs/ioctl.c:707 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:707
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x444769
Code: 25 02 00 85 c0 b8 00 00 00 00 48 0f 44 c3 5b c3 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 2b d7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00000000007eff78 EFLAGS: 00000213 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007ffc1a2515c0 RCX: 0000000000444769
RDX: 0000000020000080 RSI: 00000000802c550a RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000120080522 R09: 0000000120080522
R10: 000000000000000f R11: 0000000000000213 R12: 0000000000402320
R13: 00000000004023b0 R14: 0000000000000000 R15: 0000000000000000
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
