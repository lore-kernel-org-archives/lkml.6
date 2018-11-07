Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE8F5C32789
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 01:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7D9B2086C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 01:52:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7D9B2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389176AbeKGLUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 06:20:15 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:52778 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389123AbeKGLUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 06:20:15 -0500
Received: by mail-io1-f70.google.com with SMTP id o8-v6so17577757iob.19
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 17:52:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=arY6G+OLX0YC5A8lAfczCtbVYd5Gc9+Ift/hcKfhPow=;
        b=hNnvtzWYb5+UshmmVcALcg5G1jPGt3nhYtdjJFMMKas5p2hAsCVmezP/eBas3W9mxl
         f87SzkP140NlfptPfXdi8LwLH+9FA3RTXEGDoyjF5ffsANPl+m/zfEW4oE6T5f78lO0g
         FqkDVpbY4yEhMP0SH4Y+CBAURXkfL+J/JWDhf3Xt7iYg1BgYprgCJhpTULyCRO7vqaMs
         7WUc50IxF+GeSajyrhRo48DdE042K+jca212bMT9m8EAChgnpfPmYpljTcQFUUBLZ02K
         Tlf8MjT47d1OzrMUjkits14v3IAgcS0n43c4yXI2lO6HN3IpjWpQv27DgEWQjJU/KtTP
         zYIA==
X-Gm-Message-State: AGRZ1gKymxRwkbUOVGseu3AZ22/kmh7xjVOpa7ynCNcpILleQVBRQhSK
        mJr2TH+spdFqbCDvE6pdwARAaWEfTWAiSNPnH1FHxGLU2YVh
X-Google-Smtp-Source: AJdET5fZhG0AWQ5ah9kjq3+xS1S/YkxY3kknakxCl09R/ot/CTAP9yWU79KfQDGB3Z65W9qfgTKZLO9X66yqpL7bQwCU2JEKZj+e
MIME-Version: 1.0
X-Received: by 2002:a24:1c88:: with SMTP id c130-v6mr180572itc.3.1541555523787;
 Tue, 06 Nov 2018 17:52:03 -0800 (PST)
Date:   Tue, 06 Nov 2018 17:52:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000065a79f057a095de8@google.com>
Subject: WARNING in usb_submit_urb (4)
From:   syzbot <syzbot+7634edaea4d0b341c625@syzkaller.appspotmail.com>
To:     Thinh.Nguyen@synopsys.com, felipe.balbi@linux.intel.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, shuah@kernel.org,
        stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    163c8d54a997 compiler: remove __no_sanitize_address_or_inl..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11af34b9400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f559fee2fc3375a
dashboard link: https://syzkaller.appspot.com/bug?extid=7634edaea4d0b341c625
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+7634edaea4d0b341c625@syzkaller.appspotmail.com

------------[ cut here ]------------
URB 000000004ff98a65 submitted while active
WARNING: CPU: 1 PID: 17 at drivers/usb/core/urb.c:363  
usb_submit_urb+0x11cf/0x14e0 drivers/usb/core/urb.c:363
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 17 Comm: kworker/1:0 Not tainted 4.20.0-rc1+ #322
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events_power_efficient hub_init_func2
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x39d lib/dump_stack.c:113
  panic+0x2ad/0x55c kernel/panic.c:188
  __warn.cold.8+0x20/0x45 kernel/panic.c:540
  report_bug+0x254/0x2d0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:178 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:271
  do_invalid_op+0x36/0x40 arch/x86/kernel/traps.c:290
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:969
RIP: 0010:usb_submit_urb+0x11cf/0x14e0 drivers/usb/core/urb.c:363
Code: ee e8 c5 f1 7b fc 45 84 ed 0f 85 e2 f6 ff ff e8 e7 f0 7b fc 48 89 de  
48 c7 c7 a0 21 92 88 c6 05 a6 bd 0d 05 01 e8 a1 52 45 fc <0f> 0b e9 c0 f6  
ff ff c7 45 a0 01 00 00 00 e9 65 f7 ff ff 41 bc ed
RSP: 0018:ffff8801d9b5f4f0 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff8801cdf30000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8165e9b5 RDI: 0000000000000005
RBP: ffff8801d9b5f560 R08: ffff8801d9b4c480 R09: ffffed003b5e5020
R10: ffffed003b5e5020 R11: ffff8801daf28107 R12: 00000000fffffff0
R13: 0000000000000000 R14: 0000000000000009 R15: ffff8801d9b5f6f8
  hub_activate+0xcab/0x1940 drivers/usb/core/hub.c:1215
  hub_init_func2+0x1e/0x30 drivers/usb/core/hub.c:1240
  process_one_work+0xc90/0x1c40 kernel/workqueue.c:2153
  worker_thread+0x17f/0x1390 kernel/workqueue.c:2296
  kthread+0x35a/0x440 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
