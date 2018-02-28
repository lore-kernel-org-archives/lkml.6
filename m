Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934587AbeB1UTi (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 15:19:38 -0500
Received: from mail-yb0-f196.google.com ([209.85.213.196]:37014 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934107AbeB1UTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 15:19:36 -0500
X-Google-Smtp-Source: AG47ELt9IEpTCDjL6jQPBwRt24HsW8hDUu9cFKTjxznFDJQ/0unx/ZWDbttwZveyxVqC/D6LqIYovg==
Date: Wed, 28 Feb 2018 15:19:35 -0500
From: Sean Paul <seanpaul@chromium.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        David Airlie <airlied@linux.ie>, David Lechner <david@lechnology.com>,
        Sean Paul <seanpaul@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Meghana Madhyastha <meghana.madhyastha@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tinydrm: add backlight dependency
Message-ID: <20180228201935.GL223881@art_vandelay>
References: <20180228134111.2042877-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180228134111.2042877-1-arnd@arndb.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 28, 2018 at 02:40:48PM +0100, Arnd Bergmann wrote:
> Calling devm_of_find_backlight directly means we get a link failure
> without CONFIG_BACKLIGHT_CLASS_DEVICE:
> 
> drivers/gpu/drm/tinydrm/mi0283qt.o: In function `mi0283qt_probe':
> mi0283qt.c:(.text+0x684): undefined reference to `devm_of_find_backlight'
> 
> This adds an explicit Kconfig dependency for it. While I did not
> observe that failure for st7735r, I assume the same change is needed
> there for the same reason.
> 
> Fixes: d1a2e7004b5e ("drm/tinydrm: Replace tinydrm_of_find_backlight with of_find_backlight")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied to drm-misc-next, thanks!

Sean

> ---
>  drivers/gpu/drm/tinydrm/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/tinydrm/Kconfig b/drivers/gpu/drm/tinydrm/Kconfig
> index 13339be843bc..4592a5e3f20b 100644
> --- a/drivers/gpu/drm/tinydrm/Kconfig
> +++ b/drivers/gpu/drm/tinydrm/Kconfig
> @@ -23,6 +23,7 @@ config TINYDRM_ILI9225
>  config TINYDRM_MI0283QT
>  	tristate "DRM support for MI0283QT"
>  	depends on DRM_TINYDRM && SPI
> +	depends on BACKLIGHT_CLASS_DEVICE
>  	select TINYDRM_MIPI_DBI
>  	help
>  	  DRM driver for the Multi-Inno MI0283QT display panel
> @@ -54,6 +55,7 @@ config TINYDRM_ST7586
>  config TINYDRM_ST7735R
>  	tristate "DRM support for Sitronix ST7735R display panels"
>  	depends on DRM_TINYDRM && SPI
> +	depends on BACKLIGHT_CLASS_DEVICE
>  	select TINYDRM_MIPI_DBI
>  	help
>  	  DRM driver Sitronix ST7735R with one of the following LCDs:
> -- 
> 2.9.0
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
