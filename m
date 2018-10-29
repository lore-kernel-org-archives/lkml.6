Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2789C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94D8220873
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:28:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94D8220873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729680AbeJ2SPx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 14:15:53 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:39179 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729536AbeJ2SPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 14:15:53 -0400
Received: by mail-io1-f71.google.com with SMTP id o8-v6so7502921iom.6
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 02:28:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=1OenUvgXbL0fDUNxkTbqhCmMAngODEv1vsbfFxtd8q0=;
        b=FKk+gVXFWP5weJ8N7EVX2vKhjDyS1KmhDooKpVmwzUIX22vnh9pKp+ogn1zsQLmqxd
         ga46pCwkDNciG3f8+i9ODdZ7W7xF4sAv64LP2pZd/A8Qe28X9DDcdOnYrktEcIqE44/m
         arGqaxbx70TfGEp2VP2gnOUl5WmQgs8qiGUREbaaHokh1hcnS24lRnuCwbV/nl9uZJSN
         UVSd7T5nzgjyxLACD57MmWaVIPBalWWwhOUgDQv2M1dUBezECh+LmZROGadMwF3jxS5e
         E8rjcsh9sebJBO+D9txFz9x4tTeRlUdsAJ7hvO1rW7dr5j4lWvYrnWI5K5Es/K9zxGk4
         xv1w==
X-Gm-Message-State: AGRZ1gL2sgRXD/aEwH3/j4vFJ1XQOVCxHW6/eE5cwr0NTIJiDK7D5M3y
        yoSF3w7NcOBfZVbWvV15uQTAzSkcGWyHkTTTzTot9sL+hI3s
X-Google-Smtp-Source: AJdET5dIYGylaDaoG7wUvG8Z4DM8pd9hv2E1aNokIlK2OU+RcaQRSadqRMagIETSzrAN5GgQ2io0ajahbZVT84IOGIQFApb0ZUT8
MIME-Version: 1.0
X-Received: by 2002:a6b:8e51:: with SMTP id q78-v6mr3338663iod.33.1540805283396;
 Mon, 29 Oct 2018 02:28:03 -0700 (PDT)
Date:   Mon, 29 Oct 2018 02:28:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000095ce6305795aafbb@google.com>
Subject: KASAN: null-ptr-deref Write in kthread_stop
From:   syzbot <syzbot+53d5b2df0d9744411e2e@syzkaller.appspotmail.com>
To:     hverkuil@xs4all.nl, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, mchehab@kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    8c60c36d0b8c Add linux-next specific files for 20181019
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16128d7b400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ddc97ab84fb1ff2a
dashboard link: https://syzkaller.appspot.com/bug?extid=53d5b2df0d9744411e2e
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=124b1e83400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+53d5b2df0d9744411e2e@syzkaller.appspotmail.com

8021q: adding VLAN 0 to HW filter on device team0
8021q: adding VLAN 0 to HW filter on device team0
8021q: adding VLAN 0 to HW filter on device team0
vivid-000: kernel_thread() failed
==================================================================
BUG: KASAN: null-ptr-deref in atomic_inc  
include/asm-generic/atomic-instrumented.h:109 [inline]
BUG: KASAN: null-ptr-deref in kthread_stop+0x108/0x8f0 kernel/kthread.c:545
Write of size 4 at addr 000000000000001c by task syz-executor3/7274

CPU: 1 PID: 7274 Comm: syz-executor3 Not tainted 4.19.0-rc8-next-20181019+  
#99
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x39d lib/dump_stack.c:113
  kasan_report_error mm/kasan/report.c:352 [inline]
  kasan_report.cold.8+0x6d/0x309 mm/kasan/report.c:412
  check_memory_region_inline mm/kasan/kasan.c:260 [inline]
  check_memory_region+0x13e/0x1b0 mm/kasan/kasan.c:267
  kasan_check_write+0x14/0x20 mm/kasan/kasan.c:278
  atomic_inc include/asm-generic/atomic-instrumented.h:109 [inline]
  kthread_stop+0x108/0x8f0 kernel/kthread.c:545
  vivid_stop_generating_vid_cap+0x2bc/0x93b  
drivers/media/platform/vivid/vivid-kthread-cap.c:919
  vid_cap_stop_streaming+0x8d/0xe0  
drivers/media/platform/vivid/vivid-vid-cap.c:259
  __vb2_queue_cancel+0x171/0xca0  
drivers/media/common/videobuf2/videobuf2-core.c:1668
  vb2_core_streamoff+0x60/0x140  
drivers/media/common/videobuf2/videobuf2-core.c:1804
  __vb2_cleanup_fileio+0x73/0x160  
drivers/media/common/videobuf2/videobuf2-core.c:2325
  vb2_core_queue_release+0x1e/0x80  
drivers/media/common/videobuf2/videobuf2-core.c:2052
  vb2_queue_release drivers/media/common/videobuf2/videobuf2-v4l2.c:672  
[inline]
  _vb2_fop_release+0x1d2/0x2b0  
drivers/media/common/videobuf2/videobuf2-v4l2.c:843
  vb2_fop_release+0x77/0xc0  
drivers/media/common/videobuf2/videobuf2-v4l2.c:857
  vivid_fop_release+0x18e/0x440 drivers/media/platform/vivid/vivid-core.c:474
  v4l2_release+0xfb/0x1a0 drivers/media/v4l2-core/v4l2-dev.c:448
  __fput+0x3bc/0xa70 fs/file_table.c:279
  ____fput+0x15/0x20 fs/file_table.c:312
  task_work_run+0x1e8/0x2a0 kernel/task_work.c:113
  exit_task_work include/linux/task_work.h:22 [inline]
  do_exit+0x1ad1/0x26d0 kernel/exit.c:867
  do_group_exit+0x177/0x440 kernel/exit.c:970
  get_signal+0x8a8/0x1970 kernel/signal.c:2517
  do_signal+0x9c/0x21c0 arch/x86/kernel/signal.c:816
  exit_to_usermode_loop+0x2e5/0x380 arch/x86/entry/common.c:162
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x483081
Code: 75 14 b8 23 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 d4 f8 f8 ff c3 48  
83 ec 08 e8 ba 70 fd ff 48 89 04 24 b8 23 00 00 00 0f 05 <48> 8b 3c 24 48  
89 c2 e8 03 71 fd ff 48 89 d0 48 83 c4 08 48 3d 01
RSP: 002b:00007ffc69ddaf10 EFLAGS: 00000293 ORIG_RAX: 0000000000000023
RAX: 0000000000000000 RBX: 000000000000fef5 RCX: 0000000000483081
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00007ffc69ddaf20
RBP: 000000000072bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 00007ffc69ddb000 R11: 0000000000000293 R12: 000000000072c900
R13: 00000000000003e8 R14: 000000000000fc39 R15: 000000000000fc0c
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
