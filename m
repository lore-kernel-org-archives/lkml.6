Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti33d1t02-1407096-1528090267-2-7260566291655855374
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1528090267; b=hUzex/79RHr/2i4fJ3CL4n9hiQNuzvcCTSTxBJwIonlJqn1mJ8
    dO5hdA5jd+Qby7mDgvQD9rAhuCB87gr7CeqBMeQA9pBxi7+mlm0sBdVYOXFPN+4u
    ssRXMdAjUcqh3nTGUV52F23cD73HWxE4gyvQEfwwG+hYlN8BhwFqP9RyIKF8FpNE
    ez5z/ZaHl78V+FXCpMudBsVhvZntRLHt0Eq53TXJwv/39mFmeoZ2H9D4xHPIN2qS
    yLoVrrLeeac25e6MVgBAJXYJ7V+EWgx6WBohzNOHNMWf2bp8mT4c6hDX53E/53li
    89KIB22Dr0ZuVYEGY02m7+J+AoBfoe8JVREA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:date:message-id:subject:from
    :to:content-type:sender:list-id; s=fm2; t=1528090267; bh=tq5jEYL
    Puqpt2FPfxg9swghFQsNWqFwlLL09mpwlv0o=; b=RTBVALeCmGv7Td4ypUMDS67
    Kvil/I2tNKG7sQgUShaxCV8hL/+lf+9TOiBh73UMwOrS0lAPHAsAb2MctLICTKGA
    xJUhZSDgmVOriHP22iqKXk85pqtkaoSZtaiZLQjmyb5H1I6WRFBV1xw5AI/lOxmq
    hNmaPlOCLjgpjQroGc3DNcmOjVfVis0cLG8NUeKK+1+wtKx604RQUa6U9tVuN9R0
    YTiyck8/GPGfVor0ygHWOB5YzwEXZGFSp53pUTe1I9ZwvI3aNbuJo9rHNIHZPmtY
    no1l2qgT9J33C9wznxQy1XO9tJSdUwjGcdL6I5vRt9TfE9tfByduMhySkrriSwQ=
    =
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none)
    header.from=syzkaller.appspotmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=Y31oq8ND;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=syzkaller.appspotmail.com header.result=pass
    header_org.domain=appspotmail.com header_org.result=pass
    header_is_org_domain=no;
    x-vs=clean score=49 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none)
      header.from=syzkaller.appspotmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=Y31oq8ND;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=syzkaller.appspotmail.com header.result=pass
      header_org.domain=appspotmail.com header_org.result=pass
      header_is_org_domain=no;
    x-vs=clean score=49 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPahbLD7EtRQ2jn9b7a+3JLhOfJS6HvY6NSwHsP+fAJKSX0GTHx+GtC+CytIPSs6btsUZEySBh7SZoh5uc3ikJYGs3Ug+jltQ4RC5qvBKhubiljki6YL
    ULHrpEhfi68i4XPW0cgVXoJiaX46C6wA31Ema0cf4MwUlqN5LzQO8mTth5kvc6dPET5jE2wmKHb1yEMCWCtDgjm02C1c9tH5viTV1ho1MOKijwyCJmKISXK6
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=7mUfYlMuFuIA:10
    a=VwQbUJbxAAAA:8 a=edf1wS77AAAA:8 a=hSkVLCK3AAAA:8 a=mzoz-TVAAAAA:20
    a=4RBUngkUAAAA:8 a=6WR9MKj8Iv5OXRgAWmQA:9 a=OAta1iC1oRLzIsbK:21
    a=QEXdDO2ut3YA:10 a=vVHabExCe68A:10 a=AjGcO6oz07-iQ99wixmX:22
    a=DcSpbTIhAlouE1Uv7lRv:22 a=cQPPKAXgyycSBL8etih5:22 a=_sbA2Q-Kp09kWB8D3iXc:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751097AbeFDFbD (ORCPT <rfc822;linux@kroah.com>);
        Mon, 4 Jun 2018 01:31:03 -0400
