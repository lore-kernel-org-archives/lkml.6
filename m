Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B738ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 23:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 322182075C
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 23:49:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 322182075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729973AbeGRAYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 20:24:03 -0400
Received: from mail-io0-f198.google.com ([209.85.223.198]:48965 "EHLO
        mail-io0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729714AbeGRAYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 20:24:03 -0400
Received: by mail-io0-f198.google.com with SMTP id t11-v6so2091606iog.15
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 16:49:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=yjFXioZiecqrS62NUXaWxnKhEuWU3pvlM8mzdn3PlvM=;
        b=GJh1QM0SQDX2OOSv+kil6lQMFibp0q7I081d6sxv6y4C7aJLO+mAirtm8oB0wMJC1C
         nHthXpbTKIbb+OAmAkjryDo0TOxtBZ0vgSLWj1lkCX5+g1G/JkJUvnSLrDY7ev9GgFPd
         v9iXAZEy0J57dMB2SI+CccbynvDqE45PYH4JtsDGcjjZv97cpMn0VCQ1zTdP0Jw+4i6+
         fynQIFfa5BChmU4bg9HFQOLp195c5y06YSFJrhE5gqQBTPdOwhQonxAARH2rBTGzQuUD
         CE9a07tJdov7SM6lUaNDwMbutvcQFtFiBS+gNs2+Ewiy4Df6DsryFtjDoIBOibVWxQYc
         Yrlw==
X-Gm-Message-State: AOUpUlFVRXabw5rnUd9MfklWBF6bL0Jj5sSa5zRLSbNgzJmf+kL8/Uhj
        5lrwGcmkDLxxqMRuDPzKo92Oxtr3Rew5Q111hpszQnTQ9MEW
X-Google-Smtp-Source: AAOMgpcHGU1jSlOMmFb8gQpBbKuv+DgugfMdnjwSuAnEByuRiXtGbH2nEJocp811cMPfJ6OFJ44QcVOwYig7XzPFrweOQeaJDEvK
MIME-Version: 1.0
X-Received: by 2002:a6b:7114:: with SMTP id q20-v6mr1562666iog.4.1531871342183;
 Tue, 17 Jul 2018 16:49:02 -0700 (PDT)
Date:   Tue, 17 Jul 2018 16:49:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000314acf05713a97f9@google.com>
Subject: general protection fault in process_init_reply
From:   syzbot <syzbot+b62f08f4d5857755e3bc@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    1dcbe5f2c615 Add linux-next specific files for 20180717
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=148aac44400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ea5926dddb0db97a
dashboard link: https://syzkaller.appspot.com/bug?extid=b62f08f4d5857755e3bc
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=143725d0400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=120ef3b2400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+b62f08f4d5857755e3bc@syzkaller.appspotmail.com

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] SMP KASAN
CPU: 0 PID: 17978 Comm: syz-executor367 Not tainted  
4.18.0-rc5-next-20180717+ #9
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:process_init_reply+0xedc/0x1500 fs/fuse/inode.c:923
Code: 0f 95 c0 84 c2 0f 85 65 05 00 00 49 8d be 00 01 00 00 80 8b e9 01 00  
00 06 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f  
85 32 05 00 00 49 c7 86 00 01 00 00 a0 7f 16 89 41
RSP: 0018:ffff8801a97cf478 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffff8801cdfdfb40 RCX: 0000000000000001
RDX: 0000000000000020 RSI: ffffffff826e5a3d RDI: 0000000000000100
RBP: ffff8801a97cf4b0 R08: ffff8801b2a625c0 R09: ffffed0039cd05da
R10: ffffed0039cd05da R11: ffff8801ce682ed3 R12: ffff8801ce682e00
R13: ffff8801cdfdfd29 R14: 0000000000000000 R15: ffff8801cdfdfd25
FS:  00007f7f6d9b8700(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f7f6d9d8e78 CR3: 00000001d64ed000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  request_end+0x3de/0xb20 fs/fuse/dev.c:402
  fuse_dev_do_read.isra.25+0xf21/0x1960 fs/fuse/dev.c:1316
  fuse_dev_read+0x1a9/0x250 fs/fuse/dev.c:1349
  call_read_iter include/linux/fs.h:1820 [inline]
  new_sync_read fs/read_write.c:406 [inline]
  __vfs_read+0x6ac/0x9b0 fs/read_write.c:418
  vfs_read+0x17f/0x3c0 fs/read_write.c:452
  ksys_read+0x101/0x260 fs/read_write.c:578
  __do_sys_read fs/read_write.c:588 [inline]
  __se_sys_read fs/read_write.c:586 [inline]
  __x64_sys_read+0x73/0xb0 fs/read_write.c:586
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x445f69
Code: e8 ac e7 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 fb 0d fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f7f6d9b7da8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 00000000006dbc3c RCX: 0000000000445f69
RDX: 0000000000001000 RSI: 0000000020001000 RDI: 0000000000000006
RBP: 00000000006dbc38 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0030656c69662f2e
R13: 64695f70756f7267 R14: 65646f6d746f6f72 R15: 0000000000000007
Modules linked in:
Dumping ftrace buffer:
    (ftrace buffer empty)
---[ end trace d538f9cc84504f57 ]---
RIP: 0010:process_init_reply+0xedc/0x1500 fs/fuse/inode.c:923
Code: 0f 95 c0 84 c2 0f 85 65 05 00 00 49 8d be 00 01 00 00 80 8b e9 01 00  
00 06 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f  
85 32 05 00 00 49 c7 86 00 01 00 00 a0 7f 16 89 41
RSP: 0018:ffff8801a97cf478 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffff8801cdfdfb40 RCX: 0000000000000001
RDX: 0000000000000020 RSI: ffffffff826e5a3d RDI: 0000000000000100
RBP: ffff8801a97cf4b0 R08: ffff8801b2a625c0 R09: ffffed0039cd05da
R10: ffffed0039cd05da R11: ffff8801ce682ed3 R12: ffff8801ce682e00
R13: ffff8801cdfdfd29 R14: 0000000000000000 R15: ffff8801cdfdfd25
FS:  00007f7f6d9b8700(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f7f6d9d8e78 CR3: 00000001d64ed000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
