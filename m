Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE88BC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 09:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D90D21906
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 09:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="brq2M/bF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389093AbeLUJ5o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 04:57:44 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45910 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728643AbeLUJ5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 04:57:44 -0500
Received: by mail-wr1-f68.google.com with SMTP id t6so4566383wrr.12
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 01:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Sz0lxES7TaheVKAL2ppstqONJM4+9+minfzfMKS9Y9g=;
        b=brq2M/bFEyL07SlcTy+1qRY7AJvyEg7vsOCWwzb4fxCoD5W7INij/AJRBId1DEDL7S
         GnN/n6gq5vL7mlDbs0HY0n5Co8VWAq2HZRibvEYpW2g5N1T6nZnzJuiFWGBth9SBJPLr
         EjIlh/2TeS5Xjd9/+EooCT1TaJUaap0Y09s6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Sz0lxES7TaheVKAL2ppstqONJM4+9+minfzfMKS9Y9g=;
        b=XWgtnfbLCMlFmjCmE4B4KrkJG06v0B98hWClokubxZgP7wuZ0xYfON0Oma2KB3JlZA
         DejwPYtW4uAvaWUpniqpz1YIEzFeUn61D8nfYgCtLikQ1mjtYf04owrl2XxBJHzF30j3
         hqsIR7fZxPeV6HX/4HuEVrKvqR/zNd2lBpuPe26k6/rS7xoCY8nx0N6WiVEMNKxAV590
         QuGQoZD00mJ2iPYvZ206Bz2oOjoBiKJG3Jy+Nq/67rSagdJH7xeZlkNeudLMawiFcler
         tm6Ch47sbAy+tuEz8L7R1WmpPbFxhHlsgU5OP5NVVK1log04wDZ/O9NRPErsc6DYr/+z
         UJXA==
X-Gm-Message-State: AJcUukenPHceB1wq/hILkrfM8rWvXbhwg0Qr04OyO6d1denTBCi7D0kJ
        rxyT3A2xoP320+l0Ye8/YDnYBA==
X-Google-Smtp-Source: ALg8bN4YUleL4n7dqCj5bUduXwKyUJS9FQ2QiVECC3o0StfxEq7v0376pnoFSKuzhKTarLb3XAOZlw==
X-Received: by 2002:adf:e78f:: with SMTP id n15mr1874763wrm.115.1545386262356;
        Fri, 21 Dec 2018 01:57:42 -0800 (PST)
Received: from dell ([95.149.164.119])
        by smtp.gmail.com with ESMTPSA id d4sm7997626wmb.25.2018.12.21.01.57.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Dec 2018 01:57:41 -0800 (PST)
Date:   Fri, 21 Dec 2018 09:57:40 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Priit Laes <plaes@plaes.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Olliver Schinagl <oliver@schinagl.nl>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Subject: Re: [linux-sunxi] Re: [PATCH v2 1/8] mfd: axp20x: name voltage
 ramping define properly
Message-ID: <20181221095740.GF13248@dell>
References: <cover.923997dd7d7396bb4d71f8967698b58ca956b929.1544512919.git-series.plaes@plaes.org>
 <01367c4f4f1e174fefbef9aac645f6792bda07e5.1544512919.git-series.plaes@plaes.org>
 <20181221083927.GQ4497@dell>
 <20181221084246.myrtv6n4jrv6lajl@plaes.org>
 <20181221092658.GB13248@dell>
 <20181221092858.6koh5dkrlc7xhvbh@plaes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181221092858.6koh5dkrlc7xhvbh@plaes.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Dec 2018, Priit Laes wrote:

> On Fri, Dec 21, 2018 at 09:26:58AM +0000, Lee Jones wrote:
> > On Fri, 21 Dec 2018, Priit Laes wrote:
> > 
> > > On Fri, Dec 21, 2018 at 08:39:27AM +0000, Lee Jones wrote:
> > > > On Tue, 11 Dec 2018, Priit Laes wrote:
> > > > 
> > > > > From: Olliver Schinagl <oliver@schinagl.nl>
> > > > > 
> > > > > The current axp20x names the ramping register 'scal' which probably
> > > > > means scaling. Since the register really has nothing to do with
> > > > > scaling, but really is the voltage ramp we rename it appropriately.
> > > > > 
> > > > > Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
> > > > > Signed-off-by: Priit Laes <plaes@plaes.org>
> > > > > Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> > > > > ---
> > > > >  include/linux/mfd/axp20x.h | 4 ++--
> > > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > 
> > > > I've lost track of what's happening with this set now.
> > > > 
> > > > Mark,
> > > > 
> > > > Did you take this patch in the end?
> > > 
> > > Yes, this is in linux-next.
> > 
> > I have no idea why Mark's tracker isn't mailing me (this is not the
> > first time this has happened).
> > 
> > Could you please rebase this set and resubmit all of the patches which
> > have not yet been applied?
> 
> Whole serie has been applied.

Well that saves me a job.  Thanks.  =:-)

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
