Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4173BC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 14:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 057962176D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 14:59:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 057962176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389606AbeHGRNp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 13:13:45 -0400
Received: from mail-io0-f199.google.com ([209.85.223.199]:35461 "EHLO
        mail-io0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387617AbeHGRNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 13:13:45 -0400
Received: by mail-io0-f199.google.com with SMTP id y4-v6so12471073iol.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 07:59:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=RHOTvCZ57pBHBMy2w0V/ZRQ0BdV1VBTgzeTe6GfTPAw=;
        b=WC8DLDAJRugLvAlm2EGgoECGn53PtbFKEzjwYXcu6bTvLOzU8LvWxFnl0JAntv00xD
         i+DnwKm9tB3PgANZYc2tj0cNNHYI7nyOYO/X5nRcIfBa2dF0iaLGSVJU+JV0dM+c5phY
         pRzXM80dOVZYRZECjGWlxM8QNCXCRxSx9f8D0TzCw0qpzqwnC4YrB2rT56PCXwpgezIP
         IeocPI0QJb+x16s9bORj8ZSOP3Cb3buqpu1M5jwuZ1HPapcYw6yjAS88QwWfi8DaXB2r
         B1Xp5JZIiGFfhuyPp/8xZnu+uaX0YwTBhCa2juqlXptATG4RYuAmdLUPhDiIX2oGk3Cq
         YS/w==
X-Gm-Message-State: AOUpUlHvv2UiPIFpB+oH/Y3E/W+Hl+ZpOl5L5Uc6TC6Hu1ytmZBr4jjf
        ClfsbL2oROF35dASxrrxQBlCDgKtlAEpL+NOu2HP0ruwzHdP
X-Google-Smtp-Source: AA+uWPwFMBwWfpxp0U5+3U4v/NVxXQTvhGahzNbD1N8LqGLR8GrM/iMb/AEXuzIDbdFzf5wJ8eOD1nDEiWWl8WWXMAC1VOVhEdGk
MIME-Version: 1.0
X-Received: by 2002:a24:6b54:: with SMTP id v81-v6mr6968206itc.13.1533653942020;
 Tue, 07 Aug 2018 07:59:02 -0700 (PDT)
Date:   Tue, 07 Aug 2018 07:59:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006c37170572d9a2c0@google.com>
Subject: WARNING: refcount bug in llc_sap_find
From:   syzbot <syzbot+278893f3f7803871f7ce@syzkaller.appspotmail.com>
To:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    0585df468e8f Merge tag 'media/v4.18-3' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15927272400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2dc0cd7c2eefb46f
dashboard link: https://syzkaller.appspot.com/bug?extid=278893f3f7803871f7ce
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=1064ef78400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17d0fa8c400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+278893f3f7803871f7ce@syzkaller.appspotmail.com

------------[ cut here ]------------
refcount_t: increment on 0; use-after-free.
WARNING: CPU: 0 PID: 25217 at lib/refcount.c:153 refcount_inc+0x5d/0x70  
lib/refcount.c:153
Kernel panic - not syncing: panic_on_warn set ...

CPU: 0 PID: 25217 Comm: syz-executor271 Not tainted 4.18.0-rc7+ #175
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
  panic+0x238/0x4e7 kernel/panic.c:184
  __warn.cold.8+0x163/0x1ba kernel/panic.c:536
  report_bug+0x252/0x2d0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:178 [inline]
  do_error_trap+0x1fc/0x4d0 arch/x86/kernel/traps.c:296
  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:316
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:992
RIP: 0010:refcount_inc+0x5d/0x70 lib/refcount.c:153
Code: 1d 9c ef 25 05 31 ff 89 de e8 6f b0 1c fe 84 db 75 df e8 96 af 1c fe  
48 c7 c7 40 4b 3a 87 c6 05 7c ef 25 05 01 e8 93 c8 e7 fd <0f> 0b eb c3 0f  
1f 44 00 00 66 2e 0f 1f 84 00 00 00 00 00 55 48 89
RSP: 0018:ffff8801d6cd7af8 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff81632481 RDI: ffff8801d6cd77d0
RBP: ffff8801d6cd7b00 R08: ffff8801bfbf65c0 R09: 0000000000000002
R10: ffff8801bfbf65c0 R11: 0000000000000000 R12: 00000000000000ff
R13: dffffc0000000000 R14: 00000000000000ff R15: ffff8801d6cd7d17
  llc_sap_hold include/net/llc.h:116 [inline]
  llc_sap_find+0x1ec/0x2a0 net/llc/llc_core.c:77
  llc_ui_bind+0x6c7/0xf10 net/llc/af_llc.c:362
  __sys_bind+0x331/0x440 net/socket.c:1493
  __do_sys_bind net/socket.c:1504 [inline]
  __se_sys_bind net/socket.c:1502 [inline]
  __x64_sys_bind+0x73/0xb0 net/socket.c:1502
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x445ca9
Code: e8 ac e7 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 fb 0d fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ff435ebcdb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000031
RAX: ffffffffffffffda RBX: 00000000006dac28 RCX: 0000000000445ca9
RDX: 0000000000000010 RSI: 00000000200000c0 RDI: 0000000000000003
RBP: 00000000006dac20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dac2c
R13: 00007ffe0636e23f R14: 00007ff435ebd9c0 R15: 00000000006dac20
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
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
