Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SORTED_RECIPS,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D1E9C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 06:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A5E020652
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 06:04:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A5E020652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752903AbeFTGED (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 02:04:03 -0400
Received: from mail-it0-f72.google.com ([209.85.214.72]:37644 "EHLO
        mail-it0-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751092AbeFTGEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 02:04:02 -0400
Received: by mail-it0-f72.google.com with SMTP id p130-v6so2105268itp.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 23:04:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=QOUp1Icm6xlMt66F0NEhVvPiqPJx7MX2n25DhGPeD9Y=;
        b=cIwVuXgHZFBkC7/kIVpGLHb+PZTd/3qqxIYH9EGKjHvWDW0WE67TKuEJGSv6G0dI99
         qLXRGJIofpqR+USyJAEMctjeclVah+010t+mNDZlvEW6Gyfc4ks8hxIrkFc/kBo90nSQ
         TTodX1n5aJG9bFj4cjvyjmircwW5phn8jFPo1wQ/k44+NPuUnKiovQ60LP+RSarf2yZX
         jx/dp/lczNh6RGW3StgEfpbHK0+cytszTl3IuLKL9en3Z3kCupnZ8uC24OZjHvACUdLl
         9MLqNT72UH0Jm2xhsTaEMSkWGdR9LiaaSy4fleX2mbvQeWEHIxNDtPrqI/WD4R7nPogv
         CH5Q==
X-Gm-Message-State: APt69E0JChU7qpBT+wDYctn88AfrlOTiqnDlDKGb/eo3A7nm0Qm7JG8C
        WZ/PwPzXFoCf8O/e/Rv+/resO0BpY4Jn8n4D6L2UVlxAnza+
X-Google-Smtp-Source: ADUXVKIVOY3iADZzF1h/FOVUlWirnURafQUPsiDFTblbSz/3bP1nxYbGBOMgGpZyYwh12FiGuCjqehb4BLZB5HLHgS0NKgup5eSm
MIME-Version: 1.0
X-Received: by 2002:a24:5083:: with SMTP id m125-v6mr238745itb.26.1529474641744;
 Tue, 19 Jun 2018 23:04:01 -0700 (PDT)
Date:   Tue, 19 Jun 2018 23:04:01 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b6dcad056f0c9089@google.com>
Subject: KASAN: stack-out-of-bounds Read in unwind_next_frame
From:   syzbot <syzbot+3ae3575e398ca1d88e5d@syzkaller.appspotmail.com>
To:     hpa@zytor.com, jpoimboe@redhat.com, linux-kernel@vger.kernel.org,
        mhiramat@kernel.org, mingo@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    ba4dbdedd3ed Merge tag 'jfs-4.18' of git://github.com/klei..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17fe8bd8400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f390986c4f7cd566
dashboard link: https://syzkaller.appspot.com/bug?extid=3ae3575e398ca1d88e5d
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+3ae3575e398ca1d88e5d@syzkaller.appspotmail.com

kvm: pic: single mode not supported
==================================================================
BUG: KASAN: stack-out-of-bounds in __read_once_size  
include/linux/compiler.h:188 [inline]
BUG: KASAN: stack-out-of-bounds in unwind_next_frame.part.7+0x801/0x9e0  
arch/x86/kernel/unwind_frame.c:326
Read of size 8 at addr ffff88017c386c78 by task syz-executor0/22016

CPU: 1 PID: 22016 Comm: syz-executor0 Not tainted 4.18.0-rc1+ #109
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
  print_address_description+0x6c/0x20b mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
  __read_once_size include/linux/compiler.h:188 [inline]
  unwind_next_frame.part.7+0x801/0x9e0 arch/x86/kernel/unwind_frame.c:326
  unwind_next_frame+0x3e/0x50 arch/x86/kernel/unwind_frame.c:287
  __save_stack_trace+0x7d/0xf0 arch/x86/kernel/stacktrace.c:44
  save_stack_trace+0x1a/0x20 arch/x86/kernel/stacktrace.c:60
  save_trace+0xe0/0x290 kernel/locking/lockdep.c:404
  check_prev_add kernel/locking/lockdep.c:1915 [inline]
  check_prevs_add kernel/locking/lockdep.c:1980 [inline]
  validate_chain kernel/locking/lockdep.c:2421 [inline]
  __lock_acquire+0x39a8/0x5020 kernel/locking/lockdep.c:3435
  lock_acquire+0x1e4/0x540 kernel/locking/lockdep.c:3924
  __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
  _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:144
  vprintk_emit+0x191/0xdf0 kernel/printk/printk.c:1848
  vprintk_default+0x28/0x30 kernel/printk/printk.c:1948
  vprintk_func+0x7a/0xe7 kernel/printk/printk_safe.c:382
  printk+0xa7/0xcf kernel/printk/printk.c:1981
  kasan_die_handler.cold.22+0x11/0x30 arch/x86/mm/kasan_init_64.c:251
  notifier_call_chain+0x180/0x390 kernel/notifier.c:93
  __atomic_notifier_call_chain kernel/notifier.c:183 [inline]
  atomic_notifier_call_chain+0x98/0x190 kernel/notifier.c:193
  notify_die+0x1be/0x2e0 kernel/notifier.c:549
  do_general_protection+0x248/0x2f0 arch/x86/kernel/traps.c:559
  general_protection+0x1e/0x30 arch/x86/entry/entry_64.S:1159
RIP: 0010:msr_write_intercepted arch/x86/kvm/vmx.c:2327 [inline]
RIP: 0010:vmx_vcpu_run+0x131a/0x2600 arch/x86/kvm/vmx.c:10149
Code: 00 00 10 89 de e8 36 65 5c 00 85 db 0f 84 91 00 00 00 e8 19 64 5c 00  
48 8b 54 24 08 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80> 3c 02 00 0f  
85 8c 10 00 00 48 8b 04 24 48 8b 98 40 57 00 00 48
RSP: 0018:ffff88017c387370 EFLAGS: 00010002
RAX: dffffc0000000000 RBX: 0000000010000000 RCX: ffffffff811f467a
RDX: 000000000000045b RSI: ffffffff811f4687 RDI: 0000000000000005
RBP: ffff88017c3873a8 R08: ffff8801b0e4a080 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000

The buggy address belongs to the page:
page:ffffea0005f0e180 count:0 mapcount:0 mapping:0000000000000000  
index:0xffff88017c386940
flags: 0x2fffc0000000000()
raw: 02fffc0000000000 0000000000000000 dead000000000200 0000000000000000
raw: ffff88017c386940 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff88017c386b00: f2 f2 f8 f2 f2 f2 f2 f2 f2 f2 00 f2 f2 f2 f2 f2
  ffff88017c386b80: f2 f2 f8 f2 f2 f2 f2 f2 f2 f2 00 f2 f2 f2 f2 f2
> ffff88017c386c00: f2 f2 f8 f2 f2 f2 00 00 00 00 00 00 00 f2 f2 f2
                                                                 ^
  ffff88017c386c80: 00 f2 f2 f2 f2 f2 f2 f2 00 f2 f1 f1 f1 f1 00 f2
  ffff88017c386d00: f2 f2 f2 f2 f2 f2 f8 f2 f2 f2 f2 f2 00 00 00 00
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
