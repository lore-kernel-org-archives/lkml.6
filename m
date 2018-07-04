Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18055C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 15:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC005208E5
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 15:11:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC005208E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753190AbeGDPLF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 11:11:05 -0400
Received: from mail-it0-f70.google.com ([209.85.214.70]:58522 "EHLO
        mail-it0-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752114AbeGDPLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 11:11:02 -0400
Received: by mail-it0-f70.google.com with SMTP id j80-v6so4742489itj.8
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 08:11:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=+VMHQwcitES1IcZE21f4P16zE00p20bLzaC3uzjPXBY=;
        b=rkCuWIL5oRrzqUC7YMkY0SFu6k10riinaBdSlZjG34UUMcB1Y1rqi6xygtGOoMGMZV
         eOw6l/GpTtYFLKj9FOwGHGKEwp+aDlwaaNqAP8j6MlnlaQNkvXMvCaXqowK5sDOG49CO
         V5hITGukxDNc8dPpidwyZES+F6fR3Z496K4vHxVl4k3Zr1eX+KngDlR7SictO3XQj4LB
         kYTzaES1c2cyfnrHOKfeDU8oKoY1hPk4BUdHi8FUx2Hux95/FMMF3BUt7mGsVxFhds8u
         149YeM5OiU8I1r3HpYMWnISQg1c/4r2A7rhx4oiyZxt5bU/1e/ODi//Xhj0dY94v/ObO
         UGjA==
X-Gm-Message-State: APt69E0t2/hMv6JsbYdqbt1SqgizTYzDO6EFmbs6bOLvcsuFwQO9fFIk
        Zsyaco4d+FCYGs+YjknBQ3W/d6PmrvuK84TaAdz1B8h48aju
X-Google-Smtp-Source: AAOMgpfM0q0EBK87hEfHtoRASOAWntUf+93zsLFXCBybQsVEIh10oZ97j/30x/c4PmB3e1qF0eO8tE6aulVnD5xHJWQZvf4kSbDE
MIME-Version: 1.0
X-Received: by 2002:a24:9195:: with SMTP id i143-v6mr1061691ite.52.1530717062402;
 Wed, 04 Jul 2018 08:11:02 -0700 (PDT)
Date:   Wed, 04 Jul 2018 08:11:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c19fad05702dd6a8@google.com>
Subject: KASAN: stack-out-of-bounds Read in update_cfs_group
From:   syzbot <syzbot+3d9a14b389b1d7e54d6d@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    2bdea157b999 Merge branch 'sctp-fully-support-for-dscp-and..
git tree:       bpf-next
console output: https://syzkaller.appspot.com/x/log.txt?x=153954c2400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f62553dc846b0692
dashboard link: https://syzkaller.appspot.com/bug?extid=3d9a14b389b1d7e54d6d
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+3d9a14b389b1d7e54d6d@syzkaller.appspotmail.com

==================================================================
PANIC: double fault, error_code: 0x0
BUG: KASAN: stack-out-of-bounds in __read_once_size  
include/linux/compiler.h:188 [inline]
BUG: KASAN: stack-out-of-bounds in calc_group_shares  
kernel/sched/fair.c:2931 [inline]
BUG: KASAN: stack-out-of-bounds in update_cfs_group+0x4b1/0x590  
kernel/sched/fair.c:3028
CPU: 1 PID: 15263 Comm: syz-executor7 Not tainted 4.18.0-rc3+ #45
Read of size 8 at addr ffff8801aca4b500 by task syz-executor5/15250
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:__lock_acquire+0x2e/0x5020 kernel/locking/lockdep.c:3294

Code: 41
CPU: 0 PID: 15250 Comm: syz-executor5 Not tainted 4.18.0-rc3+ #45
57 41
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
89 cf
Call Trace:
41 56
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
41 55
49 89
fd 41
54 45
89
  print_address_description+0x6c/0x20b mm/kasan/report.c:256
cc 53
65 4c
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
8b 34
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
25 40
  __read_once_size include/linux/compiler.h:188 [inline]
  calc_group_shares kernel/sched/fair.c:2931 [inline]
  update_cfs_group+0x4b1/0x590 kernel/sched/fair.c:3028
ee 01
00 48
83 e4
f0 48
  dequeue_entity+0x400/0x15e0 kernel/sched/fair.c:4322
81
ec 60
03 00
00 48
8b 45
10 <89>
94 24
80
  dequeue_task_fair+0xf2/0x9e0 kernel/sched/fair.c:5455
00 00
00 48
ba 00
00 00
00 00
fc ff
df 48
  dequeue_task kernel/sched/core.c:762 [inline]
  deactivate_task+0xf3/0x330 kernel/sched/core.c:778
89
  __schedule+0x9c9/0x1ed0 kernel/sched/core.c:3454
84 24
98
RSP: 0018:ffff8801ac5ffe80 EFLAGS: 00010082
RAX: 0000000000000000 RBX: 1ffff100358c004c RCX: 0000000000000002
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff88f92620
RBP: ffff8801ac600208 R08: 0000000000000000 R09: 0000000000000000
R10: ffff8801acc771b8 R11: ffff8801daf236b3 R12: 0000000000000000
R13: ffffffff88f92620 R14: ffff8801aee52140 R15: 0000000000000002
FS:  00007fe265cc0700(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff8801ac5ffe78 CR3: 00000001aaa5e000 CR4: 00000000001406e0
DR0: 00000000200001c0 DR1: 0000000020000000 DR2: 0000000000000000
  schedule+0xfb/0x450 kernel/sched/core.c:3548
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
Call Trace:


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
