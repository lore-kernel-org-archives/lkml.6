Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F86C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 09:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5139521735
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 09:40:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5139521735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731784AbeHNM01 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 08:26:27 -0400
Received: from mail-io0-f198.google.com ([209.85.223.198]:43178 "EHLO
        mail-io0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728541AbeHNM00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 08:26:26 -0400
Received: by mail-io0-f198.google.com with SMTP id w19-v6so16093550ioa.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 02:40:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=raIKP13xTCo7cAx7aqE51QxuifH6nr2cl4QYzJP1Srk=;
        b=D89BXOvBv2XJgl1xrCwQYMvX+U/Fakyvli0M0JdWAbCwdjcPVNBYPsNTNP5fW0Ab/+
         WJ+Ugpm9UXWNdAra4lv9vF3p1wR6g2b58qyZLWhOg5pjMa+lJBfL4rKa0F5F4idOuzw1
         wjAI28mNQNzUaJxWUVcp0zz+/oGqVIGinYGQZblUsXWyMvTjvZFi1/y5yGjz4RDcNb7s
         1gqyE8OP5Q6Hujdc7xKHoXbXDrdy0Q+7Vq28/FC6V3hnINvCBp0hLVQMuINQ6ESdFObI
         oVgI2bKwhtUCNILv1IETbLlabZzum3SJClZsNyza8Ydl+LXmVAOywwG1zC5RuCxvi8JE
         3vYA==
X-Gm-Message-State: AOUpUlHSEeJ8GjdSZJVGKbPLs++zsbWBX6u49u9ArHlC/0sp4IJxYFwX
        f14JKcV3FaA7ANEAoWB4ksfpDsDZ7SGb0ynqd9T7wwRz/uad
X-Google-Smtp-Source: AA+uWPxZ/opCN8i0GEWeHpPSajDUGa0E+AgY2/Y3Si6pASESfrRfrU1pJKb0vtmC5fKt77oF2KClFccoI1O4o4fjix+M6ZLok32T
MIME-Version: 1.0
X-Received: by 2002:a6b:f613:: with SMTP id n19-v6mr9475069ioh.131.1534239602781;
 Tue, 14 Aug 2018 02:40:02 -0700 (PDT)
Date:   Tue, 14 Aug 2018 02:40:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000863a6e057361feb4@google.com>
Subject: WARNING: suspicious RCU usage in bpf_prog_array_copy_core
From:   syzbot <syzbot+6e72317008eef84a216b@syzkaller.appspotmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    4110b42356f3 Add linux-next specific files for 20180810
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=109bac02400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1d80606e3795a4f5
dashboard link: https://syzkaller.appspot.com/bug?extid=6e72317008eef84a216b
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=157ef48a400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12e16cf8400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+6e72317008eef84a216b@syzkaller.appspotmail.com

random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)

=============================
WARNING: suspicious RCU usage
4.18.0-rc8-next-20180810+ #36 Not tainted
-----------------------------
kernel/bpf/core.c:1582 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
2 locks held by syz-executor287/4449:
  #0: 00000000d8131c0c (&ctx->mutex){+.+.}, at:  
perf_event_ctx_lock_nested+0x375/0x600 kernel/events/core.c:1276
  #1: 000000006c916250 (bpf_event_mutex){+.+.}, at:  
perf_event_query_prog_array+0x1c6/0x380 kernel/trace/bpf_trace.c:1062

stack backtrace:
CPU: 1 PID: 4449 Comm: syz-executor287 Not tainted  
4.18.0-rc8-next-20180810+ #36
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
  lockdep_rcu_suspicious+0x14a/0x153 kernel/locking/lockdep.c:4562
  bpf_prog_array_copy_core+0x2d9/0x360 kernel/bpf/core.c:1582
  bpf_prog_array_copy_info+0x9a/0x110 kernel/bpf/core.c:1720
  perf_event_query_prog_array+0x22e/0x380 kernel/trace/bpf_trace.c:1063
  _perf_ioctl+0x986/0x1600 kernel/events/core.c:5079
  perf_ioctl+0x59/0x80 kernel/events/core.c:5110
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:501 [inline]
  do_vfs_ioctl+0x1de/0x1720 fs/ioctl.c:685
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:702
  __do_sys_ioctl fs/ioctl.c:709 [inline]
  __se_sys_ioctl fs/ioctl.c:707 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:707
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x440409
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 fb 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fffc5fc1488 EFLAGS: 00000217 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 0000000000440409
RDX: 0000000020000180 RSI: 00000000c008240a RDI: 0000000000000003
RBP: 00000000006ca018 R08: 00000000004002c8 R09: 00000000004002c8
R10: 00000000004002c8 R11: 0000000000000217 R12: 0000000000401c90
R13: 0000000000401d20 R14: 0000000000000000


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
