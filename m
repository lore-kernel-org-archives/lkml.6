Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26ED9C43610
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 18:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDAF02080C
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 18:49:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDAF02080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbeKSFKH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 00:10:07 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:54439 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbeKSFKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 00:10:06 -0500
Received: by mail-io1-f70.google.com with SMTP id f24so6516817ioh.21
        for <linux-kernel@vger.kernel.org>; Sun, 18 Nov 2018 10:49:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=MCmdvRxhl4UhMh53jIlFak6estwXP1aV5eemtvtlDsI=;
        b=R3z1/+M+4D4CF4WvJNJgVNhO0AjEP16wMHo8e6N1tItJ+z2kZz3t7KsP8a+GxghSkY
         0u4bt9HDYE49Z7Tdi5AjI2SefFoTlOykNIDvVxFV35Hw+iykpWVc4wUb+xaBOUFl07sX
         amoeQFw6gKsGfgmSmSh39P34+64sozAnHhmb7PiPEKK4tP/ZkNxxfKQuOUVPz4uHcKkl
         SkmhozbZUPNbg/OF13nwkeTR+VkzoKxSWfOK6V19fF00qw8U236nlVWwNmTlcaerHslL
         CiCrNDae4u2yUj6a/DU/OgxRnmAdYm/jgUxz8xJmasiWrijIqYInhhRNJl3l8hknu7pa
         nh0g==
X-Gm-Message-State: AGRZ1gIZGncSrF+4cdYtdCc9G4SQcOqDrUkhbRVgOnbPK4wxbpUbtT8e
        KpddXP/usw7s2QfkIwnxVQqS2uj9by26k1/yy5OZzGQIdd15
X-Google-Smtp-Source: AFSGD/VP1q+hZI8ij3NZNsVIwq980i7HINQenUEsv/KFbweHEtwfQ2jQ7H1Dk2/T+oQ2HRDgvokkWSv9G9/qkDfDUHBq1Y/T1MLM
MIME-Version: 1.0
X-Received: by 2002:a24:1f0f:: with SMTP id d15mr5240589itd.31.1542566943751;
 Sun, 18 Nov 2018 10:49:03 -0800 (PST)
Date:   Sun, 18 Nov 2018 10:49:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b99324057af4dabb@google.com>
Subject: BUG: unable to handle kernel paging request in bpf_prog_kallsyms_find
From:   syzbot <syzbot+66d6b1d3055f1d9ee4f3@syzkaller.appspotmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    592ee43faf86 bpf: fix null pointer dereference on pointer ..
git tree:       bpf-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1211f2d5400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7e5cbc38ae27657e
dashboard link: https://syzkaller.appspot.com/bug?extid=66d6b1d3055f1d9ee4f3
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10e4ec25400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+66d6b1d3055f1d9ee4f3@syzkaller.appspotmail.com

