Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id XuCqHVd2GVt6FgAAmS7hNA
	; Thu, 07 Jun 2018 18:17:10 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 26339608BA; Thu,  7 Jun 2018 18:17:10 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,FROM_LOCAL_HEX,
	MAILING_LIST_MULTI autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 7C9076074D;
	Thu,  7 Jun 2018 18:17:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7C9076074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936228AbeFGSRI (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 14:17:08 -0400
Received: from mail-it0-f70.google.com ([209.85.214.70]:37281 "EHLO
        mail-it0-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935297AbeFGSRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 14:17:02 -0400
Received: by mail-it0-f70.google.com with SMTP id p130-v6so8569206itp.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 11:17:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=ktSKA17LAA4/Pu89Wmt7p3bX1NctNFJviAh/vbefD3Q=;
        b=XgN6f0+AN08/DUFELrhrYflk8/7mCEpzvjWY1ZsDBiGqgOXDYgRyKQfsr2ZQzPeZiE
         XB3oepolv+3zKfvK4D7RoM46iFS9XCIq1+60Uzj/hVxtx+rdBCvyhapASAdy8vfAct80
         QgN5resgS1LIOsY5mwzTA9thNeKIjVq61QSY8Ri7a8dyQnGz8hc5gKiXtiG3j8RQCh7Q
         6qyv35xx/z9g/aDHstmtQARcLux8au9c7lobJ3frPeAeL+Kkgg2RurW258HQtWKRl+8+
         oLGnfYuph2j3J5pAXWOoq6GWkSTev1TdxhSuKTEJptC0f60fD0/pxlhL2VW/jAXa5Tqb
         IjWA==
X-Gm-Message-State: APt69E0ad/kBR0kPt6EmJcExLbp0IQhSvCrx0vRZgQcfuYpH55AwK/ng
        c1y/VTpZciFNgWlshRr9474BC9OLUYfdokMjpFn0TZQ7FNuM
X-Google-Smtp-Source: ADUXVKKo+DnRGcV9VbT2CgGpoaJK3okndrMEhA31/4KilnuoVWSvrOfrSmM/1FBfK1UIuSNHjnAbQHlho61U9dUD9NbqwIkFcxSv
MIME-Version: 1.0
X-Received: by 2002:a24:7d91:: with SMTP id b139-v6mr1555448itc.6.1528395422216;
 Thu, 07 Jun 2018 11:17:02 -0700 (PDT)
Date: Thu, 07 Jun 2018 11:17:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000037bf29056e114a86@google.com>
Subject: KASAN: null-ptr-deref Write in xdp_umem_unaccount_pages
From: syzbot <syzbot+979217770b09ebf5c407@syzkaller.appspotmail.com>
To: bjorn.topel@intel.com, davem@davemloft.net,
        linux-kernel@vger.kernel.org, magnus.karlsson@intel.com,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    1c8c5a9d38f6 Merge git://git.kernel.org/pub/scm/linux/kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13a72bdf800000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4f1acdf888c9d4e9
dashboard link: https://syzkaller.appspot.com/bug?extid=979217770b09ebf5c407
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=12aca2af800000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=161d4ddf800000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+979217770b09ebf5c407@syzkaller.appspotmail.com

RDX: 0000000000000004 RSI: 000000000000011b RDI: 0000000000000004
RBP: 00000000006cb018 R08: 0000000000000018 R09: 00007fffc4750032
R10: 0000000020000040 R11: 0000000000000246 R12: 0000000000000005
R13: ffffffffffffffff R14: 0000000000000000 R15: 0000000000000000
==================================================================
BUG: KASAN: null-ptr-deref in atomic64_sub  
include/asm-generic/atomic-instrumented.h:144 [inline]
BUG: KASAN: null-ptr-deref in atomic_long_sub  
include/asm-generic/atomic-long.h:199 [inline]
BUG: KASAN: null-ptr-deref in xdp_umem_unaccount_pages.isra.4+0x3d/0x80  
net/xdp/xdp_umem.c:135
Write of size 8 at addr 0000000000000060 by task syz-executor246/4527

CPU: 1 PID: 4527 Comm: syz-executor246 Not tainted 4.17.0+ #89
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
  atomic64_sub include/asm-generic/atomic-instrumented.h:144 [inline]
  atomic_long_sub include/asm-generic/atomic-long.h:199 [inline]
  xdp_umem_unaccount_pages.isra.4+0x3d/0x80 net/xdp/xdp_umem.c:135
  xdp_umem_reg net/xdp/xdp_umem.c:334 [inline]
  xdp_umem_create+0xd6c/0x10f0 net/xdp/xdp_umem.c:349
  xsk_setsockopt+0x443/0x550 net/xdp/xsk.c:531
  __sys_setsockopt+0x1bd/0x390 net/socket.c:1935
  __do_sys_setsockopt net/socket.c:1946 [inline]
  __se_sys_setsockopt net/socket.c:1943 [inline]
  __x64_sys_setsockopt+0xbe/0x150 net/socket.c:1943
  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x440549
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 5b 14 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fffc475d008 EFLAGS: 00000246 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000440549
RDX: 0000000000000004 RSI: 000000000000011b RDI: 0000000000000004
RBP: 00000000006cb018 R08: 0000000000000018 R09: 00007fffc4750032
R10: 0000000020000040 R11: 0000000000000246 R12: 0000000000000005
R13: ffffffffffffffff R14: 0000000000000000 R15: 0000000000000000
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
