Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 468D6ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 18:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F4172075D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 18:03:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KQXVQpIM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F4172075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbeJYCc1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 22:32:27 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34363 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbeJYCc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 22:32:27 -0400
Received: by mail-lf1-f66.google.com with SMTP id n26-v6so4710402lfl.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 11:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yyeDmCSlXt4k5qqsuNoj/4ImCIWV/mNaDeLP7Ex/lzI=;
        b=KQXVQpIMqwEiliZLpAuDEMXlck745+uLVVQYJ0AMQkYRq3BgFOhxq/q7z6uuF4tkVR
         95wEWZR8zvxg4NUIdAzFeyfBKLhvSMeUfCqYTi4MZQEeS0M/1zaCqK93+Gyb9KObr0g5
         owpaoHZ59OrxlRxRF5iG6v9z8cj1eVPOW7NasYL7Za78EjPJ50g7FGsDAezdo+BWTBHq
         h6vTxIzpdn5fh7LoG6bAYe++c+DjMbrC5/Rhnd1HHV9B6XyFRNMK5mp5mddjqNI46Ipy
         E0hW7NlRaF7lLE5ZL4EPso7/0JwBrup7LHONQ1yp8ZdDYMSuBBh3ZxRi84f1/YDAHRZd
         34Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yyeDmCSlXt4k5qqsuNoj/4ImCIWV/mNaDeLP7Ex/lzI=;
        b=m+NHD3QmacwPySGqsxAVIU5/moRakhULItxmHCYEfKz5g4HklMoDJC1TBzCkTVDxw1
         R0a4d8kC2tK7qqZLd0dxjUm0Dq4KxfCUYIboxO7UaNwAfhduw1YsJQxE0Z/U5k6dVC8o
         VaHUmxPWRL/H8tqMIuhGA+naCFZgz46NAYGHCI1iHqZ1W+GwfmUEv3k+T+CMg2aI4g1k
         9AXS2sU1ckRPhENkVXtagwNfAY+5lSo6K21bcsCU2w7Jgvh4dTZPxbD83FKMeK7FRKl6
         5aSQ+wg9Wgdey/wdsEKomkZg2jttDWhyUXFwuMlSyT2CjBN1wT/Xz+4x+2R8kglt6xIM
         VbMw==
X-Gm-Message-State: AGRZ1gLERYV6AgLoWCs+ak0VoRfZZyPeJxcjpqyvkGWXdqxhktFACRlA
        kvJ6LyubA7wg9PL9tXfrWnQrHz9UOw1NDkHhIyR/OQ==
X-Google-Smtp-Source: AJdET5dkcscEIZxwgGFG8O2WUCBop/il1J4D+bYcUcZGzHi0WtAdHB0cJTFtdo5KeDcO4Od8XtcrBTzYWKecDaafRrs=
X-Received: by 2002:a19:3809:: with SMTP id f9mr2424330lfa.148.1540404202573;
 Wed, 24 Oct 2018 11:03:22 -0700 (PDT)
MIME-Version: 1.0
References: <CACRpkdY7eaYk81CU8gmHKfWB82_qNJur=c=7SCRuW+BNeL=Oiw@mail.gmail.com>
 <20181018215101.169847-1-rajatja@google.com> <CAHp75Vd_r4QGR5xw2cJigM2J3WStg_0PdynBXMZOyZh+t1znKg@mail.gmail.com>
 <CACK8Z6HOsUcPFyf-GguxPxh_Zdj6gCXP=FpGw-vQXJfnM=cquw@mail.gmail.com> <20181024100230.GQ10650@smile.fi.intel.com>
In-Reply-To: <20181024100230.GQ10650@smile.fi.intel.com>
From:   Dmitry Torokhov <dtor@google.com>
Date:   Wed, 24 Oct 2018 11:03:11 -0700
Message-ID: <CAE_wzQ-80NCNbzbFx1eEDwEEOEAbv-5u+W171iUagY2pOahbmw@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-pci: Try "cd" for card-detect lookup before
 using NULL
