Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 230EEC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D45AF20838
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:31:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D45AF20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbeH3Web (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 18:34:31 -0400
Received: from mail-it0-f72.google.com ([209.85.214.72]:43911 "EHLO
        mail-it0-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727178AbeH3Web (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 18:34:31 -0400
Received: by mail-it0-f72.google.com with SMTP id z72-v6so2622074itc.8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 11:31:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=DuoeEUWz5i/xvKEDF8CYumYTV+Pw1EtrD4Don+yMYeg=;
        b=iOCiE+Awu7hky1q2/XqqkiTx5laJQuPY9En9cyRhuNN8cvPGyVKI909yiV1gh2OLO2
         r84vAdTXYnyAgKx7Yy7EkUymgWBwOcdIt7mDI0vKRYa+ROYB5aLttyPn2FQj5FOt1/vG
         t+esjvI67IJbL1QUMY+WCPs1hpihc27F0MZ2LurN1WJ+EbCra95seUoYKqJv1JpCRcyq
         A2rgL+UdDrHBxtpMJMnNTKrbb695MbTcULeSttK/xJLMJUTkWYMeh4Lew8vRKZk+qTSJ
         wskiwSZBLUpfUsQSHJCnRMsA4LxYi9Pqe9aFVspWUY7QWGFvh2IWLDDwzHqsXqQhPSb9
         Q/xQ==
X-Gm-Message-State: APzg51DCubzWPemMZ3ewOwj4ibiWQbQzxHBCGVLCl5Gp51bS4V6PLwTO
        cZToFHh42okZu+/kQLXAKkLZx/GzRJFT/qGPRZURwHZlKpSU
X-Google-Smtp-Source: ANB0VdZS5DBnG8AtLAICIO5mMKeXQkFEoGkEwmvvHmXNu9V0Op8WM7NG6wIPo9/EAjLkeVYSrGZOuM60Qtma5R2JAfGdTunS7WUq
MIME-Version: 1.0
X-Received: by 2002:a24:ac14:: with SMTP id s20-v6mr1710737ite.14.1535653863325;
 Thu, 30 Aug 2018 11:31:03 -0700 (PDT)
Date:   Thu, 30 Aug 2018 11:31:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000005859b0574ab47e5@google.com>
Subject: KMSAN: uninit-value in rds_connect
From:   syzbot <syzbot+0049bebbf3042dbd2e8f@syzkaller.appspotmail.com>
To:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
        rds-devel@oss.oracle.com, santosh.shilimkar@oracle.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    2dca2cbde67a kmsan: fix build warnings with CONFIG_KMSAN=n
git tree:       https://github.com/google/kmsan.git/master
console output: https://syzkaller.appspot.com/x/log.txt?x=1519734a400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=820d6393634b55e3
dashboard link: https://syzkaller.appspot.com/bug?extid=0049bebbf3042dbd2e8f
compiler:       clang version 8.0.0 (trunk 339414)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+0049bebbf3042dbd2e8f@syzkaller.appspotmail.com

RDX: 0000000000000000 RSI: 0000000020000380 RDI: 00000000000001ff
RBP: 00000000009300a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000003
R13: 00000000004cd2e8 R14: 00000000004c3d93 R15: 0000000000000003
==================================================================
BUG: KMSAN: uninit-value in rds_connect+0x213/0x950 net/rds/af_rds.c:511
CPU: 0 PID: 8117 Comm: syz-executor6 Not tainted 4.19.0-rc1+ #36
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x14b/0x190 lib/dump_stack.c:113
  kmsan_report+0x183/0x2b0 mm/kmsan/kmsan.c:956
  __msan_warning+0x70/0xc0 mm/kmsan/kmsan_instr.c:645
  rds_connect+0x213/0x950 net/rds/af_rds.c:511
  __sys_connect+0x64e/0x750 net/socket.c:1662
  __do_sys_connect net/socket.c:1673 [inline]
  __se_sys_connect net/socket.c:1670 [inline]
  __x64_sys_connect+0xd8/0x120 net/socket.c:1670
  do_syscall_64+0x15b/0x220 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x63/0xe7
RIP: 0033:0x457089
Code: fd b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f7090fc1c78 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
RAX: ffffffffffffffda RBX: 00007f7090fc26d4 RCX: 0000000000457089
RDX: 0000000000000000 RSI: 0000000020000000 RDI: 0000000000000003
RBP: 00000000009300a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000004cb710 R14: 00000000004c320b R15: 0000000000000000

Local variable description: ----address@__sys_connect
Variable was created at:
  __sys_connect+0x6a/0x750 net/socket.c:1645
  __do_sys_connect net/socket.c:1673 [inline]
  __se_sys_connect net/socket.c:1670 [inline]
  __x64_sys_connect+0xd8/0x120 net/socket.c:1670
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
