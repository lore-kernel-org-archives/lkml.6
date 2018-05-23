Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-582301-1527102788-2-51989693013551336
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527102787; b=DFlUS77YtEZey00Oh/hT7jJE/Ytozrx7iFTRcLUqbKK/+6tkb0
    nZ/xMfqmYL7SyHqeF6rvlZHTvC6zr/MjO0tdiuFky0a/p3oht/xX8yYICWuw6d66
    HhdL77Ln1Dec3GNfsKVhH2liKFK/eXUAzZSKKfo4IUNzf7aDIcTpcA4/OUeEhTEL
    3UKcHx7HcbZUVRNt0JhhWlmyvXUfaArOAZadD/ysg6etsMw975dQbk+EPEWDSDJd
    Uft2+AS/It+kDC0hrrcebvbqd6KOUg3Rb7tWZBoq1UUBacoh6oyBUhnRDcFdaEtB
    1WO5PJJ3JIpYNHOTEOJTxR5Pz9wRihyr7pIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:date:in-reply-to:message-id
    :subject:from:to:content-type:sender:list-id; s=fm2; t=
    1527102787; bh=yRhYeOWUyphfU2KtUb8qxZl1lMpyDOoOg9VtN5t8uoY=; b=I
    lM53ENbushTbSGnaopRkFZ+uCbSwccaxN00xxo0dapGSMbcr5E/WYl3eucFiGEBi
    2cvpqpqYFAhyX2gXxjb+u9lDi/F2KCFmeb7/BTAqz6XH0ohdYsT4IBtrVCQtvGen
    iLp9W8wmhMS8WroFytbqLZOJ18D/QjFW19PyeSmZr2tGNG/ob0RYN6HcKcxnbIeC
    TdRHw6rfYBmUhVUm1xNwCXfE5eJZKyE5R/FeO4FGg5o3bc+RLFRMN8AKzgfrPMup
    W4PQdtpZX2job3wm1GqaaeZoxRI1XNNClGaT+MYxIHbOiCP/BecUk58Qfqzri0zX
    BUcQk3eQ0532X3uwai2AQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none)
    header.from=syzkaller.appspotmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=W8eGndzH;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=syzkaller.appspotmail.com header.result=pass
    header_org.domain=appspotmail.com header_org.result=pass
    header_is_org_domain=no;
    x-vs=clean score=49 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none)
      header.from=syzkaller.appspotmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=W8eGndzH;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=syzkaller.appspotmail.com header.result=pass
      header_org.domain=appspotmail.com header_org.result=pass
      header_is_org_domain=no;
    x-vs=clean score=49 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCF4bqKqOPpC3nxGwlSFfxDJjE28wnrU0I27d2hroPpvm8kiYACVunHS1gQy1uVmOvLmOX+NlNyGPGv0bNTrxURoHgsDMxl1oFW5AWMQX9rk0nGbawwg
    eeOpQ46V4UGXw9Zu0VJNm35MO61RQ4iO9wTBXQe+jCZkAoz8Vh1+Nd+sH+j9UGA1c/3u2x7nT2eHyEp1D1nccxifcNaqfOBs8IzdkPhFTCNOzV+DI5w2ZW/r
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=edf1wS77AAAA:8 a=hSkVLCK3AAAA:8 a=p55jOCE_y_dqNojW3U0A:9
    a=4JDd3G27FG5WJ5-w:21 a=QEXdDO2ut3YA:10 a=DcSpbTIhAlouE1Uv7lRv:22
    a=cQPPKAXgyycSBL8etih5:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934206AbeEWTNE (ORCPT <rfc822;linux@kroah.com>);
        Wed, 23 May 2018 15:13:04 -0400
