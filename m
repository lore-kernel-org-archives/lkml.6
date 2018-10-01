Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B005C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 21:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2906208AE
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 21:20:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LjWlsPAD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2906208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbeJBEAT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 00:00:19 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:46809 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbeJBEAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 00:00:19 -0400
Received: by mail-io1-f68.google.com with SMTP id t7-v6so3204751ioj.13
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 14:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vyboSOFxF8XcZqDE1GI8yEINP0b3eT4WXFPPdhP28hA=;
        b=LjWlsPADeCh/d+y5Ikg0HiFACMPVCM5/hSr0H/j8buxruZfIu1rY7mYwQWScEXKbop
         SmUJXRD0xxtORRewzPexZVvZVk9xQcD7OLsqT0U2uK163UOvYY4a/Hst9mNXV3Pio+ai
         Ohw8dyUruZaELwtSqLCbHQYXbpYOHnpkNmrBc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vyboSOFxF8XcZqDE1GI8yEINP0b3eT4WXFPPdhP28hA=;
        b=Ama8iDjRpPP77nAjlVSJ63EJfRKwAjovmGQWs3eU/wCgJHTcnRvVV/zbVHdH9hB0gi
         Xc7FH96c6aLaveGKnMCwVrseGK1LaPmaglQsrCvqJAJzx/58Xceb2H38sQwm9JkCGNPN
         3r/1k/KOcz5yPyP8r5qYOzsjK3pxuKUqZfRu1Kxb/PRCU2HAELqkgMUacGSTL/vtEuUN
         t8LgqaNrmhMcm/J3KkBRt53WvItk7wpFBn/bHslmYBz4FkKV16AjDIfehS5+13WGrGyL
         HTebKUx/WFMe4H7msAqRuHr/9BtZCYcfE+rn44Dg85xof0uunkafxjqCdknSCyxQ3WjE
         cl5Q==
X-Gm-Message-State: ABuFfoisQ2TObdD7bYBYrQTaBlw6sUhb008NpE209TSPZl6e7wgt+rYD
        ZZe6A6MUAxy+xcsoQ4FL5PiaGqyKPJhZNKCyrsoyxw==
X-Google-Smtp-Source: ACcGV61zl5jiCK1h2G3TNQJyLTQPAy05d5VBJz9bRPah4nJYa1uHum9ionDJXIVTkhllPLd8wH+glDDC9zkSHzeuODs=
X-Received: by 2002:a6b:630a:: with SMTP id p10-v6mr8505934iog.175.1538428833928;
 Mon, 01 Oct 2018 14:20:33 -0700 (PDT)
MIME-Version: 1.0
References: <20180921103604.13361-1-ricardo.ribalda@gmail.com>
 <20180921103604.13361-2-ricardo.ribalda@gmail.com> <153803107307.119890.10052910965015646333@swboyd.mtv.corp.google.com>
 <ffe11a8c-368b-8c74-54a7-a088c3997032@kernel.org> <3e07cab8-0f3e-7474-8f6d-e6bb16e8f998@codeaurora.org>
 <5aea282d-6fc9-cd70-cec4-10f28aa819b9@codeaurora.org> <CAOZdJXUUWUWHzus+3sbEXbW_q92e+SSzTQJCqCyQp6Y6_HOo3g@mail.gmail.com>
 <D3E6F4C4-E1C4-4D88-B118-878576BF5281@gmail.com> <CACRpkdawwrpEe6AAfdaxw6OMFXkCnq0gpznk1Up5p1=Wigx_2g@mail.gmail.com>
 <CAPybu_1P-RWCP8yjQKkFYAX11KtYGhAfASY24Q_NZ19PD09gxA@mail.gmail.com>
In-Reply-To: <CAPybu_1P-RWCP8yjQKkFYAX11KtYGhAfASY24Q_NZ19PD09gxA@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 1 Oct 2018 23:20:21 +0200
Message-ID: <CACRpkdaN5G4ephY+6BPLRF+aUrO4-sPa+2erRYrwTGwPBwu8fw@mail.gmail.com>
Subject: Re: [PATCH v2] gpiolib: Show correct direction from the beginning
To:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc:     timur@kernel.org, jhugo@codeaurora.org,
        Stephen Boyd <swboyd@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 1, 2018 at 3:36 PM Ricardo Ribalda Delgado
<ricardo.ribalda@gmail.com> wrote:
> On Mon, Oct 1, 2018 at 1:54 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> > On Fri, Sep 28, 2018 at 9:30 PM Ricardo Ribalda Delgado
> > <ricardo.ribalda@gmail.com> wrote:
> >
> > > How do we proceed from here? Can you fix your driver somehow to
> > > init the valid mask before enabling the gpio?
> >
> > Just include a hunk to the qcom driver reordering this call
> > at the same time. No need to make it separate patches,
> > it need to be tested together anyways.
> >
> > I guess just switch the order of these two:
> >
> >         ret = gpiochip_add_data(&pctrl->chip, pctrl);
> >         if (ret) {
> >                 dev_err(pctrl->dev, "Failed register gpiochip\n");
> >                 return ret;
> >         }
> >
> >         ret = msm_gpio_init_valid_mask(chip, pctrl);
> >         if (ret) {
> >                 dev_err(pctrl->dev, "Failed to setup irq valid bits\n");
> >                 gpiochip_remove(&pctrl->chip);
> >                 return ret;
> >         }
> >
>
> the problem is that valid_mask is not a long/integer, is a struct that
> needs to be malloced, and is malloc at gpiochip_add_data :(

I don't get it, but maybe I'm not smart enough.

gpiochip_add_data() doesn't allocate anything, it
just adds a already allocated (or static!) gpio_chip
to the gpiolib subsystem.

In fact I think it is wrong to set up the mask after
calling gpiolob_add_data(), because of exactly the
type of problem you're seeing.

Don't get confused by the &pctrl->chip
vs just chip variables, it's just some sloppiness.

Yours,
Linus Walleij
