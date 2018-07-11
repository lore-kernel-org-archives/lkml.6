Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B326DC1B0E3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 19:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6444620C0E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 19:55:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6444620C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390260AbeGKUA5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 16:00:57 -0400
Received: from mail-io0-f197.google.com ([209.85.223.197]:44007 "EHLO
        mail-io0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389132AbeGKUAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 16:00:55 -0400
Received: by mail-io0-f197.google.com with SMTP id n18-v6so23031044iog.10
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 12:55:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=2jyCPL8rk2YGACL0gsKVeR3mrb6ZZMOqPRRsiLCPEDk=;
        b=BiwiIOInFoWZHwCgu25+LHzCNfyTaFOUS4154sRbdCESi0D0p6unNUoTtPIA4PDGSf
         chB1a6W0+sSAzKQ4x0qMN4qeVr2Fe43LrrTeiItBYIL3oCUy4XkQ8imxBKjuF6H90ivR
         C4mLVu8Xqz+Y5ia4R2CxPQ2ng/uQ9nviCPHC6nGVQR6ZwgQZjOP8RujANfcw6TVn6K2M
         ycPjaR4F6FvzC98CK5r5sbpYHPvrWNPeM+cuv5wQcZo/+kJIqdtYNaF6APptm9zB1HXW
         13HqhOnLw9S4aIIXeolxzELwI2XH0tUf5I41rw2X7WzYt1mGlWDb+BLYusWI40wi8+7w
         ob5w==
X-Gm-Message-State: AOUpUlHYrvDNR1R8trmVmXBO4Suc7Zdn4RotYCHdBHRbXFt6mw3Kt7v+
        TlH23ru0dmPxA0f4f+2UdIKFj6HmgYKxbnN9A2hy1hFQJ4p3
X-Google-Smtp-Source: AAOMgpeqdWfVyydBSnA+g54Zf6POg29wMMOUmEPkvJ4VVW6s85E7N5MlFpv/fcTlPVD1MUAWG07W0TiRh1p1MZTBoM5D+1g6JkRx
MIME-Version: 1.0
X-Received: by 2002:a02:5c01:: with SMTP id q1-v6mr10528jab.31.1531338902435;
 Wed, 11 Jul 2018 12:55:02 -0700 (PDT)
Date:   Wed, 11 Jul 2018 12:55:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004f7eb00570be9f92@google.com>
Subject: WARNING in port_delete
From:   syzbot <syzbot+e4c8abb920efa77bace9@syzkaller.appspotmail.com>
To:     alsa-devel@alsa-project.org, colin.king@canonical.com,
        linux-kernel@vger.kernel.org, perex@perex.cz,
        syzkaller-bugs@googlegroups.com, tiwai@suse.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    30c2c32d7f70 Merge tag 'drm-fixes-2018-07-10' of git://ano..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=139408c8400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=25856fac4e580aa7
dashboard link: https://syzkaller.appspot.com/bug?extid=e4c8abb920efa77bace9
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+e4c8abb920efa77bace9@syzkaller.appspotmail.com

netlink: 8 bytes leftover after parsing attributes in process  
`syz-executor0'.
WARNING: CPU: 0 PID: 20823 at sound/core/seq/seq_ports.c:276  
port_delete+0x16e/0x1b0 sound/core/seq/seq_ports.c:276
Kernel panic - not syncing: panic_on_warn set ...

CPU: 0 PID: 20823 Comm: syz-executor4 Not tainted 4.18.0-rc4+ #140
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
  panic+0x238/0x4e7 kernel/panic.c:184
  __warn.cold.8+0x163/0x1ba kernel/panic.c:536
  report_bug+0x252/0x2d0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:178 [inline]
  do_error_trap+0x1fc/0x4d0 arch/x86/kernel/traps.c:296
  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:316
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:992
RIP: 0010:port_delete+0x16e/0x1b0 sound/core/seq/seq_ports.c:276
Code: 00 00 31 ff 44 89 e6 e8 e0 f8 9d fb 45 85 e4 75 14 e8 c6 f7 9d fb 48  
89 df e8 4e a6 db fb 31 c0 5b 41 5c 5d c3 e8 b2 f7 9d fb <0f> 0b eb e3 e8  
a9 f7 9d fb 0f 0b eb 9b e8 d0 d1 db fb eb bd e8 c9
RSP: 0018:ffff88019b9f78d0 EFLAGS: 00010293
RAX: ffff8801c5f74100 RBX: ffff8801b053adc0 RCX: ffffffff85de13d0
RDX: 0000000000000000 RSI: ffffffff85de13ee RDI: 0000000000000005
RBP: ffff88019b9f78e0 R08: ffff8801c5f74100 R09: 0000000000000006
R10: ffff8801c5f74100 R11: 0000000000000000 R12: 0000000000000001
R13: ffff8801b053ae10 R14: 1ffff1003373ef28 R15: ffff88019b95d6d0
  snd_seq_delete_port+0x3cb/0x4a0 sound/core/seq/seq_ports.c:303
  snd_seq_ioctl_delete_port+0xba/0x190 sound/core/seq/seq_clientmgr.c:1325
  snd_seq_kernel_client_ctl+0x15a/0x190 sound/core/seq/seq_clientmgr.c:2361
  snd_seq_event_port_detach+0xfb/0x160 sound/core/seq/seq_ports.c:705
  delete_port+0x7d/0xc0 sound/core/seq/oss/seq_oss_init.c:354
  snd_seq_oss_release+0xf2/0x130 sound/core/seq/oss/seq_oss_init.c:433
  odev_release+0x52/0x70 sound/core/seq/oss/seq_oss.c:153
  __fput+0x355/0x8b0 fs/file_table.c:209
  ____fput+0x15/0x20 fs/file_table.c:243
  task_work_run+0x1ec/0x2a0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:192 [inline]
  exit_to_usermode_loop+0x313/0x370 arch/x86/entry/common.c:166
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x40ff01
Code: 75 14 b8 03 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 34 19 00 00 c3 48  
83 ec 08 e8 0a fc ff ff 48 89 04 24 b8 03 00 00 00 0f 05 <48> 8b 3c 24 48  
89 c2 e8 53 fc ff ff 48 89 d0 48 83 c4 08 48 3d 01
RSP: 002b:0000000000a3eab0 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000015 RCX: 000000000040ff01
RDX: 0000000000000000 RSI: 00000000007328a0 RDI: 0000000000000014
RBP: 0000000000000013 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000a3e930 R11: 0000000000000293 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000a3f160 R15: 00000000007034c0
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
