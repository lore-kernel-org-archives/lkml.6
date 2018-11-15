Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C0B0C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 17:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FE6521780
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 17:46:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FE6521780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388802AbeKPDyv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 22:54:51 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:46968 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388452AbeKPDyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 22:54:51 -0500
Received: by mail-io1-f69.google.com with SMTP id e144-v6so20282717iof.13
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 09:46:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Glv4smm2+Sqaz7BkgJvKLjELzT/BulbTevJkt2rnKRk=;
        b=S7YSBfiJKr52OD6fxc1D8Jm1IJ312339P5CvMzDwaULyaAMPRxMBziUWiAVYqHbT2n
         fSOqr20iwK5yl5eJGg18dScjf5+UOqbUsZ061rMgCmcfqtn90eqeeszFfKYm0Pfu+rhq
         OL2KSsR7tbSg9vPB6oDcjU1+1Yc7QpY1IAXKcsr1rAA9B/g/l05UNpD7A2LMzynf1cWY
         A/A1aQWy4dW0AN6CsAFjvUIP1CsX/xUga+hFnH2RcPu6q/5uLyeM0X94MGMvSntcydF2
         6xOmnkqnJw80zrUTP6wn3wP5WaSlRG9zyq7f0Gcpxbkj5laANfHv168xXOFjjdFgh4LT
         dCCg==
X-Gm-Message-State: AA+aEWbfS/LQA+VsHzW9GYxk7MiprUHKDayqy+zs8taA7Rjlf3gvPxSI
        GeTCzLqV4kKjcSqfbUFikfaQdtc1R/h2TQgYl/g6yAWv26K7
X-Google-Smtp-Source: AFSGD/XAEBXhJRoCLVCG/DG14ymCjpxRfDnTErV3XnKLh4uQsMDjxVmbpltNdoxjvNPSf5OBRig0Au+loagxuKkAPmxozFBj3RCh
MIME-Version: 1.0
X-Received: by 2002:a5e:d919:: with SMTP id n25-v6mr1022536iop.0.1542303964160;
 Thu, 15 Nov 2018 09:46:04 -0800 (PST)
Date:   Thu, 15 Nov 2018 09:46:04 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000eb6a8e057ab79f82@google.com>
Subject: WARNING: refcount bug in p9_req_put
From:   syzbot <syzbot+edec7868af5997928fe9@syzkaller.appspotmail.com>
To:     asmadeus@codewreck.org, davem@davemloft.net, ericvh@gmail.com,
        linux-kernel@vger.kernel.org, lucho@ionkov.net,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        v9fs-developer@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    ccda4af0f4b9 Linux 4.20-rc2
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=166b66a3400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4a0a89f12ca9b0f5
dashboard link: https://syzkaller.appspot.com/bug?extid=edec7868af5997928fe9
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+edec7868af5997928fe9@syzkaller.appspotmail.com

audit: type=1400 audit(1542156774.207:23570): avc:  denied  { map } for   
pid=3935 comm="blkid" path="/sbin/blkid" dev="sda1" ino=16128  
scontext=system_u:system_r:kernel_t:s0 tcontext=system_u:object_r:file_t:s0  
tclass=file permissive=1
XFS (loop1): device supports 512 byte sectors (not 0)
------------[ cut here ]------------
refcount_t: underflow; use-after-free.
WARNING: CPU: 0 PID: 3966 at lib/refcount.c:187  
refcount_sub_and_test_checked+0x2c9/0x310 lib/refcount.c:187
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 3966 Comm: syz-executor0 Not tainted 4.20.0-rc2+ #112
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
RIP: 0010:refcount_sub_and_test_checked+0x2c9/0x310 lib/refcount.c:187
Code: 89 de e8 ea 1a ed fd 84 db 74 07 31 db e9 4d ff ff ff e8 0a 1a ed fd  
48 c7 c7 20 ae 60 88 c6 05 7b fd 7e 06 01 e8 67 7d b6 fd <0f> 0b 31 db e9  
2c ff ff ff 48 89 cf e8 a6 67 30 fe e9 41 fe ff ff
RSP: 0018:ffff88817e87f330 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffc90005e51000
RDX: 00000000000222c2 RSI: ffffffff8165e7e5 RDI: 0000000000000005
RBP: ffff88817e87f418 R08: ffff8881866ba640 R09: ffffed103b5c5020
R10: ffffed103b5c5020 R11: ffff8881dae28107 R12: ffff88817c7a7008
R13: 00000000ffffffff R14: ffff88817e87f3f0 R15: ffff8881c1dc9d68
  refcount_dec_and_test_checked+0x1a/0x20 lib/refcount.c:212
  kref_put include/linux/kref.h:69 [inline]
  p9_req_put+0x20/0x60 net/9p/client.c:395
  p9_conn_destroy net/9p/trans_fd.c:880 [inline]
  p9_fd_close+0x39f/0x6b0 net/9p/trans_fd.c:913
  p9_client_create+0xbd0/0x1674 net/9p/client.c:1062
  v9fs_session_init+0x217/0x1bb0 fs/9p/v9fs.c:421
  v9fs_mount+0x7c/0x8f0 fs/9p/vfs_super.c:135
  mount_fs+0xae/0x31d fs/super.c:1261
  vfs_kern_mount.part.35+0xdc/0x4f0 fs/namespace.c:961
  vfs_kern_mount fs/namespace.c:951 [inline]
  do_new_mount fs/namespace.c:2469 [inline]
  do_mount+0x581/0x31f0 fs/namespace.c:2801
  ksys_mount+0x12d/0x140 fs/namespace.c:3017
  __do_sys_mount fs/namespace.c:3031 [inline]
  __se_sys_mount fs/namespace.c:3028 [inline]
  __x64_sys_mount+0xbe/0x150 fs/namespace.c:3028
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457569
Code: fd b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f1d0faf5c78 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 0000000000457569
RDX: 0000000020000600 RSI: 00000000200005c0 RDI: 0000000000000000
RBP: 000000000072bf00 R08: 0000000020000240 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f1d0faf66d4
R13: 00000000004c2b12 R14: 00000000004d4278 R15: 00000000ffffffff
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
