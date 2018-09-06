Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B46C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 16:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6C1A20652
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 16:59:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6C1A20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729312AbeIFVf1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 17:35:27 -0400
Received: from mail-it0-f72.google.com ([209.85.214.72]:38349 "EHLO
        mail-it0-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727944AbeIFVf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 17:35:26 -0400
Received: by mail-it0-f72.google.com with SMTP id h5-v6so13039633itb.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 09:59:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=P1uZWXXHopg1q6Vp/tW1BXXwjNbCyJjUXasdbrYQQM8=;
        b=gn6KxP/SgsJlTvf5/ED/VtjVhn95xwqNsRvJ9h4dXvbHVNUVOmh2zXJOvsNkXGui9E
         x2XbUZ8hZ7CHCbXwUp86Fd9a6CaAfZToTYuxgcnBENlPwVOTW9tYbUZGCORJ5LgSq3i1
         REAqVUh2QtjYVe4Wl7oYvN4JmJhX1WwTDRQe2hI4ZkTtHV/a35kLgruHUnMJJOT20Q57
         2nTxHEcYUJN8OyAkVscawYSYhlcoNmIeWAKihxk9gvwuleOqmkSafegF4AAvU5jVDrHe
         dxsu2ftz0wjlzPRoabu2IVsxUMREvAnNUJV3o2TfsPOTm7BHSuyR6SMTWdJIbVqIWAgO
         GCuQ==
X-Gm-Message-State: APzg51D631slon600S6D+ocT3Kf6lnP31mMpdzlT71rMduC4cQBgBniZ
        iEh/7yLB53/smxjnN2CjXFODIdcgjyc3Ug/X9PEzUFfea08f
X-Google-Smtp-Source: ANB0VdbJ2vOUct2B/g4MFdJUy6/ddG3WP/6PPjrVSeqjwBYOOczYc7WDFc/Ct/6Aia+am7GQWqsR7hM4UTe4BwRPZffwdKSGW99h
MIME-Version: 1.0
X-Received: by 2002:a24:ac14:: with SMTP id s20-v6mr3663126ite.14.1536253142509;
 Thu, 06 Sep 2018 09:59:02 -0700 (PDT)
Date:   Thu, 06 Sep 2018 09:59:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d83699057536ce5b@google.com>
Subject: INFO: task hung in uprobe_start_dup_mmap
From:   syzbot <syzbot+cad3df271fa4d88da051@syzkaller.appspotmail.com>
To:     acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, linux-kernel@vger.kernel.org, mingo@redhat.com,
        namhyung@kernel.org, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    f2b6e66e9885 Add linux-next specific files for 20180904
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=175217e1400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=15ad48400e39c1b3
dashboard link: https://syzkaller.appspot.com/bug?extid=cad3df271fa4d88da051
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+cad3df271fa4d88da051@syzkaller.appspotmail.com

hfs: can't find a HFS filesystem on dev loop3
INFO: task udevd:4711 blocked for more than 140 seconds.
       Not tainted 4.19.0-rc2-next-20180904+ #55
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
udevd           D22488  4711   2538 0x00000000
Call Trace:
  context_switch kernel/sched/core.c:2825 [inline]
  __schedule+0x87c/0x1df0 kernel/sched/core.c:3473
  schedule+0xfb/0x450 kernel/sched/core.c:3517
  __rwsem_down_read_failed_common kernel/locking/rwsem-xadd.c:269 [inline]
  rwsem_down_read_failed+0x362/0x610 kernel/locking/rwsem-xadd.c:286
  call_rwsem_down_read_failed+0x18/0x30 arch/x86/lib/rwsem.S:94
  __down_read arch/x86/include/asm/rwsem.h:83 [inline]
  __percpu_down_read+0x16e/0x210 kernel/locking/percpu-rwsem.c:85
  percpu_down_read_preempt_disable include/linux/percpu-rwsem.h:49 [inline]
  percpu_down_read include/linux/percpu-rwsem.h:59 [inline]
  uprobe_start_dup_mmap+0x99/0xa0 kernel/events/uprobes.c:1259
  dup_mmap kernel/fork.c:431 [inline]
  dup_mm kernel/fork.c:1275 [inline]
  copy_mm kernel/fork.c:1330 [inline]
  copy_process+0x2b3d/0x7af0 kernel/fork.c:1870
  _do_fork+0x1ca/0x1170 kernel/fork.c:2169
  __do_sys_clone kernel/fork.c:2276 [inline]
  __se_sys_clone kernel/fork.c:2270 [inline]
  __x64_sys_clone+0xbf/0x150 kernel/fork.c:2270
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x7f78fd4a8f46
Code: Bad RIP value.
RSP: 002b:00007ffcefe84b40 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
RAX: ffffffffffffffda RBX: 00007ffcefe84b40 RCX: 00007f78fd4a8f46
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
RBP: 00007ffcefe84ba0 R08: 0000000000001267 R09: 0000000000001267
R10: 00007f78fddc5a70 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffcefe84b60 R14: 0000000000000005 R15: 0000000000000005
INFO: task udevd:4712 blocked for more than 140 seconds.
       Not tainted 4.19.0-rc2-next-20180904+ #55
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
udevd           D22488  4712   2538 0x00000000
Call Trace:
  context_switch kernel/sched/core.c:2825 [inline]
  __schedule+0x87c/0x1df0 kernel/sched/core.c:3473
  schedule+0xfb/0x450 kernel/sched/core.c:3517
  __rwsem_down_read_failed_common kernel/locking/rwsem-xadd.c:269 [inline]
  rwsem_down_read_failed+0x362/0x610 kernel/locking/rwsem-xadd.c:286
  call_rwsem_down_read_failed+0x18/0x30 arch/x86/lib/rwsem.S:94
  __down_read arch/x86/include/asm/rwsem.h:83 [inline]
  __percpu_down_read+0x16e/0x210 kernel/locking/percpu-rwsem.c:85
  percpu_down_read_preempt_disable include/linux/percpu-rwsem.h:49 [inline]
  percpu_down_read include/linux/percpu-rwsem.h:59 [inline]
  uprobe_start_dup_mmap+0x99/0xa0 kernel/events/uprobes.c:1259
  dup_mmap kernel/fork.c:431 [inline]
  dup_mm kernel/fork.c:1275 [inline]
  copy_mm kernel/fork.c:1330 [inline]
  copy_process+0x2b3d/0x7af0 kernel/fork.c:1870
  _do_fork+0x1ca/0x1170 kernel/fork.c:2169
  __do_sys_clone kernel/fork.c:2276 [inline]
  __se_sys_clone kernel/fork.c:2270 [inline]
  __x64_sys_clone+0xbf/0x150 kernel/fork.c:2270
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x7f78fd4a8f46
Code: Bad RIP value.
RSP: 002b:00007ffcefe84b40 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
RAX: ffffffffffffffda RBX: 00007ffcefe84b40 RCX: 00007f78fd4a8f46
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
RBP: 00007ffcefe84ba0 R08: 0000000000001268 R09: 0000000000001268
R10: 00007f78fddc5a70 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffcefe84b60 R14: 0000000000000005 R15: 0000000000000005
INFO: task syz-executor0:4752 blocked for more than 140 seconds.
       Not tainted 4.19.0-rc2-next-20180904+ #55
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor0   D21560  4752      1 0x00000004
Call Trace:
  context_switch kernel/sched/core.c:2825 [inline]
  __schedule+0x87c/0x1df0 kernel/sched/core.c:3473
  schedule+0xfb/0x450 kernel/sched/core.c:3517
  __rwsem_down_read_failed_common kernel/locking/rwsem-xadd.c:269 [inline]
  rwsem_down_read_failed+0x362/0x610 kernel/locking/rwsem-xadd.c:286
  call_rwsem_down_read_failed+0x18/0x30 arch/x86/lib/rwsem.S:94
  __down_read arch/x86/include/asm/rwsem.h:83 [inline]
  __percpu_down_read+0x16e/0x210 kernel/locking/percpu-rwsem.c:85
  percpu_down_read_preempt_disable include/linux/percpu-rwsem.h:49 [inline]
  percpu_down_read include/linux/percpu-rwsem.h:59 [inline]
  uprobe_start_dup_mmap+0x99/0xa0 kernel/events/uprobes.c:1259
  dup_mmap kernel/fork.c:431 [inline]
  dup_mm kernel/fork.c:1275 [inline]
  copy_mm kernel/fork.c:1330 [inline]
  copy_process+0x2b3d/0x7af0 kernel/fork.c:1870
  _do_fork+0x1ca/0x1170 kernel/fork.c:2169
  __do_sys_clone kernel/fork.c:2276 [inline]
  __se_sys_clone kernel/fork.c:2270 [inline]
  __x64_sys_clone+0xbf/0x150 kernel/fork.c:2270
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x45574a
Code: Bad RIP value.
RSP: 002b:00007ffdcdf7a290 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
RAX: ffffffffffffffda RBX: 00007ffdcdf7a290 RCX: 000000000045574a
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
RBP: 00007ffdcdf7a2d0 R08: 0000000000000001 R09: 00000000011d9940
R10: 00000000011d9c10 R11: 0000000000000246 R12: 0000000000000001
R13: 0000000000000000 R14: 0000000000000000 R15: badc0ffeebadface
INFO: task syz-executor1:4754 blocked for more than 140 seconds.
       Not tainted 4.19.0-rc2-next-20180904+ #55
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor1   D21032  4754      1 0x00000004
Call Trace:
  context_switch kernel/sched/core.c:2825 [inline]
  __schedule+0x87c/0x1df0 kernel/sched/core.c:3473
  schedule+0xfb/0x450 kernel/sched/core.c:3517
  __rwsem_down_read_failed_common kernel/locking/rwsem-xadd.c:269 [inline]
  rwsem_down_read_failed+0x362/0x610 kernel/locking/rwsem-xadd.c:286
  call_rwsem_down_read_failed+0x18/0x30 arch/x86/lib/rwsem.S:94
  __down_read arch/x86/include/asm/rwsem.h:83 [inline]
  __percpu_down_read+0x16e/0x210 kernel/locking/percpu-rwsem.c:85
  percpu_down_read_preempt_disable include/linux/percpu-rwsem.h:49 [inline]
  percpu_down_read include/linux/percpu-rwsem.h:59 [inline]
  uprobe_start_dup_mmap+0x99/0xa0 kernel/events/uprobes.c:1259
  dup_mmap kernel/fork.c:431 [inline]
  dup_mm kernel/fork.c:1275 [inline]
  copy_mm kernel/fork.c:1330 [inline]
  copy_process+0x2b3d/0x7af0 kernel/fork.c:1870
  _do_fork+0x1ca/0x1170 kernel/fork.c:2169
  __do_sys_clone kernel/fork.c:2276 [inline]
  __se_sys_clone kernel/fork.c:2270 [inline]
  __x64_sys_clone+0xbf/0x150 kernel/fork.c:2270
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x45574a
Code: Bad RIP value.
RSP: 002b:00007fff590938d0 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
RAX: ffffffffffffffda RBX: 00007fff590938d0 RCX: 000000000045574a
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
RBP: 00007fff59093910 R08: 0000000000000001 R09: 0000000001d2a940
R10: 0000000001d2ac10 R11: 0000000000000246 R12: 0000000000000001
R13: 0000000000000000 R14: 0000000000000000 R15: badc0ffeebadface
INFO: task syz-executor6:4756 blocked for more than 140 seconds.
       Not tainted 4.19.0-rc2-next-20180904+ #55
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor6   D21184  4756      1 0x00000004
Call Trace:
  context_switch kernel/sched/core.c:2825 [inline]
  __schedule+0x87c/0x1df0 kernel/sched/core.c:3473
  schedule+0xfb/0x450 kernel/sched/core.c:3517
  __rwsem_down_read_failed_common kernel/locking/rwsem-xadd.c:269 [inline]
  rwsem_down_read_failed+0x362/0x610 kernel/locking/rwsem-xadd.c:286
  call_rwsem_down_read_failed+0x18/0x30 arch/x86/lib/rwsem.S:94
  __down_read arch/x86/include/asm/rwsem.h:83 [inline]
  __percpu_down_read+0x16e/0x210 kernel/locking/percpu-rwsem.c:85
  percpu_down_read_preempt_disable include/linux/percpu-rwsem.h:49 [inline]
  percpu_down_read include/linux/percpu-rwsem.h:59 [inline]
  uprobe_start_dup_mmap+0x99/0xa0 kernel/events/uprobes.c:1259
  dup_mmap kernel/fork.c:431 [inline]
  dup_mm kernel/fork.c:1275 [inline]
  copy_mm kernel/fork.c:1330 [inline]
  copy_process+0x2b3d/0x7af0 kernel/fork.c:1870
  _do_fork+0x1ca/0x1170 kernel/fork.c:2169
  __do_sys_clone kernel/fork.c:2276 [inline]
  __se_sys_clone kernel/fork.c:2270 [inline]
  __x64_sys_clone+0xbf/0x150 kernel/fork.c:2270
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x45574a
Code: Bad RIP value.
RSP: 002b:00007ffce5b71030 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
RAX: ffffffffffffffda RBX: 00007ffce5b71030 RCX: 000000000045574a
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
RBP: 00007ffce5b71070 R08: 0000000000000001 R09: 0000000002588940
R10: 0000000002588c10 R11: 0000000000000246 R12: 0000000000000001
R13: 0000000000000000 R14: 0000000000000000 R15: badc0ffeebadface
INFO: task syz-executor7:4758 blocked for more than 140 seconds.
       Not tainted 4.19.0-rc2-next-20180904+ #55
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor7   D21184  4758      1 0x00000004
Call Trace:
  context_switch kernel/sched/core.c:2825 [inline]
  __schedule+0x87c/0x1df0 kernel/sched/core.c:3473
  schedule+0xfb/0x450 kernel/sched/core.c:3517
  __rwsem_down_read_failed_common kernel/locking/rwsem-xadd.c:269 [inline]
  rwsem_down_read_failed+0x362/0x610 kernel/locking/rwsem-xadd.c:286
  call_rwsem_down_read_failed+0x18/0x30 arch/x86/lib/rwsem.S:94
  __down_read arch/x86/include/asm/rwsem.h:83 [inline]
  __percpu_down_read+0x16e/0x210 kernel/locking/percpu-rwsem.c:85
  percpu_down_read_preempt_disable include/linux/percpu-rwsem.h:49 [inline]
  percpu_down_read include/linux/percpu-rwsem.h:59 [inline]
  uprobe_start_dup_mmap+0x99/0xa0 kernel/events/uprobes.c:1259
  dup_mmap kernel/fork.c:431 [inline]
  dup_mm kernel/fork.c:1275 [inline]
  copy_mm kernel/fork.c:1330 [inline]
  copy_process+0x2b3d/0x7af0 kernel/fork.c:1870
  _do_fork+0x1ca/0x1170 kernel/fork.c:2169
  __do_sys_clone kernel/fork.c:2276 [inline]
  __se_sys_clone kernel/fork.c:2270 [inline]
  __x64_sys_clone+0xbf/0x150 kernel/fork.c:2270
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x45574a
Code: Bad RIP value.
RSP: 002b:00007ffc193b1590 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
RAX: ffffffffffffffda RBX: 00007ffc193b1590 RCX: 000000000045574a
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
RBP: 00007ffc193b15d0 R08: 0000000000000001 R09: 0000000001c79940
R10: 0000000001c79c10 R11: 0000000000000246 R12: 0000000000000001
R13: 0000000000000000 R14: 0000000000000000 R15: badc0ffeebadface
INFO: task udevd:6793 blocked for more than 140 seconds.
       Not tainted 4.19.0-rc2-next-20180904+ #55
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
udevd           D22488  6793   2538 0x00000000
Call Trace:
  context_switch kernel/sched/core.c:2825 [inline]
  __schedule+0x87c/0x1df0 kernel/sched/core.c:3473
  schedule+0xfb/0x450 kernel/sched/core.c:3517
  __rwsem_down_read_failed_common kernel/locking/rwsem-xadd.c:269 [inline]
  rwsem_down_read_failed+0x362/0x610 kernel/locking/rwsem-xadd.c:286
  call_rwsem_down_read_failed+0x18/0x30 arch/x86/lib/rwsem.S:94
  __down_read arch/x86/include/asm/rwsem.h:83 [inline]
  __percpu_down_read+0x16e/0x210 kernel/locking/percpu-rwsem.c:85
  percpu_down_read_preempt_disable include/linux/percpu-rwsem.h:49 [inline]
  percpu_down_read include/linux/percpu-rwsem.h:59 [inline]
  uprobe_start_dup_mmap+0x99/0xa0 kernel/events/uprobes.c:1259
  dup_mmap kernel/fork.c:431 [inline]
  dup_mm kernel/fork.c:1275 [inline]
  copy_mm kernel/fork.c:1330 [inline]
  copy_process+0x2b3d/0x7af0 kernel/fork.c:1870
  _do_fork+0x1ca/0x1170 kernel/fork.c:2169
  __do_sys_clone kernel/fork.c:2276 [inline]
  __se_sys_clone kernel/fork.c:2270 [inline]
  __x64_sys_clone+0xbf/0x150 kernel/fork.c:2270
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x7f78fd4a8f46
Code: Bad RIP value.
RSP: 002b:00007ffcefe84b40 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
RAX: ffffffffffffffda RBX: 00007ffcefe84b40 RCX: 00007f78fd4a8f46
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
RBP: 00007ffcefe84ba0 R08: 0000000000001a89 R09: 0000000000001a89
R10: 00007f78fddc5a70 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffcefe84b60 R14: 0000000000000005 R15: 0000000000000005
INFO: task udevd:6805 blocked for more than 140 seconds.
       Not tainted 4.19.0-rc2-next-20180904+ #55
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
udevd           D22488  6805   2538 0x00000000
Call Trace:
  context_switch kernel/sched/core.c:2825 [inline]
  __schedule+0x87c/0x1df0 kernel/sched/core.c:3473
  schedule+0xfb/0x450 kernel/sched/core.c:3517
  __rwsem_down_read_failed_common kernel/locking/rwsem-xadd.c:269 [inline]
  rwsem_down_read_failed+0x362/0x610 kernel/locking/rwsem-xadd.c:286
  call_rwsem_down_read_failed+0x18/0x30 arch/x86/lib/rwsem.S:94
  __down_read arch/x86/include/asm/rwsem.h:83 [inline]
  __percpu_down_read+0x16e/0x210 kernel/locking/percpu-rwsem.c:85
  percpu_down_read_preempt_disable include/linux/percpu-rwsem.h:49 [inline]
  percpu_down_read include/linux/percpu-rwsem.h:59 [inline]
  uprobe_start_dup_mmap+0x99/0xa0 kernel/events/uprobes.c:1259
  dup_mmap kernel/fork.c:431 [inline]
  dup_mm kernel/fork.c:1275 [inline]
  copy_mm kernel/fork.c:1330 [inline]
  copy_process+0x2b3d/0x7af0 kernel/fork.c:1870
  _do_fork+0x1ca/0x1170 kernel/fork.c:2169
  __do_sys_clone kernel/fork.c:2276 [inline]
  __se_sys_clone kernel/fork.c:2270 [inline]
  __x64_sys_clone+0xbf/0x150 kernel/fork.c:2270
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x7f78fd4a8f46
Code: Bad RIP value.
RSP: 002b:00007ffcefe84b40 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
RAX: ffffffffffffffda RBX: 00007ffcefe84b40 RCX: 00007f78fd4a8f46
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
RBP: 00007ffcefe84ba0 R08: 0000000000001a95 R09: 0000000000001a95
R10: 00007f78fddc5a70 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffcefe84b60 R14: 0000000000000005 R15: 0000000000000005
INFO: task udevd:6813 blocked for more than 140 seconds.
       Not tainted 4.19.0-rc2-next-20180904+ #55
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
udevd           D22488  6813   2538 0x00000000
Call Trace:
  context_switch kernel/sched/core.c:2825 [inline]
  __schedule+0x87c/0x1df0 kernel/sched/core.c:3473
  schedule+0xfb/0x450 kernel/sched/core.c:3517
  __rwsem_down_read_failed_common kernel/locking/rwsem-xadd.c:269 [inline]
  rwsem_down_read_failed+0x362/0x610 kernel/locking/rwsem-xadd.c:286
  call_rwsem_down_read_failed+0x18/0x30 arch/x86/lib/rwsem.S:94
  __down_read arch/x86/include/asm/rwsem.h:83 [inline]
  __percpu_down_read+0x16e/0x210 kernel/locking/percpu-rwsem.c:85
  percpu_down_read_preempt_disable include/linux/percpu-rwsem.h:49 [inline]
  percpu_down_read include/linux/percpu-rwsem.h:59 [inline]
  uprobe_start_dup_mmap+0x99/0xa0 kernel/events/uprobes.c:1259
  dup_mmap kernel/fork.c:431 [inline]
  dup_mm kernel/fork.c:1275 [inline]
  copy_mm kernel/fork.c:1330 [inline]
  copy_process+0x2b3d/0x7af0 kernel/fork.c:1870
  _do_fork+0x1ca/0x1170 kernel/fork.c:2169
  __do_sys_clone kernel/fork.c:2276 [inline]
  __se_sys_clone kernel/fork.c:2270 [inline]
  __x64_sys_clone+0xbf/0x150 kernel/fork.c:2270
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x7f78fd4a8f46
Code: Bad RIP value.
RSP: 002b:00007ffcefe84b40 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
RAX: ffffffffffffffda RBX: 00007ffcefe84b40 RCX: 00007f78fd4a8f46
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
RBP: 00007ffcefe84ba0 R08: 0000000000001a9d R09: 0000000000001a9d
R10: 00007f78fddc5a70 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffcefe84b60 R14: 0000000000000005 R15: 0000000000000005
INFO: task udevd:7279 blocked for more than 140 seconds.
       Not tainted 4.19.0-rc2-next-20180904+ #55
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
udevd           D22944  7279   2538 0x00000000
Call Trace:
  context_switch kernel/sched/core.c:2825 [inline]
  __schedule+0x87c/0x1df0 kernel/sched/core.c:3473
  schedule+0xfb/0x450 kernel/sched/core.c:3517
  __rwsem_down_read_failed_common kernel/locking/rwsem-xadd.c:269 [inline]
  rwsem_down_read_failed+0x362/0x610 kernel/locking/rwsem-xadd.c:286
  call_rwsem_down_read_failed+0x18/0x30 arch/x86/lib/rwsem.S:94
  __down_read arch/x86/include/asm/rwsem.h:83 [inline]
  __percpu_down_read+0x16e/0x210 kernel/locking/percpu-rwsem.c:85
  percpu_down_read_preempt_disable include/linux/percpu-rwsem.h:49 [inline]
  percpu_down_read include/linux/percpu-rwsem.h:59 [inline]
  uprobe_start_dup_mmap+0x99/0xa0 kernel/events/uprobes.c:1259
  dup_mmap kernel/fork.c:431 [inline]
  dup_mm kernel/fork.c:1275 [inline]
  copy_mm kernel/fork.c:1330 [inline]
  copy_process+0x2b3d/0x7af0 kernel/fork.c:1870
  _do_fork+0x1ca/0x1170 kernel/fork.c:2169
  __do_sys_clone kernel/fork.c:2276 [inline]
  __se_sys_clone kernel/fork.c:2270 [inline]
  __x64_sys_clone+0xbf/0x150 kernel/fork.c:2270
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x7f78fd4a8f46
Code: Bad RIP value.
RSP: 002b:00007ffcefe84b40 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
RAX: ffffffffffffffda RBX: 00007ffcefe84b40 RCX: 00007f78fd4a8f46
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
RBP: 00007ffcefe84ba0 R08: 0000000000001c6f R09: 0000000000001c6f
R10: 00007f78fddc5a70 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffcefe84b60 R14: 0000000000000005 R15: 0000000000000005

Showing all locks held in the system:
1 lock held by khungtaskd/792:
  #0: 00000000010c3b8a (rcu_read_lock){....}, at:  
debug_show_all_locks+0xd0/0x428 kernel/locking/lockdep.c:4436
1 lock held by rsyslogd/4614:
2 locks held by getty/4704:
  #0: 000000007272e650 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:353
  #1: 00000000d0ad5199 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
2 locks held by getty/4705:
  #0: 00000000ee01b3d2 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:353
  #1: 00000000cb4b72e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
2 locks held by getty/4706:
  #0: 00000000b1d1bfa1 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:353
  #1: 00000000d8a1ad0c (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
2 locks held by getty/4707:
  #0: 00000000d748ecc1 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:353
  #1: 000000003e534095 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
2 locks held by getty/4708:
  #0: 000000008ec58632 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:353
  #1: 00000000f247898c (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
2 locks held by getty/4709:
  #0: 000000001ebc9104 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:353
  #1: 00000000c5deaf68 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
2 locks held by getty/4710:
  #0: 00000000da7ef2b1 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:353
  #1: 000000003a231089 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
1 lock held by udevd/4711:
  #0: 00000000077431f3 (&dup_mmap_sem){++++}, at: dup_mmap kernel/fork.c:431  
[inline]
  #0: 00000000077431f3 (&dup_mmap_sem){++++}, at: dup_mm kernel/fork.c:1275  
[inline]
  #0: 00000000077431f3 (&dup_mmap_sem){++++}, at: copy_mm kernel/fork.c:1330  
[inline]
  #0: 00000000077431f3 (&dup_mmap_sem){++++}, at: copy_process+0x2b3d/0x7af0  
kernel/fork.c:1870
1 lock held by udevd/4712:
  #0: 00000000077431f3 (&dup_mmap_sem){++++}, at: dup_mmap kernel/fork.c:431  
[inline]
  #0: 00000000077431f3 (&dup_mmap_sem){++++}, at: dup_mm kernel/fork.c:1275  
[inline]
  #0: 00000000077431f3 (&dup_mmap_sem){++++}, at: copy_mm kernel/fork.c:1330  
[inline]
  #0: 00000000077431f3 (&dup_mmap_sem){++++}, at: copy_process+0x2b3d/0x7af0  
kernel/fork.c:1870
1 lock held by syz-executor0/4752:
  #0: 00000000077431f3 (&dup_mmap_sem){++++}, at: dup_mmap kernel/fork.c:431  
[inline]
  #0: 00000000077431f3 (&dup_mmap_sem){++++}, at: dup_mm kernel/fork.c:1275  
[inline]
  #0: 00000000077431f3 (&dup_mmap_sem){++++}, at: copy_mm kernel/fork.c:1330  
[inline]
  #0: 00000000077431f3 (&dup_mmap_sem){++++}, at: copy_process+0x2b3d/0x7af0  
kernel/fork.c:1870
1 lock held by syz-executor1/4754:
  #0: 00000000077431f3 (&dup_mmap_sem){++++}, at: dup_mmap kernel/fork.c:431  
[inline]
  #0: 00000000077431f3 (&dup_mmap_sem){++++}, at: dup_mm kernel/fork.c:1275  
[inline]
  #0: 00000000077431f3 (&dup_mmap_sem){++++}, at: copy_mm kernel/fork.c:1330  
[inline]
  #0: 00000000077431f3 (&dup_mmap_sem){++++}, at: copy_process+0x2b3d/0x7af0  
kernel/fork.c:1870
1 lock held by syz-executor6/4756:
  #0: 00000000077431f3 (&dup_mmap_sem){++++}, at: dup_mmap kernel/fork.c:431  
[inline]
  #0: 00000000077431f3 (&dup_mmap_sem){++++}, at: dup_mm kernel/fork.c:1275  
[inline]
  #0: 00000000077431f3 (&dup_mmap_sem){++++}, at: copy_mm kernel/fork.c:1330  
[inline]
  #0: 00000000077431f3 (&dup_mmap_sem){++++}, at: copy_process+0x2b3d/0x7af0  
kernel/fork.c:1870
1 lock held by syz-executor7/4758:
  #0: 00000000077431f3 (&dup_mmap_sem){++++}, at: dup_mmap kernel/fork.c:431  
[inline]
  #0: 00000000077431f3 (&dup_mmap_sem){++++}, at: dup_mm kernel/fork.c:1275  
[inline]
  #0: 00000000077431f3 (&dup_mmap_sem){++++}, at: copy_mm kernel/fork.c:1330  
[inline]
  #0: 00000000077431f3 (&dup_mmap_sem){++++}, at: copy_process+0x2b3d/0x7af0  
kernel/fork.c:1870
1 lock held by udevd/6793:
  #0: 00000000077431f3 (&dup_mmap_sem){++++}, at: dup_mmap kernel/fork.c:431  
[inline]
  #0: 00000000077431f3 (&dup_mmap_sem){++++}, at: dup_mm kernel/fork.c:1275  
[inline]
  #0: 00000000077431f3 (&dup_mmap_sem){++++}, at: copy_mm kernel/fork.c:1330  
[inline]
  #0: 00000000077431f3 (&dup_mmap_sem){++++}, at: copy_process+0x2b3d/0x7af0  
kernel/fork.c:1870
1 lock held by udevd/6805:
  #0: 00000000077431f3 (&dup_mmap_sem){++++}, at: dup_mmap kernel/fork.c:431  
[inline]
  #0: 00000000077431f3 (&dup_mmap_sem){++++}, at: dup_mm kernel/fork.c:1275  
[inline]
  #0: 00000000077431f3 (&dup_mmap_sem){++++}, at: copy_mm kernel/fork.c:1330  
[inline]
  #0: 00000000077431f3 (&dup_mmap_sem){++++}, at: copy_process+0x2b3d/0x7af0  
kernel/fork.c:1870
1 lock held by udevd/6813:
  #0: 00000000077431f3 (&dup_mmap_sem){++++}, at: dup_mmap kernel/fork.c:431  
[inline]
  #0: 00000000077431f3 (&dup_mmap_sem){++++}, at: dup_mm kernel/fork.c:1275  
[inline]
  #0: 00000000077431f3 (&dup_mmap_sem){++++}, at: copy_mm kernel/fork.c:1330  
[inline]
  #0: 00000000077431f3 (&dup_mmap_sem){++++}, at: copy_process+0x2b3d/0x7af0  
kernel/fork.c:1870
1 lock held by udevd/7279:
  #0: 00000000077431f3 (&dup_mmap_sem){++++}, at: dup_mmap kernel/fork.c:431  
[inline]
  #0: 00000000077431f3 (&dup_mmap_sem){++++}, at: dup_mm kernel/fork.c:1275  
[inline]
  #0: 00000000077431f3 (&dup_mmap_sem){++++}, at: copy_mm kernel/fork.c:1330  
[inline]
  #0: 00000000077431f3 (&dup_mmap_sem){++++}, at: copy_process+0x2b3d/0x7af0  
kernel/fork.c:1870
1 lock held by syz-executor0/18570:
  #0: 00000000077431f3 (&dup_mmap_sem){++++}, at: dup_mmap kernel/fork.c:431  
[inline]
  #0: 00000000077431f3 (&dup_mmap_sem){++++}, at: dup_mm kernel/fork.c:1275  
[inline]
  #0: 00000000077431f3 (&dup_mmap_sem){++++}, at: copy_mm kernel/fork.c:1330  
[inline]
  #0: 00000000077431f3 (&dup_mmap_sem){++++}, at: copy_process+0x2b3d/0x7af0  
kernel/fork.c:1870
1 lock held by syz-executor5/30110:
  #0: 00000000df7208fd (event_mutex){+.+.}, at:  
perf_trace_destroy+0x28/0x100 kernel/trace/trace_event_perf.c:236
5 locks held by syz-executor5/30115:
  #0: 00000000432a4d43 (&sig->cred_guard_mutex){+.+.}, at:  
__do_sys_perf_event_open+0x12fe/0x2f30 kernel/events/core.c:10480
  #1: 0000000043990672 (&pmus_srcu){....}, at:  
perf_event_alloc.part.93+0xffc/0x33c0 kernel/events/core.c:10039
  #2: 00000000df7208fd (event_mutex){+.+.}, at: perf_uprobe_init+0x1da/0x280  
kernel/trace/trace_event_perf.c:327
  #3: 00000000eb6356ce (&uprobe->register_rwsem){+.+.}, at:  
__uprobe_register kernel/events/uprobes.c:922 [inline]
  #3: 00000000eb6356ce (&uprobe->register_rwsem){+.+.}, at:  
uprobe_register+0x3dd/0x7c0 kernel/events/uprobes.c:941
  #4: 00000000077431f3 (&dup_mmap_sem){++++}, at:  
percpu_down_write+0xaf/0x540 kernel/locking/percpu-rwsem.c:145
1 lock held by syz-executor4/30114:
  #0: 00000000df7208fd (event_mutex){+.+.}, at:  
perf_trace_destroy+0x28/0x100 kernel/trace/trace_event_perf.c:236
3 locks held by syz-executor4/30117:
  #0: 000000007654572a (&sig->cred_guard_mutex){+.+.}, at:  
__do_sys_perf_event_open+0x12fe/0x2f30 kernel/events/core.c:10480
  #1: 0000000043990672 (&pmus_srcu){....}, at:  
perf_event_alloc.part.93+0xffc/0x33c0 kernel/events/core.c:10039
kworker/dying (7) used greatest stack depth: 11432 bytes left
  #2: 00000000df7208fd (event_mutex){+.+.}, at: perf_trace_init+0x50/0x250  
kernel/trace/trace_event_perf.c:218
3 locks held by syz-executor3/30125:
  #0: 00000000fc87ade4 (&sig->cred_guard_mutex){+.+.}, at:  
__do_sys_perf_event_open+0x12fe/0x2f30 kernel/events/core.c:10480
  #1: 0000000043990672 (&pmus_srcu){....}, at:  
perf_event_alloc.part.93+0xffc/0x33c0 kernel/events/core.c:10039
  #2: 00000000df7208fd (event_mutex){+.+.}, at: perf_trace_init+0x50/0x250  
kernel/trace/trace_event_perf.c:218
3 locks held by syz-executor2/30129:
  #0: 00000000d282122d (&sig->cred_guard_mutex){+.+.}, at:  
__do_sys_perf_event_open+0x12fe/0x2f30 kernel/events/core.c:10480
  #1: 0000000043990672 (&pmus_srcu){....}, at:  
perf_event_alloc.part.93+0xffc/0x33c0 kernel/events/core.c:10039
  #2: 00000000df7208fd (event_mutex){+.+.}, at: perf_trace_init+0x50/0x250  
kernel/trace/trace_event_perf.c:218

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 792 Comm: khungtaskd Not tainted 4.19.0-rc2-next-20180904+ #55
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
  nmi_cpu_backtrace.cold.3+0x48/0x88 lib/nmi_backtrace.c:101
  nmi_trigger_cpumask_backtrace+0x151/0x192 lib/nmi_backtrace.c:62
  arch_trigger_cpumask_backtrace+0x14/0x20 arch/x86/kernel/apic/hw_nmi.c:38
  trigger_all_cpu_backtrace include/linux/nmi.h:144 [inline]
  check_hung_uninterruptible_tasks kernel/hung_task.c:204 [inline]
  watchdog+0xb39/0x1040 kernel/hung_task.c:265
  kthread+0x35a/0x420 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:415
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1 skipped: idling at native_safe_halt+0x6/0x10  
arch/x86/include/asm/irqflags.h:57


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
