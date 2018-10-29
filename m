Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD2E4C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 17:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CA8020657
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 17:22:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="euYLzIeL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CA8020657
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbeJ3CMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 22:12:12 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:46903 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726311AbeJ3CMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 22:12:12 -0400
Received: by mail-yw1-f66.google.com with SMTP id j202-v6so3682401ywa.13
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 10:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2yw2q1J7EpeCMB6G+eo3dXFDmpbuV7PBFypR1FfYfOw=;
        b=euYLzIeLtJcFJdaTya6ysy1CIUuJ37u+Tm4LpY4xKY9d5MJTWAPvV7+h5G++3o2xpm
         /1blMdJNr8siNiqZq0mUtrg8bcXEzM9oyhoS1MDILGMUenc/bX5C4TQK76a9cC8fjixt
         aEKAp94xijN4ZjdsbskMCTQznWudZEIPtAbgdqEBJUtBAFjzuMFC6LZE88zaMydajLzs
         r+EoDbDSOFK+Imyo0aPLgtAT7lgFHVA4K2YXE+oGuTy3GsRCRI8sUZteYD4Z+kwkBkd9
         5fAt0mzqRpgUZ5/0r8o44P+J4h0Ce0j0XUDdp7A9QPzVmFZN2jH+1KeceZnv1NsUnITy
         YthA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2yw2q1J7EpeCMB6G+eo3dXFDmpbuV7PBFypR1FfYfOw=;
        b=iP6tfG8yoDctVXEdcRllJH2+KVnicw7Ztjdki6HB8k2uZEbAwZoKaUmXm7W8l+xCBL
         ojH35QlfkoHai+OrYDII7BFJHhNGYb0rPWTy8cbkRHZsRpnP63tbqNnAFTKq4sUTz40A
         lS08PouVWKz01THULJ/g19tLAa6DISpFaNTi9BWMuHsBMzLo1FuJNxwLzi9bUvzNEIAj
         oraMCzSsChW4+Inhv8vNg4seOAQyTjYhxBjfUsyIUmylPARrBSnmxBG1KykDZaUQjMCl
         JI7YVkznNZdh7UWFOFgismbboL1JrCWkLELZANPdHFSWlujYiCLIeE7N+LhkWcgO2uzS
         TwlQ==
X-Gm-Message-State: AGRZ1gJR+9RzIi1XyO+70Tt3a1VwQUS5dX+qQ0gm+sqTI5T+eQilA8wk
        UH5bKlIU9C2imFFiekVXhE0YBg5+/CzeIVrYH5jL+Q==
X-Google-Smtp-Source: AJdET5ffhj1rDjGtbwjwOVC2M9DoRKkwdBshNs2mz8t3rbGUeWwEyrzeWmz7fJ0cDqbeLymWOKOM/f4UvXQMnYECP0k=
X-Received: by 2002:a0d:df95:: with SMTP id i143-v6mr14432316ywe.349.1540833759266;
 Mon, 29 Oct 2018 10:22:39 -0700 (PDT)
MIME-Version: 1.0
References: <CACRpkdY7eaYk81CU8gmHKfWB82_qNJur=c=7SCRuW+BNeL=Oiw@mail.gmail.com>
 <20181018215101.169847-1-rajatja@google.com> <CAHp75Vd_r4QGR5xw2cJigM2J3WStg_0PdynBXMZOyZh+t1znKg@mail.gmail.com>
 <CACK8Z6HOsUcPFyf-GguxPxh_Zdj6gCXP=FpGw-vQXJfnM=cquw@mail.gmail.com>
 <20181024100230.GQ10650@smile.fi.intel.com> <CAE_wzQ-80NCNbzbFx1eEDwEEOEAbv-5u+W171iUagY2pOahbmw@mail.gmail.com>
 <CAHp75VfMHqT+aAGVaXzXGbzF2=VEABOOaGhkjfV-D0NPbBM+Rw@mail.gmail.com>
