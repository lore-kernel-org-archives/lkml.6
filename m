Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A91ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D00822146F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="WrAmzMyv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D00822146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731710AbeIREhu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:37:50 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:37782 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731335AbeIREhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:37:48 -0400
Received: by mail-io1-f68.google.com with SMTP id v14-v6so23742iob.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 16:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WrSLulCqd0TmvOKlX0RMiaIFEBZeCU/aKpTFOXMd/uI=;
        b=WrAmzMyvyYZJfGkKZyMl1roqmTnDprD5h5s27DiZUbVMno4BZB8D67YKWqnf0SYotD
         cNHV/Q1tF9dOT/B3YWM34wDDeew/bY6qOvEwm6FssV1Do2XpXMoJh5z1RsTS16ylcJlD
         HVuvfWgCLteNKe1AYVIeRyv+WlWwRUHvLoSk0+407zkvlgXcU+0OsY2kiC8o92xTzbYC
         mKgSYZqp5CqXq0UkOoZgwHywlL9Zb3KuGFkpEXMca++4cXrgbBk42XbEZWy68niLBsgM
         Jf0cs9FzjnThvpaiEROdxUplVFU2Ar7mdVCTemBZuujjwBeWqqg2Uvs0kcarsU4hOYKk
         FGBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WrSLulCqd0TmvOKlX0RMiaIFEBZeCU/aKpTFOXMd/uI=;
        b=EednaS05H7IemaGfeMXwf4m0CYPwV9Mu4ORpjqoDSVBrr6g4WMoEkKeH764yT3SRWX
         aR8Qq/VWeAm3sFv7ah45gdo1yhaZqw6VyLB7n/tBfb1RupX9Iq5K6KEfENN8vmUEw328
         o8k2p0VYq5RvenDz0kHJfKhYP/ktSTVgx9unXXNoms8PaVkF1ywqAqDroLYQOhRAQUV2
         EW24HwPtcqQugidZWwYhJuFf3ngfQHs0R//np3QgNCcbQ1en3XpQb09rAIodg49zuFm3
         FzNaIuk/0J0Mfe5oH/ICacaegpqxqHaUUGVH6Y3o6w2W4TSQvvESTmcLbl2TRLPfXpOd
         7NSA==
X-Gm-Message-State: APzg51C29AV3IVGRlCKvG1rk2bluEPhQq4inYE7DLJiKy5BjEwfq3lHB
        1djg/pe2KUgGv3Flq3PVLerTMQ==
X-Google-Smtp-Source: ANB0VdakWrGQqhb9LZUVKvBb9nw8unTgRFpHqvQg+9OVnywmr8MhmoX8o79tsDJuilgZ32r7eHafLw==
X-Received: by 2002:a6b:be83:: with SMTP id o125-v6mr22618914iof.173.1537225698571;
        Mon, 17 Sep 2018 16:08:18 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id k194-v6sm4176090itb.30.2018.09.17.16.08.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Sep 2018 16:08:18 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1g22cr-0004Of-4b; Mon, 17 Sep 2018 17:08:17 -0600
Date:   Mon, 17 Sep 2018 17:08:17 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Howell, Seth" <seth.howell@intel.com>
Cc:     "Walker, Benjamin" <benjamin.walker@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Moni Shoua <monis@mellanox.com>
Subject: Re: [PATCH] rdma: move the ib_wr_opcode enum to include/uapi
Message-ID: <20180917230817.GA10882@ziepe.ca>
References: <20180814223303.83556-1-seth.howell@intel.com>
 <20180815225021.GB31799@ziepe.ca>
 <EA913ED399BBA34AA4EAC2EDC24CDD008611724E@FMSMSX105.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <EA913ED399BBA34AA4EAC2EDC24CDD008611724E@FMSMSX105.amr.corp.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >From e3c1b1b81373601fa6cbad2ba5fadd2c8cfdfaed Mon Sep 17 00:00:00 2001
> From: Seth Howell <seth.howell@intel.com>
> Date: Tue, 14 Aug 2018 15:33:02 -0700
> Subject: [PATCH] IB/rxe: Revise the ib_wr_opcode enum
> 
> This enum has become part of the uABI, as both RXE and the
> ib_uverbs_post_send() command expect userspace to supply values from
> this enum. So it should be properly placed in include/uapi/rdma.
> 
> In userspace this enum is called 'enum ibv_wr_opcode' as part of
> libibverbs.h. That enum defines different values for
> IB_WR_LOCAL_INV, IB_WR_SEND_WITH_INV, and IB_WR_LSO. These were
> introduced (incorrectly, it turns out) into libiberbs in 2015.
> 
> The kernel has changed its mind on the numbering for several of the
> IB_WC values over the years, but has remained stable on
> IB_WR_LOCAL_INV and below.
> 
> Based on this we can conclude that there is no real user space user
> of the values beyond IB_WR_ATOMIC_FETCH_AND_ADD, as they have never
> worked via rdma-core. This is confirmed by inspection, only rxe uses
> the kernel enum and implements the latter operations. rxe has
> clearly never worked with these attributes from userspace. Other
> drivers that support these opcodes implement the functionality
> without calling out to the kernel.
> 
> To make IB_WR_SEND_WITH_INV and related work for RXE in userspace we
> choose to renumber the IB_WR enum in the kernel to match the uABI
> that userspace has bee using since before Soft RoCE was merged. This
> is an overall simpler configuration for the whole software stack,
> and obviously can't break anything existing.
> 
> Reported-by: Seth Howell <seth.howell@intel.com>
> Fixes: 8700e3e7c485 ("Soft RoCE driver")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
>  include/rdma/ib_verbs.h           | 34 ++++++++++++++++++-------------
>  include/uapi/rdma/ib_user_verbs.h | 20 +++++++++++++++++-
>  2 files changed, 39 insertions(+), 15 deletions(-)

Applied to for-next

Thanks,
Jason
