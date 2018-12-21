Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3FBBC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 08:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF7C8218E2
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 08:58:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LBmpMe80"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730807AbeLUI61 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 03:58:27 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33459 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbeLUI60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 03:58:26 -0500
Received: by mail-lj1-f196.google.com with SMTP id v1-v6so4049626ljd.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 00:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NpCGsap+4OasCzXUyGm7/loSh1yI6KWWD28dFPZcU1Q=;
        b=LBmpMe80RCJiJJDepYii2pBc0VEzM6ng7JfMLmFU3TTBJaHPM5wMZ8kD0LHjUVmMol
         wT8K78U5Uh8/BXcAk39aqoPKPtoKIO0Gw/Vkyur6J3t+163dvth14GXdi8TxOqJk3zbA
         wjlePJ5ocZLPxHlleGwbXIxooa/lSlAFCAaXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NpCGsap+4OasCzXUyGm7/loSh1yI6KWWD28dFPZcU1Q=;
        b=BCBdDRPk1IHwqSKfNZM/Gzta7KnIPolT1wyFlNvBmSzg969C6c5BJ3x8WviXZkjmeQ
         7I7uxW+Ty2YQdwfAEr5NDqHNb8rY2Fdc8CsUgweF8eOs2en18w29Ydkao5jDJ2YGy2gv
         ZmiHCbdJoKmYyv5eSqz6Qnoa73Hd5axZd+Gn4sediQ5FlWDsPOXj8LRbsTBG/HhUW9HY
         E6mL0+XEGpI8ZiYK2NAfc9v+Rk+xJVuq5QPxKMs5kMPfjpaLEI+jlkvzyPQ6YYzcSmM6
         GxASNT2AlSrVHXt/RpM/H/jXuqFlEcQOAkiZHNwVAJe+HzP53xtnlk5/c8j8DhePghiF
         qwaw==
X-Gm-Message-State: AJcUukcjVtt4MFAwIndIXlYZNnkulYHRb9msIGiQdApuPRPEkhk25P9o
        C2YQnC4+OxaKPyaokXnkbdKNkPwEcGTU2DdQrMJsPQ==
X-Google-Smtp-Source: ALg8bN6eW/Hn2gIzMscu8uhKuxGFduqv3LK7G9172varKs1DhipCX/v6RKncqi+zuOdlqQZw/ZA9r/U0JjoRnCRnxlo=
X-Received: by 2002:a2e:449b:: with SMTP id b27-v6mr964640ljf.47.1545382704170;
 Fri, 21 Dec 2018 00:58:24 -0800 (PST)
MIME-Version: 1.0
References: <20181219164827.20985-1-wsa+renesas@sang-engineering.com> <20181219164827.20985-7-wsa+renesas@sang-engineering.com>
In-Reply-To: <20181219164827.20985-7-wsa+renesas@sang-engineering.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Fri, 21 Dec 2018 16:58:11 +0800
Message-ID: <CAMz4kuKSepzktF+ZUVsrxD-pAgRDiGUC_f0oLL2CTyBMz3tfoQ@mail.gmail.com>
Subject: Re: [PATCH 06/10] i2c: sprd: don't use pdev as variable name for
 struct device *
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wolfram,

On Thu, 20 Dec 2018 at 00:48, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> The pointer to a device is usually named 'dev'. These 'pdev' here look
> much like copy&paste errors. Fix them to avoid confusion.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Thanks for fixing the copy&paste errors.
Reviewed-by: Baolin Wang <baolin.wang@linaro.org>

> ---
>  drivers/i2c/busses/i2c-sprd.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-sprd.c b/drivers/i2c/busses/i2c-sprd.c
> index a94e724f51dc..e266d8a713d9 100644
> --- a/drivers/i2c/busses/i2c-sprd.c
> +++ b/drivers/i2c/busses/i2c-sprd.c
> @@ -586,40 +586,40 @@ static int sprd_i2c_remove(struct platform_device *pdev)
>         return 0;
>  }
>
> -static int __maybe_unused sprd_i2c_suspend_noirq(struct device *pdev)
> +static int __maybe_unused sprd_i2c_suspend_noirq(struct device *dev)
>  {
> -       struct sprd_i2c *i2c_dev = dev_get_drvdata(pdev);
> +       struct sprd_i2c *i2c_dev = dev_get_drvdata(dev);
>
>         i2c_lock_bus(&i2c_dev->adap, I2C_LOCK_ROOT_ADAPTER);
>         i2c_dev->is_suspended = true;
>         i2c_unlock_bus(&i2c_dev->adap, I2C_LOCK_ROOT_ADAPTER);
>
> -       return pm_runtime_force_suspend(pdev);
> +       return pm_runtime_force_suspend(dev);
>  }
>
> -static int __maybe_unused sprd_i2c_resume_noirq(struct device *pdev)
> +static int __maybe_unused sprd_i2c_resume_noirq(struct device *dev)
>  {
> -       struct sprd_i2c *i2c_dev = dev_get_drvdata(pdev);
> +       struct sprd_i2c *i2c_dev = dev_get_drvdata(dev);
>
>         i2c_lock_bus(&i2c_dev->adap, I2C_LOCK_ROOT_ADAPTER);
>         i2c_dev->is_suspended = false;
>         i2c_unlock_bus(&i2c_dev->adap, I2C_LOCK_ROOT_ADAPTER);
>
> -       return pm_runtime_force_resume(pdev);
> +       return pm_runtime_force_resume(dev);
>  }
>
> -static int __maybe_unused sprd_i2c_runtime_suspend(struct device *pdev)
> +static int __maybe_unused sprd_i2c_runtime_suspend(struct device *dev)
>  {
> -       struct sprd_i2c *i2c_dev = dev_get_drvdata(pdev);
> +       struct sprd_i2c *i2c_dev = dev_get_drvdata(dev);
>
>         clk_disable_unprepare(i2c_dev->clk);
>
>         return 0;
>  }
>
> -static int __maybe_unused sprd_i2c_runtime_resume(struct device *pdev)
> +static int __maybe_unused sprd_i2c_runtime_resume(struct device *dev)
>  {
> -       struct sprd_i2c *i2c_dev = dev_get_drvdata(pdev);
> +       struct sprd_i2c *i2c_dev = dev_get_drvdata(dev);
>         int ret;
>
>         ret = clk_prepare_enable(i2c_dev->clk);
> --
> 2.11.0
>


-- 
Baolin Wang
Best Regards
