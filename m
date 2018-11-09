Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C406C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 11:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF5F620818
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 11:17:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="eV+w5xAq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qYwNxKWF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF5F620818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kroah.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbeKIU5O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 15:57:14 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:52737 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727532AbeKIU5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 15:57:14 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 5769D23075;
        Fri,  9 Nov 2018 06:17:04 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 09 Nov 2018 06:17:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=7+7TXjylZCN2Qkn5ycj+weTHoCM
        BEcUT/nPtjvMkYyE=; b=eV+w5xAqjHlZ5z0drRVd5vBGsCTzFSq9gvhrr3zTgBZ
        0S4A9Obm6C6aAQUtR18KAXgtBY8P6a92iJVhqgQQPU05qW/cwl/AmJwDl+4xGb9M
        HgRQEPDnVbaB3cI7xIi91J1810C0B/bMDGVhwi6ULW+O330MsDS7sX1hptWkCWYr
        Sgc+U851Zcdbw/3VOGeTspYj8myDCNQ10vAADJZQEMfsvE/65auIonmGyS0sXK2V
        mZoJ+Ryh12X+t3Kzaki098bPe92SU+gOyS9CxTHZ8YEipuotSc5rJccQXb88RFGg
        WyHaDLvKTFLi8aFwtt/nBcToH8oa7Ew2SNOlA6zUcUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=7+7TXj
        ylZCN2Qkn5ycj+weTHoCMBEcUT/nPtjvMkYyE=; b=qYwNxKWFeqaKLHPVV0TOU/
        l5UhkZGsMDEQmKuxC0CZXWPKrW4kEtTZuQSeroerHrPxfE58WuR+4g31tIs9bjUQ
        JorkbuH2DQYnxmrpWaPYfBXO6BzO8aU/JwPf2plWLLAwKL9/97ZcqGZDOVcYTOuS
        4iNPQZz5hmhFX4k39vmwM+PzHqM64gzj3ftNDsQ3dEJT6fIydZhX+xtIDMV/Se53
        T8axH0VpkVEpZi/4LceXYxLcorZc0EdHH6yXMfQ/5mYNNi7oENY6vdqEVOj7bbd2
        J00X/Nf0KK8HYoeDf/YUO+UYaQoTpnT98/Gcsmvdil3lo5LWGWVuPtL2PAY+4sOg
        ==
X-ME-Sender: <xms:rmzlWx_vPxOFZ4k6Hrj1k1hGx2Ov4twso5bUKKIiYcLubihDPAneJg>
X-ME-Proxy: <xmx:rmzlW61w0PTyWdRkOoKf09cLKaRb2mEhTq7kQW27L6o52Aq1DYOkNw>
    <xmx:rmzlW2saDEPJn26DdZV2lb_VplFff695-CX0jXto0rh7tywMgvMt5Q>
    <xmx:rmzlWy5ZWUK3cnybYWUHioOI_RAAAUAPEqreyiN9YQR5aCJyLzWGGg>
    <xmx:rmzlW_JUENXuPDz2DtYY6gHVgWyrSfDj52-8zED1p4MFZv14bDZ-LA>
    <xmx:rmzlW64aKHhoA2SzpLx9bGp10ar5O8Y-zPBeMhQSP8I2xF8rmRk55w>
    <xmx:sGzlW5Y5KOAa1UzRLMyzE7I03JI95CElytMkjgCTCRXUqszEe1es9w>
Received: from localhost (71-6-98-120.static-ip.telepacific.net [71.6.98.120])
        by mail.messagingengine.com (Postfix) with ESMTPA id AD8B4102E8;
        Fri,  9 Nov 2018 06:17:01 -0500 (EST)
Date:   Fri, 9 Nov 2018 03:17:00 -0800
From:   Greg KH <greg@kroah.com>
To:     Manjunath Patil <manjunath.b.patil@oracle.com>
Cc:     boris.ostrovsky@oracle.com, jgross@suse.com,
        konrad.wilk@oracle.com, roger.pau@citrix.com, axboe@kernel.dk,
        xen-devel@lists.xenproject.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] xen-blkfront: fix kernel panic with blkfront_remove()
Message-ID: <20181109111700.GC26335@kroah.com>
References: <1541725108-1468-1-git-send-email-manjunath.b.patil@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541725108-1468-1-git-send-email-manjunath.b.patil@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2018 at 04:58:28PM -0800, Manjunath Patil wrote:
> If a hot-attaching device fails inside domU[ex:negotiate_mq() returns
> with ENOMEM] we clear the blkfront_info struct in talk_to_blkback()
> 
> When we try to detach the device, blkfront_remove() tries to access
> blkfront_info leading to kernel panic.
> 
> Typical call stack involving panic -
>  #10 page_fault at ffffffff816f25df
>      [exception RIP: blkif_free+46]
>  #11 blkfront_remove at ffffffffa004de47 [xen_blkfront]
>  #12 xenbus_dev_remove at ffffffff813faa4c
>  #13 __device_release_driver at ffffffff814769aa
>  #14 device_release_driver at ffffffff81476a63
>  #15 bus_remove_device at ffffffff814762eb
>  #16 device_del at ffffffff81472684
>  #17 device_unregister at ffffffff814727e2
>  #18 xenbus_dev_changed at ffffffff813fa89f
>  #19 frontend_changed at ffffffff813fca19
>  #20 xenwatch_thread at ffffffff813f88f9
>  #21 kthread at ffffffff810a486b
>  #22 ret_from_fork at ffffffff816ed2a8
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Manjunath Patil <manjunath.b.patil@oracle.com>
> ---
>  drivers/block/xen-blkfront.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
> index dc8fe25..144cda8 100644
> --- a/drivers/block/xen-blkfront.c
> +++ b/drivers/block/xen-blkfront.c
> @@ -2496,6 +2496,9 @@ static int blkfront_remove(struct xenbus_device *xbdev)
>  
>  	dev_dbg(&xbdev->dev, "%s removed", xbdev->nodename);
>  
> +	if(!info)
> +		return 0;
> +

Always run scripts/checkpatch.pl on your patches so you do not get a
grumpy maintainer telling you to run scripts/checkpatch.pl on your
patches.

thanks,

greg k-h
