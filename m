Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB4CAC6787D
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 23:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 688912088F
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 23:44:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 688912088F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727400AbeJHGxB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 02:53:01 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:41156 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbeJHGxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 02:53:01 -0400
Received: by mail-io1-f70.google.com with SMTP id f64-v6so17899977ioa.8
        for <linux-kernel@vger.kernel.org>; Sun, 07 Oct 2018 16:44:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=czxXr/jGUG8KgJJCDLENMI6k/QfUSdBmhn2bp1yfvVU=;
        b=OsG39lfh49AY4/ND0fj0LvU0VE4jy3vkTdrxJ7GAnpI0kwjZgc9myPZ66HufC/y8zY
         SfC0vzsXo5OjgqS637xQB+ru5rBmlbOvLZZhWv0hESzk7Wjxi00J5vqNY4UDNlH2uZY3
         pb9Tgz28nR/C6nLemiUCEvWcUj6BK7sApGvg2+t7bzD32eHsyFqpl3jCp5RhxnhOZx9F
         yP0bba4aJ/YlxWvkGnOx5nPO317oBLD4clbU53a/O9h2WKCijcmdywqBGKbNeFOGqxki
         7nkwu3oiSfXgI80/PixymqrefPHgsewQiGc20jCXOJf/x8nvSW8X2nxTp8Z1UMMfGS3N
         YSKQ==
X-Gm-Message-State: ABuFfoj8N5dU/XAJjSfS5ZE5Xa+pUmTt1G2wVH2tHObzCpQMHKip93ZO
        BI4Lti7VxFHGgAR7Uc6/7nnh3NV9BmwOSz83wMRdCNWTveeh
X-Google-Smtp-Source: ACcGV62sLZ2RcarMKr6qD5kGslcJ/D19S6jpdTL5ZU1mDNfvZahoC4h4VEGhKHFTi3jqmpRxBUSn43Tb9OfTTlZlaH1LudOw053i
MIME-Version: 1.0
X-Received: by 2002:a24:6cc2:: with SMTP id w185-v6mr4611390itb.5.1538955843804;
 Sun, 07 Oct 2018 16:44:03 -0700 (PDT)
Date:   Sun, 07 Oct 2018 16:44:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006533a60577ac1419@google.com>
Subject: general protection fault in getname_kernel
From:   syzbot <syzbot+c54f8e94e6bba03b04e9@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    c1d84a1b42ef Merge git://git.kernel.org/pub/scm/linux/kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10f3c6a1400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c0af03fe452b65fb
dashboard link: https://syzkaller.appspot.com/bug?extid=c54f8e94e6bba03b04e9
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10688159400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1162aa31400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+c54f8e94e6bba03b04e9@syzkaller.appspotmail.com

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 5829 Comm: syz-executor215 Not tainted 4.19.0-rc6+ #271
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:strlen+0x1f/0xa0 lib/string.c:479
Code: ff ff ff 0f 1f 84 00 00 00 00 00 48 b8 00 00 00 00 00 fc ff df 55 48  
89 fa 48 89 e5 48 c1 ea 03 41 54 49 89 fc 53 48 83 ec 08 <0f> b6 04 02 48  
89 fa 83 e2 07 38 d0 7f 04 84 c0 75 4d 41 80 3c 24
RSP: 0018:ffff8801bc30f9b0 EFLAGS: 00010282
RAX: dffffc0000000000 RBX: 0000000000000001 RCX: ffff8801bc74eec0
RDX: 0000000000000000 RSI: ffffffff81d2cccc RDI: 0000000000000000
RBP: ffff8801bc30f9c8 R08: ffff8801d7c24400 R09: ffffed003af0a800
R10: fffff94000ebc2a6 R11: ffffea00075e1537 R12: 0000000000000000
R13: 0000000000000000 R14: ffffffff89f3ee98 R15: 0000000000000000
FS:  0000000001f11880(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000000 CR3: 00000001d7cc6000 CR4: 00000000001406e0
Call Trace:
  strlen include/linux/string.h:267 [inline]
  getname_kernel+0x24/0x370 fs/namei.c:218
  kern_path+0x1e/0x40 fs/namei.c:2434
  gfs2_mount_meta+0x85/0x2a0 fs/gfs2/ops_fstype.c:1336
  mount_fs+0xae/0x31d fs/super.c:1261
  vfs_kern_mount.part.35+0xdc/0x4f0 fs/namespace.c:961
  vfs_kern_mount fs/namespace.c:951 [inline]
  do_new_mount fs/namespace.c:2457 [inline]
  do_mount+0x581/0x31f0 fs/namespace.c:2787
  ksys_mount+0x12d/0x140 fs/namespace.c:3003
  __do_sys_mount fs/namespace.c:3017 [inline]
  __se_sys_mount fs/namespace.c:3014 [inline]
  __x64_sys_mount+0xbe/0x150 fs/namespace.c:3014
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x440059
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 fb 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffe32cedb58 EFLAGS: 00000217 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0030656c69662f2e RCX: 0000000000440059
RDX: 0000000020000040 RSI: 0000000020000080 RDI: 0000000000000000
RBP: 00000000006ca018 R08: 00000000200000c0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000217 R12: 00000000004018e0
R13: 0000000000401970 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
---[ end trace e8236b178a90d827 ]---
RIP: 0010:strlen+0x1f/0xa0 lib/string.c:479
Code: ff ff ff 0f 1f 84 00 00 00 00 00 48 b8 00 00 00 00 00 fc ff df 55 48  
89 fa 48 89 e5 48 c1 ea 03 41 54 49 89 fc 53 48 83 ec 08 <0f> b6 04 02 48  
89 fa 83 e2 07 38 d0 7f 04 84 c0 75 4d 41 80 3c 24
RSP: 0018:ffff8801bc30f9b0 EFLAGS: 00010282
RAX: dffffc0000000000 RBX: 0000000000000001 RCX: ffff8801bc74eec0
RDX: 0000000000000000 RSI: ffffffff81d2cccc RDI: 0000000000000000
RBP: ffff8801bc30f9c8 R08: ffff8801d7c24400 R09: ffffed003af0a800
R10: fffff94000ebc2a6 R11: ffffea00075e1537 R12: 0000000000000000
R13: 0000000000000000 R14: ffffffff89f3ee98 R15: 0000000000000000
FS:  0000000001f11880(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000000 CR3: 00000001d7cc6000 CR4: 00000000001406e0


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
