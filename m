Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC38DECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 18:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64FC4208A3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 18:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FhHHpTs+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64FC4208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733126AbeITAPH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 20:15:07 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41891 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731253AbeITAPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 20:15:07 -0400
Received: by mail-pg1-f193.google.com with SMTP id s15-v6so3149428pgv.8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 11:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QK0fSJ9W1CsbaEjWiJzh+XXQd6y2ykltB+2jjetf5xU=;
        b=FhHHpTs+7+hMtcEkjRJ3f7P0CNg5ITLfhEJnbT7ks7yJgCY3X34q0WTD7PipKH8QDm
         NnONnI9YruyDIWkCWa6Qo2H4B7+denrlSbc/7mV8rD7fHAy++HmPVbLD+gQ0wheNw85f
         0sURi6gM2q3witmt6m1l32Rr0BhpLCLfiAXOj7Ksesu1mKM5UnzBNQDT9NGJqHF4A5Jb
         pgM2/0sCmB3OKeh/43dIOU5CYqzhKc2a0M7tjjsKzpEiHW1fUi/IK3gbTtqKSn51I3BO
         EB0bT7A/6GUVA0XKJqPMhiFRLnEHcywdWojkZnnSa+XLmifJyXHE9HNtwpasPAtEaRGX
         HqaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QK0fSJ9W1CsbaEjWiJzh+XXQd6y2ykltB+2jjetf5xU=;
        b=YoykyQbrOulpnrQvwOoud/qa/1QPGRRCIu8uqvENtQTCH2ksQDQ97gPtwSnNviUZ2U
         os5CkwjW7i7T/qumvw+o9prmcdOdnS82mFTUTJLVZ9DGW/239t7cbjD3WogkydOk+dbC
         bwFK81Df8xTuh3BNK+KFAli8t09DMA4yT0vh3NOHW9VB33KFeDBrDJ9jW8ZnBEqCT1e3
         DP59LbCGsyAedjHttCdVQ5H6Mdy0uLnt1poZ3BjiW1tekiJbfbbX2HF4L9/BGp3oy631
         ZpK1L6vCZRu/khJQykerQQUIJNHrCI1i5XnRMzM0p26xmSFtPYKAq2aM6SSxhZNCbrQE
         56lQ==
X-Gm-Message-State: APzg51DF+UL/mVpcWB7bkSQMg2dE8DXUI3+uaLWWCeGhpx+AklFxJlmf
        UyppuCNzJLq2zJNozCbOa2pgCYPVbwauT4XDFFkYbQ==
X-Google-Smtp-Source: ANB0VdYaBOYYW381G5pf0iE7ujpph5SZBXHhd9iZLqUbOMov+jm7HhisOKr3815gQK4x+MmAF5XJSTSebdVRPBVei4M=
X-Received: by 2002:a63:2605:: with SMTP id m5-v6mr32138366pgm.225.1537382156482;
 Wed, 19 Sep 2018 11:35:56 -0700 (PDT)
MIME-Version: 1.0
References: <20180919053829.4858-1-natechancellor@gmail.com>
 <20180919102944.GA15014@e107981-ln.cambridge.arm.com> <CAKwvOd=ughACX1DVPrk9N-qhe_ww4hCu3FkuDTVOq+MUEuGUbA@mail.gmail.com>
 <20180919175849.GA8787@flashbox>
In-Reply-To: <20180919175849.GA8787@flashbox>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 19 Sep 2018 11:35:45 -0700
Message-ID: <CAKwvOdkQGHvE4JgfwZ2Hvk0HowBFvTBWwBSpkVtKX4U4iBEg=w@mail.gmail.com>
Subject: Re: [PATCH] PCI: kirin: Fix section mismatch warning
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     lorenzo.pieralisi@arm.com, songxiaowei@hisilicon.com,
        wangbinghui@hisilicon.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 10:58 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Wed, Sep 19, 2018 at 10:35:55AM -0700, Nick Desaulniers wrote:
