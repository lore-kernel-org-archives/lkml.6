Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_DIGITS,
	FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A54EECE567
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 17:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D451121569
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 17:24:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D451121569
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390867AbeIUXNy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 19:13:54 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:47618 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390433AbeIUXNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 19:13:54 -0400
Received: by mail-io1-f70.google.com with SMTP id v20-v6so23329145iom.14
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 10:24:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=ZIxpE0dUPPNVLQegKzTGAxWT5g35vSJBAN69lNL23dw=;
        b=QV+Yu4P7+tOTSmN7vzL74/m0YYC6WgXnuXX2BVHWrOXMSZZRe/OsMdtSQGYphsTNiZ
         tKs+0GVFRjj/QshdiJRXphZmDddPruikrqv1SEc9DfGkg88J+Eshu2jC9MyRKaOXI85s
         jmZzlVsbjmfo8/4eR/nNxpgShXm9VOJk33DvnmteZKp8fB3rY0kQ3eGYYjxe1yVIcrBA
         3vo1uRJ/DoX1fJpQysISPOAqHev1USgYyNKV1PRQj7VlFElNtX1kMTQQbCAzrpefrd0c
         MgMsgPWDM7e2AZg5ZXbjn4X3VXd1UxmtNcnMOg/SWsPDiF+s5c0DiVQtzOFFJ6SKYz5k
         Bp2Q==
X-Gm-Message-State: APzg51DiNbcbWV1EkD07dxGT8OvPJ7YxMf1jQo21Bspny/rdvfqF1z8h
        mWSNzZ0gcoxQk8XQYtdMWf8ZcDCodwB6yN+eOpR31Qu12XQ1
X-Google-Smtp-Source: ANB0VdYhKxUTplhyBeCWyD9mTYfddQAj81gqKeVX7j1hDSoaIYaB4x11kUzRONJaoFa7CAvXYG3oh0ALyVIUSTltVgWbm8YivGDC
MIME-Version: 1.0
X-Received: by 2002:a02:c9b:: with SMTP id 27-v6mr1104127jan.3.1537550642966;
 Fri, 21 Sep 2018 10:24:02 -0700 (PDT)
Date:   Fri, 21 Sep 2018 10:24:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e5f76c057664e73d@google.com>
Subject: WARNING: kmalloc bug in input_mt_init_slots
From:   syzbot <syzbot+87829a10073277282ad1@syzkaller.appspotmail.com>
To:     dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, rydberg@bitmath.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    234b69e3e089 ocfs2: fix ocfs2 read block panic
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=131f761a400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5fa12be50bca08d8
dashboard link: https://syzkaller.appspot.com/bug?extid=87829a10073277282ad1
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=126ca61a400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=119d6511400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+87829a10073277282ad1@syzkaller.appspotmail.com

input: syz0 as /devices/virtual/input/input25382
WARNING: CPU: 0 PID: 11238 at mm/slab_common.c:1031 kmalloc_slab+0x56/0x70  
mm/slab_common.c:1031
Kernel panic - not syncing: panic_on_warn set ...

CPU: 0 PID: 11238 Comm: syz-executor124 Not tainted 4.19.0-rc4+ #25
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
RIP: 0010:kmalloc_slab+0x56/0x70 mm/slab_common.c:1031
kobject: 'input25395' (00000000663cc863): kobject_cleanup, parent            
(null)
Code: c5 40 2b 17 89 5d c3 48 85 ff b8 10 00 00 00 74 f4 83 ef 01 c1 ef 03  
0f b6 87 60 2a 17 89 eb d8 31 c0 81 e6 00 02 00 00 75 db <0f> 0b 5d c3 48  
8b 04 c5 80 2a 17 89 5d c3 66 90 66 2e 0f 1f 84 00
kobject: 'input25395' (00000000663cc863): calling ktype release
RSP: 0018:ffff8801c477f978 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 00000000fffffffd RCX: ffffffff8534b947
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000003fffffff60
RBP: ffff8801c477f978 R08: ffff8801d2eee000 R09: ffffed003731ee41
R10: ffff8801c477fa48 R11: ffff8801b98f720f R12: 0000000000000000
R13: 0000000000000000 R14: ffff8801b92ac9c0 R15: 00000000006080c0
  __do_kmalloc mm/slab.c:3713 [inline]
  __kmalloc+0x25/0x760 mm/slab.c:3727
kobject: 'input25395': free name
  kmalloc include/linux/slab.h:518 [inline]
  kzalloc include/linux/slab.h:707 [inline]
  input_mt_init_slots+0xe5/0x4a0 drivers/input/input-mt.c:52
  uinput_create_device drivers/input/misc/uinput.c:335 [inline]
  uinput_ioctl_handler.isra.10+0x2049/0x2540 drivers/input/misc/uinput.c:876
  uinput_ioctl+0x4c/0x60 drivers/input/misc/uinput.c:1047
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:501 [inline]
  do_vfs_ioctl+0x1de/0x1720 fs/ioctl.c:685
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:702
  __do_sys_ioctl fs/ioctl.c:709 [inline]
  __se_sys_ioctl fs/ioctl.c:707 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:707
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x446ec9
Code: e8 2c b3 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 2b 09 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fa83f4b1da8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000006dbc28 RCX: 0000000000446ec9
RDX: 0000000000446ec9 RSI: 0000000000005501 RDI: 0000000000000004
RBP: 00000000006dbc20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dbc2c
R13: 6e69752f7665642f R14: 00007fa83f4b29c0 R15: 00000000006dbd2c
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
