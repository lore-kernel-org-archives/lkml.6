Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 150AAC04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 08:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF4F320851
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 08:48:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF4F320851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725978AbeLDIsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 03:48:04 -0500
Received: from mail-it1-f199.google.com ([209.85.166.199]:45009 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbeLDIsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 03:48:04 -0500
Received: by mail-it1-f199.google.com with SMTP id x82so11803223ita.9
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 00:48:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=LlkaKoMTPa/MCE8ZIfD1mH2NVO+svCwY1Nn4HjvG9rM=;
        b=aWbVzuecT0xG5AgFoTWo7CRlavXbP04/nqk7nglSH0G5X4Sr81mrkHRFBKntxiDLsx
         6EOfOikyE6nqzCU9Z1LtxG7ky0E9LkcOzPQWrk127jbJh4fwlnINWSXdwvS1dBjCscqy
         ml+AIo05Nd5KNPlZL7yW2P9bHT4htMy59PaaGANL5kiWIq4D5ettpz6lVVwVBDRfmhPj
         oUl4TqMl1vHEN4BiHwJty5HUDyGsH84QMek9/OMZjIXySLV6Z9HWmfyNGMIjfiCkOhSY
         B5+J0U7XmbLczzR8vPCAm4lfVH2oBON7nkzhQwMlYMFR5jH6u93SEs8CGEGgkUPRDxQn
         Mhdg==
X-Gm-Message-State: AA+aEWbnO1jueTbCNozKcWKfKF/8pC0Wg+rhzlFafHi0Y89ExWqAxc4T
        lhr+xD3pcgjpIY8aGMiffB5zbD1PymMXqQoCCYHOR2vcCqmZ
X-Google-Smtp-Source: AFSGD/WfQ0S9gsggZYXsQanH15ZUakGcJ/cp+WcaUyds1rY23tNUJl97jahfp2Qhx/yBMxwltz1q9JurEMOC0IqHnduLXHUteaBA
MIME-Version: 1.0
X-Received: by 2002:a24:134b:: with SMTP id 72mr9195503itz.15.1543913282905;
 Tue, 04 Dec 2018 00:48:02 -0800 (PST)
Date:   Tue, 04 Dec 2018 00:48:02 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cab053057c2e5202@google.com>
Subject: INFO: task hung in tls_sw_free_resources_tx
From:   syzbot <syzbot+503339bf3c9053b8a7fc@syzkaller.appspotmail.com>
To:     aviadye@mellanox.com, borisp@mellanox.com, daniel@iogearbox.net,
        davejwatson@fb.com, davem@davemloft.net, john.fastabend@gmail.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    6915bf3b002b net: phy: don't allow __set_phy_supported to ..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=177085a3400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=28ecefa8a6e10719
dashboard link: https://syzkaller.appspot.com/bug?extid=503339bf3c9053b8a7fc
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11e6996d400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=117e2125400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+503339bf3c9053b8a7fc@syzkaller.appspotmail.com

TCP: request_sock_TCPv6: Possible SYN flooding on port 20002. Sending  
cookies.  Check SNMP counters.
TCP: request_sock_TCPv6: Possible SYN flooding on port 20002. Sending  
cookies.  Check SNMP counters.
TCP: request_sock_TCPv6: Possible SYN flooding on port 20002. Sending  
cookies.  Check SNMP counters.
INFO: task syz-executor852:6003 blocked for more than 140 seconds.
       Not tainted 4.20.0-rc4+ #324
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor852 D20984  6003   5985 0x00000004
Call Trace:
  context_switch kernel/sched/core.c:2831 [inline]
  __schedule+0x8cf/0x21d0 kernel/sched/core.c:3472
  schedule+0xfe/0x460 kernel/sched/core.c:3516
  schedule_timeout+0x1cc/0x260 kernel/time/timer.c:1780
  do_wait_for_common kernel/sched/completion.c:83 [inline]
  __wait_for_common kernel/sched/completion.c:104 [inline]
  wait_for_common kernel/sched/completion.c:115 [inline]
  wait_for_completion+0x427/0x8a0 kernel/sched/completion.c:136
  crypto_wait_req include/linux/crypto.h:583 [inline]
  tls_sw_free_resources_tx+0x52b/0xcf0 net/tls/tls_sw.c:1774
  tls_sk_proto_close+0x602/0x750 net/tls/tls_main.c:278
  inet_release+0x104/0x1f0 net/ipv4/af_inet.c:428
  inet6_release+0x50/0x70 net/ipv6/af_inet6.c:458
  __sock_release+0xd7/0x250 net/socket.c:579
  sock_close+0x19/0x20 net/socket.c:1141
  __fput+0x385/0xa30 fs/file_table.c:278
  ____fput+0x15/0x20 fs/file_table.c:309
  task_work_run+0x1e8/0x2a0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:188 [inline]
  exit_to_usermode_loop+0x318/0x380 arch/x86/entry/common.c:166
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x400fe0
Code: 01 f0 ff ff 0f 83 b0 0a 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f  
44 00 00 83 3d ed 16 2d 00 00 75 14 b8 03 00 00 00 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 84 0a 00 00 c3 48 83 ec 08 e8 3a 01 00 00
RSP: 002b:00007ffe30095a88 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000400fe0
RDX: 0000000000000058 RSI: 0000000020000000 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000000 R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000067edd
R13: 0000000000401f80 R14: 0000000000000000 R15: 0000000000000000

Showing all locks held in the system:
1 lock held by khungtaskd/1020:
  #0: 0000000034ca4b1e (rcu_read_lock){....}, at:  
debug_show_all_locks+0xd0/0x424 kernel/locking/lockdep.c:4379
1 lock held by rsyslogd/5866:
  #0: 00000000f2b3f94d (&f->f_pos_lock){+.+.}, at: __fdget_pos+0x1bb/0x200  
fs/file.c:766
2 locks held by getty/5956:
  #0: 000000000ac99831 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x32/0x40 drivers/tty/tty_ldsem.c:353
  #1: 00000000d09933e4 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1e80 drivers/tty/n_tty.c:2154
2 locks held by getty/5957:
  #0: 000000005f0193c3 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x32/0x40 drivers/tty/tty_ldsem.c:353
  #1: 00000000f88a15c8 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1e80 drivers/tty/n_tty.c:2154
2 locks held by getty/5958:
  #0: 00000000794f4a79 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x32/0x40 drivers/tty/tty_ldsem.c:353
  #1: 000000002fefcb05 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1e80 drivers/tty/n_tty.c:2154
2 locks held by getty/5959:
  #0: 0000000074eb97d6 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x32/0x40 drivers/tty/tty_ldsem.c:353
  #1: 0000000065ce552e (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1e80 drivers/tty/n_tty.c:2154
2 locks held by getty/5960:
  #0: 00000000c84b7e95 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x32/0x40 drivers/tty/tty_ldsem.c:353
  #1: 0000000020f1a59d (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1e80 drivers/tty/n_tty.c:2154
2 locks held by getty/5961:
  #0: 00000000c90dcbd8 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x32/0x40 drivers/tty/tty_ldsem.c:353
  #1: 00000000409d1c2e (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1e80 drivers/tty/n_tty.c:2154
2 locks held by getty/5962:
  #0: 000000006f39f77f (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x32/0x40 drivers/tty/tty_ldsem.c:353
  #1: 00000000c23bd515 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1e80 drivers/tty/n_tty.c:2154
2 locks held by syz-executor852/6003:
  #0: 000000005aa3007c (&sb->s_type->i_mutex_key#11){+.+.}, at: inode_lock  
include/linux/fs.h:757 [inline]
  #0: 000000005aa3007c (&sb->s_type->i_mutex_key#11){+.+.}, at:  
__sock_release+0x8b/0x250 net/socket.c:578
  #1: 0000000097a7edc0 (sk_lock-AF_INET6){+.+.}, at: lock_sock  
include/net/sock.h:1492 [inline]
  #1: 0000000097a7edc0 (sk_lock-AF_INET6){+.+.}, at:  
tls_sk_proto_close+0xf5/0x750 net/tls/tls_main.c:262

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 1020 Comm: khungtaskd Not tainted 4.20.0-rc4+ #324
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x39d lib/dump_stack.c:113
  nmi_cpu_backtrace.cold.2+0x5c/0xa1 lib/nmi_backtrace.c:101
  nmi_trigger_cpumask_backtrace+0x1e8/0x22a lib/nmi_backtrace.c:62
  arch_trigger_cpumask_backtrace+0x14/0x20 arch/x86/kernel/apic/hw_nmi.c:38
  trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
  check_hung_uninterruptible_tasks kernel/hung_task.c:205 [inline]
  watchdog+0xb51/0x1060 kernel/hung_task.c:289
  kthread+0x35a/0x440 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
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
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
