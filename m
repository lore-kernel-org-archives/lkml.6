Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33221C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 19:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E48172082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 19:43:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jk7VZYlc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E48172082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728447AbeJ3Edp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 00:33:45 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39808 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbeJ3Edo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 00:33:44 -0400
Received: by mail-qt1-f196.google.com with SMTP id g10-v6so10734349qtq.6;
        Mon, 29 Oct 2018 12:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=rBTGGxdiJskMjWrUGdixSbQQERoc8ij0psm8trdkVx4=;
        b=Jk7VZYlcNYSftIydFmQj4MQ7gyaVTmbX6ZpFrqZNRp4JBoyMqjcbFwWKK2EqaYciaU
         3/1MrMpgXPK4Z9lLBiYLwy3PUJA7hK3Gzsnx4dcNl7UsV1ABuFKPCzNz9NVaRJz52LhT
         MuhkDrETlKAi4z3y1p+BV+wrUab85uS3hzQ8p5is42qrTON1eIqu6ycsEZyyO2NBSaOm
         nb/E8H1ZE6x1qzYXwwEgbbfJaYMkia8rVSN00xN1begAqC5+cVmNAxsug0V2PARgYeYC
         Uce6EEyXgY2eItQ3V3kDoj5LIulN3v2SiYajVuSJ0prtSml3bfLgQGZlwrbJ9FTS7g6D
         wMXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=rBTGGxdiJskMjWrUGdixSbQQERoc8ij0psm8trdkVx4=;
        b=BWMcMftDEAQEtFHVARBVibQBbTkbXrMCM7OWMot+ufGjNaoiP6yEFmg428Ul9uR3/1
         V/ISIFcQPrr9kZdJakgXa7L+HqR95LA54QYbwL0BK6iHwxIV3sivpiL0EYcZxpeaufBS
         hTQveUkn2UWG8knMQcjjP/VQQpea2MYilBBS4tf5KTOR1dnIKlA8/XhU0Y2sqKfZtOm4
         Alir2qHjE7r/cshZ4flRGyEmZoiW2P8R7R9f9plOgZ7vfpuPKw5w0JQHDTYdPn+0C1CV
         2KrOvqxZIkhUdDEZ/1Fwq9UboUEEfvpN5c02pDVhVtNBVLcCCWsmos5XDLhVbd0R28du
         IVqw==
X-Gm-Message-State: AGRZ1gIVsAM47hBsJnOwttyyp0a1iZnujqpJnWuJ542y2wK9OXkF0xNt
        atqZZRT7unOYwP6udDovVOpXFtbWfMMsUdxtckI=
X-Google-Smtp-Source: AJdET5cxy6ETRGZyrkNvdLTHcZzQT5GSTmcVZ2vBVKtQkyn1DduzkzuvSWWETFSVnUZgML4xZegN66zM6qFZNRvTyyc=
X-Received: by 2002:ad4:4106:: with SMTP id i6mr14040087qvp.219.1540842216067;
 Mon, 29 Oct 2018 12:43:36 -0700 (PDT)
MIME-Version: 1.0
References: <CACRpkdY7eaYk81CU8gmHKfWB82_qNJur=c=7SCRuW+BNeL=Oiw@mail.gmail.com>
 <20181018215101.169847-1-rajatja@google.com> <CAHp75Vd_r4QGR5xw2cJigM2J3WStg_0PdynBXMZOyZh+t1znKg@mail.gmail.com>
 <CACK8Z6HOsUcPFyf-GguxPxh_Zdj6gCXP=FpGw-vQXJfnM=cquw@mail.gmail.com>
 <20181024100230.GQ10650@smile.fi.intel.com> <CAE_wzQ-80NCNbzbFx1eEDwEEOEAbv-5u+W171iUagY2pOahbmw@mail.gmail.com>
 <CAHp75VfMHqT+aAGVaXzXGbzF2=VEABOOaGhkjfV-D0NPbBM+Rw@mail.gmail.com>
 <CACK8Z6GMsfVEpefzwvVgS44Eg=PQzcNOaC3GA9F2OzrBxvpchw@mail.gmail.com> <20181029174356.GR10650@smile.fi.intel.com>
In-Reply-To: <20181029174356.GR10650@smile.fi.intel.com>
Reply-To: rajatxjain@gmail.com
From:   Rajat Jain <rajatxjain@gmail.com>
Date:   Mon, 29 Oct 2018 12:43:24 -0700
Message-ID: <CAA93t1oaZ5zkv+BsGnYZg6pqKv0DzXi3j8oZHUyTyffUWHtHug@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-pci: Try "cd" for card-detect lookup before
 using NULL
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Rajat Jain <rajatja@google.com>, Dmitry Torokhov <dtor@google.com>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 10:44 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Mon, Oct 29, 2018 at 10:22:02AM -0700, Rajat Jain wrote:
> > On Mon, Oct 29, 2018 at 8:23 AM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > > On Wed, Oct 24, 2018 at 9:03 PM Dmitry Torokhov <dtor@google.com> wrote:
> > > > On Wed, Oct 24, 2018 at 3:02 AM Andy Shevchenko
> > > > <andy.shevchenko@gmail.com> wrote:
> > > > > On Mon, Oct 22, 2018 at 04:34:55PM -0700, Rajat Jain wrote:
> > > > > > On Fri, Oct 19, 2018 at 2:13 AM Andy Shevchenko
> > > > > > <andy.shevchenko@gmail.com> wrote:
>
> > > > > > Also, the driver may not
> > > > > > really know?
> > > > >
> > > > > I think in such case the bug in HW design and / or driver.
> > > >
> > > > Why? You can have a shared or dedicated interrupt and the driver does
> > > > not really need to know if it can poll the status.
> > >
> > > Yes, that's my point either we get 1:1 mapping between slot and GPIOs
> > > or have a possibility to read back from some register(s) the actual
> > > status of all of them, otherwise it's a bad design.
> >
> > No, AFAIU, the driver only should only be able to read the status of
> > *the* interrupt that was fired? (as opposite to the ability to read
> > *all of them* when an interrupt fires).
>
> I can't be sure in the details of this (sdhci) driver, I'm not a maintainer of
> that one. So, my above conclusions are purely generic.
>
> > > > > > 2) I'm not really sure what should I set "active_low" to? Isn't this
> > > > > > something that should be specified by platform / ACPI too, and driver
> > > > > > should just be able to say say choose whatever the ACPI says?
> > > > > >
> > > > > > struct acpi_gpio_params {
> > > > > >         unsigned int crs_entry_index;
> > > > > >         unsigned int line_index;
> > > > > >         bool active_low;
> > > > > > };
>
>
> > > > > ACPI specification misses this property, that's why we have it in the
> > > > > structure. In your case it should be provided by _DSD and thus be consistent
> > > > > with the hardcoded values.
> > > >
> > > > Again, you think as if the driver was platform specific; it is not. I
> > > > have 1000s of systems with different ACPI tables. Let's say half of
> > > > them use one polarity, and half another. Which polarity do you propose
> > > > to use?
> > >
> > > Use one table for one half and another for the rest.
> >
> > But how does driver determine which table to use for which platform?
> > (Currently the driver is platform independent).
>
> Based on vendor and device IDs in any form of it.

The vendor ID and device ID here would mean building a table of
platforms ids in this (currently platform independent) driver. I'm not
sure if my original patch introduces any problems that are worth
solving using such a table.

I would thus prefer to solve it using my original patch, I would
respin it taking care of your other review comments.

Thanks and best regards,

Rajat

>
> --
> With Best Regards,
> Andy Shevchenko
>
>
