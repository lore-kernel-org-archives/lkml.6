Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FAAAC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 21:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 251B72147A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 21:56:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729901AbfBSV4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 16:56:05 -0500
Received: from mail-it1-f197.google.com ([209.85.166.197]:40840 "EHLO
        mail-it1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729862AbfBSV4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 16:56:05 -0500
Received: by mail-it1-f197.google.com with SMTP id 135so6875018itk.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 13:56:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=NBGiVUWz7pUntRpiTxMISl4WVb7tBnvd03H0M/nespE=;
        b=SQIVK/5ktf1/JOdnnJO18sHGTS94vmFeJjESkLrupDhomcJMP/PZKqBFkDQKU009lB
         BnFJW3GSZDInzpoAquKPkYcw8mpGI9nwjlj+ZpkPq6V0mqMUDfK5xwPmuzxlK/jxjCxu
         N5cKuQKAaxXfBFWr9vSp8HXHswkDQw22lnwxTCWkNr/LYBsf8WcIL2JB4tetoG38OsDE
         Yt4ebJr6vayfUk9IVHSzGEoajqgpKTaj/v5RGA8I78GjOG9W8BkQqQQ5tNurEUSvEne1
         sz9cuNrsEQLm+VOynXqIyNUKJOr97lY3T252cOcYI8x4+Qtsm92wMFH7kx/wKSbA+LVr
         RjVQ==
X-Gm-Message-State: AHQUAubV3xxkhCNXFrKPeyYjm7fr2DrMMIGX1fVkgiw+uv1tloozEn4U
        CV73ipUXKeVm7RvVsJ0C6mI7RCgbsItYLGYGv4WdYsYO+Ze3
X-Google-Smtp-Source: AHgI3IYSnCkHuzJBj3n20LlNgoxcHmgZSRAbrtJRpAJrpQdbzfzKao+MGDiyMZ1VtwsDnVuYkFP56c23l7eJuIwFp1KEWFVaKe65
MIME-Version: 1.0
X-Received: by 2002:a5d:94c6:: with SMTP id y6mr22863895ior.21.1550613363821;
 Tue, 19 Feb 2019 13:56:03 -0800 (PST)
Date:   Tue, 19 Feb 2019 13:56:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bc227a0582464e62@google.com>
Subject: WARNING: locking bug in icmp_send
From:   syzbot <syzbot+ba21d65f55b562432c58@syzkaller.appspotmail.com>
To:     davem@davemloft.net, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    b5372fe5dc84 exec: load_script: Do not exec truncated inte..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=122bf7b0c00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7132344728e7ec3f
dashboard link: https://syzkaller.appspot.com/bug?extid=ba21d65f55b562432c58
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14c90fa7400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+ba21d65f55b562432c58@syzkaller.appspotmail.com

yz1> rejected, already enabled
Enabling of bearer <udp:
yz1> rejected, already enabled
------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(class_idx > MAX_LOCKDEP_KEYS)
WARNING: CPU: 0 PID: 9 at kernel/locking/lockdep.c:3315  
__lock_acquire+0x13bf/0x4700 kernel/locking/lockdep.c:3315
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 9 Comm: ksoftirqd/0 Not tainted 5.0.0-rc7+ #78
Enabling of bearer <udp:
yz1> rejected, already enabled
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
Enabling of bearer <udp:
yz1> rejected, already enabled
  panic+0x2cb/0x65c kernel/panic.c:214
Enabling of bearer <udp:
yz1> rejected, already enabled
  __warn.cold+0x20/0x45 kernel/panic.c:571
Enabling of bearer <udp:
yz1> rejected, already enabled
  report_bug+0x263/0x2b0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:178 [inline]
  fixup_bug arch/x86/kernel/traps.c:173 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:271
  do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:290
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:973
Enabling of bearer <udp:
yz1> rejected, already enabled
RIP: 0010:__lock_acquire+0x13bf/0x4700 kernel/locking/lockdep.c:3315
Code: 8b 1d c9 a6 05 08 45 85 db 0f 85 d6 f4 ff ff 48 c7 c6 e0 a3 6b 87 48  
c7 c7 40 78 6b 87 44 89 9c 24 98 00 00 00 e8 ef 29 ec ff <0f> 0b 44 8b 9c  
24 98 00 00 00 e9 af f4 ff ff 8b 3d 7c 67 fe 08 85
RSP: 0018:ffff8880a985f320 EFLAGS: 00010086
Enabling of bearer <udp:
yz1> rejected, already enabled
RAX: 0000000000000000 RBX: 000000001ac4c57a RCX: 0000000000000000
RDX: 0000000000000100 RSI: ffffffff815a92c6 RDI: ffffed101530be56
RBP: ffff8880a985f4f0 R08: ffff8880a9846240 R09: fffffbfff1133361
R10: fffffbfff1133360 R11: ffffffff88999b03 R12: ffff8880a9846b28
R13: ffff8880a9846b32 R14: 000000001ac4c57a R15: ffff8880a9846240
Enabling of bearer <udp:
yz1> rejected, already enabled
Enabling of bearer <udp:
yz1> rejected, already enabled
  lock_acquire+0x16f/0x3f0 kernel/locking/lockdep.c:3841
  __raw_spin_trylock include/linux/spinlock_api_smp.h:90 [inline]
  _raw_spin_trylock+0x62/0x80 kernel/locking/spinlock.c:128
Enabling of bearer <udp:
yz1> rejected, already enabled
  spin_trylock include/linux/spinlock.h:339 [inline]
  icmp_xmit_lock net/ipv4/icmp.c:219 [inline]
  icmp_send+0x54c/0x1400 net/ipv4/icmp.c:665
Enabling of bearer <udp:
yz1> rejected, already enabled
Enabling of bearer <udp:
yz1> rejected, already enabled
Enabling of bearer <udp:
yz1> rejected, already enabled
  __udp4_lib_rcv+0x1fb2/0x2c50 net/ipv4/udp.c:2321
  udp_rcv+0x22/0x30 net/ipv4/udp.c:2480
Enabling of bearer <udp:
yz1> rejected, already enabled
  ip_protocol_deliver_rcu+0x60/0x8e0 net/ipv4/ip_input.c:208
Enabling of bearer <udp:
yz1> rejected, already enabled
  ip_local_deliver_finish+0x23b/0x390 net/ipv4/ip_input.c:234
  NF_HOOK include/linux/netfilter.h:289 [inline]
  NF_HOOK include/linux/netfilter.h:283 [inline]
  ip_local_deliver+0x1e9/0x520 net/ipv4/ip_input.c:255
  dst_input include/net/dst.h:450 [inline]
  ip_rcv_finish+0x1db/0x2f0 net/ipv4/ip_input.c:414
  NF_HOOK include/linux/netfilter.h:289 [inline]
  NF_HOOK include/linux/netfilter.h:283 [inline]
  ip_rcv+0xe8/0x3f0 net/ipv4/ip_input.c:524
  __netif_receive_skb_one_core+0x115/0x1a0 net/core/dev.c:4973
  __netif_receive_skb+0x2c/0x1c0 net/core/dev.c:5083
  process_backlog+0x206/0x750 net/core/dev.c:5923
  napi_poll net/core/dev.c:6346 [inline]
  net_rx_action+0x4fa/0x1070 net/core/dev.c:6412
  __do_softirq+0x266/0x95a kernel/softirq.c:292
  run_ksoftirqd kernel/softirq.c:654 [inline]
  run_ksoftirqd+0x8e/0x110 kernel/softirq.c:646
  smpboot_thread_fn+0x6ab/0xa10 kernel/smpboot.c:164
  kthread+0x357/0x430 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
