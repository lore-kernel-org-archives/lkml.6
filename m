Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77634C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 15:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49D272081F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 15:39:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49D272081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbeKCAqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 20:46:34 -0400
Received: from mail-it1-f200.google.com ([209.85.166.200]:39509 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbeKCAqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 20:46:33 -0400
Received: by mail-it1-f200.google.com with SMTP id r127-v6so3127472itr.4
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 08:39:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=TQJeSjvRgZOcTuuEkh1XCb/K6hoQGdaoUo4jdQpA694=;
        b=CMzBe5W1uHXXQsw0pv00+5WFYnlyrIADeZpiaO20nHtTkGwxGiJmKyhpkXOTRhbDHd
         xoEznr/vHgEHOi+YJIfaM21aGUkICKsYZUDEX7EglrFVHpk18FaZGbXbTBT5pWenhNJv
         E2XUYrZdwkwttXTyQqv20gENRU8w/niD9VtXwxm6RPXsDvzV4s7Dhe+++00ijSY/AzO8
         LfVeB/N/3Ixto4cZ8Alr9/+FeiAE1WUHUP2l7HBgGmX/wgCq10acipDwezGVin3KEdXY
         ACm+coQgybv0BBI0+ZbCw7A8kOtZ1yf4zFTgNqB9B4ob0Y2TSDUqblt5we2uvBBNcaFW
         /lFQ==
X-Gm-Message-State: AGRZ1gLVQe+2w70/rSjCPQS58STnS2wzUNzS2uA3ZO/53/eQuuQUOJel
        7kBggdsANBuJdKUPmOnDY8Yg02PEzQ5NqVwBp2i/b/0patTq
X-Google-Smtp-Source: AJdET5cDBegSdkadN6kBdzC8MKrzhmJ85NOKi8LLXOCUVynlCaqon5oYwwB8ZIsnYGILC1w6V3CnY8tn2t+2KBy1D2F9jCTbCV1m
MIME-Version: 1.0
X-Received: by 2002:a02:89aa:: with SMTP id p39-v6mr5327330jaj.17.1541173143868;
 Fri, 02 Nov 2018 08:39:03 -0700 (PDT)
Date:   Fri, 02 Nov 2018 08:39:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c71dcf0579b0553f@google.com>
Subject: KASAN: use-after-free Read in ext4_xattr_set_entry (2)
From:   syzbot <syzbot+4a39a025912b265cacef@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    fb1c592cf4c9 Merge tag 'char-misc-4.19-rc7' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11431406400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c0af03fe452b65fb
dashboard link: https://syzkaller.appspot.com/bug?extid=4a39a025912b265cacef
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+4a39a025912b265cacef@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in ext4_xattr_set_entry+0x2f6a/0x3d70  
fs/ext4/xattr.c:1600
Read of size 4 at addr ffff8801a4db491b by task syz-executor0/14364

CPU: 1 PID: 14364 Comm: syz-executor0 Not tainted 4.19.0-rc6+ #51
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c4/0x2b4 lib/dump_stack.c:113
  print_address_description.cold.8+0x9/0x1ff mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.9+0x242/0x309 mm/kasan/report.c:412
  __asan_report_load4_noabort+0x14/0x20 mm/kasan/report.c:432
  ext4_xattr_set_entry+0x2f6a/0x3d70 fs/ext4/xattr.c:1600
  ext4_xattr_ibody_set+0x8a/0x2c0 fs/ext4/xattr.c:2240
  ext4_xattr_set_handle+0xb8f/0x1650 fs/ext4/xattr.c:2394
  ext4_initxattrs+0xbd/0x120 fs/ext4/xattr_security.c:43
  security_inode_init_security+0x1d1/0x3d0 security/security.c:502
  ext4_init_security+0x34/0x40 fs/ext4/xattr_security.c:57
  __ext4_new_inode+0x4a6a/0x65b0 fs/ext4/ialloc.c:1160
  ext4_symlink+0x4b7/0x1130 fs/ext4/namei.c:3093
  vfs_symlink+0x37a/0x5d0 fs/namei.c:4127
  do_symlinkat+0x242/0x2d0 fs/namei.c:4154
  __do_sys_symlink fs/namei.c:4173 [inline]
  __se_sys_symlink fs/namei.c:4171 [inline]
  __x64_sys_symlink+0x59/0x80 fs/namei.c:4171
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4572a7
Code: 64 8b 5d 00 e9 14 fd ff ff 4c 8b 74 24 30 64 c7 45 00 22 00 00 00 bb  
22 00 00 00 e9 fd fc ff ff 0f 1f 00 b8 58 00 00 00 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 bd b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffcaac01628 EFLAGS: 00000206 ORIG_RAX: 0000000000000058
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00000000004572a7
RDX: 00007ffcaac016a7 RSI: 00000000004bcfd0 RDI: 00007ffcaac01690
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000017
R10: 0000000000000075 R11: 0000000000000206 R12: 0000000000000000
R13: 0000000000000001 R14: 0000000000000b01 R15: 0000000000000000

The buggy address belongs to the page:
page:ffffea0006936d00 count:0 mapcount:0 mapping:0000000000000000 index:0x1
flags: 0x2fffc0000000000()
raw: 02fffc0000000000 dead000000000100 dead000000000200 0000000000000000
raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801a4db4800: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
  ffff8801a4db4880: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> ffff8801a4db4900: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                             ^
  ffff8801a4db4980: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
  ffff8801a4db4a00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
