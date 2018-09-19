Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E94DC46470
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 18:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0EDA208A3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 18:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cfcmi6nt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0EDA208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733264AbeITA1k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 20:27:40 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38345 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727676AbeITA1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 20:27:40 -0400
Received: by mail-ed1-f65.google.com with SMTP id h33-v6so5770884edb.5;
        Wed, 19 Sep 2018 11:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=G6x/LLN1YsqdA8+TWdoV+R4RP3EDGfHfQ+S7O0Tbsc4=;
        b=cfcmi6ntUbRqwkoAjtW37H6y2t/czfFgxNEoiGYO9fQYouFG1Qzf9OceGoaXdTtH9B
         Y7GsTMp/2UAdhENNzDF/Pe5otRZdbFdQeb0kY4BielkeZLxycjKAHTV7y6f36UiB9Sap
         yACFCkTKj2p6Ti+etnkW3X2FZRoHE7AowUNvncTF0p15HfkvbN75+d/tRTzw9XC6e7FN
         KWsj7ceRGF70wisvzBsHAXS11lv227aHFPDdFuuQ4g01jOvPLtIEMaJToVvObgy3FPD9
         uTonP5fmZBLVQqkVaYIMVXA2mCaJreeTazB3/8Zm3CZFOH+6C/C85VfBfCpp+SQORetV
         9kGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=G6x/LLN1YsqdA8+TWdoV+R4RP3EDGfHfQ+S7O0Tbsc4=;
        b=bfZTzzl4SpfVovn6Nn1jgzmj8V3d0tR2zwSGtZGLoi0W2HzRUHjVFglHBfk5Qkr468
         2el9iTe24aDCDRd7Ph/nP59lbWT/fO3AMOyDGjXoaycnlp15f78uoy3sds6sYOGJwRgc
         ovI9cUezks8X5iL1PWpGfOOZTM9v4DQQVKcmroONeJwr0WyM9yVhJ2D6b4pNFDSluWJF
         F/jJTreWwBZcEoiu/W6PzGb6y7sRXb0cg+4olz+P8vnf8tBiV5xvYf4TCJwmL0FtOXn0
         mIX//ssa45+dIflz2AQYtEB3024uVNNRdxYTIgxfe2cBBraX+6KwZPbHzTtkOBqjsZgA
         9x/w==
X-Gm-Message-State: APzg51D7gYuKIy0NWZbCrTluISf97nFaKOkRekTYOA9Zux41MWfCCWhf
        cAAvioetMZjv2agDa+bMz9tkgj2tXgaUoA==
X-Google-Smtp-Source: ANB0VdbnnTr6HhManT0LT6pl3ZLxz67hJuk60smY+SdDErm8008SDiOovnMc7bxC8CrBTrVgwCZ3Og==
X-Received: by 2002:a50:a105:: with SMTP id 5-v6mr59270356edj.186.1537382904326;
        Wed, 19 Sep 2018 11:48:24 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id g22-v6sm1658507edb.93.2018.09.19.11.48.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Sep 2018 11:48:23 -0700 (PDT)
Date:   Wed, 19 Sep 2018 11:48:21 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     lorenzo.pieralisi@arm.com, songxiaowei@hisilicon.com,
        wangbinghui@hisilicon.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] PCI: kirin: Fix section mismatch warning
Message-ID: <20180919184821.GA28548@flashbox>
References: <20180919053829.4858-1-natechancellor@gmail.com>
 <20180919102944.GA15014@e107981-ln.cambridge.arm.com>
 <CAKwvOd=ughACX1DVPrk9N-qhe_ww4hCu3FkuDTVOq+MUEuGUbA@mail.gmail.com>
 <20180919175849.GA8787@flashbox>
 <CAKwvOdkQGHvE4JgfwZ2Hvk0HowBFvTBWwBSpkVtKX4U4iBEg=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdkQGHvE4JgfwZ2Hvk0HowBFvTBWwBSpkVtKX4U4iBEg=w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 11:35:45AM -0700, Nick Desaulniers wrote:
