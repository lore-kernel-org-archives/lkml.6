Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D6A3C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 11:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE72E2082B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 11:51:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BJuVmpV7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE72E2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728929AbeJ2Uj5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 16:39:57 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:36901 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728033AbeJ2Uj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 16:39:56 -0400
Received: by mail-io1-f65.google.com with SMTP id k17-v6so4742342ioc.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 04:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0mKsBXhYcsDLul10YwfxiiDczdSpYJ+wzShQ2UONIcU=;
        b=BJuVmpV7Z4iZEis+1ha60dtC0GFPqWg9O10AdYgeBTTvx1LfcHw8GuHA8IrHBQ+Bdu
         f4vC3/CPjeLfQ3RbNx4AVPL6M0FsW/8umgrZlehSTl641E75osc0IjeifYFzreGZQ9xt
         6WS0Yu3LtfXuh54nsJRQUFao0Y/cHDIYmjMExYXJS/wz4/TImTbPWG9KLLQrSYBZJkb/
         4vJYYqJGm/arJe8nAuA67jD7/fZNIICrHEs9r437Dlb/Cx9q9s3YFjQGyosJ5A2+o+v/
         wWpPCt6l5ktRHznvrgfUATH4Qf45ULRQlBzkl1XZf+xYcLHQDICIUBTphC0KU15q8ukm
         8PFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0mKsBXhYcsDLul10YwfxiiDczdSpYJ+wzShQ2UONIcU=;
        b=hnLj9Z8agHJ5+BNXeVCyOcOeABDVacNUx2nN7rQtlo1QXcmNFD2+AccLgg4icX09FZ
         j13hS7vAzy9/H7tBuL7lF4fkx5mYOgMv2wkkufAf10CV3aswn07n5LCujswKcnLCu0B5
         MbET+7thXaizD3z6DnITXNzQvtbgfhGqmYaM6XQoWBJTXbse1CCdWPvs8mjO9/DqqNPK
         IBZWOHiZJdw1MlLUrpXWhPmkhOp7F18cTOKTKsHZr6+vMTLeEhIlyaj7mjoOhhFMnWCn
         qYX22JpakWYp7/9kcazJFH44f/4ORb1QaBPQFJgFkDL1x1VSrsz7vrkS2qoJefItAmdp
         rcxg==
X-Gm-Message-State: AGRZ1gIirH/vcGU3wMnVpJ5ASDLwADbIu7r13uDGJVg/xtx/UBGlQnqi
        U/5FC/Z8WXzzGEY7CX66r923FLIrmRnjFJpc44eFqQ==
X-Google-Smtp-Source: AJdET5ewFpFDJr+jJNnFL/FpwFEzQDUZEraZUyGp+0qWDmLkqHVwM8j0dDnG7UV9PvMijYqZbo214FcTW3tzBARMhes=
X-Received: by 2002:a6b:9383:: with SMTP id v125-v6mr6840407iod.282.1540813894997;
 Mon, 29 Oct 2018 04:51:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:1003:0:0:0:0:0 with HTTP; Mon, 29 Oct 2018 04:51:14
 -0700 (PDT)
In-Reply-To: <00000000000053fea105791276d8@google.com>
References: <00000000000053fea105791276d8@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 29 Oct 2018 12:51:14 +0100
Message-ID: <CACT4Y+bnxrCTD=s9X6+JdjkV_gS=qZ99WhJsWypP88af3HzMhw@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in drm_gem_object_release
To:     syzbot <syzbot+e73f2fb5ed5a5df36d33@syzkaller.appspotmail.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        maarten.lankhorst@linux.intel.com, sean@poorly.run,
        David Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 9:18 PM, syzbot
<syzbot+e73f2fb5ed5a5df36d33@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    bd6bf7c10484 Merge tag 'pci-v4.20-changes' of git://git.ke..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1448a683400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=2dd8629d56664133
> dashboard link: https://syzkaller.appspot.com/bug?extid=e73f2fb5ed5a5df36d33
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11331de5400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1334e64d400000

+drm maintainers

> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+e73f2fb5ed5a5df36d33@syzkaller.appspotmail.com
>
>  drm_mode_create_dumb+0x28d/0x310 drivers/gpu/drm/drm_dumb_buffers.c:92
>  drm_mode_create_dumb_ioctl+0x25/0x30 drivers/gpu/drm/drm_dumb_buffers.c:98
>  drm_ioctl_kernel+0x245/0x2f0 drivers/gpu/drm/drm_ioctl.c:751
>  drm_ioctl+0x57a/0xb20 drivers/gpu/drm/drm_ioctl.c:847
> ==================================================================
> BUG: KASAN: use-after-free in drm_gem_object_release+0xf1/0x110
> drivers/gpu/drm/drm_gem.c:813
> Read of size 8 at addr ffff8801d83d3410 by task syz-executor977/6742
>
>  vfs_ioctl fs/ioctl.c:46 [inline]
>  file_ioctl fs/ioctl.c:501 [inline]
>  do_vfs_ioctl+0x1de/0x1720 fs/ioctl.c:685
>  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:702
>  __do_sys_ioctl fs/ioctl.c:709 [inline]
>  __se_sys_ioctl fs/ioctl.c:707 [inline]
>  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:707
>  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x445989
> Code: e8 4c e8 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7
> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff
> 0f 83 6b c8 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007ffcf076f4e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007ffcf076f500 RCX: 0000000000445989
> RDX: 0000000020000000 RSI: ffffffffffffffb2 RDI: 0000000000000003
> RBP: 0000000000000004 R08: 0000000000000001 R09: 0000000000000100
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: ffffffffffffffff R14: 0000000000000000 R15: 0000000000000000
> CPU: 0 PID: 6742 Comm: syz-executor977 Not tainted 4.19.0+ #80
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x244/0x39d lib/dump_stack.c:113
>  print_address_description.cold.7+0x9/0x1ff mm/kasan/report.c:256
>  kasan_report_error mm/kasan/report.c:354 [inline]
>  kasan_report.cold.8+0x242/0x309 mm/kasan/report.c:412
>  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
>  drm_gem_object_release+0xf1/0x110 drivers/gpu/drm/drm_gem.c:813
>  __vgem_gem_destroy drivers/gpu/drm/vgem/vgem_drv.c:175 [inline]
>  vgem_gem_create drivers/gpu/drm/vgem/vgem_drv.c:199 [inline]
>  vgem_gem_dumb_create+0x1f8/0x260 drivers/gpu/drm/vgem/vgem_drv.c:214
>  drm_mode_create_dumb+0x28d/0x310 drivers/gpu/drm/drm_dumb_buffers.c:92
>  drm_mode_create_dumb_ioctl+0x25/0x30 drivers/gpu/drm/drm_dumb_buffers.c:98
>  drm_ioctl_kernel+0x245/0x2f0 drivers/gpu/drm/drm_ioctl.c:751
>  drm_ioctl+0x57a/0xb20 drivers/gpu/drm/drm_ioctl.c:847
>  vfs_ioctl fs/ioctl.c:46 [inline]
>  file_ioctl fs/ioctl.c:501 [inline]
>  do_vfs_ioctl+0x1de/0x1720 fs/ioctl.c:685
>  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:702
>  __do_sys_ioctl fs/ioctl.c:709 [inline]
>  __se_sys_ioctl fs/ioctl.c:707 [inline]
>  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:707
>  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x445989
> Code: e8 4c e8 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7
> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff
> 0f 83 6b c8 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007ffcf076f4e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007ffcf076f500 RCX: 0000000000445989
> RDX: 0000000020000000 RSI: ffffffffffffffb2 RDI: 0000000000000003
> RBP: 0000000000000004 R08: 0000000000000001 R09: 0000000000000100
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: ffffffffffffffff R14: 0000000000000000 R15: 0000000000000000
>
> Allocated by task 6742:
>  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
>  set_track mm/kasan/kasan.c:460 [inline]
>  kasan_kmalloc+0xc7/0xe0 mm/kasan/kasan.c:553
>  kmem_cache_alloc_trace+0x152/0x750 mm/slab.c:3620
>  kmalloc include/linux/slab.h:513 [inline]
>  kzalloc include/linux/slab.h:707 [inline]
>  __vgem_gem_create+0x4c/0x100 drivers/gpu/drm/vgem/vgem_drv.c:158
>  vgem_gem_create drivers/gpu/drm/vgem/vgem_drv.c:187 [inline]
>  vgem_gem_dumb_create+0xce/0x260 drivers/gpu/drm/vgem/vgem_drv.c:214
>  drm_mode_create_dumb+0x28d/0x310 drivers/gpu/drm/drm_dumb_buffers.c:92
>  drm_mode_create_dumb_ioctl+0x25/0x30 drivers/gpu/drm/drm_dumb_buffers.c:98
>  drm_ioctl_kernel+0x245/0x2f0 drivers/gpu/drm/drm_ioctl.c:751
>  drm_ioctl+0x57a/0xb20 drivers/gpu/drm/drm_ioctl.c:847
>  vfs_ioctl fs/ioctl.c:46 [inline]
>  file_ioctl fs/ioctl.c:501 [inline]
>  do_vfs_ioctl+0x1de/0x1720 fs/ioctl.c:685
>  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:702
>  __do_sys_ioctl fs/ioctl.c:709 [inline]
>  __se_sys_ioctl fs/ioctl.c:707 [inline]
>  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:707
>  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>
> Freed by task 6742:
>  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
>  set_track mm/kasan/kasan.c:460 [inline]
>  __kasan_slab_free+0x102/0x150 mm/kasan/kasan.c:521
>  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
>  __cache_free mm/slab.c:3498 [inline]
>  kfree+0xcf/0x230 mm/slab.c:3813
>  vgem_gem_free_object+0xb6/0xe0 drivers/gpu/drm/vgem/vgem_drv.c:61
>  drm_gem_object_free+0xf1/0x2b0 drivers/gpu/drm/drm_gem.c:839
>  kref_put include/linux/kref.h:70 [inline]
>  drm_gem_object_put_unlocked+0x14c/0x180 drivers/gpu/drm/drm_gem.c:895
>  vgem_gem_create drivers/gpu/drm/vgem/vgem_drv.c:192 [inline]
>  vgem_gem_dumb_create+0x120/0x260 drivers/gpu/drm/vgem/vgem_drv.c:214
>  drm_mode_create_dumb+0x28d/0x310 drivers/gpu/drm/drm_dumb_buffers.c:92
>  drm_mode_create_dumb_ioctl+0x25/0x30 drivers/gpu/drm/drm_dumb_buffers.c:98
>  drm_ioctl_kernel+0x245/0x2f0 drivers/gpu/drm/drm_ioctl.c:751
>  drm_ioctl+0x57a/0xb20 drivers/gpu/drm/drm_ioctl.c:847
>  vfs_ioctl fs/ioctl.c:46 [inline]
>  file_ioctl fs/ioctl.c:501 [inline]
>  do_vfs_ioctl+0x1de/0x1720 fs/ioctl.c:685
>  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:702
>  __do_sys_ioctl fs/ioctl.c:709 [inline]
>  __se_sys_ioctl fs/ioctl.c:707 [inline]
>  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:707
>  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>
> The buggy address belongs to the object at ffff8801d83d3300
>  which belongs to the cache kmalloc-512 of size 512
> The buggy address is located 272 bytes inside of
>  512-byte region [ffff8801d83d3300, ffff8801d83d3500)
> The buggy address belongs to the page:
> page:ffffea000760f4c0 count:1 mapcount:0 mapping:ffff8801da800940 index:0x0
> flags: 0x2fffc0000000100(slab)
> raw: 02fffc0000000100 ffffea0007473948 ffffea0007471dc8 ffff8801da800940
> raw: 0000000000000000 ffff8801d83d3080 0000000100000006 0000000000000000
> page dumped because: kasan: bad access detected
>
> Memory state around the buggy address:
>  ffff8801d83d3300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff8801d83d3380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>>
>> ffff8801d83d3400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>
>                          ^
>  ffff8801d83d3480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff8801d83d3500: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ==================================================================
> ==================================================================
> CPU: 0 PID: 6778 Comm: syz-executor977 Tainted: G    B             4.19.0+
> #80
> BUG: KASAN: double-free or invalid-free in __vgem_gem_destroy
> drivers/gpu/drm/vgem/vgem_drv.c:176 [inline]
> BUG: KASAN: double-free or invalid-free in vgem_gem_create
> drivers/gpu/drm/vgem/vgem_drv.c:199 [inline]
> BUG: KASAN: double-free or invalid-free in vgem_gem_dumb_create+0x203/0x260
> drivers/gpu/drm/vgem/vgem_drv.c:214
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
>
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x244/0x39d lib/dump_stack.c:113
>  fail_dump lib/fault-inject.c:51 [inline]
>  should_fail.cold.4+0xa/0x17 lib/fault-inject.c:149
>  __should_failslab+0x124/0x180 mm/failslab.c:32
>  should_failslab+0x9/0x14 mm/slab_common.c:1557
>  slab_pre_alloc_hook mm/slab.h:423 [inline]
>  slab_alloc mm/slab.c:3378 [inline]
>  kmem_cache_alloc_trace+0x2d7/0x750 mm/slab.c:3618
>  kmalloc include/linux/slab.h:513 [inline]
>  drm_vma_node_allow+0x5f/0x290 drivers/gpu/drm/drm_vma_manager.c:277
>  drm_gem_handle_create_tail+0x233/0x440 drivers/gpu/drm/drm_gem.c:409
>  drm_gem_handle_create+0x52/0x60 drivers/gpu/drm/drm_gem.c:452
>  vgem_gem_create drivers/gpu/drm/vgem/vgem_drv.c:191 [inline]
>  vgem_gem_dumb_create+0x115/0x260 drivers/gpu/drm/vgem/vgem_drv.c:214
>  drm_mode_create_dumb+0x28d/0x310 drivers/gpu/drm/drm_dumb_buffers.c:92
>  drm_mode_create_dumb_ioctl+0x25/0x30 drivers/gpu/drm/drm_dumb_buffers.c:98
>  drm_ioctl_kernel+0x245/0x2f0 drivers/gpu/drm/drm_ioctl.c:751
>  drm_ioctl+0x57a/0xb20 drivers/gpu/drm/drm_ioctl.c:847
>  vfs_ioctl fs/ioctl.c:46 [inline]
>  file_ioctl fs/ioctl.c:501 [inline]
>  do_vfs_ioctl+0x1de/0x1720 fs/ioctl.c:685
>  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:702
>  __do_sys_ioctl fs/ioctl.c:709 [inline]
>  __se_sys_ioctl fs/ioctl.c:707 [inline]
>  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:707
>  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x445989
> Code: e8 4c e8 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7
> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff
> 0f 83 6b c8 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007ffcf076f4e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007ffcf076f500 RCX: 0000000000445989
> RDX: 0000000020000000 RSI: ffffffffffffffb2 RDI: 0000000000000003
> RBP: 0000000000000004 R08: 0000000000000001 R09: 0000000000000100
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: ffffffffffffffff R14: 0000000000000000 R15: 0000000000000000
> CPU: 1 PID: 6767 Comm: syz-executor977 Tainted: G    B             4.19.0+
> #80
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x244/0x39d lib/dump_stack.c:113
>  print_address_description.cold.7+0x9/0x1ff mm/kasan/report.c:256
>  kasan_report_invalid_free+0x64/0xa0 mm/kasan/report.c:336
>  __kasan_slab_free+0x13a/0x150 mm/kasan/kasan.c:501
>  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
>  __cache_free mm/slab.c:3498 [inline]
>  kfree+0xcf/0x230 mm/slab.c:3813
>  __vgem_gem_destroy drivers/gpu/drm/vgem/vgem_drv.c:176 [inline]
>  vgem_gem_create drivers/gpu/drm/vgem/vgem_drv.c:199 [inline]
>  vgem_gem_dumb_create+0x203/0x260 drivers/gpu/drm/vgem/vgem_drv.c:214
>  drm_mode_create_dumb+0x28d/0x310 drivers/gpu/drm/drm_dumb_buffers.c:92
>  drm_mode_create_dumb_ioctl+0x25/0x30 drivers/gpu/drm/drm_dumb_buffers.c:98
>  drm_ioctl_kernel+0x245/0x2f0 drivers/gpu/drm/drm_ioctl.c:751
>  drm_ioctl+0x57a/0xb20 drivers/gpu/drm/drm_ioctl.c:847
>  vfs_ioctl fs/ioctl.c:46 [inline]
>  file_ioctl fs/ioctl.c:501 [inline]
>  do_vfs_ioctl+0x1de/0x1720 fs/ioctl.c:685
>  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:702
>  __do_sys_ioctl fs/ioctl.c:709 [inline]
>  __se_sys_ioctl fs/ioctl.c:707 [inline]
>  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:707
>  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x445989
> Code: e8 4c e8 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7
> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff
> 0f 83 6b c8 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007ffcf076f4e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007ffcf076f500 RCX: 0000000000445989
> RDX: 0000000020000000 RSI: ffffffffffffffb2 RDI: 0000000000000003
> RBP: 0000000000000004 R08: 0000000000000001 R09: 0000000000000100
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: ffffffffffffffff R14: 0000000000000000 R15: 0000000000000000
>
> Allocated by task 6767:
>  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
>  set_track mm/kasan/kasan.c:460 [inline]
>  kasan_kmalloc+0xc7/0xe0 mm/kasan/kasan.c:553
>  kmem_cache_alloc_trace+0x152/0x750 mm/slab.c:3620
>  kmalloc include/linux/slab.h:513 [inline]
>  kzalloc include/linux/slab.h:707 [inline]
>  __vgem_gem_create+0x4c/0x100 drivers/gpu/drm/vgem/vgem_drv.c:158
>  vgem_gem_create drivers/gpu/drm/vgem/vgem_drv.c:187 [inline]
>  vgem_gem_dumb_create+0xce/0x260 drivers/gpu/drm/vgem/vgem_drv.c:214
>  drm_mode_create_dumb+0x28d/0x310 drivers/gpu/drm/drm_dumb_buffers.c:92
>  drm_mode_create_dumb_ioctl+0x25/0x30 drivers/gpu/drm/drm_dumb_buffers.c:98
>  drm_ioctl_kernel+0x245/0x2f0 drivers/gpu/drm/drm_ioctl.c:751
>  drm_ioctl+0x57a/0xb20 drivers/gpu/drm/drm_ioctl.c:847
>  vfs_ioctl fs/ioctl.c:46 [inline]
>  file_ioctl fs/ioctl.c:501 [inline]
>  do_vfs_ioctl+0x1de/0x1720 fs/ioctl.c:685
>  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:702
>  __do_sys_ioctl fs/ioctl.c:709 [inline]
>  __se_sys_ioctl fs/ioctl.c:707 [inline]
>  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:707
>  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>
> Freed by task 6767:
>  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
>  set_track mm/kasan/kasan.c:460 [inline]
>  __kasan_slab_free+0x102/0x150 mm/kasan/kasan.c:521
>  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
>  __cache_free mm/slab.c:3498 [inline]
>  kfree+0xcf/0x230 mm/slab.c:3813
>  vgem_gem_free_object+0xb6/0xe0 drivers/gpu/drm/vgem/vgem_drv.c:61
>  drm_gem_object_free+0xf1/0x2b0 drivers/gpu/drm/drm_gem.c:839
>  kref_put include/linux/kref.h:70 [inline]
>  drm_gem_object_put_unlocked+0x14c/0x180 drivers/gpu/drm/drm_gem.c:895
>  vgem_gem_create drivers/gpu/drm/vgem/vgem_drv.c:192 [inline]
>  vgem_gem_dumb_create+0x120/0x260 drivers/gpu/drm/vgem/vgem_drv.c:214
>  drm_mode_create_dumb+0x28d/0x310 drivers/gpu/drm/drm_dumb_buffers.c:92
>  drm_mode_create_dumb_ioctl+0x25/0x30 drivers/gpu/drm/drm_dumb_buffers.c:98
>  drm_ioctl_kernel+0x245/0x2f0 drivers/gpu/drm/drm_ioctl.c:751
>  drm_ioctl+0x57a/0xb20 drivers/gpu/drm/drm_ioctl.c:847
>  vfs_ioctl fs/ioctl.c:46 [inline]
>  file_ioctl fs/ioctl.c:501 [inline]
>  do_vfs_ioctl+0x1de/0x1720 fs/ioctl.c:685
>  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:702
>  __do_sys_ioctl fs/ioctl.c:709 [inline]
>  __se_sys_ioctl fs/ioctl.c:707 [inline]
>  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:707
>  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>
> The buggy address belongs to the object at ffff8801d4974080
>  which belongs to the cache kmalloc-512 of size 512
> The buggy address is located 0 bytes inside of
>  512-byte region [ffff8801d4974080, ffff8801d4974280)
> The buggy address belongs to the page:
> page:ffffea0007525d00 count:1 mapcount:0 mapping:ffff8801da800940 index:0x0
> flags: 0x2fffc0000000100(slab)
> raw: 02fffc0000000100 ffffea0007558e48 ffffea00071d0508 ffff8801da800940
> raw: 0000000000000000 ffff8801d4974080 0000000100000006 0000000000000000
> page dumped because: kasan: bad access detected
>
> Memory state around the buggy address:
>  ffff8801d4973f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>  ffff8801d4974000: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>>
>> ffff8801d4974080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>
>                    ^
>  ffff8801d4974100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff8801d4974180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ==================================================================
> ==================================================================
>
>
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with
> syzbot.
> syzbot can test patches for this bug, for details see:
> https://goo.gl/tpsmEJ#testing-patches
>
> --
> You received this message because you are subscribed to the Google Groups
> "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an
> email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit
> https://groups.google.com/d/msgid/syzkaller-bugs/00000000000053fea105791276d8%40google.com.
> For more options, visit https://groups.google.com/d/optout.
