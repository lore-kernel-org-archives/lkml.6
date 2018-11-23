Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 398DAC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 07:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFC3520861
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 07:46:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M4EcZXfV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFC3520861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502433AbeKWS3n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 13:29:43 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:32954 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502420AbeKWS3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 13:29:43 -0500
Received: by mail-oi1-f195.google.com with SMTP id c206so9300477oib.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 23:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PkwJzD5gIlc7X3+74iL+HcExhZPKip8StS+vQP/JJVY=;
        b=M4EcZXfVczOtrlbQF4QM53NPVXh8A8NTh4JwH6dXzu1RI12Fcjt0CLH87ZpGN9MhfD
         UrjI/xisnKBSAH+25XZtk1S9X8ZHJtCa5YJc0bNDDwKUF0zWP7fR3rrZGtPHPNHQyzVr
         OwC1nInD06c+0ezJPnQbZ7XYBE+Gufds5GKtILCqsDBmpxsk2/XhLZ45J5iiyRFw3/t5
         RGJILo0yzAHbGBuLB6yX1mwxotCfsJt2fHUQZq9Np07P3Q1vBWA8J17sRDQPoNd288FG
         7Gdy/1vZEgemd1donbZ83uMjZKR4+3EQDDF4C6atqacFrmhVbSowPGHyq2QtWMPLybCu
         cA7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PkwJzD5gIlc7X3+74iL+HcExhZPKip8StS+vQP/JJVY=;
        b=iKm1ucPXsWFZ5H7SeUdqgdcTJp4VhT9cTGrcwq7KiZdTHY6oizQrj+jT/rsVu+Nq6z
         4HaqXxl6FLvs/TnAfSNADWH2ZVxtuZbHGtU0yxoY81D+c9g6cRY1DliqwbtYFnksXwE0
         TnpD4OX+LaWypE69U7uEfTERWNdia3FZHDzDU7MtllCi97Ac403q3b25bfj4Uc7XlnF7
         U78Wahh+TbdIy65JXddzZLzooM/fFmFydFi5ymMZphmiGpZh1+kzIwdNhBCabRLbRQ8I
         o0FNI7vIl/yNUnzkSIV0ZjGbBrd7EyfE9rQkx7TRecClpiQmGLX24+fdNLfn+AoN3lFn
         xXJg==
X-Gm-Message-State: AGRZ1gLmmLUVbpzFKEGK13ahgeqtrBmorrw+xsynOAfZNEt/FXyntgS2
        fRU87fjp0mQa4KjKI+uJCy+20RHg1ZbNHvbvuSBI/AbZ
X-Google-Smtp-Source: AJdET5eReRsDstRSGD1fW1kvmFc14ySxjr/oAifHDYT+Ai9Zfz4pvxvoA+NOWz59ah0pO8H5eFvdJv9EW3aHwTwrQbA=
X-Received: by 2002:aca:c003:: with SMTP id q3-v6mr8070939oif.45.1542959199575;
 Thu, 22 Nov 2018 23:46:39 -0800 (PST)
MIME-Version: 1.0
References: <20181117130337.5856-1-tom@aussec.com> <20181117130337.5856-2-tom@aussec.com>
 <20181117130337.5856-3-tom@aussec.com>
In-Reply-To: <20181117130337.5856-3-tom@aussec.com>
From:   Philipp Zabel <philipp.zabel@gmail.com>
Date:   Fri, 23 Nov 2018 08:46:28 +0100
Message-ID: <CA+gwMcfQ5cUZPmAJ6Uhb0KQsmwjtoSdRJVnAzk9mwy=-M19M2Q@mail.gmail.com>
Subject: Re: [PATCH v8 2/4] pps: descriptor-based gpio, capture-clear addition
To:     tom@aussec.com
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom,

On Sat, Nov 17, 2018 at 2:07 PM Tom Burkart <tom@aussec.com> wrote:
>
> This patch changes the GPIO access for the pps-gpio driver from the
> integer based ABI to the descriptor based ABI.  It also adds the
> extraction of the device tree capture-clear option.

Is the capture-clear property documented in
Documentation/devicetree/bindings/pps/pps-gpio.txt?
If not, you should add a binding documentation patch.

