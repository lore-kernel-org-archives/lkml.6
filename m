Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 523F4C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 09:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23B7720878
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 09:38:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23B7720878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbeJHQsw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 12:48:52 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:34431 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbeJHQsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 12:48:52 -0400
Received: by mail-io1-f69.google.com with SMTP id y3-v6so19056739iob.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 02:38:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=bSzIMWfrsFIpVBiWdk50WXI5a4gN9KyGl9brTZPcMzQ=;
        b=ISzE/cJjfYkNsv4YwdScMnLxhYZxwz91Ghx7jGtNzQe2MHTob1MOpx0vtvQ6LNu5H+
         Z22yOcG5kffF4gU3Z0pycUCcu6ihYGQ9Dk9JUScAgRYi8KiWFgypf5cddSowm3o4Bp0i
         2iJZuBvym9fPloSM5OQkBEkT+y5WblJFXnetqmjBVrXpOzAbAFJGCnEYsFwIQxD3f4eE
         gIZcXfGEr7FYS8Dvp7LTYp2sUs0XKIPAOVjzBSaBe3IKCSBO0lxwxNyDjhPVuCLhTJnN
         XotemL30dFdz8t5ZGdTzcIlNMGFHT6mmIxmcm8EFEE9UtWSvtFqbWNzPitpcX1aiUn83
         Uh5w==
X-Gm-Message-State: ABuFfohugJ0h6nprBG3A4reSuMM5K1X/mIv8VG3NO8KDV/vObZkmF0Jr
        bNBU19Y45jn4xxc+s8UY7ykK+9TbobV4dmYcNXxi1hxICd/b
X-Google-Smtp-Source: ACcGV60IDkqpZ1qUcwadK5167ZReetu/WuX2sgEWpOTA18AAWGfE+06UJyAEqVoit2Ro1XD+iLHLH/fClsNVSJIAiDUc4swDVMN7
MIME-Version: 1.0
X-Received: by 2002:a24:7f05:: with SMTP id r5-v6mr15784351itc.2.1538991482793;
 Mon, 08 Oct 2018 02:38:02 -0700 (PDT)
Date:   Mon, 08 Oct 2018 02:38:02 -0700
In-Reply-To: <0000000000006971fa05769d22f6@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a4f48c0577b46064@google.com>
Subject: Re: WARNING in request_end
From:   syzbot <syzbot+ef054c4d3f64cd7f7cec@syzkaller.appspotmail.com>
To:     dvyukov@google.com, ktkhai@virtuozzo.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    0238df646e62 Linux 4.19-rc7
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16daaa85400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=88e9a8a39dc0be2d
dashboard link: https://syzkaller.appspot.com/bug?extid=ef054c4d3f64cd7f7cec
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=119bf2e6400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1760f806400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+ef054c4d3f64cd7f7cec@syzkaller.appspotmail.com

8021q: adding VLAN 0 to HW filter on device team0
8021q: adding VLAN 0 to HW filter on device team0
WARNING: CPU: 1 PID: 7459 at fs/fuse/dev.c:390 request_end+0x82e/0xaa0  
fs/fuse/dev.c:390
Kernel panic - not syncing: panic_on_warn set ...

CPU: 1 PID: 7459 Comm: syz-executor659 Not tainted 4.19.0-rc7+ #176
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c4/0x2b4 lib/dump_stack.c:113
  panic+0x238/0x4e7 kernel/panic.c:184
  __warn.cold.8+0x163/0x1ba kernel/panic.c:536
  report_bug+0x254/0x2d0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:178 [inline]
  do_error_trap+0x1fc/0x4d0 arch/x86/kernel/traps.c:296
  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:316
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:993
RIP: 0010:request_end+0x82e/0xaa0 fs/fuse/dev.c:390
Code: 3c 03 0f 8f 6f fe ff ff 48 8b bd f0 fe ff ff e8 78 63 3b ff e9 5e fe  
ff ff e8 1e f3 f7 fe 0f 0b e9 b0 fa ff ff e8 12 f3 f7 fe <0f> 0b e9 f0 fa  
ff ff e8 16 ca c1 fe e8 71 63 3b ff e9 5b fb ff ff
RSP: 0018:ffff8801c65e7328 EFLAGS: 00010293
RAX: ffff8801cd3362c0 RBX: ffff8801cba17000 RCX: ffffffff8286dd65
RDX: 0000000000000000 RSI: ffffffff8286e27e RDI: 0000000000000007
RBP: ffff8801c65e7458 R08: ffff8801cd3362c0 R09: ffffed00391cd5bf
R10: ffffed00391cd5bf R11: ffff8801c8e6adfb R12: 1ffff10038cbce6a
R13: ffff8801c8e6ad80 R14: ffff8801cba17030 R15: ffff8801c65e7430
  fuse_dev_do_write+0x192e/0x36e0 fs/fuse/dev.c:1915
  fuse_dev_write+0x19a/0x240 fs/fuse/dev.c:1939
  call_write_iter include/linux/fs.h:1808 [inline]
  new_sync_write fs/read_write.c:474 [inline]
  __vfs_write+0x6b8/0x9f0 fs/read_write.c:487
  vfs_write+0x1fc/0x560 fs/read_write.c:549
  ksys_write+0x101/0x260 fs/read_write.c:598
  __do_sys_write fs/read_write.c:610 [inline]
  __se_sys_write fs/read_write.c:607 [inline]
  __ia32_sys_write+0x71/0xb0 fs/read_write.c:607
  do_syscall_32_irqs_on arch/x86/entry/common.c:326 [inline]
  do_fast_syscall_32+0x34d/0xfb2 arch/x86/entry/common.c:397
  entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139
RIP: 0023:0xf7f43ca9
Code: 85 d2 74 02 89 0a 5b 5d c3 8b 04 24 c3 8b 0c 24 c3 8b 1c 24 c3 90 90  
90 90 90 90 90 90 90 90 90 90 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90  
90 90 90 eb 0d 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 002b:00000000f7efd1fc EFLAGS: 00000246 ORIG_RAX: 0000000000000004
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00000000200002c0
RDX: 0000000000000050 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00000000003d0f00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
Kernel Offset: disabled
Rebooting in 86400 seconds..

