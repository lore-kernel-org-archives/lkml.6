Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SORTED_RECIPS,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 324BDC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 15:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9043208E5
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 15:18:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9043208E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389001AbeGKPWw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 11:22:52 -0400
Received: from mail-it0-f70.google.com ([209.85.214.70]:45036 "EHLO
        mail-it0-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbeGKPWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 11:22:51 -0400
Received: by mail-it0-f70.google.com with SMTP id z8-v6so2317930itc.9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 08:18:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=tDXEyUNdmDW3vsjXXVFpRUt5ZGpClDWeQp9HYLxDLpY=;
        b=A81gDi6rXB5V6X/+wdb4D2YWKWzORMU78BWWlUpLPZf6aQm3EJ8tXk/hIMVUHQL1ZV
         2xMESUq7vfrGNomFKnP6QW27rMVydRwu6pFtinhRQ+sA9JV9PP5KTsbO3eYzlcRkZLBR
         rfQ2D7e3QXdcEIoYgZ+PalzxacIaMd5aJxX5MRAl0KZmy/6bU4yKHtLsYr/e2Yh18XV+
         ZaoW8v0OunQpqWh6fm73vsWN3RiKhu7L5ZcdfoXJGunj0tQyPDEpROlcp6rK5h+xrppL
         PEt14sOL+wCYgASlVpDr3KpJ0GWQPItA1TktvauITUpPFSYQs9UgVXWqTm7xJT3howSY
         An0Q==
X-Gm-Message-State: AOUpUlErluUekYJcUaLLx4aoEqFHrobXdGAOdjT8Ihk5IpvHHkCNFdMT
        mCasZcvvB4o953GWG+6KxmMBQ6ePNA49VLUxFm/kqXSPa512
X-Google-Smtp-Source: AAOMgpdfzCizGJQ8XSIbW96hdKbAby69/NFWN9GXiLrEH3m4IJMF4DBjO9PZrjnOG44/muy4BWYn+b2mk3BZ6P7qNOceMGzivv7O
MIME-Version: 1.0
X-Received: by 2002:a6b:5d1c:: with SMTP id r28-v6mr12934106iob.47.1531322282659;
 Wed, 11 Jul 2018 08:18:02 -0700 (PDT)
Date:   Wed, 11 Jul 2018 08:18:02 -0700
In-Reply-To: <000000000000b15fb3056b9f94e7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b1e6c40570bac075@google.com>
Subject: Re: INFO: task hung in flush_work
From:   syzbot <syzbot+2e7b6af5956e05e5cff7@syzkaller.appspotmail.com>
To:     davem@davemloft.net, ericvh@gmail.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        lucho@ionkov.net, netdev@vger.kernel.org, rminnich@sandia.gov,
        syzkaller-bugs@googlegroups.com, ubraun@linux.ibm.com,
        v9fs-developer@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    98be45067040 Add linux-next specific files for 20180711
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=102f1d0c400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3f3b3673fec35d01
dashboard link: https://syzkaller.appspot.com/bug?extid=2e7b6af5956e05e5cff7
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=11bed2e0400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=117415b2400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+2e7b6af5956e05e5cff7@syzkaller.appspotmail.com

INFO: task syz-executor810:4676 blocked for more than 140 seconds.
       Not tainted 4.18.0-rc4-next-20180711+ #4
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor810 D23936  4676   4481 0x00000004
Call Trace:
  context_switch kernel/sched/core.c:2853 [inline]
  __schedule+0x87c/0x1ed0 kernel/sched/core.c:3501
  schedule+0xfb/0x450 kernel/sched/core.c:3545
  schedule_timeout+0x1cc/0x260 kernel/time/timer.c:1777
  do_wait_for_common kernel/sched/completion.c:83 [inline]
  __wait_for_common kernel/sched/completion.c:104 [inline]
  wait_for_common kernel/sched/completion.c:115 [inline]
  wait_for_completion+0x430/0x8d0 kernel/sched/completion.c:136
  flush_work+0x531/0x900 kernel/workqueue.c:2918
  __cancel_work_timer+0x4bd/0x830 kernel/workqueue.c:2989
  cancel_work_sync+0x17/0x20 kernel/workqueue.c:3025
  p9_conn_destroy net/9p/trans_fd.c:860 [inline]
  p9_fd_close+0x36a/0x5b0 net/9p/trans_fd.c:886
  p9_client_create+0xa9a/0x1770 net/9p/client.c:1077
  v9fs_session_init+0x21a/0x1a80 fs/9p/v9fs.c:400
  v9fs_mount+0x7c/0x900 fs/9p/vfs_super.c:135
  legacy_get_tree+0x118/0x440 fs/fs_context.c:659
  vfs_get_tree+0x1cb/0x5c0 fs/super.c:1743
  do_new_mount fs/namespace.c:2567 [inline]
  do_mount+0x6c1/0x1fb0 fs/namespace.c:2889
  ksys_mount+0x12d/0x140 fs/namespace.c:3105
  __do_sys_mount fs/namespace.c:3119 [inline]
  __se_sys_mount fs/namespace.c:3116 [inline]
  __x64_sys_mount+0xbe/0x150 fs/namespace.c:3116
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x445e89
Code: Bad RIP value.
RSP: 002b:00007fd68625eda8 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00000000006dbc3c RCX: 0000000000445e89
RDX: 0000000020000340 RSI: 00000000200000c0 RDI: 0000000000000000
RBP: 0000000000000000 R08: 00000000200001c0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 00000000006dbc38
R13: 0030656c69662f2e R14: 64663d736e617274 R15: 0000000000000005
INFO: lockdep is turned off.
NMI backtrace for cpu 1
CPU: 1 PID: 901 Comm: khungtaskd Not tainted 4.18.0-rc4-next-20180711+ #4
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
  nmi_cpu_backtrace.cold.3+0x48/0x88 lib/nmi_backtrace.c:101
  nmi_trigger_cpumask_backtrace+0x151/0x192 lib/nmi_backtrace.c:62
  arch_trigger_cpumask_backtrace+0x14/0x20 arch/x86/kernel/apic/hw_nmi.c:38
  trigger_all_cpu_backtrace include/linux/nmi.h:144 [inline]
  check_hung_uninterruptible_tasks kernel/hung_task.c:231 [inline]
  watchdog+0xb81/0x10f0 kernel/hung_task.c:292
  kthread+0x345/0x410 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:415
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0 skipped: idling at native_safe_halt+0x6/0x10  
arch/x86/include/asm/irqflags.h:54

