Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4152C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 02:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92CF52086C
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 02:09:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729716AbeLPCJF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 21:09:05 -0500
Received: from mail-it1-f200.google.com ([209.85.166.200]:42106 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727227AbeLPCJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 21:09:04 -0500
Received: by mail-it1-f200.google.com with SMTP id g7so10534004itg.7
        for <linux-kernel@vger.kernel.org>; Sat, 15 Dec 2018 18:09:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=+JTtYasYnDXe5AJ/SyDRnM1zfNivs+1kAA5SzJPJikw=;
        b=B3/HnoeW7Zsdw4178FR5ppPXyVU1KfMuSwNxovFB6WUHftPahgU9SXuuSX/KcOeifM
         d4Y+VX+6s1B+3bxX722bs9XX0pjeTj4I08JGMpJqaByQPR8NCB2L1vVtrESVn/RXOT5u
         xLVSfpOMS7ezgo832zMOAq/kMphsZ1o5UrmVJP/fHO2AoM4uHlyb0/zc+tXjCDxYzB+r
         /J55Lua+aL1sHbA5bBooDjXGaTslnmXxJAMG1KD2TjshIMnVhN6QwPcEB8ewgxfcx2Oz
         cYfrVoYzvIrbHPm+lbXJnse72L+vxotn68QTeTTu5k19DTdEf5S/8vXqbVagrrqTmP0c
         ph6Q==
X-Gm-Message-State: AA+aEWbIq6Ogv1XfGNRIgnYBMKNH/TrbeVEkUo10WB3kL2xJZiPeMAri
        g6tKs3aeEDJhyZu1KwHdeJ79H0VZZssrGxoZQJaP9dtZmt8C
X-Google-Smtp-Source: AFSGD/WNFqV28yIEYk36JS03UYDxFcpugc47ZgW1i/wUQqTQxpUdmWKal5aysbA7vcZY/lVn2OXMRzAngb8HfPQD3Bi+dD80JQDG
MIME-Version: 1.0
X-Received: by 2002:a24:334e:: with SMTP id k75mr7178848itk.19.1544926143535;
 Sat, 15 Dec 2018 18:09:03 -0800 (PST)
Date:   Sat, 15 Dec 2018 18:09:03 -0800
In-Reply-To: <000000000000ba65b0057c2d09a1@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fd63eb057d1a25f7@google.com>
Subject: Re: general protection fault in kvm_arch_vcpu_ioctl_run
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

syzbot has found a reproducer for the following crash on:

HEAD commit:    6531e115b7ab Merge branch 'akpm' (patches from Andrew)
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15d99b2b400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c8970c89a0efbb23
dashboard link: https://syzkaller.appspot.com/bug?extid=39810e6c400efadfef71
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16005a15400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1056e543400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+39810e6c400efadfef71@syzkaller.appspotmail.com

L1TF CPU bug present and SMT on, data leak possible. See CVE-2018-3646 and  
https://www.kernel.org/doc/html/latest/admin-guide/l1tf.html for details.
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 5962 Comm: syz-executor118 Not tainted 4.20.0-rc6+ #374
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
RSP: 0018:ffff8881be6bf530 EFLAGS: 00010206
RAX: 0000000000000011 RBX: 0000000000000000 RCX: ffffffff8110198b
RDX: 0000000000000000 RSI: ffffffff81103a68 RDI: 0000000000000088
RBP: ffff8881be6bf8d0 R08: ffff8881c2362640 R09: 0000000000000008
R10: 0000000000000028 R11: ffffffff810feb0f R12: dffffc0000000000
R13: 0000000000000000 R14: ffffc90005e03db8 R15: ffff8881c2b70080
FS:  0000000000e17880(0000) GS:ffff8881daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000040 CR3: 00000001d2bc9000 CR4: 00000000001426e0
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
RIP: 0033:0x440859
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 fb 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fff16fec8f8 EFLAGS: 00000207 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 0000000000440859
RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 0000000000000008
RBP: 00000000006ca018 R08: 00000000004002c8 R09: 00000000004002c8
R10: 00000000004002c8 R11: 0000000000000207 R12: 00000000004020e0
R13: 0000000000402170 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
---[ end trace 893a1b8ec645980a ]---
RIP: 0010:kvm_apic_hw_enabled arch/x86/kvm/lapic.h:169 [inline]
RIP: 0010:vcpu_scan_ioapic arch/x86/kvm/x86.c:7449 [inline]
RIP: 0010:vcpu_enter_guest arch/x86/kvm/x86.c:7602 [inline]
RIP: 0010:vcpu_run arch/x86/kvm/x86.c:7874 [inline]
RIP: 0010:kvm_arch_vcpu_ioctl_run+0x5296/0x7320 arch/x86/kvm/x86.c:8074
Code: 03 00 00 48 89 f8 48 c1 e8 03 42 80 3c 20 00 0f 85 b4 1e 00 00 49 8b  
9f e0 03 00 00 48 8d bb 88 00 00 00 48 89 f8 48 c1 e8 03 <42> 80 3c 20 00  
0f 85 8a 1e 00 00 48 8b 9b 88 00 00 00 48 8d bb d8
RSP: 0018:ffff8881be6bf530 EFLAGS: 00010206
RAX: 0000000000000011 RBX: 0000000000000000 RCX: ffffffff8110198b
RDX: 0000000000000000 RSI: ffffffff81103a68 RDI: 0000000000000088
RBP: ffff8881be6bf8d0 R08: ffff8881c2362640 R09: 0000000000000008
R10: 0000000000000028 R11: ffffffff810feb0f R12: dffffc0000000000
R13: 0000000000000000 R14: ffffc90005e03db8 R15: ffff8881c2b70080
FS:  0000000000e17880(0000) GS:ffff8881daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000040 CR3: 00000001d2bc9000 CR4: 00000000001426e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

