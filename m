Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19314C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 08:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D11592184C
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 08:08:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="sL0IR2Qp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AGoB06BX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbeLSIIt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 03:08:49 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:36749 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726706AbeLSIIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 03:08:49 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id E5CDE21D0A;
        Wed, 19 Dec 2018 03:08:47 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 19 Dec 2018 03:08:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=jQGLAOk/VAwKCaskiaTs7TDZ4H+
        QE3GqOwI6O3FcakI=; b=sL0IR2QpF4CsjkOySxfrrhyQFBHTfk0NH94ZZ/KW/i4
        dOcpE1yrD2DB5vIyAcS8IV0ALVov6ZvBxUHI0vrElnUmmJLA3LI/w7m/E/CZQq91
        4JrWWgAEaDJMhAPOZ7ExrnnyhY7juzqnAKN8nk8zWJiREi/4YJwjPSUrvSqfPl1B
        e0jbzeq7osC2VvYGVVaYy6iEOupnM0azB6NAm37YmD06vDIc1NfS9MeJ+1Oh9O0w
        sfrEMAiJooRce6wQ8nYysoKZ3nk1fUkxxGXPn2Brh2U3S0ufywSyZwAp6COWArBB
        MWRfpqnTgPLxgMsZ4g3DmgLOoFHEWig/XMgU18VJSOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=jQGLAO
        k/VAwKCaskiaTs7TDZ4H+QE3GqOwI6O3FcakI=; b=AGoB06BXp4Mzq/5N7HGNsJ
        qC7n7BMZo8qNYeJFplfnKZE/xBBmW9VrpCUEn9SVXVPOiaq4qBR81Zs2yjSR4uR3
        Z5BhS4Blea6hcm3oMJGMiD7X024Q1I2afpgYxvebPOndG6Dwmdy27bcWWQroe/CJ
        jikQDjxwYaGruWdrFLHtI9fi0fXcXdzMrPs3/t+Y/XQ1hRvSnAUZigKH56Ck4/d8
        ZyX4wXfopVB4SpKLAkweNuSc1EoYU7j5qDk2d6+jGhNheN7Gx2tlaWknCNDiZN0A
        n7AwL9pN5PwVDgoFdkltj/WZRJH5zc3k9D5oCUTA2JcwJLcIfs+b7eBtXHjo7lww
        ==
X-ME-Sender: <xms:j_wZXM3X0UPOD9gvI4tcPrSXr_Ekaq9WOL5vpKI2LR7hwKAFC2Yibw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtkedrudeiledgkeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfquhhtnecuuegrihhlohhuthemucef
    tddtnecuogfuuhhsphgvtghtffhomhgrihhnucdlgeelmdenucfjughrpeffhffvuffkfh
    ggtggujggfsehttdertddtredvnecuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehk
    rhhorghhrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdgrphhpshhpoh
    htrdgtohhmnecukfhppeekfedrkeeirdekledruddtjeenucfrrghrrghmpehmrghilhhf
    rhhomhepghhrvghgsehkrhhorghhrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:j_wZXDURgo5FEVm7mh-uCjnB6La7lmjh4YnhmuZVQAXe_Sex_Zw1cA>
    <xmx:j_wZXOh5m3fql-91u6uLZ8XA0Yl8oBE0BA8-qOZRfi6TA7ZhWsga6A>
    <xmx:j_wZXGKJuKFAIYzeSu_RHhlwW0poLAbkmodkHNt28kSXqUraOPoSWQ>
    <xmx:j_wZXMumx89ZP51oNPJ2OYmAJvtDi6a2dKR1buC2KQRTmA8LGu5lMw>
