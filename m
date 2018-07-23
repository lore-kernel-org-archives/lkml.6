Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D22FEECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 08:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D8CB20874
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 08:03:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="YT++G0EE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D8CB20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388030AbeGWJDU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 05:03:20 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:52328 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387908AbeGWJDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 05:03:20 -0400
Received: by mail-it0-f65.google.com with SMTP id p4-v6so162239itf.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 01:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=mzJjFI186k84Lo8BIDM2LMg7/d1IornPK1v3y2dJ5D8=;
        b=YT++G0EEATNJ8KhBdsAr7m8gShXO0ZyPOta0MmokgNZGAJHcn5hUVA+X38z09QztRk
         zlcy0zcOARMNJ5RkNfL6it6BwL7Q6HnXW5jAOlO1YQrXGsxp7exh5NnhT1z9j3MB53xh
         d6hfZLTdwqWihCqXVa0WTxWycDLdETgCqv1ovca9qTrM2lTYIcE8l89azZE4Srho0TO2
         2Zr3ONRV5zsoJaPXKijitGd/GV687z/GlysH1cq5ihmIrmkHCE72KdfRZOOyxMxohF17
         kEhPNXIEqw2/TZI6fbjPer0zigilEh1lEYrSyCKOaHDJOqq6BJfp4VtkryS0XkBBhwzS
         EZfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=mzJjFI186k84Lo8BIDM2LMg7/d1IornPK1v3y2dJ5D8=;
        b=hVuK9LDo4tCsepHUC220qCwQ7EFDdqW9NAhE7sewOFAVnxwbXVWW98QsykNdQmSbH1
         1U9h+PdJBz0tAtbHcLDs3VvjoYDP/jJKV43ouMFGGLZ6w8ENRidkrLMC46v67gdHutka
         G0BKnZa1kYdEpuK7fjXUm1DpwT/Omua6KTwa6xd+ry57B7per7hV5i+1Ku/78uZwstM7
         cZ0jN9Tp11PVEmmu6GPMbrqG7KVgOera6Jg7ac5x490dDrKCN5Z1uMdiK04RSq6BDNFJ
         ZuhUMwXfHo2pcZdpIs69EUXIFoCwFwM6pc+rmR6qrZfi7ct8Okjruehhl25jRFoZE0OM
         Dh+A==
X-Gm-Message-State: AOUpUlGNHWA9RAxoR1fkCnx1bSKnAV6O9OOHwHcDsba7lWxWZ4tagWIV
        DpYe8RZsZT9Qm8BgfZetuL5STG6bnugffjzxUGYytWbt
X-Google-Smtp-Source: AAOMgpctXjwewW6s8aICUVSfQ46LFZSzpBJlOMYTONI2ayJDJsWswadaAhDWRoSv943ikVR8XmQe+nKh3eF8o4wIQN8=
X-Received: by 2002:a24:e48c:: with SMTP id o134-v6mr9595482ith.125.1532333001446;
 Mon, 23 Jul 2018 01:03:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5e:9402:0:0:0:0:0 with HTTP; Mon, 23 Jul 2018 01:03:20
 -0700 (PDT)
