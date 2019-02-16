Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD6EC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 07:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 749D8222D0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 07:01:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729178AbfBPHBd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 02:01:33 -0500
Received: from mail-it1-f198.google.com ([209.85.166.198]:43167 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727727AbfBPHBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 02:01:07 -0500
Received: by mail-it1-f198.google.com with SMTP id i186so19226017ite.8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 23:01:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=iqMqjLkoJjLNAEUc1ICGprdIsoHZwGwSEsogoXc6C4w=;
        b=TjKRvRO+kJNJiFUKAB7qiVNsE3DNHtJMDUgjVpGo6oNYDkB1hhG0hYbL0k2aAAOw+X
         P9CbECHXR0gKDdqO6PRQyBZwFKtBp3kffBy6KQQT7rsZStKpzVw77h0u8HuRhVkh4gga
         bIcrgNRJ3lnBzKfDtG/tDBDv+qWF7jt3owSAUkJptGf8QYs3Mnkc6eg2xYFyvnJ3yai/
         xgVcXl8ujk0IKiSXBXppRhW3hns8tdo9pCEN9GrVe4H6yyZaeCvLyuauxcflONqWf1Fb
         tv5+hWNC31uC40hC8Pclli2kv2m6tnAjceb2bX0Mo2ZaBW9AarZHGjwVrqXUKu4LXaF+
         vnxQ==
X-Gm-Message-State: AHQUAuZkpPCZyjq+hrVHWtF6jHIufkhvu9gmUHuMhHWanASYrScdoi/1
        WEdEwEqgC0GxttWekN3D7JE309J/PjdVzuS0ZbFeefWp8qir
X-Google-Smtp-Source: AHgI3IbIf61Ce1OF0GkJjpKmYW7x/aGx5FUMzNDO1IK6bKMNbtu3LN4iDpU4N/1DXTpf5YRMDdwCmxqhyjz4h4lnP7UbR+sBNXS9
MIME-Version: 1.0
X-Received: by 2002:a24:d82:: with SMTP id 124mr7762029itx.10.1550300466018;
 Fri, 15 Feb 2019 23:01:06 -0800 (PST)
Date:   Fri, 15 Feb 2019 23:01:06 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000092839d0581fd74ad@google.com>
Subject: WARNING in __vunmap
From:   syzbot <syzbot+5ec9bb042ddfe9644773@syzkaller.appspotmail.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        steffen.klassert@secunet.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    a048a07d7f45 powerpc/64s: Add support for a store forwardi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1418d5a7800000
kernel config:  https://syzkaller.appspot.com/x/.config?x=982e2df1b9e60b02
dashboard link: https://syzkaller.appspot.com/bug?extid=5ec9bb042ddfe9644773
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+5ec9bb042ddfe9644773@syzkaller.appspotmail.com

------------[ cut here ]------------
Trying to vfree() nonexistent vm area (0000000094b55709)
WARNING: CPU: 1 PID: 8605 at mm/vmalloc.c:1525 __vunmap+0x324/0x3c0  
mm/vmalloc.c:1524
Kernel panic - not syncing: panic_on_warn set ...

CPU: 1 PID: 8605 Comm: syz-executor7 Not tainted 4.17.0-rc6+ #63
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
  panic+0x22f/0x4de kernel/panic.c:184
  __warn.cold.8+0x163/0x1b3 kernel/panic.c:536
  report_bug+0x252/0x2d0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:178 [inline]
  do_error_trap+0x1de/0x490 arch/x86/kernel/traps.c:296
  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:315
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:992
RIP: 0010:__vunmap+0x324/0x3c0 mm/vmalloc.c:1524
RSP: 0018:ffff88018273f2b0 EFLAGS: 00010286
RAX: 0000000000000038 RBX: 0000000000000000 RCX: ffffc90003ed8000
RDX: 0000000000003b55 RSI: ffffffff81610961 RDI: ffff88018273ee10
RBP: ffff88018273f2f0 R08: ffff8801ab1a0340 R09: 0000000000000006
R10: ffff8801ab1a0340 R11: 0000000000000000 R12: ffffc90014122000
R13: 0000000000000001 R14: fffffbfff12f7f76 R15: 000060fe24e7fae8
  vfree+0x68/0x100 mm/vmalloc.c:1606
  ipcomp_free_scratches+0xbb/0x150 net/xfrm/xfrm_ipcomp.c:216
  ipcomp_free_data net/xfrm/xfrm_ipcomp.c:325 [inline]
  ipcomp_init_state+0x8cf/0xc00 net/xfrm/xfrm_ipcomp.c:377
  ipcomp4_init_state+0x110/0xb30 net/ipv4/ipcomp.c:137
  __xfrm_init_state+0x60e/0x1030 net/xfrm/xfrm_state.c:2277
  xfrm_init_state+0x1e/0x80 net/xfrm/xfrm_state.c:2303
  pfkey_msg2xfrm_state net/key/af_key.c:1307 [inline]
  pfkey_add+0x1c86/0x2eb0 net/key/af_key.c:1524
  pfkey_process+0x83d/0x980 net/key/af_key.c:2844
  pfkey_sendmsg+0x5f4/0x1050 net/key/af_key.c:3683
  sock_sendmsg_nosec net/socket.c:629 [inline]
  sock_sendmsg+0xd5/0x120 net/socket.c:639
  ___sys_sendmsg+0x805/0x940 net/socket.c:2117
  __sys_sendmsg+0x115/0x270 net/socket.c:2155
  __do_sys_sendmsg net/socket.c:2164 [inline]
  __se_sys_sendmsg net/socket.c:2162 [inline]
  __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2162
  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x455a09
RSP: 002b:00007fe6fd709c68 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fe6fd70a6d4 RCX: 0000000000455a09
RDX: 0000000000000000 RSI: 0000000020f56000 RDI: 0000000000000014
RBP: 000000000072bea0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 000000000000059d R14: 00000000006fc758 R15: 0000000000000000
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
