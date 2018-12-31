Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E82BC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 07:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE31E2133F
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 07:05:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbeLaHFE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 02:05:04 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:35950 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbeLaHFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 02:05:03 -0500
Received: by mail-io1-f69.google.com with SMTP id t13so25964649ioi.3
        for <linux-kernel@vger.kernel.org>; Sun, 30 Dec 2018 23:05:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=k2Ww8s/iPBwFApa69aq1avFcBXQpI3yJdW7nEeOlABs=;
        b=KiIquOUmPakxXAhwUl+w6p8Yk2Xbi13Jd0o537E/Wt7aFtmm2BHBmf+fsg27FXnxoJ
         cQ8jMBDN3kkouBg2PuPwKGEngetGXNrBx4nmR8iiQiHHZqU4A7/sVvv5SqvY46xJzs+V
         Qtt046H6vTBd7Z8Jll2TanQyY24NB2vPPF4h/MlAlMpP4b7x9T0imYnVHGMIigqL/o70
         klMqGAN9QMADpqlODBUASMv8MZGavKqSWtbp3BoGF7ResGTiNhbm+38bkBk7M8n8TZr/
         TPGv2LteZa8Eg8FvzYwLxywkOHgxpCGKy+TqLllNSQsgUxj+B0vTU+PCAqQDM1fWDd0o
         yT9w==
X-Gm-Message-State: AA+aEWaWqIoLe+gZ3Q97dk9DSTwrJcT0A5yZtv4iJzSLK1KCGtk5bDQL
        uAoYe0+afYGJN+lJcIDjK11g+wWYKvcskj7LChihPecXGChp
X-Google-Smtp-Source: AFSGD/VmxvjbsimznQpxn+M9og2XpOgUoOfNHGnj+bhPZKuCrgxY8Rgk090jIQno91teIth1Cbfh3fDs0rh/v4M9UFN2Fth860tQ
MIME-Version: 1.0
X-Received: by 2002:a02:95ae:: with SMTP id b43mr28653427jai.4.1546239902740;
 Sun, 30 Dec 2018 23:05:02 -0800 (PST)
Date:   Sun, 30 Dec 2018 23:05:02 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000023f74b057e4c0890@google.com>
Subject: BUG: unable to handle kernel paging request in init_srcu_struct_fields
From:   syzbot <syzbot+010232b93d20ef8abde5@syzkaller.appspotmail.com>
To:     bp@alien8.de, hpa@zytor.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        pbonzini@redhat.com, rkrcmar@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    65e08c5e8631 Merge tag 'linux-kselftest-4.20-rc7' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16ca3d2b400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c8970c89a0efbb23
dashboard link: https://syzkaller.appspot.com/bug?extid=010232b93d20ef8abde5
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+010232b93d20ef8abde5@syzkaller.appspotmail.com

BUG: unable to handle kernel paging request at ffffc90013465878
PGD 1da95a067 P4D 1da95a067 PUD 1da95b067 PMD 1bfe03067 PTE 0
kobject: 'kvm' (000000003b7ad1f2): kobject_uevent_env
Oops: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 31204 Comm: syz-executor4 Not tainted 4.20.0-rc6+ #372
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
kobject: 'kvm' (000000003b7ad1f2): kobject_uevent_env
RIP: 0010:init_srcu_struct_nodes kernel/rcu/srcutree.c:161 [inline]
RIP: 0010:init_srcu_struct_fields+0xd03/0x1470 kernel/rcu/srcutree.c:191
kobject: 'kvm' (000000003b7ad1f2): kobject_uevent_env
Code: 88 00 00 00 48 89 f8 48 c1 e8 03 0f b6 04 18 84 c0 74 08 3c 03 0f 8e  
0a 04 00 00 49 8d be 98 01 00 00 44 89 e1 b8 01 00 00 00 <41> 2b 8d 88 00  
00 00 48 89 fa 48 c1 ea 03 d3 e0 80 3c 1a 00 48 98
RSP: 0018:ffff888182a37420 EFLAGS: 00010246
RAX: 0000000000000001 RBX: dffffc0000000000 RCX: 0000000000000001
RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff8881daf00198
RBP: ffff888182a37600 R08: ffff8881b89ec140 R09: 0000000000000000
R10: ffffed103b5c5b5f R11: ffff8881dae2dafb R12: 0000000000000001
kobject: 'kvm' (000000003b7ad1f2): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
R13: ffffc900134657f0 R14: ffff8881daf00000 R15: ffff8881daf000f0
FS:  00007f333e7d7700(0000) GS:ffff8881dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc90013465878 CR3: 00000001c01eb000 CR4: 00000000001426f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
kobject: 'kvm' (000000003b7ad1f2): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'kvm' (000000003b7ad1f2): kobject_uevent_env
kobject: 'kvm' (000000003b7ad1f2): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'kvm' (000000003b7ad1f2): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
  __init_srcu_struct+0x54/0x60 kernel/rcu/srcutree.c:207
