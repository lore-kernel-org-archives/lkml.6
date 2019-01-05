Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB4CC43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 05:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 214AD21871
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 05:44:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fOd706r/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbfAEFoc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 00:44:32 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36496 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfAEFob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 00:44:31 -0500
Received: by mail-wm1-f65.google.com with SMTP id p6so2981496wmc.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 21:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qGN+3vpWjUhqJoVW7kaSfLcvtprajU9oaP5dcduMWn0=;
        b=fOd706r/HS9aIVkNrKrtId+sQ9TPWdwUvgL6sXqVtlpAaJBsc+YYf1mQA4nQxMDSlH
         HtIVXK+nBIQ7vrPFYwB9SoDICcNb5l09oqLP0squrFkA5QUlsMiBAHmEPCvWaUl8Mpqr
         JtmnkFy5Z855f3yY2voHwDEpIHxo4vXh5Pehc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qGN+3vpWjUhqJoVW7kaSfLcvtprajU9oaP5dcduMWn0=;
        b=QA6/9gTsSfclCkC9nw3eWajDnfY7qcSIPvQwXQRzf5+zbbk2Y+BhOAD/TGDxyX/IEZ
         yZX/TRvJwM63xg5xvInXuDi4xneUcUX2Kg5LRWiML5TKdaGStmwX838NlpRk5tof4+/+
         N6agj1k1do3bjaHOzsekOddgxI6fCwkN6fZk0hcc8V5bmDID8SVSyn/zhVkck+7+7niq
         ttga1qHCYQhUcI2SwqC/z2XjnnMMe7+GdDESRAxFKRsf4b3Odg9rOX8n0rpF6R7fY1Y/
         uVLIrpWOnLkU/DfUupKLpIusqC9bWc73OWbKasmlCpIF47uaeTHgotCQuvyCjGIFaxhk
         YkpA==
X-Gm-Message-State: AJcUukeVKJXzlFwe5Y6HGTyj3TfPoesSigARah3H+TLB7CiPnleCbSjV
        stJhQqJMxnYWU345xXu1360nPb8mck57w6cxB7coXA==
X-Google-Smtp-Source: ALg8bN7tQ7HDSSdwGuwbbsaBI6tgyIDR9QHrsUt/OWp7LoShjo0pUwtD7GlbbQ+1pZcrj3KDOCORr3HvP2Aq5MCxrjI=
X-Received: by 2002:a1c:a68f:: with SMTP id p137mr1494107wme.64.1546667069746;
 Fri, 04 Jan 2019 21:44:29 -0800 (PST)
MIME-Version: 1.0
References: <1546635388-13795-1-git-send-email-john.stultz@linaro.org>
 <1546635388-13795-4-git-send-email-john.stultz@linaro.org>
 <20190105034157.GB2477@Mani-XPS-13-9360> <CALAqxLUAA95PBiSGrVNWkJT8r4GQQDRU9Q1LE=uFQLsDEeLZwA@mail.gmail.com>
 <20190105053908.GB3761@Mani-XPS-13-9360>
In-Reply-To: <20190105053908.GB3761@Mani-XPS-13-9360>
From:   John Stultz <john.stultz@linaro.org>
Date:   Fri, 4 Jan 2019 21:44:17 -0800
Message-ID: <CALAqxLV35NGGR4xZ-yvqLDuEqzhKTBvjAjBU+xBnyiGSAycW7Q@mail.gmail.com>
Subject: Re: [PATCH 3/8 v2] dma: k3dma: Upgrade k3dma driver to support
 hisi_asp_dma hardware
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Youlin Wang <wwx575822@notesmail.huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Zhuangluan Su <suzhuangluan@hisilicon.com>,
        Ryan Grachek <ryan@edited.us>, dmaengine@vger.kernel.org,
        Tanglei Han <hantanglei@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 4, 2019 at 9:39 PM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Fri, Jan 04, 2019 at 09:22:46PM -0800, John Stultz wrote:
> > On Fri, Jan 4, 2019 at 7:42 PM Manivannan Sadhasivam
> > <manivannan.sadhasivam@linaro.org> wrote:
> > > On Fri, Jan 04, 2019 at 12:56:23PM -0800, John Stultz wrote:
> > > > From: Youlin Wang <wwx575822@notesmail.huawei.com>
> > > >
> > > > There is an new "hisi-pcm-asp-dma-1.0" device added in
> > > > "arch/arm64/boot/dts/hisilicon/hi3660.dtsi".
> > > > So we have to add a matching id in the driver file:
> > > >  .compatible = "hisilicon,hisi-pcm-asp-dma-1.0"
> > > >
> > > > And also hisi-pcm-asp dma device needs no setting to the clock.
> > > > So we skip this by adding and using soc data flags.
> > > >
> > > > After above this driver will support both k3 and hisi_asp dma hardware.
> > > >
> > >
> > > Small description about the hardware (ASP DMAC) would be really helpful.
> >
> > I've taken a shot at this (along with integrating your other feedback
> > - thanks again for the review!), though as I don't have direct
> > documentation, my knowledge is a bit second hand.
> >
> > See here:
> > https://git.linaro.org/people/john.stultz/android-dev.git/commit/?h=dev/hikey960-mainline-WIP&id=754a79facf1af0b59a7f8fd63050da12ebf5521e
> >
> > Let me know if you have suggestions for more specific changes!
>
> Description looks good to me. But looks like you are not protecting the
> other clk APIs like clk_prepare_enable and clk_disable_unprepare. Don't
> they fail when the relevant clk is not found?

No, those calls just return 0 if null clock is passed

int clk_prepare(struct clk *clk)
{
        if (!clk)
                return 0;
...

thanks
-john
