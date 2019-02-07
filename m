Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 934F7C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 18:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60DD22086C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 18:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549565891;
	bh=bBX3EwODdAShoivNrsPGqnRyXm+QTs5nEtxPRMYSWsc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=y0jjOjeVknzcDxxnaL24tckVVAjSaK5v0mvLDNtWC8awUgBy4vIrT7L5jIEuJGFOn
	 nTySCHlAE6I9Nu3WOd+Bk2bOPbEr3gKJ41r1WlsG8Mas6WpDQyf+CqVgVxTfWoB7dd
	 RsQE2vtO3SXXJy4KhhAGrKSMmZWCITU/Q9CpDsxA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbfBGS6J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 13:58:09 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40967 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbfBGS6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 13:58:09 -0500
Received: by mail-ot1-f66.google.com with SMTP id u16so1621736otk.8
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 10:58:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qhPzPeOZSDEZKbEgk98I1WrMekcJdzrskIMPETDcPLk=;
        b=MuD8z2M+Mc1p/c/alyEYOoAFVsx4B2bFaeMwSOx10bvyB+scyhX8iiaaP5TFqavunm
         sgHQggBNNfOmOyxo8uHSP0Vplsir9SSpWz5yGZsMmwDsnWhTBj61AHAOe8uL+ekBy4Eg
         i1i9CJ0Y20EPsyn2wgAccvaxpGrnMrlDurHp1MaVQis7jA/TmskM+AMiZW0pCnAnT5/v
         JoKOpNzDb3+ZxX3FSvE2uaFubqcEH+7LPZGsLz8vKaSMIzoT6mbkisiPyWicXCBFHUSY
         Rcwq2m/p/mCJnaqEVleIPM/dTX/lIFtGcoipxxukHTlFkVfQCOXnB1wzIhKeC5+Or9xZ
         lbiA==
X-Gm-Message-State: AHQUAuZaM1t6SKfhXaHb4CGovM0M6OWqqYiGTi1Nrn0YejpJpNNwHJyU
        1SS3NSFkEDXQYF4yH6wTCbEbc5KiJIEmLa5O29w=
X-Google-Smtp-Source: AHgI3IZkPJ8FR3Hjta7S2cyfeN9sIUbw1bODwsY3qLypS2/IS5LMNe/iARpVLAhJuQPemknIsJtMBjfkIJOV/43NQt4=
X-Received: by 2002:a9d:2062:: with SMTP id n89mr1820939ota.244.1549565888382;
 Thu, 07 Feb 2019 10:58:08 -0800 (PST)
MIME-Version: 1.0
References: <20190207185043.158981-1-egranata@google.com>
In-Reply-To: <20190207185043.158981-1-egranata@google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 7 Feb 2019 19:57:56 +0100
Message-ID: <CAJZ5v0hJ2-_eiqGGrugk+bvsZ0Hmdybwz=7LQnx1nxO7KdbV8A@mail.gmail.com>
Subject: Re: [PATCH] driver: platform: Add support for GpioInt() ACPI to platform_get_irq()
To:     egranata@google.com
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        gwendal@chromium.org, Dmitry Torokhov <dtor@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Enrico Granata <egranata@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 7, 2019 at 7:50 PM <egranata@google.com> wrote:
>
> From: Enrico Granata <egranata@chromium.org>
>
> ACPI 5 added support for GpioInt resources as a way to provide
> information about interrupts mediated via a GPIO controller.
>
> Several device buses (e.g. SPI, I2C) have support for retrieving
> an IRQ specified via this type of resource, and providing it
> directly to the driver as an IRQ number.
> This is not currently done for the platform drivers, as platform_get_irq()
> does not try to parse GpioInt() resources.
>
> This commit adds that functionality.
>
> Signed-off-by: Enrico Granata <egranata@chromium.org>

Please resend this patch with a CC to the linux-acpi@vger.kernel.org
mailing list.

Thanks!

> ---
>  drivers/base/platform.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index 1c958eb33ef4d..c50c4f9033aef 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -127,7 +127,17 @@ int platform_get_irq(struct platform_device *dev, unsigned int num)
>                 irqd_set_trigger_type(irqd, r->flags & IORESOURCE_BITS);
>         }
>
> -       return r ? r->start : -ENXIO;
> +       if (r)
> +               return r->start;
> +
> +       /*
> +        * If no IRQ was found, try to parse ACPI GpioInt resources
> +        * as a last resort.
> +        */
> +       if (has_acpi_companion(&dev->dev))
> +               return acpi_dev_gpio_irq_get(ACPI_COMPANION(&dev->dev), num);
> +
> +       return -ENXIO;
>  #endif
>  }
>  EXPORT_SYMBOL_GPL(platform_get_irq);
> --
> 2.20.1.611.gfbb209baf1-goog
>
