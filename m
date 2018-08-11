Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9311C4646D
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 16:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B24821A5E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 16:39:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B24821A5E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbeHKTNt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 15:13:49 -0400
Received: from mail-it0-f70.google.com ([209.85.214.70]:52478 "EHLO
        mail-it0-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727485AbeHKTNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 15:13:49 -0400
Received: by mail-it0-f70.google.com with SMTP id l185-v6so4977381ite.2
        for <linux-kernel@vger.kernel.org>; Sat, 11 Aug 2018 09:39:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=12wLXiMIjz6kkwkyjYTRxZdAiuDXU3wXQxEz7sFIRs8=;
        b=NCdclp7ssA4WwKDpKKC1zX2zj8+A6ed7Gx8i2wPWfAEenYMhu/2zq+IfNQx1/HLp+8
         TEJc/lqg9yABGclG1sufhm7AY1KcZbAb8BVYNs9pN3FoJB9ZtJy3IwrMLnmTXquzXbwc
         h2gOTFVL0qkZoDi6UU9PpYWfE8E6/fdRflZ27Fje1rDDaQG29uBqbcEaiPtf5o1CMKpg
         Oxq/65KTuQ1wot236nEh7EBcPbvXb/nusXpigfp52sQYy8iibCiQ++2mWfQNAQppu09+
         VuJEJ34C/XTdyq6mbVAWvLVTsqx1G3VYhrCDdXrKPCibn/kErqXtm/7ruIRmmxm4401C
         CBww==
X-Gm-Message-State: AOUpUlGBQe7lv0Z68HXm/dvGwuaFYkleuDXdKj6Q8N8dkbnFGjfq/gry
        jdOirXYD+bxLl4OFZsBkjnJwW2gTXhEnnupsHiuYpbJYoXoU
X-Google-Smtp-Source: AA+uWPzDLoA4pmV9cVARmV2eI0DBnii/GvJ0JwK0IKAyiCwCUPV+Zh+lmZOh/rMueY8UkMtF6MgFk/D1RovEHE5YdVLd4jzJZjlk
MIME-Version: 1.0
X-Received: by 2002:a5e:cb07:: with SMTP id p7-v6mr2288171iom.29.1534005543418;
 Sat, 11 Aug 2018 09:39:03 -0700 (PDT)
Date:   Sat, 11 Aug 2018 09:39:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007fc64805732b7f38@google.com>
Subject: WARNING in kvm_set_tsc_khz
From:   syzbot <syzbot+c03f30b4f4c46bdf8575@syzkaller.appspotmail.com>
To:     hpa@zytor.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, pbonzini@redhat.com, rkrcmar@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    2b769bb85b48 Add linux-next specific files for 20180807
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=154d6672400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=547d800b8773c2c5
dashboard link: https://syzkaller.appspot.com/bug?extid=c03f30b4f4c46bdf8575
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=120b8672400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13203f78400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+c03f30b4f4c46bdf8575@syzkaller.appspotmail.com

random: sshd: uninitialized urandom read (32 bytes read)
urandom_read: 1 callbacks suppressed
random: sshd: uninitialized urandom read (32 bytes read)
------------[ cut here ]------------
user requested TSC rate below hardware speed
WARNING: CPU: 1 PID: 4340 at arch/x86/kvm/x86.c:1414 set_tsc_khz  
arch/x86/kvm/x86.c:1414 [inline]
WARNING: CPU: 1 PID: 4340 at arch/x86/kvm/x86.c:1414  
kvm_set_tsc_khz+0x4f1/0x540 arch/x86/kvm/x86.c:1463
Kernel panic - not syncing: panic_on_warn set ...

CPU: 1 PID: 4340 Comm: syz-executor003 Not tainted  
4.18.0-rc8-next-20180807+ #33
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
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:996
RIP: 0010:set_tsc_khz arch/x86/kvm/x86.c:1414 [inline]
RIP: 0010:kvm_set_tsc_khz+0x4f1/0x540 arch/x86/kvm/x86.c:1463
Code: c7 c7 40 1a 02 87 c6 05 77 b6 79 07 01 e8 67 6a 3b 00 0f 0b e9 ed fd  
ff ff e8 6b d1 70 00 48 c7 c7 e0 19 02 87 e8 4f 6a 3b 00 <0f> 0b bb ff ff  
ff ff e9 d0 fd ff ff 89 45 d0 e8 4b cf af 00 8b 45
RSP: 0018:ffff8801bf3c7398 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 000000000023185f RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8163ec91 RDI: ffff8801bf3c7088
RBP: ffff8801bf3c73d8 R08: ffff8801b0b3e400 R09: fffffbfff0ff1288
R10: fffffbfff0ff1288 R11: ffffffff87f89443 R12: ffff8801ae6e8040
R13: 00000000002315b8 R14: 000000000023185f R15: 0000000000000000
  kvm_arch_vcpu_init+0x269/0x830 arch/x86/kvm/x86.c:8702
  kvm_vcpu_init+0x2fb/0x420 arch/x86/kvm/../../../virt/kvm/kvm_main.c:317
  vmx_create_vcpu+0x14c/0x28b0 arch/x86/kvm/vmx.c:10691
  kvm_arch_vcpu_create+0xe5/0x220 arch/x86/kvm/x86.c:8401
  kvm_vm_ioctl_create_vcpu arch/x86/kvm/../../../virt/kvm/kvm_main.c:2476  
[inline]
  kvm_vm_ioctl+0x488/0x1d80 arch/x86/kvm/../../../virt/kvm/kvm_main.c:2977
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:501 [inline]
  do_vfs_ioctl+0x1de/0x1720 fs/ioctl.c:685
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:702
  __do_sys_ioctl fs/ioctl.c:709 [inline]
  __se_sys_ioctl fs/ioctl.c:707 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:707
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x440109
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 fb 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffda4f501e8 EFLAGS: 00000217 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 0000000000440109
RDX: 0000000000000000 RSI: 000000000000ae41 RDI: 0000000000000004
RBP: 00000000006ca018 R08: 00000000004002c8 R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000217 R12: 0000000000401990
R13: 0000000000401a20 R14: 0000000000000000 R15: 0000000000000000
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
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
