Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED61C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 15:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FAFF2081F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 15:37:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FAFF2081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728118AbeKCAoc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 20:44:32 -0400
Received: from mail-it1-f199.google.com ([209.85.166.199]:37784 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727277AbeKCAoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 20:44:32 -0400
Received: by mail-it1-f199.google.com with SMTP id m8-v6so3129169iti.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 08:37:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=B/wb0dHFfjKo5LSAD3HOGL2Y5Fj/Rl8KsnjRBrgcF68=;
        b=WVx8P7gqEedbutWMWn2lltPapHcOqRJukTqi0J1d+V4UwRf7dUC+uDsIyplxqa4ICy
         YZBkhuD3oBm8b0lyDfE8znamiNm/YP/wHPCpvgiWqZbSPAUkECQXZr4ay/Ct0LzgZRvW
         TgmjGgYcjbvnCxrYAIlzfPcdDnOtVUyzSw8cqes5EZy3MyUR6aDolQ3W15JX7IBywPPZ
         WecrG/mNmtqCRlJhZTIzHtLQy7CfD/kBZ5cl+S9EfJ7Q8r+yw2Yo/Xbtd5MfXgSNTLzf
         jXORIEUmcpG4Ml3CyftorKd+uwjR0nbXM4tSq1DdHwfvyATLjHT55Jnusx/w3zlbl7FI
         wxTg==
X-Gm-Message-State: AGRZ1gIs1t+L0OPyyC/wMazgjAH0DZXh71F5nVKLqXsO0HsmrYhL66LC
        NNlsIYlogQbfPIYfXWVvNf8v5WWkDQ01BmCR/Z3K21eDOLyP
X-Google-Smtp-Source: AJdET5fkXsJzK5dwYJtJfajxkc0/mq9y4xr7xHZyTpdvWaQesxEJNXu/4Tgt6q/5pKNHPkBdzyutACJgix2To0oouv8Q14LM90Od
MIME-Version: 1.0
X-Received: by 2002:a6b:e00c:: with SMTP id z12-v6mr9054670iog.32.1541173023686;
 Fri, 02 Nov 2018 08:37:03 -0700 (PDT)
Date:   Fri, 02 Nov 2018 08:37:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009d4c780579b04ee4@google.com>
Subject: WARNING in kmem_cache_create_usercopy
From:   syzbot <syzbot+0c1d61e4db7db94102ca@syzkaller.appspotmail.com>
To:     asmadeus@codewreck.org, davem@davemloft.net, ericvh@gmail.com,
        linux-kernel@vger.kernel.org, lucho@ionkov.net,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        v9fs-developer@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    4794a36bf08d Add linux-next specific files for 20180928
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=124f814e400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b0ba9bb377f8ae91
dashboard link: https://syzkaller.appspot.com/bug?extid=0c1d61e4db7db94102ca
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1511532a400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1701f831400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+0c1d61e4db7db94102ca@syzkaller.appspotmail.com

WARNING: CPU: 0 PID: 6065 at mm/slab_common.c:473  
kmem_cache_create_usercopy+0xad/0x240 mm/slab_common.c:473
Kernel panic - not syncing: panic_on_warn set ...

CPU: 0 PID: 6065 Comm: syz-executor140 Not tainted  
4.19.0-rc5-next-20180928+ #84
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1d3/0x2c4 lib/dump_stack.c:113
  panic+0x238/0x4e7 kernel/panic.c:184
  __warn.cold.8+0x163/0x1ba kernel/panic.c:536
  report_bug+0x254/0x2d0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:178 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:271
  do_invalid_op+0x36/0x40 arch/x86/kernel/traps.c:290
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:969
RIP: 0010:kmem_cache_create_usercopy+0xad/0x240 mm/slab_common.c:473
Code: 44 89 f0 25 00 60 de 04 45 85 ed 89 45 cc 75 0b 8b 45 d0 85 c0 0f 85  
8e 01 00 00 44 39 eb 72 0a 89 d8 44 29 e8 3b 45 d0 73 7e <0f> 0b c7 45 d0  
00 00 00 00 4c 8b 45 10 44 89 fa 89 de 4c 89 e7 8b
RSP: 0018:ffff8801bc23f5d0 EFLAGS: 00010213
RAX: 0000000000000000 RBX: 0000000000000008 RCX: 0000000000000006
RDX: 0000000000000000 RSI: 0000000000000020 RDI: ffffffff88b04b20
RBP: ffff8801bc23f608 R08: fffffbfff1283a2d R09: fffffbfff1283a2c
R10: ffff8801bc23f5c0 R11: ffffffff8941d167 R12: ffffffff88b04b20
R13: 00000000fffffffd R14: 0000000000000000 R15: 0000000000000000
  p9_client_create+0xa58/0x1769 net/9p/client.c:1054
  v9fs_session_init+0x217/0x1bb0 fs/9p/v9fs.c:421
  v9fs_mount+0x7c/0x8f0 fs/9p/vfs_super.c:135
  legacy_get_tree+0x131/0x460 fs/fs_context.c:718
  vfs_get_tree+0x1cb/0x5c0 fs/super.c:1795
  do_new_mount fs/namespace.c:2648 [inline]
  do_mount+0x70c/0x1d90 fs/namespace.c:2974
  ksys_mount+0x12d/0x140 fs/namespace.c:3190
  __do_sys_mount fs/namespace.c:3204 [inline]
  __se_sys_mount fs/namespace.c:3201 [inline]
  __x64_sys_mount+0xbe/0x150 fs/namespace.c:3201
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x440189
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 fb 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffdd30ec3c8 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0030656c69662f2e RCX: 0000000000440189
RDX: 00000000200008c0 RSI: 0000000020000000 RDI: 0000000000000000
RBP: 00000000006ca018 R08: 0000000020000a80 R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000401a10
R13: 0000000000401aa0 R14: 0000000000000000 R15: 0000000000000000
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
