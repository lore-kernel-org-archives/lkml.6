Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB2BC38A24
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 19:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DEDE213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 19:55:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DEDE213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390209AbeGKUA5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 16:00:57 -0400
Received: from mail-it0-f69.google.com ([209.85.214.69]:51896 "EHLO
        mail-it0-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389772AbeGKUA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 16:00:56 -0400
Received: by mail-it0-f69.google.com with SMTP id b83-v6so2587345itg.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 12:55:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=/3mMwbjwjrFcThKGhrMu5OTV7OjnIzGREK8TDbF4EOs=;
        b=WmFQD2A+Otm2aa2yLBdbzntdn0xYUCnLDUk6cVQJLt+BHTeouE3AIsUD/vhcrUs73L
         vKWOrzFdJG4+xxfFYD/Q9pXK26SJqghH8z73zVMYd03JZMlotTzXG8o3qzwXXYSbWsZ+
         Ar5E0gxMWbGPkwY5dS8ON+YLvxgadWs6sFICZSBu2/KIHsI6RaecHZN6sdyJ8bwefUhd
         pP/Qg/Kp8oqzD1PXx26lD4Nk//ztAp5t4R1seaH76tUejE4/314gc/zxPF+nLr6xECUw
         hJ7nWICd/ZuNnjUJ+PzyjBfzDGD+wh92TzHmW35yHPIE+UXillvfvOCMKumKs5bcF+Bj
         Fb9g==
X-Gm-Message-State: AOUpUlGEwwopTUNObArpzTc4JOBtCXjPLmTF776zKlHb1gkT70Og4PMj
        K/nVBYxroGRlSkS7wwn9dj2UnDaHr0EVFgeHl0D8oz4knnmm
X-Google-Smtp-Source: AAOMgpdLWVmzJLmN1hzgpmhzkMkUDkMI721nzw0My7tcUCZa/5pnuq93MPUG2Go4mRXNb5UAUy9l+MRARKoy+TNDUrBItZViwjNg
MIME-Version: 1.0
X-Received: by 2002:a02:c483:: with SMTP id t3-v6mr26980jam.2.1531338902794;
 Wed, 11 Jul 2018 12:55:02 -0700 (PDT)
Date:   Wed, 11 Jul 2018 12:55:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000054fd6b0570be9fa8@google.com>
Subject: general protection fault in bpf_tcp_close (2)
From:   syzbot <syzbot+339037020e772651f1d8@syzkaller.appspotmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    d90c936fb318 Merge branch 'bpf-nfp-mul-div-support'
git tree:       bpf-next
console output: https://syzkaller.appspot.com/x/log.txt?x=175aeefc400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a501a01deaf0fe9
dashboard link: https://syzkaller.appspot.com/bug?extid=339037020e772651f1d8
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+339037020e772651f1d8@syzkaller.appspotmail.com

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] SMP KASAN
CPU: 0 PID: 8097 Comm: syz-executor2 Not tainted 4.18.0-rc3+ #48
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:__hlist_del include/linux/list.h:679 [inline]
RIP: 0010:hlist_del_rcu include/linux/rculist.h:440 [inline]
RIP: 0010:bpf_tcp_close+0x94c/0x1050 kernel/bpf/sockmap.c:365
Code: 85 25 06 00 00 48 8d 95 18 ff ff ff 49 8b 4c 24 18 48 89 d6 48 c1 ee  
03 c6 04 1e 00 48 89 ce 48 c1 ee 03 48 89 85 18 ff ff ff <80> 3c 1e 00 0f  
85 bf 05 00 00 48 c1 ea 03 48 85 c0 48 89 01 48 89
RSP: 0018:ffff8801aa12f950 EFLAGS: 00010a02
RAX: 0000000000000000 RBX: dffffc0000000000 RCX: dead000000000200
RDX: ffff8801aa12fa40 RSI: 1bd5a00000000040 RDI: ffff8801cb9df090
RBP: ffff8801aa12fb28 R08: ffff8801a82be440 R09: ffffed0039b2a6e1
R10: ffffed0039b2a6e1 R11: ffff8801cd95370b R12: ffff8801cb9df080
R13: ffff8801ce721340 R14: ffff8801cd953708 R15: ffff8801cb9df098
FS:  0000000001389940(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000625208 CR3: 00000001d910f000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
Call Trace:
  inet_release+0x104/0x1f0 net/ipv4/af_inet.c:427
  inet6_release+0x50/0x70 net/ipv6/af_inet6.c:459
  __sock_release+0xd7/0x260 net/socket.c:599
  sock_close+0x19/0x20 net/socket.c:1150
  __fput+0x355/0x8b0 fs/file_table.c:209
  ____fput+0x15/0x20 fs/file_table.c:243
  task_work_run+0x1ec/0x2a0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:192 [inline]
  exit_to_usermode_loop+0x313/0x370 arch/x86/entry/common.c:166
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x40ff01
Code: 75 14 b8 03 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 34 19 00 00 c3 48  
83 ec 08 e8 0a fc ff ff 48 89 04 24 b8 03 00 00 00 0f 05 <48> 8b 3c 24 48  
89 c2 e8 53 fc ff ff 48 89 d0 48 83 c4 08 48 3d 01
RSP: 002b:00007ffca498c100 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000015 RCX: 000000000040ff01
RDX: 0000000000000000 RSI: 0000000000731568 RDI: 0000000000000014
RBP: 0000000000000013 R08: 00007ffca498c080 R09: 0000000000000000
R10: 0000000000000003 R11: 0000000000000293 R12: 0000000000000000
R13: 0000000000000000 R14: 00007ffca498c7b0 R15: 00000000007034c0
Modules linked in:
Dumping ftrace buffer:
    (ftrace buffer empty)
---[ end trace 9c4e75cd650ecd9f ]---
RIP: 0010:__hlist_del include/linux/list.h:679 [inline]
RIP: 0010:hlist_del_rcu include/linux/rculist.h:440 [inline]
RIP: 0010:bpf_tcp_close+0x94c/0x1050 kernel/bpf/sockmap.c:365
Code: 85 25 06 00 00 48 8d 95 18 ff ff ff 49 8b 4c 24 18 48 89 d6 48 c1 ee  
03 c6 04 1e 00 48 89 ce 48 c1 ee 03 48 89 85 18 ff ff ff <80> 3c 1e 00 0f  
85 bf 05 00 00 48 c1 ea 03 48 85 c0 48 89 01 48 89
RSP: 0018:ffff8801aa12f950 EFLAGS: 00010a02
RAX: 0000000000000000 RBX: dffffc0000000000 RCX: dead000000000200
RDX: ffff8801aa12fa40 RSI: 1bd5a00000000040 RDI: ffff8801cb9df090
RBP: ffff8801aa12fb28 R08: ffff8801a82be440 R09: ffffed0039b2a6e1
R10: ffffed0039b2a6e1 R11: ffff8801cd95370b R12: ffff8801cb9df080
R13: ffff8801ce721340 R14: ffff8801cd953708 R15: ffff8801cb9df098
FS:  0000000001389940(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000625208 CR3: 00000001d910f000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
