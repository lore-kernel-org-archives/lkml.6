Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C98C43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 05:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55DDA21874
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 05:39:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hqQg+IJQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbfAEFjT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 00:39:19 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33143 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbfAEFjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 00:39:18 -0500
Received: by mail-pf1-f194.google.com with SMTP id c123so19261791pfb.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 21:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=B6KWiSiMK9B/ZVkqsyxUzHtljP5vR0FEx3PiJ+4kYYc=;
        b=hqQg+IJQ3Hbym4dFaTULCHfxymZyMi4hG3TEzBIC3SktMcB1fC5CVw8ue21yZGEHLw
         pBbDI7RQHX236tp2/sL+iI15bXWBw8kdZt5JM951AXsToH2LGNJJXfKe3iGzjvVUvwHL
         5aV/51k2/iD76I/6RgxkibdJEvgrf/35QnfPc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=B6KWiSiMK9B/ZVkqsyxUzHtljP5vR0FEx3PiJ+4kYYc=;
        b=RCACMf3Z2YPRlAS3uE+95CsvjJ50nXqI0C4cWRiQVLYkBdN7opAoJmXnE+wrEdJIA2
         VlNHfkG6Ga8cVtB4hEiCHMUmz0w0AbtQDgLiwf93iU/RXN/ZeqnuUGGqtGv6nBXW/dTp
         h7TwjUlpO/eOiQdOmU58rHHjCE/7Kfh++eLd9XUp3c82B9DjEWX9xSwqT8yE9Lv9qwGG
         jGAKXhJuMF0tr6ccFs6GoKWw6RdiiX3DNIfa4qJLAi647diU4SqOgKju/pLf9MXjswlv
         xPSxp3+wqQZcUk3q4evG/2ck6zMEsSR680XmxODulF6iTjvuYVX8DqHRefZjCdC7Z6aP
         2qkQ==
X-Gm-Message-State: AJcUukcbRmMbbfTWBwI7Xk/c7Yho0eUbTkp2q2x7tleb/XcU5AKuaSOR
        e63rEGLpSsszKVpfOKcmbhJF
X-Google-Smtp-Source: ALg8bN6Hn+PlYoxR71fNDKoPJK2sP0pZaL3jGZ12cgpAsNzBx8uXgXdLkPBV3y4kz7P4wybSRrl8fQ==
X-Received: by 2002:a63:5f88:: with SMTP id t130mr23199415pgb.395.1546666757679;
        Fri, 04 Jan 2019 21:39:17 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2405:204:72cb:a88d:406c:3ac8:e78f:4779])
        by smtp.gmail.com with ESMTPSA id g28sm103613994pfd.100.2019.01.04.21.39.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Jan 2019 21:39:16 -0800 (PST)
Date:   Sat, 5 Jan 2019 11:09:08 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Youlin Wang <wwx575822@notesmail.huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Zhuangluan Su <suzhuangluan@hisilicon.com>,
        Ryan Grachek <ryan@edited.us>, dmaengine@vger.kernel.org,
        Tanglei Han <hantanglei@huawei.com>
Subject: Re: [PATCH 3/8 v2] dma: k3dma: Upgrade k3dma driver to support
 hisi_asp_dma hardware
Message-ID: <20190105053908.GB3761@Mani-XPS-13-9360>
References: <1546635388-13795-1-git-send-email-john.stultz@linaro.org>
 <1546635388-13795-4-git-send-email-john.stultz@linaro.org>
 <20190105034157.GB2477@Mani-XPS-13-9360>
 <CALAqxLUAA95PBiSGrVNWkJT8r4GQQDRU9Q1LE=uFQLsDEeLZwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALAqxLUAA95PBiSGrVNWkJT8r4GQQDRU9Q1LE=uFQLsDEeLZwA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 04, 2019 at 09:22:46PM -0800, John Stultz wrote:
> On Fri, Jan 4, 2019 at 7:42 PM Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> > On Fri, Jan 04, 2019 at 12:56:23PM -0800, John Stultz wrote:
> > > From: Youlin Wang <wwx575822@notesmail.huawei.com>
> > >
> > > There is an new "hisi-pcm-asp-dma-1.0" device added in
> > > "arch/arm64/boot/dts/hisilicon/hi3660.dtsi".
> > > So we have to add a matching id in the driver file:
> > >  .compatible = "hisilicon,hisi-pcm-asp-dma-1.0"
> > >
> > > And also hisi-pcm-asp dma device needs no setting to the clock.
> > > So we skip this by adding and using soc data flags.
> > >
> > > After above this driver will support both k3 and hisi_asp dma hardware.
> > >
> >
> > Small description about the hardware (ASP DMAC) would be really helpful.
> 
> I've taken a shot at this (along with integrating your other feedback
> - thanks again for the review!), though as I don't have direct
> documentation, my knowledge is a bit second hand.
> 
> See here:
> https://git.linaro.org/people/john.stultz/android-dev.git/commit/?h=dev/hikey960-mainline-WIP&id=754a79facf1af0b59a7f8fd63050da12ebf5521e
> 
> Let me know if you have suggestions for more specific changes!

Description looks good to me. But looks like you are not protecting the
other clk APIs like clk_prepare_enable and clk_disable_unprepare. Don't
they fail when the relevant clk is not found?

Thanks,
Mani

> thanks
> -john
