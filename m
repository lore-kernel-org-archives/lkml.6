Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SORTED_RECIPS,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EABAFC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 23:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FF18240B7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 23:18:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YztRzO3y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FF18240B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752964AbeGDXSV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 19:18:21 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:44323 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752874AbeGDXST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 19:18:19 -0400
Received: by mail-pf0-f196.google.com with SMTP id j3-v6so3656649pfh.11;
        Wed, 04 Jul 2018 16:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XYnUJZvy4QMf84edDmH88NXZIKQjnb2TGdoxx8edyPM=;
        b=YztRzO3yzrK29kuH/yeYFqvNVEQbbHlbzdX6qrBFD/XqEP6YPkFuyUNNkAo2/QPhkF
         hBvSCSRsflVaSRJYngJ5t6CSutnd44nWyXlBgpT4keyEcZ0klkDlKxIhrpgnyOZR4l+T
         H0uL7NY0IKAMMJoi5ApUXgBk+8eXj++rsyuW442lv81Qgay4ZecwfFW88jI8LV9mFSEj
         pd/dWLt2gKeqwL4YLVN6SiyLQox8Uf+2+zOomaG6hM5QoA6VnDARz16yvrG5zFy8IlmW
         jLN3mIRyJwu/H6mqxguDitC7xgTWRqJxf8YXI6SX+daliaQey3lr0A+Y8bSBT8vg8vZ1
         BhKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XYnUJZvy4QMf84edDmH88NXZIKQjnb2TGdoxx8edyPM=;
        b=qJ3+5rZR8XvDZ1+izCekBnEfxUHtH41Z+sQIPkP7x7QXLgCozIOK1OOa8tqENKscD9
         hlJs2/QVj22wS8ji1CL9EDP/gNPoSuwmQJpqCHNjL3/bEM5lj6cBYMToOuw5vnwJ+4wO
         Ra4gps/PMix5sq3PiO9sIKLGJpUw0mEeqlYsRWU3VPudfSEIsgikdCC3sk0xfeg4IIbF
         QHYM5/kTDgs3UM9aahstvjyGNIbgmwW42IA9IJiZBv0P0c6KmEe/EbRWjRMnd59po5Lx
         kMvh7ebq4VBZAX8sOPCUqIfyBpRBuK9EBxgnC5XHVwu0CVTFCKHbrll93pPRhCJTTAym
         QOmQ==
X-Gm-Message-State: APt69E2k6eJ6p1r+jUYTHDeSejKghp9Z6T3Q7OLvdH1X8ozkWiy3B0qe
        Uchgfif2G5s3CN6VCsciZHs=
X-Google-Smtp-Source: AAOMgpeNigRzfFyEIho4CSE6RRMJHPc4uPyCIaShiPHylQ1Q48DiMXPFNWg+QPneYyCJ/WHAHXYeWg==
X-Received: by 2002:a62:642:: with SMTP id 63-v6mr3996002pfg.222.1530746299243;
        Wed, 04 Jul 2018 16:18:19 -0700 (PDT)
Received: from sol.localdomain (c-67-185-97-198.hsd1.wa.comcast.net. [67.185.97.198])
        by smtp.gmail.com with ESMTPSA id j3-v6sm7356336pff.35.2018.07.04.16.18.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Jul 2018 16:18:18 -0700 (PDT)
Date:   Wed, 4 Jul 2018 16:18:16 -0700
From:   Eric Biggers <ebiggers3@gmail.com>
To:     syzbot <syzbot+449737930e1faf08523e@syzkaller.appspotmail.com>
Cc:     dasaratharaman.chandramouli@intel.com, dledford@redhat.com,
        ira.weiny@intel.com, jgg@ziepe.ca, leonro@mellanox.com,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        parav@mellanox.com, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Subject: Re: INFO: task hung in ucma_destroy_id
Message-ID: <20180704231816.GI725@sol.localdomain>
References: <001a113f2be0b4b0ad0567464413@google.com>
 <000000000000b4f5de0568760341@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000b4f5de0568760341@google.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 28, 2018 at 02:56:01AM -0700, syzbot wrote:
> syzbot has found reproducer for the following crash on upstream commit
> 3eb2ce825ea1ad89d20f7a3b5780df850e4be274 (Sun Mar 25 22:44:30 2018 +0000)
> Linux 4.16-rc7
> syzbot dashboard link:
> https://syzkaller.appspot.com/bug?extid=449737930e1faf08523e
> 
> So far this crash happened 38 times on upstream.
> C reproducer: https://syzkaller.appspot.com/x/repro.c?id=6522989826801664
> syzkaller reproducer:
> https://syzkaller.appspot.com/x/repro.syz?id=4513717152645120
> Raw console output:
> https://syzkaller.appspot.com/x/log.txt?id=6625862883475456
> Kernel config:
> https://syzkaller.appspot.com/x/.config?id=-8440362230543204781
> compiler: gcc (GCC) 7.1.1 20170620
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+449737930e1faf08523e@syzkaller.appspotmail.com
> It will help syzbot understand when the bug is fixed.
> 
> INFO: task syzkaller681645:4295 blocked for more than 120 seconds.
>       Not tainted 4.16.0-rc7+ #3
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> syzkaller681645 D20744  4295   4293 0x00000000
> Call Trace:
>  context_switch kernel/sched/core.c:2862 [inline]
>  __schedule+0x8fb/0x1ec0 kernel/sched/core.c:3440
>  schedule+0xf5/0x430 kernel/sched/core.c:3499
>  schedule_timeout+0x1a3/0x230 kernel/time/timer.c:1777
>  do_wait_for_common kernel/sched/completion.c:86 [inline]
>  __wait_for_common kernel/sched/completion.c:107 [inline]
>  wait_for_common kernel/sched/completion.c:118 [inline]
>  wait_for_completion+0x415/0x770 kernel/sched/completion.c:139
>  ucma_destroy_id+0x2f0/0x500 drivers/infiniband/core/ucma.c:611
>  ucma_write+0x2d6/0x3d0 drivers/infiniband/core/ucma.c:1649
>  __vfs_write+0xef/0x970 fs/read_write.c:480
>  vfs_write+0x189/0x510 fs/read_write.c:544
>  SYSC_write fs/read_write.c:589 [inline]
>  SyS_write+0xef/0x220 fs/read_write.c:581
>  do_syscall_64+0x281/0x940 arch/x86/entry/common.c:287
>  entry_SYSCALL_64_after_hwframe+0x42/0xb7
> RIP: 0033:0x440719
> RSP: 002b:00007ffc7e451f28 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 00007ffc7e451f50 RCX: 0000000000440719
> RDX: 0000000000000018 RSI: 0000000020000080 RDI: 0000000000000003
> RBP: 0000000000000000 R08: 00007ffc7e451fa0 R09: 00007ffc7e451fa0
> R10: 00007ffc7e451fa0 R11: 0000000000000246 R12: 0000000000402040
> R13: 00000000004020d0 R14: 0000000000000000 R15: 0000000000000000

This was fixed by commit ef95a90ae6f4f2:

#syz fix: RDMA/ucma: ucma_context reference leak in error path

- Eric
