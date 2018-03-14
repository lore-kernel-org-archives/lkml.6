Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751618AbeCNQGv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 12:06:51 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:45693 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751279AbeCNQGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 12:06:49 -0400
X-Google-Smtp-Source: AG47ELu49ka3JAVZ9i5QClZ+nUoXAk0S4QP0v5W4bYUsrc8vIyXlK01y5UHptghfmOLZSEt4clcNkA==
Date: Wed, 14 Mar 2018 09:06:46 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 31/47] watchdog: remove bfin_wdt driver
Message-ID: <20180314160646.GA15652@roeck-us.net>
References: <20180314153603.3127932-1-arnd@arndb.de>
 <20180314153603.3127932-32-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180314153603.3127932-32-arnd@arndb.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 14, 2018 at 04:35:44PM +0100, Arnd Bergmann wrote:
> The blackfin architecture is getting removed, so this driver has
> become obsolete.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  Documentation/watchdog/watchdog-parameters.txt |   5 -
>  drivers/watchdog/Kconfig                       |  17 -
>  drivers/watchdog/Makefile                      |   7 -
>  drivers/watchdog/bfin_wdt.c                    | 476 -------------------------
>  4 files changed, 505 deletions(-)
>  delete mode 100644 drivers/watchdog/bfin_wdt.c
> 
> diff --git a/Documentation/watchdog/watchdog-parameters.txt b/Documentation/watchdog/watchdog-parameters.txt
> index beea975980f6..6d6200ea27b8 100644
> --- a/Documentation/watchdog/watchdog-parameters.txt
> +++ b/Documentation/watchdog/watchdog-parameters.txt
> @@ -55,11 +55,6 @@ wdt_time: Watchdog time in seconds. (default=30)
>  nowayout: Watchdog cannot be stopped once started
>  	(default=kernel config parameter)
>  -------------------------------------------------
> -bfin_wdt:
> -timeout: Watchdog timeout in seconds. (1<=timeout<=((2^32)/SCLK), default=20)
> -nowayout: Watchdog cannot be stopped once started
> -	(default=kernel config parameter)
> --------------------------------------------------
>  coh901327_wdt:
>  margin: Watchdog margin in seconds (default 60s)
>  -------------------------------------------------
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 098e5ed4ee3d..f89f8869ca2a 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -815,23 +815,6 @@ config SPRD_WATCHDOG
>  	  Say Y here to include watchdog timer supported
>  	  by Spreadtrum system.
>  
> -# BLACKFIN Architecture
> -
> -config BFIN_WDT
> -	tristate "Blackfin On-Chip Watchdog Timer"
> -	depends on BLACKFIN
> -	---help---
> -	  If you say yes here you will get support for the Blackfin On-Chip
> -	  Watchdog Timer. If you have one of these processors and wish to
> -	  have watchdog support enabled, say Y, otherwise say N.
> -
> -	  To compile this driver as a module, choose M here: the
> -	  module will be called bfin_wdt.
> -
> -# CRIS Architecture
> -
> -# FRV Architecture
> -
>  # X86 (i386 + ia64 + x86_64) Architecture
>  
>  config ACQUIRE_WDT
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index 0474d38aa854..e209824541b8 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -91,13 +91,6 @@ obj-$(CONFIG_UNIPHIER_WATCHDOG) += uniphier_wdt.o
>  obj-$(CONFIG_RTD119X_WATCHDOG) += rtd119x_wdt.o
>  obj-$(CONFIG_SPRD_WATCHDOG) += sprd_wdt.o
>  
> -# BLACKFIN Architecture
> -obj-$(CONFIG_BFIN_WDT) += bfin_wdt.o
> -
> -# CRIS Architecture
> -
> -# FRV Architecture
> -
>  # X86 (i386 + ia64 + x86_64) Architecture
>  obj-$(CONFIG_ACQUIRE_WDT) += acquirewdt.o
>  obj-$(CONFIG_ADVANTECH_WDT) += advantechwdt.o
> diff --git a/drivers/watchdog/bfin_wdt.c b/drivers/watchdog/bfin_wdt.c
> deleted file mode 100644
> index aa4d2e8a8ef9..000000000000
> -- 
> 2.9.0
> 
