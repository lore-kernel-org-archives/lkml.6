Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A62BBC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 07:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D6F9213A2
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 07:19:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PdW0izqz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D6F9213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbeJDOLF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 10:11:05 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:44400 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727091AbeJDOLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 10:11:05 -0400
Received: by mail-io1-f68.google.com with SMTP id x26-v6so7083306iog.11
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 00:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p73WRf1ZvmFlYb+MQdIzApOD+ANqXv8H980Hl3JFA/0=;
        b=PdW0izqzcK830AX320OBjdRWgohdD77kYYg3vH1ylCvVCT89rFIBb3WgAPaCiSksp8
         RALpQhr5XiS/zf9dJbK43Z+LLFPKHXW5DLkstgcM8+n/D3pVUmXTdLjTVPkZZljmAd/a
         2IwTfpF6nJGjiAGmqC66UxRSMhKKKTnYrsEhg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p73WRf1ZvmFlYb+MQdIzApOD+ANqXv8H980Hl3JFA/0=;
        b=QwR/GchBwQVh7IXGGV2CrC5/F3Sw1iG1+PVN0azxEv2zDC9WZAoyC/vWLZQ330PmNZ
         66cjHlbYI7phBiJWbA3cpSXfOJliC+knna/3mi8clQHW2SP0YGIoPg8wRXzmcT4XEuuX
         iBOZZlfuhCKhqV+PxNnBHeCuS/pLBWGNZrF0vuu3U3dLBbDQrPLypVS7dAFLKS349pzB
         XoBrtOt3xHGB06tp/ykIu1jWBEYUUaH3ccD88GQwHMncOPTLCBJNYrxLM+ICmvkGeqYd
         EuZSa+7vgOLgsleSg6As+gMeS/yNYP/lUHq8wd5i8bFGADVGkKR/0vwVSwIbd6dACcHo
         7KcQ==
X-Gm-Message-State: ABuFfoii8Apgl244bIJcdMchOenP8fNzr1DSjTQZQJP0c9+Fo9Y+/8sm
        3z8u6TXWC9hcVpl92Jlxz1IbeAOt8GdJfNpTqNL0oA==
X-Google-Smtp-Source: ACcGV61W4xY8zxSyvTHfyRIR78RFj5xvRYq2tc6i39LRO2SViiNDFNdF9Cxshi307HD1nD62899Jdx09mcpYgpXK/Jo=
X-Received: by 2002:a6b:4006:: with SMTP id k6-v6mr3252856ioa.277.1538637554381;
 Thu, 04 Oct 2018 00:19:14 -0700 (PDT)
MIME-Version: 1.0
References: <20181001204346.4655-1-linus.walleij@linaro.org>
 <28e88d54f6503cf1be577eb1872cdf2c50d7dfa3.camel@nxp.com> <20181003121002.GA7132@sirena.org.uk>
 <c2ace38e09344d325271498fe8133c888470b5f6.camel@nxp.com>
In-Reply-To: <c2ace38e09344d325271498fe8133c888470b5f6.camel@nxp.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 4 Oct 2018 09:19:02 +0200
Message-ID: <CACRpkdYtddXBYQE4RbDj_7rKb38jE9HvKetokjiCi2Tt8-ZhzA@mail.gmail.com>
Subject: Re: [PATCH] regulator: fixed: Default enable high on DT regulators
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Mark Brown <broonie@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Duan <fugang.duan@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        John Stultz <john.stultz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 3, 2018 at 8:08 PM Leonard Crestez <leonard.crestez@nxp.com> wrote:
> On Wed, 2018-10-03 at 13:10 +0100, Mark Brown wrote:
> > On Tue, Oct 02, 2018 at 01:42:38PM +0000, Leonard Crestez wrote:
> >
> > > This turns the phy off and on again instead of leaving it up from uboot
> > > and it doesn't work for some reason. However looking at
> > > reg_fixed_voltage_probe introducing an edge seems to be intentional for
> > > regulators which are not marked with "enabled-at-boot". Right?
> >
> > No, that's definitely not desired.  We don't want to change the state of
> > the regulator at all if we can avoid it unless the user explicitly asked
> > for it.
>
> That also makes sense, for a top level perspective. But
> reg_fixed_voltage_probe contains the following snippet:
>
>         if (config->enabled_at_boot) {
>                 if (config->enable_high)
>                         cfg.ena_gpio_flags |= GPIOF_OUT_INIT_HIGH;
>                 else
>                         cfg.ena_gpio_flags |= GPIOF_OUT_INIT_LOW;
>         } else {
>                 if (config->enable_high)
>                         cfg.ena_gpio_flags |= GPIOF_OUT_INIT_LOW;
>                 else
>                         cfg.ena_gpio_flags |= GPIOF_OUT_INIT_HIGH;
>         }

GPIOD_* flags nowadays but yes.

> Unless config->enabled_at_boot the GPIO is initialized with the
> opposite polarity of enabled. This means that fixed regulators which
> are not marked with "enabled-at-boot" but happen to be "on" anyway are
> always power cycled.
>
> This is from before recent changes by Linus, code dates from 2012
> commit 25a53dfbfbfd ("regulator: fixed: Use core GPIO enable support").
> Even before that the logic was similar:
>
>         drvdata->is_enabled = config->enabled_at_boot;
>         ret = drvdata->is_enabled ?
>                 config->enable_high : !config->enable_high;
>         gpio_flag = ret ? GPIOF_OUT_INIT_HIGH : GPIOF_OUT_INIT_LOW;
>
> Looking further back it seems that this behavior has always been
> present in fixed-regulator code.

Yep, I can't take the credit for that, I just tried to preserve the
logic that was already there.

> In theory it might be possible to request the GPIO while asking to keep
> the value from the bootloader?
>
> Maybe I'm confused but I don't see an
> easy way to do this through the GPIO api; functions for requesting in
> output mode all seem to also ask for the initial value.
>
> GPIOD_ASIS looks close but it doesn't even adjust the direction.

If the bootloader set up the line value, isn't it reasonable to assume
it also set up the direction (to output)? How else would it even work?

That said, you could just call gpiod_direction_output() after
getting the handle if you want to make sure it is set as output.

We are floating patches that will re-enable the GPIO code to call
.get_direction() on all descriptors at boot. After that you can use
gpiod_get_direction() to determine if it needs to be switched,
but that would be a bit overengineered IMO.

I guess you can make a patch using GPIOD_ASIS, but I am worried
that several systems will depend on the active driving of this since
as you describe, it has been like this for ages.

Yet again I'm not the conservative kind, as you notice, so by all means
try it! :)

> > > It's possible that you exposed an imx board-specific bug: maybe power
> > > cycling the phy after uboot needs some missing fixup?
> >
> > It'd probably also be good to sort this out though.
>
> Yes, handled separately: https://lore.kernel.org/patchwork/patch/994871/

That one was especially interesting!

Yours,
Linus Walleij
