Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80056C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 05:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38B0D27A9E
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 05:17:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38B0D27A9E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932857AbeF2FRF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 01:17:05 -0400
Received: from mail-io0-f198.google.com ([209.85.223.198]:34744 "EHLO
        mail-io0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932694AbeF2FRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 01:17:03 -0400
Received: by mail-io0-f198.google.com with SMTP id w23-v6so6042248ioa.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 22:17:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=VfbDfrXWE6NjkOXavkYtBxU8hckRgo4GL6VX9REIsZo=;
        b=LBnCSkhW8rIHuIedKX6qpgIL4yIQoyFYTFoZpJ1NxXopZ/Eeb3EL1dxe7to7NQZgVZ
         Da6H3Cxcs7Qo+4K8uclLGXmGmgKZwU9/UpGO7gOpl5OTVoZHRs7BWne1LwO533EUNQQo
         TWkVKkmWDliR5DIBvLNzZQX3rZqdIoJnqmRmccqvCMsmOBiONBCkGJt4ChuZEBfnrg+G
         pSd0qIiHoTkP76AxqsEXAGqyCFfzXEUN+IjYeYRWH15yVqV8jXjNDwOIAaCOmveNPDqN
         2XmAZsdsqnFh80nGcJHMiEH4BTp5Q674BOYbm50NMvb0tBuyc8vz7hpvTGotr0lIawI7
         xI7w==
X-Gm-Message-State: APt69E1T7AzTaai/OO4NQgrCy7DMfmkIZiU3OjLllLag7foCYV+xsUMc
        5G4IUQhbZwqyh2i9nNzPs1jirdyWnpTvV8AzkGuARzIEIuVD
X-Google-Smtp-Source: AAOMgpdxTM7EPS7h29etQCi4NMieRLb9KrUtuhiFt5NmccmnIpGGuGCgmX6IshHMeS9jD6F7eSQNWlj4bwqGrxXkivG7fslW+hDJ
MIME-Version: 1.0
X-Received: by 2002:a6b:d49:: with SMTP id 70-v6mr5216311ion.139.1530249422632;
 Thu, 28 Jun 2018 22:17:02 -0700 (PDT)
Date:   Thu, 28 Jun 2018 22:17:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000410ab4056fc0f5ec@google.com>
Subject: BUG: unable to handle kernel NULL pointer dereference in do_sys_poll
From:   syzbot <syzbot+2c7e8f74f8b2571c87e8@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=109168df800000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a63be0c83e84d370
dashboard link: https://syzkaller.appspot.com/bug?extid=2c7e8f74f8b2571c87e8
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=11ce8f38400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15967188400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+2c7e8f74f8b2571c87e8@syzkaller.appspotmail.com

random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
PGD 1aec04067 P4D 1aec04067 PUD 1aed28067 PMD 0
Oops: 0010 [#1] SMP KASAN
CPU: 0 PID: 4522 Comm: syz-executor146 Not tainted 4.18.0-rc2+ #121
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:          (null)
Code: Bad RIP value.
RSP: 0018:ffff8801c3dbf758 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff8801aa717a80 RCX: ffffffff85ec9112
RDX: ffff8801c3dbfab0 RSI: ffff8801aa717a80 RDI: ffff8801b13a5040
RBP: ffff8801c3dbf800 R08: ffff8801aec18040 R09: ffffed0035ffd000
R10: ffffed0035ffd000 R11: ffff8801affe8003 R12: ffff8801c3dbfab0
R13: ffff8801b13a5040 R14: ffffffff8818a920 R15: ffff8801ae4c2980
FS:  00000000009a6880(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 00000001af185000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  vfs_poll include/linux/poll.h:86 [inline]
  do_pollfd fs/select.c:825 [inline]
  do_poll fs/select.c:873 [inline]
  do_sys_poll+0x74d/0x1180 fs/select.c:967
  __do_sys_poll fs/select.c:1025 [inline]
  __se_sys_poll fs/select.c:1013 [inline]
  __x64_sys_poll+0x197/0x530 fs/select.c:1013
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x43fd09
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 6b 45 00 00 c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffea215df98 EFLAGS: 00000213 ORIG_RAX: 0000000000000007
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 000000000043fd09
RDX: 0000000000000006 RSI: 0000000000000003 RDI: 0000000020003900
RBP: 00000000006ca018 R08: 00000000004002c8 R09: 00000000004002c8
R10: 00000000004002c8 R11: 0000000000000213 R12: 0000000000401630
R13: 00000000004016c0 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
Dumping ftrace buffer:
    (ftrace buffer empty)
CR2: 0000000000000000
---[ end trace 930be81983fe1d48 ]---
RIP: 0010:          (null)
Code: Bad RIP value.
RSP: 0018:ffff8801c3dbf758 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff8801aa717a80 RCX: ffffffff85ec9112
RDX: ffff8801c3dbfab0 RSI: ffff8801aa717a80 RDI: ffff8801b13a5040
RBP: ffff8801c3dbf800 R08: ffff8801aec18040 R09: ffffed0035ffd000
R10: ffffed0035ffd000 R11: ffff8801affe8003 R12: ffff8801c3dbfab0
R13: ffff8801b13a5040 R14: ffffffff8818a920 R15: ffff8801ae4c2980
FS:  00000000009a6880(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 00000001af185000 CR4: 00000000001406f0
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
