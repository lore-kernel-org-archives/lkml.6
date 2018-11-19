Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B30C43610
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 20:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DAAC2075B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 20:12:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="nO5L3dEg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DAAC2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730621AbeKTGhM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 01:37:12 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36023 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729957AbeKTGhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 01:37:12 -0500
Received: by mail-pg1-f194.google.com with SMTP id n2so7135238pgm.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 12:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uvRC36rXsNXiZnvvRR40e4FzmmdFK6vqRNz0Zao0K2M=;
        b=nO5L3dEgm53OeydXNSnYxOhNHwB2KJu3TRJvXtRmJYt7kt3qK31s+d0CyL1V2AepsW
         HLS6K57IqygFI2omIJZxzr/QJ59Dt6pNAMYH5HG3lA9Zw0GCv36/y5YHmhFD0BUkgPiG
         T5rExH+g8/UFLKbhUy6yak75l+1NZTkaVhiFjGVK1Wheio4lbHDxkxBr3TgXEFidI5QV
         ++XkWPzyammbQKtvd1xqRvbQeEUy4utW13WViotpKw0eAu9yi6Og6gUCUjwYHPl66X6S
         6ZNi50xl9v3/F6C8Emo8SHuYzzueZTBTo/DaTiw2nMELJUkFiiB6SOtzTf39+snTHCbl
         grtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uvRC36rXsNXiZnvvRR40e4FzmmdFK6vqRNz0Zao0K2M=;
        b=EkA8g0tSbPDI6w6b51MMNmYalazoR7DV6dFV//2dNDyqjkzJqFZLYTb+nKk4/A9Uj1
         u8XqVTMKd2bOJ/9p8ha+XpZH5cNy610ev+4jZNKWYiSj5W119jVvPVjNFDpLKiMiYPQl
         ufCudKX6Ojzd+7e0Kbad+dqDE5u/Ag7Ph0tOVnOoFZF7Exi0T7RpKMus5e06xANpiMBv
         WqHp/XvqX/R45ysWRGY7wk2xWUV2QleW0bQq+AbnmYhNt4e/QmxzrtxKikm9Su8Tu6GR
         VfSvy72YAN3flyKaG+KXWDYxOiEgW4Qi4ZPh1MJFePBEgBQDy2wRcWMCVsc5tjPchp/v
         Zi2A==
X-Gm-Message-State: AGRZ1gLwsQsjbeuglCoxid26UlD8OjPqXJ+b5kCC+uMBDN2XWWuTQntv
        yHg+D1G9Sn98PNj+tG6rqFmUPQ==
X-Google-Smtp-Source: AJdET5dLVXYI0787gY/cnzC5nocCn2FhHx6xqd+eC9wB8gK7UB4tT0WPSZ1GLgM1QoseJ59Kkklu7Q==
X-Received: by 2002:a63:1204:: with SMTP id h4mr21425509pgl.51.1542658317828;
        Mon, 19 Nov 2018 12:11:57 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id x27sm56696559pfe.178.2018.11.19.12.11.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Nov 2018 12:11:56 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gOptk-0005xv-3X; Mon, 19 Nov 2018 13:11:56 -0700
Date:   Mon, 19 Nov 2018 13:11:56 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Kenneth Lee <liguozhu@hisilicon.com>,
        Tim Sell <timothy.sell@unisys.com>, linux-doc@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Zaibo Xu <xuzaibo@huawei.com>, zhangfei.gao@foxmail.com,
        linuxarm@huawei.com, haojian.zhuang@linaro.org,
        Christoph Lameter <cl@linux.com>,
        Hao Fang <fanghao11@huawei.com>,
        Gavin Schenk <g.schenk@eckelmann.de>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Doug Ledford <dledford@redhat.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        David Kershner <david.kershner@unisys.com>,
        Kenneth Lee <nek.in.cn@gmail.com>,
        Johan Hovold <johan@kernel.org>,
        Cyrille Pitchen <cyrille.pitchen@free-electrons.com>,
        Sagar Dharia <sdharia@codeaurora.org>,
        Jens Axboe <axboe@kernel.dk>, guodong.xu@linaro.org,
        linux-netdev <netdev@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        linux-crypto@vger.kernel.org,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-accelerators@lists.ozlabs.org
Subject: Re: [RFCv3 PATCH 1/6] uacce: Add documents for WarpDrive/uacce
Message-ID: <20181119201156.GG4890@ziepe.ca>
References: <20181119091405.GE157308@Turing-Arch-b>
 <20181119091910.GF157308@Turing-Arch-b>
 <20181119104801.GF8268@mtr-leonro.mtl.com>
 <20181119164853.GA4593@redhat.com>
 <20181119182752.GA4890@ziepe.ca>
 <20181119184215.GB4593@redhat.com>
 <20181119185333.GC4890@ziepe.ca>
 <20181119191721.GC4593@redhat.com>
 <20181119192702.GD4890@ziepe.ca>
 <20181119194631.GE4593@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181119194631.GE4593@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 02:46:32PM -0500, Jerome Glisse wrote:

> > ?? How can O_DIRECT be fine but RDMA not? They use exactly the same
> > get_user_pages flow, right? Can we do what O_DIRECT does in RDMA and
> > be fine too?
> > 
> > AFAIK the only difference is the length of the race window. You'd have
> > to fork and fault during the shorter time O_DIRECT has get_user_pages
> > open.
> 
> Well in O_DIRECT case there is only one page table, the CPU
> page table and it gets updated during fork() so there is an
> ordering there and the race window is small.

Not really, in O_DIRECT case there is another 'page table', we just
call it a DMA scatter/gather list and it is sent directly to the block
device's DMA HW. The sgl plays exactly the same role as the various HW
page list data structures that underly RDMA MRs.

It is not a page table that matters here, it is if the DMA address of
the page is active for DMA on HW.

Like you say, the only difference is that the race is hopefully small
with O_DIRECT (though that is not really small, NVMeof for instance
has windows as large as connection timeouts, if you try hard enough)

So we probably can trigger this trouble with O_DIRECT and fork(), and
I would call it a bug :(

> > Why? Keep track in each mm if there are any active get_user_pages
> > FOLL_WRITE pages in the mm, if yes then sweep the VMAs and fix the
> > issue for the FOLL_WRITE pages.
> 
> This has a cost and you don't want to do it for O_DIRECT. I am pretty
> sure that any such patch to modify fork() code path would be rejected.
> At least i would not like it and vote against.

I was thinking the incremental cost on top of what John is already
doing would be very small in the common case and only be triggered in
cases that matter (which apps should avoid anyhow).

Jason
