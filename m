Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id WatoFMouGVvuKAAAmS7hNA
	; Thu, 07 Jun 2018 13:12:08 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id D1250608B8; Thu,  7 Jun 2018 13:12:08 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=2.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEXHASH_WORD,MAILING_LIST_MULTI autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 2CE45601D2;
	Thu,  7 Jun 2018 13:12:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2CE45601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753595AbeFGNMG (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 09:12:06 -0400
Received: from mail-it0-f71.google.com ([209.85.214.71]:37310 "EHLO
        mail-it0-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753125AbeFGNMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 09:12:02 -0400
Received: by mail-it0-f71.google.com with SMTP id p130-v6so7887085itp.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 06:12:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=38bmzoEfMRs/8Yfw57Cy1/ViPPhOApVotM6zMV/b2JQ=;
        b=AYxvAM6lRERU7uBu/KVeEjuPdqAEse98iffoGXm8bPg037+dsDYFkM3E+P3WXwdAH4
         Tdx1gSgeXmMfYtwUFeByrxQrG7H/UCok2FW4mJvhrkfr2nNfjp6EDa9bpzPx90zdCCvm
         eF2v5PdjaH+CbpvWeYATrFYHcOHPBS3emU5c03Hg8mRHBUgHpbsKNNaJlP6CwDeUGFQF
         0EQ6r6UYZ5BccwE+g4q/vsZEpSJYCjDEf1+yeHzYqZJ8hTae6vGtpEv2p5ZtNU5XlEmw
         JAMmU+k37Wb7SSTFGJQtJ5pGeec0R5iZhPfCM2egYWR7oiAEiJtqN1agYTMGAyrWRsOL
         0lEA==
X-Gm-Message-State: APt69E2sH0snJSrsvKgcQ391CX/8V7kZXb9m5+jiT/UWjGNTsj1N91ZW
        LGrdRX8PdIrN5qgVcFhcQaqRcvd8bxBljo7MfKwH57qAuOg4
X-Google-Smtp-Source: ADUXVKK85hIbeKsLuZy0b7mgNubr/1G5ejNIzVwFfSXiSorwgpDqGz5SPp1Le41syAtl8SbfGPfRl1KUbJyq2YBe2/cBq2IH5RDX
MIME-Version: 1.0
X-Received: by 2002:a6b:9e01:: with SMTP id h1-v6mr756066ioe.62.1528377122337;
 Thu, 07 Jun 2018 06:12:02 -0700 (PDT)
Date: Thu, 07 Jun 2018 06:12:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000075cc63056e0d0707@google.com>
Subject: KASAN: slab-out-of-bounds Write in rmd160_final
From: syzbot <syzbot+d04e58bd384f1fe0b112@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=17f025df800000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2e1a31e8576e013a
dashboard link: https://syzkaller.appspot.com/bug?extid=d04e58bd384f1fe0b112
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+d04e58bd384f1fe0b112@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in rmd160_final+0x201/0x240  
crypto/rmd160.c:334
Write of size 4 at addr ffff8801b00585d8 by task syz-executor1/15928

CPU: 0 PID: 15928 Comm: syz-executor1 Not tainted 4.17.0+ #88
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
  print_address_description+0x6c/0x20b mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
  __asan_report_store4_noabort+0x17/0x20 mm/kasan/report.c:437
  rmd160_final+0x201/0x240 crypto/rmd160.c:334
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
RSP: 002b:00007f2e9de49c68 EFLAGS: 00000246 ORIG_RAX: 00000000000000fa
RAX: ffffffffffffffda RBX: 00007f2e9de4a6d4 RCX: 0000000000455a09
RDX: 0000000020a53ffb RSI: 0000000020000140 RDI: 0000000000000017
RBP: 000000000072bea0 R08: 0000000020c61fc8 R09: 0000000000000000
R10: 0000000000000005 R11: 0000000000000246 R12: 00000000ffffffff
R13: 0000000000000499 R14: 00000000006fbef8 R15: 0000000000000000

Allocated by task 15928:
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

Freed by task 4605:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xd9/0x260 mm/slab.c:3813
  kvfree+0x61/0x70 mm/util.c:440
  translate_table+0xc24/0x1780 net/ipv4/netfilter/ip_tables.c:714
  do_replace net/ipv4/netfilter/ip_tables.c:1138 [inline]
  do_ipt_set_ctl+0x3c7/0x645 net/ipv4/netfilter/ip_tables.c:1674
  nf_sockopt net/netfilter/nf_sockopt.c:106 [inline]
  nf_setsockopt+0x7d/0xd0 net/netfilter/nf_sockopt.c:115
  ip_setsockopt+0xd8/0xf0 net/ipv4/ip_sockglue.c:1258
  tcp_setsockopt+0x93/0xe0 net/ipv4/tcp.c:3047
  sock_common_setsockopt+0x9a/0xe0 net/core/sock.c:3053
  __sys_setsockopt+0x1bd/0x390 net/socket.c:1935
  __do_sys_setsockopt net/socket.c:1946 [inline]
  __se_sys_setsockopt net/socket.c:1943 [inline]
  __x64_sys_setsockopt+0xbe/0x150 net/socket.c:1943
  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8801b00585c0
  which belongs to the cache kmalloc-32 of size 32
The buggy address is located 24 bytes inside of
  32-byte region [ffff8801b00585c0, ffff8801b00585e0)
The buggy address belongs to the page:
page:ffffea0006c01600 count:1 mapcount:0 mapping:ffff8801b0058000  
index:0xffff8801b0058fc1
flags: 0x2fffc0000000100(slab)
raw: 02fffc0000000100 ffff8801b0058000 ffff8801b0058fc1 0000000100000031
raw: ffffea00073f66a0 ffffea0007209620 ffff8801da8001c0 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801b0058480: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
  ffff8801b0058500: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
> ffff8801b0058580: 05 fc fc fc fc fc fc fc 00 00 00 fc fc fc fc fc
                                                     ^
  ffff8801b0058600: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
  ffff8801b0058680: 00 00 01 fc fc fc fc fc 00 00 03 fc fc fc fc fc
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
