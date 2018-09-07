Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E81D6C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 23:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 650DD2077C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 23:24:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 650DD2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbeIHEGX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 00:06:23 -0400
Received: from mail-it0-f70.google.com ([209.85.214.70]:43521 "EHLO
        mail-it0-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbeIHEGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 00:06:22 -0400
Received: by mail-it0-f70.google.com with SMTP id z72-v6so25540655itc.8
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 16:23:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=TQrxDiz6oYsOtKcSUEChKZ5OeL87pklypyXGOTWqkQs=;
        b=qiJrQj3aSR3dgGRIhGG4lcqbfLuvDb5Suc6hcWyamqhTRqDvIANzIhvmt0mPPmewnH
         hBcgfv1BHRR/TZEq0LF+GSDtWBP3zOeruCcjPN0h9qkUuu+kt1bTc2OW3z8ajEyP0fgy
         BfzQqp0A7zBxDIlJw3Tn7YkkG5aJQe6fMzhPtqbM2pb0FKTju3oxAoyH8EEQJHieCgPx
         O6RGkiMzPVpBdc+223sXJ4Hnr+HVz+J1COgB4ZvkHyyGcDanW02IoXjHFg5xiF0UvNSS
         VSbuPRaI8WFEPjjoX5exF8irllKhggguBXOGLZjgx+kp5Y6q/J7TDo1EfWECLwX4y87R
         s1kw==
X-Gm-Message-State: APzg51ALzivzN99ijHG910wcehMvrjUuEsrzI5opHDFURuGZ7mrG+MkH
        yOFmhLu7bS4LKDflIq1xVHZThbxT8yVsUpSemod/4fNpm4cv
X-Google-Smtp-Source: ANB0VdYJy8yr8pvMY3q0eujMq+VggmxNc8AOyHP8+hMLPHicQHyJ0bGuEb7+M24DUW2UPXOGPoMjU2SP9N5v6r3Pc8CRxfHEQm++
MIME-Version: 1.0
X-Received: by 2002:a02:7e0a:: with SMTP id h10-v6mr8752200jac.4.1536362583414;
 Fri, 07 Sep 2018 16:23:03 -0700 (PDT)
Date:   Fri, 07 Sep 2018 16:23:03 -0700
In-Reply-To: <000000000000e92d1805711f5552@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000007ec480575504af2@google.com>
Subject: Re: WARNING in bpf_jit_free
From:   syzbot <syzbot+2ff1e7cb738fd3c41113@syzkaller.appspotmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    28619527b8a7 Merge git://git.kernel.org/pub/scm/linux/kern..
git tree:       bpf
console output: https://syzkaller.appspot.com/x/log.txt?x=1339498e400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=62e9b447c16085cf
dashboard link: https://syzkaller.appspot.com/bug?extid=2ff1e7cb738fd3c41113
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=163cc149400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+2ff1e7cb738fd3c41113@syzkaller.appspotmail.com

IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
8021q: adding VLAN 0 to HW filter on device team0
WARNING: CPU: 0 PID: 5391 at kernel/bpf/core.c:628 bpf_jit_free+0x2e5/0x3f0
Kernel panic - not syncing: panic_on_warn set ...

CPU: 0 PID: 5391 Comm: kworker/0:0 Not tainted 4.19.0-rc2+ #50
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events bpf_prog_free_deferred
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c4/0x2b4 lib/dump_stack.c:113
  panic+0x238/0x4e7 kernel/panic.c:184
  __warn.cold.8+0x163/0x1ba kernel/panic.c:536
  report_bug+0x254/0x2d0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:178 [inline]
  do_error_trap+0x1fc/0x4d0 arch/x86/kernel/traps.c:296
  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:316
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:993
RIP: 0010:bpf_jit_free+0x2e5/0x3f0
Code: 07 38 c8 7f 08 84 c0 0f 85 85 00 00 00 48 b8 00 02 00 00 00 00 ad de  
44 0f b6 63 02 48 39 c2 0f 84 d9 fd ff ff e8 8b 4b f3 ff <0f> 0b e9 cd fd  
ff ff e8 7f 4b f3 ff 4c 89 f0 48 ba 00 00 00 00 00
RSP: 0018:ffff8801b77bf648 EFLAGS: 00010293
RAX: ffff8801d8730500 RBX: ffffc9000192c000 RCX: 0000000000000002
RDX: 0000000000000000 RSI: ffffffff818b83a5 RDI: ffff8801cdcea6e8
RBP: ffff8801b77bf6e0 R08: ffff8801d8730dc8 R09: 0000000000000006
R10: 0000000000000000 R11: ffff8801d8730500 R12: 000000000000000f
R13: 1ffff10036ef7ecb R14: ffffc9000192c002 R15: ffffc9000192c020
BUG: unable to handle kernel paging request at fffffbfff4004000
PGD 21ffec067 P4D 21ffec067 PUD 21fe60067 PMD 1c1a04067 PTE 0
Oops: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 5391 Comm: kworker/0:0 Not tainted 4.19.0-rc2+ #50
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events bpf_prog_free_deferred
RIP: 0010:bpf_get_prog_addr_region kernel/bpf/core.c:384 [inline]
RIP: 0010:bpf_tree_comp kernel/bpf/core.c:435 [inline]
RIP: 0010:__lt_find include/linux/rbtree_latch.h:115 [inline]
RIP: 0010:latch_tree_find include/linux/rbtree_latch.h:208 [inline]
RIP: 0010:bpf_prog_kallsyms_find+0x2fe/0x4a0 kernel/bpf/core.c:509
Code: 8e f3 ff 4c 8b ad b0 fe ff ff 4c 89 e6 4c 89 ef e8 47 8f f3 ff 4d 39  
e5 0f 82 a7 00 00 00 e8 89 8e f3 ff 4c 89 e0 48 c1 e8 03 <42> 0f b6 04 30  
84 c0 74 08 3c 03 0f 8e 35 01 00 00 41 8b 04 24 4c
RSP: 0018:ffff8801b77bef80 EFLAGS: 00010806
RAX: 1ffffffff4004000 RBX: ffff8801cdcea6b0 RCX: ffffffff818b4099
RDX: 0000000000000000 RSI: ffffffff818b40a7 RDI: 0000000000000006
RBP: ffff8801b77bf0f8 R08: ffff8801d8730500 R09: ffffed003b5c4732
R10: ffffed003b5c4732 R11: ffff8801dae23993 R12: ffffffffa0020000
R13: ffffffffffffffff R14: dffffc0000000000 R15: ffff8801cdcea6b0
FS:  0000000000000000(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffbfff4004000 CR3: 000000000946a000 CR4: 00000000001406f0
Call Trace:
BUG: unable to handle kernel paging request at fffffbfff4004000
PGD 21ffec067 P4D 21ffec067 PUD 21fe60067 PMD 1c1a04067 PTE 0
Oops: 0000 [#2] PREEMPT SMP KASAN
CPU: 0 PID: 5391 Comm: kworker/0:0 Not tainted 4.19.0-rc2+ #50
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events bpf_prog_free_deferred
RIP: 0010:bpf_get_prog_addr_region kernel/bpf/core.c:384 [inline]
RIP: 0010:bpf_tree_comp kernel/bpf/core.c:435 [inline]
RIP: 0010:__lt_find include/linux/rbtree_latch.h:115 [inline]
RIP: 0010:latch_tree_find include/linux/rbtree_latch.h:208 [inline]
RIP: 0010:bpf_prog_kallsyms_find+0x2fe/0x4a0 kernel/bpf/core.c:509
Code: 8e f3 ff 4c 8b ad b0 fe ff ff 4c 89 e6 4c 89 ef e8 47 8f f3 ff 4d 39  
e5 0f 82 a7 00 00 00 e8 89 8e f3 ff 4c 89 e0 48 c1 e8 03 <42> 0f b6 04 30  
84 c0 74 08 3c 03 0f 8e 35 01 00 00 41 8b 04 24 4c
RSP: 0018:ffff8801b77be828 EFLAGS: 00010806
RAX: 1ffffffff4004000 RBX: ffff8801cdcea6b0 RCX: ffffffff818b4099
RDX: 0000000000000000 RSI: ffffffff818b40a7 RDI: 0000000000000006
RBP: ffff8801b77be9a0 R08: ffff8801d8730500 R09: 0000000000000001
R10: ffffed003b5c4732 R11: 0000000000000000 R12: ffffffffa0020000
R13: ffffffffffffffff R14: dffffc0000000000 R15: ffff8801cdcea6b0
FS:  0000000000000000(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffbfff4004000 CR3: 000000000946a000 CR4: 00000000001406f0
Call Trace:
BUG: unable to handle kernel paging request at fffffbfff4004000
PGD 21ffec067 P4D 21ffec067 PUD 21fe60067 PMD 1c1a04067 PTE 0
Oops: 0000 [#3] PREEMPT SMP KASAN
CPU: 0 PID: 5391 Comm: kworker/0:0 Not tainted 4.19.0-rc2+ #50
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events bpf_prog_free_deferred
RIP: 0010:bpf_get_prog_addr_region kernel/bpf/core.c:384 [inline]
RIP: 0010:bpf_tree_comp kernel/bpf/core.c:435 [inline]
RIP: 0010:__lt_find include/linux/rbtree_latch.h:115 [inline]
RIP: 0010:latch_tree_find include/linux/rbtree_latch.h:208 [inline]
RIP: 0010:bpf_prog_kallsyms_find+0x2fe/0x4a0 kernel/bpf/core.c:509
Code: 8e f3 ff 4c 8b ad b0 fe ff ff 4c 89 e6 4c 89 ef e8 47 8f f3 ff 4d 39  
e5 0f 82 a7 00 00 00 e8 89 8e f3 ff 4c 89 e0 48 c1 e8 03 <42> 0f b6 04 30  
84 c0 74 08 3c 03 0f 8e 35 01 00 00 41 8b 04 24 4c
RSP: 0018:ffff8801b77be0c8 EFLAGS: 00010806
RAX: 1ffffffff4004000 RBX: ffff8801cdcea6b0 RCX: ffffffff818b4099
RDX: 0000000000000000 RSI: ffffffff818b40a7 RDI: 0000000000000006
RBP: ffff8801b77be240 R08: ffff8801d8730500 R09: 0000000000000001
R10: ffffed003b5c4732 R11: 0000000000000000 R12: ffffffffa0020000
R13: ffffffffffffffff R14: dffffc0000000000 R15: ffff8801cdcea6b0
FS:  0000000000000000(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffbfff4004000 CR3: 000000000946a000 CR4: 00000000001406f0
Call Trace:
BUG: unable to handle kernel paging request at fffffbfff4004000
PGD 21ffec067 P4D 21ffec067 PUD 21fe60067 PMD 1c1a04067 PTE 0
Oops: 0000 [#4] PREEMPT SMP KASAN
CPU: 0 PID: 5391 Comm: kworker/0:0 Not tainted 4.19.0-rc2+ #50
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events bpf_prog_free_deferred
RIP: 0010:bpf_get_prog_addr_region kernel/bpf/core.c:384 [inline]
RIP: 0010:bpf_tree_comp kernel/bpf/core.c:435 [inline]
RIP: 0010:__lt_find include/linux/rbtree_latch.h:115 [inline]
RIP: 0010:latch_tree_find include/linux/rbtree_latch.h:208 [inline]
RIP: 0010:bpf_prog_kallsyms_find+0x2fe/0x4a0 kernel/bpf/core.c:509
Code: 8e f3 ff 4c 8b ad b0 fe ff ff 4c 89 e6 4c 89 ef e8 47 8f f3 ff 4d 39  
e5 0f 82 a7 00 00 00 e8 89 8e f3 ff 4c 89 e0 48 c1 e8 03 <42> 0f b6 04 30  
84 c0 74 08 3c 03 0f 8e 35 01 00 00 41 8b 04 24 4c
RSP: 0018:ffff8801b77bd968 EFLAGS: 00010806
RAX: 1ffffffff4004000 RBX: ffff8801cdcea6b0 RCX: ffffffff818b4099
RDX: 0000000000000000 RSI: ffffffff818b40a7 RDI: 0000000000000006
RBP: ffff8801b77bdae0 R08: ffff8801d8730500 R09: 0000000000000001
R10: ffffed003b5c4732 R11: 0000000000000000 R12: ffffffffa0020000
R13: ffffffffffffffff R14: dffffc0000000000 R15: ffff8801cdcea6b0
FS:  0000000000000000(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffbfff4004000 CR3: 000000000946a000 CR4: 00000000001406f0
Call Trace:
BUG: unable to handle kernel paging request at fffffbfff4004000
PGD 21ffec067 P4D 21ffec067 PUD 21fe60067 PMD 1c1a04067 PTE 0
Oops: 0000 [#5] PREEMPT SMP KASAN
CPU: 0 PID: 5391 Comm: kworker/0:0 Not tainted 4.19.0-rc2+ #50
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events bpf_prog_free_deferred
RIP: 0010:bpf_get_prog_addr_region kernel/bpf/core.c:384 [inline]
RIP: 0010:bpf_tree_comp kernel/bpf/core.c:435 [inline]
RIP: 0010:__lt_find include/linux/rbtree_latch.h:115 [inline]
RIP: 0010:latch_tree_find include/linux/rbtree_latch.h:208 [inline]
RIP: 0010:bpf_prog_kallsyms_find+0x2fe/0x4a0 kernel/bpf/core.c:509
Code: 8e f3 ff 4c 8b ad b0 fe ff ff 4c 89 e6 4c 89 ef e8 47 8f f3 ff 4d 39  
e5 0f 82 a7 00 00 00 e8 89 8e f3 ff 4c 89 e0 48 c1 e8 03 <42> 0f b6 04 30  
84 c0 74 08 3c 03 0f 8e 35 01 00 00 41 8b 04 24 4c
RSP: 0018:ffff8801b77bd208 EFLAGS: 00010806
RAX: 1ffffffff4004000 RBX: ffff8801cdcea6b0 RCX: ffffffff818b4099
RDX: 0000000000000000 RSI: ffffffff818b40a7 RDI: 0000000000000006
RBP: ffff8801b77bd380 R08: ffff8801d8730500 R09: 0000000000000001
R10: ffffed003b5c4732 R11: 0000000000000000 R12: ffffffffa0020000
R13: ffffffffffffffff R14: dffffc0000000000 R15: ffff8801cdcea6b0
FS:  0000000000000000(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffbfff4004000 CR3: 000000000946a000 CR4: 00000000001406f0
Call Trace:
BUG: unable to handle kernel paging request at fffffbfff4004000
PGD 21ffec067 P4D 21ffec067 PUD 21fe60067 PMD 1c1a04067 PTE 0
Oops: 0000 [#6] PREEMPT SMP KASAN
CPU: 0 PID: 5391 Comm: kworker/0:0 Not tainted 4.19.0-rc2+ #50
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events bpf_prog_free_deferred
RIP: 0010:bpf_get_prog_addr_region kernel/bpf/core.c:384 [inline]
RIP: 0010:bpf_tree_comp kernel/bpf/core.c:435 [inline]
RIP: 0010:__lt_find include/linux/rbtree_latch.h:115 [inline]
RIP: 0010:latch_tree_find include/linux/rbtree_latch.h:208 [inline]
RIP: 0010:bpf_prog_kallsyms_find+0x2fe/0x4a0 kernel/bpf/core.c:509
Code: 8e f3 ff 4c 8b ad b0 fe ff ff 4c 89 e6 4c 89 ef e8 47 8f f3 ff 4d 39  
e5 0f 82 a7 00 00 00 e8 89 8e f3 ff 4c 89 e0 48 c1 e8 03 <42> 0f b6 04 30  
84 c0 74 08 3c 03 0f 8e 35 01 00 00 41 8b 04 24 4c
RSP: 0018:ffff8801b77bcaa8 EFLAGS: 00010806
RAX: 1ffffffff4004000 RBX: ffff8801cdcea6b0 RCX: ffffffff818b4099
RDX: 0000000000000000 RSI: ffffffff818b40a7 RDI: 0000000000000006
RBP: ffff8801b77bcc20 R08: ffff8801d8730500 R09: 0000000000000001
R10: ffffed003b5c4732 R11: 0000000000000000 R12: ffffffffa0020000
R13: ffffffffffffffff R14: dffffc0000000000 R15: ffff8801cdcea6b0
FS:  0000000000000000(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffbfff4004000 CR3: 000000000946a000 CR4: 00000000001406f0
Call Trace:
BUG: unable to handle kernel paging request at fffffbfff4004000
PGD 21ffec067 P4D 21ffec067 PUD 21fe60067 PMD 1c1a04067 PTE 0
Oops: 0000 [#7] PREEMPT SMP KASAN
CPU: 0 PID: 5391 Comm: kworker/0:0 Not tainted 4.19.0-rc2+ #50
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events bpf_prog_free_deferred
RIP: 0010:bpf_get_prog_addr_region kernel/bpf/core.c:384 [inline]
RIP: 0010:bpf_tree_comp kernel/bpf/core.c:435 [inline]
RIP: 0010:__lt_find include/linux/rbtree_latch.h:115 [inline]
RIP: 0010:latch_tree_find include/linux/rbtree_latch.h:208 [inline]
RIP: 0010:bpf_prog_kallsyms_find+0x2fe/0x4a0 kernel/bpf/core.c:509
Code: 8e f3 ff 4c 8b ad b0 fe ff ff 4c 89 e6 4c 89 ef e8 47 8f f3 ff 4d 39  
e5 0f 82 a7 00 00 00 e8 89 8e f3 ff 4c 89 e0 48 c1 e8 03 <42> 0f b6 04 30  
84 c0 74 08 3c 03 0f 8e 35 01 00 00 41 8b 04 24 4c
RSP: 0018:ffff8801b77bc348 EFLAGS: 00010806
RAX: 1ffffffff4004000 RBX: ffff8801cdcea6b0 RCX: ffffffff818b4099
RDX: 0000000000000000 RSI: ffffffff818b40a7 RDI: 0000000000000006
RBP: ffff8801b77bc4c0 R08: ffff8801d8730500 R09: 0000000000000001
R10: ffffed003b5c4732 R11: 0000000000000000 R12: ffffffffa0020000
R13: ffffffffffffffff R14: dffffc0000000000 R15: ffff8801cdcea6b0
FS:  0000000000000000(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffbfff4004000 CR3: 000000000946a000 CR4: 00000000001406f0
Call Trace:
BUG: unable to handle kernel paging request at fffffbfff4004000
PGD 21ffec067 P4D 21ffec067 PUD 21fe60067 PMD 1c1a04067 PTE 0
Oops: 0000 [#8] PREEMPT SMP KASAN
CPU: 0 PID: 5391 Comm: kworker/0:0 Not tainted 4.19.0-rc2+ #50
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events bpf_prog_free_deferred
RIP: 0010:bpf_get_prog_addr_region kernel/bpf/core.c:384 [inline]
RIP: 0010:bpf_tree_comp kernel/bpf/core.c:435 [inline]
RIP: 0010:__lt_find include/linux/rbtree_latch.h:115 [inline]
RIP: 0010:latch_tree_find include/linux/rbtree_latch.h:208 [inline]
RIP: 0010:bpf_prog_kallsyms_find+0x2fe/0x4a0 kernel/bpf/core.c:509
Code: 8e f3 ff 4c 8b ad b0 fe ff ff 4c 89 e6 4c 89 ef e8 47 8f f3 ff 4d 39  
e5 0f 82 a7 00 00 00 e8 89 8e f3 ff 4c 89 e0 48 c1 e8 03 <42> 0f b6 04 30  
84 c0 74 08 3c 03 0f 8e 35 01 00 00 41 8b 04 24 4c
RSP: 0018:ffff8801b77bbbe8 EFLAGS: 00010806
RAX: 1ffffffff4004000 RBX: ffff8801cdcea6b0 RCX: ffffffff818b4099
RDX: 0000000000000000 RSI: ffffffff818b40a7 RDI: 0000000000000006
RBP: ffff8801b77bbd60 R08: ffff8801d8730500 R09: 0000000000000001
R10: ffffed003b5c4732 R11: 0000000000000000 R12: ffffffffa0020000
R13: ffffffffffffffff R14: dffffc0000000000 R15: ffff8801cdcea6b0
FS:  0000000000000000(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffbfff4004000 CR3: 000000000946a000 CR4: 00000000001406f0
Call Trace:
BUG: unable to handle kernel paging request at fffffbfff4004000
PGD 21ffec067 P4D 21ffec067 PUD 21fe60067 PMD 1c1a04067 PTE 0
Oops: 0000 [#9] PREEMPT SMP KASAN
CPU: 0 PID: 5391 Comm: kworker/0:0 Not tainted 4.19.0-rc2+ #50
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events bpf_prog_free_deferred
RIP: 0010:bpf_get_prog_addr_region kernel/bpf/core.c:384 [inline]
RIP: 0010:bpf_tree_comp kernel/bpf/core.c:435 [inline]
RIP: 0010:__lt_find include/linux/rbtree_latch.h:115 [inline]
RIP: 0010:latch_tree_find include/linux/rbtree_latch.h:208 [inline]
RIP: 0010:bpf_prog_kallsyms_find+0x2fe/0x4a0 kernel/bpf/core.c:509
Code: 8e f3 ff 4c 8b ad b0 fe ff ff 4c 89 e6 4c 89 ef e8 47 8f f3 ff 4d 39  
e5 0f 82 a7 00 00 00 e8 89 8e f3 ff 4c 89 e0 48 c1 e8 03 <42> 0f b6 04 30  
84 c0 74 08 3c 03 0f 8e 35 01 00 00 41 8b 04 24 4c
RSP: 0018:ffff8801b77bb488 EFLAGS: 00010806
RAX: 1ffffffff4004000 RBX: ffff8801cdcea6b0 RCX: ffffffff818b4099
RDX: 0000000000000000 RSI: ffffffff818b40a7 RDI: 0000000000000006
RBP: ffff8801b77bb600 R08: ffff8801d8730500 R09: 0000000000000001
R10: ffffed003b5c4732 R11: 0000000000000000 R12: ffffffffa0020000
R13: ffffffffffffffff R14: dffffc0000000000 R15: ffff8801cdcea6b0
FS:  0000000000000000(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffbfff4004000 CR3: 000000000946a000 CR4: 00000000001406f0
Call Trace:
BUG: unable to handle kernel paging request at fffffbfff4004000
PGD 21ffec067 P4D 21ffec067 PUD 21fe60067 PMD 1c1a04067 PTE 0
Oops: 0000 [#10] PREEMPT SMP KASAN
CPU: 0 PID: 5391 Comm: kworker/0:0 Not tainted 4.19.0-rc2+ #50
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events bpf_prog_free_deferred
RIP: 0010:bpf_get_prog_addr_region kernel/bpf/core.c:384 [inline]
RIP: 0010:bpf_tree_comp kernel/bpf/core.c:435 [inline]
RIP: 0010:__lt_find include/linux/rbtree_latch.h:115 [inline]
RIP: 0010:latch_tree_find include/linux/rbtree_latch.h:208 [inline]
RIP: 0010:bpf_prog_kallsyms_find+0x2fe/0x4a0 kernel/bpf/core.c:509
Code: 8e f3 ff 4c 8b ad b0 fe ff ff 4c 89 e6 4c 89 ef e8 47 8f f3 ff 4d 39  
e5 0f 82 a7 00 00 00 e8 89 8e f3 ff 4c 89 e0 48 c1 e8 03 <42> 0f b6 04 30  
84 c0 74 08 3c 03 0f 8e 35 01 00 00 41 8b 04 24 4c
RSP: 0018:ffff8801b77bad28 EFLAGS: 00010806
RAX: 1ffffffff4004000 RBX: ffff8801cdcea6b0 RCX: ffffffff818b4099
RDX: 0000000000000000 RSI: ffffffff818b40a7 RDI: 0000000000000006
RBP: ffff8801b77baea0 R08: ffff8801d8730500 R09: 0000000000000001
R10: ffffed003b5c4732 R11: 0000000000000000 R12: ffffffffa0020000
R13: ffffffffffffffff R14: dffffc0000000000 R15: ffff8801cdcea6b0
FS:  0000000000000000(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffbfff4004000 CR3: 000000000946a000 CR4: 00000000001406f0
Call Trace:
BUG: unable to handle kernel paging request at fffffbfff4004000
PGD 21ffec067 P4D 21ffec067 PUD 21fe60067 PMD 1c1a04067 PTE 0
Oops: 0000 [#11] PREEMPT SMP KASAN
CPU: 0 PID: 5391 Comm: kworker/0:0 Not tainted 4.19.0-rc2+ #50
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events bpf_prog_free_deferred
RIP: 0010:bpf_get_prog_addr_region kernel/bpf/core.c:384 [inline]
RIP: 0010:bpf_tree_comp kernel/bpf/core.c:435 [inline]
RIP: 0010:__lt_find include/linux/rbtree_latch.h:115 [inline]
RIP: 0010:latch_tree_find include/linux/rbtree_latch.h:208 [inline]
RIP: 0010:bpf_prog_kallsyms_find+0x2fe/0x4a0 kernel/bpf/core.c:509
Code: 8e f3 ff 4c 8b ad b0 fe ff ff 4c 89 e6 4c 89 ef e8 47 8f f3 ff 4d 39  
e5 0f 82 a7 00 00 00 e8 89 8e f3 ff 4c 89 e0 48 c1 e8 03 <42> 0f b6 04 30  
84 c0 74 08 3c 03 0f 8e 35 01 00 00 41 8b 04 24 4c
RSP: 0018:ffff8801b77ba5c8 EFLAGS: 00010806
RAX: 1ffffffff4004000 RBX: ffff8801cdcea6b0 RCX: ffffffff818b4099
RDX: 0000000000000000 RSI: ffffffff818b40a7 RDI: 0000000000000006
RBP: ffff8801b77ba740 R08: ffff8801d8730500 R09: 0000000000000001
R10: ffffed003b5c4732 R11: 0000000000000000 R12: ffffffffa0020000
R13: ffffffffffffffff R14: dffffc0000000000 R15: ffff8801cdcea6b0
FS:  0000000000000000(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffbfff4004000 CR3: 000000000946a000 CR4: 00000000001406f0
Call Trace:
BUG: unable to handle kernel paging request at fffffbfff4004000
PGD 21ffec067 P4D 21ffec067 PUD 21fe60067 PMD 1c1a04067 PTE 0
Oops: 0000 [#12] PREEMPT SMP KASAN
CPU: 0 PID: 5391 Comm: kworker/0:0 Not tainted 4.19.0-rc2+ #50
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events bpf_prog_free_deferred
RIP: 0010:bpf_get_prog_addr_region kernel/bpf/core.c:384 [inline]
RIP: 0010:bpf_tree_comp kernel/bpf/core.c:435 [inline]
RIP: 0010:__lt_find include/linux/rbtree_latch.h:115 [inline]
RIP: 0010:latch_tree_find include/linux/rbtree_latch.h:208 [inline]
RIP: 0010:bpf_prog_kallsyms_find+0x2fe/0x4a0 kernel/bpf/core.c:509
Code: 8e f3 ff 4c 8b ad b0 fe ff ff 4c 89 e6 4c 89 ef e8 47 8f f3 ff 4d 39  
e5 0f 82 a7 00 00 00 e8 89 8e f3 ff 4c 89 e0 48 c1 e8 03 <42> 0f b6 04 30  
84 c0 74 08 3c 03 0f 8e 35 01 00 00 41 8b 04 24 4c
RSP: 0018:ffff8801b77b9e68 EFLAGS: 00010806
RAX: 1ffffffff4004000 RBX: ffff8801cdcea6b0 RCX: ffffffff818b4099
RDX: 0000000000000000 RSI: ffffffff818b40a7 RDI: 0000000000000006
RBP: ffff8801b77b9fe0 R08: ffff8801d8730500 R09: 0000000000000001
R10: ffffed003b5c4732 R11: 0000000000000000 R12: ffffffffa0020000
R13: ffffffffffffffff R14: dffffc0000000000 R15: ffff8801cdcea6b0
FS:  0000000000000000(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffbfff4004000 CR3: 000000000946a000 CR4: 00000000001406f0
Call Trace:
BUG: unable to handle kernel paging request at fffffbfff4004000
PGD 21ffec067 P4D 21ffec067 PUD 21fe60067 PMD 1c1a04067 PTE 0
Oops: 0000 [#13] PREEMPT SMP KASAN
CPU: 0 PID: 5391 Comm: kworker/0:0 Not tainted 4.19.0-rc2+ #50
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events bpf_prog_free_deferred
RIP: 0010:bpf_get_prog_addr_region kernel/bpf/core.c:384 [inline]
RIP: 0010:bpf_tree_comp kernel/bpf/core.c:435 [inline]
RIP: 0010:__lt_find include/linux/rbtree_latch.h:115 [inline]
RIP: 0010:latch_tree_find include/linux/rbtree_latch.h:208 [inline]
RIP: 0010:bpf_prog_kallsyms_find+0x2fe/0x4a0 kernel/bpf/core.c:509
Code: 8e f3 ff 4c 8b ad b0 fe ff ff 4c 89 e6 4c 89 ef e8 47 8f f3 ff 4d 39  
e5 0f 82 a7 00 00 00 e8 89 8e f3 ff 4c 89 e0 48 c1 e8 03 <42> 0f b6 04 30  
84 c0 74 08 3c 03 0f 8e 35 01 00 00 41 8b 04 24 4c
RSP: 0018:ffff8801b77b9708 EFLAGS: 00010806
RAX: 1ffffffff4004000 RBX: ffff8801cdcea6b0 RCX: ffffffff818b4099
RDX: 0000000000000000 RSI: ffffffff818b40a7 RDI: 0000000000000006
RBP: ffff8801b77b9880 R08: ffff8801d8730500 R09: 0000000000000001
R10: ffffed003b5c4732 R11: 0000000000000000 R12: ffffffffa0020000
R13: ffffffffffffffff R14: dffffc0000000000 R15: ffff8801cdcea6b0
FS:  0000000000000000(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffbfff4004000 CR3: 000000000946a000 CR4: 00000000001406f0
Call Trace:
BUG: unable to handle kernel paging request at fffffbfff4004000
PGD 21ffec067 P4D 21ffec067 PUD 21fe60067 PMD 1c1a04067 PTE 0
Thread overran stack, or stack corrupted
Oops: 0000 [#14] PREEMPT SMP KASAN
CPU: 0 PID: 5391 Comm: kworker/0:0 Not tainted 4.19.0-rc2+ #50
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events bpf_prog_free_deferred
RIP: 0010:bpf_get_prog_addr_region kernel/bpf/core.c:384 [inline]
RIP: 0010:bpf_tree_comp kernel/bpf/core.c:435 [inline]
RIP: 0010:__lt_find include/linux/rbtree_latch.h:115 [inline]
RIP: 0010:latch_tree_find include/linux/rbtree_latch.h:208 [inline]
RIP: 0010:bpf_prog_kallsyms_find+0x2fe/0x4a0 kernel/bpf/core.c:509
Code: 8e f3 ff 4c 8b ad b0 fe ff ff 4c 89 e6 4c 89 ef e8 47 8f f3 ff 4d 39  
e5 0f 82 a7 00 00 00 e8 89 8e f3 ff 4c 89 e0 48 c1 e8 03 <42> 0f b6 04 30  
84 c0 74 08 3c 03 0f 8e 35 01 00 00 41 8b 04 24 4c
RSP: 0018:ffff8801b77b8fa8 EFLAGS: 00010806
RAX: 1ffffffff4004000 RBX: ffff8801cdcea6b0 RCX: ffffffff818b4099
RDX: 0000000000000000 RSI: ffffffff818b40a7 RDI: 0000000000000006
RBP: ffff8801b77b9120 R08: ffff8801d8730500 R09: 0000000000000001
R10: ffffed003b5c4732 R11: 0000000000000000 R12: ffffffffa0020000
R13: ffffffffffffffff R14: dffffc0000000000 R15: ffff8801cdcea6b0
FS:  0000000000000000(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffbfff4004000 CR3: 000000000946a000 CR4: 00000000001406f0
Call Trace:
BUG: unable to handle kernel paging request at fffffbfff4004000
PGD 21ffec067 P4D 21ffec067 PUD 21fe60067 PMD 1c1a04067 PTE 0
Thread overran stack, or stack corrupted
Oops: 0000 [#15] PREEMPT SMP KASAN
CPU: 0 PID: 5391 Comm: kworker/0:0 Not tainted 4.19.0-rc2+ #50
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events bpf_prog_free_deferred
RIP: 0010:bpf_get_prog_addr_region kernel/bpf/core.c:384 [inline]
RIP: 0010:bpf_tree_comp kernel/bpf/core.c:435 [inline]
RIP: 0010:__lt_find include/linux/rbtree_latch.h:115 [inline]
RIP: 0010:latch_tree_find include/linux/rbtree_latch.h:208 [inline]
RIP: 0010:bpf_prog_kallsyms_find+0x2fe/0x4a0 kernel/bpf/core.c:509
Code: 8e f3 ff 4c 8b ad b0 fe ff ff 4c 89 e6 4c 89 ef e8 47 8f f3 ff 4d 39  
e5 0f 82 a7 00 00 00 e8 89 8e f3 ff 4c 89 e0 48 c1 e8 03 <42> 0f b6 04 30  
84 c0 74 08 3c 03 0f 8e 35 01 00 00 41 8b 04 24 4c
RSP: 0018:ffff8801b77b8848 EFLAGS: 00010806
RAX: 1ffffffff4004000 RBX: ffff8801cdcea6b0 RCX: ffffffff818b4099
RDX: 0000000000000000 RSI: ffffffff818b40a7 RDI: 0000000000000006
RBP: ffff8801b77b89c0 R08: ffff8801d8730500 R09: 0000000000000001
R10: ffffed003b5c4732 R11: 0000000000000000 R12: ffffffffa0020000
R13: ffffffffffffffff R14: dffffc0000000000 R15: ffff8801cdcea6b0
FS:  0000000000000000(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffbfff4004000 CR3: 000000000946a000 CR4: 00000000001406f0
Call Trace:
==================================================================
BUG: KASAN: slab-out-of-bounds in do_error_trap+0x3b6/0x4d0  
arch/x86/kernel/traps.c:296
Read of size 8 at addr ffff8801b77b7430 by task kworker/0:0/5391

CPU: 0 PID: 5391 Comm: kworker/0:0 Not tainted 4.19.0-rc2+ #50
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events bpf_prog_free_deferred
Call Trace:
BUG: unable to handle kernel paging request at fffffbfff4004000
PGD 21ffec067 P4D 21ffec067 PUD 21fe60067 PMD 1c1a04067 PTE 0
Thread overran stack, or stack corrupted
Oops: 0000 [#16] PREEMPT SMP KASAN
CPU: 0 PID: 5391 Comm: kworker/0:0 Not tainted 4.19.0-rc2+ #50
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events bpf_prog_free_deferred
RIP: 0010:bpf_get_prog_addr_region kernel/bpf/core.c:384 [inline]
RIP: 0010:bpf_tree_comp kernel/bpf/core.c:435 [inline]
RIP: 0010:__lt_find include/linux/rbtree_latch.h:115 [inline]
RIP: 0010:latch_tree_find include/linux/rbtree_latch.h:208 [inline]
RIP: 0010:bpf_prog_kallsyms_find+0x2fe/0x4a0 kernel/bpf/core.c:509
Code: 8e f3 ff 4c 8b ad b0 fe ff ff 4c 89 e6 4c 89 ef e8 47 8f f3 ff 4d 39  
e5 0f 82 a7 00 00 00 e8 89 8e f3 ff 4c 89 e0 48 c1 e8 03 <42> 0f b6 04 30  
84 c0 74 08 3c 03 0f 8e 35 01 00 00 41 8b 04 24 4c
RSP: 0018:ffff8801b77b6e58 EFLAGS: 00010806
RAX: 1ffffffff4004000 RBX: ffff8801cdcea6b0 RCX: ffffffff818b4099
RDX: 0000000000000000 RSI: ffffffff818b40a7 RDI: 0000000000000006
RBP: ffff8801b77b6fd0 R08: ffff8801d8730500 R09: 0000000000000001
R10: ffffed003b5c4732 R11: 0000000000000000 R12: ffffffffa0020000
R13: ffffffffffffffff R14: dffffc0000000000 R15: ffff8801cdcea6b0
FS:  0000000000000000(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffbfff4004000 CR3: 000000000946a000 CR4: 00000000001406f0
Call Trace:
Modules linked in:
Dumping ftrace buffer:
    (ftrace buffer empty)
CR2: fffffbfff4004000
---[ end trace 89eec6ca57f730dc ]---
RIP: 0010:bpf_get_prog_addr_region kernel/bpf/core.c:384 [inline]
RIP: 0010:bpf_tree_comp kernel/bpf/core.c:435 [inline]
RIP: 0010:__lt_find include/linux/rbtree_latch.h:115 [inline]
RIP: 0010:latch_tree_find include/linux/rbtree_latch.h:208 [inline]
RIP: 0010:bpf_prog_kallsyms_find+0x2fe/0x4a0 kernel/bpf/core.c:509
Code: 8e f3 ff 4c 8b ad b0 fe ff ff 4c 89 e6 4c 89 ef e8 47 8f f3 ff 4d 39  
e5 0f 82 a7 00 00 00 e8 89 8e f3 ff 4c 89 e0 48 c1 e8 03 <42> 0f b6 04 30  
84 c0 74 08 3c 03 0f 8e 35 01 00 00 41 8b 04 24 4c
RSP: 0018:ffff8801b77bef80 EFLAGS: 00010806
RAX: 1ffffffff4004000 RBX: ffff8801cdcea6b0 RCX: ffffffff818b4099
RDX: 0000000000000000 RSI: ffffffff818b40a7 RDI: 0000000000000006
RBP: ffff8801b77bf0f8 R08: ffff8801d8730500 R09: ffffed003b5c4732
R10: ffffed003b5c4732 R11: ffff8801dae23993 R12: ffffffffa0020000
R13: ffffffffffffffff R14: dffffc0000000000 R15: ffff8801cdcea6b0
FS:  0000000000000000(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffbfff4004000 CR3: 000000000946a000 CR4: 00000000001406f0

