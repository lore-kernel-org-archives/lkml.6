Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2420FC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 20:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6D222146D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 20:49:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="f5pB6hEV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6D222146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbeJBD2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 23:28:44 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:55865 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbeJBD2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 23:28:44 -0400
Received: by mail-it1-f193.google.com with SMTP id c23-v6so218614itd.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 13:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4OfcV+qZLMIHL0EjvmHunbQ/HRLmYv01teHcTeDRTbI=;
        b=f5pB6hEV5wI4VMTrQL6NUG/beoCy4UOhi2xEu6XT9b1gix4iQSu0Su5SvyyDZRsH3q
         PHVOWcrWCzWOmseiuUD74Puc4ldNvcjJLsHiu1gXXoddgTGsqhMT+ObMyyIWY87SyLvM
         oFcljqrveQktFe2FyHiRfq6hyfjl/LLSWuOo0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4OfcV+qZLMIHL0EjvmHunbQ/HRLmYv01teHcTeDRTbI=;
        b=llGjTKHhNrD4OSiWSsSg3uUySW+DyNeLe72EPQFe5y3qi9KQmx6vl+aePHiCwLA3rX
         bxSoCAtXEurr2AWl/a9aOhS7YIbq8EPrp/LgSMKE193KfHusL9uKl+/Yzsk69boazZsl
         xJv45/JWhNAkzEoaFXUooQ1SyOJQT31jTyvO4o77644+DV6m4s6GaTeIxmPIgcBVG8Bg
         973ruyRRHLmjkZ8qTMUNwDi9Qo4VNMSYO4qoPhqIub+UWSvZTR0aNVLTvi0acQs5SRHx
         FFp+XRZTy8kUdfS2p5N0TelhVs0O0h67KR5zZOOIprS6RvaprHD/qnZjFPXpUbK2kTyI
         65rg==
X-Gm-Message-State: ABuFfoiIcbhcBjZkbIXcRhUhvgXynu22T12a+ZHsBONAtX5u2CfpMYOp
        0SHO3SSb+iYMNjUuaH6xe/MWo0wc08Q4NKwpMRd0iQ==
X-Google-Smtp-Source: ACcGV619J7DAe3t9awByM6OjP0Lwluf7EGU6PSujg5YbnnlHiDwAMC0BbEGeVYK/jgT1hoSsm6UUKGbrtKZ5qdV3BFI=
X-Received: by 2002:a24:7605:: with SMTP id z5-v6mr10609142itb.62.1538426946702;
 Mon, 01 Oct 2018 13:49:06 -0700 (PDT)
MIME-Version: 1.0
References: <20180906122436.25610-1-linus.walleij@linaro.org>
 <afd78fe6a5e168cc9190afe3e27d12286e0dfafa.camel@nxp.com> <CACRpkdbcBrjKar4CDg+yEVuCNE3RiGD61UkPasZ35SSmSNsUBA@mail.gmail.com>
 <CAOMZO5BhjDk4u4Y4H7swKK0faWaZWL7sFHZC7=G8Em0-jusUHA@mail.gmail.com>
In-Reply-To: <CAOMZO5BhjDk4u4Y4H7swKK0faWaZWL7sFHZC7=G8Em0-jusUHA@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 1 Oct 2018 22:48:54 +0200
Message-ID: <CACRpkdZ2XQKmzeu8KK-dCses21EBLbxtK+MvzJ42gHMhKc71kw@mail.gmail.com>
Subject: Re: [PATCH v7] regulator: fixed: Convert to use GPIO descriptor only
To:     Fabio Estevam <festevam@gmail.com>
Cc:     leonard.crestez@nxp.com, John Stultz <john.stultz@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Duan <fugang.duan@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Anson Huang <anson.huang@nxp.com>,
        ext Tony Lindgren <tony@atomide.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 1, 2018 at 10:36 PM Fabio Estevam <festevam@gmail.com> wrote:
> On Mon, Oct 1, 2018 at 5:17 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> > > reg_enet_3v3: regulator-enet-3v3 {
> > >         compatible = "regulator-fixed";
> > >         pinctrl-names = "default";
> > >         pinctrl-0 = <&pinctrl_enet_3v3>;
> > >         regulator-name = "enet_3v3";
> > >         regulator-min-microvolt = <3300000>;
> > >         regulator-max-microvolt = <3300000>;
> > >         gpios = <&gpio2 6 GPIO_ACTIVE_LOW>;
> > > };
> >
> > This is a bit odd actually, the GPIO_ACTIVE_LOW flag will
> > be ignored as you see:
>
> Yes, the flag will be ignored by the regulator driver, but the dts
> description is correct: it is an active low GPIO that turns on the
> reg_enet_3v3 regulator.
>
> The 'enable-active-high' flag needs to be passed to indicate an active
> high polarity.

Yes.

> > > [    0.153171] reg_fixed_voltage_probe(179): regulator-enet-3v3 call gpiod_get_optional gflags=0x7 ena_gpio_invert
> > > [    0.153218] regulator-enet-3v3 GPIO handle specifies active low - ignored
> > > [    0.153233] of_gpio_flags_quirks(83): regulator-enet-3v3 set active low because !enable-active-high
> >
> > Because regulators don't specify active high/low in the second
> > cell because of legacy bindings.
> >
> > So this should not be in the device tree anyway, it should be
> > GPIO_ACTIVE_HIGH or just 0.
>
> Then it would provide a wrong description that does not describe the reality.

OK my bad, by all means keep it. :)

The warning message does not say the description is wrong, just that it will
be ignored, and it is there for the users to be aware of that setting
GPIO_ACTIVE_LOW will have no semantic effect.

We introduced it because we were worried that if we don't print that,
users will tend to think that their GPIO_ACTIVE_LOW flags are
respected, so it was the best we could think of.

The real problem, of course, is that the bindings are ambiguous with
the elder binding taking precedence. Sorry about that, we were young
and didn't know how to do it the right way. Lesson learnt.

Yours,
Linus Walleij
