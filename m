Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA847C65BAF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 05:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D0F720821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 05:41:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D0F720821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbeLJFlS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 00:41:18 -0500
Received: from mail-it1-f197.google.com ([209.85.166.197]:56969 "EHLO
        mail-it1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726468AbeLJFlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 00:41:06 -0500
Received: by mail-it1-f197.google.com with SMTP id x3so12636211itb.6
        for <linux-kernel@vger.kernel.org>; Sun, 09 Dec 2018 21:41:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=y/S1NZc9q4l0C0YSixa3Yomka78oVSFR3XYhEAMAxXQ=;
        b=WWSvLDC1DDCoZbDlhvUqA+379bNuuOrJb6t2+3iub15E7jTlNPn5Z0g+kzT0e6w4rq
         4MJ8lyh63Q0CugW8hYvQWJm5RnIUKnlJYn3fPc7YSbOa2P23yLh3ENDh1zK61IibdcT+
         VQvs+cvxZdNVRryCaY90m+istNNshcVasBSuK7oblMxHcJWfZNbEhqjrk9CkzErkO0cn
         shYSCe6FF4azWXGntY45zSa+5Zoks52wXMeP+Q+sXT4VJwdf/moheRoPz40vVUiETc5Y
         yMjxb+U+q9zndbWVajkP6ann/uHJRy/6yoemqvBx6G2+RvCRrWRA8k8BkViXzIjRzLd1
         xIWA==
X-Gm-Message-State: AA+aEWZ2z9Js8jD3Or4tsU+ceX2umGpYhkvG+Jz3aTI6m+w1KakJP4Of
        ruRmM9LKIxwtxE7kZFIZkWDJnEKSys5jvEXBKNuvvhCykHYr
X-Google-Smtp-Source: AFSGD/XSjns7vixNVUj5kzARwChYTpWsnXTAz8AT7EEa/VgQ1P5jhr/ycvQGKLfCluhYglrz2VyEypTU5Ns6nzndzh04sHj4+gmz
MIME-Version: 1.0
X-Received: by 2002:a24:24e:: with SMTP id 75mr9546457itu.0.1544420465375;
 Sun, 09 Dec 2018 21:41:05 -0800 (PST)
Date:   Sun, 09 Dec 2018 21:41:05 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003907cd057ca469ec@google.com>
Subject: BUG: corrupted list in ___neigh_create
From:   syzbot <syzbot+b354d1fb59091ea73c37@syzkaller.appspotmail.com>
To:     christian@brauner.io, davem@davemloft.net, dsahern@gmail.com,
        edumazet@google.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, roopa@cumulusnetworks.com,
        syzkaller-bugs@googlegroups.com, w.bumiller@proxmox.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    97ef7b4c5501 ip: silence udp zerocopy smatch false positive
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13f4592b400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=28ecefa8a6e10719
dashboard link: https://syzkaller.appspot.com/bug?extid=b354d1fb59091ea73c37
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1442c925400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17778d6d400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+b354d1fb59091ea73c37@syzkaller.appspotmail.com

list_add corruption. prev->next should be next (ffffffff89fd0da0), but was  
ffff8881d7bf42b0. (prev=ffff8881d4465db0).
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:28!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 6257 Comm: syz-executor648 Not tainted 4.20.0-rc4+ #334
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:__list_add_valid.cold.2+0x23/0x2a lib/list_debug.c:26
Code: e8 90 fd d1 fd 0f 0b 48 89 d9 48 c7 c7 a0 d8 60 88 e8 7f fd d1 fd 0f  
0b 48 89 f1 48 c7 c7 20 d9 60 88 48 89 de e8 6b fd d1 fd <0f> 0b 90 90 90  
90 90 55 48 89 e5 41 57 41 56 49 be 00 00 00 00 00
RSP: 0018:ffff8881dae06cf0 EFLAGS: 00010282
RAX: 0000000000000075 RBX: ffffffff89fd0da0 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8165eae5 RDI: 0000000000000005
RBP: ffff8881dae06d08 R08: ffff8881bcdbe000 R09: ffffed103b5c5020
R10: ffffed103b5c5020 R11: ffff8881dae28107 R12: ffff8881ce059030
R13: ffff8881ce058dc0 R14: ffffffff89fd0b60 R15: ffffffff89fd0df0
FS:  0000000000000000(0000) GS:ffff8881dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000042de80 CR3: 00000001bd45f000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  <IRQ>
  __list_add include/linux/list.h:60 [inline]
  list_add_tail include/linux/list.h:93 [inline]
  neigh_alloc net/core/neighbour.c:395 [inline]
  ___neigh_create+0x14b7/0x2600 net/core/neighbour.c:553
cgroup: fork rejected by pids controller in /syz2
cgroup: fork rejected by pids controller in /syz5
  __neigh_create+0x30/0x40 net/core/neighbour.c:640
  ip6_finish_output2+0xa59/0x27a0 net/ipv6/ip6_output.c:117
  ip6_finish_output+0x58c/0xc60 net/ipv6/ip6_output.c:154
  NF_HOOK_COND include/linux/netfilter.h:278 [inline]
  ip6_output+0x232/0x9d0 net/ipv6/ip6_output.c:171
  dst_output include/net/dst.h:444 [inline]
  NF_HOOK include/linux/netfilter.h:289 [inline]
  ndisc_send_skb+0x1005/0x1560 net/ipv6/ndisc.c:491
  ndisc_send_rs+0x134/0x6e0 net/ipv6/ndisc.c:685
  addrconf_rs_timer+0x314/0x690 net/ipv6/addrconf.c:3840
  call_timer_fn+0x272/0x920 kernel/time/timer.c:1326
  expire_timers kernel/time/timer.c:1363 [inline]
  __run_timers+0x7e5/0xc70 kernel/time/timer.c:1682
cgroup: fork rejected by pids controller in /syz0
  run_timer_softirq+0x52/0xb0 kernel/time/timer.c:1695
cgroup: fork rejected by pids controller in /syz4
  __do_softirq+0x308/0xb7e kernel/softirq.c:292
cgroup: fork rejected by pids controller in /syz3
  invoke_softirq kernel/softirq.c:373 [inline]
  irq_exit+0x17f/0x1c0 kernel/softirq.c:413
  exiting_irq arch/x86/include/asm/apic.h:536 [inline]
  smp_apic_timer_interrupt+0x1cb/0x760 arch/x86/kernel/apic/apic.c:1061
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:804
  </IRQ>
RIP: 0010:arch_atomic_add_negative arch/x86/include/asm/atomic.h:154  
[inline]
RIP: 0010:atomic_add_negative include/asm-generic/atomic-instrumented.h:398  
[inline]
RIP: 0010:page_remove_file_rmap mm/rmap.c:1235 [inline]
RIP: 0010:page_remove_rmap+0x934/0x1a30 mm/rmap.c:1300
Code: 32 6a c7 ff 45 85 ff 0f 85 45 fb ff ff e9 0d f9 ff ff e8 0f 69 c7 ff  
48 8d 7b 30 be 04 00 00 00 e8 11 d6 0a 00 f0 83 43 30 ff <41> 0f 98 c4 31  
ff 44 89 e6 e8 be 69 c7 ff 45 84 e4 0f 84 3e ff ff
RSP: 0018:ffff8881c1786918 EFLAGS: 00000213 ORIG_RAX: ffffffffffffff13
RAX: fffff94000d8c6b7 RBX: ffffea0006c63580 RCX: ffffffff81b821ef
RDX: 0000000000000001 RSI: 0000000000000004 RDI: ffffea0006c635b0
RBP: ffff8881c1786c88 R08: fffff94000d8c6b7 R09: fffff94000d8c6b6
R10: fffff94000d8c6b6 R11: ffffea0006c635b3 R12: 0000000000000000
R13: ffff8881c1786c60 R14: ffffea0006c63588 R15: 0000000000000000
  zap_pte_range mm/memory.c:1091 [inline]
  zap_pmd_range mm/memory.c:1193 [inline]
  zap_pud_range mm/memory.c:1222 [inline]
  zap_p4d_range mm/memory.c:1243 [inline]
  unmap_page_range+0x11c7/0x2930 mm/memory.c:1264
  unmap_single_vma+0x19b/0x310 mm/memory.c:1309
  unmap_vmas+0x125/0x200 mm/memory.c:1339
  exit_mmap+0x2be/0x590 mm/mmap.c:3145
  __mmput kernel/fork.c:1045 [inline]
  mmput+0x247/0x610 kernel/fork.c:1066
  exit_mm kernel/exit.c:545 [inline]
  do_exit+0xe74/0x26d0 kernel/exit.c:854
  do_group_exit+0x177/0x440 kernel/exit.c:970
  get_signal+0x8b0/0x1980 kernel/signal.c:2517
  do_signal+0x9c/0x21c0 arch/x86/kernel/signal.c:816
  exit_to_usermode_loop+0x2e5/0x380 arch/x86/entry/common.c:162
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4480f9
Code: Bad RIP value.
RSP: 002b:00007ffccd7c26e8 EFLAGS: 00000202 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffdfc RBX: 000000000003f97b RCX: 00000000004480f9
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00000000006dec2c
RBP: 0000000000000004 R08: 0000000000000000 R09: 0000000000000000
R10: 00007ffccd7c26f0 R11: 0000000000000202 R12: 00000000000003e8
R13: 00000000006dec2c R14: 00000000006dec20 R15: 000000000000002d
Modules linked in:
---[ end trace 32027e846ce348df ]---
RIP: 0010:__list_add_valid.cold.2+0x23/0x2a lib/list_debug.c:26
Code: e8 90 fd d1 fd 0f 0b 48 89 d9 48 c7 c7 a0 d8 60 88 e8 7f fd d1 fd 0f  
0b 48 89 f1 48 c7 c7 20 d9 60 88 48 89 de e8 6b fd d1 fd <0f> 0b 90 90 90  
90 90 55 48 89 e5 41 57 41 56 49 be 00 00 00 00 00
RSP: 0018:ffff8881dae06cf0 EFLAGS: 00010282
RAX: 0000000000000075 RBX: ffffffff89fd0da0 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8165eae5 RDI: 0000000000000005
RBP: ffff8881dae06d08 R08: ffff8881bcdbe000 R09: ffffed103b5c5020
R10: ffffed103b5c5020 R11: ffff8881dae28107 R12: ffff8881ce059030
R13: ffff8881ce058dc0 R14: ffffffff89fd0b60 R15: ffffffff89fd0df0
FS:  0000000000000000(0000) GS:ffff8881dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000004480cf CR3: 00000001bd45f000 CR4: 00000000001406f0
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
