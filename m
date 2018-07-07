Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2262AC6778A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 15:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBA012077B
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 15:09:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBA012077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753903AbeGGPJE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 11:09:04 -0400
Received: from mail-io0-f198.google.com ([209.85.223.198]:52122 "EHLO
        mail-io0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753447AbeGGPJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 11:09:03 -0400
Received: by mail-io0-f198.google.com with SMTP id w23-v6so2782722iob.18
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jul 2018 08:09:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=5f1miRnyXMPci4T/vIjOwei3mbfsqTgt2psg29ukIbM=;
        b=V642usVnd19oZX3+r05TwpY0dN1/yYLkJQ1JIjmbAwtDLGrZ3lqJgQICchID9tXHOL
         V/iZneVfcrB8oxZ0qpJfPeGVwmnnvtxtPthMyC7xZY36WoJ1nAYH7BAf9Rd3eA0PsDuD
         5Z5Jc1hqwYg//hIY6P7hYTi1rY2/PXZZm/BUfbMxOfAZ7KOvLVEfn3/w5R9yh34r6HYs
         fwLK9trF9a+zex4/qaJKOlS21juf94dZr5cCOgZhLeEnZ8g/GjktBzymnSaGCHxiSwYv
         Nt9DMT0fkUjJOgiAA1CWSwSnA1Rmvjh/thWbFq8eNduN4evwO4fU2bLfET8SvdTQMAZh
         CciQ==
X-Gm-Message-State: APt69E2H2EGg4PPcDAyVIX8mpT76Q2FZ5f2+sUtQu2jX42DWbkudj6cr
        /UO0jqMVaoflUm/Bp6tgEM2SgjBlYPF/aoVxPtGlhY0p3szV
X-Google-Smtp-Source: AAOMgpdcKpJfRNDAwNSo38LIbcEUyQzVD5OtG0vsg5ALfDWsdM1CpbHYAQXIRZekX9mAkDx/qATBgz2ooM/UezWYaAeMmc917HwG
MIME-Version: 1.0
X-Received: by 2002:a6b:8d8a:: with SMTP id p132-v6mr6250826iod.59.1530976142706;
 Sat, 07 Jul 2018 08:09:02 -0700 (PDT)
Date:   Sat, 07 Jul 2018 08:09:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000025545a05706a29d4@google.com>
Subject: KASAN: stack-out-of-bounds Read in rb_erase (3)
From:   syzbot <syzbot+52ee52c330c2fcdade39@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    29119529d8de Merge tag 'for-linus-20180706' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16e2550c400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2ca6c7a31d407f86
dashboard link: https://syzkaller.appspot.com/bug?extid=52ee52c330c2fcdade39
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=1463ef48400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10e481b2400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+52ee52c330c2fcdade39@syzkaller.appspotmail.com

random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
==================================================================
BUG: KASAN: stack-out-of-bounds in ____rb_erase_color lib/rbtree.c:258  
[inline]
BUG: KASAN: stack-out-of-bounds in rb_erase+0x19e9/0x3550 lib/rbtree.c:462
Read of size 8 at addr ffff8801c2dd7718 by task syz-executor396/4530

CPU: 1 PID: 4530 Comm: syz-executor396 Not tainted 4.18.0-rc3+ #134
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  <IRQ>
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
  print_address_description+0x6c/0x20b mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
  ____rb_erase_color lib/rbtree.c:258 [inline]
  rb_erase+0x19e9/0x3550 lib/rbtree.c:462
  timerqueue_del+0x86/0x150 lib/timerqueue.c:87
  __remove_hrtimer+0xa8/0x1b0 kernel/time/hrtimer.c:984
  __run_hrtimer kernel/time/hrtimer.c:1380 [inline]
  __hrtimer_run_queues+0x369/0x10c0 kernel/time/hrtimer.c:1460
  hrtimer_interrupt+0x2f3/0x750 kernel/time/hrtimer.c:1518
  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1025 [inline]
  smp_apic_timer_interrupt+0x165/0x730 arch/x86/kernel/apic/apic.c:1050
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:863
  </IRQ>

The buggy address belongs to the page:
page:ffffea00070b75c0 count:0 mapcount:0 mapping:0000000000000000 index:0x0
flags: 0x2fffc0000000000()
raw: 02fffc0000000000 0000000000000000 ffffffff070b0101 0000000000000000
raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801c2dd7600: f2 f2 f2 f2 f2 f2 f2 00 f2 f2 f2 00 00 00 00 00
  ffff8801c2dd7680: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ffff8801c2dd7700: f1 f1 f1 f1 00 f2 f2 f2 f2 f2 f2 f2 00 f2 f2 f2
                             ^
  ffff8801c2dd7780: f2 f2 f2 f2 00 f2 f2 f2 f2 f2 f2 f2 f8 f2 f2 f2
  ffff8801c2dd7800: f2 f2 f2 f2 00 f2 f2 f2 00 00 00 00 00 00 00 00
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
