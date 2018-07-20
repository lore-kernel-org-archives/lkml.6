Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SORTED_RECIPS,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1AE2ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 18:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61B7420673
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 18:44:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61B7420673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388334AbeGTTdd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 15:33:33 -0400
Received: from mail-it0-f69.google.com ([209.85.214.69]:42747 "EHLO
        mail-it0-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388096AbeGTTdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 15:33:33 -0400
Received: by mail-it0-f69.google.com with SMTP id p21-v6so9866119itc.7
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 11:44:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=qo01TFBraybmG07Ibf+P8MGbiZ0bp+62YQ3wRTzzNyM=;
        b=ijdXnwedr3mZCGjMbMJtICsbGjlUjWk09B/w/VMV6dxsVCRVEyAhqYN7XY8hMrXPtL
         sTzpiX1SwGLCrgy6gRSrH7qCocnBHg1ZkcZbgQJHRDPKV07gbaaAq0SSS67Ll29M0RTL
         ObLDjEJwz0Qb23Ae/zk67x6mpJkdWPF/3hGFvTzuDhOYDs+oas9jbDogH+R0cLLTUyAI
         Yq4UsoGm2hPDJUELC7xh4vx/G9KBGgfKHYOiTWPk0GFUJ5rONlS1hxnr5RQOPsgSjHLu
         mxPSDvHmhsYgI7oTjV//1fvqC4p177Fn7pmuYRrPo+XNsIVw2VcKPBRtTX21bhL04Oqz
         KqTQ==
X-Gm-Message-State: AOUpUlHNuVjRHxMiQCT/GpQpN0oWqi5BOEHeIJ7OGrrUdq1JJcYHv0Xn
        mSSBBPPymWPvvU2rtHzGs2xHINX8WZmLt5oDZ/HgT6VnfJxG
X-Google-Smtp-Source: AAOMgpc6Je5sPbpciTLNLBeUWD1h7tOy0DSJZYuJ6DKUNwIK3ZMXJlEejBq2WAEL1it3Fd3jsM5IJE6b/OMq+6eBm+/PoVxnnex8
MIME-Version: 1.0
X-Received: by 2002:a24:b602:: with SMTP id g2-v6mr1485303itf.16.1532112241980;
 Fri, 20 Jul 2018 11:44:01 -0700 (PDT)
Date:   Fri, 20 Jul 2018 11:44:01 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f07e8c057172adf8@google.com>
Subject: WARNING: ODEBUG bug in __queue_work (2)
From:   syzbot <syzbot+562fd7e5ae89576bbe7c@syzkaller.appspotmail.com>
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

HEAD commit:    28c20cc73b9c Merge tag 'drm-fixes-2018-07-20' of git://ano..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=160da9a4400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c0bdc4175608181c
dashboard link: https://syzkaller.appspot.com/bug?extid=562fd7e5ae89576bbe7c
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+562fd7e5ae89576bbe7c@syzkaller.appspotmail.com

------------[ cut here ]------------
ODEBUG: activate not available (active state 0) object type: work_struct  
hint: p9_read_work+0x0/0x1060 net/9p/trans_fd.c:208
WARNING: CPU: 1 PID: 5207 at lib/debugobjects.c:329  
debug_print_object+0x16a/0x210 lib/debugobjects.c:326
Kernel panic - not syncing: panic_on_warn set ...

CPU: 1 PID: 5207 Comm: kworker/1:3 Not tainted 4.18.0-rc5+ #156
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events p9_poll_workfn
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
  panic+0x238/0x4e7 kernel/panic.c:184
  __warn.cold.8+0x163/0x1ba kernel/panic.c:536
  report_bug+0x252/0x2d0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:178 [inline]
  do_error_trap+0x1fc/0x4d0 arch/x86/kernel/traps.c:296
  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:316
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:992
RIP: 0010:debug_print_object+0x16a/0x210 lib/debugobjects.c:326
Code: 1a 88 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 92 00 00 00 48 8b 14 dd  
e0 72 1a 88 4c 89 f6 48 c7 c7 80 68 1a 88 e8 96 a5 e6 fd <0f> 0b 83 05 09  
74 3e 06 01 48 83 c4 18 5b 41 5c 41 5d 41 5e 41 5f
RSP: 0018:ffff880194a9f1d0 EFLAGS: 00010082
RAX: 0000000000000000 RBX: 0000000000000005 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff81631861 RDI: 0000000000000001
RBP: ffff880194a9f210 R08: ffff8801bfbe4280 R09: ffffed003b5e3ec2
R10: ffffed003b5e3ec2 R11: ffff8801daf1f617 R12: 0000000000000001
R13: ffffffff88f63860 R14: ffffffff881a6f00 R15: ffffffff814eaa00
  debug_object_activate+0x359/0x690 lib/debugobjects.c:513
  debug_work_activate kernel/workqueue.c:491 [inline]
  __queue_work+0x1ca/0x1410 kernel/workqueue.c:1380
  queue_work_on+0x19a/0x1e0 kernel/workqueue.c:1486
  queue_work include/linux/workqueue.h:512 [inline]
  schedule_work include/linux/workqueue.h:570 [inline]
  p9_poll_mux net/9p/trans_fd.c:628 [inline]
  p9_poll_workfn+0x55e/0x6d0 net/9p/trans_fd.c:1107
  process_one_work+0xc73/0x1ba0 kernel/workqueue.c:2153
  worker_thread+0x189/0x13c0 kernel/workqueue.c:2296
  kthread+0x345/0x410 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412
Dumping ftrace buffer:
    (ftrace buffer empty)
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
