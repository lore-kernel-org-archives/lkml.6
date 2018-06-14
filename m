Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 80DD2C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 07:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37776208D7
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 07:37:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37776208D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754598AbeFNHhF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 03:37:05 -0400
Received: from mail-io0-f199.google.com ([209.85.223.199]:48331 "EHLO
        mail-io0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752748AbeFNHhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 03:37:03 -0400
Received: by mail-io0-f199.google.com with SMTP id t11-v6so4131444iog.15
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 00:37:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=XzloYqkpH4EhwVcbD6tly0xlf+CsNKf9BT9Bn0LVRWc=;
        b=c29sMJYh+6VVrLq66Jf93aD2kI12EB0sr7W7yFEePFUDD2nGFcMfNHTdJIVR+lTYA0
         B/G240jCKOE2QHTg9DFXaTceyiklGCcva9nEIe6sCldWSuBiorWeC+EuhyBNXKz44qv6
         Y/ywt6hNpic+92WxPBgfAtF9R4JGOsajBN1cUSIho/r4MHZeYmDP/0FtURlRoUw8Ovof
         M8srTIU3JwHmxTj1s+GdWgd4aRr90dvWgxJVb15YjqcIKnurtb4ZHmpTJ0nRmPK59WaD
         ien/30942svgpFfBQ6/ebqLWqblJBT5PQ4hip3mQadlsNWM55/UnZqEB69RCTKMeWmjK
         5mAw==
X-Gm-Message-State: APt69E2ucThGLchOYVehlc6KrVPzSDQUNEgObz80XJWPS9I1X2hIK7Ha
        is+lAE5jBp1XEZlbiPZoFK3L3CwcyZG1wXOQrEyobt9CjUWC
X-Google-Smtp-Source: ADUXVKLKv+IFPaO6AK/dYg5+VeULRNRR+bdL3Hl1whl4sRdKAUmG9duYTMe9JmNw7sUdTR3yWlRhVuVlB5bEhvovVEzepNbLzNyY
MIME-Version: 1.0
X-Received: by 2002:a24:35c1:: with SMTP id k184-v6mr628337ita.43.1528961822973;
 Thu, 14 Jun 2018 00:37:02 -0700 (PDT)
Date:   Thu, 14 Jun 2018 00:37:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000556929056e952ae0@google.com>
Subject: WARNING in bpf_prog_select_runtime
From:   syzbot <syzbot+3b889862e65a98317058@syzkaller.appspotmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    ee946c36be21 Merge tag 'platform-drivers-x86-v4.17-2' of g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11ca275b800000
kernel config:  https://syzkaller.appspot.com/x/.config?x=889265cebaf9bda1
dashboard link: https://syzkaller.appspot.com/bug?extid=3b889862e65a98317058
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=17530b5b800000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+3b889862e65a98317058@syzkaller.appspotmail.com

RAX: ffffffffffffffda RBX: 00000000014b0914 RCX: 0000000000455979
RDX: 0000000000000033 RSI: 0000000000000001 RDI: 0000000000000004
RBP: 000000000072bea0 R08: 0000000000000010 R09: 0000000000000000
R10: 0000000020000500 R11: 0000000000000246 R12: 0000000000000005
R13: 0000000000000578 R14: 00000000006fc3e0 R15: 000000000000000a
WARNING: CPU: 0 PID: 4502 at include/linux/filter.h:651 bpf_prog_lock_ro  
include/linux/filter.h:651 [inline]
WARNING: CPU: 0 PID: 4502 at include/linux/filter.h:651  
bpf_prog_select_runtime+0x53c/0x640 kernel/bpf/core.c:1503
Kernel panic - not syncing: panic_on_warn set ...

CPU: 0 PID: 4502 Comm: syz-executor0 Not tainted 4.17.0-rc3+ #35
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
  panic+0x22f/0x4de kernel/panic.c:184
  __warn.cold.8+0x163/0x1b3 kernel/panic.c:536
  report_bug+0x252/0x2d0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:178 [inline]
  do_error_trap+0x1de/0x490 arch/x86/kernel/traps.c:296
  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:315
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:992
RIP: 0010:bpf_prog_lock_ro include/linux/filter.h:651 [inline]
RIP: 0010:bpf_prog_select_runtime+0x53c/0x640 kernel/bpf/core.c:1503
RSP: 0018:ffff8801b094f8a8 EFLAGS: 00010293
RAX: ffff8801b194e040 RBX: ffffc90001944000 RCX: ffffffff81857b67
RDX: 0000000000000000 RSI: ffffffff81857efc RDI: 0000000000000005
RBP: ffff8801b094f908 R08: ffff8801b194e040 R09: 0000000000000006
R10: ffff8801b194e040 R11: 0000000000000000 R12: 00000000fffffff4
R13: ffffffff81862050 R14: 0000000000000000 R15: ffff8801d7186480
  bpf_migrate_filter net/core/filter.c:1069 [inline]
  bpf_prepare_filter+0xb65/0x1060 net/core/filter.c:1117
  __get_filter+0x1e0/0x280 net/core/filter.c:1310
  sk_reuseport_attach_filter+0x1d/0x90 net/core/filter.c:1343
  sock_setsockopt+0x1ad3/0x1f40 net/core/sock.c:954
  __sys_setsockopt+0x2df/0x390 net/socket.c:1899
  __do_sys_setsockopt net/socket.c:1914 [inline]
  __se_sys_setsockopt net/socket.c:1911 [inline]
  __x64_sys_setsockopt+0xbe/0x150 net/socket.c:1911
  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x455979
RSP: 002b:00007ffd0a44c648 EFLAGS: 00000246 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 00000000014b0914 RCX: 0000000000455979
RDX: 0000000000000033 RSI: 0000000000000001 RDI: 0000000000000004
RBP: 000000000072bea0 R08: 0000000000000010 R09: 0000000000000000
R10: 0000000020000500 R11: 0000000000000246 R12: 0000000000000005
R13: 0000000000000578 R14: 00000000006fc3e0 R15: 000000000000000a
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
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
