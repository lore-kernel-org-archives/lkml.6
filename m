Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B54C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 02:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B67D62146F
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 02:41:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729574AbeL2ClF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 21:41:05 -0500
Received: from mail-it1-f198.google.com ([209.85.166.198]:42806 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727815AbeL2ClF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 21:41:05 -0500
Received: by mail-it1-f198.google.com with SMTP id g7so26950071itg.7
        for <linux-kernel@vger.kernel.org>; Fri, 28 Dec 2018 18:41:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=chNgkU0KYJWp2YYP6k0gsmHksF+j3MFAq5+SUEOIJzk=;
        b=aS+beHIQepmIzSlXVMOj34d6JkGpA0jR3ySkuHNRKxK6vQQ2Pwk4AR3+KQtw1DHAfZ
         I0qHWfHE3d/aHuyomAZMXEkCJ7TTofGbXmL87DlRLnZh+rVA0LZHwAwBzW51Kf95z3a3
         91ytxw4D5bcZbDJZ8ZRuGWhDqBTxuBluQ6PIaCvp/+2lsmCVrlj6yZhIA71BNS/MkqfZ
         HKkj8UdACiYbNncCKx6zyBbJ55TC7tCncShSgf82MSzWNpNYE4JHalCUzSsqYsd8UFjm
         rsWjsYkpYXx0jhowUU3aNlOyiiERQU9yKPE0b/yXyPl9QULurqPDYnS8GHEYYIaAOgeY
         AiUw==
X-Gm-Message-State: AA+aEWZ3h+/uM6XLpx2RKomyqcLT0GjAxRO9LjZaIuilCGzZMyYIt+xD
        wLVYqSUfTM6oDXuToCqxL2XJykPPHSm1h/R+Gst/DckkOD9e
X-Google-Smtp-Source: AFSGD/WQhwBfEp1PClbrKYxgN1JtIz7ed4eUfaZWBhEs3sEONrsTDT20zKefzbJ83g4u+tttUQqNx+KTFaOG35u5USkj30dWwNer
MIME-Version: 1.0
X-Received: by 2002:a24:6fd1:: with SMTP id x200mr22677464itb.26.1546051264140;
 Fri, 28 Dec 2018 18:41:04 -0800 (PST)
Date:   Fri, 28 Dec 2018 18:41:04 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000675cea057e201cbb@google.com>
Subject: BUG: unable to handle kernel paging request in slhc_free
From:   syzbot <syzbot+6c5d567447bfa30f78e2@syzkaller.appspotmail.com>
To:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tejaswit@codeaurora.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    8fe28cb58bcb Linux 4.20
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16771b15400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7d581260bae0899a
dashboard link: https://syzkaller.appspot.com/bug?extid=6c5d567447bfa30f78e2
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=136130fd400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1607c563400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+6c5d567447bfa30f78e2@syzkaller.appspotmail.com

RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000440359
RDX: 0000000020000080 RSI: 0000000000005423 RDI: 0000000000000003
RBP: 00000000006cb018 R08: 0000000000000001 R09: 0000000000000039
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000004
R13: ffffffffffffffff R14: 0000000000000000 R15: 0000000000000000
BUG: unable to handle kernel paging request at fffffffffffffff4
PGD 946d067 P4D 946d067 PUD 946f067 PMD 0
Oops: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 8225 Comm: syz-executor096 Not tainted 4.20.0 #167
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:slhc_free+0x30/0xb0 drivers/net/slip/slhc.c:159
Code: 53 48 89 fb e8 71 04 ad fc 48 85 db 74 74 e8 67 04 ad fc 48 89 da 48  
b8 00 00 00 00 00 fc ff df 48 c1 ea 03 80 3c 02 00 75 69 <4c> 8b 23 4d 85  
e4 74 0d e8 43 04 ad fc 4c 89 e7 e8 bb e1 ef fc e8
RSP: 0018:ffff8881c1a0f770 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: fffffffffffffff4 RCX: 1ffff1103408b936
RDX: 1ffffffffffffffe RSI: ffffffff84d15439 RDI: fffffffffffffff4
RBP: ffff8881c1a0f780 R08: ffff8881a045c9b0 R09: 0000000000000006
R10: 0000000000000000 R11: ffff8881a045c0c0 R12: 00000000ffffff97
R13: ffff8881c0ca04c0 R14: ffff8881c0daed00 R15: ffff8881c2152ac0
FS:  000000000078a880(0000) GS:ffff8881daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffffffffffff4 CR3: 00000001b0909000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  sl_alloc_bufs drivers/net/slip/slip.c:196 [inline]
  slip_open+0xdee/0x1107 drivers/net/slip/slip.c:821
  tty_ldisc_open.isra.1+0x8b/0xe0 drivers/tty/tty_ldisc.c:453
  tty_set_ldisc+0x2dc/0x6a0 drivers/tty/tty_ldisc.c:578
  tiocsetd drivers/tty/tty_io.c:2321 [inline]
  tty_ioctl+0x39d/0x17d0 drivers/tty/tty_io.c:2581
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:509 [inline]
  do_vfs_ioctl+0x1de/0x1790 fs/ioctl.c:696
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:713
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl fs/ioctl.c:718 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x440359
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 5b 14 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fff63454bb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000440359
RDX: 0000000020000080 RSI: 0000000000005423 RDI: 0000000000000003
RBP: 00000000006cb018 R08: 0000000000000001 R09: 0000000000000039
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000004
R13: ffffffffffffffff R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
CR2: fffffffffffffff4
---[ end trace 45b654871fafdc18 ]---
RIP: 0010:slhc_free+0x30/0xb0 drivers/net/slip/slhc.c:159
Code: 53 48 89 fb e8 71 04 ad fc 48 85 db 74 74 e8 67 04 ad fc 48 89 da 48  
b8 00 00 00 00 00 fc ff df 48 c1 ea 03 80 3c 02 00 75 69 <4c> 8b 23 4d 85  
e4 74 0d e8 43 04 ad fc 4c 89 e7 e8 bb e1 ef fc e8
RSP: 0018:ffff8881c1a0f770 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: fffffffffffffff4 RCX: 1ffff1103408b936
RDX: 1ffffffffffffffe RSI: ffffffff84d15439 RDI: fffffffffffffff4
RBP: ffff8881c1a0f780 R08: ffff8881a045c9b0 R09: 0000000000000006
R10: 0000000000000000 R11: ffff8881a045c0c0 R12: 00000000ffffff97
R13: ffff8881c0ca04c0 R14: ffff8881c0daed00 R15: ffff8881c2152ac0
FS:  000000000078a880(0000) GS:ffff8881daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffffffffffff4 CR3: 00000001b0909000 CR4: 00000000001406e0
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
