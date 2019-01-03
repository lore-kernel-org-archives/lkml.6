Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D03DEC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 17:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9847520815
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 17:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cjzrpj/S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731945AbfACRwG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 12:52:06 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33486 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728424AbfACRwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 12:52:06 -0500
Received: by mail-pf1-f193.google.com with SMTP id c123so17019747pfb.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 09:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yDz7QBjISpr2/aHFIwizHIIDXcaqwxB6hC8+SZOWP/0=;
        b=Cjzrpj/SYRCh77oTd6unz6v1o1fRXQfyDrIOTXXGHsRmNKEDp/hUYK8KVi1Xq9FC39
         PIfEDvMIJAxFdvKxHuGifLOTwmKCoKkGpeuW+NGac5CXAZSwxvZM80PB1aU0N0YlAafI
         1YU/HZVAy60g4jA/JEaJVh5vxXcLjEPfUVnjdPm7rINY1F5uvVookWMW+DcyWjEjKZj9
         NRjttIeig7ENxJwrYjN0Ge3qlMoZ/WRW5cPCIxRmhQZ22YfjHvErrSb2UpxmcVFenJfj
         OnbMdh8AcotpfI4NwHK88hA16PXY08AN88x8nhBtx9iefwc3Ll5YU5+ElGQ3qzudL65C
         bx9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yDz7QBjISpr2/aHFIwizHIIDXcaqwxB6hC8+SZOWP/0=;
        b=THT6cKD2iVz8CiffBVQqJTFNLh2gwbaNjC+S78eh72yQtCBKnnwMf/KWDwybfvqxyQ
         QEojyNCkl/T8/PcrOX81nyVoRyLds4prjaqpgGBL/mPr/lylUEEP5C96nhNtK6zdF2hI
         0RGRFqMHWhmu3aiSjlz6UAxDdZN6L5K0jC1KehT+3M3xP6BbO7LG0vdSz/lV4pVTDBZi
         PSZ1AZSHIsaC0QwLfbZdxd3GH9V/YBUaVxNppwSD/dge/eVrZF/TWOanakM8Jpvw9FDm
         J1apWCKZrZPpsQOcdRHeiFMdMeO3G0ctOk7b/mXyIlnzqjJU9iDw8C5bL2as1LfspxkI
         17Ig==
X-Gm-Message-State: AJcUukfhoO67dK9XKOwnDDTAwaBXvPR5jJ4l2FLRD21xBFmBss01bPkQ
        7R7ilBTHXQvVtUx0n1OX/S72NORG8/yL7DSAl9RHEu1i
X-Google-Smtp-Source: ALg8bN417ey2bSZMnQ9ofltp8fY8ruvdXELY6WXzIGlzq45Sx9FiS/M15kB2PoE+rOp5PU5bAj79EfG9rb2eOgP6ON0=
X-Received: by 2002:a63:fe0a:: with SMTP id p10mr17680040pgh.265.1546537925039;
 Thu, 03 Jan 2019 09:52:05 -0800 (PST)
MIME-Version: 1.0
References: <CABGGisxcHWwhUcQML7XmriK_DLFGjmud3cKt8yp+K4G2CAL=9Q@mail.gmail.com>
 <20190102185106.56913-1-swboyd@chromium.org>
In-Reply-To: <20190102185106.56913-1-swboyd@chromium.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 3 Jan 2019 19:51:53 +0200
Message-ID: <CAHp75VcRD__AhOM0sZjuNwsPGe-1_Cnreo+CSWgPrykFg_we1w@mail.gmail.com>
Subject: Re: [PATCH v3] driver core: platform: Add an error message to platform_get_irq*()
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Rob Herring <robh@kernel.org>, Andrzej Hajda <a.hajda@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 2, 2019 at 8:51 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> A grep of the kernel shows that many drivers print an error message if
> they fail to get the irq they're looking for. Furthermore, those drivers
> all decide to print the device name, or not, and the irq they were
> requesting, or not, etc. Let's consolidate all these error messages into
> the API itself, allowing us to get rid of the error messages in each
> driver.
>

Thanks,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>
> Changes from v2:
>  * Don't refactor platform_get_irq(), just wrap it
>
> Changes from v1:
>  * Update error text to indicate irq index instead of IRQn, use %u
>
>  drivers/base/platform.c | 31 +++++++++++++++++++++++--------
>  1 file changed, 23 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index 1c958eb33ef4..388461306dd4 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -79,12 +79,7 @@ struct resource *platform_get_resource(struct platform_device *dev,
>  }
>  EXPORT_SYMBOL_GPL(platform_get_resource);
>
> -/**
> - * platform_get_irq - get an IRQ for a device
> - * @dev: platform device
> - * @num: IRQ number index
> - */
> -int platform_get_irq(struct platform_device *dev, unsigned int num)
> +static int __platform_get_irq(struct platform_device *dev, unsigned int num)
>  {
>  #ifdef CONFIG_SPARC
>         /* sparc does not have irqs represented as IORESOURCE_IRQ resources */
> @@ -130,6 +125,22 @@ int platform_get_irq(struct platform_device *dev, unsigned int num)
>         return r ? r->start : -ENXIO;
>  #endif
>  }
> +
> +/**
> + * platform_get_irq - get an IRQ for a device
> + * @dev: platform device
> + * @num: IRQ number index
> + */
> +int platform_get_irq(struct platform_device *dev, unsigned int num)
> +{
> +       int ret;
> +
> +       ret = __platform_get_irq(dev, num);
> +       if (ret < 0 && ret != -EPROBE_DEFER)
> +               dev_err(&dev->dev, "IRQ index %u not found\n", num);
> +
> +       return ret;
> +}
>  EXPORT_SYMBOL_GPL(platform_get_irq);
>
>  /**
> @@ -142,7 +153,7 @@ int platform_irq_count(struct platform_device *dev)
>  {
>         int ret, nr = 0;
>
> -       while ((ret = platform_get_irq(dev, nr)) >= 0)
> +       while ((ret = __platform_get_irq(dev, nr)) >= 0)
>                 nr++;
>
>         if (ret == -EPROBE_DEFER)
> @@ -195,7 +206,11 @@ int platform_get_irq_byname(struct platform_device *dev, const char *name)
>         }
>
>         r = platform_get_resource_byname(dev, IORESOURCE_IRQ, name);
> -       return r ? r->start : -ENXIO;
> +       if (r)
> +               return r->start;
> +
> +       dev_err(&dev->dev, "IRQ %s not found\n", name);
> +       return -ENXIO;
>  }
>  EXPORT_SYMBOL_GPL(platform_get_irq_byname);
>
> --
> Sent by a computer through tubes
>


-- 
With Best Regards,
Andy Shevchenko
