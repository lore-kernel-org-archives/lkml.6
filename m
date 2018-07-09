Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8EB1C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F6E420652
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ErPahDUs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F6E420652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932956AbeGIMS2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 08:18:28 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:34359 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932755AbeGIMSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 08:18:24 -0400
Received: by mail-it0-f66.google.com with SMTP id d191-v6so11640341ite.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 05:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LxJB9exLTqHPCZPpUzRB33nXi9BE/en/41rUPryhPkc=;
        b=ErPahDUsxLLfBaaha3qJk/8QNpe5Ua2A4MPKT0OTDjNTo3Lcw2ukb5sScd4jjQPmQa
         htm1C5/uyBTujU//0oXjf99asQpztzcNNAtwnSyjuTB6BJdkwni6CGqNW20xMADC5NkN
         /9aCnVoxLbB02cAs19irqOljHc1g6bQTR/cgI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LxJB9exLTqHPCZPpUzRB33nXi9BE/en/41rUPryhPkc=;
        b=EqREHBlynLPnZWjYAiuEAxXQ/hbyVFdoSRMAtBeWan/yJ/hNRv7k0Dff91yNb537IE
         TWnsV8OKDY0u2Y6evgs9uXhyslTrkuavxZLNcXTiX5l0ZQWZrbl2dn8isJkgFYn13S8O
         XMGU5ufTKF3sMxqAbGsGCfJy/KUMBpj3YocQnvqWnzgeRW21MJTylzlteWSF0jAh1fJ/
         kkUf1hkpulhwDrEfTrdGWpFxW7HujqbVtO6CRnX56A1ppwfYShO/hUg8guMYcK9t1j5y
         uv8bXEkqOWIPzyP0geyesqoebbhTwBPPFpmu9e7ed4v8Z41T73rQ/EyOgcCEDUj1VxmR
         xssA==
X-Gm-Message-State: APt69E1n0jQL+li49ZpZ9wCXFpS1y+77zF9dsIxk4fV6qTjx7qs8p23g
        gKT+OCTPCjJ88eVCNiHXm4V5/aCs8X45tQfMFoLhyA==
X-Google-Smtp-Source: AAOMgpeHnLed1IVFW1VqC3yQG0QnbVANA1nZRyI3TPyghXlnM6SOYOdEaHEJj0Vv0Bx406ILCpfhZahn3xKGrZYf5R8=
X-Received: by 2002:a24:5004:: with SMTP id m4-v6mr15530575itb.38.1531138703954;
 Mon, 09 Jul 2018 05:18:23 -0700 (PDT)
MIME-Version: 1.0
References: <20180627114904.10890-1-paul@crapouillou.net> <CAHp75Vc3QTYKp6oS6kW6EezsBbiLf9E=NBErHMbpxRU9EXMxWg@mail.gmail.com>
 <1530213066.3755.0@smtp.crapouillou.net>
In-Reply-To: <1530213066.3755.0@smtp.crapouillou.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 9 Jul 2018 14:18:12 +0200
Message-ID: <CACRpkdaLE-XZ08CqRdFbW3AodUHKa=CdMtfO6Lic_j--BBet-g@mail.gmail.com>
Subject: Re: [PATCH 0/5] pinctrl_gpio_get_direction & ingenic fixes
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 9:11 PM Paul Cercueil <paul@crapouillou.net> wrote:

> Sure, it'd be pretty straightforward to do it from the GPIO driver, but
> I'd still like to hear Linus' point of view about this.

I'm not sure about it, I guess it would be my second choice.

> As for merging pinctrl-ingenic.c and gpio-ingenic.c... I wouldn't
> disagree more,
> even if they share registers, they belong to different subsystems.

We actually have many pin control drivers also exposing
a GPIO chip. (Or several.) The way I see it is that we use
two kernel APIs for the same hardware, but one hardware
piece should still just have one driver, albeit exposing two
interfaces.

We actually also have serial ports and wireless network
cards exposing random GPIO chips because they happen
to have some arbitrary GPIO lines up for grabs.

So it is not just for the pin control and GPIO usecase, it is
for any usecase where the same hardware has something
plus a GPIO API. Pin control with GPIO as front-end is
special by being jitted together with the ranges though, so
they are closer related.

A good reason to keep it together in one driver is e.g. that they
have common clocking, so otherwise two drivers are grabbing
the same silicon clock and enabling/disabling it, runtime PM
would be a mess if both drivers start to request prepare
enable disable clocks at the same time etc. (I don't know
if this applied to Ingenic.)

> Besides,
> your platform might need the pinctrl driver but not the GPIO one, or
> you might
> want to provide the GPIO driver as a loadable module, etc.

I understand that concern. I think it's as nice with one
loadable module for pin control and GPIO at the same
time though, especially if the split is anyways kind
artificial between the two APIs.

Yours,
Linus Walleij
