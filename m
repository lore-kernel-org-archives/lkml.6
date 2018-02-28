Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751686AbeB1Giv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 01:38:51 -0500
Received: from lelnx193.ext.ti.com ([198.47.27.77]:62663 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750891AbeB1Git (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 01:38:49 -0500
Subject: Re: [PATCH] ARM: davinci: fix the GPIO lookup for omapl138-hawk
To: Bartosz Golaszewski <brgl@bgdev.pl>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20180227121443.3191-1-brgl@bgdev.pl>
From: Sekhar Nori <nsekhar@ti.com>
Message-ID: <2396d1a7-e4ef-95d7-3d38-309adcc3507e@ti.com>
Date: Wed, 28 Feb 2018 12:08:11 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180227121443.3191-1-brgl@bgdev.pl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 27 February 2018 05:44 PM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> The GPIO chip is called davinci_gpio.0 in legacy mode. Fix it, so that
> mmc can correctly lookup the wp and cp gpios.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  arch/arm/mach-davinci/board-omapl138-hawk.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c b/arch/arm/mach-davinci/board-omapl138-hawk.c
> index a3e78074be70..62eb7d668890 100644
> --- a/arch/arm/mach-davinci/board-omapl138-hawk.c
> +++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
> @@ -127,8 +127,8 @@ static struct gpiod_lookup_table mmc_gpios_table = {
>  	.dev_id = "da830-mmc.0",
>  	.table = {
>  		/* CD: gpio3_12: gpio60: chip 1 contains gpio range 32-63*/
> -		GPIO_LOOKUP("davinci_gpio.1", 28, "cd", GPIO_ACTIVE_LOW),
> -		GPIO_LOOKUP("davinci_gpio.1", 29, "wp", GPIO_ACTIVE_LOW),
> +		GPIO_LOOKUP("davinci_gpio.0", 28, "cd", GPIO_ACTIVE_LOW),
> +		GPIO_LOOKUP("davinci_gpio.0", 29, "wp", GPIO_ACTIVE_LOW),

Hmm, shouldn't this just be "davinci_gpio" since we use .id = -1 in
da8xx_gpio_device?

Also:

Fixes: c69f43fb4f26 ("ARM: davinci: hawk: use gpio descriptor for mmc pins")

Thanks,
Sekhar
