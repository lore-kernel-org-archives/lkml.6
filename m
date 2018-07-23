Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 059F4ECDFBB
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 17:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1B8C20893
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 17:30:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1B8C20893
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388254AbeGWScS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 14:32:18 -0400
Received: from mail-io0-f199.google.com ([209.85.223.199]:45826 "EHLO
        mail-io0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388032AbeGWScR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 14:32:17 -0400
Received: by mail-io0-f199.google.com with SMTP id l24-v6so833039ioj.12
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 10:30:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=VfvmFzwi+vfqKd0No8rUS1zv2DnvvagXBKc6uAhlveg=;
        b=PusAeUqAd/SZeK6ByQu/LpHNDfnXFXSUUEMe46VQl529Ek2pgIwC+QpAWlRyBXabMA
         XBKR4x/bYno8iXYreEtk6rT3SIALRg4umP7+LFWoBlRzIOuM7dX2kB6mgGmBEDRNMleu
         cZ1jjliJdlBnVp4DFxmPFxYH2po/7uIov+0C3U7117PZtPGLVd5n+/GiuWSAJW5Itnhh
         L6imaOEttXmDrsJ9QdwgZ1sCoBSgloicNSkd1nz70BMUM8BvgfDUa69ef+HN+X+6d+1Y
         RX9UbWu5jaFumOjQpYFLdfjkyKgdWqdIy9eQ46CPpWP4NrpCZc67+GyjXu4wScKr9FLV
         B0wA==
X-Gm-Message-State: AOUpUlGG8iDEjtbSdp1zY6wYi/O6AQtX/Nmdb1UJk0j+W+8ivi0WLs63
        J/ASJkFnJKwG80Nko1/OjCKEfBSjt0LJ/rCgs9L70VSSCba6
X-Google-Smtp-Source: AAOMgpd55CjAzM2oPz8XmYbKWCBVQk4+k1rNQeJs4Vajx3KS7Ev5saprT99kKRxy6CR+41vOpsunS565l/K43ATM7rncTYWZa01k
MIME-Version: 1.0
X-Received: by 2002:a24:27c8:: with SMTP id g191-v6mr6474918ita.20.1532367001890;
 Mon, 23 Jul 2018 10:30:01 -0700 (PDT)
Date:   Mon, 23 Jul 2018 10:30:01 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d03eea0571adfe83@google.com>
Subject: possible deadlock in mnt_want_write
From:   syzbot <syzbot+ae82084b07d0297e566b@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    45ae4df92207 Merge tag 'armsoc-fixes' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10e7eee0400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c0bdc4175608181c
dashboard link: https://syzkaller.appspot.com/bug?extid=ae82084b07d0297e566b
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+ae82084b07d0297e566b@syzkaller.appspotmail.com

device bridge_slave_0 left promiscuous mode
bridge0: port 1(bridge_slave_0) entered disabled state
IPVS: set_ctl: invalid protocol: 255 0.0.0.0:20004

======================================================
WARNING: possible circular locking dependency detected
4.18.0-rc5+ #159 Not tainted
------------------------------------------------------
syz-executor7/24660 is trying to acquire lock:
000000007bd46ec8 (sb_writers#15){.+.+}, at: sb_start_write  
include/linux/fs.h:1554 [inline]
000000007bd46ec8 (sb_writers#15){.+.+}, at: mnt_want_write+0x3f/0xc0  
fs/namespace.c:386

but task is already holding lock:
00000000a4a13f7a (&fi->mutex){+.+.}, at: fuse_lock_inode+0xaf/0xe0  
fs/fuse/inode.c:363

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&fi->mutex){+.+.}:
        __mutex_lock_common kernel/locking/mutex.c:757 [inline]
        __mutex_lock+0x176/0x1820 kernel/locking/mutex.c:894
        mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:909
        fuse_lock_inode+0xaf/0xe0 fs/fuse/inode.c:363
        fuse_lookup+0x8f/0x4c0 fs/fuse/dir.c:359
        __lookup_hash+0x12e/0x190 fs/namei.c:1505
        filename_create+0x1e5/0x5b0 fs/namei.c:3646
        user_path_create fs/namei.c:3703 [inline]
        do_mkdirat+0xda/0x310 fs/namei.c:3842
        __do_sys_mkdirat fs/namei.c:3861 [inline]
        __se_sys_mkdirat fs/namei.c:3859 [inline]
        __x64_sys_mkdirat+0x76/0xb0 fs/namei.c:3859
        do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #1 (&type->i_mutex_dir_key#5/1){+.+.}:
        down_write_nested+0x93/0x130 kernel/locking/rwsem.c:192
        inode_lock_nested include/linux/fs.h:750 [inline]
        filename_create+0x1b2/0x5b0 fs/namei.c:3645
        user_path_create fs/namei.c:3703 [inline]
        do_mkdirat+0xda/0x310 fs/namei.c:3842
        __do_sys_mkdirat fs/namei.c:3861 [inline]
        __se_sys_mkdirat fs/namei.c:3859 [inline]
        __x64_sys_mkdirat+0x76/0xb0 fs/namei.c:3859
nla_parse: 14 callbacks suppressed
netlink: 3 bytes leftover after parsing attributes in process  
`syz-executor1'.
        do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #0 (sb_writers#15){.+.+}:
        lock_acquire+0x1e4/0x540 kernel/locking/lockdep.c:3924
        percpu_down_read_preempt_disable include/linux/percpu-rwsem.h:36  
[inline]
        percpu_down_read include/linux/percpu-rwsem.h:59 [inline]
        __sb_start_write+0x1e9/0x300 fs/super.c:1403
        sb_start_write include/linux/fs.h:1554 [inline]
        mnt_want_write+0x3f/0xc0 fs/namespace.c:386
        path_removexattr+0xf0/0x210 fs/xattr.c:703
        __do_sys_removexattr fs/xattr.c:719 [inline]
        __se_sys_removexattr fs/xattr.c:716 [inline]
        __x64_sys_removexattr+0x59/0x80 fs/xattr.c:716
        do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

other info that might help us debug this:

Chain exists of:
   sb_writers#15 --> &type->i_mutex_dir_key#5/1 --> &fi->mutex

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(&fi->mutex);
                                lock(&type->i_mutex_dir_key#5/1);
                                lock(&fi->mutex);
   lock(sb_writers#15);

  *** DEADLOCK ***

1 lock held by syz-executor7/24660:
  #0: 00000000a4a13f7a (&fi->mutex){+.+.}, at: fuse_lock_inode+0xaf/0xe0  
fs/fuse/inode.c:363

stack backtrace:
CPU: 1 PID: 24660 Comm: syz-executor7 Not tainted 4.18.0-rc5+ #159
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
  print_circular_bug.isra.36.cold.57+0x1bd/0x27d  
kernel/locking/lockdep.c:1227
  check_prev_add kernel/locking/lockdep.c:1867 [inline]
  check_prevs_add kernel/locking/lockdep.c:1980 [inline]
  validate_chain kernel/locking/lockdep.c:2421 [inline]
  __lock_acquire+0x3449/0x5020 kernel/locking/lockdep.c:3435
  lock_acquire+0x1e4/0x540 kernel/locking/lockdep.c:3924
  percpu_down_read_preempt_disable include/linux/percpu-rwsem.h:36 [inline]
  percpu_down_read include/linux/percpu-rwsem.h:59 [inline]
  __sb_start_write+0x1e9/0x300 fs/super.c:1403
  sb_start_write include/linux/fs.h:1554 [inline]
  mnt_want_write+0x3f/0xc0 fs/namespace.c:386
  path_removexattr+0xf0/0x210 fs/xattr.c:703
  __do_sys_removexattr fs/xattr.c:719 [inline]
  __se_sys_removexattr fs/xattr.c:716 [inline]
  __x64_sys_removexattr+0x59/0x80 fs/xattr.c:716
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x455ab9
Code: 1d ba fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 eb b9 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fee4a211c68 EFLAGS: 00000246 ORIG_RAX: 00000000000000c5
RAX: ffffffffffffffda RBX: 00007fee4a2126d4 RCX: 0000000000455ab9
RDX: 0000000000000000 RSI: 0000000020000080 RDI: 0000000020000040
RBP: 000000000072bea0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000004bbc1c R14: 00000000004d0f48 R15: 0000000000000000
team0 (unregistering): Port device team_slave_1 removed
team0 (unregistering): Port device team_slave_0 removed
bond0 (unregistering): Releasing backup interface bond_slave_1
bond0 (unregistering): Releasing backup interface bond_slave_0
bond0 (unregistering): Released all slaves
netlink: 3 bytes leftover after parsing attributes in process  
`syz-executor4'.
netlink: 3 bytes leftover after parsing attributes in process  
`syz-executor3'.
netlink: 3 bytes leftover after parsing attributes in process  
`syz-executor1'.
netlink: 3 bytes leftover after parsing attributes in process  
`syz-executor2'.
netlink: 3 bytes leftover after parsing attributes in process  
`syz-executor4'.
netlink: 3 bytes leftover after parsing attributes in process  
`syz-executor2'.
netlink: 3 bytes leftover after parsing attributes in process  
`syz-executor1'.
netlink: 3 bytes leftover after parsing attributes in process  
`syz-executor4'.
netlink: 3 bytes leftover after parsing attributes in process  
`syz-executor2'.
nla_parse: 16 callbacks suppressed
netlink: 3 bytes leftover after parsing attributes in process  
`syz-executor4'.
netlink: 3 bytes leftover after parsing attributes in process  
`syz-executor4'.
netlink: 3 bytes leftover after parsing attributes in process  
`syz-executor4'.


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
