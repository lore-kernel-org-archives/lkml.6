Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C960C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 22:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 629E4218A1
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 22:03:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbfBKWDO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 17:03:14 -0500
Received: from mail-it1-f197.google.com ([209.85.166.197]:56217 "EHLO
        mail-it1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbfBKWDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 17:03:05 -0500
Received: by mail-it1-f197.google.com with SMTP id j3so813858itf.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 14:03:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=j3AXgMNaVIGsmCPfsHrZp4AOejYK8ex22vlRJApwzzM=;
        b=KQC8UH7la1VrYJ+pjY1cQdlUfKksZycCBwEL46BDuQJmwRo3sfZraf6hDXekT5gpsN
         H0vQr18Ym6Nhb1pTJlK9tDMOGglvMyBx7PvrGi0JnU3AyZjQ4yGlqy8QkYRLpkwZyM6U
         RcaSgxJeRum/5gvsIm/eCS+oTK/kiY/ARxAzQ7U6CvN23uTqO8it++jmwcICCzVSqF3f
         74foULYKtoaseGaurQm4h+qyLP/oHq2pUN7C+ubQBzdfe5FY6U9uLUkOudlW334CEDC+
         lKRHJDQuaq9RoGbshzY71gzkZYTqu/Qx83no+6NtLTFG+OFV0RomJcgEDDHvJYdoeGBy
         YNhg==
X-Gm-Message-State: AHQUAuYku7VS+mdvVdrDZCst6tr0Gqsu5cFb5Af5GEXdmxSaKsWksVX8
        iwPbMs6F3CZBI5Itz4hEUdDq8Ya9sKU0+8eiCQieWEsbZhuI
X-Google-Smtp-Source: AHgI3IaEDIVjPhOTEhVm/BBKobX69CHKa4/OMVzt14iPIum5HWBEJtciLpWX9jUoBvhkuTAPzkb9GC3HVw8lVWL/ETAl/wV1koIW
MIME-Version: 1.0
X-Received: by 2002:a6b:c30a:: with SMTP id t10mr334465iof.10.1549922584346;
 Mon, 11 Feb 2019 14:03:04 -0800 (PST)
Date:   Mon, 11 Feb 2019 14:03:04 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000011c9310581a579e8@google.com>
Subject: WARNING in vkms_vblank_simulate
From:   syzbot <syzbot+0871b14ca2e2fb64f6e3@syzkaller.appspotmail.com>
To:     airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        hamohammed.sa@gmail.com, linux-kernel@vger.kernel.org,
        rodrigosiqueiramelo@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    d4104460aec1 Add linux-next specific files for 20190211
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10e74624c00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c8a112d3b0d6719b
dashboard link: https://syzkaller.appspot.com/bug?extid=0871b14ca2e2fb64f6e3
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12d8e6b0c00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15c6c804c00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+0871b14ca2e2fb64f6e3@syzkaller.appspotmail.com

WARNING: CPU: 1 PID: 7773 at drivers/gpu/drm/vkms/vkms_crtc.c:40  
vkms_vblank_simulate+0x262/0x2c0 drivers/gpu/drm/vkms/vkms_crtc.c:40
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 7773 Comm: syz-executor184 Not tainted 5.0.0-rc5-next-20190211  
#32
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  <IRQ>
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  panic+0x2cb/0x65c kernel/panic.c:214
  __warn.cold+0x20/0x45 kernel/panic.c:571
  report_bug+0x263/0x2b0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:178 [inline]
  fixup_bug arch/x86/kernel/traps.c:173 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:271
  do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:290
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:973
RIP: 0010:vkms_vblank_simulate+0x262/0x2c0  
drivers/gpu/drm/vkms/vkms_crtc.c:40
Code: c7 c7 a0 bc bd 87 e8 5d 3d bb ff e9 2c fe ff ff e8 13 0e 9b fd 48 8b  
45 d0 49 89 86 40 02 00 00 e9 7a ff ff ff e8 fe 0d 9b fd <0f> 0b e9 f4 fe  
ff ff e8 b2 d2 d2 fd e9 34 fe ff ff e8 08 d3 d2 fd
RSP: 0018:ffff8880ae907dd8 EFLAGS: 00010006
RAX: ffff888098fb2480 RBX: ffff8880ae925d80 RCX: ffffffff83d53af3
RDX: 0000000000010000 RSI: ffffffff83d53c02 RDI: 0000000000000007
RBP: ffff8880ae907e08 R08: ffff888098fb2480 R09: ffffffff899a5048
R10: ffffffff899a5050 R11: 0000000000000001 R12: 0000000000055ce8
R13: ffff8881d09a99c0 R14: 0000000000000000 R15: ffff8881d09a8e98
  __run_hrtimer kernel/time/hrtimer.c:1389 [inline]
  __hrtimer_run_queues+0x33e/0xde0 kernel/time/hrtimer.c:1451
  hrtimer_interrupt+0x314/0x770 kernel/time/hrtimer.c:1509
  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1035 [inline]
  smp_apic_timer_interrupt+0x120/0x570 arch/x86/kernel/apic/apic.c:1060
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:807
  </IRQ>
RIP: 0010:arch_local_irq_restore arch/x86/include/asm/paravirt.h:767  
[inline]
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:160  
[inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0x95/0xe0  
kernel/locking/spinlock.c:184
Code: 48 c7 c0 f0 89 92 88 48 ba 00 00 00 00 00 fc ff df 48 c1 e8 03 80 3c  
10 00 75 39 48 83 3d c2 86 8b 01 00 74 24 48 89 df 57 9d <0f> 1f 44 00 00  
bf 01 00 00 00 e8 cc c2 46 fa 65 8b 05 45 ea fa 78
RSP: 0018:ffff88801de8f938 EFLAGS: 00000286 ORIG_RAX: ffffffffffffff13
RAX: 1ffffffff112513e RBX: 0000000000000286 RCX: 0000000000000000
RDX: dffffc0000000000 RSI: 0000000000000006 RDI: 0000000000000286
RBP: ffff88801de8f948 R08: ffff888098fb2480 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff8881d09a8430
R13: 0000000000000000 R14: ffff8881d09a8430 R15: ffff888066cda608
  spin_unlock_irqrestore include/linux/spinlock.h:384 [inline]
  drm_vblank_get+0x150/0x1e0 drivers/gpu/drm/drm_vblank.c:1006
  drm_wait_vblank_ioctl+0x4f8/0x17a0 drivers/gpu/drm/drm_vblank.c:1627
  drm_ioctl_kernel+0x23e/0x2e0 drivers/gpu/drm/drm_ioctl.c:758
  drm_ioctl+0x545/0xa50 drivers/gpu/drm/drm_ioctl.c:858
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:509 [inline]
  do_vfs_ioctl+0xd6e/0x1390 fs/ioctl.c:696
  ksys_ioctl+0xab/0xd0 fs/ioctl.c:713
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl fs/ioctl.c:718 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x443ca9
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b d8 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fff8472a0d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000004002e0 RCX: 0000000000443ca9
RDX: 0000000020000000 RSI: 00000000c018643a RDI: 0000000000000003
RBP: 00000000006ce018 R08: 0000000000000000 R09: 00000000004002e0
R10: 000000000000000f R11: 0000000000000246 R12: 00000000004019b0
R13: 0000000000401a40 R14: 0000000000000000 R15: 0000000000000000
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
