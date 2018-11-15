Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D19ADC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 07:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D18A21582
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 07:39:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D18A21582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728749AbeKORpp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 12:45:45 -0500
Received: from mail-it1-f200.google.com ([209.85.166.200]:55860 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728527AbeKORpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 12:45:44 -0500
Received: by mail-it1-f200.google.com with SMTP id 71-v6so4187226itl.5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 23:39:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=HoexrxShlnP6oVtKTxHBqaBeam+8rv6bdiwAMR4HiTM=;
        b=iM9CgxhoOINRTX+17fTnNrnwzuJ9WHsC/mddsvjg7toBPWJcrcI2QF2/ASO2RUcA17
         rUa8puiShftcEqGlWMjpdnT+PQ2L+ACKH19wiMxZ3kHzy6z2rzfbXXjJHtO4H01qeX43
         iIBQch24UIKMS6Mv7z/2b0KOS4HK6yIvxnkclhBjGNdCSjAvwdFNUlW0ZYyKWIQdOSaH
         drV3qlQoBg7Xx8GiWo685Qg9m5eiPirJ4eqSdNXvFI8ag+p0pJWXbmYjxiTMgeRKJtwO
         48DeQnLltVnkvUmuFOp8qcCzD7eOCS8JrQYZjG2N3udLuiRe32geZM1XxznY1rT+pYWr
         2PPQ==
X-Gm-Message-State: AGRZ1gJTTuGIw/gyjAM3DPNhBR27gtenX69x0V0iaOdEjrIDRyPIlxGS
        ml150dGbbLpfR3h700jSAhZoKdlzNs7P//mts9Mmy03E5i0U
X-Google-Smtp-Source: AFSGD/WvWBqIx2D9NPL8UG1th2XsMJVP4CDATqolneMxKiKdHK6DfXxVPXDmz295QgyYZuIhvSlWlpfj8ZqpSGW8Ow2/QZriCkv+
MIME-Version: 1.0
X-Received: by 2002:a24:153:: with SMTP id 80-v6mr3736916itk.19.1542267542962;
 Wed, 14 Nov 2018 23:39:02 -0800 (PST)
Date:   Wed, 14 Nov 2018 23:39:02 -0800
In-Reply-To: <000000000000aa8703057a7ea0bb@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000c10d8057aaf2514@google.com>
Subject: Re: WARNING in dma_buf_vunmap
From:   syzbot <syzbot+a9317fe7ad261fc76b88@syzkaller.appspotmail.com>
To:     dri-devel@lists.freedesktop.org,
        linaro-mm-sig-owner@lists.linaro.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, sumit.semwal@linaro.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    d41217aac0a5 Merge tag 'pci-v4.20-fixes-1' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15c136d5400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4a0a89f12ca9b0f5
dashboard link: https://syzkaller.appspot.com/bug?extid=a9317fe7ad261fc76b88
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16f7b6f5400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=105a2783400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+a9317fe7ad261fc76b88@syzkaller.appspotmail.com

audit: type=1400 audit(1542267352.102:36): avc:  denied  { map } for   
pid=6158 comm="syz-executor267" path="/root/syz-executor267520803"  
dev="sda1" ino=16483 scontext=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023  
tcontext=unconfined_u:object_r:user_home_t:s0 tclass=file permissive=1
WARNING: CPU: 0 PID: 6180 at drivers/dma-buf/dma-buf.c:992  
dma_buf_vunmap+0x1bb/0x220 drivers/dma-buf/dma-buf.c:992
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 6180 Comm: syz-executor267 Not tainted 4.20.0-rc2+ #113
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
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
RIP: 0010:dma_buf_vunmap+0x1bb/0x220 drivers/dma-buf/dma-buf.c:992
Code: 00 00 00 00 e8 56 f2 27 fd 4c 89 f7 e8 7e 1f 77 03 e8 49 f2 27 fd 48  
83 c4 08 5b 41 5c 41 5d 41 5e 41 5f 5d c3 e8 35 f2 27 fd <0f> 0b eb e3 e8  
2c f2 27 fd 0f 0b e8 25 f2 27 fd 0f 0b e8 1e f2 27
RSP: 0018:ffff8881b17cf948 EFLAGS: 00010293
RAX: ffff8881cde40040 RBX: 0000000000000000 RCX: ffffffff854cfa50
RDX: 0000000000000000 RSI: ffffffff845795ab RDI: 0000000000000000
RBP: ffff8881b17cf978 R08: ffff8881cde40040 R09: ffffed103a5dd096
R10: ffff8881b17cfad0 R11: ffff8881d2ee84b7 R12: ffffc90007465000
R13: ffff8881b100a940 R14: ffff8881b100a9a8 R15: ffff8881d965d800
  vb2_vmalloc_detach_dmabuf+0x5a/0x80  
drivers/media/common/videobuf2/videobuf2-vmalloc.c:406
  __vb2_plane_dmabuf_put.isra.5+0x122/0x310  
drivers/media/common/videobuf2/videobuf2-core.c:275
  __vb2_buf_dmabuf_put drivers/media/common/videobuf2/videobuf2-core.c:291  
[inline]
  __vb2_free_mem drivers/media/common/videobuf2/videobuf2-core.c:415 [inline]
  __vb2_queue_free+0x7f3/0xa30  
drivers/media/common/videobuf2/videobuf2-core.c:458
  vb2_core_queue_release+0x62/0x80  
drivers/media/common/videobuf2/videobuf2-core.c:2231
  vb2_queue_release+0x15/0x20  
drivers/media/common/videobuf2/videobuf2-v4l2.c:837
  v4l2_m2m_ctx_release+0x1e/0x35 drivers/media/v4l2-core/v4l2-mem2mem.c:930
  vim2m_release+0xe6/0x150 drivers/media/platform/vim2m.c:977
  v4l2_release+0x224/0x3a0 drivers/media/v4l2-core/v4l2-dev.c:456
  __fput+0x385/0xa30 fs/file_table.c:278
  ____fput+0x15/0x20 fs/file_table.c:309
  task_work_run+0x1e8/0x2a0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:188 [inline]
  exit_to_usermode_loop+0x318/0x380 arch/x86/entry/common.c:166
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x405731
Code: 75 14 b8 03 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 94 17 00 00 c3 48  
83 ec 08 e8 6a fc ff ff 48 89 04 24 b8 03 00 00 00 0f 05 <48> 8b 3c 24 48  
89 c2 e8 b3 fc ff ff 48 89 d0 48 83 c4 08 48 3d 01
RSP: 002b:00007fff450aae60 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000405731
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 0000000000000003
RBP: 000000000000c12d R08: 00000000006dbc3c R09: 000000037ffffa00
R10: 00007fff450aae80 R11: 0000000000000293 R12: 000000000000002d
R13: 20c49ba5e353f7cf R14: 0000000000000004 R15: 00000000006dbd2c
Kernel Offset: disabled
Rebooting in 86400 seconds..

