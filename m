Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B3BC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 864FB2229F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:26:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XTzPoKIy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731450AbfBKT0K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 14:26:10 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34588 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727036AbfBKT0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 14:26:09 -0500
Received: by mail-lf1-f66.google.com with SMTP id u21so60350lfu.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 11:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V2i5dQohXwkk/11sF9DkwRklzfG7svF3/anaXvXtaBs=;
        b=XTzPoKIyFle/OIHGmG7eXkvyYNvgPAdFBaC6HNb2/zlxkW3b7FBdIzhWTGxECwW3Or
         PHBIjVHE8Ogc/MNfAMMaL+wAEHB/prSHDUtLzSyCPYZiLsjU03MDT1zhiVPYQTOR7BW6
         9PKmzN4T44xz3Xt316r3aWPZdXGoii16GOtfw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V2i5dQohXwkk/11sF9DkwRklzfG7svF3/anaXvXtaBs=;
        b=RedPcmpE9Mo0y/BRfgPRsxQkUZLy48emBh1aVlnX0Ju0OQ5KPDXaeP5BgDw1wpONDy
         CP0+sXQ8nNwiJyI6mt6pSHiJ8KMNm8Y16YMEi5bNFdVAX3vY83tQ48AiX2Js7F+UBSso
         Hj6mxNwlyBqX8hkdjA5mSenXpXwzLGz2VoPZESl+tRQvC8oYX5vzqQvqrrWEGhAf+XPB
         OgE1hjDaN2aZ4ajsCa1y0Qn3mb3hDOnudFb35IOpNb6pPs19xPWYgZVUUi8SGGe0GUmj
         CxXTfzhPm24oO7u/wzxZ60tQge5hD1mtq54xYawgP5Ju597npjYN7IKrua87V6BImhUb
         exUw==
X-Gm-Message-State: AHQUAuawcYwvRaGoyneQgDpARUECJhUt1kl6OFSuR7h0JiD2qDWWNQ3U
        VmC2rDDneCGzYS6VvxOFKhLiKAVqYsg=
X-Google-Smtp-Source: AHgI3IZkqZFKmisYXyMpvE1W4y+w1ejTQOFHX68EX9CdlrOUtf7J+37eXh13tNzVZcUElyC8k1BoGw==
X-Received: by 2002:ac2:5335:: with SMTP id f21mr17895742lfh.85.1549913166998;
        Mon, 11 Feb 2019 11:26:06 -0800 (PST)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id h22-v6sm2316034ljh.89.2019.02.11.11.26.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 11:26:06 -0800 (PST)
Received: by mail-lj1-f171.google.com with SMTP id j13-v6so60286ljc.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 11:26:05 -0800 (PST)
X-Received: by 2002:a2e:9209:: with SMTP id k9-v6mr10741284ljg.12.1549913165379;
 Mon, 11 Feb 2019 11:26:05 -0800 (PST)
MIME-Version: 1.0
References: <20190207185917.167829-1-egranata@google.com> <20190211190112.209286-1-egranata@chromium.org>
In-Reply-To: <20190211190112.209286-1-egranata@chromium.org>
From:   Dmitry Torokhov <dtor@chromium.org>
Date:   Mon, 11 Feb 2019 11:25:54 -0800
X-Gmail-Original-Message-ID: <CAE_wzQ-a7GR3Kw4cDdD8g8eboKaDtG5zbmtdY+D3K=nh94tUqQ@mail.gmail.com>
Message-ID: <CAE_wzQ-a7GR3Kw4cDdD8g8eboKaDtG5zbmtdY+D3K=nh94tUqQ@mail.gmail.com>
Subject: Re: [PATCH v2] driver: platform: Support parsing GpioInt 0 in platform_get_irq()
To:     egranata@chromium.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        andy.shevchenko@gmail.com, "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        enric.balletbo@collabora.com, lkml <linux-kernel@vger.kernel.org>,
        gwendal@chromium.org,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        briannorris@chromium.org, andriy.shevchenko@linux.intel.com,
        Enrico Granata <egranata@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 11:01 AM <egranata@chromium.org> wrote:
>
> From: Enrico Granata <egranata@chromium.org>
>
> ACPI 5 added support for GpioInt resources as a way to provide
> information about interrupts mediated via a GPIO controller.
>
> Several device buses (e.g. SPI, I2C) have support for retrieving
> an IRQ specified via this type of resource, and providing it
> directly to the driver as an IRQ number.
>
> This is not currently done for the platform drivers, as platform_get_irq()
> does not try to parse GpioInt() resources. This requires drivers to
> either have to support only one possible IRQ resource, or to have code
> in place to try both as a failsafe.
>
> While there is a possibility of ambiguity for devices that exposes
> multiple IRQs, it is easy and feasible to support the common case
> of devices that only expose one IRQ which would be of either type
> depending on the underlying system's architecture.
>
> This commit adds support for parsing a GpioInt resource in order
> to fulfill a request for the index 0 IRQ for a platform device.
>
> Signed-off-by: Enrico Granata <egranata@chromium.org>

Yeah, this looks good to me.

Reviewed-by: Dmitry Torokhov <dtor@chromium.org>

> ---
> Changes in v2:
>  - only support IRQ index 0
>
>  drivers/base/platform.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index 1c958eb33ef4d..0d3611cd1b3bc 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -127,7 +127,20 @@ int platform_get_irq(struct platform_device *dev, unsigned int num)
>                 irqd_set_trigger_type(irqd, r->flags & IORESOURCE_BITS);
>         }
>
> -       return r ? r->start : -ENXIO;
> +       if (r)
> +               return r->start;
> +
> +       /*
> +        * For the index 0 interrupt, allow falling back to GpioInt
> +        * resources. While a device could have both Interrupt and GpioInt
> +        * resources, making this fallback ambiguous, in many common cases
> +        * the device will only expose one IRQ, and this fallback
> +        * allows a common code path across either kind of resource.
> +        */
> +       if (num == 0 && has_acpi_companion(&dev->dev))
> +               return acpi_dev_gpio_irq_get(ACPI_COMPANION(&dev->dev), num);
> +
> +       return -ENXIO;
>  #endif
>  }
>  EXPORT_SYMBOL_GPL(platform_get_irq);
> --
> 2.20.1.791.gb4d0f1c61a-goog
>