In-Reply-To: <CAHp75VfMHqT+aAGVaXzXGbzF2=VEABOOaGhkjfV-D0NPbBM+Rw@mail.gmail.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Mon, 29 Oct 2018 10:22:02 -0700
Message-ID: <CACK8Z6GMsfVEpefzwvVgS44Eg=PQzcNOaC3GA9F2OzrBxvpchw@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-pci: Try "cd" for card-detect lookup before
 using NULL
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Dmitry Torokhov <dtor@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Rajat Jain <rajatxjain@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 8:23 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Wed, Oct 24, 2018 at 9:03 PM Dmitry Torokhov <dtor@google.com> wrote:
> > On Wed, Oct 24, 2018 at 3:02 AM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > > On Mon, Oct 22, 2018 at 04:34:55PM -0700, Rajat Jain wrote:
> > > > On Fri, Oct 19, 2018 at 2:13 AM Andy Shevchenko
> > > > <andy.shevchenko@gmail.com> wrote:
> > > > > On Fri, Oct 19, 2018 at 12:53 AM Rajat Jain <rajatja@google.com> wrote:
> > >
> > > > > > across other users of this API (other MMC host controller drivers).
> > > > >
> > > > > >         if (slot->cd_idx >= 0) {
> > > > > > -               ret = mmc_gpiod_request_cd(host->mmc, NULL, slot->cd_idx,
> > > > > > +               ret = mmc_gpiod_request_cd(host->mmc, "cd", slot->cd_idx,
> > > > > >                                            slot->cd_override_level, 0, NULL);
> > > > >
> > > > > Yes.
> > > > >
> > > > > > +               if (ret && ret != -EPROBE_DEFER)
> > > > > > +                       ret = mmc_gpiod_request_cd(host->mmc, NULL,
> > > > > > +                                                  slot->cd_idx,
> > > > > > +                                                  slot->cd_override_level,
> > > > > > +                                                  0, NULL);
> > > > >
> > > > > And no. Instead of this part you need to provide an ACPI GPIO mapping table.
> > > >
> > > > Sure, I am willing to do so, and I tried earlier too. However, certain
> > > > doubts arose in my mind when I tried that and I posted my questions
> > > > earlier (https://lkml.org/lkml/2018/9/28/507) but couldn't elicit any
> > > > response. Unfortunately I still do not have answers. My primary
> > > > questions are:
> > > >
> > > > 1) - It seems that 1 SDHCI device may support multiple slots (looking
> > > > at the code). It is not clear to me if they could share card detect
> > > > interrupts, or should have separate ones?
> > >
> > > This is more likely question to HW engineers of your platform with a caveat
> > > that there should be a way to distinguish exact slot in which card is being
> > > inserted.
> > >
> > > > Also, the driver may not
> > > > really know?
> > >
> > > I think in such case the bug in HW design and / or driver.
> >
> > Why? You can have a shared or dedicated interrupt and the driver does
> > not really need to know if it can poll the status.
>
> Yes, that's my point either we get 1:1 mapping between slot and GPIOs
> or have a possibility to read back from some register(s) the actual
> status of all of them, otherwise it's a bad design.

No, AFAIU, the driver only should only be able to read the status of
*the* interrupt that was fired? (as opposite to the ability to read
*all of them* when an interrupt fires).

> Sorry if I wasn't
> clear about it.
>
> > > > So should I add 1 or two pins using the
> > > > devm_acpi_dev_add_driver_gpios().
> > >
> > > This depends on the above, e.g. HW design, ACPI tables.
> >
> > Yes, it depends on the HW design and that is exactly why the approach
> > with devm_acpi_dev_add_driver_gpios() does not work well here: this is
> > a generic driver used on many platforms and you are trying to put the
> > platform knowledge into the driver. Here we are lucky I guess as I do
> > not believe anyone is using more than one slot, so we can have a tavle
> > with a single entry, but actually doing the fallback the way Rajat was
> > proposing is more correct. Or you have a table with N entries, where N
> > is hopefully sufficiently large.
>
> Yes, unfortunately this is the case. We need to keep somewhere the
> list to support old firmwares (see hci_bcm.c as an example how BIOS
> can screw things up).
> Soonish we start _DSD in BIOSes in a correct way (ha-ha), better for everyone.
>
> > > > Is some one familiar with SDHC
> > > > driver can answer these questions, it shall be great.
> > >
> > > Actually above questions better to ask in linux-mmc mailing list, which by the
> > > fact is in Cc list already. So, wait for someone to clarify.
> > >
> > >
> > > > 2) I'm not really sure what should I set "active_low" to? Isn't this
> > > > something that should be specified by platform / ACPI too, and driver
> > > > should just be able to say say choose whatever the ACPI says?
> > > >
> > > > struct acpi_gpio_params {
> > > >         unsigned int crs_entry_index;
> > > >         unsigned int line_index;
> > > >         bool active_low;
> > > > };
> > >
> > >
> > > ACPI specification misses this property, that's why we have it in the
> > > structure. In your case it should be provided by _DSD and thus be consistent
> > > with the hardcoded values.
> >
> > Again, you think as if the driver was platform specific; it is not. I
> > have 1000s of systems with different ACPI tables. Let's say half of
> > them use one polarity, and half another. Which polarity do you propose
> > to use?
>
> Use one table for one half and another for the rest.

But how does driver determine which table to use for which platform?
(Currently the driver is platform independent).

Thanks,

Rajat

>
> --
> With Best Regards,
> Andy Shevchenko
