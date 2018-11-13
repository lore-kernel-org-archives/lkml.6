Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F52C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 14:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 763182087A
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 14:12:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 763182087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731640AbeKNAK0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 19:10:26 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:47789 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728943AbeKNAKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 19:10:25 -0500
Received: by mail-io1-f72.google.com with SMTP id y8-v6so12825175ioc.14
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 06:12:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=pJrgDtftfIYqYZFj4COtxsOlaJV6LcYpKLYRFoZ2yu0=;
        b=nQtdj+tUfNoHbfxna5xIf6qYlvxUwqPsQpsI7twDr2I4fkFlvlPmhe6M6Yi99D4tzD
         TJ495Okd+8uMBC8m5MYS6YJ2zMbgv4UOVDdm0tanh3W4pB1Y0VWC+sf9Jj7rCGylRDiH
         cjvTvh3tyMflw00OsgtcWKT/OYtkqY81ibp46c9Se8LNgE0Mu4eN4UiX6Wzx1hb193P9
         nlMdhB7qZOZaTvqXsHYuLWHYdv1v1LQu5L7iioTtOw/b+oPt904YYDQPD40d/JDfhzMH
         lnxdJ32TTZqBjhBDUihfzvmQgctdDJltJFXuayYNb+GgKdwuZSJ1Z07SrQffkIegC6Hr
         58UQ==
X-Gm-Message-State: AGRZ1gKazdzSmsm9M5ivWSOyidlB0XarpQ0bKIcYmZxIc3b8cHrGtorI
        wHLfp+BuOXz9zDyYuTHq6sBGMfm0lFSBY0u+bltEuKCmPlse
X-Google-Smtp-Source: AJdET5exTt2Ij94eqKpHkV2TGt2JbTB+UWAQJozg79oeGevYJxyh+Mk/9BpYBbXxBEO0b9dVitH13/lqgJthm0FuDnv9AnFI5ajg
MIME-Version: 1.0
X-Received: by 2002:a24:128e:: with SMTP id 136-v6mr2830266itp.32.1542118324879;
 Tue, 13 Nov 2018 06:12:04 -0800 (PST)
Date:   Tue, 13 Nov 2018 06:12:04 -0800
In-Reply-To: <000000000000a91c14057a28a4ae@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f4d1fb057a8c6621@google.com>
Subject: Re: KASAN: global-out-of-bounds Read in tpg_print_str_4
From:   syzbot <syzbot+ccf0a61ed12f2a7313ee@syzkaller.appspotmail.com>
To:     bwinther@cisco.com, hverkuil@xs4all.nl, keescook@chromium.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        mchehab@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    ccda4af0f4b9 Linux 4.20-rc2
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1779cb0b400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4a0a89f12ca9b0f5
dashboard link: https://syzkaller.appspot.com/bug?extid=ccf0a61ed12f2a7313ee
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=126f0ed5400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15ed6c25400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+ccf0a61ed12f2a7313ee@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: global-out-of-bounds in tpg_print_str_4+0xbc9/0xd70  
drivers/media/common/v4l2-tpg/v4l2-tpg-core.c:1820
Read of size 1 at addr ffffffff88632850 by task vivid-000-vid-c/5989

CPU: 0 PID: 5989 Comm: vivid-000-vid-c Not tainted 4.20.0-rc2+ #236
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
  ffffffff88632700: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  ffffffff88632780: 00 00 00 00 fa fa fa fa 00 fa fa fa fa fa fa fa
> ffffffff88632800: 00 00 00 00 00 fa fa fa fa fa fa fa 00 00 00 00
                                                  ^
  ffffffff88632880: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  ffffffff88632900: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================

