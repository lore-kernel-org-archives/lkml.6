Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752214AbeCNQEb (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 12:04:31 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:37070 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752011AbeCNQE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 12:04:29 -0400
X-Google-Smtp-Source: AG47ELs+SIpmn4pR4afc/0kx62SiaRCmsMIarBhZIih+XLlw7AukOPGpyYAyJoDs00NLvdL1DlaGGg==
Date: Wed, 14 Mar 2018 09:04:24 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH 27/47] input: keyboard: remove bf54x driver
Message-ID: <20180314160424.GA18065@dtor-ws>
References: <20180314153603.3127932-1-arnd@arndb.de>
 <20180314153603.3127932-28-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180314153603.3127932-28-arnd@arndb.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 14, 2018 at 04:35:40PM +0100, Arnd Bergmann wrote:
> The blackfin architecture is getting removed, so this
> driver is now obsolete.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Please take it through your tree with the rest of bfin removal patches.

> ---
>  drivers/input/keyboard/Kconfig      |   9 -
>  drivers/input/keyboard/Makefile     |   1 -
>  drivers/input/keyboard/bf54x-keys.c | 396 ------------------------------------
>  3 files changed, 406 deletions(-)
>  delete mode 100644 drivers/input/keyboard/bf54x-keys.c
> 
> diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
> index 4c4ab1ced235..2b469cc47a78 100644
> --- a/drivers/input/keyboard/Kconfig
> +++ b/drivers/input/keyboard/Kconfig
> @@ -157,15 +157,6 @@ config KEYBOARD_QT2160
>  	  This driver can also be built as a module. If so, the module
>  	  will be called qt2160.
>  
> -config KEYBOARD_BFIN
> -	tristate "Blackfin BF54x keypad support"
> -	depends on (BF54x && !BF544)
> -	help
> -	  Say Y here if you want to use the BF54x keypad.
> -
> -	  To compile this driver as a module, choose M here: the
> -	  module will be called bf54x-keys.
> -
>  config KEYBOARD_CLPS711X
>  	tristate "CLPS711X Keypad support"
>  	depends on OF_GPIO && (ARCH_CLPS711X || COMPILE_TEST)
> diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/Makefile
> index 526e68294e6e..8fab920afa58 100644
> --- a/drivers/input/keyboard/Makefile
> +++ b/drivers/input/keyboard/Makefile
> @@ -13,7 +13,6 @@ obj-$(CONFIG_KEYBOARD_AMIGA)		+= amikbd.o
>  obj-$(CONFIG_KEYBOARD_ATARI)		+= atakbd.o
>  obj-$(CONFIG_KEYBOARD_ATKBD)		+= atkbd.o
>  obj-$(CONFIG_KEYBOARD_BCM)		+= bcm-keypad.o
> -obj-$(CONFIG_KEYBOARD_BFIN)		+= bf54x-keys.o
>  obj-$(CONFIG_KEYBOARD_CAP11XX)		+= cap11xx.o
>  obj-$(CONFIG_KEYBOARD_CLPS711X)		+= clps711x-keypad.o
>  obj-$(CONFIG_KEYBOARD_CROS_EC)		+= cros_ec_keyb.o
> diff --git a/drivers/input/keyboard/bf54x-keys.c b/drivers/input/keyboard/bf54x-keys.c
> deleted file mode 100644
> index 8a07a426f88e..000000000000
> -- 
> 2.9.0
> 

-- 
Dmitry
