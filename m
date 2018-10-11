Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10CA6C677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 18:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEA7820652
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 18:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="d7NfRxCL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEA7820652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729506AbeJLCJ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 22:09:56 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:39748 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727944AbeJLCJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 22:09:56 -0400
Received: by mail-it1-f196.google.com with SMTP id w200-v6so14713347itc.4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 11:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9IY/hrivm6igAzQQagDcNEdfa+HIsd26jr/DwDs3xuA=;
        b=d7NfRxCLYsiEfcMR9NRtCGrRAw9LPE1ekAmIG7oO3d4Z6hbDo+kfo6oBUWrcPF8Ldb
         bH3DbP6FKJY683TAoX48TMWT2qV4mw52vevjro3nLzxm/JjVewyCWm5MA4UPWIjBxeoJ
         siWnpNsbKvnPFboSEc0ggu8iw8iZgEdQ2XDcI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9IY/hrivm6igAzQQagDcNEdfa+HIsd26jr/DwDs3xuA=;
        b=uOJzyxQtoGRBElMeBDZJtUUgQNsYWy0nhHAG0wb3oVuvePLMuEs8B91FrY7s/4LYQj
         GJFVEaL3KROeuBtcLmI7F32jdz1hxt8wlzij04kJZkhb/Nee2/62vbRxNfovZOIRG0GU
         X8LoEp8JuFzatqrK0LHP5elLN15pvO//foQB1iNRYpCyytSq40zhgMsjXIdUE8SDt6L7
         /U5vbXODSqNRtwXbrbuyJtzQ+CzOFM9++sv4v/7H83/TtUlUwFmmUvOvIyJNSBM5Y78V
         AFIka9dAvkeFjXeH8b5PuKvNOvDW3vYlfg4a6LcuLKpAG95QEPTA9kvWIEf7uwbcAYtW
         EV/A==
X-Gm-Message-State: ABuFfogkNdzFAl7Z21xhT3oSPzZuP8lRJiFkqn7wXA6oaOXZQTUuo3/G
        lp3mDna0huyd4cZ3u+gVhZFZikEnOU7C5hrysSwMk4xOm28=
X-Google-Smtp-Source: ACcGV61jBu2grNPAU0lRNH3BvNEVW0L77we8RjhlvNWUwNqvmnZSfgN1t+jVCEZBlpGbgHC4C4Lc7Am9IRmK6K7c6aY=
X-Received: by 2002:a24:e0c8:: with SMTP id c191-v6mr1607431ith.156.1539283289834;
 Thu, 11 Oct 2018 11:41:29 -0700 (PDT)
MIME-Version: 1.0
References: <20181011143531.7195-1-linus.walleij@linaro.org>
 <20181011144330.GF25351@sirena.org.uk> <CACRpkdbTnBQhPQARX77KfjtfWXY+t0oH6-B=WUN4hid8eQT0DA@mail.gmail.com>
 <20181011175406.GH25351@sirena.org.uk>
In-Reply-To: <20181011175406.GH25351@sirena.org.uk>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 11 Oct 2018 20:41:16 +0200
Message-ID: <CACRpkdY=ya9CJz0HbsdgzR+05SdoHQ+V17fY8sBtNtF482eXew@mail.gmail.com>
Subject: Re: [PATCH] gpio/regulator: Allow nonexclusive GPIO access
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 7:54 PM Mark Brown <broonie@kernel.org> wrote:
> On Thu, Oct 11, 2018 at 07:01:13PM +0200, Linus Walleij wrote:
> > On Thu, Oct 11, 2018 at 4:43 PM Mark Brown <broonie@kernel.org> wrote:
> > > On Thu, Oct 11, 2018 at 04:35:31PM +0200, Linus Walleij wrote:
>
> > > enable line so you don't need to use the bus to do the enables.  That
> > > should just be a case of adding this flag to all the drivers that have
> > > already been converted to gpiod (including the core code that's in
> > > regulator_ena_gpio_request() which I thought was coping with this
> > > already) unless I'm missing something?
>
> > Sorry if I don't get it... we already have code in the core to
> > check if the same gpiod is used by two regulators.
> > regulator_ena_gpio_request() does this:
>
> >         if (config->ena_gpiod)
> >                 gpiod = config->ena_gpiod;
> >         else
> >                 gpiod = gpio_to_desc(config->ena_gpio);
>
> > So after the change I made to fixed.c this comes in through
> > config->ena_gpiod.
>
> Other regulators that have GPIO control for their enables do their own
> requests (as does the core) so don't they all need to set the flag
> GPIOD_FLAGS_BIT_NONEXCLUSIVE when they request otherwise it'll only work
> in systems where the regulators after the first that request the GPIO
> are fixed regulators?

Yeah ... I guess I assumed that the same enable line is not used
for a fixed regulator and then some other regulator (which is not
fixed).

If this is common practice we need to account for it. Obviously
I have no idea what is common practice :/

gpio-regulator.c will work fine since it passes in a global
number (still) so it will just grab the desc out of the GPIO
with the legacy function and go on. (I need to keep it in mind
when refactoring that one later though!)

Do we know some way to identify the affected systems or
should we just tag on GPIOD_FLAGS_BIT_NONEXCLUSIVE
on all the stuff we converted to descs to play it safe?
(I can cook a patch.)

Yours,
Linus Walleij
