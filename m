Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C6BC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 07:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96D9A2064E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 07:52:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96D9A2064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbeJJPNB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 11:13:01 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:34747 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbeJJPNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 11:13:01 -0400
Received: by mail-io1-f69.google.com with SMTP id y3-v6so3855700iob.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 00:52:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=wndZTv188g8fVjC/Z4BNVqcAX+/u8I1U+msi0YxB+f8=;
        b=AVEvujT8jsE6vnPANmxd2K+AHx5o9VqGRPfc5SjrXscZ/4KGvVjTdLa9B/wZenCpll
         Y2d9K0d3DzdxMvtJAYBBKOmnLXf/bc1qerrbFZs3vGYQRqUnAQuYKMkD0MaIpfRzk5Dg
         fBrAOIGObzelL6jDtFMu89BUmvVJjqkz4jV591TDV/8jD3BBPdq/u+rRG5jD07ATyVIc
         tFOgoPBg/Elw7s64o6z9GztAMLu37GDolAS6c/iD5yxDc+VccDlFVMjWC1Gz1w2WvCwN
         EpVR6wgqGNDXUFREzL54FSQ02KkbalZLpcF66XyLcStwYZHAIKUq51kD3NAi8eYqAhGI
         I8tg==
X-Gm-Message-State: ABuFfohbZPrIVgcrpLqeuHJJ8fOTuQLEg142JEgdBw0dMVBKtQbE0ICW
        hDY0i+EY6cnzM+8eWAjIACl9WJBQmolwjo2HutUH4dWBM+Lc
X-Google-Smtp-Source: ACcGV61mwWorNtTHPpra1oWfyme/UEl8pcG8xbdVqZu6IOq1YWe+BDyQNv+5FOJN120CJHWBDTNsmk5Uu8WND0y6xLz73HRu702S
MIME-Version: 1.0
X-Received: by 2002:a6b:7012:: with SMTP id l18-v6mr22567198ioc.24.1539157923638;
 Wed, 10 Oct 2018 00:52:03 -0700 (PDT)
Date:   Wed, 10 Oct 2018 00:52:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004ab2c40577db2115@google.com>
Subject: kernel BUG at arch/x86/kvm/x86.c:LINE! (2)
From:   syzbot <syzbot+f9b42efadea9f5453100@syzkaller.appspotmail.com>
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

HEAD commit:    64c5e530ac2c Merge tag 'arc-4.19-rc8' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=167a4e85400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=88e9a8a39dc0be2d
dashboard link: https://syzkaller.appspot.com/bug?extid=f9b42efadea9f5453100
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
userspace arch: i386

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+f9b42efadea9f5453100@syzkaller.appspotmail.com

Use struct sctp_sack_info instead
sctp: [Deprecated]: syz-executor0 (pid 11077) Use of struct  
sctp_assoc_value in delayed_ack socket option.
Use struct sctp_sack_info instead
audit: type=1326 audit(1539141761.977:32): auid=4294967295 uid=0 gid=0  
ses=4294967295 subj==unconfined pid=11031 comm="syz-executor2"  
exe="/root/syz-executor2" sig=9 arch=40000003 syscall=265 compat=1  
ip=0xf7fecca9 code=0x0
------------[ cut here ]------------
kernel BUG at arch/x86/kvm/x86.c:353!
------------[ cut here ]------------
kernel BUG at arch/x86/kvm/x86.c:353!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 11079 Comm: syz-executor2 Not tainted 4.19.0-rc7+ #178
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:kvm_spurious_fault+0x9/0x10 arch/x86/kvm/x86.c:353
Code: 45 10 50 e8 e9 44 7c 00 58 5a 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f  
5d c3 0f 1f 84 00 00 00 00 00 55 48 89 e5 e8 97 03 73 00 <0f> 0b 0f 1f 44  
00 00 55 48 89 e5 41 57 41 56 41 55 41 89 fd 41 54
RSP: 0018:ffff8801dae07bd8 EFLAGS: 00010006
RAX: ffff8801cc2f2180 RBX: 1ffff1003b5c0f7f RCX: ffffffff81385bcc
RDX: 0000000000010000 RSI: ffffffff810bd1f9 RDI: ffff8801dae07c18
RBP: ffff8801dae07bd8 R08: ffff8801cc2f2180 R09: ffffed003b5c5ba0
R10: ffffed003b5c5ba0 R11: ffff8801dae2dd07 R12: ffff8801dae07c58
R13: dffffc0000000000 R14: ffff8801beccc000 R15: ffff8801dae07c18
FS:  0000000000000000(0000) GS:ffff8801dae00000(0063) knlGS:00000000f5fa6b40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: ffff8801dae07c18 CR3: 00000001cc8d1000 CR4: 00000000001426f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  <IRQ>
  kvm_fastop_exception+0x50b/0x5455
  loaded_vmcs_init arch/x86/kvm/vmx.c:2129 [inline]
  __loaded_vmcs_clear+0x2d6/0x690 arch/x86/kvm/vmx.c:2212
  flush_smp_call_function_queue+0x1d2/0x640 kernel/smp.c:243
  generic_smp_call_function_single_interrupt+0x13/0x2b kernel/smp.c:192
  smp_call_function_single_interrupt+0x12f/0x650 arch/x86/kernel/smp.c:296
  call_function_single_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:886
  </IRQ>
