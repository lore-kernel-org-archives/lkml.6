Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C7BBC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 15:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09880208D9
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 15:08:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YXWBThX4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09880208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729582AbeJAVq0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 17:46:26 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35312 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729472AbeJAVq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 17:46:26 -0400
Received: by mail-wr1-f67.google.com with SMTP id w5-v6so5150500wrt.2;
        Mon, 01 Oct 2018 08:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2Rz4PkWKUB9ZNxO4sVlgtz7ltgbQxyF/PqUXw9YfA8U=;
        b=YXWBThX4M+WNryFZNBTRWq2cdVjl/zkVCLXuYzCFOpN8LRNqKXhmpK5Lb9+Qx5s+a/
         AqjIgn3ceHSd9Na2uaKox4SspKpxNqSFbcX/gSL2/GflASUvlXSogfxooRmSMu1ySPnx
         vDAtF0rVUo0CjXqTqnmiHT5Cf0GbHZXRsTiKndg6ZkfU+sSWMdgkn6FKhA8gNF2Nj7ic
         pJsP/0uVjjpnF5pTj/sqbep9OLmmZXI76O0e+Y6L6YVAfl9daWRLpok+QLf3x4oknc0S
         mIl+/GJHhoYZjAPBJY5r4vJaF2xRDW7GAXH0EzUyDT+9+ATfBEfCRT1fc1Xr01O5KJb1
         pvBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2Rz4PkWKUB9ZNxO4sVlgtz7ltgbQxyF/PqUXw9YfA8U=;
        b=C7txi1kmbCbqlzvori9OX/P3k0/ybRqRmquTh7qrSpkQyOdvErQXo7dchxQevIX/7x
         2yu4ZokSM00TbjDfcNElcpOgawBRUx2yj2/Ao5qqWucYObeKpzDANvv7qRQxZRmEuYzv
         46ckL49pwktHIUrsADnLzdE6DiBDmWnMGK752XU8GUC6aOnKhN2XRSVGGFasvokO3rbp
         LeOyBVWW3V8TXkAAyWGnuXvsVjRl6H6AN+CgbSLV+xsAcuVAQX0Ap6piw/Ye5VJg3LDb
         eYvQPMjCed1RhA7uZz3wnkGcbISYURffdFNb6HYAXWxqVpiioMCFf58cQoXJsnCkNpmH
         iyXg==
X-Gm-Message-State: ABuFfohwYmDqsMDhcdGe5RckA4IBoLZ6OdkgLNIlyWc2Myh38K5FZDh7
        hNBedv1CHW1lCFc8fA7knwI=
X-Google-Smtp-Source: ACcGV62dR4WAbVNLR76BzF8JwhNosdF07AiZyqDL4bx2hXvbftKGs7WpuDXmB0ie/GZfdxk7sQXxsg==
X-Received: by 2002:a5d:4ec8:: with SMTP id s8-v6mr7062773wrv.32.1538406490104;
        Mon, 01 Oct 2018 08:08:10 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id h17-v6sm12606044wrq.73.2018.10.01.08.08.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Oct 2018 08:08:09 -0700 (PDT)
Date:   Mon, 1 Oct 2018 08:08:07 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Andy Walls <awalls@md.metrocast.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] media: cx18: Don't check for address of video_dev
Message-ID: <20181001150807.GA16790@flashbox>
References: <20180921195736.7977-1-natechancellor@gmail.com>
 <440b7ec3-b0b6-c96b-93de-4b6a3be44eac@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <440b7ec3-b0b6-c96b-93de-4b6a3be44eac@xs4all.nl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 01, 2018 at 10:30:54AM +0200, Hans Verkuil wrote:
> On 09/21/2018 09:57 PM, Nathan Chancellor wrote:
> > Clang warns that the address of a pointer will always evaluated as true
> > in a boolean context.
> > 
> > drivers/media/pci/cx18/cx18-driver.c:1255:23: warning: address of
> > 'cx->streams[i].video_dev' will always evaluate to 'true'
> > [-Wpointer-bool-conversion]
> >                 if (&cx->streams[i].video_dev)
> >                 ~~   ~~~~~~~~~~~~~~~^~~~~~~~~
> > 1 warning generated.
> > 
> > Presumably, the contents of video_dev should have been checked, not the
> > address. This check has been present since 2009, introduced by commit
> > 21a278b85d3c ("V4L/DVB (11619): cx18: Simplify the work handler for
> > outgoing mailbox commands")
> > 
> > Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> > 
> > Alternatively, this if statement could just be removed since it has
> > evaluated to true since 2009 and I assume some issue with this would
> > have been discovered by now.
> > 
> >  drivers/media/pci/cx18/cx18-driver.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/media/pci/cx18/cx18-driver.c b/drivers/media/pci/cx18/cx18-driver.c
> > index 56763c4ea1a7..753a37c7100a 100644
> > --- a/drivers/media/pci/cx18/cx18-driver.c
> > +++ b/drivers/media/pci/cx18/cx18-driver.c
> > @@ -1252,7 +1252,7 @@ static void cx18_cancel_out_work_orders(struct cx18 *cx)
> >  {
> >  	int i;
> >  	for (i = 0; i < CX18_MAX_STREAMS; i++)
> > -		if (&cx->streams[i].video_dev)
> > +		if (cx->streams[i].video_dev)
> 
> This should read:
> 
> 		if (cx->streams[i].video_dev.v4l2_dev)
> 
> If cx->streams[i].video_dev.v4l2_dev == NULL, then the stream is not in use
> and there is no need to cancel any work.
> 
> Can you post a v2?
> 

Hi Hans,

Yes, sorry, I completely forgot to look into this further. I will sent a
v2 right now.

Thank you for the review,
Nathan

> >  			cancel_work_sync(&cx->streams[i].out_work_order);
> >  }
> >  
> > 
> 
> Regards,
> 
> 	Hans
