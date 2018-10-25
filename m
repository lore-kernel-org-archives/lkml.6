Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02BD0C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7E0720848
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:44:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KxYQoDg6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7E0720848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbeJYXRM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 19:17:12 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36412 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727844AbeJYXRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 19:17:11 -0400
Received: by mail-wr1-f66.google.com with SMTP id y16so9625577wrw.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 07:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gY3jN4mlAOXZJQI7lW3fjoAYoUt4PrJt1bQpSMgldyk=;
        b=KxYQoDg6YnfmQFGRagtuEKDgXRiV+MJNXdg0QiSx4uvD4BmwAzXFTGbo9IOqFcHFiU
         NwJSGqjaPvj05jUD/erG8FPXBzLkkojhjzveFCmvuSu65II4G7tmUCHjeqS7UwotTkus
         ZtcdQJl+npOrO/57Ow8YCaFkgnSrkAJ8ZVSyvhlswfi4Gwg624UlTJPttn7KkaInEPE5
         gZZaShdy3m+/UjKEAIr65Rli5v6Sa6TnAQYv9kR1upOVP6WxXAAQq8twiPCzdOYYb493
         sagzeWYUXHMsEFwITb/KGIoJNPbqZ3Ib7bsrzF/MTQ7HstmZGyT2Wgmk5i3cVQTleV7f
         HGvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gY3jN4mlAOXZJQI7lW3fjoAYoUt4PrJt1bQpSMgldyk=;
        b=Jm/9yHZNnYLo46l8arwgD5HUc2X0pYjUYz0CI9jW4OzWo4BaZx60PGQPstAallRoE4
         Wzl5R6DhrvdOuBla6U4d/MUDbGSchtc01OYMQDU/8dIi1SA6MfOfYx1tbjpTKNUKmgZv
         xE6GvgPKJkZ4EUS7qn1Vnu25Kwbjr5n//Qvc6Z788JXr8/JXVdZ5fe/vCGNIvy7t3VA/
         8i+ih5wOP8MFStpwZ+/MRATa9WF5r3QByK8zxRhjL1D59bN30RFSzg4Kzsbhs9jd7PT9
         7WHG4vK8W3ahlfPQZBOZQm7+kV1ymXKke43FMf8P9LZA5MmPtaSCTsV2ECCWNdXjM4WU
         OusA==
X-Gm-Message-State: AGRZ1gL856tJF9mT6cK7lmNwsFTkuHgkAVSQwbiKTkwgukwZYXcM+PmN
        lEIDKDGbbkm4RNsljy1uaYQ=
X-Google-Smtp-Source: AJdET5dk0XZZKX4hqhxDTbvxHxiHPjdBHdX7cbG7UxhYxVrZrdX57ikqFrojbfXjYy789IfUMMO2Hw==
X-Received: by 2002:adf:dbc3:: with SMTP id e3-v6mr2336462wrj.165.1540478644649;
        Thu, 25 Oct 2018 07:44:04 -0700 (PDT)
Received: from zdravcePC (cable-178-149-91-180.dynamic.sbb.rs. [178.149.91.180])
        by smtp.gmail.com with ESMTPSA id q190-v6sm2104086wmg.40.2018.10.25.07.44.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 07:44:04 -0700 (PDT)
Date:   Thu, 25 Oct 2018 16:44:02 +0200
From:   Aleksa Zdravkovic <alex.zdravkovic98@gmail.com>
To:     Joe Perches <joe@perches.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: axis-fifo: Fix line over 80 characters error
Message-ID: <20181025144401.GA27089@zdravcePC>
References: <20181024150550.GA5150@zdravcePC>
 <20181025060533.mfmdozimla7wq2sg@mwanda>
 <cc426006c1d69f9fd464afe96a62e9e745b2078b.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc426006c1d69f9fd464afe96a62e9e745b2078b.camel@perches.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 11:18:17PM -0700, Joe Perches wrote:
> On Thu, 2018-10-25 at 09:05 +0300, Dan Carpenter wrote:
> > On Wed, Oct 24, 2018 at 05:05:53PM +0200, Aleksa Zdravkovic wrote:
> > > This patch fixes the checkpatch.pl warning:
> []
> > > diff --git a/drivers/staging/axis-fifo/axis-fifo.c b/drivers/staging/axis-fifo/axis-fifo.c
> []
> > > @@ -482,10 +482,10 @@ static ssize_t axis_fifo_write(struct file *f, const char __user *buf,
> > >  		spin_lock_irq(&fifo->write_queue_lock);
> > >  		ret = wait_event_interruptible_lock_irq_timeout
> > >  			(fifo->write_queue,
> > > -			 ioread32(fifo->base_addr + XLLF_TDFV_OFFSET)
> > > +			ioread32(fifo->base_addr + XLLF_TDFV_OFFSET)
> > >  				>= words_to_write,
> > > -			 fifo->write_queue_lock,
> > > -			 (write_timeout >= 0) ? msecs_to_jiffies(write_timeout) :
> > > +			fifo->write_queue_lock,
> > > +			(write_timeout >= 0) ? msecs_to_jiffies(write_timeout) :
> > >  				MAX_SCHEDULE_TIMEOUT);
> > 
> > The original was fine.  Just leave it.
> > 
> > Checkpatch.pl is only useful if it improves the readability for humans.
> 
> True, but I think the original is just OK.
> 
> Any suggestion on how to make the thing better?
> 
> wait_event_interruptible_lock_irq_timeout is a fairly long
> identifier with multiple long arguments.
> 
> It's as if it should be written here as
> 
>  		ret = wait_event_interruptible_lock_irq_timeout(fifo->write_queue,
> 								ioread32(fifo->base_addr + XLLF_TDFV_OFFSET) >= words_to_write,
> 								fifo->write_queue_lock,
> 								write_timeout >= 0 ? msecs_to_jiffies(write_timeout) : MAX_SCHEDULE_TIMEOUT);
> 
> where the longest is way over 80 chars, (140?) but I simply don't care
> because it's just that much more readable for me.
> 
> 

Thank you Dan and Joe for your feedback.

I don't have any suggestion how to improve this code otherwise.
I will try to find a way to improve it. Maybe we can define some
macros but I don't think it would help much.


