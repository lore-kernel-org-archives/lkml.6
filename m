Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7983AECDFB1
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 00:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36040208B2
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 00:19:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36040208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbeGPAns (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 20:43:48 -0400
Received: from mail-io0-f198.google.com ([209.85.223.198]:48820 "EHLO
        mail-io0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727120AbeGPAns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 20:43:48 -0400
Received: by mail-io0-f198.google.com with SMTP id t11-v6so33230636iog.15
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jul 2018 17:19:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=ErpqBG56rCLnCXAVWUOx90RPLE8UgWWPG8WdlyKLWR0=;
        b=d/CALJSuF/xnoCI8I4LQNVfBPsE2C4sEytue7s3VCeN268M+qNHFwh3tQOv9KuRYKH
         VGmMHCIgfgesh/nByP25VPapkdPKYdd0aipQsZn57+E/17zyhaZX2XLrLiYiTjaU1cIF
         L7VVJjVdpQqlAh+Yj8CGh9KWsY03jWqAe1nC7IVkFwla0ZB33lJJSAMf5SjspJW70qZ9
         n1Zu7XzmsIvG+WOHqMWRi6FJ0YZCdkJD4rBXJBERIr2Hn0F/O+QbWA501SbgbzV5Xo0n
         ZUNJye4HEarAp4tjvnT0f6THcPa4IHb5M54IjRPrVoqECswxMquwbOgjIvB+VbCZgz89
         WO+g==
X-Gm-Message-State: AOUpUlH3dMK2mLBox4MfUSOhcCCjA6sV+gwPJJHPgzFYxOxwZ68AMmjk
        rhEyN4WfowIcETtfl+7v0r3wYYnE+DpA0wrGlpPf7i/Y+hRg
X-Google-Smtp-Source: AAOMgpcjoLRVID3aqrdH8RGcMilON08oIdEg48zTOBXKBHPCMqIs8jxu+Oz56D/lfHC4a2DhTD/eqImppyulwC1sbSuOfBfZYNLq
MIME-Version: 1.0
X-Received: by 2002:a24:45db:: with SMTP id c88-v6mr6013496itd.41.1531700343410;
 Sun, 15 Jul 2018 17:19:03 -0700 (PDT)
Date:   Sun, 15 Jul 2018 17:19:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000df12a6057112c6de@google.com>
Subject: WARNING in __snd_rawmidi_transmit_ack
From:   syzbot <syzbot+52f83f0ea8df16932f7f@syzkaller.appspotmail.com>
To:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        perex@perex.cz, syzkaller-bugs@googlegroups.com, tiwai@suse.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    37b5dca2898d Merge tag 'rtc-4.18-2' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12204d62400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=25856fac4e580aa7
dashboard link: https://syzkaller.appspot.com/bug?extid=52f83f0ea8df16932f7f
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
userspace arch: i386
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=148ea9a4400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+52f83f0ea8df16932f7f@syzkaller.appspotmail.com

random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: cc1: uninitialized urandom read (8 bytes read)
IPVS: ftp: loaded support on port[0] = 21
WARNING: CPU: 0 PID: 4608 at sound/core/rawmidi.c:1163  
__snd_rawmidi_transmit_ack+0x263/0x2f0 sound/core/rawmidi.c:1163
Kernel panic - not syncing: panic_on_warn set ...

CPU: 0 PID: 4608 Comm: syz-executor0 Not tainted 4.18.0-rc4+ #51
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
  panic+0x238/0x4e7 kernel/panic.c:184
  __warn.cold.8+0x163/0x1ba kernel/panic.c:536
  report_bug+0x252/0x2d0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:178 [inline]
  do_error_trap+0x1fc/0x4d0 arch/x86/kernel/traps.c:296
  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:316
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:992
RIP: 0010:__snd_rawmidi_transmit_ack+0x263/0x2f0 sound/core/rawmidi.c:1163
Code: ba 01 00 00 00 be 03 00 00 00 e8 88 4a 83 fb e8 43 fe a2 fb 89 d8 48  
83 c4 18 5b 41 5c 41 5d 41 5e 41 5f 5d c3 e8 2d fe a2 fb <0f> 0b e9 72 fe  
ff ff e8 e1 dc e0 fb e9 1b ff ff ff bb ea ff ff ff
RSP: 0018:ffff8801abb8f720 EFLAGS: 00010093
RAX: ffff8801d8b500c0 RBX: 0000000000000002 RCX: ffffffff85d90b82
RDX: 0000000000000000 RSI: ffffffff85d90d13 RDI: 0000000000000006
RBP: ffff8801abb8f760 R08: ffff8801d8b500c0 R09: ffffed003b128cb4
R10: ffffed003b128cb4 R11: ffff8801d89465a3 R12: ffff8801cd646240
R13: 0000000000000802 R14: 0000000000000002 R15: ffff8801ab48e5c0
  snd_virmidi_output_trigger+0x3ae/0x6b0 sound/core/seq/seq_virmidi.c:194
  snd_rawmidi_output_trigger sound/core/rawmidi.c:150 [inline]
  snd_rawmidi_kernel_write1+0x519/0x700 sound/core/rawmidi.c:1288
  snd_rawmidi_write+0x2ea/0xde0 sound/core/rawmidi.c:1338
  __vfs_write+0x117/0x9f0 fs/read_write.c:485
  vfs_write+0x1f8/0x560 fs/read_write.c:549
  ksys_write+0x101/0x260 fs/read_write.c:598
  __do_sys_write fs/read_write.c:610 [inline]
  __se_sys_write fs/read_write.c:607 [inline]
  __ia32_sys_write+0x71/0xb0 fs/read_write.c:607
  do_syscall_32_irqs_on arch/x86/entry/common.c:326 [inline]
  do_fast_syscall_32+0x34d/0xfb2 arch/x86/entry/common.c:397
  entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139
RIP: 0023:0xf7f5fcb9
Code: 55 08 8b 88 64 cd ff ff 8b 98 68 cd ff ff 89 c8 85 d2 74 02 89 0a 5b  
5d c3 8b 04 24 c3 8b 1c 24 c3 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90  
90 90 90 eb 0d 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 002b:00000000f7f190ac EFLAGS: 00000282 ORIG_RAX: 0000000000000004
RAX: ffffffffffffffda RBX: 0000000000000006 RCX: 00000000200000c0
RDX: 000000000000ff4c RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
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