In-Reply-To: <20180621073706.22812-2-brgl@bgdev.pl>
References: <20180621073706.22812-1-brgl@bgdev.pl> <20180621073706.22812-2-brgl@bgdev.pl>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 23 Jul 2018 10:03:20 +0200
Message-ID: <CAMRc=Mcqe7VgkckL3e9GmM7fNYe=a7OO1hEv-Nyh1yiMNwfzfw@mail.gmail.com>
Subject: Re: [PATCH v7 1/4] remoteproc/davinci: use the reset framework
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        David Lechner <david@lechnology.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-remoteproc@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-06-21 9:37 GMT+02:00 Bartosz Golaszewski <brgl@bgdev.pl>:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Switch to using the reset framework instead of handcoded reset routines
> we used so far.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Reviewed-by: Sekhar Nori <nsekhar@ti.com>
> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---
>  drivers/remoteproc/da8xx_remoteproc.c | 34 +++++++++++++++++++++++----
>  1 file changed, 29 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/remoteproc/da8xx_remoteproc.c b/drivers/remoteproc/da8xx_remoteproc.c
> index b668e32996e2..76c06b70a1c6 100644
> --- a/drivers/remoteproc/da8xx_remoteproc.c
> +++ b/drivers/remoteproc/da8xx_remoteproc.c
> @@ -10,6 +10,7 @@
>
>  #include <linux/bitops.h>
>  #include <linux/clk.h>
> +#include <linux/reset.h>
>  #include <linux/err.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
> @@ -20,8 +21,6 @@
>  #include <linux/platform_device.h>
>  #include <linux/remoteproc.h>
>
> -#include <mach/clock.h>   /* for davinci_clk_reset_assert/deassert() */
> -
>  #include "remoteproc_internal.h"
>
>  static char *da8xx_fw_name;
> @@ -72,6 +71,7 @@ struct da8xx_rproc {
>         struct da8xx_rproc_mem *mem;
>         int num_mems;
>         struct clk *dsp_clk;
> +       struct reset_control *dsp_reset;
>         void (*ack_fxn)(struct irq_data *data);
>         struct irq_data *irq_data;
>         void __iomem *chipsig;
> @@ -138,6 +138,7 @@ static int da8xx_rproc_start(struct rproc *rproc)
>         struct device *dev = rproc->dev.parent;
>         struct da8xx_rproc *drproc = (struct da8xx_rproc *)rproc->priv;
>         struct clk *dsp_clk = drproc->dsp_clk;
> +       struct reset_control *dsp_reset = drproc->dsp_reset;
>         int ret;
>
>         /* hw requires the start (boot) address be on 1KB boundary */
> @@ -155,7 +156,12 @@ static int da8xx_rproc_start(struct rproc *rproc)
>                 return ret;
>         }
>
> -       davinci_clk_reset_deassert(dsp_clk);
> +       ret = reset_control_deassert(dsp_reset);
> +       if (ret) {
> +               dev_err(dev, "reset_control_deassert() failed: %d\n", ret);
> +               clk_disable_unprepare(dsp_clk);
> +               return ret;
> +       }
>
>         return 0;
>  }
> @@ -163,8 +169,15 @@ static int da8xx_rproc_start(struct rproc *rproc)
>  static int da8xx_rproc_stop(struct rproc *rproc)
>  {
>         struct da8xx_rproc *drproc = rproc->priv;
> +       struct device *dev = rproc->dev.parent;
> +       int ret;
> +
> +       ret = reset_control_assert(drproc->dsp_reset);
> +       if (ret) {
> +               dev_err(dev, "reset_control_assert() failed: %d\n", ret);
> +               return ret;
> +       }
>
> -       davinci_clk_reset_assert(drproc->dsp_clk);
>         clk_disable_unprepare(drproc->dsp_clk);
>
>         return 0;
> @@ -232,6 +245,7 @@ static int da8xx_rproc_probe(struct platform_device *pdev)
>         struct resource *bootreg_res;
>         struct resource *chipsig_res;
>         struct clk *dsp_clk;
> +       struct reset_control *dsp_reset;
>         void __iomem *chipsig;
>         void __iomem *bootreg;
>         int irq;
> @@ -268,6 +282,15 @@ static int da8xx_rproc_probe(struct platform_device *pdev)
>                 return PTR_ERR(dsp_clk);
>         }
>
> +       dsp_reset = devm_reset_control_get_exclusive(dev, NULL);
> +       if (IS_ERR(dsp_reset)) {
> +               if (PTR_ERR(dsp_reset) != -EPROBE_DEFER)
> +                       dev_err(dev, "unable to get reset control: %ld\n",
> +                               PTR_ERR(dsp_reset));
> +
> +               return PTR_ERR(dsp_reset);
> +       }
> +
>         if (dev->of_node) {
>                 ret = of_reserved_mem_device_init(dev);
>                 if (ret) {
> @@ -287,6 +310,7 @@ static int da8xx_rproc_probe(struct platform_device *pdev)
>         drproc = rproc->priv;
>         drproc->rproc = rproc;
>         drproc->dsp_clk = dsp_clk;
> +       drproc->dsp_reset = dsp_reset;
>         rproc->has_iommu = false;
>
>         ret = da8xx_rproc_get_internal_memories(pdev, drproc);
> @@ -309,7 +333,7 @@ static int da8xx_rproc_probe(struct platform_device *pdev)
>          * *not* in reset, but da8xx_rproc_start() needs the DSP to be
>          * held in reset at the time it is called.
>          */
> -       ret = davinci_clk_reset_assert(drproc->dsp_clk);
> +       ret = reset_control_assert(dsp_reset);
>         if (ret)
>                 goto free_rproc;
>
> --
> 2.17.1
>

Hi Bjorn, Sekhar,

I'm not seeing this patch in next, did you agree on how to pick it up for 4.19?

Thanks in advance,
Bartosz
