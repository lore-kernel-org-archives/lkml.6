Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4EC4C43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 05:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81D3221871
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 05:48:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AGxP6l/d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbfAEFsv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 00:48:51 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43647 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbfAEFsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 00:48:51 -0500
Received: by mail-pl1-f195.google.com with SMTP id gn14so18358248plb.10
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 21:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uexfj1ba8Xi/nr2rflBkPgGs4lOY5h+6bj3ePDdch0A=;
        b=AGxP6l/duiK0YVI/uZxwLS9EDrsszKH0A2nwv2jgiPO8lPQ1G+htsPumxrSteylSgq
         LEKWSIiqiXDiikbt+/EoFxh8VMWAicEkc9/s3An4ST6wWMsKk6J5+vp262Za81KEmVoF
         1pyUdegPJyPavirjZqOK4PGs/eHKy0TDg6At4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uexfj1ba8Xi/nr2rflBkPgGs4lOY5h+6bj3ePDdch0A=;
        b=M2pqn0/DRJGNNFupYlWQ4zKnHjPcUDgaCVqgqQdIfqW9tw1ssN9LuBlQQC0u8Ue79n
         tOJ5mVysixp/O7cFFJh/ylCP9gMbseu66MkCP9ecBJ+gp5tJSu9NXRBYWsaUuDUu6kUn
         H69eGN+8yMiGSoVX72A6g7tJxgClBosLLPQzPpnlyoHbTJeM9mlCDPDVN0y/S4abetuD
         BNj4JeOD0dGdBcbZJNBrN+VieVQ+6ip8zfIyv/DUd/aCeC29YdxRjUIMuR/j4oSFEdGL
         0tjQDoYAXsHQDmtayrtwXKbq+rnHScTKBjoYGtCa3w4IvZhrtTpZZoz0cWhbsUGir9Ow
         alnA==
X-Gm-Message-State: AJcUukeTu+FBsP7IIXHpj4iOqBmIm7B/IxSD2iNlaPJv7xYjZrPR+dJP
        Yj/sn7WhbVh73URuXiUWnFiR
X-Google-Smtp-Source: ALg8bN5q9RYkhx2bUKUUZpchdmeDxN4m2X4feq+D3MAQLGqvWERZeHdqrkEPOnTbwFFTQSiaDkNfZQ==
X-Received: by 2002:a17:902:112c:: with SMTP id d41mr51725229pla.144.1546667330139;
        Fri, 04 Jan 2019 21:48:50 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2405:204:72cb:a88d:406c:3ac8:e78f:4779])
        by smtp.gmail.com with ESMTPSA id b10sm90435115pfj.183.2019.01.04.21.48.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Jan 2019 21:48:49 -0800 (PST)
Date:   Sat, 5 Jan 2019 11:18:41 +0530
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
Message-ID: <20190105054841.GC3761@Mani-XPS-13-9360>
References: <1546635388-13795-1-git-send-email-john.stultz@linaro.org>
 <1546635388-13795-4-git-send-email-john.stultz@linaro.org>
 <20190105034157.GB2477@Mani-XPS-13-9360>
 <CALAqxLUAA95PBiSGrVNWkJT8r4GQQDRU9Q1LE=uFQLsDEeLZwA@mail.gmail.com>
 <20190105053908.GB3761@Mani-XPS-13-9360>
 <CALAqxLV35NGGR4xZ-yvqLDuEqzhKTBvjAjBU+xBnyiGSAycW7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALAqxLV35NGGR4xZ-yvqLDuEqzhKTBvjAjBU+xBnyiGSAycW7Q@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 04, 2019 at 09:44:17PM -0800, John Stultz wrote:
> On Fri, Jan 4, 2019 at 9:39 PM Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > On Fri, Jan 04, 2019 at 09:22:46PM -0800, John Stultz wrote:
> > > On Fri, Jan 4, 2019 at 7:42 PM Manivannan Sadhasivam
> > > <manivannan.sadhasivam@linaro.org> wrote:
> > > > On Fri, Jan 04, 2019 at 12:56:23PM -0800, John Stultz wrote:
> > > > > From: Youlin Wang <wwx575822@notesmail.huawei.com>
> > > > >
> > > > > There is an new "hisi-pcm-asp-dma-1.0" device added in
> > > > > "arch/arm64/boot/dts/hisilicon/hi3660.dtsi".
> > > > > So we have to add a matching id in the driver file:
> > > > >  .compatible = "hisilicon,hisi-pcm-asp-dma-1.0"
> > > > >
> > > > > And also hisi-pcm-asp dma device needs no setting to the clock.
> > > > > So we skip this by adding and using soc data flags.
> > > > >
> > > > > After above this driver will support both k3 and hisi_asp dma hardware.
> > > > >
> > > >
> > > > Small description about the hardware (ASP DMAC) would be really helpful.
> > >
> > > I've taken a shot at this (along with integrating your other feedback
> > > - thanks again for the review!), though as I don't have direct
> > > documentation, my knowledge is a bit second hand.
> > >
> > > See here:
> > > https://git.linaro.org/people/john.stultz/android-dev.git/commit/?h=dev/hikey960-mainline-WIP&id=754a79facf1af0b59a7f8fd63050da12ebf5521e
> > >
> > > Let me know if you have suggestions for more specific changes!
> >
> > Description looks good to me. But looks like you are not protecting the
> > other clk APIs like clk_prepare_enable and clk_disable_unprepare. Don't
> > they fail when the relevant clk is not found?
> 
> No, those calls just return 0 if null clock is passed
> 
> int clk_prepare(struct clk *clk)
> {
>         if (!clk)
>                 return 0;
> ...

Ah, okay. Didn't look into the definition.

So with the change in description,

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> 
> thanks
> -john
