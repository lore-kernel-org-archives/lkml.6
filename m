Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F01C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 01:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3A1B208E3
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 01:55:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E10RW3S3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3A1B208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727396AbeKKLmr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 06:42:47 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:38051 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727078AbeKKLmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 06:42:47 -0500
Received: by mail-it1-f196.google.com with SMTP id k141-v6so8749051itk.3
        for <linux-kernel@vger.kernel.org>; Sat, 10 Nov 2018 17:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vj/ltnRPl2B+xQ7WvV4Qdj3Xp2sftIu3pbM4y3c3vso=;
        b=E10RW3S395HCEIyWkrYBVbPynjcfaV+UdDHAuUkINxfUnjxtoVdShVfonPxg8H9lPm
         VKPlP4bbY0oNusw+IKRCWFuBGmo4a2sw8OuxdzSl0HGAq3q/NVOrhj9jfgJeucLJbYE9
         CXP81Wx6kbpPLkavBiV+lzKPwoD3HH/R/OS8ATCW3BUhclQmHJNfKbrPeqCkBytgALuY
         qITTWkp8KsVDocPcRztC8XfzabSOdIhhCKhdClfazpWdvRhsILWPFKPu7f2xfeKFIecW
         J2QIFL1FTagM8qpxsXUpAf8f9kMVbjyy3psIRc+wkq7J3hRFEVFzmDjpPzqnGjNtRLES
         y2gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vj/ltnRPl2B+xQ7WvV4Qdj3Xp2sftIu3pbM4y3c3vso=;
        b=G/Ftjx09L8QS5PGvBfDfh6thyOq5DiMKoT4UbYkyYJZot/fKlBCJSA82KcwVE+EHwP
         o7WaSMO7VyPsO5ozpcLag97v99AKb7UVsB3tIkT76q0PWWkVHOPtySGdXRTWzOoxQclQ
         fwNecm+TBj7M6hHH8/TfMyXF5fayYUZbQhwmyKSRKex+UumazybevLCaEUMpFEhukmWg
         FSvyPYwwFqg8RrX5zdV5B1lVW7tmIXKermbeHR4mJvggCmWhFQ4RsgxNOnNwtt/QEdvC
         YmGAU+FwkEgA4mFSGl+Fp8MU6x9R82P+eSJWiujZmsc3hTxJjYAhYfY/blJOzhcS13Nv
         XdHw==
X-Gm-Message-State: AGRZ1gIh8C7h2Y7EEjJSqMyCuGUY0DJowXVo02LLWd2n6HV+1fd9e4I7
        IqyH1Shk7Kv0UdUbU6eo5uaCnrGwAMKn+eHfjbn73Q==
X-Google-Smtp-Source: AJdET5fVgFb4BmVJxvw0b7jWKGOpC5722/EnqllGK1HfZ+h4wrxFxR6oY6r8TLdhvRnmPamxlGNvEekrj9R72OxRHHI=
X-Received: by 2002:a24:d1c7:: with SMTP id w190-v6mr3283697itg.144.1541901344655;
 Sat, 10 Nov 2018 17:55:44 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a02:b01b:0:0:0:0:0 with HTTP; Sat, 10 Nov 2018 17:55:24
 -0800 (PST)
In-Reply-To: <000000000000e5a3e1057a59db17@google.com>
References: <000000000000e5a3e1057a59db17@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sat, 10 Nov 2018 17:55:24 -0800
Message-ID: <CACT4Y+YO6i-rEAydWQPadtGw7w_ZDT58Mt6XYybnBdUQMcxh-Q@mail.gmail.com>
Subject: Re: KASAN: slab-out-of-bounds Write in __xfrm_policy_unlink
To:     syzbot <syzbot+1a5442803e5354a25766@syzkaller.appspotmail.com>
Cc:     David Miller <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 10, 2018 at 5:54 PM, syzbot
<syzbot+1a5442803e5354a25766@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    29e12207174a sfc: use the new __netdev_tx_sent_queue BQL o..
> git tree:       net-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=133c2c5d400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=8f559fee2fc3375a
> dashboard link: https://syzkaller.appspot.com/bug?extid=1a5442803e5354a25766
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>
> Unfortunately, I don't have any reproducer for this crash yet.
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+1a5442803e5354a25766@syzkaller.appspotmail.com

May be related to "KASAN: slab-out-of-bounds Write in __xfrm_policy_unlink"
https://syzkaller.appspot.com/bug?extid=aa77660edbf949365033

