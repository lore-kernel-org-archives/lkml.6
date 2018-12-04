Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D70DCC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 07:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FFBE208A3
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 07:16:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FFBE208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726056AbeLDHQD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 02:16:03 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:33420 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbeLDHQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 02:16:03 -0500
Received: by mail-io1-f71.google.com with SMTP id a6so16750906iok.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 23:16:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=CsIJszjfKZj5PR91NnucQVIRnH6pXJ2HkBm/mWJ8uSg=;
        b=b+ibx1NjdXDTPhNb7eyvusiKsX3GfTTtHMDPF/zCaqkIXuVuP9f0e2l5GQtIXtbRgi
         +FX6jaQWSUTfWcArDwHfIzFlBwnLyzLD/zt4ZpfeF5ogSXzmLJvoMm7uOWJCw1VPdRh0
         wGHxGLJZMYKWyhuacu7upN8P7ZZsLIs804tmzNyffSJXjnUJqJWSIOqLiOnUIR/Rv+HC
         Cvmm9F97zmkiwrW2rbndwnKukFb3dqxJc4IJbXZbXnMomIxuMPKDKE1QdOxn7okZn2rP
         KDKoEz0RZI9iAUMSOGTxs0FlFA4WfeSkfL8ZL5a4zyGoZs3MHKaaRfcVo98y7T/rig6j
         l29w==
X-Gm-Message-State: AA+aEWbsG4QBgqJlSkCYJ1GVUIG3R7sMex5v0DcYlyAKESQShvU6OUvE
        Krul/3dtu0r6H6cKuvrQX26liFchU7X7DPquGOQVM2eL+NsB
X-Google-Smtp-Source: AFSGD/UNKUzofDDmdcTULYqmk9jBbSkArTl/tzvZEvgrcXNyNFHKJMIN7so3pZg0kf7l2Im0vsH6nHy8v5Enhjhe0HVCD32Ju5YP
MIME-Version: 1.0
X-Received: by 2002:a24:4597:: with SMTP id c23mr9165394itd.20.1543907762132;
 Mon, 03 Dec 2018 23:16:02 -0800 (PST)
Date:   Mon, 03 Dec 2018 23:16:02 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ba65b0057c2d09a1@google.com>
Subject: general protection fault in kvm_arch_vcpu_ioctl_run
From:   syzbot <syzbot+39810e6c400efadfef71@syzkaller.appspotmail.com>
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

HEAD commit:    4b78317679c4 Merge branch 'x86-pti-for-linus' of git://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15e979f5400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4602730af4f872ef
dashboard link: https://syzkaller.appspot.com/bug?extid=39810e6c400efadfef71
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+39810e6c400efadfef71@syzkaller.appspotmail.com

kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 14932 Comm: syz-executor0 Not tainted 4.20.0-rc4+ #138
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:kvm_apic_hw_enabled arch/x86/kvm/lapic.h:169 [inline]
RIP: 0010:vcpu_scan_ioapic arch/x86/kvm/x86.c:7449 [inline]
RIP: 0010:vcpu_enter_guest arch/x86/kvm/x86.c:7602 [inline]
RIP: 0010:vcpu_run arch/x86/kvm/x86.c:7874 [inline]
RIP: 0010:kvm_arch_vcpu_ioctl_run+0x5296/0x7320 arch/x86/kvm/x86.c:8074
Code: 03 00 00 48 89 f8 48 c1 e8 03 42 80 3c 20 00 0f 85 b4 1e 00 00 49 8b  
9f e0 03 00 00 48 8d bb 88 00 00 00 48 89 f8 48 c1 e8 03 <42> 80 3c 20 00  
0f 85 8a 1e 00 00 48 8b 9b 88 00 00 00 48 8d bb d8
RSP: 0018:ffff88818b0bf530 EFLAGS: 00010206
RAX: 0000000000000011 RBX: 0000000000000000 RCX: ffffc9001302b000
RDX: 00000000000000cf RSI: ffffffff81103a68 RDI: 0000000000000088
RBP: ffff88818b0bf8d0 R08: ffff8881bfe8e0c0 R09: 0000000000000008
R10: 0000000000000028 R11: ffffffff810feb0f R12: dffffc0000000000
R13: 0000000000000000 R14: ffffc90007ddfdb8 R15: ffff888188a18400
FS:  00007ff919977700(0000) GS:ffff8881dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc94713c518 CR3: 00000001cdea0000 CR4: 00000000001426f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  kvm_vcpu_ioctl+0x5c8/0x1150 arch/x86/kvm/../../../virt/kvm/kvm_main.c:2596
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:509 [inline]
  do_vfs_ioctl+0x1de/0x1790 fs/ioctl.c:696
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:713
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl fs/ioctl.c:718 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457569
Code: fd b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ff919976c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457569
RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 0000000000000005
RBP: 000000000072bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ff9199776d4
R13: 00000000004c034e R14: 00000000004d0d60 R15: 00000000ffffffff
Modules linked in:
kobject: 'loop5' (000000004f26f0d5): kobject_uevent_env
kobject: 'loop5' (000000004f26f0d5): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop1' (0000000010db8550): kobject_uevent_env
kobject: 'loop1' (0000000010db8550): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop3' (00000000941a4e7a): kobject_uevent_env
kobject: 'loop3' (00000000941a4e7a): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
---[ end trace d7fab4e7c1a70214 ]---
RIP: 0010:kvm_apic_hw_enabled arch/x86/kvm/lapic.h:169 [inline]
RIP: 0010:vcpu_scan_ioapic arch/x86/kvm/x86.c:7449 [inline]
RIP: 0010:vcpu_enter_guest arch/x86/kvm/x86.c:7602 [inline]
RIP: 0010:vcpu_run arch/x86/kvm/x86.c:7874 [inline]
RIP: 0010:kvm_arch_vcpu_ioctl_run+0x5296/0x7320 arch/x86/kvm/x86.c:8074
Code: 03 00 00 48 89 f8 48 c1 e8 03 42 80 3c 20 00 0f 85 b4 1e 00 00 49 8b  
9f e0 03 00 00 48 8d bb 88 00 00 00 48 89 f8 48 c1 e8 03 <42> 80 3c 20 00  
0f 85 8a 1e 00 00 48 8b 9b 88 00 00 00 48 8d bb d8
kobject: 'loop4' (000000004a89aba1): kobject_uevent_env
kobject: 'loop4' (000000004a89aba1): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop2' (00000000704d7e59): kobject_uevent_env
kobject: 'loop2' (00000000704d7e59): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop4' (000000004a89aba1): kobject_uevent_env
kobject: 'loop4' (000000004a89aba1): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop2' (00000000704d7e59): kobject_uevent_env
RSP: 0018:ffff88818b0bf530 EFLAGS: 00010206
RAX: 0000000000000011 RBX: 0000000000000000 RCX: ffffc9001302b000
kobject: 'loop2' (00000000704d7e59): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
RDX: 00000000000000cf RSI: ffffffff81103a68 RDI: 0000000000000088
RBP: ffff88818b0bf8d0 R08: ffff8881bfe8e0c0 R09: 0000000000000008
R10: 0000000000000028 R11: ffffffff810feb0f R12: dffffc0000000000
R13: 0000000000000000 R14: ffffc90007ddfdb8 R15: ffff888188a18400
FS:  00007ff919977700(0000) GS:ffff8881daf00000(0000) knlGS:0000000000000000
kobject: 'loop3' (00000000941a4e7a): kobject_uevent_env
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffff600400 CR3: 00000001cdea0000 CR4: 00000000001426e0
kobject: 'loop3' (00000000941a4e7a): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
kobject: 'loop5' (000000004f26f0d5): kobject_uevent_env
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
kobject: 'loop5' (000000004f26f0d5): fill_kobj_path: path  
= '/devices/virtual/block/loop5'


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
