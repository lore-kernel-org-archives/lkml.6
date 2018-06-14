Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 3C464C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 12:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8C3F208D8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 12:47:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8C3F208D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934160AbeFNMrF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 08:47:05 -0400
Received: from mail-it0-f71.google.com ([209.85.214.71]:52689 "EHLO
        mail-it0-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754809AbeFNMrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 08:47:03 -0400
Received: by mail-it0-f71.google.com with SMTP id q5-v6so5124703itq.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 05:47:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=TNjKdcoZMPIEzIZOrQm11hMTZh5xulhzjGhTdWW5iVQ=;
        b=fASHvS2krXbQSVMgJtgswtElGXOaTXJv4zCYj1JJTOvGx4LGVxSiOoxaTfHxAK2rMh
         KWuZ889svuFAe2Q5TCv+8ckBikNuIna3V4mV2O6BQeJQ9Vqd9eWCts/OCQLZvUgPymEm
         wIb7QNk+MTyadvXNRJ1VWyoAT9Wl4qi/N1d7kPNQ+S9bViBoF2+Rx1fvxyzbgyWkeNR4
         ZMf68Nq+Hybk+7ki6u+xG8hTHpjZWvyD2CZaDjthz8Ee8nYYKENKi4gtE5ofvW21ChWe
         h2ivm37DEzMPohv7sj1uZRC4o8UQloTe5AND4C7WF6fMugmWSGngjD2pd0e7q6jQPhol
         l95Q==
X-Gm-Message-State: APt69E36UfiHBBCZa/FtU+z7JOym2GT6zKI0voQQivG8bsmkmzs57iuL
        v9RIMqdstnb1s23pDZgG/ElJZOtZMXyms+9CgDzWMgH+BfV1
X-Google-Smtp-Source: ADUXVKLeAB1ucpB8goYium9+lD+0F1uJnIHe7gNHkEnOd83998LgRk/4BMFOz7kaRufXb1EWTNHcWvHsm5iYvAcroCaFgPuKzLHZ
MIME-Version: 1.0
X-Received: by 2002:a02:b059:: with SMTP id q25-v6mr450154jah.58.1528980423185;
 Thu, 14 Jun 2018 05:47:03 -0700 (PDT)
Date:   Thu, 14 Jun 2018 05:47:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fe1d2b056e997e1f@google.com>
Subject: WARNING in input_alloc_absinfo
From:   syzbot <syzbot+c382812c78d98ecd9fb8@syzkaller.appspotmail.com>
To:     dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, rydberg@bitmath.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    d2d741e5d189 kmsan: add initialization for shmem pages
git tree:       https://github.com/google/kmsan.git/master
console output: https://syzkaller.appspot.com/x/log.txt?x=1775bae7800000
kernel config:  https://syzkaller.appspot.com/x/.config?x=48f9de3384bcd0f
dashboard link: https://syzkaller.appspot.com/bug?extid=c382812c78d98ecd9fb8
compiler:       clang version 7.0.0 (trunk 329391)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=13b31ae7800000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1733255b800000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+c382812c78d98ecd9fb8@syzkaller.appspotmail.com

RBP: 00000000006cb018 R08: 0000000000000001 R09: 00007ffe93080031
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000004
R13: ffffffffffffffff R14: 0000000000000000 R15: 0000000000000000
------------[ cut here ]------------
input_alloc_absinfo(): kcalloc() failed?
WARNING: CPU: 1 PID: 4498 at drivers/input/input.c:487  
input_alloc_absinfo+0x183/0x190 drivers/input/input.c:487
Kernel panic - not syncing: panic_on_warn set ...

CPU: 1 PID: 4498 Comm: syz-executor465 Not tainted 4.16.0+ #87
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:17 [inline]
  dump_stack+0x185/0x1d0 lib/dump_stack.c:53
  panic+0x39d/0x940 kernel/panic.c:183
  __warn+0x40f/0x580 kernel/panic.c:547
  report_bug+0x72a/0x880 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:179 [inline]
  do_error_trap+0x1aa/0x600 arch/x86/kernel/traps.c:297
  do_invalid_op+0x46/0x50 arch/x86/kernel/traps.c:316
  invalid_op+0x1b/0x40 arch/x86/entry/entry_64.S:986
RIP: 0010:input_alloc_absinfo+0x183/0x190 drivers/input/input.c:487
RSP: 0018:ffff88019651faa8 EFLAGS: 00010282
RAX: 0000000000000028 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: aaaaaaaaaaaab000 RDI: ffffea0000000000
RBP: ffff88019651fae0 R08: 0000000001080020 R09: 0000000000000002
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: ffff8801a19ec140 R14: ffff88019796e198 R15: 0000000000000000
  uinput_abs_setup drivers/input/misc/uinput.c:507 [inline]
  uinput_ioctl_handler+0x38a2/0x39f0 drivers/input/misc/uinput.c:1035
  uinput_ioctl+0x9a/0xb0 drivers/input/misc/uinput.c:1047
  vfs_ioctl fs/ioctl.c:46 [inline]
  do_vfs_ioctl+0xaf0/0x2440 fs/ioctl.c:686
  SYSC_ioctl+0x1d2/0x260 fs/ioctl.c:701
  SyS_ioctl+0x54/0x80 fs/ioctl.c:692
  do_syscall_64+0x309/0x430 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
RIP: 0033:0x440429
RSP: 002b:00007ffe9308d2b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000440429
RDX: 0000000000000000 RSI: 0000000040005504 RDI: 0000000000000003
RBP: 00000000006cb018 R08: 0000000000000001 R09: 00007ffe93080031
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000004
R13: ffffffffffffffff R14: 0000000000000000 R15: 0000000000000000
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
