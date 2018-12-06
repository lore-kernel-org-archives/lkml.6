Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E60BBC04EBF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 07:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABFFF21479
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 07:33:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hoZr2plO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABFFF21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729303AbeLFHdJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 02:33:09 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44242 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729287AbeLFHdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 02:33:08 -0500
Received: by mail-pl1-f194.google.com with SMTP id k8so11367718pls.11
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 23:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1Py1o7PoXLk0zLclLjaf6U24aMMRxPgBlX4EsDDipLw=;
        b=hoZr2plOPuxeaxDOwX/82KyNCsezxbKlCZmlj+fGmiOro2P388n7hYFMl9TC5gGEzH
         fgK2xoQoHMoNY9DRnEf4knK7/+NBs4J6D8+sp+WO3IVQR/7v4IiVAZEpcsC/weKDnizx
         IVKHT8sdqIKHBSc3fAPNQOE189DFe1/qLZDqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1Py1o7PoXLk0zLclLjaf6U24aMMRxPgBlX4EsDDipLw=;
        b=k6Kaz3G5qva/EeeCIF55ctTz0q5QfB3bETmGKHowd2IbNKY+oPB62U2P1Pn+Cml6/R
         t4Y6tFeJfR37lH/qj/iauA7lj6MhvLL3dUAd7CHoN4YxZhDR3isOE0QxlKNUxjBtrlxq
         0Fbe5mMtT2Jrve+ANA8WBA3GurU1wwz7/NIPPqsDcGadIwvHt/JreMHcr9nP8bJURDcj
         l7WMB/u+jpevjDAc6uWHUHkNarxSGjSDInN26xRU8z+SFlXadnAMxZhUrYOUz+bXPKSA
         CC6hvKQ9iA7YqQ2sxlr42fl5pxdVs2wNsUWMyGrWUfM000BYPeI+AqZ47KUeUg8jvsQq
         XUvw==
X-Gm-Message-State: AA+aEWbvogXfLsRjXyYQy4WLnPkeoqus4SsG9bcm+0vjoy9zBxXuF6Xm
        LcsRpMlgn+WA53kK0qNtvPigOA==
X-Google-Smtp-Source: AFSGD/UQtJ4xW4HzmKoW+CFcP78zvDeUZ7GHgwiur6JRVpvHIn5glFTbzxgRYkn3meozL1V7dt8FZw==
X-Received: by 2002:a17:902:d806:: with SMTP id a6mr26165686plz.172.1544081587396;
        Wed, 05 Dec 2018 23:33:07 -0800 (PST)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id h69sm30075331pge.4.2018.12.05.23.33.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 23:33:06 -0800 (PST)
Date:   Wed, 5 Dec 2018 23:33:04 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Alex Elder <elder@linaro.org>,
        David Dai <daidavid1@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, georgi.djakov@linaro.org,
        evgreen@google.com, tdas@codeaurora.org
Subject: Re: [RFC PATCH] clk: qcom: clk-rpmh: Add IPA clock support
Message-ID: <20181206073304.GB5232@tuxbook-pro>
References: <1543895413-1553-1-git-send-email-daidavid1@codeaurora.org>
 <1543895413-1553-2-git-send-email-daidavid1@codeaurora.org>
 <154395145491.88331.1174781210192403998@swboyd.mtv.corp.google.com>
 <8dafe631-4b16-94cd-392e-84728f2bb382@linaro.org>
 <154396284056.88331.12279283832884556349@swboyd.mtv.corp.google.com>
 <edeebce5-24a2-b844-6bff-781017949e2d@codeaurora.org>
 <154399414865.88331.2447825064224349951@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154399414865.88331.2447825064224349951@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 04 Dec 23:15 PST 2018, Stephen Boyd wrote:

> Quoting David Dai (2018-12-04 17:14:10)
> > 
> > On 12/4/2018 2:34 PM, Stephen Boyd wrote:
> > > Quoting Alex Elder (2018-12-04 13:41:47)
> > >> On 12/4/18 1:24 PM, Stephen Boyd wrote:
> > >>> Quoting David Dai (2018-12-03 19:50:13)
> > >>>> Add IPA clock support by extending the current clk rpmh driver to support
> > >>>> clocks that are managed by a different type of RPMh resource known as
> > >>>> Bus Clock Manager(BCM).
> > >>> Yes, but why? Does the IPA driver need to set clk rates and that somehow
> > >>> doesn't work as a bandwidth request?
> > >> The IPA core clock is a *clock*, not a bus.  Representing it as if
> > >> it were a bus, abusing the interconnect interface--pretending a bandwidth
> > >> request is really a clock rate request--is kind of kludgy.  I think Bjorn
> > >> and David (and maybe Georgi? I don't know) decided a long time ago that
> > >> exposing this as a clock is the right way to do it.  I agree with that.
> > >>
> > > But then we translate that clock rate into a bandwidth request to the
> > > BCM hardware? Seems really weird because it's doing the opposite of what
> > > you say is abusive. What does the IPA driver plan to do with this clk?
> > > Calculate a frequency by knowing that it really boils down to some
> > > bandwidth that then gets converted back into some clock frequency? Do we
> > > have the user somewhere that can be pointed to?
> > The clock rate is translated into a unitless threshold value sent as 
> > part of the rpmh msg
> > that BCM takes to select a performance. In this case, the unit 
> > conversion is based on
> > the unit value read from the aux data which is in Khz. I understand that 
> > this wasn't
> > explicitly mentioned anywhere and I'll improve on that next patch. 
> 
> How is this different from bus bandwidth requests? In those cases the
> bandwidth is calculated in bits per second or something like that, and
> written to the hardware so it can convert that bandwidth into kHz and
> set a bus clk frequency in the clock controller? So in the IPA case
> we've skipped the bps to kHz conversion step and gone straight to the
> clk frequency setting part? Is a BCM able to aggregate units of
> bandwidth or kHz depending on how it's configured and this BCM is
> configured for kHz?
> 

My objection to the use of msm_bus vs clock framework is not related to
how the actual interface of configuring the hardware looks like. It's
simply a matter of how this is represented in software, between some
provider and the IPA driver.

The IPA driver wants the IPA block to tick at 75MHz and I do not think
it's appropriate to achieve that by requesting a path between IPA Core
and IPA Core of 75000000 Kbytes/s.

Regards,
Bjorn
