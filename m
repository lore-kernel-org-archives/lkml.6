Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57235ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 15:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 271A120825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 15:11:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 271A120825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbeKIArA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 19:47:00 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:42330 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbeKIArA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 19:47:00 -0500
Received: by mail-io1-f70.google.com with SMTP id q22-v6so23590610iog.9
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 07:11:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=GgEHNiSQq/HFaVjMagNnXCetd1D4OcEPlMoCZBN4kOM=;
        b=I2wrpIrVAg8+j/MclldCB7kXqkLX7bRxlrMI+qYMMYzbXzzQTJFWrLC/QhhZsVUYHG
         48LYj3PiDlBKmW6sfdFWKSB9XWjkyq8fIkKR3PjnDi8nBPxlL/NBkt4zQHkGLH9Euxqo
         SSA3GwXQK6jo6ZxPA0F/2ynsNaG593utuKQx/TkGE3erSMp5t1MX28B2l8sFEYkS4End
         lczNkRVVm1LDcs0jhhxdCKTPN3tA7tGjqR8PEhBWxzg+XrDFVnEBXmXc/ZB4aShXjVhE
         yDZdUDbRcQ4UxsUEmCZQi12E8ir0tNyRuESLXNXAnYwS+K2WkDre0YwhFor1vUIamRMs
         vqbQ==
X-Gm-Message-State: AGRZ1gJBE1mW6bduI6eFpCtSsm3ma/UP3oURB7t/CETSEMul8bNmEsoO
        wEQkBj5VKkvjS9F9hxySB/Fg1s7K3xQcEyW2diWC4PIcRJ2H
X-Google-Smtp-Source: AJdET5cxujVorq4EhhsaeZyj7KfWCZNS8AmCwm3K97OSFlrQJCF+AS6h4LnCgI3tFUNjrwhMxr0Ds6cu1tBEIb9ytV8MocMwxS19
MIME-Version: 1.0
X-Received: by 2002:a24:bdc7:: with SMTP id x190-v6mr1222726ite.21.1541689863377;
 Thu, 08 Nov 2018 07:11:03 -0800 (PST)
Date:   Thu, 08 Nov 2018 07:11:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a91c14057a28a4ae@google.com>
Subject: KASAN: global-out-of-bounds Read in tpg_print_str_4
From:   syzbot <syzbot+ccf0a61ed12f2a7313ee@syzkaller.appspotmail.com>
To:     bwinther@cisco.com, hverkuil@xs4all.nl, keescook@chromium.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        mchehab@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    85758777c2a2 Merge tag 'hwmon-for-v4.20-rc2' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=157af45d400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f559fee2fc3375a
dashboard link: https://syzkaller.appspot.com/bug?extid=ccf0a61ed12f2a7313ee
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
userspace arch: i386

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+ccf0a61ed12f2a7313ee@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: global-out-of-bounds in tpg_print_str_4+0xbc9/0xd70  
drivers/media/common/v4l2-tpg/v4l2-tpg-core.c:1820
Read of size 1 at addr ffffffff88631c50 by task vivid-000-vid-c/7282

CPU: 0 PID: 7282 Comm: vivid-000-vid-c Not tainted 4.20.0-rc1+ #228
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x39d lib/dump_stack.c:113
  print_address_description.cold.7+0x58/0x1ff mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.8+0x242/0x309 mm/kasan/report.c:412
  __asan_report_load1_noabort+0x14/0x20 mm/kasan/report.c:430
  tpg_print_str_4+0xbc9/0xd70  
drivers/media/common/v4l2-tpg/v4l2-tpg-core.c:1820
  tpg_gen_text+0x4ba/0x540 drivers/media/common/v4l2-tpg/v4l2-tpg-core.c:1874
  vivid_fillbuff+0x3ff7/0x68e0  
drivers/media/platform/vivid/vivid-kthread-cap.c:532
  vivid_thread_vid_cap_tick  
drivers/media/platform/vivid/vivid-kthread-cap.c:709 [inline]
  vivid_thread_vid_cap+0xbc1/0x2650  
drivers/media/platform/vivid/vivid-kthread-cap.c:813
  kthread+0x35a/0x440 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352

The buggy address belongs to the variable:
  font_vga_8x16+0x50/0x60

Memory state around the buggy address:
  ffffffff88631b00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  ffffffff88631b80: 00 00 00 00 fa fa fa fa 00 fa fa fa fa fa fa fa
> ffffffff88631c00: 00 00 00 00 00 fa fa fa fa fa fa fa 00 00 00 00
                                                  ^
  ffffffff88631c80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  ffffffff88631d00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
