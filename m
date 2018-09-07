Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2AADC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 15:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77B332083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 15:17:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77B332083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729337AbeIGT60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 15:58:26 -0400
Received: from mail-it0-f72.google.com ([209.85.214.72]:39603 "EHLO
        mail-it0-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728232AbeIGT6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 15:58:25 -0400
Received: by mail-it0-f72.google.com with SMTP id w196-v6so21428999itb.4
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 08:17:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=DNzmUfvkDuPUSJVbtE9N1pOPE18PwvNhfgYozoarG2g=;
        b=DP3XKfLYEXGD4sgzP7Nt+Z8a9zwA+AWYLVBJn8DPIrU/YPYJDWiQvUggjZdAng+yme
         UE1HZZ9/dg+t8J4yMPZpeORliUCgaLbNofIVfcDqNyVDX8wLkn7Drp0ZJw3dtlCuJ1sg
         DwnPQCitT8Of6nbruCS2PeC1EoljQBo/BWaUt9Sn4Uqja2KZ3LvuzO1tvkjc2AtswdL5
         PqDFEf1C9U9s6Wp8jw64aHncHA9tS5CofzHbxzbCTnijlVzIg2USPO13sRHm27wnVR3Z
         HcfUqi+DtZmm9TuezHpJbxH6k36y5mcMoFXDoHt1rm5a6YdIpWMqzNXH39D8aYZvZvci
         m62Q==
X-Gm-Message-State: APzg51DNpalRmiTdnphkeVSYB5MFo7Kq/BbwXyVcZrM/j63jjEY/zoda
        tkLgbJ01VVl7Rc/boP5G5OrOUvHNF0kMfMjDSgO8CAXATBGE
X-Google-Smtp-Source: ANB0Vda7P43UHOuWPooPmQHq1yScy9A+3441o1eYlxChxJbQC5cpVPt+yA8oiTgcZCBLeTcRyp06+xjaczzNShCsXrKa7m/M02I6
MIME-Version: 1.0
X-Received: by 2002:a5e:c20a:: with SMTP id v10-v6mr6743109iop.100.1536333422893;
 Fri, 07 Sep 2018 08:17:02 -0700 (PDT)
Date:   Fri, 07 Sep 2018 08:17:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000edab9e0575497f40@google.com>
Subject: BUG: bad usercopy in __check_object_size (2)
From:   syzbot <syzbot+a3c9d2673837ccc0f22b@syzkaller.appspotmail.com>
To:     hpa@zytor.com, linux-kernel@vger.kernel.org, luto@kernel.org,
        mingo@redhat.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    28619527b8a7 Merge git://git.kernel.org/pub/scm/linux/kern..
git tree:       bpf
console output: https://syzkaller.appspot.com/x/log.txt?x=1618ac21400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=62e9b447c16085cf
dashboard link: https://syzkaller.appspot.com/bug?extid=a3c9d2673837ccc0f22b
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+a3c9d2673837ccc0f22b@syzkaller.appspotmail.com

  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457099
usercopy: Kernel memory overwrite attempt detected to spans multiple pages  
(offset 0, size 64)!
------------[ cut here ]------------
kernel BUG at mm/usercopy.c:102!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 15327 Comm: syz-executor2 Not tainted 4.19.0-rc2+ #50
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:usercopy_abort+0xbb/0xbd mm/usercopy.c:90
Code: c0 e8 8a 23 b2 ff 48 8b 55 c0 49 89 d9 4d 89 f0 ff 75 c8 4c 89 e1 4c  
89 ee 48 c7 c7 80 48 15 88 ff 75 d0 41 57 e8 5a 38 98 ff <0f> 0b e8 5f 23  
b2 ff e8 8a 6e f5 ff 8b 95 5c fe ff ff 4d 89 e0 31
RSP: 0018:ffff88019c5ced40 EFLAGS: 00010082
RAX: 000000000000005f RBX: ffffffff881545a0 RCX: ffffc9000728f000
RDX: 0000000000000000 RSI: ffffffff8164f825 RDI: 0000000000000005
RBP: ffff88019c5ced98 R08: ffff8801a3dd23c0 R09: ffffed003b5c3ee2
R10: ffffed003b5c3ee2 R11: ffff8801dae1f717 R12: ffffffff88154ac0
R13: ffffffff881546e0 R14: ffffffff881545a0 R15: ffffffff881545a0
FS:  00007ff971688700(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2cb25000 CR3: 00000001d38c1000 CR4: 00000000001406f0
DR0: 00000000200001c0 DR1: 0000000020000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
Call Trace:
  check_page_span mm/usercopy.c:212 [inline]
  check_heap_object mm/usercopy.c:241 [inline]
  __check_object_size.cold.2+0x23/0x134 mm/usercopy.c:266
  check_object_size include/linux/thread_info.h:119 [inline]
  __copy_from_user_inatomic include/linux/uaccess.h:65 [inline]
  __probe_kernel_read+0xda/0x1c0 mm/maccess.c:33
  show_opcodes+0x4c/0x70 arch/x86/kernel/dumpstack.c:109
  show_ip+0x31/0x36 arch/x86/kernel/dumpstack.c:126
  show_iret_regs+0x14/0x38 arch/x86/kernel/dumpstack.c:131
  __show_regs+0x1c/0x60 arch/x86/kernel/process_64.c:72
  show_regs_if_on_stack.constprop.10+0x36/0x39  
arch/x86/kernel/dumpstack.c:149
  show_trace_log_lvl+0x25d/0x28c arch/x86/kernel/dumpstack.c:274
  show_stack+0x38/0x3a arch/x86/kernel/dumpstack.c:293
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c4/0x2b4 lib/dump_stack.c:113
  fail_dump lib/fault-inject.c:51 [inline]
  should_fail.cold.4+0xa/0x17 lib/fault-inject.c:149
  __should_failslab+0x124/0x180 mm/failslab.c:32
  should_failslab+0x9/0x14 mm/slab_common.c:1557
  slab_pre_alloc_hook mm/slab.h:423 [inline]
  slab_alloc_node mm/slab.c:3299 [inline]
  kmem_cache_alloc_node_trace+0x5a/0x740 mm/slab.c:3661
  __do_kmalloc_node mm/slab.c:3681 [inline]
  __kmalloc_node_track_caller+0x33/0x70 mm/slab.c:3696
  __kmalloc_reserve.isra.39+0x41/0xe0 net/core/skbuff.c:137
  __alloc_skb+0x155/0x770 net/core/skbuff.c:205
  alloc_skb_fclone include/linux/skbuff.h:1037 [inline]
  tipc_buf_acquire+0x2d/0xf0 net/tipc/msg.c:66
  named_prepare_buf+0x8d/0x4b0 net/tipc/name_distr.c:71
  tipc_named_publish+0x433/0xa80 net/tipc/name_distr.c:99
  tipc_nametbl_publish+0x702/0xbb0 net/tipc/name_table.c:630
  tipc_sk_publish+0x236/0x530 net/tipc/socket.c:2604
  tipc_sk_join net/tipc/socket.c:2779 [inline]
  tipc_setsockopt+0x613/0xd70 net/tipc/socket.c:2883
  __sys_setsockopt+0x1ba/0x3c0 net/socket.c:1900
  __do_sys_setsockopt net/socket.c:1911 [inline]
  __se_sys_setsockopt net/socket.c:1908 [inline]
  __x64_sys_setsockopt+0xbe/0x150 net/socket.c:1908
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457099
Code: fd b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ff971687c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 00007ff9716886d4 RCX: 0000000000457099
RDX: 0000000000000087 RSI: 000000000000010f RDI: 0000000000000006
RBP: 0000000000930140 R08: 000000000000013f R09: 0000000000000000
R10: 0000000020000180 R11: 0000000000000246 R12: 0000000000000005
R13: 00000000004d6570 R14: 00000000004c9ad7 R15: 0000000000000009
Modules linked in:
Dumping ftrace buffer:
    (ftrace buffer empty)
---[ end trace d7af0d687a56e2e0 ]---
RIP: 0010:usercopy_abort+0xbb/0xbd mm/usercopy.c:90
Code: c0 e8 8a 23 b2 ff 48 8b 55 c0 49 89 d9 4d 89 f0 ff 75 c8 4c 89 e1 4c  
89 ee 48 c7 c7 80 48 15 88 ff 75 d0 41 57 e8 5a 38 98 ff <0f> 0b e8 5f 23  
b2 ff e8 8a 6e f5 ff 8b 95 5c fe ff ff 4d 89 e0 31
RSP: 0018:ffff88019c5ced40 EFLAGS: 00010082
RAX: 000000000000005f RBX: ffffffff881545a0 RCX: ffffc9000728f000
RDX: 0000000000000000 RSI: ffffffff8164f825 RDI: 0000000000000005
RBP: ffff88019c5ced98 R08: ffff8801a3dd23c0 R09: ffffed003b5c3ee2
R10: ffffed003b5c3ee2 R11: ffff8801dae1f717 R12: ffffffff88154ac0
R13: ffffffff881546e0 R14: ffffffff881545a0 R15: ffffffff881545a0
FS:  00007ff971688700(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2cb25000 CR3: 00000001d38c1000 CR4: 00000000001406f0
DR0: 00000000200001c0 DR1: 0000000020000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
