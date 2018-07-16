Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SORTED_RECIPS,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A716BECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 14:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59B9F208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 14:59:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59B9F208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728752AbeGPP0x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 11:26:53 -0400
Received: from mail-it0-f69.google.com ([209.85.214.69]:37630 "EHLO
        mail-it0-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727374AbeGPP0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 11:26:52 -0400
Received: by mail-it0-f69.google.com with SMTP id r10-v6so14003021itc.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 07:59:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=hlle/18Tt2m3iMsWkDJl4aJLdOc2mUdoHraeBW0kaE8=;
        b=QhWB+OnXJ1fKjJrf3nz45aiztcys3KuCe93GLsuwmkN3m+MNQNVePCDLzN0phSjStI
         J98WU1LV5jS8BJNqL0qayz46e0VR4oIKqa7TfeZhKWrC5Fce3z7yAC4WdoCZacuwLWeT
         YjUWA0fJbmoRWN9a/BHXDy0j4LkOuc9jpSfJuz3kRz0wXjV+PVZ2/09velI9wCF7FKTp
         h0+6guhh2Qx3NhyrzGyiHGg9xgL5q6wyvCo3vljoTiBq87L0h86uR0F1ihnuSlXCKWYK
         OrFegq0bXZWtXZ3flWtSbRxO9rMjHtYxkb05a5mqA9Jn7xUBmSCucn9RWBYpdabBaz4g
         rIeA==
X-Gm-Message-State: AOUpUlHPwEDwCrQJ+w9yf1j4ntZUEyr64A004VYL35A8nVGCW1sAhQyR
        /TFerMiaXBi3VhC/JdE51NaXnhbf64e9yykr/MtkC7fFRcRc
X-Google-Smtp-Source: AAOMgpdt8Zqg1pZ4lqN4MTVYcbhNK+KUZWSPOUeIZZ3QUD4PmY9hAg5hSNaRJQANHqKqqY7ZesUS/B0qlDuITHd7ug96leLSSxhm
MIME-Version: 1.0
X-Received: by 2002:a6b:4608:: with SMTP id t8-v6mr7341015ioa.141.1531753143391;
 Mon, 16 Jul 2018 07:59:03 -0700 (PDT)
Date:   Mon, 16 Jul 2018 07:59:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fedc1105711f11fd@google.com>
Subject: general protection fault in do_raw_spin_unlock
From:   syzbot <syzbot+83a25334ef203851dc81@syzkaller.appspotmail.com>
To:     davem@davemloft.net, ericvh@gmail.com,
        linux-kernel@vger.kernel.org, lucho@ionkov.net,
        netdev@vger.kernel.org, rminnich@sandia.gov,
        syzkaller-bugs@googlegroups.com,
        v9fs-developer@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    1d4eb636f0ab Add linux-next specific files for 20180716
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1186bf0c400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ea5926dddb0db97a
dashboard link: https://syzkaller.appspot.com/bug?extid=83a25334ef203851dc81
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=179ed444400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+83a25334ef203851dc81@syzkaller.appspotmail.com

IPVS: ftp: loaded support on port[0] = 21
IPVS: ftp: loaded support on port[0] = 21
IPVS: ftp: loaded support on port[0] = 21
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] SMP KASAN
CPU: 1 PID: 24 Comm: kworker/1:1 Not tainted 4.18.0-rc5-next-20180716+ #8
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events p9_poll_workfn
RIP: 0010:debug_spin_unlock kernel/locking/spinlock_debug.c:97 [inline]
RIP: 0010:do_raw_spin_unlock+0x65/0x2f0 kernel/locking/spinlock_debug.c:134
Code: 0a bd 88 48 c7 85 78 ff ff ff b3 8a b5 41 48 c7 45 88 d0 3c 60 81 c7  
02 f1 f1 f1 f1 c7 42 04 04 f2 f2 f2 48 89 fa 48 c1 ea 03 <0f> b6 14 02 48  
89 f8 65 48 8b 0c 25 28 00 00 00 48 89 4d d0 31 c9
RSP: 0018:ffff8801d945f288 EFLAGS: 00010047
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff8770a045
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000004
RBP: ffff8801d945f310 R08: 1ffff1003b28be45 R09: ffffed0035e7bd88
R10: ffffed0035e7bd88 R11: ffff8801af3dec43 R12: 0000000000000000
R13: 1ffff1003b28be51 R14: ffff8801d945f2e8 R15: ffff8801c5811d50
FS:  0000000000000000(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000072c029 CR3: 00000001b19fd000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:159 [inline]
  _raw_spin_unlock_irqrestore+0x27/0xc0 kernel/locking/spinlock.c:184
  spin_unlock_irqrestore include/linux/spinlock.h:384 [inline]
  p9_conn_cancel+0x9b6/0xd30 net/9p/trans_fd.c:208
  p9_poll_mux net/9p/trans_fd.c:620 [inline]
  p9_poll_workfn+0x4b2/0x6d0 net/9p/trans_fd.c:1107
  process_one_work+0xc73/0x1ba0 kernel/workqueue.c:2153
  worker_thread+0x189/0x13c0 kernel/workqueue.c:2296
  kthread+0x345/0x410 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:415
Modules linked in:
Dumping ftrace buffer:
    (ftrace buffer empty)
---[ end trace 4d86351f63a12683 ]---
RIP: 0010:debug_spin_unlock kernel/locking/spinlock_debug.c:97 [inline]
RIP: 0010:do_raw_spin_unlock+0x65/0x2f0 kernel/locking/spinlock_debug.c:134
Code: 0a bd 88 48 c7 85 78 ff ff ff b3 8a b5 41 48 c7 45 88 d0 3c 60 81 c7  
02 f1 f1 f1 f1 c7 42 04 04 f2 f2 f2 48 89 fa 48 c1 ea 03 <0f> b6 14 02 48  
89 f8 65 48 8b 0c 25 28 00 00 00 48 89 4d d0 31 c9
RSP: 0018:ffff8801d945f288 EFLAGS: 00010047
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff8770a045
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000004
RBP: ffff8801d945f310 R08: 1ffff1003b28be45 R09: ffffed0035e7bd88
R10: ffffed0035e7bd88 R11: ffff8801af3dec43 R12: 0000000000000000
R13: 1ffff1003b28be51 R14: ffff8801d945f2e8 R15: ffff8801c5811d50
FS:  0000000000000000(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000072c029 CR3: 00000001b19fd000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
