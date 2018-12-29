Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 970CDC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 23:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B174217F9
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 23:01:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbeL2XBF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 18:01:05 -0500
Received: from mail-it1-f200.google.com ([209.85.166.200]:34845 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727869AbeL2XBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 18:01:04 -0500
Received: by mail-it1-f200.google.com with SMTP id v188so1925200ita.0
        for <linux-kernel@vger.kernel.org>; Sat, 29 Dec 2018 15:01:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=8smQGhjZj6tlgnj868FZkihWX1yj/45angnxILuocpI=;
        b=YmkMppKL3DXo2e9H+Agd7tt3xbW5P5xoyL0AXEQUMRaGKrV1oDMTIcVRYRMIWAhTDX
         FlQ2fLs0iqw1sukL+htNMl61n6gAmxnn2vUApzULPDF7nojHuC3gJPqKynB7T9hlXYo3
         lt8rjBI4KL3hgG9kCmhobjQvg944mt0/ExUE+FDiXPkAxFpRF2lGhp8oVd/jvFx3GCaX
         jtJQz26BhGk3QcilF9Sb0KUXPUO6LmoPETk8nmnNBSZ/tufXw1Itv6y19rFqimtLnzLV
         prXD7fpmbAAtPihuIvnwvPIWLnfXSqkh9WJFHE1oQuIBPj0/1y6KcklWT87dZxkDvyqX
         zQxA==
X-Gm-Message-State: AA+aEWbGNumrvDWPS/4y0nv0xKRwbdvbEkZmw46XjFMLrQqBc5p/kYjK
        RmsagrKCvJn7Gz2cCQQTUjavhPtcZn4vSnRqOzpYpdME8pTW
X-Google-Smtp-Source: AFSGD/U4Rl7ZMzPEIT9+Tb5mhZitwwnNTll+x49zi+FKuD/BCSfFjoLUds4WELe6xh1lJZwM227Az6Aqid9Nx5ZGY41pOsanPeF9
MIME-Version: 1.0
X-Received: by 2002:a24:5dd4:: with SMTP id w203mr23795218ita.8.1546124463662;
 Sat, 29 Dec 2018 15:01:03 -0800 (PST)
Date:   Sat, 29 Dec 2018 15:01:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006f735c057e312722@google.com>
Subject: WARNING in mmu_spte_clear_track_bits (2)
From:   syzbot <syzbot+9aaa207a0b90b704eeda@syzkaller.appspotmail.com>
To:     bp@alien8.de, hpa@zytor.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        pbonzini@redhat.com, rkrcmar@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    6a1d293238c1 Add linux-next specific files for 20181224
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=131ae9ed400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f9369d117d073843
dashboard link: https://syzkaller.appspot.com/bug?extid=9aaa207a0b90b704eeda
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15a6629b400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11a2d29b400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+9aaa207a0b90b704eeda@syzkaller.appspotmail.com

sshd (7857) used greatest stack depth: 15720 bytes left
L1TF CPU bug present and SMT on, data leak possible. See CVE-2018-3646 and  
https://www.kernel.org/doc/html/latest/admin-guide/l1tf.html for details.
WARNING: CPU: 0 PID: 7873 at arch/x86/kvm/mmu.c:830  
mmu_spte_clear_track_bits+0x45f/0x520 arch/x86/kvm/mmu.c:830
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 7873 Comm: syz-executor226 Not tainted 4.20.0-rc7-next-20181224  
#188
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1d3/0x2c6 lib/dump_stack.c:113
  panic+0x2ad/0x632 kernel/panic.c:214
  __warn.cold.8+0x20/0x4f kernel/panic.c:571
  report_bug+0x254/0x2d0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:176 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:269
  do_invalid_op+0x36/0x40 arch/x86/kernel/traps.c:288
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:973
RIP: 0010:mmu_spte_clear_track_bits+0x45f/0x520 arch/x86/kvm/mmu.c:830
Code: 40 ff ff ff 31 ff 44 89 fe 48 ba 00 00 00 00 00 fc ff df c6 04 10 f8  
e8 4f ad 70 00 45 85 ff 0f 85 65 fd ff ff e8 31 ac 70 00 <0f> 0b e9 59 fd  
ff ff e8 25 ac 70 00 4c 89 ef e8 4d 33 f7 ff 31 f6
RSP: 0018:ffff8881b9df6860 EFLAGS: 00010293
RAX: ffff8881b1b6c3c0 RBX: 40000001af5e8c77 RCX: ffffffff81114481
RDX: 0000000000000000 RSI: ffffffff8111448f RDI: 0000000000000005
RBP: ffff8881b9df6978 R08: ffff8881b1b6c3c0 R09: fffff94000d7af46
R10: fffff94000d7af46 R11: ffffea0006bd7a37 R12: 1ffff110373bed0e
R13: 00000000001af5e8 R14: ffff8881b9df6950 R15: 0000000000000000
  drop_spte+0x24/0x220 arch/x86/kvm/mmu.c:1468
  mmu_page_zap_pte+0x2d3/0x3a0 arch/x86/kvm/mmu.c:2613
  kvm_mmu_page_unlink_children arch/x86/kvm/mmu.c:2635 [inline]
  kvm_mmu_prepare_zap_page+0x1f9/0x1530 arch/x86/kvm/mmu.c:2679
  kvm_zap_obsolete_pages arch/x86/kvm/mmu.c:5843 [inline]
  kvm_mmu_invalidate_zap_all_pages+0x348/0x7b0 arch/x86/kvm/mmu.c:5884
  kvm_arch_flush_shadow_all+0x15/0x20 arch/x86/kvm/x86.c:9431
  kvm_mmu_notifier_release+0x59/0x90  
arch/x86/kvm/../../../virt/kvm/kvm_main.c:494
  __mmu_notifier_release+0x1e9/0x630 mm/mmu_notifier.c:68
  mmu_notifier_release include/linux/mmu_notifier.h:261 [inline]
  exit_mmap+0xa1/0x590 mm/mmap.c:3088
  __mmput kernel/fork.c:1045 [inline]
  mmput+0x247/0x610 kernel/fork.c:1066
  exit_mm kernel/exit.c:545 [inline]
  do_exit+0xdcc/0x25f0 kernel/exit.c:854
  do_group_exit+0x177/0x440 kernel/exit.c:970
  get_signal+0x8b0/0x1980 kernel/signal.c:2515
  do_signal+0x9c/0x21c0 arch/x86/kernel/signal.c:816
  exit_to_usermode_loop+0x2e5/0x380 arch/x86/entry/common.c:162
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x448c79
Code: e8 3c af 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 4b 0a fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fe328b1fcf8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 00000000006ddc58 RCX: 0000000000448c79
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00000000006ddc58
RBP: 00000000006ddc50 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006ddc5c
R13: 00007ffcaa19611f R14: 00007fe328b209c0 R15: 00000000006ddd4c
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
