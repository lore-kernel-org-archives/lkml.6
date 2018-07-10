Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6BDBC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 08:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2DE52089D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 08:08:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2DE52089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754265AbeGJIIF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 04:08:05 -0400
Received: from mail-io0-f200.google.com ([209.85.223.200]:45952 "EHLO
        mail-io0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751335AbeGJIID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 04:08:03 -0400
Received: by mail-io0-f200.google.com with SMTP id i18-v6so18440394iog.12
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 01:08:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=lgtfvV0ZC/2AVSY7n49B5zNu6JT4hlnjI+fB229B+oQ=;
        b=gTVejRzHAHy1BCKvh9UXfbhXJ1OEMJxmECuQucbiHpBKjBsmYsFiQvhGyf1fwb2VT1
         /Jp9901PE7BYD+oMH9SCo5pMgqqP/FFaZ3ysKl3MH7WzDtp8ra80wXm5gKnws9gklfyT
         gNoHL9DHCSi/NFrryyQibdATbT+mn5hvVOd0BVa+o4+nwFT9yII4m7UpNYQn5XA252N4
         r9suRPDGIX7rUbvOI2Lq69uplpr1D14yjXfyCoKM7LLMeC21Aij5J1K4pHjeRfEkEMfn
         32qbqF/w+X9Rt2ZucwkAA1Lm2PlDzanf6OBdXQLX6OxjbVvMHQ3mq7CrDtFTYiuFNhWP
         sTMA==
X-Gm-Message-State: AOUpUlFl4aP5JUb+3TNpWYX7V/rJB5PGmdlDJLfTbUaDq++uSn7tFk42
        Yh4E3MpeG+S02cuubluMkIsQZ5YT5cVz7XviNAEKAB9bhWLY
X-Google-Smtp-Source: AAOMgpdqB2+eVPFV5KxIF6yiY+XNyoHGkV5HVrD2xF1BlcK9rPCgNNU+PiczcN8Xy/K2mPgoY7TaIkO949yx9J75oNMZozF5xpWd
MIME-Version: 1.0
X-Received: by 2002:a6b:6518:: with SMTP id z24-v6mr10291890iob.20.1531210082525;
 Tue, 10 Jul 2018 01:08:02 -0700 (PDT)
Date:   Tue, 10 Jul 2018 01:08:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000bafc80570a0a1db@google.com>
Subject: INFO: task hung in utimes_common
From:   syzbot <syzbot+3a0570f93c0d6ca388f5@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    d00d6d9a339d Add linux-next specific files for 20180709
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17fdd90c400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=94fe2b586beccacd
dashboard link: https://syzkaller.appspot.com/bug?extid=3a0570f93c0d6ca388f5
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+3a0570f93c0d6ca388f5@syzkaller.appspotmail.com

9pnet_virtio: no channels available for device (null)
Unknown ioctl 44801
9pnet_virtio: no channels available for device (null)
9pnet: Insufficient options for proto=fd
9pnet: Insufficient options for proto=fd
INFO: task syz-executor0:12044 blocked for more than 140 seconds.
       Not tainted 4.18.0-rc3-next-20180709+ #2
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor0   D25408 12044   4539 0x00000004
Call Trace:
  context_switch kernel/sched/core.c:2853 [inline]
  __schedule+0x87c/0x1ed0 kernel/sched/core.c:3501
  schedule+0xfb/0x450 kernel/sched/core.c:3545
  __rwsem_down_write_failed_common+0x95d/0x1630  
kernel/locking/rwsem-xadd.c:566
  rwsem_down_write_failed+0xe/0x10 kernel/locking/rwsem-xadd.c:595
  call_rwsem_down_write_failed+0x17/0x30 arch/x86/lib/rwsem.S:117
  __down_write arch/x86/include/asm/rwsem.h:142 [inline]
  down_write+0xaa/0x130 kernel/locking/rwsem.c:72
  inode_lock include/linux/fs.h:748 [inline]
  utimes_common.isra.1+0x45c/0x8e0 fs/utimes.c:90
  do_utimes+0x1f7/0x380 fs/utimes.c:156
  do_futimesat+0x249/0x350 fs/utimes.c:212
  __do_sys_utimes fs/utimes.c:225 [inline]
  __se_sys_utimes fs/utimes.c:222 [inline]
  __x64_sys_utimes+0x59/0x80 fs/utimes.c:222
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x455e29
Code: cc 64 48 8b 0c 25 f8 ff ff ff 48 3b 61 10 0f 86 ab 04 00 00 48 83 ec  
58 48 89 6c 24 50 48 8d 6c 24 50 48 8b 44 24 60 c6 00 00 <48> 8b 4c 24 68  
48 89 ca 48 89 50 08 48 8b 59 20 48 01 da 31 db 31
RSP: 002b:00007fac7c8b4c68 EFLAGS: 00000246 ORIG_RAX: 00000000000000eb
RAX: ffffffffffffffda RBX: 00007fac7c8b56d4 RCX: 0000000000455e29
RDX: 0000000000000000 RSI: 0000000020000380 RDI: 0000000020000180
RBP: 000000000072bff0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000004c2af0 R14: 00000000004d4600 R15: 0000000000000002
INFO: lockdep is turned off.
NMI backtrace for cpu 1
CPU: 1 PID: 898 Comm: khungtaskd Not tainted 4.18.0-rc3-next-20180709+ #2
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
  nmi_cpu_backtrace.cold.5+0x19/0xce lib/nmi_backtrace.c:103
  nmi_trigger_cpumask_backtrace+0x151/0x192 lib/nmi_backtrace.c:62
  arch_trigger_cpumask_backtrace+0x14/0x20 arch/x86/kernel/apic/hw_nmi.c:38
  trigger_all_cpu_backtrace include/linux/nmi.h:143 [inline]
  check_hung_uninterruptible_tasks kernel/hung_task.c:204 [inline]
  watchdog+0xb39/0x10b0 kernel/hung_task.c:265
  kthread+0x345/0x410 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:415
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0 skipped: idling at native_safe_halt+0x6/0x10  
arch/x86/include/asm/irqflags.h:54


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