RIP: 0010:arch_local_irq_enable arch/x86/include/asm/paravirt.h:798 [inline]
RIP: 0010:preempt_schedule_irq+0x7d/0x110 kernel/sched/core.c:3699
Code: 00 e8 87 6a a6 f9 e8 c2 d8 d5 f9 4c 89 f0 48 c1 e8 03 42 80 3c 20 00  
75 7b 48 83 3d 14 ea 82 01 00 74 61 fb 66 0f 1f 44 00 00 <bf> 01 00 00 00  
e8 f9 d1 ff ff 41 80 7d 00 00 75 6a 48 83 3d ea e9
RSP: 0018:ffff88018b397160 EFLAGS: 00000286 ORIG_RAX: ffffffffffffff04
RAX: 1ffffffff1263e53 RBX: 0000000000000000 RCX: ffffc9000628e000
RDX: 0000000000000004 RSI: ffffffff8184e1e4 RDI: ffffffff896fe100
RBP: ffff88018b397188 R08: ffff8801cc2f2180 R09: ffffed003b5c5979
R10: ffffed003b5c5979 R11: ffff8801dae2cbcb R12: dffffc0000000000
R13: fffffbfff1263e52 R14: ffffffff8931f298 R15: ffffffff8931f290
  retint_kernel+0x1b/0x2d
