Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D28C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 20:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 356482082B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 20:34:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 356482082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727808AbeJKD5w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 23:57:52 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:49903 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727593AbeJKD5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 23:57:52 -0400
Received: by mail-io1-f70.google.com with SMTP id k9-v6so5748646iob.16
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 13:34:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=+H351sbvuKmd8wKY69WIxEiZjFfpAtyRVleRsyvtf5A=;
        b=E7T/nDXaFrTxONsx1HrEUP25dZLkO68AcpOPoMB0OJAWvcVWe0j1FeelcMb0e9PpsJ
         LHcR+RFbIfe7Er6xXMCM1mq5lpoIZ/YSn41jcetGadzIDxLFkTv8O303kKJyZaVKUuxm
         gy0WV3sRDbLbhY7A7WzGdGKRu50F8rCI1ymY6m4Dmef7hiPkE0ufwSqAPWueeGwE6Npu
         p+UnRq5xxVEFNgcxdamElFVb+Ndwj9hkphwoJRQOe0MNBXguveMY/heiV4WEsWfSQRUf
         7dqpSGSOKYk3Hpm14TdFDiwN5TIxE/RAZCJm//tTuv98749wjFZG7WuHAaHjA5R1ow49
         BY/Q==
X-Gm-Message-State: ABuFfoiB5lWNAw9OXVJSe7NUDZnmJUtoCD63vyX9njCQedARqTCCoQu/
        BrC4JxsQQkjteHRfproVJKqBy0Ov82gjH1i641ris3hFY5ru
X-Google-Smtp-Source: ACcGV60NcvZttzt1xEAMLanbRHwd2KZRy18CaCz+DY78S/gwMD6tSJdtZA8KxskBNWqvcUtipFvHwqZ54pK31KYJIXUYAeTyNaQr
MIME-Version: 1.0
X-Received: by 2002:a6b:5d13:: with SMTP id r19-v6mr24086453iob.10.1539203642472;
 Wed, 10 Oct 2018 13:34:02 -0700 (PDT)
Date:   Wed, 10 Oct 2018 13:34:02 -0700
In-Reply-To: <0000000000004ab2c40577db2115@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000058c3520577e5c6e0@google.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=11be99a1400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=88e9a8a39dc0be2d
dashboard link: https://syzkaller.appspot.com/bug?extid=f9b42efadea9f5453100
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1057d809400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=131e37c9400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+f9b42efadea9f5453100@syzkaller.appspotmail.com

