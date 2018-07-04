Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7469C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 16:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9800223C4
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 16:29:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9800223C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752874AbeGDQ3E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 12:29:04 -0400
Received: from mail-io0-f200.google.com ([209.85.223.200]:43032 "EHLO
        mail-io0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752173AbeGDQ3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 12:29:02 -0400
Received: by mail-io0-f200.google.com with SMTP id n18-v6so4600317iog.10
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 09:29:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=vj/1SBr687277m9HiPWYVqaxBvfUhWdHr/PmTZ7z4qg=;
        b=KN1CjB4BkcWIroeBcm4LixD+U8dQAi6IkRjg/M5yPfZQMf1A2uEW4whxjKwl26/9JQ
         FCtQeDp2UhEeo/jx1dz9fbNivcGafo9gSktC7sJABBGE2wNasE+tOVCt8wKVvRNL6OlY
         xWge9C/p+4DC9HyTzgnyw7E3lgb//+CUSw7gIbsWGag1D3taclMZwE+7FCOu1/ZceMmg
         YUOurG4JHTzUqmhDHA/7/XxtkCLw284VOpPcWglnt/ZzxVngWdFUHZWb/jckK9/bH8nX
         gPk4nFzgIEJFvcBfoU0aj6nAElw71K9Wht3u/k+gfkU/7ViNXt0fLw5/zH9nV/xgsih1
         2aww==
X-Gm-Message-State: APt69E2TY2FjeJj4KskjHf/cNms0C6u7IcZlpapyw1H6ep8cLnNTDq+C
        901snYc9l7F7UGuryeImtvvmqSR67xaEZQGzplqlHEV4EQvz
X-Google-Smtp-Source: AAOMgpdrY09C0TZ9gom84GGfH5QM1/C+Yevw4xyNP4+lkq8pzmelgAnBZWsUWXP+gl54AHkd7YnQh0hRh1lJdsFRBCAnQ7zrWssc
MIME-Version: 1.0
X-Received: by 2002:a6b:6a0c:: with SMTP id x12-v6mr1020859iog.72.1530721742261;
 Wed, 04 Jul 2018 09:29:02 -0700 (PDT)
Date:   Wed, 04 Jul 2018 09:29:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b2989805702eedd3@google.com>
Subject: KASAN: stack-out-of-bounds Read in timerqueue_add
From:   syzbot <syzbot+b680e42077a0d7c9a0c4@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    fc36def997cf mm: teach dump_page() to correctly output poi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=167e3b92400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f62553dc846b0692
dashboard link: https://syzkaller.appspot.com/bug?extid=b680e42077a0d7c9a0c4
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=1030a858400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1167aaa4400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+b680e42077a0d7c9a0c4@syzkaller.appspotmail.com

random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
IPVS: ftp: loaded support on port[0] = 21
==================================================================
BUG: KASAN: stack-out-of-bounds in timerqueue_add+0x249/0x2b0  
lib/timerqueue.c:52
Read of size 8 at addr ffff8801af537cf8 by task syz-executor591/7178

CPU: 0 PID: 7178 Comm: syz-executor591 Not tainted 4.18.0-rc3+ #130
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
  timerqueue_add+0x249/0x2b0 lib/timerqueue.c:52
  enqueue_hrtimer+0x18e/0x540 kernel/time/hrtimer.c:960
  __run_hrtimer kernel/time/hrtimer.c:1413 [inline]
  __hrtimer_run_queues+0xc07/0x10c0 kernel/time/hrtimer.c:1460
  hrtimer_interrupt+0x2f3/0x750 kernel/time/hrtimer.c:1518
  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1025 [inline]
  smp_apic_timer_interrupt+0x165/0x730 arch/x86/kernel/apic/apic.c:1050
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:863
  </IRQ>

The buggy address belongs to the page:
page:ffffea0006bd4dc0 count:0 mapcount:0 mapping:0000000000000000 index:0x0
flags: 0x2fffc0000000000()
raw: 02fffc0000000000 0000000000000000 ffffffff06bd0101 0000000000000000
raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801af537b80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  ffff8801af537c00: 00 00 00 00 f1 f1 f1 f1 00 f2 f2 f2 f2 f2 f2 f2
> ffff8801af537c80: 00 f2 f2 f2 f2 f2 f2 f2 00 f2 f2 f2 f2 f2 f2 f2
                                                                 ^
  ffff8801af537d00: f8 f2 f2 f2 f2 f2 f2 f2 00 f2 f2 f2 00 00 00 00
  ffff8801af537d80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
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
