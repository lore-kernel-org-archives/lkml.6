Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936370AbeE0Jf3 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 27 May 2018 05:35:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:34858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933214AbeE0Jf0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 May 2018 05:35:26 -0400
Date: Sun, 27 May 2018 10:35:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Quentin Schulz <quentin.schulz@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: sun4i-gpadc: select REGMAP_IRQ
Message-ID: <20180527103520.134fb6f8@archlinux>
In-Reply-To: <20180525153451.3164970-1-arnd@arndb.de>
References: <20180525153451.3164970-1-arnd@arndb.de>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 May 2018 17:34:23 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> We can't call regmap_irq_get_virq() unless the regmap-irq support
> is enabled:
> 
> drivers/iio/adc/sun4i-gpadc-iio.o: In function `sun4i_irq_init':
> sun4i-gpadc-iio.c:(.text+0x59c): undefined reference to `regmap_irq_get_virq'
> 
> I came across this in a randconfig build now, but I guess this is
> a much older problem that I simply never hit before because regmap_irq
> is usually enabled by one of the other drivers that need it.
> 
> Fixes: d1caa9905538 ("iio: adc: add support for Allwinner SoCs ADC")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied to the togreg branch of iio.git.  I might move it to the fixes
branch if the merge window opens shortly so as to get it upstream
faster. Pushed out as testing for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 9da79070357c..13922b595503 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -717,6 +717,7 @@ config SUN4I_GPADC
>  	depends on IIO
>  	depends on MFD_SUN4I_GPADC || MACH_SUN8I
>  	depends on THERMAL || !THERMAL_OF
> +	select REGMAP_IRQ
>  	help
>  	  Say yes here to build support for Allwinner (A10, A13 and A31) SoCs
>  	  GPADC. This ADC provides 4 channels which can be used as an ADC or as