Received: from mail-it0-f70.google.com ([209.85.214.70]:41570 "EHLO
        mail-it0-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750825AbeFDFbC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Jun 2018 01:31:02 -0400
X-Google-Smtp-Source: ADUXVKIyRtxNAq60G4epBNXwk3XexyOf9SDyiqAQ1PmB6r1MKcA7FSPqM0LAnuBVTmDGxHwb5MYHnsLKguNWAy86dPU2PnlqZsdb
MIME-Version: 1.0
Date: Sun, 03 Jun 2018 22:31:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000043195b056dca3dad@google.com>
Subject: BUG: soft lockup in shrink_dcache_parent (2)
From: syzbot <syzbot+be3179e6006280aaf174@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello,

syzbot found the following crash on:

HEAD commit:    325e14f97e0c Merge branch 'fixes' of git://git.kernel.org/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=166329d7800000
kernel config:  https://syzkaller.appspot.com/x/.config?x=968b0b23c7854c0b
dashboard link: https://syzkaller.appspot.com/bug?extid=be3179e6006280aaf174
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+be3179e6006280aaf174@syzkaller.appspotmail.com

watchdog: BUG: soft lockup - CPU#1 stuck for 134s! [syz-executor4:4588]
Modules linked in:
irq event stamp: 76609500
hardirqs last  enabled at (76609499): [<ffffffff81c66ccf>]  
seqcount_lockdep_reader_access include/linux/seqlock.h:83 [inline]
hardirqs last  enabled at (76609499): [<ffffffff81c66ccf>]  
read_seqcount_begin include/linux/seqlock.h:164 [inline]
hardirqs last  enabled at (76609499): [<ffffffff81c66ccf>] read_seqbegin  
include/linux/seqlock.h:433 [inline]
hardirqs last  enabled at (76609499): [<ffffffff81c66ccf>]  
read_seqbegin_or_lock include/linux/seqlock.h:529 [inline]
hardirqs last  enabled at (76609499): [<ffffffff81c66ccf>]  
d_walk+0x80f/0xc80 fs/dcache.c:1248
hardirqs last disabled at (76609500): [<ffffffff87800905>]  
interrupt_entry+0xb5/0xf0 arch/x86/entry/entry_64.S:625
softirqs last  enabled at (468244): [<ffffffff87a00778>]  
__do_softirq+0x778/0xaf5 kernel/softirq.c:311
softirqs last disabled at (468177): [<ffffffff814762c1>] invoke_softirq  
kernel/softirq.c:365 [inline]
softirqs last disabled at (468177): [<ffffffff814762c1>]  
irq_exit+0x1d1/0x200 kernel/softirq.c:405
CPU: 1 PID: 4588 Comm: syz-executor4 Not tainted 4.17.0-rc7+ #81
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:arch_local_irq_restore arch/x86/include/asm/paravirt.h:783  
[inline]
RIP: 0010:seqcount_lockdep_reader_access include/linux/seqlock.h:83 [inline]
RIP: 0010:read_seqcount_begin include/linux/seqlock.h:164 [inline]
RIP: 0010:read_seqbegin include/linux/seqlock.h:433 [inline]
RIP: 0010:read_seqbegin_or_lock include/linux/seqlock.h:529 [inline]
RIP: 0010:d_walk+0x840/0xc80 fs/dcache.c:1248
RSP: 0018:ffff880183f5f9f8 EFLAGS: 00000293 ORIG_RAX: ffffffffffffff13
RAX: ffff8801b0d3c680 RBX: 0000000000000293 RCX: 1ffff100361a79e5
RDX: 0000000000000000 RSI: ffffffff81c66cfb RDI: 0000000000000293
RBP: ffff880183f5fb78 R08: ffff8801b0d3ceb8 R09: 0000000000000006
R10: ffff8801b0d3c680 R11: 0000000000000000 R12: 0000000000000200
R13: dffffc0000000000 R14: 1ffff100307ebf82 R15: ffff880183f5fb50
FS:  000000000217c940(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffca8309eac CR3: 0000000183eb2000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  shrink_dcache_parent+0x179/0x230 fs/dcache.c:1486
  vfs_rmdir+0x202/0x470 fs/namei.c:3855
  do_rmdir+0x523/0x610 fs/namei.c:3916
  __do_sys_rmdir fs/namei.c:3934 [inline]
  __se_sys_rmdir fs/namei.c:3932 [inline]
  __x64_sys_rmdir+0x36/0x40 fs/namei.c:3932
  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x455777
RSP: 002b:00007ffca830a5b8 EFLAGS: 00000206 ORIG_RAX: 0000000000000054
RAX: ffffffffffffffda RBX: 0000000000000065 RCX: 0000000000455777
RDX: 0000000000000000 RSI: 00007ffca830c360 RDI: 00007ffca830c360
RBP: 00007ffca830c360 R08: 0000000000000000 R09: 0000000000000001
R10: 0000000000000006 R11: 0000000000000206 R12: 000000000217d940
R13: 0000000000000000 R14: 0000000000000198 R15: 000000000001f12d
Code: 88 48 89 f8 48 c1 e8 03 42 80 3c 28 00 0f 85 1e 04 00 00 48 83 3d 78  
20 0b 07 00 0f 84 29 02 00 00 e8 e5 d7 b2 ff 48 89 df 57 9d <0f> 1f 44 00  
00 e8 d6 d7 b2 ff 49 8d 5f 80 48 c1 eb 03 4c 01 eb
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 4581 Comm: syz-executor6 Not tainted 4.17.0-rc7+ #81
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:select_collect+0x249/0x5f0 fs/dcache.c:1443
RSP: 0018:ffff880189947908 EFLAGS: 00000286
RAX: 0000000000000000 RBX: ffffed0031328f24 RCX: ffffffff81c5c3b4
RDX: 0000000000000000 RSI: ffffffff81c5c4fa RDI: ffff880189947c28
RBP: ffff8801899479e8 R08: ffff88018993e5c0 R09: ffffed0039dde7a4
R10: ffffed0039dde7a4 R11: ffff8801ceef3d23 R12: 0000000000000000
R13: 1ffff10031328f28 R14: ffff880189947c18 R15: dffffc0000000000
FS:  0000000001790940(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffebea69e9c CR3: 000000018989f000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  d_walk+0x3c3/0xc80 fs/dcache.c:1276
  shrink_dcache_parent+0x179/0x230 fs/dcache.c:1486
  vfs_rmdir+0x202/0x470 fs/namei.c:3855
  do_rmdir+0x523/0x610 fs/namei.c:3916
  __do_sys_rmdir fs/namei.c:3934 [inline]
  __se_sys_rmdir fs/namei.c:3932 [inline]
  __x64_sys_rmdir+0x36/0x40 fs/namei.c:3932
  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x455777
RSP: 002b:00007ffebea6a5a8 EFLAGS: 00000202 ORIG_RAX: 0000000000000054
RAX: ffffffffffffffda RBX: 0000000000000065 RCX: 0000000000455777
RDX: 0000000000000000 RSI: 00007ffebea6c350 RDI: 00007ffebea6c350
RBP: 00007ffebea6c350 R08: 0000000000000000 R09: 0000000000000001
R10: 0000000000000006 R11: 0000000000000202 R12: 0000000001791940
R13: 0000000000000000 R14: 0000000000000192 R15: 000000000001f12b
Code: 0f b6 e4 41 83 c4 01 e8 e6 7f b3 ff 48 b8 00 00 00 00 00 fc ff df 48  
01 c3 44 89 e0 48 c7 03 00 00 00 00 48 c7 43 08 00 00 00 00 <c7> 43 10 00  
00 00 00 48 81 c4 b8 00 00 00 5b 41 5c 41 5d 41 5e


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
