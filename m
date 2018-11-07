Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D274C32789
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 01:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6D8A2086C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 01:38:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6D8A2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389076AbeKGLGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 06:06:13 -0500
Received: from mail-it1-f197.google.com ([209.85.166.197]:38523 "EHLO
        mail-it1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731003AbeKGLGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 06:06:13 -0500
Received: by mail-it1-f197.google.com with SMTP id j190-v6so4792788itj.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 17:38:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=6vpWVkaXIwmz9cSkYlKWVhkSg3LlLH/uLlwkR1+SZFs=;
        b=GcwHbBA4guyMCYgZw/AGSsm6dYPGP+WOUv4lBA8TkLpMR1g/2N3RVUHKKu+g2QPx6u
         QnLKS1TltFAra346JvAxElE4KALs4f3vlfuQhWmNl4mojTqO0sjlI5BGR/EeweO7wVA0
         ZTKjdSeZ/pghJ/HQiKCpJZv57q01IXhgsRQo8zWD9082d8xqAcscoDeu9LWisyBNXR8d
         Pp6yiSLETJttkCjYEPeCuK9e2weNEQWCMQlUhSmOapt71Z+UYNPzXaGdoDI6sNRXU32B
         CjJBW1VttFGshfyntNy/6MD9rTdbGvom/ZlwSj11mTOAR0V+74pzOtOgOUpJ4CHHROOm
         s2nw==
X-Gm-Message-State: AGRZ1gITllLY0b1Meu0KaQJfD4hbd0oTA71f2QbI+pun0fVM+CHSWxuB
        otUd1rkdbyseGlC8vRu2HFXSzkJYVUoC++mFdJWbUGNgsYOp
X-Google-Smtp-Source: AJdET5e5ARrpnbV5WVia93Joff5BrMZUlBDIY3V2DGdJ+HcP3jYHsk7XQbvwX/8hYGnQMEkAjzCRomm0vTLOrE7kJ/DjqSCUePM0
MIME-Version: 1.0
X-Received: by 2002:a24:9085:: with SMTP id x127-v6mr157945itd.17.1541554684419;
 Tue, 06 Nov 2018 17:38:04 -0800 (PST)
Date:   Tue, 06 Nov 2018 17:38:04 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005de8da057a092ba2@google.com>
Subject: KMSAN: kernel-infoleak in kvm_vcpu_write_guest_page
From:   syzbot <syzbot+ded1696f6b50b615b630@syzkaller.appspotmail.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, rkrcmar@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    88b95ef4c780 kmsan: use MSan assembly instrumentation
git tree:       https://github.com/google/kmsan.git/master
console output: https://syzkaller.appspot.com/x/log.txt?x=12505e33400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8df5fc509a1b351b
dashboard link: https://syzkaller.appspot.com/bug?extid=ded1696f6b50b615b630
compiler:       clang version 8.0.0 (trunk 343298)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15ce62f5400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=174efca3400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+ded1696f6b50b615b630@syzkaller.appspotmail.com

==================================================================
BUG: KMSAN: kernel-infoleak in __copy_to_user include/linux/uaccess.h:121  
[inline]
BUG: KMSAN: kernel-infoleak in __kvm_write_guest_page  
arch/x86/kvm/../../../virt/kvm/kvm_main.c:1849 [inline]
BUG: KMSAN: kernel-infoleak in kvm_vcpu_write_guest_page+0x39a/0x510  
arch/x86/kvm/../../../virt/kvm/kvm_main.c:1870
CPU: 0 PID: 7918 Comm: syz-executor542 Not tainted 4.19.0+ #77
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x32d/0x480 lib/dump_stack.c:113
  kmsan_report+0x1a2/0x2e0 mm/kmsan/kmsan.c:911
  kmsan_internal_check_memory+0x34c/0x430 mm/kmsan/kmsan.c:991
  kmsan_copy_to_user+0x85/0xe0 mm/kmsan/kmsan_hooks.c:552
  __copy_to_user include/linux/uaccess.h:121 [inline]
  __kvm_write_guest_page arch/x86/kvm/../../../virt/kvm/kvm_main.c:1849  
[inline]
  kvm_vcpu_write_guest_page+0x39a/0x510  
arch/x86/kvm/../../../virt/kvm/kvm_main.c:1870
  nested_release_vmcs12 arch/x86/kvm/vmx.c:8441 [inline]
  handle_vmptrld+0x2384/0x26b0 arch/x86/kvm/vmx.c:8907
  vmx_handle_exit+0x1e81/0xbac0 arch/x86/kvm/vmx.c:10128
  vcpu_enter_guest arch/x86/kvm/x86.c:7667 [inline]
  vcpu_run arch/x86/kvm/x86.c:7730 [inline]
  kvm_arch_vcpu_ioctl_run+0xac32/0x11d80 arch/x86/kvm/x86.c:7930
  kvm_vcpu_ioctl+0xfb1/0x1f90 arch/x86/kvm/../../../virt/kvm/kvm_main.c:2590
  do_vfs_ioctl+0xf77/0x2d30 fs/ioctl.c:46
  ksys_ioctl fs/ioctl.c:702 [inline]
  __do_sys_ioctl fs/ioctl.c:709 [inline]
  __se_sys_ioctl+0x1da/0x270 fs/ioctl.c:707
  __x64_sys_ioctl+0x4a/0x70 fs/ioctl.c:707
  do_syscall_64+0xcf/0x110 arch/x86/entry/common.c:291
  entry_SYSCALL_64_after_hwframe+0x63/0xe7
RIP: 0033:0x44b6e9
Code: e8 dc e6 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 2b ff fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f096b292ce8 EFLAGS: 00000206 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000006e3c48 RCX: 000000000044b6e9
RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 0000000000000005
RBP: 00000000006e3c40 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000206 R12: 00000000006e3c4c
R13: 00007ffd978aeb2f R14: 00007f096b2939c0 R15: 00000000006e3d4c

Uninit was created at:
  kmsan_save_stack_with_flags mm/kmsan/kmsan.c:252 [inline]
  kmsan_internal_poison_shadow+0xc8/0x1e0 mm/kmsan/kmsan.c:177
  kmsan_kmalloc+0x98/0x110 mm/kmsan/kmsan_hooks.c:104
  __kmalloc+0x14c/0x4d0 mm/slub.c:3789
  kmalloc include/linux/slab.h:518 [inline]
  enter_vmx_operation+0x980/0x1a90 arch/x86/kvm/vmx.c:8278
  vmx_set_nested_state+0xc3a/0x1530 arch/x86/kvm/vmx.c:14045
  kvm_arch_vcpu_ioctl+0x4fc9/0x73a0 arch/x86/kvm/x86.c:4057
  kvm_vcpu_ioctl+0xca3/0x1f90 arch/x86/kvm/../../../virt/kvm/kvm_main.c:2742
  do_vfs_ioctl+0xf77/0x2d30 fs/ioctl.c:46
  ksys_ioctl fs/ioctl.c:702 [inline]
  __do_sys_ioctl fs/ioctl.c:709 [inline]
  __se_sys_ioctl+0x1da/0x270 fs/ioctl.c:707
  __x64_sys_ioctl+0x4a/0x70 fs/ioctl.c:707
  do_syscall_64+0xcf/0x110 arch/x86/entry/common.c:291
  entry_SYSCALL_64_after_hwframe+0x63/0xe7

Bytes 1000-4095 of 4096 are uninitialized
Memory access of size 4096 starts at ffff8801b5157000
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
