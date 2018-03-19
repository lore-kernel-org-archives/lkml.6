Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932493AbeCSJff (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 05:35:35 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:33112 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932421AbeCSJfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 05:35:32 -0400
X-Google-Smtp-Source: AG47ELt3DNv81IZWL+B5S7hrVvc8zQTDfEL2fNIqOtoLMCh0DCASueNlGnuhXsUmBbtVfW6vwU/Dw2WbFAxGmARwkYE=
MIME-Version: 1.0
In-Reply-To: <20180304124551.22565-1-brgl@bgdev.pl>
References: <20180304124551.22565-1-brgl@bgdev.pl>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 19 Mar 2018 10:35:31 +0100
Message-ID: <CAMRc=McpwoE-QL8b+5FeWkOgHCNZZq3AKcxzOJ11+b+Pb=TECQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: mockup: fix a potential crash when creating debugfs entries
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-04 13:45 GMT+01:00 Bartosz Golaszewski <brgl@bgdev.pl>:
> If we failed to create the top debugfs directory, we must not try to
> create the child nodes. We currently only check if gpio_mockup_dbg_dir
> is not NULL, but it can also contain an errno if debugfs is disabled
> in build options. Use IS_ERR_OR_NULL() instead.
>
> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
> ---
>  drivers/gpio/gpio-mockup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpio-mockup.c b/drivers/gpio/gpio-mockup.c
> index 3a545ad17817..b5876b07b0f7 100644
> --- a/drivers/gpio/gpio-mockup.c
> +++ b/drivers/gpio/gpio-mockup.c
> @@ -314,7 +314,7 @@ static int gpio_mockup_probe(struct platform_device *pdev)
>         if (rv)
>                 return rv;
>
> -       if (gpio_mockup_dbg_dir)
> +       if (!IS_ERR_OR_NULL(gpio_mockup_dbg_dir))
>                 gpio_mockup_debugfs_setup(dev, chip);
>
>         return 0;
> --
> 2.16.1
>

Hi Linus,

gentle ping for this one as it causes a crash if debugfs is disabled.

Bart
