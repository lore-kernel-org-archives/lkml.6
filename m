Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DCAFC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 22:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B6E22184E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 22:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="H/V0e1/s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbfBKW05 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 17:26:57 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44964 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727405AbfBKW04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 17:26:56 -0500
Received: by mail-pl1-f195.google.com with SMTP id p4so223589plq.11
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 14:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+3Vr1+QlQvEHr8M/dHYTsMTtYJsOn13EtxtdSHco0lA=;
        b=H/V0e1/sxhsB7WFX/N0kZUiV+AmZRdJGGVYYTLTxFdhY5nb1UJe+JMnI+7Wtm5qrVo
         9DKGdZYrmhxNIzyxCF6KS5CkMVSRIpCYUJRzbot216o0aLp11WfztesC46z2vIVQKZUc
         ZI9/GNYTxn8zjWtDcd83yG8sCBp8QiYlSEjrgAXp17fsDau2xXn9DrivFvbhxpscbLuC
         7HVtwNSOpqLOBrEI/PlSCF012t0kMC3O3npmpCtHZ4RfHPEs2KGr9RsCy5xDxzURE5f4
         mg3unr8OMtjXkEcp7pTHKVDKmny/uxKl/gcCRrqEWwL6yLsQkj/XfeCVr5wIoXrnoYCd
         OEjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+3Vr1+QlQvEHr8M/dHYTsMTtYJsOn13EtxtdSHco0lA=;
        b=Vf7VzY1QF4/7FA4Yk7GjPylG+aU2Dc0Cvno8PrqKrbZ7KXop9vlzv3n2t2QM38YodM
         bQ7rgOTn4SIM0yCZtQjrFS9NoY+7+s3tw9ifaGHVmw+Pj3KxY3OjDeEIMAgTwtj8UIGN
         Jzg+sTzUEc48wXpqhD83wM8HbnuP+B0xEzb2d/nqq23wsSEHt4dctDO5HkIyFk66ev3M
         2ZD110Fmlovo2dke9e0DFicw4UhW1s5gBPXJWAzVY6eDwEOSAWZoBOC2CyIa3pP0Kz8O
         smoSzps0qPIlVkArGkBJIHgE8n0+HQPgZ4tRoKIOHUW+wrfExotgtX6uoiQmjF15IAYj
         L5Aw==
X-Gm-Message-State: AHQUAuZ4gTn6q53IAWkb4vK/k+oxPKydlUJNGKV4mMa8ntWdw5wAkN1c
        tfE47mkr8HODuEwSv9RRNSUfJA==
X-Google-Smtp-Source: AHgI3IYq1z9EDDskfPJiG3lu2lcPl33yTxNv97aU7OWUwiC1jPilPFYNRxNJjOyeAsLu9VB8ezqHMg==
X-Received: by 2002:a17:902:2aa8:: with SMTP id j37mr556452plb.226.1549924015920;
        Mon, 11 Feb 2019 14:26:55 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id u6sm12486420pgr.79.2019.02.11.14.26.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Feb 2019 14:26:54 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gtK2Q-00046Q-65; Mon, 11 Feb 2019 15:26:54 -0700
Date:   Mon, 11 Feb 2019 15:26:54 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Daniel Stone <daniel@fooishbar.org>, "hch@lst.de" <hch@lst.de>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yong.zhi@intel.com" <yong.zhi@intel.com>,
        "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "bingbu.cao@intel.com" <bingbu.cao@intel.com>,
        "tian.shu.qiu@intel.com" <tian.shu.qiu@intel.com>,
        "shiraz.saleem@intel.com" <shiraz.saleem@intel.com>,
        "sakari.ailus@linux.intel.com" <sakari.ailus@linux.intel.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v2] lib/scatterlist: Provide a DMA page iterator
Message-ID: <20190211222654.GA15746@ziepe.ca>
References: <20190207222647.GA30974@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190207222647.GA30974@ziepe.ca>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2019 at 10:26:52PM +0000, Jason Gunthorpe wrote:
> Commit 2db76d7c3c6d ("lib/scatterlist: sg_page_iter: support sg lists w/o
> backing pages") introduced the sg_page_iter_dma_address() function without
> providing a way to use it in the general case. If the sg_dma_len() is not
> equal to the sg length callers cannot safely use the
> for_each_sg_page/sg_page_iter_dma_address combination.
> 
> Resolve this API mistake by providing a DMA specific iterator,
> for_each_sg_dma_page(), that uses the right length so
> sg_page_iter_dma_address() works as expected with all sglists.
> 
> A new iterator type is introduced to provide compile-time safety against
> wrongly mixing accessors and iterators.
> 
> Acked-by: Christoph Hellwig <hch@lst.de> (for scatterlist)
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> Acked-by: Thomas Hellstrom <thellstrom@vmware.com>
> ---
>  .clang-format                              |  1 +
>  drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c |  8 +++-
>  drivers/media/pci/intel/ipu3/ipu3-cio2.c   |  4 +-
>  include/linux/scatterlist.h                | 49 ++++++++++++++++++----
>  lib/scatterlist.c                          | 26 ++++++++++++
>  5 files changed, 76 insertions(+), 12 deletions(-)

Applied to rdma.git's for-next, thanks everyone.

Jason
