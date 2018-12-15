Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB8D5C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 18:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F9A42084D
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 18:43:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbeLOSnF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 13:43:05 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:51824 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbeLOSnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 13:43:05 -0500
Received: by mail-io1-f71.google.com with SMTP id h6so7796822ioq.18
        for <linux-kernel@vger.kernel.org>; Sat, 15 Dec 2018 10:43:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=GSxp26CwHguU++n7uWPFJxMxTbWpXBDsuInFpbVm4a4=;
        b=LSPQLhsMAtz/6arCPkcUYQRs8A9izEyrNUPUUc0W/q4pYKqdh7/TlQ3eMs1iaz8+ch
         GK6PThSh6RClbv7fxRk1WaVbsOMwX/qnLQWDLLBfH6KkjiLjfBC224AgGWIlCSsk6U5U
         0AVZKnSYEPAHPHE64LjwVvEBvF09hwRJN9Xo1qG9b+xlk+w4frMFxifWc4+2kHBVJu7y
         ypAxA1v2mEvZDZVJWUqkCYHVvD8h/0gqNldTTe/UMRZqUJJjR1OrAE1ajV1ZwbVslJ+x
         pGKwe0UXSz+nVyc4lRRSAOqB5R07gKbyztxafmZJX8B4COzoABvoFxtXEY8j8LDvNhsK
         yiKQ==
X-Gm-Message-State: AA+aEWbkgEFNrO9OvFOL3ZnVGBEUbGyzarz3txA42VGrr4ptUH4gRZ5i
        jNRN8dKCmiddc/KgZXiJa9ARrthQao8xn2pVYaFvieZQlqQt
X-Google-Smtp-Source: AFSGD/XIUcXYgL5+d27yrmhI1UIo1yNlDM/uZUpppVNZMmF3fSGRXeCwzEVtwdvXUW+uAWG2XBmdLnyLyR5+1QgjkOZLyChGNS+z
MIME-Version: 1.0
X-Received: by 2002:a5e:c206:: with SMTP id v6mr6404745iop.1.1544899383729;
 Sat, 15 Dec 2018 10:43:03 -0800 (PST)
Date:   Sat, 15 Dec 2018 10:43:03 -0800
In-Reply-To: <00000000000085c1ce05708f6724@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fb268d057d13ea55@google.com>
Subject: Re: BUG: sleeping function called from invalid context at
 mm/slab.h:LINE (4)
From:   syzbot <syzbot+9bf843c33f782d73ae7d@syzkaller.appspotmail.com>
To:     davem@davemloft.net, gregkh@linuxfoundation.org,
        herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, rafael@kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    d14b746c6c1c Add linux-next specific files for 20181214
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=129bc943400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1da6d2d18f803140
dashboard link: https://syzkaller.appspot.com/bug?extid=9bf843c33f782d73ae7d
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=136154cd400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1687bfa3400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+9bf843c33f782d73ae7d@syzkaller.appspotmail.com

sshd (6035) used greatest stack depth: 15600 bytes left
BUG: sleeping function called from invalid context at mm/slab.h:421
in_atomic(): 1, irqs_disabled(): 0, pid: 6051, name: syz-executor515
1 lock held by syz-executor515/6051:
  #0: 000000002f6552ef (sk_lock-AF_ALG){+.+.}, at: lock_sock  
include/net/sock.h:1502 [inline]
  #0: 000000002f6552ef (sk_lock-AF_ALG){+.+.}, at:  
skcipher_recvmsg+0xbb/0x1420 crypto/algif_skcipher.c:163
Preemption disabled at:
[<ffffffff812e4ae6>] kernel_fpu_begin+0x16/0x260  
arch/x86/kernel/fpu/core.c:127
CPU: 0 PID: 6051 Comm: syz-executor515 Not tainted  
4.20.0-rc6-next-20181214+ #171
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x39d lib/dump_stack.c:113
  ___might_sleep.cold.86+0x221/0x254 kernel/sched/core.c:6148
  __might_sleep+0x95/0x190 kernel/sched/core.c:6101
  slab_pre_alloc_hook mm/slab.h:421 [inline]
  slab_alloc mm/slab.c:3365 [inline]
  __do_kmalloc mm/slab.c:3707 [inline]
  __kmalloc+0x2da/0x760 mm/slab.c:3718
  kmalloc include/linux/slab.h:550 [inline]
  kzalloc include/linux/slab.h:740 [inline]
  skcipher_next_slow crypto/skcipher.c:254 [inline]
  skcipher_walk_next+0x7f9/0x17f0 crypto/skcipher.c:358
  skcipher_walk_first+0xff/0x3a0 crypto/skcipher.c:441
  skcipher_walk_skcipher+0x541/0x700 crypto/skcipher.c:469
  skcipher_walk_virt+0x58/0xd0 crypto/skcipher.c:479
  chacha_simd_stream_xor+0xb3/0xa40 arch/x86/crypto/chacha_glue.c:141
  chacha_simd+0xd8/0x110 arch/x86/crypto/chacha_glue.c:179
  crypto_skcipher_decrypt include/crypto/skcipher.h:538 [inline]
  _skcipher_recvmsg crypto/algif_skcipher.c:146 [inline]
  skcipher_recvmsg+0xcc9/0x1420 crypto/algif_skcipher.c:165
  sock_recvmsg_nosec net/socket.c:795 [inline]
  sock_recvmsg+0xd0/0x110 net/socket.c:802
  ___sys_recvmsg+0x2b6/0x680 net/socket.c:2279
  do_recvmmsg+0x303/0xb90 net/socket.c:2392
  __sys_recvmmsg+0x265/0x2a0 net/socket.c:2471
  __do_sys_recvmmsg net/socket.c:2494 [inline]
  __se_sys_recvmmsg net/socket.c:2487 [inline]
  __x64_sys_recvmmsg+0xe6/0x140 net/socket.c:2487
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x440349
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 fb 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fff9312c608 EFLAGS: 00000203 ORIG_RAX: 000000000000012b
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 0000000000440349
RDX: 0000000000000001 RSI: 000000002000a280 RDI: 0000000000000004
RBP: 00000000006ca018 R08: 0000000000000000 R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000203 R12: 00000000

