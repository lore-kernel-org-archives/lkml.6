Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27431C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 10:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECD182087A
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 10:04:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECD182087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728538AbeKLT4f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 14:56:35 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:37470 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbeKLT4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 14:56:34 -0500
Received: by mail-io1-f72.google.com with SMTP id w26-v6so9484623ioa.4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 02:04:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=NouYNZVQ4av7xQT3I70WetY+myCq/ZkiGAUGyQNC+Oo=;
        b=ZrITnWQ7WMpX7AW/f+c9epnZaBbCvc8SgRIl4N9mXdOqY90KcUGZY7j6pKlLuG/7jd
         w+OYgxm68j+WRTCDNU4YAeZjPD/d98e6UuM7+DEMQpTImasqLwj+j1J/L1cy0JRCCjlD
         gjTEtAN6LJvvZgiVbkX/29C078mPrlTt+bOtzTBWixCYWUxWWhxpzrAguhS8xKKcnkbZ
         9JAXSwEHzwetpy1CLisG5z1/KqFGjzF14+rnV7yaq2qB7yO6yKDoER1NvBDvvq1Kd5rr
         nMIjCZXqXAiPnYIxwQ0eczcqNkhep+cb6u7Uup/Cp2A96XpEGezpLPqEkfbikMZ8UI2v
         zpww==
X-Gm-Message-State: AGRZ1gL3yE2BOEbhMGRhvsn4pgz9WI9t4qXYfr/1UkWJav3xSa5vo6xc
        NKoET+/RDx97pg3FlvTlR5ySWEA2S+Kj/lnS+QDD1DAzcg+a
X-Google-Smtp-Source: AJdET5feFZFv/bQJPNP/mKZf8DLRxDWTP6cKiBKs1j17l1pN3S7u5TaA+7k3v+c4PNergq21rEAyNBVqMryEOKIYdsckM+sJbEMc
MIME-Version: 1.0
X-Received: by 2002:a02:9952:: with SMTP id d18-v6mr171064jak.19.1542017043743;
 Mon, 12 Nov 2018 02:04:03 -0800 (PST)
Date:   Mon, 12 Nov 2018 02:04:03 -0800
In-Reply-To: <00000000000065a79f057a095de8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000214dc1057a74d206@google.com>
Subject: Re: WARNING in usb_submit_urb (4)
From:   syzbot <syzbot+7634edaea4d0b341c625@syzkaller.appspotmail.com>
To:     Thinh.Nguyen@synopsys.com, felipe.balbi@linux.intel.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, shuah@kernel.org,
        stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    e12e00e388de Merge tag 'kbuild-fixes-v4.20' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=100e4ef5400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f215f21f041a0d7
dashboard link: https://syzkaller.appspot.com/bug?extid=7634edaea4d0b341c625
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11ce6fbd400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+7634edaea4d0b341c625@syzkaller.appspotmail.com

hub 3-0:1.0: 8 ports detected
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 8 ports detected
------------[ cut here ]------------
URB 000000005e43faa5 submitted while active
WARNING: CPU: 0 PID: 6240 at drivers/usb/core/urb.c:363  
usb_submit_urb+0x11cf/0x14e0 drivers/usb/core/urb.c:363
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 6240 Comm: kworker/0:1 Not tainted 4.20.0-rc1+ #332
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events_power_efficient hub_init_func2
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x39d lib/dump_stack.c:113
  panic+0x2ad/0x55c kernel/panic.c:188
  __warn.cold.8+0x20/0x45 kernel/panic.c:540
  report_bug+0x254/0x2d0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:178 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:271
  do_invalid_op+0x36/0x40 arch/x86/kernel/traps.c:290
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:969
RIP: 0010:usb_submit_urb+0x11cf/0x14e0 drivers/usb/core/urb.c:363
Code: ee e8 95 62 7b fc 45 84 ed 0f 85 e2 f6 ff ff e8 b7 61 7b fc 48 89 de  
48 c7 c7 a0 32 92 88 c6 05 d4 45 0d 05 01 e8 11 c5 44 fc <0f> 0b e9 c0 f6  
ff ff c7 45 a0 01 00 00 00 e9 65 f7 ff ff 41 bc ed
RSP: 0018:ffff8881c1f974f0 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff8881c83bb800 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8165e7e5 RDI: 0000000000000005
RBP: ffff8881c1f97560 R08: ffff8881bc062040 R09: ffffed103b5c3ef8
R10: ffffed103b5c3ef8 R11: ffff8881dae1f7c7 R12: 00000000fffffff0
R13: 0000000000000000 R14: 0000000000000009 R15: ffff8881c1f976f8
  hub_activate+0xcab/0x1940 drivers/usb/core/hub.c:1215
  hub_init_func2+0x1e/0x30 drivers/usb/core/hub.c:1240
  process_one_work+0xc90/0x1c40 kernel/workqueue.c:2153
  worker_thread+0x17f/0x1390 kernel/workqueue.c:2296
  kthread+0x35a/0x440 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
Kernel Offset: disabled
Rebooting in 86400 seconds..

