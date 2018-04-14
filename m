Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751141AbeDNBHE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 21:07:04 -0400
Received: from mail-it0-f71.google.com ([209.85.214.71]:40156 "EHLO
        mail-it0-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750904AbeDNBHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 21:07:02 -0400
X-Google-Smtp-Source: AIpwx4+fgnb+Xn/jP1tAmpUm4q5GI/FKYQVxRSoI5s2ZG10isyPHud92NAmLnfyWiA4dbl3cKPSAITJmE806WbnFIURyI7FbnovF
MIME-Version: 1.0
Date: Fri, 13 Apr 2018 18:07:02 -0700
In-Reply-To: <883d24f79ad8fd475f0569a39ba6@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000037b58a0569c49b70@google.com>
Subject: Re: general protection fault in vmx_vcpu_run
From: syzbot <syzbot+cc483201a3c6436d3550@syzkaller.appspotmail.com>
To: hpa@zytor.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, pbonzini@redhat.com, rkrcmar@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found reproducer for the following crash on upstream commit
1bad9ce155a7c010a9a5f3261ad12a6a8eccfb2c (Fri Apr 13 19:27:11 2018 +0000)
Merge tag 'sh-for-4.17' of git://git.libc.org/linux-sh
syzbot dashboard link:  
https://syzkaller.appspot.com/bug?extid=cc483201a3c6436d3550

So far this crash happened 4 times on upstream.
C reproducer: https://syzkaller.appspot.com/x/repro.c?id=6257386297753600
syzkaller reproducer:  
https://syzkaller.appspot.com/x/repro.syz?id=4808329293463552
Raw console output:  
https://syzkaller.appspot.com/x/log.txt?id=4943675322793984
Kernel config:  
https://syzkaller.appspot.com/x/.config?id=-5947642240294114534
compiler: gcc (GCC) 8.0.1 20180413 (experimental)

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+cc483201a3c6436d3550@syzkaller.appspotmail.com
It will help syzbot understand when the bug is fixed.

IPv6: ADDRCONF(NETDEV_CHANGE): veth1: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
8021q: adding VLAN 0 to HW filter on device team0
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] SMP KASAN
Dumping ftrace buffer:
    (ftrace buffer empty)
Modules linked in:
CPU: 0 PID: 6472 Comm: syzkaller667776 Not tainted 4.16.0+ #1
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:vmx_vcpu_run+0x95f/0x25f0 arch/x86/kvm/vmx.c:9746
RSP: 0018:ffff8801c95bf368 EFLAGS: 00010002
RAX: ffff8801b44df6e8 RBX: ffff8801ada0ec40 RCX: 1ffff100392b7e78
RDX: 0000000000000000 RSI: ffffffff81467b15 RDI: ffff8801ada0ec50
RBP: ffff8801b44df790 R08: ffff8801c4efe780 R09: fffffbfff1141218
R10: fffffbfff1141218 R11: ffffffff88a090c3 R12: ffff8801b186aa90
R13: ffff8801ae61e000 R14: dffffc0000000000 R15: ffff8801ae61e3e0
FS:  00007fa147982700(0000) GS:ffff8801db000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 00000001d780d000 CR4: 00000000001426f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
Code: 8b a9 68 03 00 00 4c 8b b1 70 03 00 00 4c 8b b9 78 03 00 00 48 8b 89  
08 03 00 00 75 05 0f 01 c2 eb 03 0f 01 c3 48 89 4c 24 08 59 <0f> 96 81 88  
56 00 00 48 89 81 00 03 00 00 48 89 99 18 03 00 00
RIP: vmx_vcpu_run+0x95f/0x25f0 arch/x86/kvm/vmx.c:9746 RSP: ffff8801c95bf368
---[ end trace ffd91ebc3bb06b01 ]---
Kernel panic - not syncing: Fatal exception
Shutting down cpus with NMI
Dumping ftrace buffer:
    (ftrace buffer empty)
Kernel Offset: disabled
Rebooting in 86400 seconds..
