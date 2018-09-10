Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_DIGITS,
	FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E09BDC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 951652086B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:31:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 951652086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbeIJNX7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 09:23:59 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:55684 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727955AbeIJNX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 09:23:58 -0400
Received: by mail-io1-f72.google.com with SMTP id m15-v6so3238606ioj.22
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 01:31:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=jSNj3oIHAQJCHtsYpkwin8ry6V8jVB5EKN3q3VxjCUw=;
        b=hdJAXhSdCyJBqa6p6oyc8MyureH2EAzMvx0eu9+WpFMuuN0DK5jhhwNMx+Fklk3Cr8
         Nu3JkXoBT0CbgGva440W5pILkgJT+2BOvVTxOOx5RaegcQq8dTnfkkzNVTLmLK5B+UDN
         aT+C3Wi2AbChJ3s6PENRK00E829ulqU8dVpYIOqtvGUkJfD7cMj1dcKVwS110zSA57UV
         /l4Xk84mHuSSpIku1f3+6Ja3f3fnjAM+rsDFNftPhNLIA5uCJyGSkvtgbB+wRB9+fAbN
         VssOYVwir26+c6CUrVg8ijZlPqNQLep1u8scrFuea3PfALxm3e6KXWgLramwwjTndz2l
         usug==
X-Gm-Message-State: APzg51AmmAzkZuHqSjz/5KiQ2ITEWFjfr5LOSRzsPeETdfbVIz6EU9/m
        8qaJWqRUaBwl7zJmwUYrOvrz8lUdCJyTdRLv2YBPomjhHODj
X-Google-Smtp-Source: ANB0VdbVgdtRK+zYPqsE6uoacyxwZe+x/AuxkV8pWudNkCMB5TZBT+ffUeWh4aaoPH74MC8T0gKpba8u5xlG5q4n2H5lO+0o3Kh9
MIME-Version: 1.0
X-Received: by 2002:a6b:6a18:: with SMTP id x24-v6mr16602685iog.48.1536568264493;
 Mon, 10 Sep 2018 01:31:04 -0700 (PDT)
Date:   Mon, 10 Sep 2018 01:31:04 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009417ef0575802d44@google.com>
Subject: BUG: unable to handle kernel paging request in bpf_prog_kallsyms_add
From:   syzbot <syzbot+c827a78260579449ad39@syzkaller.appspotmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    f6f3bac08ff9 tools/bpf: bpftool: add net support
git tree:       bpf-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17940056400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f59875069d721b6
dashboard link: https://syzkaller.appspot.com/bug?extid=c827a78260579449ad39
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1611c7e1400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+c827a78260579449ad39@syzkaller.appspotmail.com

**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **
**********************************************************
BUG: unable to handle kernel paging request at ffffc90001930002
PGD 1da948067 P4D 1da948067 PUD 1da949067 PMD 1d49da067 PTE 0
Oops: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 12601 Comm: syz-executor3 Not tainted 4.19.0-rc2+ #93
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:bpf_prog_kallsyms_candidate kernel/bpf/core.c:472 [inline]
RIP: 0010:bpf_prog_kallsyms_add+0xbe/0x9b0 kernel/bpf/core.c:483
Code: d0 31 c0 e8 14 68 f3 ff 49 8d 7c 24 02 48 89 f8 48 89 fa 48 c1 e8 03  
83 e2 07 0f b6 04 18 38 d0 7f 08 84 c0 0f 85 39 07 00 00 <41> 0f b6 5c 24  
02 31 ff 83 e3 01 89 de e8 b0 68 f3 ff 84 db 0f 84
RSP: 0018:ffff8801bc2af9c0 EFLAGS: 00010246
RAX: 0000000000000000 RBX: dffffc0000000000 RCX: ffffffff818c8b39
RDX: 0000000000000002 RSI: ffffffff818b671c RDI: ffffc90001930002
RBP: ffff8801bc2afb30 R08: ffff8801bf750100 R09: ffffed003b584732
R10: ffffed003b584732 R11: ffff8801dac23993 R12: ffffc90001930000
R13: ffff8801bc2afd18 R14: 0000000000000000 R15: 1ffff10037855f3d
FS:  00007fb5d21c9700(0000) GS:ffff8801dac00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc90001930002 CR3: 00000001bcd1c000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  bpf_prog_load+0x13d1/0x1cb0 kernel/bpf/syscall.c:1442
  __do_sys_bpf kernel/bpf/syscall.c:2371 [inline]
  __se_sys_bpf kernel/bpf/syscall.c:2333 [inline]
  __x64_sys_bpf+0x36c/0x510 kernel/bpf/syscall.c:2333
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457099
Code: fd b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fb5d21c8c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007fb5d21c96d4 RCX: 0000000000457099
RDX: 0000000000000048 RSI: 0000000020000000 RDI: 0000000000000005
RBP: 00000000009300a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000004cb9c8 R14: 00000000004c335d R15: 0000000000000000
Modules linked in:
Dumping ftrace buffer:
    (ftrace buffer empty)
CR2: ffffc90001930002
---[ end trace fcb4474011e9b55c ]---
RIP: 0010:bpf_prog_kallsyms_candidate kernel/bpf/core.c:472 [inline]
RIP: 0010:bpf_prog_kallsyms_add+0xbe/0x9b0 kernel/bpf/core.c:483
Code: d0 31 c0 e8 14 68 f3 ff 49 8d 7c 24 02 48 89 f8 48 89 fa 48 c1 e8 03  
83 e2 07 0f b6 04 18 38 d0 7f 08 84 c0 0f 85 39 07 00 00 <41> 0f b6 5c 24  
02 31 ff 83 e3 01 89 de e8 b0 68 f3 ff 84 db 0f 84
RSP: 0018:ffff8801bc2af9c0 EFLAGS: 00010246
RAX: 0000000000000000 RBX: dffffc0000000000 RCX: ffffffff818c8b39
RDX: 0000000000000002 RSI: ffffffff818b671c RDI: ffffc90001930002
RBP: ffff8801bc2afb30 R08: ffff8801bf750100 R09: ffffed003b584732
R10: ffffed003b584732 R11: ffff8801dac23993 R12: ffffc90001930000
R13: ffff8801bc2afd18 R14: 0000000000000000 R15: 1ffff10037855f3d
FS:  00007fb5d21c9700(0000) GS:ffff8801dac00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc90001930002 CR3: 00000001bcd1c000 CR4: 00000000001406f0
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