To:     andy.shevchenko@gmail.com
Cc:     Rajat Jain <rajatja@google.com>, adrian.hunter@intel.com,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>, rajatxjain@gmail.com,
        lkml <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-gpio@vger.kernel.org,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Wed, Oct 24, 2018 at 3:02 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Mon, Oct 22, 2018 at 04:34:55PM -0700, Rajat Jain wrote:
> > On Fri, Oct 19, 2018 at 2:13 AM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > > On Fri, Oct 19, 2018 at 12:53 AM Rajat Jain <rajatja@google.com> wrote:
>
> > > > across other users of this API (other MMC host controller drivers).
> > >
> > > >         if (slot->cd_idx >= 0) {
> > > > -               ret = mmc_gpiod_request_cd(host->mmc, NULL, slot->cd_idx,
> > > > +               ret = mmc_gpiod_request_cd(host->mmc, "cd", slot->cd_idx,
> > > >                                            slot->cd_override_level, 0, NULL);
> > >
> > > Yes.
> > >
> > > > +               if (ret && ret != -EPROBE_DEFER)
> > > > +                       ret = mmc_gpiod_request_cd(host->mmc, NULL,
> > > > +                                                  slot->cd_idx,
> > > > +                                                  slot->cd_override_level,
> > > > +                                                  0, NULL);
> > >
> > > And no. Instead of this part you need to provide an ACPI GPIO mapping table.
> >
> > Sure, I am willing to do so, and I tried earlier too. However, certain
> > doubts arose in my mind when I tried that and I posted my questions
> > earlier (https://lkml.org/lkml/2018/9/28/507) but couldn't elicit any
> > response. Unfortunately I still do not have answers. My primary
> > questions are:
> >
> > 1) - It seems that 1 SDHCI device may support multiple slots (looking
> > at the code). It is not clear to me if they could share card detect
> > interrupts, or should have separate ones?
>
> This is more likely question to HW engineers of your platform with a caveat
> that there should be a way to distinguish exact slot in which card is being
> inserted.
>
> > Also, the driver may not
> > really know?
>
> I think in such case the bug in HW design and / or driver.

Why? You can have a shared or dedicated interrupt and the driver does
not really need to know if it can poll the status.

>
> > So should I add 1 or two pins using the
> > devm_acpi_dev_add_driver_gpios().
>
> This depends on the above, e.g. HW design, ACPI tables.

Yes, it depends on the HW design and that is exactly why the approach
with devm_acpi_dev_add_driver_gpios() does not work well here: this is
a generic driver used on many platforms and you are trying to put the
platform knowledge into the driver. Here we are lucky I guess as I do
not believe anyone is using more than one slot, so we can have a tavle
with a single entry, but actually doing the fallback the way Rajat was
proposing is more correct. Or you have a table with N entries, where N
is hopefully sufficiently large.

>
>
> > Is some one familiar with SDHC
> > driver can answer these questions, it shall be great.
>
> Actually above questions better to ask in linux-mmc mailing list, which by the
> fact is in Cc list already. So, wait for someone to clarify.
>
>
> > 2) I'm not really sure what should I set "active_low" to? Isn't this
> > something that should be specified by platform / ACPI too, and driver
> > should just be able to say say choose whatever the ACPI says?
> >
> > struct acpi_gpio_params {
> >         unsigned int crs_entry_index;
> >         unsigned int line_index;
> >         bool active_low;
> > };
>
>
> ACPI specification misses this property, that's why we have it in the
> structure. In your case it should be provided by _DSD and thus be consistent
> with the hardcoded values.

Again, you think as if the driver was platform specific; it is not. I
have 1000s of systems with different ACPI tables. Let's say half of
them use one polarity, and half another. Which polarity do you propose
to use?

Thanks.

-- 
Dmitry
