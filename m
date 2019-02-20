Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1EE1C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAB572070B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:32:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbfBTJcF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 04:32:05 -0500
Received: from mail-it1-f200.google.com ([209.85.166.200]:59159 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfBTJcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 04:32:04 -0500
Received: by mail-it1-f200.google.com with SMTP id 9so1327205ita.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 01:32:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=RPiu9o4aoXFTlNOUWMxQMi5raHo7X74iF0aKrIt2EJo=;
        b=lMoS+QR/xi6rXV+IgYQXHzcFLq9k/WNCzvghgXkkp/frPZU36ywsBFn7bXCGDtHaU3
         FTpzQpDq8LlQL0yI2V91DKYzdoggrU5wrOdvFdS3BKyPBu7I1FJJz3uw7XPFMP2mqOFv
         snAqICEWMfaTWXH19uQFLiByOsuFIQIX8aX3yKAtRtbpnLOhOB1cpwZwpQstNDUdvPsS
         pqM1dKx7z0LvSsT5RzP4ud9rqRnPR1ey7uj7Gq/Lsq7QPZixtvj21uSv6rpuSKOI/hNC
         vhaQmDDeFFRtiWGySJIHKit3EIXpHQ3pDsicHzXfC0ovtTZubx6QXDH9wgX++TyrmkJH
         kOqw==
X-Gm-Message-State: AHQUAuaAfVurED1hsTJ0ch+uUyrtLg5+WDk/zfnMLRPSvo9D+79VvG6T
        iOefii9iljR8qNdlre+oiZYviA5b25em6D5cuelFi5t2+OYZ
X-Google-Smtp-Source: AHgI3IbxrHexu8zH/rW5XIZknrdbBRncKT0u1RqSZW6yQ4CvlFOWZZL/gFSL6o5bqkPC/FBprt/LjttMw3VclZpD3DpE6rPgPuhh
MIME-Version: 1.0
X-Received: by 2002:a24:5c81:: with SMTP id q123mr5031743itb.34.1550655123540;
 Wed, 20 Feb 2019 01:32:03 -0800 (PST)
Date:   Wed, 20 Feb 2019 01:32:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cedfe1058250076c@google.com>
Subject: BUG: assuming atomic context at kernel/seccomp.c:LINE
From:   syzbot <syzbot+8bf19ee2aa580de7a2a7@syzkaller.appspotmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, kafai@fb.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        luto@amacapital.net, netdev@vger.kernel.org, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, wad@chromium.org, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    abf446c90405 Add linux-next specific files for 20190220
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17f250d8c00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=463cb576ac40e350
dashboard link: https://syzkaller.appspot.com/bug?extid=8bf19ee2aa580de7a2a7
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+8bf19ee2aa580de7a2a7@syzkaller.appspotmail.com

BUG: assuming atomic context at kernel/seccomp.c:271
in_atomic(): 0, irqs_disabled(): 0, pid: 12803, name: syz-executor.5
no locks held by syz-executor.5/12803.
CPU: 1 PID: 12803 Comm: syz-executor.5 Not tainted 5.0.0-rc7-next-20190220  
#39
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  __cant_sleep kernel/sched/core.c:6218 [inline]
  __cant_sleep.cold+0xa3/0xbb kernel/sched/core.c:6195
  seccomp_run_filters kernel/seccomp.c:271 [inline]
  __seccomp_filter+0x12b/0x12b0 kernel/seccomp.c:801
  __secure_computing+0x101/0x360 kernel/seccomp.c:932
  syscall_trace_enter+0x5bf/0xe10 arch/x86/entry/common.c:120
  do_syscall_64+0x479/0x610 arch/x86/entry/common.c:280
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x45ac8a
Code: 25 18 00 00 00 00 74 01 f0 48 0f b1 3d df ba 5f 00 48 39 c2 75 da f3  
c3 0f 1f 84 00 00 00 00 00 48 63 ff b8 e4 00 00 00 0f 05 <48> 3d 00 f0 ff  
ff 77 06 f3 c3 0f 1f 40 00 48 c7 c2 d4 ff ff ff f7
RSP: 002b:00007f92ed7b2c58 EFLAGS: 00000246 ORIG_RAX: 00000000000000e4
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 000000000045ac8a
RDX: 0000000000017230 RSI: 00007f92ed7b2c60 RDI: 0000000000000001
RBP: 000000000073bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00000000004c4cd5 R14: 00000000004d8890 R15: 00000000ffffffff


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
