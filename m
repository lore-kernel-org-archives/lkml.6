Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B9CC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E10720661
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:31:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E10720661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbeH3Tdp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 15:33:45 -0400
Received: from mail-io0-f199.google.com ([209.85.223.199]:57145 "EHLO
        mail-io0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726235AbeH3Tdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 15:33:45 -0400
Received: by mail-io0-f199.google.com with SMTP id o18-v6so7803890ioh.23
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 08:31:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=i0FvpuMhplJAgw+0N527fxM4y1fu2WwuGP7nYq7k+R8=;
        b=BrAEg9yWD4j40qiwSPxptHtpFHTkYPi59+plEOYI8P+ige1Qk38gioG++rs7c2IXuw
         UGtrkOuKux1SfTNz3r5boWqIcgqXhUOr8Yxc6ITp/ug5sHY7GayeaPK/W+WFen6fnVpE
         x43Bg/IfCjw4/vMl/ZtZ3rIrzKIY4Zz27zr1k736KRMR5el3xI4taXLLTkYqoj82Ux8N
         1OJ6N5Bgz1WEyvKajK0CdCi0l5f6K/5JBaEqjnYzlj08/xtv6szeOxMLkVqXK7hJZNCX
         j2Z7wgotiXuA5UwpkLV8ZrcVV5apvZBc1M/d0Eb7uh4HCD9vwJX1Q8oTDky1/+gtVQAj
         nYMg==
X-Gm-Message-State: APzg51AtiH41m4J6jPerc7zpqxHrDbkuyiZ0QTBN4JEgZNGARS7YAStb
        KW1pVQ/D6t5O89+wLk5RKa8seAf//DSlRPnIlqwL6KPjevjR
X-Google-Smtp-Source: ANB0VdbofEkmqgn5dCwaOMkIvDq33SK6QGnmpvYiTQDNCvg41syl1Y8nhLZ1Pwym0JYXfj72TXmIAnnZx/YVZHvyq8xlfLqKWQLZ
MIME-Version: 1.0
X-Received: by 2002:a24:7d03:: with SMTP id b3-v6mr1402390itc.52.1535643062308;
 Thu, 30 Aug 2018 08:31:02 -0700 (PDT)
Date:   Thu, 30 Aug 2018 08:31:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003b1c360574a8c31e@google.com>
Subject: WARNING in handle_irq (3)
From:   syzbot <syzbot+a58b558e3e62d0604e5c@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, hpa@zytor.com,
        kstewart@linuxfoundation.org, linux-kernel@vger.kernel.org,
        luto@kernel.org, mingo@redhat.com, nstange@suse.de,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    58c3f14f86c9 Merge tag 'riscv-for-linus-4.19-rc2' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10be176a400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=531a917630d2a492
dashboard link: https://syzkaller.appspot.com/bug?extid=a58b558e3e62d0604e5c
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+a58b558e3e62d0604e5c@syzkaller.appspotmail.com

TCP: request_sock_TCPv6: Possible SYN flooding on port 20002. Sending  
cookies.  Check SNMP counters.
------------[ cut here ]------------
do_IRQ(): syz-executor5 has overflown the kernel stack  
(cur:ffff88018aec0000,sp:ffff88018aeb0e18,irq stk  
top-bottom:ffff8801db000080-ffff8801db008000,exception stk  
top-bottom:fffffe0000007080-fffffe0000011000,ip:lock_is_held_type+0x18b/0x210)
WARNING: CPU: 0 PID: 13805 at arch/x86/kernel/irq_64.c:64  
stack_overflow_check arch/x86/kernel/irq_64.c:61 [inline]
WARNING: CPU: 0 PID: 13805 at arch/x86/kernel/irq_64.c:64  
handle_irq+0x1fb/0x2e7 arch/x86/kernel/irq_64.c:73
Kernel panic - not syncing: panic_on_warn set ...

CPU: 0 PID: 13805 Comm: syz-executor5 Not tainted 4.19.0-rc1+ #215
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  <IRQ>
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
  panic+0x238/0x4e7 kernel/panic.c:184
  __warn.cold.8+0x163/0x1ba kernel/panic.c:536
  report_bug+0x252/0x2d0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:178 [inline]
  do_error_trap+0x1fc/0x4d0 arch/x86/kernel/traps.c:296
  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:316
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:993
RIP: 0010:stack_overflow_check arch/x86/kernel/irq_64.c:61 [inline]
RIP: 0010:handle_irq+0x1fb/0x2e7 arch/x86/kernel/irq_64.c:73
Code: 00 00 ff b6 80 00 00 00 48 c7 c7 80 ca 24 87 41 54 41 55 65 48 8b 04  
25 40 ee 01 00 48 05 68 06 00 00 48 89 c6 e8 95 c4 1c 00 <0f> 0b 48 83 c4  
18 e9 3f ff ff ff 48 89 75 e0 e8 c1 fe 90 00 48 8b
RSP: 0018:ffff8801db007f58 EFLAGS: 00010082
RAX: 0000000000000000 RBX: ffff8801cee0ad80 RCX: 0000000000000000
RDX: 0000000000010000 RSI: ffffffff8163ac01 RDI: 0000000000000001
RBP: ffff8801db007fb0 R08: ffff8801c9b4a700 R09: ffffed003b603eca
R10: ffffed003b603eca R11: ffff8801db01f657 R12: fffffe0000011000
R13: fffffe0000007080 R14: 000000000000002a R15: 0000000000000000
  do_IRQ+0x80/0x1a0 arch/x86/kernel/irq.c:246
  common_interrupt+0xf/0xf arch/x86/entry/entry_64.S:643
  </IRQ>
Dumping ftrace buffer:
    (ftrace buffer empty)
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
