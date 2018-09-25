Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A6EC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 10:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1955E20842
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 10:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KrXJJt0z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1955E20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727613AbeIYQN2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 12:13:28 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35375 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbeIYQN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 12:13:27 -0400
Received: by mail-lf1-f68.google.com with SMTP id r191-v6so6928737lff.2;
        Tue, 25 Sep 2018 03:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9iCj/OR5WWhxMBVtao8yNe4JPF8lrAh5TbLarWk9SIw=;
        b=KrXJJt0zMsCPWg1K3GR7LwUnFv6hnxEwrSrBVEZ2/6wQldaNJ3KBI03EUcfuLWTf2C
         aGHCD4TGF6M4FZlXvjky3RdMj9mS6Coahk2sj8ZHLNJ4lm4/h/vJ4g6TeZmMgPAx5mL/
         8fWFfQa3j5UEhX9GBCwUhEABbBAqY6Qmj/i6eJVUvEZ0qT84SDZNxhuFH19prBQCCWE7
         3odxWXqgbFkdMUaoHtl5SDE4mm3MjOfnOc/CT9fqFDAOwny5NDSpEo/8bEBswtbRLatJ
         M7VPrusNkIyJiDjcYhVlYSQJnna/nk5BKRf7AKRz1thYP6UGE/IhCuqyExMLAeKvxnwa
         rRQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=9iCj/OR5WWhxMBVtao8yNe4JPF8lrAh5TbLarWk9SIw=;
        b=E//GUC05DiHW4Ijb8cml4pTIiTTALIQ5KsKRTsqQyo2Js38lJiIz6oAhBpC5KTVH0Y
         R/yWhyPCtR+igZPvEsS01ILg+cAdLjHpB3dG8z2BljpmSUhrf92kNPAPjWeY6mjAc8mw
         04LksXnSrb+1x0BbgpOutcCjHBOiabhGvJ54A8YreAUuYMpgXK4l9NCTNDA0h3Z4opqZ
         QnixlV8yjIojYIknQHtVqaOyMSoZlPnB3vnAnzfGt5G6XS1Tstmpt4fy7h1A23gYqsQD
         epgbIZIDxq/A7RRTQvqpxKImwr2jtEFvckj4iLXoyjElA+2cMuw8CFb/SpWmi1FCfMTu
         Axng==
X-Gm-Message-State: ABuFfoiBUQyI6DKPaCBbjz8l6izjuZnX/46QQmnAojmwGj8rCgSDEOh2
        pSyeXb1R8fjX8Oi1MJXTmDs=
X-Google-Smtp-Source: ACcGV63/CAHs3u38p4mOb42QHvyyGmB+Sfcu4uWVdYJYTl45AGXL1FDKeHe9bDQsx2sCbGA1UMjIOw==
X-Received: by 2002:a19:a545:: with SMTP id o66-v6mr252541lfe.94.1537869997126;
        Tue, 25 Sep 2018 03:06:37 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id t15-v6sm319978ljh.21.2018.09.25.03.06.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 03:06:35 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1g4kEl-0005cL-E0; Tue, 25 Sep 2018 12:06:35 +0200
Date:   Tue, 25 Sep 2018 12:06:35 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Karoly Pados <pados@pados.hu>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Loic Poulain <loic.poulain@linaro.org>
Subject: Re: [PATCH v6] USB: serial: ftdi_sio: implement GPIO support for
 FT-X devices
Message-ID: <20180925100635.GC3332@localhost>
References: <20180924143151.2273-1-pados@pados.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180924143151.2273-1-pados@pados.hu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 04:31:51PM +0200, Karoly Pados wrote:
> This patch allows using the CBUS pins of FT-X devices as GPIO in CBUS
> bitbanging mode. There is no conflict between the GPIO and VCP
> functionality in this mode. Tested on FT230X and FT231X.
> 
> As there is no way to request the current CBUS register configuration
> from the device, all CBUS pins are set to a known state when the first
> GPIO is requested. This allows using libftdi to set the GPIO pins
> before loading this module for UART functionality, a behavior that
> existing applications might be relying upon (though no specific case
> is known to the authors of this patch).
> 
> Signed-off-by: Karoly Pados <pados@pados.hu>
> ---
> Changelog:
> - v2: Fix compile error when CONFIG_GPIOLIB is not defined.
> - v3: Incorporate review feedback.
> - v4: Include linux/gpio/driver.h unconditionally.
>       Replace and invert gpio_input with gpio_output.
>       Make ftdi_gpio_direction_get return 0/1.
>       Change dev_err msg in ftdi_set_bitmode_req.
>       Change formatting of error checking in ftdi_gpio_get.
>       Drop dev_err in ftdi_gpio_set.
>       Remove some line breaks and empty lines.
>       Change error handling in ftdi_read_eeprom (and adjust caller).
>       Replace SIO->FTX in FTDI_SIO_CBUS_MUX_GPIO macro name.
> - v5: Resent v4 with no changes by mistake. Please ignore.
> - v6: Read only 4 bytes from eeprom in ftx_gpioconf_init.
>       Compare ftdi_read_eeprom result with 0 instead of eq. cehck.
>       Reserve 4 GPIOs even for FT234X.
>       Release CBUS after gpiochip deregister to avoid possible race.
>       Adjust comment on FTDI_SIO_SET_BITMODE macro.
>       Protect GPIO value/dir setting with mutex.
>       Add support for gpiochip.get_multiple and set_multiple.
>       Add names to GPIO lines.
>
> get_multiple / set_multiple methods have been added in addition to earlier
> review comments.

Adding new features like this late in a review cycle risks adding new
bugs and creates more work for everyone involved.

In this case, there's a bug in your set_multiple() implementation that
will need to be addressed in a v7, so I'll comment on some style issues
as well while at it.

>  drivers/usb/serial/ftdi_sio.c | 369 +++++++++++++++++++++++++++++++++-
>  drivers/usb/serial/ftdi_sio.h |  27 ++-
>  2 files changed, 394 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
> index b5cef322826f..566284e2c316 100644
> --- a/drivers/usb/serial/ftdi_sio.c
> +++ b/drivers/usb/serial/ftdi_sio.c
> @@ -40,6 +40,7 @@
>  #include <linux/usb.h>
>  #include <linux/serial.h>
>  #include <linux/usb/serial.h>
> +#include <linux/gpio/driver.h>

Nit: place this above linux/usb/serial.h to keep at least those includes
sorted.

>  #include "ftdi_sio.h"
>  #include "ftdi_sio_ids.h"
>  
> @@ -72,8 +73,23 @@ struct ftdi_private {
>  	unsigned int latency;		/* latency setting in use */
>  	unsigned short max_packet_size;
>  	struct mutex cfg_lock; /* Avoid mess by parallel calls of config ioctl() and change_speed() */
> +#if defined(CONFIG_GPIOLIB)

Use #ifdef here and elsewhere (defined() can be used in actual code).

> +	struct gpio_chip gc;
> +	struct mutex  gpio_lock;  /* Protect GPIO state against parallel calls */

Just "protects gpio state", if anything.

> +	bool	gpio_registered;  /* is the gpiochip in kernel registered */
> +	bool	gpio_used;	  /* true if the user requested a gpio */
> +	u8	gpio_altfunc;	  /* which pins are in gpio mode */
> +	u8	gpio_output;	  /* pin directions cache */
> +	u8	gpio_value;	  /* pin value for outputs */

Your mixing tabs and spaces heavily above. Just stick to the current
style and drop the variable name alignment, remove superfluous spaces,
and use tabs only for indentation.

> +#endif
>  };
>  
> +#if defined(CONFIG_GPIOLIB)
> +static const char * const ftdi_ftx_gpio_names[] = {
> +	"CBUS0", "CBUS1", "CBUS2", "CBUS3"
> +};
> +#endif

We want to keep the ifdeffery to a minimum, so move this inside the
gpiolib ifdef below (and possibly even into the function where it is
used).

Also note that these names are shared with FT232R, but not with FT232H.

> +
>  /* struct ftdi_sio_quirk is used by devices requiring special attention. */
>  struct ftdi_sio_quirk {
>  	int (*probe)(struct usb_serial *);
> @@ -1766,6 +1782,347 @@ static void remove_sysfs_attrs(struct usb_serial_port *port)
>  
>  }
>  
> +#if defined(CONFIG_GPIOLIB)
> +
> +static int ftdi_set_bitmode_req(struct usb_serial_port *port, u8 mode)

Nit: please drop the _req suffix here.

> +{
> +	struct ftdi_private *priv = usb_get_serial_port_data(port);
> +	struct usb_serial *serial = port->serial;
> +	int result;
> +	u16 val;
> +
> +	val = (mode << 8) | (priv->gpio_output << 4) | priv->gpio_value;
> +	result = usb_control_msg(serial->dev,
> +				 usb_sndctrlpipe(serial->dev, 0),
> +				 FTDI_SIO_SET_BITMODE_REQUEST,
> +				 FTDI_SIO_SET_BITMODE_REQUEST_TYPE, val,
> +				 priv->interface, NULL, 0, WDR_TIMEOUT);
> +	if (result < 0) {
> +		dev_err(&serial->interface->dev,
> +			"bitmode request failed for value 0x%04x: %d\n",
> +			val, result);
> +	}
> +
> +	return result;
> +}

