Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 967B0C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 04:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15CBC208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 04:47:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15CBC208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbeJRMqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 08:46:08 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:46803 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727368AbeJRMqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 08:46:08 -0400
Received: by mail-io1-f70.google.com with SMTP id l4-v6so27184828iog.13
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 21:47:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=zgu7sr5HyTdzFho8P603Ud/JlxsjS8206giD/MqmFyU=;
        b=FcXipcMtWPBaG1nZrxgfveG3G1Xa3M8yjejQ9+vKzonf/rbKAl/4yAoj+BsjBGlzcr
         XT9K6Ff5xtFYZg6mmcKc+bgmrl3nwaM4KzkzMiTjDnqnfqLvf/+n0tHgh361NJWBDLgs
         NOMKf1vRgQKWQYBt3DOsepxTAHurHj/oPZGAvyOOjc6ut7KT3pYiViZjyGvxJXhR3EK5
         JTiS9Cw4yIS7ylvjxohPIib0xMj8rstkj7A5ndwqvq6zknlQvTy9Qd1zG+KuQCdSA9eu
         FTbOQxzRP8LSE6vxU6pc+Atpr5/Md3BWQ7CDlD2BWNSjGb8iLPbdWT/LcC57Z/ynLT6i
         vD1Q==
X-Gm-Message-State: AGRZ1gL6X2h3uv856WuzBkzfT3MhAE+J9sGJ0kCySESeqcppA6hh9Iry
        OtbT7iWSJ5EtcQ5v2jgzTAmiXWXD21TQje9kldpproQ/jmzx
X-Google-Smtp-Source: ACcGV61reHU3FBo0sdNoP51TZeA3fTLia5jDhoOH/qHlhlczlwIc4GgSICUJLWj2QjVfXEYErxvZKRCfLujBBXp+1QsPKBgzeqQS
MIME-Version: 1.0
X-Received: by 2002:a24:e001:: with SMTP id c1-v6mr3945307ith.7.1539838022519;
 Wed, 17 Oct 2018 21:47:02 -0700 (PDT)
Date:   Wed, 17 Oct 2018 21:47:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000058404b0578797a9d@google.com>
Subject: possible deadlock in ovl_copy_up_start
From:   syzbot <syzbot+3ef5c0d1a5cb0b21e6be@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    c343db455eb3 Merge branch 'parisc-4.19-3' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=167d08ee400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b3f55cb3dfcc6c33
dashboard link: https://syzkaller.appspot.com/bug?extid=3ef5c0d1a5cb0b21e6be
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+3ef5c0d1a5cb0b21e6be@syzkaller.appspotmail.com

overlayfs: filesystem on './file0' not supported as upperdir
XFS (loop3): unknown mount option [uid<00000000000000000000].

kobject: 'loop2' (00000000ce85f3f9): kobject_uevent_env
============================================
WARNING: possible recursive locking detected
kobject: 'loop2' (00000000ce85f3f9): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
4.19.0-rc8+ #65 Not tainted
--------------------------------------------
syz-executor2/8184 is trying to acquire lock:
00000000d7157f3f (&ovl_i_lock_key[depth]){+.+.}, at:  
ovl_copy_up_start+0x9c/0x2e0 fs/overlayfs/util.c:528

but task is already holding lock:
000000006f802695 (&ovl_i_lock_key[depth]){+.+.}, at:  
ovl_nlink_start+0xe0/0x350 fs/overlayfs/util.c:771

other info that might help us debug this:
  Possible unsafe locking scenario:

        CPU0
        ----
   lock(&ovl_i_lock_key[depth]);
   lock(&ovl_i_lock_key[depth]);

  *** DEADLOCK ***

  May be due to missing lock nesting notation

5 locks held by syz-executor2/8184:
  #0: 0000000075695ecf (sb_writers#17){.+.+}, at: sb_start_write  
include/linux/fs.h:1566 [inline]
  #0: 0000000075695ecf (sb_writers#17){.+.+}, at: mnt_want_write+0x3f/0xc0  
fs/namespace.c:360
  #1: 00000000ee99eb71 (&ovl_i_mutex_dir_key[depth]/1){+.+.}, at:  
inode_lock_nested include/linux/fs.h:773 [inline]
  #1: 00000000ee99eb71 (&ovl_i_mutex_dir_key[depth]/1){+.+.}, at:  
filename_create+0x1b2/0x5b0 fs/namei.c:3635
  #2: 0000000065f3eeeb (&ovl_i_mutex_key[depth]){+.+.}, at: inode_lock  
include/linux/fs.h:738 [inline]
  #2: 0000000065f3eeeb (&ovl_i_mutex_key[depth]){+.+.}, at:  
vfs_link+0x543/0xb70 fs/namei.c:4232
  #3: 000000008b285486 (sb_writers#3){.+.+}, at: sb_start_write  
