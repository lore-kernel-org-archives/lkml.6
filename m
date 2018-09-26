Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC2FC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 10:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB34220843
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 10:42:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZaZK8NCW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB34220843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbeIZQzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 12:55:14 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35443 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbeIZQzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 12:55:14 -0400
Received: by mail-lf1-f66.google.com with SMTP id r191-v6so10271347lff.2;
        Wed, 26 Sep 2018 03:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IsoddFHKSqPmNXitAyQG7Xfic1EUMb8THp8yGYyWRrE=;
        b=ZaZK8NCW3J02JuIjzEJB5tN4DAtvEsa69kjzWZSGjiy/KBAbnWTg4Ay+rLHuHgyCR0
         S1sxFzfCT637MVNUdcTn2QNXUp8UKLCtDY7Vi+q8ytcO5NgPoavcWyHbJgZ2GWEKdBNq
         sR8xCF3nVwELD+YQ9mabxX6nlZMLIvn5MmNQh+PSPBiabQo7pXJ1fFehdZvTB0L8YDrK
         DnmXuJGxyd+RaurJSbW4QFtKR1A2VtG2SJLsB+U9z2XkstOupkeqMW1pXOe2lvYTRgaN
         d6Lj2AqzLAFvyJ7uGFjNaHhqClQnuQjBgPE4i1TvvhzyVX/2wUYAhVyKQA6hQTI7VQ8S
         9/2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=IsoddFHKSqPmNXitAyQG7Xfic1EUMb8THp8yGYyWRrE=;
        b=H//hSuN3JIcM+6dFXE6KHvLdFEKHk8M9tnxAw/0zqLsH0kjvsttfRPCXmwKCfjWasl
         RTL9sWG53oKSRJvY1rj4SaX1+Y0IsivGlvCUsEV/dZQYZbbuEkRoypRc+2cA2p+ehFun
         E/8WoXk1kko4o6Pi2MIiKYdPk6IN2uu1l9tLcLTUFz6qCo3JfX+LO4tmB9CswbloFTCZ
         Ryjvx+B9oq6qZcbIlPEc6NTq3Bt3bPKErKtVoRIO4GtvCpEAd3UyhgPK0qksjEA3BM5p
         b5jczzrqnjUFuLNxXrA53Rshhoq/fl4QUEvBkEmf7KFhmcnPihBBTkTVYoEHtLJXGFI/
         /ecA==
X-Gm-Message-State: ABuFfoi+9XhuNf/83pG+cbNdlZAN9SdU7qnVwfJtR3Qa3fCxSUrzkkV+
        Du6nN5vg28MzakaoSn+ZAhY=
X-Google-Smtp-Source: ACcGV6385dnev4BDQD689uNdJPP0aLzDLrA+1vAObOTDErXjjdQBTDmqIZs2bHE//YsJ7u4vbYTdGQ==
X-Received: by 2002:a19:ae15:: with SMTP id f21-v6mr2033237lfc.86.1537958570896;
        Wed, 26 Sep 2018 03:42:50 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id t22-v6sm904630ljc.82.2018.09.26.03.42.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 03:42:50 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1g57HO-0004eN-Uy; Wed, 26 Sep 2018 12:42:51 +0200
Date:   Wed, 26 Sep 2018 12:42:50 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Karoly Pados <pados@pados.hu>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Loic Poulain <loic.poulain@linaro.org>
Subject: Re: [PATCH v7] USB: serial: ftdi_sio: implement GPIO support for
 FT-X devices
Message-ID: <20180926104250.GJ3332@localhost>
References: <20180925135911.2926-1-pados@pados.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180925135911.2926-1-pados@pados.hu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 03:59:11PM +0200, Karoly Pados wrote:
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
> - v7: Move <linux/gpio/driver.h> line for better include sorting.
>       Adjust comment on gpio_lock declaration.
>       Space vs tab formatting changes in struct ftdi_private.
>       Move ftdi_ftx_gpio_names to merge it with existing #ifdef.
>       Rename function ftdi_set_bitmode_req to ftdi_set_bitmode.
>       Rename rcvbuf to buf in function ftdi_read_cbus_pins.
>       AND *bits and *mask in ftdi_gpio_set_multiple as gpiolib does not.
>       Replace if in ftdi_gpio_direction_get with negation.
>       Move priv->gc.names assignment to chip-specific ftx_gpioconf_init.

Thanks again for doing this work. I've applied the patch now with some
minor style changes (see below).

> +#if defined(CONFIG_GPIOLIB)

I changed these to plain #ifdef, which is what we commonly use.

> +static int ftdi_gpio_get_multiple(struct gpio_chip *gc,
> +				   unsigned long *mask, unsigned long *bits)

You had some odd indentation using spaces after tabs, but which still
didn't line up with opening parenthesis (a left over from removing the
_sio_ infix, I think) which I fixed up by using plain tabs instead.

> +static int ftx_gpioconf_init(struct usb_serial_port *port)
> +{
> +	struct ftdi_private *priv = usb_get_serial_port_data(port);
> +	struct usb_serial *serial = port->serial;
> +	const u16 cbus_cfg_addr = 0x1a;
> +	const u16 cbus_cfg_size = 4;
> +	u8 *cbus_cfg_buf;
> +	int result;
> +	u8 i;
> +
> +	priv->gc.names = ftdi_ftx_gpio_names;

I moved this to where you set ngpio below as they are related (and
need not be set if we bail out early).

> +
> +	/* Read a part of device EEPROM */
> +	cbus_cfg_buf = kmalloc(cbus_cfg_size, GFP_KERNEL);
> +	if (!cbus_cfg_buf)
> +		return -ENOMEM;
> +
> +	result = ftdi_read_eeprom(serial, cbus_cfg_buf,
> +				  cbus_cfg_addr, cbus_cfg_size);
> +	if (result < 0)
> +		goto out_free;
> +
> +	/* FIXME: FT234XD alone has 1 GPIO, but how to recognize this IC? */
> +	priv->gc.ngpio = 4;
> +
> +	/* Determine which pins are configured for CBUS bitbanging */
> +	priv->gpio_altfunc = 0xff;
> +	for (i = 0; i < priv->gc.ngpio; ++i) {
> +		if (cbus_cfg_buf[i] == FTDI_FTX_CBUS_MUX_GPIO)
> +			priv->gpio_altfunc &= ~BIT(i);
> +	}
> +
> +out_free:
> +	kfree(cbus_cfg_buf);
> +
> +	return result;
> +}

Thanks,
Johan
