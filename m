Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933603AbeBLKIb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 05:08:31 -0500
Received: from mga18.intel.com ([134.134.136.126]:33152 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933579AbeBLKI2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 05:08:28 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,501,1511856000";
   d="scan'208";a="29328242"
Message-ID: <1518430103.22495.252.camel@linux.intel.com>
Subject: Re: [PATCH] gpio: merrifield: Delete an error message for a failed
 memory allocation in mrfld_gpio_probe()
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: SF Markus Elfring <elfring@users.sourceforge.net>,
        linux-gpio@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Date: Mon, 12 Feb 2018 12:08:23 +0200
In-Reply-To: <d73420c9-60ee-ab28-e881-299441815afc@users.sourceforge.net>
References: <d73420c9-60ee-ab28-e881-299441815afc@users.sourceforge.net>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.3-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-02-11 at 13:42 +0100, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 11 Feb 2018 13:30:14 +0100
> 
> Omit an extra message for a memory allocation failure in this
> function.
> 
> This issue was detected by using the Coccinelle software.
> 

Linus, I have no strong opinion here, so, up to you to decide.

If you decide this patch to go, 

Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>


> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/gpio/gpio-merrifield.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-merrifield.c b/drivers/gpio/gpio-
> merrifield.c
> index dd67a31ac337..eec21122299e 100644
> --- a/drivers/gpio/gpio-merrifield.c
> +++ b/drivers/gpio/gpio-merrifield.c
> @@ -408,10 +408,8 @@ static int mrfld_gpio_probe(struct pci_dev *pdev,
> const struct pci_device_id *id
>  	pcim_iounmap_regions(pdev, BIT(1));
>  
>  	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> -	if (!priv) {
> -		dev_err(&pdev->dev, "can't allocate chip data\n");
> +	if (!priv)
>  		return -ENOMEM;
> -	}
>  
>  	priv->dev = &pdev->dev;
>  	priv->reg_base = pcim_iomap_table(pdev)[0];

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
