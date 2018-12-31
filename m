Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F41EC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 22:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF8C32075D
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 22:22:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbeLaWWE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 17:22:04 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:51706 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727416AbeLaWWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 17:22:04 -0500
Received: by mail-io1-f69.google.com with SMTP id q207so30264906iod.18
        for <linux-kernel@vger.kernel.org>; Mon, 31 Dec 2018 14:22:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=xSPpOOzkJMGt8pmISA+fLmNjIepK7tcdv1wnKSWJkdw=;
        b=TkYKBHapjH+w2TUztLPpPITF4sQp4x/uMuyqsjcNIdyr8qDo80JeTqSV6Co6+eKuns
         PyJogeU1NnoUrZh+RZ/pfBSjNqMRUCAQ73et5D2qQHFXG386zefbIzujNvJgQWu7L/9n
         zatUv+U7F43FCNZF3jNUOh0ffMIV+dk2eLxJJ7fZ6rPp4GZkS8Hb3Z/bMz3gyQkwGbAJ
         X9ONLT2HW/zrStfTDdcV1l+kM9lFVdPQNsNfBbvAkMrviEDekQOwGKWL/7jsRrU4KCf4
         8cgHZMeiyApFZeavE52ydheJTbwoOghcxuat25scLmDqSAKSZLwboA3YRXWNUxj6nRAn
         08Cg==
X-Gm-Message-State: AA+aEWYqVV3YATUIQuFddmD5vbyIejZfTkPz6R+DQjH/13ZhqQY36RS0
        vRIqrjRrAYpsDJMk5veCxSAVmRNGAneI79huRMZEN/VyESTQ
X-Google-Smtp-Source: ALg8bN5jk7Ne+xX1RxEE7p+TF0YJYCKQlernuK+qhreE+QPJtg3K/OMjhQC0IJdSqK9iTWWl0q4QuM4LA4yyJtOZe4IUBJwIFcFV
MIME-Version: 1.0
X-Received: by 2002:a24:6852:: with SMTP id v79mr28507249itb.29.1546294923270;
 Mon, 31 Dec 2018 14:22:03 -0800 (PST)
Date:   Mon, 31 Dec 2018 14:22:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009ea37c057e58d787@google.com>
Subject: general protection fault in ax25_send_frame
From:   syzbot <syzbot+e0b81535a27b8be39502@syzkaller.appspotmail.com>
To:     davem@davemloft.net, jreuter@yaina.de, linux-hams@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        ralf@linux-mips.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    90cadbbf341d Merge git://git.kernel.org/pub/scm/linux/kern..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17127500c00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f9a32c9a4aef9af7
dashboard link: https://syzkaller.appspot.com/bug?extid=e0b81535a27b8be39502
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+e0b81535a27b8be39502@syzkaller.appspotmail.com

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
kobject: 'loop3' (00000000a0e7275a): kobject_uevent_env
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 18625 Comm: blkid Not tainted 4.20.0-rc7+ #361
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:ax25_send_frame+0xe2/0x570 net/ax25/ax25_out.c:59
kobject: 'loop3' (00000000a0e7275a): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
Code: 34 91 00 00 48 85 c0 0f 85 c2 03 00 00 e8 d6 bd 7e fa 48 8d bb 38 03  
00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f  
85 ea 03 00 00 48 8b 83 38 03 00 00 48 85 c0 48 89
RSP: 0018:ffff8880ae707518 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 1ffff1100a4e3951
RDX: 0000000000000067 RSI: ffffffff86ff9d4a RDI: 0000000000000338
RBP: ffff8880ae707558 R08: ffff88805271ca88 R09: 0000000000000002
R10: 0000000000000000 R11: ffff88805271c1c0 R12: ffff88809aec1a88
R13: ffffffff8be98280 R14: 0000000000000104 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
kobject: 'loop2' (0000000016318dbe): kobject_uevent_env
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fff26e69ed8 CR3: 0000000097648000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  <IRQ>
  rose_send_frame+0xda/0x280 net/rose/rose_link.c:109
  rose_transmit_clear_request+0x1de/0x2a0 net/rose/rose_link.c:258
  rose_rx_call_request+0x4ea/0x1c90 net/rose/af_rose.c:999
  rose_loopback_timer+0x26a/0x3f0 net/rose/rose_loopback.c:100
  call_timer_fn+0x272/0x920 kernel/time/timer.c:1326
kobject: 'loop2' (0000000016318dbe): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
  expire_timers kernel/time/timer.c:1363 [inline]
  __run_timers+0x7e5/0xc70 kernel/time/timer.c:1682
