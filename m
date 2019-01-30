Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CAF5C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39A5C20882
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:45:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="X2nQ9RDc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730400AbfA3JpM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 04:45:12 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46186 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729227AbfA3JpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 04:45:12 -0500
Received: by mail-lf1-f67.google.com with SMTP id f5so16849191lfc.13
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 01:45:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IHYDpmbEo5hTGFgl7UscPI40cBT4uBEAauRqHmh6yPM=;
        b=X2nQ9RDcrW19PNss7xXsk95Ag8XJBTwoU9IKQlLVtYXKK/c3n9bMZMCIPtV847v7Ok
         4Jnwp25v69wlCm9CTGaGDDf3J7dkmRSo3l/51bKKFWSdHBgpEr9cVpxqSHKjWDEfQghl
         whieKtNUc2fY0roXkEG2c3oqomK64geJjZRkY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IHYDpmbEo5hTGFgl7UscPI40cBT4uBEAauRqHmh6yPM=;
        b=Jbcd9F70T0x1LWCKXyXmVRP7jEnyxUl7GG1SwKM2FB5WDz3QN32jfB13ef3HieYUpn
         Gp8E96pOamcWSKxp0OtrhuwD2vs3GriqaPHGbJ5Ecyvvq2KMTuq2EuEQEmLTggNoa+/D
         ihWghJ/Ih9VdY4JZL8GYMBKMWjVI3bfMpqLcMxYm48VIzqa0mtDrXkwsDaq05TK8YeUx
         tQDIPKjlsieaEzt4m31qQbvEeQyjNrYMRNeubghVlFLJVyv1ls4Dba79Z/VuD0CGTH4B
         yQuCisC65S0oRW2GiJviyCcrVzRxDPLz6dAAvOKua3UUBffd4iAmu+X4uQGctHjsLyP6
         DNpg==
X-Gm-Message-State: AJcUukc+TVdnZlXVIvPUjh7OEcfQy8dz2cWNu3Hy6X5hyPGdKjN7NB81
        NzjqFeJ1tf7WXWM3iasJwzCdH5c+fNDoBxodogc49w==
X-Google-Smtp-Source: ALg8bN6tYYioQsOEzdhAWlrtMCm0zqehL6JWXmn2G0ozwbCoG75haDetRYkSY1wb/rnG8Z8heJNrUVW8x0XShTLNYOE=
X-Received: by 2002:ac2:53b1:: with SMTP id j17mr22369995lfh.167.1548841509880;
 Wed, 30 Jan 2019 01:45:09 -0800 (PST)
MIME-Version: 1.0
References: <cover.1547445576.git.vilhelm.gray@gmail.com> <20190129170734.688a6adf91267cc6f1b5fa08@linux-foundation.org>
In-Reply-To: <20190129170734.688a6adf91267cc6f1b5fa08@linux-foundation.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 30 Jan 2019 10:44:58 +0100
Message-ID: <CACRpkdZi1BHUq4mT==5OOepq=o4Pus1=DJBY-fWBZyjG5bdpoA@mail.gmail.com>
Subject: Re: [PATCH v8 0/8] Introduce the for_each_set_clump8 macro
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>,
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

On Wed, Jan 30, 2019 at 2:07 AM Andrew Morton <akpm@linux-foundation.org> wrote:
> On Mon, 14 Jan 2019 15:19:17 +0900 William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> >  drivers/gpio/gpio-104-dio-48e.c   |  73 ++++++--------------
> >  drivers/gpio/gpio-104-idi-48.c    |  37 +++-------
> >  drivers/gpio/gpio-gpio-mm.c       |  73 ++++++--------------
> >  drivers/gpio/gpio-pci-idio-16.c   |  75 ++++++++------------
> >  drivers/gpio/gpio-pcie-idio-24.c  | 111 +++++++++++-------------------
> >  drivers/gpio/gpio-ws16c48.c       |  72 ++++++-------------
> >  include/asm-generic/bitops/find.h |  14 ++++
> >  include/linux/bitops.h            |   5 ++
> >  lib/find_bit.c                    |  81 ++++++++++++++++++++++
> >  lib/test_bitmap.c                 |  65 +++++++++++++++++
> >  10 files changed, 307 insertions(+), 299 deletions(-)
>
> It's a shame that it doesn't actually dercease the kernel line count,
> but there are other benefits.
>
> The patches are missing the hoped-for acks, but I think you maintain
> most/all of those drivers.

He does, but FWIW:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