include/linux/fs.h:1566 [inline]
  #3: 000000008b285486 (sb_writers#3){.+.+}, at: mnt_want_write+0x3f/0xc0  
fs/namespace.c:360
  #4: 000000006f802695 (&ovl_i_lock_key[depth]){+.+.}, at:  
ovl_nlink_start+0xe0/0x350 fs/overlayfs/util.c:771

stack backtrace:
CPU: 1 PID: 8184 Comm: syz-executor2 Not tainted 4.19.0-rc8+ #65
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c4/0x2b4 lib/dump_stack.c:113
  print_deadlock_bug kernel/locking/lockdep.c:1759 [inline]
  check_deadlock kernel/locking/lockdep.c:1803 [inline]
  validate_chain kernel/locking/lockdep.c:2399 [inline]
  __lock_acquire.cold.61+0x1fb/0x482 kernel/locking/lockdep.c:3411
  lock_acquire+0x1ed/0x520 kernel/locking/lockdep.c:3900
  __mutex_lock_common kernel/locking/mutex.c:925 [inline]
  __mutex_lock+0x166/0x1700 kernel/locking/mutex.c:1072
  mutex_lock_interruptible_nested+0x16/0x20 kernel/locking/mutex.c:1109
  ovl_copy_up_start+0x9c/0x2e0 fs/overlayfs/util.c:528
  ovl_copy_up_one+0x51f/0x1970 fs/overlayfs/copy_up.c:775
  ovl_copy_up_flags+0x14e/0x1d0 fs/overlayfs/copy_up.c:827
  ovl_copy_up+0x17/0x1a fs/overlayfs/copy_up.c:874
  ovl_create_or_link+0xc7/0x1450 fs/overlayfs/dir.c:543
  ovl_link+0x28b/0x37c fs/overlayfs/dir.c:679
  vfs_link+0x7a9/0xb70 fs/namei.c:4241
  do_linkat+0x724/0xa90 fs/namei.c:4309
  __do_sys_linkat fs/namei.c:4333 [inline]
  __se_sys_linkat fs/namei.c:4330 [inline]
  __x64_sys_linkat+0xbe/0x150 fs/namei.c:4330
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457569
Code: fd b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f8ab8a13c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000109
RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 0000000000457569
RDX: 000000000000000f RSI: 0000000020000200 RDI: 000000000000000f
RBP: 000000000072c040 R08: 0000000000000400 R09: 0000000000000000
R10: 0000000020000180 R11: 0000000000000246 R12: 00007f8ab8a146d4
R13: 00000000004c31d1 R14: 00000000004d3840 R15: 00000000ffffffff
kobject: 'bluetooth' (00000000bd8be530): kobject_add_internal:  
parent: 'virtual', set: '(null)'
kobject: 'loop3' (000000007c159c39): kobject_uevent_env
kobject: 'kvm' (000000003101062f): kobject_uevent_env
kobject: 'loop3' (000000007c159c39): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'hci0' (000000006b48ee74): kobject_add_internal:  
parent: 'bluetooth', set: 'devices'
kobject: 'kvm' (000000003101062f): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
block nbd0: Device being setup by another task
kobject: 'hci0' (000000006b48ee74): kobject_uevent_env
kobject: 'hci0' (000000006b48ee74): fill_kobj_path: path  
= '/devices/virtual/bluetooth/hci0'
kobject: 'rx-0' (000000001d4618b6): kobject_cleanup, parent 000000005fa09179
kobject: 'rx-0' (000000001d4618b6): auto cleanup 'remove' event
kobject: 'rx-0' (000000001d4618b6): kobject_uevent_env
kobject: 'rfkill6' (0000000056a17cad): kobject_add_internal:  
parent: 'hci0', set: 'devices'
kobject: 'rx-0' (000000001d4618b6): fill_kobj_path: path  
= '/devices/virtual/net/bctf0/queues/rx-0'
kobject: 'loop3' (000000007c159c39): kobject_uevent_env
kobject: 'kvm' (000000003101062f): kobject_uevent_env
kobject: 'rx-0' (000000001d4618b6): auto cleanup kobject_del
kobject: 'kvm' (000000003101062f): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'rfkill6' (0000000056a17cad): kobject_uevent_env
kobject: 'rx-0' (000000001d4618b6): calling ktype release
kobject: 'rfkill6' (0000000056a17cad): fill_kobj_path: path  
= '/devices/virtual/bluetooth/hci0/rfkill6'
kobject: 'loop4' (000000002f2c99c3): kobject_uevent_env
kobject: 'loop3' (000000007c159c39): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'hci1' (0000000016b5c913): kobject_add_internal:  
parent: 'bluetooth', set: 'devices'
kobject: 'rx-0': free name
kobject: 'hci1' (0000000016b5c913): kobject_uevent_env
XFS (loop3): unknown mount option [uid<00000000000000000000].
kobject: 'tx-0' (00000000da13c238): kobject_cleanup, parent 000000005fa09179
kobject: 'hci1' (0000000016b5c913): fill_kobj_path: path  
= '/devices/virtual/bluetooth/hci1'
kobject: 'loop4' (000000002f2c99c3): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'tx-0' (00000000da13c238): auto cleanup 'remove' event
kobject: 'rfkill7' (000000009dd6f842): kobject_add_internal:  
parent: 'hci1', set: 'devices'
kobject: 'loop0' (00000000f1223470): kobject_uevent_env
kobject: 'loop3' (000000007c159c39): kobject_uevent_env
kobject: 'tx-0' (00000000da13c238): kobject_uevent_env
kobject: 'loop3' (000000007c159c39): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop0' (00000000f1223470): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'rfkill7' (000000009dd6f842): kobject_uevent_env
kobject: 'rfkill7' (000000009dd6f842): fill_kobj_path: path  
= '/devices/virtual/bluetooth/hci1/rfkill7'
kobject: 'tx-0' (00000000da13c238): fill_kobj_path: path  
= '/devices/virtual/net/bctf0/queues/tx-0'
block nbd0: shutting down sockets
kobject: 'tx-0' (00000000da13c238): auto cleanup kobject_del
kobject: 'kvm' (000000003101062f): kobject_uevent_env
kobject: 'tx-0' (00000000da13c238): calling ktype release
kobject: 'tx-0': free name
kobject: 'loop1' (0000000090b2e742): kobject_uevent_env
kobject: 'kvm' (000000003101062f): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop1' (0000000090b2e742): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'queues' (000000005fa09179): kobject_cleanup, parent            
(null)
kobject: 'loop0' (00000000f1223470): kobject_uevent_env
kobject: 'queues' (000000005fa09179): calling ktype release
kobject: 'loop0' (00000000f1223470): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'queues' (000000005fa09179): kset_release
kobject: 'loop3' (000000007c159c39): kobject_uevent_env
kobject: 'queues': free name
kobject: 'loop3' (000000007c159c39): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'bctf0' (0000000013317453): kobject_uevent_env
kobject: 'loop5' (00000000b77ceb3f): kobject_uevent_env
kobject: 'bctf0' (0000000013317453): fill_kobj_path: path  
= '/devices/virtual/net/bctf0'
kobject: 'loop5' (00000000b77ceb3f): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop4' (000000002f2c99c3): kobject_uevent_env
kobject: 'bctf0' (0000000013317453): kobject_cleanup, parent            
(null)
kobject: 'bctf0' (0000000013317453): calling ktype release
kobject: 'loop4' (000000002f2c99c3): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'bctf0': free name
kobject: 'kvm' (000000003101062f): kobject_uevent_env
kobject: 'kvm' (000000003101062f): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
block nbd0: Receive control failed (result -22)
kobject: 'nbd0' (0000000041cd8979): kobject_uevent_env
kobject: 'nbd0' (0000000041cd8979): fill_kobj_path: path  
= '/devices/virtual/block/nbd0'
kobject: 'loop2' (00000000ce85f3f9): kobject_uevent_env
kobject: 'loop2' (00000000ce85f3f9): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop5' (00000000b77ceb3f): kobject_uevent_env
block nbd0: Device being setup by another task
kobject: 'loop5' (00000000b77ceb3f): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop3' (000000007c159c39): kobject_uevent_env
kobject: 'loop4' (000000002f2c99c3): kobject_uevent_env
XFS (loop5): unknown mount option [uid<00000000000000000000].
kobject: 'loop3' (000000007c159c39): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'kvm' (000000003101062f): kobject_uevent_env
XFS (loop3): unknown mount option [uid<00000000000000000000].
kobject: 'loop4' (000000002f2c99c3): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'bctf0' (00000000e58f73c6): kobject_add_internal: parent: 'net',  
set: 'devices'
kobject: 'loop0' (00000000f1223470): kobject_uevent_env
kobject: 'bctf0' (00000000e58f73c6): kobject_uevent_env
kobject: 'kvm' (000000003101062f): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'bctf0' (00000000e58f73c6): fill_kobj_path: path  
= '/devices/virtual/net/bctf0'
kobject: 'loop5' (00000000b77ceb3f): kobject_uevent_env
kobject: 'loop0' (00000000f1223470): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'queues' (0000000086dffe89): kobject_add_internal:  
parent: 'bctf0', set: '<NULL>'
kobject: 'loop0' (00000000f1223470): kobject_uevent_env
kobject: 'loop3' (000000007c159c39): kobject_uevent_env
kobject: 'loop5' (00000000b77ceb3f): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop0' (00000000f1223470): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop3' (000000007c159c39): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop4' (000000002f2c99c3): kobject_uevent_env
kobject: 'queues' (0000000086dffe89): kobject_uevent_env
kobject: 'loop4' (000000002f2c99c3): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'queues' (0000000086dffe89): kobject_uevent_env: filter function  
caused the event to drop!
kobject: 'loop1' (0000000090b2e742): kobject_uevent_env
kobject: 'rx-0' (00000000e092e8c7): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'loop1' (0000000090b2e742): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
block nbd0: shutting down sockets
kobject: 'loop5' (00000000b77ceb3f): kobject_uevent_env
kobject: 'rx-0' (00000000e092e8c7): kobject_uevent_env
kobject: 'loop5' (00000000b77ceb3f): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop0' (00000000f1223470): kobject_uevent_env
kobject: 'loop0' (00000000f1223470): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop3' (000000007c159c39): kobject_uevent_env
kobject: 'rx-0' (00000000e092e8c7): fill_kobj_path: path  
= '/devices/virtual/net/bctf0/queues/rx-0'
kobject: 'loop3' (000000007c159c39): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop1' (0000000090b2e742): kobject_uevent_env
kobject: 'loop1' (0000000090b2e742): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop4' (000000002f2c99c3): kobject_uevent_env
kobject: 'tx-0' (000000006e07a5f0): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'loop4' (000000002f2c99c3): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop2' (00000000ce85f3f9): kobject_uevent_env
kobject: 'loop0' (00000000f1223470): kobject_uevent_env
kobject: 'tx-0' (000000006e07a5f0): kobject_uevent_env
kobject: 'loop0' (00000000f1223470): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
overlayfs: failed to resolve './file1': -2
kobject: 'loop2' (00000000ce85f3f9): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'tx-0' (000000006e07a5f0): fill_kobj_path: path  
= '/devices/virtual/net/bctf0/queues/tx-0'
ntfs: (device loop2): parse_options(): Unrecognized mount  
option ./file0/file0.
kobject: 'loop2' (00000000ce85f3f9): kobject_uevent_env
kobject: 'loop2' (00000000ce85f3f9): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'rx-0' (00000000e092e8c7): kobject_cleanup, parent 0000000086dffe89
kobject: 'rx-0' (00000000e092e8c7): auto cleanup 'remove' event
kobject: 'rx-0' (00000000e092e8c7): kobject_uevent_env
kobject: 'rx-0' (00000000e092e8c7): fill_kobj_path: path  
= '/devices/virtual/net/bctf0/queues/rx-0'
kobject: 'rx-0' (00000000e092e8c7): auto cleanup kobject_del
kobject: 'rx-0' (00000000e092e8c7): calling ktype release
kobject: 'rx-0': free name
kobject: 'tx-0' (000000006e07a5f0): kobject_cleanup, parent 0000000086dffe89
kobject: 'tx-0' (000000006e07a5f0): auto cleanup 'remove' event
kobject: 'tx-0' (000000006e07a5f0): kobject_uevent_env
kobject: 'tx-0' (000000006e07a5f0): fill_kobj_path: path  
= '/devices/virtual/net/bctf0/queues/tx-0'
kobject: 'tx-0' (000000006e07a5f0): auto cleanup kobject_del
kobject: 'tx-0' (000000006e07a5f0): calling ktype release
kobject: 'tx-0': free name
kobject: 'queues' (0000000086dffe89): kobject_cleanup, parent            
(null)
kobject: 'queues' (0000000086dffe89): calling ktype release
kobject: 'queues' (0000000086dffe89): kset_release
kobject: 'queues': free name
kobject: 'bctf0' (00000000e58f73c6): kobject_uevent_env
kobject: 'bctf0' (00000000e58f73c6): fill_kobj_path: path  
= '/devices/virtual/net/bctf0'
kobject: 'bctf0' (00000000e58f73c6): kobject_cleanup, parent            
(null)
kobject: 'bctf0' (00000000e58f73c6): calling ktype release
kobject: 'bctf0': free name
kobject: 'loop2' (00000000ce85f3f9): kobject_uevent_env
kobject: 'loop2' (00000000ce85f3f9): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'bctf0' (00000000424d23a2): kobject_add_internal: parent: 'net',  
set: 'devices'
kobject: 'loop5' (00000000b77ceb3f): kobject_uevent_env
kobject: 'bctf0' (00000000424d23a2): kobject_uevent_env
kobject: 'loop5' (00000000b77ceb3f): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'bctf0' (00000000424d23a2): fill_kobj_path: path  
= '/devices/virtual/net/bctf0'
kobject: 'loop4' (000000002f2c99c3): kobject_uevent_env
kobject: 'loop4' (000000002f2c99c3): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'queues' (00000000cd4e0f1b): kobject_add_internal:  
parent: 'bctf0', set: '<NULL>'
kobject: 'loop0' (00000000f1223470): kobject_uevent_env
kobject: 'loop0' (00000000f1223470): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop1' (0000000090b2e742): kobject_uevent_env
kobject: 'loop2' (00000000ce85f3f9): kobject_uevent_env
kobject: 'queues' (00000000cd4e0f1b): kobject_uevent_env
kobject: 'loop1' (0000000090b2e742): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop2' (00000000ce85f3f9): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
overlayfs: failed to resolve './file1': -2
kobject: 'loop3' (000000007c159c39): kobject_uevent_env
kobject: 'queues' (00000000cd4e0f1b): kobject_uevent_env: filter function  
caused the event to drop!
kobject: 'rx-0' (0000000081b57724): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'loop3' (000000007c159c39): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'rx-0' (0000000081b57724): kobject_uevent_env
kobject: 'loop4' (000000002f2c99c3): kobject_uevent_env
kobject: 'rx-0' (0000000081b57724): fill_kobj_path: path  
= '/devices/virtual/net/bctf0/queues/rx-0'
kobject: 'loop4' (000000002f2c99c3): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'tx-0' (0000000033757d52): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'loop5' (00000000b77ceb3f): kobject_uevent_env
kobject: 'loop2' (00000000ce85f3f9): kobject_uevent_env
kobject: 'loop2' (00000000ce85f3f9): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop5' (00000000b77ceb3f): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'tx-0' (0000000033757d52): kobject_uevent_env
kobject: 'loop1' (0000000090b2e742): kobject_uevent_env
kobject: 'tx-0' (0000000033757d52): fill_kobj_path: path  
= '/devices/virtual/net/bctf0/queues/tx-0'
kobject: 'loop1' (0000000090b2e742): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop3' (000000007c159c39): kobject_uevent_env
kobject: 'loop3' (000000007c159c39): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop0' (00000000f1223470): kobject_uevent_env
kobject: 'loop0' (00000000f1223470): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop2' (00000000ce85f3f9): kobject_uevent_env
kobject: 'loop2' (00000000ce85f3f9): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'rx-0' (0000000081b57724): kobject_cleanup, parent 00000000cd4e0f1b
kobject: 'rx-0' (0000000081b57724): auto cleanup 'remove' event
kobject: 'rx-0' (0000000081b57724): kobject_uevent_env
kobject: 'rx-0' (0000000081b57724): fill_kobj_path: path  
= '/devices/virtual/net/bctf0/queues/rx-0'
kobject: 'rx-0' (0000000081b57724): auto cleanup kobject_del
kobject: 'rx-0' (0000000081b57724): calling ktype release
kobject: 'rx-0': free name
kobject: 'tx-0' (0000000033757d52): kobject_cleanup, parent 00000000cd4e0f1b
kobject: 'tx-0' (0000000033757d52): auto cleanup 'remove' event
kobject: 'tx-0' (0000000033757d52): kobject_uevent_env
kobject: 'tx-0' (0000000033757d52): fill_kobj_path: path  
= '/devices/virtual/net/bctf0/queues/tx-0'
kobject: 'tx-0' (0000000033757d52): auto cleanup kobject_del
kobject: 'tx-0' (0000000033757d52): calling ktype release
kobject: 'tx-0': free name
kobject: 'queues' (00000000cd4e0f1b): kobject_cleanup, parent            
(null)
kobject: 'queues' (00000000cd4e0f1b): calling ktype release
kobject: 'queues' (00000000cd4e0f1b): kset_release
kobject: 'queues': free name
kobject: 'bctf0' (00000000424d23a2): kobject_uevent_env
kobject: 'bctf0' (00000000424d23a2): fill_kobj_path: path  
= '/devices/virtual/net/bctf0'
kobject: 'bctf0' (00000000424d23a2): kobject_cleanup, parent            
(null)
kobject: 'bctf0' (00000000424d23a2): calling ktype release
kobject: 'bctf0': free name
kobject: 'loop2' (00000000ce85f3f9): kobject_uevent_env
kobject: 'loop2' (00000000ce85f3f9): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop5' (00000000b77ceb3f): kobject_uevent_env
kobject: 'loop5' (00000000b77ceb3f): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'bctf0' (000000008c199bcb): kobject_add_internal: parent: 'net',  
set: 'devices'
kobject: 'bctf0' (000000008c199bcb): kobject_uevent_env
kobject: 'bctf0' (000000008c199bcb): fill_kobj_path: path  
= '/devices/virtual/net/bctf0'
kobject: 'queues' (0000000051f0c714): kobject_add_internal:  
parent: 'bctf0', set: '<NULL>'
kobject: 'queues' (0000000051f0c714): kobject_uevent_env
kobject: 'loop5' (00000000b77ceb3f): kobject_uevent_env
kobject: 'loop5' (00000000b77ceb3f): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'queues' (0000000051f0c714): kobject_uevent_env: filter function  
caused the event to drop!
kobject: 'loop1' (0000000090b2e742): kobject_uevent_env
kobject: 'loop1' (0000000090b2e742): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'rx-0' (000000002d5aad68): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'loop0' (00000000f1223470): kobject_uevent_env
kobject: 'rx-0' (000000002d5aad68): kobject_uevent_env
kobject: 'loop0' (00000000f1223470): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'rx-0' (000000002d5aad68): fill_kobj_path: path  
= '/devices/virtual/net/bctf0/queues/rx-0'
kobject: 'loop4' (000000002f2c99c3): kobject_uevent_env
kobject: 'loop4' (000000002f2c99c3): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop2' (00000000ce85f3f9): kobject_uevent_env
kobject: 'loop3' (000000007c159c39): kobject_uevent_env
kobject: 'tx-0' (000000001b3b7a9e): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'loop3' (000000007c159c39): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop2' (00000000ce85f3f9): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
overlayfs: failed to resolve './file1': -2
kobject: 'tx-0' (000000001b3b7a9e): kobject_uevent_env
kobject: 'loop5' (00000000b77ceb3f): kobject_uevent_env
ntfs: (device loop2): ntfs_fill_super(): Unable to determine device size.
kobject: 'tx-0' (000000001b3b7a9e): fill_kobj_path: path  
= '/devices/virtual/net/bctf0/queues/tx-0'
kobject: 'loop5' (00000000b77ceb3f): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop0' (00000000f1223470): kobject_uevent_env
kobject: 'loop0' (00000000f1223470): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop2' (00000000ce85f3f9): kobject_uevent_env
kobject: 'loop4' (000000002f2c99c3): kobject_uevent_env
kobject: 'loop2' (00000000ce85f3f9): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop4' (000000002f2c99c3): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop2' (00000000ce85f3f9): kobject_uevent_env
kobject: 'loop2' (00000000ce85f3f9): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'rx-0' (000000002d5aad68): kobject_cleanup, parent 0000000051f0c714
kobject: 'rx-0' (000000002d5aad68): auto cleanup 'remove' event
kobject: 'rx-0' (000000002d5aad68): kobject_uevent_env
kobject: 'rx-0' (000000002d5aad68): fill_kobj_path: path  
= '/devices/virtual/net/bctf0/queues/rx-0'
kobject: 'rx-0' (000000002d5aad68): auto cleanup kobject_del
kobject: 'rx-0' (000000002d5aad68): calling ktype release
kobject: 'rx-0': free name
kobject: 'tx-0' (000000001b3b7a9e): kobject_cleanup, parent 0000000051f0c714
kobject: 'tx-0' (000000001b3b7a9e): auto cleanup 'remove' event
kobject: 'tx-0' (000000001b3b7a9e): kobject_uevent_env
kobject: 'tx-0' (000000001b3b7a9e): fill_kobj_path: path  
= '/devices/virtual/net/bctf0/queues/tx-0'
kobject: 'tx-0' (000000001b3b7a9e): auto cleanup kobject_del
kobject: 'tx-0' (000000001b3b7a9e): calling ktype release
kobject: 'tx-0': free name
kobject: 'queues' (0000000051f0c714): kobject_cleanup, parent            
(null)
kobject: 'queues' (0000000051f0c714): calling ktype release
kobject: 'queues' (0000000051f0c714): kset_release
kobject: 'queues': free name
kobject: 'bctf0' (000000008c199bcb): kobject_uevent_env
kobject: 'bctf0' (000000008c199bcb): fill_kobj_path: path  
= '/devices/virtual/net/bctf0'
kobject: 'bctf0' (000000008c199bcb): kobject_cleanup, parent            
(null)
kobject: 'bctf0' (000000008c199bcb): calling ktype release
kobject: 'bctf0': free name
kobject: 'loop2' (00000000ce85f3f9): kobject_uevent_env
kobject: 'loop2' (00000000ce85f3f9): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop5' (00000000b77ceb3f): kobject_uevent_env
kobject: 'loop5' (00000000b77ceb3f): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop3' (000000007c159c39): kobject_uevent_env
kobject: 'loop3' (000000007c159c39): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop0' (00000000f1223470): kobject_uevent_env
kobject: 'loop0' (00000000f1223470): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop1' (0000000090b2e742): kobject_uevent_env
kobject: 'loop1' (0000000090b2e742): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop2' (00000000ce85f3f9): kobject_uevent_env
kobject: 'loop2' (00000000ce85f3f9): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop4' (000000002f2c99c3): kobject_uevent_env
kobject: 'loop4' (000000002f2c99c3): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop3' (000000007c159c39): kobject_uevent_env
kobject: 'loop3' (000000007c159c39): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop0' (00000000f1223470): kobject_uevent_env
kobject: 'loop0' (00000000f1223470): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop1' (0000000090b2e742): kobject_uevent_env
kobject: 'loop1' (0000000090b2e742): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop2' (00000000ce85f3f9): kobject_uevent_env
kobject: 'loop2' (00000000ce85f3f9): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop1' (0000000090b2e742): kobject_uevent_env
kobject: 'loop1' (0000000090b2e742): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop2' (00000000ce85f3f9): kobject_uevent_env
kobject: 'loop2' (00000000ce85f3f9): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop3' (000000007c159c39): kobject_uevent_env
kobject: 'loop3' (000000007c159c39): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop0' (00000000f1223470): kobject_uevent_env
kobject: 'loop0' (00000000f1223470): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop5' (00000000b77ceb3f): kobject_uevent_env
kobject: 'loop5' (00000000b77ceb3f): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop3' (000000007c159c39): kobject_uevent_env
kobject: 'loop3' (000000007c159c39): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop4' (000000002f2c99c3): kobject_uevent_env
kobject: 'loop4' (000000002f2c99c3): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop1' (0000000090b2e742): kobject_uevent_env
kobject: 'loop1' (0000000090b2e742): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop2' (00000000ce85f3f9): kobject_uevent_env
kobject: 'loop2' (00000000ce85f3f9): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop5' (00000000b77ceb3f): kobject_uevent_env
kobject: 'loop5' (00000000b77ceb3f): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop3' (000000007c159c39): kobject_uevent_env
kobject: 'loop3' (000000007c159c39): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop0' (00000000f1223470): kobject_uevent_env
kobject: 'loop0' (00000000f1223470): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop4' (000000002f2c99c3): kobject_uevent_env
kobject: 'loop4' (000000002f2c99c3): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop5' (00000000b77ceb3f): kobject_uevent_env
kobject: 'loop5' (00000000b77ceb3f): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop4' (000000002f2c99c3): kobject_uevent_env
kobject: 'loop4' (000000002f2c99c3): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop5' (00000000b77ceb3f): kobject_uevent_env
kobject: 'loop5' (00000000b77ceb3f): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop0' (00000000f1223470): kobject_uevent_env
kobject: 'loop0' (00000000f1223470): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop1' (0000000090b2e742): kobject_uevent_env
kobject: 'loop1' (0000000090b2e742): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop2' (00000000ce85f3f9): kobject_uevent_env
kobject: 'loop2' (00000000ce85f3f9): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop4' (000000002f2c99c3): kobject_uevent_env
kobject: 'loop4' (000000002f2c99c3): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop1' (0000000090b2e742): kobject_uevent_env
kobject: 'loop1' (0000000090b2e742): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop0' (00000000f1223470): kobject_uevent_env
kobject: 'loop0' (00000000f1223470): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop2' (00000000ce85f3f9): kobject_uevent_env
kobject: 'loop2' (00000000ce85f3f9): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop3' (000000007c159c39): kobject_uevent_env
kobject: 'loop3' (000000007c159c39): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop0' (00000000f1223470): kobject_uevent_env
kobject: 'loop0' (00000000f1223470): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop5' (00000000b77ceb3f): kobject_uevent_env
kobject: 'loop5' (00000000b77ceb3f): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop3' (000000007c159c39): kobject_uevent_env
kobject: 'loop3' (000000007c159c39): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop2' (00000000ce85f3f9): kobject_uevent_env
kobject: 'loop2' (00000000ce85f3f9): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop1' (0000000090b2e742): kobject_uevent_env
kobject: 'loop1' (0000000090b2e742): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop4' (000000002f2c99c3): kobject_uevent_env
kobject: 'loop4' (000000002f2c99c3): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop4' (000000002f2c99c3): kobject_uevent_env
kobject: 'loop4' (000000002f2c99c3): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop5' (00000000b77ceb3f): kobject_uevent_env
kobject: 'loop5' (00000000b77ceb3f): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop0' (00000000f1223470): kobject_uevent_env
kobject: 'loop0' (00000000f1223470): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop4' (000000002f2c99c3): kobject_uevent_env
kobject: 'loop4' (000000002f2c99c3): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop0' (00000000f1223470): kobject_uevent_env
kobject: 'loop0' (00000000f1223470): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop4' (000000002f2c99c3): kobject_uevent_env
kobject: 'loop4' (000000002f2c99c3): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop5' (00000000b77ceb3f): kobject_uevent_env
kobject: 'loop5' (00000000b77ceb3f): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop0' (00000000f1223470): kobject_uevent_env
kobject: 'loop0' (00000000f1223470): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop4' (000000002f2c99c3): kobject_uevent_env
kobject: 'loop4' (000000002f2c99c3): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop5' (00000000b77ceb3f): kobject_uevent_env
kobject: 'loop5' (00000000b77ceb3f): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop2' (00000000ce85f3f9): kobject_uevent_env
kobject: 'loop2' (00000000ce85f3f9): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop1' (0000000090b2e742): kobject_uevent_env
kobject: 'loop1' (0000000090b2e742): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop3' (000000007c159c39): kobject_uevent_env
kobject: 'loop3' (000000007c159c39): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop2' (00000000ce85f3f9): kobject_uevent_env
kobject: 'loop2' (00000000ce85f3f9): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop4' (000000002f2c99c3): kobject_uevent_env
kobject: 'loop4' (000000002f2c99c3): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop5' (00000000b77ceb3f): kobject_uevent_env
kobject: 'loop5' (00000000b77ceb3f): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop2' (00000000ce85f3f9): kobject_uevent_env
kobject: 'loop2' (00000000ce85f3f9): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop0' (00000000f1223470): kobject_uevent_env
kobject: 'loop0' (00000000f1223470): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop1' (0000000090b2e742): kobject_uevent_env
kobject: 'loop1' (0000000090b2e742): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop4' (000000002f2c99c3): kobject_uevent_env
kobject: 'loop4' (000000002f2c99c3): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop5' (00000000b77ceb3f): kobject_uevent_env
kobject: 'loop5' (00000000b77ceb3f): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop3' (000000007c159c39): kobject_uevent_env
kobject: 'loop3' (000000007c159c39): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop4' (000000002f2c99c3): kobject_uevent_env
kobject: 'loop4' (000000002f2c99c3): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop0' (00000000f1223470): kobject_uevent_env
kobject: 'loop0' (00000000f1223470): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop2' (00000000ce85f3f9): kobject_uevent_env
kobject: 'loop2' (00000000ce85f3f9): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop1' (0000000090b2e742): kobject_uevent_env
kobject: 'loop1' (0000000090b2e742): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop5' (00000000b77ceb3f): kobject_uevent_env
kobject: 'loop5' (00000000b77ceb3f): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop4' (000000002f2c99c3): kobject_uevent_env
kobject: 'loop4' (000000002f2c99c3): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop0' (00000000f1223470): kobject_uevent_env
kobject: 'loop0' (00000000f1223470): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop5' (00000000b77ceb3f): kobject_uevent_env
kobject: 'loop5' (00000000b77ceb3f): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop2' (00000000ce85f3f9): kobject_uevent_env
kobject: 'loop2' (00000000ce85f3f9): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop0' (00000000f1223470): kobject_uevent_env
kobject: 'loop0' (00000000f1223470): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop1' (0000000090b2e742): kobject_uevent_env
kobject: 'loop1' (0000000090b2e742): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop2' (00000000ce85f3f9): kobject_uevent_env
kobject: 'loop2' (00000000ce85f3f9): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop0' (00000000f1223470): kobject_uevent_env
kobject: 'loop0' (00000000f1223470): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop3' (000000007c159c39): kobject_uevent_env
kobject: 'loop3' (000000007c159c39): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop5' (00000000b77ceb3f): kobject_uevent_env
kobject: 'loop5' (00000000b77ceb3f): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop0' (00000000f1223470): kobject_uevent_env
kobject: 'loop0' (00000000f1223470): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop1' (0000000090b2e742): kobject_uevent_env
kobject: 'loop1' (0000000090b2e742): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop4' (000000002f2c99c3): kobject_uevent_env
kobject: 'loop4' (000000002f2c99c3): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop5' (00000000b77ceb3f): kobject_uevent_env
kobject: 'loop5' (00000000b77ceb3f): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop1' (0000000090b2e742): kobject_uevent_env
kobject: 'loop1' (0000000090b2e742): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop0' (00000000f1223470): kobject_uevent_env
kobject: 'loop0' (00000000f1223470): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop5' (00000000b77ceb3f): kobject_uevent_env
kobject: 'loop5' (00000000b77ceb3f): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop4' (000000002f2c99c3): kobject_uevent_env
kobject: 'loop4' (000000002f2c99c3): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop0' (00000000f1223470): kobject_uevent_env
kobject: 'loop0' (00000000f1223470): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop5' (00000000b77ceb3f): kobject_uevent_env
kobject: 'loop5' (00000000b77ceb3f): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop3' (000000007c159c39): kobject_uevent_env
kobject: 'loop3' (000000007c159c39): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop3' (000000007c159c39): kobject_uevent_env
kobject: 'loop3' (000000007c159c39): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop2' (00000000ce85f3f9): kobject_uevent_env
kobject: 'loop2' (00000000ce85f3f9): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop3' (000000007c159c39): kobject_uevent_env
kobject: 'loop3' (000000007c159c39): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop3' (000000007c159c39): kobject_uevent_env
kobject: 'loop3' (000000007c159c39): fill_kobj_path: path  
= '/devices/virtual/block/loop3'


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
