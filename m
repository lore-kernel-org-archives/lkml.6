Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5369C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 07:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BD9F2084D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 07:04:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731307AbeLQHEE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 02:04:04 -0500
Received: from mail-it1-f198.google.com ([209.85.166.198]:52545 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbeLQHED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 02:04:03 -0500
Received: by mail-it1-f198.google.com with SMTP id o205so13277231itc.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Dec 2018 23:04:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=G7JVJf7A8KWWjAZjY00nfRbU6Elpzoov8TclTETWaJs=;
        b=Iqv3JqzQCmnIyDPmLtyptXo4PnOvLswQ5MPl/UsCHLZIjh2KBt+SZ0lv/0+OORE/XO
         zhmBKs7n4YinONiJeXlh081NCIaa8NkLhyN3dWOuMLgS1WJj74wuJXCFI1HaoWG/U7SJ
         zGUT7AxdQnJtPLkMf//qxYlGk/ngb2pkNUSudeMQWHY9ASVJgA+WXI12Fhu3GIkxyy6W
         C4tTnYglhgh/c2CgLAQ3F4FR32+C1Ek/9Y3WmMNF6MeG69lbfdDbuydR/LJtIX8Ia8QU
         6DuJRYOV8Ze96uHJ09wrI53Ln2kCJAnChhaVVT0AZjvhY5O20yYfmLbCswY0oxtCFHKG
         AN0g==
X-Gm-Message-State: AA+aEWYutVLLkFnyMuWj+TITwDSV7kerpbl1Q++AnYQ2K6gEq/A6odt/
        XcGn9EbV1azdEmUoIhVBhHQLPGkQ1TPJpOl5fpfYVASrgYGF
X-Google-Smtp-Source: AFSGD/W5fvljfszWfjHQNEzC1WQhRUCpXyLqcCqqSf9qs/8ye54Ywm49EEX9nJhMtn+JGoM3MOW89EXSJAIHJwZ5Q2j+o9hg/sw7
MIME-Version: 1.0
X-Received: by 2002:a05:660c:4e:: with SMTP id p14mr10359131itk.31.1545030242689;
 Sun, 16 Dec 2018 23:04:02 -0800 (PST)
Date:   Sun, 16 Dec 2018 23:04:02 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c867e9057d326295@google.com>
Subject: divide error in alarm_forward
From:   syzbot <syzbot+9d38bedac9cc77b8ad5e@syzkaller.appspotmail.com>
To:     john.stultz@linaro.org, linux-kernel@vger.kernel.org,
        sboyd@kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    6531e115b7ab Merge branch 'akpm' (patches from Andrew)
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10c68f6d400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c8970c89a0efbb23
dashboard link: https://syzkaller.appspot.com/bug?extid=9d38bedac9cc77b8ad5e
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+9d38bedac9cc77b8ad5e@syzkaller.appspotmail.com

divide error: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 8629 Comm: syz-executor0 Not tainted 4.20.0-rc6+ #374
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:ktime_divns include/linux/ktime.h:172 [inline]
RIP: 0010:alarm_forward+0xe7/0x180 kernel/time/alarmtimer.c:458
Code: 41 5d 41 5e 41 5f 5d c3 e8 56 44 10 00 31 ff 4c 89 ee e8 7c 45 10 00  
4d 85 ed 78 62 e8 42 44 10 00 48 89 d8 48 8b 4d c8 48 99 <49> f7 fd 48 89  
c3 49 89 c6 48 ba 00 00 00 00 00 fc ff df 49 0f af
RSP: 0018:ffff8881b85b77e0 EFLAGS: 00010046
RAX: 0000000000008a1c RBX: 0000000000008a1c RCX: ffff8881b88e8aa0
RDX: 0000000000000000 RSI: ffffffff816f402e RDI: 0000000000000007
RBP: ffff8881b85b7820 R08: ffff8881b85a8040 R09: 0000000000000004
R10: fffffbfff14a7409 R11: 0000000000000001 R12: ffff8881b88e8a88
R13: 0000000000000000 R14: 0000000000000001 R15: 0000003d6987822d
FS:  00007f31b5e40700(0000) GS:ffff8881daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f31b5e1edb8 CR3: 00000001b9024000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  alarm_forward_now kernel/time/alarmtimer.c:481 [inline]
  alarm_timer_rearm+0xbb/0x150 kernel/time/alarmtimer.c:575
  posixtimer_rearm+0x200/0x3e0 kernel/time/posix-timers.c:321
  dequeue_signal+0x1b0/0x630 kernel/signal.c:680
  signalfd_dequeue fs/signalfd.c:173 [inline]
  signalfd_read+0x295/0x7f0 fs/signalfd.c:226
  __vfs_read+0x117/0x9b0 fs/read_write.c:416
  vfs_read+0x17f/0x3c0 fs/read_write.c:452
  ksys_read+0x101/0x260 fs/read_write.c:578
  __do_sys_read fs/read_write.c:588 [inline]
  __se_sys_read fs/read_write.c:586 [inline]
  __x64_sys_read+0x73/0xb0 fs/read_write.c:586
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457669
Code: fd b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f31b5e3fc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457669
RDX: 000000000ae3f1a6 RSI: 0000000020000080 RDI: 0000000000000005
RBP: 000000000072bfa0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f31b5e406d4
R13: 00000000004c2b0b R14: 00000000004d6608 R15: 00000000ffffffff
Modules linked in:
---[ end trace a0d2cc178e3c2817 ]---
RIP: 0010:ktime_divns include/linux/ktime.h:172 [inline]
RIP: 0010:alarm_forward+0xe7/0x180 kernel/time/alarmtimer.c:458
Code: 41 5d 41 5e 41 5f 5d c3 e8 56 44 10 00 31 ff 4c 89 ee e8 7c 45 10 00  
4d 85 ed 78 62 e8 42 44 10 00 48 89 d8 48 8b 4d c8 48 99 <49> f7 fd 48 89  
c3 49 89 c6 48 ba 00 00 00 00 00 fc ff df 49 0f af
RSP: 0018:ffff8881b85b77e0 EFLAGS: 00010046
RAX: 0000000000008a1c RBX: 0000000000008a1c RCX: ffff8881b88e8aa0
RDX: 0000000000000000 RSI: ffffffff816f402e RDI: 0000000000000007
RBP: ffff8881b85b7820 R08: ffff8881b85a8040 R09: 0000000000000004
R10: fffffbfff14a7409 R11: 0000000000000001 R12: ffff8881b88e8a88
R13: 0000000000000000 R14: 0000000000000001 R15: 0000003d6987822d
FS:  00007f31b5e40700(0000) GS:ffff8881daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f31b5e1edb8 CR3: 00000001b9024000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
