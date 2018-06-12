Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B04E5C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 08:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 668D2208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 08:15:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="g/6VgbBQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 668D2208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934033AbeFLIPt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 04:15:49 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:43648 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932803AbeFLIPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 04:15:43 -0400
Received: by mail-io0-f194.google.com with SMTP id t6-v6so27011757iob.10
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 01:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8p1CFS2O3E5h9rXQg6U3ITMKE1FkZyDDSplG4QvHBDo=;
        b=g/6VgbBQ7E0S6GR6viQhnGdBhMb9M57dohBJKY4sjHEoFrZyiRMwNJ5+iYQwrcMPvz
         dZClI4DkE3RyCTWJKFW3UqCZNsCae2VGhh1Oq12ymmp3w1JK/eRjxC2UECg1Xy6kONBW
         2WAxsUPHqGwHPqzUZOjCbQq8tQbT5XMQ6Q8gE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8p1CFS2O3E5h9rXQg6U3ITMKE1FkZyDDSplG4QvHBDo=;
        b=Fp1HFJA+uLH1UUA1WbKtA4K7nViC0g+xFMoaKmJ4Tb3toSn2PRZIkcMigAImFvXYNG
         Jf2KNvVFYT7FFQOSC77bgvkoXkUGAtXbYIOLoBzkB7FIW+tu6pPOinOZlk7pg+Ukg+Eq
         yTpbV63xWup83WuiJkkdrqrHEJPkHslb+888x5bsxfBtvYuK+nHeuOJ9VkLo5zkIlBzI
         wcMShmRYdtfngHiLEaQn9iU6NQSeG/xTOaR/2YE8dxBCOH+7OGDFa/j3TZz6eehP4WnP
         idKMAz0ZMfuexpB5gXkrY9pxZyu8Q78Traoxf/5eVQVx232Uwq6EZ72xJzK1vUeaLcL+
         rlqw==
X-Gm-Message-State: APt69E10ed9sLN++aDg64ttP92TX6097nuItZjfQrB0JTUYB4ZEvrPyd
        hwzoT0EcnYwZEhnbjInXnXN+qNfcWHwE1pd0AgEcyA==
X-Google-Smtp-Source: ADUXVKIKTLe+rB3A1Wt0eWIzCveEWI34WDZ5Qd9En0TjF5XTPI4ytey5KNEOB33m7Jfe3L+Tm8h2LJFOgOHWeh4dmlE=
X-Received: by 2002:a6b:4a15:: with SMTP id w21-v6mr871730iob.277.1528791342411;
 Tue, 12 Jun 2018 01:15:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:78c9:0:0:0:0:0 with HTTP; Tue, 12 Jun 2018 01:15:40
 -0700 (PDT)
In-Reply-To: <20180611150054.GC11580@sirena.org.uk>
References: <20180514080640.12515-1-linus.walleij@linaro.org>
 <20180514080640.12515-2-linus.walleij@linaro.org> <20180601093511.GA11734@ulmo>
 <CACRpkdZEMPfxHc8dZOvyYN+S4o_zwKuYCTBbMiXMLsCZRz_f6A@mail.gmail.com> <20180611150054.GC11580@sirena.org.uk>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 12 Jun 2018 10:15:40 +0200
Message-ID: <CACRpkdYxTNWcvJ41TJ+uLyVuGzbdip9uOOgDdiyyjYt1Vd8pfg@mail.gmail.com>
Subject: Re: [PATCH 01/19 v3] regulator: fixed: Convert to use GPIO descriptor only
To:     Mark Brown <broonie@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexander Shiyan <shc_work@mail.ru>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Tony Lindgren <tony@atomide.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Philipp Zabel <philipp.zabel@gmail.com>,
        Daniel Mack <zonque@gmail.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Russell King <rmk+kernel@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 11, 2018 at 5:00 PM, Mark Brown <broonie@kernel.org> wrote:
> On Mon, Jun 11, 2018 at 03:11:14PM +0200, Linus Walleij wrote:
>
>> The DT binding for "regulator-fixed" specifies that enable-active-high
>> should be set for polarity inversion. For historical reasons, I guess,
>> we screwed up. The example in the binding uses that.
>
> No, it just says that if the enable is active high then we should
> specify it using that boolean property.  It explicitly says that enables
> might be active low
>
> | - enable-active-high: Polarity of GPIO is Active high
> | If this property is missing, the default assumed is Active low.

Yeah my code gets it right I think, my head doesn't always :/

The assumed default is active low and then we tag this
bool property on the regulator if we want it to be active high.

> This binding predates the GPIO binding having any gpiolib level polarity
> inversion.

Yeah, that's how it is.

The confusion stems from Tegra using kinda both.

I think I have it handled right in the gpiolib core by assuming
it is active low, and explicitlt ignoring any attempts to use
the GPIO flags to flag it as active low. It will be active low
anyway in the Tegra case (after my patch to the second
compatible string) albeit giving a warning in the
dmesg.

>> Sadly this only handled the undocumented fixed
>> regulator binding "reg-fixed-voltage". So I need to fix it
>> for "regulator-fixed" as well, and then it "should work".
>
> The normal fixed voltage regulator parses enable-active-high?

Yeah currently. However I moved the handling to the gpiolib
parsing code to centralize polarity inversion handling, in an
attempt so keep things under control. So in the patch series
this flag handling moves over to the gpiolib.

I was thinking to do the same with other subsystems, such as
MMC to get legacy GPIO flags under control and contained.

Yours,
Linus Walleij
