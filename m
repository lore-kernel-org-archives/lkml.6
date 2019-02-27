Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC42C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 09:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAA87218CD
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 09:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NW6JurUs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729667AbfB0JLz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 04:11:55 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:44400 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727189AbfB0JLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 04:11:54 -0500
Received: by mail-ua1-f67.google.com with SMTP id r21so7482577uan.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 01:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kw8tusPCA1LkwwPgvJXNDPcc4GR2+4CJ0mI3cYf1BkI=;
        b=NW6JurUsFRBVGoroaa+zeoQy2/PFjytXZNZqRWxNnjdraqjWti0Y7TE7stuzyMby0J
         pxzTIxUPwrb5z6IHqEVqn15wlB0v+qfNMHApva8CksWdK15+niZ9Hmc6jrCJSWX81e2U
         ITnth/3ALPjaSfQO8MLrN1RZeN+G1mzuDqdzAiMkMJG/L4jtSrmvti0QE8OTGpq9BHkq
         hyLq512TRv5CrdVA8Xn9IcjSTdWMSUvi4R3uVI8EMc6sN8d5ZjkIdTJPiViuxgMfqjeH
         H4sj5D9HDUSIOW7mtmNxDdUbWqKISgUDs67gFjbp1N+0GAehZIewxg30xKnCQEGuDuaC
         xxbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kw8tusPCA1LkwwPgvJXNDPcc4GR2+4CJ0mI3cYf1BkI=;
        b=MWkGSE9Afdjryl5SiYQAC0MS/W9qmmCD6VlDbTnVNNdwXXZCvt2MXLHhFi5erngPWB
         G5W+dBvSQ6AQp63SHWDFJATFGVSw7tAl8SY185lYnZ2s38Mq78s/N6VjclOzH8i34oL5
         bc7KKffWO7fRUGvQ8hZtVJHxdBQdkYt3ALv7fkvNIDPrci+z52LZeCakTvdtaoFAPIAb
         IbZe7QRiAU6FOCrIIDpB7Vh4Vf23QPyAyKwWKIAIbZ3zrWtBA0GujjIAgBtgkFa0c8AJ
         Tk75D5TIoh4s0cWtKe/g7sFl/QLq6PPMU9oMr7DwcqrYN9B+Ua5utVy8GRUkZNmuxR6Q
         0/YQ==
X-Gm-Message-State: AHQUAuZxhTLHAEeWjJr16IwNcci1vuJ57Y/FcmanNVoGHVgQHyfDy5+c
        V1CJM2clYnTjanHLEXZDTGOqs6tmjJ3oZ0y4/KSw4Q==
X-Google-Smtp-Source: AHgI3IaQqA1hiqd+sfYZ3tlX1mFzyAUGnsDVblZH9Yvb4jtfwPOWLyNntcNO6dtLDbSsZzqjuQ3HvMHgvHdRjyo0wRs=
X-Received: by 2002:a67:8055:: with SMTP id b82mr1203928vsd.200.1551258713237;
 Wed, 27 Feb 2019 01:11:53 -0800 (PST)
MIME-Version: 1.0
References: <1550743851-13588-1-git-send-email-ludovic.Barre@st.com>
 <20190221102739.cc37au6elqu6gvfe@shell.armlinux.org.uk> <20190221103049.tspc5igoe6wmt3jd@shell.armlinux.org.uk>
 <a736b773-d6e6-eb81-90d6-ebeab7b401cb@st.com> <20190221140300.y3tunrvsh3gyig5f@shell.armlinux.org.uk>
 <9c88d76c-2080-71b1-c9c6-c24d0f0aeb91@st.com>
In-Reply-To: <9c88d76c-2080-71b1-c9c6-c24d0f0aeb91@st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 27 Feb 2019 10:11:17 +0100
Message-ID: <CAPDyKFpgvLdcmpFkhAm8vPNZruF9e6GT8wnhpLQYsG9L=h_5Cg@mail.gmail.com>
Subject: Re: [PATCH 0/2] mmc: mmci: add quirk property to add stm32 transfer mode
To:     Ludovic BARRE <ludovic.barre@st.com>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        DTML <devicetree@vger.kernel.org>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Feb 2019 at 11:49, Ludovic BARRE <ludovic.barre@st.com> wrote:
>
> hi Russell & Ulf
>
> On 2/21/19 3:03 PM, Russell King - ARM Linux admin wrote:
> > On Thu, Feb 21, 2019 at 02:38:36PM +0100, Ludovic BARRE wrote:
> >> hi Russell & Ulf
> >>
> >> On 2/21/19 11:30 AM, Russell King - ARM Linux admin wrote:
> >>> On Thu, Feb 21, 2019 at 10:27:39AM +0000, Russell King - ARM Linux admin wrote:
> >>>> On Thu, Feb 21, 2019 at 11:10:49AM +0100, Ludovic Barre wrote:
> >>>>> From: Ludovic Barre <ludovic.barre@st.com>
> >>>>>
> >>>>> This patch series introduces a bitmap of hardware quirks that require
> >>>>> some special action. This should reduce the number of boolean
> >>>>> into variant structure.
> >>>>> And adds quirk bit to define sdmmc specific transfer modes.
> >>>>
> >>>> Please find some other way to deal with these differences.  As far as
> >>>> I'm concerned, introducing a quirk bitmask such as what was done in
> >>>> sdhci is a complete disaster and leads to long-term maintanability
> >>>> problems.
> >>>>
> >>>> We already have a way to deal with variants in mmci.
> >>>
> >>> ... to finish what I was saying ...
> >>>
> >>> and I think that:
> >>>
> >>>           if (variant->blksz_datactrl16)
> >>>                   datactrl = variant->datactrl_dpsm_enable | (data->blksz << 16);
> >>>           else if (variant->blksz_datactrl4)
> >>>                   datactrl = variant->datactrl_dpsm_enable | (data->blksz << 4);
> >>>           else
> >>>                   datactrl = variant->datactrl_dpsm_enable | blksz_bits << 4;
> >>>
> >>> ought to become a variant function call which returns the appropriate
> >>> datactrl value.  This would shrink the amount of variant testing in this
> >>> path, and also means that going forward we aren't facing an endlessly
> >>> increasing number of tests here.
> >>
> >> For blksz_datactrl case:
> >> We could create an inline function for datactrl16 and blksz_datactrl4
> >> which returns the appropriate datactrl value (specific for ux500v2 and
> >> qcom). This function could be register in mmci_host_ops structure.
> >
> > Yes, this is what I'm proposing (except for the "inline" bit which
> > seems meaningless if it's called via the mmci_host_ops structure.)
> > I'm also proposing that it shouldn't just be the blksz that's
> > returned but anything that the variant needs to take account of,
> > including the stm transfer mode.
>
> Ulf, are you alright with this callback approach (just to be sure that
> every body is align, before send a patch)?

Go ahead, let's see how it looks!

>
> This mmci_host_ops callback could return datactrl config to
> start data (defined by variant).

Yes.

[...]

Kind regards
Uffe
