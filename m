Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E79C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 01:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA6D0208E3
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 01:56:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA6D0208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbeKKLnF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 06:43:05 -0500
Received: from mail-it1-f197.google.com ([209.85.166.197]:36742 "EHLO
        mail-it1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbeKKLnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 06:43:05 -0500
Received: by mail-it1-f197.google.com with SMTP id p78-v6so8829382itb.1
        for <linux-kernel@vger.kernel.org>; Sat, 10 Nov 2018 17:56:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=xHkozkC2vQJNLQotC5dTs//LpGQbaBfGWjWB76Ay6uE=;
        b=HL9HrI5ggNNj7Fuw8ARWbTijMig0g8jmWSwnVVuSWJIFMmEOiGkT0o/ciA9KNOWfoR
         z4flD08Q0jeJAOO1Cl9b4DAt3B1CCx/MYrkkTlXk0hUpxZ+E7KTIeayghoC/ioBoiUAS
         ltvUdhxjE99CibOCuvUCHRYE0FwljW4hcHeWvV5lElCbS1BRRhNivEx+odtjE0zplrAe
         oIvwlw4RcRUII8GR4e6jVCfOXPaCPrfrVNJq8SHI4t755Bw3nNujwhuWNJGbO+jt8UX/
         esqolkhAFosXIUeDqs9taF8Su+5ze/9NHJjeH89bLd5CWUt+sB6TGwPQikOVumPljZuk
         l0ig==
X-Gm-Message-State: AGRZ1gJ9lyWNXbTDJrG1j6jmuuhDCvQff0bZ2ul8rTLovkGQpMpe/N3P
        Wj+4Bd0H8I3X2m1uL8syI6NdTrCcPDwPL3a714gsKdVV2MFo
X-Google-Smtp-Source: AJdET5feYes+0kSsg4nZrk+6scDa8TDYG8dq4Jb4Dzzb11wZtEr8uGs1FmF6odj6IyojpPIFstvBGc+si9Qed37gaCA271lkIFBQ
MIME-Version: 1.0
X-Received: by 2002:a24:7f03:: with SMTP id r3-v6mr6416429itc.5.1541901363070;
 Sat, 10 Nov 2018 17:56:03 -0800 (PST)
Date:   Sat, 10 Nov 2018 17:56:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000064bcf057a59e3b9@google.com>
Subject: WARNING in ovl_instantiate
From:   syzbot <syzbot+9c69c282adc4edd2b540@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    442b8cea2477 Add linux-next specific files for 20181109
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=169a6fbd400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2f72bdb11df9fbe8
dashboard link: https://syzkaller.appspot.com/bug?extid=9c69c282adc4edd2b540
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+9c69c282adc4edd2b540@syzkaller.appspotmail.com

WARNING: CPU: 0 PID: 9768 at fs/overlayfs/dir.c:263  
ovl_instantiate+0x369/0x400 fs/overlayfs/dir.c:263
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 9768 Comm: syz-executor2 Not tainted 4.20.0-rc1-next-20181109+  
#110
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
RIP: 0010:ovl_instantiate+0x369/0x400 fs/overlayfs/dir.c:263
Code: c3 89 c6 e8 69 84 ee fe 85 db 0f 85 9e 00 00 00 e8 4c 83 ee fe 4c 89  
e7 45 31 f6 e8 11 18 45 ff e9 ec fe ff ff e8 37 83 ee fe <0f> 0b e9 e0 fe  
ff ff e8 2b 83 ee fe 0f 0b e9 63 ff ff ff e8 1f db
RSP: 0018:ffff88018f31f990 EFLAGS: 00010212
RAX: 0000000000040000 RBX: ffff88018f31fa28 RCX: ffffc90013c02000
RDX: 000000000000a369 RSI: ffffffff82912579 RDI: 0000000000000007
RBP: ffff88018f31fa50 R08: ffff8801bb18a000 R09: ffffed0031e63ee5
R10: ffffed0031e63ee5 R11: 0000000000000003 R12: ffff8801cd1e8300
R13: ffff88018f31f9c8 R14: ffffffffffffff8c R15: 0000000000000000
  ovl_create_over_whiteout fs/overlayfs/dir.c:518 [inline]
  ovl_create_or_link+0xad6/0x1560 fs/overlayfs/dir.c:582
  ovl_create_object+0x2e9/0x3a0 fs/overlayfs/dir.c:616
  ovl_create+0x2b/0x30 fs/overlayfs/dir.c:630
  vfs_create+0x388/0x5b0 fs/namei.c:2912
  do_mknodat+0x410/0x530 fs/namei.c:3766
  __do_sys_mknod fs/namei.c:3795 [inline]
  __se_sys_mknod fs/namei.c:3793 [inline]
  __x64_sys_mknod+0x7b/0xb0 fs/namei.c:3793
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457569
Code: fd b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f2126d09c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000085
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457569
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000340
RBP: 000000000072bfa0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f2126d0a6d4
R13: 00000000004c2a6e R14: 00000000004d4110 R15: 00000000ffffffff
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