> ==================================================================
> BUG: KASAN: slab-out-of-bounds in __write_once_size
> include/linux/compiler.h:209 [inline]
> BUG: KASAN: slab-out-of-bounds in __hlist_del include/linux/list.h:702
> [inline]
> BUG: KASAN: slab-out-of-bounds in hlist_del_rcu include/linux/rculist.h:455
> [inline]
> BUG: KASAN: slab-out-of-bounds in __xfrm_policy_unlink+0x75f/0x810
> net/xfrm/xfrm_policy.c:1241
> Write of size 8 at addr ffff8801b979db48 by task blkid/15614
>
> CPU: 1 PID: 15614 Comm: blkid Not tainted 4.20.0-rc1+ #287
> kernel msg: ebtables bug: please report to author: Nentries wrong
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  <IRQ>
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x244/0x39d lib/dump_stack.c:113
>  print_address_description.cold.7+0x9/0x1ff mm/kasan/report.c:256
>  kasan_report_error mm/kasan/report.c:354 [inline]
>  kasan_report.cold.8+0x242/0x309 mm/kasan/report.c:412
>  __asan_report_store8_noabort+0x17/0x20 mm/kasan/report.c:438
>  __write_once_size include/linux/compiler.h:209 [inline]
>  __hlist_del include/linux/list.h:702 [inline]
>  hlist_del_rcu include/linux/rculist.h:455 [inline]
>  __xfrm_policy_unlink+0x75f/0x810 net/xfrm/xfrm_policy.c:1241
>  xfrm_policy_delete+0x49/0x90 net/xfrm/xfrm_policy.c:1266
>  xfrm_policy_timer+0x46f/0x660 net/xfrm/xfrm_policy.c:254
>  call_timer_fn+0x272/0x920 kernel/time/timer.c:1326
>  expire_timers kernel/time/timer.c:1363 [inline]
>  __run_timers+0x7e5/0xc70 kernel/time/timer.c:1682
>  run_timer_softirq+0x52/0xb0 kernel/time/timer.c:1695
>  __do_softirq+0x308/0xb7e kernel/softirq.c:292
>  invoke_softirq kernel/softirq.c:373 [inline]
>  irq_exit+0x17f/0x1c0 kernel/softirq.c:413
>  exiting_irq arch/x86/include/asm/apic.h:536 [inline]
>  smp_apic_timer_interrupt+0x1cb/0x760 arch/x86/kernel/apic/apic.c:1061
>  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:804
>  </IRQ>
> RIP: 0010:arch_local_irq_restore arch/x86/include/asm/paravirt.h:761
> [inline]
> RIP: 0010:count_memcg_events include/linux/memcontrol.h:742 [inline]
> RIP: 0010:count_memcg_event_mm include/linux/memcontrol.h:763 [inline]
> RIP: 0010:handle_mm_fault+0x9a8/0xc70 mm/memory.c:3906
> Code: df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 4e 02 00 00 48 83 3d 78 5b
> 9e 07 00 0f 84 70 01 00 00 e8 7d ea cb ff 4c 89 ff 57 9d <0f> 1f 44 00 00 e9
> 22 fa ff ff e8 69 ea cb ff 49 8d bd 20 04 00 00
> RSP: 0000:ffff8801bbcffcc8 EFLAGS: 00000293 ORIG_RAX: ffffffffffffff13
> RAX: ffff8801bc1ae540 RBX: ffff8801c6f5dca0 RCX: 1ffff10037835dbc
> RDX: 0000000000000000 RSI: ffffffff81b3a043 RDI: 0000000000000293
> RBP: ffff8801bbcffd68 R08: ffff8801bc1aede0 R09: 0000000000000007
> R10: 0000000000000000 R11: ffff8801bc1ae540 R12: 1ffff1003779ff9c
> R13: 0000000000000200 R14: 0000000000000054 R15: 0000000000000293
>  do_user_addr_fault arch/x86/mm/fault.c:1423 [inline]
>  __do_page_fault+0x5e8/0xe60 arch/x86/mm/fault.c:1489
>  do_page_fault+0xf2/0x7e0 arch/x86/mm/fault.c:1520
>  page_fault+0x1e/0x30 arch/x86/entry/entry_64.S:1139
> RIP: 0033:0x7f05c5e50d61
> Code: 00 c3 f7 05 9d c4 30 00 04 00 00 00 74 07 48 8d 05 84 95 0b 00 c3 0f
> 1f 00 48 31 c0 89 f9 83 e1 3f 66 0f ef c0 83 f9 30 77 19 <f3> 0f 6f 0f 66 0f
> 74 c1 66 0f d7 d0 85 d2 75 7a 48 89 f8 48 83 e0
> RSP: 002b:00007ffc5d3e2558 EFLAGS: 00010287
> RAX: 0000000000000000 RBX: 00007f05c638487c RCX: 0000000000000020
> RDX: 0000000000000005 RSI: 00007ffc5d3e2d48 RDI: 00007f05c6179a20
> RBP: 00007ffc5d3e2f2b R08: 0000000000000008 R09: 0101010101010101
> R10: 0000000000000000 R11: 00007f05c5e07060 R12: 0000000000403738
> R13: 0000000000000001 R14: 0000000000000000 R15: 00007f05c6179a20
>
> Allocated by task 7136:
>  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
>  set_track mm/kasan/kasan.c:460 [inline]
>  kasan_kmalloc+0xc7/0xe0 mm/kasan/kasan.c:553
>  kasan_slab_alloc+0x12/0x20 mm/kasan/kasan.c:490
>  kmem_cache_alloc+0x12e/0x730 mm/slab.c:3554
>  mempool_alloc_slab+0x44/0x60 mm/mempool.c:505
>  mempool_alloc+0x193/0x4a0 mm/mempool.c:385
>  bvec_alloc+0x12a/0x2d0 block/bio.c:218
>  bio_alloc_bioset+0x47a/0x700 block/bio.c:509
>  bio_alloc include/linux/bio.h:393 [inline]
>  io_submit_init_bio fs/ext4/page-io.c:374 [inline]
>  io_submit_add_bh fs/ext4/page-io.c:399 [inline]
>  ext4_bio_write_page+0x1304/0x1bd1 fs/ext4/page-io.c:506
>  mpage_submit_page+0x15e/0x270 fs/ext4/inode.c:2237
>  mpage_process_page_bufs+0x50a/0x600 fs/ext4/inode.c:2348
>  mpage_prepare_extent_to_map+0xea5/0x19c0 fs/ext4/inode.c:2710
>  ext4_writepages+0x140c/0x41a0 fs/ext4/inode.c:2837
>  do_writepages+0x9a/0x1a0 mm/page-writeback.c:2328
>  __writeback_single_inode+0x20a/0x1660 fs/fs-writeback.c:1316
>  writeback_sb_inodes+0x71f/0x1210 fs/fs-writeback.c:1580
>  __writeback_inodes_wb+0x1b9/0x340 fs/fs-writeback.c:1649
>  wb_writeback+0xa73/0xfc0 fs/fs-writeback.c:1758
>  wb_check_start_all fs/fs-writeback.c:1882 [inline]
>  wb_do_writeback fs/fs-writeback.c:1908 [inline]
>  wb_workfn+0xee9/0x1790 fs/fs-writeback.c:1942
>  process_one_work+0xc90/0x1c40 kernel/workqueue.c:2153
>  worker_thread+0x17f/0x1390 kernel/workqueue.c:2296
>  kthread+0x35a/0x440 kernel/kthread.c:246
>  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
>
> Freed by task 5729:
>  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
>  set_track mm/kasan/kasan.c:460 [inline]
>  __kasan_slab_free+0x102/0x150 mm/kasan/kasan.c:521
>  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
>  __cache_free mm/slab.c:3498 [inline]
>  kmem_cache_free+0x83/0x290 mm/slab.c:3760
>  mempool_free_slab+0x1d/0x30 mm/mempool.c:512
>  mempool_free+0xed/0x370 mm/mempool.c:494
>  bvec_free+0xa8/0xd0 block/bio.c:173
>  bio_free+0xc1/0x150 block/bio.c:259
>  bio_put+0x187/0x200 block/bio.c:561
>  ext4_end_bio+0x197/0x6e0 fs/ext4/page-io.c:343
>  bio_endio+0x5d2/0xb80 block/bio.c:1773
>  req_bio_endio block/blk-core.c:278 [inline]
>  blk_update_request+0x585/0xd20 block/blk-core.c:3076
>  scsi_end_request+0xde/0x860 drivers/scsi/scsi_lib.c:673
>  scsi_io_completion+0x2ce/0x1ca0 drivers/scsi/scsi_lib.c:1093
>  scsi_finish_command+0x579/0x970 drivers/scsi/scsi.c:248
>  scsi_softirq_done+0x465/0x520 drivers/scsi/scsi_lib.c:1737
>  blk_done_softirq+0x4c2/0x760 block/blk-softirq.c:37
>  __do_softirq+0x308/0xb7e kernel/softirq.c:292
>
> The buggy address belongs to the object at ffff8801b979ddc0
>  which belongs to the cache biovec-max of size 8192
> The buggy address is located 632 bytes to the left of
>  8192-byte region [ffff8801b979ddc0, ffff8801b979fdc0)
> The buggy address belongs to the page:
> page:ffffea0006e5e700 count:1 mapcount:0 mapping:ffff8801d79b6980 index:0x0
> compound_mapcount: 0
> flags: 0x2fffc0000010200(slab|head)
> raw: 02fffc0000010200 ffffea000730ee08 ffffea000652d508 ffff8801d79b6980
> raw: 0000000000000000 ffff8801b979ddc0 0000000100000001 0000000000000000
> page dumped because: kasan: bad access detected
>
> Memory state around the buggy address:
>  ffff8801b979da00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>  ffff8801b979da80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>>
>> ffff8801b979db00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>
>                                               ^
>  ffff8801b979db80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>  ffff8801b979dc00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
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
>
> --
> You received this message because you are subscribed to the Google Groups
> "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an
> email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit
> https://groups.google.com/d/msgid/syzkaller-bugs/000000000000e5a3e1057a59db17%40google.com.
> For more options, visit https://groups.google.com/d/optout.
