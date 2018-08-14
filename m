Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31900C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 14:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E98D2170E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 14:20:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E98D2170E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732672AbeHNRHZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 13:07:25 -0400
Received: from mail-it0-f72.google.com ([209.85.214.72]:55148 "EHLO
        mail-it0-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729560AbeHNRHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 13:07:25 -0400
Received: by mail-it0-f72.google.com with SMTP id c191-v6so5776495itb.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 07:20:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=tx6+QPmZzxS1hn54G7lT6STYG5Q68423ZgCpDsQMEow=;
        b=OsS5D4T3HA4CHWASvPR5CLLxfH5TsWfZNskI71a2AAdD3H3k/Bno+QXo+KydRV6Fsn
         Q9xyy7MbOqZQboka50srIGWgh2Kjoa1WfAuuajRF86kVEaKOPRiQdgXosvGr4DuuXEAj
         I1m9iydqIGcFNphTKG59595p2uXvGW/8gN1siv08fs9mMbXhRpK+Vs22wugb/8NnXVpx
         7i+I7BJKE4EbPmTznmL14xAPoDSsXmZ7t5Oukb+PzoNQyClBmJR5+rqEgM+FNKjbgvVZ
         01oiUikhcr5HzADrn4lDh1r1ZqUGRXEgWteA1m1qJCQ0ylrbJtgYkylS0d3XbeK8YN8Z
         WjIw==
X-Gm-Message-State: AOUpUlHRuSNfIKER59Y/Q/rXnuOkutu+lvz3AibnESWpmEDzQwlPS8sG
        mb0YQFF0qfGdn/ss+0iOWqQogbIlo8wqR6vEG6AIwKOw8rLk
X-Google-Smtp-Source: AA+uWPxkByTHvnaf+KE2VFPQPCeSeyOoJrGDTzjLR53RuYfZXNGI5G+TsZxUU9oyKS3vspqx3Hf1oEeYw+1TnMm2kQPvMTpMyLEB
MIME-Version: 1.0
X-Received: by 2002:a02:ba04:: with SMTP id z4-v6mr480295jan.61.1534256402733;
 Tue, 14 Aug 2018 07:20:02 -0700 (PDT)
Date:   Tue, 14 Aug 2018 07:20:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e1226c057365e75d@google.com>
Subject: WARNING in __snd_rawmidi_transmit_ack (2)
From:   syzbot <syzbot+ec5f605c91812d200367@syzkaller.appspotmail.com>
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

HEAD commit:    4e8b38549b50 Add linux-next specific files for 20180814
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11f5e78c400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=18edf0289d1b5ab
dashboard link: https://syzkaller.appspot.com/bug?extid=ec5f605c91812d200367
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=12f8c6d2400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16976b72400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+ec5f605c91812d200367@syzkaller.appspotmail.com

WARNING: CPU: 1 PID: 1691 at sound/core/rawmidi.c:1170  
__snd_rawmidi_transmit_ack+0x263/0x2f0 sound/core/rawmidi.c:1170
Kernel panic - not syncing: panic_on_warn set ...

CPU: 1 PID: 1691 Comm: kworker/1:1H Not tainted 4.18.0-next-20180814+ #38
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events_highpri snd_vmidi_output_work
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
  panic+0x238/0x4e7 kernel/panic.c:184
  __warn.cold.8+0x163/0x1ba kernel/panic.c:536
  report_bug+0x252/0x2d0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:178 [inline]
  do_error_trap+0x1fc/0x4d0 arch/x86/kernel/traps.c:296
  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:316
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:996
RIP: 0010:__snd_rawmidi_transmit_ack+0x263/0x2f0 sound/core/rawmidi.c:1170
Code: ba 01 00 00 00 be 03 00 00 00 e8 18 3a 66 fc e8 e3 44 86 fc 89 d8 48  
83 c4 18 5b 41 5c 41 5d 41 5e 41 5f 5d c3 e8 cd 44 86 fc <0f> 0b e9 72 fe  
ff ff e8 21 5a c5 fc e9 1b ff ff ff bb ea ff ff ff
RSP: 0018:ffff8801d2a6f5a8 EFLAGS: 00010093
RAX: ffff8801d2a52300 RBX: 0000000000000001 RCX: ffffffff84f64792
RDX: 0000000000000000 RSI: ffffffff84f64923 RDI: 0000000000000006
RBP: ffff8801d2a6f5e8 R08: ffff8801d2a52300 R09: ffffed003607acc1
R10: ffffed003607acc1 R11: ffff8801b03d660b R12: ffff8801ce2479c0
R13: 0000000000001001 R14: 0000000000000001 R15: ffff8801b03d65c0
  snd_rawmidi_transmit_ack+0x51/0x80 sound/core/rawmidi.c:1201
  snd_vmidi_output_work+0x3f4/0x4e0 sound/core/seq/seq_virmidi.c:153
  process_one_work+0xc73/0x1aa0 kernel/workqueue.c:2153
  worker_thread+0x189/0x13c0 kernel/workqueue.c:2296
  kthread+0x35a/0x420 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:415
Shutting down cpus with NMI
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
