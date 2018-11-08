Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B6FECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 20:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98578206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 20:38:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98578206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbeKIGPO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 01:15:14 -0500
Received: from mail-it1-f199.google.com ([209.85.166.199]:56611 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbeKIGPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 01:15:14 -0500
Received: by mail-it1-f199.google.com with SMTP id m123-v6so14029ite.6
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 12:38:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=P09Ff9hA0rxQyh2HrEk30bjER+AEaNefKM6J01oyq0A=;
        b=FYom2E41EI/EGSg8Pd+qy3tr3aZHxm/8aRJ+BsZORTGeUgYXIu4ane1vl8GV6G/0Jv
         wwfDRyS7+rjSR9j5xevISyspN3A52BiO6k+OFJWDa1yL0Qy+ok4cIgynyGL6lYG15xRD
         57tGCjqhQA6bYQPxvgQFcWOelOno16MbB7xE3HLsY5i7ZRY9DCQowIon6p3zIqbUEo0J
         tk96Ypz5dzTaZPmBFpfuckMr2Xb2llSWn22ZcCMbF3/KtTfYlYaqbhuu2FQSJXumq2u0
         0NqyONOD+LL4X0IqttiR+HIEIMQS3HEELQtcjlsW+ZOtDsRYEbau/bcj4xfM3sPgP1pF
         MpJg==
X-Gm-Message-State: AGRZ1gIxEsERIM8uVfSEyya2d6Jb1JDy75plqPWFe51mRAiJ7Pukb9T/
        UmJL9rbCxIEETpOblrQwlvMSko63e6ocoyfP3zf7uHlvtb/v
X-Google-Smtp-Source: AJdET5fZ9TvXWfrcqE+s7cGIQXM/eKR4kEAbwn7HlK1U9BQ9GeP4RcJYWXOzaXjlJ/M2earHrZ11GIHOTtghbs40V4AdFXY2vpx4
MIME-Version: 1.0
X-Received: by 2002:a24:ed82:: with SMTP id r124-v6mr2043727ith.39.1541709483846;
 Thu, 08 Nov 2018 12:38:03 -0800 (PST)
Date:   Thu, 08 Nov 2018 12:38:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000021d9a9057a2d364e@google.com>
Subject: KMSAN: uninit-value in linear_transfer (2)
From:   syzbot <syzbot+1cb36954e127c98dd037@syzkaller.appspotmail.com>
To:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        perex@perex.cz, syzkaller-bugs@googlegroups.com, tiwai@suse.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    7438a3b20295 kmsan: print user address when reporting info..
git tree:       https://github.com/google/kmsan.git/master
console output: https://syzkaller.appspot.com/x/log.txt?x=15b42133400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8df5fc509a1b351b
dashboard link: https://syzkaller.appspot.com/bug?extid=1cb36954e127c98dd037
compiler:       clang version 8.0.0 (trunk 343298)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12be9825400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13e2c425400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+1cb36954e127c98dd037@syzkaller.appspotmail.com

==================================================================
BUG: KMSAN: uninit-value in __arch_swab32  
arch/x86/include/uapi/asm/swab.h:10 [inline]
BUG: KMSAN: uninit-value in __fswab32 include/uapi/linux/swab.h:59 [inline]
BUG: KMSAN: uninit-value in do_convert sound/core/oss/linear.c:50 [inline]
BUG: KMSAN: uninit-value in convert sound/core/oss/linear.c:81 [inline]
BUG: KMSAN: uninit-value in linear_transfer+0x92d/0xca0  
sound/core/oss/linear.c:110
CPU: 1 PID: 6835 Comm: syz-executor866 Not tainted 4.19.0+ #78
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x32d/0x480 lib/dump_stack.c:113
  kmsan_report+0x19f/0x300 mm/kmsan/kmsan.c:911
  __msan_warning+0x76/0xd0 mm/kmsan/kmsan_instr.c:415
  __arch_swab32 arch/x86/include/uapi/asm/swab.h:10 [inline]
  __fswab32 include/uapi/linux/swab.h:59 [inline]
  do_convert sound/core/oss/linear.c:50 [inline]
  convert sound/core/oss/linear.c:81 [inline]
  linear_transfer+0x92d/0xca0 sound/core/oss/linear.c:110
  snd_pcm_plug_read_transfer+0x3bf/0x590 sound/core/oss/pcm_plugin.c:659
  snd_pcm_oss_read2 sound/core/oss/pcm_oss.c:1480 [inline]
  snd_pcm_oss_read1 sound/core/oss/pcm_oss.c:1518 [inline]
  snd_pcm_oss_read+0xe6d/0x1cb0 sound/core/oss/pcm_oss.c:2758
  __vfs_read+0x1e2/0xb10 fs/read_write.c:416
  vfs_read+0x380/0x6b0 fs/read_write.c:452
  ksys_read fs/read_write.c:578 [inline]
  __do_sys_read fs/read_write.c:588 [inline]
  __se_sys_read+0x17a/0x370 fs/read_write.c:586
  __x64_sys_read+0x4a/0x70 fs/read_write.c:586
  do_syscall_64+0xcf/0x110 arch/x86/entry/common.c:291
  entry_SYSCALL_64_after_hwframe+0x63/0xe7
RIP: 0033:0x446379
Code: e8 0c e8 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b 08 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fcd5b97cda8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 00000000006dac38 RCX: 0000000000446379
RDX: 0000000000000184 RSI: 0000000020002180 RDI: 0000000000000003
RBP: 00000000006dac30 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dac3c
R13: 7073642f7665642f R14: 00800000c0045002 R15: 0000000000000001

Uninit was stored to memory at:
  kmsan_save_stack_with_flags mm/kmsan/kmsan.c:252 [inline]
  kmsan_save_stack mm/kmsan/kmsan.c:267 [inline]
  kmsan_internal_chain_origin+0x136/0x240 mm/kmsan/kmsan.c:569
  kmsan_memcpy_origins+0x13d/0x1b0 mm/kmsan/kmsan.c:393
  __msan_memcpy+0x6f/0x80 mm/kmsan/kmsan_instr.c:242
  do_convert sound/core/oss/linear.c:48 [inline]
  convert sound/core/oss/linear.c:81 [inline]
  linear_transfer+0x74c/0xca0 sound/core/oss/linear.c:110
  snd_pcm_plug_read_transfer+0x3bf/0x590 sound/core/oss/pcm_plugin.c:659
  snd_pcm_oss_read2 sound/core/oss/pcm_oss.c:1480 [inline]
  snd_pcm_oss_read1 sound/core/oss/pcm_oss.c:1518 [inline]
  snd_pcm_oss_read+0xe6d/0x1cb0 sound/core/oss/pcm_oss.c:2758
  __vfs_read+0x1e2/0xb10 fs/read_write.c:416
  vfs_read+0x380/0x6b0 fs/read_write.c:452
  ksys_read fs/read_write.c:578 [inline]
  __do_sys_read fs/read_write.c:588 [inline]
  __se_sys_read+0x17a/0x370 fs/read_write.c:586
  __x64_sys_read+0x4a/0x70 fs/read_write.c:586
  do_syscall_64+0xcf/0x110 arch/x86/entry/common.c:291
  entry_SYSCALL_64_after_hwframe+0x63/0xe7

Uninit was created at:
  kmsan_save_stack_with_flags mm/kmsan/kmsan.c:252 [inline]
  kmsan_internal_alloc_meta_for_pages+0x155/0x740 mm/kmsan/kmsan.c:689
  kmsan_alloc_page+0x77/0xe0 mm/kmsan/kmsan_hooks.c:320
  __alloc_pages_nodemask+0x12cc/0x6640 mm/page_alloc.c:4416
  alloc_pages_current+0x584/0x7e0 mm/mempolicy.c:2093
  alloc_pages include/linux/gfp.h:511 [inline]
  __vmalloc_area_node mm/vmalloc.c:1689 [inline]
  __vmalloc_node_range+0x879/0x12a0 mm/vmalloc.c:1752
  __vmalloc_node mm/vmalloc.c:1797 [inline]
  __vmalloc_node_flags mm/vmalloc.c:1811 [inline]
  vmalloc+0xd8/0xf0 mm/vmalloc.c:1833
  snd_pcm_plugin_alloc+0x255/0xc80 sound/core/oss/pcm_plugin.c:71
  snd_pcm_plug_alloc+0x281/0x600 sound/core/oss/pcm_plugin.c:137
  snd_pcm_oss_change_params_locked+0x5e40/0x6e30  
sound/core/oss/pcm_oss.c:1039
  snd_pcm_oss_change_params sound/core/oss/pcm_oss.c:1107 [inline]
  snd_pcm_oss_get_active_substream+0x4f7/0x5a0 sound/core/oss/pcm_oss.c:1124
  snd_pcm_oss_get_rate sound/core/oss/pcm_oss.c:1774 [inline]
  snd_pcm_oss_set_rate sound/core/oss/pcm_oss.c:1766 [inline]
  snd_pcm_oss_ioctl+0x4adb/0x8860 sound/core/oss/pcm_oss.c:2614
  do_vfs_ioctl+0xf77/0x2d30 fs/ioctl.c:46
  ksys_ioctl fs/ioctl.c:702 [inline]
  __do_sys_ioctl fs/ioctl.c:709 [inline]
  __se_sys_ioctl+0x1da/0x270 fs/ioctl.c:707
  __x64_sys_ioctl+0x4a/0x70 fs/ioctl.c:707
  do_syscall_64+0xcf/0x110 arch/x86/entry/common.c:291
  entry_SYSCALL_64_after_hwframe+0x63/0xe7
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