Received: from mail-io0-f200.google.com ([209.85.223.200]:34155 "EHLO
        mail-io0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934085AbeEWTND (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 May 2018 15:13:03 -0400
X-Google-Smtp-Source: ADUXVKIqEfO/dtKG4CFgI4+EKx6ZaS22D9fpEPuOEIyuReZ7WOPZvWx3KOFgdNpYWtMgouJhm6BIR4LND7upcPX/plDUE0NqP9gF
MIME-Version: 1.0
Date: Wed, 23 May 2018 12:13:02 -0700
In-Reply-To: <0000000000006de361056b146dbe@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e588f5056ce452ce@google.com>
Subject: Re: INFO: task hung in lock_mount
From: syzbot <syzbot+221d75710bde87fa0e97@syzkaller.appspotmail.com>
To: dvyukov@google.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

syzbot has found a reproducer for the following crash on:

HEAD commit:    a048a07d7f45 powerpc/64s: Add support for a store forwardi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1084cc27800000
kernel config:  https://syzkaller.appspot.com/x/.config?x=982e2df1b9e60b02
dashboard link: https://syzkaller.appspot.com/bug?extid=221d75710bde87fa0e97
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=13992a0f800000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=131a727b800000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+221d75710bde87fa0e97@syzkaller.appspotmail.com

INFO: task syz-executor694:4903 blocked for more than 120 seconds.
       Not tainted 4.17.0-rc6+ #63
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor694 D24936  4903   4506 0x00000004
Call Trace:
  context_switch kernel/sched/core.c:2859 [inline]
  __schedule+0x801/0x1e30 kernel/sched/core.c:3501
  schedule+0xef/0x430 kernel/sched/core.c:3545
  __rwsem_down_write_failed_common+0x919/0x15d0  
kernel/locking/rwsem-xadd.c:565
  rwsem_down_write_failed+0xe/0x10 kernel/locking/rwsem-xadd.c:594
  call_rwsem_down_write_failed+0x17/0x30 arch/x86/lib/rwsem.S:117
  __down_write arch/x86/include/asm/rwsem.h:142 [inline]
  down_write+0xa2/0x120 kernel/locking/rwsem.c:72
  namespace_lock fs/namespace.c:1431 [inline]
  lock_mount+0xdc/0x2e0 fs/namespace.c:2093
  do_loopback fs/namespace.c:2221 [inline]
  do_mount+0xebc/0x3070 fs/namespace.c:2842
  ksys_mount+0x12d/0x140 fs/namespace.c:3064
  __do_sys_mount fs/namespace.c:3078 [inline]
  __se_sys_mount fs/namespace.c:3075 [inline]
  __x64_sys_mount+0xbe/0x150 fs/namespace.c:3075
  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x447099
RSP: 002b:00007f0d700b4da8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00000000006ddcb4 RCX: 0000000000447099
RDX: 0000000020000140 RSI: 00000000200000c0 RDI: 0000000020000000
RBP: 00000000006ddcb0 R08: 0000000020000200 R09: 0000000000000000
R10: 0000000000003080 R11: 0000000000000246 R12: 0030656c69662f2e
R13: 6f7365725f736e64 R14: 70756f7267632f2e R15: 0000000000000007

Showing all locks held in the system:
2 locks held by khungtaskd/892:
  #0:         (ptrval) (rcu_read_lock){....}, at:  
check_hung_uninterruptible_tasks kernel/hung_task.c:175 [inline]
  #0:         (ptrval) (rcu_read_lock){....}, at: watchdog+0x1ff/0xf60  
kernel/hung_task.c:249
  #1:         (ptrval) (tasklist_lock){.+.+}, at:  
debug_show_all_locks+0xde/0x34a kernel/locking/lockdep.c:4470
1 lock held by rsyslogd/4380:
  #0:         (ptrval) (&f->f_pos_lock){+.+.}, at: __fdget_pos+0x1a9/0x1e0  
fs/file.c:766
2 locks held by getty/4470:
  #0:         (ptrval) (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1:         (ptrval) (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x321/0x1cc0 drivers/tty/n_tty.c:2131
2 locks held by getty/4471:
  #0:         (ptrval) (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1:         (ptrval) (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x321/0x1cc0 drivers/tty/n_tty.c:2131
2 locks held by getty/4472:
  #0:         (ptrval) (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1:         (ptrval) (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x321/0x1cc0 drivers/tty/n_tty.c:2131
2 locks held by getty/4473:
  #0:         (ptrval) (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1:         (ptrval) (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x321/0x1cc0 drivers/tty/n_tty.c:2131
2 locks held by getty/4474:
  #0:         (ptrval) (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1:         (ptrval) (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x321/0x1cc0 drivers/tty/n_tty.c:2131
2 locks held by getty/4475:
  #0:         (ptrval) (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1:         (ptrval) (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x321/0x1cc0 drivers/tty/n_tty.c:2131
2 locks held by getty/4476:
  #0:         (ptrval) (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1:         (ptrval) (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x321/0x1cc0 drivers/tty/n_tty.c:2131
2 locks held by syz-executor694/4903:
  #0:         (ptrval) (&sb->s_type->i_mutex_key#15){++++}, at: inode_lock  
include/linux/fs.h:713 [inline]
  #0:         (ptrval) (&sb->s_type->i_mutex_key#15){++++}, at:  
lock_mount+0x8c/0x2e0 fs/namespace.c:2088
  #1:         (ptrval) (namespace_sem){++++}, at: namespace_lock  
fs/namespace.c:1431 [inline]
  #1:         (ptrval) (namespace_sem){++++}, at: lock_mount+0xdc/0x2e0  
fs/namespace.c:2093
2 locks held by syz-executor694/4901:
  #0:         (ptrval) (&sb->s_type->i_mutex_key#15){++++}, at: inode_lock  
include/linux/fs.h:713 [inline]
  #0:         (ptrval) (&sb->s_type->i_mutex_key#15){++++}, at:  
lock_mount+0x8c/0x2e0 fs/namespace.c:2088
  #1:         (ptrval) (namespace_sem){++++}, at: namespace_lock  
fs/namespace.c:1431 [inline]
  #1:         (ptrval) (namespace_sem){++++}, at: lock_mount+0xdc/0x2e0  
fs/namespace.c:2093
2 locks held by syz-executor694/4905:
  #0:         (ptrval) (&sb->s_type->i_mutex_key#15){++++}, at: inode_lock  
include/linux/fs.h:713 [inline]
  #0:         (ptrval) (&sb->s_type->i_mutex_key#15){++++}, at:  
lock_mount+0x8c/0x2e0 fs/namespace.c:2088
  #1:         (ptrval) (namespace_sem){++++}, at: namespace_lock  
fs/namespace.c:1431 [inline]
  #1:         (ptrval) (namespace_sem){++++}, at: lock_mount+0xdc/0x2e0  
fs/namespace.c:2093
2 locks held by syz-executor694/4911:
  #0:         (ptrval) (&sb->s_type->i_mutex_key#15){++++}, at: inode_lock  
include/linux/fs.h:713 [inline]
  #0:         (ptrval) (&sb->s_type->i_mutex_key#15){++++}, at:  
lock_mount+0x8c/0x2e0 fs/namespace.c:2088
  #1:         (ptrval) (namespace_sem){++++}, at: namespace_lock  
fs/namespace.c:1431 [inline]
  #1:         (ptrval) (namespace_sem){++++}, at: lock_mount+0xdc/0x2e0  
fs/namespace.c:2093
2 locks held by syz-executor694/4913:
  #0:         (ptrval) (&sb->s_type->i_mutex_key#15){++++}, at: inode_lock  
include/linux/fs.h:713 [inline]
  #0:         (ptrval) (&sb->s_type->i_mutex_key#15){++++}, at:  
lock_mount+0x8c/0x2e0 fs/namespace.c:2088
  #1:         (ptrval) (namespace_sem){++++}, at: namespace_lock  
fs/namespace.c:1431 [inline]
  #1:         (ptrval) (namespace_sem){++++}, at: lock_mount+0xdc/0x2e0  
fs/namespace.c:2093
2 locks held by syz-executor694/4919:
  #0:         (ptrval) (&sb->s_type->i_mutex_key#15){++++}, at: inode_lock  
include/linux/fs.h:713 [inline]
  #0:         (ptrval) (&sb->s_type->i_mutex_key#15){++++}, at:  
lock_mount+0x8c/0x2e0 fs/namespace.c:2088
  #1:         (ptrval) (namespace_sem){++++}, at: namespace_lock  
fs/namespace.c:1431 [inline]
  #1:         (ptrval) (namespace_sem){++++}, at: lock_mount+0xdc/0x2e0  
fs/namespace.c:2093
2 locks held by syz-executor694/4921:
  #0:         (ptrval) (&sb->s_type->i_mutex_key#15){++++}, at: inode_lock  
include/linux/fs.h:713 [inline]
  #0:         (ptrval) (&sb->s_type->i_mutex_key#15){++++}, at:  
lock_mount+0x8c/0x2e0 fs/namespace.c:2088
  #1:         (ptrval) (namespace_sem){++++}, at: namespace_lock  
fs/namespace.c:1431 [inline]
  #1:         (ptrval) (namespace_sem){++++}, at: lock_mount+0xdc/0x2e0  
fs/namespace.c:2093
2 locks held by syz-executor694/4928:
  #0:         (ptrval) (&sb->s_type->i_mutex_key#15){++++}, at: inode_lock  
include/linux/fs.h:713 [inline]
  #0:         (ptrval) (&sb->s_type->i_mutex_key#15){++++}, at:  
lock_mount+0x8c/0x2e0 fs/namespace.c:2088
  #1:         (ptrval) (namespace_sem){++++}, at: namespace_lock  
fs/namespace.c:1431 [inline]
  #1:         (ptrval) (namespace_sem){++++}, at: lock_mount+0xdc/0x2e0  
fs/namespace.c:2093
2 locks held by syz-executor694/4935:
  #0:         (ptrval) (&sb->s_type->i_mutex_key#15){++++}, at: inode_lock  
include/linux/fs.h:713 [inline]
  #0:         (ptrval) (&sb->s_type->i_mutex_key#15){++++}, at:  
lock_mount+0x8c/0x2e0 fs/namespace.c:2088
  #1:         (ptrval) (namespace_sem){++++}, at: namespace_lock  
fs/namespace.c:1431 [inline]
  #1:         (ptrval) (namespace_sem){++++}, at: lock_mount+0xdc/0x2e0  
fs/namespace.c:2093
2 locks held by syz-executor694/4937:
  #0:         (ptrval) (&sb->s_type->i_mutex_key#15){++++}, at: inode_lock  
include/linux/fs.h:713 [inline]
  #0:         (ptrval) (&sb->s_type->i_mutex_key#15){++++}, at:  
lock_mount+0x8c/0x2e0 fs/namespace.c:2088
  #1:         (ptrval) (namespace_sem){++++}, at: namespace_lock  
fs/namespace.c:1431 [inline]
  #1:         (ptrval) (namespace_sem){++++}, at: lock_mount+0xdc/0x2e0  
fs/namespace.c:2093
2 locks held by syz-executor694/4939:
  #0:         (ptrval) (&sb->s_type->i_mutex_key#15){++++}, at: inode_lock  
include/linux/fs.h:713 [inline]
  #0:         (ptrval) (&sb->s_type->i_mutex_key#15){++++}, at:  
lock_mount+0x8c/0x2e0 fs/namespace.c:2088
  #1:         (ptrval) (namespace_sem){++++}, at: namespace_lock  
fs/namespace.c:1431 [inline]
  #1:         (ptrval) (namespace_sem){++++}, at: lock_mount+0xdc/0x2e0  
fs/namespace.c:2093
2 locks held by syz-executor694/4941:
  #0:         (ptrval) (&sb->s_type->i_mutex_key#15){++++}, at: inode_lock  
include/linux/fs.h:713 [inline]
  #0:         (ptrval) (&sb->s_type->i_mutex_key#15){++++}, at:  
lock_mount+0x8c/0x2e0 fs/namespace.c:2088
  #1:         (ptrval) (namespace_sem){++++}, at: namespace_lock  
fs/namespace.c:1431 [inline]
  #1:         (ptrval) (namespace_sem){++++}, at: lock_mount+0xdc/0x2e0  
fs/namespace.c:2093
1 lock held by syz-executor694/4943:
  #0:         (ptrval) (&sb->s_type->i_mutex_key#15){++++}, at:  
inode_lock_shared include/linux/fs.h:723 [inline]
  #0:         (ptrval) (&sb->s_type->i_mutex_key#15){++++}, at:  
lookup_slow+0x49/0x80 fs/namei.c:1646
2 locks held by syz-executor694/4944:
  #0:         (ptrval) (sb_writers#12){.+.+}, at: sb_start_write  
include/linux/fs.h:1550 [inline]
  #0:         (ptrval) (sb_writers#12){.+.+}, at: mnt_want_write+0x3f/0xc0  
fs/namespace.c:386
  #1:         (ptrval) (&sb->s_type->i_mutex_key#15/1){+.+.}, at:  
inode_lock_nested include/linux/fs.h:748 [inline]
  #1:         (ptrval) (&sb->s_type->i_mutex_key#15/1){+.+.}, at:  
filename_create+0x1aa/0x5a0 fs/namei.c:3606
1 lock held by syz-executor694/4945:
  #0:         (ptrval) (&sb->s_type->i_mutex_key#15){++++}, at: inode_lock  
include/linux/fs.h:713 [inline]
  #0:         (ptrval) (&sb->s_type->i_mutex_key#15){++++}, at:  
lock_mount+0x8c/0x2e0 fs/namespace.c:2088
1 lock held by syz-executor694/4947:
  #0:         (ptrval) (&sb->s_type->i_mutex_key#15){++++}, at: inode_lock  
include/linux/fs.h:713 [inline]
  #0:         (ptrval) (&sb->s_type->i_mutex_key#15){++++}, at:  
lock_mount+0x8c/0x2e0 fs/namespace.c:2088

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 892 Comm: khungtaskd Not tainted 4.17.0-rc6+ #63
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
  nmi_cpu_backtrace.cold.4+0x19/0xce lib/nmi_backtrace.c:103
  nmi_trigger_cpumask_backtrace+0x151/0x192 lib/nmi_backtrace.c:62
  arch_trigger_cpumask_backtrace+0x14/0x20 arch/x86/kernel/apic/hw_nmi.c:38
  trigger_all_cpu_backtrace include/linux/nmi.h:138 [inline]
  check_hung_task kernel/hung_task.c:132 [inline]
  check_hung_uninterruptible_tasks kernel/hung_task.c:190 [inline]
  watchdog+0xc10/0xf60 kernel/hung_task.c:249
  kthread+0x345/0x410 kernel/kthread.c:240
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 4901 Comm: syz-executor694 Not tainted 4.17.0-rc6+ #63
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:__lock_release kernel/locking/lockdep.c:3674 [inline]
RIP: 0010:lock_release+0x1f5/0xa10 kernel/locking/lockdep.c:3939
RSP: 0018:ffff8801afca7708 EFLAGS: 00000097
RAX: 0000000000000003 RBX: 1ffff10035f94ee6 RCX: ffffffff815e1551
RDX: 0000000000000004 RSI: 0000000000000001 RDI: 0000000000000001
RBP: ffff8801afca7838 R08: 0000000000000000 R09: ffffed00351966c8
R10: ffffed00351966c8 R11: ffff8801a8cb3643 R12: ffff8801afca7810
R13: ffff8801a8cb3658 R14: ffff8801a9a003c0 R15: ffff8801afca7750
FS:  00007f0d700f7700(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffff600400 CR3: 00000001d05cc000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  __raw_spin_unlock include/linux/spinlock_api_smp.h:150 [inline]
  _raw_spin_unlock+0x1a/0x30 kernel/locking/spinlock.c:176
  spin_unlock include/linux/spinlock.h:350 [inline]
  lockref_get+0x42/0x50 lib/lockref.c:51
  dget include/linux/dcache.h:326 [inline]
  mnt_set_mountpoint+0xe7/0x360 fs/namespace.c:914
  propagate_one+0x5a7/0x910 fs/pnode.c:269
  propagate_mnt+0x18a/0x3e0 fs/pnode.c:315
  attach_recursive_mnt+0x5f8/0xb50 fs/namespace.c:2033
  graft_tree+0x1aa/0x240 fs/namespace.c:2133
  do_add_mount+0x1fe/0x370 fs/namespace.c:2491
  do_new_mount fs/namespace.c:2532 [inline]
  do_mount+0x18e6/0x3070 fs/namespace.c:2848
  ksys_mount+0x12d/0x140 fs/namespace.c:3064
  __do_sys_mount fs/namespace.c:3078 [inline]
  __se_sys_mount fs/namespace.c:3075 [inline]
  __x64_sys_mount+0xbe/0x150 fs/namespace.c:3075
  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x447099
RSP: 002b:00007f0d700f6da8 EFLAGS: 00000293 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00000000006ddc84 RCX: 0000000000447099
RDX: 00000000200001c0 RSI: 0000000020026ff8 RDI: 000000002000a000
RBP: 00000000006ddc80 R08: 00000000200007c0 R09: 0000000000000000
R10: 0000000000000080 R11: 0000000000000293 R12: 0030656c69662f2e
R13: 6f7365725f736e64 R14: 70756f7267632f2e R15: 0000000000000007
Code: c1 ea 03 0f b6 14 02 48 89 f8 83 e0 07 83 c0 03 65 4c 8b 34 25 40 ee  
01 00 38 d0 7c 08 84 d2 0f 85 67 06 00 00 8b 3d fb bd ac 07 <85> ff 0f 84  
41 02 00 00 49 8d 86 30 08 00 00 48 89 c2 48 89 85
