Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 566A2C6778D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 18:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FE6F20854
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 18:36:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pVYPMgAK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FE6F20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728212AbeILXmK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 19:42:10 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34777 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727651AbeILXmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 19:42:10 -0400
Received: by mail-wr1-f66.google.com with SMTP id g33-v6so3107323wrd.1;
        Wed, 12 Sep 2018 11:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=305ja6OjRmxKCLsXrqshDqhAmhji0MI8HdLy4EroxUk=;
        b=pVYPMgAKHyPcfJqAAej6E5RsSEjqXYmk/T0oPyM5qkkl9q8HhuaI7fBjIkipOpZXKa
         gGwnXFjDMu5RZp8QgeZc9Qn+Ahdg6eq9CgYI/JqCwvokiJsAfU6UhRMZg0JlgEo0NYXE
         Xcdqu+v/qWc75TxYqpQ0ouAYmTZrjDOGAyMD6F4bRV/feQbKyXQ7nI0U9dgf+Z2VppZJ
         Dn1bQqGHRtt3uXyww5T/Pdx8yBZUhiO89Oa3tbbkTlG39lQoi05fqDHkpxZNINNxps0l
         5x2c133iGxBjFvUh/WabZzx5wX8/maY7alpLCIazEqn8puRG48OkcShrxLZgcWr9zaUJ
         yAlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=305ja6OjRmxKCLsXrqshDqhAmhji0MI8HdLy4EroxUk=;
        b=EtrCmsk7sylr5/texwC7xHQ0iglyb4CVMnB9K+N41cwLJ1FrBJtGuwRVfhFMFMJOA/
         LYeaVfyw8tNvo2tsyDUXmSFdACSgtz/Roow2tODxRxmgqaSDlYhBFnh3RhnxSEFUsUQ0
         WjjKYCRI9MhZxb00trm64DHjxlNgWjYqJ1X7TXVskZ/WBPY8woj60vmd8HweIscJibhQ
         8FAx6M7LYnGfeFn6LsCG7qSyyMXRlLvaRy2x6082mqTzcbhDMp/W8p44v+Apae6AB+/p
         OOeF5PpS7FOhXU9OzuWWZtG0eX70zfRXIAG2n5E9bn+thm17zBokhNPklzOjUQh4muvA
         hqaQ==
X-Gm-Message-State: APzg51AZj4hzWnZPH27PJmjjalvSW2SwjEMjdEmcXJIy32v7mTjM59eo
        FfjOdYgeI4guayg5HnXnfOE=
X-Google-Smtp-Source: ANB0VdYahnPgwEl+cZWXwZz1oPSWM03sT8fom14gFw+iUdF8WNTZyZp3Yweh7iHHLw1Twm9YP1TKsw==
X-Received: by 2002:adf:e6c2:: with SMTP id y2-v6mr2584444wrm.35.1536777381926;
        Wed, 12 Sep 2018 11:36:21 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id g17-v6sm1186393wmh.19.2018.09.12.11.36.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Sep 2018 11:36:21 -0700 (PDT)
Date:   Wed, 12 Sep 2018 11:36:19 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     dan.j.williams@intel.com, vkoul@kernel.org,
        dmaengine@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dmaengine: ep93xx: Return proper enum in
 ep93xx_dma_chan_direction
Message-ID: <20180912183619.GA30421@flashbox>
References: <20180911234020.9064-1-natechancellor@gmail.com>
 <CAKwvOdmJ1NGmFi8Vcv5oPr7828X3tbOZeUainPhtC4HnTK_xjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdmJ1NGmFi8Vcv5oPr7828X3tbOZeUainPhtC4HnTK_xjw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 10:00:57AM -0700, Nick Desaulniers wrote:
> On Tue, Sep 11, 2018 at 4:40 PM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > Clang warns when implicitly converting from one enumerated type to
> > another. Avoid this by using the equivalent value from the expected
> > type.
> >
> > In file included from drivers/dma/ep93xx_dma.c:30:
> > ./include/linux/platform_data/dma-ep93xx.h:88:10: warning: implicit
> > conversion from enumeration type 'enum dma_data_direction' to different
> > enumeration type 'enum dma_transfer_direction' [-Wenum-conversion]
> >                 return DMA_NONE;
> >                 ~~~~~~ ^~~~~~~~
> > 1 warning generated.
> >
> > Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> >  include/linux/platform_data/dma-ep93xx.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/linux/platform_data/dma-ep93xx.h b/include/linux/platform_data/dma-ep93xx.h
> > index f8f1f6b952a6..eb9805bb3fe8 100644
> > --- a/include/linux/platform_data/dma-ep93xx.h
> > +++ b/include/linux/platform_data/dma-ep93xx.h
> > @@ -85,7 +85,7 @@ static inline enum dma_transfer_direction
> >  ep93xx_dma_chan_direction(struct dma_chan *chan)
> >  {
> >         if (!ep93xx_dma_chan_is_m2p(chan))
> > -               return DMA_NONE;
> > +               return DMA_TRANS_NONE;
> 
> Looks like this changes the value of the returned enum from:
> DMA_NONE: 3
> DMA_TRANS_NONE: 4
> 
> Hopefully the DMA maintainer can review if this was ever correct?
> Looks like the callers of ep93xx_dma_chan_direction were comparing
> this return type, so those comparisons would likely always be failing
> if `!ep93xx_dma_chan_is_m2p(chan)`.
> 
> Normally this warning (-Wenum-conversion) is kind of noisey, but it's
> concerning when the enumerated values evaluate to different integers.
> I think it's found an actual bug here.
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> 

I should have highlighted this in the actual commit message but I
checked all of the callsites of ep93xx_dma_chan_direction and one
directly refers to an enum value, DMA_MEM_TO_DEV; every other one
just checks if the value is or isn't equal to another value of this
enum type (DMA_NONE isn't referenced anywhere else in this driver).
I don't believe this results in a funcitonal change.

Thanks for the review!
Nathan

> >
> >         /* even channels are for TX, odd for RX */
> >         return (chan->chan_id % 2 == 0) ? DMA_MEM_TO_DEV : DMA_DEV_TO_MEM;
> > --
> > 2.18.0
> >
> 
> 
> -- 
> Thanks,
> ~Nick Desaulniers
