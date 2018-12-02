Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 648E3C04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 17:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BE042081C
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 17:02:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Xb/E+0Cm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BE042081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725781AbeLBRC5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 12:02:57 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46457 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbeLBRC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 12:02:56 -0500
Received: by mail-ot1-f68.google.com with SMTP id w25so9457462otm.13
        for <linux-kernel@vger.kernel.org>; Sun, 02 Dec 2018 09:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=00HLrtqm8W1r9ik78WiiDuK7C6SV9SWCZPAJkFAh0Dk=;
        b=Xb/E+0Cm9MxD0kpZ7MXIgeC5mh8I5f3m+iCRR2jhqDDme+7mcRpx0SR3fa2/xJmbxq
         rMreYrDh1KQWKBp5oJg8Q/LhbkgeNWjcSlj4DIPQpsddv9YJwx9R9VAt3ByTJXneOLMz
         hD1yFnVhR9galQAyMJo7L12n65TY3CQRNv3emSdVdCPh+SMjQNVUZdR1GSUH8xaacMG9
         UfDgMhTlj/gd+DHCZJMwrsET/IvNMCOYBnZ65QttMd53GGmx5f/tmrwiksQJFBxEl+4K
         KbQnyCwCtCXzwyzCJdZwhcZdkrj8FjVxmFihyiL7U+7CGbO8x0ga7PVZujpdXQC1WNiX
         JpwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=00HLrtqm8W1r9ik78WiiDuK7C6SV9SWCZPAJkFAh0Dk=;
        b=BB9EJPgEuod0llSvAfvmi8GMlYWCSo9xCDNnafk5wdj3LSITRNr3P9zcZO/uyLMU6a
         u/M0GlrgTjrwo4neErDuDh+05pvJIZO9YFUNge5Ujt4YW9XRjDElL+fzRNd5uF8Q6dig
         LjrKXvc7E1mxcfWEeZ2clkGrn+j13yx5rqEili1tuuaqGw3ldHsUoZpY6vOrUerDzGXF
         UALu0UkctNs9R8UvPeNZlgGDB5r4AyjCf6597zm4bcVwwC5YgNi1SSbm9OvJ2uoXCmTA
         DIwuPL4Wz0yMCtRbITSwBpbdppDc6zNoLFeCyASHsyQX1Xk91sS8ynlxgN1IJeI5RHOR
         JZHA==
X-Gm-Message-State: AA+aEWYpa/SQeqK8TQtVMWwF/dlrx0dSivBJx1e7z2DkPzK0KtytXz8Y
        khX5XVwtHfzo8f0S74OpQ3NC3EaRNZOefZJZRzSWeQ==
X-Google-Smtp-Source: AFSGD/XW6KDTqpvxc4Luc0LNTmbeMaX/ahjCpT5Mm+pKUoKyzOX1lNjFcHCrbt02IRks4H39he3KkL2tyMgWehZXpGQ=
X-Received: by 2002:a9d:4595:: with SMTP id x21mr8022866ote.234.1543770173456;
 Sun, 02 Dec 2018 09:02:53 -0800 (PST)
