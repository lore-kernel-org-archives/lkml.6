Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C8CFC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 07:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62F09213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 07:41:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62F09213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727597AbeGLHtX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 03:49:23 -0400
Received: from mail-io0-f197.google.com ([209.85.223.197]:41021 "EHLO
        mail-io0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbeGLHtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 03:49:23 -0400
Received: by mail-io0-f197.google.com with SMTP id p12-v6so10221388iog.8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 00:41:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=o2Fi+905MR47TFzgNqSjfUgtq/Pa9v6HCk5SkTNY+zo=;
        b=PpHcJ9lhY4odmwgeGkwgcjkRp6qEQUGHDR7VzMgE34cKl/RGfkQbWCiVmjKSLWlpeN
         7H77Pmxen7UusAJYcL42kN0tiR+dp0ovnN1M4TMIAtD4MiCkdDdEft8fBmQot+SFjw/V
         tbcnc9PrqCTrHsd0zDsmB1qUtftASmSfo2Q4rfXg4AkPaxl3tJeYVUGWxbvXJowjQ9wd
         cvRGFdeG3sIlOBrIkdg1cbyP05eu0XmY+zTof1lXLccHlb7ltH/e2hKs8X0AGnZRLVe+
         oT+wEO54opvEJuaLlNAPK1S1XiuUgBXXE+35+yCPsrnAgnYrbjdIr3I+pefaMD0ejYhu
         QMIw==
X-Gm-Message-State: AOUpUlH3nkLx2/2Hprs3BkIYqETrlE688IFm3FEfms1n9KAG/seNpX8a
        iVPRHFxvmgTvqPtiKFE8TpMzgw5Mq6r0jLq/1x5Bvd5Grzg1
X-Google-Smtp-Source: AAOMgpdyVxBV5N+oCTwcGWuxoO3FGhj5js5+Zz0AXBV/sfJ3YlhEAShrvtw2NRLdWj0mu1HaS2TwtbPL/+WlO3atYyQMnq1BXJwW
MIME-Version: 1.0
X-Received: by 2002:a6b:87c1:: with SMTP id r62-v6mr453488ioi.116.1531381262184;
 Thu, 12 Jul 2018 00:41:02 -0700 (PDT)
Date:   Thu, 12 Jul 2018 00:41:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000025f8880570c87c51@google.com>
Subject: WARNING in bpf_check
From:   syzbot <syzbot+7d427828b2ea6e592804@syzkaller.appspotmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    671dffa7de7b Merge branch 'bpf-bpftool-improved-prog-load'
git tree:       bpf-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1550b562400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a501a01deaf0fe9
dashboard link: https://syzkaller.appspot.com/bug?extid=7d427828b2ea6e592804
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+7d427828b2ea6e592804@syzkaller.appspotmail.com

RBP: 000000000072bea0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000013
R13: 00000000004bbbc2 R14: 00000000004c8e28 R15: 0000000000000037
------------[ cut here ]------------
verifier bug. No program starts at insn 3
WARNING: CPU: 0 PID: 12586 at kernel/bpf/verifier.c:1613  
get_callee_stack_depth kernel/bpf/verifier.c:1612 [inline]
WARNING: CPU: 0 PID: 12586 at kernel/bpf/verifier.c:1613 fixup_call_args  
kernel/bpf/verifier.c:5587 [inline]
WARNING: CPU: 0 PID: 12586 at kernel/bpf/verifier.c:1613  
bpf_check+0x5239/0x5e60 kernel/bpf/verifier.c:5952
Kernel panic - not syncing: panic_on_warn set ...

CPU: 0 PID: 12586 Comm: syz-executor0 Not tainted 4.18.0-rc3+ #49
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
RIP: 0010:get_callee_stack_depth kernel/bpf/verifier.c:1612 [inline]
RIP: 0010:fixup_call_args kernel/bpf/verifier.c:5587 [inline]
RIP: 0010:bpf_check+0x5239/0x5e60 kernel/bpf/verifier.c:5952
Code: ff 48 89 df e8 28 08 2e 00 e9 d8 d7 ff ff e8 6e 2f f0 ff 8b 74 24 58  
48 c7 c7 20 8d ef 87 c6 05 d5 f1 0d 08 01 e8 37 52 bb ff <0f> 0b 48 8b 54  
24 08 b8 ff ff 37 00 48 c1 e0 2a 48 c1 ea 03 0f b6
RSP: 0018:ffff88019745f980 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffc90003eec000
RDX: 0000000000040000 RSI: ffffffff81631851 RDI: ffff88019745f658
RBP: ffff88019745fb30 R08: ffff880197666100 R09: fffffbfff11f1220
R10: fffffbfff11f1220 R11: ffffffff88f89103 R12: dffffc0000000000
R13: ffffc90001ace040 R14: 00000000fffffffe R15: ffff8801b0b7e800
  bpf_prog_load+0x1141/0x1c90 kernel/bpf/syscall.c:1352
  __do_sys_bpf kernel/bpf/syscall.c:2305 [inline]
  __se_sys_bpf kernel/bpf/syscall.c:2267 [inline]
  __x64_sys_bpf+0x36c/0x510 kernel/bpf/syscall.c:2267
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x455e29
Code: 1d ba fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 eb b9 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f28af3e8c68 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007f28af3e96d4 RCX: 0000000000455e29
RDX: 0000000000000048 RSI: 0000000020000000 RDI: 0000000000000005
RBP: 000000000072bea0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000013
R13: 00000000004bbbc2 R14: 00000000004c8e28 R15: 0000000000000037
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
