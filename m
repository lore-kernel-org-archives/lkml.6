Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E18C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 07:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 856F12098A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 07:26:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 856F12098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbeJKOwu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 10:52:50 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:46693 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbeJKOwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 10:52:50 -0400
Received: by mail-vs1-f66.google.com with SMTP id i10so7551299vsm.13;
        Thu, 11 Oct 2018 00:26:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Av5hR24ThmTBwKmPzSxPVDugHipgNv4xoiZsvxVln+Y=;
        b=lfiRPmGNtuYjd1kl6UYbb1TMz2wHobGFy5Da4dkAbKWtmeRQS0zKdEEcbvsfAy8ZTU
         ckeVJXRSXHVoP8xC650jluU0tsd/xy3+U7g1Vh+Bi6WHf1o1H2ncI4xLp1HyK8suUboS
         Ijwgi7I4d3txb0YlBuUR1BGfEyCPbE0C0Dgp1+EFn5nkMA56mGLAAp+nE/tNX0R/TGSA
         /YB8/31/efeeLgPN3NOKcZ0PBzDOvenpCZdjaIMZT26B76/mI/6bGqZgePNHFy1i4GOl
         aoZzf+zdnDQUvxORX8hPFD2HQ32MEJfgFYeXL2lnLffM0Tob4M7q67VarfqTQt5uf4Bq
         F0BA==
X-Gm-Message-State: ABuFfoib4+WaKkkTvAMply/VxSMC9v6dPzpTc58RSM2wxw0kGwmbibWe
        WDZEGWoWMoNJ9oCAMWrxcjnGhKmtOE16L58z7Xk=
X-Google-Smtp-Source: ACcGV60Gxxu9kSYfDCkzbrPvzsLNYJzspAV6YD4tJ9m4Zebwv4sT/G/T+4fnvVv5fxTaTonjvdwkk5AHXVme3gKk5LI=
X-Received: by 2002:a67:e015:: with SMTP id c21mr155747vsl.63.1539242810523;
 Thu, 11 Oct 2018 00:26:50 -0700 (PDT)
MIME-Version: 1.0
References: <20181010170936.316862-1-lkundrak@v3.sk> <20181010170936.316862-10-lkundrak@v3.sk>
In-Reply-To: <20181010170936.316862-10-lkundrak@v3.sk>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 11 Oct 2018 09:26:39 +0200
Message-ID: <CAMuHMdWJ1YN-_HKbXHH_zhJcG23-9ZnXn3hfV=4bPQHbV6No3g@mail.gmail.com>
Subject: Re: [PATCH 09/11] dt-bindings: spi/spi-pxa2xx: Add ready GPIO signal
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>, quozl@laptop.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-spi <linux-spi@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lubomir,

On Wed, Oct 10, 2018 at 7:10 PM Lubomir Rintel <lkundrak@v3.sk> wrote:
> This this is used to let the SPI master know that our FIFO is filled and
> we're ready to service a transfer. Only useful in slave mode.
>
> A signal like this is used by an embedded controller on a OLPC XO 1.75
> machine, that happens to be a SPI master.
>
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

Thanks for your patch!

> --- a/Documentation/devicetree/bindings/spi/spi-pxa2xx.txt
> +++ b/Documentation/devicetree/bindings/spi/spi-pxa2xx.txt
> @@ -12,6 +12,8 @@ Optional properties:
>  - cs-gpios: list of GPIO chip selects. See the SPI bus bindings,
>    Documentation/devicetree/bindings/spi/spi-bus.txt
>  - spi-slave: Empty property indicating the SPI controller is used in slave mode.
> +- ready-gpio: GPIO used to signal a SPI master that the FIFO is filled

ready-gpios

Documentation/devicetree/bindings/gpio/gpio.txt:
   "GPIO properties named "[<name>-]gpio" are valid and old
    bindings use it, but are only supported for compatibility reasons
and should not
    be used for newer bindings since it has been deprecated."

> +  and we're ready to service a transfer. Only useful in slave mode.
>
>  Child nodes represent devices on the SPI bus
>    See ../spi/spi-bus.txt

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