> +static int ftdi_read_cbus_pins(struct usb_serial_port *port)
> +{
> +	struct ftdi_private *priv = usb_get_serial_port_data(port);
> +	struct usb_serial *serial = port->serial;
> +	unsigned char *rcvbuf;

Nit: Please rename simply buf, which is more common and improves
readability by being easier to tell apart from result.

> +	int result;
> +
> +	rcvbuf = kmalloc(1, GFP_KERNEL);
> +	if (!rcvbuf)
> +		return -ENOMEM;
> +
> +	result = usb_control_msg(serial->dev,
> +				 usb_rcvctrlpipe(serial->dev, 0),
> +				 FTDI_SIO_READ_PINS_REQUEST,
> +				 FTDI_SIO_READ_PINS_REQUEST_TYPE, 0,
> +				 priv->interface, rcvbuf, 1, WDR_TIMEOUT);
> +	if (result < 1) {
> +		if (result >= 0)
> +			result = -EIO;
> +	} else {
> +		result = rcvbuf[0];
> +	}
> +
> +	kfree(rcvbuf);
> +
> +	return result;
> +}

> +static void ftdi_gpio_set_multiple(struct gpio_chip *gc,
> +				   unsigned long *mask, unsigned long *bits)
> +{
> +	struct usb_serial_port *port = gpiochip_get_data(gc);
> +	struct ftdi_private *priv = usb_get_serial_port_data(port);
> +
> +	mutex_lock(&priv->gpio_lock);
> +
> +	priv->gpio_value &= ~(*mask);
> +	priv->gpio_value |= *bits;

gpiolib doesn't clear bits not in mask for you, so you need to OR with
*mask here to avoid setting random other bits.

> +	ftdi_set_cbus_pins(port);
> +
> +	mutex_unlock(&priv->gpio_lock);
> +}
> +
> +static int ftdi_gpio_direction_get(struct gpio_chip *gc, unsigned int gpio)
> +{
> +	struct usb_serial_port *port = gpiochip_get_data(gc);
> +	struct ftdi_private *priv = usb_get_serial_port_data(port);
> +
> +	if (priv->gpio_output & BIT(gpio))
> +		return 0;
> +	else
> +		return 1;

This could just simplified using negation (!), but perhaps this is
easier to parse as it stands.

> +}

> +static int ftdi_gpio_init(struct usb_serial_port *port)
> +{
> +	struct ftdi_private *priv = usb_get_serial_port_data(port);
> +	struct usb_serial *serial = port->serial;
> +	int result;
> +
> +	/* Device-specific initializations */
> +	switch (priv->chip_type) {
> +	case FTX:
> +		result = ftx_gpioconf_init(port);
> +		break;
> +	default:
> +		return 0;
> +	}
> +
> +	if (result < 0)
> +		return result;
> +
> +	mutex_init(&priv->gpio_lock);
> +
> +	/* Register GPIO chip to kernel */
> +	priv->gc.label = "ftdi-cbus";
> +	priv->gc.request = ftdi_gpio_request;
> +	priv->gc.get_direction = ftdi_gpio_direction_get;
> +	priv->gc.direction_input = ftdi_gpio_direction_input;
> +	priv->gc.direction_output = ftdi_gpio_direction_output;
> +	priv->gc.get = ftdi_gpio_get;
> +	priv->gc.set = ftdi_gpio_set;
> +	priv->gc.get_multiple = ftdi_gpio_get_multiple;
> +	priv->gc.set_multiple = ftdi_gpio_set_multiple;
> +	priv->gc.owner = THIS_MODULE;
> +	priv->gc.parent = &serial->interface->dev;
> +	priv->gc.base = -1;
> +	priv->gc.can_sleep = true;
> +	priv->gc.names = ftdi_ftx_gpio_names;

As noted above, these names are shared with ft232r but not with ft232h,
and this needs to be set in the device specific init function,
specifically, as the array size must always match (or at least be as
large as) ngpio.

> +
> +	result = gpiochip_add_data(&priv->gc, port);
> +	if (!result)
> +		priv->gpio_registered = true;
> +
> +	return result;
> +}

Johan
