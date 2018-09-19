Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6459C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F9F92151B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:36:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ecKo10e/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F9F92151B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733031AbeISXPF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 19:15:05 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38567 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731569AbeISXPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 19:15:04 -0400
Received: by mail-pg1-f193.google.com with SMTP id t84-v6so3079582pgb.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 10:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FS4LNoQNOejsjU2YLeuxRCSertSWSrH+0u/9rG1/SU8=;
        b=ecKo10e/XteQ8g3fABMNr66cgHiierCYeSXQ/emei+jw5irFc698zKJkD85rN7Gn5s
         8DZ83XuT2aH8OZO4Klb/ndOSxqHNm/mtJsFji3/0uP3rVneVsjHgqvfWbPcStRG1SmQ3
         nVlHFPEHILkA8dsQ71nnleFi70ITdNrxJ2cRAo5/lz9YV7aJ4LVqtNaLNqqiYHxmKFnl
         39QKTwI3C5ahunXxOBdwjzbfUW/9zg0Je4PjH8mN+PKndvyr1+RnaLpLFPetZ+6kHBAf
         oEklTs2N8usO0OnaW4075aOwT+gsR7tU66eEo7F8fHHVRFk6QKUp7TxVmFc94/PxuRkR
         sxIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FS4LNoQNOejsjU2YLeuxRCSertSWSrH+0u/9rG1/SU8=;
        b=iTzrRUl3K4T5sEqDbdpfQ89S1JMU/myznh7YhmaJT0pQ1/seFOUP3oIbWEwuxuOP6b
         mOmDnBFh9CJ+0L2K1i34qidLMvpuoD9nHhejIKYnCBLpVbPucdGq0/JrB7KMK8/ImjzY
         NIC9qKE5es0EDl87vxWzpStcLYVGD8VMFo9o9ZzKTX9uFro8/4i4sSxDkGnhL8Idctm+
         NTk+PjxZMXiYwSkEh3RPlauDQjjnt3wA9v+72c+YqrOJbNU5RKAe88LAmaBrRteB/Wyt
         c3X1/GOxq+2ySts+53p1BmcNTIUVzxL/sY10jxUzKqYKVaX96mizeVSlF8nLh7D+xuBt
         WoLA==
X-Gm-Message-State: APzg51BDenf4VPIUebdSbyyL/4U0SScYcPkfPiLFOms2ylaMkzcsHafv
        W7OnNGY3oJIuRivPGSE21pifM/R1FnyJHOs7ZEsewA==
X-Google-Smtp-Source: ANB0VdbdS8+DdujKtNDgRwO1MCaQfWRVPKVZgIUrCB3nhQBqT7EOuCuq6fnhqUVEe4IIaKDlnxh4EfZJFUE96wArwTo=
X-Received: by 2002:a62:4b14:: with SMTP id y20-v6mr36915368pfa.93.1537378566577;
 Wed, 19 Sep 2018 10:36:06 -0700 (PDT)
MIME-Version: 1.0
References: <20180919053829.4858-1-natechancellor@gmail.com> <20180919102944.GA15014@e107981-ln.cambridge.arm.com>
In-Reply-To: <20180919102944.GA15014@e107981-ln.cambridge.arm.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 19 Sep 2018 10:35:55 -0700
Message-ID: <CAKwvOd=ughACX1DVPrk9N-qhe_ww4hCu3FkuDTVOq+MUEuGUbA@mail.gmail.com>
Subject: Re: [PATCH] PCI: kirin: Fix section mismatch warning
To:     lorenzo.pieralisi@arm.com
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        songxiaowei@hisilicon.com, wangbinghui@hisilicon.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 3:29 AM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> Xiaowei, Binghui,
>
> On Tue, Sep 18, 2018 at 10:38:29PM -0700, Nathan Chancellor wrote:
> > WARNING: vmlinux.o(.text+0x4758cc): Section mismatch in reference from
> > the function kirin_pcie_probe() to the function
> > .init.text:kirin_add_pcie_port()
> > The function kirin_pcie_probe() references
> > the function __init kirin_add_pcie_port().
> > This is often because kirin_pcie_probe lacks a __init
> > annotation or the annotation of kirin_add_pcie_port is wrong.
> >
> > Remove '__init' from kirin_add_pcie_port so there is no mismatch.
>
> I think that instead of removing __init section tag we should add
> it to kirin_pcie_probe().

A bunch of these functions have a single call site, with a mix of __init:

kirin_pcie_probe() ->
  kirin_add_pcie_port() ->  // __init
    kirin_pcie_add_msi()

But it looks like probe functions should be marked init:
$ cd drivers; grep -r __init | grep probe

seems to turn up quite a lot of *probe() functions that are marked __init.
https://www.tldp.org/LDP/lkmpg/2.4/html/x281.htm has more info, and
from reading that, it seems that it's a no-op for a module that's
marked loadable.

So I agree; __init should be added to kirin_pcie_probe(), but also
kirin_pcie_add_msi().  That way if the module is statically compiled
into the kernel image, these functions with a single call site get
cleaned up after init.

Nathan, would you mind sending a v2?

>
> Please let me know and ACK accordingly.
>
> Lorenzo
>
> > Fixes: fc5165db245a ("PCI: kirin: Add HiSilicon Kirin SoC PCIe controller driver")
> > Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-kirin.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
> > index 5352e0c3be82..9b599296205d 100644
> > --- a/drivers/pci/controller/dwc/pcie-kirin.c
> > +++ b/drivers/pci/controller/dwc/pcie-kirin.c
> > @@ -467,8 +467,8 @@ static int kirin_pcie_add_msi(struct dw_pcie *pci,
> >       return 0;
> >  }
> >
> > -static int __init kirin_add_pcie_port(struct dw_pcie *pci,
> > -                                   struct platform_device *pdev)
> > +static int kirin_add_pcie_port(struct dw_pcie *pci,
> > +                            struct platform_device *pdev)
> >  {
> >       int ret;
> >
> > --
> > 2.19.0
> >



-- 
Thanks,
~Nick Desaulniers
