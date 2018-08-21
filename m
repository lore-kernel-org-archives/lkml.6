Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E82CC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 15:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CF2D217BE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 15:24:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CF2D217BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbeHUSoj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 14:44:39 -0400
Received: from mail-it0-f69.google.com ([209.85.214.69]:41332 "EHLO
        mail-it0-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbeHUSoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 14:44:38 -0400
Received: by mail-it0-f69.google.com with SMTP id w132-v6so2866769ita.6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 08:24:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=zy1GzwFnkCnq2VjG01amO09N5RaVXp0hgS9UydJv2sA=;
        b=ikY/JMGwup55366/AsYsPmYGCIkECD/ZDA55cQ0rUgxKJJtIF/T4cp6fM3AXCSYElK
         UwXEzu34OOr3EM/UhpTDp+tm4WmgweoeE7SN7bzwOS9XSQsVOVSQAL8Sv8uwEWTxP9YX
         +TncsrADXNIUXLWIOl5Lc8Ct2QRZ5PYPLhF4gutyEZ5Xg3jFw8U4RNp4EqkLTtNGzCcX
         ItayBALVzWJSl2ftX90RJ66qdS8T5hGeKj0QgtPR/vmxJKRYfOMsWA6uWkQUjFyrnpCF
         hPT3U2PQo5onubNsR6WgFY1HLGxo2lzcB37ilb0yS666NigyYmPLAIs5qPp3CsW/YYaO
         1tDw==
X-Gm-Message-State: AOUpUlEtjHljLbG7lSZ3YuK+v7+tNR+YF7seLZawQZAym5r9EjaBbXKt
        CIcDjgHcatmsy0mhDoAmctmEwUHNPxXicx98MVlV7lFuuEuf
X-Google-Smtp-Source: AA+uWPxQHh1PX1ssyGwqygRs+Yq1YvzcdF+rLUIyileA098DLK9hNy4mcv9gqlI+F20hZoShIWDT7k/lX11SCGbEiQOvURNAJzpv
MIME-Version: 1.0
X-Received: by 2002:a02:b428:: with SMTP id i37-v6mr5690034jaj.7.1534865043001;
 Tue, 21 Aug 2018 08:24:03 -0700 (PDT)
Date:   Tue, 21 Aug 2018 08:24:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000aa9ac00573f39d69@google.com>
Subject: BUG: corrupted list in __loaded_vmcs_clear
From:   syzbot <syzbot+4c36e7123cd45e8e02dd@syzkaller.appspotmail.com>
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

HEAD commit:    cc26ebbebde8 ia64: Fix kernel BUG at lib/ioremap.c:72!
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17c869de400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=79e695838ce7a210
dashboard link: https://syzkaller.appspot.com/bug?extid=4c36e7123cd45e8e02dd
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+4c36e7123cd45e8e02dd@syzkaller.appspotmail.com

hfs: type requires a 4 character value
hfs: unable to parse mount options
list_del corruption. prev->next should be ffff8801a82de820, but was  
ffff8801909ad9e0
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:53!
invalid opcode: 0000 [#1] SMP KASAN
CPU: 1 PID: 21286 Comm: syz-executor0 Not tainted 4.18.0+ #199
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:__list_del_entry_valid.cold.1+0x48/0x58 lib/list_debug.c:51
Code: 9c 3a 87 e8 46 28 01 fe 0f 0b 48 89 de 48 c7 c7 20 9d 3a 87 e8 35 28  
01 fe 0f 0b 48 89 de 48 c7 c7 c0 9c 3a 87 e8 24 28 01 fe <0f> 0b 90 90 90  
90 90 90 90 90 90 90 90 90 90 90 55 48 89 e5 41 57
RSP: 0018:ffff8801db107c68 EFLAGS: 00010086
RAX: 0000000000000054 RBX: ffff8801a82de820 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff816422b1 RDI: 0000000000000001
RBP: ffff8801db107c80 R08: ffff8801b482a100 R09: ffffed003b624fd0
R10: ffffed003b624fd0 R11: ffff8801db127e87 R12: ffff88019bacde60
R13: ffff8801db11d130 R14: ffff8801a82de820 R15: 0000000000000001
FS:  00007fa2f3f9d700(0000) GS:ffff8801db100000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000001c6f978 CR3: 00000001c55b2000 CR4: 00000000001426e0
Call Trace:
  <IRQ>
  __list_del_entry include/linux/list.h:117 [inline]
  list_del include/linux/list.h:125 [inline]
  __loaded_vmcs_clear+0x14f/0x630 arch/x86/kvm/vmx.c:2187
  flush_smp_call_function_queue+0x1a8/0x5e0 kernel/smp.c:243
  generic_smp_call_function_single_interrupt+0x13/0x2b kernel/smp.c:192
  smp_call_function_single_interrupt+0x11a/0x670 arch/x86/kernel/smp.c:296
  call_function_single_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:886
  </IRQ>
RIP: 0010:arch_local_irq_restore arch/x86/include/asm/paravirt.h:783  
[inline]
RIP: 0010:lock_acquire+0x25f/0x540 kernel/locking/lockdep.c:3927
Code: 00 00 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 6a 02 00 00 48 83 3d 08  
9f 91 06 00 0f 84 d4 01 00 00 48 8b bd 20 ff ff ff 57 9d <0f> 1f 44 00 00  
48 b8 00 00 00 00 00 fc ff df 48 01 c3 48 c7 03 00
RSP: 0018:ffff880196e16798 EFLAGS: 00000286 ORIG_RAX: ffffffffffffff04
RAX: dffffc0000000000 RBX: 1ffff10032dc2cf8 RCX: 0000000000000000
RDX: 1ffffffff0fe3795 RSI: 0000000000000000 RDI: 0000000000000286
RBP: ffff880196e16888 R08: 0000000000000008 R09: 0000000000000001
R10: ffff8801b482a960 R11: 96c168e39ced084b R12: ffff8801b482a100
R13: 0000000000000002 R14: 0000000000000000 R15: 0000000000000000
  rcu_lock_acquire include/linux/rcupdate.h:244 [inline]
  rcu_read_lock+0x2b/0x70 include/linux/rcupdate.h:629
  lock_page_memcg+0x75/0x300 mm/memcontrol.c:1806
  page_remove_file_rmap mm/rmap.c:1215 [inline]
  page_remove_rmap+0x6b9/0x1260 mm/rmap.c:1300
  zap_pte_range mm/memory.c:1345 [inline]
  zap_pmd_range mm/memory.c:1447 [inline]
  zap_pud_range mm/memory.c:1476 [inline]
  zap_p4d_range mm/memory.c:1497 [inline]
  unmap_page_range+0xecd/0x2180 mm/memory.c:1518
  unmap_single_vma+0x1a0/0x310 mm/memory.c:1563
  unmap_vmas+0x120/0x1f0 mm/memory.c:1593
  exit_mmap+0x2c2/0x5b0 mm/mmap.c:3095
  __mmput kernel/fork.c:1001 [inline]
  mmput+0x265/0x620 kernel/fork.c:1022
  exit_mm kernel/exit.c:544 [inline]
  do_exit+0xec6/0x2760 kernel/exit.c:852
  do_group_exit+0x177/0x440 kernel/exit.c:968
  get_signal+0x88e/0x1970 kernel/signal.c:2468
  do_signal+0x9c/0x21c0 arch/x86/kernel/signal.c:816
  exit_to_usermode_loop+0x2e5/0x380 arch/x86/entry/common.c:162
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457089
Code: fd b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fa2f3f9ccf8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 00000000009300a8 RCX: 0000000000457089
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000009300a8
RBP: 00000000009300a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000009300ac
R13: 00007fffe4f483df R14: 00007fa2f3f9d9c0 R15: 0000000000000000
Modules linked in:
Dumping ftrace buffer:
    (ftrace buffer empty)
---[ end trace 4d2dfa4bbce8a17d ]---
RIP: 0010:__list_del_entry_valid.cold.1+0x48/0x58 lib/list_debug.c:51
Code: 9c 3a 87 e8 46 28 01 fe 0f 0b 48 89 de 48 c7 c7 20 9d 3a 87 e8 35 28  
01 fe 0f 0b 48 89 de 48 c7 c7 c0 9c 3a 87 e8 24 28 01 fe <0f> 0b 90 90 90  
90 90 90 90 90 90 90 90 90 90 90 55 48 89 e5 41 57
RSP: 0018:ffff8801db107c68 EFLAGS: 00010086
RAX: 0000000000000054 RBX: ffff8801a82de820 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff816422b1 RDI: 0000000000000001
RBP: ffff8801db107c80 R08: ffff8801b482a100 R09: ffffed003b624fd0
R10: ffffed003b624fd0 R11: ffff8801db127e87 R12: ffff88019bacde60
R13: ffff8801db11d130 R14: ffff8801a82de820 R15: 0000000000000001
FS:  00007fa2f3f9d700(0000) GS:ffff8801db100000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000001c6f978 CR3: 00000001c55b2000 CR4: 00000000001426e0


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
