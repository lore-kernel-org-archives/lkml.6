Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753418AbeFASeW (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 14:34:22 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:44505 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753304AbeFASeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 14:34:20 -0400
X-Google-Smtp-Source: ADUXVKJZjO397VqxHQNL8fFiUNcFeAswGteSfr1E/uaA2haMTVlLI9FU01dfWJzLT1i6f6Mm+8t6Ow==
Date: Fri, 1 Jun 2018 11:34:16 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jeffy Chen <jeffy.chen@rock-chips.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/3] Input: gpio-keys - Switch to bitmap_zalloc()
Message-ID: <20180601183416.GB222005@dtor-ws>
References: <20180601083120.40352-1-andriy.shevchenko@linux.intel.com>
 <20180601083120.40352-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180601083120.40352-2-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 01, 2018 at 11:31:19AM +0300, Andy Shevchenko wrote:
> Switch to bitmap_zalloc() to show clearly what we are allocating.
> Besides that it returns pointer of bitmap type instead of opaque void *.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

> ---
>  drivers/input/keyboard/gpio_keys.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
> index 052e37675086..492a971b95b5 100644
> --- a/drivers/input/keyboard/gpio_keys.c
> +++ b/drivers/input/keyboard/gpio_keys.c
> @@ -196,7 +196,7 @@ static ssize_t gpio_keys_attr_show_helper(struct gpio_keys_drvdata *ddata,
>  	ssize_t ret;
>  	int i;
>  
> -	bits = kcalloc(BITS_TO_LONGS(n_events), sizeof(*bits), GFP_KERNEL);
> +	bits = bitmap_zalloc(n_events, GFP_KERNEL);
>  	if (!bits)
>  		return -ENOMEM;
>  
> @@ -216,7 +216,7 @@ static ssize_t gpio_keys_attr_show_helper(struct gpio_keys_drvdata *ddata,
>  	buf[ret++] = '\n';
>  	buf[ret] = '\0';
>  
> -	kfree(bits);
> +	bitmap_free(bits);
>  
>  	return ret;
>  }
> @@ -240,7 +240,7 @@ static ssize_t gpio_keys_attr_store_helper(struct gpio_keys_drvdata *ddata,
>  	ssize_t error;
>  	int i;
>  
> -	bits = kcalloc(BITS_TO_LONGS(n_events), sizeof(*bits), GFP_KERNEL);
> +	bits = bitmap_zalloc(n_events, GFP_KERNEL);
>  	if (!bits)
>  		return -ENOMEM;
>  
> @@ -284,7 +284,7 @@ static ssize_t gpio_keys_attr_store_helper(struct gpio_keys_drvdata *ddata,
>  	mutex_unlock(&ddata->disable_lock);
>  
>  out:
> -	kfree(bits);
> +	bitmap_free(bits);
>  	return error;
>  }
>  
> -- 
> 2.17.0
> 

-- 
Dmitry
