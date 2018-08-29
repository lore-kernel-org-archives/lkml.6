Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44854C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D830820850
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:09:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cvAiSkJZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D830820850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbeH2QG2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 12:06:28 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:33785 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727562AbeH2QG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 12:06:28 -0400
Received: by mail-it0-f65.google.com with SMTP id j198-v6so4931524ita.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 05:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gtU6YyhgXVj7dccZ3H+KpHZdMVIScyinN3wtISC1poA=;
        b=cvAiSkJZe2pCoues+D6TOR/DIaUkvEFcgQJs/hsbsJuuHGBDQKFK/w74clDcDWd4CI
         D8pFxcj94OxAW4iG0xYu/CjyX9u4rK+hlwtEaNwDcMKkDro0MFqn+kw7XjztcDXQg5pC
         1H3AmTMvjdlrTl0i/qr1WSdISeyp7UborI8iI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gtU6YyhgXVj7dccZ3H+KpHZdMVIScyinN3wtISC1poA=;
        b=tzfZbVOxHWWUI/IZp1qPtVIYj3oD5UI4lrwQkK6GklHHhCIwdlkXk7RZIPpuVHe2hb
         WSNIq554+dOhZzzTklPrCWtPznELrCRzoRZDSFKIYid8f6HASm6BvTxavzVp3cgxdaCi
         AtoKrJPJAmCGD9hTjFWKuPcgrfedUx45gaEc5YzzT33aqInui2Ix0pSvi0myOLUJY1Ks
         Pzo3hJC4EUon2B5YpalyEN/8MIHwBcIzEPtMju//ZXwsyNh9hWovzXbMipbTQ/NlstJ1
         9ROvgAilYW2kY7ZG3IBlftz6cnwDjzybI03pIZ9C7/NU6WLjoxtXSR6+zLW3K+OLg9m9
         Tk/w==
X-Gm-Message-State: APzg51B2AEcHz6Mu0nJNbBRPFiHZSk8RjtZ/GpUZvVHnBl2lbnDoZ4E8
        3MSy5MYcUJt9rNFFuQ4srpGMd1+UZp3w4/ZEI2U9dw==
X-Google-Smtp-Source: ANB0Vdb2nOC/gJ/4AlD9fakDgFz0Z6eTX7NUlqqpXCcZfWEMkPiylLaMFcG6ChM2lGxJVSojnHYCZvvaJOC5K5nlQNI=
X-Received: by 2002:a24:144:: with SMTP id 65-v6mr4668022itk.62.1535544591542;
 Wed, 29 Aug 2018 05:09:51 -0700 (PDT)
MIME-Version: 1.0
References: <1533522556-55055-1-git-send-email-aditya@kobol.io>
 <1533522556-55055-2-git-send-email-aditya@kobol.io> <CACRpkda2qXxyEj+y8DaZ-_PWcj3pBGtvVAac8qaFCnC0LTNkNA@mail.gmail.com>
 <20180829100229.7566e0db@windsurf>
In-Reply-To: <20180829100229.7566e0db@windsurf>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 29 Aug 2018 14:09:37 +0200
Message-ID: <CACRpkdZU36s=-G7ncW3JMb+vXDmpdLO+3zupQD_fwUyfZxx4vA@mail.gmail.com>
Subject: Re: [PATCH RESEND 1/2] gpio: mvebu: Add support for multiple PWM
 lines per GPIO chip
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     aditya@kobol.io,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Jason Cooper <jason@lakedaemon.net>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Richard Genoud <richard.genoud@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        gauthier@kobol.io, Alban Browaeys <alban.browaeys@gmail.com>,
        linux-pwm@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dennis Gilmore <dennis@ausil.us>,
        Ralph Sennhauser <ralph.sennhauser@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 10:02 AM Thomas Petazzoni
<thomas.petazzoni@bootlin.com> wrote:

> Andrew Lunn did the initial support for PWM in this driver, and he
> outlined in the commit log the limitation of his first implementation:
>
>     However, there are only two sets of PWM configuration registers for
>     all the GPIO lines. This driver simply allows a single GPIO line per
>     GPIO chip of 32 lines to be used as a PWM. Attempts to use more
>     return EBUSY.
>
> Andrew, perhaps you could review the patch posted by Aditya, since you
> already looked at PWM support on mvebu platforms ?

Thanks yes Andrew is involved, I will wait for Andrew's definitive ACK
before merging any of this.

Yours,
Linus Walleij
