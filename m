Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF963C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 05:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6CB127822
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 05:38:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6CB127822
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933034AbeF2FiD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 01:38:03 -0400
Received: from mail-io0-f198.google.com ([209.85.223.198]:52326 "EHLO
        mail-io0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932880AbeF2FiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 01:38:02 -0400
Received: by mail-io0-f198.google.com with SMTP id n21-v6so6071995iob.19
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 22:38:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=aOqCkSx6DMZL4agtNvhWK2MVCE8SATLhg40eFIAavQo=;
        b=tkt7/j8rZqYBdwPr9CAzwYlQIbXABxzI5SpTp4m28Eqw/1iQOSDtzb//e+KuetL3+t
         t+Mr0tiUs1x69L+mc0/dt6NSPUkCwpxW+foCCQZeQcO7nd9hjQ54WC9kcXe2qgWoZmXU
         89xVSDJyiplTpBoGXifPsRq+QbwXjwVLw089g8kiiuiSGo/FJ8CTHoZ4aj9drh7IdOJi
         MSJ88A1shAe5DN+OPebozuMfjVrMjhkTavJRodLHqd43sFgfO8RjPbK6d4oQGc2tB7GX
         +U0gAfRh8PwJWYPTHYoWoYtt8swErWPpr3Gfl8admKhLbRwHpz+ccanJvMyh+Xlh9nqg
         J9HA==
X-Gm-Message-State: APt69E26w/LsI/F5Sfb0oxblF5GHvyhWOxCGeX2Lwan+tFvODnTDt9U0
        A38HPKwDXHZTIy8t+/Z1flqNPoBZnUYNpYIr6jv5CJ4QODnf
X-Google-Smtp-Source: AAOMgpeuExKQTN/frDc/vNnFfvQQPDE9y3RRAIzpaSZmfGJ/wFtQ4ZmiQFS93brNMfNwmukmxoG8gy/Cv+/X2iSSys6syUYwutkT
MIME-Version: 1.0
X-Received: by 2002:a02:a48a:: with SMTP id d10-v6mr5209520jam.26.1530250681537;
 Thu, 28 Jun 2018 22:38:01 -0700 (PDT)
Date:   Thu, 28 Jun 2018 22:38:01 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004a5d64056fc140c0@google.com>
Subject: BUG: unable to handle kernel NULL pointer dereference in ep_item_poll
From:   syzbot <syzbot+57727883dbad76db2ef0@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    90368a37fbbe Merge tag 'printk-for-4.18-rc3' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14e0dd14400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a63be0c83e84d370
dashboard link: https://syzkaller.appspot.com/bug?extid=57727883dbad76db2ef0
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+57727883dbad76db2ef0@syzkaller.appspotmail.com

device lo entered promiscuous mode
device lo left promiscuous mode
BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
PGD 1ccf13067 P4D 1ccf13067 PUD 1bc558067 PMD 0
Oops: 0010 [#1] SMP KASAN
CPU: 1 PID: 13288 Comm: syz-executor0 Not tainted 4.18.0-rc2+ #121
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:          (null)
Code: Bad RIP value.
RSP: 0018:ffff8801ce74f568 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff8801b2a681c0 RCX: ffffc90001e14000
RDX: ffff8801ce74f7c0 RSI: ffff8801b2a681c0 RDI: ffff8801b819ed00
RBP: ffff8801ce74f610 R08: ffff8801cfc64480 R09: ffffed003b5e46d6
R10: ffffed003b5e46d6 R11: ffff8801daf236b3 R12: ffff8801ce74f7c0
R13: ffff8801b819ed00 R14: ffffffff8818a920 R15: ffff8801cfd33740
FS:  00007f1c1e46f700(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 00000001ca482000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  vfs_poll include/linux/poll.h:86 [inline]
  ep_item_poll.isra.14+0x15c/0x400 fs/eventpoll.c:887
  ep_insert+0x6c1/0x1c20 fs/eventpoll.c:1459
  __do_sys_epoll_ctl fs/eventpoll.c:2113 [inline]
  __se_sys_epoll_ctl fs/eventpoll.c:1999 [inline]
  __x64_sys_epoll_ctl+0xf00/0x10a0 fs/eventpoll.c:1999
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x455a99
Code: 1d ba fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 eb b9 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f1c1e46ec68 EFLAGS: 00000246 ORIG_RAX: 00000000000000e9
RAX: ffffffffffffffda RBX: 00007f1c1e46f6d4 RCX: 0000000000455a99
RDX: 0000000000000013 RSI: 0000000000000001 RDI: 0000000000000014
RBP: 000000000072bea0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000020000180 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000004bb9c5 R14: 00000000004c8910 R15: 0000000000000000
Modules linked in:
Dumping ftrace buffer:
    (ftrace buffer empty)
CR2: 0000000000000000
---[ end trace 727efc30ae8b7e22 ]---
RIP: 0010:          (null)
Code: Bad RIP value.
RSP: 0018:ffff8801ce74f568 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff8801b2a681c0 RCX: ffffc90001e14000
RDX: ffff8801ce74f7c0 RSI: ffff8801b2a681c0 RDI: ffff8801b819ed00
RBP: ffff8801ce74f610 R08: ffff8801cfc64480 R09: ffffed003b5e46d6
R10: ffffed003b5e46d6 R11: ffff8801daf236b3 R12: ffff8801ce74f7c0
R13: ffff8801b819ed00 R14: ffffffff8818a920 R15: ffff8801cfd33740
FS:  00007f1c1e46f700(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 00000001ca482000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
