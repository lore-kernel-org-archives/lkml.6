Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB1D9C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 12:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EE9D20B6F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 12:46:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EE9D20B6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732447AbeHNPdE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 11:33:04 -0400
Received: from mail-io0-f198.google.com ([209.85.223.198]:33243 "EHLO
        mail-io0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732092AbeHNPdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 11:33:04 -0400
Received: by mail-io0-f198.google.com with SMTP id s14-v6so16721646ioc.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 05:46:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=zz1Ok9fToGebP9MQslnizJostyGFNBf8TNlnjg8akC0=;
        b=fN3gKG//jIUy2jWd1ButtBuSpO6VT8pw35BdzBifaBS7IwAonPImPMiVz/naIUZWfF
         z759bORh0weBPt0qAuLFSmBuftDfSGYADKhfCPUsfTWvavNX7flsGCymVSieMhXo/9Y1
         dPL6Lhtbbu/U4FWvdlwgkvMyZBWxHjUl0R61vPb78eMjTAdKySpJate89RnpeMIjjE4z
         C2z+NJL0g5d91eRlhkJ8f910XSjy5Lop7t7NMa2s5a7uehC2sah92f+N3hpXsx5YCPmu
         CLr5brMb2nJOuxQnPuAqZpxCU8SDRNrWU0Q/8bEPsE3CrE/TljOZeLktfCO4I8xkPfVh
         m+Ow==
X-Gm-Message-State: AOUpUlFONuGjFQDHv/UZEinu1Jxox8FRaNgfdLhQq2fqWgvkBn1W/ncP
        fmH9WSZCaQAkujPqmXFcOqZtdVu1AiXKUITILKPpZS60h245
X-Google-Smtp-Source: AA+uWPw+f8+DAmMb6XAFlTKS/Ujq/3o57hlMyi2gYy96LUtp6O5Pn83HM2eXPXgTg5fABfGiUnijMrV1X6WUG3Qe+ZZEjq44msCR
MIME-Version: 1.0
X-Received: by 2002:a6b:1cc9:: with SMTP id c192-v6mr10083637ioc.120.1534250762514;
 Tue, 14 Aug 2018 05:46:02 -0700 (PDT)
Date:   Tue, 14 Aug 2018 05:46:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b239d705736497a3@google.com>
Subject: WARNING in free_loaded_vmcs (2)
From:   syzbot <syzbot+01bc9e7a8a3f138b71cf@syzkaller.appspotmail.com>
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

HEAD commit:    112cbae26d18 Merge branch 'linus' of git://git.kernel.org/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=161d8a3c400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=152cb8ccd35b1f70
dashboard link: https://syzkaller.appspot.com/bug?extid=01bc9e7a8a3f138b71cf
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+01bc9e7a8a3f138b71cf@syzkaller.appspotmail.com

WARNING: CPU: 1 PID: 5195 at arch/x86/kvm/vmx.c:4431  
free_loaded_vmcs+0x160/0x1b0 arch/x86/kvm/vmx.c:4431
Kernel panic - not syncing: panic_on_warn set ...

CPU: 1 PID: 5195 Comm: syz-executor3 Not tainted 4.18.0-rc8+ #182
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
RIP: 0010:free_loaded_vmcs+0x160/0x1b0 arch/x86/kvm/vmx.c:4431
Code: 81 e8 64 25 53 00 48 89 da 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03  
80 3c 02 00 75 49 4c 8b 23 e9 22 ff ff ff e8 50 5f 5f 00 <0f> 0b eb b0 e8  
77 3b 9d 00 e9 f4 fe ff ff 48 89 df e8 8a 3b 9d 00
RSP: 0018:ffff8801947bf780 EFLAGS: 00010293
RAX: ffff88018fe4a680 RBX: ffff88018f95e3e8 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff811cb900 RDI: ffff88018f95e3f0
RBP: ffff8801947bf798 R08: ffffea0007544608 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff8801d5118000
R13: 0000000000000001 R14: dffffc0000000000 R15: 0000000000000001
  vmx_free_vcpu+0x204/0x300 arch/x86/kvm/vmx.c:10299
  kvm_arch_vcpu_free arch/x86/kvm/x86.c:8314 [inline]
  kvm_free_vcpus arch/x86/kvm/x86.c:8763 [inline]
  kvm_arch_destroy_vm+0x365/0x7c0 arch/x86/kvm/x86.c:8860
  kvm_destroy_vm arch/x86/kvm/../../../virt/kvm/kvm_main.c:746 [inline]
  kvm_put_kvm+0x73f/0x1060 arch/x86/kvm/../../../virt/kvm/kvm_main.c:767
  kvm_vcpu_release+0x7b/0xa0 arch/x86/kvm/../../../virt/kvm/kvm_main.c:2397
  __fput+0x355/0x8b0 fs/file_table.c:209
  ____fput+0x15/0x20 fs/file_table.c:243
  task_work_run+0x1ec/0x2a0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:192 [inline]
  exit_to_usermode_loop+0x313/0x370 arch/x86/entry/common.c:166
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x410c41
Code: 75 14 b8 03 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 34 19 00 00 c3 48  
83 ec 08 e8 0a fc ff ff 48 89 04 24 b8 03 00 00 00 0f 05 <48> 8b 3c 24 48  
89 c2 e8 53 fc ff ff 48 89 d0 48 83 c4 08 48 3d 01
RSP: 002b:0000000000a3fdc0 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000007 RCX: 0000000000410c41
RDX: 0000000000000000 RSI: 0000000000731000 RDI: 0000000000000006
RBP: 0000000000000000 R08: ffffffffffffffff R09: ffffffffffffffff
R10: 0000000000a3fcf0 R11: 0000000000000293 R12: 0000000000000007
R13: 000000000008c6e7 R14: 0000000000000398 R15: badc0ffeebadface
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
