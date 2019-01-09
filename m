Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE16C43612
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 00:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8A1B20821
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 00:02:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="DJEWjO52"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729415AbfAIACS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 19:02:18 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:42679 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728112AbfAIACR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 19:02:17 -0500
Received: by mail-oi1-f195.google.com with SMTP id w13so4864316oiw.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 16:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HtCFKH6WaKZLZfxKQl817UpJfz065Vj+MgIv87PvbVg=;
        b=DJEWjO52Er7uAWcq5f9yaZGdclO5Coe/lpVRairTZyU8b58uNnjVA+bjFmNSVtOCiX
         dkDFvjSXa4q6aJsP198azW1ZT84oU7RH8lEhO/2S54zJHSB0W0YKmAm+GN8wjbVbWwFS
         W0pjsplZPZkCPUYRbKgC084WjvEIaaRUVtkAtVZFUCVKYBFr1WcBNk6eHu5U+/0O4kMo
         ry7Ja2dwnUEfnVyzh6RnZ9Em9pSav+8RkKuXtEQRuS/yjvvFlovN+O2YgC3acrk0KAH0
         V1RoySpjUbgdHjmp0tSVhErOs3y/l6Dbg8BRlFS3xqCWHG9vDRw3UCzAZDUncxWm13La
         x60A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HtCFKH6WaKZLZfxKQl817UpJfz065Vj+MgIv87PvbVg=;
        b=jSFzmodc/rmXcXpMGreft3i+JR+cpqWkQqHNL7A0UJjvDhHZdhmwz/d5oIZYdJEWmz
         eeZro8yPuk7mcrfNyy8BAdo4a/+PKPppAdo5d0wp6IRKojnyhZGbu2mWSE/fY8Tee2Jn
         esiZlGpw3B3BLZC9u0KB2qMLEK96bd/6NiRBXC44Ios+nkrjsaaitH/H1k9gbydm240g
         wdCxLA574wfA2xPXgtCBCnhdkjdK0lrw73YYKT31jY1CehivfbfLK+PDzGpVKP6hsSwJ
         7pdEo3mXlE0nF0k2nD0bXjpQA7H0J+2D6+BqgyhJJdtb57BskVv0gFX6PLGhdVurOOby
         NoYQ==
X-Gm-Message-State: AJcUukdMfoFYuEeh2wV+eo75APB81WYgOYYhxBkTXltwmw76duuW4e+Z
        4kc7PKBB8wIF0qXoVzUDfOMUhQL9rkiuSYEbM/k+/w==
X-Google-Smtp-Source: ALg8bN7wG4kE0fnu3wFSlWabWb8q7ZQgpVFBna7XEMZsF5f3TCUXyn+4echKGX6CkHlshyPsuZ/ifPrQGjv03bCJ2Zw=
X-Received: by 2002:aca:d905:: with SMTP id q5mr2558283oig.0.1546992136616;
 Tue, 08 Jan 2019 16:02:16 -0800 (PST)
MIME-Version: 1.0
References: <CAGXu5jKUP9o-ZgW5Wa5-9DHeQNZ5VA3cLBCJ0P7AVkTQ5tqHtQ@mail.gmail.com>
 <CAPcyv4iZZEM3D8vta_sge7a4iMgPZ5a1AnunXa4DKUaWauZk1g@mail.gmail.com>
 <CAGXu5j+z_yRPgE0HO=Sjo_VwwDDPJ+VLxbxwKgbb2cUAB5jmwg@mail.gmail.com>
 <CAPcyv4jhFGMzBrWHS_9q0Fe2MersRXz31VG3H2dJfujx1CJGhQ@mail.gmail.com> <CAGXu5jKrhvUduv_XUYF94YM=bBfPGNkPrZ_EkvRKB0pDY_6uOw@mail.gmail.com>
In-Reply-To: <CAGXu5jKrhvUduv_XUYF94YM=bBfPGNkPrZ_EkvRKB0pDY_6uOw@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 8 Jan 2019 16:02:05 -0800
Message-ID: <CAPcyv4jQ1Og_mEVjb77xdM263MugzK7_yrR_zi498JFrOrhSrg@mail.gmail.com>
Subject: Re: nvdimm crash at boot
To:     Kees Cook <keescook@chromium.org>
Cc:     Dave Jiang <dave.jiang@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 8, 2019 at 3:55 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Tue, Jan 8, 2019 at 3:54 PM Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > On Tue, Jan 8, 2019 at 3:34 PM Kees Cook <keescook@chromium.org> wrote:
> > >
> > > On Tue, Jan 8, 2019 at 3:28 PM Dan Williams <dan.j.williams@intel.com> wrote:
> > > > Ah, thanks for the report! The key difference is that you don't define
> > > > a "label area", so the driver bails out early and never initializes
> > > > the security state.
> > > >
> > > > This should fix it up.
> > > >
> > > > diff --git a/drivers/nvdimm/dimm_devs.c b/drivers/nvdimm/dimm_devs.c
> > > > index 4890310df874..636cdb06ee17 100644
> > > > --- a/drivers/nvdimm/dimm_devs.c
> > > > +++ b/drivers/nvdimm/dimm_devs.c
> > > > @@ -514,7 +514,7 @@ static umode_t nvdimm_visible(struct kobject
> > > > *kobj, struct attribute *a, int n)
> > > >
> > > >         if (a != &dev_attr_security.attr)
> > > >                 return a->mode;
> > > > -       if (nvdimm->sec.state < 0)
> > > > +       if (!nvdimm->sec.ops || nvdimm->sec.state < 0)
> > > >                 return 0;
> > > >         /* Are there any state mutation ops? */
> > > >         if (nvdimm->sec.ops->freeze || nvdimm->sec.ops->disable
> > >
> > > Okay, cool. I wasn't sure if that test needed a deeper check. :)
> > >
> > > Fixes: 37833fb7989a9 ("acpi/nfit, libnvdimm: Add freeze security
> > > support to Intel nvdimm")
> > > Tested-by: Kees Cook <keescook@chromium.org>
> > >
> >
> > Actually, looking closer this should have been avoided by the fact
> > that __nvdimm_create() initializes the security state early and that
> > nvdimm->sec.state should have saved us.
> >
> > I'll dig a bit deeper with your qemu config.
>
> Maybe something goes weird with pstore stealing the region?

No, pstore is off the hook. I was just able to reproduce locally and
I'm not doing anything with pstore.
