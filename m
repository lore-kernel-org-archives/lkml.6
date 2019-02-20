Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C0CEC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48D042089F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:38:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="loBxs8Go"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbfBTJiA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 04:38:00 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34207 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbfBTJiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 04:38:00 -0500
Received: by mail-lf1-f66.google.com with SMTP id u21so17095496lfu.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 01:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qYUjIotbYzNlul+o0jVHN/+Dk/uMFrxj+uj/aWxE2o0=;
        b=loBxs8GojcPvogSmlluvr3Cyd69TEg6VRKV/mf1RvcG73QxdZB2QqySbr6YvfisL2u
         o5norCjmQtuFDmMuB5KD/cVpBHaNrh9AQqWAKQ39qtpj5kfPrCM6AxrEVFue80amaXn7
         1+2gerkha1oCLkewknNU9BWxNgHWeGcCYCbCf78N1UVQ5St3xqoaZPihQZAA8dSGcpcv
         eXkBHylwpBB91IwI0fIbBMiYbrcH73n31aKNDALrF+Q6NFa3jVNZ3KdbKprViRJdtmSL
         nVEz7jl1fIQukqj9x+T0/1nfECimNHl2gwMAgAfO2n+20YA6nobFX7bOPB4IS15qqm19
         I63g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qYUjIotbYzNlul+o0jVHN/+Dk/uMFrxj+uj/aWxE2o0=;
        b=hhM8/RIs11vbrodLicORbH3exSAn/1kONM+UxzpZPKMPjOJCJlGE3fkAKFpcd2tawg
         or5mID0h630+Gbjw46+qEFjBVHcw+np5jMxnI4u/SqONsWFv9TWmhbEgmdLChgCXy2uG
         /7QVnUsdnkxlWD6y8Y2Pn07nRJt+olaV1rDmPZmkNbAfGX5rKDev0Y7OHY1omYiNUJ6/
         vwUCW9fS5NH6FJmT7QMgOEXCyrf2dBkClMtYnm8E7t/astqAiEKlT1PZGCnrnZwiOTm6
         +nIbJmZYnzh+87xoO8t6+kGZ+KDn8YZzhIxUUuhaVrDn3JnXEmeY/+Cjf9sY50jZ7BDq
         7QDA==
X-Gm-Message-State: AHQUAuauHyfU1BOuwLPGBPBVfnUr84xYuU/3oib5fEbaIxMICYmJFaZx
        NlMAKd/eCNvkVRRiHg8kYzWgmBhp2j865FMC84PnAg==
X-Google-Smtp-Source: AHgI3IbKlVWrKJbdM5sHqRchB7TN+d0OGOb/yHLQ38rIswBC21Vzxo61XIf/AEeUDWLRLRLP4ss0IHwK1nsayF6Gouk=
X-Received: by 2002:a19:ec0c:: with SMTP id b12mr20867595lfa.27.1550655478062;
 Wed, 20 Feb 2019 01:37:58 -0800 (PST)
MIME-Version: 1.0
References: <1549588593-4856-1-git-send-email-lkml@metux.net>
 <CACRpkdaSEZMR7LuLbO1V0k9QEBu4FWxFbq4ZL1pE9dAvNT1z_Q@mail.gmail.com> <55cfbefe-5ff7-9f8d-4507-a5a2f9c78d13@metux.net>
In-Reply-To: <55cfbefe-5ff7-9f8d-4507-a5a2f9c78d13@metux.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 20 Feb 2019 10:37:46 +0100
Message-ID: <CACRpkdYgZ1jh-kvHuwY5gFKDc9kMY23MSN0+G9SX7xbmSBBS+Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] x86: gpio: AMD G-Series pch gpio platform driver
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86 <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 10:56 AM Enrico Weigelt, metux IT consult
<lkml@metux.net> wrote:
> On 08.02.19 15:25, Linus Walleij wrote:
>
> >> +config GPIO_AMD_FCH
> >> +       tristate "GPIO support for AMD Fusion Controller Hub (G-series SOCs)"
> >> +       select GPIO_GENERIC
> >
> > You are selecting GPIO_GENERIC, is this necessary? I thought
> > X86 was already selecting this.
>
> Doesn't look so - at least haven't found anything where it's
> automatically selected on x86. OTOH, that wouldn't make much
> sense to me  - I somewhat doubt that x86 can't run w/o that.

Sorry my bad. You should select this if you use it, but are you
using the GPIO MMIO abstractions?
The hallmark of those implementations are that they
call bgpio_init() and this driver does not, and it seems
with the funny layout of the registers it can't even use
it anyway.

> IMHO, dependencies should always be direct - indirect ones could
> suddenly change in subtle ways.

Agreed.

> >> +       priv->gc.owner                  = THIS_MODULE;
> >> +       priv->gc.parent                 = &pdev->dev;
> >> +       priv->gc.label                  = dev_name(&pdev->dev);
> >> +       priv->gc.base                   = priv->pdata->gpio_base;
> >
> > No please, use priv->gc.base = -1;
>
> Could I also leave that field untouched (IOW: =0) ?

No unfortunately not, because 0 is a valid GPIO base.

Yours,
Linus Walleij