> On Wed, Sep 19, 2018 at 10:58 AM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > On Wed, Sep 19, 2018 at 10:35:55AM -0700, Nick Desaulniers wrote:
> > > On Wed, Sep 19, 2018 at 3:29 AM Lorenzo Pieralisi
> > > <lorenzo.pieralisi@arm.com> wrote:
> > > >
> > > > Xiaowei, Binghui,
> > > >
> > > > On Tue, Sep 18, 2018 at 10:38:29PM -0700, Nathan Chancellor wrote:
> > > > > WARNING: vmlinux.o(.text+0x4758cc): Section mismatch in reference from
> > > > > the function kirin_pcie_probe() to the function
> > > > > .init.text:kirin_add_pcie_port()
> > > > > The function kirin_pcie_probe() references
> > > > > the function __init kirin_add_pcie_port().
> > > > > This is often because kirin_pcie_probe lacks a __init
> > > > > annotation or the annotation of kirin_add_pcie_port is wrong.
> > > > >
> > > > > Remove '__init' from kirin_add_pcie_port so there is no mismatch.
> > > >
> > > > I think that instead of removing __init section tag we should add
> > > > it to kirin_pcie_probe().
> > >
> > > A bunch of these functions have a single call site, with a mix of __init:
> > >
> > > kirin_pcie_probe() ->
> > >   kirin_add_pcie_port() ->  // __init
> > >     kirin_pcie_add_msi()
> > >
> > > But it looks like probe functions should be marked init:
> > > $ cd drivers; grep -r __init | grep probe
> > >
> > > seems to turn up quite a lot of *probe() functions that are marked __init.
> > > https://www.tldp.org/LDP/lkmpg/2.4/html/x281.htm has more info, and
> > > from reading that, it seems that it's a no-op for a module that's
> > > marked loadable.
> > >
> > > So I agree; __init should be added to kirin_pcie_probe(), but also
> > > kirin_pcie_add_msi().  That way if the module is statically compiled
> > > into the kernel image, these functions with a single call site get
> > > cleaned up after init.
> > >
> > > Nathan, would you mind sending a v2?
> > >
> >
> > Hi Nick and Lorenzo,
> >
> > I had tested adding __init to both kirin_pcie_probe and
> > kirin_pcie_add_msi but ran into this warning:
> >
> > WARNING: vmlinux.o(.data+0x68b78): Section mismatch in reference from
> > the variable kirin_pcie_driver to the function
> 
> I think we want builtin_platform_driver_probe() here.
> 
> Try removing the probe reference from the declaration of
> kirin_pcie_driver, and then calling
> 
> builtin_platform_driver_probe(kirin_pcie_driver, kirin_pcie_probe);
> 
> Does that fix the section mismatches, while keeping as much in __init
> as possible?
> 

Hi Nick,

Thank you for that suggestion, it worked. I will send a v2 for review
shortly.

Nathan

> > .init.text:kirin_pcie_probe()
> > The variable kirin_pcie_driver references
> > the function __init kirin_pcie_probe()
> >
> > Doing a quick 'grep -r __init | grep platform_driver' doesn't show any
> > 'static struct platform_driver' constructs marked as __init, leading me
> > to believe this patch is the proper solution.
> >
> > I'm happy to hear otherwise, thank you both for the quick responses,
> > Nathan
> >
> > > >
> > > > Please let me know and ACK accordingly.
> > > >
> > > > Lorenzo
> > > >
> > > > > Fixes: fc5165db245a ("PCI: kirin: Add HiSilicon Kirin SoC PCIe controller driver")
> > > > > Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> > > > > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > > > > ---
> > > > >  drivers/pci/controller/dwc/pcie-kirin.c | 4 ++--
> > > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
> > > > > index 5352e0c3be82..9b599296205d 100644
> > > > > --- a/drivers/pci/controller/dwc/pcie-kirin.c
> > > > > +++ b/drivers/pci/controller/dwc/pcie-kirin.c
> > > > > @@ -467,8 +467,8 @@ static int kirin_pcie_add_msi(struct dw_pcie *pci,
> > > > >       return 0;
> > > > >  }
> > > > >
> > > > > -static int __init kirin_add_pcie_port(struct dw_pcie *pci,
> > > > > -                                   struct platform_device *pdev)
> > > > > +static int kirin_add_pcie_port(struct dw_pcie *pci,
> > > > > +                            struct platform_device *pdev)
> > > > >  {
> > > > >       int ret;
> > > > >
> > > > > --
> > > > > 2.19.0
> > > > >
> > >
> > >
> > >
> > > --
> > > Thanks,
> > > ~Nick Desaulniers
> 
> 
> 
> -- 
> Thanks,
> ~Nick Desaulniers
