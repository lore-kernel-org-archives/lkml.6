Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E6FC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 14:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 343452075C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 14:44:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tRGU+Wpo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbfBHOoZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 09:44:25 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39317 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbfBHOoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 09:44:25 -0500
Received: by mail-lf1-f65.google.com with SMTP id m11so2706433lfc.6
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 06:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d7mpthh9qbBpbstylm66N0YWNLkrVz8Hxq03Nwpfug8=;
        b=tRGU+WpouAW40ri0fonKY9shTTmpVfJsUFK8OPGchqNcyNHHH+ZLtN8ceJ0Pb/RkIx
         CpXmj+5qR03V5jjf06OxEmIDKzZWTSRIqEa4oxkGq/qv20x1McQ7tpLPkYk0p9UwS5Bz
         7Iz8GTk4ndvgpctuJZsbHkqhskrU00xKTMRwfuZJgNOIDGZXOJsI26ei3Qsm8G7uBPBG
         m7dikTXVBqAIa/qJCadxIByLBWTI7Su8LnBTRGA7NmIyluSoxAw6gKCmqIoWiMuAyjTE
         7n0TTnCRmvVQexm8C0m7+SF2X1G/L9/0hVyvF2a2kFdgh39PSdy9hWtBGNBCmPbeih/4
         mI1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d7mpthh9qbBpbstylm66N0YWNLkrVz8Hxq03Nwpfug8=;
        b=CoR0cldQf8/rTJAIK0rmVJaNFQcyX/rzaHM6zZl5NkVsP0A3EFeWIkoK4zEOJ+07uR
         lekD8IEf/7ljv3ArqE+CCZMEe0hDIs0KS/Zjny5mz0aAB6mYy32XskedQC1CwvCejrng
         qHwIkl7g9WIeDKR8qEAFKibeVpyctoMIEDBckECWdhYVqL6l9sO/xpacT4bpX5jJ+Aqv
         iUpK9fwWzgydrSibOTrvSef638zmBx/a0wNJtQMk1h5sALZIwYCHempJu6hU2GZIdu4a
         0AbktKhVzJ0DylRWGidW7TxP+IKNXkigtM/U2MiWPl/PvuXeWXdGNHmVqsXsbkZqlvYE
         9YdQ==
X-Gm-Message-State: AHQUAuY51JSDzFCLZYqa+y09ckfpFzsZXd55HLFyW42MhkluKc4Ftn4Z
        MHTPc8JYZwDayzYVsuZTPj+t7PfEXmejpc8FmmF+9w==
X-Google-Smtp-Source: AHgI3IYY9h+FaltqfUQ9+0nq3ZeHW7rM/WbXCg5gBoCOy/sjPk2jJAs6SzLR/NXfyMqApauWcc9a6PWQilXm2yMccKI=
X-Received: by 2002:ac2:4219:: with SMTP id y25mr13585359lfh.130.1549637063340;
 Fri, 08 Feb 2019 06:44:23 -0800 (PST)
MIME-Version: 1.0
References: <20190208115201.7518-1-thomas.petazzoni@bootlin.com>
In-Reply-To: <20190208115201.7518-1-thomas.petazzoni@bootlin.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 8 Feb 2019 15:44:11 +0100
Message-ID: <CACRpkdYe2r_HC=sUjW8K0vsLucVe6aVC-SKS++Kw6zryXuuzRg@mail.gmail.com>
Subject: Re: [PATCH 0/3] gpio: drop a few unneeded irq_{request,release}_resources
 implementations
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 8, 2019 at 12:52 PM Thomas Petazzoni
<thomas.petazzoni@bootlin.com> wrote:

> Three GPIO drivers in the tree implement the
> irq_{request,release}_resources hooks with what is in fact the default
> implementation provided by the GPIO core, making this driver-specific
> code redundant.

So you could think!

But the GPIOLIB_IRQCHIP code only kicks in if the GPIO driver
is using the gpiolib irqchip helpers, i.e. calls gpiolib_irqchip_add_*.
And those three are the ones that still have to implement their
own irqchips.

The helpers did come about because all drivers started to
duplicate code like this.

The designware chip should ideally be converted to use
hierarchical irqdomain since that seems to be what it is doing,
but I think the hierarchical irqdomain didn't even exist when that
driver was submitted.

Yours,
Linus Walleij
