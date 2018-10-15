Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B7DC7112A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 08:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C817920644
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 08:56:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C817920644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbeJOQkb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 12:40:31 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:48450 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbeJOQkb (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Mon, 15 Oct 2018 12:40:31 -0400
Received: from emea4-mta.ukb.novell.com ([10.120.13.87])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Mon, 15 Oct 2018 10:56:09 +0200
Received: from [192.168.1.2] (nwb-a10-snat.microfocus.com [10.120.13.201])
        by emea4-mta.ukb.novell.com with ESMTP (TLS encrypted); Mon, 15 Oct 2018 09:56:03 +0100
Message-ID: <886d0f79d59d2d35ca75f9d2d79cdb45c1628c78.camel@suse.com>
Subject: Re: [Xen-devel] [PATCH] xen/blkfront: avoid NULL blkfront_info
 dereference on device removal
From:   Vasilis Liaskovitis <vliaskovitis@suse.com>
To:     Roger Pau =?ISO-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
Cc:     axboe@kernel.dk, jgross@suse.com, konrad.wilk@oracle.com,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com
Date:   Mon, 15 Oct 2018 10:55:54 +0200
In-Reply-To: <20181011163427.ilpsl4hxb2y3hcfp@mac.bytemobile.com>
References: <20181011162000.19191-1-vliaskovitis@suse.com>
         <20181011163427.ilpsl4hxb2y3hcfp@mac.bytemobile.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-10-11 at 18:34 +0200, Roger Pau Monné wrote:
> --- a/drivers/block/xen-blkfront.c
> > +++ b/drivers/block/xen-blkfront.c
> > @@ -2493,6 +2493,9 @@ static int blkfront_remove(struct
> > xenbus_device *xbdev)
> >  
> >  	dev_dbg(&xbdev->dev, "%s removed", xbdev->nodename);
> >  
> > +	if (!info)
> > +		goto out;
> 
> I don't see the point in adding the 'out' label. Can you just return
> 0
> here?

of course, I will send a second version.
 
thanks for the review,

- Vasilis

> 
> Thanks, Roger.
> 
> _______________________________________________
> Xen-devel mailing list
> Xen-devel@lists.xenproject.org
> https://lists.xenproject.org/mailman/listinfo/xen-devel

