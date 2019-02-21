Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15009C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 19:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8A632081B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 19:56:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ld1vzekh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfBUT4B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 14:56:01 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:32819 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbfBUT4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 14:56:00 -0500
Received: by mail-pl1-f196.google.com with SMTP id y10so14694521plp.0;
        Thu, 21 Feb 2019 11:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+tdSvCq8GL7lavXCsSW2Fx0scQwS6XqNwpB3L0uRkEc=;
        b=ld1vzekh9KeE8JhurD5oJlUPwV/MAHugJeyjEXi3QxkXrDCD80TvKQzyTT6aaWO2sK
         R6sM3tJkHblS7ejZY6mRZj3oULD+IsPt9xSgEEWsGMcmb12tn01zkw507tm+dWS6SL3n
         eSEmePjgZr1s3ZFDeL3FGKDfLRUaUsqttxjzYeK8kGM+gEyndWVksDhBOvE/S6S8eE7p
         pVX//bzvTr/qW+X104z8QGjPaBFWB+uEJmYrmehji/ySQn0Ld2ivjg3j3OtJtgoEJDUl
         E1lH/1H4IO8LfAI4xDzZMSSVILvjcBSB+j4eN0Be2P9I6rYzFm4jqx1HCCYE//nv6CWn
         /tsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+tdSvCq8GL7lavXCsSW2Fx0scQwS6XqNwpB3L0uRkEc=;
        b=AJUq+mgtQG/VgezMnQTG1NMuCkeGKVGk1CN0QTj+YJ3DI1R/BpYoBh90H0Le6ZGLrp
         /myZstiChVODb4KtglJyT9qccNuSW0yIaCafQzxLE3pnENzTcNWM2pXKlxgnlDnsZq1G
         RkqSEkX5XOkYShf7tlbQCDayufY9+nNbpi38hJW9egPeEqWFLXe1T1kZaGmKdgK/TGwa
         ezFDIPRV72YpGGWuGsQz5GwRmzgqbCPxbaqJ6OKsR7ap5xPmqMwFBltrj7DLUe+XQu2I
         PLa2+xMCVkNxEAGcsr/D4W0oEw6C2JXgEbczG6tYiX4YYqRURKlZxVFE4hSOY8eCUMJm
         6n8A==
X-Gm-Message-State: AHQUAuaErSQsn86AFtIOjEIu1Eju7Z3iCnFr1f6MElYXtHTUJ2pW9pvk
        qBrsZKdmjj9Elsj37M6YCXgsJHXAQEov1pJldDs=
X-Google-Smtp-Source: AHgI3IYHDkPJSjGin9OW41dTwndrXELAaUhDp94kQ/+L9OY7HCW6Mu9pULDhVR/mnCp7jAxVmBodMXpH2SMjH+dwnrE=
X-Received: by 2002:a17:902:bc88:: with SMTP id bb8mr291444plb.12.1550778960089;
 Thu, 21 Feb 2019 11:56:00 -0800 (PST)
MIME-Version: 1.0
References: <20190221162627.3476-1-brgl@bgdev.pl>
In-Reply-To: <20190221162627.3476-1-brgl@bgdev.pl>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 21 Feb 2019 21:55:48 +0200
Message-ID: <CAHp75VfKq5rkLUzW3HL8+a0wmaqGz7nz09Ki0nc0TxQDJb=9DA@mail.gmail.com>
Subject: Re: [PATCH] drivers: depend on HAS_IOMEM for devm_platform_ioremap_resource()
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Keerthy <j-keerthy@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 6:27 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> We only build devm_ioremap_resource() if HAS_IOMEM is selected, so this
> dependency must cascade down to devm_platform_ioremap_resource().

> +#ifdef CONFIG_HAS_IOMEM
>  void __iomem *devm_platform_ioremap_resource(struct platform_device *pdev,
>                                              unsigned int index)
>  {
> @@ -96,6 +97,7 @@ void __iomem *devm_platform_ioremap_resource(struct platform_device *pdev,
>         return devm_ioremap_resource(&pdev->dev, res);
>  }
>  EXPORT_SYMBOL_GPL(devm_platform_ioremap_resource);
> +#endif /* CONFIG_HAS_IOMEM */

What about declaration in *.h?

Perhaps you may just do this inside the function?

-- 
With Best Regards,
Andy Shevchenko
