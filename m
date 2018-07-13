Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC6FECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 06:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4D042089C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 06:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hgeKg2q4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4D042089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729797AbeGMHMj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 03:12:39 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:53988 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729762AbeGMHMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 03:12:39 -0400
Received: by mail-it0-f68.google.com with SMTP id a195-v6so10229566itd.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 23:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vlY1hvkhLZ/cr1qXjlFxE57xeg3cHCVXtzK0wyfy6mU=;
        b=hgeKg2q4pBijz7/ofYLwORvn7ue/Tp3o4CAPgu0b6sgDKnr1ZtNzUl1Jtr4T6aG9D3
         jVAChrrFiPHHEx0DyBgUzo6TKhrnSKteEU/Iq7t4KgtiEGPL49yX79HyOOHoC8DsL0eK
         3KWXaD5e7vg3861wRGQreSVwzKSxMIUv3110M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vlY1hvkhLZ/cr1qXjlFxE57xeg3cHCVXtzK0wyfy6mU=;
        b=fXGko2t3Ke8A9JTG4xUOUeLIzSpQV7muttGma4b57K1nZ6AOPr5on4fdDTgRv0MhrK
         tx1rt4RvkdY0aDzRNX3oLoxFXIt6eQvtL5QaiFwKoAEGBTlsuAkdDROxdAk/eE9gbgUk
         t9r7JCz9fnniJY0cQ/F+Yu7Xrf9U3T8hwOthok/B2BDYJRuojSphMc/cOJoB1jYUJelD
         pjQ6WTbhtPQlyF5ayxrczZiveDW/ObyT0kAiKYRNHJaPD8DVfy5CPNHWorsZKudiuS+s
         Uki39kGF7itQdzq+bzVbg3cPy9J29ygXlQ4FlwXJU+838rrPdCTJBbJOLH46LAjgv2xS
         XvWg==
X-Gm-Message-State: AOUpUlH5YiRbut1EaDC1wk04f7oAKzX6DRepX5EY189KAcakZOW/LASh
        xLDYglzrsTZNekn/QoVEGhY2R0exbwsVX5+RkTK+LQ==
X-Google-Smtp-Source: AAOMgpcN9e+nfbYfJvpKPJRfJ6STlM3CCkWmRhR/GFCkwNAP0prddTmFy8cOlX/+6YVP1gT2vnlJG7OrOmyOmhyj4Vw=
X-Received: by 2002:a02:597:: with SMTP id 23-v6mr4255728jal.112.1531465163864;
 Thu, 12 Jul 2018 23:59:23 -0700 (PDT)
MIME-Version: 1.0
References: <20180618205255.246104-1-swboyd@chromium.org> <20180618205255.246104-3-swboyd@chromium.org>
 <20180622175836.GC3402@tuxbook-pro> <20180622183129.GD3402@tuxbook-pro>
 <CACRpkdZr5tKCjyO6Eq2vPPE8Lg+m+Ky_f24wYBSiLjdZuQ4WwA@mail.gmail.com>
 <153020606866.143105.1849265284764230975@swboyd.mtv.corp.google.com>
 <CAD=FV=Xmo4p7DbOReO02JVKnykoAOz7PtnkbdwryxvpsgZCgWw@mail.gmail.com>
 <153055420964.143105.3738779882090053054@swboyd.mtv.corp.google.com>
 <CACRpkdbNSNzT8tiYDXk1dc447xGqf1bV+O93hgEQdT+GcQtddA@mail.gmail.com> <153115064295.143105.5291742668895542720@swboyd.mtv.corp.google.com>
In-Reply-To: <153115064295.143105.5291742668895542720@swboyd.mtv.corp.google.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 13 Jul 2018 08:59:11 +0200
Message-ID: <CACRpkdZYyOT-Ua9BN=wbzmCDog3Hh0Un73-_f-fozZghrmO0=A@mail.gmail.com>
Subject: Re: [PATCH 2/3] pinctrl: msm: Mux out gpio function with gpio_request()
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 9, 2018 at 5:37 PM Stephen Boyd <swboyd@chromium.org> wrote:
> Quoting Linus Walleij (2018-07-09 06:54:01)
> > On Mon, Jul 2, 2018 at 7:56 PM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > > I could do with some more clarity from Linus in the "Drivers needing
> > > both pin control and GPIOs" section of
> > > Documentation/driver-api/pinctl.rst but I read that section as stating
> > > that the GPIO driver needs to mux the pin as a GPIO by requesting the
> > > pinctrl backend to do so, unless the hardware overrides the muxed
> > > function selection when the GPIO is used, without involving pinctrl
> > > software.
> >
> > Yeah that text is especially terse :/
> >
> > What it says (or what I meant to say) is that there is a choice
> > between letting the pin control and GPIO functionality on the
> > same pin be handled orthogonally or implementing these
> > gpio_*() callbacks into the pin control backend, but in either case
> > the two APIs must be used in sequence:
> > pin control setting comes first, second the GPIO subsystem can
> > request the GPIO line.
> >
> > I'll see if I can clarify.
>
> Ok. Is my interpretation correct though? The fundamental question here
> is if gpio_request() should remux the GPIO for the GPIO function or if
> drivers are expected to have pinmux settings to use their pin as a GPIO.

It's an either/or situation.

So there are two ways to do it, as the gpio_request() callback to
pinctrl_gpio_request() etc are not compulsory to implement.

For any one specific system, it is either done such that gpio_request()
does it by calling down to pinctrl_gpio_request() and talking to the
pinctrl back-end, OR the pin muxing is done as a side dish
without any interaction with the GPIO subsystem.

So pick one...

I know this is not very consistent. Sorry for the inconvenience :(

Yours,
Linus Walleij
