Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E35AAC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 09:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D72F2172C
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 09:34:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D72F2172C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729181AbeI1P46 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 11:56:58 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:44575 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729008AbeI1P45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 11:56:57 -0400
Received: by mail-io1-f70.google.com with SMTP id s15-v6so5582189iob.11
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 02:34:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=lnd1vs05C+E7fcK0K6l6v2hdu8dS8uXMCLT9kEUjctE=;
        b=OkEH7ssd4r/WAFYCfZfztszH+zK7OmVuB5L4aPfHXAfGuIKWx0MHzIHEQBphkG7llk
         pbvwhcmhJaPsv5tCQqGHbjIKlgP5S9KkTnACPBkG+B+KAAKi6EsCyKOsemPxU23mOzUP
         SFyRy1RBrgbJ8Sb+yWxfcjyXL4YACDkjcwBmJ/CRLGM4HXe4uiTTqMsJ/sAn5pqjh3Ls
         r7YX4VeKWcc3SqSznsFgGuUYSI9WqyPERgSJOZ+2Ns6JTS1tQm7pPA27OojdUbJSiOZw
         8nf9j8t2bZ+Kh0J7kWViJbXdtLhArb4qkXAvqZRijhuUF0sRN4FkcPSY6Adomlga0Z/J
         YMzQ==
X-Gm-Message-State: ABuFfojfwiLVhixVrQW9klKooKuhrPiw5aeN5s/MOk7v5wdXtqK420FG
        feOUNhlfZtjMToja+YhHplBqtRQFJSOhlYtgGcUT5GLU4/i3
X-Google-Smtp-Source: ACcGV60M++RlNeynckKsKQN8R7wzaxKagH/lPv/pN3BTlgy1zvhFWh7kE0p3Q+B+5x1HEIQL8lKc4fPTvNhYVNvNxdsj5k7+m4vL
MIME-Version: 1.0
X-Received: by 2002:a24:7546:: with SMTP id y67-v6mr360294itc.26.1538127244603;
 Fri, 28 Sep 2018 02:34:04 -0700 (PDT)
Date:   Fri, 28 Sep 2018 02:34:04 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000008b7ab0576eb285a@google.com>
Subject: KMSAN: uninit-value in aa_fqlookupn_profile
From:   syzbot <syzbot+3a0d172d51be1b3de837@syzkaller.appspotmail.com>
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

HEAD commit:    7ace43031cfc kmsan, kcov: don't check atomic functions in ..
git tree:       https://github.com/google/kmsan.git/master
console output: https://syzkaller.appspot.com/x/log.txt?x=17b97111400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=94a9ed72288f7fef
dashboard link: https://syzkaller.appspot.com/bug?extid=3a0d172d51be1b3de837
compiler:       clang version 8.0.0 (trunk 339414)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=179819f1400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14761bae400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+3a0d172d51be1b3de837@syzkaller.appspotmail.com

random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
==================================================================
BUG: KMSAN: uninit-value in aa_fqlookupn_profile+0x33a/0x750  
security/apparmor/policy.c:467
CPU: 0 PID: 4663 Comm: syz-executor299 Not tainted 4.19.0-rc4+ #56
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x2f6/0x430 lib/dump_stack.c:113
  kmsan_report+0x183/0x2b0 mm/kmsan/kmsan.c:956
  __msan_warning+0x70/0xc0 mm/kmsan/kmsan_instr.c:645
  aa_fqlookupn_profile+0x33a/0x750 security/apparmor/policy.c:467
  aa_label_strn_parse+0x179e/0x1f30 security/apparmor/label.c:1841
  aa_label_parse+0x11f/0x130 security/apparmor/label.c:1943
  aa_change_profile+0x979/0x41d0 security/apparmor/domain.c:1362
  apparmor_setprocattr+0x121a/0x12f0 security/apparmor/lsm.c:651
  security_setprocattr+0x139/0x210 security/security.c:1298
  proc_pid_attr_write+0x3f9/0x4e0 fs/proc/base.c:2555
  __vfs_write+0x1a8/0xa50 fs/read_write.c:485
  vfs_write+0x495/0x8e0 fs/read_write.c:549
  ksys_write fs/read_write.c:598 [inline]
  __do_sys_write fs/read_write.c:610 [inline]
  __se_sys_write+0x173/0x350 fs/read_write.c:607
  __x64_sys_write+0x4a/0x70 fs/read_write.c:607
  do_syscall_64+0xb8/0x100 arch/x86/entry/common.c:291
  entry_SYSCALL_64_after_hwframe+0x63/0xe7
RIP: 0033:0x440059
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 fb 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffd4b1e0f18 EFLAGS: 00000213 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 0000000000440059
RDX: 0000000000000009 RSI: 0000000020000040 RDI: 0000000000000003
RBP: 00000000006ca018 R08: 0000000000000000 R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000213 R12: 00000000004018e0
R13: 0000000000401970 R14: 0000000000000000 R15: 0000000000000000

Local variable description: ----ns_name@aa_fqlookupn_profile
Variable was created at:
  aa_fqlookupn_profile+0x81/0x750 security/apparmor/policy.c:460
  aa_label_strn_parse+0x179e/0x1f30 security/apparmor/label.c:1841
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
