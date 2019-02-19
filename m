Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A997C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 06:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18877217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 06:43:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SCnWIyzF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfBSGnq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 01:43:46 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38364 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfBSGnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 01:43:46 -0500
Received: by mail-pf1-f193.google.com with SMTP id n125so2475392pfn.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 22:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NNOK1sTlkh3SuuIp9zkNJCFoUhdTNr0wK+3dV7ZTLgM=;
        b=SCnWIyzFcyib5h8PfSDgJ1BhROZdtbyC4vfd4OVMzj73lZuE8vR9BhCu4LVR6+73uL
         bO+/HD9vOgD4eGxukOmy+eYMoTr5OhoUwL4ame5vElXjMrW1kfD/FKttawUikiE2/kyv
         PHLMy6ryThTk+4cIorNRXMPkeihFqJN2y/lk4YmPDprTMDdV660V5o/G8lOTYc995otd
         PJhPVbbBn/QXDThYU4VUTUIdvA+sYFTRoqhbRhQbP4jxILX9Tkvszuf4Za/34qBC0OiO
         tb0qszIk7T6puj12F2P0qGyK4ez12P5Q7OZnz5Z6+tdOnNuP/BuZxb3JpiDhB9pMiSXO
         EQnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NNOK1sTlkh3SuuIp9zkNJCFoUhdTNr0wK+3dV7ZTLgM=;
        b=gQjbIzGg7nUgcB5lZJePW/+fOkXGCqONTO9/6BLauSZwLV5ya3c7zKJ7fHJIg5sUGA
         kgwkdfhKp2W4RcBToVgY22Ivj9SEV/HftLx2NN4WkQomjgiM8KO75Gwo4MySg5ieXkfn
         AdEKRsuH0H9lwjfLKY01CJyJd/kpNLLvkipqjWR+ibCPYyYVy6t32kNDIEalFR8gGlsx
         PjfRmxRLmjEN+jQNSktvtchN9qskVDy9pE9+lJ+CofZ/zGlVI8CH8cxf0pkTEo+2MaoH
         n4TnITMeYEcRKnHtKbf4htuJNwqtmzZpWJHXd9rYf7uZ0bt7oavozAjokY6ESwie48Ua
         LXkQ==
X-Gm-Message-State: AHQUAubsvbVc130FfynoXltVjHnRs83m6uStaxKKEcIe0qFNymIP/3Go
        YG32vd25I7rNLDWfIfSvudkUvQ==
X-Google-Smtp-Source: AHgI3IaQd4ZxTT221PGwAb7H2tFxwj2mjq7aWgxyk6ja9xMiVTV3vfnUURsceZwB87Hud24UQfKLIg==
X-Received: by 2002:a63:8b4b:: with SMTP id j72mr22483975pge.100.1550558625218;
        Mon, 18 Feb 2019 22:43:45 -0800 (PST)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id q75sm26161022pfa.38.2019.02.18.22.43.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 22:43:44 -0800 (PST)
Date:   Mon, 18 Feb 2019 22:43:42 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: Re: [RESEND PATCH] amba: Allow pclk to be controlled by power domain
Message-ID: <20190219064342.GC13018@tuxbook-pro>
References: <20190131020141.28352-1-bjorn.andersson@linaro.org>
 <CAPDyKFpvBnFg1+mtTvBP72qAu2=ciSwV=PMaEgM=iMSDcvtc7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFpvBnFg1+mtTvBP72qAu2=ciSwV=PMaEgM=iMSDcvtc7A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 05 Feb 06:58 PST 2019, Ulf Hansson wrote:

> On Thu, 31 Jan 2019 at 03:01, Bjorn Andersson
> <bjorn.andersson@linaro.org> wrote:
> >
> > On the Qualcomm SDM845 platform the apb_pclk is controlled as part of
> > the QDSS power/clock domain. Handle this by allowing amba to operate
> > without direct apb_pclk control, when a powerdomain is attached and no
> > clock is described.
> >
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> >
> > Resending this separate from the series it was originally part of.
> >
> >  drivers/amba/bus.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
> > index 41b706403ef7..3e13050c6d59 100644
> > --- a/drivers/amba/bus.c
> > +++ b/drivers/amba/bus.c
> > @@ -219,8 +219,13 @@ static int amba_get_enable_pclk(struct amba_device *pcdev)
> >         int ret;
> >
> >         pcdev->pclk = clk_get(&pcdev->dev, "apb_pclk");
> > -       if (IS_ERR(pcdev->pclk))
> > -               return PTR_ERR(pcdev->pclk);
> > +       if (IS_ERR(pcdev->pclk)) {
> > +               /* Continue with no clock specified, but pm_domain attached */
> > +               if (PTR_ERR(pcdev->pclk) == -ENOENT && pcdev->dev.pm_domain)
> > +                       pcdev->pclk = NULL;
> 
> This looks fragile to me.
> 
> I would prefer to make a do match with DT, to check whether the clock
> is needed or not.

Can you please elaborate on what you want me to match on?

As an example you can find the patch depending on this here:
https://lore.kernel.org/lkml/60ebf1617f0285c89e921bf3839cba6906d493c9.1548419933.git.saiprakash.ranjan@codeaurora.org/

> Moreover, there should be no reason to check for the
> ->dev.pm_domain, because, if there was an error while doing the
> attach, that should already have been reported/propagated.
> 

The purpose of this check was to extend the current requirement of a
clock to require either a clock or a power domain, rather than just
making the clock optional - which would be the result if this part is
omitted.

Regards,
Bjorn

> > +               else
> > +                       return PTR_ERR(pcdev->pclk);
> > +       }
> >
> >         ret = clk_prepare_enable(pcdev->pclk);
> >         if (ret)
> > --
> > 2.18.0
> >
> 
> Kind regards
> Uffe
