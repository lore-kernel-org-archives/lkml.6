Return-Path: <SRS0=4YaO=K3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C03EDC46460
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 05:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70B2B21A5E
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 05:39:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70B2B21A5E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbeHLIPt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Aug 2018 04:15:49 -0400
Received: from mail-it0-f69.google.com ([209.85.214.69]:54798 "EHLO
        mail-it0-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbeHLIPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Aug 2018 04:15:48 -0400
Received: by mail-it0-f69.google.com with SMTP id l8-v6so6233823ita.4
        for <linux-kernel@vger.kernel.org>; Sat, 11 Aug 2018 22:39:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=P8XNezAbPXL7RjedT/kxj8sz4YGRo2mMSqon0Nz9bDw=;
        b=Iq6CNYvmPs9SIGV3MU7cTU2iCezfSQAYns5EX+TrcflfAEHxGX72gs1q0zn3YvuciV
         dPB6vXbFXswIowXXP4qMSkeFNapW32cmGK7ghM8jb/3qwG1cMWtJZ9pWh7WduJAD8Ouz
         edVnTYNk+yjdAaDAHiyxHe/iqaTUOPLibGRXykYdkact1o7c1Y1AIQZMkyBj7jqjqNAR
         N4XwXXg2c2aKoB0exuSRVf4p2iwrfM2sPig8DJDVywESGmE0dHmU/xomW9QBy+IcT0ts
         RM4cRF6CXMLj8YIvln/GrmDn8jew6twPonmpgdHrr1tTutrpcOoFvga7ktBtNWeEpkzb
         PqnA==
X-Gm-Message-State: AOUpUlH/bNxgUYtVXt35QrPN5UrNDbRVbBM0Q48k9p/SlV1/lmGTpAqw
        GuW4wOK7VTBtbuW7T3qvAloclikSd0wtds5GZnMQk2LcUCd+
X-Google-Smtp-Source: AA+uWPxvRpUUio2tfHtLo5P1tvgMCWKZeMh0mNST7YNIW86wOlU/zOjF8hmSRaW5JKZxVunDxiWfIsVDXBFxNFkLovL5GG1UluHq
MIME-Version: 1.0
X-Received: by 2002:a6b:150:: with SMTP id 77-v6mr5833128iob.14.1534052342654;
 Sat, 11 Aug 2018 22:39:02 -0700 (PDT)
Date:   Sat, 11 Aug 2018 22:39:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f3735a05733664b3@google.com>
Subject: general protection fault in kstrtouint
From:   syzbot <syzbot+657c927f261cbdd5c50f@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    2b769bb85b48 Add linux-next specific files for 20180807
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1525beac400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=547d800b8773c2c5
dashboard link: https://syzkaller.appspot.com/bug?extid=657c927f261cbdd5c50f
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=170cdffc400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=160f7830400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+657c927f261cbdd5c50f@syzkaller.appspotmail.com

random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] SMP KASAN
CPU: 0 PID: 4328 Comm: syz-executor623 Not tainted  
4.18.0-rc8-next-20180807+ #33
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:kstrtoull lib/kstrtox.c:123 [inline]
RIP: 0010:kstrtouint+0x83/0x1b0 lib/kstrtox.c:222
Code: f1 f1 c7 40 04 00 f2 f2 f2 65 48 8b 04 25 28 00 00 00 48 89 45 d0 31  
c0 e8 1a 31 18 fe 48 89 d8 48 89 da 48 c1 e8 03 83 e2 07 <42> 0f b6 04 30  
38 d0 7f 08 84 c0 0f 85 e8 00 00 00 44 0f b6 33 bf
RSP: 0018:ffff8801ad63f888 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 1ffff10035ac7f5f
RDX: 0000000000000000 RSI: ffffffff8364fc96 RDI: 0000000000000000
RBP: ffff8801ad63f918 R08: ffff8801ad5da3c0 R09: ffff8801ad588580
R10: 00000000900ed4cc R11: ffff8801db0236b3 R12: 1ffff10035ac7f12
R13: ffff8801ad63fa18 R14: dffffc0000000000 R15: ffff8801ad63f8f0
FS:  0000000001d3b880(0000) GS:ffff8801db000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fbd50b94518 CR3: 00000001c46c3000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  fs_parse+0xb8d/0x1130 fs/fs_parser.c:164
  hugetlbfs_parse_param+0xd1/0xa50 fs/hugetlbfs/inode.c:1210
  vfs_parse_fs_param+0x196/0x2c0 fs/fs_context.c:162
  vfs_parse_fs_string+0x1d5/0x2b0 fs/fs_context.c:191
  generic_parse_monolithic+0x17c/0x210 fs/fs_context.c:228
  parse_monolithic_mount_data fs/namespace.c:2320 [inline]
  do_new_mount fs/namespace.c:2599 [inline]
  do_mount+0x6d8/0x1e30 fs/namespace.c:2927
  ksys_mount+0x12d/0x140 fs/namespace.c:3143
  __do_sys_mount fs/namespace.c:3157 [inline]
  __se_sys_mount fs/namespace.c:3154 [inline]
  __x64_sys_mount+0xbe/0x150 fs/namespace.c:3154
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4441a9
Code: 0d d8 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 db d7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffcb4f5f8a8 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0030656c69662f2e RCX: 00000000004441a9
RDX: 0000000020000300 RSI: 0000000020000340 RDI: 0000000020000000
RBP: 00000000006cf018 R08: 00000000200001c0 R09: 00000000200001c0
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000401e10
R13: 0000000000401ea0 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
Dumping ftrace buffer:
    (ftrace buffer empty)
---[ end trace 3277e6ee2f78e7e4 ]---
RIP: 0010:kstrtoull lib/kstrtox.c:123 [inline]
RIP: 0010:kstrtouint+0x83/0x1b0 lib/kstrtox.c:222
Code: f1 f1 c7 40 04 00 f2 f2 f2 65 48 8b 04 25 28 00 00 00 48 89 45 d0 31  
c0 e8 1a 31 18 fe 48 89 d8 48 89 da 48 c1 e8 03 83 e2 07 <42> 0f b6 04 30  
38 d0 7f 08 84 c0 0f 85 e8 00 00 00 44 0f b6 33 bf
RSP: 0018:ffff8801ad63f888 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 1ffff10035ac7f5f
RDX: 0000000000000000 RSI: ffffffff8364fc96 RDI: 0000000000000000
RBP: ffff8801ad63f918 R08: ffff8801ad5da3c0 R09: ffff8801ad588580
R10: 00000000900ed4cc R11: ffff8801db0236b3 R12: 1ffff10035ac7f12
R13: ffff8801ad63fa18 R14: dffffc0000000000 R15: ffff8801ad63f8f0
FS:  0000000001d3b880(0000) GS:ffff8801db000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fbd50b94518 CR3: 00000001c46c3000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
