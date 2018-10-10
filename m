Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD18C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 12:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1F672085B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 12:33:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1F672085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbeJJTzC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 15:55:02 -0400
Received: from mail-it1-f198.google.com ([209.85.166.198]:40306 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbeJJTzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 15:55:01 -0400
Received: by mail-it1-f198.google.com with SMTP id z136-v6so5693669itc.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 05:33:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=F/ZOCXbWXYcYqc/Oi6HyiZl7aDtzbDwUbAh+iolyJKw=;
        b=gIutQFDTjlV52cyY02bHHRYLP3aiTFkRnzyC6W1mgTR27KMad36DX3cT4yVSE/I4DC
         IBivP3akODJOYp+hIi41QG+AvaI9JV/lQUPSzvAcPqpAZ3qtK6XL7I7kL6t53e4r2OSi
         yJHV5zeXowEbuxRaNNhoDH+Udh/nVOjry1dTRjMW7EFqD/uJ153gaoYMugfxGzB5NBM8
         QmnTx9Hi8BSvdql6yBKX/oXadP2Sbd+KdomYvOC+s1N51nEv12cG4pcgNlGtnQM/wlOa
         zq61wC2owIMUj4gTtS5LFtpzqu/iQJPlpluznBpYi0Pac9O2f3brilByYcU2GryjSzv7
         lAwg==
X-Gm-Message-State: ABuFfoh47zjz5ju85jv4w3PZXVplsvEBgYWe60MZt9JgXzgwxbWn49XO
        Dknk7hiArr9vNF4XBlGwqcTx4aiINGG25BNFFc57n872+nyo
X-Google-Smtp-Source: ACcGV60WnRBp7l+GQZmGhGfTqLBqC1eVB+F19gmDqaEwNHUkVl4FBYR2v801Paj5ZQfvozXgAGedskxzisDSh4SatcbAjVlF73ft
MIME-Version: 1.0
X-Received: by 2002:a05:660c:18a:: with SMTP id v10mr573629itj.10.1539174782790;
 Wed, 10 Oct 2018 05:33:02 -0700 (PDT)
Date:   Wed, 10 Oct 2018 05:33:02 -0700
In-Reply-To: <0000000000004ab2c40577db2115@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002cf7070577df0e64@google.com>
Subject: Re: kernel BUG at arch/x86/kvm/x86.c:LINE! (2)
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

syzbot has found a reproducer for the following crash on:

HEAD commit:    3d647e62686f Merge tag 's390-4.19-4' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15fc834e400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=88e9a8a39dc0be2d
dashboard link: https://syzkaller.appspot.com/bug?extid=f9b42efadea9f5453100
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1271be91400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+f9b42efadea9f5453100@syzkaller.appspotmail.com

IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
8021q: adding VLAN 0 to HW filter on device team0
8021q: adding VLAN 0 to HW filter on device team0
L1TF CPU bug present and SMT on, data leak possible. See CVE-2018-3646 and  
https://www.kernel.org/doc/html/latest/admin-guide/l1tf.html for details.
------------[ cut here ]------------
kernel BUG at arch/x86/kvm/x86.c:353!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 7328 Comm: syz-executor4 Not tainted 4.19.0-rc7+ #179
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
kobject: 'loop3' (0000000004d24d87): kobject_uevent_env
RIP: 0010:kvm_spurious_fault+0x9/0x10 arch/x86/kvm/x86.c:353
kobject: 'loop3' (0000000004d24d87): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
Code: 45 10 50 e8 e9 44 7c 00 58 5a 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f  
5d c3 0f 1f 84 00 00 00 00 00 55 48 89 e5 e8 97 03 73 00 <0f> 0b 0f 1f 44  
00 00 55 48 89 e5 41 57 41 56 41 55 41 89 fd 41 54
RSP: 0018:ffff8801ce167340 EFLAGS: 00010093
RAX: ffff8801cd750440 RBX: 1ffff10039c2ce6c RCX: ffffffff81385bcc
RDX: 0000000000000000 RSI: ffffffff810bd1f9 RDI: ffff8801ce167380
kobject: 'kvm' (0000000063fb9207): kobject_uevent_env
RBP: ffff8801ce167340 R08: ffff8801cd750440 R09: fffff520003f4047
R10: fffff520003f4047 R11: ffffc90001fa023b R12: ffff8801ce1673c0
R13: dffffc0000000000 R14: ffff8801d7dc9000 R15: ffff8801ce167380
FS:  0000000000000000(0000) GS:ffff8801dae00000(0063) knlGS:0000000009b8d900
kobject: 'kvm' (0000000063fb9207): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: ffff8801ce167380 CR3: 00000001d5af7000 CR4: 00000000001426f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
kobject: 'kvm' (0000000063fb9207): kobject_uevent_env
  kvm_fastop_exception+0x50b/0x5455
------------[ cut here ]------------
kernel BUG at arch/x86/kvm/x86.c:353!
  loaded_vmcs_init arch/x86/kvm/vmx.c:2129 [inline]
  __loaded_vmcs_clear+0x2d6/0x690 arch/x86/kvm/vmx.c:2212
kobject: 'kvm' (0000000063fb9207): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
  generic_exec_single+0x373/0x5f0 kernel/smp.c:153
  smp_call_function_single+0x1b2/0x660 kernel/smp.c:299
  loaded_vmcs_clear arch/x86/kvm/vmx.c:2221 [inline]
  free_loaded_vmcs+0x13c/0x1b0 arch/x86/kvm/vmx.c:4746
  vmx_free_vcpu+0x204/0x300 arch/x86/kvm/vmx.c:10982
  kvm_arch_vcpu_free arch/x86/kvm/x86.c:8457 [inline]
  kvm_free_vcpus arch/x86/kvm/x86.c:8909 [inline]
  kvm_arch_destroy_vm+0x365/0x7c0 arch/x86/kvm/x86.c:9006
  kvm_destroy_vm arch/x86/kvm/../../../virt/kvm/kvm_main.c:752 [inline]
  kvm_put_kvm+0x6c8/0xff0 arch/x86/kvm/../../../virt/kvm/kvm_main.c:773
  kvm_vcpu_release+0x7b/0xa0 arch/x86/kvm/../../../virt/kvm/kvm_main.c:2407
  __fput+0x385/0xa30 fs/file_table.c:278
  ____fput+0x15/0x20 fs/file_table.c:309
  task_work_run+0x1e8/0x2a0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:193 [inline]
  exit_to_usermode_loop+0x318/0x380 arch/x86/entry/common.c:166
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_32_irqs_on arch/x86/entry/common.c:341 [inline]
  do_fast_syscall_32+0xcd5/0xfb2 arch/x86/entry/common.c:397
  entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139
RIP: 0023:0xf7efdca9
Code: 85 d2 74 02 89 0a 5b 5d c3 8b 04 24 c3 8b 0c 24 c3 8b 1c 24 c3 90 90  
90 90 90 90 90 90 90 90 90 90 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90  
90 90 90 eb 0d 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 002b:000000000845fdac EFLAGS: 00000216 ORIG_RAX: 0000000000000006
RAX: 0000000000000000 RBX: 0000000000000007 RCX: 0000000000000000
RDX: 0000000000000008 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
---[ end trace 2ea88a0e29b1263b ]---
invalid opcode: 0000 [#2] PREEMPT SMP KASAN
CPU: 1 PID: 7351 Comm: syz-executor3 Tainted: G      D            
4.19.0-rc7+ #179
RIP: 0010:kvm_spurious_fault+0x9/0x10 arch/x86/kvm/x86.c:353
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Code: 45 10 50 e8 e9 44 7c 00 58 5a 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f  
5d c3 0f 1f 84 00 00 00 00 00 55 48 89 e5 e8 97 03 73 00 <0f> 0b 0f 1f 44  
00 00 55 48 89 e5 41 57 41 56 41 55 41 89 fd 41 54
RIP: 0010:kvm_spurious_fault+0x9/0x10 arch/x86/kvm/x86.c:353
RSP: 0018:ffff8801ce167340 EFLAGS: 00010093
Code: 45 10 50 e8 e9 44 7c 00 58 5a 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f  
5d c3 0f 1f 84 00 00 00 00 00 55 48 89 e5 e8 97 03 73 00 <0f> 0b 0f 1f 44  
00 00 55 48 89 e5 41 57 41 56 41 55 41 89 fd 41 54
RSP: 0018:ffff8801cd357448 EFLAGS: 00010293
RAX: ffff8801cd750440 RBX: 1ffff10039c2ce6c RCX: ffffffff81385bcc
RDX: 0000000000000000 RSI: ffffffff810bd1f9 RDI: ffff8801ce167380
RAX: ffff8801bbcea080 RBX: 1ffff10039a6ae8d RCX: ffffffff81385bcc
RBP: ffff8801ce167340 R08: ffff8801cd750440 R09: fffff520003f4047
RDX: 0000000000000000 RSI: ffffffff810bd1f9 RDI: ffff8801cd357488
R10: fffff520003f4047 R11: ffffc90001fa023b R12: ffff8801ce1673c0
RBP: ffff8801cd357448 R08: ffff8801bbcea080 R09: ffff8801ce981000
R13: dffffc0000000000 R14: ffff8801d7dc9000 R15: ffff8801ce167380
R10: ffffed0039d303ff R11: ffff8801ce981fff R12: ffff8801cd3574c8
FS:  0000000000000000(0000) GS:ffff8801dae00000(0063) knlGS:0000000009b8d900
R13: dffffc0000000000 R14: ffff8801ce981000 R15: ffff8801cd357488
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
FS:  0000000000000000(0000) GS:ffff8801daf00000(0063) knlGS:00000000f7ef6b40
CR2: ffff8801ce167380 CR3: 00000001d5af7000 CR4: 00000000001426f0
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
CR2: 00007f1f49c6b000 CR3: 00000001cf36e000 CR4: 00000000001426e0
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000

