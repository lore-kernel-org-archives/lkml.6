Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A843C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 16:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21D6020830
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 16:52:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21D6020830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbeKBB4B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 21:56:01 -0400
Received: from mail-it1-f197.google.com ([209.85.166.197]:33131 "EHLO
        mail-it1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbeKBBzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 21:55:50 -0400
Received: by mail-it1-f197.google.com with SMTP id i15-v6so2738480itb.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 09:52:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=mogCSHy6FetDS0BtWyPr5fYAzBr6BSXR6diWB0SUNnI=;
        b=FWP0sUhPIwM+1tfCwS6CAFLD4lS0+wRbE5/Nq8Ti0fUA6DMW2UYiOFITSep9K/QI1p
         XZ7Uj4AP6Zarg3uWxyo04tDxYqDMeKyrNtKmdA3KpNZi1j+vmsST+OeK23nFNyktOBVG
         fRYW5zeOm5AeX18p+tHA6ABOB/OHCLXsnhjQLaz/uH6zTgPXu8WOqtCE4ew9Do2bdRLc
         2I/QKxh1R1ggg4WOuDxjZlnPHSUNOtJk7dSBtpwNOsXagMU0sXb0S7yD6QM4jO8keGu1
         O3iuw3v/7SSvqCZfxxLnA/mn4J2zhLGwtXvpKgaSfv/UdhA+BoAdRWes4T+AOBdhW6R2
         HpZw==
X-Gm-Message-State: AGRZ1gK9Bdal5Fci/rhGMHRRFD9WoDhLZ6dS6Ef7yR/3bvGEWN1bFj4u
        8N/vtiEFILKgBKp3CeUqqkywdjbqzU5aqCVWQ9IzUK012wvQ
X-Google-Smtp-Source: AJdET5dB3Q3S+1lKOzrz32NmRzA9I1LDJmg+zLyf/hOnC3WSIrlRZ+gZLGEbi47TsPbjd95Sl7D73excZAsr1KeF4p2JlZgQgEQS
MIME-Version: 1.0
X-Received: by 2002:a24:10cd:: with SMTP id 196-v6mr5875002ity.21.1541091123832;
 Thu, 01 Nov 2018 09:52:03 -0700 (PDT)
Date:   Thu, 01 Nov 2018 09:52:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000000d55405799d3d58@google.com>
Subject: KASAN: use-after-free Read in delayed_uprobe_remove
From:   syzbot <syzbot+cb1fb754b771caca0a88@syzkaller.appspotmail.com>
To:     acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, linux-kernel@vger.kernel.org, mingo@redhat.com,
        namhyung@kernel.org, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    5b7449810ae6 Merge tag 'tag-chrome-platform-for-v4.20' of ..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15a89825400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4e8e3fa31e0cc680
dashboard link: https://syzkaller.appspot.com/bug?extid=cb1fb754b771caca0a88
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+cb1fb754b771caca0a88@syzkaller.appspotmail.com

RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000005
RBP: 000000000072bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fbaf376a6d4
R13: 00000000004efe32 R14: 00000000004cc6e0 R15: 0000000000000007
==================================================================
BUG: KASAN: use-after-free in delayed_uprobe_remove+0x124/0x140  
kernel/events/uprobes.c:344
Read of size 8 at addr ffff8801cd7b6358 by task syz-executor3/14242

CPU: 1 PID: 14242 Comm: syz-executor3 Not tainted 4.19.0+ #91
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x39d lib/dump_stack.c:113
  print_address_description.cold.7+0x9/0x1ff mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.8+0x242/0x309 mm/kasan/report.c:412
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
  delayed_uprobe_remove+0x124/0x140 kernel/events/uprobes.c:344
  uprobe_clear_state+0xbe/0x390 kernel/events/uprobes.c:1510
  __mmput kernel/fork.c:1040 [inline]
  mmput+0x1bc/0x610 kernel/fork.c:1065
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
RIP: 0033:0x457569
Code: fd b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f719e958c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffe0 RBX: 0000000000000003 RCX: 0000000000457569
RDX: 0000000000000447 RSI: 00000000200008c0 RDI: 0000000000000003
RBP: 000000000072bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f719e9596d4
R13: 00000000004c57ab R14: 00000000004d9370 R15: 00000000ffffffff

Allocated by task 14239:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc7/0xe0 mm/kasan/kasan.c:553
  kmem_cache_alloc_trace+0x152/0x750 mm/slab.c:3620
  kmalloc include/linux/slab.h:546 [inline]
  kzalloc include/linux/slab.h:741 [inline]
  delayed_uprobe_add kernel/events/uprobes.c:313 [inline]
  update_ref_ctr+0x36f/0x590 kernel/events/uprobes.c:447
  uprobe_write_opcode+0x94b/0xc50 kernel/events/uprobes.c:496
  set_swbp+0x2a/0x40
  install_breakpoint.isra.24+0x161/0x840 kernel/events/uprobes.c:883
  register_for_each_vma+0xa38/0xee0 kernel/events/uprobes.c:1039
  uprobe_apply+0xee/0x140 kernel/events/uprobes.c:1190
  uprobe_perf_open kernel/trace/trace_uprobe.c:1087 [inline]
  trace_uprobe_register+0x771/0xcf0 kernel/trace/trace_uprobe.c:1227
  perf_trace_event_open kernel/trace/trace_event_perf.c:181 [inline]
  perf_trace_event_init+0x1a5/0x990 kernel/trace/trace_event_perf.c:203
  perf_uprobe_init+0x1f1/0x280 kernel/trace/trace_event_perf.c:329
  perf_uprobe_event_init+0x106/0x1a0 kernel/events/core.c:8503
  perf_try_init_event+0x137/0x2f0 kernel/events/core.c:9770
  perf_init_event kernel/events/core.c:9801 [inline]
  perf_event_alloc.part.94+0x1d54/0x3740 kernel/events/core.c:10074
  perf_event_alloc kernel/events/core.c:10430 [inline]
  __do_sys_perf_event_open+0xada/0x3020 kernel/events/core.c:10531
  __se_sys_perf_event_open kernel/events/core.c:10420 [inline]
  __x64_sys_perf_event_open+0xbe/0x150 kernel/events/core.c:10420
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 14239:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xcf/0x230 mm/slab.c:3817
  delayed_uprobe_delete+0x1b0/0x2b0 kernel/events/uprobes.c:328
  delayed_uprobe_remove+0xe8/0x140 kernel/events/uprobes.c:347
  put_uprobe+0x4d/0x60 kernel/events/uprobes.c:575
  uprobe_unregister+0x56/0x70 kernel/events/uprobes.c:1088
  probe_event_disable.part.16+0x16a/0x2c0 kernel/trace/trace_uprobe.c:990
  probe_event_disable kernel/trace/trace_uprobe.c:1224 [inline]
  trace_uprobe_register+0x52c/0xcf0 kernel/trace/trace_uprobe.c:1223
  perf_trace_event_unreg.isra.3+0xbb/0x220  
kernel/trace/trace_event_perf.c:157
  perf_uprobe_destroy+0xc3/0x130 kernel/trace/trace_event_perf.c:342
  _free_event+0x414/0x1660 kernel/events/core.c:4446
  put_event+0x48/0x60 kernel/events/core.c:4532
  perf_event_release_kernel+0x8d0/0x10e0 kernel/events/core.c:4638
  perf_release+0x37/0x50 kernel/events/core.c:4648
  __fput+0x385/0xa30 fs/file_table.c:278
  ____fput+0x15/0x20 fs/file_table.c:309
  task_work_run+0x1e8/0x2a0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:188 [inline]
  exit_to_usermode_loop+0x318/0x380 arch/x86/entry/common.c:166
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8801cd7b6340
  which belongs to the cache kmalloc-32 of size 32
The buggy address is located 24 bytes inside of
  32-byte region [ffff8801cd7b6340, ffff8801cd7b6360)
The buggy address belongs to the page:
page:ffffea000735ed80 count:1 mapcount:0 mapping:ffff8801da8001c0  
index:0xffff8801cd7b6fc1
flags: 0x2fffc0000000200(slab)
raw: 02fffc0000000200 ffffea000732d188 ffffea00075aff08 ffff8801da8001c0
raw: ffff8801cd7b6fc1 ffff8801cd7b6000 000000010000003f 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801cd7b6200: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
  ffff8801cd7b6280: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
> ffff8801cd7b6300: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
                                                     ^
  ffff8801cd7b6380: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
  ffff8801cd7b6400: 06 fc fc fc fc fc fc fc fb fb fb fb fc fc fc fc
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