MIME-Version: 1.0
References: <20181201154151.14890-1-linus.walleij@linaro.org> <20181201154151.14890-10-linus.walleij@linaro.org>
In-Reply-To: <20181201154151.14890-10-linus.walleij@linaro.org>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Sun, 2 Dec 2018 18:02:42 +0100
Message-ID: <CAMpxmJXoZOJkKJRL0pO-LJ4HXxWb4qj7iADbpEoS=kfL4h-jHQ@mail.gmail.com>
Subject: Re: [PATCH 09/13 v2] gpio: Add devm_gpiod_unhinge()
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        ckeepax@opensource.cirrus.com, m.szyprowski@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sob., 1 gru 2018 o 16:53 Linus Walleij <linus.walleij@linaro.org> napisa=C5=
=82(a):
>
> This adds a function named devm_gpiod_unhinge() that removes
> the resource management from a GPIO descriptor.
>
> I am not sure if this is the best anglosaxon name for the
> function, no other managed resources have an equivalent
> currently, but I chose "unhinge" as the closest intuitive
> thing I could imagine that fits Rusty Russell's API design
> criterions "the obvious use is the correct one" and
> "the name tells you how to use it".
>
> The idea came out of a remark from Mark Brown that it should
> be possible to handle over management of a resource from
> devres to the regulator core, and indeed we can do that.
>
> Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - New patch to be able to hand over GPIO descriptors to
>   the regulator core.
> - Mark: feel free to apply this to the regulator tree with
>   the regulator tree with the rest.
> ---
>  Documentation/driver-model/devres.txt |  1 +
>  drivers/gpio/gpiolib-devres.c         | 17 +++++++++++++++++
>  include/linux/gpio/consumer.h         | 10 ++++++++++
>  3 files changed, 28 insertions(+)
>
> diff --git a/Documentation/driver-model/devres.txt b/Documentation/driver=
-model/devres.txt
> index 43681ca0837f..fc4cc24dfb97 100644
> --- a/Documentation/driver-model/devres.txt
> +++ b/Documentation/driver-model/devres.txt
> @@ -254,6 +254,7 @@ GPIO
>    devm_gpiod_get_index_optional()
>    devm_gpiod_get_optional()
>    devm_gpiod_put()
> +  devm_gpiod_unhinge()
>    devm_gpiochip_add_data()
>    devm_gpiochip_remove()
>    devm_gpio_request()
> diff --git a/drivers/gpio/gpiolib-devres.c b/drivers/gpio/gpiolib-devres.=
c
> index 01959369360b..5864e758d7f2 100644
> --- a/drivers/gpio/gpiolib-devres.c
> +++ b/drivers/gpio/gpiolib-devres.c
> @@ -320,6 +320,23 @@ void devm_gpiod_put(struct device *dev, struct gpio_=
desc *desc)
>  }
>  EXPORT_SYMBOL(devm_gpiod_put);
>
> +/**
> + * devm_gpiod_unhinge - Remove resource management from a gpio descripto=
r
> + * @dev:       GPIO consumer
> + * @desc:      GPIO descriptor to remove resource management from
> + *
> + * Remove resource management from a GPIO descriptor. This is needed whe=
n
> + * you want to hand over lifecycle management of a descriptor to another
> + * mechanism.
> + */
> +
> +void devm_gpiod_unhinge(struct device *dev, struct gpio_desc *desc)
> +{
> +       WARN_ON(devres_destroy(dev, devm_gpiod_release,
> +                              devm_gpiod_match, desc));
> +}
> +EXPORT_SYMBOL(devm_gpiod_unhinge);
> +
>  /**
>   * devm_gpiod_put_array - Resource-managed gpiod_put_array()
>   * @dev:       GPIO consumer
> diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.=
h
> index 348885f2f3d3..8aebcf822082 100644
> --- a/include/linux/gpio/consumer.h
> +++ b/include/linux/gpio/consumer.h
> @@ -104,6 +104,7 @@ struct gpio_descs *__must_check
>  devm_gpiod_get_array_optional(struct device *dev, const char *con_id,
>                               enum gpiod_flags flags);
>  void devm_gpiod_put(struct device *dev, struct gpio_desc *desc);
> +void devm_gpiod_unhinge(struct device *dev, struct gpio_desc *desc);
>  void devm_gpiod_put_array(struct device *dev, struct gpio_descs *descs);
>
>  int gpiod_get_direction(struct gpio_desc *desc);
> @@ -249,6 +250,15 @@ static inline void gpiod_put(struct gpio_desc *desc)
>         WARN_ON(1);
>  }
>
> +static inline void devm_gpiod_unhinge(struct device *dev,
> +                                     struct gpio_desc *desc)
> +{
> +       might_sleep();
> +
> +       /* GPIO can never have been requested */
> +       WARN_ON(1);
> +}
> +
>  static inline void gpiod_put_array(struct gpio_descs *descs)
>  {
>         might_sleep();
> --
> 2.19.1
>

Yes! This is much better than simply using non-devm variants of gpiod_get()=
.

Reviewed-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
