Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F37AFC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 17:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C831A206B2
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 17:10:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C831A206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406218AbeKWDuU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 22:50:20 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:34927 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbeKWDuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 22:50:20 -0500
Received: by mail-io1-f70.google.com with SMTP id n12-v6so9063872ioh.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 09:10:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=ceZI5TjOUMURUtRxtej52ZdfdY445P83Jrhz3F/LVBc=;
        b=HDjyUKzQul7KUcy9mToPcM3KWRgLnmJVfVkNVk5SsMngvA4bpuz6/rYDt/BpqUShYQ
         Pv2wPlGNLAHPLa2qXPGhnXykzkuduZl+vBfOfdv3Za4gFqRCRYfA1CFGSWthIVjzJ4X7
         ZehoIKFpGWD8lDpkjv1QSpiZMiMjERHq50KTZhPb7YYeVOvc9n5AGbDO2+rpRS/bZplX
         D4wsH8B/YeMzrQ0GxhEyjWoSbnn8qGoLIezi/vx6+9LiwhORyiaUCn3wVR3mqmBt/ark
         cwLefdp++8wylAOnPRsWBSiSU2SqCTgkprqvKYV6BFnq2K+SGX9T4uykGevQnooq1lUq
         Q16g==
X-Gm-Message-State: AGRZ1gIx7lvObN/ivpDBe/R3t26CrV63e1dQ9Pv2ky6lK8pfcuYzY+7m
        uKqI2i1IRZ7+uRoC5T/8TjEy9w2l0uNcRvAa2YdygguZlWmU
X-Google-Smtp-Source: AJdET5eZ9LovZohycN4niVMOwwqvsf1RU1j52oiyvEnmVyW0htpmPwy3iaC78j/Yjkuy53gH8o7K728aa+z7BMn5XS5iOWfPf22M
MIME-Version: 1.0
X-Received: by 2002:a24:76d4:: with SMTP id z203-v6mr7644319itb.24.1542906603793;
 Thu, 22 Nov 2018 09:10:03 -0800 (PST)
Date:   Thu, 22 Nov 2018 09:10:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000a7c8c057b43f025@google.com>
Subject: WARNING in vkms_plane_duplicate_state
From:   syzbot <syzbot+eb6e5365f23c02517dda@syzkaller.appspotmail.com>
To:     airlied@linux.ie, daniel.vetter@ffwll.ch,
        dri-devel@lists.freedesktop.org, gustavo.padovan@collabora.com,
        hamohammed.sa@gmail.com, linux-kernel@vger.kernel.org,
        rodrigosiqueiramelo@gmail.com, seanpaul@chromium.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    92b419289cee Merge tag 'riscv-for-linus-4.20-rc4' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17ed377b400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=73e2bc0cb6463446
dashboard link: https://syzkaller.appspot.com/bug?extid=eb6e5365f23c02517dda
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1507d533400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=113be77b400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+eb6e5365f23c02517dda@syzkaller.appspotmail.com

RDX: 0000000020000080 RSI: ffffffffffffffb7 RDI: 0000000000000003
RBP: 00007ffecec49940 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: ffffffffffffffff
R13: 0000000000000004 R14: 0000000000000000 R15: 0000000000000000
WARNING: CPU: 0 PID: 8437 at drivers/gpu/drm/vkms/vkms_plane.c:26  
vkms_plane_duplicate_state+0x9f/0x120 drivers/gpu/drm/vkms/vkms_plane.c:26
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 8437 Comm: syz-executor513 Not tainted 4.20.0-rc3+ #344
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
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
RIP: 0010:vkms_plane_duplicate_state+0x9f/0x120  
drivers/gpu/drm/vkms/vkms_plane.c:26
Code: 00 0f 85 86 00 00 00 48 8b 3d fd aa db 04 ba f8 00 00 00 be c0 80 60  
00 e8 de fc 76 fd 48 85 c0 49 89 c5 75 13 e8 11 fb 33 fd <0f> 0b 48 c7 c7  
80 20 7b 88 e8 17 47 1a fd e8 fe fa 33 fd 48 8d bb
RSP: 0018:ffff8881afd2f6f8 EFLAGS: 00010293
RAX: ffff8881b7360040 RBX: ffff8881d781b900 RCX: 0000000000000004
RDX: 0000000000000000 RSI: ffffffff844b8fdf RDI: 0000000000000286
RBP: ffff8881afd2f710 R08: ffff8881b7360040 R09: ffffed103b5c5b67
R10: ffffed103b5c5b67 R11: ffff8881dae2db3b R12: ffff8881d1eb3680
R13: 0000000000000000 R14: 0000000000000000 R15: ffff8881afd2f860
  drm_atomic_get_plane_state+0x225/0x560 drivers/gpu/drm/drm_atomic.c:465
  drm_atomic_helper_disable_plane+0x7b/0x200  
drivers/gpu/drm/drm_atomic_helper.c:2776
  __setplane_atomic+0x2a3/0x330 drivers/gpu/drm/drm_plane.c:715
  setplane_internal+0x127/0x370 drivers/gpu/drm/drm_plane.c:754
  drm_mode_setplane+0x567/0x830 drivers/gpu/drm/drm_plane.c:814
  drm_ioctl_kernel+0x278/0x330 drivers/gpu/drm/drm_ioctl.c:757
  drm_ioctl+0x57e/0xb00 drivers/gpu/drm/drm_ioctl.c:853
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:509 [inline]
  do_vfs_ioctl+0x1de/0x1790 fs/ioctl.c:696
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:713
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl fs/ioctl.c:718 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x444dc9
Code: e8 ac e8 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 2b ce fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffecec49928 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000444dc9
RDX: 0000000020000080 RSI: ffffffffffffffb7 RDI: 0000000000000003
RBP: 00007ffecec49940 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: ffffffffffffffff
R13: 0000000000000004 R14: 0000000000000000 R15: 0000000000000000
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
