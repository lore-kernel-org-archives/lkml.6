Return-Path: <Ludovic.Desroches@microchip.com>
X-Google-Smtp-Source: AIpwx48bYTCjTGz1js8zUrPJaAbvwm+xIE/pBngdRUodCK5J2GD96mvwBy7idLbUioZ9QmwkpUJ1
ARC-Seal: i=1; a=rsa-sha256; t=1523879087; cv=none;
        d=google.com; s=arc-20160816;
        b=KrH5bSWOYgMU+BryOSXRWDkrEEBAAczjR+FnjLfJTVznOFLGQtue0pSGBpuPNRYBvA
         6EVj4Swfubfni4mLFLrD4M4pjJ9hycUaaaazZxFLJeae9n6XirY00M2OqjUDB0So8qJQ
         0/GR/iFHt7S2Wsvm5m11lKYfr5jPa+Lkl/0djuvt+CuiwpNvXasZYXKT3n8kUCIDkLMz
         WwbzUJLCA+ZCAChVNgCMqrqPOIpV8RWJCZLwtw0ggsmGzsJAxI0aUhhm5Yw1SiMM309m
         STDLynihkg/cIc+LyCf0Dfwdq1+SJqBw+JBXy+4SbGqxZ4hlgUY8VjvT28o+7kc9/4Kx
         0kGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=bZ0gUhK3zPOj9KOSW8Lkfqykyfp2G2ihG1IqFFKSy4I=;
        b=MjkWXX+lP52lV7XHaa9g8FiAdHA5Dsz7rNnqSxu3dJh3cQTp6t7/ohjsERij5GHxou
         N1v5Ib/lqB31nJLvgRELKIo29+4qcN+5HMxwJoePew5TIVWc8HNkHPGaoKBRhuq2Kp0O
         WpyQrV6K1VXLHrHRgzdlxdJZGSkSn43u4YSgbRWtgnkik0geEVzQNlt0KYQM6v9NdiRi
         RFA92+aP2N3ZCGJvfuTdIVlvkiOEn6ANFizarU4BTCmiosA1OoUaEc+V/bbwYMz/egFB
         TQMgogaG6JsdGlS6iP3UIea/4c0ouy3WSQj0YP8ciSPvb7c3Q8s0N2UYObCJHrWdSPVe
         ngSg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ludovic.desroches@microchip.com designates 68.232.147.91 as permitted sender) smtp.mailfrom=Ludovic.Desroches@microchip.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ludovic.desroches@microchip.com designates 68.232.147.91 as permitted sender) smtp.mailfrom=Ludovic.Desroches@microchip.com
X-IronPort-AV: E=Sophos;i="5.48,459,1517900400";
   d="scan'208";a="13858629"
Date: Mon, 16 Apr 2018 13:44:10 +0200
From: Ludovic Desroches <ludovic.desroches@microchip.com>
To: Romain Izard <romain.izard.pro@gmail.com>
CC: Nicolas Ferre <nicolas.ferre@microchip.com>, Felipe Balbi
	<balbi@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Ludovic Desroches
	<ludovic.desroches@microchip.com>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-usb@vger.kernel.org>
Subject: Re: [PATCH 2/3] usb: gadget: udc: atmel: Remove obsolete include
Message-ID: <20180416114410.GD2750@rfolt0960.corp.atmel.com>
Mail-Followup-To: Romain Izard <romain.izard.pro@gmail.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Felipe Balbi <balbi@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-usb@vger.kernel.org
References: <20180416093405.16612-1-romain.izard.pro@gmail.com>
 <20180416093405.16612-3-romain.izard.pro@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180416093405.16612-3-romain.izard.pro@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597894877564688177?=
X-GMAIL-MSGID: =?utf-8?q?1597903038225370777?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 16, 2018 at 11:34:04AM +0200, Romain Izard wrote:
> The include defines the private platform_data structure used with AVR
> platforms. It has no user since 7c55984e191f. Remove it.
> 
> Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>
> ---
>  drivers/usb/gadget/udc/atmel_usba_udc.c |  1 -
>  include/linux/usb/atmel_usba_udc.h      | 24 ------------------------
>  2 files changed, 25 deletions(-)
>  delete mode 100644 include/linux/usb/atmel_usba_udc.h
> 
> diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
> index 0fe3d0feb8f7..b9623e228609 100644
> --- a/drivers/usb/gadget/udc/atmel_usba_udc.c
> +++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
> @@ -20,7 +20,6 @@
>  #include <linux/ctype.h>
>  #include <linux/usb/ch9.h>
>  #include <linux/usb/gadget.h>
> -#include <linux/usb/atmel_usba_udc.h>
>  #include <linux/delay.h>
>  #include <linux/of.h>
>  #include <linux/irq.h>
> diff --git a/include/linux/usb/atmel_usba_udc.h b/include/linux/usb/atmel_usba_udc.h
> deleted file mode 100644
> index 9bb00df3b53f..000000000000
> --- a/include/linux/usb/atmel_usba_udc.h
> +++ /dev/null
> @@ -1,24 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -/*
> - * Platform data definitions for Atmel USBA gadget driver.
> - */
> -#ifndef __LINUX_USB_USBA_H
> -#define __LINUX_USB_USBA_H
> -
> -struct usba_ep_data {
> -	char	*name;
> -	int	index;
> -	int	fifo_size;
> -	int	nr_banks;
> -	int	can_dma;
> -	int	can_isoc;
> -};
> -
> -struct usba_platform_data {
> -	int			vbus_pin;
> -	int			vbus_pin_inverted;
> -	int			num_ep;
> -	struct usba_ep_data	ep[0];
> -};
> -
> -#endif /* __LINUX_USB_USBA_H */
> -- 
> 2.14.1
> 
