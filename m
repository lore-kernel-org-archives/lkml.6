Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C82EFC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A16702084D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:44:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729479AbfBUOoY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 09:44:24 -0500
Received: from mail-it1-f197.google.com ([209.85.166.197]:41550 "EHLO
        mail-it1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729827AbfBUOoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 09:44:04 -0500
Received: by mail-it1-f197.google.com with SMTP id q184so15683005itd.6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 06:44:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Ka1LfNYrMGwk9ee+N1Vo76fA+wItesHIaTwt/Apjta8=;
        b=kOI+lte90TfReRLX5Ypt9hu0xRqAgPcxdTMUUH7LHCVwEYufOlI9+K8H45zII03M2+
         1NgmQPrI9rIRTvJxlTvtqSjB/lkLTerx71WKRIIw0bWLOuX8m2+DM+SuUBOm3qtyRlJA
         lxEQN2H3xQnaWYOOQTUIguQnGzf7lPEf1BClBMAl2/Tvnx+oI8LKaxDk5GrsU8S+PdYG
         H0/qpa7ySL4PdLcyTJXKHyY78J880bguttepswZEc4aMKPjF0xBDrOS68b4UHvYepqPZ
         YApjA99f4kkYmceu5pzquQeHpBLwvZ5oUq2ULezF4xURlg++xZP3GJ1thic7XqRg4YXO
         kLGw==
X-Gm-Message-State: AHQUAubtH119cMhuqdGxK6TAZ6FB6QJnHnmCe1hehyPY1k0dKWmpwG7x
        uLCFBXbrXbKesnVgQAkLy/gM5eFofxkudm1J7OeGw66KROQG
X-Google-Smtp-Source: AHgI3IZ9weZbif3KbgtO1QaBazEm+cxJ8sNajAAYfTbEVD3Jv3YTXhu1NKZGpJRk5wI15NkZLfPYP1ghUWkHvZ2jNzS3GjRBWswl
MIME-Version: 1.0
X-Received: by 2002:a5d:914f:: with SMTP id y15mr12331802ioq.18.1550760243382;
 Thu, 21 Feb 2019 06:44:03 -0800 (PST)
Date:   Thu, 21 Feb 2019 06:44:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007056430582688164@google.com>
Subject: WARNING in cleanup_mnt
From:   syzbot <syzbot+3f12aa66b747ba56fcae@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    48b161983ae5 Merge tag 'xarray-5.0-rc3' of git://git.infra..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10cc68ef400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=505743eba4e4f68
dashboard link: https://syzkaller.appspot.com/bug?extid=3f12aa66b747ba56fcae
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+3f12aa66b747ba56fcae@syzkaller.appspotmail.com

Enabling of bearer <udp:syz0> rejected, already enabled
WARNING: CPU: 0 PID: 17831 at fs/namespace.c:1091 cleanup_mnt+0x118/0x160  
fs/namespace.c:1091
Kernel panic - not syncing: panic_on_warn set ...
Enabling of bearer <udp:syz0> rejected, already enabled
CPU: 0 PID: 17831 Comm: kworker/0:1 Not tainted 5.0.0-rc3+ #37
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events proc_cleanup_work
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1db/0x2d0 lib/dump_stack.c:113
  panic+0x2cb/0x65c kernel/panic.c:214
kobject: 'loop4' (00000000cd062423): kobject_uevent_env
  __warn.cold+0x20/0x48 kernel/panic.c:571
  report_bug+0x263/0x2b0 lib/bug.c:186
kobject: 'loop4' (00000000cd062423): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
  fixup_bug arch/x86/kernel/traps.c:178 [inline]
  fixup_bug arch/x86/kernel/traps.c:173 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:271
  do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:290
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:973
RIP: 0010:cleanup_mnt+0x118/0x160 fs/namespace.c:1091
Code: 1c 01 00 00 48 c7 c7 c0 c9 a5 89 e8 12 4e 11 06 48 8d 7b 38 48 c7 c6  
a0 0f db 81 e8 e2 77 91 ff 5b 41 5c 5d c3 e8 a8 dc a6 ff <0f> 0b e9 0e ff  
ff ff e8 9c dc a6 ff 48 89 df e8 94 fe 06 00 e9 31
RSP: 0018:ffff8880586b7888 EFLAGS: 00010293
RAX: ffff88809f4b4140 RBX: ffff8880909c3a00 RCX: ffffffff81db2334
RDX: 0000000000000000 RSI: ffffffff81db2428 RDI: 0000000000000005
RBP: ffff8880586b7898 R08: ffff88809f4b4140 R09: fffffbfff13024e6
R10: fffffbfff13024e5 R11: ffffffff8981272b R12: 00000000000000fc
R13: 0000000000004000 R14: dffffc0000000000 R15: ffff8880909c3a30
  mntput_no_expire fs/namespace.c:1175 [inline]
  mntput_no_expire+0x866/0xbd0 fs/namespace.c:1117
kobject: 'loop2' (00000000d5abe9f2): kobject_uevent_env
kobject: 'loop2' (00000000d5abe9f2): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
  mntput fs/namespace.c:1185 [inline]
  create_mnt_ns fs/namespace.c:3005 [inline]
  kern_unmount+0xbd/0xf0 fs/namespace.c:2995
  pid_ns_release_proc+0x37/0x41 fs/proc/root.c:224
  proc_cleanup_work+0x19/0x20 kernel/pid_namespace.c:64
Enabling of bearer <udp:syz0> rejected, already enabled
  process_one_work+0xd0c/0x1ce0 kernel/workqueue.c:2153
Enabling of bearer <udp:syz0> rejected, already enabled
  worker_thread+0x143/0x14a0 kernel/workqueue.c:2296
  kthread+0x357/0x430 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