Received: from localhost (5356596b.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id F1E3BE4445;
        Wed, 19 Dec 2018 03:08:46 -0500 (EST)
Date:   Wed, 19 Dec 2018 09:08:45 +0100
From:   Greg KH <greg@kroah.com>
To:     linux-kernel@vger.kernel.org
Cc:     penguin-kernel@i-love.sakura.ne.jp, stable-commits@vger.kernel.org
Subject: Re: Patch "block/loop: fix deadlock after loop_set_status" has been
 added to the 3.18-stable tree
Message-ID: <20181219080845.GA3087@kroah.com>
References: <20181219004552.562162080D@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181219004552.562162080D@mail.kernel.org>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 07:45:51PM -0500, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     block/loop: fix deadlock after loop_set_status
> 
> to the 3.18-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      block-loop-fix-deadlock-after-loop_set_status.patch
> and it can be found in the queue-3.18 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 
> 
> commit 352efb22c71d30d72d60f364cb8ea8a16408b985
> Author: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Date:   Fri Apr 6 10:03:17 2018 +0900
> 
>     block/loop: fix deadlock after loop_set_status
>     
>     [ Upstream commit 1e047eaab3bb5564f25b41e9cd3a053009f4e789 ]
>     
>     syzbot is reporting deadlocks at __blkdev_get() [1].
>     
>     ----------------------------------------
>     [   92.493919] systemd-udevd   D12696   525      1 0x00000000
>     [   92.495891] Call Trace:
>     [   92.501560]  schedule+0x23/0x80
>     [   92.502923]  schedule_preempt_disabled+0x5/0x10
>     [   92.504645]  __mutex_lock+0x416/0x9e0
>     [   92.510760]  __blkdev_get+0x73/0x4f0
>     [   92.512220]  blkdev_get+0x12e/0x390
>     [   92.518151]  do_dentry_open+0x1c3/0x2f0
>     [   92.519815]  path_openat+0x5d9/0xdc0
>     [   92.521437]  do_filp_open+0x7d/0xf0
>     [   92.527365]  do_sys_open+0x1b8/0x250
>     [   92.528831]  do_syscall_64+0x6e/0x270
>     [   92.530341]  entry_SYSCALL_64_after_hwframe+0x42/0xb7
>     
>     [   92.931922] 1 lock held by systemd-udevd/525:
>     [   92.933642]  #0: 00000000a2849e25 (&bdev->bd_mutex){+.+.}, at: __blkdev_get+0x73/0x4f0
>     ----------------------------------------
>     
>     The reason of deadlock turned out that wait_event_interruptible() in
>     blk_queue_enter() got stuck with bdev->bd_mutex held at __blkdev_put()
>     due to q->mq_freeze_depth == 1.
>     
>     ----------------------------------------
>     [   92.787172] a.out           S12584   634    633 0x80000002
>     [   92.789120] Call Trace:
>     [   92.796693]  schedule+0x23/0x80
>     [   92.797994]  blk_queue_enter+0x3cb/0x540
>     [   92.803272]  generic_make_request+0xf0/0x3d0
>     [   92.807970]  submit_bio+0x67/0x130
>     [   92.810928]  submit_bh_wbc+0x15e/0x190
>     [   92.812461]  __block_write_full_page+0x218/0x460
>     [   92.815792]  __writepage+0x11/0x50
>     [   92.817209]  write_cache_pages+0x1ae/0x3d0
>     [   92.825585]  generic_writepages+0x5a/0x90
>     [   92.831865]  do_writepages+0x43/0xd0
>     [   92.836972]  __filemap_fdatawrite_range+0xc1/0x100
>     [   92.838788]  filemap_write_and_wait+0x24/0x70
>     [   92.840491]  __blkdev_put+0x69/0x1e0
>     [   92.841949]  blkdev_close+0x16/0x20
>     [   92.843418]  __fput+0xda/0x1f0
>     [   92.844740]  task_work_run+0x87/0xb0
>     [   92.846215]  do_exit+0x2f5/0xba0
>     [   92.850528]  do_group_exit+0x34/0xb0
>     [   92.852018]  SyS_exit_group+0xb/0x10
>     [   92.853449]  do_syscall_64+0x6e/0x270
>     [   92.854944]  entry_SYSCALL_64_after_hwframe+0x42/0xb7
>     
>     [   92.943530] 1 lock held by a.out/634:
>     [   92.945105]  #0: 00000000a2849e25 (&bdev->bd_mutex){+.+.}, at: __blkdev_put+0x3c/0x1e0
>     ----------------------------------------
>     
>     The reason of q->mq_freeze_depth == 1 turned out that loop_set_status()
>     forgot to call blk_mq_unfreeze_queue() at error paths for
>     info->lo_encrypt_type != NULL case.
>     
>     ----------------------------------------
>     [   37.509497] CPU: 2 PID: 634 Comm: a.out Tainted: G        W        4.16.0+ #457
>     [   37.513608] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 05/19/2017
>     [   37.518832] RIP: 0010:blk_freeze_queue_start+0x17/0x40
>     [   37.521778] RSP: 0018:ffffb0c2013e7c60 EFLAGS: 00010246
>     [   37.524078] RAX: 0000000000000000 RBX: ffff8b07b1519798 RCX: 0000000000000000
>     [   37.527015] RDX: 0000000000000002 RSI: ffffb0c2013e7cc0 RDI: ffff8b07b1519798
>     [   37.529934] RBP: ffffb0c2013e7cc0 R08: 0000000000000008 R09: 47a189966239b898
>     [   37.532684] R10: dad78b99b278552f R11: 9332dca72259d5ef R12: ffff8b07acd73678
>     [   37.535452] R13: 0000000000004c04 R14: 0000000000000000 R15: ffff8b07b841e940
>     [   37.538186] FS:  00007fede33b9740(0000) GS:ffff8b07b8e80000(0000) knlGS:0000000000000000
>     [   37.541168] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>     [   37.543590] CR2: 00000000206fdf18 CR3: 0000000130b30006 CR4: 00000000000606e0
>     [   37.546410] Call Trace:
>     [   37.547902]  blk_freeze_queue+0x9/0x30
>     [   37.549968]  loop_set_status+0x67/0x3c0 [loop]
>     [   37.549975]  loop_set_status64+0x3b/0x70 [loop]
>     [   37.549986]  lo_ioctl+0x223/0x810 [loop]
>     [   37.549995]  blkdev_ioctl+0x572/0x980
>     [   37.550003]  block_ioctl+0x34/0x40
>     [   37.550006]  do_vfs_ioctl+0xa7/0x6d0
>     [   37.550017]  ksys_ioctl+0x6b/0x80
>     [   37.573076]  SyS_ioctl+0x5/0x10
>     [   37.574831]  do_syscall_64+0x6e/0x270
>     [   37.576769]  entry_SYSCALL_64_after_hwframe+0x42/0xb7
>     ----------------------------------------
>     
>     [1] https://syzkaller.appspot.com/bug?id=cd662bc3f6022c0979d01a262c318fab2ee9b56f
>     
>     Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>     Reported-by: syzbot <bot+48594378e9851eab70bcd6f99327c7db58c5a28a@syzkaller.appspotmail.com>
>     Fixes: ecdd09597a572513 ("block/loop: fix race between I/O and set_status")
>     Cc: Ming Lei <tom.leiming@gmail.com>
>     Cc: Dmitry Vyukov <dvyukov@google.com>
>     Cc: stable <stable@vger.kernel.org>
>     Cc: Jens Axboe <axboe@fb.com>
>     Signed-off-by: Jens Axboe <axboe@kernel.dk>
>     
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 15157a3eabb4..5ad99bc5ac84 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -1095,11 +1095,15 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
>  	if (info->lo_encrypt_type) {
>  		unsigned int type = info->lo_encrypt_type;
>  
> -		if (type >= MAX_LO_CRYPT)
> -			return -EINVAL;
> +		if (type >= MAX_LO_CRYPT) {
> +			err = -EINVAL;
> +			goto exit;
> +		}
>  		xfer = xfer_funcs[type];
> -		if (xfer == NULL)
> -			return -EINVAL;
> +		if (xfer == NULL) {
> +			err = -EINVAL;
> +			goto exit;
> +		}
>  	} else
>  		xfer = NULL;
>  

This breaks the build on the 3.18.y kernel, so I have dropped it from
the tree.

greg k-h
