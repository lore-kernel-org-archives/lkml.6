Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0727C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 07:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E54C2089C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 07:15:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nCup4HLD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E54C2089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbeJBN5c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 09:57:32 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45603 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbeJBN5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 09:57:32 -0400
Received: by mail-lj1-f195.google.com with SMTP id x16-v6so764002ljd.12;
        Tue, 02 Oct 2018 00:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EmWNADZTKC1ESUoZvuRSxXAvaewf36EagvpJmbk4zmg=;
        b=nCup4HLD8Ui2kudROV8knsjhrT7HCciYYY+Fg8NOHTvPnTbHA1ZZurdI9/Tm9ko4Pv
         xJAG4YzseKVRVJLt1CsyEUcvO6o2h69pP04U5ONgYvO9VPlMloqtsCRNfqCjU/Dc1VHA
         P8N5oHze+cy2bW4WFdDmsbEfN/41RGPepgQkNF0HUDQ0A82q9uSvdCJeovGJwzt1VU/8
         ME6xwJrSLtrE16/j6JpJMca5a3kTvZeEGxj++p1m2YF/gWULXEd7qEycfzxt1C80tcW9
         elZznZl8gmR9j9TecO2Dg3dlShh/3hU5sR7MfZzDWZOHJ5Pn0B1M7TfcrKQ2O7eRBopU
         +CvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EmWNADZTKC1ESUoZvuRSxXAvaewf36EagvpJmbk4zmg=;
        b=np7TTPGivSu1c3bmnrX48lpeuHoD44FJEAx7fjIxdDDJXzyF5F+0EzYO5uUZCfa5px
         n0HV6e13m3xEIEjRrMXI++xtlbeWXDMvEkMa1UqPtXR2s9+jqfofjKiwap+mjL3/8xxl
         TQ9ehPeJ2m3DC+/72DXqHzRvy/7WXFj49XwOHjn8e5O3tKiEk1QBjn0w6EqFFUWih1JV
         wiOD7GJ1VkmnGSlSaRWLWHzHmcbJYpUJ+c0wTzDEgU11/jeRx9C4Syf+LmBaQjfn6lG5
         OZ87n3UjOSN1ttWONiy/bir+OmZ2u4nyfG1VmDkqUz6kj/8NDicyWvBS9m26d8Ki8yx3
         eYUg==
X-Gm-Message-State: ABuFfogGVWxzlwXYPRHLVWYPR+Z2NCiJVII/qV7rBjFpAZJ9pp34JwqL
        qiqApKb/2nPL0V+gK/Pj1kNZ+5lt6baEdeXFmlQ=
X-Google-Smtp-Source: ACcGV60WWT4XmutzpfPaKzeuO58Y7Xk3JOSQOcwF6TIVZXuMGTI59xxB5/ZPugTjG9ghfASTsjedFjjthNshhqzKwr8=
X-Received: by 2002:a2e:921a:: with SMTP id k26-v6mr8467477ljg.163.1538464543139;
 Tue, 02 Oct 2018 00:15:43 -0700 (PDT)
MIME-Version: 1.0
References: <20180921103604.13361-1-ricardo.ribalda@gmail.com>
 <20180921103604.13361-2-ricardo.ribalda@gmail.com> <153803107307.119890.10052910965015646333@swboyd.mtv.corp.google.com>
 <ffe11a8c-368b-8c74-54a7-a088c3997032@kernel.org> <3e07cab8-0f3e-7474-8f6d-e6bb16e8f998@codeaurora.org>
 <5aea282d-6fc9-cd70-cec4-10f28aa819b9@codeaurora.org> <CAOZdJXUUWUWHzus+3sbEXbW_q92e+SSzTQJCqCyQp6Y6_HOo3g@mail.gmail.com>
 <D3E6F4C4-E1C4-4D88-B118-878576BF5281@gmail.com> <CACRpkdawwrpEe6AAfdaxw6OMFXkCnq0gpznk1Up5p1=Wigx_2g@mail.gmail.com>
 <CAPybu_1P-RWCP8yjQKkFYAX11KtYGhAfASY24Q_NZ19PD09gxA@mail.gmail.com> <CACRpkdaN5G4ephY+6BPLRF+aUrO4-sPa+2erRYrwTGwPBwu8fw@mail.gmail.com>
In-Reply-To: <CACRpkdaN5G4ephY+6BPLRF+aUrO4-sPa+2erRYrwTGwPBwu8fw@mail.gmail.com>
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date:   Tue, 2 Oct 2018 09:15:26 +0200
Message-ID: <CAPybu_33WNiCdkwgNtkiTP2PL+9ai85Z2LiMB6yqNZrV5JdmXw@mail.gmail.com>
Subject: Re: [PATCH v2] gpiolib: Show correct direction from the beginning
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Timur Tabi <timur@kernel.org>, Jeffrey Hugo <jhugo@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-gpio <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
On Mon, Oct 1, 2018 at 11:20 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Mon, Oct 1, 2018 at 3:36 PM Ricardo Ribalda Delgado
> <ricardo.ribalda@gmail.com> wrote:
> > On Mon, Oct 1, 2018 at 1:54 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> > > On Fri, Sep 28, 2018 at 9:30 PM Ricardo Ribalda Delgado
> > > <ricardo.ribalda@gmail.com> wrote:
> > >
> > > > How do we proceed from here? Can you fix your driver somehow to
> > > > init the valid mask before enabling the gpio?
> > >
> > > Just include a hunk to the qcom driver reordering this call
> > > at the same time. No need to make it separate patches,
> > > it need to be tested together anyways.
> > >
> > > I guess just switch the order of these two:
> > >
> > >         ret = gpiochip_add_data(&pctrl->chip, pctrl);
> > >         if (ret) {
> > >                 dev_err(pctrl->dev, "Failed register gpiochip\n");
> > >                 return ret;
> > >         }
> > >
> > >         ret = msm_gpio_init_valid_mask(chip, pctrl);
> > >         if (ret) {
> > >                 dev_err(pctrl->dev, "Failed to setup irq valid bits\n");
> > >                 gpiochip_remove(&pctrl->chip);
> > >                 return ret;
> > >         }
> > >
> >
> > the problem is that valid_mask is not a long/integer, is a struct that
> > needs to be malloced, and is malloc at gpiochip_add_data :(
>
> I don't get it, but maybe I'm not smart enough.

Dont take my job, I am the not smart of the conversation :P

>
> gpiochip_add_data() doesn't allocate anything, it
> just adds a already allocated (or static!) gpio_chip
> to the gpiolib subsystem.
>

Take a look to gpiochip_add_data_with_key()
  ->gpiochip_init_valid_mask()
       -> gpiochip->valid_mask = gpiochip_allocate_mask(gpiochip);



> In fact I think it is wrong to set up the mask after
> calling gpiolob_add_data(), because of exactly the
> type of problem you're seeing.

I agree, and I believe that the cleaner way would be to add a function
pointer that replaces:

gpiochip_allocate_mask()
  bitmap_fill(p, chip->ngpio);

with a proper initalization from the driver

But as today the only driver that seems to be using valid_mask is msm,
so perhaps a hack is something better and then when we have a second
driver that requires it we figure out the real requirements. But it is
definately your decision ;)


>
> Don't get confused by the &pctrl->chip
> vs just chip variables, it's just some sloppiness.
>
> Yours,
> Linus Walleij

Thanks!

-- 
Ricardo Ribalda
