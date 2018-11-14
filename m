Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E2ADC07E85
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 07:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DCCE223DD
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 07:18:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DCCE223DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731980AbeKNRUI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 12:20:08 -0500
Received: from mail-it1-f198.google.com ([209.85.166.198]:33322 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727375AbeKNRUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 12:20:06 -0500
Received: by mail-it1-f198.google.com with SMTP id w68so3889129ith.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 23:18:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=oKZFd+ijTALEACq4VyK3aBsoKW4wWHUTyuI+flcvKYM=;
        b=qR/asDsmVP+21j9ovwylPL2ijlpkBfTMdoBDw3m/Pw7p4amIaHshxmsYeEEGOFvh5I
         dNm+B8K3jQnxwHPFq15dL8r6UnuJDzFE6JqxibNesftkIuWeNMh9Dl29u2lOJEmezTsg
         QxdT867BeDUqWbTtB7BMyfqHkZimMEBo83XMzZ0mxkXLnfsW+ZX5YIBzJHy+yeSDCGCV
         rG9nH0YMixenc734+FmrymV1t0Jwab3GCArm3JCnICsv+5xVDUhB3TwfN5i2B8LP3YeY
         B1IxArkV45u5kWEj6M7J5h5MfN9qahE35ct24xCFTWJ+LYgiWENullcKMoNmEb43UbFm
         UVVw==
X-Gm-Message-State: AA+aEWZsf4AAwXX122MdFIoeIYOYOMy7+VxMQGqPTTeks+SidFg2j5rW
        jb+gNieYifAR3crQ8gz54HPUW2QiM/+lLZ0rfTUR6vCMPc5s
X-Google-Smtp-Source: AJdET5dOOTMF8JLsORqC91uHyyuXjTY+AjVPd4RiMWV3E9ycT1jhpD8lkFdYcmDynUIJ211U8rsW8sgvOAbFxlYbcXGHUODEoGyq
MIME-Version: 1.0
X-Received: by 2002:a24:7a4b:: with SMTP id a72-v6mr760964itc.8.1542179886980;
 Tue, 13 Nov 2018 23:18:06 -0800 (PST)
Date:   Tue, 13 Nov 2018 23:18:06 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000057e614057a9abcd3@google.com>
Subject: KASAN: null-ptr-deref Read in refcount_sub_and_test_checked (2)
From:   syzbot <syzbot+0468b73bdbb243217224@syzkaller.appspotmail.com>
To:     kyungmin.park@samsung.com, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, m.szyprowski@samsung.com,
        mchehab@kernel.org, pawel@osciak.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    ccda4af0f4b9 Linux 4.20-rc2
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16f9cb0b400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4a0a89f12ca9b0f5
dashboard link: https://syzkaller.appspot.com/bug?extid=0468b73bdbb243217224
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16d20893400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=118f5a2b400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+0468b73bdbb243217224@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: null-ptr-deref in atomic_read  
include/asm-generic/atomic-instrumented.h:21 [inline]
BUG: KASAN: null-ptr-deref in refcount_sub_and_test_checked+0x9d/0x310  
lib/refcount.c:179
Read of size 4 at addr 0000000000000020 by task syz-executor487/6051

CPU: 0 PID: 6051 Comm: syz-executor487 Not tainted 4.20.0-rc2+ #333
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x39d lib/dump_stack.c:113
  kasan_report_error mm/kasan/report.c:352 [inline]
  kasan_report.cold.8+0x6d/0x309 mm/kasan/report.c:412
  check_memory_region_inline mm/kasan/kasan.c:260 [inline]
  check_memory_region+0x13e/0x1b0 mm/kasan/kasan.c:267
  kasan_check_read+0x11/0x20 mm/kasan/kasan.c:272
  atomic_read include/asm-generic/atomic-instrumented.h:21 [inline]
  refcount_sub_and_test_checked+0x9d/0x310 lib/refcount.c:179
  refcount_dec_and_test_checked+0x1a/0x20 lib/refcount.c:212
  vb2_vmalloc_put+0x19/0x80  
drivers/media/common/videobuf2/videobuf2-vmalloc.c:68
  __vb2_buf_mem_free+0x112/0x210  
drivers/media/common/videobuf2/videobuf2-core.c:242
  __vb2_free_mem drivers/media/common/videobuf2/videobuf2-core.c:413 [inline]
  __vb2_queue_free+0x830/0xa30  
drivers/media/common/videobuf2/videobuf2-core.c:458
  vb2_core_queue_release+0x62/0x80  
drivers/media/common/videobuf2/videobuf2-core.c:2231
  vb2_queue_release drivers/media/common/videobuf2/videobuf2-v4l2.c:837  
[inline]
  _vb2_fop_release+0x1d2/0x2b0  
drivers/media/common/videobuf2/videobuf2-v4l2.c:1010
  vb2_fop_release+0x77/0xc0  
drivers/media/common/videobuf2/videobuf2-v4l2.c:1024
  vivid_fop_release+0x18e/0x440 drivers/media/platform/vivid/vivid-core.c:474
  v4l2_release+0x224/0x3a0 drivers/media/v4l2-core/v4l2-dev.c:456
  __fput+0x385/0xa30 fs/file_table.c:278
  ____fput+0x15/0x20 fs/file_table.c:309
  task_work_run+0x1e8/0x2a0 kernel/task_work.c:113
  exit_task_work include/linux/task_work.h:22 [inline]
  do_exit+0x1ad6/0x26d0 kernel/exit.c:867
  do_group_exit+0x177/0x440 kernel/exit.c:970
  __do_sys_exit_group kernel/exit.c:981 [inline]
  __se_sys_exit_group kernel/exit.c:979 [inline]
  __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:979
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x442c78
Code: Bad RIP value.
RSP: 002b:00007fff4ac5a278 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000442c78
RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
RBP: 00000000004c2848 R08: 00000000000000e7 R09: ffffffffffffffd0
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00000000006d4180 R14: 0000000000000000 R15: 0000000000000000
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
