Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1059408-1527326107-2-12586230305224091149
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527326107; b=Pa//5/O90FM7aFDiCASmziJ6kdBN2/hqq6gUvhEicsa04vTDYf
    cTVGcah9ewMUfPn/FxrHbi/sjWbF+UvKCsft16LgZdoHHCumD76T/dLf/rDVmMVC
    OmkCnwOSCIHhCPvpnzjm9t6nEMiBr7eJWkYsJ2WxhfzeJm98QUawOPlYm45UxpfD
    OE5xRLIRN1YUFYkUbpeqK2SSWKZEX06gWwTObsDo+a+n1hBZKOH/8TKH+nLDIWxp
    M0A+sOD5O3VBNFqOoHzcOxGmrg15Kk8zoPDUCm39+ip7T4fvqP+Yv2OKyqUMTc2H
    JX+9nmGYOCDsma6U6qiLrJ15hwu6G90C4yEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:date:message-id:subject:from
    :to:content-type:sender:list-id; s=fm2; t=1527326107; bh=A0xHgnJ
    C4RuX8xcDxB2ZujUcjANo698K0vv1ejsjB4E=; b=RKKa1Owm1ZzuDBkARFDKgsT
    hAhqcjNF1xTvk/Fj4AbSUPJaedgH6b4H9fRiqiBKMZafyre3iVabgXdj9bH2Z8vk
    eRVvnYUl9L6Ox3jfTHDSW7fY4HYNiFyb8D1rQUNPVHSxaYLa9jjnzk5u9Et0KoEp
    DGOy2oCGIYqeLpoJiOMPKP72qHiQf6IgOhPluZLZmdv6c8zViJctwYety7Dn6T/V
    LDLGZSZ0Qo+o+hJI1Ai77ISJuYXQKU8qIqK23CrXAbXKvYI1v83ozQd2R7mLV903
    p0V6PXaZOdfHE5xWLMBvVsxoYKYRycXWo7vLhTGpsGqjOpmyIYuYD453yyhZZdQ=
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
    header.i=@1e100.net header.b=jlpiu5Rz;
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
      header.i=@1e100.net header.b=jlpiu5Rz;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=syzkaller.appspotmail.com header.result=pass
      header_org.domain=appspotmail.com header_org.result=pass
      header_is_org_domain=no;
    x-vs=clean score=49 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEh9b8Nu2/eEUPzyBhI2+rcf8xt90G6OMBJOVbBc4dEUsQsq75QWWILZxeXMTNvhqyxXXHTqVJbikj8E9TatNM8kxzW2lUlFYfG9WaJiPUBLGP6yelAj
    RysflupZ7hCt88bHRa/+hdKwv6Fv6Vw5nV5WAV76dA4biItjY2e03hG8Hl34wHN6uqBp71ldbSwqvMpjpu27nugjlG/Hn8kXxJ6FWk7257ZiRJoA4lTG+YRk
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=edf1wS77AAAA:8 a=hSkVLCK3AAAA:8 a=mzoz-TVAAAAA:20 a=4RBUngkUAAAA:8
    a=42MPjglSIj8MkqavDpkA:9 a=QEXdDO2ut3YA:10 a=vVHabExCe68A:10
    a=DcSpbTIhAlouE1Uv7lRv:22 a=cQPPKAXgyycSBL8etih5:22 a=_sbA2Q-Kp09kWB8D3iXc:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031552AbeEZJPE (ORCPT <rfc822;linux@kroah.com>);
        Sat, 26 May 2018 05:15:04 -0400
Received: from mail-it0-f70.google.com ([209.85.214.70]:39525 "EHLO
        mail-it0-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031380AbeEZJPD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 26 May 2018 05:15:03 -0400
X-Google-Smtp-Source: ADUXVKLlJnoeU/bz5k4+F315zKABFnWJX2GbvqEpQvzYWHH8JlT4Rb63J3+yS56Rea7pTAj3UTyT8KRBJDCu97dl6c815nvjJ7Dv
MIME-Version: 1.0
Date: Sat, 26 May 2018 02:15:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cbd959056d1851ca@google.com>
Subject: general protection fault in wb_workfn (2)
From: syzbot <syzbot+4a7438e774b21ddd8eca@syzkaller.appspotmail.com>
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

HEAD commit:    305bb5521282 Merge tag 'selinux-pr-20180516' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=153eb40f800000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f3b4e30da84ec1ed
dashboard link: https://syzkaller.appspot.com/bug?extid=4a7438e774b21ddd8eca
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+4a7438e774b21ddd8eca@syzkaller.appspotmail.com

binder: 13169:13171 ioctl 40047459 20000000 returned -22
sock: process `syz-executor6' is using obsolete setsockopt SO_BSDCOMPAT
binder: 13169:13202 Acquire 1 refcount change on invalid ref 0 ret -22
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] SMP KASAN
Dumping ftrace buffer:
    (ftrace buffer empty)
Modules linked in:
CPU: 1 PID: 88 Comm: kworker/u4:3 Not tainted 4.17.0-rc5+ #55
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: writeback wb_workfn
RIP: 0010:dev_name include/linux/device.h:1008 [inline]
RIP: 0010:wb_workfn+0x195/0x1740 fs/fs-writeback.c:1937
RSP: 0018:ffff8801d964f270 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff814e0f15
RDX: 000000000000000a RSI: ffffffff81cd221d RDI: 0000000000000050
RBP: ffff8801d964f750 R08: ffff8801d97c6700 R09: ffffed003b5e46c2
R10: ffffed003b5e46c2 R11: ffff8801daf23613 R12: 0000000000000001
R13: 1ffff1003b2c9f37 R14: ffff8801d964f728 R15: ffff8801d6836f18
FS:  0000000000000000(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fec3a840db8 CR3: 00000001b49ae000 CR4: 00000000001426e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  process_one_work+0xc1e/0x1b50 kernel/workqueue.c:2145
  process_scheduled_works kernel/workqueue.c:2205 [inline]
  worker_thread+0xa30/0x1440 kernel/workqueue.c:2284
  kthread+0x345/0x410 kernel/kthread.c:240
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412
Code: fa 48 c1 ea 03 80 3c 02 00 0f 85 ee 13 00 00 48 8b 9b 08 06 00 00 48  
b8 00 00 00 00 00 fc ff df 48 8d 7b 50 48 89 fa 48 c1 ea 03 <80> 3c 02 00  
0f 85 3f 14 00 00 4c 8b 63 50 4d 85 e4 0f 84 a9 0e
RIP: dev_name include/linux/device.h:1008 [inline] RSP: ffff8801d964f270
RIP: wb_workfn+0x195/0x1740 fs/fs-writeback.c:1937 RSP: ffff8801d964f270
---[ end trace baf4ced88bb756b8 ]---


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