> Signed-off-by: Tom Burkart <tom@aussec.com>
> ---
>  drivers/pps/clients/pps-gpio.c | 80 +++++++++++++++++++++---------------------
>  include/linux/pps-gpio.h       |  3 +-
>  2 files changed, 41 insertions(+), 42 deletions(-)
>
> diff --git a/drivers/pps/clients/pps-gpio.c b/drivers/pps/clients/pps-gpio.c
> index 333ad7d5b45b..d2fbc91dc8fc 100644
> --- a/drivers/pps/clients/pps-gpio.c
> +++ b/drivers/pps/clients/pps-gpio.c
> @@ -31,7 +31,7 @@
>  #include <linux/slab.h>
>  #include <linux/pps_kernel.h>
>  #include <linux/pps-gpio.h>
> -#include <linux/gpio.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/list.h>
>  #include <linux/of_device.h>
>  #include <linux/of_gpio.h>
> @@ -41,9 +41,9 @@ struct pps_gpio_device_data {
>         int irq;                        /* IRQ used as PPS source */
>         struct pps_device *pps;         /* PPS source device */
>         struct pps_source_info info;    /* PPS source information */
> +       struct gpio_desc *gpio_pin;     /* GPIO port descriptors */
>         bool assert_falling_edge;
>         bool capture_clear;
> -       unsigned int gpio_pin;
>  };
>
>  /*
> @@ -61,18 +61,49 @@ static irqreturn_t pps_gpio_irq_handler(int irq, void *data)
>
>         info = data;
>
> -       rising_edge = gpio_get_value(info->gpio_pin);
> +       rising_edge = gpiod_get_value(info->gpio_pin);
>         if ((rising_edge && !info->assert_falling_edge) ||
>                         (!rising_edge && info->assert_falling_edge))
>                 pps_event(info->pps, &ts, PPS_CAPTUREASSERT, NULL);
>         else if (info->capture_clear &&
>                         ((rising_edge && info->assert_falling_edge) ||
> -                        (!rising_edge && !info->assert_falling_edge)))
> +                       (!rising_edge && !info->assert_falling_edge)))
>                 pps_event(info->pps, &ts, PPS_CAPTURECLEAR, NULL);
>
>         return IRQ_HANDLED;
>  }
>
> +static int pps_gpio_setup(struct platform_device *pdev)
> +{
> +       struct pps_gpio_device_data *data = platform_get_drvdata(pdev);
> +       const struct pps_gpio_platform_data *pdata = pdev->dev.platform_data;
> +       struct device_node *np = pdev->dev.of_node;
> +       int ret;

Unused variable?

> +
> +       if (pdata) {
> +               data->gpio_pin = pdata->gpio_pin;
> +
> +               data->assert_falling_edge = pdata->assert_falling_edge;
> +               data->capture_clear = pdata->capture_clear;

This is just a matter of personal taste, so feel free to ignore:
I would keep the pdata branch in pps_gpio_probe and call this function
pps_gpio_dt_setup, to reduce indentation of the OF branch.

> +       } else {
> +               data->gpio_pin = devm_gpiod_get(&pdev->dev,
> +                       NULL,   /* request "gpios" */
> +                       GPIOD_IN);
> +               if (IS_ERR(data->gpio_pin)) {
> +                       dev_err(&pdev->dev,
> +                               "failed to request PPS GPIO\n");
> +                       return PTR_ERR(data->gpio_pin);
> +               }
> +
> +               if (of_get_property(np, "assert-falling-edge", NULL))
> +                       data->assert_falling_edge = true;
> +
> +               if (of_get_property(np, "capture-clear", NULL))
> +                       data->capture_clear = true;

Those two should use the of_property_read_bool wrapper.

> +       }
> +       return 0;
> +}
> +
>  static unsigned long
>  get_irqf_trigger_flags(const struct pps_gpio_device_data *data)
>  {
> @@ -90,53 +121,23 @@ get_irqf_trigger_flags(const struct pps_gpio_device_data *data)
>  static int pps_gpio_probe(struct platform_device *pdev)
>  {
>         struct pps_gpio_device_data *data;
> -       const char *gpio_label;
>         int ret;
>         int pps_default_params;
> -       const struct pps_gpio_platform_data *pdata = pdev->dev.platform_data;
> -       struct device_node *np = pdev->dev.of_node;
>
>         /* allocate space for device info */
>         data = devm_kzalloc(&pdev->dev, sizeof(struct pps_gpio_device_data),

Could use sizeof(*data) here. Otherwise,

Reviewed-by: Philipp Zabel <philipp.zabel@gmail.com>

regards
Philipp
