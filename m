Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35826C43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 05:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECF1A208E3
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 05:23:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vnx25x4u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbfAEFXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 00:23:01 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40441 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbfAEFXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 00:23:00 -0500
Received: by mail-wr1-f65.google.com with SMTP id p4so38285087wrt.7
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 21:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N01x2Vb4ssWwuVcAVvzxSfGxMwbwh0+4yfJln6JkK4w=;
        b=Vnx25x4uglmjQxVL0fQr6dZDwj4BX7bSs8sjjewbWAV5Xjk5l4GNlP/cp/lgmdsJa2
         CfBNVtCtk+KKtEPEdSxpHINTXQ0ry1FYo/oj8lLnOruLsrxv+1ZsUlrLtf1LG5q7QuIU
         mk7t4/AYjeQNOYuZI80oL+Jpx2xVVHbJeCnKA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N01x2Vb4ssWwuVcAVvzxSfGxMwbwh0+4yfJln6JkK4w=;
        b=EuRNmz9TW/EnAR+IOneMTXfUFbhpxHSXw32iHkwbP5JjBEREtp6Wl+J1Ecn64Im68T
         Mz8pwndtypA9kMOojJbylCF+WSMtf3o7/rPAXkwk9VWrCp+c+WhMmiuqKfCF4wbgyeOs
         twbrymhlBNNvh4WVfxZGwOi8HaROI/4ukMSWLJArhr5WY5wRQiiwb3MAJ6fm7WesrAh4
         M2UHHL+pRGItmpjRsKfbxDlcR7u4i4Q7cnrTDGkxgO7niY7eJO9QQApWxiaM0yr9LMrQ
         QfP4H8+sfluG49oWXUmCcP+Omxk2vQ456kouTtgaV6ZnXRRRQ1dTwPe5S0Ry4H0Pk+SB
         hjZg==
X-Gm-Message-State: AJcUukfmEx3jPQ8wIbgUorz7k4k4LFMBtm3QayblE/mYiInaPTAuTGjo
        3WKPzHs49rmpRETnoU+qrjlo6nn0gIusD7u+O+z4CQ==
X-Google-Smtp-Source: ALg8bN4eTSUMVa1QumkruTl+fZTI1E77V6yy8jleBN57itIWXKmFBEZK2DswC/eBms/TEkk1R5Dq7ZWqD0yUloKDBnQ=
X-Received: by 2002:a5d:4250:: with SMTP id s16mr47276043wrr.253.1546665778714;
 Fri, 04 Jan 2019 21:22:58 -0800 (PST)
MIME-Version: 1.0
References: <1546635388-13795-1-git-send-email-john.stultz@linaro.org>
 <1546635388-13795-4-git-send-email-john.stultz@linaro.org> <20190105034157.GB2477@Mani-XPS-13-9360>
In-Reply-To: <20190105034157.GB2477@Mani-XPS-13-9360>
From:   John Stultz <john.stultz@linaro.org>
Date:   Fri, 4 Jan 2019 21:22:46 -0800
Message-ID: <CALAqxLUAA95PBiSGrVNWkJT8r4GQQDRU9Q1LE=uFQLsDEeLZwA@mail.gmail.com>
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

On Fri, Jan 4, 2019 at 7:42 PM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
> On Fri, Jan 04, 2019 at 12:56:23PM -0800, John Stultz wrote:
> > From: Youlin Wang <wwx575822@notesmail.huawei.com>
> >
> > There is an new "hisi-pcm-asp-dma-1.0" device added in
> > "arch/arm64/boot/dts/hisilicon/hi3660.dtsi".
> > So we have to add a matching id in the driver file:
> >  .compatible = "hisilicon,hisi-pcm-asp-dma-1.0"
> >
> > And also hisi-pcm-asp dma device needs no setting to the clock.
> > So we skip this by adding and using soc data flags.
> >
> > After above this driver will support both k3 and hisi_asp dma hardware.
> >
>
> Small description about the hardware (ASP DMAC) would be really helpful.

I've taken a shot at this (along with integrating your other feedback
- thanks again for the review!), though as I don't have direct
documentation, my knowledge is a bit second hand.

See here:
https://git.linaro.org/people/john.stultz/android-dev.git/commit/?h=dev/hikey960-mainline-WIP&id=754a79facf1af0b59a7f8fd63050da12ebf5521e

Let me know if you have suggestions for more specific changes!
thanks
-john
