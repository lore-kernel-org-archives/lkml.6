Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E4B3C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 18:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4E5720871
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 18:26:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4E5720871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729435AbeKLEPS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 23:15:18 -0500
Received: from mail-it1-f199.google.com ([209.85.166.199]:42464 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726848AbeKLEPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 23:15:18 -0500
Received: by mail-it1-f199.google.com with SMTP id z195-v6so10722180itb.7
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 10:26:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=nUlCy2hLDsYaXyWagQn3o6grC8x0fDvEPsUDw6QXKfw=;
        b=mYGyhkxv6c/LDjwm2kTqbl3sPM9x9bG/ZpARk+VPJbI+TE1ME0QzhnmuAyIDr6ZXJ9
         q5tU9EN8jkr3bd5P5+5k54zohnRWuB/llJsTd1ox6AW7xvKIsbCZeZE+Hq4UL7SlAfiK
         Bhv51i4hYNYACHh73awzLWmzjDqdMLabratbfn1oy7Xqw4qTRi7LF2HBoiw8q0SAwzJh
         Cg6OPw3N/X73InJ4ArQzdR3pfPGkY1fN1jUwk0qmb7dwBgBY61Rd60h/vhJp/cJ6QXFg
         QYCB3xeLi9ZHnGe7x1xlzGQQ7E/YdJZF6EK5rYw9Bz3jU5STnvPFjNrjzsv8g5/Pb7z8
         wYfA==
X-Gm-Message-State: AGRZ1gKRiroySdNJOU8lIk29ZVyMSd3Y876QT3Obg3CvKrX3Vnc0K1AE
        amM95wxp/6ycB4ZZricGoZh2W1tVg5LyCKb0hc7a5ZQbfI9n
X-Google-Smtp-Source: AJdET5eXWqlUpJuJFCCvaScyyj1XRfA1dkfKzW+CEWjRVtO99uc0V1asvTJIkjPZms9YumQwnh21BkirMhHvKBhpNGiqydFSMH5e
MIME-Version: 1.0
X-Received: by 2002:a6b:b4cc:: with SMTP id d195mr1380092iof.39.1541960762453;
 Sun, 11 Nov 2018 10:26:02 -0800 (PST)
Date:   Sun, 11 Nov 2018 10:26:02 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000080f8fa057a67b75c@google.com>
Subject: BUG: GPF in non-whitelisted uaccess (non-canonical address?)
From:   syzbot <syzbot+72473edc9bf4eb1c6556@syzkaller.appspotmail.com>
To:     benjamin.tissoires@redhat.com, dh.herrmann@googlemail.com,
        jikos@kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    ab6e1f378f54 Merge tag 'for-linus-4.20a-rc2-tag' of git://..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11f65b83400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f215f21f041a0d7
dashboard link: https://syzkaller.appspot.com/bug?extid=72473edc9bf4eb1c6556
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+72473edc9bf4eb1c6556@syzkaller.appspotmail.com

kernel msg: ebtables bug: please report to author: Nentries wrong
kernel msg: ebtables bug: please report to author: Nentries wrong
BUG: GPF in non-whitelisted uaccess (non-canonical address?)
kasan: CONFIG_KASAN_INLINE enabled
IPVS: ftp: loaded support on port[0] = 21
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 31848 Comm: syz-executor1 Not tainted 4.20.0-rc1+ #109
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:copy_user_enhanced_fast_string+0xe/0x20  
arch/x86/lib/copy_user_64.S:180
Code: 89 d1 c1 e9 03 83 e2 07 f3 48 a5 89 d1 f3 a4 31 c0 0f 1f 00 c3 0f 1f  
80 00 00 00 00 0f 1f 00 83 fa 40 0f 82 70 ff ff ff 89 d1 <f3> a4 31 c0 0f  
1f 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 83
kobject: 'lo' (00000000a6443dd1): kobject_add_internal: parent: 'net',  
set: 'devices'
RSP: 0018:ffff8801d70af398 EFLAGS: 00010206
RAX: 0000000000000000 RBX: 00000000000000be RCX: 00000000000000be
RDX: 00000000000000be RSI: 4caaadbf9db04a99 RDI: ffff8801bf63b2b8
RBP: ffff8801d70af3d0 R08: ffffed0037ec766f R09: ffffed0037ec766f
R10: ffffed0037ec766e R11: ffff8801bf63b375 R12: 4caaadbf9db04b57
R13: 4caaadbf9db04a99 R14: ffff8801bf63b2b8 R15: ffffffffffffffff
FS:  00007f0b59d0f700(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000625208 CR3: 00000001b7e87000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
kobject: 'loop5' (00000000bad8892f): kobject_uevent_env
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  copy_from_user include/linux/uaccess.h:147 [inline]
  uhid_dev_create+0x20c/0xb40 drivers/hid/uhid.c:542
kobject: 'loop5' (00000000bad8892f): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kernel msg: ebtables bug: please report to author: Nentries wrong
  uhid_char_write+0xc74/0xef0 drivers/hid/uhid.c:725
kernel msg: ebtables bug: please report to author: Nentries wrong
  __vfs_write+0x119/0x9f0 fs/read_write.c:485
kobject: 'loop4' (000000000f3fc2e6): kobject_uevent_env
kobject: 'loop4' (000000000f3fc2e6): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'lo' (00000000a6443dd1): kobject_uevent_env
  __kernel_write+0x10c/0x370 fs/read_write.c:506
  write_pipe_buf+0x180/0x240 fs/splice.c:797
kobject: 'lo' (00000000a6443dd1): fill_kobj_path: path  
= '/devices/virtual/net/lo'
  splice_from_pipe_feed fs/splice.c:503 [inline]
  __splice_from_pipe+0x38b/0x7c0 fs/splice.c:627
kobject: 'queues' (00000000cdfb81e7): kobject_add_internal: parent: 'lo',  
set: '<NULL>'
  splice_from_pipe+0x1ec/0x340 fs/splice.c:662
kernel msg: ebtables bug: please report to author: Nentries wrong
  default_file_splice_write+0x3c/0x90 fs/splice.c:809
kernel msg: ebtables bug: please report to author: Nentries wrong
  do_splice_from fs/splice.c:851 [inline]
  direct_splice_actor+0x128/0x190 fs/splice.c:1018
  splice_direct_to_actor+0x318/0x8f0 fs/splice.c:973
kobject: 'queues' (00000000cdfb81e7): kobject_uevent_env
kobject: 'loop2' (00000000314877e3): kobject_uevent_env
kobject: 'loop2' (00000000314877e3): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
  do_splice_direct+0x2d4/0x420 fs/splice.c:1061
kobject: 'queues' (00000000cdfb81e7): kobject_uevent_env: filter function  
caused the event to drop!
  do_sendfile+0x62a/0xe20 fs/read_write.c:1439
kobject: 'rx-0' (0000000095d78570): kobject_add_internal: parent: 'queues',  
set: 'queues'
  __do_sys_sendfile64 fs/read_write.c:1494 [inline]
  __se_sys_sendfile64 fs/read_write.c:1486 [inline]
  __x64_sys_sendfile64+0x15d/0x250 fs/read_write.c:1486
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
kobject: 'rx-0' (0000000095d78570): kobject_uevent_env
kobject: 'rx-0' (0000000095d78570): fill_kobj_path: path  
= '/devices/virtual/net/lo/queues/rx-0'
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457569
Code: fd b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
kobject: 'tx-0' (0000000002ec5b19): kobject_add_internal: parent: 'queues',  
set: 'queues'
RSP: 002b:00007f0b59d0ec78 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 0000000000457569
RDX: 0000000020d83ff8 RSI: 0000000000000004 RDI: 0000000000000003
RBP: 000000000072bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 00008000fffffffe R11: 0000000000000246 R12: 00007f0b59d0f6d4
R13: 00000000004c37cc R14: 00000000004d5958 R15: 00000000ffffffff
kobject: 'tx-0' (0000000002ec5b19): kobject_uevent_env
Modules linked in:
---[ end trace 05f5a052f649341e ]---
kobject: 'tx-0' (0000000002ec5b19): fill_kobj_path: path  
= '/devices/virtual/net/lo/queues/tx-0'
RIP: 0010:copy_user_enhanced_fast_string+0xe/0x20  
arch/x86/lib/copy_user_64.S:180
Code: 89 d1 c1 e9 03 83 e2 07 f3 48 a5 89 d1 f3 a4 31 c0 0f 1f 00 c3 0f 1f  
80 00 00 00 00 0f 1f 00 83 fa 40 0f 82 70 ff ff ff 89 d1 <f3> a4 31 c0 0f  
1f 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 83
IPVS: ftp: loaded support on port[0] = 21
kobject: 'loop0' (00000000340bf24d): kobject_uevent_env
kobject: 'rx-0' (00000000a3b2c01d): kobject_cleanup, parent 00000000717c1169
kobject: 'loop0' (00000000340bf24d): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'rx-0' (00000000a3b2c01d): auto cleanup 'remove' event
RSP: 0018:ffff8801d70af398 EFLAGS: 00010206
RAX: 0000000000000000 RBX: 00000000000000be RCX: 00000000000000be
kobject: 'rx-0' (00000000a3b2c01d): kobject_uevent_env
kobject: 'loop5' (00000000bad8892f): kobject_uevent_env
kobject: 'rx-0' (00000000a3b2c01d): fill_kobj_path: path  
= '/devices/virtual/net/syz_tun/queues/rx-0'
RDX: 00000000000000be RSI: 4caaadbf9db04a99 RDI: ffff8801bf63b2b8
kobject: 'loop5' (00000000bad8892f): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
RBP: ffff8801d70af3d0 R08: ffffed0037ec766f R09: ffffed0037ec766f
kobject: 'rx-0' (00000000a3b2c01d): auto cleanup kobject_del
R10: ffffed0037ec766e R11: ffff8801bf63b375 R12: 4caaadbf9db04b57
R13: 4caaadbf9db04a99 R14: ffff8801bf63b2b8 R15: ffffffffffffffff
kobject: 'rx-0' (00000000a3b2c01d): calling ktype release
FS:  00007f0b59d0f700(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000001cc6308 CR3: 00000001b7e87000 CR4: 00000000001406e0
kobject: 'rx-0': free name
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
kobject: 'tx-0' (00000000bb9c9857): kobject_cleanup, parent 00000000717c1169
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
