Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C77C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 22:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 786322081C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 22:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="L8/zOYds"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 786322081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbeKJIm1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 03:42:27 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:35517 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727557AbeKJIm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 03:42:26 -0500
Received: by mail-io1-f66.google.com with SMTP id 79-v6so2456678iou.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 14:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=U5XNH8HaqeoJ5/jUdE3lpJrv2wXwKHXt0e0uHsejo24=;
        b=L8/zOYdsHT0kiKfEwBN7e0htm2fULR88l/McUXVU1N+k0NWjK0V10bVCDW5bX+qjEP
         9Ka9EuAdVn5uhUDPI/10YtAd1j7QCeROQxG35jQidBe6WPIoQiEZcT0Dj7Q5CrosmAcg
         l3VgSrq/hj6L+L9ZGe9KcHTD4pNGcRfG+cAaOl3NfWzttBqZ9u9C+1deHOYgE7rYlK+d
         kaOPbvfsMLUE6K7NjWHEdVo6bGO2mMNLsuZP/HEd9n1tzNP9d3SFFfev4ZSbI83e9d/T
         tPCCt7u+dOyIZGfOZ916B+Kfkmwdvf17pl+zqBGX2QQ1qVAeu8fs2hy+zNm9EkT6FBwd
         8VrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=U5XNH8HaqeoJ5/jUdE3lpJrv2wXwKHXt0e0uHsejo24=;
        b=hAXABXyk/Vm2K8jYUsCatKdJWrjJOHfZeYFokZjSJzDdO500LQG1kSxv5DXr4wCMTj
         CRpAfgeKJPqxSGuzMELr1A92a0UFJ3IaFo2AMnQ2Nsl7OHzdY28z+u2IPdWVOaQ50Ixj
         fgRGHcTMD+7HEzLWWX77K+C9hiunJ4LG/CG+dc952EVU/sKLnq1gMhMCoi1fyZ/BIemA
         VDdQpXjgxDHf07dGBOf8SZMZ67l3M9T3he++Hhq+Ns877LM/RRNSJTLu+HaJMV0QGc7Q
         SXQBgMnuWeGABHUC7438/eovsp6/eVA+nl0g2yln5EDSpUDDLyL1PQmGwgVYBc+3flh0
         oSqw==
X-Gm-Message-State: AGRZ1gJmU9i9rJ9qdQYYUj61/pCNK6fGL8yMAjtj+z/0GICXb/xL92Kv
        I2/irLkTuwUGaXx6FWc0EW3U1WU4LeI=
X-Google-Smtp-Source: AJdET5ft54xNcOQ+U6n8gCXF9dXxu7TS7+rK3YRLPpwW7moB+TYgelvGTLyNRbWChT2nJFydsGYFEA==
X-Received: by 2002:a6b:cd08:: with SMTP id d8-v6mr8752955iog.121.1541804383474;
        Fri, 09 Nov 2018 14:59:43 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id f133-v6sm1337660itf.10.2018.11.09.14.59.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 14:59:42 -0800 (PST)
Subject: Re: [LKP] a9f38e1dec [ 245.678853] INFO: task mount:580 blocked for
 more than 120 seconds.
To:     kernel test robot <rong.a.chen@intel.com>,
        Omar Sandoval <osandov@fb.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        LKP <lkp@01.org>
References: <20181107031643.GD24195@shao2-debian>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6914078b-a348-f92d-abbb-b2ccb162fc80@kernel.dk>
Date:   Fri, 9 Nov 2018 15:59:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181107031643.GD24195@shao2-debian>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/6/18 8:16 PM, kernel test robot wrote:
> Greetings,
> 
> 0day kernel testing robot got the below dmesg and the first bad commit is
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> 
> commit a9f38e1dec107af70d81338332494bf0a1e76597
> Author:     Omar Sandoval <osandov@fb.com>
> AuthorDate: Mon Oct 15 09:21:34 2018 -0600
> Commit:     Jens Axboe <axboe@kernel.dk>
> CommitDate: Tue Oct 16 09:50:14 2018 -0600
> 
>     floppy: convert to blk-mq
>     
>     This driver likes to fetch requests from all over the place, so make
>     queue_rq put requests on a list so that the logic stays the same. Tested
>     with QEMU.
>     
>     Signed-off-by: Omar Sandoval <osandov@fb.com>
>     
>     Converted to blk_mq_init_sq_queue() and fixed a few spots where the
>     tag_set leaked on cleanup.
>     
>     Signed-off-by: Jens Axboe <axboe@kernel.dk>

