Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF2FAC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 11:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2BFD20882
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 11:56:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PDysMpHU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730859AbfA3L4i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 06:56:38 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37927 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730847AbfA3L4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 06:56:37 -0500
Received: by mail-lj1-f194.google.com with SMTP id c19-v6so20464405lja.5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 03:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oNMco5tAjl1a3GvBUWtghgZXjAYi71IVJGdFX+ipEzw=;
        b=PDysMpHUhfHG9QGU170VoKLHcEGPmIak3HNjueDV2mt2knWxI/FWDz/XGGyv1sDWUa
         Kyum6Xr8pwhfl2vY/agPPpmyOPn1SawK/BUHCiv2aZIwBzkg6EE9yYP4+opNeEG+Vw/i
         UffHPJ7Jfu75GZ1DVgVswQbYr4hKAKsXxK37k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oNMco5tAjl1a3GvBUWtghgZXjAYi71IVJGdFX+ipEzw=;
        b=omJicLksah5WLI2AOjAeFVi5gaumJDmsUaqmzpll4BHjLqxEv/y0ARLAXGS5x/5N6U
         O39WZESE4RTYSOVmN6vTRA06Q/jpljMLk3WghMyBzI5iSfMSkHvoIC6z1BLDYOxDI1mK
         rUCSbqXvDcOPg0glAJefUiwj5Upprb/zPnTGFsv+jO1rfvhdKZOWDqRCQZvtSj8nTFvc
         ufPSpvMmK8HBQVLuiFmryJVT0aWJwY77iyHgHLGy9G8+jZ61zrRq9snov1+l1VhHGaO2
         Fm01uAWsrp6B2hnYdPp3ZHDJtuEsR+e3hPIIIs8fswzGJR8CAcBR9Ydoeh2bOFC1WBI2
         FWNQ==
X-Gm-Message-State: AJcUukcrvLPDHbyrptHaJAYYqJMJduAT5VUQvQo+KBeN7vuIJNrvn6bO
        T1eEHPUBVeeB5S77cjdFYTGBAn7e+1VZf+1RRVNITA==
X-Google-Smtp-Source: ALg8bN5cR0AeFkyE2P8JBpOz3JyPq9cznqWgf6dTsOMeVRLFC4UXEGFRa2V7lfECj7DKAuAOJrW2bSHJFTv7GhZahwc=
X-Received: by 2002:a2e:568d:: with SMTP id k13-v6mr25898323lje.105.1548849395212;
 Wed, 30 Jan 2019 03:56:35 -0800 (PST)
MIME-Version: 1.0
References: <cover.1547445576.git.vilhelm.gray@gmail.com> <20190129170734.688a6adf91267cc6f1b5fa08@linux-foundation.org>
 <20190130101814.GA3668@icarus>
In-Reply-To: <20190130101814.GA3668@icarus>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 30 Jan 2019 12:56:23 +0100
Message-ID: <CACRpkdYuqU0YkEBoWdPAeuB7Ab8ERinVg_-yz6Q=vQVXFbvDRA@mail.gmail.com>
Subject: Re: [PATCH v8 0/8] Introduce the for_each_set_clump8 macro
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-arch@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 11:17 AM William Breathitt Gray
<vilhelm.gray@gmail.com> wrote:
> On Tue, Jan 29, 2019 at 05:07:34PM -0800, Andrew Morton wrote:

> > Do we have any expectation that these facilities will be used by
> > anything other than GPIO?  If not then perhaps they should be sited
> > within drivers/gpio (presumably as a standalone module) until such a
> > need is found?
>
> I can move it within drivers/gpio since my only use at moment is for
> these gpio drivers I maintain. However, moving it to the gpio subsystem
> does make it less likely to be seen by authors in other subsystems who
> may have use for it -- so there is the chance that this becomes isolated
> and untilized only amonst the gpio drivers. That may not be such a bad
> thing in the end; I suspect it will be easy to spot if other subsystems
> start implementing their own for_each_set_clump (if other subsystems
> would even have such a need for it).

I would sure prefer to have these in the generic core where this patch
puts them. I don't see the problem with that. We have to start generic
code from some point.

> Linus, if I move the for_each_set_clump macro and related functions to
> drivers/gpio, should I move the code into the gpiolib.h and gpiolib.c
> files? Or would it be best to implement this as a separate standalone
> module, and make a Kconfig dependency for those gpio drivers which
> require it? A standalone module feels somewhat overkill for such little
> code in my opinion.

Yeah. I was however thinking about that we should create a helper
library for port-mapped IO along the lines of gpio-mmio.c so we might
as well get started with that in that case, just call it gpio-port-mapped-io.c
and put these in first or something.

Yours,
Linus Walleij