kobject: 'kvm' (000000003b7ad1f2): kobject_uevent_env
  kvm_page_track_init+0x27/0x60 arch/x86/kvm/page_track.c:177
  kvm_arch_init_vm+0x5f0/0x790 arch/x86/kvm/x86.c:9024
kobject: 'kvm' (000000003b7ad1f2): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'kvm' (000000003b7ad1f2): kobject_uevent_env
  kvm_create_vm arch/x86/kvm/../../../virt/kvm/kvm_main.c:641 [inline]
  kvm_dev_ioctl_create_vm arch/x86/kvm/../../../virt/kvm/kvm_main.c:3197  
[inline]
  kvm_dev_ioctl+0x4c4/0x1ae0 arch/x86/kvm/../../../virt/kvm/kvm_main.c:3249
kobject: 'kvm' (000000003b7ad1f2): kobject_uevent_env
kobject: 'kvm' (000000003b7ad1f2): kobject_uevent_env
kobject: 'kvm' (000000003b7ad1f2): kobject_uevent_env
kobject: 'kvm' (000000003b7ad1f2): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'kvm' (000000003b7ad1f2): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:509 [inline]
  do_vfs_ioctl+0x1de/0x1790 fs/ioctl.c:696
kobject: 'kvm' (000000003b7ad1f2): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:713
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl fs/ioctl.c:718 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457679
Code: fd b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f333e7d6c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457679
RDX: 0000000000000000 RSI: 000000000000ae01 RDI: 0000000000000007
RBP: 000000000072bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f333e7d76d4
R13: 00000000004c00fe R14: 00000000004d1138 R15: 00000000ffffffff
Modules linked in:
CR2: ffffc90013465878
---[ end trace 6d1d73f0a8f2db3c ]---
RIP: 0010:init_srcu_struct_nodes kernel/rcu/srcutree.c:161 [inline]
RIP: 0010:init_srcu_struct_fields+0xd03/0x1470 kernel/rcu/srcutree.c:191
Code: 88 00 00 00 48 89 f8 48 c1 e8 03 0f b6 04 18 84 c0 74 08 3c 03 0f 8e  
0a 04 00 00 49 8d be 98 01 00 00 44 89 e1 b8 01 00 00 00 <41> 2b 8d 88 00  
00 00 48 89 fa 48 c1 ea 03 d3 e0 80 3c 1a 00 48 98
RSP: 0018:ffff888182a37420 EFLAGS: 00010246
RAX: 0000000000000001 RBX: dffffc0000000000 RCX: 0000000000000001
RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff8881daf00198
RBP: ffff888182a37600 R08: ffff8881b89ec140 R09: 0000000000000000
R10: ffffed103b5c5b5f R11: ffff8881dae2dafb R12: 0000000000000001
R13: ffffc900134657f0 R14: ffff8881daf00000 R15: ffff8881daf000f0
FS:  00007f333e7d7700(0000) GS:ffff8881dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc90013465878 CR3: 00000001c01eb000 CR4: 00000000001426f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
