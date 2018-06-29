Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A7DC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 05:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED1C627A9F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 05:17:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED1C627A9F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753809AbeF2FRW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 01:17:22 -0400
Received: from mail-it0-f72.google.com ([209.85.214.72]:50399 "EHLO
        mail-it0-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932713AbeF2FRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 01:17:04 -0400
Received: by mail-it0-f72.google.com with SMTP id g125-v6so858569ita.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 22:17:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=vRXaEasuY8BKQ0orVEWsuHhX6bF2e48SZmc9JFzNuz8=;
        b=lZqNagPn0CABE4Nx8MAeKc7qx12ELDoP1pDbY/hrJtLcTQLplhGWBbVjgOYtpE0McI
         NwYVZYiNcwDxQFdcyrU0C+SMP0+71oCwvJ7rER+USWXNKD5YwTDEi5IUHEnOM5DsOchM
         9fpgwC7dAabbf/FQq82MwdBHeoFv2jH6nljQCqiD9gbdj2MZgziI4uQokE+FggsdIj18
         Ou7wdKHCSjXVrUwPq8iJ7OcD//f1DNLCSx6qkvx2M+2xqDVKiyqqxMQl9Kp+VRbArRSa
         Gn0FzActTbwsWr+KaiAUL5K4fQaJb2XuUKQni2kAaDLJKSLYUP99ZlCdhgD2AleAjRNo
         zSZA==
X-Gm-Message-State: APt69E0JBy7EXFAECf5Au6STk+PQnBu1pmK80OZjqoMj62R73ZiLUoC7
        yCKCK9TJQtO1bGR9jLNAkfC3YQng+aqqXANAlc8+SzOsLEXC
X-Google-Smtp-Source: AAOMgpcbBjUziIWtXY1obrWDX/E6lnUl2xH2eNwe86tebQt3WUyyIXJH99yZQ02BI9sKxaDjiyMYt50ibZdiC5fkfjZGS7TV2fZ4
MIME-Version: 1.0
X-Received: by 2002:a6b:b244:: with SMTP id b65-v6mr5209054iof.47.1530249423453;
 Thu, 28 Jun 2018 22:17:03 -0700 (PDT)
Date:   Thu, 28 Jun 2018 22:17:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004d84bc056fc0f5d3@google.com>
Subject: BUG: unable to handle kernel NULL pointer dereference in do_select
From:   syzbot <syzbot+cdb0d3176b53d35ad454@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=1759737f800000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a63be0c83e84d370
dashboard link: https://syzkaller.appspot.com/bug?extid=cdb0d3176b53d35ad454
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+cdb0d3176b53d35ad454@syzkaller.appspotmail.com

netlink: 8 bytes leftover after parsing attributes in process  
`syz-executor4'.
kvm [7726]: vcpu0, guest rIP: 0x9166 disabled perfctr wrmsr: 0xc1 data 0xb8
BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
PGD 1b10e9067 P4D 1b10e9067 PUD 1b3a1f067 PMD 0
Oops: 0010 [#1] SMP KASAN
CPU: 0 PID: 7772 Comm: syz-executor5 Not tainted 4.18.0-rc2+ #121
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:          (null)
Code: Bad RIP value.
RSP: 0018:ffff88019746f438 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff8801d270f140 RCX: ffffc90005628000
RDX: ffff88019746f6f0 RSI: ffff8801d270f140 RDI: ffff8801b273d800
RBP: ffff88019746f4e0 R08: ffff880195b58640 R09: ffffed003b5c46d6
R10: 0000000000000003 R11: 0000000000000000 R12: ffff88019746f6f0
R13: ffff8801b273d800 R14: ffffffff8818a920 R15: ffff880195c6e980
FS:  00007f300e4bb700(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 00000001a8e4d000 CR4: 00000000001426f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  vfs_poll include/linux/poll.h:86 [inline]
  do_select+0xac4/0x1b00 fs/select.c:507
  core_sys_select+0x78a/0xb80 fs/select.c:650
  do_pselect+0x241/0x4e0 fs/select.c:731
  __do_sys_pselect6 fs/select.c:772 [inline]
  __se_sys_pselect6 fs/select.c:757 [inline]
  __x64_sys_pselect6+0x1f7/0x280 fs/select.c:757
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x455a99
Code: 1d ba fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 eb b9 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f300e4bac68 EFLAGS: 00000246 ORIG_RAX: 000000000000010e
RAX: ffffffffffffffda RBX: 00007f300e4bb6d4 RCX: 0000000000455a99
RDX: 0000000020768000 RSI: 0000000020f33fc0 RDI: 0000000000000040
RBP: 000000000072bea0 R08: 0000000020349000 R09: 0000000020f14000
R10: 0000000020086000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000004c0708 R14: 00000000004d0140 R15: 0000000000000000
Modules linked in:
Dumping ftrace buffer:
    (ftrace buffer empty)
CR2: 0000000000000000
---[ end trace f41162cfde74d2ca ]---
RIP: 0010:          (null)
Code: Bad RIP value.
RSP: 0018:ffff88019746f438 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff8801d270f140 RCX: ffffc90005628000
RDX: ffff88019746f6f0 RSI: ffff8801d270f140 RDI: ffff8801b273d800
RBP: ffff88019746f4e0 R08: ffff880195b58640 R09: ffffed003b5c46d6
R10: 0000000000000003 R11: 0000000000000000 R12: ffff88019746f6f0
R13: ffff8801b273d800 R14: ffffffff8818a920 R15: ffff880195c6e980
FS:  00007f300e4bb700(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 00000001a8e4d000 CR4: 00000000001426f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