kobject: 'loop5' (00000000d24778f2): kobject_uevent_env
kobject: 'loop5' (00000000d24778f2): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
  run_timer_softirq+0x52/0xb0 kernel/time/timer.c:1695
  __do_softirq+0x30c/0xb2e kernel/softirq.c:292
kobject: 'loop3' (00000000a0e7275a): kobject_uevent_env
  invoke_softirq kernel/softirq.c:373 [inline]
  irq_exit+0x17f/0x1c0 kernel/softirq.c:413
  exiting_irq arch/x86/include/asm/apic.h:536 [inline]
  smp_apic_timer_interrupt+0x1cb/0x760 arch/x86/kernel/apic/apic.c:1061
kobject: 'loop3' (00000000a0e7275a): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:807
  </IRQ>
RIP: 0010:write_comp_data+0x1/0x70 kernel/kcov.c:116
Code: e5 90 43 00 e9 a6 fc ff ff 4c 89 f7 e8 38 90 43 00 e9 6f fc ff ff e8  
9e b7 c9 ff 90 90 90 90 90 90 90 90 90 90 90 90 90 90 55 <48> 89 e5 65 4c  
8b 04 25 40 ee 01 00 65 8b 05 0c 93 83 7e a9 00 01
RSP: 0018:ffff888090d1f088 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
kobject: 'loop2' (0000000016318dbe): kobject_uevent_env
RAX: 0000000000000000 RBX: 00007f538b24f000 RCX: ffffffff81b177ab
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000005
RBP: ffff888090d1f098 R08: ffff88805271c1c0 R09: fffff94000052236
R10: fffff94000052236 R11: ffffea00002911b3 R12: 0000000000000025
R13: ffffea00002911c8 R14: dffffc0000000000 R15: ffffea00002911c0
kobject: 'loop2' (0000000016318dbe): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
  zap_pte_range mm/memory.c:1082 [inline]
  zap_pmd_range mm/memory.c:1193 [inline]
  zap_pud_range mm/memory.c:1222 [inline]
  zap_p4d_range mm/memory.c:1243 [inline]
  unmap_page_range+0xc4b/0x25b0 mm/memory.c:1264
kobject: 'loop0' (00000000f27d2df2): kobject_uevent_env
kobject: 'loop0' (00000000f27d2df2): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
  unmap_single_vma+0x19b/0x310 mm/memory.c:1309
  unmap_vmas+0x125/0x200 mm/memory.c:1339
  exit_mmap+0x2be/0x590 mm/mmap.c:3145
kobject: 'loop3' (00000000a0e7275a): kobject_uevent_env
  __mmput kernel/fork.c:1045 [inline]
  mmput+0x247/0x610 kernel/fork.c:1066
kobject: 'loop3' (00000000a0e7275a): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
  exit_mm kernel/exit.c:545 [inline]
  do_exit+0xe74/0x26d0 kernel/exit.c:854
kobject: 'loop5' (00000000d24778f2): kobject_uevent_env
kobject: 'loop5' (00000000d24778f2): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
  do_group_exit+0x177/0x440 kernel/exit.c:970
  __do_sys_exit_group kernel/exit.c:981 [inline]
  __se_sys_exit_group kernel/exit.c:979 [inline]
  __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:979
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x7f538b1e71e8
Code: Bad RIP value.
RSP: 002b:00007fff26e6cfa8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f538b1e71e8
RDX: 0000000000000002 RSI: 000000000000003c RDI: 0000000000000002
RBP: 00007f538b4bc840 R08: 00000000000000e7 R09: ffffffffffffffa8
R10: 00007f538b4c2740 R11: 0000000000000246 R12: 00007f538b4bc840
R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
---[ end trace 9b094a20ff9d7199 ]---
RIP: 0010:ax25_send_frame+0xe2/0x570 net/ax25/ax25_out.c:59
Code: 34 91 00 00 48 85 c0 0f 85 c2 03 00 00 e8 d6 bd 7e fa 48 8d bb 38 03  
00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f  
85 ea 03 00 00 48 8b 83 38 03 00 00 48 85 c0 48 89
RSP: 0018:ffff8880ae707518 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 1ffff1100a4e3951
RDX: 0000000000000067 RSI: ffffffff86ff9d4a RDI: 0000000000000338
RBP: ffff8880ae707558 R08: ffff88805271ca88 R09: 0000000000000002
R10: 0000000000000000 R11: ffff88805271c1c0 R12: ffff88809aec1a88
R13: ffffffff8be98280 R14: 0000000000000104 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f538b1e71be CR3: 0000000097648000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
