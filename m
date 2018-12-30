Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B074C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 10:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26C6020866
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 10:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gy1v4zbX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbeL3Kmx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 05:42:53 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39101 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbeL3Kmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 05:42:52 -0500
Received: by mail-pg1-f194.google.com with SMTP id w6so11765463pgl.6
        for <linux-kernel@vger.kernel.org>; Sun, 30 Dec 2018 02:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0XgghK1nd2s2qo2RWUpMVObrnXaajFF0lB8CRb1jtwQ=;
        b=gy1v4zbXScgnaff6he+BmRb6STOERDK/cAPglgOxhXuNBOvl8kqC+X/Dm7XmRyxiTY
         O9VJJOT0UdKQs3hGQkLkZrgBixCafhvYWSumrValDFYqNkJhCTMLFkGJ8DhvT892CbG1
         0L+uLsDNhwaLuharBcklhagccgk37Qc8gmWyM68ugr7RNxDex6GvrEc/KkTuV3q9b59M
         w9ZKK9sS95N2IqA2Ew+jlnWOyhBiuApGOCPVaMJAEPp6xXpvo8wFOGpbKshNOmaEvVhW
         IFoTcPYe4J+5+cDuWJRtgLqNx880nHFAZnODtsWV46NDQJC/6DD6JeW8aEcxVqP+d9PH
         S1KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0XgghK1nd2s2qo2RWUpMVObrnXaajFF0lB8CRb1jtwQ=;
        b=aaEahHyFxhO/da16b6lOdRXjMtc2z5xSeCNkt4gJgcOHGpLYvyauGEI3oNpNC1zof0
         QW4g17UwQR1fwMCouf3gzYNRcV4KU+MB4gSJM5IjGe3HyJnPvyOlDTvvt4ySnbWTVuWV
         dpb3kCyOgGGnOBuNrPGZsNgtvhV1CEcWFTdEYG6PEwW/Z+wwyicEUMkf8U17k42HOK6m
         /W7QpQiyd68b27vGetlyqaPXpIfRgWuve23uBE2vKXxzzTP39rYIOh+cf/t6q1TYKXHA
         1FASa2jFjPeeGbEXfABrUS/Jrxvk/3NBV5GU49jEYGqzp/YmZli9syBrXRMl8kXRNGXB
         488g==
X-Gm-Message-State: AJcUukeRuy3x9/CI8LbGx88AC3QjAC580+SVFHmyri9agfOfby3iIp16
        NaD2qyMVsOajPIHi0sIZMEYEjVwRSGBHLtr0jtg=
X-Google-Smtp-Source: ALg8bN696aSK9qlYReLCuD7oSB0tO2TFFr/sQab2hDnuHaUv5jjc+ui1jJWM4BKbm6bbbNxQhD4LDJq3eqc7cuZWIOs=
X-Received: by 2002:a63:fe0a:: with SMTP id p10mr4125571pgh.265.1546166571329;
 Sun, 30 Dec 2018 02:42:51 -0800 (PST)
MIME-Version: 1.0
References: <CABGGisxcHWwhUcQML7XmriK_DLFGjmud3cKt8yp+K4G2CAL=9Q@mail.gmail.com>
 <20181228215620.120672-1-swboyd@chromium.org>
In-Reply-To: <20181228215620.120672-1-swboyd@chromium.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 30 Dec 2018 12:42:39 +0200
Message-ID: <CAHp75Ve9YSPy14hwKOsjChZ6JhRYokLqm-RNs6xgu-RG-5QctA@mail.gmail.com>
Subject: Re: [PATCH v2] driver core: platform: Add an error message to platform_get_irq*()
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

On Fri, Dec 28, 2018 at 11:56 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> A grep of the kernel shows that many drivers print an error message if
> they fail to get the irq they're looking for. Furthermore, those drivers
> all decide to print the device name, or not, and the irq they were
> requesting, or not, etc. Let's consolidate all these error messages into
> the API itself, allowing us to get rid of the error messages in each
> driver.

> +static int __platform_get_irq(struct platform_device *dev, unsigned int num, bool warn)
>  {

> +error:
> +       if (warn)
> +               dev_err(&dev->dev, "IRQ index %u not found\n", num);
> +
> +       return ret;
> +}
> +
> +/**
> + * platform_get_irq - get an IRQ for a device
> + * @dev: platform device
> + * @num: IRQ number index
> + */
> +int platform_get_irq(struct platform_device *dev, unsigned int num)
> +{
> +       return __platform_get_irq(dev, num, true);

Hmm... Why not just  do
int  ret = __plaform_get_irq();
if (ret)
 dev_err();
return ret;

instead of big refactoring of platform_get_irq()?

>  }



-- 
With Best Regards,
Andy Shevchenko
