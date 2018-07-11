Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SORTED_RECIPS,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55F99C1B0E3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 19:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D705C208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 19:49:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D705C208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389924AbeGKTy4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 15:54:56 -0400
Received: from mail-it0-f69.google.com ([209.85.214.69]:44909 "EHLO
        mail-it0-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732921AbeGKTyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 15:54:55 -0400
Received: by mail-it0-f69.google.com with SMTP id z8-v6so2588502itc.9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 12:49:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=KuzDjwyoMHX8x9PNyLTV/yFV0CBbx+xL2KlVPVDOFC4=;
        b=dFmJSm318zESyEhk1HNS1q2wxHu3eRTZBfUdK8yvpd/D91RQ/gSCft1hJkgsCN5Du3
         4691DmAN9KCP072jDsE8jtS+GoOmU0uiOuWd//tOIZB3zR+lFDlR19pQlikx7xR9w6ip
         j2eiI5I26EmZGCa3pl/oM9p+qNAiow6Yo3NpEVi/2uzpp1f5i1Bu7jqvJsd+OQvOiDbV
         HH4AwF3O7rqoK62q2PSGRamn9eJWd+b2DuefACEIpTESvtbYc4DffBSebavA7JK+iuuI
         tmXsoYdZwD1qEOGzVXS01Fr6mZVpuvWws3JU+waWWkqbt2gOcjzHWFq88BjtG5D+QVyi
         YP1w==
X-Gm-Message-State: APt69E0gg4SSrrbZ+Q04LwFNJdGvhr7EKwBCXCS60YtUYbTO+NE6HCui
        Asjn4useMbHXY4Fs9w/nF8bGbdMLNofrC52Vq6KSeABkikWq
X-Google-Smtp-Source: AAOMgpcATAw7C4Oh9S2XsuC2D9EW5FjFUqYm7fgwFazuEN2zwgNxvkcIKukt3KMEGJKGCRbwV6Kxo0BwMi3nNRonKx3tqlrlGCw5
MIME-Version: 1.0
X-Received: by 2002:a02:384a:: with SMTP id v10-v6mr13467940jae.59.1531338543744;
 Wed, 11 Jul 2018 12:49:03 -0700 (PDT)
Date:   Wed, 11 Jul 2018 12:49:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ee4dab0570be896c@google.com>
Subject: general protection fault in p9_conn_cancel
From:   syzbot <syzbot+4d29d76a0da7a8c4d86c@syzkaller.appspotmail.com>
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

HEAD commit:    30c2c32d7f70 Merge tag 'drm-fixes-2018-07-10' of git://ano..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15e7aa78400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=25856fac4e580aa7
dashboard link: https://syzkaller.appspot.com/bug?extid=4d29d76a0da7a8c4d86c
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=10e2c5b2400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=179415b2400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+4d29d76a0da7a8c4d86c@syzkaller.appspotmail.com

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] SMP KASAN
CPU: 1 PID: 2133 Comm: kworker/1:2 Not tainted 4.18.0-rc4+ #140
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events p9_poll_workfn
RIP: 0010:__lock_acquire+0x245/0x5020 kernel/locking/lockdep.c:3314
Code: 28 00 00 00 0f 85 03 34 00 00 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f  
5d c3 48 b8 00 00 00 00 00 fc ff df 4c 89 ea 48 c1 ea 03 <80> 3c 02 00 0f  
85 c6 35 00 00 49 81 7d 00 60 86 e7 89 0f 84 42 ff
RSP: 0018:ffff8801cd546e60 EFLAGS: 00010006
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000003 RSI: 0000000000000000 RDI: ffffffff88f1b060
RBP: ffff8801cd5471e8 R08: 0000000000000001 R09: 0000000000000001
R10: ffffed003ac9b825 R11: 0000000000000001 R12: 0000000000000001
R13: 0000000000000018 R14: ffff8801cd4f4680 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000203b9fdc CR3: 00000001ab7f9000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  lock_acquire+0x1e4/0x540 kernel/locking/lockdep.c:3924
  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
  _raw_spin_lock_irqsave+0x96/0xc0 kernel/locking/spinlock.c:152
  p9_conn_cancel+0x166/0xd30 net/9p/trans_fd.c:205
  p9_poll_mux net/9p/trans_fd.c:620 [inline]
  p9_poll_workfn+0x4b2/0x6d0 net/9p/trans_fd.c:1107
  process_one_work+0xc73/0x1ba0 kernel/workqueue.c:2153
  worker_thread+0x189/0x13c0 kernel/workqueue.c:2296
  kthread+0x345/0x410 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412
Modules linked in:
Dumping ftrace buffer:
    (ftrace buffer empty)
---[ end trace 7b21d69ebadc8360 ]---
RIP: 0010:__lock_acquire+0x245/0x5020 kernel/locking/lockdep.c:3314
Code: 28 00 00 00 0f 85 03 34 00 00 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f  
5d c3 48 b8 00 00 00 00 00 fc ff df 4c 89 ea 48 c1 ea 03 <80> 3c 02 00 0f  
85 c6 35 00 00 49 81 7d 00 60 86 e7 89 0f 84 42 ff
RSP: 0018:ffff8801cd546e60 EFLAGS: 00010006
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000003 RSI: 0000000000000000 RDI: ffffffff88f1b060
RBP: ffff8801cd5471e8 R08: 0000000000000001 R09: 0000000000000001
R10: ffffed003ac9b825 R11: 0000000000000001 R12: 0000000000000001
R13: 0000000000000018 R14: ffff8801cd4f4680 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000203b9fdc CR3: 00000001ab7f9000 CR4: 00000000001406e0
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
