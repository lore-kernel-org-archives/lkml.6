Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC58C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 07:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27BE02148D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 07:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kv2F7fMm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfBUHzj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 02:55:39 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:40427 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbfBUHzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 02:55:39 -0500
Received: by mail-vs1-f66.google.com with SMTP id z18so15634187vso.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 23:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cNHLL6u4aOXpnjxTnJzkBDhRaA6a2w95ebLIg3AA7Q4=;
        b=kv2F7fMm4rMvOFmliHkCEhUfoheb2aFL4N9FenFC/qgbDivjmWnr3ra919Bvdw1YIh
         9w0zGQqRtnV/vfrUQuLhtkN7v7UxlH649Mt1UwGAVS6xeB+LD9dbSgyaGh/uZ2jMr77V
         79ACYY0nc65tt8ckrTrI8V1y5R6sXtIQA4H+Qw77jTy2Ay3L4o2nKXwefi9sApmTInAU
         TX4Sqv0WRvx+LF4cS+BRq3tZ9oKDP/+hY2IDUCfgGP/VOuol+XMLcu5rVOP8xVT2eeOz
         JeO91uz1QMP8YMZCzw3y8oeBQVNUtkaCqrnHyWrP8KV5fTLSDjZxcSx6tByygugv11XE
         X71A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cNHLL6u4aOXpnjxTnJzkBDhRaA6a2w95ebLIg3AA7Q4=;
        b=UcZPiHSy/t1C3MiRqF/XQBFmX3kR1NUpmRhnu8dsOb89nwog/nuCvXiW88I0BAOM9w
         EAGLXPEEtxiC+AdWuu/9bDtPMr0aROFC8a6MSLRXma7wpcTlOs8i9eaTgOLc5Fn49NSR
         D7of+ja+4LRnJJzzhNnZJKze/PoarQ6oGfDssa4sCtt3MJcKSc02jxkWAPcvI7LyPMjU
         t9CXznLrpw+J0NRaGMi44tEyE6APKzR7PfAFnGfQtUSf4Iv3Hu7eg6sCfCl05NhIsedZ
         NDRPSVhC3PZLbDa5HRa9QYMA5OjdTDvEtQiwTCvLbJZlX2KC55OW8Hvd7FZiSBufwfOE
         0BPw==
X-Gm-Message-State: AHQUAuaCkb76e1nYMhExswJD0fLxiW74te9XL40f4/dAAjagkfUZUjbC
        GlmQfo43b0zKAUoOE2z9yetmBdTsIvvwHqaMz9Fk2A==
X-Google-Smtp-Source: AHgI3IbbmSArN2EAnOdawcv2LY5BRnJEWD2EAYgzIKZiFgzrL3O0ASiNJNk0XqI8kpOy/Dt4N6oe8T69NdmOT34cpw0=
X-Received: by 2002:a67:f69a:: with SMTP id n26mr20199096vso.191.1550735736782;
 Wed, 20 Feb 2019 23:55:36 -0800 (PST)
MIME-Version: 1.0
References: <20190131020141.28352-1-bjorn.andersson@linaro.org>
 <CAPDyKFpvBnFg1+mtTvBP72qAu2=ciSwV=PMaEgM=iMSDcvtc7A@mail.gmail.com> <20190219064342.GC13018@tuxbook-pro>
In-Reply-To: <20190219064342.GC13018@tuxbook-pro>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 21 Feb 2019 08:55:00 +0100
Message-ID: <CAPDyKFrWZ5C=rp7_ad0Pvz-GFb20yU+BZn_hEHxR_6DDBW8zrQ@mail.gmail.com>
Subject: Re: [RESEND PATCH] amba: Allow pclk to be controlled by power domain
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Feb 2019 at 07:43, Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Tue 05 Feb 06:58 PST 2019, Ulf Hansson wrote:
>
> > On Thu, 31 Jan 2019 at 03:01, Bjorn Andersson
> > <bjorn.andersson@linaro.org> wrote:
> > >
> > > On the Qualcomm SDM845 platform the apb_pclk is controlled as part of
> > > the QDSS power/clock domain. Handle this by allowing amba to operate
> > > without direct apb_pclk control, when a powerdomain is attached and no
> > > clock is described.
> > >
> > > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > ---
> > >
> > > Resending this separate from the series it was originally part of.
> > >
> > >  drivers/amba/bus.c | 9 +++++++--
> > >  1 file changed, 7 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
> > > index 41b706403ef7..3e13050c6d59 100644
> > > --- a/drivers/amba/bus.c
> > > +++ b/drivers/amba/bus.c
> > > @@ -219,8 +219,13 @@ static int amba_get_enable_pclk(struct amba_device *pcdev)
> > >         int ret;
> > >
> > >         pcdev->pclk = clk_get(&pcdev->dev, "apb_pclk");
> > > -       if (IS_ERR(pcdev->pclk))
> > > -               return PTR_ERR(pcdev->pclk);
> > > +       if (IS_ERR(pcdev->pclk)) {
> > > +               /* Continue with no clock specified, but pm_domain attached */
> > > +               if (PTR_ERR(pcdev->pclk) == -ENOENT && pcdev->dev.pm_domain)
> > > +                       pcdev->pclk = NULL;
> >
> > This looks fragile to me.
> >
> > I would prefer to make a do match with DT, to check whether the clock
> > is needed or not.
>
> Can you please elaborate on what you want me to match on?
>
> As an example you can find the patch depending on this here:
> https://lore.kernel.org/lkml/60ebf1617f0285c89e921bf3839cba6906d493c9.1548419933.git.saiprakash.ranjan@codeaurora.org/

I would extend the compatible with a "soc-id" prefix and match on that.

If that doesn't work, I guess we need check for the soc family/id,
thus use soc_device_match().

>
> > Moreover, there should be no reason to check for the
> > ->dev.pm_domain, because, if there was an error while doing the
> > attach, that should already have been reported/propagated.
> >
>
> The purpose of this check was to extend the current requirement of a
> clock to require either a clock or a power domain, rather than just
> making the clock optional - which would be the result if this part is
> omitted.

Well, that would break the current requirement for everybody else,
which is that the clock is required and the PM domain is optional.

[...]

Kind regards
Uffe
