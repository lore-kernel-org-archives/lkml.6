Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7515C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 22:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9158F2146F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 22:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Ra51otyA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729968AbfAHWrj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 17:47:39 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36469 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729459AbfAHWrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 17:47:39 -0500
Received: by mail-pf1-f195.google.com with SMTP id b85so2636690pfc.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 14:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sLC7rHJyyI9y93CuLOGLaxfbCvXb0XM9Y2JZiN8bq8k=;
        b=Ra51otyATYM1ioHYueFp3Ma0vu8bwAoBwDwBovgCAQTT2WqDc2XkBmdhHjTXNZmfWa
         hEmffiB9X682zVcUkeQjDMLvTjLPiUFxmtcBIXwiuaUwdpUZNSs//UG+JXd3b4WRbnhV
         9f1rkX6tmrX4lnFgeu/lV0tedAYl3JG2KFwRXYY6goopW4AWxSYhp6FTlc7bSa9ZVraq
         zN9RYxivHRtgyCi2mv0MIdamemD4IusYSR0a5y2uE0TJ0czCewwsxnhkzzA0lXEw03DC
         CbOvgemjoArI9bXYiCtrexfbJt3M95lKMRLljXM1yEVJcRdCAqp2yWiwduwf8GsVbnM3
         Rt+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sLC7rHJyyI9y93CuLOGLaxfbCvXb0XM9Y2JZiN8bq8k=;
        b=fJsPW+cgCWQEX8dLd0ivZFPEyyXmlcyzxGtfV6a5lPPaeITpGbSWHbyIP0xxSUgeb+
         07cHFyHmaml60rwOQEfOeMtgAbKK7VcQDyF0sU56xOrs22OJcdyYIklD+DjFu0fWgn+x
         mZSxqJbjk3SKVxdmuKar4vzQeJQhjV2OgUXbjypOtT3p6I5ey51gDzGE6qlulX0FDwtz
         aixcGovN6NDgOR+PwNRMPeQ0FoeXb8Rg9J5mvUmwHno1VH+NgUZBsudfmcEmXPpINCJt
         yUqckN/6coFfkF08wt7GQH8Nl3f6653o037Vh6faxaoJoH8N9usr4Z4sbNi/TZmbdYUc
         2r0w==
X-Gm-Message-State: AJcUukfdMArMkjiRH+iJ62xyS8Jhan6veWTpyEWo5zZa4MNr9ImBqiHe
        aJD6on4CgOvrd2Zddt7gNuQHYg==
X-Google-Smtp-Source: ALg8bN6vBMlTHFib7ISHGaF0YbUoL9a74RMQAMIz+wakrN+70ZiBvMweLV8DOsvzinOTXEergiRIqg==
X-Received: by 2002:a62:7086:: with SMTP id l128mr3553122pfc.68.1546987658288;
        Tue, 08 Jan 2019 14:47:38 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id u137sm126939946pfc.140.2019.01.08.14.47.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Jan 2019 14:47:37 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gh09o-00019j-2y; Tue, 08 Jan 2019 15:47:36 -0700
Date:   Tue, 8 Jan 2019 15:47:36 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IB/srp: Use struct_size() in kzalloc()
Message-ID: <20190108224736.GA4368@ziepe.ca>
References: <20190108160805.GA22698@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190108160805.GA22698@embeddedor>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2019 at 10:08:05AM -0600, Gustavo A. R. Silva wrote:
> One of the more common cases of allocation size calculations is finding the
> size of a structure that has a zero-sized array at the end, along with memory
> for some number of elements for that array. For example:
> 
> struct foo {
>     int stuff;
>     void *entry[];
> };
> 
> instance = kzalloc(sizeof(struct foo) + sizeof(void *) * count, GFP_KERNEL);
> 
> Instead of leaving these open-coded and prone to type mistakes, we can now
> use the new struct_size() helper:
> 
> instance = kzalloc(struct_size(instance, entry, count), GFP_KERNEL);
> 
> This code was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  drivers/infiniband/ulp/srp/ib_srp.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied to for-next

Thanks,
Jason
