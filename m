Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id rjM5BiovGVvuKQAAmS7hNA
	; Thu, 07 Jun 2018 13:12:10 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 069B5608BA; Thu,  7 Jun 2018 13:12:10 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=2.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEXHASH_WORD,MAILING_LIST_MULTI autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 4DF15601C3;
	Thu,  7 Jun 2018 13:12:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4DF15601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932526AbeFGNMH (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 09:12:07 -0400
Received: from mail-io0-f197.google.com ([209.85.223.197]:35047 "EHLO
        mail-io0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753285AbeFGNMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 09:12:03 -0400
Received: by mail-io0-f197.google.com with SMTP id r16-v6so7494126ioj.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 06:12:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=B3nJNrqrbkjdBWajg4dpMf69xlgTcUz0ZCt7pfGNBrM=;
        b=rB2giTf0ouOZyA/DH2h4dwl0Wgl1qZU1D4dQ2o6+DWJ3e6eaH5ji0Mx/HKJqw59tif
         3zH+kCz5ZSznV804SIRRnCPHNq6n2EJ/6ljRIMnGcCl/aHWsp7cgxpQmWGyK0nht7sAl
         OaY2w+GEHdOyVeiXwG6z6gqDakXr/DbcM4K1LnrSRM4DhnBkr/8jgSYjJz5Xvu9OBPL+
         6b8Rr/WGi/0DxsN+csUfhoJjwLMVXqHOolHzgwDezUYFL3bjGhaBqrVKI8G/n9LQyJxa
         8MCcvZe8d2jg9Y3FsAxppiIUEOjsKc6Vx7iJV0FnQE1M+okMhq52jYBOokmIcnZidzn7
         X4XQ==
X-Gm-Message-State: APt69E1EDZIn+NHwhiM7RuGGw1IddNtKiRuVj7Q4Pev+WCMk0T+Daz6l
        etRmaELqT2lAQIwaUY0p6mfX3gdu4OtvIiquFS8g5CDtGfB5
X-Google-Smtp-Source: ADUXVKLbRrdWedYrBA9F3UJqT2lOlyEHLmmdlbCQFYpQuVoShi0vZaIGRFiqvc5A7z3/pf4Pli0KmltFmDDS22DqEULuz8z1AbMG
MIME-Version: 1.0
X-Received: by 2002:a6b:d407:: with SMTP id l7-v6mr746570iog.109.1528377122610;
 Thu, 07 Jun 2018 06:12:02 -0700 (PDT)
Date: Thu, 07 Jun 2018 06:12:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000079e595056e0d0796@google.com>
Subject: KASAN: slab-out-of-bounds Write in sha256_final
From: syzbot <syzbot+8a608baf8751184ec727@syzkaller.appspotmail.com>
To: davem@davemloft.net, herbert@gondor.apana.org.au,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    1c8c5a9d38f6 Merge git://git.kernel.org/pub/scm/linux/kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12cca2af800000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2e1a31e8576e013a
dashboard link: https://syzkaller.appspot.com/bug?extid=8a608baf8751184ec727
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+8a608baf8751184ec727@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in put_unaligned_be32  
include/linux/unaligned/access_ok.h:60 [inline]
BUG: KASAN: slab-out-of-bounds in sha256_base_finish  
include/crypto/sha256_base.h:124 [inline]
BUG: KASAN: slab-out-of-bounds in sha256_final+0x303/0x380  
crypto/sha256_generic.c:253
Write of size 4 at addr ffff8801ce26f060 by task syz-executor1/7811

CPU: 0 PID: 7811 Comm: syz-executor1 Not tainted 4.17.0+ #88
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
  print_address_description+0x6c/0x20b mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
  __asan_report_store4_noabort+0x17/0x20 mm/kasan/report.c:437
  put_unaligned_be32 include/linux/unaligned/access_ok.h:60 [inline]
  sha256_base_finish include/crypto/sha256_base.h:124 [inline]
  sha256_final+0x303/0x380 crypto/sha256_generic.c:253
  crypto_shash_final+0x104/0x260 crypto/shash.c:152
  kdf_ctr security/keys/dh.c:186 [inline]
  keyctl_dh_compute_kdf security/keys/dh.c:217 [inline]
  __keyctl_dh_compute+0x1184/0x1bc0 security/keys/dh.c:389
  keyctl_dh_compute+0xb9/0x100 security/keys/dh.c:425
  __do_sys_keyctl security/keys/keyctl.c:1741 [inline]
  __se_sys_keyctl security/keys/keyctl.c:1637 [inline]
  __x64_sys_keyctl+0x12a/0x3b0 security/keys/keyctl.c:1637
  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x455a09
Code: 1d ba fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 eb b9 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fc9dbbc5c68 EFLAGS: 00000246 ORIG_RAX: 00000000000000fa
RAX: ffffffffffffffda RBX: 00007fc9dbbc66d4 RCX: 0000000000455a09
RDX: 0000000020000080 RSI: 00000000200001c0 RDI: 0000000000000017
RBP: 000000000072bea0 R08: 0000000020000200 R09: 0000000000000000
R10: 0000000000000005 R11: 0000000000000246 R12: 00000000ffffffff
R13: 0000000000000499 R14: 00000000006fbef8 R15: 0000000000000000

Allocated by task 7811:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:553
  __do_kmalloc mm/slab.c:3718 [inline]
  __kmalloc+0x14e/0x760 mm/slab.c:3727
  kmalloc include/linux/slab.h:518 [inline]
  keyctl_dh_compute_kdf security/keys/dh.c:211 [inline]
  __keyctl_dh_compute+0xfe9/0x1bc0 security/keys/dh.c:389
  keyctl_dh_compute+0xb9/0x100 security/keys/dh.c:425
  __do_sys_keyctl security/keys/keyctl.c:1741 [inline]
  __se_sys_keyctl security/keys/keyctl.c:1637 [inline]
  __x64_sys_keyctl+0x12a/0x3b0 security/keys/keyctl.c:1637
  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 2819:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xd9/0x260 mm/slab.c:3813
  single_release+0x8f/0xb0 fs/seq_file.c:609
  __fput+0x353/0x890 fs/file_table.c:209
  ____fput+0x15/0x20 fs/file_table.c:243
  task_work_run+0x1e4/0x290 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:192 [inline]
  exit_to_usermode_loop+0x2bd/0x310 arch/x86/entry/common.c:166
  prepare_exit_to_usermode arch/x86/entry/common.c:196 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:265 [inline]
  do_syscall_64+0x6ac/0x800 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8801ce26f040
  which belongs to the cache kmalloc-32 of size 32
The buggy address is located 0 bytes to the right of
  32-byte region [ffff8801ce26f040, ffff8801ce26f060)
The buggy address belongs to the page:
page:ffffea0007389bc0 count:1 mapcount:0 mapping:ffff8801ce26f000  
index:0xffff8801ce26ffc1
flags: 0x2fffc0000000100(slab)
raw: 02fffc0000000100 ffff8801ce26f000 ffff8801ce26ffc1 000000010000003f
raw: ffffea000739d360 ffff8801da801248 ffff8801da8001c0 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801ce26ef00: 00 fc fc 00 00 00 00 00 fc fc 00 00 00 00 00 fc
  ffff8801ce26ef80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ffff8801ce26f000: fb fb fb fb fc fc fc fc 00 00 00 00 fc fc fc fc
                                                        ^
  ffff8801ce26f080: 05 fc fc fc fc fc fc fc fb fb fb fb fc fc fc fc
  ffff8801ce26f100: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
