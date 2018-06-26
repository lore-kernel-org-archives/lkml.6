Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SORTED_RECIPS,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1367C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 05:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CD8826507
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 05:06:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CD8826507
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751265AbeFZFGE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 01:06:04 -0400
Received: from mail-io0-f197.google.com ([209.85.223.197]:41952 "EHLO
        mail-io0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751025AbeFZFGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 01:06:02 -0400
Received: by mail-io0-f197.google.com with SMTP id t14-v6so9930592ioj.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 22:06:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Yfs6ojc1oFaONQknY2b4FPXgJivEW4v/nDusBdhaxmY=;
        b=mw/jDuIrbf232B6KdVaWKQ8HhouliBvDUTrptDxnTMByTVJKdRemCyj9B4vtORP72p
         r+V+eLQihYhAXJoy808zf2gHCj1YLKXmThtmlxVoiGdRexRKiRu05bv/ZZd532Ek21HU
         NyMJsnDQrJIx1m6Je+pDhHnTtj+myGRUC6RPz9m8exmqYg6qQWgmXh4jGI2SxSyjRKpp
         18EALhVUQprt7I9b5Kw/iMsygThLWVTV9dSI7RA0s5AE3TXoWQYOxDM+z8XbwAGenpLq
         7ggBgElrw1Z+Y+x7p/nUEuDXv2s9KxtmjD36Ln+klP5PyI44KET9rtAK+UsomLnzn/ek
         Kmug==
X-Gm-Message-State: APt69E2eSkXQJYjxWHJzMcxGaNVMAwDLWOtnLBHpfRhaH9Ht8PdwdoZX
        Vsr5WsV8jlUvh2MqVoc/khoFbCTPnP0Ko137x+N5iwQ+xo/9
X-Google-Smtp-Source: ADUXVKL/6yc//JIG24RuZNKlwbCy/oajrWD0r/WFQgTevrVKwpdUoAUpQ9E7jISw44HCIOZVokTcTrYGVDRPydwZcLhhK/rq1/1W
MIME-Version: 1.0
X-Received: by 2002:a02:3b1a:: with SMTP id c26-v6mr6632263jaa.9.1529989562180;
 Mon, 25 Jun 2018 22:06:02 -0700 (PDT)
Date:   Mon, 25 Jun 2018 22:06:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005d2af6056f8474ac@google.com>
Subject: WARNING in sctp_assoc_update_frag_point
From:   syzbot <syzbot+f0d9d7cba052f9344b03@syzkaller.appspotmail.com>
To:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        linux-sctp@vger.kernel.org, marcelo.leitner@gmail.com,
        netdev@vger.kernel.org, nhorman@tuxdriver.com,
        syzkaller-bugs@googlegroups.com, vyasevich@gmail.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    6f0d349d922b Merge git://git.kernel.org/pub/scm/linux/kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12a423c0400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a63be0c83e84d370
dashboard link: https://syzkaller.appspot.com/bug?extid=f0d9d7cba052f9344b03
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+f0d9d7cba052f9344b03@syzkaller.appspotmail.com

WARNING: CPU: 0 PID: 22543 at include/net/sctp/sctp.h:598 sctp_mtu_payload  
include/net/sctp/sctp.h:598 [inline]
WARNING: CPU: 0 PID: 22543 at include/net/sctp/sctp.h:598  
sctp_assoc_update_frag_point+0x252/0x2c0 net/sctp/associola.c:1401
Kernel panic - not syncing: panic_on_warn set ...

CPU: 0 PID: 22543 Comm: syz-executor2 Not tainted 4.18.0-rc2+ #117
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
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
RIP: 0010:sctp_mtu_payload include/net/sctp/sctp.h:598 [inline]
RIP: 0010:sctp_assoc_update_frag_point+0x252/0x2c0 net/sctp/associola.c:1401
Code: 76 fa 45 39 e5 76 1e e8 0c 69 76 fa 45 29 e5 45 89 ec e9 34 ff ff ff  
e8 fc 68 76 fa 45 8d 66 34 e9 09 ff ff ff e8 ee 68 76 fa <0f> 0b 45 31 e4  
e9 17 ff ff ff e8 7f 3c b4 fa e9 31 fe ff ff 4c 89
RSP: 0018:ffff8801d7def378 EFLAGS: 00010216
RAX: 0000000000040000 RBX: ffff8801d8580ac0 RCX: ffffc900133ca000
RDX: 00000000000001b9 RSI: ffffffff8705a382 RDI: 0000000000000004
RBP: ffff8801d7def3a0 R08: ffff8801cfaa6000 R09: ffffed002e0421af
R10: ffffed002e0421af R11: ffff880170210d7f R12: 0000000000000044
R13: 0000000000000044 R14: 0000000000000010 R15: ffff8801d8580ac0
  sctp_assoc_set_pmtu net/sctp/associola.c:1417 [inline]
  sctp_assoc_sync_pmtu+0x251/0x2e0 net/sctp/associola.c:1445
  sctp_sendmsg_to_asoc+0x1851/0x21a0 net/sctp/socket.c:1921
  sctp_sendmsg+0x13c2/0x1d90 net/sctp/socket.c:2124
  inet_sendmsg+0x1a1/0x690 net/ipv4/af_inet.c:798
  sock_sendmsg_nosec net/socket.c:645 [inline]
  sock_sendmsg+0xd5/0x120 net/socket.c:655
  ___sys_sendmsg+0x51d/0x930 net/socket.c:2161
  __sys_sendmmsg+0x240/0x6f0 net/socket.c:2256
  __do_sys_sendmmsg net/socket.c:2285 [inline]
  __se_sys_sendmmsg net/socket.c:2282 [inline]
  __x64_sys_sendmmsg+0x9d/0x100 net/socket.c:2282
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x455a99
Code: 1d ba fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 eb b9 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f75b488ec68 EFLAGS: 00000246 ORIG_RAX: 0000000000000133
RAX: ffffffffffffffda RBX: 00007f75b488f6d4 RCX: 0000000000455a99
RDX: 0000000000000001 RSI: 0000000020005900 RDI: 0000000000000014
RBP: 000000000072bff0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000004c0b1b R14: 00000000004d0938 R15: 0000000000000002
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
