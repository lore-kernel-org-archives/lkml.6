Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1981440-1525535229-2-8600646325943274248
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525535229; b=Ppo4GIT71SnvKaFG2swn0J/WAO7m7QTy4j6MkUfzPJ2m4KChxf
    iecHKe9ZIMVlu4tuKQYhh8fogqVIyRT7Mcpx0ArGEpUT31lmQq5t+NXjIOnx99AG
    RNQObW0sa6Kp7loIcybjXZAyCcuMEc4vKQfD/NVR+Bdwpwwph7ww7qjngH/D0r7K
    enr5a7KI8dbSvngjlk/1veiXAhu095a9O0mK65fSfv+hmPvbkVlQYG1GqhqnTHbO
    pZ6zr3ADTBr7kqhRh4UUlkwf6zneje3sB12WO7ebvHaXjPE8F5I+hwHNj53+xIHa
    2Li9StChN/pRkFHp1eGWTxKGeJNwEGTX0cwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:date:message-id:subject:from
    :to:content-type:sender:list-id; s=fm2; t=1525535229; bh=BVZ6Lwc
    ksH3moHb0wZn9S6kZv5UIHO9ThrrKxbbO2ks=; b=jxRF7t6wqDeWnRb1VPUBgO0
    S31MM2pW7NldHKbzkjdZ6Ko3Jw/R5Yyf3aDnTumUaCgEbfyNjSuOw4PeaMMbW6fE
    PCWQyir9w1MG5BgL2NpKUw0HLD2oD2Z/ZxYUgDTEOfonj0d/MTVoAIFzNH9uKIEd
    V9S3upA/69dTgFeSE9XzyV3tURx0pw4GhsWsnCVu55Tb+boUrwS0kmzP0eIDBa5H
    6JAIWE1cWFtYpOezlUPMTLgfWCmS/89qRwke6KrhCBYWKmINySnp/UwyoC8M15iQ
    CsY6QCd428ZP5uNW5SO/lOjPjpMPntfNjkK/BwHWrBBu9SYvXTUhLlPIMGH+UTw=
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
    header.i=@1e100.net header.b=lFeWFfKe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
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
      header.i=@1e100.net header.b=lFeWFfKe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=syzkaller.appspotmail.com header.result=pass
      header_org.domain=appspotmail.com header_org.result=pass
      header_is_org_domain=no;
    x-vs=clean score=49 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGvQp4pbsWVRLXvJRWbmvMOv5g6U2+aCnJDV+cHritY0gUyLCC4YCUlb4LIhUUX+eu58XI3hJThWf9AeBqHxas4RH0KsRX0kk55GXD9f6kZRGl0aIqEF
    pu6WmqAVvn/r8RaXz7figy9vl0lds7Ck28U1lByJ5VfTqa2QLJVzbC7+476xtI2gDJfatKqTBQoixkXFoeDw2c2wqXJU9mQuARMe+sam9YfEhDYj8dCxipdJ
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=edf1wS77AAAA:8 a=hSkVLCK3AAAA:8 a=mzoz-TVAAAAA:20 a=4RBUngkUAAAA:8
    a=hXGII_ervTZYTjFEORMA:9 a=3mAEGIRFl-Ih8bHf:21 a=QEXdDO2ut3YA:10
    a=vVHabExCe68A:10 a=DcSpbTIhAlouE1Uv7lRv:22 a=cQPPKAXgyycSBL8etih5:22
    a=_sbA2Q-Kp09kWB8D3iXc:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751248AbeEEPrE (ORCPT <rfc822;linux@kroah.com>);
        Sat, 5 May 2018 11:47:04 -0400
Received: from mail-io0-f197.google.com ([209.85.223.197]:55521 "EHLO
        mail-io0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751193AbeEEPrD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 May 2018 11:47:03 -0400
X-Google-Smtp-Source: AB8JxZp8RGWhZlcnlQMeophH9kRJEMMMBFWEKbFLg6KjLcP9rX9xl3oz//KSmIEaN56K+2uEHbgWnVBk/MXYEKdVT3w0eeOiZnee
MIME-Version: 1.0
Date: Sat, 05 May 2018 08:47:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000005aaf6056b7759ba@google.com>
Subject: KASAN: null-ptr-deref Write in simple_write_to_buffer
From: syzbot <syzbot+ae590932da6e45d6564d@syzkaller.appspotmail.com>
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

HEAD commit:    c1c07416cdd4 Merge tag 'kbuild-fixes-v4.17' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17912237800000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5a1dc06635c10d27
dashboard link: https://syzkaller.appspot.com/bug?extid=ae590932da6e45d6564d
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=108c8e07800000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=142f907b800000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+ae590932da6e45d6564d@syzkaller.appspotmail.com

random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
Restarting kernel threads ... done.
==================================================================
BUG: KASAN: null-ptr-deref in _copy_from_user+0x100/0x150 lib/usercopy.c:12
Write of size 32 at addr 0000000000000020 by task syz-executor101/4498

CPU: 1 PID: 4498 Comm: syz-executor101 Not tainted 4.17.0-rc3+ #34
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
  kasan_report_error mm/kasan/report.c:352 [inline]
  kasan_report.cold.7+0x6d/0x2fe mm/kasan/report.c:412
  check_memory_region_inline mm/kasan/kasan.c:260 [inline]
  check_memory_region+0x13e/0x1b0 mm/kasan/kasan.c:267
  kasan_check_write+0x14/0x20 mm/kasan/kasan.c:278
  _copy_from_user+0x100/0x150 lib/usercopy.c:12
  copy_from_user include/linux/uaccess.h:147 [inline]
  simple_write_to_buffer+0xaf/0x130 fs/libfs.c:669
  snapshot_write+0x16d/0x270 kernel/power/user.c:189
  __vfs_write+0x10b/0x960 fs/read_write.c:485
  vfs_write+0x1f8/0x560 fs/read_write.c:549
  ksys_write+0xf9/0x250 fs/read_write.c:598
  __do_sys_write fs/read_write.c:610 [inline]
  __se_sys_write fs/read_write.c:607 [inline]
  __x64_sys_write+0x73/0xb0 fs/read_write.c:607
  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4455a9
RSP: 002b:00007f973a88ada8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00000000006dac24 RCX: 00000000004455a9
RDX: 0000000000000020 RSI: 0000000020000040 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dac20
R13: 616e732f7665642f R14: 00007f973a88b9c0 R15: 0000000000000003
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report.
If you forgot to add the Reported-by tag, once the fix for this bug is  
merged
into any tree, please reply to this email with:
#syz fix: exact-commit-title
If you want to test a patch for this bug, please reply with:
#syz test: git://repo/address.git branch
and provide the patch inline or as an attachment.
To mark this as a duplicate of another syzbot report, please reply with:
#syz dup: exact-subject-of-another-report
If it's a one-off invalid bug report, please reply with:
#syz invalid
Note: if the crash happens again, it will cause creation of a new bug  
report.
Note: all commands must start from beginning of the line in the email body.