RIP: 0010:arch_local_irq_enable arch/x86/include/asm/paravirt.h:798 [inline]
RIP: 0010:cond_local_irq_enable arch/x86/kernel/traps.c:80 [inline]
RIP: 0010:do_error_trap+0x270/0x4d0 arch/x86/kernel/traps.c:301
Code: 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 4f 02 00 00 48 83  
3d 55 6a 07 08 00 0f 84 46 01 00 00 fb 66 0f 1f 44 00 00 <e9> b8 fe ff ff  
31 c0 41 b8 01 00 00 00 48 ba 00 00 00 00 00 fc ff
RSP: 0018:ffff88018b397248 EFLAGS: 00000286 ORIG_RAX: ffffffffffffff02
RAX: dffffc0000000000 RBX: ffff88018b397398 RCX: ffffc9000628e000
RDX: 1ffffffff1263e53 RSI: ffffffff8184e1e4 RDI: ffffffff8931f298
RBP: ffff88018b397378 R08: ffff8801cc2f2180 R09: 0000000000000001
R10: fffffbfff12720fc R11: 0000000000000000 R12: 0000000000000006
R13: ffff88018b397350 R14: 0000000000000004 R15: 1ffff10031672e4e
  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:316
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:993
RIP: 0010:kvm_spurious_fault+0x9/0x10 arch/x86/kvm/x86.c:353
Code: 45 10 50 e8 e9 44 7c 00 58 5a 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f  
5d c3 0f 1f 84 00 00 00 00 00 55 48 89 e5 e8 97 03 73 00 <0f> 0b 0f 1f 44  
00 00 55 48 89 e5 41 57 41 56 41 55 41 89 fd 41 54
RSP: 0018:ffff88018b397448 EFLAGS: 00010212
RAX: 0000000000040000 RBX: 1ffff10031672e8d RCX: ffffc9000628e000
RDX: 0000000000000417 RSI: ffffffff810bd1f9 RDI: ffff88018b397488
RBP: ffff88018b397448 R08: ffff8801cc2f2180 R09: ffff8801c308d000
R10: ffffed0038611bff R11: ffff8801c308dfff R12: ffff88018b3974c8
R13: dffffc0000000000 R14: ffff8801c308d000 R15: ffff88018b397488
  kvm_fastop_exception+0x50b/0x5455
  loaded_vmcs_init arch/x86/kvm/vmx.c:2129 [inline]
  alloc_loaded_vmcs+0x7f/0x280 arch/x86/kvm/vmx.c:4766
  vmx_create_vcpu+0x20e/0x25e0 arch/x86/kvm/vmx.c:11025
  kvm_arch_vcpu_create+0xe5/0x220 arch/x86/kvm/x86.c:8471
  kvm_vm_ioctl_create_vcpu arch/x86/kvm/../../../virt/kvm/kvm_main.c:2476  
[inline]
  kvm_vm_ioctl+0x470/0x1d40 arch/x86/kvm/../../../virt/kvm/kvm_main.c:2977
  kvm_vm_compat_ioctl+0x143/0x430  
arch/x86/kvm/../../../virt/kvm/kvm_main.c:3170
  __do_compat_sys_ioctl fs/compat_ioctl.c:1419 [inline]
  __se_compat_sys_ioctl fs/compat_ioctl.c:1365 [inline]
  __ia32_compat_sys_ioctl+0x20e/0x630 fs/compat_ioctl.c:1365
  do_syscall_32_irqs_on arch/x86/entry/common.c:326 [inline]
  do_fast_syscall_32+0x34d/0xfb2 arch/x86/entry/common.c:397
  entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139
RIP: 0023:0xf7fecca9
Code: 85 d2 74 02 89 0a 5b 5d c3 8b 04 24 c3 8b 0c 24 c3 8b 1c 24 c3 90 90  
90 90 90 90 90 90 90 90 90 90 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90  
90 90 90 eb 0d 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 002b:00000000f5fa60cc EFLAGS: 00000296 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 000000000000000c RCX: 000000000000ae41
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
---[ end trace 1c8fec48833612c0 ]---
RIP: 0010:kvm_spurious_fault+0x9/0x10 arch/x86/kvm/x86.c:353
Code: 45 10 50 e8 e9 44 7c 00 58 5a 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f  
5d c3 0f 1f 84 00 00 00 00 00 55 48 89 e5 e8 97 03 73 00 <0f> 0b 0f 1f 44  
00 00 55 48 89 e5 41 57 41 56 41 55 41 89 fd 41 54
RSP: 0018:ffff8801dae07bd8 EFLAGS: 00010006
RAX: ffff8801cc2f2180 RBX: 1ffff1003b5c0f7f RCX: ffffffff81385bcc
RDX: 0000000000010000 RSI: ffffffff810bd1f9 RDI: ffff8801dae07c18
RBP: ffff8801dae07bd8 R08: ffff8801cc2f2180 R09: ffffed003b5c5ba0
R10: ffffed003b5c5ba0 R11: ffff8801dae2dd07 R12: ffff8801dae07c58
R13: dffffc0000000000 R14: ffff8801beccc000 R15: ffff8801dae07c18
FS:  0000000000000000(0000) GS:ffff8801dae00000(0063) knlGS:00000000f5fa6b40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: ffff8801dae07c18 CR3: 00000001cc8d1000 CR4: 00000000001426f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
