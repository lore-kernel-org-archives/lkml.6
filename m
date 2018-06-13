Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 2AA68C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 07:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8D06208AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 07:52:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AkYk3rCq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8D06208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754558AbeFMHwy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 03:52:54 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:43034 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754472AbeFMHww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 03:52:52 -0400
Received: by mail-pl0-f66.google.com with SMTP id c41-v6so1041511plj.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 00:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4B/XOfuk2G13nvr1CxEh+O1cUJatBaD4NseJj2BzTSc=;
        b=AkYk3rCqivGenjFyKrLsUx3oKJJre2pcKiwneWKIoyTRpVr/f6AovxqR87FJOiDuau
         vRgF5LyUaLzBSW2+3PuJE16W4/eLr+t69zyxjBnV8ngG9ibXv6XL/9RX1VWPq2e4xOp+
         5eRjkeo6rVRolovzgXUcU59kL6Kdr2LWwRKypnHz36cJ9TVNt5oJOZJv1gKJvyQRNBHA
         GH6bx4T/Jmoq1TpduIP/I+skXWbeh1d8wmYl9zM07jpsiPHukdcB2MpzSwSgqT40GI/U
         lzco/MXtrd8ZIDDBfhpgeFCTbw+K/tSJPCgz76sCWzznVsaw4/H9sLTHPd4OdU4jTGBj
         MT/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4B/XOfuk2G13nvr1CxEh+O1cUJatBaD4NseJj2BzTSc=;
        b=GZm5Rp2a1jz7SAgDlMuB31gJ9XwUZTzZ7ANJ8O+2baitBfnNCHonhaJ+hsUWPaZ4eG
         TIFvVUYHDLYwYHf6sq2eRsafWqlLolrsMK9+SdEatB7H1aL10H1D/DFfNHR6upVOEuHg
         SEsOV0pQiSX3NDgerifCOjVNbiEbn+Pqx3VgvUaYMIai6sbMVMYmU6qTAgkOjZF7B8WO
         iC3a9vIsKfnK2CSUj2f+upU4wTCVAS7S8APnwdGcjL22Z15en1Z/uxJaAnLUP2q0nr4r
         JrCqv44jMqt0YAux0uO+6BbmE10Fp3i1J2fS5WWQwimDxuYFM7G/pu/cGIrhICaQFuO4
         f0rQ==
X-Gm-Message-State: APt69E2JborplfZ9IF7TgIiIZvQ1MT0M7IP+mgdptNtel25H9t+Pg8Qs
        0KwHEYAVmkrpUzfkEo7kwa+bpXmXZekkUXl7YJC4OQ==
X-Google-Smtp-Source: ADUXVKLLrNl2nc8xMFQDKdKlS21IihJ46XrME3IkH2GbE8Y3zQbTpQUcypYIgd8SAJE0kBHY5ZcXurWe3C/kG7L1MPA=
X-Received: by 2002:a17:902:ab95:: with SMTP id f21-v6mr3915609plr.264.1528876371525;
 Wed, 13 Jun 2018 00:52:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:de2:0:0:0:0 with HTTP; Wed, 13 Jun 2018 00:52:31
 -0700 (PDT)
In-Reply-To: <00000000000081bd9d056e813e48@google.com>
References: <00000000000081bd9d056e813e48@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 13 Jun 2018 09:52:31 +0200
Message-ID: <CACT4Y+bM4jA4Ptrdb1x8xVONJOCurcwYKL+kgxFCdk7R4g9Nvw@mail.gmail.com>
Subject: Re: KASAN: out-of-bounds Read in rds_cong_queue_updates (2)
To:     syzbot <syzbot+287843ad8a4d2870e538@syzkaller.appspotmail.com>,
        Sowmini Varadhan <sowmini.varadhan@oracle.com>
Cc:     David Miller <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>, linux-rdma@vger.kernel.org,
        netdev <netdev@vger.kernel.org>, rds-devel@oss.oracle.com,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 9:51 AM, syzbot
<syzbot+287843ad8a4d2870e538@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    0adb32858b0b Linux 4.16
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=138f2d0b800000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=df0c336cc3b55d45
> dashboard link: https://syzkaller.appspot.com/bug?extid=287843ad8a4d2870e538
> compiler:       gcc (GCC) 7.1.1 20170620
>
> Unfortunately, I don't have any reproducer for this crash yet.
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+287843ad8a4d2870e538@syzkaller.appspotmail.com

I think this is:

#syz dup: KASAN: use-after-free Read in rds_cong_queue_updates

