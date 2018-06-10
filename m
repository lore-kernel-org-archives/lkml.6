Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id UDRyCdnAHFuBKgAAmS7hNA
	; Sun, 10 Jun 2018 06:27:09 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 706CD60850; Sun, 10 Jun 2018 06:27:09 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=2.0 tests=BAYES_00,FROM_LOCAL_HEX,
	MAILING_LIST_MULTI,SORTED_RECIPS autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id A93EA604D4;
	Sun, 10 Jun 2018 06:27:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A93EA604D4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932212AbeFJG1E (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sun, 10 Jun 2018 02:27:04 -0400
Received: from mail-it0-f69.google.com ([209.85.214.69]:57112 "EHLO
        mail-it0-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932138AbeFJG1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 02:27:03 -0400
Received: by mail-it0-f69.google.com with SMTP id g4-v6so2194081itf.6
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jun 2018 23:27:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=mZAkaT8Iob65TMn85BxgUd46qFcB2d+Rd114/794bXo=;
        b=jick/AOKAwqvyag3xt6O6Aont4qkoeEnwfCBaD+lImuNe/hGB8z5+4run8IAfd0nSF
         1+Eisqr2as9Fr/wdi7WM0+r8Fhpr/PqLQXqEc231lhl/bIjAji7X4KTudJ3lqTcGDn5T
         L/YJmiSLLkII9bGod+vLWduNdO07uzFxnmYZGXrbkqOb/4mZaXTg9nsNDzq/iEmvDHnf
         2UHhDyQPC8uyWPPaDgmfS3zHxV2gLxK6Ekd6wVnWfzV40WBbXWi3MsrhRYxltjPugGIt
         9mwBX49w3zxgukQqf5Isop3ceoCuRaV3TAEFylJwVf22KqBLPOQnJ4Fh133PvIWFRVgN
         s0qw==
X-Gm-Message-State: APt69E2Ly1v9E8bRlwX2SHVT3mhYCFCQasPF1n0WKoaqWvHL9EbtaUYj
        Gme93eqewXndzTSqItC2Mbu+2t5V0q8ltEsiGugpEeIhaVb+
X-Google-Smtp-Source: ADUXVKIiyBRktgJJ0yL9MF+U+O5uITD/ITCf0bBBQi1XfH2W+Dy7q64VPkbK3i5H0D6IEBAfM1+8b8i5s8b8u+R1Kfn5vMjAy9Sq
MIME-Version: 1.0
X-Received: by 2002:a6b:bb42:: with SMTP id l63-v6mr6017841iof.101.1528612022736;
 Sat, 09 Jun 2018 23:27:02 -0700 (PDT)
Date: Sat, 09 Jun 2018 23:27:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009d5f42056e43b822@google.com>
Subject: WARNING in ion_dma_buf_begin_cpu_access
From: syzbot <syzbot+55b1d9f811650de944c6@syzkaller.appspotmail.com>
To: arve@android.com, devel@driverdev.osuosl.org,
        dri-devel@lists.freedesktop.org, gregkh@linuxfoundation.org,
        labbott@redhat.com, linaro-mm-sig@lists.linaro.org,
        linux-kernel@vger.kernel.org, maco@android.com,
        sumit.semwal@linaro.org, syzkaller-bugs@googlegroups.com,
        tkjos@android.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    a16afaf7928b Merge tag 'for-v4.18' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1480e36f800000
kernel config:  https://syzkaller.appspot.com/x/.config?x=314f2150f36c16ca
dashboard link: https://syzkaller.appspot.com/bug?extid=55b1d9f811650de944c6
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=150b8abf800000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1204efdf800000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+55b1d9f811650de944c6@syzkaller.appspotmail.com

1965969 pages RAM
0 pages HighMem/MovableOnly
340001 pages reserved
------------[ cut here ]------------
heap->ops->map_kernel should return ERR_PTR on error
WARNING: CPU: 1 PID: 4564 at drivers/staging/android/ion/ion.c:148  
ion_buffer_kmap_get drivers/staging/android/ion/ion.c:147 [inline]
WARNING: CPU: 1 PID: 4564 at drivers/staging/android/ion/ion.c:148  
ion_dma_buf_begin_cpu_access+0x48e/0x5a0  
drivers/staging/android/ion/ion.c:328
Kernel panic - not syncing: panic_on_warn set ...

CPU: 1 PID: 4564 Comm: syz-executor145 Not tainted 4.17.0+ #93
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
  panic+0x22f/0x4de kernel/panic.c:184
  __warn.cold.8+0x163/0x1b3 kernel/panic.c:536
  report_bug+0x252/0x2d0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:178 [inline]
  do_error_trap+0x1fc/0x4d0 arch/x86/kernel/traps.c:296
  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:316
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:992
RIP: 0010:ion_buffer_kmap_get drivers/staging/android/ion/ion.c:147 [inline]
RIP: 0010:ion_dma_buf_begin_cpu_access+0x48e/0x5a0  
drivers/staging/android/ion/ion.c:328
Code: ff 41 bc ea ff ff ff 89 de e8 8e b0 ba fb 84 db 75 a8 e8 b5 af ba fb  
48 c7 c7 00 05 68 88 c6 05 39 8d d9 03 01 e8 02 c7 86 fb <0f> 0b eb 8c 48  
c7 c7 40 09 ef 88 e8 12 a3 f7 fb e9 15 ff ff ff e8
RSP: 0018:ffff8801ac87fb08 EFLAGS: 00010286
RAX: 0000000000000034 RBX: 0000000000000000 RCX: ffffffff816191ea
RDX: 0000000000000000 RSI: ffffffff8161f4e1 RDI: ffff8801ac87f7e0
RBP: ffff8801ac87fb60 R08: ffff8801d8856480 R09: 0000000000000006
R10: ffff8801d8856480 R11: 0000000000000000 R12: 00000000ffffffea
R13: ffff8801d977d148 R14: 0000000000000001 R15: ffffffff89724b80
  dma_buf_begin_cpu_access+0x7f/0x160 drivers/dma-buf/dma-buf.c:823
  dma_buf_ioctl+0x1aa/0x240 drivers/dma-buf/dma-buf.c:314
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:500 [inline]
  do_vfs_ioctl+0x1cf/0x16f0 fs/ioctl.c:684
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:701
  __do_sys_ioctl fs/ioctl.c:708 [inline]
  __se_sys_ioctl fs/ioctl.c:706 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:706
  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x440479
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 5b 14 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fff6df8d2f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000440479
RDX: 0000000020fd3ff8 RSI: 0000000040086200 RDI: 0000000000000004
RBP: 00000000006cb018 R08: 0000000000000001 R09: 00007fff6df80031
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000005
R13: ffffffffffffffff R14: 0000000000000000 R15: 0000000000000000
Dumping ftrace buffer:
    (ftrace buffer empty)
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
