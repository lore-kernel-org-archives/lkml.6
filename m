Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A3CC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69ADE204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:30:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69ADE204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbeIJNW6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 09:22:58 -0400
Received: from mail-it0-f72.google.com ([209.85.214.72]:36681 "EHLO
        mail-it0-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727614AbeIJNW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 09:22:57 -0400
Received: by mail-it0-f72.google.com with SMTP id m185-v6so37857983itm.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 01:30:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=MrlPnA5nqFE/g1pS3FrNVwbgt7Q8iNUxKVuX+RETVIM=;
        b=JSaOz4iQxTKWCldySIU38H73NHBCPqLGwIrIhzPb5kPto/30sKbPd5bYgK/ZBaW9HX
         fhWCoSbfSqB5Kup+27GiYKP/WlkvA6AGcS9p6/tez/qutX2a22kuFENHAhbRvZCnI1Zb
         ZxFWqmvcaRwNXWJNRFmswnpp3oe5qC1f0jshG9gP+oCGyhzuFBA6/vPJr8PiARAI/RWj
         PRb3Urk8VtARMv8uc8dss15an/cdG6XUPYbdLf87TGXoSsF2kkSsWCcm6NFXB1uI2wNI
         aiSj/IctZlnpubJna5wmGNzhYZ+NqIpNd+1CmwuLnjkEHFhKf/VGYTvZhjf5qfJx1U0l
         b29g==
X-Gm-Message-State: APzg51Cuoc9L37o8DSeDGxfk+ggYq7K0v5z+9AJVhl4EuSPZN4v7ovIQ
        UAI5mPvJawqQcquqfwK70SBCDmWA7btxxPNSjnB4RLBqSrfB
X-Google-Smtp-Source: ANB0VdZkvQe+LvMo5kcllFVVPK1MktHoG0DWYOOBI4tZrMIQdnmVJ5QxnJSoPl49NOgig+1ga4zsPLKT8kyG9m1GjximH8TzI67y
MIME-Version: 1.0
X-Received: by 2002:a02:1b55:: with SMTP id l82-v6mr16582235jad.2.1536568202947;
 Mon, 10 Sep 2018 01:30:02 -0700 (PDT)
Date:   Mon, 10 Sep 2018 01:30:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e9037e057580294c@google.com>
Subject: KASAN: use-after-free Write in rb_erase
From:   syzbot <syzbot+83e25da873f2a81c5e3c@syzkaller.appspotmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    7a8c7f5c30f9 net: dsa: b53: Fix build with B53_SRAB enable..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17b19e49400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f59875069d721b6
dashboard link: https://syzkaller.appspot.com/bug?extid=83e25da873f2a81c5e3c
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+83e25da873f2a81c5e3c@syzkaller.appspotmail.com

syz-executor4 (7549) used greatest stack depth: 16104 bytes left
==================================================================
BUG: KASAN: use-after-free in __rb_erase_augmented  
include/linux/rbtree_augmented.h:188 [inline]
BUG: KASAN: use-after-free in rb_erase+0x26d0/0x3710 lib/rbtree.c:459
Write of size 8 at addr ffff8801c2a5aaf0 by task syz-executor5/7453

CPU: 1 PID: 7453 Comm: syz-executor5 Not tainted 4.19.0-rc2+ #209
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c4/0x2b4 lib/dump_stack.c:113
  print_address_description.cold.8+0x9/0x1ff mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.9+0x242/0x309 mm/kasan/report.c:412
  __asan_report_store8_noabort+0x17/0x20 mm/kasan/report.c:438
  __rb_erase_augmented include/linux/rbtree_augmented.h:188 [inline]
  rb_erase+0x26d0/0x3710 lib/rbtree.c:459
  __lt_erase include/linux/rbtree_latch.h:102 [inline]
  latch_tree_erase include/linux/rbtree_latch.h:176 [inline]
  bpf_prog_ksym_node_del kernel/bpf/core.c:466 [inline]
  bpf_prog_kallsyms_del+0x1c2/0x410 kernel/bpf/core.c:498
  bpf_prog_kallsyms_del_all+0x1d/0x20 kernel/bpf/core.c:364
  __bpf_prog_put+0xd7/0x150 kernel/bpf/syscall.c:1105
  bpf_prog_put kernel/bpf/syscall.c:1113 [inline]
  bpf_prog_test_run+0x145/0x1a0 kernel/bpf/syscall.c:1754
BUG: unable to handle kernel paging request at ffffc90001930030
PGD 1da948067 P4D 1da948067 PUD 1da949067 PMD 1d49ae067 PTE 0
Oops: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 7453 Comm: syz-executor5 Not tainted 4.19.0-rc2+ #209
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:bpf_prog_ebpf_jited include/linux/filter.h:898 [inline]
RIP: 0010:bpf_get_prog_addr_region kernel/bpf/core.c:381 [inline]
RIP: 0010:bpf_tree_comp kernel/bpf/core.c:435 [inline]
RIP: 0010:__lt_find include/linux/rbtree_latch.h:115 [inline]
RIP: 0010:latch_tree_find include/linux/rbtree_latch.h:208 [inline]
RIP: 0010:bpf_prog_kallsyms_find+0x289/0x4a0 kernel/bpf/core.c:509
Code: 03 42 80 3c 30 00 0f 85 b1 01 00 00 4d 8b 6f 50 49 8d 7d 30 48 89 fa  
48 c1 ea 03 42 80 3c 32 00 0f 85 ab 01 00 00 49 8d 7d 02 <4d> 8b 65 30 48  
89 fa 48 89 f9 48 c1 ea 03 83 e1 07 42 0f b6 14 32
RSP: 0018:ffff88019a066dd0 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffff8801c2a5ab08 RCX: ffffffff818b41d1
RDX: 1ffff92000326006 RSI: 0000000000000008 RDI: ffffc90001930002
RBP: ffff88019a066f48 R08: ffff8801cce982c0 R09: ffffed003b5a4732
R10: ffffed003b5a4732 R11: ffff8801dad23993 R12: 1ffff1003340cddc
R13: ffffc90001930000 R14: dffffc0000000000 R15: ffff8801c2a5aaf0
FS:  00007f524d117700(0000) GS:ffff8801dad00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc90001930030 CR3: 00000001d3889000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
BUG: unable to handle kernel paging request at ffffc90001930030
PGD 1da948067 P4D 1da948067 PUD 1da949067 PMD 1d49ae067 PTE 0
Oops: 0000 [#2] PREEMPT SMP KASAN
CPU: 1 PID: 7453 Comm: syz-executor5 Not tainted 4.19.0-rc2+ #209
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:bpf_prog_ebpf_jited include/linux/filter.h:898 [inline]
RIP: 0010:bpf_get_prog_addr_region kernel/bpf/core.c:381 [inline]
RIP: 0010:bpf_tree_comp kernel/bpf/core.c:435 [inline]
RIP: 0010:__lt_find include/linux/rbtree_latch.h:115 [inline]
RIP: 0010:latch_tree_find include/linux/rbtree_latch.h:208 [inline]
RIP: 0010:bpf_prog_kallsyms_find+0x289/0x4a0 kernel/bpf/core.c:509
Code: 03 42 80 3c 30 00 0f 85 b1 01 00 00 4d 8b 6f 50 49 8d 7d 30 48 89 fa  
48 c1 ea 03 42 80 3c 32 00 0f 85 ab 01 00 00 49 8d 7d 02 <4d> 8b 65 30 48  
89 fa 48 89 f9 48 c1 ea 03 83 e1 07 42 0f b6 14 32
RSP: 0018:ffff88019a066678 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffff8801c2a5ab08 RCX: ffffffff818b41d1
RDX: 1ffff92000326006 RSI: 0000000000000008 RDI: ffffc90001930002
RBP: ffff88019a0667f0 R08: ffff8801cce982c0 R09: 0000000000000001
R10: ffffed003b5a4732 R11: 0000000000000000 R12: 1ffff1003340ccf1
R13: ffffc90001930000 R14: dffffc0000000000 R15: ffff8801c2a5aaf0
FS:  00007f524d117700(0000) GS:ffff8801dad00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc90001930030 CR3: 00000001d3889000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
BUG: unable to handle kernel paging request at ffffc90001930030
PGD 1da948067 P4D 1da948067 PUD 1da949067 PMD 1d49ae067 PTE 0
Oops: 0000 [#3] PREEMPT SMP KASAN
CPU: 1 PID: 7453 Comm: syz-executor5 Not tainted 4.19.0-rc2+ #209
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:bpf_prog_ebpf_jited include/linux/filter.h:898 [inline]
RIP: 0010:bpf_get_prog_addr_region kernel/bpf/core.c:381 [inline]
RIP: 0010:bpf_tree_comp kernel/bpf/core.c:435 [inline]
RIP: 0010:__lt_find include/linux/rbtree_latch.h:115 [inline]
RIP: 0010:latch_tree_find include/linux/rbtree_latch.h:208 [inline]
RIP: 0010:bpf_prog_kallsyms_find+0x289/0x4a0 kernel/bpf/core.c:509
Code: 03 42 80 3c 30 00 0f 85 b1 01 00 00 4d 8b 6f 50 49 8d 7d 30 48 89 fa  
48 c1 ea 03 42 80 3c 32 00 0f 85 ab 01 00 00 49 8d 7d 02 <4d> 8b 65 30 48  
89 fa 48 89 f9 48 c1 ea 03 83 e1 07 42 0f b6 14 32
RSP: 0018:ffff88019a065f18 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffff8801c2a5ab08 RCX: ffffffff818b41d1
RDX: 1ffff92000326006 RSI: 0000000000000008 RDI: ffffc90001930002
RBP: ffff88019a066090 R08: ffff8801cce982c0 R09: 0000000000000001
R10: ffffed003b5a4732 R11: 0000000000000000 R12: 1ffff1003340cc05
R13: ffffc90001930000 R14: dffffc0000000000 R15: ffff8801c2a5aaf0
FS:  00007f524d117700(0000) GS:ffff8801dad00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc90001930030 CR3: 00000001d3889000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
BUG: unable to handle kernel paging request at ffffc90001930030
PGD 1da948067 P4D 1da948067 PUD 1da949067 PMD 1d49ae067 PTE 0
Oops: 0000 [#4] PREEMPT SMP KASAN
CPU: 1 PID: 7453 Comm: syz-executor5 Not tainted 4.19.0-rc2+ #209
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:bpf_prog_ebpf_jited include/linux/filter.h:898 [inline]
RIP: 0010:bpf_get_prog_addr_region kernel/bpf/core.c:381 [inline]
RIP: 0010:bpf_tree_comp kernel/bpf/core.c:435 [inline]
RIP: 0010:__lt_find include/linux/rbtree_latch.h:115 [inline]
RIP: 0010:latch_tree_find include/linux/rbtree_latch.h:208 [inline]
RIP: 0010:bpf_prog_kallsyms_find+0x289/0x4a0 kernel/bpf/core.c:509
Code: 03 42 80 3c 30 00 0f 85 b1 01 00 00 4d 8b 6f 50 49 8d 7d 30 48 89 fa  
48 c1 ea 03 42 80 3c 32 00 0f 85 ab 01 00 00 49 8d 7d 02 <4d> 8b 65 30 48  
89 fa 48 89 f9 48 c1 ea 03 83 e1 07 42 0f b6 14 32
RSP: 0018:ffff88019a0657b8 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffff8801c2a5ab08 RCX: ffffffff818b41d1
RDX: 1ffff92000326006 RSI: 0000000000000008 RDI: ffffc90001930002
RBP: ffff88019a065930 R08: ffff8801cce982c0 R09: 0000000000000001
R10: ffffed003b5a4732 R11: 0000000000000000 R12: 1ffff1003340cb19
R13: ffffc90001930000 R14: dffffc0000000000 R15: ffff8801c2a5aaf0
FS:  00007f524d117700(0000) GS:ffff8801dad00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc90001930030 CR3: 00000001d3889000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
BUG: unable to handle kernel paging request at ffffc90001930030
PGD 1da948067 P4D 1da948067 PUD 1da949067 PMD 1d49ae067 PTE 0
Oops: 0000 [#5] PREEMPT SMP KASAN
CPU: 1 PID: 7453 Comm: syz-executor5 Not tainted 4.19.0-rc2+ #209
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:bpf_prog_ebpf_jited include/linux/filter.h:898 [inline]
RIP: 0010:bpf_get_prog_addr_region kernel/bpf/core.c:381 [inline]
RIP: 0010:bpf_tree_comp kernel/bpf/core.c:435 [inline]
RIP: 0010:__lt_find include/linux/rbtree_latch.h:115 [inline]
RIP: 0010:latch_tree_find include/linux/rbtree_latch.h:208 [inline]
RIP: 0010:bpf_prog_kallsyms_find+0x289/0x4a0 kernel/bpf/core.c:509
Code: 03 42 80 3c 30 00 0f 85 b1 01 00 00 4d 8b 6f 50 49 8d 7d 30 48 89 fa  
48 c1 ea 03 42 80 3c 32 00 0f 85 ab 01 00 00 49 8d 7d 02 <4d> 8b 65 30 48  
89 fa 48 89 f9 48 c1 ea 03 83 e1 07 42 0f b6 14 32
RSP: 0018:ffff88019a065058 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffff8801c2a5ab08 RCX: ffffffff818b41d1
RDX: 1ffff92000326006 RSI: 0000000000000008 RDI: ffffc90001930002
RBP: ffff88019a0651d0 R08: ffff8801cce982c0 R09: 0000000000000001
R10: ffffed003b5a4732 R11: 0000000000000000 R12: 1ffff1003340ca2d
R13: ffffc90001930000 R14: dffffc0000000000 R15: ffff8801c2a5aaf0
FS:  00007f524d117700(0000) GS:ffff8801dad00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc90001930030 CR3: 00000001d3889000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
BUG: unable to handle kernel paging request at ffffc90001930030
PGD 1da948067 P4D 1da948067 PUD 1da949067 PMD 1d49ae067 PTE 0
Oops: 0000 [#6] PREEMPT SMP KASAN
CPU: 1 PID: 7453 Comm: syz-executor5 Not tainted 4.19.0-rc2+ #209
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:bpf_prog_ebpf_jited include/linux/filter.h:898 [inline]
RIP: 0010:bpf_get_prog_addr_region kernel/bpf/core.c:381 [inline]
RIP: 0010:bpf_tree_comp kernel/bpf/core.c:435 [inline]
RIP: 0010:__lt_find include/linux/rbtree_latch.h:115 [inline]
RIP: 0010:latch_tree_find include/linux/rbtree_latch.h:208 [inline]
RIP: 0010:bpf_prog_kallsyms_find+0x289/0x4a0 kernel/bpf/core.c:509
Code: 03 42 80 3c 30 00 0f 85 b1 01 00 00 4d 8b 6f 50 49 8d 7d 30 48 89 fa  
48 c1 ea 03 42 80 3c 32 00 0f 85 ab 01 00 00 49 8d 7d 02 <4d> 8b 65 30 48  
89 fa 48 89 f9 48 c1 ea 03 83 e1 07 42 0f b6 14 32
RSP: 0018:ffff88019a0648f8 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffff8801c2a5ab08 RCX: ffffffff818b41d1
RDX: 1ffff92000326006 RSI: 0000000000000008 RDI: ffffc90001930002
RBP: ffff88019a064a70 R08: ffff8801cce982c0 R09: 0000000000000001
R10: ffffed003b5a4732 R11: 0000000000000000 R12: 1ffff1003340c941
R13: ffffc90001930000 R14: dffffc0000000000 R15: ffff8801c2a5aaf0
FS:  00007f524d117700(0000) GS:ffff8801dad00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc90001930030 CR3: 00000001d3889000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
BUG: unable to handle kernel paging request at ffffc90001930030
PGD 1da948067 P4D 1da948067 PUD 1da949067 PMD 1d49ae067 PTE 0
Oops: 0000 [#7] PREEMPT SMP KASAN
CPU: 1 PID: 7453 Comm: syz-executor5 Not tainted 4.19.0-rc2+ #209
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:bpf_prog_ebpf_jited include/linux/filter.h:898 [inline]
RIP: 0010:bpf_get_prog_addr_region kernel/bpf/core.c:381 [inline]
RIP: 0010:bpf_tree_comp kernel/bpf/core.c:435 [inline]
RIP: 0010:__lt_find include/linux/rbtree_latch.h:115 [inline]
RIP: 0010:latch_tree_find include/linux/rbtree_latch.h:208 [inline]
RIP: 0010:bpf_prog_kallsyms_find+0x289/0x4a0 kernel/bpf/core.c:509
Code: 03 42 80 3c 30 00 0f 85 b1 01 00 00 4d 8b 6f 50 49 8d 7d 30 48 89 fa  
48 c1 ea 03 42 80 3c 32 00 0f 85 ab 01 00 00 49 8d 7d 02 <4d> 8b 65 30 48  
89 fa 48 89 f9 48 c1 ea 03 83 e1 07 42 0f b6 14 32
RSP: 0018:ffff88019a064198 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffff8801c2a5ab08 RCX: ffffffff818b41d1
RDX: 1ffff92000326006 RSI: 0000000000000008 RDI: ffffc90001930002
RBP: ffff88019a064310 R08: ffff8801cce982c0 R09: 0000000000000001
R10: ffffed003b5a4732 R11: 0000000000000000 R12: 1ffff1003340c855
R13: ffffc90001930000 R14: dffffc0000000000 R15: ffff8801c2a5aaf0
FS:  00007f524d117700(0000) GS:ffff8801dad00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc90001930030 CR3: 00000001d3889000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
BUG: unable to handle kernel paging request at ffffc90001930030
PGD 1da948067 P4D 1da948067 PUD 1da949067 PMD 1d49ae067 PTE 0
Oops: 0000 [#8] PREEMPT SMP KASAN
CPU: 1 PID: 7453 Comm: syz-executor5 Not tainted 4.19.0-rc2+ #209
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:bpf_prog_ebpf_jited include/linux/filter.h:898 [inline]
RIP: 0010:bpf_get_prog_addr_region kernel/bpf/core.c:381 [inline]
RIP: 0010:bpf_tree_comp kernel/bpf/core.c:435 [inline]
RIP: 0010:__lt_find include/linux/rbtree_latch.h:115 [inline]
RIP: 0010:latch_tree_find include/linux/rbtree_latch.h:208 [inline]
RIP: 0010:bpf_prog_kallsyms_find+0x289/0x4a0 kernel/bpf/core.c:509
Code: 03 42 80 3c 30 00 0f 85 b1 01 00 00 4d 8b 6f 50 49 8d 7d 30 48 89 fa  
48 c1 ea 03 42 80 3c 32 00 0f 85 ab 01 00 00 49 8d 7d 02 <4d> 8b 65 30 48  
89 fa 48 89 f9 48 c1 ea 03 83 e1 07 42 0f b6 14 32
RSP: 0018:ffff88019a063a38 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffff8801c2a5ab08 RCX: ffffffff818b41d1
RDX: 1ffff92000326006 RSI: 0000000000000008 RDI: ffffc90001930002
RBP: ffff88019a063bb0 R08: ffff8801cce982c0 R09: 0000000000000001
R10: ffffed003b5a4732 R11: 0000000000000000 R12: 1ffff1003340c769
R13: ffffc90001930000 R14: dffffc0000000000 R15: ffff8801c2a5aaf0
FS:  00007f524d117700(0000) GS:ffff8801dad00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc90001930030 CR3: 00000001d3889000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
BUG: unable to handle kernel paging request at ffffc90001930030
PGD 1da948067 P4D 1da948067 PUD 1da949067 PMD 1d49ae067 PTE 0
Oops: 0000 [#9] PREEMPT SMP KASAN
CPU: 1 PID: 7453 Comm: syz-executor5 Not tainted 4.19.0-rc2+ #209
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:bpf_prog_ebpf_jited include/linux/filter.h:898 [inline]
RIP: 0010:bpf_get_prog_addr_region kernel/bpf/core.c:381 [inline]
RIP: 0010:bpf_tree_comp kernel/bpf/core.c:435 [inline]
RIP: 0010:__lt_find include/linux/rbtree_latch.h:115 [inline]
RIP: 0010:latch_tree_find include/linux/rbtree_latch.h:208 [inline]
RIP: 0010:bpf_prog_kallsyms_find+0x289/0x4a0 kernel/bpf/core.c:509
Code: 03 42 80 3c 30 00 0f 85 b1 01 00 00 4d 8b 6f 50 49 8d 7d 30 48 89 fa  
48 c1 ea 03 42 80 3c 32 00 0f 85 ab 01 00 00 49 8d 7d 02 <4d> 8b 65 30 48  
89 fa 48 89 f9 48 c1 ea 03 83 e1 07 42 0f b6 14 32
RSP: 0018:ffff88019a0632d8 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffff8801c2a5ab08 RCX: ffffffff818b41d1
RDX: 1ffff92000326006 RSI: 0000000000000008 RDI: ffffc90001930002
RBP: ffff88019a063450 R08: ffff8801cce982c0 R09: 0000000000000001
R10: ffffed003b5a4732 R11: 0000000000000000 R12: 1ffff1003340c67d
R13: ffffc90001930000 R14: dffffc0000000000 R15: ffff8801c2a5aaf0
FS:  00007f524d117700(0000) GS:ffff8801dad00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc90001930030 CR3: 00000001d3889000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
BUG: unable to handle kernel paging request at ffffc90001930030
PGD 1da948067 P4D 1da948067 PUD 1da949067 PMD 1d49ae067 PTE 0
Oops: 0000 [#10] PREEMPT SMP KASAN
CPU: 1 PID: 7453 Comm: syz-executor5 Not tainted 4.19.0-rc2+ #209
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:bpf_prog_ebpf_jited include/linux/filter.h:898 [inline]
RIP: 0010:bpf_get_prog_addr_region kernel/bpf/core.c:381 [inline]
RIP: 0010:bpf_tree_comp kernel/bpf/core.c:435 [inline]
RIP: 0010:__lt_find include/linux/rbtree_latch.h:115 [inline]
RIP: 0010:latch_tree_find include/linux/rbtree_latch.h:208 [inline]
RIP: 0010:bpf_prog_kallsyms_find+0x289/0x4a0 kernel/bpf/core.c:509
Code: 03 42 80 3c 30 00 0f 85 b1 01 00 00 4d 8b 6f 50 49 8d 7d 30 48 89 fa  
48 c1 ea 03 42 80 3c 32 00 0f 85 ab 01 00 00 49 8d 7d 02 <4d> 8b 65 30 48  
89 fa 48 89 f9 48 c1 ea 03 83 e1 07 42 0f b6 14 32
RSP: 0018:ffff88019a062b78 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffff8801c2a5ab08 RCX: ffffffff818b41d1
RDX: 1ffff92000326006 RSI: 0000000000000008 RDI: ffffc90001930002
RBP: ffff88019a062cf0 R08: ffff8801cce982c0 R09: 0000000000000001
R10: ffffed003b5a4732 R11: 0000000000000000 R12: 1ffff1003340c591
R13: ffffc90001930000 R14: dffffc0000000000 R15: ffff8801c2a5aaf0
FS:  00007f524d117700(0000) GS:ffff8801dad00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc90001930030 CR3: 00000001d3889000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
BUG: unable to handle kernel paging request at ffffc90001930030
PGD 1da948067 P4D 1da948067 PUD 1da949067 PMD 1d49ae067 PTE 0
Oops: 0000 [#11] PREEMPT SMP KASAN
CPU: 1 PID: 7453 Comm: syz-executor5 Not tainted 4.19.0-rc2+ #209
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:bpf_prog_ebpf_jited include/linux/filter.h:898 [inline]
RIP: 0010:bpf_get_prog_addr_region kernel/bpf/core.c:381 [inline]
RIP: 0010:bpf_tree_comp kernel/bpf/core.c:435 [inline]
RIP: 0010:__lt_find include/linux/rbtree_latch.h:115 [inline]
RIP: 0010:latch_tree_find include/linux/rbtree_latch.h:208 [inline]
RIP: 0010:bpf_prog_kallsyms_find+0x289/0x4a0 kernel/bpf/core.c:509
Code: 03 42 80 3c 30 00 0f 85 b1 01 00 00 4d 8b 6f 50 49 8d 7d 30 48 89 fa  
48 c1 ea 03 42 80 3c 32 00 0f 85 ab 01 00 00 49 8d 7d 02 <4d> 8b 65 30 48  
89 fa 48 89 f9 48 c1 ea 03 83 e1 07 42 0f b6 14 32
RSP: 0018:ffff88019a062418 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffff8801c2a5ab08 RCX: ffffffff818b41d1
RDX: 1ffff92000326006 RSI: 0000000000000008 RDI: ffffc90001930002
RBP: ffff88019a062590 R08: ffff8801cce982c0 R09: 0000000000000001
R10: ffffed003b5a4732 R11: 0000000000000000 R12: 1ffff1003340c4a5
R13: ffffc90001930000 R14: dffffc0000000000 R15: ffff8801c2a5aaf0
FS:  00007f524d117700(0000) GS:ffff8801dad00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc90001930030 CR3: 00000001d3889000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
BUG: unable to handle kernel paging request at ffffc90001930030
PGD 1da948067 P4D 1da948067 PUD 1da949067 PMD 1d49ae067 PTE 0
Oops: 0000 [#12] PREEMPT SMP KASAN
CPU: 1 PID: 7453 Comm: syz-executor5 Not tainted 4.19.0-rc2+ #209
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:bpf_prog_ebpf_jited include/linux/filter.h:898 [inline]
RIP: 0010:bpf_get_prog_addr_region kernel/bpf/core.c:381 [inline]
RIP: 0010:bpf_tree_comp kernel/bpf/core.c:435 [inline]
RIP: 0010:__lt_find include/linux/rbtree_latch.h:115 [inline]
RIP: 0010:latch_tree_find include/linux/rbtree_latch.h:208 [inline]
RIP: 0010:bpf_prog_kallsyms_find+0x289/0x4a0 kernel/bpf/core.c:509
Code: 03 42 80 3c 30 00 0f 85 b1 01 00 00 4d 8b 6f 50 49 8d 7d 30 48 89 fa  
48 c1 ea 03 42 80 3c 32 00 0f 85 ab 01 00 00 49 8d 7d 02 <4d> 8b 65 30 48  
89 fa 48 89 f9 48 c1 ea 03 83 e1 07 42 0f b6 14 32
RSP: 0018:ffff88019a061cb8 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffff8801c2a5ab08 RCX: ffffffff818b41d1
RDX: 1ffff92000326006 RSI: 0000000000000008 RDI: ffffc90001930002
RBP: ffff88019a061e30 R08: ffff8801cce982c0 R09: 0000000000000001
R10: ffffed003b5a4732 R11: 0000000000000000 R12: 1ffff1003340c3b9
R13: ffffc90001930000 R14: dffffc0000000000 R15: ffff8801c2a5aaf0
FS:  00007f524d117700(0000) GS:ffff8801dad00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc90001930030 CR3: 00000001d3889000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
BUG: unable to handle kernel paging request at ffffc90001930030
PGD 1da948067 P4D 1da948067 PUD 1da949067 PMD 1d49ae067 PTE 0
Oops: 0000 [#13] PREEMPT SMP KASAN
CPU: 1 PID: 7453 Comm: syz-executor5 Not tainted 4.19.0-rc2+ #209
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:bpf_prog_ebpf_jited include/linux/filter.h:898 [inline]
RIP: 0010:bpf_get_prog_addr_region kernel/bpf/core.c:381 [inline]
RIP: 0010:bpf_tree_comp kernel/bpf/core.c:435 [inline]
RIP: 0010:__lt_find include/linux/rbtree_latch.h:115 [inline]
RIP: 0010:latch_tree_find include/linux/rbtree_latch.h:208 [inline]
RIP: 0010:bpf_prog_kallsyms_find+0x289/0x4a0 kernel/bpf/core.c:509
Code: 03 42 80 3c 30 00 0f 85 b1 01 00 00 4d 8b 6f 50 49 8d 7d 30 48 89 fa  
48 c1 ea 03 42 80 3c 32 00 0f 85 ab 01 00 00 49 8d 7d 02 <4d> 8b 65 30 48  
89 fa 48 89 f9 48 c1 ea 03 83 e1 07 42 0f b6 14 32
RSP: 0018:ffff88019a061558 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffff8801c2a5ab08 RCX: ffffffff818b41d1
RDX: 1ffff92000326006 RSI: 0000000000000008 RDI: ffffc90001930002
RBP: ffff88019a0616d0 R08: ffff8801cce982c0 R09: 0000000000000001
R10: ffffed003b5a4732 R11: 0000000000000000 R12: 1ffff1003340c2cd
R13: ffffc90001930000 R14: dffffc0000000000 R15: ffff8801c2a5aaf0
FS:  00007f524d117700(0000) GS:ffff8801dad00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc90001930030 CR3: 00000001d3889000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
BUG: unable to handle kernel paging request at ffffc90001930030
PGD 1da948067 P4D 1da948067 PUD 1da949067 PMD 1d49ae067 PTE 0
Thread overran stack, or stack corrupted
Oops: 0000 [#14] PREEMPT SMP KASAN
CPU: 1 PID: 7453 Comm: syz-executor5 Not tainted 4.19.0-rc2+ #209
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:bpf_prog_ebpf_jited include/linux/filter.h:898 [inline]
RIP: 0010:bpf_get_prog_addr_region kernel/bpf/core.c:381 [inline]
RIP: 0010:bpf_tree_comp kernel/bpf/core.c:435 [inline]
RIP: 0010:__lt_find include/linux/rbtree_latch.h:115 [inline]
RIP: 0010:latch_tree_find include/linux/rbtree_latch.h:208 [inline]
RIP: 0010:bpf_prog_kallsyms_find+0x289/0x4a0 kernel/bpf/core.c:509
Code: 03 42 80 3c 30 00 0f 85 b1 01 00 00 4d 8b 6f 50 49 8d 7d 30 48 89 fa  
48 c1 ea 03 42 80 3c 32 00 0f 85 ab 01 00 00 49 8d 7d 02 <4d> 8b 65 30 48  
89 fa 48 89 f9 48 c1 ea 03 83 e1 07 42 0f b6 14 32
RSP: 0018:ffff88019a060df8 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffff8801c2a5ab08 RCX: ffffffff818b41d1
RDX: 1ffff92000326006 RSI: 0000000000000008 RDI: ffffc90001930002
RBP: ffff88019a060f70 R08: ffff8801cce982c0 R09: 0000000000000001
R10: ffffed003b5a4732 R11: 0000000000000000 R12: 1ffff1003340c1e1
R13: ffffc90001930000 R14: dffffc0000000000 R15: ffff8801c2a5aaf0
FS:  00007f524d117700(0000) GS:ffff8801dad00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc90001930030 CR3: 00000001d3889000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
BUG: unable to handle kernel paging request at ffffc90001930030
PGD 1da948067 P4D 1da948067 PUD 1da949067 PMD 1d49ae067 PTE 0
Thread overran stack, or stack corrupted
Oops: 0000 [#15] PREEMPT SMP KASAN
CPU: 1 PID: 7453 Comm: syz-executor5 Not tainted 4.19.0-rc2+ #209
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:bpf_prog_ebpf_jited include/linux/filter.h:898 [inline]
RIP: 0010:bpf_get_prog_addr_region kernel/bpf/core.c:381 [inline]
RIP: 0010:bpf_tree_comp kernel/bpf/core.c:435 [inline]
RIP: 0010:__lt_find include/linux/rbtree_latch.h:115 [inline]
RIP: 0010:latch_tree_find include/linux/rbtree_latch.h:208 [inline]
RIP: 0010:bpf_prog_kallsyms_find+0x289/0x4a0 kernel/bpf/core.c:509
Code: 03 42 80 3c 30 00 0f 85 b1 01 00 00 4d 8b 6f 50 49 8d 7d 30 48 89 fa  
48 c1 ea 03 42 80 3c 32 00 0f 85 ab 01 00 00 49 8d 7d 02 <4d> 8b 65 30 48  
89 fa 48 89 f9 48 c1 ea 03 83 e1 07 42 0f b6 14 32
RSP: 0018:ffff88019a060698 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffff8801c2a5ab08 RCX: ffffffff818b41d1
RDX: 1ffff92000326006 RSI: 0000000000000008 RDI: ffffc90001930002
RBP: ffff88019a060810 R08: ffff8801cce982c0 R09: 0000000000000001
R10: ffffed003b5a4732 R11: 0000000000000000 R12: 1ffff1003340c0f5
R13: ffffc90001930000 R14: dffffc0000000000 R15: ffff8801c2a5aaf0
FS:  00007f524d117700(0000) GS:ffff8801dad00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc90001930030 CR3: 00000001d3889000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
------------[ cut here ]------------
kernel BUG at mm/slab.c:4421!
invalid opcode: 0000 [#16] PREEMPT SMP KASAN
CPU: 1 PID: 7453 Comm: syz-executor5 Not tainted 4.19.0-rc2+ #209
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:__check_heap_object+0xa7/0xb5 mm/slab.c:4446
Code: 48 c7 c7 15 75 25 89 e8 97 83 0a 00 5d c3 41 8b 91 04 01 00 00 48 29  
c7 48 39 d7 77 be 48 01 d0 48 29 c8 48 39 f0 72 b3 5d c3 <0f> 0b 48 c7 c7  
15 75 25 89 e8 fd 8b 0a 00 44 89 e9 48 c7 c7 d0 75
RSP: 0018:ffff88019a05f3f0 EFLAGS: 00010046
RAX: 0000000000000001 RBX: 1ffff1003340be85 RCX: 000000000000000c
RDX: ffff88019a05e380 RSI: 0000000000000002 RDI: ffff88019a05f598
RBP: ffff88019a05f3f0 R08: ffff8801cce982c0 R09: ffff8801da972d80
R10: 0000000000000ff7 R11: 0000000000000000 R12: ffff88019a05f598
R13: 0000000000000002 R14: ffffea0006681780 R15: 0000000000000001
FS:  00007f524d117700(0000) GS:ffff8801dad00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc90001930030 CR3: 00000001d3889000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
BUG: unable to handle kernel paging request at ffffc90001930030
PGD 1da948067 P4D 1da948067 PUD 1da949067 PMD 1d49ae067 PTE 0
Thread overran stack, or stack corrupted
Oops: 0000 [#17] PREEMPT SMP KASAN
CPU: 1 PID: 7453 Comm: syz-executor5 Not tainted 4.19.0-rc2+ #209
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:bpf_prog_ebpf_jited include/linux/filter.h:898 [inline]
RIP: 0010:bpf_get_prog_addr_region kernel/bpf/core.c:381 [inline]
RIP: 0010:bpf_tree_comp kernel/bpf/core.c:435 [inline]
RIP: 0010:__lt_find include/linux/rbtree_latch.h:115 [inline]
RIP: 0010:latch_tree_find include/linux/rbtree_latch.h:208 [inline]
RIP: 0010:bpf_prog_kallsyms_find+0x289/0x4a0 kernel/bpf/core.c:509
Code: 03 42 80 3c 30 00 0f 85 b1 01 00 00 4d 8b 6f 50 49 8d 7d 30 48 89 fa  
48 c1 ea 03 42 80 3c 32 00 0f 85 ab 01 00 00 49 8d 7d 02 <4d> 8b 65 30 48  
89 fa 48 89 f9 48 c1 ea 03 83 e1 07 42 0f b6 14 32
RSP: 0018:ffff88019a05ee68 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffff8801c2a5ab08 RCX: ffffffff818b41d1
RDX: 1ffff92000326006 RSI: 0000000000000008 RDI: ffffc90001930002
RBP: ffff88019a05efe0 R08: ffff8801cce982c0 R09: 0000000000000001
R10: ffffed003b5a4732 R11: 0000000000000000 R12: 1ffff1003340bdef
R13: ffffc90001930000 R14: dffffc0000000000 R15: ffff8801c2a5aaf0
FS:  00007f524d117700(0000) GS:ffff8801dad00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc90001930030 CR3: 00000001d3889000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
Modules linked in:
Dumping ftrace buffer:
    (ftrace buffer empty)
CR2: ffffc90001930030
---[ end trace 90699f7c967c99ef ]---
RIP: 0010:bpf_prog_ebpf_jited include/linux/filter.h:898 [inline]
RIP: 0010:bpf_get_prog_addr_region kernel/bpf/core.c:381 [inline]
RIP: 0010:bpf_tree_comp kernel/bpf/core.c:435 [inline]
RIP: 0010:__lt_find include/linux/rbtree_latch.h:115 [inline]
RIP: 0010:latch_tree_find include/linux/rbtree_latch.h:208 [inline]
RIP: 0010:bpf_prog_kallsyms_find+0x289/0x4a0 kernel/bpf/core.c:509
Code: 03 42 80 3c 30 00 0f 85 b1 01 00 00 4d 8b 6f 50 49 8d 7d 30 48 89 fa  
48 c1 ea 03 42 80 3c 32 00 0f 85 ab 01 00 00 49 8d 7d 02 <4d> 8b 65 30 48  
89 fa 48 89 f9 48 c1 ea 03 83 e1 07 42 0f b6 14 32
RSP: 0018:ffff88019a066dd0 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffff8801c2a5ab08 RCX: ffffffff818b41d1
RDX: 1ffff92000326006 RSI: 0000000000000008 RDI: ffffc90001930002
RBP: ffff88019a066f48 R08: ffff8801cce982c0 R09: ffffed003b5a4732
R10: ffffed003b5a4732 R11: ffff8801dad23993 R12: 1ffff1003340cddc
R13: ffffc90001930000 R14: dffffc0000000000 R15: ffff8801c2a5aaf0
FS:  00007f524d117700(0000) GS:ffff8801dad00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc90001930030 CR3: 00000001d3889000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
