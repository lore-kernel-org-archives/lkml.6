Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8FD5C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE5A520851
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:21:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE5A520851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbeLKPVF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:21:05 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:50872 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbeLKPVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:21:04 -0500
Received: by mail-io1-f71.google.com with SMTP id p4so14367023iod.17
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 07:21:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=StFa0hJG/OAopjInNt9zhUoIgmvn8ODt2320XdH402Y=;
        b=ZZ2eMQsqdXGobCC/6DQOMmw5SrF45wVx/jUP7Xz6GTxSGrHEurPXPGb/nPmOQAKr+q
         qrbzRm01ICbud2uPVhyIOa6x/OaVDXqr4OQ2AAGmHmFKVI97NqdwT/z8UalSPi8DzAOF
         twUbKyQVMThSrZpHMGCePX/cipBmasNLACZW26lErNRUY6ouE4lp2VOXbr5iDCoNyfm7
         t262uopUNHNPuAOQ6MtsY7kJWG5jo21TOE1lSfZohqWgLw5mLSeA4Av5bPLFc2zFpPpc
         NMAWobUunGUZFd6mZTmiop9awlLUoWiZAElWy3O2rhyHs/Vpu1sjA+eCJqgcJsIR5JjU
         kB6A==
X-Gm-Message-State: AA+aEWbp4zNrllDVceW/v2TfmLtaS5efBiKHhYTBS3qIQDG70WtoNzXm
        /xkZtmqZJnqRGUHDxPQz+oQ/UaDvBQbbzlB/6SryLwsMPXfc
X-Google-Smtp-Source: AFSGD/UvmJ7mNqw7w/Gph7IcccNYheuYBbXmIPkfj+ukNZqnFgvX7u0rqKTp+fHyJZ8LmPYt3lTedFvPsR1IqQ4PXhgVHjbR7NZg
MIME-Version: 1.0
X-Received: by 2002:a6b:d11a:: with SMTP id l26mr12503199iob.34.1544541663732;
 Tue, 11 Dec 2018 07:21:03 -0800 (PST)
Date:   Tue, 11 Dec 2018 07:21:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000352b7e057cc0a13f@google.com>
Subject: general protection fault in dst_dev_put (2)
From:   syzbot <syzbot+9d4c12bfd45a58738d0a@syzkaller.appspotmail.com>
To:     davem@davemloft.net, dsahern@gmail.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pablo@netfilter.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    290974d43478 nfp: flower: ensure TCP flags can be placed i..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=16132705400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c8970c89a0efbb23
dashboard link: https://syzkaller.appspot.com/bug?extid=9d4c12bfd45a58738d0a
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17a9d525400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13ed7c8b400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+9d4c12bfd45a58738d0a@syzkaller.appspotmail.com

New replicast peer: 255.255.255.255
Enabled bearer <udp:syz1>, priority 10
Enabling of bearer <udp:syz1> rejected, already enabled
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.20.0-rc6+ #225
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:dst_dev_put+0x24/0x290 net/core/dst.c:168
Code: 90 90 90 90 90 90 55 48 89 e5 41 56 41 55 41 54 53 48 89 fb e8 fd ed  
4d fb 48 89 da 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80> 3c 02 00 0f  
85 e3 01 00 00 48 8d 7b 3a 4c 8b 23 48 b8 00 00 00
RSP: 0018:ffff8881daf07658 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 00000000000001b8 RCX: ffffffff86b6790f
RDX: 0000000000000037 RSI: ffffffff86319673 RDI: 00000000000001b8
RBP: ffff8881daf07678 R08: ffff8881d9b14340 R09: 0000000000000008
R10: 0000000000000000 R11: ffff8881d9b14340 R12: dffffc0000000000
R13: 0000000000000000 R14: 00000000000001b8 R15: 0000607e24e2ca08
FS:  0000000000000000(0000) GS:ffff8881daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f955571ce78 CR3: 00000001cea15000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  <IRQ>
  rt_fibinfo_free_cpus net/ipv4/fib_semantics.c:200 [inline]
  free_fib_info_rcu+0x2e1/0x490 net/ipv4/fib_semantics.c:217
  __rcu_reclaim kernel/rcu/rcu.h:240 [inline]
  rcu_do_batch kernel/rcu/tree.c:2437 [inline]
  invoke_rcu_callbacks kernel/rcu/tree.c:2716 [inline]
  rcu_process_callbacks+0x100a/0x1ac0 kernel/rcu/tree.c:2697
  __do_softirq+0x308/0xb7e kernel/softirq.c:292
  invoke_softirq kernel/softirq.c:373 [inline]
  irq_exit+0x17f/0x1c0 kernel/softirq.c:413
  exiting_irq arch/x86/include/asm/apic.h:536 [inline]
  smp_apic_timer_interrupt+0x1cb/0x760 arch/x86/kernel/apic/apic.c:1061
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:807
  </IRQ>
RIP: 0010:native_safe_halt+0x6/0x10 arch/x86/include/asm/irqflags.h:57
Code: e9 2c ff ff ff 48 89 c7 48 89 45 d8 e8 c3 ef e7 f9 48 8b 45 d8 e9 ca  
fe ff ff 48 89 df e8 b2 ef e7 f9 eb 82 55 48 89 e5 fb f4 <5d> c3 0f 1f 84  
00 00 00 00 00 55 48 89 e5 f4 5d c3 90 90 90 90 90
RSP: 0018:ffff8881d9b27cb8 EFLAGS: 00000282 ORIG_RAX: ffffffffffffff13
RAX: dffffc0000000000 RBX: 1ffff1103b364f9b RCX: 0000000000000000
RDX: 1ffffffff12a4021 RSI: 0000000000000001 RDI: ffffffff89520108
RBP: ffff8881d9b27cb8 R08: ffff8881d9b14340 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff8881d9b27d78
R13: ffffffff8a163e20 R14: 0000000000000000 R15: 0000000000000001
  arch_safe_halt arch/x86/include/asm/paravirt.h:151 [inline]
  default_idle+0xbf/0x490 arch/x86/kernel/process.c:561
  arch_cpu_idle+0x10/0x20 arch/x86/kernel/process.c:552
  default_idle_call+0x6d/0x90 kernel/sched/idle.c:93
  cpuidle_idle_call kernel/sched/idle.c:153 [inline]
  do_idle+0x49b/0x5c0 kernel/sched/idle.c:262
  cpu_startup_entry+0x18/0x20 kernel/sched/idle.c:353
  start_secondary+0x487/0x5f0 arch/x86/kernel/smpboot.c:271
  secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:243
Modules linked in:
---[ end trace d0be650c8601c1dd ]---
RIP: 0010:dst_dev_put+0x24/0x290 net/core/dst.c:168
Code: 90 90 90 90 90 90 55 48 89 e5 41 56 41 55 41 54 53 48 89 fb e8 fd ed  
4d fb 48 89 da 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80> 3c 02 00 0f  
85 e3 01 00 00 48 8d 7b 3a 4c 8b 23 48 b8 00 00 00
RSP: 0018:ffff8881daf07658 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 00000000000001b8 RCX: ffffffff86b6790f
RDX: 0000000000000037 RSI: ffffffff86319673 RDI: 00000000000001b8
RBP: ffff8881daf07678 R08: ffff8881d9b14340 R09: 0000000000000008
R10: 0000000000000000 R11: ffff8881d9b14340 R12: dffffc0000000000
R13: 0000000000000000 R14: 00000000000001b8 R15: 0000607e24e2ca08
FS:  0000000000000000(0000) GS:ffff8881daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f955571ce78 CR3: 00000001cea15000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
