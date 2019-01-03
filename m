Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1192C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 09:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF6C921019
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 09:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546508439;
	bh=LcvrV+8gSqLyFm7j5686I48r3/GUsefGtC39Ms0MUc0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=doORxhPbo6VyK0aSsPLIvcjMmn9Y+w9xMj7cu58+UAHN23reeaeNg7Am8j9yGw+kK
	 HCDf4m6a/BDzSz2hx885msS22FivOi3Wfas3pQ7ZDhReJzmCptTLwlMGFMgW4x3UAT
	 RprUQFQgOnvIunMDMVpObKkiwT/hu299LfKGBWPg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730559AbfACJki (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 04:40:38 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45132 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730544AbfACJki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 04:40:38 -0500
Received: by mail-ot1-f66.google.com with SMTP id 32so28875714ota.12
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 01:40:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LNsMCQvi3YESu2jFZko6wer3qJnV5q2cyJUAqddcti8=;
        b=G5Me+Ef/4Iz8ociIMOBbj2Xx4HlfIAHCBXPwkv9XjQfal2BbewCC0aWA0R3kdaP/xr
         GOkyMUmu3tyieos5jebxCa+2Btzg+uWKhMBCBFsPoBhbxnRVEmmuQtDDJce+4jAQyAyJ
         XkP3DLU3E9U4Om7N6gvybVH9GyYXHjuYUPQgwgmgmuKA3ZLbDquidLt5Iib9W4ROiWgh
         PxUMyO58l40pHN87nYdcjhpWr8W0aIEfL8glCjgZ4xn4wJ3luSHljMsse1gubpqd0qyP
         fs2OPaOkpIoC0OHUt8aLECSl5+yr1SgSNWK5g88N+e/45Yasy2dtpK+75oh7y5/9SPwR
         qZ5w==
X-Gm-Message-State: AJcUukcLFttWRJifkCCYIP6x6PNy267Cs4QWduRuohUWbSAKEC3xbOcp
        s6sXm1sWMW10J+mNcklBz6pUQx0CIwem1z8RYpg=
X-Google-Smtp-Source: ALg8bN5bNQVyXhI+pGRbcezUF6FdCyaOh0kU5aOHChNz9GMRIj1A6Qmo5giOMg5RXpXBxuSuOs8CSdB/o2l/od2QHAs=
X-Received: by 2002:a9d:7f0d:: with SMTP id j13mr30890239otq.119.1546508437044;
 Thu, 03 Jan 2019 01:40:37 -0800 (PST)
MIME-Version: 1.0
References: <CABGGisxcHWwhUcQML7XmriK_DLFGjmud3cKt8yp+K4G2CAL=9Q@mail.gmail.com>
 <20190102185106.56913-1-swboyd@chromium.org>
In-Reply-To: <20190102185106.56913-1-swboyd@chromium.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 3 Jan 2019 10:40:26 +0100
Message-ID: <CAJZ5v0iL_Fq0RUbLjMj9WBitDw2amNV_ybirkiPbuYb0zroGAg@mail.gmail.com>
Subject: Re: [PATCH v3] driver core: platform: Add an error message to platform_get_irq*()
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Rob Herring <robh@kernel.org>, Andrzej Hajda <a.hajda@samsung.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        javierm@redhat.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 2, 2019 at 7:51 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> A grep of the kernel shows that many drivers print an error message if
> they fail to get the irq they're looking for. Furthermore, those drivers
> all decide to print the device name, or not, and the irq they were
> requesting, or not, etc. Let's consolidate all these error messages into
> the API itself, allowing us to get rid of the error messages in each
> driver.
>
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

Why don't you log the error code too?

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
