Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965522AbeBMSps (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 13:45:48 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:34020 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965415AbeBMSpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 13:45:46 -0500
X-Google-Smtp-Source: AH8x225GyF8o8b20HRyyubELAcmzBtQTFzzw4Xqeww1zbD+iN1COIoEoSlHlDIHHCzxfsFOXLZwdp1/CzW0gUwkKevQ=
MIME-Version: 1.0
In-Reply-To: <0ea6dba4-0c52-4c9c-ae7e-d80c2f3d50f3@users.sourceforge.net>
References: <0ea6dba4-0c52-4c9c-ae7e-d80c2f3d50f3@users.sourceforge.net>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 13 Feb 2018 20:45:45 +0200
Message-ID: <CAHp75Ve+Yifx4YO2Fbn+Ui4pGPpx0xSutSVjLVN9nVq6aOQyjg@mail.gmail.com>
Subject: Re: [PATCH] gpio-intel-mid: Delete an error message for a failed
 memory allocation in intel_gpio_probe()
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        David Cohen <david.a.cohen@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 11, 2018 at 11:04 PM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 11 Feb 2018 21:56:42 +0100
>
> Omit an extra message for a memory allocation failure in this function.
>
> This issue was detected by using the Coccinelle software.
>

Linus, same comment as previously.
If you are OK with the change, take my

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/gpio/gpio-intel-mid.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/gpio/gpio-intel-mid.c b/drivers/gpio/gpio-intel-mid.c
> index 629575ea46a0..028d64c2cb1e 100644
> --- a/drivers/gpio/gpio-intel-mid.c
> +++ b/drivers/gpio/gpio-intel-mid.c
> @@ -361,10 +361,8 @@ static int intel_gpio_probe(struct pci_dev *pdev,
>         pcim_iounmap_regions(pdev, 1 << 1);
>
>         priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> -       if (!priv) {
> -               dev_err(&pdev->dev, "can't allocate chip data\n");
> +       if (!priv)
>                 return -ENOMEM;
> -       }
>
>         priv->reg_base = pcim_iomap_table(pdev)[0];
>         priv->chip.label = dev_name(&pdev->dev);
> --
> 2.16.1
>



-- 
With Best Regards,
Andy Shevchenko
