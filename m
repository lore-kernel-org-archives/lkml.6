Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id nbmKJ31MGVvJYQAAmS7hNA
	; Thu, 07 Jun 2018 15:19:08 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 05D14607E7; Thu,  7 Jun 2018 15:19:08 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,FROM_LOCAL_HEX,
	MAILING_LIST_MULTI autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 5C7EB6074D;
	Thu,  7 Jun 2018 15:19:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5C7EB6074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936059AbeFGPTE (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 11:19:04 -0400
Received: from mail-io0-f199.google.com ([209.85.223.199]:50809 "EHLO
        mail-io0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934980AbeFGPTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 11:19:02 -0400
Received: by mail-io0-f199.google.com with SMTP id n15-v6so7621611ioc.17
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 08:19:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Ggiga23nkZH3CS84fQMw+RF8nQGrMDAevTGakdT8yAc=;
        b=QcxyESzfKYKL2Va8SCReN/rO4O0E1FZDG/lURNakYCV5ApK3AYtbOsXLLNOeRYe7Es
         hZC5CDr9kfQrP/viG3OY8aM7ruPi/s7F0uVBaK3ZyLDtvhfG11UjBgnlZbVuQDo3GfiU
         g52YBiw4crFpnLw5m80W2xm5OzxEnXW4EIqzPzYo6+ODwlboVSHhbRX8agaUSjAOQF6X
         Nk6sJ083ORBAjiEMnyyyVlAAhxv+IAfWuLLIaeiQFBAi1tMI8bJ2EpFoGfolFEklusa1
         v3GjsMxS7K/t2CPPxV7Tv3dwAkKNehaDaRpJWg4y8KBciZi669dPKYiMlECcmPBTOKer
         XYGQ==
X-Gm-Message-State: APt69E1YlmTaZfM79UBjmQi2ABDVc1Zb5l8csEJXqKZBPeDq2hfEq7vd
        0FT8EThWsO6DnCKH+NUNFS5GqBeAF9v+uaoU0+7MPC8q5LId
X-Google-Smtp-Source: ADUXVKIe1rKD5LNCvSZUROvpXN4T0Kof4CiFiS32OTlcc0LrMxKdO9tdiej71ULn9wcqogjwOqTu34h7Xrxxh3rOsbiAqYTV/3d+
MIME-Version: 1.0
X-Received: by 2002:a6b:d208:: with SMTP id q8-v6mr994143iob.137.1528384741388;
 Thu, 07 Jun 2018 08:19:01 -0700 (PDT)
Date: Thu, 07 Jun 2018 08:19:01 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000973c2c056e0ecddd@google.com>
Subject: general protection fault in __vfs_write
From: syzbot <syzbot+7ade6c94abb2774c0fee@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    7170e6045a6a strparser: Add __strp_unpause and use it in k..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14bde74f800000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a601a80fec461d44
dashboard link: https://syzkaller.appspot.com/bug?extid=7ade6c94abb2774c0fee
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+7ade6c94abb2774c0fee@syzkaller.appspotmail.com

bpfilter: read fail -512
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] SMP KASAN
Dumping ftrace buffer:
    (ftrace buffer empty)
Modules linked in:
CPU: 1 PID: 4590 Comm: syz-executor7 Not tainted 4.17.0-rc7+ #82
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:file_write_hint include/linux/fs.h:1925 [inline]
RIP: 0010:init_sync_kiocb include/linux/fs.h:1935 [inline]
RIP: 0010:new_sync_write fs/read_write.c:470 [inline]
RIP: 0010:__vfs_write+0x4a6/0x960 fs/read_write.c:487
RSP: 0018:ffff88019b5c7850 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffff8801d2117c80 RCX: ffffffff81bfc6bb
RDX: 0000000000000019 RSI: ffffffff81bfc6ca RDI: 00000000000000c8
RBP: ffff88019b5c79c8 R08: ffff88019b5ba540 R09: fffffbfff12cae69
R10: ffff88019b5c7a10 R11: ffffffff8965734b R12: 0000000000000000
R13: ffff88019b5c79a0 R14: 0000000000000000 R15: ffff88019b5c7a88
FS:  0000000002a11940(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000700138 CR3: 000000019b410000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  __kernel_write+0x10c/0x380 fs/read_write.c:506
  __bpfilter_process_sockopt+0x1d8/0x35b net/bpfilter/bpfilter_kern.c:66
  bpfilter_mbox_request+0x4d/0xb0 net/ipv4/bpfilter/sockopt.c:25
  bpfilter_ip_get_sockopt+0x6b/0x90 net/ipv4/bpfilter/sockopt.c:42
  ip_getsockopt+0x238/0x2a0 net/ipv4/ip_sockglue.c:1563
  tcp_getsockopt+0x93/0xe0 net/ipv4/tcp.c:3543
  sock_common_getsockopt+0x9a/0xe0 net/core/sock.c:3018
  __sys_getsockopt+0x1a5/0x370 net/socket.c:1940
  __do_sys_getsockopt net/socket.c:1951 [inline]
  __se_sys_getsockopt net/socket.c:1948 [inline]
  __x64_sys_getsockopt+0xbe/0x150 net/socket.c:1948
  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4584ea
RSP: 002b:0000000000a3e328 EFLAGS: 00000246 ORIG_RAX: 0000000000000037
RAX: ffffffffffffffda RBX: 0000000000a3e350 RCX: 00000000004584ea
RDX: 0000000000000040 RSI: 0000000000000000 RDI: 0000000000000013
RBP: 0000000000705f20 R08: 0000000000a3e34c R09: 0000000000004000
R10: 0000000000a3e350 R11: 0000000000000246 R12: 0000000000000013
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000705860
Code: 48 c1 ea 03 80 3c 02 00 0f 85 1b 04 00 00 48 b8 00 00 00 00 00 fc ff  
df 4c 8b 63 20 49 8d bc 24 c8 00 00 00 48 89 fa 48 c1 ea 03 <0f> b6 04 02  
84 c0 74 08 3c 03 0f 8e ec 02 00 00 41 8b 84 24 c8
RIP: file_write_hint include/linux/fs.h:1925 [inline] RSP: ffff88019b5c7850
RIP: init_sync_kiocb include/linux/fs.h:1935 [inline] RSP: ffff88019b5c7850
RIP: new_sync_write fs/read_write.c:470 [inline] RSP: ffff88019b5c7850
RIP: __vfs_write+0x4a6/0x960 fs/read_write.c:487 RSP: ffff88019b5c7850
---[ end trace 556c3fc867e1de54 ]---


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
