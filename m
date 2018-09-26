Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A8CFC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 07:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BAA620843
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 07:52:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BAA620843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbeIZODn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 10:03:43 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:37667 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbeIZODn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 10:03:43 -0400
Received: by mail-io1-f69.google.com with SMTP id r18-v6so39010246ioj.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 00:52:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=eFRpXEomBuuI7IyRi9qy+HJ0haPCVGotqyVBq2bpDBY=;
        b=j8pfRlwjP6haZjeeKJIzWsttc/ueHTxRnuEjBMHnkUWdtPGcSUXjj3NBEOEDcxOQPX
         dh5hJbPS50VzB3E63jJWXy3rcolU8iqBCqISkmmIWkfJAAqMh8/DN2DNrH8L8x1/b5b+
         i622FYALgeg1MHvtMzKS13uiuiX5WepJBcLVJa1eaq2abo7JYlFY4pjkqvWolj8mr50W
         yhKNFhNtnGDyDbCEcigyw12QA8nwcCBsLdvdpaX3FUjtgT1f0qSPaUjxkHy857wMkFhE
         Rob2KmonrRhO2KyaoT9MAdWRIFEV3G3it3SbghaDUo4io50Gj12Ht77An7Nkb7uakyU6
         jiOQ==
X-Gm-Message-State: ABuFfoiR+pAOHJeZsjgPewEAYK2WLUgNYOIEqHB0DViHsUK5+k/MdLEx
        jNZJkI8z9C6CMQMKLhXlov4jZg0/P2r3flD9Y9oD2LUPPc+g
X-Google-Smtp-Source: ACcGV61DETIMvItVZEZkxajA4o4291qKkQmG5fBYTGFzdSj/Lsi3ieCC0AiHPyIGPOnasrVfd/AHK/d3r2PIseBEifT3dZR6hjxt
MIME-Version: 1.0
X-Received: by 2002:a24:a85:: with SMTP id 127-v6mr3385465itw.9.1537948324587;
 Wed, 26 Sep 2018 00:52:04 -0700 (PDT)
Date:   Wed, 26 Sep 2018 00:52:04 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000091f2660576c17fab@google.com>
Subject: KASAN: stack-out-of-bounds Read in __aa_lookupn_ns
From:   syzbot <syzbot+61e4b490d9d2da591b50@syzkaller.appspotmail.com>
To:     jmorris@namei.org, john.johansen@canonical.com,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, serge@hallyn.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    02214bfc89c7 Merge tag 'media/v4.19-2' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=159b85f1400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=22a62640793a83c9
dashboard link: https://syzkaller.appspot.com/bug?extid=61e4b490d9d2da591b50
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1782443a400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15ebf556400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+61e4b490d9d2da591b50@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: stack-out-of-bounds in memcmp+0xe3/0x160 lib/string.c:861
Read of size 1 at addr ffff8801ba8df400 by task syz-executor610/5662

CPU: 0 PID: 5662 Comm: syz-executor610 Not tainted 4.19.0-rc5+ #252
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c4/0x2b4 lib/dump_stack.c:113
  print_address_description.cold.8+0x9/0x1ff mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.9+0x242/0x309 mm/kasan/report.c:412
  __asan_report_load1_noabort+0x14/0x20 mm/kasan/report.c:430
  memcmp+0xe3/0x160 lib/string.c:861
  strnstr+0x4b/0x70 lib/string.c:934
  __aa_lookupn_ns+0xc1/0x570 security/apparmor/policy_ns.c:209
  aa_lookupn_ns+0x88/0x1e0 security/apparmor/policy_ns.c:240
  aa_fqlookupn_profile+0x1b9/0x1010 security/apparmor/policy.c:468
  fqlookupn_profile+0x80/0xc0 security/apparmor/label.c:1844
  aa_label_strn_parse+0xa3a/0x1230 security/apparmor/label.c:1908
  aa_label_parse+0x42/0x50 security/apparmor/label.c:1943
  aa_change_profile+0x513/0x3510 security/apparmor/domain.c:1362
  apparmor_setprocattr+0xaa4/0x1150 security/apparmor/lsm.c:658
  security_setprocattr+0x66/0xc0 security/security.c:1298
  proc_pid_attr_write+0x301/0x540 fs/proc/base.c:2555
  __vfs_write+0x119/0x9f0 fs/read_write.c:485
  vfs_write+0x1fc/0x560 fs/read_write.c:549
  ksys_write+0x101/0x260 fs/read_write.c:598
  __do_sys_write fs/read_write.c:610 [inline]
  __se_sys_write fs/read_write.c:607 [inline]
  __x64_sys_write+0x73/0xb0 fs/read_write.c:607
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x441469
Code: e8 cc b2 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 4b 09 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffced82b788 EFLAGS: 00000213 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000441469
RDX: 0000000000000009 RSI: 0000000020000180 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000001e49880 R11: 0000000000000213 R12: 000000000000014f
R13: 000000000000ae37 R14: 0000000000000000 R15: 0000000000000000

The buggy address belongs to the page:
page:ffffea0006ea37c0 count:0 mapcount:0 mapping:0000000000000000 index:0x0
flags: 0x2fffc0000000000()
raw: 02fffc0000000000 0000000000000000 ffffffff06ea0101 0000000000000000
raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801ba8df300: f2 f2 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  ffff8801ba8df380: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 f1
> ffff8801ba8df400: f1 f1 f1 f8 f2 f2 f2 f2 f2 f2 f2 00 f2 f2 f2 f2
                    ^
  ffff8801ba8df480: f2 f2 f2 f8 f2 f2 f2 f2 f2 f2 f2 00 f2 f2 f2 f2
  ffff8801ba8df500: f2 f2 f2 00 00 00 00 00 00 00 00 f3 f3 f3 f3 00
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
