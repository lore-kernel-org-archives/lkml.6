Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_DIGITS,
	FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA1FC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 22:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C6C22086A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 22:09:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C6C22086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729795AbeKQIXP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 03:23:15 -0500
Received: from mail-it1-f200.google.com ([209.85.166.200]:60344 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728110AbeKQIXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 03:23:14 -0500
Received: by mail-it1-f200.google.com with SMTP id 66-v6so27695itz.9
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 14:09:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=BqGwivBAeUjZXPf9XmWfeAN0CAqV0uKi5QbycI5xRyw=;
        b=uJVNXzbcSfUJp4au6cJeIK0QZk3ekVOVV5myV+kI4U0POD2+VmxKQidyoOmgqaRe/z
         VLhnTCGp4dnQQhYGupxSWc2twxWXvIgrK1jgcAhZ8AadG4mJkf7kxjXtCZmDPGW9qujT
         jlyo6E7kn2rwWbzsJG/cXB3IBDDavLmZz4Ps7xBun2JUSJv8TKwIgxne/1Xvr/PUc3/K
         PS3cPtiFU3RtJ+ix6CWyw2xneQsW1gvZ3BlFUhUCSn15iF9Ku5P3yUc+nSE0Aw7IRJ4v
         v7droIcI2e06CFkBHfs/0f/LqB2IF3Glq0gPaxzzygeNG8zyrelSTtGni5j69EGHFAFO
         Abiw==
X-Gm-Message-State: AGRZ1gIibc0IZApRe+K558C04u3EFT78z5vjK2mFowUyK9KO7zh9ZDNq
        pBH0G839rElOMDZALnauVius5hWyn+bvX3pLYAe8gvzyMLtb
X-Google-Smtp-Source: AJdET5cx4i4DRz8/WmVpCFggLtMTbTXwKcAEHHybQI0J9sIAFvWcFP50fkN8e5u7ehch6/j7DrR4SUnrHo0MVWzva6mm9mkqn5Tj
MIME-Version: 1.0
X-Received: by 2002:a02:9952:: with SMTP id d18-v6mr4948332jak.19.1542406144405;
 Fri, 16 Nov 2018 14:09:04 -0800 (PST)
Date:   Fri, 16 Nov 2018 14:09:04 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000563bb6057acf6ac5@google.com>
Subject: WARNING in fuse_destroy_inode
From:   syzbot <syzbot+b9c89b84423073226299@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    da5322e65940 Merge tag 'selinux-pr-20181115' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11a5bb0b400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d86f24333880b605
dashboard link: https://syzkaller.appspot.com/bug?extid=b9c89b84423073226299
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=157b5f7b400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12ac8ed5400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+b9c89b84423073226299@syzkaller.appspotmail.com

audit: type=1800 audit(1542387310.926:30): pid=5882 uid=0 auid=4294967295  
ses=4294967295 subj==unconfined op=collect_data cause=failed(directio)  
comm="startpar" name="rmnologin" dev="sda1" ino=2423 res=0
sshd (6020) used greatest stack depth: 15744 bytes left
IPVS: ftp: loaded support on port[0] = 21
WARNING: CPU: 0 PID: 6039 at fs/fuse/inode.c:119  
fuse_destroy_inode+0x251/0x2c0 fs/fuse/inode.c:119
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 6039 Comm: syz-executor459 Not tainted 4.20.0-rc2+ #337
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x39d lib/dump_stack.c:113
  panic+0x2ad/0x55c kernel/panic.c:188
  __warn.cold.8+0x20/0x45 kernel/panic.c:540
  report_bug+0x254/0x2d0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:178 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:271
  do_invalid_op+0x36/0x40 arch/x86/kernel/traps.c:290
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:969
RIP: 0010:fuse_destroy_inode+0x251/0x2c0 fs/fuse/inode.c:119
Code: 41 c6 44 15 00 f8 0f 84 8c fe ff ff e8 c8 f2 f2 fe 0f 0b e9 80 fe ff  
ff 48 89 df e8 b9 3f 36 ff e9 50 fe ff ff e8 af f2 f2 fe <0f> 0b e9 6a ff  
ff ff e8 e3 3f 36 ff e9 90 fe ff ff e8 29 5a bc fe
RSP: 0018:ffff8881c0b76818 EFLAGS: 00010293
RAX: ffff8881c435c700 RBX: ffff8881b19bb5c0 RCX: 1ffff1103816ed08
RDX: 0000000000000000 RSI: ffffffff828c9531 RDI: 0000000000000003
RBP: ffff8881c0b768e8 R08: ffff8881c435c700 R09: 0000000000000008
R10: 0000000000000002 R11: ffff8881c435c700 R12: 1ffff1103816ed04
R13: 1ffff1103816ed08 R14: ffff8881c0b768c0 R15: ffff8881b19bb998
  destroy_inode+0x159/0x200 fs/inode.c:267
  evict+0x5e0/0x980 fs/inode.c:575
  iput_final fs/inode.c:1547 [inline]
  iput+0x679/0xa90 fs/inode.c:1573
  dentry_unlink_inode+0x461/0x5e0 fs/dcache.c:360
  __dentry_kill+0x44c/0x7a0 fs/dcache.c:552
  dentry_kill+0xc9/0x680 fs/dcache.c:671
  dput.part.25+0x660/0x860 fs/dcache.c:832
  dput fs/dcache.c:815 [inline]
  do_one_tree+0x37/0x40 fs/dcache.c:1515
  shrink_dcache_for_umount+0xc7/0x2b0 fs/dcache.c:1529
  generic_shutdown_super+0xd5/0x530 fs/super.c:441
  kill_anon_super+0x3e/0x60 fs/super.c:1032
  fuse_kill_sb_anon+0x1d/0x20 fs/fuse/inode.c:1256
  deactivate_locked_super+0x97/0x100 fs/super.c:329
  deactivate_super+0x2bb/0x320 fs/super.c:360
  cleanup_mnt+0xbf/0x160 fs/namespace.c:1098
  __cleanup_mnt+0x16/0x20 fs/namespace.c:1105
  task_work_run+0x1e8/0x2a0 kernel/task_work.c:113
  exit_task_work include/linux/task_work.h:22 [inline]
  do_exit+0x1ad6/0x26d0 kernel/exit.c:867
  do_group_exit+0x177/0x440 kernel/exit.c:970
  get_signal+0x8b0/0x1980 kernel/signal.c:2517
  do_signal+0x9c/0x21c0 arch/x86/kernel/signal.c:816
  exit_to_usermode_loop+0x2e5/0x380 arch/x86/entry/common.c:162
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x445f79
Code: Bad RIP value.
RSP: 002b:00007f081109ada8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 00000000006dbc38 RCX: 0000000000445f79
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00000000006dbc38
RBP: 00000000006dbc30 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dbc3c
R13: 2f30656c69662f2e R14: 0000000100000001 R15: 0000000000000001
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
