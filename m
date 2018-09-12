Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38521C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 10:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7C6020866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 10:24:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7C6020866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727746AbeILP14 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 11:27:56 -0400
Received: from mail-io0-f200.google.com ([209.85.223.200]:49765 "EHLO
        mail-io0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726782AbeILP14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 11:27:56 -0400
Received: by mail-io0-f200.google.com with SMTP id k9-v6so1304309iob.16
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 03:24:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=5d6b41EEhWzHCgy1NQANctfz8TQS9WVztPuDbOPPY90=;
        b=aHG/aYStDIL05DUXDVwbq0xlIPs5ZAQ3yjVCHvDYzZUKWnE2L8tikiHQqD0Q5HweX3
         d1hN3XJErG7fZbrinMISlz/D26CKmyH/i6PlXktmjFYV+aSljERPc4AeWbpb8hGqUKOS
         op2ASp7qXS3X62VE3rTHQj983kET40/LS3XmQyhCXT7RFOPGZBlT+b7xUNLJWQSh9bjU
         Rw9/eJmgS9rAAWjoW8t2yEzm4y1S224yac0885Omo50z3pYznZprxW2bpuvV3ohRhVfV
         tfbhWuET7uhfm7JlczRUjo0NFgu7O6LxUIp4njcKfhOSDjToLG/wisj/apZd2WpacPb6
         ue2A==
X-Gm-Message-State: APzg51CYuRGK1i5Kv94nDfdVX6AK4EUjPp6zZDJcV3CH0X8FZdV2SATp
        JIZo4SYP1bx2iycPWvCnLVcjYRqFHdwtK+2Wuya3Jt0Hafbd
X-Google-Smtp-Source: ANB0VdZODwZtxeg+9hMHpvDxeyBrMbKS3POwWOqp/IoLqp6znbB7tuBbhJtseVlsD5FcWMr0jkOAJgUVdxfeI8+J9/kC8JoI0Fcx
MIME-Version: 1.0
X-Received: by 2002:a6b:3c17:: with SMTP id k23-v6mr704112iob.81.1536747842705;
 Wed, 12 Sep 2018 03:24:02 -0700 (PDT)
Date:   Wed, 12 Sep 2018 03:24:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004624c30575a9fd40@google.com>
Subject: KMSAN: uninit-value in pppoe_rcv
From:   syzbot <syzbot+f5f6080811c849739212@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, mostrows@earthlink.net,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    d2d741e5d189 kmsan: add initialization for shmem pages
git tree:       https://github.com/google/kmsan.git/master
console output: https://syzkaller.appspot.com/x/log.txt?x=1465fc37800000
kernel config:  https://syzkaller.appspot.com/x/.config?x=48f9de3384bcd0f
dashboard link: https://syzkaller.appspot.com/bug?extid=f5f6080811c849739212
compiler:       clang version 7.0.0 (trunk 329391)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14d6e607800000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10a15b5b800000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+f5f6080811c849739212@syzkaller.appspotmail.com

IPVS: ftp: loaded support on port[0] = 21
==================================================================
BUG: KMSAN: uninit-value in __get_item drivers/net/ppp/pppoe.c:172 [inline]
BUG: KMSAN: uninit-value in get_item drivers/net/ppp/pppoe.c:236 [inline]
BUG: KMSAN: uninit-value in pppoe_rcv+0xcef/0x10e0  
drivers/net/ppp/pppoe.c:450
CPU: 0 PID: 4543 Comm: syz-executor355 Not tainted 4.16.0+ #87
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:17 [inline]
  dump_stack+0x185/0x1d0 lib/dump_stack.c:53
  kmsan_report+0x142/0x240 mm/kmsan/kmsan.c:1067
  __msan_warning_32+0x6c/0xb0 mm/kmsan/kmsan_instr.c:683
  __get_item drivers/net/ppp/pppoe.c:172 [inline]
  get_item drivers/net/ppp/pppoe.c:236 [inline]
  pppoe_rcv+0xcef/0x10e0 drivers/net/ppp/pppoe.c:450
  __netif_receive_skb_core+0x47df/0x4a90 net/core/dev.c:4562
  __netif_receive_skb net/core/dev.c:4627 [inline]
  netif_receive_skb_internal+0x49d/0x630 net/core/dev.c:4701
  netif_receive_skb+0x230/0x240 net/core/dev.c:4725
  tun_rx_batched drivers/net/tun.c:1555 [inline]
  tun_get_user+0x740f/0x7c60 drivers/net/tun.c:1962
  tun_chr_write_iter+0x1d4/0x330 drivers/net/tun.c:1990
  call_write_iter include/linux/fs.h:1782 [inline]
  new_sync_write fs/read_write.c:469 [inline]
  __vfs_write+0x7fb/0x9f0 fs/read_write.c:482
  vfs_write+0x463/0x8d0 fs/read_write.c:544
  SYSC_write+0x172/0x360 fs/read_write.c:589
  SyS_write+0x55/0x80 fs/read_write.c:581
  do_syscall_64+0x309/0x430 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
RIP: 0033:0x4447c9
RSP: 002b:00007fff64c8fc28 EFLAGS: 00000297 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00000000004447c9
RDX: 000000000000fd87 RSI: 0000000020000600 RDI: 0000000000000004
RBP: 00000000006cf018 R08: 00007fff64c8fda8 R09: 00007fff00006bda
R10: 0000000000005fe7 R11: 0000000000000297 R12: 00000000004020d0
R13: 0000000000402160 R14: 0000000000000000 R15: 0000000000000000

Uninit was created at:
  kmsan_save_stack_with_flags mm/kmsan/kmsan.c:278 [inline]
  kmsan_internal_poison_shadow+0xb8/0x1b0 mm/kmsan/kmsan.c:188
  kmsan_kmalloc+0x94/0x100 mm/kmsan/kmsan.c:314
  kmsan_slab_alloc+0x11/0x20 mm/kmsan/kmsan.c:321
  slab_post_alloc_hook mm/slab.h:445 [inline]
  slab_alloc_node mm/slub.c:2737 [inline]
  __kmalloc_node_track_caller+0xaed/0x11c0 mm/slub.c:4369
  __kmalloc_reserve net/core/skbuff.c:138 [inline]
  __alloc_skb+0x2cf/0x9f0 net/core/skbuff.c:206
  alloc_skb include/linux/skbuff.h:984 [inline]
  alloc_skb_with_frags+0x1d4/0xb20 net/core/skbuff.c:5234
  sock_alloc_send_pskb+0xb56/0x1190 net/core/sock.c:2085
  tun_alloc_skb drivers/net/tun.c:1532 [inline]
  tun_get_user+0x2242/0x7c60 drivers/net/tun.c:1829
  tun_chr_write_iter+0x1d4/0x330 drivers/net/tun.c:1990
  call_write_iter include/linux/fs.h:1782 [inline]
  new_sync_write fs/read_write.c:469 [inline]
  __vfs_write+0x7fb/0x9f0 fs/read_write.c:482
  vfs_write+0x463/0x8d0 fs/read_write.c:544
  SYSC_write+0x172/0x360 fs/read_write.c:589
  SyS_write+0x55/0x80 fs/read_write.c:581
  do_syscall_64+0x309/0x430 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
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
