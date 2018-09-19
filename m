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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56357C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EB532150F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="edWNwUCM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EB532150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731881AbeISXh4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 19:37:56 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37481 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbeISXh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 19:37:56 -0400
Received: by mail-wm1-f68.google.com with SMTP id n11-v6so7968670wmc.2;
        Wed, 19 Sep 2018 10:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+h1S5CYak0cUW/1wPfDiNabftNkxM+hmCkdRBrkRjJU=;
        b=edWNwUCMaYAN5ouQEodmu53C0NVk2B3vVgcnnm9uUDgplQZJ5Nhx75FbF2iPcO29Y+
         QdYLw9Pfk7OvyIAtcvlwg3PVTzJIne2p8Is2N73lvMPD9EB3s5QV1SwQ974PyMWfoXog
         0CbVSc2mNDu+ECKqTrBRPU6Qr2tCnPiz/Geg+reGjBXYVdWj+lM/Q5ckpREq86heygDh
         C/53urRc4PKZ3DY1/87L0B+LZXlknwL7+47UPqeVahQldC7hFQLK+VwmO0V2ocJQ2jxW
         m2LWem4h+nSVjP4iUEY9dtisTK3yPf1FfTOvZRlAOC8c1fprdX2f4Jo08W/8g0HDS+lg
         2faQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+h1S5CYak0cUW/1wPfDiNabftNkxM+hmCkdRBrkRjJU=;
        b=IIo+GmwjV0uOf+OWzktH7XPp8cXyHldWV1oTxuIcPYelVXaD0Lk0Wnv8PMCHkSZUl/
         13BlsPnNOfzaqSxh0b0tU3X91VAaH9mJSBA5JfHU4ykIKKQwVeh9LTMvXGnnSg5bWNVB
         3SpzSHi+43Zs2O4qYel/JED3pmTNpm/u0anrg0pLeYJzASRtv8a8oUMSoGmo8BrKxlYS
         CFhoHojr8ATcV+ykUYDuuQr0szgloEw8FP99JORhQlG5V1FP7mLIvUFfjv/yuUz+N9ie
         eDBjEKhbzWQumXx7NceL6MObZCFsD2afdwRA/cIK8ots96OLp7oqB1FEzDYqkEyHKCOx
         /MSA==
X-Gm-Message-State: APzg51DA5WvpVXz1nsrLKoQ3pDVb+DY2nxyScHql0E/d0tjT54DHNq69
        UgxeiJyx+1hVx7QUt3uX050=
X-Google-Smtp-Source: ANB0VdaaJuiwgxpl2Zu+WjuxS5DfR6WYoDlGBRM3IR9mP1nqvqDIrETxRoiC6JLGYJRy/7mtiMCpHQ==
X-Received: by 2002:a1c:dac9:: with SMTP id r192-v6mr22269081wmg.141.1537379932132;
        Wed, 19 Sep 2018 10:58:52 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id a11-v6sm21044142wrr.81.2018.09.19.10.58.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Sep 2018 10:58:51 -0700 (PDT)
Date:   Wed, 19 Sep 2018 10:58:49 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     lorenzo.pieralisi@arm.com, songxiaowei@hisilicon.com,
        wangbinghui@hisilicon.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] PCI: kirin: Fix section mismatch warning
Message-ID: <20180919175849.GA8787@flashbox>
References: <20180919053829.4858-1-natechancellor@gmail.com>
 <20180919102944.GA15014@e107981-ln.cambridge.arm.com>
 <CAKwvOd=ughACX1DVPrk9N-qhe_ww4hCu3FkuDTVOq+MUEuGUbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOd=ughACX1DVPrk9N-qhe_ww4hCu3FkuDTVOq+MUEuGUbA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 10:35:55AM -0700, Nick Desaulniers wrote:
> On Wed, Sep 19, 2018 at 3:29 AM Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com> wrote:
> >
> > Xiaowei, Binghui,
> >
> > On Tue, Sep 18, 2018 at 10:38:29PM -0700, Nathan Chancellor wrote:
> > > WARNING: vmlinux.o(.text+0x4758cc): Section mismatch in reference from
> > > the function kirin_pcie_probe() to the function
> > > .init.text:kirin_add_pcie_port()
> > > The function kirin_pcie_probe() references
> > > the function __init kirin_add_pcie_port().
> > > This is often because kirin_pcie_probe lacks a __init
> > > annotation or the annotation of kirin_add_pcie_port is wrong.
> > >
> > > Remove '__init' from kirin_add_pcie_port so there is no mismatch.
> >
> > I think that instead of removing __init section tag we should add
> > it to kirin_pcie_probe().
> 
> A bunch of these functions have a single call site, with a mix of __init:
> 
> kirin_pcie_probe() ->
>   kirin_add_pcie_port() ->  // __init
>     kirin_pcie_add_msi()
> 
> But it looks like probe functions should be marked init:
> $ cd drivers; grep -r __init | grep probe
> 
> seems to turn up quite a lot of *probe() functions that are marked __init.
> https://www.tldp.org/LDP/lkmpg/2.4/html/x281.htm has more info, and
> from reading that, it seems that it's a no-op for a module that's
> marked loadable.
> 
> So I agree; __init should be added to kirin_pcie_probe(), but also
> kirin_pcie_add_msi().  That way if the module is statically compiled
> into the kernel image, these functions with a single call site get
> cleaned up after init.
> 
> Nathan, would you mind sending a v2?
> 

Hi Nick and Lorenzo,

I had tested adding __init to both kirin_pcie_probe and
kirin_pcie_add_msi but ran into this warning:

WARNING: vmlinux.o(.data+0x68b78): Section mismatch in reference from
the variable kirin_pcie_driver to the function
.init.text:kirin_pcie_probe()
The variable kirin_pcie_driver references                      
the function __init kirin_pcie_probe()

Doing a quick 'grep -r __init | grep platform_driver' doesn't show any
'static struct platform_driver' constructs marked as __init, leading me
to believe this patch is the proper solution.

I'm happy to hear otherwise, thank you both for the quick responses,
Nathan

> >
> > Please let me know and ACK accordingly.
> >
> > Lorenzo
> >
> > > Fixes: fc5165db245a ("PCI: kirin: Add HiSilicon Kirin SoC PCIe controller driver")
> > > Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> > > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > > ---
> > >  drivers/pci/controller/dwc/pcie-kirin.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
> > > index 5352e0c3be82..9b599296205d 100644
> > > --- a/drivers/pci/controller/dwc/pcie-kirin.c
> > > +++ b/drivers/pci/controller/dwc/pcie-kirin.c
> > > @@ -467,8 +467,8 @@ static int kirin_pcie_add_msi(struct dw_pcie *pci,
> > >       return 0;
> > >  }
> > >
> > > -static int __init kirin_add_pcie_port(struct dw_pcie *pci,
> > > -                                   struct platform_device *pdev)
> > > +static int kirin_add_pcie_port(struct dw_pcie *pci,
> > > +                            struct platform_device *pdev)
> > >  {
> > >       int ret;
> > >
> > > --
> > > 2.19.0
> > >
> 
> 
> 
> -- 
> Thanks,
> ~Nick Desaulniers