BUG: unable to handle kernel paging request at ffffc90001933030
PGD 1da95a067 P4D 1da95a067 PUD 1da95b067 PMD 1d4203067 PTE 0
Oops: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 13017 Comm: blkid Not tainted 4.20.0-rc1+ #144
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:bpf_prog_ebpf_jited include/linux/filter.h:885 [inline]
RIP: 0010:bpf_get_prog_addr_region kernel/bpf/core.c:384 [inline]
RIP: 0010:bpf_tree_comp kernel/bpf/core.c:438 [inline]
RIP: 0010:__lt_find include/linux/rbtree_latch.h:115 [inline]
RIP: 0010:latch_tree_find include/linux/rbtree_latch.h:208 [inline]
RIP: 0010:bpf_prog_kallsyms_find+0x289/0x4a0 kernel/bpf/core.c:512
Code: 03 42 80 3c 30 00 0f 85 b1 01 00 00 4d 8b 6f 50 49 8d 7d 30 48 89 fa  
48 c1 ea 03 42 80 3c 32 00 0f 85 ab 01 00 00 49 8d 7d 02 <4d> 8b 65 30 48  
89 fa 48 89 f9 48 c1 ea 03 83 e1 07 42 0f b6 14 32
RSP: 0018:ffff8801b1126bc8 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffff8801d54e0a30 RCX: ffffffff818c0a21
RDX: 1ffff92000326606 RSI: 0000000000000008 RDI: ffffc90001933002
RBP: ffff8801b1126d40 R08: ffff8801c2ac4040 R09: 0000000000000000
R10: ffffed003b5c5b67 R11: ffff8801dae2db3b R12: 0000000000000000
R13: ffffc90001933000 R14: dffffc0000000000 R15: ffff8801d54e0a30
FS:  00007fe237cd5740(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc90001933030 CR3: 00000001b96da000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
BUG: unable to handle kernel paging request at ffffc90001933030
PGD 1da95a067 P4D 1da95a067 PUD 1da95b067 PMD 1d4203067 PTE 0
Oops: 0000 [#2] PREEMPT SMP KASAN
CPU: 0 PID: 13017 Comm: blkid Not tainted 4.20.0-rc1+ #144
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:bpf_prog_ebpf_jited include/linux/filter.h:885 [inline]
RIP: 0010:bpf_get_prog_addr_region kernel/bpf/core.c:384 [inline]
RIP: 0010:bpf_tree_comp kernel/bpf/core.c:438 [inline]
RIP: 0010:__lt_find include/linux/rbtree_latch.h:115 [inline]
RIP: 0010:latch_tree_find include/linux/rbtree_latch.h:208 [inline]
RIP: 0010:bpf_prog_kallsyms_find+0x289/0x4a0 kernel/bpf/core.c:512
Code: 03 42 80 3c 30 00 0f 85 b1 01 00 00 4d 8b 6f 50 49 8d 7d 30 48 89 fa  
48 c1 ea 03 42 80 3c 32 00 0f 85 ab 01 00 00 49 8d 7d 02 <4d> 8b 65 30 48  
89 fa 48 89 f9 48 c1 ea 03 83 e1 07 42 0f b6 14 32
RSP: 0018:ffff8801b11264d8 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffff8801d54e0a30 RCX: ffffffff818c0a21
RDX: 1ffff92000326606 RSI: 0000000000000008 RDI: ffffc90001933002
RBP: ffff8801b1126650 R08: ffff8801c2ac4040 R09: 0000000000000000
R10: ffffed003b5c5b67 R11: ffff8801dae2db3b R12: 0000000000000000
R13: ffffc90001933000 R14: dffffc0000000000 R15: ffff8801d54e0a30
FS:  00007fe237cd5740(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc90001933030 CR3: 00000001b96da000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
BUG: unable to handle kernel paging request at ffffc90001933030
PGD 1da95a067 P4D 1da95a067 PUD 1da95b067 PMD 1d4203067 PTE 0
Oops: 0000 [#3] PREEMPT SMP KASAN
CPU: 0 PID: 13017 Comm: blkid Not tainted 4.20.0-rc1+ #144
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:bpf_prog_ebpf_jited include/linux/filter.h:885 [inline]
RIP: 0010:bpf_get_prog_addr_region kernel/bpf/core.c:384 [inline]
RIP: 0010:bpf_tree_comp kernel/bpf/core.c:438 [inline]
RIP: 0010:__lt_find include/linux/rbtree_latch.h:115 [inline]
RIP: 0010:latch_tree_find include/linux/rbtree_latch.h:208 [inline]
RIP: 0010:bpf_prog_kallsyms_find+0x289/0x4a0 kernel/bpf/core.c:512
Code: 03 42 80 3c 30 00 0f 85 b1 01 00 00 4d 8b 6f 50 49 8d 7d 30 48 89 fa  
48 c1 ea 03 42 80 3c 32 00 0f 85 ab 01 00 00 49 8d 7d 02 <4d> 8b 65 30 48  
89 fa 48 89 f9 48 c1 ea 03 83 e1 07 42 0f b6 14 32
RSP: 0018:ffff8801b1125de8 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffff8801d54e0a30 RCX: ffffffff818c0a21
RDX: 1ffff92000326606 RSI: 0000000000000008 RDI: ffffc90001933002
RBP: ffff8801b1125f60 R08: ffff8801c2ac4040 R09: 0000000000000000
R10: ffffed003b5c5b67 R11: ffff8801dae2db3b R12: 0000000000000000
R13: ffffc90001933000 R14: dffffc0000000000 R15: ffff8801d54e0a30
FS:  00007fe237cd5740(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc90001933030 CR3: 00000001b96da000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
BUG: unable to handle kernel paging request at ffffc90001933030
PGD 1da95a067 P4D 1da95a067 PUD 1da95b067 PMD 1d4203067 PTE 0
Oops: 0000 [#4] PREEMPT SMP KASAN
CPU: 0 PID: 13017 Comm: blkid Not tainted 4.20.0-rc1+ #144
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:bpf_prog_ebpf_jited include/linux/filter.h:885 [inline]
RIP: 0010:bpf_get_prog_addr_region kernel/bpf/core.c:384 [inline]
RIP: 0010:bpf_tree_comp kernel/bpf/core.c:438 [inline]
RIP: 0010:__lt_find include/linux/rbtree_latch.h:115 [inline]
RIP: 0010:latch_tree_find include/linux/rbtree_latch.h:208 [inline]
RIP: 0010:bpf_prog_kallsyms_find+0x289/0x4a0 kernel/bpf/core.c:512
Code: 03 42 80 3c 30 00 0f 85 b1 01 00 00 4d 8b 6f 50 49 8d 7d 30 48 89 fa  
48 c1 ea 03 42 80 3c 32 00 0f 85 ab 01 00 00 49 8d 7d 02 <4d> 8b 65 30 48  
89 fa 48 89 f9 48 c1 ea 03 83 e1 07 42 0f b6 14 32
RSP: 0018:ffff8801b11256f8 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffff8801d54e0a30 RCX: ffffffff818c0a21
RDX: 1ffff92000326606 RSI: 0000000000000008 RDI: ffffc90001933002
RBP: ffff8801b1125870 R08: ffff8801c2ac4040 R09: 0000000000000000
R10: ffffed003b5c5b67 R11: ffff8801dae2db3b R12: 0000000000000000
R13: ffffc90001933000 R14: dffffc0000000000 R15: ffff8801d54e0a30
FS:  00007fe237cd5740(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc90001933030 CR3: 00000001b96da000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
BUG: unable to handle kernel paging request at ffffc90001933030
PGD 1da95a067 P4D 1da95a067 PUD 1da95b067 PMD 1d4203067 PTE 0
Oops: 0000 [#5] PREEMPT SMP KASAN
CPU: 0 PID: 13017 Comm: blkid Not tainted 4.20.0-rc1+ #144
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:bpf_prog_ebpf_jited include/linux/filter.h:885 [inline]
RIP: 0010:bpf_get_prog_addr_region kernel/bpf/core.c:384 [inline]
RIP: 0010:bpf_tree_comp kernel/bpf/core.c:438 [inline]
RIP: 0010:__lt_find include/linux/rbtree_latch.h:115 [inline]
RIP: 0010:latch_tree_find include/linux/rbtree_latch.h:208 [inline]
RIP: 0010:bpf_prog_kallsyms_find+0x289/0x4a0 kernel/bpf/core.c:512
Code: 03 42 80 3c 30 00 0f 85 b1 01 00 00 4d 8b 6f 50 49 8d 7d 30 48 89 fa  
48 c1 ea 03 42 80 3c 32 00 0f 85 ab 01 00 00 49 8d 7d 02 <4d> 8b 65 30 48  
89 fa 48 89 f9 48 c1 ea 03 83 e1 07 42 0f b6 14 32
RSP: 0018:ffff8801b1125008 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffff8801d54e0a30 RCX: ffffffff818c0a21
RDX: 1ffff92000326606 RSI: 0000000000000008 RDI: ffffc90001933002
RBP: ffff8801b1125180 R08: ffff8801c2ac4040 R09: 0000000000000000
R10: ffffed003b5c5b67 R11: ffff8801dae2db3b R12: 0000000000000000
R13: ffffc90001933000 R14: dffffc0000000000 R15: ffff8801d54e0a30
FS:  00007fe237cd5740(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc90001933030 CR3: 00000001b96da000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
BUG: unable to handle kernel paging request at ffffc90001933030
PGD 1da95a067 P4D 1da95a067 PUD 1da95b067 PMD 1d4203067 PTE 0
Oops: 0000 [#6] PREEMPT SMP KASAN
CPU: 0 PID: 13017 Comm: blkid Not tainted 4.20.0-rc1+ #144
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:bpf_prog_ebpf_jited include/linux/filter.h:885 [inline]
RIP: 0010:bpf_get_prog_addr_region kernel/bpf/core.c:384 [inline]
RIP: 0010:bpf_tree_comp kernel/bpf/core.c:438 [inline]
RIP: 0010:__lt_find include/linux/rbtree_latch.h:115 [inline]
RIP: 0010:latch_tree_find include/linux/rbtree_latch.h:208 [inline]
RIP: 0010:bpf_prog_kallsyms_find+0x289/0x4a0 kernel/bpf/core.c:512
Code: 03 42 80 3c 30 00 0f 85 b1 01 00 00 4d 8b 6f 50 49 8d 7d 30 48 89 fa  
48 c1 ea 03 42 80 3c 32 00 0f 85 ab 01 00 00 49 8d 7d 02 <4d> 8b 65 30 48  
89 fa 48 89 f9 48 c1 ea 03 83 e1 07 42 0f b6 14 32
RSP: 0018:ffff8801b1124918 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffff8801d54e0a30 RCX: ffffffff818c0a21
RDX: 1ffff92000326606 RSI: 0000000000000008 RDI: ffffc90001933002
RBP: ffff8801b1124a90 R08: ffff8801c2ac4040 R09: 0000000000000000
R10: ffffed003b5c5b67 R11: ffff8801dae2db3b R12: 0000000000000000
R13: ffffc90001933000 R14: dffffc0000000000 R15: ffff8801d54e0a30
FS:  00007fe237cd5740(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc90001933030 CR3: 00000001b96da000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
BUG: unable to handle kernel paging request at ffffc90001933030
PGD 1da95a067 P4D 1da95a067 PUD 1da95b067 PMD 1d4203067 PTE 0
Oops: 0000 [#7] PREEMPT SMP KASAN
CPU: 0 PID: 13017 Comm: blkid Not tainted 4.20.0-rc1+ #144
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:bpf_prog_ebpf_jited include/linux/filter.h:885 [inline]
RIP: 0010:bpf_get_prog_addr_region kernel/bpf/core.c:384 [inline]
RIP: 0010:bpf_tree_comp kernel/bpf/core.c:438 [inline]
RIP: 0010:__lt_find include/linux/rbtree_latch.h:115 [inline]
RIP: 0010:latch_tree_find include/linux/rbtree_latch.h:208 [inline]
RIP: 0010:bpf_prog_kallsyms_find+0x289/0x4a0 kernel/bpf/core.c:512
Code: 03 42 80 3c 30 00 0f 85 b1 01 00 00 4d 8b 6f 50 49 8d 7d 30 48 89 fa  
48 c1 ea 03 42 80 3c 32 00 0f 85 ab 01 00 00 49 8d 7d 02 <4d> 8b 65 30 48  
89 fa 48 89 f9 48 c1 ea 03 83 e1 07 42 0f b6 14 32
RSP: 0018:ffff8801b1124228 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffff8801d54e0a30 RCX: ffffffff818c0a21
RDX: 1ffff92000326606 RSI: 0000000000000008 RDI: ffffc90001933002
RBP: ffff8801b11243a0 R08: ffff8801c2ac4040 R09: 0000000000000000
R10: ffffed003b5c5b67 R11: ffff8801dae2db3b R12: 0000000000000000
R13: ffffc90001933000 R14: dffffc0000000000 R15: ffff8801d54e0a30
FS:  00007fe237cd5740(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc90001933030 CR3: 00000001b96da000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
BUG: unable to handle kernel paging request at ffffc90001933030
PGD 1da95a067 P4D 1da95a067 PUD 1da95b067 PMD 1d4203067 PTE 0
Oops: 0000 [#8] PREEMPT SMP KASAN
CPU: 0 PID: 13017 Comm: blkid Not tainted 4.20.0-rc1+ #144
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:bpf_prog_ebpf_jited include/linux/filter.h:885 [inline]
RIP: 0010:bpf_get_prog_addr_region kernel/bpf/core.c:384 [inline]
RIP: 0010:bpf_tree_comp kernel/bpf/core.c:438 [inline]
RIP: 0010:__lt_find include/linux/rbtree_latch.h:115 [inline]
RIP: 0010:latch_tree_find include/linux/rbtree_latch.h:208 [inline]
RIP: 0010:bpf_prog_kallsyms_find+0x289/0x4a0 kernel/bpf/core.c:512
Code: 03 42 80 3c 30 00 0f 85 b1 01 00 00 4d 8b 6f 50 49 8d 7d 30 48 89 fa  
48 c1 ea 03 42 80 3c 32 00 0f 85 ab 01 00 00 49 8d 7d 02 <4d> 8b 65 30 48  
89 fa 48 89 f9 48 c1 ea 03 83 e1 07 42 0f b6 14 32
RSP: 0018:ffff8801b1123b38 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffff8801d54e0a30 RCX: ffffffff818c0a21
RDX: 1ffff92000326606 RSI: 0000000000000008 RDI: ffffc90001933002
RBP: ffff8801b1123cb0 R08: ffff8801c2ac4040 R09: 0000000000000000
R10: ffffed003b5c5b67 R11: ffff8801dae2db3b R12: 0000000000000000
R13: ffffc90001933000 R14: dffffc0000000000 R15: ffff8801d54e0a30
FS:  00007fe237cd5740(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc90001933030 CR3: 00000001b96da000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
BUG: unable to handle kernel paging request at ffffc90001933030
PGD 1da95a067 P4D 1da95a067 PUD 1da95b067 PMD 1d4203067 PTE 0
Oops: 0000 [#9] PREEMPT SMP KASAN
CPU: 0 PID: 13017 Comm: blkid Not tainted 4.20.0-rc1+ #144
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:bpf_prog_ebpf_jited include/linux/filter.h:885 [inline]
RIP: 0010:bpf_get_prog_addr_region kernel/bpf/core.c:384 [inline]
RIP: 0010:bpf_tree_comp kernel/bpf/core.c:438 [inline]
RIP: 0010:__lt_find include/linux/rbtree_latch.h:115 [inline]
RIP: 0010:latch_tree_find include/linux/rbtree_latch.h:208 [inline]
RIP: 0010:bpf_prog_kallsyms_find+0x289/0x4a0 kernel/bpf/core.c:512
Code: 03 42 80 3c 30 00 0f 85 b1 01 00 00 4d 8b 6f 50 49 8d 7d 30 48 89 fa  
48 c1 ea 03 42 80 3c 32 00 0f 85 ab 01 00 00 49 8d 7d 02 <4d> 8b 65 30 48  
89 fa 48 89 f9 48 c1 ea 03 83 e1 07 42 0f b6 14 32
RSP: 0018:ffff8801b1123448 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffff8801d54e0a30 RCX: ffffffff818c0a21
RDX: 1ffff92000326606 RSI: 0000000000000008 RDI: ffffc90001933002
RBP: ffff8801b11235c0 R08: ffff8801c2ac4040 R09: 0000000000000000
R10: ffffed003b5c5b67 R11: ffff8801dae2db3b R12: 0000000000000000
R13: ffffc90001933000 R14: dffffc0000000000 R15: ffff8801d54e0a30
FS:  00007fe237cd5740(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc90001933030 CR3: 00000001b96da000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
BUG: unable to handle kernel paging request at ffffc90001933030
PGD 1da95a067 P4D 1da95a067 PUD 1da95b067 PMD 1d4203067 PTE 0
Oops: 0000 [#10] PREEMPT SMP KASAN
CPU: 0 PID: 13017 Comm: blkid Not tainted 4.20.0-rc1+ #144
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:bpf_prog_ebpf_jited include/linux/filter.h:885 [inline]
RIP: 0010:bpf_get_prog_addr_region kernel/bpf/core.c:384 [inline]
RIP: 0010:bpf_tree_comp kernel/bpf/core.c:438 [inline]
RIP: 0010:__lt_find include/linux/rbtree_latch.h:115 [inline]
RIP: 0010:latch_tree_find include/linux/rbtree_latch.h:208 [inline]
RIP: 0010:bpf_prog_kallsyms_find+0x289/0x4a0 kernel/bpf/core.c:512
Code: 03 42 80 3c 30 00 0f 85 b1 01 00 00 4d 8b 6f 50 49 8d 7d 30 48 89 fa  
48 c1 ea 03 42 80 3c 32 00 0f 85 ab 01 00 00 49 8d 7d 02 <4d> 8b 65 30 48  
89 fa 48 89 f9 48 c1 ea 03 83 e1 07 42 0f b6 14 32
RSP: 0018:ffff8801b1122d58 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffff8801d54e0a30 RCX: ffffffff818c0a21
RDX: 1ffff92000326606 RSI: 0000000000000008 RDI: ffffc90001933002
RBP: ffff8801b1122ed0 R08: ffff8801c2ac4040 R09: 0000000000000000
R10: ffffed003b5c5b67 R11: ffff8801dae2db3b R12: 0000000000000000
R13: ffffc90001933000 R14: dffffc0000000000 R15: ffff8801d54e0a30
FS:  00007fe237cd5740(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc90001933030 CR3: 00000001b96da000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
BUG: unable to handle kernel paging request at ffffc90001933030
PGD 1da95a067 P4D 1da95a067 PUD 1da95b067 PMD 1d4203067 PTE 0
Oops: 0000 [#11] PREEMPT SMP KASAN
CPU: 0 PID: 13017 Comm: blkid Not tainted 4.20.0-rc1+ #144
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:bpf_prog_ebpf_jited include/linux/filter.h:885 [inline]
RIP: 0010:bpf_get_prog_addr_region kernel/bpf/core.c:384 [inline]
RIP: 0010:bpf_tree_comp kernel/bpf/core.c:438 [inline]
RIP: 0010:__lt_find include/linux/rbtree_latch.h:115 [inline]
RIP: 0010:latch_tree_find include/linux/rbtree_latch.h:208 [inline]
RIP: 0010:bpf_prog_kallsyms_find+0x289/0x4a0 kernel/bpf/core.c:512
Code: 03 42 80 3c 30 00 0f 85 b1 01 00 00 4d 8b 6f 50 49 8d 7d 30 48 89 fa  
48 c1 ea 03 42 80 3c 32 00 0f 85 ab 01 00 00 49 8d 7d 02 <4d> 8b 65 30 48  
89 fa 48 89 f9 48 c1 ea 03 83 e1 07 42 0f b6 14 32
RSP: 0018:ffff8801b1122668 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffff8801d54e0a30 RCX: ffffffff818c0a21
RDX: 1ffff92000326606 RSI: 0000000000000008 RDI: ffffc90001933002
RBP: ffff8801b11227e0 R08: ffff8801c2ac4040 R09: 0000000000000000
R10: ffffed003b5c5b67 R11: ffff8801dae2db3b R12: 0000000000000000
R13: ffffc90001933000 R14: dffffc0000000000 R15: ffff8801d54e0a30
FS:  00007fe237cd5740(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc90001933030 CR3: 00000001b96da000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
BUG: unable to handle kernel paging request at ffffc90001933030
PGD 1da95a067 P4D 1da95a067 PUD 1da95b067 PMD 1d4203067 PTE 0
Oops: 0000 [#12] PREEMPT SMP KASAN
CPU: 0 PID: 13017 Comm: blkid Not tainted 4.20.0-rc1+ #144
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:bpf_prog_ebpf_jited include/linux/filter.h:885 [inline]
RIP: 0010:bpf_get_prog_addr_region kernel/bpf/core.c:384 [inline]
RIP: 0010:bpf_tree_comp kernel/bpf/core.c:438 [inline]
RIP: 0010:__lt_find include/linux/rbtree_latch.h:115 [inline]
RIP: 0010:latch_tree_find include/linux/rbtree_latch.h:208 [inline]
RIP: 0010:bpf_prog_kallsyms_find+0x289/0x4a0 kernel/bpf/core.c:512
Code: 03 42 80 3c 30 00 0f 85 b1 01 00 00 4d 8b 6f 50 49 8d 7d 30 48 89 fa  
48 c1 ea 03 42 80 3c 32 00 0f 85 ab 01 00 00 49 8d 7d 02 <4d> 8b 65 30 48  
89 fa 48 89 f9 48 c1 ea 03 83 e1 07 42 0f b6 14 32
RSP: 0018:ffff8801b1121f78 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffff8801d54e0a30 RCX: ffffffff818c0a21
RDX: 1ffff92000326606 RSI: 0000000000000008 RDI: ffffc90001933002
RBP: ffff8801b11220f0 R08: ffff8801c2ac4040 R09: 0000000000000000
R10: ffffed003b5c5b67 R11: ffff8801dae2db3b R12: 0000000000000000
R13: ffffc90001933000 R14: dffffc0000000000 R15: ffff8801d54e0a30
FS:  00007fe237cd5740(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc90001933030 CR3: 00000001b96da000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
BUG: unable to handle kernel paging request at ffffc90001933030
PGD 1da95a067 P4D 1da95a067 PUD 1da95b067 PMD 1d4203067 PTE 0
Oops: 0000 [#13] PREEMPT SMP KASAN
CPU: 0 PID: 13017 Comm: blkid Not tainted 4.20.0-rc1+ #144
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:bpf_prog_ebpf_jited include/linux/filter.h:885 [inline]
RIP: 0010:bpf_get_prog_addr_region kernel/bpf/core.c:384 [inline]
RIP: 0010:bpf_tree_comp kernel/bpf/core.c:438 [inline]
RIP: 0010:__lt_find include/linux/rbtree_latch.h:115 [inline]
RIP: 0010:latch_tree_find include/linux/rbtree_latch.h:208 [inline]
RIP: 0010:bpf_prog_kallsyms_find+0x289/0x4a0 kernel/bpf/core.c:512
Code: 03 42 80 3c 30 00 0f 85 b1 01 00 00 4d 8b 6f 50 49 8d 7d 30 48 89 fa  
48 c1 ea 03 42 80 3c 32 00 0f 85 ab 01 00 00 49 8d 7d 02 <4d> 8b 65 30 48  
89 fa 48 89 f9 48 c1 ea 03 83 e1 07 42 0f b6 14 32
RSP: 0018:ffff8801b1121888 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffff8801d54e0a30 RCX: ffffffff818c0a21
RDX: 1ffff92000326606 RSI: 0000000000000008 RDI: ffffc90001933002
RBP: ffff8801b1121a00 R08: ffff8801c2ac4040 R09: 0000000000000000
R10: ffffed003b5c5b67 R11: ffff8801dae2db3b R12: 0000000000000000
R13: ffffc90001933000 R14: dffffc0000000000 R15: ffff8801d54e0a30
FS:  00007fe237cd5740(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc90001933030 CR3: 00000001b96da000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
BUG: unable to handle kernel paging request at ffffc90001933030
PGD 1da95a067 P4D 1da95a067 PUD 1da95b067 PMD 1d4203067 PTE 0
Oops: 0000 [#14] PREEMPT SMP KASAN
CPU: 0 PID: 13017 Comm: blkid Not tainted 4.20.0-rc1+ #144
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:bpf_prog_ebpf_jited include/linux/filter.h:885 [inline]
RIP: 0010:bpf_get_prog_addr_region kernel/bpf/core.c:384 [inline]
RIP: 0010:bpf_tree_comp kernel/bpf/core.c:438 [inline]
RIP: 0010:__lt_find include/linux/rbtree_latch.h:115 [inline]
RIP: 0010:latch_tree_find include/linux/rbtree_latch.h:208 [inline]
RIP: 0010:bpf_prog_kallsyms_find+0x289/0x4a0 kernel/bpf/core.c:512
Code: 03 42 80 3c 30 00 0f 85 b1 01 00 00 4d 8b 6f 50 49 8d 7d 30 48 89 fa  
48 c1 ea 03 42 80 3c 32 00 0f 85 ab 01 00 00 49 8d 7d 02 <4d> 8b 65 30 48  
89 fa 48 89 f9 48 c1 ea 03 83 e1 07 42 0f b6 14 32
RSP: 0018:ffff8801b1121198 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffff8801d54e0a30 RCX: ffffffff818c0a21
RDX: 1ffff92000326606 RSI: 0000000000000008 RDI: ffffc90001933002
RBP: ffff8801b1121310 R08: ffff8801c2ac4040 R09: 0000000000000000
R10: ffffed003b5c5b67 R11: ffff8801dae2db3b R12: 0000000000000000
R13: ffffc90001933000 R14: dffffc0000000000 R15: ffff8801d54e0a30
FS:  00007fe237cd5740(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc90001933030 CR3: 00000001b96da000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
BUG: unable to handle kernel paging request at ffffc90001933030
PGD 1da95a067 P4D 1da95a067 PUD 1da95b067 PMD 1d4203067 PTE 0
Thread overran stack, or stack corrupted
Oops: 0000 [#15] PREEMPT SMP KASAN
CPU: 0 PID: 13017 Comm: blkid Not tainted 4.20.0-rc1+ #144
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:bpf_prog_ebpf_jited include/linux/filter.h:885 [inline]
RIP: 0010:bpf_get_prog_addr_region kernel/bpf/core.c:384 [inline]
RIP: 0010:bpf_tree_comp kernel/bpf/core.c:438 [inline]
RIP: 0010:__lt_find include/linux/rbtree_latch.h:115 [inline]
RIP: 0010:latch_tree_find include/linux/rbtree_latch.h:208 [inline]
RIP: 0010:bpf_prog_kallsyms_find+0x289/0x4a0 kernel/bpf/core.c:512
Code: 03 42 80 3c 30 00 0f 85 b1 01 00 00 4d 8b 6f 50 49 8d 7d 30 48 89 fa  
48 c1 ea 03 42 80 3c 32 00 0f 85 ab 01 00 00 49 8d 7d 02 <4d> 8b 65 30 48  
89 fa 48 89 f9 48 c1 ea 03 83 e1 07 42 0f b6 14 32
RSP: 0018:ffff8801b1120aa8 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffff8801d54e0a30 RCX: ffffffff818c0a21
RDX: 1ffff92000326606 RSI: 0000000000000008 RDI: ffffc90001933002
RBP: ffff8801b1120c20 R08: ffff8801c2ac4040 R09: 0000000000000000
R10: ffffed003b5c5b67 R11: ffff8801dae2db3b R12: 0000000000000000
R13: ffffc90001933000 R14: dffffc0000000000 R15: ffff8801d54e0a30
FS:  00007fe237cd5740(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc90001933030 CR3: 00000001b96da000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
------------[ cut here ]------------
kernel BUG at mm/slab.c:4425!
invalid opcode: 0000 [#16] PREEMPT SMP KASAN
CPU: 0 PID: 13017 Comm: blkid Not tainted 4.20.0-rc1+ #144
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:__check_heap_object+0xa7/0xb5 mm/slab.c:4450
Code: 48 c7 c7 d5 b7 14 89 e8 97 e3 0a 00 5d c3 41 8b 91 04 01 00 00 48 29  
c7 48 39 d7 77 be 48 01 d0 48 29 c8 48 39 f0 72 b3 5d c3 <0f> 0b 48 c7 c7  
d5 b7 14 89 e8 fd eb 0a 00 44 89 e9 48 c7 c7 90 b8
RSP: 0018:ffff8801b111fd38 EFLAGS: 00010046
RAX: 0000000000000001 RBX: 1ffff10036223fae RCX: 000000000000000c
RDX: ffff8801b111ed80 RSI: 0000000000000001 RDI: ffff8801b111ff18
RBP: ffff8801b111fd38 R08: ffff8801c2ac4040 R09: ffff8801da980e00
R10: 0000000000000f86 R11: 0000000000000000 R12: ffff8801b111ff18
R13: 0000000000000001 R14: ffffea0006c44780 R15: 0000000000000001
FS:  00007fe237cd5740(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc90001933030 CR3: 00000001b96da000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
BUG: unable to handle kernel paging request at ffffc90001933030
PGD 1da95a067 P4D 1da95a067 PUD 1da95b067 PMD 1d4203067 PTE 0
Thread overran stack, or stack corrupted
Oops: 0000 [#17] PREEMPT SMP KASAN
CPU: 0 PID: 13017 Comm: blkid Not tainted 4.20.0-rc1+ #144
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:bpf_prog_ebpf_jited include/linux/filter.h:885 [inline]
RIP: 0010:bpf_get_prog_addr_region kernel/bpf/core.c:384 [inline]
RIP: 0010:bpf_tree_comp kernel/bpf/core.c:438 [inline]
RIP: 0010:__lt_find include/linux/rbtree_latch.h:115 [inline]
RIP: 0010:latch_tree_find include/linux/rbtree_latch.h:208 [inline]
RIP: 0010:bpf_prog_kallsyms_find+0x289/0x4a0 kernel/bpf/core.c:512
Code: 03 42 80 3c 30 00 0f 85 b1 01 00 00 4d 8b 6f 50 49 8d 7d 30 48 89 fa  
48 c1 ea 03 42 80 3c 32 00 0f 85 ab 01 00 00 49 8d 7d 02 <4d> 8b 65 30 48  
89 fa 48 89 f9 48 c1 ea 03 83 e1 07 42 0f b6 14 32
RSP: 0018:ffff8801b111f880 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffff8801d54e0a30 RCX: ffffffff818c0a21
RDX: 1ffff92000326606 RSI: 0000000000000008 RDI: ffffc90001933002
RBP: ffff8801b111f9f8 R08: ffff8801c2ac4040 R09: 0000000000000000
R10: ffffed003b5c5b67 R11: ffff8801dae2db3b R12: 0000000000000000
R13: ffffc90001933000 R14: dffffc0000000000 R15: ffff8801d54e0a30
FS:  00007fe237cd5740(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc90001933030 CR3: 00000001b96da000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
------------[ cut here ]------------
kernel BUG at mm/slab.c:4425!
invalid opcode: 0000 [#18] PREEMPT SMP KASAN
CPU: 0 PID: 13017 Comm: blkid Not tainted 4.20.0-rc1+ #144
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:__check_heap_object+0xa7/0xb5 mm/slab.c:4450
Code: 48 c7 c7 d5 b7 14 89 e8 97 e3 0a 00 5d c3 41 8b 91 04 01 00 00 48 29  
c7 48 39 d7 77 be 48 01 d0 48 29 c8 48 39 f0 72 b3 5d c3 <0f> 0b 48 c7 c7  
d5 b7 14 89 e8 fd eb 0a 00 44 89 e9 48 c7 c7 90 b8
RSP: 0018:ffff8801b111d300 EFLAGS: 00010046
RAX: 0000000000000001 RBX: 1ffff10036223a67 RCX: 000000000000000c
RDX: ffff8801b111c200 RSI: 0000000000000002 RDI: ffff8801b111d4a8
RBP: ffff8801b111d300 R08: ffff8801c2ac4040 R09: ffff8801da980e00
R10: 0000000000001076 R11: 0000000000000000 R12: ffff8801b111d4a8
R13: 0000000000000002 R14: ffffea0006c44700 R15: 0000000000000001
FS:  00007fe237cd5740(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc90001933030 CR3: 00000001b96da000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
Modules linked in:
---[ end trace 53dd6c86d14a98c0 ]---
RIP: 0010:bpf_prog_ebpf_jited include/linux/filter.h:885 [inline]
RIP: 0010:bpf_get_prog_addr_region kernel/bpf/core.c:384 [inline]
RIP: 0010:bpf_tree_comp kernel/bpf/core.c:438 [inline]
RIP: 0010:__lt_find include/linux/rbtree_latch.h:115 [inline]
RIP: 0010:latch_tree_find include/linux/rbtree_latch.h:208 [inline]
RIP: 0010:bpf_prog_kallsyms_find+0x289/0x4a0 kernel/bpf/core.c:512
Code: 03 42 80 3c 30 00 0f 85 b1 01 00 00 4d 8b 6f 50 49 8d 7d 30 48 89 fa  
48 c1 ea 03 42 80 3c 32 00 0f 85 ab 01 00 00 49 8d 7d 02 <4d> 8b 65 30 48  
89 fa 48 89 f9 48 c1 ea 03 83 e1 07 42 0f b6 14 32
RSP: 0018:ffff8801b1126bc8 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffff8801d54e0a30 RCX: ffffffff818c0a21
RDX: 1ffff92000326606 RSI: 0000000000000008 RDI: ffffc90001933002
RBP: ffff8801b1126d40 R08: ffff8801c2ac4040 R09: 0000000000000000
R10: ffffed003b5c5b67 R11: ffff8801dae2db3b R12: 0000000000000000
R13: ffffc90001933000 R14: dffffc0000000000 R15: ffff8801d54e0a30
FS:  00007fe237cd5740(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc90001933030 CR3: 00000001b96da000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
