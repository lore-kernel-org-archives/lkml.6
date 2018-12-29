Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD38CC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 06:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82E9520857
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 06:34:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728840AbeL2GeF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 01:34:05 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:54738 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728824AbeL2GeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 01:34:05 -0500
Received: by mail-io1-f72.google.com with SMTP id f24so26950830ioh.21
        for <linux-kernel@vger.kernel.org>; Fri, 28 Dec 2018 22:34:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=JjMfWilsZnsihe9/K6YYF/1GBKo3QqHAraN5o0WM4es=;
        b=Bq/+FeNKZPW3TGahn5E9M1dHkr0wi7Ex3ONbedhevwiXTWIUP2Op5+zYMRniPgBY84
         j83AnA7sY7tnTlvDS7dpYH/DhU/ehkOMn0CqqEUDxVy+ye4V1Wo3+k9JdKYRf2kGrqoN
         99RUv6dH1ZELo0KeDG170pcQ92FId7AwnhfifXpSKXICrI0zVsbKTWWfVTUb9GezwSQ0
         1a6FShA1cohizlcJRAY008GYa5H98MzV0hvSw+LOjmLLYKRNwnTLZy6TrwFXd2MMEFGG
         nhLwKru5AzkmnHWOaHQR9d5bkwK9nopJJHeyN8M/yA8ayiQpfzRkBKJk+M39GgWlbLAk
         YBnA==
X-Gm-Message-State: AA+aEWZzzQaKsdTojLcZjrSUhJ7Aj8yZ0Z24GVdzK0ae7/LICxjfQsvf
        KBTF4rlSby4qbRDLkcj3M5a9/2XK2iLYcN+YzqpUrP5hrZJW
X-Google-Smtp-Source: AFSGD/V+3nVrt+vutej/YW0iNqFOKC/nHUFFyFIMEstg4V4CYqCQwopwouz3KyXw54XpeQ9Bh9Q0SW+VC6nc0VKiIvA2GJ9crDQW
MIME-Version: 1.0
X-Received: by 2002:a02:6006:: with SMTP id i6mr23408574jac.6.1546065243970;
 Fri, 28 Dec 2018 22:34:03 -0800 (PST)
Date:   Fri, 28 Dec 2018 22:34:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000aaa7bf057e235d28@google.com>
Subject: KASAN: slab-out-of-bounds Read in perf_exclude_event
From:   syzbot <syzbot+90e033e65bf7256f2afb@syzkaller.appspotmail.com>
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

HEAD commit:    7566ec393f41 Linux 4.20-rc7
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16c1b21b400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=861a3573f4e78ba1
dashboard link: https://syzkaller.appspot.com/bug?extid=90e033e65bf7256f2afb
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+90e033e65bf7256f2afb@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in perf_exclude_event+0x18b/0x1a0  
kernel/events/core.c:7895
Read of size 8 at addr ffff8881b09cff90 by task syz-executor2/30277

CPU: 0 PID: 30277 Comm: syz-executor2 Not tainted 4.20.0-rc7+ #154
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  <IRQ>
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x39d lib/dump_stack.c:113
  print_address_description.cold.7+0x9/0x1ff mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.8+0x242/0x309 mm/kasan/report.c:412
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
  perf_exclude_event+0x18b/0x1a0 kernel/events/core.c:7895
  perf_swevent_hrtimer+0x28f/0x510 kernel/events/core.c:9153
  __run_hrtimer kernel/time/hrtimer.c:1398 [inline]
  __hrtimer_run_queues+0x41c/0x10d0 kernel/time/hrtimer.c:1460
  hrtimer_interrupt+0x313/0x780 kernel/time/hrtimer.c:1518
  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1034 [inline]
  smp_apic_timer_interrupt+0x1a1/0x760 arch/x86/kernel/apic/apic.c:1059
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:807
  </IRQ>

Allocated by task 30091:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc7/0xe0 mm/kasan/kasan.c:553
  kmem_cache_alloc_trace+0x152/0x750 mm/slab.c:3620
  kmalloc include/linux/slab.h:546 [inline]
  kzalloc include/linux/slab.h:741 [inline]
  kernfs_iop_get_link+0x6d/0x690 fs/kernfs/symlink.c:136
  get_link fs/namei.c:1084 [inline]
  trailing_symlink+0x779/0x970 fs/namei.c:2263
  path_openat+0xb58/0x5150 fs/namei.c:3536
  do_filp_open+0x255/0x380 fs/namei.c:3564
  do_sys_open+0x568/0x700 fs/open.c:1063
  __do_sys_open fs/open.c:1081 [inline]
  __se_sys_open fs/open.c:1076 [inline]
  __x64_sys_open+0x7e/0xc0 fs/open.c:1076
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 30091:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xcf/0x230 mm/slab.c:3817
  kfree_link+0x15/0x20 fs/libfs.c:1105
  do_delayed_call include/linux/delayed_call.h:28 [inline]
  put_link fs/namei.c:883 [inline]
  step_into fs/namei.c:1772 [inline]
  do_last fs/namei.c:3383 [inline]
  path_openat+0x1ed3/0x5150 fs/namei.c:3534
  do_filp_open+0x255/0x380 fs/namei.c:3564
  do_sys_open+0x568/0x700 fs/open.c:1063
  __do_sys_open fs/open.c:1081 [inline]
  __se_sys_open fs/open.c:1076 [inline]
  __x64_sys_open+0x7e/0xc0 fs/open.c:1076
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8881b09ce080
  which belongs to the cache kmalloc-4k of size 4096
The buggy address is located 3856 bytes to the right of
  4096-byte region [ffff8881b09ce080, ffff8881b09cf080)
The buggy address belongs to the page:
page:ffffea0006c27380 count:1 mapcount:0 mapping:ffff8881da800dc0 index:0x0  
compound_mapcount: 0
flags: 0x2fffc0000010200(slab|head)
raw: 02fffc0000010200 ffffea00070ee188 ffffea0006ff4d08 ffff8881da800dc0
raw: 0000000000000000 ffff8881b09ce080 0000000100000001 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8881b09cfe80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  ffff8881b09cff00: 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc fc
> ffff8881b09cff80: fc fc fc fc fc fc fc fc fc fc fc f1 f1 f1 f1 00
                          ^
  ffff8881b09d0000: f2 f2 f2 00 00 00 00 00 00 00 00 00 00 00 00 00
  ffff8881b09d0080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
