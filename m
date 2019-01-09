Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA081C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93A6720859
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:55:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PufgkLK6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbfAISzM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 13:55:12 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:35103 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbfAISzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 13:55:11 -0500
Received: by mail-oi1-f193.google.com with SMTP id v6so7184290oif.2;
        Wed, 09 Jan 2019 10:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l23tRoJyNH/aRGl6SY9XuO7gGDTC9LhKkPqoiQNNxj0=;
        b=PufgkLK6tFkM5345Cseqs8mNxahheiCAek6p+7FjmsK1s5rbiWT8sv5uSO3fhfwinb
         euM+Us8wKnus10hNbPH2gjYgEHCZQq+Sfhnux5IT4W7Gn4c56R/AaynlVS733xff1Aia
         tLFG8quFva5UzvLRVg29r+rQj62heiLBR8dJcAAwVhgIaD4NwJZR6GnsnXRfr7LYpnPc
         dFUCPIGjBBlPrv+bqRXT5PYRilgvJtRtok863mDYz8nS7e7rwZmbta2owV9dDSFnRb9p
         2DgDshszHFoi/p/dCcO3yyqKEUtgYPbHh84iNbXDtE2hpyz7kDeQimf5VTFPLZTIPnwq
         XNKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l23tRoJyNH/aRGl6SY9XuO7gGDTC9LhKkPqoiQNNxj0=;
        b=YnDSzMVWUHh9imyxMk+K/osKQoMCcxh1WBwm5478BBYeuaAC+O3dolgvwkIXDh1X0o
         X31BKNDhGPMNGlgLA+2yeFgYN9Gv9Thrk/NHRRxFC0T4iiUsdHyO4s960nYGSjHJeNap
         WHiMzW4ytczNSNshilQdUXBmNcskeyNOBPNB4lDOSxPkSffCelKCP6RvZ3D7Dl3H40gf
         A9OFDLZlGGoeqfEps6jWvEm+I2FkH333oEu0MA3jLnxW3D8JhAv0SnPyyK7s3hXTeQ/b
         U9LbwI1WAQqTtWxOeoowEknw1VGvWT/GPxvu5qkaJMhwlXrCYdAuICp7iVL90Dg5sznA
         T3cA==
X-Gm-Message-State: AJcUukfNuab88jnF3SJky86KHKYUPT+GlUSeQXipDQdcIrXRgS+WDQam
        7xPGj2gWOX/CA372BPmCBStH1lO/ojSEpjPtxwnrqvFj
X-Google-Smtp-Source: ALg8bN5ZqdSTEtt70rNxGq0xw0PF7lDYOtkNEuLx+mAQj74V5FZowtROENJbsEgGyM18FBHEPoFSVex44w/T/gvwquM=
X-Received: by 2002:aca:5b88:: with SMTP id p130mr4415551oib.96.1547060110599;
 Wed, 09 Jan 2019 10:55:10 -0800 (PST)
MIME-Version: 1.0
References: <20190101194414.24766-1-martin.blumenstingl@googlemail.com> <20190101194414.24766-2-martin.blumenstingl@googlemail.com>
In-Reply-To: <20190101194414.24766-2-martin.blumenstingl@googlemail.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Thu, 10 Jan 2019 00:24:58 +0530
Message-ID: <CANAwSgQVaeAb5ta+zC6Fhc3xLjSCMY5-XzQpK7SwdS4LNAYfNA@mail.gmail.com>
Subject: Re: [PATCH 1/1] mmc: core: don't override the CD GPIO level when
 "cd-inverted" is set
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-mmc@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        bgolaszewski@baylibre.com, linux-amlogic@lists.infradead.org,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

On Wed, 2 Jan 2019 at 01:14, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Since commit 89a5e15bcba87d ("gpio/mmc/of: Respect polarity in the device
> tree") gpiolib-of parses the "cd-gpios" property and flips the polarity
> if "cd-inverted" is also set. This results in the "cd-inverted" property
> being evaluated twice, which effectively makes it a no-op:
> - first in drivers/gpio/gpiolib-of.c (of_xlate_and_get_gpiod_flags) when
>   setting up the CD GPIO
> - then again in drivers/mmc/core/slot-gpio.c (mmc_gpio_get_cd) when
>   reading the CD GPIO value at runtime
>
> On boards which are using device-tree with the "cd-inverted" property
> being set any inserted card are not detected anymore. This is due to the
> MMC core treating the CD GPIO with the wrong polarity.
>
> Disable "override_cd_active_level" for the card detection GPIO which is
> parsed using mmc_of_parse. This fixes SD card detection on the boards
> which are currently using the "cd-inverted" device-tree property (tested
> on Meson8b Odroid-C1 and Meson8b EC-100).
>
> This does not remove the CD GPIO inversion logic from the MMC core
> because there's at least one driver (sdhci-pci-core for Intel BayTrail
> based boards) which still passes "override_cd_active_level = true" to
> mmc_gpiod_request_cd(). Due to lack of hardware for testing this is left
> untouched.
> In the future the GPIO inversion logic for both, card and read-only
> detection can be removed once no driver is using it anymore.
>
> Fixes: 89a5e15bcba87d ("gpio/mmc/of: Respect polarity in the device tree")
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  drivers/mmc/core/host.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index f57f5de54206..cf58ccaf22d5 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -234,7 +234,7 @@ int mmc_of_parse(struct mmc_host *host)
>                 if (device_property_read_bool(dev, "broken-cd"))
>                         host->caps |= MMC_CAP_NEEDS_POLL;
>
> -               ret = mmc_gpiod_request_cd(host, "cd", 0, true,
> +               ret = mmc_gpiod_request_cd(host, "cd", 0, false,
>                                            cd_debounce_delay_ms * 1000,
>                                            &cd_gpio_invert);
>                 if (!ret)
> --
> 2.20.1
>

Please add my.
Tested on Odroidc1+ and Odroidc2 both booted up fine.

Tested-by: Anand Moon <linux.amoon@gmail.com>

>
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic
