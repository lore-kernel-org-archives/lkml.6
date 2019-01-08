Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95BCDC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 06:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B9E32087F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 06:21:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbfAHGVF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 01:21:05 -0500
Received: from mail-it1-f200.google.com ([209.85.166.200]:53141 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727566AbfAHGVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 01:21:05 -0500
Received: by mail-it1-f200.google.com with SMTP id o205so2494883itc.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 22:21:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=fJ7TZpagLCGTI772+uuWKdc5B/+o9+qXyVw73pc8ivY=;
        b=avVma6x/HzCUql+KOY0AGb1mnfVWlC1ELuYPvhmbZHhu/mJHWiy28vuRXs/QVfcgVn
         8WnxePyqF9fbWVWPxWkezsQ/ByzaDN45CS7U5rpIvP4FV73lMrkacCJkjg8qHJiOOQtO
         2vIB0SBqt6ADgcVy22dVfVPTMt0DMuTb9NiDwgtojGrz9bsLBSLSQZy1eG6wzM+aAP5I
         kpj3EfvpYhCV7Rcn5Qsp9u0QzScxS2SPR2BY4rPgI1ocjTuleasGJOogUwUG0JYWKd3q
         UHRAIXJiVFKBTTyhBYMmNSrKSC46U7IPibqgcJZF5RCU+8wbRWLvqrC2xN8k3iNDbPOZ
         3aPg==
X-Gm-Message-State: AJcUukelMY+Hv+aN2GaRlK+eDrt9pJPKOZafIPB93NWKjANeRpgQoKS/
        BuE3PWpfNKt6zRL2V81uf5hbmicz8HxcWh1Qcct7vvNF6l9L
X-Google-Smtp-Source: ALg8bN4BoM6uHlNyLDY53+A971CT7JnwA92aj8IGBTGQdtdDc3luqZS+KymoOOSNcPp2+jT439KsdLSwZ4y/IkazrJ98w9bz2VUj
MIME-Version: 1.0
X-Received: by 2002:a24:5dd4:: with SMTP id w203mr539034ita.8.1546928463887;
 Mon, 07 Jan 2019 22:21:03 -0800 (PST)
Date:   Mon, 07 Jan 2019 22:21:03 -0800
In-Reply-To: <000000000000d8bec0057eec0a92@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009546de057eec59be@google.com>
Subject: Re: WARNING in ep_poll_callback
From:   syzbot <syzbot+aea82bf9ee6ffd9a79d9@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, dvyukov@google.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        rpenyaev@suse.de, sfr@canb.auug.org.au,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    139287cc2cc0 Add linux-next specific files for 20190108
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14c9dd4b400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1521b074ff5a5bdf
dashboard link: https://syzkaller.appspot.com/bug?extid=aea82bf9ee6ffd9a79d9
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1776034b400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14c2e580c00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+aea82bf9ee6ffd9a79d9@syzkaller.appspotmail.com

------------[ cut here ]------------
IRQs not disabled as expected
WARNING: CPU: 0 PID: 7862 at fs/eventpoll.c:1224  
ep_poll_callback+0x77e/0x1450 fs/eventpoll.c:1224
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 7862 Comm: syz-executor245 Not tainted 5.0.0-rc1-next-20190108  
#7
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1db/0x2d0 lib/dump_stack.c:113
  panic+0x2cb/0x65c kernel/panic.c:214
  __warn.cold+0x20/0x48 kernel/panic.c:571
  report_bug+0x263/0x2b0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:178 [inline]
  fixup_bug arch/x86/kernel/traps.c:173 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:271
  do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:290
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:973
RIP: 0010:ep_poll_callback+0x77e/0x1450 fs/eventpoll.c:1224
Code: ff 44 89 ee e8 63 84 98 ff 45 84 ed 0f 85 4a fa ff ff e8 15 83 98 ff  
48 c7 c7 00 69 56 88 c6 05 a1 b2 6e 08 01 e8 52 c8 61 ff <0f> 0b e9 2b fa  
ff ff e8 f6 82 98 ff 48 8d 7b 30 48 b8 00 00 00 00
RSP: 0018:ffff8880924ff6a0 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff88809241f480 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff816869f6 RDI: 0000000000000005
RBP: ffff8880924ff880 R08: ffff888099776640 R09: ffff888099776f30
R10: ffff888099776640 R11: 0000000000000000 R12: ffff8880924ff858
R13: 0000000000000000 R14: ffff88809241f4d0 R15: 0000000000000000
  __wake_up_common+0x1d3/0x7d0 kernel/sched/wait.c:92
  __wake_up_locked+0x11/0x20 kernel/sched/wait.c:154
  fuse_abort_conn+0xd01/0x1200 fs/fuse/dev.c:2212
  fuse_sb_destroy+0xd3/0x1d0 fs/fuse/inode.c:1245
  fuse_kill_sb_anon+0x16/0x30 fs/fuse/inode.c:1256
  deactivate_locked_super+0x9a/0x100 fs/super.c:331
  deactivate_super fs/super.c:362 [inline]
  deactivate_super+0x2ab/0x320 fs/super.c:358
  cleanup_mnt+0xbf/0x160 fs/namespace.c:1140
  __cleanup_mnt+0x16/0x20 fs/namespace.c:1147
  task_work_run+0x1f4/0x2b0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:188 [inline]
  exit_to_usermode_loop+0x32a/0x3b0 arch/x86/entry/common.c:166
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x696/0x800 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x440229
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 fb 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fffbe5bdb08 EFLAGS: 00000217 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 00000000004002c8 RCX: 0000000000440229
RDX: 0000000000440229 RSI: 0000000000000000 RDI: 0000000020000040
RBP: 00000000006ca018 R08: 00000000004002c8 R09: 00000000004002c8
R10: 00000000004002c8 R11: 0000000000000217 R12: 0000000000401ab0
R13: 0000000000401b40 R14: 0000000000000000 R15: 0000000000000000
Kernel Offset: disabled
Rebooting in 86400 seconds..

