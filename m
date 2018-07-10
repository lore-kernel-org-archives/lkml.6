Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SORTED_RECIPS,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58463C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 19:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 183E420871
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 19:25:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 183E420871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732671AbeGJTZa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 15:25:30 -0400
Received: from mail-it0-f72.google.com ([209.85.214.72]:43352 "EHLO
        mail-it0-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732280AbeGJTZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 15:25:30 -0400
Received: by mail-it0-f72.google.com with SMTP id n68-v6so103016ite.8
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 12:25:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=EMWl83IKmOV8rbJSokRPwf7C3A/8fIGfIURmGeeSITs=;
        b=ftchGIcH97awTcNBssx/mNkzbEFltcfxDIWSpWxkOVdNvDcdVY3p0u5QhHwr4Gr80x
         JkAHiuuxHJ76BeAxp8jwIcbEFN7mJNu3/LnQWHnGgsRUwpORkf6x0m47QmXf1jYq74Ey
         yNLsVQZD2B9ZkFgvubJ2iHd9GzqyeCgq2XI7qD4eFMAO13zVv7y/S+iiJKc46neLK8pm
         KP/JC3VJ2RrO21K3EVMIItVy3uHRPuclTpdgRzbUXiYZtv5mOGor6eYs7TZQv4DaieR4
         /4TjRVvImWVOSOoZSZvuo8ZKq796Iwjs0A+vftM/camkayTVtwolsZ+V+RsdhSWVaBXp
         8GIg==
X-Gm-Message-State: APt69E20+S4qthujXI34X/CPJ9+xSmhh74CTxw/fuYpN4wyziCezH0X2
        B9t57mCXfy1JuhpUlD26StQqJEsGQCjBRJgtjttXl5/fA47w
X-Google-Smtp-Source: AAOMgpdIQ1aE9H2avyMy7+pg/6BRYxsNVaKxxaR1xTGpsEkyXoPsgNPW7kUe58db9tT0frQOKuxhDmZfMgxlcjzkLg4xXjbkhOYu
MIME-Version: 1.0
X-Received: by 2002:a24:7c0d:: with SMTP id a13-v6mr9529492itd.15.1531250702458;
 Tue, 10 Jul 2018 12:25:02 -0700 (PDT)
Date:   Tue, 10 Jul 2018 12:25:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002ea8610570aa1623@google.com>
Subject: general protection fault in perf_tp_event_match
From:   syzbot <syzbot+79f185656ab5873a0680@syzkaller.appspotmail.com>
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

HEAD commit:    d90c936fb318 Merge branch 'bpf-nfp-mul-div-support'
git tree:       bpf-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13213968400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a501a01deaf0fe9
dashboard link: https://syzkaller.appspot.com/bug?extid=79f185656ab5873a0680
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+79f185656ab5873a0680@syzkaller.appspotmail.com

device bridge_slave_1 left promiscuous mode
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] SMP KASAN
CPU: 0 PID: 82 Comm: kworker/u4:3 Not tainted 4.18.0-rc3+ #48
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: netns cleanup_net
RIP: 0010:perf_tp_filter_match kernel/events/core.c:8228 [inline]
RIP: 0010:perf_tp_event_match.isra.85.part.86+0x63/0x160  
kernel/events/core.c:8245
Code: 9c 24 c8 02 00 00 48 85 db 49 0f 44 dc e8 95 d7 e9 ff 48 b8 00 00 00  
00 00 fc ff df 48 8d bb d8 04 00 00 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f  
85 c5 00 00 00 4c 8b a3 d8 04 00 00 bb 01 00 00 00
RSP: 0018:ffff8801d97be4d8 EFLAGS: 00010802
RAX: dffffc0000000000 RBX: dead4ead00000000 RCX: ffffffff81960180
RDX: 1bd5a9d5a000009b RSI: ffffffff8192343b RDI: dead4ead000004d8
RBP: ffff8801d97be4f0 R08: ffff8801d97b05c0 R09: ffffe8ffffc87298
R10: ffff8801d97be930 R11: ffffe8ffff81402b R12: ffff88019e3bc120
R13: ffff8801d97be5c0 R14: ffff8801d97be5c0 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f9838a7ddb8 CR3: 00000001d4835000 CR4: 00000000001406f0
DR0: 0000000020000000 DR1: 0000000020000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
Call Trace:
  perf_tp_event_match kernel/events/core.c:8242 [inline]
  perf_tp_event+0x4a9/0xc40 kernel/events/core.c:8288
  perf_trace_run_bpf_submit+0x269/0x3b0 kernel/events/core.c:8263
  perf_trace_lock_acquire+0x4f9/0x9a0 include/trace/events/lock.h:13
  trace_lock_acquire include/trace/events/lock.h:13 [inline]
  lock_acquire+0x3a2/0x540 kernel/locking/lockdep.c:3923
  __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
  _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:144
  console_lock_spinning_disable_and_check kernel/printk/printk.c:1603  
[inline]
  console_unlock+0x960/0x10b0 kernel/printk/printk.c:2392
  vprintk_emit+0x6c6/0xdf0 kernel/printk/printk.c:1907
  vprintk_default+0x28/0x30 kernel/printk/printk.c:1948
  vprintk_func+0x7a/0xe7 kernel/printk/printk_safe.c:382
  printk+0xa7/0xcf kernel/printk/printk.c:1981
  __dev_set_promiscuity.cold.171+0x49/0x3d0 net/core/dev.c:7090
  dev_set_promiscuity+0x55/0xe0 net/core/dev.c:7129
  nbp_delete_promisc net/bridge/br_if.c:195 [inline]
  del_nbp+0x17f/0xb10 net/bridge/br_if.c:273
  br_dev_delete+0x94/0x190 net/bridge/br_if.c:315
  default_device_exit_batch+0x374/0x560 net/core/dev.c:9345
  ops_exit_list.isra.7+0x105/0x160 net/core/net_namespace.c:155
  cleanup_net+0x537/0xb50 net/core/net_namespace.c:523
  process_one_work+0xc73/0x1ba0 kernel/workqueue.c:2153
  worker_thread+0x189/0x13c0 kernel/workqueue.c:2296
  kthread+0x345/0x410 kernel/kthread.c:240
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412
Modules linked in:
Dumping ftrace buffer:
    (ftrace buffer empty)
---[ end trace a4623dccf99ca950 ]---
RIP: 0010:perf_tp_filter_match kernel/events/core.c:8228 [inline]
RIP: 0010:perf_tp_event_match.isra.85.part.86+0x63/0x160  
kernel/events/core.c:8245
Code: 9c 24 c8 02 00 00 48 85 db 49 0f 44 dc e8 95 d7 e9 ff 48 b8 00 00 00  
00 00 fc ff df 48 8d bb d8 04 00 00 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f  
85 c5 00 00 00 4c 8b a3 d8 04 00 00 bb 01 00 00 00
RSP: 0018:ffff8801d97be4d8 EFLAGS: 00010802
RAX: dffffc0000000000 RBX: dead4ead00000000 RCX: ffffffff81960180
RDX: 1bd5a9d5a000009b RSI: ffffffff8192343b RDI: dead4ead000004d8
RBP: ffff8801d97be4f0 R08: ffff8801d97b05c0 R09: ffffe8ffffc87298
R10: ffff8801d97be930 R11: ffffe8ffff81402b R12: ffff88019e3bc120
R13: ffff8801d97be5c0 R14: ffff8801d97be5c0 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f9838a7ddb8 CR3: 00000001d4835000 CR4: 00000000001406f0
DR0: 0000000020000000 DR1: 0000000020000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