I don't think this is the reason for the hang, I think it just exposed
it. I posted a patch to fix this, hopefully, it's included below as
well. Can you give it a try?


From fd85da23e51d8c055592c2fde5bc36d43eb29074 Mon Sep 17 00:00:00 2001
From: Jens Axboe <axboe@kernel.dk>
Date: Fri, 9 Nov 2018 15:53:04 -0700
Subject: [PATCH] floppy: fix race condition in __floppy_read_block_0()

LKP recently reported a hang at bootup in the floppy code:

[  245.678853] INFO: task mount:580 blocked for more than 120 seconds.
[  245.679906]       Tainted: G                T 4.19.0-rc6-00172-ga9f38e1 #1
[  245.680959] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  245.682181] mount           D 6372   580      1 0x00000004
[  245.683023] Call Trace:
[  245.683425]  __schedule+0x2df/0x570
[  245.683975]  schedule+0x2d/0x80
[  245.684476]  schedule_timeout+0x19d/0x330
[  245.685090]  ? wait_for_common+0xa5/0x170
[  245.685735]  wait_for_common+0xac/0x170
[  245.686339]  ? do_sched_yield+0x90/0x90
[  245.686935]  wait_for_completion+0x12/0x20
[  245.687571]  __floppy_read_block_0+0xfb/0x150
[  245.688244]  ? floppy_resume+0x40/0x40
[  245.688844]  floppy_revalidate+0x20f/0x240
[  245.689486]  check_disk_change+0x43/0x60
[  245.690087]  floppy_open+0x1ea/0x360
[  245.690653]  __blkdev_get+0xb4/0x4d0
[  245.691212]  ? blkdev_get+0x1db/0x370
[  245.691777]  blkdev_get+0x1f3/0x370
[  245.692351]  ? path_put+0x15/0x20
[  245.692871]  ? lookup_bdev+0x4b/0x90
[  245.693539]  blkdev_get_by_path+0x3d/0x80
[  245.694165]  mount_bdev+0x2a/0x190
[  245.694695]  squashfs_mount+0x10/0x20
[  245.695271]  ? squashfs_alloc_inode+0x30/0x30
[  245.695960]  mount_fs+0xf/0x90
[  245.696451]  vfs_kern_mount+0x43/0x130
[  245.697036]  do_mount+0x187/0xc40
[  245.697563]  ? memdup_user+0x28/0x50
[  245.698124]  ksys_mount+0x60/0xc0
[  245.698639]  sys_mount+0x19/0x20
[  245.699167]  do_int80_syscall_32+0x61/0x130
[  245.699813]  entry_INT80_32+0xc7/0xc7

showing that we never complete that read request. The reason is that
the completion setup is racy - it initializes the completion event
AFTER submitting the IO, which means that the IO could complete
before/during the init. If it does, we are passing garbage to
complete() and we may sleep forever waiting for the event to
occur.

Fixes: 7b7b68bba5ef ("floppy: bail out in open() if drive is not responding to block0 read")
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/block/floppy.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index a8cfa011c284..fb23578e9a41 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -4148,10 +4148,11 @@ static int __floppy_read_block_0(struct block_device *bdev, int drive)
 	bio.bi_end_io = floppy_rb0_cb;
 	bio_set_op_attrs(&bio, REQ_OP_READ, 0);
 
+	init_completion(&cbdata.complete);
+
 	submit_bio(&bio);
 	process_fd_request();
 
-	init_completion(&cbdata.complete);
 	wait_for_completion(&cbdata.complete);
 
 	__free_page(page);
-- 
2.17.1


-- 
Jens Axboe