> ==================================================================
> BUG: KASAN: out-of-bounds in __read_once_size include/linux/compiler.h:188
> [inline]
> BUG: KASAN: out-of-bounds in atomic_read arch/x86/include/asm/atomic.h:27
> [inline]
> BUG: KASAN: out-of-bounds in refcount_read include/linux/refcount.h:42
> [inline]
> BUG: KASAN: out-of-bounds in check_net include/net/net_namespace.h:228
> [inline]
> BUG: KASAN: out-of-bounds in rds_destroy_pending net/rds/rds.h:868 [inline]
> BUG: KASAN: out-of-bounds in rds_cong_queue_updates+0x4d3/0x4f0
> net/rds/cong.c:226
> Read of size 4 at addr ffff88018d7f2204 by task kworker/u4:6/10561
>
> CPU: 1 PID: 10561 Comm: kworker/u4:6 Not tainted 4.16.0+ #10
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Workqueue: krdsd rds_send_worker
> Call Trace:
>  __dump_stack lib/dump_stack.c:17 [inline]
>  dump_stack+0x194/0x24d lib/dump_stack.c:53
> kernel msg: ebtables bug: please report to author: Wrong len argument
>  print_address_description+0x73/0x250 mm/kasan/report.c:256
>  kasan_report_error mm/kasan/report.c:354 [inline]
>  kasan_report+0x23c/0x360 mm/kasan/report.c:412
>  __asan_report_load4_noabort+0x14/0x20 mm/kasan/report.c:432
>  __read_once_size include/linux/compiler.h:188 [inline]
>  atomic_read arch/x86/include/asm/atomic.h:27 [inline]
>  refcount_read include/linux/refcount.h:42 [inline]
>  check_net include/net/net_namespace.h:228 [inline]
>  rds_destroy_pending net/rds/rds.h:868 [inline]
>  rds_cong_queue_updates+0x4d3/0x4f0 net/rds/cong.c:226
>  rds_recv_rcvbuf_delta.part.2+0x289/0x320 net/rds/recv.c:118
>  rds_recv_rcvbuf_delta net/rds/recv.c:377 [inline]
>  rds_recv_incoming+0xeb4/0x11d0 net/rds/recv.c:377
>  rds_loop_xmit+0x149/0x320 net/rds/loop.c:82
>  rds_send_xmit+0xbcd/0x26b0 net/rds/send.c:355
>  rds_send_worker+0x115/0x2a0 net/rds/threads.c:199
>  process_one_work+0xc47/0x1bb0 kernel/workqueue.c:2113
>  worker_thread+0x223/0x1990 kernel/workqueue.c:2247
>  kthread+0x33c/0x400 kernel/kthread.c:238
>  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:406
>
> The buggy address belongs to the page:
> page:ffffea000635fc80 count:3 mapcount:2 mapping:0000000000000000 index:0x0
> flags: 0x2fffc0000000000()
> raw: 02fffc0000000000 0000000000000000 0000000000000000 0000000300000001
> raw: dead000000000100 dead000000000200 0000000000000000 0000000000000000
> page dumped because: kasan: bad access detected
>
> Memory state around the buggy address:
>  ffff88018d7f2100: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  ffff88018d7f2180: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>                       ^
>  ffff88018d7f2280: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  ffff88018d7f2300: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ==================================================================
> Kernel panic - not syncing: panic_on_warn set ...
>
> CPU: 1 PID: 10561 Comm: kworker/u4:6 Tainted: G    B            4.16.0+ #10
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Workqueue: krdsd rds_send_worker
> Call Trace:
>  __dump_stack lib/dump_stack.c:17 [inline]
>  dump_stack+0x194/0x24d lib/dump_stack.c:53
>  panic+0x1e4/0x41c kernel/panic.c:183
>  kasan_end_report+0x50/0x50 mm/kasan/report.c:180
>  kasan_report_error mm/kasan/report.c:359 [inline]
>  kasan_report+0x149/0x360 mm/kasan/report.c:412
>  __asan_report_load4_noabort+0x14/0x20 mm/kasan/report.c:432
>  __read_once_size include/linux/compiler.h:188 [inline]
>  atomic_read arch/x86/include/asm/atomic.h:27 [inline]
>  refcount_read include/linux/refcount.h:42 [inline]
>  check_net include/net/net_namespace.h:228 [inline]
>  rds_destroy_pending net/rds/rds.h:868 [inline]
>  rds_cong_queue_updates+0x4d3/0x4f0 net/rds/cong.c:226
>  rds_recv_rcvbuf_delta.part.2+0x289/0x320 net/rds/recv.c:118
>  rds_recv_rcvbuf_delta net/rds/recv.c:377 [inline]
>  rds_recv_incoming+0xeb4/0x11d0 net/rds/recv.c:377
>  rds_loop_xmit+0x149/0x320 net/rds/loop.c:82
>  rds_send_xmit+0xbcd/0x26b0 net/rds/send.c:355
>  rds_send_worker+0x115/0x2a0 net/rds/threads.c:199
>  process_one_work+0xc47/0x1bb0 kernel/workqueue.c:2113
>  worker_thread+0x223/0x1990 kernel/workqueue.c:2247
>  kthread+0x33c/0x400 kernel/kthread.c:238
>  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:406
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> Kernel Offset: disabled
> Rebooting in 86400 seconds..
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
> https://groups.google.com/d/msgid/syzkaller-bugs/00000000000081bd9d056e813e48%40google.com.
> For more options, visit https://groups.google.com/d/optout.
