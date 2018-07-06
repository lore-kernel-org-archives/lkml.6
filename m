Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_DIGITS,
	FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F13C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 22:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A6A222B26
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 22:39:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A6A222B26
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754400AbeGFWjI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 18:39:08 -0400
Received: from mail-io0-f197.google.com ([209.85.223.197]:50501 "EHLO
        mail-io0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754187AbeGFWjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 18:39:04 -0400
Received: by mail-io0-f197.google.com with SMTP id v2-v6so4415661ioh.17
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 15:39:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=skk4jB3gjkQ1X/G8NP7jc1v8uMIEh8FGxU+MtkNvf4w=;
        b=k6w13LZ3ZF3uGCzCb/+6hKjsR/pWT4zOgLM6U5dvvzqRMBPJJ1+KDVz/aHaUGrLAwV
         p6TmF5rESdRR2pu3bqT0HJAiHVzdGazEsvfGHfwDU4D08sGIsuGBvxn47YNHmK8yavqW
         yvCDGl/2aLAdoCeNGhZn0/7Tcux5KvIPHOBRwlfNJly5I0L+47hjlpTyV+yGOFJaclbY
         NyMlQO84/JwFbcBeI1FnjmJyHuVC0x8O1x02J88dvLpowpoSyIt1BVhOAhtOGRUSOOgi
         kEfOmovT4qNvNxotTdQaAcivjiCSordsvmad2bpeggCKgq2AmuOjivhNl14NC6oZVRaJ
         N1iw==
X-Gm-Message-State: APt69E3sdb/XraPcNlo3nZbroJZJS6GaJ16wkA/WuZomKP5G/lCofMkq
        eVJS7dbqQlDFgC+M3fSQGfgnDnhweKmF4aM5N11Rn6FFkmiZ
X-Google-Smtp-Source: AAOMgpcWlw4zDPSyFCknZ2K5FMh8+RetS7JvGae5rJyYWz6XO36DkDpWMUekIsV2vnDkJq3+yBHrmpiLy65SnnG/MuqmlKPjfXnP
MIME-Version: 1.0
X-Received: by 2002:a24:5a44:: with SMTP id v65-v6mr3243121ita.14.1530916743820;
 Fri, 06 Jul 2018 15:39:03 -0700 (PDT)
Date:   Fri, 06 Jul 2018 15:39:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b2425905705c540f@google.com>
Subject: general protection fault in do_remount_sb
From:   syzbot <syzbot+049ea4b3691673030783@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    526674536360 Add linux-next specific files for 20180706
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1642b734400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c8d1cfc0cb798e48
dashboard link: https://syzkaller.appspot.com/bug?extid=049ea4b3691673030783
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=118bf170400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1783690c400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+049ea4b3691673030783@syzkaller.appspotmail.com

random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] SMP KASAN
CPU: 1 PID: 4462 Comm: syz-executor233 Not tainted  
4.18.0-rc3-next-20180706+ #1
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:do_remount_sb+0x371/0x850 fs/super.c:992
Code: ff ff ff e8 01 85 fa 05 41 89 c5 48 8b 85 30 ff ff ff 48 8d b8 e0 00  
00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 04 02 84  
c0 74 08 3c 03 0f 8e b5 03 00 00 48 8b 85 30 ff ff
RSP: 0018:ffff8801ac117a38 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffff8801caf68e40 RCX: ffffffff81c5edb2
RDX: 000000000000001c RSI: ffffffff81edb5ef RDI: 00000000000000e0
RBP: ffff8801ac117b40 R08: ffff8801ac1e2140 R09: fffffbfff11c24e5
R10: fffffbfff11c24e5 R11: ffffffff88e1272b R12: ffff8801ac117b18
R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000000
FS:  0000000001440880(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000680 CR3: 00000001ac28f000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  do_umount fs/namespace.c:1467 [inline]
  ksys_umount+0xfa7/0x12f0 fs/namespace.c:1585
  __do_sys_umount fs/namespace.c:1596 [inline]
  __se_sys_umount fs/namespace.c:1594 [inline]
  __x64_sys_umount+0x54/0x80 fs/namespace.c:1594
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x440069
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 fb 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffded829168 EFLAGS: 00000217 ORIG_RAX: 00000000000000a6
RAX: ffffffffffffffda RBX: 0030656c69662f2e RCX: 0000000000440069
RDX: 0000000000440069 RSI: 0000000000000000 RDI: 0000000020000040
RBP: 00000000006ca018 R08: 00000000004002c8 R09: 00000000004002c8
R10: 00000000004002c8 R11: 0000000000000217 R12: 00000000004018f0
R13: 0000000000401980 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
Dumping ftrace buffer:
    (ftrace buffer empty)
---[ end trace e836fc74e88778be ]---
RIP: 0010:do_remount_sb+0x371/0x850 fs/super.c:992
Code: ff ff ff e8 01 85 fa 05 41 89 c5 48 8b 85 30 ff ff ff 48 8d b8 e0 00  
00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 04 02 84  
c0 74 08 3c 03 0f 8e b5 03 00 00 48 8b 85 30 ff ff
RSP: 0018:ffff8801ac117a38 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffff8801caf68e40 RCX: ffffffff81c5edb2
RDX: 000000000000001c RSI: ffffffff81edb5ef RDI: 00000000000000e0
RBP: ffff8801ac117b40 R08: ffff8801ac1e2140 R09: fffffbfff11c24e5
R10: fffffbfff11c24e5 R11: ffffffff88e1272b R12: ffff8801ac117b18
R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000000
FS:  0000000001440880(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000680 CR3: 00000001ac28f000 CR4: 00000000001406e0
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