> > On Wed, Sep 19, 2018 at 3:29 AM Lorenzo Pieralisi
> > <lorenzo.pieralisi@arm.com> wrote:
> > >
> > > Xiaowei, Binghui,
> > >
> > > On Tue, Sep 18, 2018 at 10:38:29PM -0700, Nathan Chancellor wrote:
> > > > WARNING: vmlinux.o(.text+0x4758cc): Section mismatch in reference from
> > > > the function kirin_pcie_probe() to the function
> > > > .init.text:kirin_add_pcie_port()
> > > > The function kirin_pcie_probe() references
> > > > the function __init kirin_add_pcie_port().
> > > > This is often because kirin_pcie_probe lacks a __init
> > > > annotation or the annotation of kirin_add_pcie_port is wrong.
> > > >
> > > > Remove '__init' from kirin_add_pcie_port so there is no mismatch.
> > >
> > > I think that instead of removing __init section tag we should add
> > > it to kirin_pcie_probe().
> >
> > A bunch of these functions have a single call site, with a mix of __init:
> >
> > kirin_pcie_probe() ->
> >   kirin_add_pcie_port() ->  // __init
> >     kirin_pcie_add_msi()
> >
> > But it looks like probe functions should be marked init:
> > $ cd drivers; grep -r __init | grep probe
> >
> > seems to turn up quite a lot of *probe() functions that are marked __init.
> > https://www.tldp.org/LDP/lkmpg/2.4/html/x281.htm has more info, and
> > from reading that, it seems that it's a no-op for a module that's
> > marked loadable.
> >
> > So I agree; __init should be added to kirin_pcie_probe(), but also
> > kirin_pcie_add_msi().  That way if the module is statically compiled
> > into the kernel image, these functions with a single call site get
> > cleaned up after init.
> >
> > Nathan, would you mind sending a v2?
> >
>
> Hi Nick and Lorenzo,
>
> I had tested adding __init to both kirin_pcie_probe and
> kirin_pcie_add_msi but ran into this warning:
>
> WARNING: vmlinux.o(.data+0x68b78): Section mismatch in reference from
> the variable kirin_pcie_driver to the function

I think we want builtin_platform_driver_probe() here.

Try removing the probe reference from the declaration of
kirin_pcie_driver, and then calling

builtin_platform_driver_probe(kirin_pcie_driver, kirin_pcie_probe);

Does that fix the section mismatches, while keeping as much in __init
as possible?

> .init.text:kirin_pcie_probe()
> The variable kirin_pcie_driver references
> the function __init kirin_pcie_probe()
>
> Doing a quick 'grep -r __init | grep platform_driver' doesn't show any
> 'static struct platform_driver' constructs marked as __init, leading me
> to believe this patch is the proper solution.
>
> I'm happy to hear otherwise, thank you both for the quick responses,
> Nathan
>
> > >
> > > Please let me know and ACK accordingly.
> > >
> > > Lorenzo
> > >
> > > > Fixes: fc5165db245a ("PCI: kirin: Add HiSilicon Kirin SoC PCIe controller driver")
> > > > Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> > > > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > > > ---
> > > >  drivers/pci/controller/dwc/pcie-kirin.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
> > > > index 5352e0c3be82..9b599296205d 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-kirin.c
> > > > +++ b/drivers/pci/controller/dwc/pcie-kirin.c
> > > > @@ -467,8 +467,8 @@ static int kirin_pcie_add_msi(struct dw_pcie *pci,
> > > >       return 0;
> > > >  }
> > > >
> > > > -static int __init kirin_add_pcie_port(struct dw_pcie *pci,
> > > > -                                   struct platform_device *pdev)
> > > > +static int kirin_add_pcie_port(struct dw_pcie *pci,
> > > > +                            struct platform_device *pdev)
> > > >  {
> > > >       int ret;
> > > >
> > > > --
> > > > 2.19.0
> > > >
> >
> >
> >
> > --
> > Thanks,
> > ~Nick Desaulniers



-- 
Thanks,
~Nick Desaulniers
