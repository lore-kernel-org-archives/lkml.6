Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE785C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 03:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B82D208A3
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 03:10:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B82D208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933181AbeGIDJx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 23:09:53 -0400
Received: from mail-it0-f69.google.com ([209.85.214.69]:50176 "EHLO
        mail-it0-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932688AbeGIDJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 23:09:04 -0400
Received: by mail-it0-f69.google.com with SMTP id g125-v6so14668941ita.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jul 2018 20:09:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=nl6L5+p9//Y1h8Fvs3ZSEo0wrgihdS82RPxl0fUPsnY=;
        b=kuDgN2vV6aqagJEwBDpfBuJvMw4d2/8/2J0czd62WU/PL9dTPOHNpTyKN5chyB823C
         r20wPpzpDt6ftUckxruUias+HAXpdPPZQ4IrkSQe9eAGh/HkjOeMH8HzYOfZo4w8Td4J
         Tu78fgZ+Uzs3eUv2OsrSl+DF8U18vuWV/EnLXxPGyyKZWFptpIn1kJ3ZXeasF8npf+c2
         7hC+uyN9pi4Dvd3/fWiaNyj/FGv8MD/LJOKUMTpVg89WOJNu231f1fOKi4zC55daEasT
         qmFtF+KNqyTEyZJA8CuvupbUVcyW0NNt9117FBX5MLE0SPBmLAAno0NN3S6PZi51RwSf
         WgdQ==
X-Gm-Message-State: APt69E0K1KMIVAeCwKrCjub3vmJPzYvBK/Ze7k1d8nX5NN3hOg2nq957
        9c3KWRHXGZB589vamxbqx3rquJWBlqOJtwiSPPFUwFOAiDvE
X-Google-Smtp-Source: AAOMgpcxqL18Sh0YZIBeIhIPtFXH9NdIXjxDKNHieYtkBDazTT21exE3w8KPER5WYsjwsfSg+QBlOyZgtX03iZ0gAtAVzg6otqTv
MIME-Version: 1.0
X-Received: by 2002:a24:4ac8:: with SMTP id k191-v6mr8055508itb.7.1531105744291;
 Sun, 08 Jul 2018 20:09:04 -0700 (PDT)
Date:   Sun, 08 Jul 2018 20:09:04 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000000978e05708856cb@google.com>
Subject: KASAN: stack-out-of-bounds Read in account_system_index_time
From:   syzbot <syzbot+df1a417b3485bed2c190@syzkaller.appspotmail.com>
To:     fweisbec@gmail.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    ca04b3cca11a Merge tag 'armsoc-fixes' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11f1e968400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2ca6c7a31d407f86
dashboard link: https://syzkaller.appspot.com/bug?extid=df1a417b3485bed2c190
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=17f8f6d0400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15e88a78400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+df1a417b3485bed2c190@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: stack-out-of-bounds in __read_once_size  
include/linux/compiler.h:188 [inline]
BUG: KASAN: stack-out-of-bounds in get_running_cputimer  
include/linux/sched/cputime.h:85 [inline]
BUG: KASAN: stack-out-of-bounds in account_group_system_time  
include/linux/sched/cputime.h:149 [inline]
BUG: KASAN: stack-out-of-bounds in account_system_index_time+0x512/0x5c0  
kernel/sched/cputime.c:168
Read of size 1 at addr ffff8801afffc278 by task syz-executor708/17155

CPU: 1 PID: 17155 Comm: syz-executor708 Not tainted 4.18.0-rc3+ #137
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  <IRQ>
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
  print_address_description+0x6c/0x20b mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
  __asan_report_load1_noabort+0x14/0x20 mm/kasan/report.c:430
  __read_once_size include/linux/compiler.h:188 [inline]
  get_running_cputimer include/linux/sched/cputime.h:85 [inline]
  account_group_system_time include/linux/sched/cputime.h:149 [inline]
  account_system_index_time+0x512/0x5c0 kernel/sched/cputime.c:168
  account_system_time+0x7f/0xb0 kernel/sched/cputime.c:199
  account_process_tick+0x76/0x240 kernel/sched/cputime.c:498
  update_process_times+0x21/0x70 kernel/time/timer.c:1634
  tick_sched_handle+0x9f/0x180 kernel/time/tick-sched.c:164
  tick_sched_timer+0x45/0x130 kernel/time/tick-sched.c:1274
  __run_hrtimer kernel/time/hrtimer.c:1398 [inline]
  __hrtimer_run_queues+0x3eb/0x10c0 kernel/time/hrtimer.c:1460
  hrtimer_interrupt+0x2f3/0x750 kernel/time/hrtimer.c:1518
  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1025 [inline]
  smp_apic_timer_interrupt+0x165/0x730 arch/x86/kernel/apic/apic.c:1050
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:863
  </IRQ>

Allocated by task 905967825:
BUG: unable to handle kernel paging request at ffffffff8c42a180
PGD 8e6d067 P4D 8e6d067 PUD 8e6e063 PMD 0
Thread overran stack, or stack corrupted
Oops: 0000 [#1] SMP KASAN
CPU: 1 PID: 17155 Comm: syz-executor708 Not tainted 4.18.0-rc3+ #137
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:depot_fetch_stack+0x10/0x30 lib/stackdepot.c:201
Code: e8 65 1b 47 fe e9 b3 fd ff ff e8 5b 1b 47 fe e9 55 fd ff ff 90 90 90  
90 90 90 89 f8 c1 ef 11 25 ff ff 1f 00 81 e7 f0 3f 00 00 <48> 03 3c c5 80  
19 43 8b 8b 47 0c 48 83 c7 18 c7 46 10 00 00 00 00
RSP: 0018:ffff8801daf078b8 EFLAGS: 00010006
RAX: 00000000001ff100 RBX: ffff8801afffc654 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffff8801daf078c0 RDI: 0000000000000ff0
RBP: ffff8801daf078e8 R08: ffff8801adacc6c0 R09: ffffed003b5e3ec2
R10: ffffed003b5e3ec2 R11: ffff8801daf1f617 R12: ffff8801afffc140
R13: ffff8801afffc278 R14: ffff8801da97be40 R15: ffff8801afffc650
FS:  0000000000c14940(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffff8c42a180 CR3: 00000001ae362000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  <IRQ>
  describe_object mm/kasan/report.c:243 [inline]
  print_address_description+0xfb/0x20b mm/kasan/report.c:263
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
  __asan_report_load1_noabort+0x14/0x20 mm/kasan/report.c:430
  __read_once_size include/linux/compiler.h:188 [inline]
  get_running_cputimer include/linux/sched/cputime.h:85 [inline]
  account_group_system_time include/linux/sched/cputime.h:149 [inline]
  account_system_index_time+0x512/0x5c0 kernel/sched/cputime.c:168
  account_system_time+0x7f/0xb0 kernel/sched/cputime.c:199
  account_process_tick+0x76/0x240 kernel/sched/cputime.c:498
  update_process_times+0x21/0x70 kernel/time/timer.c:1634
  tick_sched_handle+0x9f/0x180 kernel/time/tick-sched.c:164
  tick_sched_timer+0x45/0x130 kernel/time/tick-sched.c:1274
  __run_hrtimer kernel/time/hrtimer.c:1398 [inline]
  __hrtimer_run_queues+0x3eb/0x10c0 kernel/time/hrtimer.c:1460
  hrtimer_interrupt+0x2f3/0x750 kernel/time/hrtimer.c:1518
  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1025 [inline]
  smp_apic_timer_interrupt+0x165/0x730 arch/x86/kernel/apic/apic.c:1050
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:863
  </IRQ>
Modules linked in:
Dumping ftrace buffer:
    (ftrace buffer empty)
CR2: ffffffff8c42a180
---[ end trace 9194b6f505fa64d0 ]---
RIP: 0010:depot_fetch_stack+0x10/0x30 lib/stackdepot.c:201
Code: e8 65 1b 47 fe e9 b3 fd ff ff e8 5b 1b 47 fe e9 55 fd ff ff 90 90 90  
90 90 90 89 f8 c1 ef 11 25 ff ff 1f 00 81 e7 f0 3f 00 00 <48> 03 3c c5 80  
19 43 8b 8b 47 0c 48 83 c7 18 c7 46 10 00 00 00 00
RSP: 0018:ffff8801daf078b8 EFLAGS: 00010006
RAX: 00000000001ff100 RBX: ffff8801afffc654 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffff8801daf078c0 RDI: 0000000000000ff0
RBP: ffff8801daf078e8 R08: ffff8801adacc6c0 R09: ffffed003b5e3ec2
R10: ffffed003b5e3ec2 R11: ffff8801daf1f617 R12: ffff8801afffc140
R13: ffff8801afffc278 R14: ffff8801da97be40 R15: ffff8801afffc650
FS:  0000000000c14940(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffff8c42a180 CR3: 00000001ae362000 CR4: 00000000001406e0
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
