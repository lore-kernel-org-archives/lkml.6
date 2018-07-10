Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SORTED_RECIPS,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 548C5C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1732C208EB
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:41:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1732C208EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390031AbeGJSlS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:41:18 -0400
Received: from mail-io0-f197.google.com ([209.85.223.197]:43469 "EHLO
        mail-io0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389735AbeGJSlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:41:17 -0400
Received: by mail-io0-f197.google.com with SMTP id n18-v6so19927500iog.10
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 11:41:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=IxLiiblRs9SIy/vRn13ReuWHjb8XfxuWMIHSLbxSAh4=;
        b=MFtTTQMOwHaOfYV7RZ13pRGmlnVTobXWLbWuEjotMobWy6R6I3StBwMa9hqPsef70A
         VXl9Mvm/8BmFx3s6aq9m5NXEVEaVPWBxZiQSgat78biw0RFNGP5hsVH6QezIdrYOu/g8
         9EOOjoxXgC4MzBaudalD2yIInRcwLPPeIeSDCsUYS7gVa9uQhcaUknlPwq1Nd7ADurzj
         TR+YU58wSdwp4knbvB0euB0d7VxXfoCzTu99nuLF6wwDXnrqqr49s6UOLCXhT1LerMUo
         Z0HeIKumWeQPW4h050VY8heqM6UIBpVofDzhGGSGJ2ZBPel9ysofTcQJsrOmrmVfP9EP
         jmmA==
X-Gm-Message-State: APt69E1UMpy93jEpMqmZV84OimmR/EBh730ZA4rQj5YBGjpz/DdqymNi
        zgF6KBdvpKSKwr+20mJk3RRbJ+RMygmNxEMlY8q35kr7PTA6
X-Google-Smtp-Source: AAOMgpeX6hqzV7wHvkPhjGSLq57vMNt2Q8yDktJurN54oxfIqLkMauXQc4WO4Ii39WTjo0+f7OYTXxRq8CA09a53FLgZEcxGcSTp
MIME-Version: 1.0
X-Received: by 2002:a6b:4908:: with SMTP id u8-v6mr11170161iob.112.1531248061527;
 Tue, 10 Jul 2018 11:41:01 -0700 (PDT)
Date:   Tue, 10 Jul 2018 11:41:01 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c541110570a978a4@google.com>
Subject: KMSAN: uninit-value in p9_client_rpc
From:   syzbot <syzbot+4de40388f584432bf004@syzkaller.appspotmail.com>
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

HEAD commit:    b64f7ec04e12 kmsan: implement kmsan_memmove_shadow() and k..
git tree:       https://github.com/google/kmsan.git/master
console output: https://syzkaller.appspot.com/x/log.txt?x=127179b2400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=93d57043084eee38
dashboard link: https://syzkaller.appspot.com/bug?extid=4de40388f584432bf004
compiler:       clang version 7.0.0 (trunk 334104)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+4de40388f584432bf004@syzkaller.appspotmail.com

==================================================================
BUG: KMSAN: uninit-value in p9_client_rpc+0x194c/0x1dc0 net/9p/client.c:818
CPU: 0 PID: 14601 Comm: syz-executor4 Not tainted 4.18.0-rc4+ #24
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x185/0x1e0 lib/dump_stack.c:113
  kmsan_report+0x195/0x2c0 mm/kmsan/kmsan.c:1092
  __msan_warning_32+0x7d/0xe0 mm/kmsan/kmsan_instr.c:640
  p9_client_rpc+0x194c/0x1dc0 net/9p/client.c:818
  p9_client_attach+0x35b/0xc30 net/9p/client.c:1147
  v9fs_session_init+0x24b9/0x2970 fs/9p/v9fs.c:449
  v9fs_mount+0x107/0x11b0 fs/9p/vfs_super.c:135
  mount_fs+0x29b/0x780 fs/super.c:1277
  vfs_kern_mount+0x222/0x990 fs/namespace.c:1037
  do_new_mount fs/namespace.c:2518 [inline]
  do_mount+0xd30/0x5310 fs/namespace.c:2848
  ksys_mount+0x32e/0x3d0 fs/namespace.c:3064
  __do_sys_mount fs/namespace.c:3078 [inline]
  __se_sys_mount fs/namespace.c:3075 [inline]
  __x64_sys_mount+0x157/0x1c0 fs/namespace.c:3075
  do_syscall_64+0x15b/0x230 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x63/0xe7
RIP: 0033:0x455e29
Code: 1d ba fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 eb b9 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f2b81f7fc68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f2b81f806d4 RCX: 0000000000455e29
RDX: 0000000020000080 RSI: 0000000020000000 RDI: 0000000000000000
RBP: 000000000072bea0 R08: 0000000020000380 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000004c05ca R14: 00000000004d0070 R15: 0000000000000000

Local variable description: ----ecode.i@p9_client_rpc
Variable was created at:
  p9_client_rpc+0x183/0x1dc0 net/9p/client.c:750
  p9_client_attach+0x35b/0xc30 net/9p/client.c:1147
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
