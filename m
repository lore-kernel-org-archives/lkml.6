Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id wS66J3CAGlsANwAAmS7hNA
	; Fri, 08 Jun 2018 13:11:12 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 8E0F1608B8; Fri,  8 Jun 2018 13:11:12 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=2.0 tests=BAYES_00,FROM_LOCAL_HEX,
	MAILING_LIST_MULTI,SORTED_RECIPS autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id E65AE601D2;
	Fri,  8 Jun 2018 13:11:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E65AE601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752692AbeFHNLE (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 09:11:04 -0400
Received: from mail-it0-f70.google.com ([209.85.214.70]:41007 "EHLO
        mail-it0-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751253AbeFHNLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 09:11:02 -0400
Received: by mail-it0-f70.google.com with SMTP id m12-v6so1792690ita.6
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 06:11:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=+2xGgAWPu4G6JpEo22YRQf/QzrAAKZiIHAgkeL04sv0=;
        b=eicZHzEDUWZmGTIRq3wqwVUgWPT33DHrI2HrKXGmJqv1Zjx2HVwBEc7yvx7Etn6KeG
         y1OqX2jrTvR3StEE/R3OTEkZJAWQn9HSlKUwNMZ5HOrFsalc4S/nv2Ij+hsRBzGg+32W
         Si0n63H0Pd5E4mebL2L51h5iBpNmmHLw9P3zLK6dLcDcgHhKgGWcmioHU8dIY6zqopw/
         7zpSjVhj8jzx/H7fw0mW/3Cjpo5M8XDrhdFFd7ikR0nrZtWMHEwfK3l+4I19LpDtu2Gm
         wFfrnQS0pSCHdhdqYA+kQVPGSL0eUXGycQMW1ssf83JVjesWQTtv2kewcQxwDI3eJubo
         52Ug==
X-Gm-Message-State: APt69E1Rnvpa6MKD2H6MLDjL1ICYniGiWLUqiFm4vus0lOD2P4GncZnv
        oOpywZNZy+7I9QO1DRpdzrTIJRWq23W/AccR9Yd6awOi0sl6
X-Google-Smtp-Source: ADUXVKLTp0u6ZI176KHKzSmBbGFVVyVFvIrQoYuDzhMi2UXdfojFUmbGRkeMxIgW/PjzWWLXy6XaVbgpw2Z8m/URY+vlCsn7yMM/
MIME-Version: 1.0
X-Received: by 2002:a6b:1d87:: with SMTP id d129-v6mr2600192iod.17.1528463462098;
 Fri, 08 Jun 2018 06:11:02 -0700 (PDT)
Date: Fri, 08 Jun 2018 06:11:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b5f145056e2121a4@google.com>
Subject: kernel BUG at include/linux/mm.h:LINE! (2)
From: syzbot <syzbot+3225ce21c0e9929bb9cf@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    7170e6045a6a strparser: Add __strp_unpause and use it in k..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=114236af800000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a601a80fec461d44
dashboard link: https://syzkaller.appspot.com/bug?extid=3225ce21c0e9929bb9cf
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=10f44fdf800000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=110f636f800000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+3225ce21c0e9929bb9cf@syzkaller.appspotmail.com

flags: 0x2fffc0000000000()
raw: 02fffc0000000000 0000000000000000 0000000000000000 00000000ffffff80
raw: ffffea0006b29220 ffff88021fffac18 0000000000000003 0000000000000000
page dumped because: VM_BUG_ON_PAGE(page_ref_count(page) <= 0)
------------[ cut here ]------------
kernel BUG at include/linux/mm.h:853!
invalid opcode: 0000 [#1] SMP KASAN
Dumping ftrace buffer:
    (ftrace buffer empty)
Modules linked in:
CPU: 1 PID: 4545 Comm: syz-executor492 Not tainted 4.17.0-rc7+ #82
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:get_page include/linux/mm.h:853 [inline]
RIP: 0010:do_tcp_sendpages+0x1879/0x1e60 net/ipv4/tcp.c:1002
RSP: 0018:ffff8801c2a06f88 EFLAGS: 00010203
RAX: 0000000000000000 RBX: ffff8801d972d580 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff81a66c25 RDI: ffffed0038540de0
RBP: ffff8801c2a071e8 R08: ffff8801b11d2480 R09: 0000000000000006
R10: ffff8801b11d2480 R11: 0000000000000000 R12: 000000000000301d
R13: ffffea0006b2621c R14: ffff8801ae5a6040 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020008000 CR3: 0000000008c6a000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  tls_push_sg+0x25b/0x860 net/tls/tls_main.c:126
  tls_push_record+0xae5/0x13e0 net/tls/tls_sw.c:266
  tls_sw_push_pending_record+0x22/0x30 net/tls/tls_sw.c:276
  tls_handle_open_record net/tls/tls_main.c:164 [inline]
  tls_sk_proto_close+0x734/0xad0 net/tls/tls_main.c:264
  inet_release+0x104/0x1f0 net/ipv4/af_inet.c:427
  inet6_release+0x50/0x70 net/ipv6/af_inet6.c:459
  sock_release+0x96/0x1b0 net/socket.c:594
  sock_close+0x16/0x20 net/socket.c:1149
  __fput+0x34d/0x890 fs/file_table.c:209
  ____fput+0x15/0x20 fs/file_table.c:243
  task_work_run+0x1e4/0x290 kernel/task_work.c:113
  exit_task_work include/linux/task_work.h:22 [inline]
  do_exit+0x1aee/0x2730 kernel/exit.c:865
  do_group_exit+0x16f/0x430 kernel/exit.c:968
  __do_sys_exit_group kernel/exit.c:979 [inline]
  __se_sys_exit_group kernel/exit.c:977 [inline]
  __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:977
  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x43f368
RSP: 002b:00007ffd03500578 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 000000000043f368
RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
RBP: 00000000004bf448 R08: 00000000000000e7 R09: ffffffffffffffd0
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00000000006d1180 R14: 0000000000000000 R15: 0000000000000000
Code: ff ff 41 89 86 cc 08 00 00 e8 e4 07 05 00 e9 2c eb ff ff e8 ca 4b 27  
fb 48 8b bd b8 fd ff ff 48 c7 c6 40 0c 54 88 e8 77 72 54 fb <0f> 0b 48 89  
85 b8 fd ff ff e8 a9 4b 27 fb 48 8b 85 b8 fd ff ff
RIP: get_page include/linux/mm.h:853 [inline] RSP: ffff8801c2a06f88
RIP: do_tcp_sendpages+0x1879/0x1e60 net/ipv4/tcp.c:1002 RSP:  
ffff8801c2a06f88
---[ end trace 500a6e4fab99629c ]---


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