audit: type=1400 audit(1539203398.925:36): avc:  denied  { map } for   
pid=5855 comm="syz-executor775" path="/root/syz-executor775778886"  
dev="sda1" ino=16481 scontext=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023  
tcontext=unconfined_u:object_r:user_home_t:s0 tclass=file permissive=1
L1TF CPU bug present and SMT on, data leak possible. See CVE-2018-3646 and  
https://www.kernel.org/doc/html/latest/admin-guide/l1tf.html for details.
------------[ cut here ]------------
kernel BUG at arch/x86/kvm/x86.c:353!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
kobject: 'kvm' (00000000154a8e53): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
CPU: 0 PID: 5871 Comm: syz-executor775 Not tainted 4.19.0-rc7+ #55
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:kvm_spurious_fault+0x9/0x10 arch/x86/kvm/x86.c:353
Code: 45 10 50 e8 e9 44 7c 00 58 5a 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f  
5d c3 0f 1f 84 00 00 00 00 00 55 48 89 e5 e8 97 03 73 00 <0f> 0b 0f 1f 44  
00 00 55 48 89 e5 41 57 41 56 41 55 41 89 fd 41 54
RSP: 0018:ffff8801c428f388 EFLAGS: 00010293
RAX: ffff8801c5676380 RBX: ffff8801c428f408 RCX: ffffffff81385bcc
RDX: 0000000000000000 RSI: ffffffff810bd1f9 RDI: ffff8801c428f3c8
RBP: ffff8801c428f388 R08: ffff8801c5676380 R09: fffff520003dea46
R10: fffff520003dea46 R11: ffffc90001ef5237 R12: 1ffff10038851e75
R13: ffff8801c428f3c8 R14: ffff8801c481d000 R15: ffff8801c7cdb000
FS:  00007f4825a83700(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff8801c428f3c8 CR3: 00000001c4e7c000 CR4: 00000000001426f0
kobject: 'kvm' (00000000154a8e53): kobject_uevent_env
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  kvm_fastop_exception+0x523/0x5455
kobject: 'kvm' (00000000154a8e53): kobject_uevent_env
kobject: 'kvm' (00000000154a8e53): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
  vmx_vcpu_load+0x496/0x1030 arch/x86/kvm/vmx.c:3079
------------[ cut here ]------------
kernel BUG at arch/x86/kvm/x86.c:353!
  kvm_arch_vcpu_load+0x247/0x970 arch/x86/kvm/x86.c:3109
  vcpu_load+0x35/0x70 arch/x86/kvm/../../../virt/kvm/kvm_main.c:164
  kvm_arch_vcpu_setup+0x1d/0x40 arch/x86/kvm/x86.c:8479
  kvm_vm_ioctl_create_vcpu arch/x86/kvm/../../../virt/kvm/kvm_main.c:2484  
[inline]
  kvm_vm_ioctl+0x107d/0x1d40 arch/x86/kvm/../../../virt/kvm/kvm_main.c:2977
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:501 [inline]
  do_vfs_ioctl+0x1de/0x1720 fs/ioctl.c:685
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:702
  __do_sys_ioctl fs/ioctl.c:709 [inline]
  __se_sys_ioctl fs/ioctl.c:707 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:707
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x446df9
Code: e8 dc e6 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 4b 07 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f4825a82da8 EFLAGS: 00000297 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000006dcc48 RCX: 0000000000446df9
RDX: 0000000000000000 RSI: 000000000000ae41 RDI: 0000000000000004
RBP: 00000000006dcc40 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000297 R12: 00000000006dcc4c
R13: 6d766b2f7665642f R14: 00007f4825a839c0 R15: 00000000006dcd4c
Modules linked in:
invalid opcode: 0000 [#2] PREEMPT SMP KASAN
---[ end trace 646ff58a828dac28 ]---
CPU: 1 PID: 5870 Comm: syz-executor775 Tainted: G      D            
4.19.0-rc7+ #55
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:kvm_spurious_fault+0x9/0x10 arch/x86/kvm/x86.c:353
Code: 45 10 50 e8 e9 44 7c 00 58 5a 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f  
5d c3 0f 1f 84 00 00 00 00 00 55 48 89 e5 e8 97 03 73 00 <0f> 0b 0f 1f 44  
00 00 55 48 89 e5 41 57 41 56 41 55 41 89 fd 41 54
RIP: 0010:kvm_spurious_fault+0x9/0x10 arch/x86/kvm/x86.c:353
RSP: 0018:ffff8801c4347380 EFLAGS: 00010093
RAX: ffff8801c5662340 RBX: 1ffff10038868e74 RCX: ffffffff81385bcc
RDX: 0000000000000000 RSI: ffffffff810bd1f9 RDI: ffff8801c43473c0
RBP: ffff8801c4347380 R08: ffff8801c5662340 R09: fffff520003e0247
Code: 45 10 50 e8 e9 44 7c 00 58 5a 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f  
5d c3 0f 1f 84 00 00 00 00 00 55 48 89 e5 e8 97 03 73 00 <0f> 0b 0f 1f 44  
00 00 55 48 89 e5 41 57 41 56 41 55 41 89 fd 41 54
R10: fffff520003e0247 R11: ffffc90001f0123b R12: ffff8801c4347400
RSP: 0018:ffff8801c428f388 EFLAGS: 00010293
R13: dffffc0000000000 R14: ffff8801be3c2000 R15: ffff8801c43473c0
FS:  00000000010fc880(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff8801c43473c0 CR3: 00000001c44d8000 CR4: 00000000001426e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
RAX: ffff8801c5676380 RBX: ffff8801c428f408 RCX: ffffffff81385bcc
Call Trace:
RDX: 0000000000000000 RSI: ffffffff810bd1f9 RDI: ffff8801c428f3c8
  kvm_fastop_exception+0x50b/0x5455
RBP: ffff8801c428f388 R08: ffff8801c5676380 R09: fffff520003dea46
R10: fffff520003dea46 R11: ffffc90001ef5237 R12: 1ffff10038851e75
  loaded_vmcs_init arch/x86/kvm/vmx.c:2129 [inline]
  __loaded_vmcs_clear+0x2d6/0x690 arch/x86/kvm/vmx.c:2212
R13: ffff8801c428f3c8 R14: ffff8801c481d000 R15: ffff8801c7cdb000
FS:  00007f4825a83700(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  generic_exec_single+0x373/0x5f0 kernel/smp.c:153
CR2: ffff8801c428f3c8 CR3: 00000001c4e7c000 CR4: 00000000001426f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
  smp_call_function_single+0x1b2/0x660 kernel/smp.c:299

