Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB24C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28B16204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:35:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28B16204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbeIJN16 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 09:27:58 -0400
Received: from mail-it0-f71.google.com ([209.85.214.71]:41514 "EHLO
        mail-it0-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727488AbeIJN15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 09:27:57 -0400
Received: by mail-it0-f71.google.com with SMTP id w132-v6so37954628ita.6
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 01:35:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=u2JLB9hCsiaxuDyu1PQKJUXmzTltDyRDKG/RI7AO7gA=;
        b=bYknFcYAXmNddEnZcZDmMAPQeSQ6pqKOFAyqOdSawS1zenHVgXrVh8h+7mnVE9Jzcq
         0PMKWiosXQ7Ue3UpfCWib8B8BxfIUgE0jX+ySnHjy1lmJKI3aKGW6+DDB0yiFUtAPDVl
         Sn9bUhAVlCE8Ke+P1pqvntTju/7Jkn11NkTB5qlGkjY5ZxyQVSxccvS5vNj60/anvx7f
         m9k52WSWSjxoVxPatVjdXVk8QzRJxKDwujYJ6n9fhakE0LhEWZXPHwOcHdvgR7qq6uBJ
         0qcAO/1od5odqVSSCiAiqQjqcX0H+9n08sqC08pCS5oBYM9NkHc/e52C61I2oIsNtixW
         2MwQ==
X-Gm-Message-State: APzg51BdvWRWAplxOSfGuHh0WRBx02wvSHjIj5GXiXMUTSA3YzaCdovo
        rhn9pGwFXbxf7Agj7Dx9UWTnZ1SNOP1VOz41wBRpmAsMQjP+
X-Google-Smtp-Source: ANB0VdaUGBW7FlsDavhHbOVsNypSOU1t40eHXgNryLw7JopdW5PCtUuzNbG5XqAEVBY9uWfZxBeuZiCmj3x3no/RNWLshKPmnlq7
MIME-Version: 1.0
X-Received: by 2002:a24:3cc3:: with SMTP id m186-v6mr17736117ita.30.1536568502682;
 Mon, 10 Sep 2018 01:35:02 -0700 (PDT)
Date:   Mon, 10 Sep 2018 01:35:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c691670575803b0c@google.com>
Subject: BUG: Bad page map (3)
From:   syzbot <syzbot+0b10582e8ee2a6253de7@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, christian.koenig@amd.com,
        dan.j.williams@intel.com, dave@stgolabs.net, dwmw@amazon.co.uk,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux@dominikbrodowski.net, mhocko@suse.com, rientjes@google.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    3d0e7a9e00fd Merge tag 'md/4.19-rc2' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1782d70a400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f59875069d721b6
dashboard link: https://syzkaller.appspot.com/bug?extid=0b10582e8ee2a6253de7
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+0b10582e8ee2a6253de7@syzkaller.appspotmail.com

BUG: Bad page map in process syz-executor3  pte:ffffffff8901f947  
pmd:18d73f067
addr:000000006b20cb06 vm_flags:180400fb anon_vma:          (null)  
mapping:000000007878cb6c index:b7
file:kcov fault:          (null) mmap:kcov_mmap readpage:          (null)
CPU: 0 PID: 19022 Comm: syz-executor3 Not tainted 4.19.0-rc2+ #4
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c4/0x2b4 lib/dump_stack.c:113
  print_bad_pte.cold.111+0x1e6/0x24b mm/memory.c:773
  _vm_normal_page+0x248/0x3c0 mm/memory.c:859
  zap_pte_range mm/memory.c:1311 [inline]
  zap_pmd_range mm/memory.c:1440 [inline]
  zap_pud_range mm/memory.c:1469 [inline]
  zap_p4d_range mm/memory.c:1490 [inline]
  unmap_page_range+0x9a5/0x2000 mm/memory.c:1511
  unmap_single_vma+0x19b/0x310 mm/memory.c:1556
  unmap_vmas+0x125/0x200 mm/memory.c:1586
  exit_mmap+0x2be/0x590 mm/mmap.c:3093
  __mmput kernel/fork.c:1001 [inline]
  mmput+0x247/0x610 kernel/fork.c:1022
  exit_mm kernel/exit.c:545 [inline]
  do_exit+0xe6f/0x2610 kernel/exit.c:854
  do_group_exit+0x177/0x440 kernel/exit.c:970
  get_signal+0x8b0/0x1980 kernel/signal.c:2513
  do_signal+0x9c/0x21e0 arch/x86/kernel/signal.c:816
  exit_to_usermode_loop+0x2e5/0x380 arch/x86/entry/common.c:162
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457099
Code: Bad RIP value.
RSP: 002b:00007f9decd04cf8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 00000000009300a8 RCX: 0000000000457099
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00000000009300a8
RBP: 00000000009300a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000009300ac
R13: 00007ffe4545d67f R14: 00007f9decd059c0 R15: 0000000000000000
swap_info_get: Bad swap file entry 3ffffffffffff
BUG: Bad page map in process syz-executor3  pte:00000008 pmd:18d73f067
addr:000000005c045c2f vm_flags:180400fb anon_vma:          (null)  
mapping:000000007878cb6c index:ba
file:kcov fault:          (null) mmap:kcov_mmap readpage:          (null)
CPU: 0 PID: 19022 Comm: syz-executor3 Tainted: G    B              
4.19.0-rc2+ #4
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c4/0x2b4 lib/dump_stack.c:113
  print_bad_pte.cold.111+0x1e6/0x24b mm/memory.c:773
  zap_pte_range mm/memory.c:1385 [inline]
  zap_pmd_range mm/memory.c:1440 [inline]
  zap_pud_range mm/memory.c:1469 [inline]
  zap_p4d_range mm/memory.c:1490 [inline]
  unmap_page_range+0x196f/0x2000 mm/memory.c:1511
  unmap_single_vma+0x19b/0x310 mm/memory.c:1556
  unmap_vmas+0x125/0x200 mm/memory.c:1586
  exit_mmap+0x2be/0x590 mm/mmap.c:3093
  __mmput kernel/fork.c:1001 [inline]
  mmput+0x247/0x610 kernel/fork.c:1022
  exit_mm kernel/exit.c:545 [inline]
  do_exit+0xe6f/0x2610 kernel/exit.c:854
  do_group_exit+0x177/0x440 kernel/exit.c:970
  get_signal+0x8b0/0x1980 kernel/signal.c:2513
  do_signal+0x9c/0x21e0 arch/x86/kernel/signal.c:816
  exit_to_usermode_loop+0x2e5/0x380 arch/x86/entry/common.c:162
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457099
Code: Bad RIP value.
RSP: 002b:00007f9decd04cf8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 00000000009300a8 RCX: 0000000000457099
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00000000009300a8
RBP: 00000000009300a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000009300ac
R13: 00007ffe4545d67f R14: 00007f9decd059c0 R15: 0000000000000000
BUG: Bad page map in process syz-executor3  pte:ffff8801ce138140  
pmd:18d73f067
addr:00000000df7251c2 vm_flags:180400fb anon_vma:          (null)  
mapping:000000007878cb6c index:bc
file:kcov fault:          (null) mmap:kcov_mmap readpage:          (null)
CPU: 0 PID: 19022 Comm: syz-executor3 Tainted: G    B              
4.19.0-rc2+ #4
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c4/0x2b4 lib/dump_stack.c:113
  print_bad_pte.cold.111+0x1e6/0x24b mm/memory.c:773
  _vm_normal_page+0x248/0x3c0 mm/memory.c:859
  zap_pte_range mm/memory.c:1311 [inline]
  zap_pmd_range mm/memory.c:1440 [inline]
  zap_pud_range mm/memory.c:1469 [inline]
  zap_p4d_range mm/memory.c:1490 [inline]
  unmap_page_range+0x9a5/0x2000 mm/memory.c:1511
  unmap_single_vma+0x19b/0x310 mm/memory.c:1556
  unmap_vmas+0x125/0x200 mm/memory.c:1586
  exit_mmap+0x2be/0x590 mm/mmap.c:3093
  __mmput kernel/fork.c:1001 [inline]
  mmput+0x247/0x610 kernel/fork.c:1022
  exit_mm kernel/exit.c:545 [inline]
  do_exit+0xe6f/0x2610 kernel/exit.c:854
  do_group_exit+0x177/0x440 kernel/exit.c:970
  get_signal+0x8b0/0x1980 kernel/signal.c:2513
  do_signal+0x9c/0x21e0 arch/x86/kernel/signal.c:816
  exit_to_usermode_loop+0x2e5/0x380 arch/x86/entry/common.c:162
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457099
Code: Bad RIP value.
RSP: 002b:00007f9decd04cf8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 00000000009300a8 RCX: 0000000000457099
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00000000009300a8
RBP: 00000000009300a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000009300ac
R13: 00007ffe4545d67f R14: 00007f9decd059c0 R15: 0000000000000000
------------[ cut here ]------------
kernel BUG at include/linux/swapops.h:215!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 19022 Comm: syz-executor3 Tainted: G    B              
4.19.0-rc2+ #4
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:migration_entry_to_page+0x444/0x550 include/linux/swapops.h:215
Code: 2b e8 70 6a cd ff 48 c7 c6 60 af 13 88 4c 89 e7 e8 c1 0b ff ff 0f 0b  
e8 5a 6a cd ff 4d 8d 67 ff e9 a3 fe ff ff e8 4c 6a cd ff <0f> 0b e8 45 6a  
cd ff 4c 8d 63 ff eb ca e8 da cf 10 00 e9 63 fc ff
RSP: 0018:ffff880081026b20 EFLAGS: 00010293
RAX: ffff8801cc706340 RBX: fffff8ffce518000 RCX: ffffffff81b163c4
RDX: 0000000000000000 RSI: ffffffff81b164f4 RDI: 0000000000000007
RBP: ffff880081026c78 R08: ffff8801cc706340 R09: fffffbfff1326cb0
R10: fffffbfff1326cb0 R11: 0000000000000003 R12: 0000000000000000
R13: 1ffff10010204d66 R14: 0000000000000000 R15: 0000000000000000
FS:  00007f9decd05700(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000045706f CR3: 0000000136186000 CR4: 00000000001426f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  zap_pte_range mm/memory.c:1381 [inline]
  zap_pmd_range mm/memory.c:1440 [inline]
  zap_pud_range mm/memory.c:1469 [inline]
  zap_p4d_range mm/memory.c:1490 [inline]
  unmap_page_range+0x108f/0x2000 mm/memory.c:1511
  unmap_single_vma+0x19b/0x310 mm/memory.c:1556
  unmap_vmas+0x125/0x200 mm/memory.c:1586
  exit_mmap+0x2be/0x590 mm/mmap.c:3093
  __mmput kernel/fork.c:1001 [inline]
  mmput+0x247/0x610 kernel/fork.c:1022
  exit_mm kernel/exit.c:545 [inline]
  do_exit+0xe6f/0x2610 kernel/exit.c:854
  do_group_exit+0x177/0x440 kernel/exit.c:970
  get_signal+0x8b0/0x1980 kernel/signal.c:2513
  do_signal+0x9c/0x21e0 arch/x86/kernel/signal.c:816
  exit_to_usermode_loop+0x2e5/0x380 arch/x86/entry/common.c:162
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457099
Code: Bad RIP value.
RSP: 002b:00007f9decd04cf8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 00000000009300a8 RCX: 0000000000457099
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00000000009300a8
RBP: 00000000009300a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000009300ac
R13: 00007ffe4545d67f R14: 00007f9decd059c0 R15: 0000000000000000
Modules linked in:
Dumping ftrace buffer:
    (ftrace buffer empty)
---[ end trace 434b92653afbda82 ]---
RIP: 0010:migration_entry_to_page+0x444/0x550 include/linux/swapops.h:215
Code: 2b e8 70 6a cd ff 48 c7 c6 60 af 13 88 4c 89 e7 e8 c1 0b ff ff 0f 0b  
e8 5a 6a cd ff 4d 8d 67 ff e9 a3 fe ff ff e8 4c 6a cd ff <0f> 0b e8 45 6a  
cd ff 4c 8d 63 ff eb ca e8 da cf 10 00 e9 63 fc ff
RSP: 0018:ffff880081026b20 EFLAGS: 00010293
RAX: ffff8801cc706340 RBX: fffff8ffce518000 RCX: ffffffff81b163c4
RDX: 0000000000000000 RSI: ffffffff81b164f4 RDI: 0000000000000007
RBP: ffff880081026c78 R08: ffff8801cc706340 R09: fffffbfff1326cb0
R10: fffffbfff1326cb0 R11: 0000000000000003 R12: 0000000000000000
R13: 1ffff10010204d66 R14: 0000000000000000 R15: 0000000000000000
FS:  00007f9decd05700(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000045706f CR3: 0000000136186000 CR4: 00000000001426f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
